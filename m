Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEE0655CE91
	for <lists+bpf@lfdr.de>; Tue, 28 Jun 2022 15:05:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241056AbiF0VPk convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Mon, 27 Jun 2022 17:15:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234920AbiF0VPk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Jun 2022 17:15:40 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66238167C7
        for <bpf@vger.kernel.org>; Mon, 27 Jun 2022 14:15:39 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25RJ1Ogn024549
        for <bpf@vger.kernel.org>; Mon, 27 Jun 2022 14:15:39 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3gwyfsdu4r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 27 Jun 2022 14:15:38 -0700
Received: from twshared31479.05.prn5.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 27 Jun 2022 14:15:38 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id ADE431BAC2790; Mon, 27 Jun 2022 14:15:35 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH v2 bpf-next 03/15] libbpf: remove deprecated XDP APIs
Date:   Mon, 27 Jun 2022 14:15:15 -0700
Message-ID: <20220627211527.2245459-4-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220627211527.2245459-1-andrii@kernel.org>
References: <20220627211527.2245459-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 4Ppc6YzYyxjdM47DQZIzRvUiUjYVDKnk
X-Proofpoint-ORIG-GUID: 4Ppc6YzYyxjdM47DQZIzRvUiUjYVDKnk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-06-27_06,2022-06-24_01,2022-06-22_01
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Get rid of deprecated bpf_set_link*() and bpf_get_link*() APIs.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/libbpf.h   | 20 -------------
 tools/lib/bpf/libbpf.map |  4 ---
 tools/lib/bpf/netlink.c  | 62 ++++++----------------------------------
 3 files changed, 8 insertions(+), 78 deletions(-)

diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 0b2de10b5878..d1c93a1e7d66 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -1164,15 +1164,6 @@ LIBBPF_API int bpf_map__get_next_key(const struct bpf_map *map,
  */
 LIBBPF_API long libbpf_get_error(const void *ptr);
 
-/* XDP related API */
-struct xdp_link_info {
-	__u32 prog_id;
-	__u32 drv_prog_id;
-	__u32 hw_prog_id;
-	__u32 skb_prog_id;
-	__u8 attach_mode;
-};
-
 struct bpf_xdp_set_link_opts {
 	size_t sz;
 	int old_fd;
@@ -1180,17 +1171,6 @@ struct bpf_xdp_set_link_opts {
 };
 #define bpf_xdp_set_link_opts__last_field old_fd
 
-LIBBPF_DEPRECATED_SINCE(0, 8, "use bpf_xdp_attach() instead")
-LIBBPF_API int bpf_set_link_xdp_fd(int ifindex, int fd, __u32 flags);
-LIBBPF_DEPRECATED_SINCE(0, 8, "use bpf_xdp_attach() instead")
-LIBBPF_API int bpf_set_link_xdp_fd_opts(int ifindex, int fd, __u32 flags,
-					const struct bpf_xdp_set_link_opts *opts);
-LIBBPF_DEPRECATED_SINCE(0, 8, "use bpf_xdp_query_id() instead")
-LIBBPF_API int bpf_get_link_xdp_id(int ifindex, __u32 *prog_id, __u32 flags);
-LIBBPF_DEPRECATED_SINCE(0, 8, "use bpf_xdp_query() instead")
-LIBBPF_API int bpf_get_link_xdp_info(int ifindex, struct xdp_link_info *info,
-				     size_t info_size, __u32 flags);
-
 struct bpf_xdp_attach_opts {
 	size_t sz;
 	int old_prog_fd;
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index a480490914a4..713c769f125a 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -91,7 +91,6 @@ LIBBPF_0.0.1 {
 		bpf_prog_linfo__lfind_addr_func;
 		bpf_prog_linfo__lfind;
 		bpf_raw_tracepoint_open;
-		bpf_set_link_xdp_fd;
 		bpf_task_fd_query;
 		btf__fd;
 		btf__find_by_name;
@@ -120,7 +119,6 @@ LIBBPF_0.0.2 {
 		bpf_map_lookup_elem_flags;
 		bpf_object__btf;
 		bpf_object__find_map_fd_by_name;
-		bpf_get_link_xdp_id;
 		btf__dedup;
 		btf__get_map_kv_tids;
 		btf__get_nr_types;
@@ -172,7 +170,6 @@ LIBBPF_0.0.5 {
 
 LIBBPF_0.0.6 {
 	global:
-		bpf_get_link_xdp_info;
 		bpf_map__get_pin_path;
 		bpf_map__is_pinned;
 		bpf_map__set_pin_path;
@@ -231,7 +228,6 @@ LIBBPF_0.0.8 {
 		bpf_program__is_lsm;
 		bpf_program__set_attach_target;
 		bpf_program__set_lsm;
-		bpf_set_link_xdp_fd_opts;
 } LIBBPF_0.0.7;
 
 LIBBPF_0.0.9 {
diff --git a/tools/lib/bpf/netlink.c b/tools/lib/bpf/netlink.c
index cbc8967d5402..6c013168032d 100644
--- a/tools/lib/bpf/netlink.c
+++ b/tools/lib/bpf/netlink.c
@@ -27,6 +27,14 @@ typedef int (*libbpf_dump_nlmsg_t)(void *cookie, void *msg, struct nlattr **tb);
 typedef int (*__dump_nlmsg_t)(struct nlmsghdr *nlmsg, libbpf_dump_nlmsg_t,
 			      void *cookie);
 
+struct xdp_link_info {
+	__u32 prog_id;
+	__u32 drv_prog_id;
+	__u32 hw_prog_id;
+	__u32 skb_prog_id;
+	__u8 attach_mode;
+};
+
 struct xdp_id_md {
 	int ifindex;
 	__u32 flags;
@@ -288,31 +296,6 @@ int bpf_xdp_detach(int ifindex, __u32 flags, const struct bpf_xdp_attach_opts *o
 	return bpf_xdp_attach(ifindex, -1, flags, opts);
 }
 
-int bpf_set_link_xdp_fd_opts(int ifindex, int fd, __u32 flags,
-			     const struct bpf_xdp_set_link_opts *opts)
-{
-	int old_fd = -1, ret;
-
-	if (!OPTS_VALID(opts, bpf_xdp_set_link_opts))
-		return libbpf_err(-EINVAL);
-
-	if (OPTS_HAS(opts, old_fd)) {
-		old_fd = OPTS_GET(opts, old_fd, -1);
-		flags |= XDP_FLAGS_REPLACE;
-	}
-
-	ret = __bpf_set_link_xdp_fd_replace(ifindex, fd, old_fd, flags);
-	return libbpf_err(ret);
-}
-
-int bpf_set_link_xdp_fd(int ifindex, int fd, __u32 flags)
-{
-	int ret;
-
-	ret = __bpf_set_link_xdp_fd_replace(ifindex, fd, 0, flags);
-	return libbpf_err(ret);
-}
-
 static int __dump_link_nlmsg(struct nlmsghdr *nlh,
 			     libbpf_dump_nlmsg_t dump_link_nlmsg, void *cookie)
 {
@@ -413,30 +396,6 @@ int bpf_xdp_query(int ifindex, int xdp_flags, struct bpf_xdp_query_opts *opts)
 	return 0;
 }
 
-int bpf_get_link_xdp_info(int ifindex, struct xdp_link_info *info,
-			  size_t info_size, __u32 flags)
-{
-	LIBBPF_OPTS(bpf_xdp_query_opts, opts);
-	size_t sz;
-	int err;
-
-	if (!info_size)
-		return libbpf_err(-EINVAL);
-
-	err = bpf_xdp_query(ifindex, flags, &opts);
-	if (err)
-		return libbpf_err(err);
-
-	/* struct xdp_link_info field layout matches struct bpf_xdp_query_opts
-	 * layout after sz field
-	 */
-	sz = min(info_size, offsetofend(struct xdp_link_info, attach_mode));
-	memcpy(info, &opts.prog_id, sz);
-	memset((void *)info + sz, 0, info_size - sz);
-
-	return 0;
-}
-
 int bpf_xdp_query_id(int ifindex, int flags, __u32 *prog_id)
 {
 	LIBBPF_OPTS(bpf_xdp_query_opts, opts);
@@ -463,11 +422,6 @@ int bpf_xdp_query_id(int ifindex, int flags, __u32 *prog_id)
 }
 
 
-int bpf_get_link_xdp_id(int ifindex, __u32 *prog_id, __u32 flags)
-{
-	return bpf_xdp_query_id(ifindex, flags, prog_id);
-}
-
 typedef int (*qdisc_config_t)(struct libbpf_nla_req *req);
 
 static int clsact_config(struct libbpf_nla_req *req)
-- 
2.30.2

