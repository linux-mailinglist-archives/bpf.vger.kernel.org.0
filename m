Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8B4B57E54D
	for <lists+bpf@lfdr.de>; Fri, 22 Jul 2022 19:20:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236011AbiGVRUU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 22 Jul 2022 13:20:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236087AbiGVRUT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 22 Jul 2022 13:20:19 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE3CF1839C
        for <bpf@vger.kernel.org>; Fri, 22 Jul 2022 10:20:17 -0700 (PDT)
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LqGNw4bpSz67f6D;
        Sat, 23 Jul 2022 01:18:24 +0800 (CST)
Received: from roberto-ThinkStation-P620.huawei.com (10.204.63.22) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 22 Jul 2022 19:20:15 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <quentin@isovalent.com>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <andrii@kernel.org>, <martin.lau@linux.dev>, <song@kernel.org>,
        <john.fastabend@gmail.com>, <kpsingh@kernel.org>, <sdf@google.com>,
        <jevburton.kernel@gmail.com>
CC:     <bpf@vger.kernel.org>, Roberto Sassu <roberto.sassu@huawei.com>
Subject: [RFC][PATCH v3 05/15] libbpf: Introduce bpf_btf_get_fd_by_id_opts()
Date:   Fri, 22 Jul 2022 19:18:26 +0200
Message-ID: <20220722171836.2852247-6-roberto.sassu@huawei.com>
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

Introduce bpf_btf_get_fd_by_id_opts(), to let the caller specify the needed
permissions for the operation. Keep the existing bpf_btf_get_fd_by_id()
function, to request read-write permissions.

Currently, setting permissions in the data structure has no effect, as the
kernel does not evaluate them. The new variant has been introduced anyway
for symmetry with bpf_map_get_fd_by_id_opts(). Evaluating permissions could
be done in future kernel versions.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 tools/lib/bpf/bpf.c      | 13 ++++++++++++-
 tools/lib/bpf/bpf.h      |  2 ++
 tools/lib/bpf/libbpf.map |  1 +
 3 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index 4b574ad046f3..b131bbc8509e 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -979,18 +979,29 @@ int bpf_map_get_fd_by_id(__u32 id)
 	return bpf_map_get_fd_by_id_opts(id, NULL);
 }
 
-int bpf_btf_get_fd_by_id(__u32 id)
+int bpf_btf_get_fd_by_id_opts(__u32 id,
+			      const struct bpf_get_fd_opts *opts)
 {
 	union bpf_attr attr;
 	int fd;
 
+	if (!OPTS_VALID(opts, bpf_get_fd_opts))
+		return libbpf_err(-EINVAL);
+
 	memset(&attr, 0, sizeof(attr));
 	attr.btf_id = id;
+	if (kernel_supports(NULL, FEAT_GET_FD_BY_ID_OPEN_FLAGS))
+		attr.open_flags = OPTS_GET(opts, flags, 0);
 
 	fd = sys_bpf_fd(BPF_BTF_GET_FD_BY_ID, &attr, sizeof(attr));
 	return libbpf_err_errno(fd);
 }
 
+int bpf_btf_get_fd_by_id(__u32 id)
+{
+	return bpf_btf_get_fd_by_id_opts(id, NULL);
+}
+
 int bpf_link_get_fd_by_id(__u32 id)
 {
 	union bpf_attr attr;
diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index d4b84d3f7e16..45d3739d901f 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -369,6 +369,8 @@ LIBBPF_API int bpf_prog_get_fd_by_id(__u32 id);
 LIBBPF_API int bpf_map_get_fd_by_id_opts(__u32 id,
 					 const struct bpf_get_fd_opts *opts);
 LIBBPF_API int bpf_map_get_fd_by_id(__u32 id);
+LIBBPF_API int bpf_btf_get_fd_by_id_opts(__u32 id,
+					 const struct bpf_get_fd_opts *opts);
 LIBBPF_API int bpf_btf_get_fd_by_id(__u32 id);
 LIBBPF_API int bpf_link_get_fd_by_id(__u32 id);
 LIBBPF_API int bpf_obj_get_info_by_fd(int bpf_fd, void *info, __u32 *info_len);
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 83dc18b5e5cf..ee6755dbf004 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -366,4 +366,5 @@ LIBBPF_1.0.0 {
 		perf_buffer__buffer;
 		bpf_prog_get_fd_by_id_opts;
 		bpf_map_get_fd_by_id_opts;
+		bpf_btf_get_fd_by_id_opts;
 };
-- 
2.25.1

