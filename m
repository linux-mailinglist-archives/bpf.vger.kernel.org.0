Return-Path: <bpf+bounces-6883-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E44D076EFB3
	for <lists+bpf@lfdr.de>; Thu,  3 Aug 2023 18:38:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 124C61C203B1
	for <lists+bpf@lfdr.de>; Thu,  3 Aug 2023 16:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65E461F937;
	Thu,  3 Aug 2023 16:38:10 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE3718B0A
	for <bpf@vger.kernel.org>; Thu,  3 Aug 2023 16:38:09 +0000 (UTC)
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 891F330D2
	for <bpf@vger.kernel.org>; Thu,  3 Aug 2023 09:38:06 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-267ffa7e441so699788a91.1
        for <bpf@vger.kernel.org>; Thu, 03 Aug 2023 09:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1691080686; x=1691685486;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mu93cy9dn4sIHVLCdHM/juTYvjzyY5DvemgKanEAgs8=;
        b=MsV1QNPcjyPkR+mIr+wJRxVAPsMf7eYSgBCaMFnNi6XHMPPQez6YvGkHX6IEV9nHaK
         HOB8JSAzMzljpBTgLnw8FFzhQlaxUPq/uTknz05x6hTwZhzs7a3vqtu6Wo8Je8kobIFV
         +wELZOvm59iHbgNcQUv9Uq/JgB5aV8Aif2b7g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691080686; x=1691685486;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mu93cy9dn4sIHVLCdHM/juTYvjzyY5DvemgKanEAgs8=;
        b=HBqd3lUiF6TWKdORk/z+GPMUCfXeqiazJNoIlBOH+7pNH/chzsnvnWt4Dt+RUaAQwt
         yGe/O1kCE4NxlENznwvZs1F69qZJ3mopIeArvDZ6D2irrQKfG0qE/u7CR/0YyNf/q7E1
         MGK/4E8T5dk3b8DxYZIA1nnO+WPlEHWV7mqHMNp6whhQpjnuZ4Htt/ByKFHyuBBZBw6Z
         NXcET2Mb4jOc27e7s1+hro6DUbhAEkRiMhg/IymMeWmW49OWaQK9s+mPzCeGINKDV8ow
         IAG0Hz+yE4pm+fxY0r+bn9PXOxkRpkWmEIclz9WjKntlLrBohn9uie/unzwjn0Ayz7Cj
         Ztqg==
X-Gm-Message-State: ABy/qLbxswbM/hqByGD4INNmC9pl1sQI09vZYZRX994ad/LF8Q2KFru7
	TzflNuso5r8wUKJF4cgM4vya3wnpjBxNvMNHtaj8+A==
X-Google-Smtp-Source: APBJJlHA7N4ogAox7g539S9KJITGPahE5YRibE1yhXgbbPoa3IVnqYihGAY0bH4f2T5l/D8MJJOP0wxUSnF9XOLJgsI=
X-Received: by 2002:a17:90b:f88:b0:268:3f4f:7bdb with SMTP id
 ft8-20020a17090b0f8800b002683f4f7bdbmr17559438pjb.18.1691080686029; Thu, 03
 Aug 2023 09:38:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <169078860386.173706.3091034523220945605.stgit@devnote2>
 <169078863449.173706.2322042687021909241.stgit@devnote2> <CAADnVQ+C64_C1w1kqScZ6C5tr6_juaWFaQdAp9Mt3uzaQp2KOw@mail.gmail.com>
 <20230801085724.9bb07d2c82e5b6c6a6606848@kernel.org> <CAADnVQLaFpd2OhqP7W3xWB1b9P2GAKgrVQU1FU2yeNYKbCkT=Q@mail.gmail.com>
 <20230802000228.158f1bd605e497351611739e@kernel.org> <20230801112036.0d4ee60d@gandalf.local.home>
 <20230801113240.4e625020@gandalf.local.home> <CAADnVQ+N7b8_0UhndjwW9-5Vx2wUVvojujFLOCFr648DUv-Y2Q@mail.gmail.com>
 <20230801190920.7a1abfd5@gandalf.local.home> <CABRcYmJjtVq-330ktqTAUiNO1=yG_aHd0xz=c550O5C7QP++UA@mail.gmail.com>
 <20230804004206.9fdfae0b9270b9acca2c096f@kernel.org>
In-Reply-To: <20230804004206.9fdfae0b9270b9acca2c096f@kernel.org>
From: Florent Revest <revest@chromium.org>
Date: Thu, 3 Aug 2023 18:37:54 +0200
Message-ID: <CABRcYmJPD2VUPHs3DrxS8mxstvtdBR7Z8cG7joi0Qr9O3sP6vg@mail.gmail.com>
Subject: Re: [PATCH v4 3/9] bpf/btf: Add a function to search a member of a struct/union
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
	linux-trace-kernel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, bpf <bpf@vger.kernel.org>, 
	Sven Schnelle <svens@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Alan Maguire <alan.maguire@oracle.com>, Mark Rutland <mark.rutland@arm.com>, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Aug 3, 2023 at 5:42=E2=80=AFPM Masami Hiramatsu <mhiramat@kernel.or=
g> wrote:
>
> On Wed, 2 Aug 2023 16:44:09 +0200
> Florent Revest <revest@chromium.org> wrote:
>
> > On Wed, Aug 2, 2023 at 1:09=E2=80=AFAM Steven Rostedt <rostedt@goodmis.=
org> wrote:
> > >
> > > On Tue, 1 Aug 2023 15:18:56 -0700
> > > Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
> > >
> > > > On Tue, Aug 1, 2023 at 8:32=E2=80=AFAM Steven Rostedt <rostedt@good=
mis.org> wrote:
> > > > >
> > > > > On Tue, 1 Aug 2023 11:20:36 -0400
> > > > > Steven Rostedt <rostedt@goodmis.org> wrote:
> > > > >
> > > > > > The solution was to come up with ftrace_regs, which just means =
it has all
> > > > > > the registers to extract the arguments of a function and nothin=
g more. Most
> > > > >
> > > > > This isn't 100% true. The ftrace_regs may hold a fully filled pt_=
regs. As
> > > > > the FTRACE_WITH_REGS callbacks still get passed a ftrace_regs poi=
nter. They
> > > > > will do:
> > > > >
> > > > >         void callback(..., struct ftrace_regs *fregs) {
> > > > >                 struct pt_regs *regs =3D ftrace_get_regs(fregs);
> > > > >
> > > > >
> > > > > Where ftrace_get_regs() will return the pt_regs only if it is ful=
ly filled.
> > > > > If it is not, then it returns NULL. This was what the x86 maintai=
ners
> > > > > agreed with.
> > > >
> > > > arch/arm64/include/asm/ftrace.h:#define arch_ftrace_get_regs(regs) =
NULL
> > > >
> > > > Ouch. That's very bad.
> > > > We care a lot about bpf running well on arm64.
> > >
> > > [ Adding Mark and Florent ]
> >
> > Ah, thanks Steve! That's my favorite can of worms :) I actually
> > consider sending a talk proposal to the tracing MC at LPC "pt_regs -
> > the good the bad and the ugly" on this very topic because I care about
> > unblocking BPF "multi_kprobe" (which really is fprobe) on arm64, maybe
> > it would be interesting.
>
> Ah, it is almost same as my talk :)

Oh, I didn't know! I submitted a proposal today but if the talks have
a lot of overlap maybe it's best that only you give your talk, since
you're the actual maintainer :) or we could co-present if there's
something I could add but I think you have all the background anyway

> > I pointed this out in
> > https://lore.kernel.org/all/CABRcYm+esb8J2O1v6=3DC+h+HSa5NxraPUgo63w7-i=
Zj0CXbpusg@mail.gmail.com/#t
> > when Masami proposed adding calls from fprobe to perf. If every
> > subsystem makes different assumptions about "how sparse" their pt_regs
> > is and they call into one another, this could lead to... interesting
> > bugs. (eg: currently, we don't populate a fake pstate in ftrace_regs.
> > so we'd need to fake it when creating a sparse pt_regs _for Perf_,
> > knowing that Perf specifically expects this reg to be set. this would
> > require a struct copy anyway and some knowledge about how the data
> > will be consumed, in an arch- and subsystem- specific way)
>
> yeah, sorry I missed that point. I should remove it until we can fix it.

Uh, I shouldn't have buried my important comments so far down the
email :/ I wasn't sure whether you had missed the paragraph.

> > On the other hand, untangling all code paths that come from
> > trampolines (with a light regs structure) from those that come from an
> > exception (with a pt_regs) could lead to a lot of duplicated code, and
> > converting between each subsystem's idea of a light regs structure
> > (what if perf introduces a perf_regs now ?) would be tedious and slow
> > (lots of copies ?).
>
> This is one discussion point I think. Actually, using pt_regs in kretprob=
e
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

That sounds reasonable to me

> As I said, I would like to phase out the kretprobe itself because it
> provides the same feature of fprobe, which is confusing. jprobe was
> removed a while ago, and now kretprobe is. But we can not phase out
> it at once. So I think we will keep current kretprobe trampoline on
> arm64 and just add new ftrace_regs based rethook. Then remove the
> API next release. (after all users including systemtap is moved)

Heads up to BPF folks though since they also have BPF "kretprobe"
program types which would break in a similar fashion as multi_kprobe
(even though BPF kretprobe programs have also been discouraged for a
while in favor of BPF fexit programs)

> > > The reason I started the FTRACE_WITH_ARGS (which gave us ftrace_regs)=
 in
> > > the first place, was because of the overhead you reported to me with
> > > ftrace_regs_caller and why you wanted to go the direct trampoline app=
roach.
> > > That's when I realized I could use a subset because those registers w=
ere
> > > already being saved. The only reason FTRACE_WITH_REGS was created was=
 it
> > > had to supply full pt_regs (including flags) and emulate a breakpoint=
 for
> > > the kprobes interface. But in reality, nothing really needs all that.
> > >
> > > > It's not about access to args.
> > > > pt_regs is passed from bpf prog further into all kinds of perf even=
t
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

I agree with Alexei that this is an unnecessary amount of complexity
in the verifier just to avoid a struct copy though. It's good to know
that we _could_ do it if we really need to someday but then again, if
a user chooses an interface that gets a pt_regs they shouldn't expect
high performance. Therefore, I think it's ok for BPF multi_kprobe to
copy fields from a ftrace_regs to a pt_regs on stack, especially if it
avoids so much additional complexity in the verifier.

