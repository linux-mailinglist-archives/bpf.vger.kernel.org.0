Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EBD367BECD
	for <lists+bpf@lfdr.de>; Wed, 25 Jan 2023 22:40:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235764AbjAYVkE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 25 Jan 2023 16:40:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236864AbjAYVj5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 25 Jan 2023 16:39:57 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 354BE1F932
        for <bpf@vger.kernel.org>; Wed, 25 Jan 2023 13:39:54 -0800 (PST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30PKLext012818;
        Wed, 25 Jan 2023 21:39:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=1uouxkzrS50D4rHklG11TaSvmLfVym+jKYuljlX5V8A=;
 b=tjJoMLtCIph4J5b0GtjDXKVPI5YTGDw/boM73gHoZYwOsPORJF3lR3wyFvBLQD4T/Wch
 Tx8fl9H0husIE00UXoixD8996V+7f60wrGTnNU0nHQZb6ABPVGi/D6zsFImeRaWNGECN
 QBrYAWqX0hlKnyUUOMyrycVOMNUOu9x5v9dedaUPDJq7DDMJonPH71T2f9wa9aEtwxPy
 jlCLm2M1Ld2PqCD+jIWE9/DJQb6kzApM0VnrODS7m8nitHf2RtagqxA0fa097uSMTa5H
 snIH3AbadpLZFLssabYS6iUutXn19VtJHwVnQP6KKcffKnP4vXbaS7jDv5C6gb2ecp/L Zg== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nac21atbt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Jan 2023 21:39:41 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30PEqP9T028677;
        Wed, 25 Jan 2023 21:39:39 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3n87afdkxa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Jan 2023 21:39:38 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30PLdZYZ46793036
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Jan 2023 21:39:35 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5B48C20043;
        Wed, 25 Jan 2023 21:39:35 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2798C20040;
        Wed, 25 Jan 2023 21:39:35 +0000 (GMT)
Received: from heavy.boeblingen.de.ibm.com (unknown [9.155.209.149])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 25 Jan 2023 21:39:35 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next 24/24] s390/bpf: Implement bpf_jit_supports_kfunc_call()
Date:   Wed, 25 Jan 2023 22:38:17 +0100
Message-Id: <20230125213817.1424447-25-iii@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230125213817.1424447-1-iii@linux.ibm.com>
References: <20230125213817.1424447-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: qHUvQAoawG9r_h2XDfgZRCHg2a05-vva
X-Proofpoint-ORIG-GUID: qHUvQAoawG9r_h2XDfgZRCHg2a05-vva
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-25_13,2023-01-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 priorityscore=1501 spamscore=0 clxscore=1015
 impostorscore=0 mlxlogscore=999 lowpriorityscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301250193
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Implement calling kernel functions from eBPF. In general, the eBPF ABI
is fairly close to that of s390x, with one important difference: on
s390x callers should sign-extend signed arguments. Handle that by using
information returned by bpf_jit_find_kfunc_model().

At the moment bpf_jit_find_kfunc_model() does not seem to play nicely
with XDP metadata functions: add_kfunc_call() adds an "abstract" bpf_*()
version to kfunc_btf_tab, but then fixup_kfunc_call() puts the concrete
version into insn->imm, which bpf_jit_find_kfunc_model() cannot find.
But this seems to be a common code problem.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 arch/s390/net/bpf_jit_comp.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/arch/s390/net/bpf_jit_comp.c b/arch/s390/net/bpf_jit_comp.c
index f4cdecb32629..74b38e817bd8 100644
--- a/arch/s390/net/bpf_jit_comp.c
+++ b/arch/s390/net/bpf_jit_comp.c
@@ -1401,9 +1401,10 @@ static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp,
 	 */
 	case BPF_JMP | BPF_CALL:
 	{
-		u64 func;
+		const struct btf_func_model *m;
 		bool func_addr_fixed;
-		int ret;
+		int j, ret;
+		u64 func;
 
 		ret = bpf_jit_get_func_addr(fp, insn, extra_pass,
 					    &func, &func_addr_fixed);
@@ -1425,6 +1426,21 @@ static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp,
 		/* mvc STK_OFF_TCCNT(4,%r15),N(%r15) */
 		_EMIT6(0xd203f000 | STK_OFF_TCCNT,
 		       0xf000 | (STK_OFF_TCCNT + STK_OFF + stack_depth));
+
+		/* Sign-extend the kfunc arguments. */
+		if (insn->src_reg == BPF_PSEUDO_KFUNC_CALL) {
+			m = bpf_jit_find_kfunc_model(fp, insn);
+			if (!m)
+				return -1;
+
+			for (j = 0; j < m->nr_args; j++) {
+				if (sign_extend(jit, BPF_REG_1 + j,
+						m->arg_size[j],
+						m->arg_flags[j]))
+					return -1;
+			}
+		}
+
 		/* lgrl %w1,func */
 		EMIT6_PCREL_RILB(0xc4080000, REG_W1, _EMIT_CONST_U64(func));
 		/* %r1() */
@@ -1980,6 +1996,11 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
 	return fp;
 }
 
+bool bpf_jit_supports_kfunc_call(void)
+{
+	return true;
+}
+
 int bpf_arch_text_poke(void *ip, enum bpf_text_poke_type t,
 		       void *old_addr, void *new_addr)
 {
-- 
2.39.1

