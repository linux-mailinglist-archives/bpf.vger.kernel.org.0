Return-Path: <bpf+bounces-65512-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7D57B2493C
	for <lists+bpf@lfdr.de>; Wed, 13 Aug 2025 14:10:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F78B6879CD
	for <lists+bpf@lfdr.de>; Wed, 13 Aug 2025 12:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 725AF2FF17F;
	Wed, 13 Aug 2025 12:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="UEsI9lib"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803BB2F90ED
	for <bpf@vger.kernel.org>; Wed, 13 Aug 2025 12:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755087040; cv=none; b=EPV+38QwSwATJrX69bPtxQSmpRu0qEkLQVDvvKe0w59f0LvW4WqsIfMugA0xMvEvAlPKDYXDc8UbE5WtuRz/lGQaXkKSyH7ShLDAVXrlS4/XzfxinNkI7oJkPhTS88303Ln3StgjmmH6IDFAUYmidoK8IBCuoQXJF2mjDB8pzw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755087040; c=relaxed/simple;
	bh=9A1KcanRzD7VJ7IR+wiyt2hWj1t5ZuZC5KA4sztE/4w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZeyTVWsb9V3nhTcKfrsWVRugf4/UosoXTTY5zWBPzwp2xyntVQTOgZ71GMgsSJSYn638YyW6A6H1p+qGSE75xUgHwHkjk3V7yjeIl9ibelLa5DFxtu7+SFzPjSryGfdlJMRFM6YhdCNC3xKhRmNJ0uZSHKaY3H/jpgDQHPtFnZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=UEsI9lib; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57DBmHRx029469;
	Wed, 13 Aug 2025 12:10:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=v2XNSz28VRzYZFQVB
	wa8hsrfQQfJlhQEmm0WvBScDQs=; b=UEsI9libKxygOVe4DnsWA1x2lJMQAOXmU
	9tN3GZv1IIaX06YnPHAoSaKFbSJEhGtCY2Ebm9plvYuH6pOPHa1epBgwX35dfqpa
	N+eOXFWNaGLvqZJYMaIfdnuPs2OdLrdOIFdosfVUM3MaLOI7MBt1fA7PEjIFIk3/
	uylb6Fo426ff4h7Oki/qHS9L6920TM2RmifQHndD5CagL4ENlCJr9lDzP4JYZU0G
	ZjZ1y5wUqpqgA2yvxksyCa4CZqOWgSu0u22BLpsiZmpyzohub9Qtz77l8sj5ePRU
	/KOG9iGznhKQ5STV0xloCuZizLKSreAjelU9ZKuqLbDp8dlNL2tXQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48dwudcav5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Aug 2025 12:10:25 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57D84iWT025643;
	Wed, 13 Aug 2025 12:10:24 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 48ejvmex8y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Aug 2025 12:10:24 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57DCAKQ717760662
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Aug 2025 12:10:21 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DF8982004B;
	Wed, 13 Aug 2025 12:10:20 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7537C20043;
	Wed, 13 Aug 2025 12:10:20 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.111.48.128])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 13 Aug 2025 12:10:20 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next v2 3/4] s390/bpf: Write back tail call counter for BPF_TRAMP_F_CALL_ORIG
Date: Wed, 13 Aug 2025 14:06:30 +0200
Message-ID: <20250813121016.163375-4-iii@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250813121016.163375-1-iii@linux.ibm.com>
References: <20250813121016.163375-1-iii@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEyMDIyNCBTYWx0ZWRfX3VH7/AyQWLqx
 7raRNni2tQ6qTOUpI335KFmXZ1WyPzP6b0rrQQZNZlo5r8xtbzgHLM9PxQvnhKoAwuoQAoFqZsA
 IX5EDLm3/gbseUAbTQgDE7Cyg9RtlzPzk0+uZCyP90oU00I+tWmNe5Qg7WBkim+jkm+LMS51KOK
 HobwrcJlhIAnNYVF+/h6ow4tI7L/a4py/5+JY+inj/DKvrJej1WGoeO9515NxevHwaGtMnztE4i
 Ln1yfS3gohcWOwu/rtHrGkL/g4cxHWhTasZgqqFJwgr3kqvBEWcUUkeJmBPQDzQFH4OzS1nH365
 GWPaAgQZIOTQdom5QHQcuAPiYyQMfy0l+H/aGzjGjJBMFwPBvgRZfqxl0l/cSJ5pJS/4NlM6haD
 oR9IyU6X
X-Authority-Analysis: v=2.4 cv=d/31yQjE c=1 sm=1 tr=0 ts=689c80b1 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=2OwXVqhp2XgA:10 a=VnNF1IyMAAAA:8 a=DNBvyAJy8adCTgxFzIEA:9
X-Proofpoint-GUID: vk1YbG6uWgp4hNhg2_YDGS5RRqyhTk_x
X-Proofpoint-ORIG-GUID: vk1YbG6uWgp4hNhg2_YDGS5RRqyhTk_x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_01,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 impostorscore=0 priorityscore=1501 phishscore=0
 spamscore=0 adultscore=0 bulkscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508120224

The tailcall_bpf2bpf_hierarchy_fentry test hangs on s390. Its call
graph is as follows:

  entry()
    subprog_tail()
      trampoline()
        fentry()
        the rest of subprog_tail()  # via BPF_TRAMP_F_CALL_ORIG
        return to entry()

The problem is that the rest of subprog_tail() increments the tail call
counter, but the trampoline discards the incremented value. This
results in an astronomically large number of tail calls.

Fix by making the trampoline write the incremented tail call counter
back.

Fixes: 528eb2cb87bc ("s390/bpf: Implement arch_prepare_bpf_trampoline()")
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 arch/s390/net/bpf_jit_comp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/s390/net/bpf_jit_comp.c b/arch/s390/net/bpf_jit_comp.c
index ccb83ac3e6f3..b2b8eb62b82e 100644
--- a/arch/s390/net/bpf_jit_comp.c
+++ b/arch/s390/net/bpf_jit_comp.c
@@ -2839,6 +2839,9 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
 		/* stg %r2,retval_off(%r15) */
 		EMIT6_DISP_LH(0xe3000000, 0x0024, REG_2, REG_0, REG_15,
 			      tjit->retval_off);
+		/* mvc tccnt_off(%r15),tail_call_cnt(4,%r15) */
+		_EMIT6(0xd203f000 | tjit->tccnt_off,
+		       0xf000 | offsetof(struct prog_frame, tail_call_cnt));
 
 		im->ip_after_call = jit->prg_buf + jit->prg;
 
-- 
2.50.1


