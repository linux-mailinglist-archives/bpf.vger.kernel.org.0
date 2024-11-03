Return-Path: <bpf+bounces-43845-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8D0B9BA7AB
	for <lists+bpf@lfdr.de>; Sun,  3 Nov 2024 20:35:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 364E81F219C9
	for <lists+bpf@lfdr.de>; Sun,  3 Nov 2024 19:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 099B0189F37;
	Sun,  3 Nov 2024 19:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U9YVOaym"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1179175D45
	for <bpf@vger.kernel.org>; Sun,  3 Nov 2024 19:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730662523; cv=none; b=jOochxY5vWerFXBnUley9EdxA7PZHmyr+Bl/DouJOg2qfB6Kle8sk4v7Y2X7qg4KBxZo1ZZOBECNxXE1jAslzJUL1+xav9pHtQLKN7hIYnWcmUGk1IAhPWvS2mNdYJU77UuPywFhv6pMOtVl76TUmbaLovyx9N/7DpPZCzFPBKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730662523; c=relaxed/simple;
	bh=1HXCG3nTLc7zR8zdspgk2xsHWUxX+SKe9U3lnmN6z60=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i3osWtUa4h4hHEQ8cG8xmianVxpYgGsyKBGc9lJURH6CZLwDQGxqrDoOG0eiNBiCHTSg1kMlffXmSRRha1bTMSWgq1eWfs7A7+12GHJgryj6ksKJl7Ym+Z18wD4o9EYz+NfcKEx0daoghlpMCRgE81cqBmgYdZ+OLSXuZTmHy28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U9YVOaym; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-4314f38d274so43900005e9.1
        for <bpf@vger.kernel.org>; Sun, 03 Nov 2024 11:35:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730662520; x=1731267320; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tKuf0piAxx3HVnImVjpuo//lYXPD5MuJPh3iJyvRmQ4=;
        b=U9YVOaym8iBhXaMMJQUz4Ak5LYt7RiC+9XRmP6InD/boNV+C7XXCdiqVsuCdPAC/OT
         lPCrsHKHIspPNKNmq3qvVOBhx8QvdrJT3D5snxOuKAiRzWWVpQL3i7o9/0NkkRuhAiFG
         KUxsJ+I/sf6TjoyImfBYmKQh4DchhjGMxn/4706Kk6FyxH+l/4rmFHVNS2aXl1Pb3tNQ
         28NSY+A9PrWU9aGie7wSS4XTO6KcF3Wun8b643Wo2paqi1xn0yxj0MQneOC7WNZOleA0
         7fdjUJ3pfbQOWcJhDy5Gu3pCj1oQsifnVL0GA03tZcsDwXYSu0W/UlUxU+RLMhkgh2pW
         8ZgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730662520; x=1731267320;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tKuf0piAxx3HVnImVjpuo//lYXPD5MuJPh3iJyvRmQ4=;
        b=JUbwTfR2ujUl9HPYJV2SeJ2CRfisHsqlaWtZf7h6d6EqXLsoQoaG/kiIgh6g6DGmBH
         A2hpYlNFCbGJpCQKoXygTCX9E4SW2Dathw+RoJojGud7ts4tnQtkPwIk8hiZmw61WI61
         8XEC0tYJ4PUUmoPOMWUDDrhrYwNBK/NHNywjhpTDhQ5lPbsZcQ+6VpavE/LZlG/AQoTp
         M4w+krkJaCMea9TQUjtQuDvNb++6Vg+RQubJwBblApH4V16+gPkRE1PSEwL+Y5eEJm4b
         fFEaO8JhmFdm7z47DjMfCkEhqQQhfluuv8O94c/elCipFpbb/jPvWC6Y7wyZN0AY91YD
         GxTg==
X-Gm-Message-State: AOJu0YxtKPCo2mNYw3/Mgu687om743d7WjJCT8rd8Ef/0QXw14GeBRwD
	SO8ekV5VzjDxInBGqKikWK+jSpCUkdYxmCLFvRtZjpOkunXmn+wuUl3ZPKIy/BM3qA==
X-Google-Smtp-Source: AGHT+IGkSKwVVKFCfxgnTcqoxre81NbZndQpdbUfb7NuEFa2a9cdJOsEanClHaH/oxeoudx7CDK61w==
X-Received: by 2002:a05:600c:4683:b0:431:5ba1:a520 with SMTP id 5b1f17b1804b1-432942dd802mr38288695e9.3.1730662518308;
        Sun, 03 Nov 2024 11:35:18 -0800 (PST)
Received: from localhost (fwdproxy-cln-016.fbsv.net. [2a03:2880:31ff:10::face:b00c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431bd8e9145sm160603235e9.1.2024.11.03.11.35.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Nov 2024 11:35:17 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: kkd@meta.com,
	Puranjay Mohan <puranjay@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Rishabh Iyer <rishabh.iyer@berkeley.edu>,
	Sanidhya Kashyap <sanidhya.kashyap@epfl.ch>,
	x86@kernel.org,
	kernel-team@fb.com
Subject: [PATCH bpf-next v3 1/2] x86: Perform BPF exception fixup in do_user_addr_fault
Date: Sun,  3 Nov 2024 11:35:11 -0800
Message-ID: <20241103193512.4076710-2-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241103193512.4076710-1-memxor@gmail.com>
References: <20241103193512.4076710-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3013; h=from:subject; bh=1HXCG3nTLc7zR8zdspgk2xsHWUxX+SKe9U3lnmN6z60=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnJ8wNJpmWYQgs2zmTqWQ+16u+4dc30s6k6QyeMWqQ ejFeS6OJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZyfMDQAKCRBM4MiGSL8RypCFD/ 0er51/TVp6u82UCrtbFrIWSdhFBfnv+Q14bfLFbjFd1/ruILK9Hfo4/z+8M5m/ngoh0BeWr9zLaGuA YBzYCDp7PSLj+FBA7ANAeQOgr3tG2q7PJVP/avdAxfMg2W4fAdjB3ISJBNh1B9IN0l9/dm3GFQUq0C hOUuiNhGaWxcxTrqM2sho27OJnAeCC6JgALXOFja49FqGA3rqrN3so8hnTA8digiFkFrKjbJPBkvE5 wkxiEkUbKGdn7k3cijYLdkOj/Fspdbh/lTk8fG6JSmVKB+HJw8cFlW2KrKkVkys1zDczeL4KOED0pI jebGQKkqTFVy5cRPqw5ph6eIHD0z2wDexFNxHIcvH9xHuC4T+NmJ/CBTQFxl64uW4OjUjAU7+axZw0 A2q3l9gkAGyk2UtbFISCAdqOZJr8npTmK5p0cvXvhPXSJ2Itaa+cDk+IcbncxQWxDPTNaDPL1v9wls +GVTS9e0ZcJQKjphDt2W5yBmLtDj+i/tnME8N0edPn2TwPL6rNBPdTetrZUuPR4/jd3gmbRwkX+axC rPOb/ebEyfzW16SCfXtHfjdLusiCB4jmXJjFPK0aAn/OARQweAyBzTP10doCDtAYpDdy85WUFbUViA yDyJtniwAmLeNFYPX2A2qnD6G8HrESOEOYLPweq1pmRNKn4jQ4Amjlqp//UQ==
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

Acked-by: Puranjay Mohan <puranjay@kernel.org>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 arch/x86/mm/fault.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index e6c469b323cc..189e93d88bd4 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -21,6 +21,7 @@
 #include <linux/mm_types.h>
 #include <linux/mm.h>			/* find_and_lock_vma() */
 #include <linux/vmalloc.h>
+#include <linux/filter.h>		/* is_bpf_text_address()	*/
 
 #include <asm/cpufeature.h>		/* boot_cpu_has, ...		*/
 #include <asm/traps.h>			/* dotraplinkage, ...		*/
@@ -1257,6 +1258,16 @@ void do_user_addr_fault(struct pt_regs *regs,
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
2.43.5


