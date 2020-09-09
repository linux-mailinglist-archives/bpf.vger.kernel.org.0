Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 782D5263AF1
	for <lists+bpf@lfdr.de>; Thu, 10 Sep 2020 04:49:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727893AbgIJB67 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Sep 2020 21:58:59 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:18784 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729789AbgIJBoP (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 9 Sep 2020 21:44:15 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 089NUdHV189446;
        Wed, 9 Sep 2020 19:35:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=b3WFthoDKjKR9I/DkTgdZOS3smXy47kVdfX9G3THCXw=;
 b=bFOCNXZ7yUqXAStfONKEsKdG2qGlalLadJ1XXqdRFJEELtzY7NbnOcoeeUhQJUEuEgWq
 g1S4sTzEJ/prIWv4nzOK3HPFmtDm9k6wR5XK1P6jQfYouS1bxcPBz+EE6L7Y9kB2yggv
 H7ZxMnBiPnfFXvNVZtlCzufa1s615Zk7X8R4OuL2siP/Fo9dzRuEDKTEW31vzKaiEm0u
 GIHB4qipNHXQ4WGY+GtUioYZdDoY7/1RG3yEbAFjgh6ViCAiIcBjplp7fKncpxTRMcwg
 tjEhu7eWuedBU8wY+whlr4cDaYFmAwvDNOmaGR1DP3iOliCw3NPl0isAZK00C0c3xBum 5A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 33f86pgvej-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Sep 2020 19:35:37 -0400
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 089NWbII001417;
        Wed, 9 Sep 2020 19:35:37 -0400
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0b-001b2d01.pphosted.com with ESMTP id 33f86pgve4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Sep 2020 19:35:37 -0400
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 089NWiBK026316;
        Wed, 9 Sep 2020 23:35:35 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma01fra.de.ibm.com with ESMTP id 33c2a811w3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Sep 2020 23:35:35 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 089NZWgX23658854
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 9 Sep 2020 23:35:32 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 87125A4051;
        Wed,  9 Sep 2020 23:35:32 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 26684A4040;
        Wed,  9 Sep 2020 23:35:32 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.5.224])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  9 Sep 2020 23:35:32 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH RFC bpf-next 2/5] bpf: Make adjust_insn_aux_data() accept variable number of old insns
Date:   Thu, 10 Sep 2020 01:34:36 +0200
Message-Id: <20200909233439.3100292-3-iii@linux.ibm.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200909233439.3100292-1-iii@linux.ibm.com>
References: <20200909233439.3100292-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-09_17:2020-09-09,2020-09-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 phishscore=0 priorityscore=1501 suspectscore=0 clxscore=1015 mlxscore=0
 malwarescore=0 spamscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009090202
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Since this changes the function's meaning, rename it to
adjust_insns_aux_data(). The way this function used to be implemented
for a single insn is somewhat tricky, and the new version preserves
this behavior:

1. For both fast and slow paths, populate zext_dst at [off, off +
   cnt_old) positions from insns at [off + cnt - cnt_old, off + cnt)
   positions. On the fast path, this produces identical insn_aux_data
   and insnsi offsets. On the slow path the offsets are different, but
   they will be fixed up later.
2. If the prog size did not change, return (fast path).
3. Preserve all the aux data for the leading insns.
4. Preserve all the aux data for the trailing insns, including what has
   been produced during step 1. This is done by memcpying it to a
   different offset, which corrects the difference between insn_aux_data
   and insnsi offsets.
5. Populate seen and zext_dst for the remaining insns.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 kernel/bpf/verifier.c | 33 +++++++++++++++++++--------------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index dd0b138ee382..077919ac3826 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -9572,25 +9572,29 @@ static void convert_pseudo_ld_imm64(struct bpf_verifier_env *env)
 			insn->src_reg = 0;
 }
 
-/* single env->prog->insni[off] instruction was replaced with the range
- * insni[off, off + cnt).  Adjust corresponding insn_aux_data by copying
- * [0, off) and [off, end) to new locations, so the patched range stays zero
+/* Instructions from the range env->prog->insni[off, off + cnt_old) were
+ * replaced with the range insni[off, off + cnt). Adjust corresponding
+ * insn_aux_data by copying [0, off) and [off, end) to new locations, so the
+ * patched range stays zero.
  */
-static int adjust_insn_aux_data(struct bpf_verifier_env *env,
-				struct bpf_prog *new_prog, u32 off, u32 cnt)
+static int adjust_insns_aux_data(struct bpf_verifier_env *env,
+				 struct bpf_prog *new_prog, u32 off,
+				 u32 cnt_old, u32 cnt)
 {
 	struct bpf_insn_aux_data *new_data, *old_data = env->insn_aux_data;
 	struct bpf_insn *insn = new_prog->insnsi;
 	u32 prog_len;
 	int i;
 
-	/* aux info at OFF always needs adjustment, no matter fast path
-	 * (cnt == 1) is taken or not. There is no guarantee INSN at OFF is the
-	 * original insn at old prog.
+	/* aux infos at [off, off + cnt_old) need adjustment even on the fast
+	 * path (cnt == cnt_old). There is no guarantee the insns at [off,
+	 * off + cnt_old) are the original ones at old prog.
 	 */
-	old_data[off].zext_dst = insn_has_def32(env, insn + off + cnt - 1);
+	for (i = off; i < off + cnt_old; i++)
+		old_data[i].zext_dst =
+			insn_has_def32(env, insn + i + cnt - cnt_old);
 
-	if (cnt == 1)
+	if (cnt == cnt_old)
 		return 0;
 	prog_len = new_prog->len;
 	new_data = vzalloc(array_size(prog_len,
@@ -9598,9 +9602,10 @@ static int adjust_insn_aux_data(struct bpf_verifier_env *env,
 	if (!new_data)
 		return -ENOMEM;
 	memcpy(new_data, old_data, sizeof(struct bpf_insn_aux_data) * off);
-	memcpy(new_data + off + cnt - 1, old_data + off,
-	       sizeof(struct bpf_insn_aux_data) * (prog_len - off - cnt + 1));
-	for (i = off; i < off + cnt - 1; i++) {
+	memcpy(new_data + off + cnt - cnt_old, old_data + off,
+	       sizeof(struct bpf_insn_aux_data) *
+		       (prog_len - off - cnt + cnt_old));
+	for (i = off; i < off + cnt - cnt_old; i++) {
 		new_data[i].seen = env->pass_cnt;
 		new_data[i].zext_dst = insn_has_def32(env, insn + i);
 	}
@@ -9636,7 +9641,7 @@ static struct bpf_prog *bpf_patch_insn_data(struct bpf_verifier_env *env, u32 of
 				env->insn_aux_data[off].orig_idx);
 		return NULL;
 	}
-	if (adjust_insn_aux_data(env, new_prog, off, len))
+	if (adjust_insns_aux_data(env, new_prog, off, 1, len))
 		return NULL;
 	adjust_subprog_starts(env, off, len);
 	return new_prog;
-- 
2.25.4

