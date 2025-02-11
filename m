Return-Path: <bpf+bounces-51162-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DEAA1A311FB
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 17:47:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D15887A3270
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 16:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92E0525EFA2;
	Tue, 11 Feb 2025 16:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JNv3zrtu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9505325C6F1;
	Tue, 11 Feb 2025 16:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739292453; cv=none; b=KGWVgZUGRRODhxR6+WVvXIh5ZnyzdNPPtJpHGwQaDp1C1uC8s/89T5kmU1t1rwIJFU+vlsCRvYqlxnFWYxuvEoOcMy3Vb/bc1Sv2OwAycnQ0DCD6ozN45HgmgNRQzwzMPWoeO7bMVj6cL0vtuAz420nDThhuJhWy+LnJB2gxq/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739292453; c=relaxed/simple;
	bh=9qfKloJ1Sdb7kUwKMngycijFydBKVCi5IB7EhWLxtVQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u19ZVAAXZGiMTHlGz5BrlfVaoCEX1KylNih59ZQ/PQfGqqJ7MJ+mzI/NR7tNwgVzplVU8pcXR0zIj6sjnqr56bDtEes4GQHxf7R/r+4s19x/dtBRTao+5zT2WjpBYgPhAATyMVbNVQ6g/jYrydGQtsM1cqE1XiiWWPIlzBJcDBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JNv3zrtu; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-21f7f03d856so53897475ad.1;
        Tue, 11 Feb 2025 08:47:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739292451; x=1739897251; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9RUzvp1ZG0y8AnaFa56cpTK5bp8QlW6Oa2OethA2BWA=;
        b=JNv3zrtufXAtqGg3N7InBVF0BWul/O3ij5ThonjBV6FHvhfTi836Ma5II9LglP3C8j
         a3drlJGvMoMu68y4bldyNGfusCq2BI9gp8HsZQroiJzq+e58IZE5gBlIbZMkk56JhwUP
         d+VAOKICfIev+YfoWcMoTfdHzuaMAsaNfo1cM6FWpyU/xDsGRa9Vu0uKAMHuuyaJK/we
         P2U235mNz2oOFKQ9xVdikiZ7OqLa+gJ4lcilld9BVr+EpgTeEVyMSsbzNQPU1wU0ORwb
         ApB0HBkyJNOVMXEUC5Lw+24yADRUrT3kNl2ZsiJyc9hTuiM1UizT/z0whnBtPU0V7tnT
         VGqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739292451; x=1739897251;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9RUzvp1ZG0y8AnaFa56cpTK5bp8QlW6Oa2OethA2BWA=;
        b=DaKT8NfovrtL9S/QUJYErR76GH5jPfe25lCbeClw2uzscOlq89BEHaZ5+e088GM1xv
         2k9vPXgf8lZmVOF94bPzNZky3z9RUo78rw4DKa3KKNhBZwQ2LLVOgPuE01AESlOkJFZ0
         izQOgLHcF+FxPf7zAvt33db0ffWxtMwzlwhD34EThLZYIpFHG+xzENkvO4R0UJ68flXD
         NgXWF9ZGlYUQCkV0wNQ16RjPHcgc1fNxlrzwWNxMD5nTSXcIXLSz9VZwXk5CAKOEDlSf
         Y53UPZbHYSLb41l9dHyGH8FZcn32I6F/vYloFYX1WRpaae8wrSljwquZLAVnNPvb48mo
         7HFw==
X-Forwarded-Encrypted: i=1; AJvYcCUUOyBWxyQrSsolypzskRgQdkwh4fPvWXTWhhfrQ8gPvh2PMUYgvczUazotAJrZe8rftPtTWZB2@vger.kernel.org, AJvYcCVFliWoSio8QLq9NQJ+BxFq1BDvCPMb+W77PXsXBWckMMasiKOYTsJOyemO6xTA1LWJZjNa0WQkflbB@vger.kernel.org, AJvYcCVnLqVXMl/D0nlls9mv6/IIC7a7aAo4SsmTgfIbmJ0SHBToBla4k0O0ELYUeMk5gE/HUJY=@vger.kernel.org, AJvYcCWOrq+bPCBMWJgJB5rHa7sVwzk9/3e7di4c849QObyV4sXq6eeo2Emic3KsTl1tUae6KE66ACCXsgo3nYRlH3Y8cH9v@vger.kernel.org, AJvYcCXcDBk3kEyjwEShWHzzTlXJBEFYn67l9kJgPveOppnOGlHhzcVQ0LdvY35tlG+iokF3u8ullbbvIDrGRoAW@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5LGXbplhtj/aZt8dd09KM7iMpfdcHDQIMzwvbZ39g4zLt0F5S
	Q/xod1L5fsohneW/ohdCtSgpvFqkOe2zEydlgkJ5NT/LRZpakXuLx9wfRtV0yPRuh9MLo/ESkzN
	c2cOGW92RYEdN0BlYnWoliQHEgyE=
X-Gm-Gg: ASbGncs9unPnew5uhjUwwxhllmEgHSWAVq1+EuvZZmORx23v4uu0F+6xI/SFamRg3yF
	zcb8WnsZhe4zZlWU8fV0fYMs4Gt326XrAqAdRIBmzmMP9NG/Rd5pJfP1R5HlD3dlxmYjHr/+IoN
	hz3d/q4rLdX3W7
X-Google-Smtp-Source: AGHT+IEELJ655DrjeaM+rroctVnf4elYF5IHZCLHCw4dEP2dpIbZwF+siQVA2GTnQaJTu2aqS+be48SXQ+7EaUjBAOA=
X-Received: by 2002:aa7:8894:0:b0:730:9752:d02a with SMTP id
 d2e1a72fcca58-7309752d29dmr9553456b3a.4.1739292450533; Tue, 11 Feb 2025
 08:47:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250211111559.2984778-1-jolsa@kernel.org>
In-Reply-To: <20250211111559.2984778-1-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 11 Feb 2025 08:47:18 -0800
X-Gm-Features: AWEUYZlR5xmU_PonJ8aeN81Mk0X1T2Cpls2DEXwC15pznh_L4ZPcGMH7kF4zKRI
Message-ID: <CAEf4BzYPmtUirnO3Bp+3F3d4++4ttL_MZAG+yGcTTKTRK2X2vw@mail.gmail.com>
Subject: Re: [PATCHv2 perf/core] uprobes: Harden uretprobe syscall trampoline check
To: Jiri Olsa <jolsa@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Kees Cook <kees@kernel.org>, Eyal Birger <eyal.birger@gmail.com>, 
	stable@vger.kernel.org, Jann Horn <jannh@google.com>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-api@vger.kernel.org, x86@kernel.org, 
	bpf@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Andy Lutomirski <luto@kernel.org>, Deepak Gupta <debug@rivosinc.com>, 
	Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 11, 2025 at 3:16=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Jann reported [1] possible issue when trampoline_check_ip returns
> address near the bottom of the address space that is allowed to
> call into the syscall if uretprobes are not set up.
>
> Though the mmap minimum address restrictions will typically prevent
> creating mappings there, let's make sure uretprobe syscall checks
> for that.
>
> [1] https://lore.kernel.org/bpf/202502081235.5A6F352985@keescook/T/#m9d41=
6df341b8fbc11737dacbcd29f0054413cbbf
> Cc: Kees Cook <kees@kernel.org>
> Cc: Eyal Birger <eyal.birger@gmail.com>
> Cc: stable@vger.kernel.org
> Fixes: ff474a78cef5 ("uprobe: Add uretprobe syscall to speed up return pr=
obe")
> Reported-by: Jann Horn <jannh@google.com>
> Reviewed-by: Oleg Nesterov <oleg@redhat.com>
> Reviewed-by: Kees Cook <kees@kernel.org>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
> v2 changes:
> - adding UPROBE_NO_TRAMPOLINE_VADDR macro (Andrii)
> - rebased on top of perf/core
>
>  arch/x86/kernel/uprobes.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
>
> diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
> index 5a952c5ea66b..e8d3c59aa9f7 100644
> --- a/arch/x86/kernel/uprobes.c
> +++ b/arch/x86/kernel/uprobes.c
> @@ -357,19 +357,25 @@ void *arch_uprobe_trampoline(unsigned long *psize)
>         return &insn;
>  }
>
> -static unsigned long trampoline_check_ip(void)
> +static unsigned long trampoline_check_ip(unsigned long tramp)
>  {
> -       unsigned long tramp =3D uprobe_get_trampoline_vaddr();
> -
>         return tramp + (uretprobe_syscall_check - uretprobe_trampoline_en=
try);
>  }
>
> +#define UPROBE_NO_TRAMPOLINE_VADDR ((unsigned long)-1)
> +
>  SYSCALL_DEFINE0(uretprobe)
>  {
>         struct pt_regs *regs =3D task_pt_regs(current);
> -       unsigned long err, ip, sp, r11_cx_ax[3];
> +       unsigned long err, ip, sp, r11_cx_ax[3], tramp;
> +
> +       /* If there's no trampoline, we are called from wrong place. */
> +       tramp =3D uprobe_get_trampoline_vaddr();
> +       if (tramp =3D=3D UPROBE_NO_TRAMPOLINE_VADDR)
> +               goto sigill;
>
> -       if (regs->ip !=3D trampoline_check_ip())
> +       /* Make sure the ip matches the only allowed sys_uretprobe caller=
. */
> +       if (regs->ip !=3D trampoline_check_ip(tramp))
>                 goto sigill;
>

LGTM. I don't know if that would make any difference, but I'd sprinkle
unlikely() around these two conditions to make sure they don't
interfere with instruction flow much

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>         err =3D copy_from_user(r11_cx_ax, (void __user *)regs->sp, sizeof=
(r11_cx_ax));
> --
> 2.48.1
>

