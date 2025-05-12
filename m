Return-Path: <bpf+bounces-58009-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7461AB36ED
	for <lists+bpf@lfdr.de>; Mon, 12 May 2025 14:27:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 487E3175D3D
	for <lists+bpf@lfdr.de>; Mon, 12 May 2025 12:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72557293729;
	Mon, 12 May 2025 12:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XzbhCnsM"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85FFC255E20
	for <bpf@vger.kernel.org>; Mon, 12 May 2025 12:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747052867; cv=none; b=VK5uuknN4+C2+sG687dId+1/BroN9kwnmFAME03H5NaZH9iZVis9/y024kT4okaTOhfpIIynHhcDjxvdimr9WHXGQge7zH3hNsB49eoH7E2u5vsU0FTwwoNaIV0dmnoe391pIkzSeP81N2MhIm/yilRVPkKHa1P5+E3evjtDo5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747052867; c=relaxed/simple;
	bh=/QAzt2u77te4mGvjLwm6bOXu6tnVaa9EjPKmizs+Cro=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n2jAJUrkoQH9nWdx2BtRz+7mirP5QphUTfebgr9+Yhwe/kIKlNdU842GuW+pP994TqPElhQk4ryqQLNoe6FDFDG/WLVH7agm+ohFD5vWVvE0LRKOC/v9pyiBIiMWeKmjSbniA5MA6LzPnYzhn54VCmd8wUnfb3FxYrY5yVccTkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=XzbhCnsM; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54C8pQFH007016;
	Mon, 12 May 2025 12:27:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=LN399QAqEqBAeAgjzQhRlkkRCv1bGy8TJTHLEVK+P
	QQ=; b=XzbhCnsMt7pdtuYngDTQx9Vy512wWoXfxh0yzbbqXo/HjoaM7jR0fKMYO
	0OhTFj8XfHxgRsE62IJhcarQltkLHtMRRCe0j2Zyg64MOmrgDyyyqdCiPb3z4C9E
	Sdnv0y2pVkWS0ja1T6ulN7/8ODW05AOOPPqEkHkGnX0kFpbggGR3QoUJlaNRybI4
	5nLoFdCqIW9WsFH6fPIW8B6itWCtWzArIKiNeFbG0YIpcKk6ZPj+F05zKNMmcGlv
	bkM8zwTSCRZjUBi67ZnV5a38pT86jaXMwIRC9fe9iWr9NdJbvKDQ96jX3zePmR6G
	3VwVl8b4Md9opjM4IjYNY/iXo6umw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46kdug8vm3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 May 2025 12:27:31 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54C9jf8D025907;
	Mon, 12 May 2025 12:27:30 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46jj4nnvus-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 May 2025 12:27:30 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 54CCRQcs53215530
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 May 2025 12:27:26 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8281520076;
	Mon, 12 May 2025 12:27:19 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 164AB20073;
	Mon, 12 May 2025 12:27:19 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.87.156.229])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 12 May 2025 12:27:19 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next] s390/bpf: Store backchain even for leaf progs
Date: Mon, 12 May 2025 14:26:15 +0200
Message-ID: <20250512122717.54878-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=OOUn3TaB c=1 sm=1 tr=0 ts=6821e933 cx=c_pps a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=ns3oJ60yhNq-Kd0gdBwA:9
X-Proofpoint-ORIG-GUID: V8T-lSPNrVX_a6R4ILmt2eA4qYNwhmV5
X-Proofpoint-GUID: V8T-lSPNrVX_a6R4ILmt2eA4qYNwhmV5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEyMDEyNyBTYWx0ZWRfXwJ8yADo0cAI/ p7WN2m3w0vwYubvCJ3U+iY9ByieJKc4hwEjqTC4isXJmtICMLz53n8jm4wm4mck+awqhedEy1LW fm6RMHvCfBp3GOAN8cKCTRsqbqHtN3ML5jH3U+0UzNHqueR6ouaURkHAHrImMUMTutN3MErph39
 kvOWK06cFZjNV4ysvckBZvOD6AVbhg27gbWyzxw3z+3KXIaQmDsuat6oOJ51LqVcoiBQi0fssib jzAhT6saWdaThxNnzHrQeDzghl9ia+GgjoBbm5Qa+lV683JHkKvsnSLrOwo/jeGNaa9WdvDjicy 3JJqDZGoTT79K2/qdkEPJLNdw7BI+rIPVgwGiPdT4SmK3HGRzQt5J0Si4K2Bl3CWL6ZISbcEfXm
 ka02d5Z0nlOqe7q4l3+Ga+bx4pZ7nPMq7fqSK+qwm3kTf5bJVSBTW7lr5rEJmSLAmYtvU7jw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-12_04,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0
 clxscore=1015 bulkscore=0 malwarescore=0 adultscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505120127

Currently a crash in a leaf prog (caused by a bug) produces the
following call trace:

     [<000003ff600ebf00>] bpf_prog_6df0139e1fbf2789_fentry+0x20/0x78
     [<0000000000000000>] 0x0

This is because leaf progs do not store backchain. Fix by making all
progs do it. This is what GCC and Clang-generated code does as well.
Now the call trace looks like this:

     [<000003ff600eb0f2>] bpf_prog_6df0139e1fbf2789_fentry+0x2a/0x80
     [<000003ff600ed096>] bpf_trampoline_201863462940+0x96/0xf4
     [<000003ff600e3a40>] bpf_prog_05f379658fdd72f2_classifier_0+0x58/0xc0
     [<000003ffe0aef070>] bpf_test_run+0x210/0x390
     [<000003ffe0af0dc2>] bpf_prog_test_run_skb+0x25a/0x668
     [<000003ffe038a90e>] __sys_bpf+0xa46/0xdb0
     [<000003ffe038ad0c>] __s390x_sys_bpf+0x44/0x50
     [<000003ffe0defea8>] __do_syscall+0x150/0x280
     [<000003ffe0e01d5c>] system_call+0x74/0x98

Fixes: 054623105728 ("s390/bpf: Add s390x eBPF JIT compiler backend")
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 arch/s390/net/bpf_jit_comp.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/arch/s390/net/bpf_jit_comp.c b/arch/s390/net/bpf_jit_comp.c
index 0776dfde2dba..945106b5562d 100644
--- a/arch/s390/net/bpf_jit_comp.c
+++ b/arch/s390/net/bpf_jit_comp.c
@@ -605,17 +605,15 @@ static void bpf_jit_prologue(struct bpf_jit *jit, struct bpf_prog *fp,
 	}
 	/* Setup stack and backchain */
 	if (is_first_pass(jit) || (jit->seen & SEEN_STACK)) {
-		if (is_first_pass(jit) || (jit->seen & SEEN_FUNC))
-			/* lgr %w1,%r15 (backchain) */
-			EMIT4(0xb9040000, REG_W1, REG_15);
+		/* lgr %w1,%r15 (backchain) */
+		EMIT4(0xb9040000, REG_W1, REG_15);
 		/* la %bfp,STK_160_UNUSED(%r15) (BPF frame pointer) */
 		EMIT4_DISP(0x41000000, BPF_REG_FP, REG_15, STK_160_UNUSED);
 		/* aghi %r15,-STK_OFF */
 		EMIT4_IMM(0xa70b0000, REG_15, -(STK_OFF + stack_depth));
-		if (is_first_pass(jit) || (jit->seen & SEEN_FUNC))
-			/* stg %w1,152(%r15) (backchain) */
-			EMIT6_DISP_LH(0xe3000000, 0x0024, REG_W1, REG_0,
-				      REG_15, 152);
+		/* stg %w1,152(%r15) (backchain) */
+		EMIT6_DISP_LH(0xe3000000, 0x0024, REG_W1, REG_0,
+			      REG_15, 152);
 	}
 }
 
-- 
2.49.0


