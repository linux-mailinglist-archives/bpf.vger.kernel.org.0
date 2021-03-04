Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F11E232DDE1
	for <lists+bpf@lfdr.de>; Fri,  5 Mar 2021 00:30:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbhCDXa2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 4 Mar 2021 18:30:28 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38772 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231455AbhCDXa2 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 4 Mar 2021 18:30:28 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 124N2xVa104761;
        Thu, 4 Mar 2021 18:30:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=4RLmBSJSV3MJ6iqwh6/1mehPi3yo3v8O7bTpGZsH7DQ=;
 b=rY9vsG7zIDN+N7mpP1b8fnDlwxVsGI8NQXmOieN1W2XfQx/CHWVOWaj176wiFkgfygiD
 GplqoptzOJhF4MFAsexlQizxtIkpiwiANzEelrtOzfkwnl7HaXpLS7XDF/RlovFaXOa6
 jkCZcj1xSfJDQnXpT/9F8CvQAg83Ab7yLGgKeU3pYBQR6GjR69fdeY5lV6ZboUwNVzG0
 a3z8j18pr7rVseH5BOOtQNJSq8SBv4ykDcZmypQIpqxxgruLIiSnGP3P4QF5tv6fnNrL
 TL4/uGr3DOT/bIUP4wAey8NOuqM74tlzZwCYhUeOmMAwW2Jq4PbPLdcnVlU748VERsM7 BQ== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3736yqbqvq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 Mar 2021 18:30:16 -0500
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 124NRrM2031211;
        Thu, 4 Mar 2021 23:30:14 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma04ams.nl.ibm.com with ESMTP id 3712fmk63d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 Mar 2021 23:30:14 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 124NTvHS27001152
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 4 Mar 2021 23:29:57 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CD513A40A3;
        Thu,  4 Mar 2021 23:30:09 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7B8B8A409B;
        Thu,  4 Mar 2021 23:30:09 +0000 (GMT)
Received: from vm.lan (unknown [9.145.31.74])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  4 Mar 2021 23:30:09 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next] s390/bpf: Implement new atomic ops
Date:   Fri,  5 Mar 2021 00:30:02 +0100
Message-Id: <20210304233002.149096-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-04_08:2021-03-03,2021-03-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=999 spamscore=0 mlxscore=0 bulkscore=0 phishscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 impostorscore=0
 adultscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2103040113
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Implement BPF_AND, BPF_OR and BPF_XOR as the existing BPF_ADD. Since
the corresponding machine instructions return the old value, BPF_FETCH
happens by itself, the only additional thing that is required is
zero-extension.

There is no single instruction that implements BPF_XCHG on s390, so use
a COMPARE AND SWAP loop.

BPF_CMPXCHG, on the other hand, can be implemented by a single COMPARE
AND SWAP. Zero-extension is automatically inserted by the verifier.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---

Note: this patch depends on [1]; posting now to get some feedback.

[1] https://lore.kernel.org/bpf/20210303110402.3965626-1-jackmanb@google.com/

 arch/s390/net/bpf_jit_comp.c | 64 +++++++++++++++++++++++++++++++-----
 1 file changed, 55 insertions(+), 9 deletions(-)

diff --git a/arch/s390/net/bpf_jit_comp.c b/arch/s390/net/bpf_jit_comp.c
index f973e2ead197..63cae0476bb4 100644
--- a/arch/s390/net/bpf_jit_comp.c
+++ b/arch/s390/net/bpf_jit_comp.c
@@ -1209,21 +1209,67 @@ static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp,
 	 */
 	case BPF_STX | BPF_ATOMIC | BPF_DW:
 	case BPF_STX | BPF_ATOMIC | BPF_W:
-		if (insn->imm != BPF_ADD) {
+	{
+		bool is32 = BPF_SIZE(insn->code) == BPF_W;
+
+		switch (insn->imm) {
+/* {op32|op64} {%w0|%src},%src,off(%dst) */
+#define EMIT_ATOMIC(op32, op64) do {					\
+	EMIT6_DISP_LH(0xeb000000, is32 ? (op32) : (op64),		\
+		      (insn->imm & BPF_FETCH) ? src_reg : REG_W0,	\
+		      src_reg, dst_reg, off);				\
+	if (is32 && (insn->imm & BPF_FETCH))				\
+		EMIT_ZERO(src_reg);					\
+} while (0)
+		case BPF_ADD:
+		case BPF_ADD | BPF_FETCH:
+			/* {laal|laalg} */
+			EMIT_ATOMIC(0x00fa, 0x00ea);
+			break;
+		case BPF_AND:
+		case BPF_AND | BPF_FETCH:
+			/* {lan|lang} */
+			EMIT_ATOMIC(0x00f4, 0x00e4);
+			break;
+		case BPF_OR:
+		case BPF_OR | BPF_FETCH:
+			/* {lao|laog} */
+			EMIT_ATOMIC(0x00f6, 0x00e6);
+			break;
+		case BPF_XOR:
+		case BPF_XOR | BPF_FETCH:
+			/* {lax|laxg} */
+			EMIT_ATOMIC(0x00f7, 0x00e7);
+			break;
+#undef EMIT_ATOMIC
+		case BPF_XCHG:
+			/* {ly|lg} %w0,off(%dst) */
+			EMIT6_DISP_LH(0xe3000000,
+				      is32 ? 0x0058 : 0x0004, REG_W0, REG_0,
+				      dst_reg, off);
+			/* 0: {csy|csg} %w0,%src,off(%dst) */
+			EMIT6_DISP_LH(0xeb000000, is32 ? 0x0014 : 0x0030,
+				      REG_W0, src_reg, dst_reg, off);
+			/* brc 4,0b */
+			EMIT4_PCREL_RIC(0xa7040000, 4, jit->prg - 6);
+			/* {llgfr|lgr} %src,%w0 */
+			EMIT4(is32 ? 0xb9160000 : 0xb9040000, src_reg, REG_W0);
+			if (is32 && insn_is_zext(&insn[1]))
+				insn_count = 2;
+			break;
+		case BPF_CMPXCHG:
+			/* 0: {csy|csg} %b0,%src,off(%dst) */
+			EMIT6_DISP_LH(0xeb000000, is32 ? 0x0014 : 0x0030,
+				      BPF_REG_0, src_reg, dst_reg, off);
+			break;
+		default:
 			pr_err("Unknown atomic operation %02x\n", insn->imm);
 			return -1;
 		}
 
-		/* *(u32/u64 *)(dst + off) += src
-		 *
-		 * BFW_W:  laal  %w0,%src,off(%dst)
-		 * BPF_DW: laalg %w0,%src,off(%dst)
-		 */
-		EMIT6_DISP_LH(0xeb000000,
-			      BPF_SIZE(insn->code) == BPF_W ? 0x00fa : 0x00ea,
-			      REG_W0, src_reg, dst_reg, off);
 		jit->seen |= SEEN_MEM;
 		break;
+	}
 	/*
 	 * BPF_LDX
 	 */
-- 
2.29.2

