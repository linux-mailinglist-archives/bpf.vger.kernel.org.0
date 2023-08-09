Return-Path: <bpf+bounces-7377-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED6657764E0
	for <lists+bpf@lfdr.de>; Wed,  9 Aug 2023 18:18:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4FEA1C212E9
	for <lists+bpf@lfdr.de>; Wed,  9 Aug 2023 16:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BACE51CA04;
	Wed,  9 Aug 2023 16:18:00 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4E918AE4
	for <bpf@vger.kernel.org>; Wed,  9 Aug 2023 16:18:00 +0000 (UTC)
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EED3E7
	for <bpf@vger.kernel.org>; Wed,  9 Aug 2023 09:17:59 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-55b0e7efb1cso30880a12.1
        for <bpf@vger.kernel.org>; Wed, 09 Aug 2023 09:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1691597879; x=1692202679;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cHLoN7tBYiBt4IC9BoSBMZPybpCDdS5lyEi5Q2VdGdE=;
        b=ZNVS/49rrsAyq36TYDMzxwqxd53cG5yh8OylLIDFnThnxrCUme34Nn+E3Y2gRhm8/2
         b/KI/HrW+tuUQ6d/+Ue7k1/YcH8E6Vf/D7O3DOsc2PHlpuGTKgAoxH7OOSd+E6XmG8i2
         2O2EYohAM9qNZJUaU2p8tRnu5eoQhRZet42j4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691597879; x=1692202679;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cHLoN7tBYiBt4IC9BoSBMZPybpCDdS5lyEi5Q2VdGdE=;
        b=VwX/c8CkDT2/0i//7+bsi5paW+aiixTw5RAl+36+sEZAOPaLhldRHee+sRI854ixiN
         qQh2AKcwylEqPofoIVO9qezlQ6ZgZh6OSq58C90iWKmWzDg2nNukgUJxtk8BWyxYdyVp
         YC6XZCSP7/fUzEAXe1+EKGVc7vkopi2Zxa+IZfEEaM7Mmrvfur87sFeX+oALTROQ5R7j
         yrIRAdax8JNybYzS7px88RkdZixJynMF7NxmeghmQjwov6pdJlQxWSHrezAHWk+6BDEv
         P+pGuAJTZ2iLk7bYk4YDo9QUMYyYxrjD9afP9SMYas8g4m9SmCTGlzkhySPrWUDaBsX2
         NHcQ==
X-Gm-Message-State: AOJu0YzQdid4qO1ckVzaz9yMthZ/pAvbSxL7YDCt7vnKcX98DD6a53ze
	I/6Dr2N5myi0JCr+jo2fsVSNIrL2Ijl3wuk9zmHPvw==
X-Google-Smtp-Source: AGHT+IFILk9qe3x2c3g5OACJh3zb2BvFno+fEkvYJ4z02ZUwtZ5eqs4WQPQxCBVrDK7PeZD8uAl3/YBDVn/TXhqgUl8=
X-Received: by 2002:a17:90b:3ec1:b0:268:ee6:6bdf with SMTP id
 rm1-20020a17090b3ec100b002680ee66bdfmr2446960pjb.47.1691597878863; Wed, 09
 Aug 2023 09:17:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <169139090386.324433.6412259486776991296.stgit@devnote2>
 <169139091575.324433.13168120610633669432.stgit@devnote2> <CABRcYmKRAbOuqNQm5mCwC9NWbtcz1JJDYL_h5x6dK77SJ5FRkA@mail.gmail.com>
 <20230809231011.b125bd68887a5659db59905e@kernel.org> <CABRcYmKEd=zmriE8VUnSTvybwA962r60+QaRJZK=KNqYixd_eg@mail.gmail.com>
In-Reply-To: <CABRcYmKEd=zmriE8VUnSTvybwA962r60+QaRJZK=KNqYixd_eg@mail.gmail.com>
From: Florent Revest <revest@chromium.org>
Date: Wed, 9 Aug 2023 18:17:47 +0200
Message-ID: <CABRcYmLHfQsjwf7dk+A0Q96iANhj60M0g_xRjVyMUY9LJPybNg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/6] fprobe: Use fprobe_regs in fprobe entry handler
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
	linux-trace-kernel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, bpf <bpf@vger.kernel.org>, 
	Sven Schnelle <svens@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Alan Maguire <alan.maguire@oracle.com>, Mark Rutland <mark.rutland@arm.com>, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Aug 9, 2023 at 6:09=E2=80=AFPM Florent Revest <revest@chromium.org>=
 wrote:
>
> On Wed, Aug 9, 2023 at 4:10=E2=80=AFPM Masami Hiramatsu <mhiramat@kernel.=
org> wrote:
> >
> > Hi Florent,
> >
> > On Wed, 9 Aug 2023 12:28:38 +0200
> > Florent Revest <revest@chromium.org> wrote:
> >
> > > On Mon, Aug 7, 2023 at 8:48=E2=80=AFAM Masami Hiramatsu (Google)
> > > <mhiramat@kernel.org> wrote:
> > > >
> > > > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > > >
> > > > This allows fprobes to be available with CONFIG_DYNAMIC_FTRACE_WITH=
_ARGS
> > > > instead of CONFIG_DYNAMIC_FTRACE_WITH_REGS, then we can enable fpro=
be
> > > > on arm64.
> > >
> > > This patch lets fprobe code build on configs WITH_ARGS and !WITH_REGS
> > > but fprobe wouldn't run on these builds because fprobe still register=
s
> > > to ftrace with FTRACE_OPS_FL_SAVE_REGS, which would fail on
> > > !WITH_REGS. Shouldn't we also let the fprobe_init callers decide
> > > whether they want REGS or not ?
> >
> > Ah, I think you meant FPROBE_EVENTS? Yes I forgot to add the dependency
> > on it. But fprobe itself can work because fprobe just pass the ftrace_r=
egs
> > to the handlers. (Note that exit callback may not work until next patch=
)
>
> No, I mean that fprobe still registers its ftrace ops with the
> FTRACE_OPS_FL_SAVE_REGS flag:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/mhiramat/linux.git/tree/k=
ernel/trace/fprobe.c?h=3Dtopic/fprobe-ftrace-regs&id=3D2ca022b2753ae0d2a251=
3c95f7ed5b5b727fb2c4#n185
>
> Which means that __register_ftrace_function will return -EINVAL on
> builds !WITH_REGS:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/mhiramat/linux.git/tree/k=
ernel/trace/ftrace.c?h=3Dtopic/fprobe-ftrace-regs&id=3D2ca022b2753ae0d2a251=
3c95f7ed5b5b727fb2c4#n338
>
> As documented here:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/mhiramat/linux.git/tree/i=
nclude/linux/ftrace.h?h=3Dtopic/fprobe-ftrace-regs&id=3D2ca022b2753ae0d2a25=
13c95f7ed5b5b727fb2c4#n188
>
> There are two parts to using sparse pt_regs. One is "static": having
> WITH_ARGS in the config, the second one is "dynamic": a ftrace ops
> needs to specify that it doesn't want to go through the ftrace
> trampoline that saves a full pt_regs, by not giving
> FTRACE_OPS_FL_SAVE_REGS. If we want fprobe to work on builds
> !WITH_REGS then we should both remove Kconfig dependencies to
> WITH_REGS (like you've done) but also stop passing this ftrace ops
> flag.

Said in a different way: there are arches that support both WITH_ARGS
and WITH_REGS (like x86 actually). They have two ftrace trampolines
compiled in: ftrace_caller and ftrace_regs_caller, one for each
usecase. If you register to ftrace with the FTRACE_OPS_FL_SAVE_REGS
flag you are telling it that what you want is a pt_regs. If you are
trying to move away from pt_regs and support ftrace_regs in the more
general case (meaning, in the case where it can contain a sparse
pt_regs) then you should stop passing that flag so you go through the
lighter, faster trampoline and test your code in the circumstances
where ftrace_regs isn't just a regular pt_regs but an actually sparse
or light data structure.

I hope that makes my thoughts clearer? It's a hairy topic ahah

