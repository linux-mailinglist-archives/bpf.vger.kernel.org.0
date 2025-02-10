Return-Path: <bpf+bounces-51005-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21581A2F541
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 18:27:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0B4F3A779A
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 17:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38A31255E5E;
	Mon, 10 Feb 2025 17:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XZcPKZD0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A8324BD0C;
	Mon, 10 Feb 2025 17:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739208427; cv=none; b=lniYWf4wo4LtLGh3fslPuWTQ3jru8kU0xP22SAhmzEWDIpgIkMhVlAt2fDmnwC1y/rXUov+m9KpVmAtQa8qckBPHWddbdiUoNz8dI0Zr7SnY7xWIVAySCYUdppgsSAmTcozcwgjSd2BP1a7yausqpviAb3viMj1MNNQjIkvVYqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739208427; c=relaxed/simple;
	bh=1TsLwSNIODCyCtoMMInJN2hxwExvt91BRQh/dFO7ytg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h8u2JSMyhSQfRFtN4xRDkvHE6PNhZcd0eYqmdnQQLJ5B19jQvG0Gv1H8nz65NKUqv9/Tbm2clCub2F0rc3p0nnPuy0QPAiP+a8gyEO2CSZcU99x351obtXk5CEf4Q9LnWkCve7kttwsyktVZpqc9+r1WvmAKvNMTR1q28zesc0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XZcPKZD0; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-21f49837d36so51752475ad.3;
        Mon, 10 Feb 2025 09:27:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739208425; x=1739813225; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zktfdqzMeMwjC0BeHzef0BqRxxg/u+VUG81lM/bxr8U=;
        b=XZcPKZD0xHJqex7Oj4wBm2mQ78QTsfHQPGdBgLpcXpMGKYjWvkf9Hq5LL1p3w3PNRQ
         4b+0MOfUI2I2B1pyc9mMm+HNreSiieTOdsAMOrHUh5b7Yn/RBc6MhAQCT2qe460TX91s
         Yhn0z44zsg/T6iI18Oh1fH/TxpPUEQfX32rWd45Wol2rbrfQK8awptAd5mJLQdjF826S
         4J+OoY7Vtug6KUPED7j96OL5Vs1cKtDH9NttPSkho2Rn+tu51wnQMHdXFH8jd3iAZaZW
         aUGlUSKnk85/fDzq/aKg0/NwcfIpJic0AauB8v74Uj1rzsSPv4tnItC8wDenrwNHjtPq
         SBmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739208425; x=1739813225;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zktfdqzMeMwjC0BeHzef0BqRxxg/u+VUG81lM/bxr8U=;
        b=YrS715QtEGhKfI8h1rjzbsr+DsvFxO6oZ27E8RxskxdPN3wiN5OU+hJWIG/7pNqK1Y
         htQl0ImxRBLofTi9LvSyoEgTIgs72Ne0qE8Ihzix/4OzMJWHWZjzqSuB+s8vB8oWFOlw
         9326Ltnq7XTXtMVmRajZOBpwmbeMjE7MsioNthzAIG4tcHC81vlEoEmlpfQyiFAYpqgf
         Ut3J2u8bOjE0YINIQE7a7pVQ+DlsHf1rBNTg0zkE5AjT6HQ5wpjRVUU6H0hKHLE0vcwZ
         VGyA4yEcdoij34FmAfln7jiFWAxCCwU0oYF98cn3OyLWEykazXF4CbH/Oj6W8aH4apne
         XTtA==
X-Forwarded-Encrypted: i=1; AJvYcCU625Jk9uOTXjRQLV/hO8DAqCD8mY+Asv5wSfg/61vSVHDmkUAxC6p/oikUaSr2E3fLkrCU7Wnn@vger.kernel.org, AJvYcCUYEhC97QrZMCqoX7Kc6IL/51KoxpmGb3FzZUfu3s1rDgnCywf1bKcpS28W7ueSqC1mGGsWvw58gIFXdkxvto5rbRnw@vger.kernel.org, AJvYcCUzW2H+hANtfQkraaR/C6u+Qafx48dv56QggEPDjNtGlIY4QBosrcRMVdEOjgSm28KpnxU=@vger.kernel.org, AJvYcCWgZzhqloGBc5BL1dOPKA/DNdByblgqaBARzr8msLywJhG3HnAM59vEkgQdO4JIAPa6MYCLln/91w5WOuni@vger.kernel.org, AJvYcCXJU2qSmAykfwPiO49L+y6LbRQH368rafsGMYCkmxDpu0p2Kemu893/+cdPDsQxsqql4Y6W1EydrJAb@vger.kernel.org
X-Gm-Message-State: AOJu0Yx87/COZk9F4Ffq/SkEGr9fbeqJg1WBbNdDvtqkn1AQS0CV+Vcq
	8smNNzZ/X33KER2D0b6fW0k1+QZ3+bgvJwshWU3WlBPPr2dxotJXdWr1YYjgzUxVrWDh7Dw3L4N
	Y98wlFmiah81aSwyFMeVA9xUgvMk=
X-Gm-Gg: ASbGnct6tfW4L6mxvJN9O4InFJh8AE8hIV4LiDTWHCsvatgmiI5FT2sTZm7Yg6pLvR5
	IDrknMxuVD6g/ORuZCD7PS92RMFi82qWJVjj8eFDQ7Y7HcEuN8Tj/2QZX+zhsC0LITVV/C8hatn
	qf9PccTdKEe1zf
X-Google-Smtp-Source: AGHT+IE5zCCUJuchWiR5YczuUu7jAG0iwCKJQMiLLkUQ2Fo/APpTjQalXVSkY230/hIw14r5JrHG9UvVj6k2uAv6tyk=
X-Received: by 2002:a17:903:3d03:b0:21f:801a:9be1 with SMTP id
 d9443c01a7336-21f801aa620mr119753205ad.33.1739208425589; Mon, 10 Feb 2025
 09:27:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250209220515.2554058-1-jolsa@kernel.org>
In-Reply-To: <20250209220515.2554058-1-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 10 Feb 2025 09:26:53 -0800
X-Gm-Features: AWEUYZneXLBiDOJWqgYBMH0F-wezftc0RsqYEeTR83R9d-szAQ4fRffxE8w_gIM
Message-ID: <CAEf4BzbpKReuNhdH6RnwYOyYxFwgJjjgUB_2xwU=dGkC--K=Kg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] uprobes: Harden uretprobe syscall trampoline check
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

On Sun, Feb 9, 2025 at 2:05=E2=80=AFPM Jiri Olsa <jolsa@kernel.org> wrote:
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
> Reported-by: Jann Horn <jannh@google.com>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  arch/x86/kernel/uprobes.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
>
> diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
> index 5a952c5ea66b..109d6641a1b3 100644
> --- a/arch/x86/kernel/uprobes.c
> +++ b/arch/x86/kernel/uprobes.c
> @@ -357,19 +357,23 @@ void *arch_uprobe_trampoline(unsigned long *psize)
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
>  SYSCALL_DEFINE0(uretprobe)
>  {
>         struct pt_regs *regs =3D task_pt_regs(current);
> -       unsigned long err, ip, sp, r11_cx_ax[3];
> +       unsigned long err, ip, sp, r11_cx_ax[3], tramp;
> +
> +       /* If there's no trampoline, we are called from wrong place. */
> +       tramp =3D uprobe_get_trampoline_vaddr();
> +       if (tramp =3D=3D -1)

slight nit: mixing -1 and unsigned long looks sloppy. Maybe let's add
something like

#define UPROBE_NO_TRAMPOLINE_VADDR ((unsigned long)-1)

and return that from uprobe_get_trampoline_vaddr()?

> +               goto sigill;
>
> -       if (regs->ip !=3D trampoline_check_ip())
> +       /* Make sure the ip matches the only allowed sys_uretprobe caller=
. */
> +       if (regs->ip !=3D trampoline_check_ip(tramp))
>                 goto sigill;
>
>         err =3D copy_from_user(r11_cx_ax, (void __user *)regs->sp, sizeof=
(r11_cx_ax));
> --
> 2.48.1
>

