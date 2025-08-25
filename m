Return-Path: <bpf+bounces-66384-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A123B33EAD
	for <lists+bpf@lfdr.de>; Mon, 25 Aug 2025 14:03:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E28417444E
	for <lists+bpf@lfdr.de>; Mon, 25 Aug 2025 12:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F92A269AFB;
	Mon, 25 Aug 2025 12:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qa5HI015"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED4E921A444
	for <bpf@vger.kernel.org>; Mon, 25 Aug 2025 12:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756123430; cv=none; b=QPE7YSkTHBNVeNQBVE1vnHELy4vVBWwzdvvxpqPH2/cUi3+K+OsP5tnKXuPZZiO/JGIUI1Cy/JSF2k6N60ivq3aCIikVVW9crmRshjChvPnCNaJCOHov+Y/C/x8QsI+IIr4U9JwpT3wA06lNMzCiXLOhNCVQomzJpTgU20ayjz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756123430; c=relaxed/simple;
	bh=LUU+K0b9EeasdRodJmfbaHZk5c7eqBlpbjRO10WhyAc=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cbwhbhfo9kRgIrM40Sbu4s4TVkthxRydkEBl2NlrJ+3WD0di195rb/mUANGleLwEHfnHzvwgN+m0ky9lDtM1S2NnUCOfRqCD5GIl41qvkPsU/R9XJC8G6sE3TYXPKfs0/j5Tg2X96ic4ZHeNel5nuQjXDnNaVeboCF5uoUivknU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qa5HI015; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3c84925055aso954562f8f.2
        for <bpf@vger.kernel.org>; Mon, 25 Aug 2025 05:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756123427; x=1756728227; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/rYdLek0Do8CfuQMNTePNIuLm0/Zj8KMwu2cTd9xkTQ=;
        b=Qa5HI015Q3AEwH2CHs2SQmFO0+qhQ0+NVRpu55ALERWAum+3iJQ12unZffeFe64/hM
         8zIbHg9oCcIGjE2TJyKegy1kMSJh2Db4M/+i+PLp0gCgHJp3qP1Nt+IJ0s6x5+I7aaw5
         Exke3Kd8lRV0Nfs9ZDO3/uezARl2nkWnxJ/TYn3R0ARFUPltXm8p/eDqIn+1aUTYk9+f
         PqNuD3sU+copqBgkBGAc9IakYBbSqO6vtHCZ/X65BW5EVOyLQZ1EqLi5miwt3qWxawqZ
         u2zuHGjtaEBf2/3X75iZoVS2VXodGThHdKkvO+sZvoTOZbV4ubEHF3qqpTDgCCTQ3n4g
         BMVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756123427; x=1756728227;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/rYdLek0Do8CfuQMNTePNIuLm0/Zj8KMwu2cTd9xkTQ=;
        b=suEdYGiFCF+uDc9UGkC11s/ZMU5aWfNJaBlIhxXsk+31BwBR/WSXJUJxtvO2dgpxyn
         3Rks+6qxqjTmwcgNTYdlBSmXituDThFgQvbYmPE5kgqC1IZ/aVHV8OIkrDediNWRusAn
         GoeBI1oRVFJ8wxJRI5LfLVjqtfNVnll8BvqJIiO6DCHjeucPVj9z/vE5f+yAW2iNyX34
         ys0Y6CawTPcLmN9MXSlyOEiJhKBYEPBmYW7OXizZmxhj6ZrdY4n/Q7wJXf5Zhavmb3zj
         xBr+pKq4YkTXG2wZg6Cbij2MzgxD18p5/+oBXMphDx5QMwiranFT3rP8krm58KewigOB
         M8hg==
X-Gm-Message-State: AOJu0YyPKzRj+0HUC3fVtSZ3mf1GDeKugMXqFb6slyCjqoNWq0b9HJli
	w+c90GKRZv05vXwTqulcRG+A9o4eMSRJ08RlUyr6Yrxv+Kh8Fu9ElAQd
X-Gm-Gg: ASbGncsFg8Mpd9PMurQqq5kw7EqJum/r/BwltzRx22pwfqug5LzAIE1BslqFjpt95q5
	F2GwdDGW7FT6DKqDy/V76R8k3qNqAD6zCN1h3fjzwt8CsaXLXe1yNrQAwguEs3VuqkYd+ik2fQS
	GVJj8WBCRjJFaWixe8Jqlpf55Pix3peEknHUWI31D3aPilDFuichPrMWQh5m61Ob2UNa5+E03Ni
	0BuWncusuUK6yGPtqTbx5gGznB5ovsH/rwdfkyscXgh37OaF6nO3Y6bwr1V1kuZ00GtDjXpIF1Y
	N7NxKkIYzNGyJhVjXBKC1mMm2hSJAve2cY9cdbSwMgFqbUBx3+GYBQwSr4JSf3wB5lEVvNbISSX
	0Tdgh3A==
X-Google-Smtp-Source: AGHT+IH6glTMBfsHsTt1L+c+MUVR6832G1K229ELI5rieY+EJAIrFkzS62GW8hWfGhU0GqwbmH+tBw==
X-Received: by 2002:a05:6000:188e:b0:3b9:14f2:7eed with SMTP id ffacd0b85a97d-3c5dce03f34mr8961669f8f.56.1756123426918;
        Mon, 25 Aug 2025 05:03:46 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200::31e0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b5f9b9dcdsm44994065e9.22.2025.08.25.05.03.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 05:03:46 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 25 Aug 2025 14:03:44 +0200
To: Maciej =?utf-8?Q?=C5=BBenczykowski?= <maze@google.com>
Cc: bpf <bpf@vger.kernel.org>, Jesper Dangaard Brouer <brouer@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>, Yonghong Song <yhs@fb.com>,
	Andrii Nakryiko <andrii@kernel.org>, KP Singh <kpsingh@google.com>,
	Stanislav Fomichev <sdf@google.com>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Steven Rostedt <rostedt@goodmis.org>
Subject: Re: 6.12.30 x86_64 BPF_LSM doesn't work without (?) fentry/mcount
 config options
Message-ID: <aKxRIKfqBwvBYxoo@krava>
References: <CANP3RGdfdAuWDexxT8_mt9WP2w4B39i-qo4GLBkQyn2+B7ED2A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANP3RGdfdAuWDexxT8_mt9WP2w4B39i-qo4GLBkQyn2+B7ED2A@mail.gmail.com>

On Thu, Aug 21, 2025 at 03:14:04PM -0700, Maciej Żenczykowski wrote:
> This is on an Android 6.12 GKI kernel for cuttlefish VM, but the
> Android-ness probably shouldn't matter.
> 
> $ cat config.bad | grep BPF_LSM
> CONFIG_BPF_LSM=y
> 
> Trying to attach bpf_lsm_bpf_prog_load hook fails with -EBUSY (always).
> 
> So I decided to enable function graph with retval tracing to track
> down the source of EBUSY... and it started reliably working.

hi,
I don't really have a solution for you, just few notes below

> 
> $ diff config.bad config.works | egrep '^[<>]' | sort
> < 6.12.30-android16-5-g5c72e9fabab7-ab13770814
> < # CONFIG_ENABLE_DEFAULT_TRACERS is not set
> < # CONFIG_FUNCTION_TRACER is not set
> 
> > 6.12.30-android16-5-maybe-dirty
> > # CONFIG_FPROBE is not set
> > # CONFIG_FTRACE_RECORD_RECURSION is not set
> > # CONFIG_FTRACE_SORT_STARTUP_TEST is not set
> > # CONFIG_FTRACE_STARTUP_TEST is not set
> > # CONFIG_FTRACE_VALIDATE_RCU_IS_WATCHING is not set
> > # CONFIG_FUNCTION_PROFILER is not set
> > # CONFIG_HID_BPF is not set
> > # CONFIG_KPROBE_EVENTS_ON_NOTRACE is not set
> > # CONFIG_LIVEPATCH is not set
> > # CONFIG_PSTORE_FTRACE is not set
> > CONFIG_BUILDTIME_MCOUNT_SORT=y
> > CONFIG_DYNAMIC_FTRACE=y
> > CONFIG_DYNAMIC_FTRACE_WITH_ARGS=y
> > CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
> > CONFIG_DYNAMIC_FTRACE_WITH_REGS=y
> > CONFIG_FTRACE_MCOUNT_RECORD=y
> > CONFIG_FTRACE_MCOUNT_USE_OBJTOOL=y
> > CONFIG_FUNCTION_GRAPH_RETVAL=y
> > CONFIG_FUNCTION_GRAPH_TRACER=y
> > CONFIG_FUNCTION_TRACER=y

CONFIG_FUNCTION_TRACER should enable the build with -mnop-mcount or
-mfentry that ends up with nop5 at the function entry

> > CONFIG_GENERIC_TRACER=y
> > CONFIG_HAVE_FUNCTION_GRAPH_RETVAL=y
> > CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
> > CONFIG_KPROBES_ON_FTRACE=y
> > CONFIG_TASKS_RUDE_RCU=y
> 
> The above config diff makes it work (ie. it no longer fails with EBUSY).
> 
> I'm not sure which exact option fixes things
> (I can test if someone has a more specific guess)
> 
> However, I've tracked it down via extensive printk debugging to a pair
> of 'bugs'.
> 
> (a) there is no 5-byte nop in bpf_lsm hooks in the bad config
> (confirmed via disassembly).
> this can be fixed (worked around) via:
> 
> diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
> index 3bc61628ab25..f38744df79c8 100644
> --- a/kernel/bpf/bpf_lsm.c
> +++ b/kernel/bpf/bpf_lsm.c
> @@ -21,7 +21,8 @@
>   * function where a BPF program can be attached.
>   */
>  #define LSM_HOOK(RET, DEFAULT, NAME, ...)      \
> -noinline RET bpf_lsm_##NAME(__VA_ARGS__)       \
> +noinline __attribute__((patchable_function_entry(5))) \
> +RET bpf_lsm_##NAME(__VA_ARGS__) \
>  {                                              \
>         return DEFAULT;                         \
>  }
> 
> [this is likely wrong for non-x86_64, and probably should be
> conditional on something, and may be clang specific...]

we used to do something remotely similar with patchable_function_entry
for bpf_dispatcher [1], but ended up with changing that later [2]

[1] ceea991a019c bpf: Move bpf_dispatcher function out of ftrace locations
    dbe69b299884 bpf: Fix dispatcher patchable function entry to 5 bytes nop

[2] 18acb7fac22f bpf: Revert ("Fix dispatcher patchable function entry to 5 bytes nop")
    c86df29d11df bpf: Convert BPF_DISPATCHER to use static_call() (not ftrace)

> 
> AFAICT the existence of a bpf_lsm hook makes no sense without the nop in it.
> So this is imho a kernel bug.

yes, all the bpf_lsm_* hooks are there for the lsm bpf program as
attachment points and they attach as bpf tracing program ... and we have
ftrace subsystem that keeps track and manages nop5 at function entry for
tracing purposes.. hence the ftrace dependency

perhaps we could generate nops for set of bpf_lsm_* functions if FTRACE
is not enabled, but attachment code already depends on ftrace setup as
you found below with the nop5 and I wonder there will be other surprises

cc Steven

> 
> (b) this results in a *different* (but valid) 5 byte nop then the
> kernel expects (confirmed by disassembly).
> 
> 0f 1f 44 00 08
> vs
> 0f 1f 44 00 00
> 
> It looks to be a compiler (clang I believe) vs tooling (objdump or
> kernel itself?) type of problem.
> [MCOUNT_USE_OBJTOOL makes me think the compiler is being instructed to
> add mcounts that are then replaced with nops, possibly at build time
> via objtool????]

ftrace initializes that at start, check ftrace_init

jirka

> 
> Anyway, this can be fixed via:
> 
> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index ccb2f7703c33..e782acbe6ada 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -575,7 +575,8 @@ static int emit_jump(u8 **pprog, void *func, void *ip)
>  static int __bpf_arch_text_poke(void *ip, enum bpf_text_poke_type t,
>                                 void *old_addr, void *new_addr)
>  {
> -       const u8 *nop_insn = x86_nops[5];
> +       const u8 nop5alt[5] = { 0x0f,0x1f,0x44,0x00,0x08 };
> +       const u8 *nop_insn = nop5alt;
>         u8 old_insn[X86_PATCH_SIZE];
>         u8 new_insn[X86_PATCH_SIZE];
>         u8 *prog;
> 
> Any thoughts on how to fix this more correctly?
> 
> I'm guessing:
> (a) the bpf lsm hooks should be tagged with some 'traceable' macro,
> which should be arch-specific and empty once mcount/fentry or
> something are enabled.
> (b) I'm guessing the x86 poke function needs to accept multiple forms
> of 5 byte pokes.
> 
> But I'm not really sure what would be acceptable here in terms of
> *how* to actually implement this.
> 
> --
> Maciej Zenczykowski, Kernel Networking Developer @ Google
> 

