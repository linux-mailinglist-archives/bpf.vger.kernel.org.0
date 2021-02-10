Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEEBC3171A1
	for <lists+bpf@lfdr.de>; Wed, 10 Feb 2021 21:47:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233353AbhBJUqV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 10 Feb 2021 15:46:21 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38582 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233393AbhBJUqE (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 10 Feb 2021 15:46:04 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 11AKYpii082314;
        Wed, 10 Feb 2021 15:45:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=ogMTO6pjojnaajEnERmyXdS7tEeXt2KM6zw/NUcgN4E=;
 b=Ci9hrAKVjNcrjR9+0PP8SDgB08xJdFfpkOSDP4bHYS3O7Gd32RHfh1utt4MwiHbmDraI
 C6WkHfrLkFYjCQ7pQCZ0StIPpBwJCX36XARYBenp9yUqj4OCxUo/jZW8up2RFCAB6qCK
 6L5KmhJdwPqF5YRd2MPxPGgrJKeLNam5lzwDUoPGn4cMkl2jLb0Do3aY0S6sKmReyi/h
 emKInGPRx1c13VD2MA9m9wNyjmZvbyX6OKZc+LUnMeS4hldBmHxS8eDEnCiytQOCb0Lm
 LeVHw8BPiNsRbpp/fDeOMLBjVE3GksoTIL82Xi1Ft9ywXk7DwAllEYNebdpKVS2Xjr1Y RA== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36mpawruv9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 Feb 2021 15:45:11 -0500
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11AKh4UB003975;
        Wed, 10 Feb 2021 20:45:09 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04ams.nl.ibm.com with ESMTP id 36hjr8d4ys-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 Feb 2021 20:45:08 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11AKj6Mi33620398
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Feb 2021 20:45:06 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F33B25205F;
        Wed, 10 Feb 2021 20:45:05 +0000 (GMT)
Received: from vm.lan (unknown [9.171.67.27])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 9E05F5204E;
        Wed, 10 Feb 2021 20:45:05 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next] bpf: Fix subreg optimization for BPF_FETCH
Date:   Wed, 10 Feb 2021 21:45:02 +0100
Message-Id: <20210210204502.83429-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-10_10:2021-02-10,2021-02-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 phishscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0 bulkscore=0
 mlxlogscore=999 impostorscore=0 adultscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102100178
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

All 32-bit variants of BPF_FETCH (add, and, or, xor, xchg, cmpxchg)
define a 32-bit subreg and thus have zext_dst set. Their encoding,
however, uses dst_reg field as a base register, which causes
opt_subreg_zext_lo32_rnd_hi32() to zero-extend said base register
instead of the one the insn really defines (r0 or src_reg).

Fix by properly choosing a register being defined, similar to how
check_atomic() already does that.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 kernel/bpf/verifier.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 15694246f854..4b97e42f34cf 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -10588,6 +10588,7 @@ static int opt_subreg_zext_lo32_rnd_hi32(struct bpf_verifier_env *env,
 	for (i = 0; i < len; i++) {
 		int adj_idx = i + delta;
 		struct bpf_insn insn;
+		u8 load_reg;
 
 		insn = insns[adj_idx];
 		if (!aux[adj_idx].zext_dst) {
@@ -10630,9 +10631,27 @@ static int opt_subreg_zext_lo32_rnd_hi32(struct bpf_verifier_env *env,
 		if (!bpf_jit_needs_zext())
 			continue;
 
+		/* zext_dst means that we want to zero-extend whatever register
+		 * the insn defines, which is dst_reg most of the time, with
+		 * the notable exception of BPF_STX + BPF_ATOMIC + BPF_FETCH.
+		 */
+		if (BPF_CLASS(insn.code) == BPF_STX &&
+		    BPF_MODE(insn.code) == BPF_ATOMIC) {
+			/* BPF_STX + BPF_ATOMIC insns without BPF_FETCH do not
+			 * define any registers, therefore zext_dst cannot be
+			 * set.
+			 */
+			if (WARN_ON(!(insn.imm & BPF_FETCH)))
+				return -EINVAL;
+			load_reg = insn.imm == BPF_CMPXCHG ? BPF_REG_0
+							   : insn.src_reg;
+		} else {
+			load_reg = insn.dst_reg;
+		}
+
 		zext_patch[0] = insn;
-		zext_patch[1].dst_reg = insn.dst_reg;
-		zext_patch[1].src_reg = insn.dst_reg;
+		zext_patch[1].dst_reg = load_reg;
+		zext_patch[1].src_reg = load_reg;
 		patch = zext_patch;
 		patch_len = 2;
 apply_patch_buffer:
-- 
2.29.2

