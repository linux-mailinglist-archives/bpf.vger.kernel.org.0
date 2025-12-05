Return-Path: <bpf+bounces-76108-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AB33CA7CDD
	for <lists+bpf@lfdr.de>; Fri, 05 Dec 2025 14:41:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4697E3037A0F
	for <lists+bpf@lfdr.de>; Fri,  5 Dec 2025 13:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00BD33314B9;
	Fri,  5 Dec 2025 13:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="TECbHZlI"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A7232D7F3;
	Fri,  5 Dec 2025 13:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764942106; cv=none; b=lgSrJqvbybFxtTruTNb6oAC6AKyrD2Pact356gHlPOCLA+DAxMVZmrJdkjd1fOPPI2z2tV5TYSxlQ1ZZa8XlsJrwktcZaiva6h4hXLSTJhbpodEwSYdjcZeuK9Kld3p79Vy0drLFmk+eFRyYK/ViTbAZJtJ250Mi2adcJgoCcG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764942106; c=relaxed/simple;
	bh=QRpPQUi3VpxIpyWCWqGM6BhOsZ8LpoDl98EVJNnoSMI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EHFLjRYYoR5CAoQJf1g6KC7EaJJhxlGu7d3cdpFG8F6TSehCegDxJMGgnKjxjQSNKcbkCBg1orX1cHg+PUpyHQlCcMKz/k+AY+L3ZyYq2oCGz8nBuKauFngzIAROXiTDfKpnMIBmPmkSTh9TuOD8m3Z1XN4xG2Ky1530lP5m+nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=TECbHZlI; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5B51Udqm022200;
	Fri, 5 Dec 2025 13:40:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=I+g8Aw
	ntXMlT0hsQ9lG039AxM0DJyRMYhYOTG24t2TI=; b=TECbHZlIpfLhviH5oEnZaq
	w5X64frxat5DxMaVMHQ+zSnqnBsEfq1oaYCstaa9Z07fuvFARizzLndJHyhc6cbA
	tRnQAATeCIAuX/rLH+qR9vRi6iu91MqZ3iIGAjUJ7OZBJoqRTJ1m/EVOectVnzcn
	nzxwydGflM1lvhK4Km2JHJM6/RZiBn1y4d/eN7v32B0uFuOlWWpnkn7MNJJj4ngt
	F10yIE9GtnoTNh7UQ+hzhH3rI1r4MM69hcp4beLDYAZuqbvJL0E4YKjkHxOVYNi0
	vE/ZiMc04K8D1QDEa8M3EKD9dD2ZBxsYp6rtaFSs9aqLLllqAHT+SAHkLi3DXGFg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aqrbgp3x8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Dec 2025 13:40:56 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5B5Dau3S022126;
	Fri, 5 Dec 2025 13:40:56 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aqrbgp3x5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Dec 2025 13:40:56 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5B5CGdRH029361;
	Fri, 5 Dec 2025 13:40:55 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ardv1w6ay-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Dec 2025 13:40:55 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5B5Dep5N27197908
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 5 Dec 2025 13:40:51 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 533C420040;
	Fri,  5 Dec 2025 13:40:51 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0B5E020043;
	Fri,  5 Dec 2025 13:40:47 +0000 (GMT)
Received: from li-621bac4c-27c7-11b2-a85c-c2bf7c4b3c07.ibm.com.com (unknown [9.43.65.165])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  5 Dec 2025 13:40:46 +0000 (GMT)
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
Subject: [PATCH bpf-next v3 1/2] powerpc64/bpf: Support internal-only MOV instruction to resolve per-CPU addrs
Date: Fri,  5 Dec 2025 19:10:40 +0530
Message-ID: <1957532cd4b87b450a2efc0e9d732f448bcf9706.1764930425.git.skb99@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1764930425.git.skb99@linux.ibm.com>
References: <cover.1764930425.git.skb99@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: N4IUscQRT1bjK4oWVt9Zvqp5TDSVq_iz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI5MDAxNiBTYWx0ZWRfXwVaSpMuzfKON
 FuN3L9Lyzye8P7YXTLVsBcZv7MbneAFHY3F9sqzGqh+lVnvweH+ODYIy/wNNKhRwjuiQXptoAbH
 ZIzJTBD9y/w1MX1WnvRN7G2mRl18tXVunIEDjMjTJaZO8KR1q1RJhPiDYDpjk1eI91mD/ZDz0+U
 D15hIO3bME1xh69nWW/llQeFjuDxquElg4/iqYB1WlRsZr7N5zmOV5hpefEv+Qf1qOQoAmwb+w2
 Xv8oM8gUihBFjUdq8dvn4VGQPGKei/fyinDf1W+hMGjO8KEsX6ArSD/vSZgv46DzC3DTwa8YwlD
 Qj0Tu84frD+iwyHGDdG4ofBW9H1NXrnYDYmwwhwBe2A0cKz8JWP1TgXYxUQ0m2OmRUb1uuIKkkD
 8fk+ZVI7+RFc0W7H4cawFxDO0dbfJw==
X-Authority-Analysis: v=2.4 cv=UO7Q3Sfy c=1 sm=1 tr=0 ts=6932e0e8 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=mFN1cuOBngCmvTvEACsA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 4sZxyoWCUPZhznsOdE02UkV2dM6TgO0U
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-05_04,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 adultscore=0 priorityscore=1501
 impostorscore=0 spamscore=0 phishscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511290016

With the introduction of commit 7bdbf7446305 ("bpf: add special
internal-only MOV instruction to resolve per-CPU addrs"),
a new BPF instruction BPF_MOV64_PERCPU_REG has been added to
resolve absolute addresses of per-CPU data from their per-CPU
offsets. This update requires enabling support for this
instruction in the powerpc JIT compiler.

As of commit 7a0268fa1a36 ("[PATCH] powerpc/64: per cpu data
optimisations"), the per-CPU data offset for the CPU is stored in
the paca.

To support this BPF instruction in the powerpc JIT, the following
powerpc instructions are emitted:
if (IS_ENABLED(CONFIG_SMP))
ld tmp1_reg, 48(13)		//Load per-CPU data offset from paca(r13) in tmp1_reg.
add dst_reg, src_reg, tmp1_reg	//Add the per cpu offset to the dst.
else if (src_reg != dst_reg)
mr dst_reg, src_reg		//Move src_reg to dst_reg, if src_reg != dst_reg

To evaluate the performance improvements introduced by this change,
the benchmark described in [1] was employed.

Before Change:
glob-arr-inc   :   41.580 ± 0.034M/s
arr-inc        :   39.592 ± 0.055M/s
hash-inc       :   25.873 ± 0.012M/s

After Change:
glob-arr-inc   :   42.024 ± 0.049M/s
arr-inc        :   55.447 ± 0.031M/s
hash-inc       :   26.565 ± 0.014M/s

[1] https://github.com/anakryiko/linux/commit/8dec900975ef

Reviewed-by: Puranjay Mohan <puranjay@kernel.org>
Signed-off-by: Saket Kumar Bhaskar <skb99@linux.ibm.com>
---
 arch/powerpc/net/bpf_jit_comp.c   | 5 +++++
 arch/powerpc/net/bpf_jit_comp64.c | 9 +++++++++
 2 files changed, 14 insertions(+)

diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
index 5e976730b2f5..d53e9cd7563f 100644
--- a/arch/powerpc/net/bpf_jit_comp.c
+++ b/arch/powerpc/net/bpf_jit_comp.c
@@ -466,6 +466,11 @@ bool bpf_jit_supports_insn(struct bpf_insn *insn, bool in_arena)
 	return true;
 }
 
+bool bpf_jit_supports_percpu_insn(void)
+{
+	return IS_ENABLED(CONFIG_PPC64);
+}
+
 void *arch_alloc_bpf_trampoline(unsigned int size)
 {
 	return bpf_prog_pack_alloc(size, bpf_jit_fill_ill_insns);
diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
index 1fe37128c876..816f9d7d9e5d 100644
--- a/arch/powerpc/net/bpf_jit_comp64.c
+++ b/arch/powerpc/net/bpf_jit_comp64.c
@@ -918,6 +918,15 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, u32 *fimage, struct code
 		case BPF_ALU | BPF_MOV | BPF_X: /* (u32) dst = src */
 		case BPF_ALU64 | BPF_MOV | BPF_X: /* dst = src */
 
+			if (insn_is_mov_percpu_addr(&insn[i])) {
+				if (IS_ENABLED(CONFIG_SMP)) {
+					EMIT(PPC_RAW_LD(tmp1_reg, _R13, offsetof(struct paca_struct, data_offset)));
+					EMIT(PPC_RAW_ADD(dst_reg, src_reg, tmp1_reg));
+				} else if (src_reg != dst_reg) {
+					EMIT(PPC_RAW_MR(dst_reg, src_reg));
+				}
+			}
+
 			if (insn_is_cast_user(&insn[i])) {
 				EMIT(PPC_RAW_RLDICL_DOT(tmp1_reg, src_reg, 0, 32));
 				PPC_LI64(dst_reg, (ctx->user_vm_start & 0xffffffff00000000UL));
-- 
2.51.0


