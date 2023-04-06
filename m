Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E24F6DA63B
	for <lists+bpf@lfdr.de>; Fri,  7 Apr 2023 01:47:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232119AbjDFXo0 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Thu, 6 Apr 2023 19:44:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238763AbjDFXnf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 6 Apr 2023 19:43:35 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CCD486B8
        for <bpf@vger.kernel.org>; Thu,  6 Apr 2023 16:42:59 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 336N4Y7K031546
        for <bpf@vger.kernel.org>; Thu, 6 Apr 2023 16:42:58 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3pt7e6g5gg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 06 Apr 2023 16:42:58 -0700
Received: from twshared21709.17.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Thu, 6 Apr 2023 16:42:57 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id CE61B2D5BE550; Thu,  6 Apr 2023 16:42:39 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>, <lmb@isovalent.com>, <timo@incline.eu>,
        <robin.goegge@isovalent.com>
CC:     <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH v4 bpf-next 15/19] libbpf: wire through log_true_size returned from kernel for BPF_PROG_LOAD
Date:   Thu, 6 Apr 2023 16:42:01 -0700
Message-ID: <20230406234205.323208-16-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230406234205.323208-1-andrii@kernel.org>
References: <20230406234205.323208-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: wxaDpQEUL43TM8f6F5HcLs0sA0yXslYv
X-Proofpoint-GUID: wxaDpQEUL43TM8f6F5HcLs0sA0yXslYv
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

Add output-only log_true_size field to bpf_prog_load_opts to return
bpf_attr->log_true_size value back from bpf() syscall.

Note, that we have to drop const modifier from opts in bpf_prog_load().
This could potentially cause compilation error for some users. But
the usual practice is to define bpf_prog_load_ops
as a local variable next to bpf_prog_load() call and pass pointer to it,
so const vs non-const makes no difference and won't even come up in most
(if not all) cases.

There are no runtime and ABI backwards/forward compatibility issues at all.
If user provides old struct bpf_prog_load_opts, libbpf won't set new
fields. If old libbpf is provided new bpf_prog_load_opts, nothing will
happen either as old libbpf doesn't yet know about this new field.

Adding a new variant of bpf_prog_load() just for this seems like a big
and unnecessary overkill. As a corroborating evidence is the fact that
entire selftests/bpf code base required not adjustment whatsoever.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/bpf.c |  7 +++++--
 tools/lib/bpf/bpf.h | 11 +++++++++--
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index f1d04ee14d83..a031de0a707a 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -230,9 +230,9 @@ alloc_zero_tailing_info(const void *orecord, __u32 cnt,
 int bpf_prog_load(enum bpf_prog_type prog_type,
 		  const char *prog_name, const char *license,
 		  const struct bpf_insn *insns, size_t insn_cnt,
-		  const struct bpf_prog_load_opts *opts)
+		  struct bpf_prog_load_opts *opts)
 {
-	const size_t attr_sz = offsetofend(union bpf_attr, fd_array);
+	const size_t attr_sz = offsetofend(union bpf_attr, log_true_size);
 	void *finfo = NULL, *linfo = NULL;
 	const char *func_info, *line_info;
 	__u32 log_size, log_level, attach_prog_fd, attach_btf_obj_fd;
@@ -312,6 +312,7 @@ int bpf_prog_load(enum bpf_prog_type prog_type,
 	}
 
 	fd = sys_bpf_prog_load(&attr, attr_sz, attempts);
+	OPTS_SET(opts, log_true_size, attr.log_true_size);
 	if (fd >= 0)
 		return fd;
 
@@ -352,6 +353,7 @@ int bpf_prog_load(enum bpf_prog_type prog_type,
 		}
 
 		fd = sys_bpf_prog_load(&attr, attr_sz, attempts);
+		OPTS_SET(opts, log_true_size, attr.log_true_size);
 		if (fd >= 0)
 			goto done;
 	}
@@ -366,6 +368,7 @@ int bpf_prog_load(enum bpf_prog_type prog_type,
 		attr.log_level = 1;
 
 		fd = sys_bpf_prog_load(&attr, attr_sz, attempts);
+		OPTS_SET(opts, log_true_size, attr.log_true_size);
 	}
 done:
 	/* free() doesn't affect errno, so we don't need to restore it */
diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index b073e73439ef..cfa0cdfa50f8 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -96,13 +96,20 @@ struct bpf_prog_load_opts {
 	__u32 log_level;
 	__u32 log_size;
 	char *log_buf;
+	/* output: actual total log contents size (including termintaing zero).
+	 * It could be both larger than original log_size (if log was
+	 * truncated), or smaller (if log buffer wasn't filled completely).
+	 * If kernel doesn't support this feature, log_size is left unchanged.
+	 */
+	__u32 log_true_size;
+	size_t :0;
 };
-#define bpf_prog_load_opts__last_field log_buf
+#define bpf_prog_load_opts__last_field log_true_size
 
 LIBBPF_API int bpf_prog_load(enum bpf_prog_type prog_type,
 			     const char *prog_name, const char *license,
 			     const struct bpf_insn *insns, size_t insn_cnt,
-			     const struct bpf_prog_load_opts *opts);
+			     struct bpf_prog_load_opts *opts);
 
 /* Flags to direct loading requirements */
 #define MAPS_RELAX_COMPAT	0x01
-- 
2.34.1

