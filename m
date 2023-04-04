Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B0236D579E
	for <lists+bpf@lfdr.de>; Tue,  4 Apr 2023 06:38:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232473AbjDDEiQ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Tue, 4 Apr 2023 00:38:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232560AbjDDEiP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 4 Apr 2023 00:38:15 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FB61C2
        for <bpf@vger.kernel.org>; Mon,  3 Apr 2023 21:38:14 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 333NLdkc006259
        for <bpf@vger.kernel.org>; Mon, 3 Apr 2023 21:38:13 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3pqytf50dk-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 03 Apr 2023 21:38:13 -0700
Received: from twshared21709.17.frc2.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Mon, 3 Apr 2023 21:37:50 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 9FA532D051ADB; Mon,  3 Apr 2023 21:37:33 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>, <lmb@isovalent.com>, <timo@incline.eu>,
        <robin.goegge@isovalent.com>
CC:     <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH v3 bpf-next 16/19] libbpf: wire through log_size_actual for bpf_btf_load() API
Date:   Mon, 3 Apr 2023 21:36:56 -0700
Message-ID: <20230404043659.2282536-17-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230404043659.2282536-1-andrii@kernel.org>
References: <20230404043659.2282536-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: aBTEc5Owl5ZV1OrJtppy-7AY9hbHU5Jd
X-Proofpoint-GUID: aBTEc5Owl5ZV1OrJtppy-7AY9hbHU5Jd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-03_19,2023-04-03_03,2023-02-09_01
X-Spam-Status: No, score=-0.4 required=5.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Similar to what we did for bpf_prog_load() in previous patch, wire
returning of log_size_actual value from kernel back to the user through
OPTS out field.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/bpf.c |  6 ++++--
 tools/lib/bpf/bpf.h | 11 +++++++++--
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index cfe79d441c65..586776315afe 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -1083,9 +1083,9 @@ int bpf_raw_tracepoint_open(const char *name, int prog_fd)
 	return libbpf_err_errno(fd);
 }
 
-int bpf_btf_load(const void *btf_data, size_t btf_size, const struct bpf_btf_load_opts *opts)
+int bpf_btf_load(const void *btf_data, size_t btf_size, struct bpf_btf_load_opts *opts)
 {
-	const size_t attr_sz = offsetofend(union bpf_attr, btf_log_level);
+	const size_t attr_sz = offsetofend(union bpf_attr, btf_log_size_actual);
 	union bpf_attr attr;
 	char *log_buf;
 	size_t log_size;
@@ -1128,6 +1128,8 @@ int bpf_btf_load(const void *btf_data, size_t btf_size, const struct bpf_btf_loa
 		attr.btf_log_level = 1;
 		fd = sys_bpf_fd(BPF_BTF_LOAD, &attr, attr_sz);
 	}
+
+	OPTS_SET(opts, log_size_actual, attr.btf_log_size_actual);
 	return libbpf_err_errno(fd);
 }
 
diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index 45a967e65165..fd45b70b9ea8 100644
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
+	__u32 log_size_actual;
+	size_t :0;
 };
-#define bpf_btf_load_opts__last_field log_size
+#define bpf_btf_load_opts__last_field log_size_actual
 
 LIBBPF_API int bpf_btf_load(const void *btf_data, size_t btf_size,
-			    const struct bpf_btf_load_opts *opts);
+			    struct bpf_btf_load_opts *opts);
 
 LIBBPF_API int bpf_map_update_elem(int fd, const void *key, const void *value,
 				   __u64 flags);
-- 
2.34.1

