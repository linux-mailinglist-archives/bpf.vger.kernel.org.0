Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A633263AED
	for <lists+bpf@lfdr.de>; Thu, 10 Sep 2020 04:48:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730136AbgIJB7K (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Sep 2020 21:59:10 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:63980 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730127AbgIJBxX (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 9 Sep 2020 21:53:23 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 089NWE9E063609;
        Wed, 9 Sep 2020 19:35:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=c5K0tr2EUSh8vhEx/GnEl/mv9R9MKq/O6pEhPZpA72M=;
 b=QdY75rDZehVABFyDtHBLTAoPo3/Fob/71FZhzxjyGgoitdHvXupbFzG7SYFlVMMztKOD
 n4H0USMNHhK6xU2BVbXXdPuFglcyrPdcKAM8cqBCwtqeliIWWY53prvXj46aPwdUSGpM
 q1MHHlVOB6fxH1MZL6pjgbXPfQq9O/PAdNMvNKeM2ubMnY7NUnTeQlkS1mEWtNFUk2gf
 7fYhHyaU5nf5ohskYviXn7KGIg5tFKJCeI1a+SsFbGG9NPz2HGSE9nAdAto5ttJOOaGb
 zpVWRKlsR/YtxuDridINif51Isn7I9pETYncSuYvSkwcAt4z1kzUOIU1FwiAqL5s+2Zc tw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33f8jq0bxp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Sep 2020 19:35:00 -0400
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 089NX5YI065089;
        Wed, 9 Sep 2020 19:34:59 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33f8jq0bx3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Sep 2020 19:34:59 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 089NWsBA023911;
        Wed, 9 Sep 2020 23:34:58 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma04ams.nl.ibm.com with ESMTP id 33c2a8dba4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Sep 2020 23:34:58 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 089NXMXL64225740
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 9 Sep 2020 23:33:22 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 33897A405B;
        Wed,  9 Sep 2020 23:34:55 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C7E44A4051;
        Wed,  9 Sep 2020 23:34:54 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.5.224])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  9 Sep 2020 23:34:54 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH RFC bpf-next 1/5] bpf: Make bpf_patch_insn_single() accept variable number of old insns
Date:   Thu, 10 Sep 2020 01:34:35 +0200
Message-Id: <20200909233439.3100292-2-iii@linux.ibm.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200909233439.3100292-1-iii@linux.ibm.com>
References: <20200909233439.3100292-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-09_17:2020-09-09,2020-09-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 impostorscore=0 malwarescore=0 adultscore=0 clxscore=1015
 bulkscore=0 phishscore=0 mlxlogscore=999 mlxscore=0 priorityscore=1501
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009090202
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Since this changes the function's meaning, rename it to
bpf_patch_insns(). It is still expected to only grow the function or
to preserve its size, not to shrink it.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 include/linux/filter.h |  4 ++--
 kernel/bpf/core.c      | 18 +++++++++---------
 kernel/bpf/verifier.c  |  2 +-
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index 995625950cc1..d926ab1cfada 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -892,8 +892,8 @@ static inline bool bpf_dump_raw_ok(const struct cred *cred)
 	return kallsyms_show_value(cred);
 }
 
-struct bpf_prog *bpf_patch_insn_single(struct bpf_prog *prog, u32 off,
-				       const struct bpf_insn *patch, u32 len);
+struct bpf_prog *bpf_patch_insns(struct bpf_prog *prog, u32 off, u32 len_old,
+				 const struct bpf_insn *patch, u32 len);
 int bpf_remove_insns(struct bpf_prog *prog, u32 off, u32 cnt);
 
 void bpf_clear_redirect_map(struct bpf_map *map);
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index ed0b3578867c..dde5f61f5a99 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -429,10 +429,10 @@ static void bpf_adj_linfo(struct bpf_prog *prog, u32 off, u32 delta)
 		linfo[i].insn_off += delta;
 }
 
-struct bpf_prog *bpf_patch_insn_single(struct bpf_prog *prog, u32 off,
-				       const struct bpf_insn *patch, u32 len)
+struct bpf_prog *bpf_patch_insns(struct bpf_prog *prog, u32 off, u32 len_old,
+				 const struct bpf_insn *patch, u32 len)
 {
-	u32 insn_adj_cnt, insn_rest, insn_delta = len - 1;
+	u32 insn_adj_cnt, insn_rest, insn_delta = len - len_old;
 	const u32 cnt_max = S16_MAX;
 	struct bpf_prog *prog_adj;
 	int err;
@@ -451,7 +451,7 @@ struct bpf_prog *bpf_patch_insn_single(struct bpf_prog *prog, u32 off,
 	 * we afterwards may not fail anymore.
 	 */
 	if (insn_adj_cnt > cnt_max &&
-	    (err = bpf_adj_branches(prog, off, off + 1, off + len, true)))
+	    (err = bpf_adj_branches(prog, off, off + len_old, off + len, true)))
 		return ERR_PTR(err);
 
 	/* Several new instructions need to be inserted. Make room
@@ -468,14 +468,13 @@ struct bpf_prog *bpf_patch_insn_single(struct bpf_prog *prog, u32 off,
 	/* Patching happens in 3 steps:
 	 *
 	 * 1) Move over tail of insnsi from next instruction onwards,
-	 *    so we can patch the single target insn with one or more
-	 *    new ones (patching is always from 1 to n insns, n > 0).
+	 *    so we can patch the target insns.
 	 * 2) Inject new instructions at the target location.
 	 * 3) Adjust branch offsets if necessary.
 	 */
 	insn_rest = insn_adj_cnt - off - len;
 
-	memmove(prog_adj->insnsi + off + len, prog_adj->insnsi + off + 1,
+	memmove(prog_adj->insnsi + off + len, prog_adj->insnsi + off + len_old,
 		sizeof(*patch) * insn_rest);
 	memcpy(prog_adj->insnsi + off, patch, sizeof(*patch) * len);
 
@@ -483,7 +482,8 @@ struct bpf_prog *bpf_patch_insn_single(struct bpf_prog *prog, u32 off,
 	 * the ship has sailed to reverse to the original state. An
 	 * overflow cannot happen at this point.
 	 */
-	BUG_ON(bpf_adj_branches(prog_adj, off, off + 1, off + len, false));
+	BUG_ON(bpf_adj_branches(prog_adj, off, off + len_old, off + len,
+				false));
 
 	bpf_adj_linfo(prog_adj, off, insn_delta);
 
@@ -1155,7 +1155,7 @@ struct bpf_prog *bpf_jit_blind_constants(struct bpf_prog *prog)
 		if (!rewritten)
 			continue;
 
-		tmp = bpf_patch_insn_single(clone, i, insn_buff, rewritten);
+		tmp = bpf_patch_insns(clone, i, 1, insn_buff, rewritten);
 		if (IS_ERR(tmp)) {
 			/* Patching may have repointed aux->prog during
 			 * realloc from the original one, so we need to
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 814bc6c1ad16..dd0b138ee382 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -9628,7 +9628,7 @@ static struct bpf_prog *bpf_patch_insn_data(struct bpf_verifier_env *env, u32 of
 {
 	struct bpf_prog *new_prog;
 
-	new_prog = bpf_patch_insn_single(env->prog, off, patch, len);
+	new_prog = bpf_patch_insns(env->prog, off, 1, patch, len);
 	if (IS_ERR(new_prog)) {
 		if (PTR_ERR(new_prog) == -ERANGE)
 			verbose(env,
-- 
2.25.4

