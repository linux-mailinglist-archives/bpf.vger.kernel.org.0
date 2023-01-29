Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A243680117
	for <lists+bpf@lfdr.de>; Sun, 29 Jan 2023 20:05:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235114AbjA2TFc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 29 Jan 2023 14:05:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbjA2TFb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 29 Jan 2023 14:05:31 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DEED76B2
        for <bpf@vger.kernel.org>; Sun, 29 Jan 2023 11:05:30 -0800 (PST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30TDL1xV004392;
        Sun, 29 Jan 2023 19:05:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=Ek4/IGZiWm5oQVUeYiD5UlAicrnJMSF15nHo+Xh0oOg=;
 b=R9Mrg1V+mj3Jq6xKUWfqRw6Up/CoJ0r9T/YvTgmFlBYpaSUBvM7/lbi0dMHKa0tXzezH
 +3rp6yyLYbvnIJfeflYT2iTRXIXnhajp0KmJLxY8Bl2Af7yjtRDlSncZEvAFKoWY+k4y
 zn14BJL//KBbeJ0ngS8IsZjdZm83xNk4ewGXLZ8cdyjpzWv8+ctMBlQ/3C48WQUlrZ2m
 +eIoCniZHkhTK6xwnLqJONOEEuY2oV1W/aGo74s9BPAMCI+TmopqCfIzNuVbUQbh8bEM
 ZfKiS2W+1PUzcDlNxOklSAOui2Nn45sb2v1hFBpkM8QqyKhiFiVKUoiFNmCMGl5Q9VYL oA== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nddfc5eg1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 29 Jan 2023 19:05:16 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30T4vhG1026871;
        Sun, 29 Jan 2023 19:05:14 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3ncvs7hd4d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 29 Jan 2023 19:05:14 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30TJ5Alb48628052
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 29 Jan 2023 19:05:10 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C051F2004B;
        Sun, 29 Jan 2023 19:05:10 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 36F8220040;
        Sun, 29 Jan 2023 19:05:10 +0000 (GMT)
Received: from heavy.ibmuc.com (unknown [9.179.11.57])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Sun, 29 Jan 2023 19:05:10 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next v3 6/8] s390/bpf: Implement bpf_jit_supports_kfunc_call()
Date:   Sun, 29 Jan 2023 20:04:59 +0100
Message-Id: <20230129190501.1624747-7-iii@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230129190501.1624747-1-iii@linux.ibm.com>
References: <20230129190501.1624747-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: STJBjH4hsX0OMuMm20UYEZDkkmr-RO2d
X-Proofpoint-GUID: STJBjH4hsX0OMuMm20UYEZDkkmr-RO2d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-29_10,2023-01-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 priorityscore=1501 adultscore=0 bulkscore=0 mlxscore=0 lowpriorityscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301290189
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

Here is an example of how sign extensions works. Suppose we need to
call the following function from BPF:

    ; long noinline bpf_kfunc_call_test4(signed char a, short b, int c,
long d)
    0000000000936a78 <bpf_kfunc_call_test4>:
    936a78:       c0 04 00 00 00 00       jgnop bpf_kfunc_call_test4
    ;     return (long)a + (long)b + (long)c + d;
    936a7e:       b9 08 00 45             agr     %r4,%r5
    936a82:       b9 08 00 43             agr     %r4,%r3
    936a86:       b9 08 00 24             agr     %r2,%r4
    936a8a:       c0 f4 00 1e 3b 27       jg      <__s390_indirect_jump_r14>

As per the s390x ABI, bpf_kfunc_call_test4() has the right to assume
that a, b and c are sign-extended by the caller, which results in using
64-bit additions (agr) without any additional conversions. Without sign
extension we would have the following on the JITed code side:

    ; tmp = bpf_kfunc_call_test4(-3, -30, -200, -1000);
    ;        5:       b4 10 00 00 ff ff ff fd w1 = -3
    0x3ff7fdcdad4:       llilf   %r2,0xfffffffd
    ;        6:       b4 20 00 00 ff ff ff e2 w2 = -30
    0x3ff7fdcdada:       llilf   %r3,0xffffffe2
    ;        7:       b4 30 00 00 ff ff ff 38 w3 = -200
    0x3ff7fdcdae0:       llilf   %r4,0xffffff38
    ;       8:       b7 40 00 00 ff ff fc 18 r4 = -1000
    0x3ff7fdcdae6:       lgfi    %r5,-1000
    0x3ff7fdcdaec:       mvc     64(4,%r15),160(%r15)
    0x3ff7fdcdaf2:       lgrl    %r1,bpf_kfunc_call_test4@GOT
    0x3ff7fdcdaf8:       brasl   %r14,__s390_indirect_jump_r1

This first 3 llilfs are 32-bit loads, that need to be sign-extended
to 64 bits.

Note: at the moment bpf_jit_find_kfunc_model() does not seem to play
nicely with XDP metadata functions: add_kfunc_call() adds an "abstract"
bpf_*() version to kfunc_btf_tab, but then fixup_kfunc_call() puts the
concrete version into insn->imm, which bpf_jit_find_kfunc_model() cannot
find. But this seems to be a common code problem.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 arch/s390/net/bpf_jit_comp.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/arch/s390/net/bpf_jit_comp.c b/arch/s390/net/bpf_jit_comp.c
index b84c7ddb758a..d0846ba818ee 100644
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

