Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 540D54A9FA2
	for <lists+bpf@lfdr.de>; Fri,  4 Feb 2022 20:01:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231483AbiBDTBV convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Fri, 4 Feb 2022 14:01:21 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:21036 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229987AbiBDTBJ (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 4 Feb 2022 14:01:09 -0500
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.1.2/8.16.1.2) with ESMTP id 214IisXA008488
        for <bpf@vger.kernel.org>; Fri, 4 Feb 2022 11:01:08 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net (PPS) with ESMTPS id 3e0utmmh5r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 04 Feb 2022 11:01:08 -0800
Received: from twshared9880.08.ash8.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 4 Feb 2022 11:01:07 -0800
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id 48AB2296C5771; Fri,  4 Feb 2022 10:58:02 -0800 (PST)
From:   Song Liu <song@kernel.org>
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <kernel-team@fb.com>, <peterz@infradead.org>, <x86@kernel.org>,
        <iii@linux.ibm.com>, Song Liu <song@kernel.org>
Subject: [PATCH v9 bpf-next 4/9] bpf: use prog->jited_len in  bpf_prog_ksym_set_addr()
Date:   Fri, 4 Feb 2022 10:57:37 -0800
Message-ID: <20220204185742.271030-5-song@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220204185742.271030-1-song@kernel.org>
References: <20220204185742.271030-1-song@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: iaC-1PpAZattcZOgoQQPssFNB5nuVVls
X-Proofpoint-GUID: iaC-1PpAZattcZOgoQQPssFNB5nuVVls
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-04_07,2022-02-03_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 suspectscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 mlxlogscore=949 phishscore=0 mlxscore=0 lowpriorityscore=0
 adultscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202040104
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Using prog->jited_len is simpler and more accurate than current
estimation (header + header->size).

Also, fix missing prog->jited_len with multi function program. This hasn't
been a real issue before this.

Signed-off-by: Song Liu <song@kernel.org>
---
 kernel/bpf/core.c     | 5 +----
 kernel/bpf/verifier.c | 1 +
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 14199228a6f0..e3fe53df0a71 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -537,13 +537,10 @@ long bpf_jit_limit_max __read_mostly;
 static void
 bpf_prog_ksym_set_addr(struct bpf_prog *prog)
 {
-	const struct bpf_binary_header *hdr = bpf_jit_binary_hdr(prog);
-	unsigned long addr = (unsigned long)hdr;
-
 	WARN_ON_ONCE(!bpf_prog_ebpf_jited(prog));
 
 	prog->aux->ksym.start = (unsigned long) prog->bpf_func;
-	prog->aux->ksym.end   = addr + hdr->size;
+	prog->aux->ksym.end   = prog->aux->ksym.start + prog->jited_len;
 }
 
 static void
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 1ae41d0cf96c..bbef86cb4e72 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -13067,6 +13067,7 @@ static int jit_subprogs(struct bpf_verifier_env *env)
 
 	prog->jited = 1;
 	prog->bpf_func = func[0]->bpf_func;
+	prog->jited_len = func[0]->jited_len;
 	prog->aux->func = func;
 	prog->aux->func_cnt = env->subprog_cnt;
 	bpf_prog_jit_attempt_done(prog);
-- 
2.30.2

