Return-Path: <bpf+bounces-31938-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 911C99056F1
	for <lists+bpf@lfdr.de>; Wed, 12 Jun 2024 17:33:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DBF1DB25FC1
	for <lists+bpf@lfdr.de>; Wed, 12 Jun 2024 15:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 385B7181332;
	Wed, 12 Jun 2024 15:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=motorola.com header.i=@motorola.com header.b="rBqrXBe6"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00823401.pphosted.com (mx0b-00823401.pphosted.com [148.163.152.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322F9180A79;
	Wed, 12 Jun 2024 15:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.152.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718206374; cv=none; b=LZQJLuEnYwSggYpmNkA9viPgsWdecgGDYEdumU5f+Z6ECbVlwyWA6e8nG6i36JgAFA12VjmRhsSq+Px3Z9C64m/TEwcXYbRjW/K2f9knCDDKM1TXAIkRYsIDLAQpkZLgfCksBgNCsR1uJBoeZswJPVU7mpX8agC5MWuKBHZjn/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718206374; c=relaxed/simple;
	bh=2wwPlROZa4IjXKMB/B8j6xb6yzJ8Sd+ewIMeIt5CG6g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SUxrC1UnfIn7jaltqv9sGRaP4Gf0CHF7ZkRLmCcRT9ROpc5jNYCAeeKBw4Gjp37MRZhXkCIBiuTCbyb8ghAEqgg3tXe5Mu5iA5l0eH+dpXkcCIdhlx7zHAYYZiRlwGsCa91lrU6PXbPLvEo9lOqMC3gDhfgQ2gRn+YZh7E3lNKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motorola.com; spf=pass smtp.mailfrom=motorola.com; dkim=pass (2048-bit key) header.d=motorola.com header.i=@motorola.com header.b=rBqrXBe6; arc=none smtp.client-ip=148.163.152.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motorola.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motorola.com
Received: from pps.filterd (m0355090.ppops.net [127.0.0.1])
	by m0355090.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 45CDleNs004491;
	Wed, 12 Jun 2024 15:32:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=motorola.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=DKIM202306; bh=5UYz7vM8ukqZ7+rx3Rz0bIj
	lD/l1jReNBhEadDHRJ70=; b=rBqrXBe6qrlvYkIRocJmwI/w/30JQDW1d5FBlxC
	va2Yr8DYzIwLJHWai3Oc23+Z38N+nLb1A6NmAyyo0KiBVdSsjoqDkUAtN+v094ZZ
	7YvxCfQJE/q2bSheubx/z+/uE25pTJfzug+bZtiiF0TtvJJ9LWrAGXb964dNls8g
	DTt9jV/8l+9NqvXRvu4Gy3CkY69yhk1tnquk+L4KbYZbTxzH1mGohMRdkl3uohBq
	2/QVrzM9vwqtVEIrJ+oa5GjHSV0Zq1/CGZaB3jgo61B80EcHbD0rdHkSAdHATqFi
	cTMJJfnWz4jqBAtHyO7lUswFAEYC5MgvVTGGS/jT0jOpsUg==
Received: from va32lpfpp03.lenovo.com ([104.232.228.23])
	by m0355090.ppops.net (PPS) with ESMTPS id 3yn2msg6vg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Jun 2024 15:32:19 +0000 (GMT)
Received: from va32lmmrp02.lenovo.com (va32lmmrp02.mot.com [10.62.176.191])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by va32lpfpp03.lenovo.com (Postfix) with ESMTPS id 4VzqKZ6ymTz51Q9y;
	Wed, 12 Jun 2024 15:32:18 +0000 (UTC)
Received: from ilclasset02 (ilclasset02.mot.com [100.64.49.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: mbland)
	by va32lmmrp02.lenovo.com (Postfix) with ESMTPSA id 4VzqKZ3HsBz2VZ3B;
	Wed, 12 Jun 2024 15:32:18 +0000 (UTC)
Date: Wed, 12 Jun 2024 10:32:17 -0500
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
Subject: [PATCH bpf-next v6 3/3] arm64/cfi,bpf: Use DEFINE_CFI_TYPE in arm64
Message-ID: <c6fsgv7bjt2d2ejz2uuin2g475fkvpyenp32wehdqlcf6ihqgx@5gicsaw4u37f>
References: <illfkwuxwq3adca2h4shibz2xub62kku3g2wte4sqp7xj7cwkb@ckn3qg7zxjuv>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <illfkwuxwq3adca2h4shibz2xub62kku3g2wte4sqp7xj7cwkb@ckn3qg7zxjuv>
X-Proofpoint-ORIG-GUID: 4_v9B3kXPAzqWmjgo_DoyOlN5e58hRxg
X-Proofpoint-GUID: 4_v9B3kXPAzqWmjgo_DoyOlN5e58hRxg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-12_08,2024-06-12_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 bulkscore=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 phishscore=0 adultscore=0 mlxscore=0 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406120111

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
2.43.0



