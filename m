Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2886126399C
	for <lists+bpf@lfdr.de>; Thu, 10 Sep 2020 03:58:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725772AbgIJB6j (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Sep 2020 21:58:39 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52974 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727893AbgIJBjE (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 9 Sep 2020 21:39:04 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 089NV6np093258;
        Wed, 9 Sep 2020 19:36:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=UtVGwcgokTQGGsRFQ9YKQlW9Re6DacOp1/VYozSm0KY=;
 b=XzDnIL8q+7lYg2spU+TbNR2tApa3Yk8QlSWml90eDsFLVdJ+zQcs8/RsKNqlVmnvEfm3
 axAPcKjCnjMbQKYCFa0Mio/ztDhe579mr8xqGxefES4bidq+qhytNEMm+4xAUwG4av8c
 jv7yqmTsRYClff8fFbFT2l68UH/wkLiZrQmEwCHWwp+IC7n9cpbQv9AWYF1pl0tqC6gj
 YEqZ6GImo0e3B/fJJ/z9ql7DnsA9jFW0xn0kLb42nWQ2PAT1uyL8I8ZlnK5U7aKg3HH+
 lfEmA8vd88jbAGerh1XbG+4FVEG8sJZg3Cz6ok4PYquBo1tCAmLnzsuzchtCfrW0ZSE5 JQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 33f6hfup49-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Sep 2020 19:36:51 -0400
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 089NYRVx104345;
        Wed, 9 Sep 2020 19:36:51 -0400
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0b-001b2d01.pphosted.com with ESMTP id 33f6hfup3s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Sep 2020 19:36:51 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 089NWD0x013772;
        Wed, 9 Sep 2020 23:36:49 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma05fra.de.ibm.com with ESMTP id 33f3yrg6ec-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Sep 2020 23:36:49 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 089NakSx39715274
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 9 Sep 2020 23:36:46 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7FACDA404D;
        Wed,  9 Sep 2020 23:36:46 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1DD06A4051;
        Wed,  9 Sep 2020 23:36:46 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.5.224])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  9 Sep 2020 23:36:46 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH RFC bpf-next 4/5] bpf: Make bpf_patch_insn_data() accept variable number of old insns
Date:   Thu, 10 Sep 2020 01:34:38 +0200
Message-Id: <20200909233439.3100292-5-iii@linux.ibm.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200909233439.3100292-1-iii@linux.ibm.com>
References: <20200909233439.3100292-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-09_17:2020-09-09,2020-09-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 spamscore=0 bulkscore=0 suspectscore=0 adultscore=0 priorityscore=1501
 mlxscore=0 lowpriorityscore=0 phishscore=0 mlxlogscore=999 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009090202
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Since this changes the function's meaning, rename it to
bpf_patch_insns_data(). There are quite a few uses - adjust them all
instead of creating a wrapper, which is not worth it in this case.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 kernel/bpf/verifier.c | 44 ++++++++++++++++++++++++++-----------------
 1 file changed, 27 insertions(+), 17 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 6791a6e1bf76..17c2e926e436 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -9629,12 +9629,14 @@ static void adjust_subprog_starts(struct bpf_verifier_env *env, u32 off,
 	}
 }
 
-static struct bpf_prog *bpf_patch_insn_data(struct bpf_verifier_env *env, u32 off,
-					    const struct bpf_insn *patch, u32 len)
+static struct bpf_prog *bpf_patch_insns_data(struct bpf_verifier_env *env,
+					     u32 off, u32 len_old,
+					     const struct bpf_insn *patch,
+					     u32 len)
 {
 	struct bpf_prog *new_prog;
 
-	new_prog = bpf_patch_insns(env->prog, off, 1, patch, len);
+	new_prog = bpf_patch_insns(env->prog, off, len_old, patch, len);
 	if (IS_ERR(new_prog)) {
 		if (PTR_ERR(new_prog) == -ERANGE)
 			verbose(env,
@@ -9642,9 +9644,9 @@ static struct bpf_prog *bpf_patch_insn_data(struct bpf_verifier_env *env, u32 of
 				env->insn_aux_data[off].orig_idx);
 		return NULL;
 	}
-	if (adjust_insns_aux_data(env, new_prog, off, 1, len))
+	if (adjust_insns_aux_data(env, new_prog, off, len_old, len))
 		return NULL;
-	adjust_subprog_starts(env, off, 1, len);
+	adjust_subprog_starts(env, off, len_old, len);
 	return new_prog;
 }
 
@@ -9972,7 +9974,8 @@ static int opt_subreg_zext_lo32_rnd_hi32(struct bpf_verifier_env *env,
 		patch = zext_patch;
 		patch_len = 2;
 apply_patch_buffer:
-		new_prog = bpf_patch_insn_data(env, adj_idx, patch, patch_len);
+		new_prog = bpf_patch_insns_data(env, adj_idx, 1, patch,
+						patch_len);
 		if (!new_prog)
 			return -ENOMEM;
 		env->prog = new_prog;
@@ -10011,7 +10014,8 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
 			verbose(env, "bpf verifier is misconfigured\n");
 			return -EINVAL;
 		} else if (cnt) {
-			new_prog = bpf_patch_insn_data(env, 0, insn_buf, cnt);
+			new_prog =
+				bpf_patch_insns_data(env, 0, 1, insn_buf, cnt);
 			if (!new_prog)
 				return -ENOMEM;
 
@@ -10059,7 +10063,8 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
 			};
 
 			cnt = ARRAY_SIZE(patch);
-			new_prog = bpf_patch_insn_data(env, i + delta, patch, cnt);
+			new_prog = bpf_patch_insns_data(env, i + delta, 1,
+							patch, cnt);
 			if (!new_prog)
 				return -ENOMEM;
 
@@ -10157,7 +10162,8 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
 			}
 		}
 
-		new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
+		new_prog =
+			bpf_patch_insns_data(env, i + delta, 1, insn_buf, cnt);
 		if (!new_prog)
 			return -ENOMEM;
 
@@ -10435,7 +10441,8 @@ static int fixup_bpf_calls(struct bpf_verifier_env *env)
 				cnt = ARRAY_SIZE(mask_and_mod) - (is64 ? 1 : 0);
 			}
 
-			new_prog = bpf_patch_insn_data(env, i + delta, patchlet, cnt);
+			new_prog = bpf_patch_insns_data(env, i + delta, 1,
+							patchlet, cnt);
 			if (!new_prog)
 				return -ENOMEM;
 
@@ -10454,7 +10461,8 @@ static int fixup_bpf_calls(struct bpf_verifier_env *env)
 				return -EINVAL;
 			}
 
-			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
+			new_prog = bpf_patch_insns_data(env, i + delta, 1,
+							insn_buf, cnt);
 			if (!new_prog)
 				return -ENOMEM;
 
@@ -10506,7 +10514,8 @@ static int fixup_bpf_calls(struct bpf_verifier_env *env)
 				*patch++ = BPF_ALU64_IMM(BPF_MUL, off_reg, -1);
 			cnt = patch - insn_buf;
 
-			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
+			new_prog = bpf_patch_insns_data(env, i + delta, 1,
+							insn_buf, cnt);
 			if (!new_prog)
 				return -ENOMEM;
 
@@ -10590,7 +10599,8 @@ static int fixup_bpf_calls(struct bpf_verifier_env *env)
 								 map)->index_mask);
 			insn_buf[2] = *insn;
 			cnt = 3;
-			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
+			new_prog = bpf_patch_insns_data(env, i + delta, 1,
+							insn_buf, cnt);
 			if (!new_prog)
 				return -ENOMEM;
 
@@ -10625,8 +10635,8 @@ static int fixup_bpf_calls(struct bpf_verifier_env *env)
 					return -EINVAL;
 				}
 
-				new_prog = bpf_patch_insn_data(env, i + delta,
-							       insn_buf, cnt);
+				new_prog = bpf_patch_insns_data(
+					env, i + delta, 1, insn_buf, cnt);
 				if (!new_prog)
 					return -ENOMEM;
 
@@ -10694,8 +10704,8 @@ static int fixup_bpf_calls(struct bpf_verifier_env *env)
 						  BPF_REG_0, 0);
 			cnt = 3;
 
-			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf,
-						       cnt);
+			new_prog = bpf_patch_insns_data(env, i + delta, 1,
+							insn_buf, cnt);
 			if (!new_prog)
 				return -ENOMEM;
 
-- 
2.25.4

