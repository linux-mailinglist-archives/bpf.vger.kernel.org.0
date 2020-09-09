Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B2D22639A0
	for <lists+bpf@lfdr.de>; Thu, 10 Sep 2020 03:59:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728363AbgIJB7C (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Sep 2020 21:59:02 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44908 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729824AbgIJBpB (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 9 Sep 2020 21:45:01 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 089NZI5e128144;
        Wed, 9 Sep 2020 19:37:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=pBMLCZNcYuWQcclrP/ceXhKw5ZPXEsDgH8qPadhIZMA=;
 b=BT4b1AhXzbLFM8c947LEhRa+9tapDmN9/i/o4lOvmhePIX5TxydtYe+88ljywoh92Xq8
 rpnMTlei+TaYQmFf75zXkhsnQQYz+IDMVIMWInUbFntrFMVPSKCbvKyQ7elWtNPc9TeG
 jBluvlRLAcuu/LttF6n20OZ/0kCGjY/cdRWW1oPlqV8WXp1UEOWib+/wbL4ov2tzOvjy
 Aak9T7juM9dFI3VmkI7tNtPA3JsE56jTOLFCG1MsRwpRMO48MsOIpZT9wGB+U9OJuzKx
 69kupZSa4TR8rGdKa8ypNR9Hbwc4sBTgWD0rPX9esRtnBlvcw1gKK7jbmEQYIVKSIHt3 dA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33f7v598b2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Sep 2020 19:37:15 -0400
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 089NZxjv131604;
        Wed, 9 Sep 2020 19:37:15 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33f7v598ap-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Sep 2020 19:37:14 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 089NbDhW028000;
        Wed, 9 Sep 2020 23:37:13 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma04ams.nl.ibm.com with ESMTP id 33c2a8dbcv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Sep 2020 23:37:13 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 089NbAIu34406714
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 9 Sep 2020 23:37:10 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8AD1FA4040;
        Wed,  9 Sep 2020 23:37:10 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 271D1A404D;
        Wed,  9 Sep 2020 23:37:10 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.5.224])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  9 Sep 2020 23:37:10 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH RFC bpf-next 5/5] bpf: Do not include the original insn in zext patchlet
Date:   Thu, 10 Sep 2020 01:34:39 +0200
Message-Id: <20200909233439.3100292-6-iii@linux.ibm.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200909233439.3100292-1-iii@linux.ibm.com>
References: <20200909233439.3100292-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-09_17:2020-09-09,2020-09-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 mlxscore=0 suspectscore=0 mlxlogscore=987 priorityscore=1501
 malwarescore=0 impostorscore=0 adultscore=0 spamscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009090202
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

If the original insn is a jump, then it is not subjected to branch
adjustment, which is incorrect. As discovered by Yauheni in

https://lore.kernel.org/bpf/20200903140542.156624-1-yauheni.kaliuta@redhat.com/

this causes `test_progs -t global_funcs` failures on s390.

Most likely, the current code includes the original insn in the
patchlet, because there was no infrastructure to insert new insns, only
to replace the existing ones. Now that bpf_patch_insns_data() can do
insertions, stop including the original insns in zext patchlets.

Fixes: a4b1d3c1ddf6 ("bpf: verifier: insert zero extension according to analysis result")
Reported-by: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 kernel/bpf/verifier.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 17c2e926e436..64a04953c631 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -9911,7 +9911,7 @@ static int opt_remove_nops(struct bpf_verifier_env *env)
 static int opt_subreg_zext_lo32_rnd_hi32(struct bpf_verifier_env *env,
 					 const union bpf_attr *attr)
 {
-	struct bpf_insn *patch, zext_patch[2], rnd_hi32_patch[4];
+	struct bpf_insn *patch, zext_patch, rnd_hi32_patch[4];
 	struct bpf_insn_aux_data *aux = env->insn_aux_data;
 	int i, patch_len, delta = 0, len = env->prog->len;
 	struct bpf_insn *insns = env->prog->insnsi;
@@ -9919,13 +9919,14 @@ static int opt_subreg_zext_lo32_rnd_hi32(struct bpf_verifier_env *env,
 	bool rnd_hi32;
 
 	rnd_hi32 = attr->prog_flags & BPF_F_TEST_RND_HI32;
-	zext_patch[1] = BPF_ZEXT_REG(0);
+	zext_patch = BPF_ZEXT_REG(0);
 	rnd_hi32_patch[1] = BPF_ALU64_IMM(BPF_MOV, BPF_REG_AX, 0);
 	rnd_hi32_patch[2] = BPF_ALU64_IMM(BPF_LSH, BPF_REG_AX, 32);
 	rnd_hi32_patch[3] = BPF_ALU64_REG(BPF_OR, 0, BPF_REG_AX);
 	for (i = 0; i < len; i++) {
 		int adj_idx = i + delta;
 		struct bpf_insn insn;
+		int len_old = 1;
 
 		insn = insns[adj_idx];
 		if (!aux[adj_idx].zext_dst) {
@@ -9968,20 +9969,21 @@ static int opt_subreg_zext_lo32_rnd_hi32(struct bpf_verifier_env *env,
 		if (!bpf_jit_needs_zext())
 			continue;
 
-		zext_patch[0] = insn;
-		zext_patch[1].dst_reg = insn.dst_reg;
-		zext_patch[1].src_reg = insn.dst_reg;
-		patch = zext_patch;
-		patch_len = 2;
+		zext_patch.dst_reg = insn.dst_reg;
+		zext_patch.src_reg = insn.dst_reg;
+		patch = &zext_patch;
+		patch_len = 1;
+		adj_idx++;
+		len_old = 0;
 apply_patch_buffer:
-		new_prog = bpf_patch_insns_data(env, adj_idx, 1, patch,
+		new_prog = bpf_patch_insns_data(env, adj_idx, len_old, patch,
 						patch_len);
 		if (!new_prog)
 			return -ENOMEM;
 		env->prog = new_prog;
 		insns = new_prog->insnsi;
 		aux = env->insn_aux_data;
-		delta += patch_len - 1;
+		delta += patch_len - len_old;
 	}
 
 	return 0;
-- 
2.25.4

