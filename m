Return-Path: <bpf+bounces-10372-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8CE47A5F3C
	for <lists+bpf@lfdr.de>; Tue, 19 Sep 2023 12:14:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A32C6281483
	for <lists+bpf@lfdr.de>; Tue, 19 Sep 2023 10:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7676F2E659;
	Tue, 19 Sep 2023 10:14:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B8892E64C
	for <bpf@vger.kernel.org>; Tue, 19 Sep 2023 10:14:25 +0000 (UTC)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CA2311A
	for <bpf@vger.kernel.org>; Tue, 19 Sep 2023 03:13:58 -0700 (PDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38JA7XEc018614;
	Tue, 19 Sep 2023 10:13:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=0kAwOejOMqjPuzRO/6l/B15y+wc0dQuH2MACTMsOQm0=;
 b=q0cwGFEPrKg8g69bTFBKHCPJEilaGamttnRIr3QvS3cZyAo49g4MJrfwuAnX5DF/rxRY
 lsmRuMLeNRvrqX4qqEKXpwrss88b5smiACcnLLFjeAswgx6ywkxzl6wfwhpuu9pkVjKL
 xeqLUAUxOUcmgMHBqHzdp6JrMaHNo+WpJdkKtgNpwgFA4ofrkGmhTtYxxXdnfh4O323z
 8sHkEdvP48zZHvuiCHhqTIu7NQurTV9qlht1q/2f8Lpu1yr9uQHx0cTBvDQFrhXz6H73
 SLPmJjIyywJbjFQF7HXa+qk7R4FxR3BDBA5jdNcGWrXa7TkQhma2CbLyfX0E5DpDJPmA mA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t76tkcajd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Sep 2023 10:13:45 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38JA7f5P020153;
	Tue, 19 Sep 2023 10:13:45 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t76tkcahr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Sep 2023 10:13:45 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 38J9nj1a016455;
	Tue, 19 Sep 2023 10:13:44 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3t5sd1tn2e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Sep 2023 10:13:44 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 38JADfhn17171108
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Sep 2023 10:13:41 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CAA7520067;
	Tue, 19 Sep 2023 10:13:41 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3366E2004F;
	Tue, 19 Sep 2023 10:13:41 +0000 (GMT)
Received: from heavy.boeblingen.de.ibm.com (unknown [9.171.67.55])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 19 Sep 2023 10:13:41 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Puranjay Mohan <puranjay12@gmail.com>
Subject: [PATCH bpf-next v2 01/10] bpf: Disable zero-extension for BPF_MEMSX
Date: Tue, 19 Sep 2023 12:09:03 +0200
Message-ID: <20230919101336.2223655-2-iii@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230919101336.2223655-1-iii@linux.ibm.com>
References: <20230919101336.2223655-1-iii@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: mZrHaNzZ0Yc3D-MyGxhmaNzOTx86Yhld
X-Proofpoint-ORIG-GUID: jGsn8zzH2sBOJttjAwOWA7L7xgkcYanY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-19_04,2023-09-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 malwarescore=0 spamscore=0 bulkscore=0 priorityscore=1501 adultscore=0
 clxscore=1015 phishscore=0 impostorscore=0 mlxlogscore=511 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309190085
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
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

Suggested-by: Puranjay Mohan <puranjay12@gmail.com>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 kernel/bpf/verifier.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index a7178ecf676d..614bf3fa4fd5 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3114,7 +3114,7 @@ static bool is_reg64(struct bpf_verifier_env *env, struct bpf_insn *insn,
 
 	if (class == BPF_LDX) {
 		if (t != SRC_OP)
-			return BPF_SIZE(code) == BPF_DW;
+			return BPF_SIZE(code) == BPF_DW || BPF_MODE(code) == BPF_MEMSX;
 		/* LDX source must be ptr. */
 		return true;
 	}
-- 
2.41.0


