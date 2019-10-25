Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01999E46E8
	for <lists+bpf@lfdr.de>; Fri, 25 Oct 2019 11:17:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727125AbfJYJRW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 25 Oct 2019 05:17:22 -0400
Received: from mga14.intel.com ([192.55.52.115]:15204 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726541AbfJYJRW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 25 Oct 2019 05:17:22 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Oct 2019 02:17:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,228,1569308400"; 
   d="scan'208";a="349976481"
Received: from mkarlsso-mobl.ger.corp.intel.com (HELO VM.isw.intel.com) ([10.103.211.42])
  by orsmga004.jf.intel.com with ESMTP; 25 Oct 2019 02:17:18 -0700
From:   Magnus Karlsson <magnus.karlsson@intel.com>
To:     magnus.karlsson@intel.com, bjorn.topel@intel.com, ast@kernel.org,
        daniel@iogearbox.net, netdev@vger.kernel.org,
        jonathan.lemon@gmail.com
Cc:     bpf@vger.kernel.org, degeneloy@gmail.com, john.fastabend@gmail.com
Subject: [PATCH bpf-next v3] libbpf: fix compatibility for kernels without need_wakeup
Date:   Fri, 25 Oct 2019 11:17:15 +0200
Message-Id: <1571995035-21889-1-git-send-email-magnus.karlsson@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

When the need_wakeup flag was added to AF_XDP, the format of the
XDP_MMAP_OFFSETS getsockopt was extended. Code was added to the
kernel to take care of compatibility issues arrising from running
applications using any of the two formats. However, libbpf was
not extended to take care of the case when the application/libbpf
uses the new format but the kernel only supports the old
format. This patch adds support in libbpf for parsing the old
format, before the need_wakeup flag was added, and emulating a
set of static need_wakeup flags that will always work for the
application.

v2 -> v3:
* Incorporated code improvements suggested by Jonathan Lemon

v1 -> v2:
* Rebased to bpf-next
* Rewrote the code as the previous version made you blind

Fixes: a4500432c2587cb2a ("libbpf: add support for need_wakeup flag in AF_XDP part")
Reported-by: Eloy Degen <degeneloy@gmail.com>
Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
---
 tools/lib/bpf/xsk.c | 83 +++++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 71 insertions(+), 12 deletions(-)

diff --git a/tools/lib/bpf/xsk.c b/tools/lib/bpf/xsk.c
index 9a2af44..280010c 100644
--- a/tools/lib/bpf/xsk.c
+++ b/tools/lib/bpf/xsk.c
@@ -73,6 +73,21 @@ struct xsk_nl_info {
 	int fd;
 };
 
+/* Up until and including Linux 5.3 */
+struct xdp_ring_offset_v1 {
+	__u64 producer;
+	__u64 consumer;
+	__u64 desc;
+};
+
+/* Up until and including Linux 5.3 */
+struct xdp_mmap_offsets_v1 {
+	struct xdp_ring_offset_v1 rx;
+	struct xdp_ring_offset_v1 tx;
+	struct xdp_ring_offset_v1 fr;
+	struct xdp_ring_offset_v1 cr;
+};
+
 int xsk_umem__fd(const struct xsk_umem *umem)
 {
 	return umem ? umem->fd : -EINVAL;
@@ -133,6 +148,58 @@ static int xsk_set_xdp_socket_config(struct xsk_socket_config *cfg,
 	return 0;
 }
 
+static void xsk_mmap_offsets_v1(struct xdp_mmap_offsets *off)
+{
+	struct xdp_mmap_offsets_v1 off_v1;
+
+	/* getsockopt on a kernel <= 5.3 has no flags fields.
+	 * Copy over the offsets to the correct places in the >=5.4 format
+	 * and put the flags where they would have been on that kernel.
+	 */
+	memcpy(&off_v1, off, sizeof(off_v1));
+
+	off->rx.producer = off_v1.rx.producer;
+	off->rx.consumer = off_v1.rx.consumer;
+	off->rx.desc = off_v1.rx.desc;
+	off->rx.flags = off_v1.rx.consumer + sizeof(u32);
+
+	off->tx.producer = off_v1.tx.producer;
+	off->tx.consumer = off_v1.tx.consumer;
+	off->tx.desc = off_v1.tx.desc;
+	off->tx.flags = off_v1.tx.consumer + sizeof(u32);
+
+	off->fr.producer = off_v1.fr.producer;
+	off->fr.consumer = off_v1.fr.consumer;
+	off->fr.desc = off_v1.fr.desc;
+	off->fr.flags = off_v1.fr.consumer + sizeof(u32);
+
+	off->cr.producer = off_v1.cr.producer;
+	off->cr.consumer = off_v1.cr.consumer;
+	off->cr.desc = off_v1.cr.desc;
+	off->cr.flags = off_v1.cr.consumer + sizeof(u32);
+}
+
+static int xsk_get_mmap_offsets(int fd, struct xdp_mmap_offsets *off)
+{
+	socklen_t optlen;
+	int err;
+
+	optlen = sizeof(*off);
+	err = getsockopt(fd, SOL_XDP, XDP_MMAP_OFFSETS, off, &optlen);
+	if (err)
+		return err;
+
+	if (optlen == sizeof(*off))
+		return 0;
+
+	if (optlen == sizeof(struct xdp_mmap_offsets_v1)) {
+		xsk_mmap_offsets_v1(off);
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
 int xsk_umem__create_v0_0_4(struct xsk_umem **umem_ptr, void *umem_area,
 			    __u64 size, struct xsk_ring_prod *fill,
 			    struct xsk_ring_cons *comp,
@@ -141,7 +208,6 @@ int xsk_umem__create_v0_0_4(struct xsk_umem **umem_ptr, void *umem_area,
 	struct xdp_mmap_offsets off;
 	struct xdp_umem_reg mr;
 	struct xsk_umem *umem;
-	socklen_t optlen;
 	void *map;
 	int err;
 
@@ -190,8 +256,7 @@ int xsk_umem__create_v0_0_4(struct xsk_umem **umem_ptr, void *umem_area,
 		goto out_socket;
 	}
 
-	optlen = sizeof(off);
-	err = getsockopt(umem->fd, SOL_XDP, XDP_MMAP_OFFSETS, &off, &optlen);
+	err = xsk_get_mmap_offsets(umem->fd, &off);
 	if (err) {
 		err = -errno;
 		goto out_socket;
@@ -514,7 +579,6 @@ int xsk_socket__create(struct xsk_socket **xsk_ptr, const char *ifname,
 	struct sockaddr_xdp sxdp = {};
 	struct xdp_mmap_offsets off;
 	struct xsk_socket *xsk;
-	socklen_t optlen;
 	int err;
 
 	if (!umem || !xsk_ptr || !rx || !tx)
@@ -573,8 +637,7 @@ int xsk_socket__create(struct xsk_socket **xsk_ptr, const char *ifname,
 		}
 	}
 
-	optlen = sizeof(off);
-	err = getsockopt(xsk->fd, SOL_XDP, XDP_MMAP_OFFSETS, &off, &optlen);
+	err = xsk_get_mmap_offsets(xsk->fd, &off);
 	if (err) {
 		err = -errno;
 		goto out_socket;
@@ -660,7 +723,6 @@ int xsk_socket__create(struct xsk_socket **xsk_ptr, const char *ifname,
 int xsk_umem__delete(struct xsk_umem *umem)
 {
 	struct xdp_mmap_offsets off;
-	socklen_t optlen;
 	int err;
 
 	if (!umem)
@@ -669,8 +731,7 @@ int xsk_umem__delete(struct xsk_umem *umem)
 	if (umem->refcount)
 		return -EBUSY;
 
-	optlen = sizeof(off);
-	err = getsockopt(umem->fd, SOL_XDP, XDP_MMAP_OFFSETS, &off, &optlen);
+	err = xsk_get_mmap_offsets(umem->fd, &off);
 	if (!err) {
 		munmap(umem->fill->ring - off.fr.desc,
 		       off.fr.desc + umem->config.fill_size * sizeof(__u64));
@@ -688,7 +749,6 @@ void xsk_socket__delete(struct xsk_socket *xsk)
 {
 	size_t desc_sz = sizeof(struct xdp_desc);
 	struct xdp_mmap_offsets off;
-	socklen_t optlen;
 	int err;
 
 	if (!xsk)
@@ -699,8 +759,7 @@ void xsk_socket__delete(struct xsk_socket *xsk)
 		close(xsk->prog_fd);
 	}
 
-	optlen = sizeof(off);
-	err = getsockopt(xsk->fd, SOL_XDP, XDP_MMAP_OFFSETS, &off, &optlen);
+	err = xsk_get_mmap_offsets(xsk->fd, &off);
 	if (!err) {
 		if (xsk->rx) {
 			munmap(xsk->rx->ring - off.rx.desc,
-- 
2.7.4

