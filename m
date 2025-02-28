Return-Path: <bpf+bounces-52891-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E67CA4A23F
	for <lists+bpf@lfdr.de>; Fri, 28 Feb 2025 19:55:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E52FB189A07E
	for <lists+bpf@lfdr.de>; Fri, 28 Feb 2025 18:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F17F51F4CBA;
	Fri, 28 Feb 2025 18:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a6JcuCF4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D91FE27700B;
	Fri, 28 Feb 2025 18:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740768939; cv=none; b=ZqhJedkYf3Brv/HBfErG2tecaODijlk9ydErxPNar4/q/ULz0JL6Qo9qwCDodjl33wvga64j0sK2+9QstF6VELrFwYXSTQnTMeeaSwhnwMhZr5xXa/g5SnCnf1bz26RnihvldpwjLiegbpPQ6ypt9IAxKMw0Q5QxgDCxrp1FjIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740768939; c=relaxed/simple;
	bh=qqiIh6rmfqsqrrc8shoq/c35GXjPGHne7gjq1NwDyqw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CcPvoIYs/b2XmYhj1TpsR7nX61G4dBIaDtHBaG7cCLhRg7emhmNUnz5edWGa+F0d7Kwm5eihBoJmH9ri1jKhVpDCX9HB/g+MilKwiK2Yarou79FYV+psVTEzQAqN3GDZJ4Ha6PxRgX6VKZ9p/AB7E2T4cVcNzAmI8toaAwjvWpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a6JcuCF4; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-22334203781so56124635ad.0;
        Fri, 28 Feb 2025 10:55:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740768937; x=1741373737; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WbTH0UTxoxfveyPapeklW//IOypLA0HMVy+eii2u6NQ=;
        b=a6JcuCF4zTAVZP8fU7g2Uum4AyGuPfpdZg+Kpdh/VCjd+Hs7c477o5LaEvKD9n2gKa
         +S2bJxIrzU6JBi3Psp9/kilhIHIur9sx0ZtAzmy7Vx89c1y1KcBTlDdfpGKd97KUnvCZ
         eCeqlhJ0UqmS+CCoH7JZUAL6tuBZ6fbgBQXYRPb9ohJyYldc+pm1ol4NVz5M+K5FUuzJ
         VSkuq20gMaJC0dYQBd1fHLuDqjCkP6o3ghJgcVPoMu+iCln2U/FWBfxQm7Eget79Wg2Z
         chxK7ILE/JBUJGgdyxOWtnkWjGqthjhkUTV6dYEZBG5Zzssupkam/yG8mkzZLTmhAC3t
         iL1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740768937; x=1741373737;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WbTH0UTxoxfveyPapeklW//IOypLA0HMVy+eii2u6NQ=;
        b=XOxykP7tdHmoKKZeSt67dOcZl4BYQM0HBGmfkiMajdWY3OkXohNXXewILV89968bGX
         LAUnb7O+SZrlL+tBM8SjRecmKKloLpj2xR2wiEZNrnygSOGQ6O0OzE8Z06SCNtHkkV1D
         pc/cSoTNSVb3GqHFMp8DaZxyXUdbhqgN5KytYUbWBz4h8Lkb4cYG//3kX9hVmP0uml/0
         8rIoyH7g9siGSTg3NIm9+Vvm0buD3dwFAI92+aF+5g2XZKnWrcbwySbP3mO6KKgmTLj1
         DrotQ9z1sl0ft2hbUR0x56N0TeVARDCV0/NgF7vgT8HGe14oDBcdr7ZZKq0eH22jqFWi
         jN1Q==
X-Forwarded-Encrypted: i=1; AJvYcCW7tGkX9NL14jeCIixxaStCRaZ+vqScRG3XZDV8PPhw7248CeVJMiFK4VomyuvQyIcmRb9QsVaMFBwWQNGxaWM0BkuX@vger.kernel.org, AJvYcCWac7/IU5Z3CgOweT97bi/mRqO5q3wgaoJKyussnFu/60Ah0kw1v/a6DMjPM2deF3xhOKI=@vger.kernel.org, AJvYcCXv2q7ph5YTNJGwVOvaKVh9Q8rxUOs2pGBUjzh72nYk8cZ3AdhQ7gy2jC81EPf+sSGzNMeWLPhH3T/KSTaR@vger.kernel.org
X-Gm-Message-State: AOJu0YzKrKnD1QDknsIt8E6VNoNCKj8O7um/8EI8ZUz2Ve7TQHASzk62
	OEXSMINQ0CjDbko7foPgU3aFwsSjoUHeaxZe8AcjfTDD67w3lWUBJwhbWj2mQKtLEPB7vrDLhEL
	vduEuJ08O08X74nOs6SMGPZDCk7g=
X-Gm-Gg: ASbGnctTqQaCDONKmdWVm7BUsjFkyby9Y1C4f4xozgZxuALwarBDVRFNx5TA1nEcoUP
	IIkTyEdONj46IK7fsZsu3yzIz15U6erYB5GcYOGpx4wGsUbqZyY//17dtgKtz6IFZbodoMT16A9
	UlPLXXLUoF0tarq3NgJkykYiY=
X-Google-Smtp-Source: AGHT+IHWYg7JalQt0NqATGXccoU6fEfl5DvQ6QmNoIB7isjFTNW6yaciFgvu+xAk8Vw7lq7K96arvyoIe1mf8zhj4sA=
X-Received: by 2002:a05:6a00:3918:b0:728:f21b:ce4c with SMTP id
 d2e1a72fcca58-734ac385bf8mr8419527b3a.5.1740768936952; Fri, 28 Feb 2025
 10:55:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224140151.667679-1-jolsa@kernel.org> <20250224140151.667679-13-jolsa@kernel.org>
In-Reply-To: <20250224140151.667679-13-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 28 Feb 2025 10:55:24 -0800
X-Gm-Features: AQ5f1JrWLS6lddUwkgojGshVfBqV95kvvKU1l5AvnsUomP_dmtSZ6jSlPueJD54
Message-ID: <CAEf4BzbE1dhqZWpLYhZFo7cuuK04t9iM+1ykHA5_PbM_xdb1PQ@mail.gmail.com>
Subject: Re: [PATCH RFCv2 12/18] uprobes/x86: Add support to optimize uprobes
To: Jiri Olsa <jolsa@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, x86@kernel.org, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, Hao Luo <haoluo@google.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Alan Maguire <alan.maguire@oracle.com>, David Laight <David.Laight@aculab.com>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2025 at 6:04=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Putting together all the previously added pieces to support optimized
> uprobes on top of 5-byte nop instruction.
>
> The current uprobe execution goes through following:
>   - installs breakpoint instruction over original instruction
>   - exception handler hit and calls related uprobe consumers
>   - and either simulates original instruction or does out of line single =
step
>     execution of it
>   - returns to user space
>
> The optimized uprobe path
>
>   - checks the original instruction is 5-byte nop (plus other checks)
>   - adds (or uses existing) user space trampoline and overwrites original
>     instruction (5-byte nop) with call to user space trampoline
>   - the user space trampoline executes uprobe syscall that calls related =
uprobe
>     consumers
>   - trampoline returns back to next instruction
>
> This approach won't speed up all uprobes as it's limited to using nop5 as
> original instruction, but we could use nop5 as USDT probe instruction (wh=
ich
> uses single byte nop ATM) and speed up the USDT probes.
>
> This patch overloads related arch functions in uprobe_write_opcode and
> set_orig_insn so they can install call instruction if needed.
>
> The arch_uprobe_optimize triggers the uprobe optimization and is called a=
fter
> first uprobe hit. I originally had it called on uprobe installation but t=
hen
> it clashed with elf loader, because the user space trampoline was added i=
n a
> place where loader might need to put elf segments, so I decided to do it =
after
> first uprobe hit when loading is done.
>
> We do not unmap and release uprobe trampoline when it's no longer needed,
> because there's no easy way to make sure none of the threads is still
> inside the trampoline. But we do not waste memory, because there's just
> single page for all the uprobe trampoline mappings.
>
> We do waste frmae on page mapping for every 4GB by keeping the uprobe
> trampoline page mapped, but that seems ok.
>
> Attaching the speed up from benchs/run_bench_uprobes.sh script:
>
> current:
>         usermode-count :  818.836 =C2=B1 2.842M/s
>         syscall-count  :    8.917 =C2=B1 0.003M/s
>         uprobe-nop     :    3.056 =C2=B1 0.013M/s
>         uprobe-push    :    2.903 =C2=B1 0.002M/s
>         uprobe-ret     :    1.533 =C2=B1 0.001M/s
> -->     uprobe-nop5    :    1.492 =C2=B1 0.000M/s
>         uretprobe-nop  :    1.783 =C2=B1 0.000M/s
>         uretprobe-push :    1.672 =C2=B1 0.001M/s
>         uretprobe-ret  :    1.067 =C2=B1 0.002M/s
> -->     uretprobe-nop5 :    1.052 =C2=B1 0.000M/s
>
> after the change:
>
>         usermode-count :  818.386 =C2=B1 1.886M/s
>         syscall-count  :    8.923 =C2=B1 0.003M/s
>         uprobe-nop     :    3.086 =C2=B1 0.005M/s
>         uprobe-push    :    2.751 =C2=B1 0.001M/s
>         uprobe-ret     :    1.481 =C2=B1 0.000M/s
> -->     uprobe-nop5    :    4.016 =C2=B1 0.002M/s
>         uretprobe-nop  :    1.712 =C2=B1 0.008M/s
>         uretprobe-push :    1.616 =C2=B1 0.001M/s
>         uretprobe-ret  :    1.052 =C2=B1 0.000M/s
> -->     uretprobe-nop5 :    2.015 =C2=B1 0.000M/s
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  arch/x86/include/asm/uprobes.h |   6 ++
>  arch/x86/kernel/uprobes.c      | 191 ++++++++++++++++++++++++++++++++-
>  include/linux/uprobes.h        |   6 +-
>  kernel/events/uprobes.c        |  16 ++-
>  4 files changed, 209 insertions(+), 10 deletions(-)
>
> diff --git a/arch/x86/include/asm/uprobes.h b/arch/x86/include/asm/uprobe=
s.h
> index 678fb546f0a7..7d4df920bb59 100644
> --- a/arch/x86/include/asm/uprobes.h
> +++ b/arch/x86/include/asm/uprobes.h
> @@ -20,6 +20,10 @@ typedef u8 uprobe_opcode_t;
>  #define UPROBE_SWBP_INSN               0xcc
>  #define UPROBE_SWBP_INSN_SIZE             1
>
> +enum {
> +       ARCH_UPROBE_FLAG_CAN_OPTIMIZE   =3D 0,
> +};
> +
>  struct uprobe_xol_ops;
>
>  struct arch_uprobe {
> @@ -45,6 +49,8 @@ struct arch_uprobe {
>                         u8      ilen;
>                 }                       push;
>         };
> +
> +       unsigned long flags;
>  };
>
>  struct arch_uprobe_task {
> diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
> index e8aebbda83bc..73ddff823904 100644
> --- a/arch/x86/kernel/uprobes.c
> +++ b/arch/x86/kernel/uprobes.c
> @@ -18,6 +18,7 @@
>  #include <asm/processor.h>
>  #include <asm/insn.h>
>  #include <asm/mmu_context.h>
> +#include <asm/nops.h>
>
>  /* Post-execution fixups. */
>
> @@ -768,7 +769,7 @@ static struct uprobe_trampoline *create_uprobe_trampo=
line(unsigned long vaddr)
>         return NULL;
>  }
>
> -static __maybe_unused struct uprobe_trampoline *uprobe_trampoline_get(un=
signed long vaddr)
> +static struct uprobe_trampoline *uprobe_trampoline_get(unsigned long vad=
dr)
>  {
>         struct uprobes_state *state =3D &current->mm->uprobes_state;
>         struct uprobe_trampoline *tramp =3D NULL;
> @@ -794,7 +795,7 @@ static void destroy_uprobe_trampoline(struct uprobe_t=
rampoline *tramp)
>         kfree(tramp);
>  }
>
> -static __maybe_unused void uprobe_trampoline_put(struct uprobe_trampolin=
e *tramp)
> +static void uprobe_trampoline_put(struct uprobe_trampoline *tramp)
>  {
>         if (tramp =3D=3D NULL)
>                 return;
> @@ -807,6 +808,7 @@ struct mm_uprobe {
>         struct rb_node rb_node;
>         unsigned long auprobe;
>         unsigned long vaddr;
> +       bool optimized;
>  };
>

I'm trying to understand if this RB-tree based mm_uprobe is strictly
necessary. Is it? Sure we keep optimized flag, but that's more for
defensive checks, no? Is there any other reason we need this separate
look up data structure?

>  #define __node_2_mm_uprobe(node) rb_entry((node), struct mm_uprobe, rb_n=
ode)
> @@ -874,6 +876,7 @@ static struct mm_uprobe *insert_mm_uprobe(struct mm_s=
truct *mm, struct arch_upro
>         if (mmu) {
>                 mmu->auprobe =3D (unsigned long) auprobe;
>                 mmu->vaddr =3D vaddr;
> +               mmu->optimized =3D false;
>                 RB_CLEAR_NODE(&mmu->rb_node);
>                 rb_add(&mmu->rb_node, &mm->uprobes_state.root_uprobes, __=
mm_uprobe_less);
>         }

[...]

