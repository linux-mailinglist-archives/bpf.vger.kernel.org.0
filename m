Return-Path: <bpf+bounces-66500-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13B8AB3520C
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 05:07:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCEC63A99D5
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 03:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5BED2BE7CB;
	Tue, 26 Aug 2025 03:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fdIac/yB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5039D7260B
	for <bpf@vger.kernel.org>; Tue, 26 Aug 2025 03:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756177657; cv=none; b=SHePajm6oPxsdiTpsMDLCjPuqE2ChwWMFvLX/KXe7FkT1fmvywoxGg/QkCMC4hHQmKMc7ivI3kBsXCuovQ+nnh4Q/S5bHN2jGalep/3ia0O6bjJCeIx7nNEzSOfh0mEWqu/PGL+e/Kpjww+JX7VE9Tc3UNTNm8Zqd0BelesE3U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756177657; c=relaxed/simple;
	bh=NcrD+O8+5QxYvfrDVIpE1P4YJC1Bii9npoD2aVfJysU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kM1m5knOaZsWWUtYPARTP7qnzvbF/Z0f5+s0XY6rIw9Qx5FZ45qI+dhlIjYHRwQO4Xx8aaG5dQH4Eb82qc+Ga3vCieQ6yttTZftLvDEkrdr6guos3rd6j8c5AD2u6tvn2gExGSESmnSLKmD21Jsqy78wt5I0OnUNaCyREVLBYHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fdIac/yB; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-618660b684fso5946a12.0
        for <bpf@vger.kernel.org>; Mon, 25 Aug 2025 20:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756177654; x=1756782454; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1A0naJnkjzGU4cVm86kMe71hm4BK2zM65Rb/UuUgMyU=;
        b=fdIac/yB+feQJMIPaDtg8xdNytuODliLXkSoY7PebgqPJqXaGTFtlxt72dW213aFqO
         Dk7vAjqwk2qO+tO4S84knE7BLaeZGQFMQ5bZ1WmE55I+cN9a63BBt+fyeQ+FdY2B7zaW
         PpPfHBKp9NwzFj41Aok/T19e6OW+Z1TMOxVqQ7dRK1TgQa9P89hVxBmET3o8VLT5Vhj4
         BuxT3OBLh8psiwdVkHldsmYl2Ze71r7YlT0/1vr8M8438+2rBAiP1XkAlsbp8LZpFBzx
         ARz9Yc8xt/Ylntd7bm2mtamKgl6X3//zGgOM8+tj3we0H9ltQI7AISox8URODb9Pyhxb
         ICHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756177654; x=1756782454;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1A0naJnkjzGU4cVm86kMe71hm4BK2zM65Rb/UuUgMyU=;
        b=rANPkVv3/HhydL9GkfOR3qFrU+77/Gmf63r0ObyQ4FusLHAKSW6TUwYDwwzbX1fQ1I
         SDyNgpoBHQmzs7l3YdvWr+gvpztvfckDbtz9IQMejpj7KNhI379Yek8NRVMrKmKs61kT
         IoYVE0FKWdEpjrvSIOeNDvTL1wyqn5d+hsyUR0MRdP1gOD5bJJpZLK1gxGawG9TCLxBf
         R7JyUif+CbutElPUU67pfgxC4maMOm27jqbw3A/w2qPsn4QLNeBxBH00hazmvGkvysKl
         igQGyoFQXi7Rb36YSkvDd6ytdWs66KaQngBDbrbqVBkkMWEoTIb/+cgt9/JrmoAbyIpO
         W+Pw==
X-Gm-Message-State: AOJu0YxTFHiIuIhNrmW3RjhF9u/MloNk4iuDslL7CQjNQKJzoIzZWsTN
	z9EwCp+AiBPhZH7L4p9t0/Otdl5+TZihDiYHDkNKXaxsbeKAXZyzdqF2db6woSrglJC9GMR8Fqo
	6no5wTXJeOJODV0iKoKNVPy3qyqWCWRsmEAz0hf1a
X-Gm-Gg: ASbGncs4249op/dCs3cnsUkxgyx+usKu0XojqjAhAifrM+ls+48z5Ziysizuk4C7Ph+
	moR08tLSghq67gH6GwKDTAEAigwdzhjEEWS5wVdtysDc/xipxSoC2bwPT+jTvgUWA3Yk13JK3iY
	dNb5J30f1EUEMXtcm/ASMYTQ3vwPxctZBuCqaay0csQPCRtBeSHn+hgf98TXVFoIC9oWIBq77qO
	4STVTX97Yz/QSN4Ud88dZf2UOChfHDq2HqtITJc2Rqu
X-Google-Smtp-Source: AGHT+IFKUqyIYRKJNYO5GceZBDibleYjP/az3hfAZHjfeHCyRRfmEgNlII9yeCBtjCvbxDBOblU79cg/AoUud/HhcS0=
X-Received: by 2002:a05:6402:2398:b0:61c:32fb:999b with SMTP id
 4fb4d7f45d1cf-61c91d000e6mr26198a12.1.1756177653394; Mon, 25 Aug 2025
 20:07:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANP3RGdfdAuWDexxT8_mt9WP2w4B39i-qo4GLBkQyn2+B7ED2A@mail.gmail.com>
 <aKxRIKfqBwvBYxoo@krava>
In-Reply-To: <aKxRIKfqBwvBYxoo@krava>
From: =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>
Date: Mon, 25 Aug 2025 20:07:21 -0700
X-Gm-Features: Ac12FXxRo7BqDXh8ESMoU1zuA8uijgQHBcgN1r7AYW_hhe4SqHlQhDPi_fe_UDg
Message-ID: <CANP3RGfYVyQHrZYrSQAsCWiaia72FOVp_Lwv-H-bScAPkyfoEg@mail.gmail.com>
Subject: Re: 6.12.30 x86_64 BPF_LSM doesn't work without (?) fentry/mcount
 config options
To: Jiri Olsa <olsajiri@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Jesper Dangaard Brouer <brouer@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Yonghong Song <yhs@fb.com>, 
	Andrii Nakryiko <andrii@kernel.org>, KP Singh <kpsingh@google.com>, 
	Stanislav Fomichev <sdf@google.com>, Matt Bobrowski <mattbobrowski@google.com>, 
	Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 25, 2025 at 5:03=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Thu, Aug 21, 2025 at 03:14:04PM -0700, Maciej =C5=BBenczykowski wrote:
> > This is on an Android 6.12 GKI kernel for cuttlefish VM, but the
> > Android-ness probably shouldn't matter.
> >
> > $ cat config.bad | grep BPF_LSM
> > CONFIG_BPF_LSM=3Dy
> >
> > Trying to attach bpf_lsm_bpf_prog_load hook fails with -EBUSY (always).
> >
> > So I decided to enable function graph with retval tracing to track
> > down the source of EBUSY... and it started reliably working.
>
> hi,
> I don't really have a solution for you, just few notes below
>
> >
> > $ diff config.bad config.works | egrep '^[<>]' | sort
> > < 6.12.30-android16-5-g5c72e9fabab7-ab13770814
> > < # CONFIG_ENABLE_DEFAULT_TRACERS is not set
> > < # CONFIG_FUNCTION_TRACER is not set
> >
> > > 6.12.30-android16-5-maybe-dirty
> > > # CONFIG_FPROBE is not set
> > > # CONFIG_FTRACE_RECORD_RECURSION is not set
> > > # CONFIG_FTRACE_SORT_STARTUP_TEST is not set
> > > # CONFIG_FTRACE_STARTUP_TEST is not set
> > > # CONFIG_FTRACE_VALIDATE_RCU_IS_WATCHING is not set
> > > # CONFIG_FUNCTION_PROFILER is not set
> > > # CONFIG_HID_BPF is not set
> > > # CONFIG_KPROBE_EVENTS_ON_NOTRACE is not set
> > > # CONFIG_LIVEPATCH is not set
> > > # CONFIG_PSTORE_FTRACE is not set
> > > CONFIG_BUILDTIME_MCOUNT_SORT=3Dy
> > > CONFIG_DYNAMIC_FTRACE=3Dy
> > > CONFIG_DYNAMIC_FTRACE_WITH_ARGS=3Dy
> > > CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=3Dy
> > > CONFIG_DYNAMIC_FTRACE_WITH_REGS=3Dy
> > > CONFIG_FTRACE_MCOUNT_RECORD=3Dy
> > > CONFIG_FTRACE_MCOUNT_USE_OBJTOOL=3Dy
> > > CONFIG_FUNCTION_GRAPH_RETVAL=3Dy
> > > CONFIG_FUNCTION_GRAPH_TRACER=3Dy
> > > CONFIG_FUNCTION_TRACER=3Dy
>
> CONFIG_FUNCTION_TRACER should enable the build with -mnop-mcount or
> -mfentry that ends up with nop5 at the function entry
>
> > > CONFIG_GENERIC_TRACER=3Dy
> > > CONFIG_HAVE_FUNCTION_GRAPH_RETVAL=3Dy
> > > CONFIG_HAVE_FUNCTION_GRAPH_TRACER=3Dy
> > > CONFIG_KPROBES_ON_FTRACE=3Dy
> > > CONFIG_TASKS_RUDE_RCU=3Dy
> >
> > The above config diff makes it work (ie. it no longer fails with EBUSY)=
.
> >
> > I'm not sure which exact option fixes things
> > (I can test if someone has a more specific guess)
> >
> > However, I've tracked it down via extensive printk debugging to a pair
> > of 'bugs'.
> >
> > (a) there is no 5-byte nop in bpf_lsm hooks in the bad config
> > (confirmed via disassembly).
> > this can be fixed (worked around) via:
> >
> > diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
> > index 3bc61628ab25..f38744df79c8 100644
> > --- a/kernel/bpf/bpf_lsm.c
> > +++ b/kernel/bpf/bpf_lsm.c
> > @@ -21,7 +21,8 @@
> >   * function where a BPF program can be attached.
> >   */
> >  #define LSM_HOOK(RET, DEFAULT, NAME, ...)      \
> > -noinline RET bpf_lsm_##NAME(__VA_ARGS__)       \
> > +noinline __attribute__((patchable_function_entry(5))) \
> > +RET bpf_lsm_##NAME(__VA_ARGS__) \
> >  {                                              \
> >         return DEFAULT;                         \
> >  }
> >
> > [this is likely wrong for non-x86_64, and probably should be
> > conditional on something, and may be clang specific...]
>
> we used to do something remotely similar with patchable_function_entry
> for bpf_dispatcher [1], but ended up with changing that later [2]
>
> [1] ceea991a019c bpf: Move bpf_dispatcher function out of ftrace location=
s
>     dbe69b299884 bpf: Fix dispatcher patchable function entry to 5 bytes =
nop
>
> [2] 18acb7fac22f bpf: Revert ("Fix dispatcher patchable function entry to=
 5 bytes nop")
>     c86df29d11df bpf: Convert BPF_DISPATCHER to use static_call() (not ft=
race)
>
> >
> > AFAICT the existence of a bpf_lsm hook makes no sense without the nop i=
n it.
> > So this is imho a kernel bug.
>
> yes, all the bpf_lsm_* hooks are there for the lsm bpf program as
> attachment points and they attach as bpf tracing program ... and we have
> ftrace subsystem that keeps track and manages nop5 at function entry for
> tracing purposes.. hence the ftrace dependency
>
> perhaps we could generate nops for set of bpf_lsm_* functions if FTRACE
> is not enabled, but attachment code already depends on ftrace setup as
> you found below with the nop5 and I wonder there will be other surprises
>
> cc Steven
>
> >
> > (b) this results in a *different* (but valid) 5 byte nop then the
> > kernel expects (confirmed by disassembly).
> >
> > 0f 1f 44 00 08
> > vs
> > 0f 1f 44 00 00
> >
> > It looks to be a compiler (clang I believe) vs tooling (objdump or
> > kernel itself?) type of problem.
> > [MCOUNT_USE_OBJTOOL makes me think the compiler is being instructed to
> > add mcounts that are then replaced with nops, possibly at build time
> > via objtool????]
>
> ftrace initializes that at start, check ftrace_init
>
> jirka
>
> >
> > Anyway, this can be fixed via:
> >
> > diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> > index ccb2f7703c33..e782acbe6ada 100644
> > --- a/arch/x86/net/bpf_jit_comp.c
> > +++ b/arch/x86/net/bpf_jit_comp.c
> > @@ -575,7 +575,8 @@ static int emit_jump(u8 **pprog, void *func, void *=
ip)
> >  static int __bpf_arch_text_poke(void *ip, enum bpf_text_poke_type t,
> >                                 void *old_addr, void *new_addr)
> >  {
> > -       const u8 *nop_insn =3D x86_nops[5];
> > +       const u8 nop5alt[5] =3D { 0x0f,0x1f,0x44,0x00,0x08 };
> > +       const u8 *nop_insn =3D nop5alt;
> >         u8 old_insn[X86_PATCH_SIZE];
> >         u8 new_insn[X86_PATCH_SIZE];
> >         u8 *prog;
> >
> > Any thoughts on how to fix this more correctly?
> >
> > I'm guessing:
> > (a) the bpf lsm hooks should be tagged with some 'traceable' macro,
> > which should be arch-specific and empty once mcount/fentry or
> > something are enabled.
> > (b) I'm guessing the x86 poke function needs to accept multiple forms
> > of 5 byte pokes.
> >
> > But I'm not really sure what would be acceptable here in terms of
> > *how* to actually implement this.

One possible way I see to fix this - on x86-64 at least, is to do something=
 like
what 'bpf: Fix dispatcher patchable function entry to 5 bytes nop' did
during early (still single threaded) kernel startup and rewrite:
      55               push   %rbp
      48 89 e5         mov    %rsp,%rbp
      31 c0            xor    %eax,%eax
      5d               pop    %rbp
 with equivalent number of bytes:
      0f 1f 44 00 00   nopl   0x0(%rax,%rax,1)   (this is x86_nops[5])
      31 c0            xor    %eax,%eax
which means later we will find the 5-byte nop we need...

Though this does require explicitly listing all the bpf lsm hooks so
we can iterate through them...

Unfortunately it's x86 specific, and I think/believe (again haven't
had time to test) that arm64 has a similar issue.
Except there's likely not enough bytes there to play these sorts of games.

I did initially think I could do that at run time when we actually try
to poke, but that looks hard to do correctly on smp...

So even though this would work, I think it would be better if we had
some actual way to flag bpf lsm hooks as needing the right number of
nops for the arch even with dynamic_ftrace off...
(and why not just enable it?  Well, I haven't tried pushing that past
our security team yet, but it feels it might be an uphill battle)

