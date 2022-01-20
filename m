Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9072249472E
	for <lists+bpf@lfdr.de>; Thu, 20 Jan 2022 07:14:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231272AbiATGOy convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Thu, 20 Jan 2022 01:14:54 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:36396 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1358721AbiATGOd (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 20 Jan 2022 01:14:33 -0500
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20K1GtKb009307
        for <bpf@vger.kernel.org>; Wed, 19 Jan 2022 22:14:32 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3dpwwt96ws-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 19 Jan 2022 22:14:32 -0800
Received: from twshared13036.24.prn2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 19 Jan 2022 22:14:31 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 48FDCFBA1262; Wed, 19 Jan 2022 22:14:27 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 1/4] libbpf: streamline low-level XDP APIs
Date:   Wed, 19 Jan 2022 22:14:19 -0800
Message-ID: <20220120061422.2710637-2-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220120061422.2710637-1-andrii@kernel.org>
References: <20220120061422.2710637-1-andrii@kernel.org>
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: bqtHYc8PFnZd6PL_BS3TZq5KHXk7-mu4
X-Proofpoint-ORIG-GUID: bqtHYc8PFnZd6PL_BS3TZq5KHXk7-mu4
Content-Transfer-Encoding: 8BIT
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-20_02,2022-01-19_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 suspectscore=0
 malwarescore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 impostorscore=0 adultscore=0 mlxscore=0 mlxlogscore=999 phishscore=0
 bulkscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201200031
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Introduce 4 new netlink-based XDP APIs for attaching, detaching, and
querying XDP programs:
  - bpf_xdp_attach;
  - bpf_xdp_detach;
  - bpf_xdp_query;
  - bpf_xdp_query_id.

These APIs replace bpf_set_link_xdp_fd, bpf_set_link_xdp_fd_opts,
bpf_get_link_xdp_id, and bpf_get_link_xdp_info APIs ([0]). The latter
don't follow a consistent naming pattern and some of them use
non-extensible approaches (e.g., struct xdp_link_info which can't be
modified without breaking libbpf ABI).

The approach I took with these low-level XDP APIs is similar to what we
did with low-level TC APIs. There is a nice duality of bpf_tc_attach vs
bpf_xdp_attach, and so on. I left bpf_xdp_attach() to support detaching
when -1 is specified for prog_fd for generality and convenience, but
bpf_xdp_detach() is preferred due to clearer naming and associated
semantics. Both bpf_xdp_attach() and bpf_xdp_detach() accept the same
opts struct allowing to specify expected old_prog_fd.

While doing the refactoring, I noticed that old APIs require users to
specify opts with old_fd == -1 to declare "don't care about already
attached XDP prog fd" condition. Otherwise, FD 0 is assumed, which is
essentially never an intended behavior. So I made this behavior
consistent with other kernel and libbpf APIs, in which zero FD means "no
FD". This seems to be more in line with the latest thinking in BPF land
and should cause less user confusion, hopefully.

For querying, I left two APIs, both more generic bpf_xdp_query()
allowing to query multiple IDs and attach mode, but also
a specialization of it, bpf_xdp_query_id(), which returns only requested
prog_id. Uses of prog_id returning bpf_get_link_xdp_id() were so
prevalent across selftests and samples, that it seemed a very common use
case and using bpf_xdp_query() for doing it felt very cumbersome with
a highly branches if/else chain based on flags and attach mode.

Old APIs are scheduled for deprecation in libbpf 0.8 release.

  [0] Closes: https://github.com/libbpf/libbpf/issues/309

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/libbpf.h   |  29 ++++++++++
 tools/lib/bpf/libbpf.map |   4 ++
 tools/lib/bpf/netlink.c  | 117 ++++++++++++++++++++++++++++-----------
 3 files changed, 117 insertions(+), 33 deletions(-)

diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 9728551501ae..94670066de62 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -833,13 +833,42 @@ struct bpf_xdp_set_link_opts {
 };
 #define bpf_xdp_set_link_opts__last_field old_fd
 
+LIBBPF_DEPRECATED_SINCE(0, 8, "use bpf_xdp_attach() instead")
 LIBBPF_API int bpf_set_link_xdp_fd(int ifindex, int fd, __u32 flags);
+LIBBPF_DEPRECATED_SINCE(0, 8, "use bpf_xdp_attach() instead")
 LIBBPF_API int bpf_set_link_xdp_fd_opts(int ifindex, int fd, __u32 flags,
 					const struct bpf_xdp_set_link_opts *opts);
+LIBBPF_DEPRECATED_SINCE(0, 8, "use bpf_xdp_query_id() instead")
 LIBBPF_API int bpf_get_link_xdp_id(int ifindex, __u32 *prog_id, __u32 flags);
+LIBBPF_DEPRECATED_SINCE(0, 8, "use bpf_xdp_query() instead")
 LIBBPF_API int bpf_get_link_xdp_info(int ifindex, struct xdp_link_info *info,
 				     size_t info_size, __u32 flags);
 
+struct bpf_xdp_attach_opts {
+	size_t sz;
+	int old_prog_fd;
+	size_t :0;
+};
+#define bpf_xdp_attach_opts__last_field old_prog_fd
+
+struct bpf_xdp_query_opts {
+	size_t sz;
+	__u32 prog_id;		/* output */
+	__u32 drv_prog_id;	/* output */
+	__u32 hw_prog_id;	/* output */
+	__u32 skb_prog_id;	/* output */
+	__u8 attach_mode;	/* output */
+	size_t :0;
+};
+#define bpf_xdp_query_opts__last_field attach_mode
+
+LIBBPF_API int bpf_xdp_attach(int ifindex, int prog_fd, __u32 flags,
+			      const struct bpf_xdp_attach_opts *opts);
+LIBBPF_API int bpf_xdp_detach(int ifindex, __u32 flags,
+			      const struct bpf_xdp_attach_opts *opts);
+LIBBPF_API int bpf_xdp_query(int ifindex, int flags, struct bpf_xdp_query_opts *opts);
+LIBBPF_API int bpf_xdp_query_id(int ifindex, int flags, __u32 *prog_id);
+
 /* TC related API */
 enum bpf_tc_attach_point {
 	BPF_TC_INGRESS = 1 << 0,
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 8262cfca2240..e10f0822845a 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -428,6 +428,10 @@ LIBBPF_0.7.0 {
 		bpf_program__log_level;
 		bpf_program__set_log_buf;
 		bpf_program__set_log_level;
+		bpf_xdp_attach;
+		bpf_xdp_detach;
+		bpf_xdp_query;
+		bpf_xdp_query_id;
 		libbpf_probe_bpf_helper;
 		libbpf_probe_bpf_map_type;
 		libbpf_probe_bpf_prog_type;
diff --git a/tools/lib/bpf/netlink.c b/tools/lib/bpf/netlink.c
index 39f25e09b51e..c39c37f99d5c 100644
--- a/tools/lib/bpf/netlink.c
+++ b/tools/lib/bpf/netlink.c
@@ -217,6 +217,28 @@ static int __bpf_set_link_xdp_fd_replace(int ifindex, int fd, int old_fd,
 	return libbpf_netlink_send_recv(&req, NULL, NULL, NULL);
 }
 
+int bpf_xdp_attach(int ifindex, int prog_fd, __u32 flags, const struct bpf_xdp_attach_opts *opts)
+{
+	int old_prog_fd, err;
+
+	if (!OPTS_VALID(opts, bpf_xdp_attach_opts))
+		return libbpf_err(-EINVAL);
+
+	old_prog_fd = OPTS_GET(opts, old_prog_fd, 0);
+	if (old_prog_fd)
+		flags |= XDP_FLAGS_REPLACE;
+	else
+		old_prog_fd = -1;
+
+	err = __bpf_set_link_xdp_fd_replace(ifindex, prog_fd, old_prog_fd, flags);
+	return libbpf_err(err);
+}
+
+int bpf_xdp_detach(int ifindex, __u32 flags, const struct bpf_xdp_attach_opts *opts)
+{
+	return bpf_xdp_attach(ifindex, -1, flags, opts);
+}
+
 int bpf_set_link_xdp_fd_opts(int ifindex, int fd, __u32 flags,
 			     const struct bpf_xdp_set_link_opts *opts)
 {
@@ -303,69 +325,98 @@ static int get_xdp_info(void *cookie, void *msg, struct nlattr **tb)
 	return 0;
 }
 
-int bpf_get_link_xdp_info(int ifindex, struct xdp_link_info *info,
-			  size_t info_size, __u32 flags)
+int bpf_xdp_query(int ifindex, int xdp_flags, struct bpf_xdp_query_opts *opts)
 {
-	struct xdp_id_md xdp_id = {};
-	__u32 mask;
-	int ret;
 	struct libbpf_nla_req req = {
 		.nh.nlmsg_len      = NLMSG_LENGTH(sizeof(struct ifinfomsg)),
 		.nh.nlmsg_type     = RTM_GETLINK,
 		.nh.nlmsg_flags    = NLM_F_DUMP | NLM_F_REQUEST,
 		.ifinfo.ifi_family = AF_PACKET,
 	};
+	struct xdp_id_md xdp_id = {};
+	int err;
 
-	if (flags & ~XDP_FLAGS_MASK || !info_size)
+	if (!OPTS_VALID(opts, bpf_xdp_query_opts))
+		return libbpf_err(-EINVAL);
+
+	if (xdp_flags & ~XDP_FLAGS_MASK)
 		return libbpf_err(-EINVAL);
 
 	/* Check whether the single {HW,DRV,SKB} mode is set */
-	flags &= (XDP_FLAGS_SKB_MODE | XDP_FLAGS_DRV_MODE | XDP_FLAGS_HW_MODE);
-	mask = flags - 1;
-	if (flags && flags & mask)
+	xdp_flags &= XDP_FLAGS_SKB_MODE | XDP_FLAGS_DRV_MODE | XDP_FLAGS_HW_MODE;
+	if (xdp_flags & (xdp_flags - 1))
 		return libbpf_err(-EINVAL);
 
 	xdp_id.ifindex = ifindex;
-	xdp_id.flags = flags;
+	xdp_id.flags = xdp_flags;
 
-	ret = libbpf_netlink_send_recv(&req, __dump_link_nlmsg,
+	err = libbpf_netlink_send_recv(&req, __dump_link_nlmsg,
 				       get_xdp_info, &xdp_id);
-	if (!ret) {
-		size_t sz = min(info_size, sizeof(xdp_id.info));
+	if (err)
+		return libbpf_err(err);
 
-		memcpy(info, &xdp_id.info, sz);
-		memset((void *) info + sz, 0, info_size - sz);
-	}
+	OPTS_SET(opts, prog_id, xdp_id.info.prog_id);
+	OPTS_SET(opts, drv_prog_id, xdp_id.info.drv_prog_id);
+	OPTS_SET(opts, hw_prog_id, xdp_id.info.hw_prog_id);
+	OPTS_SET(opts, skb_prog_id, xdp_id.info.skb_prog_id);
+	OPTS_SET(opts, attach_mode, xdp_id.info.attach_mode);
 
-	return libbpf_err(ret);
+	return 0;
 }
 
-static __u32 get_xdp_id(struct xdp_link_info *info, __u32 flags)
+int bpf_get_link_xdp_info(int ifindex, struct xdp_link_info *info,
+			  size_t info_size, __u32 flags)
 {
-	flags &= XDP_FLAGS_MODES;
+	LIBBPF_OPTS(bpf_xdp_query_opts, opts);
+	size_t sz;
+	int err;
+
+	if (!info_size)
+		return libbpf_err(-EINVAL);
 
-	if (info->attach_mode != XDP_ATTACHED_MULTI && !flags)
-		return info->prog_id;
-	if (flags & XDP_FLAGS_DRV_MODE)
-		return info->drv_prog_id;
-	if (flags & XDP_FLAGS_HW_MODE)
-		return info->hw_prog_id;
-	if (flags & XDP_FLAGS_SKB_MODE)
-		return info->skb_prog_id;
+	err = bpf_xdp_query(ifindex, flags, &opts);
+	if (err)
+		return libbpf_err(err);
+
+	/* struct xdp_link_info field layout matches struct bpf_xdp_query_opts
+	 * layout after sz field
+	 */
+	sz = min(info_size, offsetofend(struct xdp_link_info, attach_mode));
+	memcpy(info, &opts.prog_id, sz);
+	memset((void *)info + sz, 0, info_size - sz);
 
 	return 0;
 }
 
-int bpf_get_link_xdp_id(int ifindex, __u32 *prog_id, __u32 flags)
+int bpf_xdp_query_id(int ifindex, int flags, __u32 *prog_id)
 {
-	struct xdp_link_info info;
+	LIBBPF_OPTS(bpf_xdp_query_opts, opts);
 	int ret;
 
-	ret = bpf_get_link_xdp_info(ifindex, &info, sizeof(info), flags);
-	if (!ret)
-		*prog_id = get_xdp_id(&info, flags);
+	ret = bpf_xdp_query(ifindex, flags, &opts);
+	if (ret)
+		return libbpf_err(ret);
+
+	flags &= XDP_FLAGS_MODES;
 
-	return libbpf_err(ret);
+	if (opts.attach_mode != XDP_ATTACHED_MULTI && !flags)
+		*prog_id = opts.prog_id;
+	else if (flags & XDP_FLAGS_DRV_MODE)
+		*prog_id = opts.drv_prog_id;
+	else if (flags & XDP_FLAGS_HW_MODE)
+		*prog_id = opts.hw_prog_id;
+	else if (flags & XDP_FLAGS_SKB_MODE)
+		*prog_id = opts.skb_prog_id;
+	else
+		*prog_id = 0;
+
+	return 0;
+}
+
+
+int bpf_get_link_xdp_id(int ifindex, __u32 *prog_id, __u32 flags)
+{
+	return bpf_xdp_query_id(ifindex, flags, prog_id);
 }
 
 typedef int (*qdisc_config_t)(struct libbpf_nla_req *req);
-- 
2.30.2

