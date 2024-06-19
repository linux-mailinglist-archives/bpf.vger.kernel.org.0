Return-Path: <bpf+bounces-32509-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DCBEC90E6D6
	for <lists+bpf@lfdr.de>; Wed, 19 Jun 2024 11:22:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 656671F21CE6
	for <lists+bpf@lfdr.de>; Wed, 19 Jun 2024 09:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83C738005B;
	Wed, 19 Jun 2024 09:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BV5DdU4Q"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f196.google.com (mail-lj1-f196.google.com [209.85.208.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60FD679DC7
	for <bpf@vger.kernel.org>; Wed, 19 Jun 2024 09:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718788944; cv=none; b=Fu0DTzYJK9l/CNLP0HoHNm9BH0uV1vEqih7SLtNsYQL/8/HjZBijoU+hXseh2oxZ8E1My96f8ABPGg27PTZqQ3OhdbhjQp6NLhm8ghxQbDsQEjuIhs32Kt+UriO9JHufXHMI974LIQiCoVF7fPjWcmmGLhtNolDXMy4fnGEpqiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718788944; c=relaxed/simple;
	bh=mY5SBIVa14u2VjPWIp7hVxyy5bTzHfSg1McACT/etHc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VvcBEdxBuIwUInZui+W1rpqwO3x+pHw4OtdlQlJjzxUqShm29LaDQIY1SyeeTJ+MXEGgGp7y+V+Ct9zritRhYWyFZTbEbPSdQBSRkvEAQBtHMUitLCmzupHJV6RAHqtXTUJL33Xkp7n7gphV3L9iBDjG6Uap5X/u8ONKg+HY0s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BV5DdU4Q; arc=none smtp.client-ip=209.85.208.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f196.google.com with SMTP id 38308e7fff4ca-2ebe785b234so63314541fa.1
        for <bpf@vger.kernel.org>; Wed, 19 Jun 2024 02:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718788940; x=1719393740; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M619BJr1wfMGHjyjRuE2IRDAIUZLIDAA97Lw+i23gJk=;
        b=BV5DdU4QAD9/WH9wSW2SW4J7XUfzLMg6ZSWyew9XkgWreDpbfa0dNu2jvkFxv8fUVO
         RRxNc65+10wBxPEJZcFXnbg+h0mJE0Ovx4CtTnRoqY9gOjqaGWsQfYNUuF4gZkCQ0Nog
         K/bJJm8EC4eAJHqDSTdba6uKShOV5cOUp9pQAECf1LJMgXuSZi1y89FQ4oRiX6ZxUkJn
         cQ0eK1zmkWnI806+8tsQpg5mBTgidwVuts5rGW5w8YRgATsx6sqa+4srN/pf0+5Y34Eh
         NZgTho7zfTwobDHOAeUwlPkSe1KmSoCFxOrHbnohoBxfZ5ncE023ChKFe0zkkxL+XO7b
         ZN2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718788940; x=1719393740;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M619BJr1wfMGHjyjRuE2IRDAIUZLIDAA97Lw+i23gJk=;
        b=NXlP2QLpZyQBGUPk1xi4VGQe2NLStJUFfSlmCJUDVLVqdR8jMeb4qBlruYW0r5oLqv
         Amu3WYmu/1+kvpQUknWEj3aO0tbIsGXnP9fwV/GsYsBN4YuZWXxTQ2Fgg9iyqaoHzCrV
         q3kCszi6m/d9NTzoR3vj7gfXP5Ao7bgxCPKOgDzeD0+Hi/LNCq9cjXiYHQEW/9aThf9/
         ACUloVZXPlGqurCQ3N1L+DUOf+yVbY7xAGCY3Z/M0r3Y7SnmjKGVw38nFggM8x7ImqXn
         gsXzxFLiFIidY+ML3zlkBIdKiIl7QqXNzbe2xIoc5BEIuSpE5P6JrZBqdVdMvL8y56LC
         HFgg==
X-Gm-Message-State: AOJu0Yx5C+tiJZ2DjcqJJnlNPvBCMBeLrI2fhiLlsVsMcCHtUdeEIImk
	ghMziFgh+Zonp/plvARQMF8KwX6gBmaWPlKA5nqRF4C8qPeC7CIlFYUczdpE
X-Google-Smtp-Source: AGHT+IHIhDmykuO7OTR09KFRKgWaiwEc7Nv2jcXLOO48baXdhcxciBC4Bzv+SQt1W9QeldA13fg2lg==
X-Received: by 2002:a2e:2416:0:b0:2ec:1042:fb02 with SMTP id 38308e7fff4ca-2ec3cea5765mr16171261fa.8.1718788939631;
        Wed, 19 Jun 2024 02:22:19 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422870e9676sm255312915e9.24.2024.06.19.02.22.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 02:22:18 -0700 (PDT)
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
	"H. Peter Anvin" <hpa@zytor.com>,
	Rishabh Iyer <rishabh.iyer@berkeley.edu>,
	Sanidhya Kashyap <sanidhya.kashyap@epfl.ch>
Subject: [PATCH bpf-next v2 1/2] x86: Perform BPF exception fixup in do_user_addr_fault
Date: Wed, 19 Jun 2024 09:22:15 +0000
Message-ID: <20240619092216.1780946-2-memxor@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240619092216.1780946-1-memxor@gmail.com>
References: <20240619092216.1780946-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2965; i=memxor@gmail.com; h=from:subject; bh=mY5SBIVa14u2VjPWIp7hVxyy5bTzHfSg1McACT/etHc=; b=owEBbQKS/ZANAwAKAUzgyIZIvxHKAcsmYgBmcqMXCedlnqJwMQhJ6Hv4aBvbkxoXFOpWeO6nQ s2OQVPhaBWJAjMEAAEKAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZnKjFwAKCRBM4MiGSL8R ymULD/wI69aqIShM0H4jjq3JBkDpMT9RoUADPyMFTS91TvH8rgMizwtWUZeEac4pdUHzzqMNgFK 2MrnPcwRSNR5prerJjeRSbt6JJjd7GJ1PqLCFol8extbvfdufft4suV7ZbOPyMtOLSdWuQQCGMp bslQi9Smwlf9zh2qiQaUCpLxLBCWCkkoIKOwYNeNFvDbkX6h9qNFTztqU5oM/0WsOKvKi8DnQuf 7GixjGHPiJDlSp+AxagNG/oNEN/h4nCktZkbSZhpU/+uH+hA1zYQr02gfecr+Hf8LaDbI9fC2Ia gjNYuAskmP/+faMIMiM3AQpqrPw3h8tqx0flLn3A8SFh0l1uOh8koPydZ/l1jKAra3f+y2UQB9j l+NmX23tdRdsc2L8i/3Jfim+zSPgeWi4crqAdDiVKM9CeuIVbsM9SKvuCygLKzROxPzl2oUrIDD OWehKcinuBqNRoZzhHMxSmTL7z+uJN4AM4Hh4MqydTqYxorBxXVoHNYpDKB3/aXb3kmO74c3ooI /ahPT3GfSr4/HBkgh7MwPaHotEDTk/76GP7F33QPN2R8MMVYc23xQ3NqxDgBOuMDY/c+/Mvcvc0 QGVScEpvbwqgBS969k2N1Y2auJSmJ4wf1NmtE2cDwwgZxA4Mb2Ob53uQdcsm0r4Z+j9QiG3Dq7W qkprKuuhqBOLAcA==
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
2.43.0


