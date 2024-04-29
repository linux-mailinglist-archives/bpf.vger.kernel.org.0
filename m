Return-Path: <bpf+bounces-28197-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE6DC8B65D5
	for <lists+bpf@lfdr.de>; Tue, 30 Apr 2024 00:38:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 835A1283650
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 22:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35F24179AF;
	Mon, 29 Apr 2024 22:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fkUj+Vww"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C9318AE0;
	Mon, 29 Apr 2024 22:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714430302; cv=none; b=VRtdwUMVZ/vPnmQxmD0gRLpX6PhrEvu2Nc6wmbxIOYiCa3dvtXcfIatPlkz4/Nt+M3fC7mtiAWKCNWgYC0n7qxk7lC/kEWDv5uhlVeTt1/B4dGkDLGOmLUTyJB0FRHvtt4TX+m3Jjkkhegng36t7LtweP9FZJObrR7o1hDovyOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714430302; c=relaxed/simple;
	bh=xKSgPHsvpg4uHUdIyUyQAu2reqjkMEeFFZFRS6mNbsg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aay2YeshwItL20xVv8re65vhB1UkPs/ISiwC7lLxXd3WvTdn8L1okOjpJh4l+BZ0OzjMg2d3U7XxlLN25kPO8XVGO7BHQZ8bNW5s0vDHLgUTowtic9N5JBVfmcHWVdvUqQd3NBZCRuHSFvAGu4ej+svo3ZlPWhLls86hgu/+7hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fkUj+Vww; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6ed01c63657so4907318b3a.2;
        Mon, 29 Apr 2024 15:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714430300; x=1715035100; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bdhabLT6nTkxL6jzCSqVatZTAki9S+/Xpea+1MAPm0I=;
        b=fkUj+VwwsX1a1lGIUXb0X45LAuABKFPNVc8IQO14Zp1H/ok/AG9wMUl7cH+wB9DcN1
         ba90W1xIoBzhBOoldC+El0vci58EH+Ff2wzqNY7/c4oNkWUKJOPSw5QwxCsK2aOCjLoC
         +6109nQABeUnvi/TlwiYxhyv7QM1jiVUb/YfL/ucOC7Nq3HnKg3Q75/RDtx9DfMeLlSF
         1q/D6fFL+YmTwrvMTcXw6+PKH2fe2YufMA+dGNs5dbIz2ItzsQA8yGij85S/lV3D+4BZ
         Hf8q+a6hEDODUuxgjQWZYMYVxHVa/QU2uaL09EIQ0v671D7K6Hbn4hBAnqIhXIDZDYG0
         oTEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714430300; x=1715035100;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bdhabLT6nTkxL6jzCSqVatZTAki9S+/Xpea+1MAPm0I=;
        b=j2+dTDiCzd9ftzuY4loxT1/QPXfJoCq68JmjXQqzxpaI97OzJsIjLBTT0QcpPdjl9F
         coKedLcCD3Fek3ZPhH/Hw5Pu9jTBX6NNg0DTdWRs/OUfYrSzNN6yq3DZoMwPpsyrwZrY
         UkhnS/0vvP66foBkrHGNvQ3Pd26U5dORhg7IfC5DeKYynLuI7HaWBp3m0uI4qAxSEpok
         fZZfuQUf/QOq43OrlCuQTERJ6L5vDMWok3QHrguXyinTPgY8dr8wU8IDHJfoB1yWH0M6
         96wL7yYeSe6bvGpV+/GcchCmU51QCH7JeuaYBcd5Vy7lcKa709WaXyLeacvwOqW/pNkf
         JYOg==
X-Forwarded-Encrypted: i=1; AJvYcCV9ciysss7p3ikk7hsGnbCrWjJKJgK7FP7MRUgsuTJxky9ZjvXUphpOEWk4MHIywfF6AfAv1g6EUtfvH5/d4aViyqPt
X-Gm-Message-State: AOJu0YzuaZ84qacJazKkzxa4gU6Q73zkWpFUqvnhJTJR+TA8oqrpDxkZ
	415VpSAge0CHAb6+5X3DsXYjis1RoiYS7mrkDPnRUEknhEZ54wXTpnra9lpmjdQyVwqhCFYH+QT
	XhhYYqJDZR0CYf4DiWhsgXKd3iLU1sQ==
X-Google-Smtp-Source: AGHT+IEZJjsFEDlD43tRFyS5jidT7UTbMAmocx6hc/hfqh6b95vldDCLAVUUG4d5itIpFKUdFdPlQ1kNa6DzZun+0kE=
X-Received: by 2002:a05:6300:640b:b0:1a7:7306:3677 with SMTP id
 jr11-20020a056300640b00b001a773063677mr7394514pzc.25.1714430300586; Mon, 29
 Apr 2024 15:38:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240425000211.708557-1-andrii@kernel.org>
In-Reply-To: <20240425000211.708557-1-andrii@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 29 Apr 2024 15:38:08 -0700
Message-ID: <CAEf4Bza9X_yp84ujDMwGengK1wTPjwZhtH7aXtPfXj6eT1M5Eg@mail.gmail.com>
Subject: Re: [PATCH RFC] rethook: inline arch_rethook_trampoline_callback() in
 assembly code
To: Andrii Nakryiko <andrii@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, rostedt@goodmis.org, 
	mhiramat@kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 24, 2024 at 5:02=E2=80=AFPM Andrii Nakryiko <andrii@kernel.org>=
 wrote:
>
> At the lowest level, rethook-based kretprobes on x86-64 architecture go
> through arch_rethoook_trampoline() function, manually written in
> assembly, which calls into a simple arch_rethook_trampoline_callback()
> function, written in C, and only doing a few straightforward field
> assignments, before calling further into rethook_trampoline_handler(),
> which handles kretprobe callbacks generically.
>
> Looking at simplicity of arch_rethook_trampoline_callback(), it seems
> not really worthwhile to spend an extra function call just to do 4 or
> 5 assignments. As such, this patch proposes to "inline"
> arch_rethook_trampoline_callback() into arch_rethook_trampoline() by
> manually implementing it in an assembly code.
>
> This has two motivations. First, we do get a bit of runtime speed up by
> avoiding function calls. Using BPF selftests's bench tool, we see
> 0.6%-0.8% throughput improvement for kretprobe/multi-kretprobe
> triggering code path:
>
> BEFORE (latest probes/for-next)
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> kretprobe      :   10.455 =C2=B1 0.024M/s
> kretprobe-multi:   11.150 =C2=B1 0.012M/s
>
> AFTER (probes/for-next + this patch)
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> kretprobe      :   10.540 =C2=B1 0.009M/s (+0.8%)
> kretprobe-multi:   11.219 =C2=B1 0.042M/s (+0.6%)
>
> Second, and no less importantly for some specialized use cases, this
> avoids unnecessarily "polluting" LBR records with an extra function call
> (recorded as a jump by CPU). This is the case for the retsnoop ([0])
> tool, which relies havily on capturing LBR records to provide users with
> lots of insight into kernel internals.
>
> This RFC patch is only inlining this function for x86-64, but it's
> possible to do that for 32-bit x86 arch as well and then remove
> arch_rethook_trampoline_callback() implementation altogether. Please let
> me know if this change is acceptable and whether I should complete it
> with 32-bit "inlining" as well. Thanks!
>
>   [0] https://nakryiko.com/posts/retsnoop-intro/#peering-deep-into-functi=
ons-with-lbr
>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  arch/x86/kernel/asm-offsets_64.c |  4 ++++
>  arch/x86/kernel/rethook.c        | 37 +++++++++++++++++++++++++++-----
>  2 files changed, 36 insertions(+), 5 deletions(-)
>
> diff --git a/arch/x86/kernel/asm-offsets_64.c b/arch/x86/kernel/asm-offse=
ts_64.c
> index bb65371ea9df..5c444abc540c 100644
> --- a/arch/x86/kernel/asm-offsets_64.c
> +++ b/arch/x86/kernel/asm-offsets_64.c
> @@ -42,6 +42,10 @@ int main(void)
>         ENTRY(r14);
>         ENTRY(r15);
>         ENTRY(flags);
> +       ENTRY(ip);
> +       ENTRY(cs);
> +       ENTRY(ss);
> +       ENTRY(orig_ax);
>         BLANK();
>  #undef ENTRY
>
> diff --git a/arch/x86/kernel/rethook.c b/arch/x86/kernel/rethook.c
> index 8a1c0111ae79..3e1c01beebd1 100644
> --- a/arch/x86/kernel/rethook.c
> +++ b/arch/x86/kernel/rethook.c
> @@ -6,6 +6,7 @@
>  #include <linux/rethook.h>
>  #include <linux/kprobes.h>
>  #include <linux/objtool.h>
> +#include <asm/asm-offsets.h>
>
>  #include "kprobes/common.h"
>
> @@ -34,10 +35,36 @@ asm(
>         "       pushq %rsp\n"
>         "       pushfq\n"
>         SAVE_REGS_STRING
> -       "       movq %rsp, %rdi\n"
> -       "       call arch_rethook_trampoline_callback\n"
> +       "       movq %rsp, %rdi\n" /* $rdi points to regs */
> +       /* fixup registers */
> +       /* regs->cs =3D __KERNEL_CS; */
> +       "       movq $" __stringify(__KERNEL_CS) ", " __stringify(pt_regs=
_cs) "(%rdi)\n"
> +       /* regs->ip =3D (unsigned long)&arch_rethook_trampoline; */
> +       "       movq $arch_rethook_trampoline, " __stringify(pt_regs_ip) =
"(%rdi)\n"
> +       /* regs->orig_ax =3D ~0UL; */
> +       "       movq $0xffffffffffffffff, " __stringify(pt_regs_orig_ax) =
"(%rdi)\n"
> +       /* regs->sp +=3D 2*sizeof(long); */
> +       "       addq $16, " __stringify(pt_regs_sp) "(%rdi)\n"
> +       /* 2nd arg is frame_pointer =3D (long *)(regs + 1); */
> +       "       lea " __stringify(PTREGS_SIZE) "(%rdi), %rsi\n"

BTW, all this __stringify() ugliness can be avoided if we move this
assembly into its own .S file, like lots of other assembly functions
in arch/x86/kernel subdir. That has another benefit of generating
better line information in DWARF for those assembly instructions. It's
lots more work, so before I do this, I'd like to get confirmation that
this change is acceptable in principle.

> +       /*
> +        * The return address at 'frame_pointer' is recovered by the
> +        * arch_rethook_fixup_return() which called from this
> +        * rethook_trampoline_handler().
> +        */
> +       "       call rethook_trampoline_handler\n"
> +       /*
> +        * Copy FLAGS to 'pt_regs::ss' so we can do RET right after POPF.
> +        *
> +        * We don't save/restore %rax below, because we ignore
> +        * rethook_trampoline_handler result.
> +        *
> +        * *(unsigned long *)&regs->ss =3D regs->flags;
> +        */
> +       "       mov " __stringify(pt_regs_flags) "(%rsp), %rax\n"
> +       "       mov %rax, " __stringify(pt_regs_ss) "(%rsp)\n"
>         RESTORE_REGS_STRING
> -       /* In the callback function, 'regs->flags' is copied to 'regs->ss=
'. */
> +       /* We just copied 'regs->flags' into 'regs->ss'. */
>         "       addq $16, %rsp\n"
>         "       popfq\n"
>  #else
> @@ -61,6 +88,7 @@ asm(
>  );
>  NOKPROBE_SYMBOL(arch_rethook_trampoline);
>
> +#ifdef CONFIG_X86_32
>  /*
>   * Called from arch_rethook_trampoline
>   */
> @@ -70,9 +98,7 @@ __used __visible void arch_rethook_trampoline_callback(=
struct pt_regs *regs)
>
>         /* fixup registers */
>         regs->cs =3D __KERNEL_CS;
> -#ifdef CONFIG_X86_32
>         regs->gs =3D 0;
> -#endif
>         regs->ip =3D (unsigned long)&arch_rethook_trampoline;
>         regs->orig_ax =3D ~0UL;
>         regs->sp +=3D 2*sizeof(long);
> @@ -92,6 +118,7 @@ __used __visible void arch_rethook_trampoline_callback=
(struct pt_regs *regs)
>         *(unsigned long *)&regs->ss =3D regs->flags;
>  }
>  NOKPROBE_SYMBOL(arch_rethook_trampoline_callback);
> +#endif
>
>  /*
>   * arch_rethook_trampoline() skips updating frame pointer. The frame poi=
nter
> --
> 2.43.0
>

