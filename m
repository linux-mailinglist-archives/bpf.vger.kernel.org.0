Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5B2F475279
	for <lists+bpf@lfdr.de>; Wed, 15 Dec 2021 07:04:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235846AbhLOGEA convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Wed, 15 Dec 2021 01:04:00 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:10326 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S235800AbhLOGEA (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 15 Dec 2021 01:04:00 -0500
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.1.2/8.16.1.2) with ESMTP id 1BF4t5P5020985
        for <bpf@vger.kernel.org>; Tue, 14 Dec 2021 22:03:59 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net (PPS) with ESMTPS id 3cy9r30ck9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 14 Dec 2021 22:03:59 -0800
Received: from intmgw001.38.frc1.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 14 Dec 2021 22:03:58 -0800
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id 5F64126045B2F; Tue, 14 Dec 2021 22:01:23 -0800 (PST)
From:   Song Liu <song@kernel.org>
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <kernel-team@fb.com>, <peterz@infradead.org>, <x86@kernel.org>,
        Song Liu <song@kernel.org>, Song Liu <songliubraving@fb.com>
Subject: [PATCH v2 bpf-next 4/7] bpf: add a pointer of bpf_binary_header to bpf_prog
Date:   Tue, 14 Dec 2021 22:00:59 -0800
Message-ID: <20211215060102.3793196-5-song@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211215060102.3793196-1-song@kernel.org>
References: <20211215060102.3793196-1-song@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: bVmzxmqmjWwseIb3efa-euf1uM0FpFRo
X-Proofpoint-ORIG-GUID: bVmzxmqmjWwseIb3efa-euf1uM0FpFRo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-15_06,2021-12-14_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 spamscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 mlxscore=0 suspectscore=0
 mlxlogscore=867 phishscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112150035
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

With sub page allocation, we cannot simply use bpf_func & PAGE_MASK to
find the bpf_binary_header. Add a pointer to struct bpf_prog to avoid
this logic.

Use this point for x86_64. If the pointer is not set by the jit engine,
fall back to original logic.

Signed-off-by: Song Liu <songliubraving@fb.com>
---
 arch/x86/net/bpf_jit_comp.c |  2 ++
 include/linux/filter.h      | 10 ++++++++--
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 4bbcded07415..2231d483f82c 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -2304,6 +2304,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 			if (header)
 				bpf_jit_binary_free(header);
 			prog = orig_prog;
+			header = NULL;
 			goto out_addrs;
 		}
 		if (image) {
@@ -2371,6 +2372,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 	if (tmp_blinded)
 		bpf_jit_prog_release_other(prog, prog == orig_prog ?
 					   tmp : orig_prog);
+	prog->hdr = header;
 	return prog;
 }
 
diff --git a/include/linux/filter.h b/include/linux/filter.h
index 6d73d89c99a4..b5c7e12f7675 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -584,6 +584,7 @@ struct bpf_prog {
 					    const struct bpf_insn *insn);
 	struct bpf_prog_aux	*aux;		/* Auxiliary fields */
 	struct sock_fprog_kern	*orig_prog;	/* Original BPF program */
+	struct bpf_binary_header *hdr;
 	/* Instructions for interpreter */
 	union {
 		DECLARE_FLEX_ARRAY(struct sock_filter, insns);
@@ -893,9 +894,14 @@ static inline void bpf_jit_binary_lock_ro(struct bpf_binary_header *hdr)
 static inline struct bpf_binary_header *
 bpf_jit_binary_hdr(const struct bpf_prog *fp)
 {
-	unsigned long real_start = (unsigned long)fp->bpf_func;
-	unsigned long addr = real_start & PAGE_MASK;
+	unsigned long real_start;
+	unsigned long addr;
 
+	if (fp->hdr)
+		return fp->hdr;
+
+	real_start = (unsigned long)fp->bpf_func;
+	addr = real_start & PAGE_MASK;
 	return (void *)addr;
 }
 
-- 
2.30.2

