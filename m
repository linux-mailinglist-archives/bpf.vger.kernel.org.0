Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 899A557E540
	for <lists+bpf@lfdr.de>; Fri, 22 Jul 2022 19:19:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236056AbiGVRTG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 22 Jul 2022 13:19:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236064AbiGVRTD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 22 Jul 2022 13:19:03 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E276C89EAC
        for <bpf@vger.kernel.org>; Fri, 22 Jul 2022 10:19:01 -0700 (PDT)
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LqGJJ19yTz67PnL;
        Sat, 23 Jul 2022 01:14:24 +0800 (CST)
Received: from roberto-ThinkStation-P620.huawei.com (10.204.63.22) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 22 Jul 2022 19:18:59 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <quentin@isovalent.com>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <andrii@kernel.org>, <martin.lau@linux.dev>, <song@kernel.org>,
        <john.fastabend@gmail.com>, <kpsingh@kernel.org>, <sdf@google.com>,
        <jevburton.kernel@gmail.com>
CC:     <bpf@vger.kernel.org>, Roberto Sassu <roberto.sassu@huawei.com>
Subject: [RFC][PATCH v3 03/15] libbpf: Introduce bpf_prog_get_fd_by_id_opts()
Date:   Fri, 22 Jul 2022 19:18:24 +0200
Message-ID: <20220722171836.2852247-4-roberto.sassu@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220722171836.2852247-1-roberto.sassu@huawei.com>
References: <20220722171836.2852247-1-roberto.sassu@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.204.63.22]
X-ClientProxiedBy: lhreml754-chm.china.huawei.com (10.201.108.204) To
 fraeml714-chm.china.huawei.com (10.206.15.33)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Define a new data structure called bpf_get_fd_opts, with the member flags,
to be used by callers of the _opts variants of bpf_*_get_fd_by_id() and
bpf_obj_get() to specify the permissions needed for the operations on the
obtained file descriptor.

Define only one data structure for all variants, as the open_flags field in
bpf_attr for bpf_*_get_fd_by_id_opts() and file_flags for
bpf_obj_get_opts() have the same meaning. Also, it would avoid the
confusion when the same bpftool function calls both
bpf_*_get_fd_by_id_opts() and bpf_obj_get_opts() (e.g. map_parse_fds()).

Then, introduce the new feature FEAT_GET_FD_BY_ID_OPEN_FLAGS to determine
whether or not the kernel supports setting open_flags for
bpf_*_get_fd_by_id() functions (except for bpf_map_get_fd_by_id(), which
already can get it). If the feature is not detected, the _opts variants
ignore flags in the bpf_get_fd_opts structure and leave open_flags to zero.

Finally, introduce bpf_prog_get_fd_by_id_opts(), to let the caller pass the
newly introduced data structure. Keep the existing bpf_prog_get_fd_by_id(),
and call bpf_prog_get_fd_by_id_opts() with NULL as opts argument.

Currently, setting permissions in the data structure has no effect, as the
kernel does not evaluate them. The new variant has been introduced anyway
for symmetry with bpf_map_get_fd_by_id_opts(). Evaluating permissions could
be done in future kernel versions.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 tools/lib/bpf/bpf.c             | 37 ++++++++++++++++++++++++++++++++-
 tools/lib/bpf/bpf.h             | 11 ++++++++++
 tools/lib/bpf/libbpf.c          |  4 ++++
 tools/lib/bpf/libbpf.map        |  1 +
 tools/lib/bpf/libbpf_internal.h |  3 +++
 5 files changed, 55 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index 5eb0df90eb2b..9014a61bca83 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -910,18 +910,53 @@ int bpf_link_get_next_id(__u32 start_id, __u32 *next_id)
 	return bpf_obj_get_next_id(start_id, next_id, BPF_LINK_GET_NEXT_ID);
 }
 
-int bpf_prog_get_fd_by_id(__u32 id)
+static int
+bpf_prog_get_fd_by_id_opts_check(__u32 id, const struct bpf_get_fd_opts *opts,
+				 bool check_support)
 {
 	union bpf_attr attr;
 	int fd;
 
+	if (!OPTS_VALID(opts, bpf_get_fd_opts))
+		return libbpf_err(-EINVAL);
+
 	memset(&attr, 0, sizeof(attr));
 	attr.prog_id = id;
+	if (!check_support ||
+	    kernel_supports(NULL, FEAT_GET_FD_BY_ID_OPEN_FLAGS))
+		attr.open_flags = OPTS_GET(opts, flags, 0);
 
 	fd = sys_bpf_fd(BPF_PROG_GET_FD_BY_ID, &attr, sizeof(attr));
 	return libbpf_err_errno(fd);
 }
 
+int bpf_prog_get_fd_by_id_opts(__u32 id, const struct bpf_get_fd_opts *opts)
+{
+	return bpf_prog_get_fd_by_id_opts_check(id, opts, true);
+}
+
+int probe_get_fd_by_id_open_flags(void)
+{
+	DECLARE_LIBBPF_OPTS(bpf_get_fd_opts, opts,
+		.flags = BPF_F_RDONLY,
+	);
+
+	int ret, fd;
+
+	fd = bpf_prog_get_fd_by_id_opts_check(0, &opts, false);
+	ret = (fd >= 0) || (errno == ENOENT);
+
+	if (fd >= 0)
+		close(fd);
+
+	return ret;
+}
+
+int bpf_prog_get_fd_by_id(__u32 id)
+{
+	return bpf_prog_get_fd_by_id_opts(id, NULL);
+}
+
 int bpf_map_get_fd_by_id(__u32 id)
 {
 	union bpf_attr attr;
diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index 88a7cc4bd76f..bc241343a0f9 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -271,6 +271,14 @@ LIBBPF_API int bpf_map_update_batch(int fd, const void *keys, const void *values
 				    const struct bpf_map_batch_opts *opts);
 
 LIBBPF_API int bpf_obj_pin(int fd, const char *pathname);
+
+struct bpf_get_fd_opts {
+	size_t sz; /* size of this struct for forward/backward compatibility */
+	__u32 flags; /* permissions requested for the operation on fd */
+	__u32 :0;
+};
+#define bpf_get_fd_opts__last_field flags
+
 LIBBPF_API int bpf_obj_get(const char *pathname);
 
 struct bpf_prog_attach_opts {
@@ -354,6 +362,9 @@ LIBBPF_API int bpf_prog_get_next_id(__u32 start_id, __u32 *next_id);
 LIBBPF_API int bpf_map_get_next_id(__u32 start_id, __u32 *next_id);
 LIBBPF_API int bpf_btf_get_next_id(__u32 start_id, __u32 *next_id);
 LIBBPF_API int bpf_link_get_next_id(__u32 start_id, __u32 *next_id);
+
+LIBBPF_API int bpf_prog_get_fd_by_id_opts(__u32 id,
+					  const struct bpf_get_fd_opts *opts);
 LIBBPF_API int bpf_prog_get_fd_by_id(__u32 id);
 LIBBPF_API int bpf_map_get_fd_by_id(__u32 id);
 LIBBPF_API int bpf_btf_get_fd_by_id(__u32 id);
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index b01fe01b0761..12b5e6833726 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -4784,6 +4784,10 @@ static struct kern_feature_desc {
 	[FEAT_SYSCALL_WRAPPER] = {
 		"Kernel using syscall wrapper", probe_kern_syscall_wrapper,
 	},
+	[FEAT_GET_FD_BY_ID_OPEN_FLAGS] = {
+		"open_flags accepted for bpf_*_get_fd_by_id() funcs",
+		probe_get_fd_by_id_open_flags,
+	},
 };
 
 bool kernel_supports(const struct bpf_object *obj, enum kern_feature_id feat_id)
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 0625adb9e888..ab818612a585 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -364,4 +364,5 @@ LIBBPF_1.0.0 {
 		libbpf_bpf_map_type_str;
 		libbpf_bpf_prog_type_str;
 		perf_buffer__buffer;
+		bpf_prog_get_fd_by_id_opts;
 };
diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
index 4135ae0a2bc3..84c589b310e7 100644
--- a/tools/lib/bpf/libbpf_internal.h
+++ b/tools/lib/bpf/libbpf_internal.h
@@ -354,10 +354,13 @@ enum kern_feature_id {
 	FEAT_BTF_ENUM64,
 	/* Kernel uses syscall wrapper (CONFIG_ARCH_HAS_SYSCALL_WRAPPER) */
 	FEAT_SYSCALL_WRAPPER,
+	/* open_flags accepted for bpf_*_get_fd_by_id() funcs */
+	FEAT_GET_FD_BY_ID_OPEN_FLAGS,
 	__FEAT_CNT,
 };
 
 int probe_memcg_account(void);
+int probe_get_fd_by_id_open_flags(void);
 bool kernel_supports(const struct bpf_object *obj, enum kern_feature_id feat_id);
 int bump_rlimit_memlock(void);
 
-- 
2.25.1

