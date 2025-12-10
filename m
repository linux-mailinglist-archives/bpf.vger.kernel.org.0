Return-Path: <bpf+bounces-76394-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 921CECB21F7
	for <lists+bpf@lfdr.de>; Wed, 10 Dec 2025 07:54:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 852ED312BA86
	for <lists+bpf@lfdr.de>; Wed, 10 Dec 2025 06:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC7D1285074;
	Wed, 10 Dec 2025 06:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WxZr+p1V"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F191F3BA4;
	Wed, 10 Dec 2025 06:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765349551; cv=none; b=hvQB0arMgQLVI2iZNuTIOOgFnDZch/DnYBtzogjyOvnaTzhGlK0ttmJR6gWZv7oUuwN6LZT0MIA4FTftt5dEoMmQEdwexSTaJp5YSOvL5Ri4Zu+E3zmOTTu5XOpB6dKfzhLPFCXk/Oox0G03Az78JECRWBbJXzYh3s6UUL5Vwh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765349551; c=relaxed/simple;
	bh=URCLm0Dcbn0di0un2C8AC4lqAk1vMa6lISOsQawZYOI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Gs4RgroxFl8r8kFAN0q9zXLN1KOrt8uqzcIDqScy1uppNlwPYMI3odUJ7Tl/votYYnm/1DWMTROl6FLbPQszzAOSdOYeQ0eHM++ppYyJwO2nrYrWV9qMaF+fZYuK9HtGxfGbopOTjvGKwPOQPG8uxQPkkwN8qsKz4dtoFVh6V38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WxZr+p1V; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BA1pZgD012377;
	Wed, 10 Dec 2025 06:50:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=S+ItbLvvPfQQUbnRlJuvKz/ZBJgs
	5LRyq+OLdmyi2/4=; b=WxZr+p1Vys0ZwrPwADkL/6yy6FfAC0IL0/3nIwzxoZ29
	Jyti5pEq2Ki3YncZmYvOLNYyP4cJf2bdJEDWS5rvVls43xpxotxUCh98AbZdXHsp
	xwudypDXBQQ4sj4j6Tu7fQiVQtvTlH318jcclbG8y63ZMoqpr3HsRG6v3b7ipAC4
	8z3hkZGHpBMGxCwkEMMTwqaiiTNqtrf8Aow8NTEuQ5FLcqZmSuH0wQbiwcY+/Pr6
	b5r/Rul/t0UtnMm6RgYpbtRA7maR6FZSLa4ZFxLYo0FBgDJZ1m0ARdRBbloo+xyW
	qPfUvaOA0oiBnaBW4eL/RhGj+IoN4OqgUdelSGkTdg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4avc7c0yjy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Dec 2025 06:50:44 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5BA6dgMQ023884;
	Wed, 10 Dec 2025 06:50:43 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4avc7c0yjw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Dec 2025 06:50:43 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5BA4NAXU030242;
	Wed, 10 Dec 2025 06:50:42 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4avxts7d3u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Dec 2025 06:50:42 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5BA6ocni60096910
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Dec 2025 06:50:38 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 47E7220040;
	Wed, 10 Dec 2025 06:50:38 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1B54820043;
	Wed, 10 Dec 2025 06:50:34 +0000 (GMT)
Received: from li-621bac4c-27c7-11b2-a85c-c2bf7c4b3c07.ibm.com.com (unknown [9.43.106.237])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 10 Dec 2025 06:50:33 +0000 (GMT)
From: Saket Kumar Bhaskar <skb99@linux.ibm.com>
To: bpf@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Cc: hbathini@linux.ibm.com, sachinpb@linux.ibm.com, venkat88@linux.ibm.com,
        andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org,
        daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
        yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
        christophe.leroy@csgroup.eu, naveen@kernel.org, maddy@linux.ibm.com,
        mpe@ellerman.id.au, npiggin@gmail.com
Subject: [PATCH bpf-next v4 0/2] powerpc64/bpf: Inline helper in powerpc JIT
Date: Wed, 10 Dec 2025 12:20:31 +0530
Message-ID: <cover.1765343385.git.skb99@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 1qCyGFVynq_hUNIekmwnV8hHajS1GjNv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA2MDAyMCBTYWx0ZWRfX22EB5WBWAtxZ
 tjBDn/VvZjwbAUSUkYOmQ0lX/1R3MccciM4ebvb+9BxCXxRcN18c2iNfIhE5+kzP7FfBsTkrok4
 35jsNWBHHqxo4DJaz2OBq6bozEsfof7idjP+mvuBuW2EU6cGE4VZfMmhoWTAxoJbRo9x7Hqps91
 VfQgQxwGoS8ufwJIP49J5ewhf4chWKlXC++AOEcIsGU2C43HtuvZg23anLYPNg3LDqw9KbsYEoW
 w0uwpxXf4gJXqzUG7kEkrDyTBjazFO7v2QPHaX/vbJyIGp7a7MbogX7LUo3BZcfGHBY6qKxVPE/
 JWhtyf0ML+Xf9IPNAf24Xo2jnqvVeXqmHoxL0e9A+b8xYyDg7t1PZmW8ST/7G2KlQKZ+Zbnvvq0
 PIAG5vwI59t8Cd28+WVdssk2l1wiew==
X-Proofpoint-GUID: W0YHzG-o49s83kLEeCFGcftgfZVU0pyG
X-Authority-Analysis: v=2.4 cv=FpwIPmrq c=1 sm=1 tr=0 ts=69391844 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=xaTGKGj_L-QPSGpYTFkA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-09_05,2025-12-09_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 malwarescore=0 phishscore=0 clxscore=1015 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2512060020

This series add support for internal only per-CPU instructions,
inlines the bpf_get_smp_processor_id() and bpf_get_current_task()
helper calls for powerpc BPF JIT.

Changes since v3:
* Added break after computing per cpu address so that the computed 
  address is not overwritten by src_reg as suggested by AI bot.

v3: https://lore.kernel.org/all/cover.1764930425.git.skb99@linux.ibm.com/

Changes since v2:
* Collected Reviewed-by tag.
* Inlined bpf_get_current_task/btf().
* Fixed addressing of src_reg and BPF_REG_0. (Christophe) 
* Fixed condition for non smp case as suggested by Christophe.

v2: https://lore.kernel.org/all/cover.1762422548.git.skb99@linux.ibm.com/

Changes since v1:
* Addressed Christophe's comments.
* Inlined bpf_get_current_task() as well.

v1: https://lore.kernel.org/all/20250311160955.825647-1-skb99@linux.ibm.com/ 

Saket Kumar Bhaskar (2):
  powerpc64/bpf: Support internal-only MOV instruction to resolve
    per-CPU addrs
  powerpc64/bpf: Inline bpf_get_smp_processor_id() and
    bpf_get_current_task/_btf()

 arch/powerpc/net/bpf_jit_comp.c   | 17 +++++++++++++++++
 arch/powerpc/net/bpf_jit_comp64.c | 21 +++++++++++++++++++++
 2 files changed, 38 insertions(+)

-- 
2.51.0


