Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A2DE3B93B9
	for <lists+bpf@lfdr.de>; Thu,  1 Jul 2021 17:10:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232625AbhGAPMp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 1 Jul 2021 11:12:45 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:5131 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232969AbhGAPMp (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 1 Jul 2021 11:12:45 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 161F79gA076288;
        Thu, 1 Jul 2021 11:09:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=ubGNqFG5KcgLyKIENcAKYydTQimq31wdX0j7ep3sUHI=;
 b=nhLmLtTzJJvcY+cGQzG3e0L4t/SF2u/q8hxxsSGxBQmTh7WS4XHWPGqoY9FtaDiEY//9
 wOxOPOtt0YG2WFG8D6GWGp6vySsOcjN1zfpTzWoaNaVPZZIP06zsdCQjzCWzXGiUW6a9
 H+rj7xpsXaurOHTkviufxyek6v8/HZY0zgj/v66/DXfbC8xjEBEZBUAVu4yd3XHxa5r5
 ntjiwU86ykFUPfrJfOctYKFMjcZ/r/4qqusTiGBfzIQ39Y+fDv4JvVcnnV7CYFYw4IT+
 Chq7LoeLXp3oGkVlIdCIDSAYH6k69c7K5WBe1iYAp1NM7t1vKAMoGuBlWaPCAQp8Ccir 7g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39he8fusk9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Jul 2021 11:09:35 -0400
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 161F7Ndh077943;
        Thu, 1 Jul 2021 11:09:34 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39he8fusj1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Jul 2021 11:09:34 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 161EtEBW026989;
        Thu, 1 Jul 2021 15:09:32 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03ams.nl.ibm.com with ESMTP id 39duv8aftx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Jul 2021 15:09:32 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 161F9UxH31588764
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 1 Jul 2021 15:09:30 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0F82FAE89D;
        Thu,  1 Jul 2021 15:09:30 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 45487AE87F;
        Thu,  1 Jul 2021 15:09:26 +0000 (GMT)
Received: from naverao1-tp.in.ibm.com (unknown [9.85.115.110])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  1 Jul 2021 15:09:26 +0000 (GMT)
From:   "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To:     <bpf@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Brendan Jackman <jackmanb@google.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH 2/2] powerpc/bpf: Reject atomic ops in ppc32 JIT
Date:   Thu,  1 Jul 2021 20:38:59 +0530
Message-Id: <426699046d89fe50f66ecf74bd31c01eda976ba5.1625145429.git.naveen.n.rao@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1625145429.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1625145429.git.naveen.n.rao@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: yCBw-pmmBVaW5t4-Az1aurzpmog8aV3n
X-Proofpoint-GUID: 6inMzho6QJFnYVkHYViCz-ACO8_UkTQB
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-01_08:2021-07-01,2021-07-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 clxscore=1015 priorityscore=1501 impostorscore=0 malwarescore=0
 spamscore=0 adultscore=0 bulkscore=0 mlxscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107010092
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Commit 91c960b0056672 ("bpf: Rename BPF_XADD and prepare to encode other
atomics in .imm") converted BPF_XADD to BPF_ATOMIC and updated all JIT
implementations to reject JIT'ing instructions with an immediate value
different from BPF_ADD. However, ppc32 BPF JIT was implemented around
the same time and didn't include the same change. Update the ppc32 JIT
accordingly.

Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 arch/powerpc/net/bpf_jit_comp32.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/net/bpf_jit_comp32.c b/arch/powerpc/net/bpf_jit_comp32.c
index cbe5b399ed869d..91c990335a16c9 100644
--- a/arch/powerpc/net/bpf_jit_comp32.c
+++ b/arch/powerpc/net/bpf_jit_comp32.c
@@ -773,9 +773,17 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, struct codegen_context *
 			break;
 
 		/*
-		 * BPF_STX XADD (atomic_add)
+		 * BPF_STX ATOMIC (atomic ops)
 		 */
-		case BPF_STX | BPF_XADD | BPF_W: /* *(u32 *)(dst + off) += src */
+		case BPF_STX | BPF_ATOMIC | BPF_W:
+			if (imm != BPF_ADD) {
+				pr_err_ratelimited(
+					"eBPF filter atomic op code %02x (@%d) unsupported\n", code, i);
+				return -ENOTSUPP;
+			}
+
+			/* *(u32 *)(dst + off) += src */
+
 			bpf_set_seen_register(ctx, tmp_reg);
 			/* Get offset into TMP_REG */
 			EMIT(PPC_RAW_LI(tmp_reg, off));
@@ -789,7 +797,7 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, struct codegen_context *
 			PPC_BCC_SHORT(COND_NE, (ctx->idx - 3) * 4);
 			break;
 
-		case BPF_STX | BPF_XADD | BPF_DW: /* *(u64 *)(dst + off) += src */
+		case BPF_STX | BPF_ATOMIC | BPF_DW: /* *(u64 *)(dst + off) += src */
 			return -EOPNOTSUPP;
 
 		/*
-- 
2.31.1

