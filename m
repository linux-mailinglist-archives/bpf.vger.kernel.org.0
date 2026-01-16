Return-Path: <bpf+bounces-79307-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ED8ED33812
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 17:30:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 22CD33027270
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 16:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5447F2DF12F;
	Fri, 16 Jan 2026 16:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EJ4KCFkY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5D136A036
	for <bpf@vger.kernel.org>; Fri, 16 Jan 2026 16:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768581009; cv=none; b=mp/14tDk60X9otWrCyeby13tN06LwyrGK6JVtCmMUzNe8x99dWZwzwKLNoROJYbcibnnV6ngFXIhYwo5hcIxWuH7vcHcR6ny4dwsyICdz38erjU3uylxzNz4L+/0DOQZn1LIhBI5JB4c/yInaxmVDy1uYJl4DCvcr3Y4yXaFrFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768581009; c=relaxed/simple;
	bh=vqAtTeNWt3JMsiSmpuFstThHQ/fLKkzmuvRKV8eEXAM=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KHeB+BLfD1lTuFiuTSfCm+9nVaL8c3odRG8zmgH7pC1qLQT09D31/FSNCn/bTP0JN4gE20ia/lTTxsslr2X2qTrCfDwhcy9hngNKA/dmgizj2Uyk+SqVxrHEQTaJ7nJAd5KlEGiUwRP6b2Mb7lVsA6rlkvFAVhG1Sss02Lf3bwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EJ4KCFkY; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4801d1daf53so12813785e9.2
        for <bpf@vger.kernel.org>; Fri, 16 Jan 2026 08:30:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768581004; x=1769185804; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SRhP8YQ5SRdHis3aow3C5p57lTyMCB7HNXIP4SvzJMY=;
        b=EJ4KCFkY4E58842ryfjumr68rgQszyD3rKBBWA+c4BJksdzCddSr5GKn29WtCyXKHS
         CK/J+IeE5Y3o9A+9ybt6NMFk1k7WtG/cB1RkvMxFNqYSjhsa3Kg8NUW2StwT6SSQ4xvV
         XisHQX/1lzpOTEoFB1jonJVnnJyIFYvtKZrH/CtmQgYbKikQ87tLnFwyUeTWxFCMJDD7
         cDCljw5a0BVCkvbRaddX2xWUY92mey325I48oJ3Zocpyq+8RguQS7JX2JmV5tOch4gCe
         sHZeFc+ZiNcl2KrxdolN+ypiRMiz3VkGDuRtyXibYRxUVNtrfOXRlmaU0ljiPIn8nZee
         haNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768581004; x=1769185804;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SRhP8YQ5SRdHis3aow3C5p57lTyMCB7HNXIP4SvzJMY=;
        b=jfQAUo/HMhh8wROIDIIXmdEml9q3h9U4IQpPTdrkGfN27EIn3KU4bKc2EJWlNGG6gj
         DCLWHvgPRTdR0yRrEQfTvlGZaXkHCf73tKLd0/YPnR6Q8a5kZWiTU842pgAstZN4G2FW
         eIIgkyi65uiZWV2ywpVW1OJHtIRqgrONIBRu9WxQhuD6SDAUbWliLUpYnVvz126gxRxl
         3HOjU31iqOWEBruhIs1WqRre7ahUy+N5gygWpt035YQUGN+0aVhijVc45UoD452HBIWN
         rFkYeTFilvgh+Yzs6fX0lI8oDUptVrolVAEBpm6Z/hJdt2FQ5IRsgHxqktHNkjyoTAA4
         hyjw==
X-Forwarded-Encrypted: i=1; AJvYcCXZFA5NctQhjKulKnBMjtsZhSRzfDshR9UpDLA3GbPSiN0oko7+8ggd9d3UqbhJ/OOOUk8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUXsnJAs/smw+T/dm0gZaea7KjR1sv8DybiILOEfrkSnNs3smE
	gxVyJ1eB4jZ+aZZMtwTjcVdTXckQ+LFoDLhsM3kk9HbPu3oveAg6bbDC
X-Gm-Gg: AY/fxX6qMkrJZKKsZfsEQHeJ6hwGNSjfJgkBFXOhSFOws9VkVsm+D6QRd4ZQ71vxaTI
	uf8g+CO0M0wlKXQ22Z98gztBzAfwepkczGfwQbYrSTe8sPOdHvbarsb9qPAmbCVnUCtP0vKDBNt
	XmJ4zJc/UNhOzPf1DYaz70h+5ar1GE3I7JS2TT7kTaz3RtKEURjesInMoQRHu1nORR48MvOwqzr
	f6Km7Z7z+RY9DE3GDYX7CxAkxrM+R1yW2mgEo/s7ObL/Hny7CPbM2BO4OapaqiBFdsJP473Evdi
	Xx/oRGJJO6jvKHI4ussuLwzhYKIF6LbG8+oMqPnk3oDBMnAhhu2A4Akk8DPf7VCauskFc8NtDGa
	S5ron8++2n6cfN6B5X4E5Wie/9RYageVsJ6pmgmIWcpWxrgz4o2Dc/8ltc1Q2OxFHW5JZaWfws1
	IfGlxGuE56vDIxng==
X-Received: by 2002:a05:600c:4586:b0:477:9ce2:a0d8 with SMTP id 5b1f17b1804b1-4801e29edc9mr45785855e9.0.1768581004338;
        Fri, 16 Jan 2026 08:30:04 -0800 (PST)
Received: from krava ([2a00:102a:400f:3ccc:ffd6:980:bac0:cb06])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4801e80c477sm62954615e9.0.2026.01.16.08.30.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 08:30:04 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 16 Jan 2026 17:30:01 +0100
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, x86@kernel.org,
	Yonghong Song <yhs@fb.com>, Song Liu <songliubraving@fb.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Mahe Tardy <mahe.tardy@gmail.com>
Subject: Re: [PATCH bpf-next 4/4] selftests/bpf: Allow to benchmark trigger
 with stacktrace
Message-ID: <aWpniVM2NKteJaA5@krava>
References: <20260112214940.1222115-1-jolsa@kernel.org>
 <20260112214940.1222115-5-jolsa@kernel.org>
 <CAEf4BzaXhGpkycs-TO_1V81-irq3d8Mjfyk=LMc0OC-NW-FnRg@mail.gmail.com>
 <CAEf4Bzbn-Sai+pnC1Gu-E-uhJeSA8g-6xB49bswdPFpJd92Rng@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4Bzbn-Sai+pnC1Gu-E-uhJeSA8g-6xB49bswdPFpJd92Rng@mail.gmail.com>

On Thu, Jan 15, 2026 at 10:50:13AM -0800, Andrii Nakryiko wrote:

SNIP

> > > diff --git a/tools/testing/selftests/bpf/benchs/bench_trigger.c b/tools/testing/selftests/bpf/benchs/bench_trigger.c
> > > index 34018fc3927f..aeec9edd3851 100644
> > > --- a/tools/testing/selftests/bpf/benchs/bench_trigger.c
> > > +++ b/tools/testing/selftests/bpf/benchs/bench_trigger.c
> > > @@ -146,6 +146,7 @@ static void setup_ctx(void)
> > >         bpf_program__set_autoload(ctx.skel->progs.trigger_driver, true);
> > >
> > >         ctx.skel->rodata->batch_iters = args.batch_iters;
> > > +       ctx.skel->rodata->stacktrace = env.stacktrace;
> > >  }
> > >
> > >  static void load_ctx(void)
> > > diff --git a/tools/testing/selftests/bpf/progs/trigger_bench.c b/tools/testing/selftests/bpf/progs/trigger_bench.c
> > > index 2898b3749d07..479400d96fa4 100644
> > > --- a/tools/testing/selftests/bpf/progs/trigger_bench.c
> > > +++ b/tools/testing/selftests/bpf/progs/trigger_bench.c
> > > @@ -25,6 +25,23 @@ static __always_inline void inc_counter(void)
> > >         __sync_add_and_fetch(&hits[cpu & CPU_MASK].value, 1);
> > >  }
> > >
> > > +volatile const int stacktrace;
> > > +
> > > +typedef __u64 stack_trace_t[128];
> > > +
> > > +struct {
> > > +       __uint(type, BPF_MAP_TYPE_STACK_TRACE);
> > > +       __uint(max_entries, 16384);
> > > +       __type(key, __u32);
> > > +       __type(value, stack_trace_t);
> > > +} stackmap SEC(".maps");
> 
> oh, and why bother with STACK_TRACE map, just call bpf_get_stack() API
> and have maybe per-CPU scratch array for stack trace (per-CPU so that
> in multi-cpu benchmarks they don't just contend on the same cache
> lines)

ok, will change

thanks,
jirka

