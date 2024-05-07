Return-Path: <bpf+bounces-28997-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4664C8BF330
	for <lists+bpf@lfdr.de>; Wed,  8 May 2024 02:07:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 558BDB2683F
	for <lists+bpf@lfdr.de>; Wed,  8 May 2024 00:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A142E136663;
	Tue,  7 May 2024 23:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=motorola.com header.i=@motorola.com header.b="iT6AKPTN"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00823401.pphosted.com (mx0a-00823401.pphosted.com [148.163.148.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4698136657;
	Tue,  7 May 2024 23:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.148.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715125692; cv=none; b=P3VbFlW+wbv0NwXBAFK6UHEzTcUHGi8P3XFNCtqtd+kmFPJu/5a3KwVvOpkEscKGqL1gcI08RzPpzyGJFeY5vZV1MHkUq13zk+4PvP6tyMsKLopx+S5ySWlqcRAr1SOm7LHyQkMuIZNKkGB15JwBuxpDEhtpJwnPIxUgcXh1bBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715125692; c=relaxed/simple;
	bh=33erqRfm50dy4WDDGbSJahdMBXSmjtcQRIZ3HCaaYI4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bKfc0BwgZZuIkk4q6snsP404JjYODPvV/GNiYfCENehWfdfoOcBoKiQLf7wQmVI5lv+2wY3twE9wYH8LjykGMXDiqYxusAn+Cr2j+kFLVQq9htacqHa3hVZOXWiQOr9WdKe3qR7ek7YfvfB9BNdWwZaLm4CP0Z+WhmmmNSBe9gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motorola.com; spf=pass smtp.mailfrom=motorola.com; dkim=pass (2048-bit key) header.d=motorola.com header.i=@motorola.com header.b=iT6AKPTN; arc=none smtp.client-ip=148.163.148.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motorola.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motorola.com
Received: from pps.filterd (m0355086.ppops.net [127.0.0.1])
	by mx0a-00823401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 447IK5Ia013400;
	Tue, 7 May 2024 23:47:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=motorola.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=DKIM202306; bh=FdxN5qFp6MoVErrH5QHe
	3LkBFgBJ9NheMIyMy9pry2s=; b=iT6AKPTNdEk+A0JNaqgm3fEsSDUBO8uEPpiz
	xlf81+kxn/PjLJIq9pwYhgFIMR2+1OjyGmIAplgekyGVU7vaiq6bQ9yyLzfFMcbs
	gr7FKl9XIf/Q9myelYIhqz4y/l/ePzfy4ZXeeOyjhTzOT8fb2o/MJ+7YwdWgq+mR
	IEbltpC9tImOwH5p+znYHz2SPNonoYrEHwZjUXt7jRq7VoqTmHxV4ShULj6qhA4Q
	+EBDbxGinmdBGFirGvqKQIK0Zp3vElkByrjsK8j9RAdndyuD0veyr5XWKzrPpvrA
	ORlLwakgpnnR31aAMs7VdKtkaOIC4+JUDvG+hMt3GSuvexx00Q==
Received: from ilclpfpp02.lenovo.com ([144.188.128.68])
	by mx0a-00823401.pphosted.com (PPS) with ESMTPS id 3xysg2res6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 May 2024 23:47:48 +0000 (GMT)
Received: from ilclmmrp02.lenovo.com (ilclmmrp02.mot.com [100.65.83.26])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ilclpfpp02.lenovo.com (Postfix) with ESMTPS id 4VYw1v4yRHzc3Hg;
	Tue,  7 May 2024 23:47:47 +0000 (UTC)
Received: from ilclasset02 (ilclasset02.mot.com [100.64.49.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: mbland)
	by ilclmmrp02.lenovo.com (Postfix) with ESMTPSA id 4VYw1v4Lv1z3p6jp;
	Tue,  7 May 2024 23:47:47 +0000 (UTC)
Date: Tue, 7 May 2024 18:47:46 -0500
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
        Puranjay Mohan <puranjay12@gmail.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>
Subject: [PATCH bpf-next v3 3/3] arm64/cfi,bpf: Use DEFINE_CFI_TYPE in arm64
Message-ID: <zpdzbgzewk2lv5fi2xcvxqhmuwrodyxbbv2uljqrgqpehwhkb4@sj75h45n2wn7>
References: <fhdcjdzqdqnoehenxbipfaorseeamt3q7fbm7ghe6z5s2chif5@lrhtasolawud>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fhdcjdzqdqnoehenxbipfaorseeamt3q7fbm7ghe6z5s2chif5@lrhtasolawud>
X-Proofpoint-GUID: 49LzqQaurmamECirz3wumR8bOIVMTJGG
X-Proofpoint-ORIG-GUID: 49LzqQaurmamECirz3wumR8bOIVMTJGG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-07_15,2024-05-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 mlxlogscore=999 malwarescore=0 spamscore=0 phishscore=0
 clxscore=1015 lowpriorityscore=0 adultscore=0 impostorscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405070167

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
2.34.1



