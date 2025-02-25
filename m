Return-Path: <bpf+bounces-52543-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76946A447AD
	for <lists+bpf@lfdr.de>; Tue, 25 Feb 2025 18:17:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FA47189324B
	for <lists+bpf@lfdr.de>; Tue, 25 Feb 2025 17:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB9C2198E75;
	Tue, 25 Feb 2025 17:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m95+wSrE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D655E194147;
	Tue, 25 Feb 2025 17:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740503466; cv=none; b=QY6vCjEvfrmsabnWygrWLBol3LMYaoNwQYUcnh/4WKOicHFjUw9RzGZTbNwyVeKt8+E+Q2ReKOqNzrui5Gj+IQOdJXlwDQCXz6oyYFWxaaYL/8eSl3ebW2BJswP+WcYQC/zDk9mkGtje2ORsesZnUi9TIpHBG+ReKym+A30wLAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740503466; c=relaxed/simple;
	bh=7D/I/5OTT1Rez6Aag4uUkFHpcFEBDO0XHl+tjf34ARs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YLAF9D/gcoU1hO1KGM11HIsdiqWJmYbv5QGpFIFQ3Js1M6cRyNwtcvfklJnhekuNKxBRQ920yACp/OyQIzhqd8F29txESfNnrES68W7afVNaRuCto085QzNyJve8YNz/k4NtaUtCjGrA8U5gHQsWwXuPIl+zGbUkRTEIBQaSobI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m95+wSrE; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2fc33aef343so11881910a91.1;
        Tue, 25 Feb 2025 09:11:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740503464; x=1741108264; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=17+E8uKCjh/sT4qLs5OeEUuxTMdEWwpPCfDVhSZcVYQ=;
        b=m95+wSrEdSBYlZSkhI8EPz5eOrhLKrJ6zopVh7fcHXlvnlw/16pqAQD3sVH2idRpsm
         whjSq2ddist5dKuznGKZ0dMyQpSIaMlWWyp8PKVkzjaU/QHrcdrmtxB9npxsm2wl6Cjj
         aKGmWqYCLvob6puitNIDJpYb5Cg0xXMZd+a5F+RkiIIIiPh5FY10krqcP8XeItrE3SB8
         0tCV/lyQwP0ChQHTbjjk8g47tjj3VEEKnjEHd/xmQTqNTAOdORQT9x9sn+DF2KYDuFd/
         ZejZJZN5Ef4fspKwJhESMg2bXdtDq6XTOBmTAq5H0RREd/BkIrB7If3No9kILnDmOo3S
         dIFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740503464; x=1741108264;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=17+E8uKCjh/sT4qLs5OeEUuxTMdEWwpPCfDVhSZcVYQ=;
        b=t6Hn8Yo0RpZtb05MzHiwV5OIMKkLatgLtcs71ISxvdvlgDIdCkS3LViFZid5z4biTz
         pa4ahZL08zXFvAAsPFtLkxtIf24X2MJ89+wmDaiwpzyDo0Ih+ELpcHxV0bum+B2bHgTb
         6nm6t9GA/1LY/ZdV7BjiduMX9WNbbypGCrrm5GTNeUz8fKHeoeZx5SQTZpMAVwKqZUUX
         GkQpCIgAS9lgfdjWLLNZ/Hzgg7SvDgGGzRFCmTU3yJ8/fJUxU6pHtIfqAlT3MjrkNDeD
         BMH9TK7i1VkUZIohzHU6cEHCJp90JTvol2yZFAU8nJZPQkWwFWvpXYggks0Vzpe2loJv
         RdRA==
X-Forwarded-Encrypted: i=1; AJvYcCU0h50Q1ozisCcS7g0/EslF4w6VtRTO/ap2YQMTvfzByB0zUP0paKgRfapM7Ac+vqL4A5xlJuURehSGBNo4ICm/0Rau@vger.kernel.org, AJvYcCX5X//fthhcZ3FFXC8kvGu6nc8AQuwLCDiL6V7pn3W2M1XKO8ewnL/NYHuy9tGlL0CVRfsLRI+DrP2EHgTe@vger.kernel.org, AJvYcCXUvzxZVzkSzazMxDwWdVIbja9UMZY98RqEs3vNFcqUijQpBttFDqKyOG2C5+biQVY3sSQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJm6TOG25s7n1moASbelHIVq+2qBdTnN760GN0x3rmqYotlFvg
	v9iUf189GFQTRkvNMQAiKWa2RIYafvqZb9G0Je8dTMfHJ8cDo3wdGia8H++EnNpgVPNs7RXSl1O
	n026fTUu9ezxGTUTv5fgme/D77XY=
X-Gm-Gg: ASbGncuRx+b/tvQIdEVpgKVSD5qTr/+CTZESgpuquQZEG7TkjfpxN8WC3lGhmZjz9gX
	FchnhQFLS2yzr2DLL3wFwiA8J3uwoutUr6O3t0Zy7IN1e75DSReEU8Zp3RAjFKEYyOQkCAMnWYA
	D2W0ZxYRbCIEYk8hs69ZVUfbg=
X-Google-Smtp-Source: AGHT+IHmjTQI1QUC4DD91GlZPoxDstTrfBDXAvGfma10Eq4txi+xv3pR1zz3BcToc08sL9N2s+i3cpbtGP4XsUK0bjE=
X-Received: by 2002:a17:90b:2dc5:b0:2f6:be57:49d2 with SMTP id
 98e67ed59e1d1-2fe7e32b7c8mr223907a91.17.1740503464075; Tue, 25 Feb 2025
 09:11:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224140151.667679-1-jolsa@kernel.org> <20250224140151.667679-9-jolsa@kernel.org>
 <CAADnVQJ_-7cB3OaeFWaupcq0fRPh3uP62HBGxq0QbyZsx3aHqA@mail.gmail.com> <Z73HDU5IZ5NV3BtM@krava>
In-Reply-To: <Z73HDU5IZ5NV3BtM@krava>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 25 Feb 2025 09:10:51 -0800
X-Gm-Features: AWEUYZlih3LzwO6a_5meOCe00Q8gUTSUMKIw7SRS3-DzCUOUSJq2R7Fj2qLtNz4
Message-ID: <CAEf4BzZOCW6oFrNDfKMWfNJAuA1-8nnaCUyfNT3-BAUynZQ5HQ@mail.gmail.com>
Subject: Re: [PATCH RFCv2 08/18] uprobes/x86: Add uprobe syscall to speed up uprobe
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Oleg Nesterov <oleg@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, Hao Luo <haoluo@google.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Alan Maguire <alan.maguire@oracle.com>, David Laight <David.Laight@aculab.com>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 25, 2025 at 5:35=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Mon, Feb 24, 2025 at 11:22:42AM -0800, Alexei Starovoitov wrote:
> > On Mon, Feb 24, 2025 at 6:08=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wr=
ote:
> > >
> > > +SYSCALL_DEFINE0(uprobe)
> > > +{
> > > +       struct pt_regs *regs =3D task_pt_regs(current);
> > > +       unsigned long bp_vaddr;
> > > +       int err;
> > > +
> > > +       err =3D copy_from_user(&bp_vaddr, (void __user *)regs->sp + 3=
*8, sizeof(bp_vaddr));
> > > +       if (err) {
> > > +               force_sig(SIGILL);
> > > +               return -1;
> > > +       }
> > > +
> > > +       /* Allow execution only from uprobe trampolines. */
> > > +       if (!in_uprobe_trampoline(regs->ip)) {
> > > +               force_sig(SIGILL);
> > > +               return -1;
> > > +       }
> > > +
> > > +       handle_syscall_uprobe(regs, bp_vaddr - 5);
> > > +       return 0;
> > > +}
> > > +
> > > +asm (
> > > +       ".pushsection .rodata\n"
> > > +       ".balign " __stringify(PAGE_SIZE) "\n"
> > > +       "uprobe_trampoline_entry:\n"
> > > +       "endbr64\n"
> >
> > why endbr is there?
> > The trampoline is called with a direct call.
>
> ok, that's wrong, will remove that
>
> >
> > > +       "push %rcx\n"
> > > +       "push %r11\n"
> > > +       "push %rax\n"
> > > +       "movq $" __stringify(__NR_uprobe) ", %rax\n"
> >
> > To avoid introducing a new syscall for a very similar operation
> > can we disambiguate uprobe vs uretprobe via %rdi or
> > some other way?
> > imo not too late to change uretprobe api.
> > Maybe it was discussed already.
>
> yes, I recall discussing that early during uretprobe work with the decisi=
on to
> have separate syscalls for each uprobe and uretprobe.. however wrt recent=
 seccomp
> changes, it might be easier just to add argument to uretprobe syscall to =
handle
> uprobe
>
> too bad it's not the other way around.. uprobe syscall with argument to d=
o uretprobe
> would sound better

It's an "internal" syscall, why can't we rename it, if we want to?

Though I'm not sure I see the problem having both sys_uprobe and
sys_uretprobe, tbh. We just add sys_uprobe to the same list(s) that
sys_uretprobe is in for seccomp.

>
> >
> > > +       "syscall\n"
> > > +       "pop %rax\n"
> > > +       "pop %r11\n"
> > > +       "pop %rcx\n"
> > > +       "ret\n"
> >
> > In later patches I see nop5 is replaced with a call to
> > uprobe_trampoline_entry, but which part saves
> > rdi and other regs?
> > Compiler doesn't automatically spill/fill around USDT's nop/nop5.
> > Selftest is doing:
> > +__naked noinline void uprobe_test(void)
> > so just lucky ?
>
> if you mean registers that would carry usdt arguments, ebpf programs
> access those based on assembler operand string stored in usdt record:
>
>   stapsdt              0x00000048       NT_STAPSDT (SystemTap probe descr=
iptors)
>     Provider: test
>     Name: usdt3
>     Location: 0x0000000000712f2f, Base: 0x0000000002f516b0, Semaphore: 0x=
0000000003348ec2
> ->  Arguments: -4@-1192(%rbp) -8@-1200(%rbp) 8@%rax
>
> it's up to bpf program to know which register(+offset) to access, libbpf =
have all
> this logic hidden behind usdt_manager_attach_usdt and bpf_usdt_arg bpf ca=
ll
>
> the trampoline only saves rcx/r11/rax, because they are changed by syscal=
l instruction
>
> but actually I forgot to load these saved values (of rcx/r11/rax) and rsp=
 into regs that
> are passed to ebpf program, (like we do in uretprobe syscall) will fix th=
at in next version
>
> I'll add tests for optimized usdt with more arguments
>
> thanks,
> jirka

