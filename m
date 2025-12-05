Return-Path: <bpf+bounces-76107-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 57019CA7CE6
	for <lists+bpf@lfdr.de>; Fri, 05 Dec 2025 14:42:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1284A3042297
	for <lists+bpf@lfdr.de>; Fri,  5 Dec 2025 13:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA5F0315D58;
	Fri,  5 Dec 2025 13:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="A4kk7Zeb"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B9A32ED56;
	Fri,  5 Dec 2025 13:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764942099; cv=none; b=UsESF1RTLeEQ96d99IgWXAEL0ox8LbBNc86pSMIS+xRDf/llwWn5UOT5xmxW4kn3MLTJRnPzfIiBcHF4aPsp0BTEG0o3lC+ZigpxwwElvXzZ5lJEiw/PccNE7Ezrthz5qSZQtwRWKEp9qZduB/aRc3XWMBTN7dIDr4QUIIlEYuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764942099; c=relaxed/simple;
	bh=dPYofiFgBI/nTomLa5BMPWyO0luQXTTu6wx8C4dgBXE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dZ4jwqcdO8VQ4mZMNL9v2XrVxhpyuuY5xicv1rvaWMI0yYsWdCn8obbkkhavA8R2hVeNdd7a0RrVH3+hOKHbO3K5kNYkJQh85SMxGEHaenM6zI5mxafzBusnKM/VfO7VcEe8mCcv2sw59ZTqet/N4tpR/EYnJLF3fWBdSY/24V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=A4kk7Zeb; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5B5Ajs1s013242;
	Fri, 5 Dec 2025 13:40:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=YLhyL3IvXOaOUXg9Qsq3itltYFri
	j1c4ehNNTcsHjvA=; b=A4kk7ZebKzNXRfmEBOMBjEO3ZS3qgoNJ1DueH6S1FrM2
	uyPz4+yWGNS8lk4IWotk89ag303O04E3Dz7HLufR91v7IvfNpnQyRajIsrxxRpgo
	oeZckoj0CXjO1a8Mc4AlCO0IQKcaMWyi7BTbm6THHnCy9EAyaGF1kSA87FNzUzq1
	Sn88fadNfylNpv42hOcXIzGPIlFO3Fn1B9RcQxthzTcVfMFKIXAl/v8rQ9DXW6ij
	DydA2aOwmvF8md9LBwSdR5RnTlvw+5XiLOsswBRoNdP2iMjJdsEeO5r/Dwj6KSpo
	X9abK23DWmzliSRR4VgogCFHBldHcDyQ60QufY4J5w==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aqq8v5795-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Dec 2025 13:40:52 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5B5DZ4jx005493;
	Fri, 5 Dec 2025 13:40:51 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aqq8v5792-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Dec 2025 13:40:51 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5B5AP3Qj019133;
	Fri, 5 Dec 2025 13:40:50 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4arbhydhf7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Dec 2025 13:40:50 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5B5DekJb38666746
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 5 Dec 2025 13:40:46 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AD4AD2004B;
	Fri,  5 Dec 2025 13:40:46 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 63E1920043;
	Fri,  5 Dec 2025 13:40:42 +0000 (GMT)
Received: from li-621bac4c-27c7-11b2-a85c-c2bf7c4b3c07.ibm.com.com (unknown [9.43.65.165])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  5 Dec 2025 13:40:42 +0000 (GMT)
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
Subject: [PATCH bpf-next v3 0/2] powerpc64/bpf: Inline helper in powerpc JIT
Date: Fri,  5 Dec 2025 19:10:39 +0530
Message-ID: <cover.1764930425.git.skb99@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: VQYKML7JH8kUl66KVGxABaAeI6Y16Ig-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI5MDAwOCBTYWx0ZWRfX+K90K2A2vcXV
 KrwRZ+uYv9l4apOqOKYSfUK3S5cDrXDKwKnQv+kB4MsGPym++JcES7egXawdhnO5KYkpa6hVW+z
 JyugvBlKtTM4RPaHXrSHI8u5IA76uVUqSJB/YWIXqqNziJ2dRKX+TgwPDiemRduQxPmd2HtdYbX
 D9ZU7j5pPwuJP4hRqblKMeopRXlk22JLJiqlTua0k7thMheNBMpQsw0Logk67IzVeo3bzs2Wq3h
 g9KQcUmc+urPXVP1dRlozkwnFmHAT8I6xewc2281/GNGbz0F6ymvgdjndBfA7uymAaHtUUqzmy4
 7DSBpf7lmr8KV92ffhsbxkUXnxhI0qoaTUTXNmN7Z+4BvsZr0j9Mcv273hVooseStu2I1vhQFwj
 bg+YNaE+YVziVVa6Gg0pd2On8vUNIQ==
X-Authority-Analysis: v=2.4 cv=Scz6t/Ru c=1 sm=1 tr=0 ts=6932e0e4 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=u2jAAMxGmqqbKrY86BEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: ZeaUm8ft7PYqmLoM4K0n4FcQEgNctKYM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-05_04,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0
 clxscore=1015 spamscore=0 impostorscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511290008

This series add support for internal only per-CPU instructions,
inlines the bpf_get_smp_processor_id() and bpf_get_current_task()
helper calls for powerpc BPF JIT.

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
 arch/powerpc/net/bpf_jit_comp64.c | 20 ++++++++++++++++++++
 2 files changed, 37 insertions(+)

-- 
2.51.0


