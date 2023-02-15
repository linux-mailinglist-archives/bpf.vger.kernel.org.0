Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EECAC6988F8
	for <lists+bpf@lfdr.de>; Thu, 16 Feb 2023 01:00:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbjBOX76 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Feb 2023 18:59:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjBOX75 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 15 Feb 2023 18:59:57 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 109EE2367F
        for <bpf@vger.kernel.org>; Wed, 15 Feb 2023 15:59:56 -0800 (PST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31FLg1nN008732;
        Wed, 15 Feb 2023 23:59:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=Qvc5ozM8xfc7Ya/Av7zWfDzNpbUAaG22bSROTRmmpsI=;
 b=chljCmZIEIzqRtsIaaWHjpSngkCy4kUofTgYXR5OmQeXN7ShLv3L2EKGsh9VrHG0buwe
 TOHKNS0YPJBeBwH95y8CpI5LB9DpIpgHmEX+d0t/yI5paB6ac9q+npy1IGemmVXGflu9
 BRYUnlc+aVimLLEGseQKD6tkJZZTnhQoPFtLTnfb2vaWAHnay/V0oVE6StO2wiXhv3AA
 8kCYCEJPA4lAAlZKejT8YQ2b6bXA5ENquV6eRj5PGPdNWeo8LDfkHtfPWlWEP19M5BXC
 qIS3a2CNvK+pxWDr3rMTuOLIcuhPzAZWRWsQDt4HaFHSueyBqzQfGq/leT+uEgyCOSeA fg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ns7hjaeny-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Feb 2023 23:59:42 +0000
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 31FNva8F011830;
        Wed, 15 Feb 2023 23:59:42 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ns7hjaene-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Feb 2023 23:59:42 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31FC7bbo010915;
        Wed, 15 Feb 2023 23:59:39 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3np2n6wypj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Feb 2023 23:59:39 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31FNxaN122151756
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Feb 2023 23:59:36 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2648520040;
        Wed, 15 Feb 2023 23:59:36 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7DC632004B;
        Wed, 15 Feb 2023 23:59:35 +0000 (GMT)
Received: from heavy.boeblingen.de.ibm.com (unknown [9.179.4.133])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 15 Feb 2023 23:59:35 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH RFC bpf-next v2 1/4] bpf: Introduce BPF_HELPER_CALL
Date:   Thu, 16 Feb 2023 00:59:28 +0100
Message-Id: <20230215235931.380197-2-iii@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230215235931.380197-1-iii@linux.ibm.com>
References: <20230215235931.380197-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: VmBEpwveHbCAFOIB6jxuKVkyvMdgXWVU
X-Proofpoint-GUID: 52utQUk9D1nT88fEmtq8mMTQ0TLdCLKc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-15_14,2023-02-15_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 mlxscore=0 mlxlogscore=999 priorityscore=1501
 phishscore=0 malwarescore=0 suspectscore=0 adultscore=0 clxscore=1015
 spamscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302150200
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Make the code more readable by introducing a symbolic constant
instead of using 0.

Suggested-by: Stanislav Fomichev <sdf@google.com>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 include/uapi/linux/bpf.h       |  4 ++++
 kernel/bpf/disasm.c            |  2 +-
 kernel/bpf/verifier.c          | 12 +++++++-----
 tools/include/linux/filter.h   |  2 +-
 tools/include/uapi/linux/bpf.h |  4 ++++
 5 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 1503f61336b6..37f7588d5b2f 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1211,6 +1211,10 @@ enum bpf_link_type {
  */
 #define BPF_PSEUDO_FUNC		4
 
+/* when bpf_call->src_reg == BPF_HELPER_CALL, bpf_call->imm == index of a bpf
+ * helper function (see ___BPF_FUNC_MAPPER below for a full list)
+ */
+#define BPF_HELPER_CALL		0
 /* when bpf_call->src_reg == BPF_PSEUDO_CALL, bpf_call->imm == pc-relative
  * offset to another bpf function
  */
diff --git a/kernel/bpf/disasm.c b/kernel/bpf/disasm.c
index 7b4afb7d96db..c11d9b5a45a9 100644
--- a/kernel/bpf/disasm.c
+++ b/kernel/bpf/disasm.c
@@ -19,7 +19,7 @@ static const char *__func_get_name(const struct bpf_insn_cbs *cbs,
 {
 	BUILD_BUG_ON(ARRAY_SIZE(func_id_str) != __BPF_FUNC_MAX_ID);
 
-	if (!insn->src_reg &&
+	if (insn->src_reg == BPF_HELPER_CALL &&
 	    insn->imm >= 0 && insn->imm < __BPF_FUNC_MAX_ID &&
 	    func_id_str[insn->imm])
 		return func_id_str[insn->imm];
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 272563a0b770..427525fc3791 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2947,7 +2947,8 @@ static int backtrack_insn(struct bpf_verifier_env *env, int idx,
 			/* BPF helpers that invoke callback subprogs are
 			 * equivalent to BPF_PSEUDO_CALL above
 			 */
-			if (insn->src_reg == 0 && is_callback_calling_function(insn->imm))
+			if (insn->src_reg == BPF_HELPER_CALL &&
+			    is_callback_calling_function(insn->imm))
 				return -ENOTSUPP;
 			/* kfunc with imm==0 is invalid and fixup_kfunc_call will
 			 * catch this error later. Make backtracking conservative
@@ -7522,7 +7523,7 @@ static int __check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 	}
 
 	if (insn->code == (BPF_JMP | BPF_CALL) &&
-	    insn->src_reg == 0 &&
+	    insn->src_reg == BPF_HELPER_CALL &&
 	    insn->imm == BPF_FUNC_timer_set_callback) {
 		struct bpf_verifier_state *async_cb;
 
@@ -14730,7 +14731,7 @@ static int do_check(struct bpf_verifier_env *env)
 				if (BPF_SRC(insn->code) != BPF_K ||
 				    (insn->src_reg != BPF_PSEUDO_KFUNC_CALL
 				     && insn->off != 0) ||
-				    (insn->src_reg != BPF_REG_0 &&
+				    (insn->src_reg != BPF_HELPER_CALL &&
 				     insn->src_reg != BPF_PSEUDO_CALL &&
 				     insn->src_reg != BPF_PSEUDO_KFUNC_CALL) ||
 				    insn->dst_reg != BPF_REG_0 ||
@@ -14740,7 +14741,8 @@ static int do_check(struct bpf_verifier_env *env)
 				}
 
 				if (env->cur_state->active_lock.ptr) {
-					if ((insn->src_reg == BPF_REG_0 && insn->imm != BPF_FUNC_spin_unlock) ||
+					if ((insn->src_reg == BPF_HELPER_CALL &&
+					     insn->imm != BPF_FUNC_spin_unlock) ||
 					    (insn->src_reg == BPF_PSEUDO_CALL) ||
 					    (insn->src_reg == BPF_PSEUDO_KFUNC_CALL &&
 					     (insn->off != 0 || !is_bpf_graph_api_kfunc(insn->imm)))) {
@@ -16933,7 +16935,7 @@ static struct bpf_prog *inline_bpf_loop(struct bpf_verifier_env *env,
 static bool is_bpf_loop_call(struct bpf_insn *insn)
 {
 	return insn->code == (BPF_JMP | BPF_CALL) &&
-		insn->src_reg == 0 &&
+		insn->src_reg == BPF_HELPER_CALL &&
 		insn->imm == BPF_FUNC_loop;
 }
 
diff --git a/tools/include/linux/filter.h b/tools/include/linux/filter.h
index 736bdeccdfe4..78dc208c8d88 100644
--- a/tools/include/linux/filter.h
+++ b/tools/include/linux/filter.h
@@ -261,7 +261,7 @@
 	((struct bpf_insn) {					\
 		.code  = BPF_JMP | BPF_CALL,			\
 		.dst_reg = 0,					\
-		.src_reg = 0,					\
+		.src_reg = BPF_HELPER_CALL,			\
 		.off   = 0,					\
 		.imm   = ((FUNC) - BPF_FUNC_unspec) })
 
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 1503f61336b6..37f7588d5b2f 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1211,6 +1211,10 @@ enum bpf_link_type {
  */
 #define BPF_PSEUDO_FUNC		4
 
+/* when bpf_call->src_reg == BPF_HELPER_CALL, bpf_call->imm == index of a bpf
+ * helper function (see ___BPF_FUNC_MAPPER below for a full list)
+ */
+#define BPF_HELPER_CALL		0
 /* when bpf_call->src_reg == BPF_PSEUDO_CALL, bpf_call->imm == pc-relative
  * offset to another bpf function
  */
-- 
2.39.1

