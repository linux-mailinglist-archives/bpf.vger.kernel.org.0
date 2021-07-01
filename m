Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EA9D3B93B6
	for <lists+bpf@lfdr.de>; Thu,  1 Jul 2021 17:09:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232799AbhGAPMS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 1 Jul 2021 11:12:18 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33592 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232625AbhGAPMS (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 1 Jul 2021 11:12:18 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 161F4Ph7067583;
        Thu, 1 Jul 2021 11:09:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=I4QJIE4Iy5UnQK1GY2UOxb3L6c48DcS/vb+vYQ96keg=;
 b=fdpNFc7NqSqyx+NfMAEoKE4CM8D9VV+92vRGtZO7+ggPxz2/Rzx0Ammn03Y+fXK2ZKN6
 xDTHl+HSqeyw7uQEvbQGS4/B4OWZ0ZYH8jTXAmdvw8wVuMKq9ZF6lqXU08nTFamFr02p
 ceEPAjN4IyfNX5ZrV5YEvhj/dPl2Qpq/eS89OxN7ckj+xMmrDtg+4CHGGGGg7aeK9FZl
 9FsOCXilCt1FhQnKCnj3ZvQgELbetChxN3uBaJrsH0+76ynxTVgLWTgj60AdTyhJjiJ4
 aHVxAv77fE0NV36OhAEz2DZe2V3ck+vbHXQl5+bptJbxr6fPQ7Xj1wIWu+13PegpHaZZ 5w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39hdcanutf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Jul 2021 11:09:30 -0400
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 161F5u8Z075884;
        Thu, 1 Jul 2021 11:09:30 -0400
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39hdcanus4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Jul 2021 11:09:29 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 161EtCWR025015;
        Thu, 1 Jul 2021 15:09:27 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma03fra.de.ibm.com with ESMTP id 39duv8h9qs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Jul 2021 15:09:27 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 161F9ONe26214846
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 1 Jul 2021 15:09:24 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AD06DAE885;
        Thu,  1 Jul 2021 15:09:24 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 081F8AE872;
        Thu,  1 Jul 2021 15:09:21 +0000 (GMT)
Received: from naverao1-tp.in.ibm.com (unknown [9.85.115.110])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  1 Jul 2021 15:09:19 +0000 (GMT)
From:   "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To:     <bpf@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Brendan Jackman <jackmanb@google.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH 1/2] powerpc/bpf: Fix detecting BPF atomic instructions
Date:   Thu,  1 Jul 2021 20:38:58 +0530
Message-Id: <4117b430ffaa8cd7af042496f87fd7539e4f17fd.1625145429.git.naveen.n.rao@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1625145429.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1625145429.git.naveen.n.rao@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 7I59dwrNfX-mZfighPz16eCSic3A81wm
X-Proofpoint-ORIG-GUID: ToQy-Y9rCS4d2kQeYr4FYG7A1FxBM-mK
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-01_08:2021-07-01,2021-07-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 adultscore=0 phishscore=0 mlxlogscore=999 mlxscore=0 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107010092
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Commit 91c960b0056672 ("bpf: Rename BPF_XADD and prepare to encode other
atomics in .imm") converted BPF_XADD to BPF_ATOMIC and added a way to
distinguish instructions based on the immediate field. Existing JIT
implementations were updated to check for the immediate field and to
reject programs utilizing anything more than BPF_ADD (such as BPF_FETCH)
in the immediate field.

However, the check added to powerpc64 JIT did not look at the correct
BPF instruction. Due to this, such programs would be accepted and
incorrectly JIT'ed resulting in soft lockups, as seen with the atomic
bounds test. Fix this by looking at the correct immediate value.

Fixes: 91c960b0056672 ("bpf: Rename BPF_XADD and prepare to encode other atomics in .imm")
Reported-by: Jiri Olsa <jolsa@redhat.com>
Tested-by: Jiri Olsa <jolsa@redhat.com>
Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
Hi Jiri,
FYI: I made a small change in this patch -- using 'imm' directly, rather 
than insn[i].imm. I've still added your Tested-by since this shouldn't 
impact the fix in any way.

- Naveen


 arch/powerpc/net/bpf_jit_comp64.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
index 5cad5b5a7e9774..de8595880feec6 100644
--- a/arch/powerpc/net/bpf_jit_comp64.c
+++ b/arch/powerpc/net/bpf_jit_comp64.c
@@ -667,7 +667,7 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, struct codegen_context *
 		 * BPF_STX ATOMIC (atomic ops)
 		 */
 		case BPF_STX | BPF_ATOMIC | BPF_W:
-			if (insn->imm != BPF_ADD) {
+			if (imm != BPF_ADD) {
 				pr_err_ratelimited(
 					"eBPF filter atomic op code %02x (@%d) unsupported\n",
 					code, i);
@@ -689,7 +689,7 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, struct codegen_context *
 			PPC_BCC_SHORT(COND_NE, tmp_idx);
 			break;
 		case BPF_STX | BPF_ATOMIC | BPF_DW:
-			if (insn->imm != BPF_ADD) {
+			if (imm != BPF_ADD) {
 				pr_err_ratelimited(
 					"eBPF filter atomic op code %02x (@%d) unsupported\n",
 					code, i);
-- 
2.31.1

