Return-Path: <bpf+bounces-31731-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9EB390285F
	for <lists+bpf@lfdr.de>; Mon, 10 Jun 2024 20:10:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D72811C2161D
	for <lists+bpf@lfdr.de>; Mon, 10 Jun 2024 18:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 892F314AD3F;
	Mon, 10 Jun 2024 18:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=motorola.com header.i=@motorola.com header.b="Auuy7MG/"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00823401.pphosted.com (mx0a-00823401.pphosted.com [148.163.148.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836F57E761;
	Mon, 10 Jun 2024 18:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.148.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718042991; cv=none; b=aLjbhZ10L+fNGt1WW3G3j+qhjW86u7T1B0Ieh5lD5UKXHMXrNv13HY7/NvL/bIPqzuLcK5ZLSu6JNGNIvgUYt6KEQAA2shk3q15jZ1+KEyHaawvq0HsMExB4JRIC1tbhvfur5V2dJc0n46QeVFcD9x5wcIBY/VbfXzTqeOI/LXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718042991; c=relaxed/simple;
	bh=VMAGW0oB8N8oHwmlZO78JAp91DNuXS2+2Hv5FK2UPzw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IGiADsqpvff5vED00ZhG3zLTwuKwAfL2pd9aGu95dVEKRHrONYk00ssCQJQ+63PTHEC+EsB/rhxnj/zmtR+9g+UkxVe2a5hNb0mAT5gMq3Ago7Hu4tUAa+67MI5iRH+PuiBvib6JFOrotCgjAVJOeYuoGcaS1eS+NjGlfhVd6ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motorola.com; spf=pass smtp.mailfrom=motorola.com; dkim=pass (2048-bit key) header.d=motorola.com header.i=@motorola.com header.b=Auuy7MG/; arc=none smtp.client-ip=148.163.148.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motorola.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motorola.com
Received: from pps.filterd (m0355088.ppops.net [127.0.0.1])
	by m0355088.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 45ABm98Q002176;
	Mon, 10 Jun 2024 18:09:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=motorola.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=DKIM202306; bh=JCButQwjvZVZNyRkDdtQ7rO
	g+hf/mkn6MXierihoty0=; b=Auuy7MG/eYyQO2j/HY+HwmdSM/To4BwhQSNUuYD
	mBj7Ez1Z1LvB5NXDoH7nIOpsIv9voZPDm0hxhmi5OU1Ym77L2nBN+jUsOCIKT3Ev
	GU3pRsnOxVLUWc4CBIvb9zdEmhJknXgcEY6Aep2z9bO0A+V9QahgTbTQ4VBUESfm
	6FiWvZZkvRYJ2AEittN4DrrqjlrvUSnmBbiQOjBXs+62atkgtowLix9+rG/eVWel
	qdIOdLCRvtqxDtm5/xliA691usMjGKOFoDLSsxyXIa8LKNJTlWHJrooCPf3wVX5s
	wwzSR/Qp2WNC9SUJQYx27BtjMrxvWE6gCLG3sihQIKvXkHA==
Received: from va32lpfpp01.lenovo.com ([104.232.228.21])
	by m0355088.ppops.net (PPS) with ESMTPS id 3yn4ft2ax8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Jun 2024 18:09:26 +0000 (GMT)
Received: from va32lmmrp02.lenovo.com (va32lmmrp02.mot.com [10.62.176.191])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by va32lpfpp01.lenovo.com (Postfix) with ESMTPS id 4Vyfvn0XBZzhWB3;
	Mon, 10 Jun 2024 18:09:25 +0000 (UTC)
Received: from ilclasset02 (ilclasset02.mot.com [100.64.49.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: mbland)
	by va32lmmrp02.lenovo.com (Postfix) with ESMTPSA id 4Vyfvm4nzfz2VZ3B;
	Mon, 10 Jun 2024 18:09:24 +0000 (UTC)
Date: Mon, 10 Jun 2024 13:09:23 -0500
From: Maxwell Bland <mbland@motorola.com>
To: "open list:BPF [GENERAL] (Safe Dynamic Programs and Tools)" <bpf@vger.kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Zi Shen Lim <zlim.lnx@gmail.com>, Mark Rutland <mark.rutland@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mark Brown <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org,
        open list <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Puranjay Mohan <puranjay12@gmail.com>
Subject: [PATCH bpf-next v5 3/3] arm64/cfi,bpf: Use DEFINE_CFI_TYPE in arm64
Message-ID: <enuputvysbmsujfjfzxqurwubc7ffv5mtu5iw3tqijd6i4p45u@ioe5sbuy6dpq>
References: <mafwhrai2nz3u4wn4fu72kvzjm6krs57klc3qqvd2sz2mham6d@x4ukf6xqp4f4>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mafwhrai2nz3u4wn4fu72kvzjm6krs57klc3qqvd2sz2mham6d@x4ukf6xqp4f4>
X-Proofpoint-GUID: DUHw64W3JWg0MRvl_rezKK9v29hYaxtk
X-Proofpoint-ORIG-GUID: DUHw64W3JWg0MRvl_rezKK9v29hYaxtk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-10_04,2024-06-10_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 adultscore=0 clxscore=1015 bulkscore=0 spamscore=0 priorityscore=1501
 malwarescore=0 phishscore=0 suspectscore=0 mlxlogscore=999 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405170001
 definitions=main-2406100137

Corrects Puranjay Mohan's commit to adopt Mark Rutland's
suggestion of using a C CFI type macro in kCFI+BPF.

Signed-off-by: Maxwell Bland <mbland@motorola.com>
---
 arch/arm64/kernel/alternative.c | 46 ++++-----------------------------
 1 file changed, 5 insertions(+), 41 deletions(-)

diff --git a/arch/arm64/kernel/alternative.c b/arch/arm64/kernel/alternative.c
index 1715da7df137..d7a58eca7665 100644
--- a/arch/arm64/kernel/alternative.c
+++ b/arch/arm64/kernel/alternative.c
@@ -8,6 +8,7 @@
 
 #define pr_fmt(fmt) "alternatives: " fmt
 
+#include <linux/cfi_types.h>
 #include <linux/init.h>
 #include <linux/cpu.h>
 #include <linux/elf.h>
@@ -302,53 +303,16 @@ EXPORT_SYMBOL(alt_cb_patch_nops);
 
 #ifdef CONFIG_CFI_CLANG
 struct bpf_insn;
-
 /* Must match bpf_func_t / DEFINE_BPF_PROG_RUN() */
 extern unsigned int __bpf_prog_runX(const void *ctx,
 				    const struct bpf_insn *insn);
-
-/*
- * Force a reference to the external symbol so the compiler generates
- * __kcfi_typid.
- */
-__ADDRESSABLE(__bpf_prog_runX);
-
-/* u32 __ro_after_init cfi_bpf_hash = __kcfi_typeid___bpf_prog_runX; */
-asm (
-"	.pushsection	.data..ro_after_init,\"aw\",@progbits	\n"
-"	.type	cfi_bpf_hash,@object				\n"
-"	.globl	cfi_bpf_hash					\n"
-"	.p2align	2, 0x0					\n"
-"cfi_bpf_hash:							\n"
-"	.word	__kcfi_typeid___bpf_prog_runX			\n"
-"	.size	cfi_bpf_hash, 4					\n"
-"	.popsection						\n"
-);
-
+DEFINE_CFI_TYPE(cfi_bpf_hash, __bpf_prog_runX);
 /* Must match bpf_callback_t */
 extern u64 __bpf_callback_fn(u64, u64, u64, u64, u64);
-
-__ADDRESSABLE(__bpf_callback_fn);
-
-/* u32 __ro_after_init cfi_bpf_subprog_hash = __kcfi_typeid___bpf_callback_fn; */
-asm (
-"	.pushsection	.data..ro_after_init,\"aw\",@progbits	\n"
-"	.type	cfi_bpf_subprog_hash,@object			\n"
-"	.globl	cfi_bpf_subprog_hash				\n"
-"	.p2align	2, 0x0					\n"
-"cfi_bpf_subprog_hash:						\n"
-"	.word	__kcfi_typeid___bpf_callback_fn			\n"
-"	.size	cfi_bpf_subprog_hash, 4				\n"
-"	.popsection						\n"
-);
-
+DEFINE_CFI_TYPE(cfi_bpf_subprog_hash, __bpf_callback_fn);
 u32 cfi_get_func_hash(void *func)
 {
-	u32 hash;
-
-	if (get_kernel_nofault(hash, func - cfi_get_offset()))
-		return 0;
-
-	return hash;
+	u32 *hashp = func - cfi_get_offset();
+	return READ_ONCE(*hashp);
 }
 #endif
-- 
2.39.2



