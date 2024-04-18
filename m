Return-Path: <bpf+bounces-27156-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A7BD8AA218
	for <lists+bpf@lfdr.de>; Thu, 18 Apr 2024 20:35:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8A961F217CC
	for <lists+bpf@lfdr.de>; Thu, 18 Apr 2024 18:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4EEF16F913;
	Thu, 18 Apr 2024 18:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BmR2ROPf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B04438DF2;
	Thu, 18 Apr 2024 18:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713465301; cv=none; b=SJCrWNYVAl80bHY2xlghTNUPQW/vSNoLR1b+rYkQLB2jXH6t6mt3jBiXdEjhjjgdpuGJEiknjO+vmTnKc0MPiOd8UpifBI/hvqlbrSlRH2XlZk274UTaPJwnZOm5shfVCC7NXnqIrc5EnyWK0W3IYsY6tg9GTeVZ7O4X8/5eJfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713465301; c=relaxed/simple;
	bh=cPt44jxSVrdhZJrIQnC8pnx/xoLCJM42pv8YS2Rc51w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cER/LfvI0JymXpRjoS3r6FeNbQb/nQV9O4kFVFJaIW18MCXp05+VDeY4aiXK7dfWKJbwV8fD/e/s7FV76kMQjt/VST6LcKVRrAhvkeTtfYNPkWUKu2LzXQqwoII06mBZqX+VVLPQl1p0MSAcqw1ytz30lSW4kZjkQU+PxL3FgnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BmR2ROPf; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6ed2170d89fso1560140b3a.1;
        Thu, 18 Apr 2024 11:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713465299; x=1714070099; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/h/Do95bbYq5Tt0KYD+0H8my015G5GgNdhr/yLxS+rI=;
        b=BmR2ROPfUHjXmPwg/lsQajN9js9jtNXfTQ2nNjlKZbWekzB+MHpuVHUnG8QKFj01ap
         n5FPasCpfGLPnBMolNCSxx+l4j0MJRUULrLnkZ4lmHwLZYlJuygzaFrufrSwSs5T7k9G
         9mR55GJCN68FIu/KaY5H14lfMWV2O3yIEbI9OawOgOpcdpgTaqFuNFZlaCqVpJzw1t6E
         CQpjITTujxV+itZxY51zZ3EXQYLuV8Vk3+QSYeFA7tNcOibEYyw3D7mzVaEZFlGwDIfG
         VbHnNpqGDVc0aMEAEf0Fj06w6lPiq3HWarAm498s1qHxOi0zRo398qZ2TTPCZGyDdd6e
         rz9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713465299; x=1714070099;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/h/Do95bbYq5Tt0KYD+0H8my015G5GgNdhr/yLxS+rI=;
        b=EB1iN+crgrVmjGy/Sjv5BhYo3oFuBsep4+DDRDISX6lGBeYLtDIetjDwCtsMdZtDej
         Wbtmm2mXRnKhWbByKu7MCgYvDZAy7fwNR0Bk+3OuXjhfilfMCyUqAiYy6x3XLkaSjNqj
         FgAHOefCB5D4+62fvcHgWeE+jy+oeejt/qyAP3bAaXz+VP+4gOCr6IPs24oG234VK3sE
         scWgA9RnIOPg2fPE3Th57WEMuQtVj4urhspoQ6r6oHUl7uadYeP+qZsy+n0WEt6mLquP
         3i3umhkDzDsmSow7UW2sgvrSFooT3r37EcsT8Es3Y/h925N/sKXNlA0jnmdWfNTzskgN
         NxDA==
X-Forwarded-Encrypted: i=1; AJvYcCV8/J8YnNzUvaUfHw45Js1vTtgZR/Qgtnh/4QqKTiKJ/c1UTeMhKRX3p5rbG+qnRCDsraeLur6LgiJQHqh9T9cAWxarUTyvg6RvDtFHhpCHQCrLyHyppVWP3EfdUaZE04vEnyvAymQewjOOvugEDD6UxKSqqN+ORDjoA/oPHjkNVXlKEXTT
X-Gm-Message-State: AOJu0YxfgJ7Dy8B9bWWf4sHofxnuf+DZxBMyVjUmcxOg+eqsUAQgZ1IF
	yEKAaIvAupKOieTRUnXy6XaIlsxmtyqL0OL7sttL5rIbCy6niLLdhC0RVAg/bO9x6TxJZawr77L
	yPWAEyf1b3LEmq7jMLSmTx4pVw4vgfQ==
X-Google-Smtp-Source: AGHT+IEB3bUb0iplzA4oMVXjAhm6Bb8bKdPQg8QMrh0wepwiuAokgwg5qhBuLi7t8YCF8gknqnuogEna5gHrEuq+3oE=
X-Received: by 2002:a05:6a21:2d8a:b0:1a7:53c1:ad8d with SMTP id
 ty10-20020a056a212d8a00b001a753c1ad8dmr44266pzb.24.1713465299216; Thu, 18 Apr
 2024 11:34:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240402093302.2416467-1-jolsa@kernel.org> <20240402093302.2416467-2-jolsa@kernel.org>
 <ZhzkbN7DWq6Tzp5G@krava>
In-Reply-To: <ZhzkbN7DWq6Tzp5G@krava>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 18 Apr 2024 11:34:46 -0700
Message-ID: <CAEf4BzZ_en3hw72zqjW3tyn9M+Az069NXU3a3+hsn_k0T0TwnA@mail.gmail.com>
Subject: Re: [PATCHv2 1/3] uprobe: Add uretprobe syscall to speed up return probe
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Oleg Nesterov <oleg@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, Peter Zijlstra <peterz@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>, "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 15, 2024 at 1:25=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Tue, Apr 02, 2024 at 11:33:00AM +0200, Jiri Olsa wrote:
>
> SNIP
>
> >  #include <linux/kdebug.h>
> >  #include <asm/processor.h>
> > @@ -308,6 +309,88 @@ static int uprobe_init_insn(struct arch_uprobe *au=
probe, struct insn *insn, bool
> >  }
> >
> >  #ifdef CONFIG_X86_64
> > +
> > +asm (
> > +     ".pushsection .rodata\n"
> > +     ".global uretprobe_syscall_entry\n"
> > +     "uretprobe_syscall_entry:\n"
> > +     "pushq %rax\n"
> > +     "pushq %rcx\n"
> > +     "pushq %r11\n"
> > +     "movq $" __stringify(__NR_uretprobe) ", %rax\n"
> > +     "syscall\n"
> > +     "popq %r11\n"
> > +     "popq %rcx\n"
> > +
> > +     /* The uretprobe syscall replaces stored %rax value with final
> > +      * return address, so we don't restore %rax in here and just
> > +      * call ret.
> > +      */
> > +     "retq\n"
> > +     ".global uretprobe_syscall_end\n"
> > +     "uretprobe_syscall_end:\n"
> > +     ".popsection\n"
> > +);
> > +
> > +extern u8 uretprobe_syscall_entry[];
> > +extern u8 uretprobe_syscall_end[];
> > +
> > +void *arch_uprobe_trampoline(unsigned long *psize)
> > +{
> > +     *psize =3D uretprobe_syscall_end - uretprobe_syscall_entry;
> > +     return uretprobe_syscall_entry;
>
> fyi I realized this screws 32-bit programs, we either need to add
> compat trampoline, or keep the standard breakpoint for them:
>
> +       struct pt_regs *regs =3D task_pt_regs(current);
> +       static uprobe_opcode_t insn =3D UPROBE_SWBP_INSN;
> +
> +       if (user_64bit_mode(regs)) {
> +               *psize =3D uretprobe_syscall_end - uretprobe_syscall_entr=
y;
> +               return uretprobe_syscall_entry;
> +       }
> +
> +       *psize =3D UPROBE_SWBP_INSN_SIZE;
> +       return &insn;
>
>
> not sure it's worth the effort to add the trampoline, I'll check
>

32-bit arch isn't a high-performance target anyways, so I'd probably
not bother and prioritize simplicity and long term maintenance.

>
> jirka

