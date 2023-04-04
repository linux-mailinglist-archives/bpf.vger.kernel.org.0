Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C6636D579D
	for <lists+bpf@lfdr.de>; Tue,  4 Apr 2023 06:38:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232776AbjDDEiP convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Tue, 4 Apr 2023 00:38:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231208AbjDDEiO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 4 Apr 2023 00:38:14 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B24C10F9
        for <bpf@vger.kernel.org>; Mon,  3 Apr 2023 21:38:13 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 333NLdkb006259
        for <bpf@vger.kernel.org>; Mon, 3 Apr 2023 21:38:13 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3pqytf50dk-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 03 Apr 2023 21:38:13 -0700
Received: from twshared29091.48.prn1.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Mon, 3 Apr 2023 21:37:45 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 935672D051AA8; Mon,  3 Apr 2023 21:37:31 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>, <lmb@isovalent.com>, <timo@incline.eu>,
        <robin.goegge@isovalent.com>
CC:     <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH v3 bpf-next 15/19] libbpf: wire through log_size_actual returned from kernel for BPF_PROG_LOAD
Date:   Mon, 3 Apr 2023 21:36:55 -0700
Message-ID: <20230404043659.2282536-16-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230404043659.2282536-1-andrii@kernel.org>
References: <20230404043659.2282536-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: VQWZuX2QwhifZvVcgmWTTvais2rGykYv
X-Proofpoint-GUID: VQWZuX2QwhifZvVcgmWTTvais2rGykYv
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

Add output-only log_size_actual field to bpf_prog_load_opts to return
bpf_attr->log_size_actual value back from bpf() syscall.

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
index f1d04ee14d83..cfe79d441c65 100644
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
+	const size_t attr_sz = offsetofend(union bpf_attr, log_size_actual);
 	void *finfo = NULL, *linfo = NULL;
 	const char *func_info, *line_info;
 	__u32 log_size, log_level, attach_prog_fd, attach_btf_obj_fd;
@@ -312,6 +312,7 @@ int bpf_prog_load(enum bpf_prog_type prog_type,
 	}
 
 	fd = sys_bpf_prog_load(&attr, attr_sz, attempts);
+	OPTS_SET(opts, log_size_actual, attr.log_size_actual);
 	if (fd >= 0)
 		return fd;
 
@@ -352,6 +353,7 @@ int bpf_prog_load(enum bpf_prog_type prog_type,
 		}
 
 		fd = sys_bpf_prog_load(&attr, attr_sz, attempts);
+		OPTS_SET(opts, log_size_actual, attr.log_size_actual);
 		if (fd >= 0)
 			goto done;
 	}
@@ -366,6 +368,7 @@ int bpf_prog_load(enum bpf_prog_type prog_type,
 		attr.log_level = 1;
 
 		fd = sys_bpf_prog_load(&attr, attr_sz, attempts);
+		OPTS_SET(opts, log_size_actual, attr.log_size_actual);
 	}
 done:
 	/* free() doesn't affect errno, so we don't need to restore it */
diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index b073e73439ef..45a967e65165 100644
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
+	__u32 log_size_actual;
+	size_t :0;
 };
-#define bpf_prog_load_opts__last_field log_buf
+#define bpf_prog_load_opts__last_field log_size_actual
 
 LIBBPF_API int bpf_prog_load(enum bpf_prog_type prog_type,
 			     const char *prog_name, const char *license,
 			     const struct bpf_insn *insns, size_t insn_cnt,
-			     const struct bpf_prog_load_opts *opts);
+			     struct bpf_prog_load_opts *opts);
 
 /* Flags to direct loading requirements */
 #define MAPS_RELAX_COMPAT	0x01
-- 
2.34.1

