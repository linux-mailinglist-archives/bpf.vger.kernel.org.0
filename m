Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B58B44D15F
	for <lists+bpf@lfdr.de>; Thu, 11 Nov 2021 06:18:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbhKKFU4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Thu, 11 Nov 2021 00:20:56 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:36788 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229463AbhKKFU4 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 11 Nov 2021 00:20:56 -0500
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AB5EBEC026793
        for <bpf@vger.kernel.org>; Wed, 10 Nov 2021 21:18:07 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3c8n7stwsk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 10 Nov 2021 21:18:06 -0800
Received: from intmgw001.05.prn6.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Wed, 10 Nov 2021 21:18:05 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id B4AA08B08655; Wed, 10 Nov 2021 21:18:01 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 1/2] libbpf: add ability to get/set per-program load flags
Date:   Wed, 10 Nov 2021 21:17:57 -0800
Message-ID: <20211111051758.92283-2-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211111051758.92283-1-andrii@kernel.org>
References: <20211111051758.92283-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: bw79RMONn4l0x3K_THCvigtJ-g2KUxf2
X-Proofpoint-ORIG-GUID: bw79RMONn4l0x3K_THCvigtJ-g2KUxf2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-11_01,2021-11-08_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 mlxlogscore=999 phishscore=0 impostorscore=0 bulkscore=0 mlxscore=0
 clxscore=1015 suspectscore=0 adultscore=0 malwarescore=0
 lowpriorityscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2111110028
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add bpf_program__flags() API to retrieve prog_flags that will be (or
were) supplied to BPF_PROG_LOAD command.

Also add bpf_program__set_extra_flags() API to allow to set *extra*
flags, in addition to those determined by program's SEC() definition.
Such flags are logically OR'ed with libbpf-derived flags.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/libbpf.c   | 14 ++++++++++++++
 tools/lib/bpf/libbpf.h   |  3 +++
 tools/lib/bpf/libbpf.map |  2 ++
 3 files changed, 19 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index d869ebee1e27..a823b5ed705b 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -8262,6 +8262,20 @@ void bpf_program__set_expected_attach_type(struct bpf_program *prog,
 	prog->expected_attach_type = type;
 }
 
+__u32 bpf_program__flags(const struct bpf_program *prog)
+{
+	return prog->prog_flags;
+}
+
+int bpf_program__set_extra_flags(struct bpf_program *prog, __u32 extra_flags)
+{
+	if (prog->obj->loaded)
+		return libbpf_err(-EBUSY);
+
+	prog->prog_flags |= extra_flags;
+	return 0;
+}
+
 #define SEC_DEF(sec_pfx, ptype, atype, flags, ...) {			    \
 	.sec = sec_pfx,							    \
 	.prog_type = BPF_PROG_TYPE_##ptype,				    \
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 039058763173..f69512ae8505 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -493,6 +493,9 @@ LIBBPF_API void
 bpf_program__set_expected_attach_type(struct bpf_program *prog,
 				      enum bpf_attach_type type);
 
+LIBBPF_API __u32 bpf_program__flags(const struct bpf_program *prog);
+LIBBPF_API int bpf_program__set_extra_flags(struct bpf_program *prog, __u32 extra_flags);
+
 LIBBPF_API int
 bpf_program__set_attach_target(struct bpf_program *prog, int attach_prog_fd,
 			       const char *attach_func_name);
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index b895861a13c0..256d5d4be951 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -397,8 +397,10 @@ LIBBPF_0.6.0 {
 		bpf_object__prev_program;
 		bpf_prog_load_deprecated;
 		bpf_prog_load;
+		bpf_program__flags;
 		bpf_program__insn_cnt;
 		bpf_program__insns;
+		bpf_program__set_extra_flags;
 		btf__add_btf;
 		btf__add_decl_tag;
 		btf__raw_data;
-- 
2.30.2

