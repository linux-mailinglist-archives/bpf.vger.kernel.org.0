Return-Path: <bpf+bounces-48777-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3638DA108AA
	for <lists+bpf@lfdr.de>; Tue, 14 Jan 2025 15:10:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D701118859F2
	for <lists+bpf@lfdr.de>; Tue, 14 Jan 2025 14:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3966613D600;
	Tue, 14 Jan 2025 14:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FAbFlgDJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E08374C08;
	Tue, 14 Jan 2025 14:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736863731; cv=none; b=loRLIHACTZb88G3SCd/T9KyzyWXvvjiw15lJFEqYnHzHgse5XL6kbh30aSg6Ta1WaRuRtEJWh1qfqA+Y80VduYUHMtyV+BFgKhBT5Hqa2oZHoDxPCIXDOhAUCIJAWdFlCLXFLlpKMETJvVPVMHUrWR9ev6i0VlcQeiOrMfhyTmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736863731; c=relaxed/simple;
	bh=wXFulweOCajtJWc3c78dFmY70FgH2IZofWiRzlYXI5g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iggFZa7yIXWFrI2iqU3tuHLp1Pu5vuxz6O3VpY03rwvOcaoSjSFSMcuyeZR/3UXFbla03YS5PMidcRtxS1iTP5/PPUF2e/WdJhXJ6dh88SJY+u0HSTF9oY7YfiEUwbubrA0LvJdCggNJF8pxjALmCUG8AHohv4DINHHmN3tzCgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FAbFlgDJ; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5f31f8f4062so2500631eaf.3;
        Tue, 14 Jan 2025 06:08:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736863729; x=1737468529; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5z5lcl34A9KIDzDLvEGrZ6KUyn8Mutl6VWflA0PShTw=;
        b=FAbFlgDJd3CljJaRy7LgI5GLJSo3gqSXW6Y6tD1g8tjmlgTr6IrNRoB9E0l0z58W+w
         MX9dh0sjPBMxDyKSXmB4J16Oc7NedJXb3sa2m+xL75tH8sGkwpAlVhHpJYjbzRZSVY4n
         aSQlD5h1V8CjbSl2tLCWjgD+quyjj8nrJfgUcmFsaFkFO5P+ANcwNQRMUGiQB3s6bVEY
         VQQ1919/loV5A2v5lYCntzV+oykpENG/cX3FZPzb4c3NKiMpIx+mvoPUnok7l78iEC8z
         rFHTRRwGuzFV07ap4Ke1EiDmWA/meKzczK6LukI/KR9G3vBWrFmTacZYLBQVKVfnXTLV
         Gmyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736863729; x=1737468529;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5z5lcl34A9KIDzDLvEGrZ6KUyn8Mutl6VWflA0PShTw=;
        b=dY9PeR+b+vGZWc9yRM/QZh9pAoqyEXuto4dmykK9iIwVIsDVuNQqHLwRSro4oYxAui
         XMQmv1FQgPczkybosukXidHE+Fn7U4LhtmW+FFSm2s+3WX8P8SdATBG1WlGymQjmBecq
         THCXbCWA6YzjRDnG5T0phqFjxVgIsVZMarpob2nbgnNEbL2AYAn1Y9b/j1jSccum7IIp
         g6ngoNIIHX3Yn3swcpN2oB56EUQjoFjB1GqFLG/BewuBO4UP6lCRt3scAkGC7GY8rEaS
         GOjlqBxH6L6wOwFvyX5kQRe/XxGJtkdJIMFtx1w+1aDU87UdIAB4IrTm0IQs9phX90J2
         zzWQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUpNs6hzcKZ8zDMz6oJTbLJhRXbXaQpCT8793r3ytgN8xp/Li4J/bguZbTazRb6QzFdTY=@vger.kernel.org, AJvYcCV9gW460Kx4Vfsvbh6MnTRZZHEUkWXXhZ/sPWkrv5Ftd7/UoFfSmz8cVBqBxSpZtb5Ww+8wl6nVvX4yE+pVVRo68BRW@vger.kernel.org, AJvYcCW4C0Z6LwKwF9Y2YPhpr72ejA/auUk5/FW53hI3AFf7qkOYEKKfjNdXNbKLtON3ErSu0F2TaVQlcvI2HVp+@vger.kernel.org, AJvYcCXDzRE7Mm4aljGLUisi3+bVzz3V6B1fwMGCwaJvvE6ua/WXXMSIxTfCG+qob9cowIFdCmEJ2v6AcU1X@vger.kernel.org
X-Gm-Message-State: AOJu0Ywf6NeCClkVly4Ii8bLMkywpGGLCl/sjBVaXlKVDCXxX3mYhnXv
	IttJbw8MPGdVLulnbnfBco0l9JXsPkcMqOPxJLJ4bA887vtC1Tmz1GoDbkom4H2l+1wkbDygrCL
	pCDmseE7cf28siMAjPBL7Vs1o/Hpk18UQA5Y=
X-Gm-Gg: ASbGncu7EzSiq1s+HeXhEGb6nRAVx3yNPq2eO7WmFGCgDhaqYcFmdu/9oMC73pO/jA8
	e1TRVke8FWzCVHJmuYWy4PsZFUthoDa7D1+H5gA==
X-Google-Smtp-Source: AGHT+IG1aLRLrw1K/q/d1ovAXouliIATfIUXXqzMPWFAtGRO5bcluNmfGAxmaAQv+scaU6NjGc3u4fpwS5Q3JAV7Ptk=
X-Received: by 2002:a05:6871:a403:b0:29e:6ae2:442 with SMTP id
 586e51a60fabf-2aa068d6800mr14293391fac.32.1736863729044; Tue, 14 Jan 2025
 06:08:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHsH6Gs3Eh8DFU0wq58c_LF8A4_+o6z456J7BidmcVY2AqOnHQ@mail.gmail.com>
 <20250110.152323-sassy.torch.lavish.rent-vKX3ul5B3qyi@cyphar.com>
 <Z4K7D10rjuVeRCKq@krava> <Z4YszJfOvFEAaKjF@krava>
In-Reply-To: <Z4YszJfOvFEAaKjF@krava>
From: Eyal Birger <eyal.birger@gmail.com>
Date: Tue, 14 Jan 2025 06:08:36 -0800
X-Gm-Features: AbW1kvarn5OR3QOa3IHs-toNdeSRYyK2xpzFDMEOn1fXZItUAHsSpJq2fg_UCck
Message-ID: <CAHsH6Gst+UGCtiCaNq2ikaknZGghpTq2SFZX7S0A8=uDsXt=Zw@mail.gmail.com>
Subject: Re: Crash when attaching uretprobes to processes running in Docker
To: Jiri Olsa <olsajiri@gmail.com>
Cc: oleg@redhat.com, Aleksa Sarai <cyphar@cyphar.com>, mhiramat@kernel.org, 
	linux-kernel <linux-kernel@vger.kernel.org>, linux-trace-kernel@vger.kernel.org, 
	BPF-dev-list <bpf@vger.kernel.org>, Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, peterz@infradead.org, tglx@linutronix.de, 
	bp@alien8.de, x86@kernel.org, linux-api@vger.kernel.org, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii.nakryiko@gmail.com>, 
	"rostedt@goodmis.org" <rostedt@goodmis.org>, rafi@rbk.io, 
	Shmulik Ladkani <shmulik.ladkani@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jiri,

On Tue, Jan 14, 2025 at 1:22=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Sat, Jan 11, 2025 at 07:40:15PM +0100, Jiri Olsa wrote:
> > On Sat, Jan 11, 2025 at 02:25:37AM +1100, Aleksa Sarai wrote:
> > > On 2025-01-10, Eyal Birger <eyal.birger@gmail.com> wrote:
> > > > Hi,
> > > >
> > > > When attaching uretprobes to processes running inside docker, the a=
ttached
> > > > process is segfaulted when encountering the retprobe. The offending=
 commit
> > > > is:
> > > >
> > > > ff474a78cef5 ("uprobe: Add uretprobe syscall to speed up return pro=
be")
> > > >
> > > > To my understanding, the reason is that now that uretprobe is a sys=
tem call,
> > > > the default seccomp filters in docker block it as they only allow a=
 specific
> > > > set of known syscalls.
> > >
> > > FWIW, the default seccomp profile of Docker _should_ return -ENOSYS f=
or
> > > uretprobe (runc has a bunch of ugly logic to try to guarantee this if
> > > Docker hasn't updated their profile to include it). Though I guess th=
at
> > > isn't sufficient for the magic that uretprobe(2) does...
> > >
> > > > This behavior can be reproduced by the below bash script, which wor=
ks before
> > > > this commit.
> > > >
> > > > Reported-by: Rafael Buchbinder <rafi@rbk.io>
> >
> > hi,
> > nice ;-) thanks for the report, the problem seems to be that uretprobe =
syscall
> > is blocked and uretprobe trampoline does not expect that
> >
> > I think we could add code to the uretprobe trampoline to detect this an=
d
> > execute standard int3 as fallback to process uretprobe, I'm checking on=
 that
>
> hack below seems to fix the issue, it's using rbx to signal that uretprob=
e
> syscall got executed, if not, trampoline does int3 and executes uretprobe
> handler in the old way

FWIW If I change the seccomp policy to SCMP_ACT_KILL this still fails.

Eyal.

>
> unfortunately now the uretprobe trampoline size crosses the xol slot limi=
t so
> will need to come up with some generic/arch code solution for that, code =
below
> is neglecting that for now


>
> jirka
>
>
> ---
>  arch/x86/kernel/uprobes.c | 24 ++++++++++++++++++++++++
>  include/linux/uprobes.h   |  1 +
>  kernel/events/uprobes.c   | 10 ++++++++--
>  3 files changed, 33 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
> index 5a952c5ea66b..b54863f6fa25 100644
> --- a/arch/x86/kernel/uprobes.c
> +++ b/arch/x86/kernel/uprobes.c
> @@ -315,14 +315,25 @@ asm (
>         ".global uretprobe_trampoline_entry\n"
>         "uretprobe_trampoline_entry:\n"
>         "pushq %rax\n"
> +       "pushq %rbx\n"
>         "pushq %rcx\n"
>         "pushq %r11\n"
> +       "movq $1, %rbx\n"
>         "movq $" __stringify(__NR_uretprobe) ", %rax\n"
>         "syscall\n"
>         ".global uretprobe_syscall_check\n"
>         "uretprobe_syscall_check:\n"
> +       "or %rbx,%rbx\n"
> +       "jz uretprobe_syscall_return\n"
>         "popq %r11\n"
>         "popq %rcx\n"
> +       "popq %rbx\n"
> +       "popq %rax\n"
> +       "int3\n"
> +       "uretprobe_syscall_return:\n"
> +       "popq %r11\n"
> +       "popq %rcx\n"
> +       "popq %rbx\n"
>
>         /* The uretprobe syscall replaces stored %rax value with final
>          * return address, so we don't restore %rax in here and just
> @@ -338,6 +349,16 @@ extern u8 uretprobe_trampoline_entry[];
>  extern u8 uretprobe_trampoline_end[];
>  extern u8 uretprobe_syscall_check[];
>
> +#define UINSNS_PER_PAGE                 (PAGE_SIZE/UPROBE_XOL_SLOT_BYTES=
)
> +
> +bool arch_is_uretprobe_trampoline(unsigned long vaddr)
> +{
> +       unsigned long start =3D uprobe_get_trampoline_vaddr();
> +       unsigned long end =3D start + 2*UINSNS_PER_PAGE;
> +
> +       return vaddr >=3D start && vaddr < end;
> +}
> +
>  void *arch_uprobe_trampoline(unsigned long *psize)
>  {
>         static uprobe_opcode_t insn =3D UPROBE_SWBP_INSN;
> @@ -418,6 +439,9 @@ SYSCALL_DEFINE0(uretprobe)
>         regs->r11 =3D regs->flags;
>         regs->cx  =3D regs->ip;
>
> +       /* zero rbx to signal trampoline that uretprobe syscall was execu=
ted */
> +       regs->bx  =3D 0;
> +
>         return regs->ax;
>
>  sigill:
> diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
> index e0a4c2082245..dbde57a68a1b 100644
> --- a/include/linux/uprobes.h
> +++ b/include/linux/uprobes.h
> @@ -213,6 +213,7 @@ extern void arch_uprobe_copy_ixol(struct page *page, =
unsigned long vaddr,
>  extern void uprobe_handle_trampoline(struct pt_regs *regs);
>  extern void *arch_uprobe_trampoline(unsigned long *psize);
>  extern unsigned long uprobe_get_trampoline_vaddr(void);
> +bool arch_is_uretprobe_trampoline(unsigned long vaddr);
>  #else /* !CONFIG_UPROBES */
>  struct uprobes_state {
>  };
> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> index fa04b14a7d72..73df64109f38 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -1703,6 +1703,11 @@ void * __weak arch_uprobe_trampoline(unsigned long=
 *psize)
>         return &insn;
>  }
>
> +bool __weak arch_is_uretprobe_trampoline(unsigned long vaddr)
> +{
> +       return vaddr =3D=3D uprobe_get_trampoline_vaddr();
> +}
> +
>  static struct xol_area *__create_xol_area(unsigned long vaddr)
>  {
>         struct mm_struct *mm =3D current->mm;
> @@ -1725,8 +1730,9 @@ static struct xol_area *__create_xol_area(unsigned =
long vaddr)
>
>         area->vaddr =3D vaddr;
>         init_waitqueue_head(&area->wq);
> -       /* Reserve the 1st slot for get_trampoline_vaddr() */
> +       /* Reserve the first two slots for get_trampoline_vaddr() */
>         set_bit(0, area->bitmap);
> +       set_bit(1, area->bitmap);
>         insns =3D arch_uprobe_trampoline(&insns_size);
>         arch_uprobe_copy_ixol(area->page, 0, insns, insns_size);
>
> @@ -2536,7 +2542,7 @@ static void handle_swbp(struct pt_regs *regs)
>         int is_swbp;
>
>         bp_vaddr =3D uprobe_get_swbp_addr(regs);
> -       if (bp_vaddr =3D=3D uprobe_get_trampoline_vaddr())
> +       if (arch_is_uretprobe_trampoline(bp_vaddr))
>                 return uprobe_handle_trampoline(regs);
>
>         rcu_read_lock_trace();
> --
> 2.47.1
>

