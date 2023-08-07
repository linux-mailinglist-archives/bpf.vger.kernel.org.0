Return-Path: <bpf+bounces-7197-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 970967730A6
	for <lists+bpf@lfdr.de>; Mon,  7 Aug 2023 22:48:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D73D2814FA
	for <lists+bpf@lfdr.de>; Mon,  7 Aug 2023 20:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15D4715AC2;
	Mon,  7 Aug 2023 20:48:43 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E329C125C3
	for <bpf@vger.kernel.org>; Mon,  7 Aug 2023 20:48:42 +0000 (UTC)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76BD610F6;
	Mon,  7 Aug 2023 13:48:34 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-9936b3d0286so750347466b.0;
        Mon, 07 Aug 2023 13:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691441313; x=1692046113;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8CVC74fhP0sy/y3NvWAwOMXaX3+HMUjEbw6HzuiD9uQ=;
        b=PaO30Qr5zLgmYyvf4Z+3G9KqIMYdeSd8FopFZ00wZGL4BEOxcbvvOpWz7RlOI1c9US
         6aZAkmx9N0AvGcN8N3/tQ1qTjP3JNKdY+zB59VB7BetcvCRJrnKPY2Ckw3nKC7LbcUij
         8gryIoefc4PbipIouFSencBJt48m/ZpWWU3HCBLIXLM9jd0VApvE7wDIUEfvxhzNZlKN
         cLHLPey7tiMmqYjczppU9fc8B9sZGMqO3XyNdW0Gh3bz9PxB+qNweIwAQSz0YsJumcv8
         uMu/8r7BKAtq0b9AcHz5imdDna1lTdFQ+NdWd0VuHZPz0RpHGGdlKTDAtTFf4yqAY+ee
         mt/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691441313; x=1692046113;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8CVC74fhP0sy/y3NvWAwOMXaX3+HMUjEbw6HzuiD9uQ=;
        b=EypoGcyikHW8kCvdPONsrlqaOb6PwGIcZVxfteYvZ/KJJ2IIN9dp5p7iIwvovtY9/f
         Ptbtg4xuQw9yVS1Q369FR4+VwrhWeq6xfXYE9lVCNs+pftzFt8eTzFVnS4W4J07Kz9SX
         sntrGM3+cj+LxKpNb4Uw0oE7hRm2aux7kKfrnRFqi27/TlmYBkSHBsFwPHGpHOUZYYrx
         //Je0fr2xd8U2bbYwgqd85MYpAy9WAD7QG4OUzmCaRRX75uetbZo/7LoJPmQqu/oPvOJ
         aS7Erv4YpnTL64mwV7aU5ZQHTD7eae8/9Bp7ppUBIwuzano3nn4TnEwZ7VRpwFHCWV4w
         3wdA==
X-Gm-Message-State: AOJu0YyWm71Vok4PYz+i/bsHkZL5u/P52YJnnjZ+eEn74ENumKISyNBu
	K97/8CZO8nYZXq9q6DyNLpU=
X-Google-Smtp-Source: AGHT+IGi9neasvPU3HF15xpZdrL+c2axX9IYb3Ux1/9J0YE2gqbZBeoWr756aN7H9t+gAOmSyfgBGA==
X-Received: by 2002:a17:906:1045:b0:98d:f4a7:71cf with SMTP id j5-20020a170906104500b0098df4a771cfmr10832322ejj.62.1691441312595;
        Mon, 07 Aug 2023 13:48:32 -0700 (PDT)
Received: from krava ([83.240.60.134])
        by smtp.gmail.com with ESMTPSA id ot29-20020a170906ccdd00b00991d54db2acsm5617944ejb.44.2023.08.07.13.48.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 13:48:32 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 7 Aug 2023 22:48:29 +0200
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Florent Revest <revest@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	linux-trace-kernel@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, bpf <bpf@vger.kernel.org>,
	Sven Schnelle <svens@linux.ibm.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alan Maguire <alan.maguire@oracle.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v4 3/9] bpf/btf: Add a function to search a member of a
 struct/union
Message-ID: <ZNFYnbqlyOjo5dkH@krava>
References: <CAADnVQ+C64_C1w1kqScZ6C5tr6_juaWFaQdAp9Mt3uzaQp2KOw@mail.gmail.com>
 <20230801085724.9bb07d2c82e5b6c6a6606848@kernel.org>
 <CAADnVQLaFpd2OhqP7W3xWB1b9P2GAKgrVQU1FU2yeNYKbCkT=Q@mail.gmail.com>
 <20230802000228.158f1bd605e497351611739e@kernel.org>
 <20230801112036.0d4ee60d@gandalf.local.home>
 <20230801113240.4e625020@gandalf.local.home>
 <CAADnVQ+N7b8_0UhndjwW9-5Vx2wUVvojujFLOCFr648DUv-Y2Q@mail.gmail.com>
 <20230801190920.7a1abfd5@gandalf.local.home>
 <CABRcYmJjtVq-330ktqTAUiNO1=yG_aHd0xz=c550O5C7QP++UA@mail.gmail.com>
 <20230804004206.9fdfae0b9270b9acca2c096f@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230804004206.9fdfae0b9270b9acca2c096f@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Aug 04, 2023 at 12:42:06AM +0900, Masami Hiramatsu wrote:

SNIP

> > 
> > On the other hand, untangling all code paths that come from
> > trampolines (with a light regs structure) from those that come from an
> > exception (with a pt_regs) could lead to a lot of duplicated code, and
> > converting between each subsystem's idea of a light regs structure
> > (what if perf introduces a perf_regs now ?) would be tedious and slow
> > (lots of copies ?).
> 
> This is one discussion point I think. Actually, using pt_regs in kretprobe
> (and rethook) is histrical accident. Originally, it had put a kprobe on
> the function return trampoline to hook it. So keep the API compatiblity
> I made the hand assembled code to save the pt_regs on the stack.
> 
> My another question is if we have the fprobe to trace (hook) the function
> return, why we still need the kretprobe itself. I think we can remove
> kretprobe and use fprobe exit handler, because "function" probing will
> be done by fprobe, not kprobe. And then, we can simplify the kprobe
> interface and clarify what it is -- "kprobe is a wrapper of software
> breakpoint". And we don't need to think about duplicated code anymore :)

1+ sounds like good idea

> 
> >  
> > > Otherwise, ftrace_regs() has support on arm64 for getting to the argument
> > > registers and the stack. Even live kernel patching now uses ftrace_regs().
> > >
> > > >
> > > > If you guys decide to convert fprobe to ftrace_regs please
> > > > make it depend on kconfig or something.
> > > > bpf side needs full pt_regs.
> > 
> > Some wild ideas that I brought up once in a BPF office hour: BPF
> > "multi_kprobe" could provide a fake pt_regs (either by constructing a
> > sparse one on the stack or by JIT-ing different offset accesses and/or
> > by having the verifier deny access to unpopulated fields) or break the
> > current API (is it conceivable to phase out BPF "multi_kprobe"
> > programs in favor of BPF "fprobe" programs that don't lie about their
> > API and guarantees and just provide a ftrace_regs ?)
> 
> +1 :)

so multi_kprobe link was created to allow fast attach of BPF kprobe-type
programs to multiple functions.. I don't think there's need for new fprobe
program

> 
> > 
> > > Then use kprobes. When I asked Masami what the difference between fprobes
> > > and kprobes was, he told me that it would be that it would no longer rely
> > > on the slower FTRACE_WITH_REGS. But currently, it still does.
> > 
> > Actually... Moving fprobe to ftrace_regs should get even more spicy!
> > :) Fprobe also wraps "rethook" which is basically the same thing as
> > kretprobe: a return trampoline that saves a pt_regs, to the point that
> > on x86 kretprobe's trampoline got dropped in favor of rethook's
> > trampoline. But for the same reasons that we don't want ftrace to save
> > pt_regs on arm64, rethook should probably also just save a ftrace_regs
> > ? (also, to keep the fprobe callback signatures consistent between
> > pre- and post- handlers). But if we want fprobe "post" callbacks to
> > save a ftrace_regs now, either we need to re-introduce the kretprobe
> > trampoline or also change the API of kretprobe (and break its symmetry
> > with kprobe and we'd have the same problem all over again with BPF
> > kretprobe program types...). All of this is "beautifully" entangled...
> > :)
> 
> As I said, I would like to phase out the kretprobe itself because it
> provides the same feature of fprobe, which is confusing. jprobe was
> removed a while ago, and now kretprobe is. But we can not phase out
> it at once. So I think we will keep current kretprobe trampoline on
> arm64 and just add new ftrace_regs based rethook. Then remove the
> API next release. (after all users including systemtap is moved) 
> 
> > 
> > > The reason I started the FTRACE_WITH_ARGS (which gave us ftrace_regs) in
> > > the first place, was because of the overhead you reported to me with
> > > ftrace_regs_caller and why you wanted to go the direct trampoline approach.
> > > That's when I realized I could use a subset because those registers were
> > > already being saved. The only reason FTRACE_WITH_REGS was created was it
> > > had to supply full pt_regs (including flags) and emulate a breakpoint for
> > > the kprobes interface. But in reality, nothing really needs all that.
> > >
> > > > It's not about access to args.
> > > > pt_regs is passed from bpf prog further into all kinds of perf event
> > > > functions including stack walking.
> > 
> > If all accesses are done in BPF bytecode, we could (theoretically)
> > have the verifier and JIT work together to deny accesses to
> > unpopulated fields, or relocate pt_regs accesses to ftrace_regs
> > accesses to keep backward compatibility with existing multi_kprobe BPF
> > programs.
> 
> Yeah, that is what I would like to suggest, and what my patch does.
> (let me update rethook too, it'll be a bit tricky since I don't want
> break anything) 
> 
> Thanks,
> 
> > 
> > Is there a risk that a "multi_kprobe" program could call into a BPF
> > helper or kfunc that reads this pt_regs pointer and expect certain
> > fields to be set ? I suppose we could also deny giving that "pt_regs"
> > pointer to a helper... :/

I think Alexei answered this earlier in the thread:

 >From bpf side we don't care that such pt_regs is 100% filled in or
 >only partial as long as this pt_regs pointer is valid for perf_event_output
 >and stack walking that consume pt_regs.
 >I believe that was and still is the case for both x86 and arm64.


jirka

