Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4F3C65D264
	for <lists+bpf@lfdr.de>; Wed,  4 Jan 2023 13:20:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239251AbjADMTi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 4 Jan 2023 07:19:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239210AbjADMTV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 4 Jan 2023 07:19:21 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E654B3739C;
        Wed,  4 Jan 2023 04:18:55 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id p1-20020a05600c1d8100b003d8c9b191e0so26270066wms.4;
        Wed, 04 Jan 2023 04:18:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9IrdotBTH+GLZdNg1Jm80pQe/cT7CwjM8cp9rwgvmVs=;
        b=mCIo94qeecPMkThu2gMqh+inwASx4mg/7LXdOL/KAHNme5NhMTnq3lbBl/Q5H8W7k1
         Eysq8vF5W3irWOPSj7UL144ePZ0coZULmjqVBqgCQ+4KPvFNEgxsNTtcFCiIwcqELi2q
         y+b0D7NKeadhzyKCQrBAiSnIxhPZsPMCIo9zn/F51CoxnYQX6DEQCmpX3cHVTiyMeT+l
         SF6XSJpHe5MkJuwwmHyYDVLVeNdBsU8GPLQjGVSRGO7K1sV+kGCwXTjdVfG5O5usUMUB
         rhypW4nMH2onR5drGDoPf3B1pnyVi3j9xZXKZ3zmLWsFzugyRSxndU7dAHUZcYKKuhXV
         kG5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9IrdotBTH+GLZdNg1Jm80pQe/cT7CwjM8cp9rwgvmVs=;
        b=2awrl0Z9G9zhKqJePQMb9LFbwiQmYl2j6D6r3a8NPTONtIqDm6fGl9+Os2Q1JY5ZVG
         iUNcCpW9yMa2MVBb89CrMDn6bKyZL8qoMbldGdRrbTcV756S2H0umJrGlhSgM2ROXV7O
         xQWX7op822ElR/DIc/4ApWtbDYVMxkf6a5ZaI7j6YbQ8dWotZdtuIXOMeR8qQxkNht7M
         rZkjPBx2jOjWj5p2ZKRFafzMQ/1AqYw2GZ+MCeE+ZweZO55XD0hk2Ep04pBM0EIEznnT
         6qFJTr9UDNtbiiO+t7xa34KrFus+RdUBI+iiR7pIvIt+k7Q+hhF8HGMufzca4MTVgVMe
         vInQ==
X-Gm-Message-State: AFqh2kqTrP5YMu/4zNPyBJF304kamfjVGlk/Wgtil3si/O1X6HRzgqAq
        fhgHqHD0jyXU5ytl1cDBCi0=
X-Google-Smtp-Source: AMrXdXsU6pRQZQ9JTXP9+l6EfvTrzarjClpEa5S8rRQaNkdLzRieO9mTgamMvfvbUUDZ4l1b24rQRg==
X-Received: by 2002:a05:600c:3584:b0:3d9:719a:8f7d with SMTP id p4-20020a05600c358400b003d9719a8f7dmr26346157wmq.35.1672834734300;
        Wed, 04 Jan 2023 04:18:54 -0800 (PST)
Received: from localhost.localdomain (h-176-10-254-193.A165.priv.bahnhof.se. [176.10.254.193])
        by smtp.gmail.com with ESMTPSA id w12-20020a05600c474c00b003d04e4ed873sm35013749wmo.22.2023.01.04.04.18.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Jan 2023 04:18:53 -0800 (PST)
From:   Magnus Karlsson <magnus.karlsson@gmail.com>
To:     magnus.karlsson@intel.com, bjorn@kernel.org, ast@kernel.org,
        daniel@iogearbox.net, netdev@vger.kernel.org,
        maciej.fijalkowski@intel.com, bpf@vger.kernel.org, yhs@fb.com,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, tirthendu.sarkar@intel.com
Cc:     jonathan.lemon@gmail.com
Subject: [PATCH bpf-next v2 09/15] selftests/xsk: load and attach XDP program only once per mode
Date:   Wed,  4 Jan 2023 13:17:38 +0100
Message-Id: <20230104121744.2820-10-magnus.karlsson@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230104121744.2820-1-magnus.karlsson@gmail.com>
References: <20230104121744.2820-1-magnus.karlsson@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Magnus Karlsson <magnus.karlsson@intel.com>

Load and attach the XDP program only once per XDP mode that is being
executed. Today, the XDP program is loaded and attached for every
test, then unloaded, which takes a long time on real NICs, since they
have to reconfigure their HW, in contrast to veth. The test suite now
completes in 21 seconds, instead of 207 seconds previously on my
machine. This is a speed-up of around 10x.

This is accomplished by moving the XDP loading from the worker threads
to the main thread and replacing the XDP loading interfaces of xsk.c
that was taken from the xsk support in libbpf, with something more
explicit that is more useful for these tests. Instead, the relevant
file descriptors and ifindexes are just passed down to the new
functions.

Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
---
 tools/testing/selftests/bpf/xsk.c        |  92 +++++++++-----
 tools/testing/selftests/bpf/xsk.h        |   7 +-
 tools/testing/selftests/bpf/xskxceiver.c | 147 ++++++++++++++---------
 tools/testing/selftests/bpf/xskxceiver.h |   3 +
 4 files changed, 162 insertions(+), 87 deletions(-)

diff --git a/tools/testing/selftests/bpf/xsk.c b/tools/testing/selftests/bpf/xsk.c
index b166edfff86d..1dd953541812 100644
--- a/tools/testing/selftests/bpf/xsk.c
+++ b/tools/testing/selftests/bpf/xsk.c
@@ -51,6 +51,8 @@
 
 #define pr_warn(fmt, ...) fprintf(stderr, fmt, ##__VA_ARGS__)
 
+#define XSKMAP_SIZE 1
+
 enum xsk_prog {
 	XSK_PROG_FALLBACK,
 	XSK_PROG_REDIRECT_FLAGS,
@@ -387,10 +389,9 @@ static enum xsk_prog get_xsk_prog(void)
 	return detected;
 }
 
-static int xsk_load_xdp_prog(struct xsk_socket *xsk)
+static int __xsk_load_xdp_prog(int xsk_map_fd)
 {
 	static const int log_buf_size = 16 * 1024;
-	struct xsk_ctx *ctx = xsk->ctx;
 	char log_buf[log_buf_size];
 	int prog_fd;
 
@@ -418,7 +419,7 @@ static int xsk_load_xdp_prog(struct xsk_socket *xsk)
 		/* *(u32 *)(r10 - 4) = r2 */
 		BPF_STX_MEM(BPF_W, BPF_REG_10, BPF_REG_2, -4),
 		/* r1 = xskmap[] */
-		BPF_LD_MAP_FD(BPF_REG_1, ctx->xsks_map_fd),
+		BPF_LD_MAP_FD(BPF_REG_1, xsk_map_fd),
 		/* r3 = XDP_PASS */
 		BPF_MOV64_IMM(BPF_REG_3, 2),
 		/* call bpf_redirect_map */
@@ -430,7 +431,7 @@ static int xsk_load_xdp_prog(struct xsk_socket *xsk)
 		/* r2 += -4 */
 		BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -4),
 		/* r1 = xskmap[] */
-		BPF_LD_MAP_FD(BPF_REG_1, ctx->xsks_map_fd),
+		BPF_LD_MAP_FD(BPF_REG_1, xsk_map_fd),
 		/* call bpf_map_lookup_elem */
 		BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
 		/* r1 = r0 */
@@ -442,7 +443,7 @@ static int xsk_load_xdp_prog(struct xsk_socket *xsk)
 		/* r2 = *(u32 *)(r10 - 4) */
 		BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_10, -4),
 		/* r1 = xskmap[] */
-		BPF_LD_MAP_FD(BPF_REG_1, ctx->xsks_map_fd),
+		BPF_LD_MAP_FD(BPF_REG_1, xsk_map_fd),
 		/* r3 = 0 */
 		BPF_MOV64_IMM(BPF_REG_3, 0),
 		/* call bpf_redirect_map */
@@ -461,7 +462,7 @@ static int xsk_load_xdp_prog(struct xsk_socket *xsk)
 		/* r2 = *(u32 *)(r1 + 16) */
 		BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_1, 16),
 		/* r1 = xskmap[] */
-		BPF_LD_MAP_FD(BPF_REG_1, ctx->xsks_map_fd),
+		BPF_LD_MAP_FD(BPF_REG_1, xsk_map_fd),
 		/* r3 = XDP_PASS */
 		BPF_MOV64_IMM(BPF_REG_3, 2),
 		/* call bpf_redirect_map */
@@ -480,13 +481,40 @@ static int xsk_load_xdp_prog(struct xsk_socket *xsk)
 
 	prog_fd = bpf_prog_load(BPF_PROG_TYPE_XDP, NULL, "LGPL-2.1 or BSD-2-Clause",
 				progs[option], insns_cnt[option], &opts);
-	if (prog_fd < 0) {
+	if (prog_fd < 0)
 		pr_warn("BPF log buffer:\n%s", log_buf);
-		return prog_fd;
+
+	return prog_fd;
+}
+
+int xsk_attach_xdp_program(int ifindex, int prog_fd, u32 xdp_flags)
+{
+	DECLARE_LIBBPF_OPTS(bpf_link_create_opts, opts);
+	__u32 prog_id = 0;
+	int link_fd;
+	int err;
+
+	err = bpf_xdp_query_id(ifindex, xdp_flags, &prog_id);
+	if (err) {
+		pr_warn("getting XDP prog id failed\n");
+		return err;
 	}
 
-	ctx->prog_fd = prog_fd;
-	return 0;
+	/* If there's a netlink-based XDP prog loaded on interface, bail out
+	 * and ask user to do the removal by himself
+	 */
+	if (prog_id) {
+		pr_warn("Netlink-based XDP prog detected, please unload it in order to launch AF_XDP prog\n");
+		return -EINVAL;
+	}
+
+	opts.flags = xdp_flags & ~(XDP_FLAGS_UPDATE_IF_NOEXIST | XDP_FLAGS_REPLACE);
+
+	link_fd = bpf_link_create(prog_fd, ifindex, BPF_XDP, &opts);
+	if (link_fd < 0)
+		pr_warn("bpf_link_create failed: %s\n", strerror(errno));
+
+	return link_fd;
 }
 
 static int xsk_create_bpf_link(struct xsk_socket *xsk)
@@ -775,7 +803,7 @@ static int xsk_init_xdp_res(struct xsk_socket *xsk,
 	if (err)
 		return err;
 
-	err = xsk_load_xdp_prog(xsk);
+	err = __xsk_load_xdp_prog(*xsks_map_fd);
 	if (err)
 		goto err_load_xdp_prog;
 
@@ -871,6 +899,22 @@ int xsk_setup_xdp_prog_xsk(struct xsk_socket *xsk, int *xsks_map_fd)
 	return __xsk_setup_xdp_prog(xsk, xsks_map_fd);
 }
 
+int xsk_load_xdp_program(int *xsk_map_fd, int *prog_fd)
+{
+	*xsk_map_fd = bpf_map_create(BPF_MAP_TYPE_XSKMAP, "xsks_map", sizeof(int), sizeof(int),
+				     XSKMAP_SIZE, NULL);
+	if (*xsk_map_fd < 0)
+		return *xsk_map_fd;
+
+	*prog_fd = __xsk_load_xdp_prog(*xsk_map_fd);
+	if (*prog_fd < 0) {
+		close(*xsk_map_fd);
+		return *prog_fd;
+	}
+
+	return 0;
+}
+
 static struct xsk_ctx *xsk_get_ctx(struct xsk_umem *umem, int ifindex,
 				   __u32 queue_id)
 {
@@ -917,7 +961,7 @@ static void xsk_put_ctx(struct xsk_ctx *ctx, bool unmap)
 
 static struct xsk_ctx *xsk_create_ctx(struct xsk_socket *xsk,
 				      struct xsk_umem *umem, int ifindex,
-				      const char *ifname, __u32 queue_id,
+				      __u32 queue_id,
 				      struct xsk_ring_prod *fill,
 				      struct xsk_ring_cons *comp)
 {
@@ -944,7 +988,6 @@ static struct xsk_ctx *xsk_create_ctx(struct xsk_socket *xsk,
 	ctx->refcount = 1;
 	ctx->umem = umem;
 	ctx->queue_id = queue_id;
-	bpf_strlcpy(ctx->ifname, ifname, IFNAMSIZ);
 	ctx->prog_fd = FD_NOT_USED;
 	ctx->link_fd = FD_NOT_USED;
 	ctx->xsks_map_fd = FD_NOT_USED;
@@ -991,7 +1034,7 @@ int xsk_setup_xdp_prog(int ifindex, int *xsks_map_fd)
 }
 
 int xsk_socket__create_shared(struct xsk_socket **xsk_ptr,
-			      const char *ifname,
+			      int ifindex,
 			      __u32 queue_id, struct xsk_umem *umem,
 			      struct xsk_ring_cons *rx,
 			      struct xsk_ring_prod *tx,
@@ -1005,7 +1048,7 @@ int xsk_socket__create_shared(struct xsk_socket **xsk_ptr,
 	struct xdp_mmap_offsets off;
 	struct xsk_socket *xsk;
 	struct xsk_ctx *ctx;
-	int err, ifindex;
+	int err;
 
 	if (!umem || !xsk_ptr || !(rx || tx))
 		return -EFAULT;
@@ -1020,12 +1063,6 @@ int xsk_socket__create_shared(struct xsk_socket **xsk_ptr,
 	if (err)
 		goto out_xsk_alloc;
 
-	ifindex = if_nametoindex(ifname);
-	if (!ifindex) {
-		err = -errno;
-		goto out_xsk_alloc;
-	}
-
 	if (umem->refcount++ > 0) {
 		xsk->fd = socket(AF_XDP, SOCK_RAW | SOCK_CLOEXEC, 0);
 		if (xsk->fd < 0) {
@@ -1045,8 +1082,7 @@ int xsk_socket__create_shared(struct xsk_socket **xsk_ptr,
 			goto out_socket;
 		}
 
-		ctx = xsk_create_ctx(xsk, umem, ifindex, ifname, queue_id,
-				     fill, comp);
+		ctx = xsk_create_ctx(xsk, umem, ifindex, queue_id, fill, comp);
 		if (!ctx) {
 			err = -ENOMEM;
 			goto out_socket;
@@ -1144,12 +1180,6 @@ int xsk_socket__create_shared(struct xsk_socket **xsk_ptr,
 		goto out_mmap_tx;
 	}
 
-	if (!(xsk->config.libbpf_flags & XSK_LIBBPF_FLAGS__INHIBIT_PROG_LOAD)) {
-		err = __xsk_setup_xdp_prog(xsk, NULL);
-		if (err)
-			goto out_mmap_tx;
-	}
-
 	*xsk_ptr = xsk;
 	umem->fill_save = NULL;
 	umem->comp_save = NULL;
@@ -1173,7 +1203,7 @@ int xsk_socket__create_shared(struct xsk_socket **xsk_ptr,
 	return err;
 }
 
-int xsk_socket__create(struct xsk_socket **xsk_ptr, const char *ifname,
+int xsk_socket__create(struct xsk_socket **xsk_ptr, int ifindex,
 		       __u32 queue_id, struct xsk_umem *umem,
 		       struct xsk_ring_cons *rx, struct xsk_ring_prod *tx,
 		       const struct xsk_socket_config *usr_config)
@@ -1181,7 +1211,7 @@ int xsk_socket__create(struct xsk_socket **xsk_ptr, const char *ifname,
 	if (!umem)
 		return -EFAULT;
 
-	return xsk_socket__create_shared(xsk_ptr, ifname, queue_id, umem,
+	return xsk_socket__create_shared(xsk_ptr, ifindex, queue_id, umem,
 					 rx, tx, umem->fill_save,
 					 umem->comp_save, usr_config);
 }
diff --git a/tools/testing/selftests/bpf/xsk.h b/tools/testing/selftests/bpf/xsk.h
index 24ee765aded3..7a5aeacd261b 100644
--- a/tools/testing/selftests/bpf/xsk.h
+++ b/tools/testing/selftests/bpf/xsk.h
@@ -204,6 +204,9 @@ int xsk_socket__update_xskmap(struct xsk_socket *xsk, int xsks_map_fd);
 /* Flags for the libbpf_flags field. */
 #define XSK_LIBBPF_FLAGS__INHIBIT_PROG_LOAD (1 << 0)
 
+int xsk_load_xdp_program(int *xsk_map_fd, int *prog_fd);
+int xsk_attach_xdp_program(int ifindex, int prog_fd, u32 xdp_flags);
+
 struct xsk_socket_config {
 	__u32 rx_size;
 	__u32 tx_size;
@@ -219,13 +222,13 @@ int xsk_umem__create(struct xsk_umem **umem,
 		     struct xsk_ring_cons *comp,
 		     const struct xsk_umem_config *config);
 int xsk_socket__create(struct xsk_socket **xsk,
-		       const char *ifname, __u32 queue_id,
+		       int ifindex, __u32 queue_id,
 		       struct xsk_umem *umem,
 		       struct xsk_ring_cons *rx,
 		       struct xsk_ring_prod *tx,
 		       const struct xsk_socket_config *config);
 int xsk_socket__create_shared(struct xsk_socket **xsk_ptr,
-			      const char *ifname,
+			      int ifindex,
 			      __u32 queue_id, struct xsk_umem *umem,
 			      struct xsk_ring_cons *rx,
 			      struct xsk_ring_prod *tx,
diff --git a/tools/testing/selftests/bpf/xskxceiver.c b/tools/testing/selftests/bpf/xskxceiver.c
index 4c8f32e1c431..0c0974c209cd 100644
--- a/tools/testing/selftests/bpf/xskxceiver.c
+++ b/tools/testing/selftests/bpf/xskxceiver.c
@@ -268,6 +268,11 @@ static void gen_udp_csum(struct udphdr *udp_hdr, struct iphdr *ip_hdr)
 	    udp_csum(ip_hdr->saddr, ip_hdr->daddr, UDP_PKT_SIZE, IPPROTO_UDP, (u16 *)udp_hdr);
 }
 
+static u32 mode_to_xdp_flags(enum test_mode mode)
+{
+	return (mode == TEST_MODE_SKB) ? XDP_FLAGS_SKB_MODE : XDP_FLAGS_DRV_MODE;
+}
+
 static int xsk_configure_umem(struct xsk_umem_info *umem, void *buffer, u64 size)
 {
 	struct xsk_umem_config cfg = {
@@ -329,7 +334,7 @@ static int __xsk_configure_socket(struct xsk_socket_info *xsk, struct xsk_umem_i
 
 	txr = ifobject->tx_on ? &xsk->tx : NULL;
 	rxr = ifobject->rx_on ? &xsk->rx : NULL;
-	return xsk_socket__create(&xsk->xsk, ifobject->ifname, 0, umem->umem, rxr, txr, &cfg);
+	return xsk_socket__create(&xsk->xsk, ifobject->ifindex, 0, umem->umem, rxr, txr, &cfg);
 }
 
 static bool ifobj_zc_avail(struct ifobject *ifobject)
@@ -359,8 +364,7 @@ static bool ifobj_zc_avail(struct ifobject *ifobject)
 	xsk = calloc(1, sizeof(struct xsk_socket_info));
 	if (!xsk)
 		goto out;
-	ifobject->xdp_flags = XDP_FLAGS_UPDATE_IF_NOEXIST;
-	ifobject->xdp_flags |= XDP_FLAGS_DRV_MODE;
+	ifobject->xdp_flags = XDP_FLAGS_DRV_MODE;
 	ifobject->bind_flags = XDP_USE_NEED_WAKEUP | XDP_ZEROCOPY;
 	ifobject->rx_on = true;
 	xsk->rxqsize = XSK_RING_CONS__DEFAULT_NUM_DESCS;
@@ -430,6 +434,11 @@ static void parse_command_line(struct ifobject *ifobj_tx, struct ifobject *ifobj
 
 			memcpy(ifobj->ifname, optarg,
 			       min_t(size_t, MAX_INTERFACE_NAME_CHARS, strlen(optarg)));
+
+			ifobj->ifindex = if_nametoindex(ifobj->ifname);
+			if (!ifobj->ifindex)
+				exit_with_error(errno);
+
 			interface_nb++;
 			break;
 		case 'D':
@@ -510,12 +519,6 @@ static void test_spec_init(struct test_spec *test, struct ifobject *ifobj_tx,
 	for (i = 0; i < MAX_INTERFACES; i++) {
 		struct ifobject *ifobj = i ? ifobj_rx : ifobj_tx;
 
-		ifobj->xdp_flags = XDP_FLAGS_UPDATE_IF_NOEXIST;
-		if (mode == TEST_MODE_SKB)
-			ifobj->xdp_flags |= XDP_FLAGS_SKB_MODE;
-		else
-			ifobj->xdp_flags |= XDP_FLAGS_DRV_MODE;
-
 		ifobj->bind_flags = XDP_USE_NEED_WAKEUP;
 		if (mode == TEST_MODE_ZC)
 			ifobj->bind_flags |= XDP_ZEROCOPY;
@@ -1252,7 +1255,8 @@ static void thread_common_ops(struct test_spec *test, struct ifobject *ifobject)
 	u64 umem_sz = ifobject->umem->num_frames * ifobject->umem->frame_size;
 	int mmap_flags = MAP_PRIVATE | MAP_ANONYMOUS | MAP_NORESERVE;
 	LIBBPF_OPTS(bpf_xdp_query_opts, opts);
-	int ret, ifindex;
+	u32 queue_id = 0;
+	int ret, fd;
 	void *bufs;
 
 	if (ifobject->umem->unaligned_mode)
@@ -1278,31 +1282,8 @@ static void thread_common_ops(struct test_spec *test, struct ifobject *ifobject)
 	if (!ifobject->rx_on)
 		return;
 
-	ifindex = if_nametoindex(ifobject->ifname);
-	if (!ifindex)
-		exit_with_error(errno);
-
-	ret = xsk_setup_xdp_prog_xsk(ifobject->xsk->xsk, &ifobject->xsk_map_fd);
-	if (ret)
-		exit_with_error(-ret);
-
-	ret = bpf_xdp_query(ifindex, ifobject->xdp_flags, &opts);
-	if (ret)
-		exit_with_error(-ret);
-
-	if (ifobject->xdp_flags & XDP_FLAGS_SKB_MODE) {
-		if (opts.attach_mode != XDP_ATTACHED_SKB) {
-			ksft_print_msg("ERROR: [%s] XDP prog not in SKB mode\n");
-			exit_with_error(EINVAL);
-		}
-	} else if (ifobject->xdp_flags & XDP_FLAGS_DRV_MODE) {
-		if (opts.attach_mode != XDP_ATTACHED_DRV) {
-			ksft_print_msg("ERROR: [%s] XDP prog not in DRV mode\n");
-			exit_with_error(EINVAL);
-		}
-	}
-
-	ret = xsk_socket__update_xskmap(ifobject->xsk->xsk, ifobject->xsk_map_fd);
+	fd = xsk_socket__fd(ifobject->xsk->xsk);
+	ret = bpf_map_update_elem(ifobject->xsk_map_fd, &queue_id, &fd, 0);
 	if (ret)
 		exit_with_error(errno);
 }
@@ -1336,15 +1317,19 @@ static void *worker_testapp_validate_rx(void *arg)
 {
 	struct test_spec *test = (struct test_spec *)arg;
 	struct ifobject *ifobject = test->ifobj_rx;
+	int id = 0, err, fd = xsk_socket__fd(ifobject->xsk->xsk);
 	struct pollfd fds = { };
-	int id = 0;
-	int err;
+	u32 queue_id = 0;
 
 	if (test->current_step == 1) {
 		thread_common_ops(test, ifobject);
 	} else {
 		bpf_map_delete_elem(ifobject->xsk_map_fd, &id);
-		xsk_socket__update_xskmap(ifobject->xsk->xsk, ifobject->xsk_map_fd);
+		err = bpf_map_update_elem(ifobject->xsk_map_fd, &queue_id, &fd, 0);
+		if (err) {
+			printf("Error: Failed to update xskmap, error %s\n", strerror(err));
+			exit_with_error(err);
+		}
 	}
 
 	fds.fd = xsk_socket__fd(ifobject->xsk->xsk);
@@ -1413,7 +1398,10 @@ static int testapp_validate_traffic_single_thread(struct test_spec *test, struct
 	pthread_join(t0, NULL);
 
 	if (test->total_steps == test->current_step || test->fail) {
+		u32 queue_id = 0;
+
 		xsk_socket__delete(ifobj->xsk->xsk);
+		bpf_map_delete_elem(ifobj->xsk_map_fd, &queue_id);
 		testapp_clean_xsk_umem(ifobj);
 	}
 
@@ -1502,14 +1490,14 @@ static void testapp_bidi(struct test_spec *test)
 
 static void swap_xsk_resources(struct ifobject *ifobj_tx, struct ifobject *ifobj_rx)
 {
-	int ret;
+	int ret, queue_id = 0, fd = xsk_socket__fd(ifobj_rx->xsk->xsk);
 
 	xsk_socket__delete(ifobj_tx->xsk->xsk);
 	xsk_socket__delete(ifobj_rx->xsk->xsk);
 	ifobj_tx->xsk = &ifobj_tx->xsk_arr[1];
 	ifobj_rx->xsk = &ifobj_rx->xsk_arr[1];
 
-	ret = xsk_socket__update_xskmap(ifobj_rx->xsk->xsk, ifobj_rx->xsk_map_fd);
+	ret = bpf_map_update_elem(ifobj_rx->xsk_map_fd, &queue_id, &fd, 0);
 	if (ret)
 		exit_with_error(errno);
 }
@@ -1673,8 +1661,9 @@ static void testapp_invalid_desc(struct test_spec *test)
 
 static void init_iface(struct ifobject *ifobj, const char *dst_mac, const char *src_mac,
 		       const char *dst_ip, const char *src_ip, const u16 dst_port,
-		       const u16 src_port, thread_func_t func_ptr)
+		       const u16 src_port, thread_func_t func_ptr, bool load_xdp)
 {
+	int xsk_map_fd, prog_fd, err;
 	struct in_addr ip;
 
 	memcpy(ifobj->dst_mac, dst_mac, ETH_ALEN);
@@ -1690,6 +1679,24 @@ static void init_iface(struct ifobject *ifobj, const char *dst_mac, const char *
 	ifobj->src_port = src_port;
 
 	ifobj->func_ptr = func_ptr;
+
+	if (!load_xdp)
+		return;
+
+	err = xsk_load_xdp_program(&xsk_map_fd, &prog_fd);
+	if (err) {
+		printf("Error loading XDP program\n");
+		exit_with_error(err);
+	}
+
+	ifobj->xsk_map_fd = xsk_map_fd;
+	ifobj->prog_fd = prog_fd;
+	ifobj->xdp_flags = mode_to_xdp_flags(TEST_MODE_SKB);
+	ifobj->link_fd = xsk_attach_xdp_program(ifobj->ifindex, prog_fd, ifobj->xdp_flags);
+	if (ifobj->link_fd < 0) {
+		printf("Error attaching XDP program\n");
+		exit_with_error(ifobj->link_fd);
+	}
 }
 
 static void run_pkt_test(struct test_spec *test, enum test_mode mode, enum test_type type)
@@ -1824,12 +1831,15 @@ static struct ifobject *ifobject_create(void)
 
 static void ifobject_delete(struct ifobject *ifobj)
 {
+	close(ifobj->prog_fd);
+	close(ifobj->xsk_map_fd);
+
 	free(ifobj->umem);
 	free(ifobj->xsk_arr);
 	free(ifobj);
 }
 
-static bool is_xdp_supported(struct ifobject *ifobject)
+static bool is_xdp_supported(int ifindex)
 {
 	int flags = XDP_FLAGS_DRV_MODE;
 
@@ -1838,7 +1848,6 @@ static bool is_xdp_supported(struct ifobject *ifobject)
 		BPF_MOV64_IMM(BPF_REG_0, XDP_PASS),
 		BPF_EXIT_INSN()
 	};
-	int ifindex = if_nametoindex(ifobject->ifname);
 	int prog_fd, insn_cnt = ARRAY_SIZE(insns);
 	int err;
 
@@ -1858,6 +1867,29 @@ static bool is_xdp_supported(struct ifobject *ifobject)
 	return true;
 }
 
+static void change_to_drv_mode(struct ifobject *ifobj)
+{
+	LIBBPF_OPTS(bpf_xdp_query_opts, opts);
+	int ret;
+
+	close(ifobj->link_fd);
+	ifobj->link_fd = xsk_attach_xdp_program(ifobj->ifindex, ifobj->prog_fd,
+						XDP_FLAGS_DRV_MODE);
+	if (ifobj->link_fd < 0) {
+		ksft_print_msg("Error attaching XDP program\n");
+		exit_with_error(-ifobj->link_fd);
+	}
+
+	ret = bpf_xdp_query(ifobj->ifindex, XDP_FLAGS_DRV_MODE, &opts);
+	if (ret)
+		exit_with_error(errno);
+
+	if (opts.attach_mode != XDP_ATTACHED_DRV) {
+		ksft_print_msg("ERROR: XDP prog not in DRV mode\n");
+		exit_with_error(EINVAL);
+	}
+}
+
 int main(int argc, char **argv)
 {
 	struct pkt_stream *rx_pkt_stream_default;
@@ -1866,7 +1898,7 @@ int main(int argc, char **argv)
 	int modes = TEST_MODE_SKB + 1;
 	u32 i, j, failed_tests = 0;
 	struct test_spec test;
-	bool shared_umem;
+	bool shared_netdev;
 
 	/* Use libbpf 1.0 API mode */
 	libbpf_set_strict_mode(LIBBPF_STRICT_ALL);
@@ -1881,27 +1913,27 @@ int main(int argc, char **argv)
 	setlocale(LC_ALL, "");
 
 	parse_command_line(ifobj_tx, ifobj_rx, argc, argv);
-	shared_umem = !strcmp(ifobj_tx->ifname, ifobj_rx->ifname);
 
-	ifobj_tx->shared_umem = shared_umem;
-	ifobj_rx->shared_umem = shared_umem;
+	shared_netdev = (ifobj_tx->ifindex == ifobj_rx->ifindex);
+	ifobj_tx->shared_umem = shared_netdev;
+	ifobj_rx->shared_umem = shared_netdev;
 
 	if (!validate_interface(ifobj_tx) || !validate_interface(ifobj_rx)) {
 		usage(basename(argv[0]));
 		ksft_exit_xfail();
 	}
 
-	init_iface(ifobj_tx, MAC1, MAC2, IP1, IP2, UDP_PORT1, UDP_PORT2,
-		   worker_testapp_validate_tx);
-	init_iface(ifobj_rx, MAC2, MAC1, IP2, IP1, UDP_PORT2, UDP_PORT1,
-		   worker_testapp_validate_rx);
-
-	if (is_xdp_supported(ifobj_tx)) {
+	if (is_xdp_supported(ifobj_tx->ifindex)) {
 		modes++;
 		if (ifobj_zc_avail(ifobj_tx))
 			modes++;
 	}
 
+	init_iface(ifobj_rx, MAC1, MAC2, IP1, IP2, UDP_PORT1, UDP_PORT2,
+		   worker_testapp_validate_rx, true);
+	init_iface(ifobj_tx, MAC2, MAC1, IP2, IP1, UDP_PORT2, UDP_PORT1,
+		   worker_testapp_validate_tx, !shared_netdev);
+
 	test_spec_init(&test, ifobj_tx, ifobj_rx, 0);
 	tx_pkt_stream_default = pkt_stream_generate(ifobj_tx->umem, DEFAULT_PKT_CNT, PKT_SIZE);
 	rx_pkt_stream_default = pkt_stream_generate(ifobj_rx->umem, DEFAULT_PKT_CNT, PKT_SIZE);
@@ -1912,7 +1944,13 @@ int main(int argc, char **argv)
 
 	ksft_set_plan(modes * TEST_TYPE_MAX);
 
-	for (i = 0; i < modes; i++)
+	for (i = 0; i < modes; i++) {
+		if (i == TEST_MODE_DRV) {
+			change_to_drv_mode(ifobj_rx);
+			if (!shared_netdev)
+				change_to_drv_mode(ifobj_tx);
+		}
+
 		for (j = 0; j < TEST_TYPE_MAX; j++) {
 			test_spec_init(&test, ifobj_tx, ifobj_rx, i);
 			run_pkt_test(&test, i, j);
@@ -1921,6 +1959,7 @@ int main(int argc, char **argv)
 			if (test.fail)
 				failed_tests++;
 		}
+	}
 
 	pkt_stream_delete(tx_pkt_stream_default);
 	pkt_stream_delete(rx_pkt_stream_default);
diff --git a/tools/testing/selftests/bpf/xskxceiver.h b/tools/testing/selftests/bpf/xskxceiver.h
index dcb908f5bb4c..b2ba877b1966 100644
--- a/tools/testing/selftests/bpf/xskxceiver.h
+++ b/tools/testing/selftests/bpf/xskxceiver.h
@@ -139,6 +139,9 @@ struct ifobject {
 	validation_func_t validation_func;
 	struct pkt_stream *pkt_stream;
 	int xsk_map_fd;
+	int prog_fd;
+	int link_fd;
+	int ifindex;
 	u32 dst_ip;
 	u32 src_ip;
 	u32 xdp_flags;
-- 
2.34.1

