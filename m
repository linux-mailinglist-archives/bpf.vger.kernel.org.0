Return-Path: <bpf+bounces-6721-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B244E76D060
	for <lists+bpf@lfdr.de>; Wed,  2 Aug 2023 16:44:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3FD81C209B6
	for <lists+bpf@lfdr.de>; Wed,  2 Aug 2023 14:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8AA979F9;
	Wed,  2 Aug 2023 14:44:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADBEE6FD0
	for <bpf@vger.kernel.org>; Wed,  2 Aug 2023 14:44:24 +0000 (UTC)
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D8251FCB
	for <bpf@vger.kernel.org>; Wed,  2 Aug 2023 07:44:21 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-2680ccc1d52so3977347a91.0
        for <bpf@vger.kernel.org>; Wed, 02 Aug 2023 07:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1690987461; x=1691592261;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wgRN+uBkX/aKGmKyVkjo++4WfFqQrMrW/AnF1HvfliM=;
        b=JxqVAnydE90YyqLWk847YXcnni6xWB+aybuuAqjR/e+yi5AoEaHGDVO3f2nXKsj7R+
         mz8NVZqdFFzKL2f9ungT2FtOQjZulRNjxSfm+PnzBeOnI2r/2vR6fVshtft/XPe/9Kz5
         Xw74TyAgr7bOWFLHZiAADLNIkDJ7iW5v5L+Fk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690987461; x=1691592261;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wgRN+uBkX/aKGmKyVkjo++4WfFqQrMrW/AnF1HvfliM=;
        b=HKLK702VXC8hh7leywqA4Ra8w230pMHht3buiQrbG4/cGrPjfUAvXmh6FjAEm77gT1
         DOtzYN6ICfni3uvO096Jz3D9xQRlU55trJxTx386fi1UQbm1PxGpui51bC9yZvj4wqQd
         kmfXuZVU/FNI64SMATM/2TAgX0WSKtOMwy7/PngbhPtqtFmplTO6ADxmh1SYgPambqIx
         cceZv1ksG2uwP2u/9k83142AnoogwwPncX65WCkAq6RsoLDzwBpYy1mMZ4+Xdl9J75Xg
         /Ng1+hP9UbnsXIwX7PAq8wiQg/BbfzkUBiUpgEW7Y1TcZ+Na1Al5UaVUBi1bvfkFx+0M
         /SXg==
X-Gm-Message-State: ABy/qLa3XVGIpLWvlWQsCCsT0oTRO9/Bui24/G+AOgo8inx8myV4UMDm
	RnDk5JDD+GPKf1Du3GI3rLUsAt47qThp0QKOHEdw4w==
X-Google-Smtp-Source: APBJJlGdjuPeMm3TnjIefT65swZJSb+qdAq9PEMyM5qNVTXDyNsx1CfmacvKzi9uM1iL5+XPRt9rq2+4DZQJyaEpUs0=
X-Received: by 2002:a17:90a:dc14:b0:263:3386:9da8 with SMTP id
 i20-20020a17090adc1400b0026333869da8mr11616075pjv.49.1690987460992; Wed, 02
 Aug 2023 07:44:20 -0700 (PDT)
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
 <20230801190920.7a1abfd5@gandalf.local.home>
In-Reply-To: <20230801190920.7a1abfd5@gandalf.local.home>
From: Florent Revest <revest@chromium.org>
Date: Wed, 2 Aug 2023 16:44:09 +0200
Message-ID: <CABRcYmJjtVq-330ktqTAUiNO1=yG_aHd0xz=c550O5C7QP++UA@mail.gmail.com>
Subject: Re: [PATCH v4 3/9] bpf/btf: Add a function to search a member of a struct/union
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, linux-trace-kernel@vger.kernel.org, 
	LKML <linux-kernel@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	bpf <bpf@vger.kernel.org>, Sven Schnelle <svens@linux.ibm.com>, 
	Alexei Starovoitov <ast@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Alan Maguire <alan.maguire@oracle.com>, Mark Rutland <mark.rutland@arm.com>, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Aug 2, 2023 at 1:09=E2=80=AFAM Steven Rostedt <rostedt@goodmis.org>=
 wrote:
>
> On Tue, 1 Aug 2023 15:18:56 -0700
> Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
>
> > On Tue, Aug 1, 2023 at 8:32=E2=80=AFAM Steven Rostedt <rostedt@goodmis.=
org> wrote:
> > >
> > > On Tue, 1 Aug 2023 11:20:36 -0400
> > > Steven Rostedt <rostedt@goodmis.org> wrote:
> > >
> > > > The solution was to come up with ftrace_regs, which just means it h=
as all
> > > > the registers to extract the arguments of a function and nothing mo=
re. Most
> > >
> > > This isn't 100% true. The ftrace_regs may hold a fully filled pt_regs=
. As
> > > the FTRACE_WITH_REGS callbacks still get passed a ftrace_regs pointer=
. They
> > > will do:
> > >
> > >         void callback(..., struct ftrace_regs *fregs) {
> > >                 struct pt_regs *regs =3D ftrace_get_regs(fregs);
> > >
> > >
> > > Where ftrace_get_regs() will return the pt_regs only if it is fully f=
illed.
> > > If it is not, then it returns NULL. This was what the x86 maintainers
> > > agreed with.
> >
> > arch/arm64/include/asm/ftrace.h:#define arch_ftrace_get_regs(regs) NULL
> >
> > Ouch. That's very bad.
> > We care a lot about bpf running well on arm64.
>
> [ Adding Mark and Florent ]

Ah, thanks Steve! That's my favorite can of worms :) I actually
consider sending a talk proposal to the tracing MC at LPC "pt_regs -
the good the bad and the ugly" on this very topic because I care about
unblocking BPF "multi_kprobe" (which really is fprobe) on arm64, maybe
it would be interesting.

> That's because arm64 doesn't support FTRACE_WITH_REGS anymore. Their
> function handlers only care about the arguments. If you want full regs at
> function entry, then you need to take a breakpoint hit for a full kprobe.

The main reason why arm64 dropped FTRACE_WITH_REGS is because some
registers (like pstate) can not be saved outside of an exception entry
(they are just wrong), so trampolines either have to make a pstate up
or not populate it.

The other reasons are: simplicity (for architectural reasons, it's a
lot easier to have only one type of ftrace trampoline on arm64, the
"with_args" one) and performance (as you said, why bother saving a
pt_regs when most ftrace users don't need it anyway). If you need an
actual full pt_regs, then your use case is debugging rather than
tracing and you should be able to deal with the slowness and go
through an exception (a kprobe).

> In fact, fprobes isn't even supported on arm64 because it it doesn't have
> DYNAMIC_FTRACE_WITH_REGS. I believe that was the reason Masami was trying
> to get it to work with ftrace_regs. To get it to work on arm64.
>
> Again, ftrace_get_regs(fregs) is only suppose to return something if the
> pt_regs is fully supplied. If they are not, then it must not be used. Are
> you not using a fully filled pt_regs? Because that's what both Thomas and
> Peter (also added) told me not to do!

Funnily enough, there's another use of sparse pt_regs in the kernel, in Per=
f:
https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/tree/arch/a=
rm64/include/asm/perf_event.h#n20
Notice how Perf on arm64 implicitly expects the "pstate" register to
be set (the very register which we try so hard not to fake in
ftrace_regs) because Perf happens to call the "user_mode()" macro
somewhere which reads this field:
https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/tree/arch/a=
rm64/include/asm/ptrace.h#n227

I pointed this out in
https://lore.kernel.org/all/CABRcYm+esb8J2O1v6=3DC+h+HSa5NxraPUgo63w7-iZj0C=
Xbpusg@mail.gmail.com/#t
when Masami proposed adding calls from fprobe to perf. If every
subsystem makes different assumptions about "how sparse" their pt_regs
is and they call into one another, this could lead to... interesting
bugs. (eg: currently, we don't populate a fake pstate in ftrace_regs.
so we'd need to fake it when creating a sparse pt_regs _for Perf_,
knowing that Perf specifically expects this reg to be set. this would
require a struct copy anyway and some knowledge about how the data
will be consumed, in an arch- and subsystem- specific way)

On the other hand, untangling all code paths that come from
trampolines (with a light regs structure) from those that come from an
exception (with a pt_regs) could lead to a lot of duplicated code, and
converting between each subsystem's idea of a light regs structure
(what if perf introduces a perf_regs now ?) would be tedious and slow
(lots of copies ?).

> Otherwise, ftrace_regs() has support on arm64 for getting to the argument
> registers and the stack. Even live kernel patching now uses ftrace_regs()=
.
>
> >
> > If you guys decide to convert fprobe to ftrace_regs please
> > make it depend on kconfig or something.
> > bpf side needs full pt_regs.

Some wild ideas that I brought up once in a BPF office hour: BPF
"multi_kprobe" could provide a fake pt_regs (either by constructing a
sparse one on the stack or by JIT-ing different offset accesses and/or
by having the verifier deny access to unpopulated fields) or break the
current API (is it conceivable to phase out BPF "multi_kprobe"
programs in favor of BPF "fprobe" programs that don't lie about their
API and guarantees and just provide a ftrace_regs ?)

> Then use kprobes. When I asked Masami what the difference between fprobes
> and kprobes was, he told me that it would be that it would no longer rely
> on the slower FTRACE_WITH_REGS. But currently, it still does.

Actually... Moving fprobe to ftrace_regs should get even more spicy!
:) Fprobe also wraps "rethook" which is basically the same thing as
kretprobe: a return trampoline that saves a pt_regs, to the point that
on x86 kretprobe's trampoline got dropped in favor of rethook's
trampoline. But for the same reasons that we don't want ftrace to save
pt_regs on arm64, rethook should probably also just save a ftrace_regs
? (also, to keep the fprobe callback signatures consistent between
pre- and post- handlers). But if we want fprobe "post" callbacks to
save a ftrace_regs now, either we need to re-introduce the kretprobe
trampoline or also change the API of kretprobe (and break its symmetry
with kprobe and we'd have the same problem all over again with BPF
kretprobe program types...). All of this is "beautifully" entangled...
:)

> The reason I started the FTRACE_WITH_ARGS (which gave us ftrace_regs) in
> the first place, was because of the overhead you reported to me with
> ftrace_regs_caller and why you wanted to go the direct trampoline approac=
h.
> That's when I realized I could use a subset because those registers were
> already being saved. The only reason FTRACE_WITH_REGS was created was it
> had to supply full pt_regs (including flags) and emulate a breakpoint for
> the kprobes interface. But in reality, nothing really needs all that.
>
> > It's not about access to args.
> > pt_regs is passed from bpf prog further into all kinds of perf event
> > functions including stack walking.

If all accesses are done in BPF bytecode, we could (theoretically)
have the verifier and JIT work together to deny accesses to
unpopulated fields, or relocate pt_regs accesses to ftrace_regs
accesses to keep backward compatibility with existing multi_kprobe BPF
programs.

Is there a risk that a "multi_kprobe" program could call into a BPF
helper or kfunc that reads this pt_regs pointer and expect certain
fields to be set ? I suppose we could also deny giving that "pt_regs"
pointer to a helper... :/

> ftrace_regs gives you the stack pointer. Basically, it gives you access t=
o
> anything that is required to be saved to do a function call from fentry.
>
> > I think ORC unwinder might depend on availability of all registers.
> > Other perf helpers might need it too. Like perf_event_output.
> > bpf progs need to access arguments, no doubt about that.
> > If ftrace_regs have them exactly in the same offsets as in pt_regs
> > that might work transparently for bpf progs, but, I'm afraid,
> > it's not the case on all archs.
> > So we need full pt_regs to make sure all paths are still working.
> >
> > Adding Jiri and others.
>
> Then I recommend that you give up using fprobes and just stick with kprob=
es
> as that's guaranteed to give you full pt_regs (at the overhead of doing
> things like filing in flags and such). And currently for arm64, fprobes c=
an
> only work with ftrace_regs, without the full pt_regs.

