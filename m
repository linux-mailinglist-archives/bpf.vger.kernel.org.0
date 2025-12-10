Return-Path: <bpf+bounces-76393-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 20575CB21E6
	for <lists+bpf@lfdr.de>; Wed, 10 Dec 2025 07:52:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8A20C30E67E2
	for <lists+bpf@lfdr.de>; Wed, 10 Dec 2025 06:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0A1C2820A0;
	Wed, 10 Dec 2025 06:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rEgHVN8s"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D920A1F3BA4;
	Wed, 10 Dec 2025 06:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765349510; cv=none; b=lPJ0xhzJMqdqeMmdrvZeNDl/69pTSousE8ppjRp9dWSnx0BPZ/1FNkcZWPIfSoWvKzLFhdIJVsgX7z51HBmwvg/J1m2FJyLfFY9swEUh7HSXGtkgkbjN6rsrl5OxIxKT+//3DzJSVuBJUcLEsC3/ArfkZ6GO2ChVhPeljzRWclQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765349510; c=relaxed/simple;
	bh=g3YArYhvbl0gEzinJ/bUXt8a8I9Rcwsw0E3OY8h7rPg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KloaE0t5sAesnjzJGCekoPYxCtbX1uLDzXJUkPMbPVNGUhWU95S92vUEyV57npr1sdBkRjxu25EcgOMMm6mfdnQL8neP60ZaEsOdROdiIoSQzhy5kRc5IxKEDc7HqzofVNUFHD9O+9EPZX1RXujL7xJaL6ZCO4b+O34NGoY8XX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rEgHVN8s; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BA2rXAK017674;
	Wed, 10 Dec 2025 06:50:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=QbLF06
	aoc9AEQM4U6440jWePKSqPQqSALf4CCdrTQVI=; b=rEgHVN8sa0JsuibDc9LrcU
	dHQ7pTURWF8ztY/crvVC3KIYUd75GhamohwkYQ6J4+T4H6MTN6yjYqwLP+iwflav
	0mVRLIVVo3yYjS20jvQ00yJ+CbjBu6+dL2gixXJ69IbD7qKFY+Z/GElpgYligR4g
	0vqdcAPzI2QA9+jWtiMTVt4y+ISefNStyEaptpGvJQtFlBLet7K+f2VLVzb36Wpy
	Tjnzc2GYU6eZjy7UnL4ggIpugf38sIV/0kP4c28o42b+HlqKhKvSYFwswMOMof7T
	IhC6nbrzM3+7kvMahuKrdrOzQWaePFZsPVHZzO2QSpciz006/f1EiQeJLfLttogw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4avawv8fvs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Dec 2025 06:50:53 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5BA6mOxP005045;
	Wed, 10 Dec 2025 06:50:53 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4avawv8fvp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Dec 2025 06:50:53 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5BA5Orrw009044;
	Wed, 10 Dec 2025 06:50:52 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4avytmy8dt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Dec 2025 06:50:52 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5BA6om0R52691440
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Dec 2025 06:50:48 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5AB972004B;
	Wed, 10 Dec 2025 06:50:48 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2D22D20040;
	Wed, 10 Dec 2025 06:50:44 +0000 (GMT)
Received: from li-621bac4c-27c7-11b2-a85c-c2bf7c4b3c07.ibm.com.com (unknown [9.43.106.237])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 10 Dec 2025 06:50:43 +0000 (GMT)
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
Subject: [PATCH bpf-next v4 2/2] powerpc64/bpf: Inline bpf_get_smp_processor_id() and bpf_get_current_task/_btf()
Date: Wed, 10 Dec 2025 12:20:33 +0530
Message-ID: <89abfdd6f6721fbe7897865e74f2f691e5f7824a.1765343385.git.skb99@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1765343385.git.skb99@linux.ibm.com>
References: <cover.1765343385.git.skb99@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: y7vsctMC0RIf_zRLlguJP1a5Z7zJjdzg
X-Proofpoint-ORIG-GUID: 93ch5fYpdkuJsbwMfJ0peuFYBRqELjkP
X-Authority-Analysis: v=2.4 cv=aY9sXBot c=1 sm=1 tr=0 ts=6939184e cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=mFN1cuOBngCmvTvEACsA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA2MDAwNyBTYWx0ZWRfX8F/dSIpgjExQ
 1j/gEPEbu6eRgjuaT/e3IVj5ZQ/lNiHnpETSvjv0OoJqc4shiT+VkOOsqmxohsZjre7vR1W/dUl
 P3BOelPJHicqr0FKxxqJsajmud1T2lbShcl0BvdI35mVrBra4m3hQqLzr1e8xPRjgIYZPNRrexB
 bE8E/B8oPnC7Rwh87fpfglIlyonqAbayDnWgB61Jz4s7ybjWx8goy0Wje6Eef3/qeWyDjehlPqv
 2tl2VRkc9O8fFSAIw8hE2yad+5aQxucLIBa0tB6gn0wj3duU8BIcJqV6FUOhypD4nPiDa9phHIn
 mEwYtHLIpN+CTjIpcwo+MLaVZtq0M4uqvM3dy03JcCjvgzp4X2KLWYO537sGS29tzxXKhPPvYFI
 hxtxDu2sdmuUjjV4qi7xHCbsQ9KDQA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-09_05,2025-12-09_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0 bulkscore=0
 adultscore=0 impostorscore=0 malwarescore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2512060007

Inline the calls to bpf_get_smp_processor_id() and bpf_get_current_task/_btf()
in the powerpc bpf jit.

powerpc saves the Logical processor number (paca_index) and pointer
to current task (__current) in paca.

Here is how the powerpc JITed assembly changes after this commit:

Before:

cpu = bpf_get_smp_processor_id();

addis 12, 2, -517
addi 12, 12, -29456
mtctr 12
bctrl
mr	8, 3

After:

cpu = bpf_get_smp_processor_id();

lhz 8, 8(13)

To evaluate the performance improvements introduced by this change,
the benchmark described in [1] was employed.

+---------------+-------------------+-------------------+--------------+
|      Name     |      Before       |        After      |   % change   |
|---------------+-------------------+-------------------+--------------|
| glob-arr-inc  | 40.701 ± 0.008M/s | 55.207 ± 0.021M/s |   + 35.64%   |
| arr-inc       | 39.401 ± 0.007M/s | 56.275 ± 0.023M/s |   + 42.42%   |
| hash-inc      | 24.944 ± 0.004M/s | 26.212 ± 0.003M/s |   +  5.08%   |
+---------------+-------------------+-------------------+--------------+

[1] https://github.com/anakryiko/linux/commit/8dec900975ef

Reviewed-by: Puranjay Mohan <puranjay@kernel.org>
Signed-off-by: Saket Kumar Bhaskar <skb99@linux.ibm.com>
---
 arch/powerpc/net/bpf_jit_comp.c   | 12 ++++++++++++
 arch/powerpc/net/bpf_jit_comp64.c | 11 +++++++++++
 2 files changed, 23 insertions(+)

diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
index d53e9cd7563f..b243ee205885 100644
--- a/arch/powerpc/net/bpf_jit_comp.c
+++ b/arch/powerpc/net/bpf_jit_comp.c
@@ -471,6 +471,18 @@ bool bpf_jit_supports_percpu_insn(void)
 	return IS_ENABLED(CONFIG_PPC64);
 }
 
+bool bpf_jit_inlines_helper_call(s32 imm)
+{
+	switch (imm) {
+	case BPF_FUNC_get_smp_processor_id:
+	case BPF_FUNC_get_current_task:
+	case BPF_FUNC_get_current_task_btf:
+		return true;
+	default:
+		return false;
+	}
+}
+
 void *arch_alloc_bpf_trampoline(unsigned int size)
 {
 	return bpf_prog_pack_alloc(size, bpf_jit_fill_ill_insns);
diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
index 37723ee9344e..6c827e7aa691 100644
--- a/arch/powerpc/net/bpf_jit_comp64.c
+++ b/arch/powerpc/net/bpf_jit_comp64.c
@@ -1400,6 +1400,17 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, u32 *fimage, struct code
 		case BPF_JMP | BPF_CALL:
 			ctx->seen |= SEEN_FUNC;
 
+			if (src_reg == bpf_to_ppc(BPF_REG_0)) {
+				if (imm == BPF_FUNC_get_smp_processor_id) {
+					EMIT(PPC_RAW_LHZ(src_reg, _R13, offsetof(struct paca_struct, paca_index)));
+					break;
+				} else if (imm == BPF_FUNC_get_current_task ||
+					   imm == BPF_FUNC_get_current_task_btf) {
+					EMIT(PPC_RAW_LD(src_reg, _R13, offsetof(struct paca_struct, __current)));
+					break;
+				}
+			}
+
 			ret = bpf_jit_get_func_addr(fp, &insn[i], extra_pass,
 						    &func_addr, &func_addr_fixed);
 			if (ret < 0)
-- 
2.51.0


