Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA83F6DA64C
	for <lists+bpf@lfdr.de>; Fri,  7 Apr 2023 01:47:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbjDFXny convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Thu, 6 Apr 2023 19:43:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238744AbjDFXnb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 6 Apr 2023 19:43:31 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3EA1AD06
        for <bpf@vger.kernel.org>; Thu,  6 Apr 2023 16:42:56 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 336KBaaZ005942
        for <bpf@vger.kernel.org>; Thu, 6 Apr 2023 16:42:56 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3psv2fmu3a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 06 Apr 2023 16:42:56 -0700
Received: from twshared38955.16.prn3.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Thu, 6 Apr 2023 16:42:55 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id E0DD32D5BE57B; Thu,  6 Apr 2023 16:42:41 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>, <lmb@isovalent.com>, <timo@incline.eu>,
        <robin.goegge@isovalent.com>
CC:     <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH v4 bpf-next 16/19] libbpf: wire through log_true_size for bpf_btf_load() API
Date:   Thu, 6 Apr 2023 16:42:02 -0700
Message-ID: <20230406234205.323208-17-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230406234205.323208-1-andrii@kernel.org>
References: <20230406234205.323208-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: zFYy_aZjaetiekjcO3k8tJIhc5VvuBkt
X-Proofpoint-ORIG-GUID: zFYy_aZjaetiekjcO3k8tJIhc5VvuBkt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-06_13,2023-04-06_03,2023-02-09_01
X-Spam-Status: No, score=-0.4 required=5.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Similar to what we did for bpf_prog_load() in previous patch, wire
returning of log_true_size value from kernel back to the user through
OPTS out field.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/bpf.c |  6 ++++--
 tools/lib/bpf/bpf.h | 11 +++++++++--
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index a031de0a707a..128ac723c4ea 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -1083,9 +1083,9 @@ int bpf_raw_tracepoint_open(const char *name, int prog_fd)
 	return libbpf_err_errno(fd);
 }
 
-int bpf_btf_load(const void *btf_data, size_t btf_size, const struct bpf_btf_load_opts *opts)
+int bpf_btf_load(const void *btf_data, size_t btf_size, struct bpf_btf_load_opts *opts)
 {
-	const size_t attr_sz = offsetofend(union bpf_attr, btf_log_level);
+	const size_t attr_sz = offsetofend(union bpf_attr, btf_log_true_size);
 	union bpf_attr attr;
 	char *log_buf;
 	size_t log_size;
@@ -1128,6 +1128,8 @@ int bpf_btf_load(const void *btf_data, size_t btf_size, const struct bpf_btf_loa
 		attr.btf_log_level = 1;
 		fd = sys_bpf_fd(BPF_BTF_LOAD, &attr, attr_sz);
 	}
+
+	OPTS_SET(opts, log_true_size, attr.btf_log_true_size);
 	return libbpf_err_errno(fd);
 }
 
diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index cfa0cdfa50f8..a2c091389b18 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -124,11 +124,18 @@ struct bpf_btf_load_opts {
 	char *log_buf;
 	__u32 log_level;
 	__u32 log_size;
+	/* output: actual total log contents size (including termintaing zero).
+	 * It could be both larger than original log_size (if log was
+	 * truncated), or smaller (if log buffer wasn't filled completely).
+	 * If kernel doesn't support this feature, log_size is left unchanged.
+	 */
+	__u32 log_true_size;
+	size_t :0;
 };
-#define bpf_btf_load_opts__last_field log_size
+#define bpf_btf_load_opts__last_field log_true_size
 
 LIBBPF_API int bpf_btf_load(const void *btf_data, size_t btf_size,
-			    const struct bpf_btf_load_opts *opts);
+			    struct bpf_btf_load_opts *opts);
 
 LIBBPF_API int bpf_map_update_elem(int fd, const void *key, const void *value,
 				   __u64 flags);
-- 
2.34.1

