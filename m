Return-Path: <bpf+bounces-76109-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F1B01CA7CFB
	for <lists+bpf@lfdr.de>; Fri, 05 Dec 2025 14:43:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 80FCA306DC97
	for <lists+bpf@lfdr.de>; Fri,  5 Dec 2025 13:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C61CD32F76C;
	Fri,  5 Dec 2025 13:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PaiMgalR"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0AB42E8B96;
	Fri,  5 Dec 2025 13:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764942163; cv=none; b=fmU6Hro1uPQ8B7Qu5bwT88853Cn6+voFva4W7cCmCj8L/TzbepCE/22nZZYeugXqlGjMk2WNbS+6/adp4VJ/sYAHJZMKf3HStfQ9p/1IKQxPjQAWRI9/pTqqFpz4UHIoKOs2vHz5NcnqYjAyBQPb80ySWFGFecGhmbExJ0ffwmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764942163; c=relaxed/simple;
	bh=VqJ6hLWdNfj2v1Dw/De4HOD3e83tcwL7vgoM8QntjeE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b3J60GAaAjUU4kkybuCF4/y1oDxj+vgc+jl8UvtjM8ATWT07Z2gLfyIF7p0y+Ache0xGzWqVEtyHDreydNANliaJ4rm4iQuqmXpDqp7O2P9MRkZIR5ssWF5jh/ZK9raLRHUMhZRTPdraag5OKXcrsHbOtFy8f+rR3NwRa3W6vlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=PaiMgalR; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5B5DVxRQ009816;
	Fri, 5 Dec 2025 13:41:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=p4zRrm
	zeYQ1oFw0fuS/+4/Khe8QDw1WqVnIwE9OEyKs=; b=PaiMgalRiBeMiN/K09BXjF
	B77LlXX+IzCmLg+NF/hZP2tG2t8VHEvNMv1c5sdH5p2Y3jv2nuxJtn9p+hGwMROS
	JGSDwN3bsu4uUpMtkmckT8VFp1TT+qucntMkvwTA3D7Rx4ziTVDpU9+t6GSkbnwC
	ZHTwWDAhELIJN/baHq0DfLraJfrvltuI5nGUd7xdrxt6rbDSQbGG94+75mq+bcz2
	KxXfAQ/cewJG1Vrz/0gezzWnMPfmuNAFpBCZBsnXFpI1zfDDBJbDs2V0ePajtkYW
	chZVnJWEI7KxMzt1siP46bmmZBV0A787cais9bJjRe2RVu4lRHo/H+ZPU6hRhcwg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aqq8v579u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Dec 2025 13:41:01 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5B5DZJ8Z006480;
	Fri, 5 Dec 2025 13:41:00 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aqq8v579q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Dec 2025 13:41:00 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5B5BRJsF003867;
	Fri, 5 Dec 2025 13:40:59 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ardck58q3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Dec 2025 13:40:59 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5B5DeuWa29229420
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 5 Dec 2025 13:40:56 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EBCF22004E;
	Fri,  5 Dec 2025 13:40:55 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A78452004B;
	Fri,  5 Dec 2025 13:40:51 +0000 (GMT)
Received: from li-621bac4c-27c7-11b2-a85c-c2bf7c4b3c07.ibm.com.com (unknown [9.43.65.165])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  5 Dec 2025 13:40:51 +0000 (GMT)
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
Subject: [PATCH bpf-next v3 2/2] powerpc64/bpf: Inline bpf_get_smp_processor_id() and bpf_get_current_task/_btf()
Date: Fri,  5 Dec 2025 19:10:41 +0530
Message-ID: <45f7585f2d4771123b4f1429fe39aa8d756577f6.1764930425.git.skb99@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: fHunfLG5IeVj2RaSfoulGtZoNj3M2XfC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI5MDAwOCBTYWx0ZWRfX2e15+dWSiDU5
 wnQM0ZTya8uEREQAgB/yGjweiWgpLHk4Wd/MRlBG6toS9BzhCphXeS6I0K1f2mLNu8gEQRBaBI3
 zGyzINTEKU9dd2vmB9jdL/uK/1EuhmD8/n6BLYNK0jZh7tOzV/Iz2UVUmGXGLzk67NW1bFN804m
 7HgvoohYp11OinurQND47HFdFYikNkLdXFhpUsDvAt5cVTC1w+V06dCJgYf9xw1wC+eGsBzuDCh
 HUEKtHHr6zJ+7sRTTzqjkGm6ZoRtXjFYcuEv7teXAHxrrgozXLuMz7T6+IVWBz4hzJSndCBnEm1
 /q1Hhjj/N4rEP4WmLHK/UEAQ+X62jYlXLx3HolbjMR399CyTjLMlVWawknulMSsIYZRtMcIN5ZC
 wu5JQfnb5cAFqknhG1N/GApttcO8Gw==
X-Authority-Analysis: v=2.4 cv=Scz6t/Ru c=1 sm=1 tr=0 ts=6932e0ed cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=mFN1cuOBngCmvTvEACsA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: -o7Af3fhrSd50-FUF2RmvDbCFiHZ75PM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-05_04,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0
 clxscore=1015 spamscore=0 impostorscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511290008

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
index 816f9d7d9e5d..76a44f9ad7d2 100644
--- a/arch/powerpc/net/bpf_jit_comp64.c
+++ b/arch/powerpc/net/bpf_jit_comp64.c
@@ -1399,6 +1399,17 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, u32 *fimage, struct code
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


