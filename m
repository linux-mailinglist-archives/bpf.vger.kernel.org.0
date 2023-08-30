Return-Path: <bpf+bounces-8945-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97EA678D191
	for <lists+bpf@lfdr.de>; Wed, 30 Aug 2023 03:12:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6AC71C20A8B
	for <lists+bpf@lfdr.de>; Wed, 30 Aug 2023 01:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6B78EDD;
	Wed, 30 Aug 2023 01:11:59 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79AB8EBB
	for <bpf@vger.kernel.org>; Wed, 30 Aug 2023 01:11:59 +0000 (UTC)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5E9383
	for <bpf@vger.kernel.org>; Tue, 29 Aug 2023 18:11:57 -0700 (PDT)
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37U0a1DW028967;
	Wed, 30 Aug 2023 01:11:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=TWlgmCpbLxSr3BwPkZDytI9uGWT66jwMXnpOYQ9zCrk=;
 b=HC3+nsgVBktyw1b1opMABiCTTsn1Lc0pESqyevhHTqb1oV9QuN14reBlGfZHFfn6sdI/
 5s0UW1iqznnPYwRgY7OwZ6z8pcIFLTGnfWvLT7YCDrOTjWVFiSY/681CO+jgx/EH3NR1
 M+/RMiiHUOkxtHCcSjmXXXdBRNMafmeRFDu5Sa+7GV519G17/JtaAIxG24sNSRzD1YY0
 pAuUZXPGjjlSxuT5ywSlE9FXg7GxJ9ZNTJuH25YtaCwEtvqBv1qDjw1Ab/49DosBh6Hj
 sboZDkzOIUOjusbMi8rsr2M9rVo2Ay1pPH/2IhRXy6dk+plPhrcQoHDPGb7uynIAvD7q HQ== 
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ssu57rw5p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Aug 2023 01:11:44 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 37U0PBBt014345;
	Wed, 30 Aug 2023 01:11:43 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3sqvqn80tr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Aug 2023 01:11:43 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 37U1Be9821299724
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Aug 2023 01:11:40 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BB54120040;
	Wed, 30 Aug 2023 01:11:40 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 48AA42004B;
	Wed, 30 Aug 2023 01:11:40 +0000 (GMT)
Received: from heavy.boeblingen.de.ibm.com (unknown [9.171.5.44])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 30 Aug 2023 01:11:40 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next 01/11] bpf: Disable zero-extension for BPF_MEMSX
Date: Wed, 30 Aug 2023 03:07:42 +0200
Message-ID: <20230830011128.1415752-2-iii@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230830011128.1415752-1-iii@linux.ibm.com>
References: <20230830011128.1415752-1-iii@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 9fGc_BO-ShR21dhwdESM6CWzjughN3af
X-Proofpoint-ORIG-GUID: 9fGc_BO-ShR21dhwdESM6CWzjughN3af
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-29_16,2023-08-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 adultscore=0 malwarescore=0 spamscore=0 mlxlogscore=477 bulkscore=0
 lowpriorityscore=0 clxscore=1015 suspectscore=0 impostorscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308300008
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On the architectures that use bpf_jit_needs_zext(), e.g., s390x, the
verifier incorrectly inserts a zero-extension after BPF_MEMSX, leading
to miscompilations like the one below:

      24:       89 1a ff fe 00 00 00 00 "r1 = *(s16 *)(r10 - 2);"       # zext_dst set
   0x3ff7fdb910e:       lgh     %r2,-2(%r13,%r0)                        # load halfword
   0x3ff7fdb9114:       llgfr   %r2,%r2                                 # wrong!
      25:       65 10 00 03 00 00 7f ff if r1 s> 32767 goto +3 <l0_1>   # check_cond_jmp_op()

Disable such zero-extensions. The JITs need to insert sign-extension
themselves, if necessary.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 kernel/bpf/verifier.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index bb78212fa5b2..097985a46edc 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3110,7 +3110,9 @@ static void mark_insn_zext(struct bpf_verifier_env *env,
 {
 	s32 def_idx = reg->subreg_def;
 
-	if (def_idx == DEF_NOT_SUBREG)
+	if (def_idx == DEF_NOT_SUBREG ||
+	    (BPF_CLASS(env->prog->insnsi[def_idx - 1].code) == BPF_LDX &&
+	     BPF_MODE(env->prog->insnsi[def_idx - 1].code) == BPF_MEMSX))
 		return;
 
 	env->insn_aux_data[def_idx - 1].zext_dst = true;
-- 
2.41.0


