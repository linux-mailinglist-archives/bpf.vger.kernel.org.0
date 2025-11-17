Return-Path: <bpf+bounces-74700-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C56AAC6297F
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 07:53:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAFA33AE593
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 06:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7134316185;
	Mon, 17 Nov 2025 06:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="tLNghg/K"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85DBCA52;
	Mon, 17 Nov 2025 06:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763362411; cv=none; b=ceMc6EsOh5a3pU62ynGqTNzNQj2ZUTcppDoPbIRVvWGi5hJfTjMybLkAqUfToNf96UKeYruqliPwqXQrkByzxGKOCZlXvoK3MG32N7rHA5BFQVx3sFjHzMHHWE0XzZZK/Ihqyuz/acsyi4eZoB3H6r5J/UhSY3m/zYJ41FN/AQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763362411; c=relaxed/simple;
	bh=1yzf8onJM6PqNQMkzbUrD7ldyzkK3nBVG+AhX2toCmA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Yb10lwdsQ/S3af3Vot+IXdBQmGikIBMuOBej0WpkrwR6fRb4LEiD1Mut+RlLH8+XfgXvzS9d6RxFS0OHpNOB7W/0bz1zxFHxuKQEBwzrlGnY898FbhQ/xdxq3GF1sz6xWAoq3jrQYZWjfpe13qLnXhKlRDfWt6EtMN3M5tNmLL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=tLNghg/K; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AGMl45p010097;
	Mon, 17 Nov 2025 06:52:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=goh29T
	nuhyapOGXR0zlX/Z8AleVLtcjUxGl6sp6C0JE=; b=tLNghg/KTtWWzB1rbw+l+6
	zQsJLZuE8VjlfqCV78ZhBXg9MVt5VtmbaymwHiU10VIGiwosl22GC0AZUZ52+V9w
	8WgCL7FbYVr7v159GhgTk7kmv3lqzdZl3gJUwE/oGkYYHV+KBNNpdAjZ1jxdfXC7
	ZCpSyrcJ1o7g6dxH/01HPakD0Duu0Skcd2/onvROhAzbsjDF2Y7ftJ00Z/b64+Ut
	yXDIpeq6kPCUEzKemS1XIurlmdH5lFStOpipJBOthbGVv4HDKS9SKRgOMJApJnLE
	O3vdsy4l3v5pKynuifAEXO9fpxQLz7ZKfFrjhvT7ZQWXP/CvpzbVCZ0KeYN2GIzg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aejk14udh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Nov 2025 06:52:55 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5AH6qsFU001845;
	Mon, 17 Nov 2025 06:52:54 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aejk14udd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Nov 2025 06:52:54 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AH2nJhr022042;
	Mon, 17 Nov 2025 06:52:53 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4af4umme9e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Nov 2025 06:52:53 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5AH6qnUH27329190
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Nov 2025 06:52:49 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2A7672004B;
	Mon, 17 Nov 2025 06:52:49 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 478A020040;
	Mon, 17 Nov 2025 06:52:45 +0000 (GMT)
Received: from li-621bac4c-27c7-11b2-a85c-c2bf7c4b3c07.in.ibm.com (unknown [9.109.219.153])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 17 Nov 2025 06:52:45 +0000 (GMT)
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
Subject: [PATCH bpf-next v2 2/2] powerpc64/bpf: Inline bpf_get_smp_processor_id() and bpf_get_current_task()
Date: Mon, 17 Nov 2025 12:22:35 +0530
Message-ID: <1ff85160e12abfe1bd1e553b394957492187d133.1762422548.git.skb99@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1762422548.git.skb99@linux.ibm.com>
References: <cover.1762422548.git.skb99@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=C/nkCAP+ c=1 sm=1 tr=0 ts=691ac647 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=NEAV23lmAAAA:8 a=VnNF1IyMAAAA:8 a=9ieA5zyVNCi_1SjJAlMA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: _e3zeQflEfxkh1U5_2jp0BWjdKq9oiNs
X-Proofpoint-ORIG-GUID: 5vIa992N3xODDCZUEEZr3giKP6QnUkXG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMiBTYWx0ZWRfX2bpz1iXo9ll3
 TRaEtZGbGDhqXk6DC79twvZR2esula8n4BwIhT6LmseyFl2j4iaELHd7C3XPoZtXDuFpGKOoFnW
 aQq2L20W6VhWzMDylIzSkCjUoSS1D7RVBQbzNNYzteRcUN9tfpliFlNTiAqSgA1zNK9KKK1eZVT
 Wi6gZuQmrrGj5NmD4H7oCqaBHjUWDwFaOGI6wo1sFXHp0OJtdi+aQlOKrRk653wk385qGCdjujX
 cY1OvH/WJDvCwQEKqG36ANBYp1/fqM+//n+9RZZoUZ2iMX0mUhdAC6bBoAUcAwNUZiwBdx5P9W/
 t9n36Ws0LPm39Gt1DbLxXRP2rQib2ftaQ926Bq+TwgiWffFP7qDOihOMvtkODHMLLuGdj+L4xGB
 hucXcB5A2TBR9lggG40Ea+d0iqrk7g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-17_02,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 spamscore=0 impostorscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511150032

Inline the calls to bpf_get_smp_processor_id()/bpf_get_current_task()
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

Signed-off-by: Saket Kumar Bhaskar <skb99@linux.ibm.com>
---
 arch/powerpc/net/bpf_jit_comp.c   | 11 +++++++++++
 arch/powerpc/net/bpf_jit_comp64.c | 10 ++++++++++
 2 files changed, 21 insertions(+)

diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
index 2f2230ae2145..c88dfa1418ec 100644
--- a/arch/powerpc/net/bpf_jit_comp.c
+++ b/arch/powerpc/net/bpf_jit_comp.c
@@ -471,6 +471,17 @@ bool bpf_jit_supports_percpu_insn(void)
 	return IS_ENABLED(CONFIG_PPC64);
 }
 
+bool bpf_jit_inlines_helper_call(s32 imm)
+{
+	switch (imm) {
+	case BPF_FUNC_get_smp_processor_id:
+	case BPF_FUNC_get_current_task:
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
index 21486706b5ea..4e1643422370 100644
--- a/arch/powerpc/net/bpf_jit_comp64.c
+++ b/arch/powerpc/net/bpf_jit_comp64.c
@@ -1399,6 +1399,16 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, u32 *fimage, struct code
 		case BPF_JMP | BPF_CALL:
 			ctx->seen |= SEEN_FUNC;
 
+			if (insn[i].src_reg == BPF_REG_0) {
+				if (imm == BPF_FUNC_get_smp_processor_id) {
+					EMIT(PPC_RAW_LHZ(insn[i].src_reg, _R13, offsetof(struct paca_struct, paca_index)));
+					break;
+				} else if (imm == BPF_FUNC_get_current_task) {
+					EMIT(PPC_RAW_LD(insn[i].src_reg, _R13, offsetof(struct paca_struct, __current)));
+					break;
+				}
+			}
+
 			ret = bpf_jit_get_func_addr(fp, &insn[i], extra_pass,
 						    &func_addr, &func_addr_fixed);
 			if (ret < 0)
-- 
2.51.0


