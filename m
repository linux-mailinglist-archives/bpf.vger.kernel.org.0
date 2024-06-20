Return-Path: <bpf+bounces-32658-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3533A9115CA
	for <lists+bpf@lfdr.de>; Fri, 21 Jun 2024 00:43:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4B6528328D
	for <lists+bpf@lfdr.de>; Thu, 20 Jun 2024 22:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AB8F13D8A7;
	Thu, 20 Jun 2024 22:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Xuh6wHzl"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 123477407A
	for <bpf@vger.kernel.org>; Thu, 20 Jun 2024 22:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718923410; cv=none; b=EbV8KB5vL1xvKtTFPA3xpDy3JT2xYzlknl4uPP04m5IEq2DWoy659as2xNN0XtLz2PaWrd3ARaCv7EryxTjpakZXLOXT8waQ2BURDnfuzR8NDm/LMK7lopqklJ+B4d0JzOZpLRUV3TKrTvfUm3+s6kOO8Qe5Rm6DQVY+S19YyFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718923410; c=relaxed/simple;
	bh=Bfe2AgnXI7qc1eB42tP3sJ3GNIZuodteiRtnzVol0M4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HV5BNF6hDcicN8Pyx5xo37ugI4NaWx3QgmosbKsUppnTRF7rqItjqYg3yGOEMJdZEgo52fHTjLLKglRhljIjj6/VbMeaDPJaPmOyJMS5Nhr+x4DyuBjioVgBWSySO0Cf0QZHHUdJJjGmtKY8dnsCDFi3HSnS/FVl258FS1tarYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Xuh6wHzl; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-42189d3c7efso16831955e9.2
        for <bpf@vger.kernel.org>; Thu, 20 Jun 2024 15:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1718923407; x=1719528207; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cLIJyrB/gnFlAkantfHrGOHAaqRt3DpcOw/9lCMmFlk=;
        b=Xuh6wHzlzPecf/xTL0rb1TirFDtPYEh56jd8SxwYo2xMciOt0gj2PywNeWP165Nm8l
         C+RsFLMQOSQjcIlbv9UJoeIl3pnqlr6kWhCrQUBDUaM75UsUznqzd3hjJTMsSV2FnN/T
         6H2aLEKT6FW0pGNinr6Z2IFWhMSbrmixvCL98=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718923407; x=1719528207;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cLIJyrB/gnFlAkantfHrGOHAaqRt3DpcOw/9lCMmFlk=;
        b=LpEHxXrphPhOX5RWH6RmAcugvkBWCOhhpp3ZtQEiv9TFhfwj6/FTgfiCjVDAe93l7y
         TQ2pPmS/0OZnDMzDQfWp20jOkIyEA8W+YXElqnsKdaQJFx1U2PspFun9XX61JuTmEy3/
         IWA8mas95C6sXN6GYPApuUeeAwernjTOsUvTp/269JrE6dVJIq3WGYQUcTM+/4iUq6I/
         r4TNqBrrmEv3Ywe5tz6iXlUZml2yhzOccopTq7OqxVd9bh3Q2fsLtJfrnIcVaMPN+6ZC
         mng87XShKBgh6qVwsoaV4cwyuMtriBgVb2KZ2iU4q5VocLIM2HoDZsMJS/WZ3ki1joou
         3w5A==
X-Forwarded-Encrypted: i=1; AJvYcCXoSQnkscfU4HloflnEimTDtKj3hiBvlE5C/ghDt46Hlnzyga7Cbk/gDmRXgv7fvHEyZH+Az0qvE0Qi1kgRJr+Ac7CT
X-Gm-Message-State: AOJu0YzfO2etcuFDEkNQ7a/756+R6HFkT9Gk/ntYUi8duetuJgfEcHHG
	r9dE1Gc2jP4pdBS+lgoV25lH7Cc41E26VLkHM6cdCVBkfkO88Fvyyd9IFOjMZVGteN730GNxmhE
	yaHp/TQ==
X-Google-Smtp-Source: AGHT+IHGQqfSpD0h+InRnvO7zxRw2LBJuimaVY2cJHuNAZfcKUqNzBZEsND4XvgoRn2Qaiu9NntCDA==
X-Received: by 2002:a5d:4488:0:b0:365:e76b:e914 with SMTP id ffacd0b85a97d-365e76be9cdmr653408f8f.43.1718923407329;
        Thu, 20 Jun 2024 15:43:27 -0700 (PDT)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com. [209.85.128.52])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6fcf428b41sm17161066b.21.2024.06.20.15.43.26
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jun 2024 15:43:27 -0700 (PDT)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-421757d217aso16818275e9.3
        for <bpf@vger.kernel.org>; Thu, 20 Jun 2024 15:43:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVcB4yuTH1qSqBgecPyQtacnOYLEfXv4QDXdn022JOvpxnTG0+LkHr9SO2yeJGt7wSUekNeFrQjQV5I9Y2Iy3fqccou
X-Received: by 2002:ac2:5f93:0:b0:52b:e7ff:32b with SMTP id
 2adb3069b0e04-52ccaa32fbdmr4812180e87.23.1718923384950; Thu, 20 Jun 2024
 15:43:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wg8APE61e5Ddq5mwH55Eh0ZLDV4Tr+c6_gFS7g2AxnuHQ@mail.gmail.com>
 <87ed8sps71.ffs@tglx> <CAHk-=wg3RDXp2sY9EXA0JD26kdNHHBP4suXyeqJhnL_3yjG2gg@mail.gmail.com>
 <87bk3wpnzv.ffs@tglx> <CAHk-=wiKgKpNA6Dv7zoLHATweM-nEYWeXeFdS03wUQ8-V4wFxg@mail.gmail.com>
 <878qz0pcir.ffs@tglx> <CAHk-=wg88k=EsHyGrX9dKt10KxSygzcEGdKRYRTx9xtA_y=rqQ@mail.gmail.com>
 <CAHk-=wgjbNLRtOvcmeEUtBQyJtYYAtvRTROBy9GHeF1Quszfgg@mail.gmail.com>
 <ZnRptXC-ONl-PAyX@slm.duckdns.org> <ZnSp5mVp3uhYganb@slm.duckdns.org>
In-Reply-To: <ZnSp5mVp3uhYganb@slm.duckdns.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 20 Jun 2024 15:42:48 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjFPLqo7AXu8maAGEGnOy6reUg-F4zzFhVB0Kyu22h7pw@mail.gmail.com>
Message-ID: <CAHk-=wjFPLqo7AXu8maAGEGnOy6reUg-F4zzFhVB0Kyu22h7pw@mail.gmail.com>
Subject: Re: [PATCH sched_ext/for-6.11] sched, sched_ext: Replace
 scx_next_task_picked() with sched_class->switch_class()
To: Tejun Heo <tj@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, mingo@redhat.com, peterz@infradead.org, 
	juri.lelli@redhat.com, vincent.guittot@linaro.org, dietmar.eggemann@arm.com, 
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, bristot@redhat.com, 
	vschneid@redhat.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@kernel.org, joshdon@google.com, brho@google.com, pjt@google.com, 
	derkling@google.com, haoluo@google.com, dvernet@meta.com, 
	dschatzberg@meta.com, dskarlat@cs.cmu.edu, riel@surriel.com, 
	changwoo@igalia.com, himadrics@inria.fr, memxor@gmail.com, 
	andrea.righi@canonical.com, joel@joelfernandes.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 20 Jun 2024 at 15:15, Tejun Heo <tj@kernel.org> wrote:
>
> The changes are straightforward and the code looks better afterwards.
> However, when !CONFIG_SCHED_CLASS_EXT, this just ends up adding an unused
> hook which is unlikely to be useful to other sched_classes. We can #ifdef
> the op with CONFIG_SCHED_CLASS_EXT but then I'm not sure the code
> necessarily looks better afterwards.

So honestly, if people _really_ care about performance here, then I
think that in the long run the right thing to do is

 - expose all the DEFINE_SCHED_CLASS() definitions in a header file

 - rename for_each_class() to FOR_EACH_CLASS() and make it unroll the
whole damn loop statically

which would turn the indirect branches into actual direct branches,
and would statically just remove any "if (!class->zyz)" conditionals.

Pretty? No. But it probably wouldn't be hugely ugly either, and
honestly, looking at the existing for_each_class() uses (and the one
single "for_class_range()" one), they are so small and the number of
classes is so small that unrolling the loop entirely doesn't sound
bad.

It wouldn't help deal with *this* case (since it's a "call variable
class"), but considering that the current __pick_next_task()

 (a) special-cases one class as-is

 (b) does a "for_each_class()" and calls an indirect call for each
when that doesn't trigger

I would claim that people don't care enough about this that one test
for a NULL 'switch_class' function would be worth worrying about.

Btw, indirect calls are now expensive enough that when you have only a
handful of choices, instead of a variable

        class->some_callback(some_arguments);

you might literally be better off with a macro that does

       #define call_sched_fn(class, name, arg...) switch (class) { \
        case &fair_name_class: fair_name_class.name(arg); break; \
        ... unroll them all here..

which then just generates a (very small) tree of if-statements.

Again, this is entirely too ugly to do unless people *really* care.
But for situations where you have a small handful of cases known at
compile-time, it's not out of the question, and it probably does
generate better code.

NOTE NOTE NOTE! This is a comp[letely independent aside, and has
nothing to do with sched_ext except for the very obvious indirect fact
that sched_ext would be one of the classes in this kind of code.

And yes, I suspect it is too ugly to actually do this.

            Linus

