Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E09257E54E
	for <lists+bpf@lfdr.de>; Fri, 22 Jul 2022 19:20:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236093AbiGVRUW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 22 Jul 2022 13:20:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236096AbiGVRUU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 22 Jul 2022 13:20:20 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9851F1CFC8
        for <bpf@vger.kernel.org>; Fri, 22 Jul 2022 10:20:19 -0700 (PDT)
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LqGNy1RTNz67fK4;
        Sat, 23 Jul 2022 01:18:26 +0800 (CST)
Received: from roberto-ThinkStation-P620.huawei.com (10.204.63.22) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 22 Jul 2022 19:20:17 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <quentin@isovalent.com>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <andrii@kernel.org>, <martin.lau@linux.dev>, <song@kernel.org>,
        <john.fastabend@gmail.com>, <kpsingh@kernel.org>, <sdf@google.com>,
        <jevburton.kernel@gmail.com>
CC:     <bpf@vger.kernel.org>, Roberto Sassu <roberto.sassu@huawei.com>
Subject: [RFC][PATCH v3 07/15] libbpf: Introduce bpf_obj_get_opts()
Date:   Fri, 22 Jul 2022 19:18:28 +0200
Message-ID: <20220722171836.2852247-8-roberto.sassu@huawei.com>
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

Introduce bpf_obj_get_opts(), to let the caller pass the needed permissions
for the operation. Keep the existing bpf_obj_get() to request read-write
permissions.

bpf_obj_get() allows the caller to get a file descriptor from a pinned
object with the provided pathname. Specifying permissions has only effect
on maps (for links, the permission must be always read-write).

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 tools/lib/bpf/bpf.c      | 12 +++++++++++-
 tools/lib/bpf/bpf.h      |  2 ++
 tools/lib/bpf/libbpf.map |  1 +
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index 5f2785a4c358..0df088890864 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -577,18 +577,28 @@ int bpf_obj_pin(int fd, const char *pathname)
 	return libbpf_err_errno(ret);
 }
 
-int bpf_obj_get(const char *pathname)
+int bpf_obj_get_opts(const char *pathname,
+		     const struct bpf_get_fd_opts *opts)
 {
 	union bpf_attr attr;
 	int fd;
 
+	if (!OPTS_VALID(opts, bpf_get_fd_opts))
+		return libbpf_err(-EINVAL);
+
 	memset(&attr, 0, sizeof(attr));
 	attr.pathname = ptr_to_u64((void *)pathname);
+	attr.file_flags = OPTS_GET(opts, flags, 0);
 
 	fd = sys_bpf_fd(BPF_OBJ_GET, &attr, sizeof(attr));
 	return libbpf_err_errno(fd);
 }
 
+int bpf_obj_get(const char *pathname)
+{
+	return bpf_obj_get_opts(pathname, NULL);
+}
+
 int bpf_prog_attach(int prog_fd, int target_fd, enum bpf_attach_type type,
 		    unsigned int flags)
 {
diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index b75fd9d37bad..e0c5018cc131 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -279,6 +279,8 @@ struct bpf_get_fd_opts {
 };
 #define bpf_get_fd_opts__last_field flags
 
+LIBBPF_API int bpf_obj_get_opts(const char *pathname,
+				const struct bpf_get_fd_opts *opts);
 LIBBPF_API int bpf_obj_get(const char *pathname);
 
 struct bpf_prog_attach_opts {
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index dba97d2ef8a9..55516b19e22f 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -368,4 +368,5 @@ LIBBPF_1.0.0 {
 		bpf_map_get_fd_by_id_opts;
 		bpf_btf_get_fd_by_id_opts;
 		bpf_link_get_fd_by_id_opts;
+		bpf_obj_get_opts;
 };
-- 
2.25.1

