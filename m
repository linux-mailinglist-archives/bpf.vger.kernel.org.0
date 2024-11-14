Return-Path: <bpf+bounces-44893-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ECB9F9C965E
	for <lists+bpf@lfdr.de>; Fri, 15 Nov 2024 00:46:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62124B25590
	for <lists+bpf@lfdr.de>; Thu, 14 Nov 2024 23:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A5EC1B85CA;
	Thu, 14 Nov 2024 23:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LpYg/YSB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E381B6CF3;
	Thu, 14 Nov 2024 23:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731627875; cv=none; b=XMg6yk5/1zDzcjCurQ8QKp4xlW3cv4DPEPam+SwceBGqGFugC4v5wKgBQ+m75MYL3WOs8RswvXddtrERwKDG8U/29jwRuz5l8VytG4PM9zy1jDnbbsHAv8xVJ+NcDvmoVh1qNQTUYi321RCExUQovemwPpuwpTlW810nOhFBNqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731627875; c=relaxed/simple;
	bh=nrzL63usYT6Zit64pBsY748wpg51x/pKDZ198Hroddo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IDTw+cjZKpTItQ3UNxXsBGiUDr2PC8fwQnpr6Oimoft3L7uSXX+Gq59CyhDr22PMqAA/8T5bZPqi7Ob3Jl3BngPgjJoXgQfqOdlo+l2IvaMrmCRHVDFymGCP+Ib/QjWxTSGVJ63vgg7O5Hvfp3SCVa+/py9xLKT9IW1siN4Z7Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LpYg/YSB; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2ea0c38f0fdso766378a91.3;
        Thu, 14 Nov 2024 15:44:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731627873; x=1732232673; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NkEc0pjQBiJKihcl8Ampp9WSxBNI3byp8MstTjhwb3g=;
        b=LpYg/YSBOiMyrkeYJ15Nl0gbrtcKE75ePpBEWhl0DVo3DsSEKd7/3RyTz1jDD/YWZc
         zu2BoZSQwj4cyFCZslYJwrvGk48wJ5oiQhLwnUmznCeFuv/KROEP5a+mVPdh5/sqbsog
         Vn1sxKfwYVHaVJSdtuX5ekp6xznh+uv87MV+Sjg5iFPUgFaexj1TnuHR8IoLX0uD2CQA
         /J7tfba+F2V4hfY5wWSfG47i1Owfi9uANo/REgqlFrF4ikfbgMs2hm5D29sfnC3dKaA7
         qGAuAKb77gok5T9CZ8fU32RhnFc/+GvOHYmMUNxDZIx0bR/l6Wg0NeWD06dzRL5862nV
         JxYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731627873; x=1732232673;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NkEc0pjQBiJKihcl8Ampp9WSxBNI3byp8MstTjhwb3g=;
        b=qMYttUq6uWmrK7MvV771/oNahJjxVTWe0IoVfPZqNIpAvqwOumaneJDrUnIRIyypj9
         nwV1hwgnxYs0vkBiXtsO1reN5+H1iQh527ozMKrzPEb8sONzfdPSljWguDW1k1jqZljB
         0bOW/0VkeISWJ3FmbPd0kqqmbYk4IOoQFAwEOkNm8iTDJIqFPPV3nAuaIzriJjFkmEfk
         tDfharIZtequAzeW5QpQHrFUvDjUfGGftgwlNjNDf2GPKO2Y2IM+QYcAuPYZfBLJ9+ex
         049AgTMHxnB1zCFcl3GgTusnLGQ4OSgJq3K8bzXUbmxWH6MAwY/6M+saXo8Uwl6hWrzf
         0iAQ==
X-Forwarded-Encrypted: i=1; AJvYcCUfY2UtLe+XXXW6twsG1bcPsynerxBaLX53rKSvK2/ZXgeUeo/bpaxjpdORRpBgOjjVCwg=@vger.kernel.org, AJvYcCVanLWgCqJZ4zNxuJ97M1lIekiFW8foacmGYsPvfyUiUp8DzpyjDm+gVfirgKlmLpfFeqPSaiWmbOb0OdfE@vger.kernel.org, AJvYcCW9KzVvb1+KOWoAqBz0GGxbKZSkIVo3v0es/uTJJ2gVfFuv7wj8kYWIAxekk3iLyea4Lxb3TBOS+EcvId78cBRNrVJs@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8DJOel7IXtktu98AkeNCyj7Nv+V+EUVU6JEVbG5uFdeNEHGiq
	5I3hOUIxOmhh/sreXqHvSXGhyW8u0DH2oiy+KKLPBpJSel9btzf6u2gvAOQgVXhnBjkR8CDQ7vi
	f/taMwsbL3jGrh4l9oiEkgC2MvE8=
X-Google-Smtp-Source: AGHT+IFmnnSPmZNJVfy7K3kH6Qfs6QPidvlhFwrzhcCtpQtHc2v0wh6eszbMV+FHcExN5m+9ba8PTZ84bCN28P+Dy7A=
X-Received: by 2002:a17:90b:1dcc:b0:2e2:e31a:220e with SMTP id
 98e67ed59e1d1-2ea154cc16fmr1063746a91.8.1731627872931; Thu, 14 Nov 2024
 15:44:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241105133405.2703607-1-jolsa@kernel.org> <20241105133405.2703607-8-jolsa@kernel.org>
In-Reply-To: <20241105133405.2703607-8-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 14 Nov 2024 15:44:20 -0800
Message-ID: <CAEf4BzYH8YvNLjBPB5sBQ-gz3GkvCVBbU1JCxqpHoVb9Zq51Gw@mail.gmail.com>
Subject: Re: [RFC perf/core 07/11] uprobes/x86: Add support to optimize uprobes
To: Jiri Olsa <jolsa@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, Song Liu <songliubraving@fb.com>, 
	Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>, Hao Luo <haoluo@google.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Alan Maguire <alan.maguire@oracle.com>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 5, 2024 at 5:35=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
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

As discussed offline, it's not as simple as just replacing nop1 with
nop5 in USDT definition due to performance considerations on old
kernels (nop5 isn't fast as far as uprobe is concerned), but I think
we'll be able to accommodate transparent "nop1 or nop5" behavior in
user space, we'll just need a careful backwards compatible extension
to USDT definition.

BTW, do you plan to send an optimization for nop5 to avoid
single-stepping them? Ideally we'd just handle any-sized nop, so we
don't have to do this "nop1 or nop5" acrobatics in the future.

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

fun... ideally we wouldn't do this lazily, I just came up with another
possible idea, but let's keep all this discussion to another thread
with Peter

>
> TODO release uprobe trampoline when it's no longer needed.. we might need=
 to
> stop all cpus to make sure no user space thread is in the trampoline.. or=
 we
> might just keep it, because there's just one 4GB memory region?

4KB not 4GB, right? Yeah, probably leaving it until process exists is
totally fine.

>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  arch/x86/include/asm/uprobes.h |   7 ++
>  arch/x86/kernel/uprobes.c      | 130 +++++++++++++++++++++++++++++++++
>  include/linux/uprobes.h        |   1 +
>  kernel/events/uprobes.c        |   3 +
>  4 files changed, 141 insertions(+)
>
> diff --git a/arch/x86/include/asm/uprobes.h b/arch/x86/include/asm/uprobe=
s.h
> index 678fb546f0a7..84a75ed748f0 100644
> --- a/arch/x86/include/asm/uprobes.h
> +++ b/arch/x86/include/asm/uprobes.h
> @@ -20,6 +20,11 @@ typedef u8 uprobe_opcode_t;
>  #define UPROBE_SWBP_INSN               0xcc
>  #define UPROBE_SWBP_INSN_SIZE             1
>
> +enum {
> +       ARCH_UPROBE_FLAG_CAN_OPTIMIZE   =3D 0,
> +       ARCH_UPROBE_FLAG_OPTIMIZED      =3D 1,
> +};
> +
>  struct uprobe_xol_ops;
>
>  struct arch_uprobe {
> @@ -45,6 +50,8 @@ struct arch_uprobe {
>                         u8      ilen;
>                 }                       push;
>         };
> +
> +       unsigned long flags;
>  };
>
>  struct arch_uprobe_task {
> diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
> index 02aa4519b677..50ccf24ff42c 100644
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
> @@ -877,6 +878,33 @@ static const struct uprobe_xol_ops push_xol_ops =3D =
{
>         .emulate  =3D push_emulate_op,
>  };
>
> +static int is_nop5_insns(uprobe_opcode_t *insn)

insns -> insn?

> +{
> +       return !memcmp(insn, x86_nops[5], 5);
> +}
> +
> +static int is_call_insns(uprobe_opcode_t *insn)

ditto, insn, singular?

> +{
> +       return *insn =3D=3D 0xe8;
> +}
> +
> +static void relative_insn(void *dest, void *from, void *to, u8 op)
> +{
> +       struct __arch_relative_insn {
> +               u8 op;
> +               s32 raddr;
> +       } __packed *insn;
> +
> +       insn =3D (struct __arch_relative_insn *)dest;
> +       insn->raddr =3D (s32)((long)(to) - ((long)(from) + 5));
> +       insn->op =3D op;
> +}
> +
> +static void relative_call(void *dest, void *from, void *to)
> +{
> +       relative_insn(dest, from, to, CALL_INSN_OPCODE);
> +}
> +
>  /* Returns -ENOSYS if branch_xol_ops doesn't handle this insn */
>  static int branch_setup_xol_ops(struct arch_uprobe *auprobe, struct insn=
 *insn)
>  {
> @@ -896,6 +924,10 @@ static int branch_setup_xol_ops(struct arch_uprobe *=
auprobe, struct insn *insn)
>                 break;
>
>         case 0x0f:
> +               if (is_nop5_insns((uprobe_opcode_t *) &auprobe->insn)) {
> +                       set_bit(ARCH_UPROBE_FLAG_CAN_OPTIMIZE, &auprobe->=
flags);
> +                       break;
> +               }
>                 if (insn->opcode.nbytes !=3D 2)
>                         return -ENOSYS;
>                 /*
> @@ -1267,3 +1299,101 @@ bool arch_uretprobe_is_alive(struct return_instan=
ce *ret, enum rp_check ctx,
>         else
>                 return regs->sp <=3D ret->stack;
>  }
> +
> +int arch_uprobe_verify_opcode(struct page *page, unsigned long vaddr,
> +                             uprobe_opcode_t *new_opcode, void *opt)
> +{
> +       if (opt) {
> +               uprobe_opcode_t old_opcode[5];
> +               bool is_call;
> +
> +               uprobe_copy_from_page(page, vaddr, (uprobe_opcode_t *) &o=
ld_opcode, 5);
> +               is_call =3D is_call_insns((uprobe_opcode_t *) &old_opcode=
);
> +
> +               if (is_call_insns(new_opcode)) {
> +                       if (is_call)            /* register: already inst=
alled? */

probably should check that the destination of the call instruction is
what we expect?

> +                               return 0;
> +               } else {
> +                       if (!is_call)           /* unregister: was it cha=
nged by us? */
> +                               return 0;
> +               }
> +
> +               return 1;
> +       }
> +
> +       return uprobe_verify_opcode(page, vaddr, new_opcode);
> +}

[...]

> +int set_orig_insn(struct arch_uprobe *auprobe, struct mm_struct *mm, uns=
igned long vaddr)
> +{
> +       uprobe_opcode_t *insn =3D (uprobe_opcode_t *) auprobe->insn;
> +
> +       if (test_bit(ARCH_UPROBE_FLAG_OPTIMIZED, &auprobe->flags))
> +               return uprobe_write_opcode(auprobe, mm, vaddr, insn, 5, (=
void *) 1);
> +
> +       return uprobe_write_opcode(auprobe, mm, vaddr, insn, UPROBE_SWBP_=
INSN_SIZE, NULL);
> +}
> +
> +bool arch_uprobe_is_callable(unsigned long vtramp, unsigned long vaddr)
> +{
> +       unsigned long delta;
> +
> +       /* call instructions size */
> +       vaddr +=3D 5;
> +       delta =3D vaddr < vtramp ? vtramp - vaddr : vaddr - vtramp;
> +       return delta < 0xffffffff;

isn't immediate a sign extended 32-bit value (that is, int)? wouldn't
this work and be correct:

long delta =3D (long)(vaddr + 5 - vtramp);
return delta >=3D INT_MIN && delta <=3D INT_MAX;

?


> +}
> diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
> index 4024e6ea52a4..42ab29f80220 100644
> --- a/include/linux/uprobes.h
> +++ b/include/linux/uprobes.h
> @@ -233,6 +233,7 @@ void put_tramp_area(struct tramp_area *area);
>  bool arch_uprobe_is_callable(unsigned long vtramp, unsigned long vaddr);
>  extern void *arch_uprobe_trampoline(unsigned long *psize);
>  extern void handle_syscall_uprobe(struct pt_regs *regs, unsigned long bp=
_vaddr);
> +extern void arch_uprobe_optimize(struct arch_uprobe *auprobe, unsigned l=
ong vaddr);
>  #else /* !CONFIG_UPROBES */
>  struct uprobes_state {
>  };
> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> index b8399684231c..efe45fcd5d0a 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -2759,6 +2759,9 @@ static void handle_swbp(struct pt_regs *regs)
>
>         handler_chain(uprobe, regs);
>
> +       /* Try to optimize after first hit. */
> +       arch_uprobe_optimize(&uprobe->arch, bp_vaddr);
> +
>         if (arch_uprobe_skip_sstep(&uprobe->arch, regs))
>                 goto out;
>
> --
> 2.47.0
>

