Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 329324863E0
	for <lists+bpf@lfdr.de>; Thu,  6 Jan 2022 12:46:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238622AbiAFLq4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Jan 2022 06:46:56 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:14106 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238456AbiAFLqz (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 6 Jan 2022 06:46:55 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 206BBgw9018773;
        Thu, 6 Jan 2022 11:46:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=rumKT25CiZcZQFA6RKAMOxMvAoMZxaFrXsh8Uy/FW9Y=;
 b=Pw/2EORsWMEnELI+/lfKays4htUxqMo7udX2aG3WWrKfPIoqdKQksUSdjaiAZLS22KYK
 bqStPQlV+TFWdHb6SLK8qNe2yfUSD82cPaX/qsZQH7s8qe9EgSnJ5apHpjPC8sd+yrBa
 nwHr4vO6VLy8CcBmInUd5frNtuQqVkzz2QoWjxuIvrxtED33st8Q609VM0edbOnilEJx
 Y2nnQTY3xPc2UCvfubmVZKOsd+lcrugphj7p2IDm2KDEoMxztvDCym0gK0AZBye5+tzX
 9Xwr1s9crd95kMhFe15Tzo+29icGc8hmiospgPpErl6CPI3h9mFGJ5AiGIjKU8cI181r hw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ddyb68m80-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Jan 2022 11:46:37 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 206BYSa0028485;
        Thu, 6 Jan 2022 11:46:36 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ddyb68m7c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Jan 2022 11:46:36 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 206Bho4u024832;
        Thu, 6 Jan 2022 11:46:34 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma04ams.nl.ibm.com with ESMTP id 3ddmsvmrkx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Jan 2022 11:46:34 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 206BbgVE49217832
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 6 Jan 2022 11:37:42 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4A402A4054;
        Thu,  6 Jan 2022 11:46:31 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6FB17A405B;
        Thu,  6 Jan 2022 11:46:28 +0000 (GMT)
Received: from naverao1-tp.ibm.com (unknown [9.43.91.118])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  6 Jan 2022 11:46:28 +0000 (GMT)
From:   "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, ykaliuta@redhat.com,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        song@kernel.org, johan.almbladh@anyfinetworks.com,
        Hari Bathini <hbathini@linux.ibm.com>, <bpf@vger.kernel.org>,
        <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 11/13] powerpc64/bpf elfv2: Setup kernel TOC in r2 on entry
Date:   Thu,  6 Jan 2022 17:15:15 +0530
Message-Id: <4501050f6080f12bd3ba1b5d9d7bef8d3aa57d23.1641468127.git.naveen.n.rao@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1641468127.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1641468127.git.naveen.n.rao@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: CHKuxuiRiQx7NG-hMlQFlqYVNjYYK-g6
X-Proofpoint-GUID: T82c7jQWwmqTmqQYGECtzLMGlNNXLnaN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-06_04,2022-01-06_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1015 adultscore=0 impostorscore=0 mlxlogscore=999
 lowpriorityscore=0 spamscore=0 suspectscore=0 mlxscore=0 phishscore=0
 bulkscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2112160000 definitions=main-2201060081
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

In preparation for using kernel TOC, load the same in r2 on entry. With
elfv1, the kernel TOC is already setup by our caller so we just emit a
nop. We adjust the number of instructions to skip on a tail call
accordingly.

Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 arch/powerpc/net/bpf_jit_comp64.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
index ce4fc59bbd6a92..e05b577d95bf11 100644
--- a/arch/powerpc/net/bpf_jit_comp64.c
+++ b/arch/powerpc/net/bpf_jit_comp64.c
@@ -73,6 +73,12 @@ void bpf_jit_build_prologue(u32 *image, struct codegen_context *ctx)
 {
 	int i;
 
+#ifdef PPC64_ELF_ABI_v2
+	PPC_BPF_LL(_R2, _R13, offsetof(struct paca_struct, kernel_toc));
+#else
+	EMIT(PPC_RAW_NOP());
+#endif
+
 	/*
 	 * Initialize tail_call_cnt if we do tail calls.
 	 * Otherwise, put in NOPs so that it can be skipped when we are
@@ -87,7 +93,7 @@ void bpf_jit_build_prologue(u32 *image, struct codegen_context *ctx)
 		EMIT(PPC_RAW_NOP());
 	}
 
-#define BPF_TAILCALL_PROLOGUE_SIZE	8
+#define BPF_TAILCALL_PROLOGUE_SIZE	12
 
 	if (bpf_has_stack_frame(ctx)) {
 		/*
-- 
2.34.1

