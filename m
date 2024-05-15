Return-Path: <bpf+bounces-29810-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CE418C6F45
	for <lists+bpf@lfdr.de>; Thu, 16 May 2024 01:39:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 238661F2330F
	for <lists+bpf@lfdr.de>; Wed, 15 May 2024 23:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7535E50297;
	Wed, 15 May 2024 23:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MEi1is/+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f66.google.com (mail-ej1-f66.google.com [209.85.218.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76DDD4D9F2
	for <bpf@vger.kernel.org>; Wed, 15 May 2024 23:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715816383; cv=none; b=hq8gU8Fc0sOLwqXZSxIYiMwNjm1vX3HIQUhFf7XYHWRyickifXICghzS+cMZ2nYpFbPJzmRzSKNH9/5cAH1Nk9pgAEKbKVhRAcBp1vaRjcHW0NovFlWC7dH8yS7ndhWK+hznw6s3QhMrENowY9637EdOtVBCphPKCAd71Q8sGxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715816383; c=relaxed/simple;
	bh=5MvUSEn9J+PjSdBO3utcE/+7IsYnvJ85wSQvwltCY7c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nl4RiB4IKOT9jq26H/Xr8ZshgzVrtjkrMbPRyPRbSLuM9M9/iB2UqH1bV4xaFP8OYtjQRpEryAx5grQOfmE1UTDQV/vP99Bfxuqi0dHJrnibfotBpnJL+puBSH0E3G0O337J7ZvZnp08yzkUKrS3qlZYhyoBqYG382NwUCGLeLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MEi1is/+; arc=none smtp.client-ip=209.85.218.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f66.google.com with SMTP id a640c23a62f3a-a59a0e4b773so240094666b.2
        for <bpf@vger.kernel.org>; Wed, 15 May 2024 16:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715816379; x=1716421179; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oi3VKQi+kfCeBqE0u8yX5xl5ALnD9Yf93ry4CDZhVYA=;
        b=MEi1is/+sp1W86eXy0Q+pA0c/LFevS0Nke7oXZkdnMKGGS/3cw9AU23upg4LRrEhAt
         HD9PvoQAoIdFSthPQGIFgOy76FKri5T5HaXNM/evb4Jblfm/jQsU1BRX8l+I4DZMxA5k
         JspYrIHxaWof+HWucUpWrVI6K27VUfi+k0F/5hIKGztsfpoIkpWuzzRLql8Cc1qu64Ia
         zGCxFwZIEUuC3Oml4hDKu3oIqsogeL8RJtrdqykZ2TFE+ewnCaJnQCITDMEq0bg/FAlK
         ta7A38bEkrwLc7mhEdRwQWxceBTNqyseselLYjcxqfaKaBApp4Iy32FKiewbl2RTC1/K
         bLcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715816380; x=1716421180;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oi3VKQi+kfCeBqE0u8yX5xl5ALnD9Yf93ry4CDZhVYA=;
        b=cXrb3h+nW1CdySj7JqmJ3fPIXPZCGT4ZwZFwxRTDbW7QN8M8jKbKjspLVWq5ctzQTY
         YuOeTPwCmLVnzcNRc1BKi7veSPBkZm0FPVrgIlrObE5N4t21lTpUO+pzcUyCp6gBq+nw
         zZL33I9BxbixUjxLr7Mn0q7HAG+C0zMStvxxt9ebsk5KHKkX4f2ow7/dP5lkcdrVMIUY
         yRip9sd1dG5Ar/2iBcJDh+8VrW3DgnRpDkLpyyAYk+0nLxbv3dNI37kBqx90/ooA5lij
         6tXcgiYONfLrkBhjZmTqu0rzIgXVqIhHyfoChapSY5Xo1BiF6lIYisFUSxz1zWywfpS0
         XxbQ==
X-Gm-Message-State: AOJu0Yz5NWx7ohUnGBTFqiGzIMg65P2yJfpUqIse8ZZRiwmDxmNqukNZ
	ZrpedG2l7UTRUMRbckLOA8WVq3mLejxrTEn+ZifrAmKaQGDhybk1zP9epj8n
X-Google-Smtp-Source: AGHT+IFOTEt3TUMmWXi+VGQxZd2jJqGKVRVMdMMQiSZfeh2pZR+HiPamC4V5DJzgEj/DamvajMacVw==
X-Received: by 2002:a17:906:1dd7:b0:a59:a431:f951 with SMTP id a640c23a62f3a-a5a2d665e13mr1119514766b.48.1715816379626;
        Wed, 15 May 2024 16:39:39 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a179c7e2bsm916631066b.110.2024.05.15.16.39.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 16:39:39 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Puranjay Mohan <puranjay@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH bpf-next v1 1/2] x86: Perform BPF exception fixup in do_user_addr_fault
Date: Wed, 15 May 2024 23:39:31 +0000
Message-ID: <20240515233932.3733815-2-memxor@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240515233932.3733815-1-memxor@gmail.com>
References: <20240515233932.3733815-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3005; i=memxor@gmail.com; h=from:subject; bh=5MvUSEn9J+PjSdBO3utcE/+7IsYnvJ85wSQvwltCY7c=; b=owEBbQKS/ZANAwAKAUzgyIZIvxHKAcsmYgBmRUUks+YTp5oYDU+g9+GK1KdsCxwk0doxPWh+X nQy1EuWGV2JAjMEAAEKAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZkVFJAAKCRBM4MiGSL8R ymHtD/0XJqthahOUVJNJ7AU0iBAMGjR2ky3GnGfsNe8+MVu3c9O76IGkz+Rhzewas74yoeFl4kU gPT+0wzXsRt3O2WNanu0Egeii/juFGuL48XuqVjoscru9l4io9aSxxjh9QREJbAstC/vliRtV/x ivnILZ6yfXYKNeI/Ahdq3ufBBFePIODmFo271cyujcRKxbDOoN/t209SkUiSK8A/aBzCCGDmCHU 4GIwus/dOL6SZ1eU27fXOBkHESXbCH3ZDZC4fqTwCNzq7bSt3T2W2L6bM9ugDSEF5W4eXfvyeIU zy0qFN6NASqG9hvO9vQtms4EvqsO1Fquofl7mye91dncuH3lzP91Hy5mD1sYYU4Om9JV2WI4qNo D9jo8tZnaISMHxksavINiBiPqNKtErnMqdOyBut/woA7Orz4T+e8PfOwmGISAXIXVBrgL/wVbjV bnRVSqL6W8WccxHUdBp+WdIMdI67ND9Y0P71PvGWW9MZ5exJRBwFOEXq9rtLIXLiF3pfqR5gfY2 dUW1sbpO4zziNtYzuk0NYz+SUKZlIKRsHxrgOp4d6thOiBrinYIQogXWUgbkd2cYgBaLGDr/Ul8 wVC2j8U7Ltg8zuaVAyudfUheFnF++IpwbF0OvIZPt1VxftM9B3zRD251mE2hQm2cTnqR2jaJGvo syHR3dGU9ld2hIw==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Currently, on x86, when SMAP is enabled, and a page fault occurs in
kernel mode for accessing a user address, the kernel will rightly panic
as no valid kernel code can cause such a page fault (unless buggy).
There is no valid correct kernel code that can generate such a fault,
therefore this behavior would be correct.

BPF programs that currently encounter user addresses when doing
PROBE_MEM loads (load instructions which are allowed to read any kernel
address, only available for root users) avoid a page fault by performing
bounds checking on the address.  This requires the JIT to emit a jump
over each PROBE_MEM load instruction to avoid hitting page faults.

We would prefer avoiding these jump instructions to improve performance
of programs which use PROBE_MEM loads pervasively. For correct behavior,
programs already rely on the kernel addresses being valid when they are
executing, but BPF's safety properties must still ensure kernel safety
in presence of invalid addresses. Therefore, for correct programs, the
bounds checking is an added cost meant to ensure kernel safety. If the
do_user_addr_fault handler could perform fixups for the BPF program in
such a case, the bounds checking could be eliminated, the load
instruction could be emitted directly without any checking.

Thus, in case SMAP is enabled (which would mean the kernel traps on
accessing a user address), and the instruction pointer belongs to a BPF
program, perform fixup for the access by searching exception tables.
All BPF programs already execute with SMAP protection. When SMAP is not
enabled, the BPF JIT will continue to emit bounds checking instructions.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 arch/x86/mm/fault.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index bba4e020dd64..6bd2d566d9e5 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -20,6 +20,7 @@
 #include <linux/efi.h>			/* efi_crash_gracefully_on_page_fault()*/
 #include <linux/mm_types.h>
 #include <linux/mm.h>			/* find_and_lock_vma() */
+#include <linux/filter.h>		/* is_bpf_text_address()	*/
 
 #include <asm/cpufeature.h>		/* boot_cpu_has, ...		*/
 #include <asm/traps.h>			/* dotraplinkage, ...		*/
@@ -1251,6 +1252,16 @@ void do_user_addr_fault(struct pt_regs *regs,
 	if (unlikely(cpu_feature_enabled(X86_FEATURE_SMAP) &&
 		     !(error_code & X86_PF_USER) &&
 		     !(regs->flags & X86_EFLAGS_AC))) {
+		/*
+		 * If the kernel access happened to an invalid user pointer
+		 * under SMAP by a BPF program, we will have an extable entry
+		 * here, and need to perform the fixup.
+		 */
+		if (is_bpf_text_address(regs->ip)) {
+			kernelmode_fixup_or_oops(regs, error_code, address,
+						 0, 0, ARCH_DEFAULT_PKEY);
+			return;
+		}
 		/*
 		 * No extable entry here.  This was a kernel access to an
 		 * invalid pointer.  get_kernel_nofault() will not get here.
-- 
2.43.0


