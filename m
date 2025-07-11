Return-Path: <bpf+bounces-63032-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38818B016A2
	for <lists+bpf@lfdr.de>; Fri, 11 Jul 2025 10:43:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEF041885E70
	for <lists+bpf@lfdr.de>; Fri, 11 Jul 2025 08:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C78021127D;
	Fri, 11 Jul 2025 08:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HanP6k6B"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37F61F4289;
	Fri, 11 Jul 2025 08:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752223407; cv=none; b=h7xiOeRK71asSYh2qzL3mBytiL6jmNYZgOYDlRJXoIfmUT10o5g1YWrNIGvSagUf8m72AsFRcnh/7JL097/GXYRIBUIP+moFMlR8CW2kuHzoIREXYBhVwj3mqNyl/9UYSjC0BZ3gXMoxBC9HuFmeBA/VaugDoAT2UDoymNCnMLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752223407; c=relaxed/simple;
	bh=pgLc4wdfen2ah7+WJsoZa+9SCjUBa8JFoERrQ9cbwQw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UqnSeEc4GCm734KhiaQ/HI6CioeEpeDkhazeIC1wNyY5cqsRZPNNCr1cg7IquqzVTlc5iUp9MdMdITAkO3JoPSpUxeAYH6IWpokcF35C4M3aZZu6hugrsjbFTr7LBW2WL/DBIbHbMS02t5Z2eIWm1/lixt9HWgDECAJmuiAvgZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HanP6k6B; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3a4ef2c2ef3so1440913f8f.2;
        Fri, 11 Jul 2025 01:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752223404; x=1752828204; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sr1JCZTZXretouNuvu9bNpVv7/Bdj2RVZfHckc6B8wg=;
        b=HanP6k6B61lYGSDU7P3Id/TZFqh0icz9mHP/j4dlnlgIhYeqt43Kr+Wzn5vFpb2p5k
         QISH4ybeEnoGaJSUBI/9BeUf39vwAcjdXOErs9tR000c4bWm5LwPhZkNa2amAcJNWKTu
         mdEtVdV8eMuxD/YeAoCxq8XidykzyDUPJMqoZra/nnUkce3kqiUzPnzNqunWgUM7nyNc
         uNc52MSZzl1l8WD4ad0LfvvDCgTh1EWP/HaZApuBGfhwrbc1je+dCuyUCO9X5v4mZSCs
         KRUCDhWWr33Yms5Fbex7KrWJ973wCtuk89/MUSHKJGNQCUxoDkl5htHADT4zirjlXDif
         0RKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752223404; x=1752828204;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sr1JCZTZXretouNuvu9bNpVv7/Bdj2RVZfHckc6B8wg=;
        b=xUm00ZIODZglu7LEUiSFV7OPk4bRREiosAhhQzvcPIaSylDDeSKEdZFE8uW5KPdVgy
         ZPSKE17bnXwsxHA9/DZ35JMBD8Z6s2Hrl03XUghWPc7BlfNj8OiXiJsqu20AfNkLQwB8
         Ye/QVljpmax52NLV62nFwWnSla/SscLfohSVtNwT0577hrjZfB+GHploP9kGV6eGRRTS
         bfaeBuUP/2B0mYCO18GvRWLokrXlCNjoxG7jhGBvVV+s5AelLhR2chsH6qevsavZtA6U
         semru1cmBV0e5Tkq1pqs/PmuJyFhyi9U+lOEwnSUDg2NwbBt/y4ju4fYD2uSw1n7W9dw
         lrJg==
X-Forwarded-Encrypted: i=1; AJvYcCWxV59ryvJV6wtIw93QvBewFDAKj6nzwKDKJ9rnSFN2o6TeDhtJ2hkgEcaWlUJAFbBea2I=@vger.kernel.org, AJvYcCX3BLKkOTpvFb6Kb9CW0Iu/DP/8KFtY1NZ3cog+aRoQHdpet42DEp7COf3sWL8XtRaiQUO8Fa3aTRJH6O7ffP0eyQ6B@vger.kernel.org
X-Gm-Message-State: AOJu0YxmJn88emTJlyVYGSR/GG9kSjw670y/tcpor4qqvDeVouI8CmeU
	VsHFXD9p6kpkSa0t9474ywUfTNRW3wrNT0zYSHVtoePk2ZMrXNkjKOnM
X-Gm-Gg: ASbGncvEIpmbXNOxMQ8Aa9W3tNucnqkJs5WGsCahKVzBqhqJzrUue9Mbo0kCzg1Cuf3
	MFyHrKNw5j+rv8+9aowUNAzTxv4fwm5V7G6oudKJL6v058hWHWUsyNzKFsmcHHOVTLzvuQNF4Bg
	SBl/24A7JLyaLeaTW20BWRdOfa8H4aPam82F2WtvE04IZKGb+ECJwlLVszldiUMNXr0+Kh/uwbr
	xjagIotAEcq/bUS3q5DI80iZnv6CG3T+9SNyrQCCeTzVz3zsNheZzFeLkZcjNCFTLjp9+wPzKkG
	WO9jf8v6EIhvmjrTpVAc50BH8gI29Cc83oUe0axzThtGRp1hHEXKFC7syGCloInGbyos+IufrZP
	kGtQx4+4bjxcv6dVkdzVYgxAlT2Eb2soCaSUMcAvl2KqowcoaAvaCEg==
X-Google-Smtp-Source: AGHT+IHIphwZ1YVO+sebpVREmkoXuUKb+l9PeruYveFtfD2yh9R3hj879HGuu3i2hFdm6B6ADcVk1Q==
X-Received: by 2002:a05:6000:26d0:b0:3a5:26fd:d450 with SMTP id ffacd0b85a97d-3b5f2e281c9mr1640317f8f.47.1752223404124;
        Fri, 11 Jul 2025 01:43:24 -0700 (PDT)
Received: from pumpkin (host-92-21-58-28.as13285.net. [92.21.58.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8e14d12sm3891457f8f.70.2025.07.11.01.43.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 01:43:23 -0700 (PDT)
Date: Fri, 11 Jul 2025 09:43:21 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Steven Rostedt <rostedt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org, x86@kernel.org, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Jiri Olsa
 <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Thomas Gleixner
 <tglx@linutronix.de>, Andrii Nakryiko <andrii@kernel.org>, Indu Bhagat
 <indu.bhagat@oracle.com>, "Jose E. Marchesi" <jemarch@gnu.org>, Beau
 Belgrave <beaub@linux.microsoft.com>, Jens Remus <jremus@linux.ibm.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton
 <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>, Florian Weimer
 <fweimer@redhat.com>, Sam James <sam@gentoo.org>
Subject: Re: [PATCH v13 13/14] unwind_user/x86: Enable frame pointer
 unwinding on x86
Message-ID: <20250711094321.3c64757c@pumpkin>
In-Reply-To: <20250708012359.853818537@kernel.org>
References: <20250708012239.268642741@kernel.org>
	<20250708012359.853818537@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 07 Jul 2025 21:22:52 -0400
Steven Rostedt <rostedt@kernel.org> wrote:

> From: Josh Poimboeuf <jpoimboe@kernel.org>
> 
> Use ARCH_INIT_USER_FP_FRAME to describe how frame pointers are unwound
> on x86, and enable CONFIG_HAVE_UNWIND_USER_FP accordingly so the
> unwind_user interfaces can be used.

How is that going to work?
Pretty much all x86 userspace is compiled with bp as a general
purpose register not a frame pointer.

	David

> 
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  arch/x86/Kconfig                   |  1 +
>  arch/x86/include/asm/unwind_user.h | 11 +++++++++++
>  2 files changed, 12 insertions(+)
>  create mode 100644 arch/x86/include/asm/unwind_user.h
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 71019b3b54ea..5862433c81e1 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -302,6 +302,7 @@ config X86
>  	select HAVE_SYSCALL_TRACEPOINTS
>  	select HAVE_UACCESS_VALIDATION		if HAVE_OBJTOOL
>  	select HAVE_UNSTABLE_SCHED_CLOCK
> +	select HAVE_UNWIND_USER_FP		if X86_64
>  	select HAVE_USER_RETURN_NOTIFIER
>  	select HAVE_GENERIC_VDSO
>  	select VDSO_GETRANDOM			if X86_64
> diff --git a/arch/x86/include/asm/unwind_user.h b/arch/x86/include/asm/unwind_user.h
> new file mode 100644
> index 000000000000..8597857bf896
> --- /dev/null
> +++ b/arch/x86/include/asm/unwind_user.h
> @@ -0,0 +1,11 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _ASM_X86_UNWIND_USER_H
> +#define _ASM_X86_UNWIND_USER_H
> +
> +#define ARCH_INIT_USER_FP_FRAME							\
> +	.cfa_off	= (s32)sizeof(long) *  2,				\
> +	.ra_off		= (s32)sizeof(long) * -1,				\
> +	.fp_off		= (s32)sizeof(long) * -2,				\
> +	.use_fp		= true,
> +
> +#endif /* _ASM_X86_UNWIND_USER_H */


