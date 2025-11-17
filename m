Return-Path: <bpf+bounces-74701-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EF5FC62988
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 07:54:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id ECC32359134
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 06:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80BBC316185;
	Mon, 17 Nov 2025 06:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Wk4j8vYu"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866CA21CA0D;
	Mon, 17 Nov 2025 06:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763362458; cv=none; b=HFLBlXsl9UvROVDl/UxdDnU3XbAhBM68apZUxLH5YH5KacSWaPbGIuevrH6/5cNej4JyYn81R34XvhqIH+2fQxJKnr4E+v+MGTRCKGgGjZHfUxUhxAU8JoD6bonDPZ4M4huAa5SmjL9+P+Pct4ENC1Kt2SR++gXc2kCQizNzlbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763362458; c=relaxed/simple;
	bh=QRVt09rz4rlrYu7L8Ufin7r+zFS1PUUtVq0Z8EVwUv0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ouneXu2siITsHngh96XIF/s9lUxBbUVLJ74K5pZD3zAVI9BMYrO7UJIQERxcElyFXSp49T5ENjBbEMPmOnsy8BJqc57T5KAX2YVzgK5KbzZv1aAWwCt+r6p0sTqE4XH7DcYN+swtHTcckHSTFVcFxqIoqD1KE0Na0rFySt8jX4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Wk4j8vYu; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AH0aQHJ028819;
	Mon, 17 Nov 2025 06:52:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=FOVCjB6bATzzeeCLzcbsx+ZH7xzceW3ZTHeiPuw8l
	AE=; b=Wk4j8vYuAk2Ns/T9AEdHrfpbXJsSTZPmJY8noMbIs0J6iAa2d3edDZjwJ
	MIgsK29cygLe/Pk0TpoN/pRd8d+fRfMeq5+TmZ708gGmA5V6wGEi//x6+LRnx9bN
	v0A8dJmtl0G5eDdWukz2+i3j6/jFrT3ec0hHbBXKxtq14b1F7/L9pfS/T2Yp6USy
	pSoYenLRy05VsJfz8JMNBpgM+ayVgVv5PRlqlV+wjrksAK+gMcc8Qzn6RjL2RuDE
	gHHKU67nV/fr6DQzPtYW42LNvZGbORyS9w6aRyl8vWPzqAkD/0F0g+Jgm4iDVPXR
	oYbO+SlGQjIBFgVfYxdSM9JPXXxhA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aejmscq5j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Nov 2025 06:52:46 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5AH6qjZt029694;
	Mon, 17 Nov 2025 06:52:45 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aejmscq5g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Nov 2025 06:52:45 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AH2WSFb022311;
	Mon, 17 Nov 2025 06:52:45 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4af4umme96-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Nov 2025 06:52:45 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5AH6qeAk48824654
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Nov 2025 06:52:40 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C4A792004E;
	Mon, 17 Nov 2025 06:52:40 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 95F4220040;
	Mon, 17 Nov 2025 06:52:36 +0000 (GMT)
Received: from li-621bac4c-27c7-11b2-a85c-c2bf7c4b3c07.in.ibm.com (unknown [9.109.219.153])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 17 Nov 2025 06:52:36 +0000 (GMT)
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
Subject: [PATCH bpf-next v2 0/2] bpf: Inline helper in powerpc JIT
Date: Mon, 17 Nov 2025 12:22:33 +0530
Message-ID: <cover.1762422548.git.skb99@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: p8CNUhvPtohm6Jwc96Z-h4yjFOC7-bBr
X-Authority-Analysis: v=2.4 cv=Rv3I7SmK c=1 sm=1 tr=0 ts=691ac63e cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=Kh3Ll-5vp6X81fc8IPUA:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: 9Vp-nMdO3UtOpSuNraCmLDhiKUMDuetx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMiBTYWx0ZWRfX/PLb6/Ja+amk
 BUq4PESu23dliovwzND6ZaBQWgEu9pykQv7QzCJQs8io8uw4BaRm/bZM7y1vCOWh/KXBctplGCU
 fa8koSL+GZsjtgrkoXPLRQ8QvObKVaPRnaconD1yPyAgxDeJvBBuu8LcBo/gOHFvTVmdDDhV8wq
 pjbjf4ku6YXYXVCP0bp2uMf/ZpZhjs4uN4/byHgXE+u4rPdVlZPMODWk7nmPlq8qyF+J3bsri88
 qcrendOYbpfeirhOJYUaCJeBgeRoaQnjrzd8DJPlM14OhED8Cj5kXdy/kw+0ecKOtRtYUe+RMcy
 r+r7c7lN8Fvb7bTc00eT/5phSsU/HaA43WSFufA1WGukQKXRBzXjWzV4ajgl5Vipa/+7/ul926R
 8m5F2oeEWG7MLdAQzkeI2ECwDckwMA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-17_02,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 clxscore=1011 phishscore=0 priorityscore=1501
 spamscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511150032

This series add support for internal only per-CPU instructions,
inlines the bpf_get_smp_processor_id() and bpf_get_current_task()
helper calls for powerpc BPF JIT.

Changes since v1:
* Addressed Christophe's comments.
* Inlined bpf_get_current_task() as well.

v1: https://lore.kernel.org/all/20250311160955.825647-1-skb99@linux.ibm.com/ 

Saket Kumar Bhaskar (2):
  powerpc64/bpf: Support internal-only MOV instruction to resolve
    per-CPU addrs
  powerpc64/bpf: Inline bpf_get_smp_processor_id() and
    bpf_get_current_task()

 arch/powerpc/net/bpf_jit_comp.c   | 16 ++++++++++++++++
 arch/powerpc/net/bpf_jit_comp64.c | 19 +++++++++++++++++++
 2 files changed, 35 insertions(+)

-- 
2.51.0


