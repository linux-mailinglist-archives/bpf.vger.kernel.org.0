Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8A454954BE
	for <lists+bpf@lfdr.de>; Thu, 20 Jan 2022 20:15:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377495AbiATTOw convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Thu, 20 Jan 2022 14:14:52 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:19888 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1377518AbiATTNm (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 20 Jan 2022 14:13:42 -0500
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20KHwfpN016169
        for <bpf@vger.kernel.org>; Thu, 20 Jan 2022 11:13:41 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3dq56xkcuk-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 20 Jan 2022 11:13:41 -0800
Received: from twshared0654.04.ash8.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 20 Jan 2022 11:13:30 -0800
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id 35D1D283245F4; Thu, 20 Jan 2022 11:13:23 -0800 (PST)
From:   Song Liu <song@kernel.org>
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <kernel-team@fb.com>, <peterz@infradead.org>, <x86@kernel.org>,
        Song Liu <song@kernel.org>
Subject: [PATCH v5 bpf-next 4/7] bpf: add a pointer of bpf_binary_header to bpf_prog
Date:   Thu, 20 Jan 2022 11:13:02 -0800
Message-ID: <20220120191306.1801459-5-song@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220120191306.1801459-1-song@kernel.org>
References: <20220120191306.1801459-1-song@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 3WWm5SwLSgRzfqfjzJ24Oo-sW4XrC__A
X-Proofpoint-ORIG-GUID: 3WWm5SwLSgRzfqfjzJ24Oo-sW4XrC__A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-20_07,2022-01-20_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 malwarescore=0
 bulkscore=0 mlxscore=0 impostorscore=0 lowpriorityscore=0 spamscore=0
 suspectscore=0 clxscore=1015 mlxlogscore=880 phishscore=0
 priorityscore=1501 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2201200097
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

With sub page allocation, we cannot simply use bpf_func & PAGE_MASK to
find the bpf_binary_header. Add a pointer to struct bpf_prog to avoid
this logic.

Use this point for x86_64. If the pointer is not set by the jit engine,
fall back to original logic.

Signed-off-by: Song Liu <song@kernel.org>
---
 arch/x86/net/bpf_jit_comp.c |  2 ++
 include/linux/filter.h      | 10 ++++++++--
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index ce1f86f245c9..fe4f08e25a1d 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -2339,6 +2339,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 			if (header)
 				bpf_jit_binary_free(header);
 			prog = orig_prog;
+			header = NULL;
 			goto out_addrs;
 		}
 		if (image) {
@@ -2406,6 +2407,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 	if (tmp_blinded)
 		bpf_jit_prog_release_other(prog, prog == orig_prog ?
 					   tmp : orig_prog);
+	prog->hdr = header;
 	return prog;
 }
 
diff --git a/include/linux/filter.h b/include/linux/filter.h
index 5855eb474c62..27ea68604c22 100644
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

