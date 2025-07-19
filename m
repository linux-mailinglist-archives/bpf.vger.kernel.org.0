Return-Path: <bpf+bounces-63801-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 780FCB0AF17
	for <lists+bpf@lfdr.de>; Sat, 19 Jul 2025 11:31:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DC9B17C7B7
	for <lists+bpf@lfdr.de>; Sat, 19 Jul 2025 09:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67B65233D85;
	Sat, 19 Jul 2025 09:31:42 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA0F1CA84;
	Sat, 19 Jul 2025 09:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752917502; cv=none; b=f8+U1Qd+kjzDDgD/3M799qkVhZM7EDAa7WMATZblWx2pJWjzj9d619hfH2VMhclCGpg4sG+11WPLF9yoUyfCKT55FNntmojMHX0q/etQhAfUBLGI5pdzhW+k52r4jbPas0nDJPopQCjWmSKx0SZDHZMckRaVBpctgdlToL5hyQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752917502; c=relaxed/simple;
	bh=qTPANgJhoxN+77TcMvbQIoWCGUwfN/Vi70SixOWqH98=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=d7znqGE6D6cPXpTecvqybjlHVcgIVtWX2e1T3tm93/cAgYbXwLvvMYxtbIEVyIGqZozrDvqP8NMyBi0ayFX35kEO0hOVlGWxTX5kixIeB26bNYTPTuV8ymA2Q730EozLly0B+9zWygtwb4F8uW/2sFo0UMN0ilu7N51NtTiOLjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4bkgw11NXPzYQvFL;
	Sat, 19 Jul 2025 17:14:25 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id E446C1A10A8;
	Sat, 19 Jul 2025 17:14:23 +0800 (CST)
Received: from ultra.huawei.com (unknown [10.90.53.71])
	by APP4 (Coremail) with SMTP id gCh0CgCHURLuYXtopCAYAw--.54295S6;
	Sat, 19 Jul 2025 17:14:23 +0800 (CST)
From: Pu Lehui <pulehui@huaweicloud.com>
To: bpf@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Puranjay Mohan <puranjay@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Pu Lehui <pulehui@huawei.com>
Subject: [PATCH bpf-next 04/10] riscv: Separate toolchain support dependency from RISCV_ISA_ZACAS
Date: Sat, 19 Jul 2025 09:17:24 +0000
Message-Id: <20250719091730.2660197-5-pulehui@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250719091730.2660197-1-pulehui@huaweicloud.com>
References: <20250719091730.2660197-1-pulehui@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCHURLuYXtopCAYAw--.54295S6
X-Coremail-Antispam: 1UD129KBjvJXoWxZw17tF13Xr45Kw4DZr17trb_yoW5Xr4Upr
	4IkrZ5KrykCFy2qrZYyryDWr1kXws7W343Kw4UW345JFW0y3y0qr90v3WfuryqqFWIvrWS
	9F1fur1fZa1jkaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPSb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
	xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
	z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2
	AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAq
	x4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6r
	W5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF
	7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI
	0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7I
	U0sqXPUUUUU==
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/

From: Pu Lehui <pulehui@huawei.com>

RV64 bpf is going to support ZACAS instructions. Let's separate
toolchain support dependency from RISCV_ISA_ZACAS.

Signed-off-by: Pu Lehui <pulehui@huawei.com>
---
 arch/riscv/Kconfig               | 1 -
 arch/riscv/include/asm/cmpxchg.h | 6 ++++--
 arch/riscv/kernel/setup.c        | 1 +
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index d71ea0f4466f..191b5d372fdf 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -717,7 +717,6 @@ config TOOLCHAIN_HAS_ZACAS
 
 config RISCV_ISA_ZACAS
 	bool "Zacas extension support for atomic CAS"
-	depends on TOOLCHAIN_HAS_ZACAS
 	depends on RISCV_ALTERNATIVE
 	default y
 	help
diff --git a/arch/riscv/include/asm/cmpxchg.h b/arch/riscv/include/asm/cmpxchg.h
index 0b749e710216..4f4f389282b8 100644
--- a/arch/riscv/include/asm/cmpxchg.h
+++ b/arch/riscv/include/asm/cmpxchg.h
@@ -133,6 +133,7 @@
 ({										\
 	if (IS_ENABLED(CONFIG_RISCV_ISA_ZABHA) &&				\
 	    IS_ENABLED(CONFIG_RISCV_ISA_ZACAS) &&				\
+	    IS_ENABLED(CONFIG_TOOLCHAIN_HAS_ZACAS) &&				\
 	    riscv_has_extension_unlikely(RISCV_ISA_EXT_ZABHA) &&		\
 	    riscv_has_extension_unlikely(RISCV_ISA_EXT_ZACAS)) {		\
 		r = o;								\
@@ -180,6 +181,7 @@
 		       r, p, co, o, n)					\
 ({									\
 	if (IS_ENABLED(CONFIG_RISCV_ISA_ZACAS) &&			\
+	    IS_ENABLED(CONFIG_TOOLCHAIN_HAS_ZACAS) &&			\
 	    riscv_has_extension_unlikely(RISCV_ISA_EXT_ZACAS)) {	\
 		r = o;							\
 									\
@@ -315,7 +317,7 @@
 	arch_cmpxchg_release((ptr), (o), (n));				\
 })
 
-#if defined(CONFIG_64BIT) && defined(CONFIG_RISCV_ISA_ZACAS)
+#if defined(CONFIG_64BIT) && defined(CONFIG_RISCV_ISA_ZACAS) && defined(CONFIG_TOOLCHAIN_HAS_ZACAS)
 
 #define system_has_cmpxchg128()        riscv_has_extension_unlikely(RISCV_ISA_EXT_ZACAS)
 
@@ -351,7 +353,7 @@ union __u128_halves {
 #define arch_cmpxchg128_local(ptr, o, n)					\
 	__arch_cmpxchg128((ptr), (o), (n), "")
 
-#endif /* CONFIG_64BIT && CONFIG_RISCV_ISA_ZACAS */
+#endif /* CONFIG_64BIT && CONFIG_RISCV_ISA_ZACAS && CONFIG_TOOLCHAIN_HAS_ZACAS */
 
 #ifdef CONFIG_RISCV_ISA_ZAWRS
 /*
diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
index 14888e5ea19a..348b924bbbca 100644
--- a/arch/riscv/kernel/setup.c
+++ b/arch/riscv/kernel/setup.c
@@ -288,6 +288,7 @@ static void __init riscv_spinlock_init(void)
 
 	if (IS_ENABLED(CONFIG_RISCV_ISA_ZABHA) &&
 	    IS_ENABLED(CONFIG_RISCV_ISA_ZACAS) &&
+	    IS_ENABLED(CONFIG_TOOLCHAIN_HAS_ZACAS) &&
 	    riscv_isa_extension_available(NULL, ZABHA) &&
 	    riscv_isa_extension_available(NULL, ZACAS)) {
 		using_ext = "using Zabha";
-- 
2.34.1


