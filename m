Return-Path: <bpf+bounces-6722-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 634AE76D08B
	for <lists+bpf@lfdr.de>; Wed,  2 Aug 2023 16:49:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F21A5281E0D
	for <lists+bpf@lfdr.de>; Wed,  2 Aug 2023 14:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06C79747E;
	Wed,  2 Aug 2023 14:49:08 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31765230
	for <bpf@vger.kernel.org>; Wed,  2 Aug 2023 14:49:07 +0000 (UTC)
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B209A2D4C
	for <bpf@vger.kernel.org>; Wed,  2 Aug 2023 07:49:05 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-2680ccc1d52so3980299a91.0
        for <bpf@vger.kernel.org>; Wed, 02 Aug 2023 07:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1690987745; x=1691592545;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1rRKUOEKn1QH1pife42dl+oAyUZxrskG/HFrJzSInDA=;
        b=DpYN5MG0pzSiAPLsEzoV8eOmMSH1CDuQ7vDHg5gc6jCKcVT0S7RrTmS8bmzOo/Or5c
         HEsw+RoC6s78YHnus1bYyA8SSwEuq57QW5wFSaLNzgEEy/1B+byNTXYP3uiyDEP3UoyG
         pBzpm1YwDzfWWjOcNKiHqpDzbdmL2Hl4q0wMA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690987745; x=1691592545;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1rRKUOEKn1QH1pife42dl+oAyUZxrskG/HFrJzSInDA=;
        b=DGujZcmZh3yi1Lzjp7mcs6GczIq0cg7DAuFEZfX5KFpn/fZDepcMKNENtTi73hABON
         wDGahsq8KfFLJUjDcjtWzNEB+Me+IFxg0mjpXvv76V570EE4zJlESC1IYX3M0k9DcHY2
         1Ljb08Yxg7rhcA2LjQp9cKwBLNpEUAtvsH0Dr1x/DLZu+o0vqQtkK/dApfLluWO92fWo
         OSY4yt6RIVZ8ZiKKnPPcYg66shMb+Bm84/kIkUIc8zRHKQVu4lVOzoXkf26fEXWyDQD7
         JgTbbRArviDk5Q/vCEIB8lL4p/Uo2aW/j19eV7wgZq+amIecytM2SzloOatx0R+Y4L/Q
         e1SQ==
X-Gm-Message-State: ABy/qLa9dbitPlRHI9exU/p7xZhRYrFQPuQFBNiJCYIA5AWaVahoglOY
	hbwPt43Q8ngYWsR1oPNWtf/INQNi9yvJjCdFvYWtkg==
X-Google-Smtp-Source: APBJJlHF04dNCJtjHcj6eeAys3uZls91rhQLt0HULf+PZKIecfP1ICaH1OKZG7EDqEOkjEduKPKqOMNRvGF6NKzCaA0=
X-Received: by 2002:a17:90a:5ae3:b0:262:e742:f419 with SMTP id
 n90-20020a17090a5ae300b00262e742f419mr14639445pji.47.1690987745147; Wed, 02
 Aug 2023 07:49:05 -0700 (PDT)
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
 <20230801190920.7a1abfd5@gandalf.local.home> <20230802092146.9bda5e49528e6988ab97899c@kernel.org>
 <20230801204054.3884688e@rorschach.local.home> <20230802225634.f520080cd9de759d687a2b0a@kernel.org>
In-Reply-To: <20230802225634.f520080cd9de759d687a2b0a@kernel.org>
From: Florent Revest <revest@chromium.org>
Date: Wed, 2 Aug 2023 16:48:53 +0200
Message-ID: <CABRcYmJS_nbXbsiurd_KMCmUdTroB=ERcRyVyUvqnpw3ndE=Qw@mail.gmail.com>
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
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Aug 2, 2023 at 3:56=E2=80=AFPM Masami Hiramatsu <mhiramat@kernel.or=
g> wrote:
>
> On Tue, 1 Aug 2023 20:40:54 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
>
> > On Wed, 2 Aug 2023 09:21:46 +0900
> > Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> >
> > > > Then use kprobes. When I asked Masami what the difference between f=
probes
> > > > and kprobes was, he told me that it would be that it would no longe=
r rely
> > > > on the slower FTRACE_WITH_REGS. But currently, it still does.
> > >
> > > kprobes needs to keep using pt_regs because software-breakpoint excep=
tion
> > > handler gets that. And fprobe is used for bpf multi-kprobe interface,
> > > but I think it can be optional.
> > >
> > > So until user-land tool supports the ftrace_regs, you can just disabl=
e
> > > using fprobes if CONFIG_DYNAMIC_FTRACE_WITH_REGS=3Dn
> >
> > I'm confused. I asked about the difference between kprobes on ftrace
> > and fprobes, and you said it was to get rid of the requirement of
> > FTRACE_WITH_REGS.
> >
> >  https://lore.kernel.org/all/20230120205535.98998636329ca4d5f8325bc3@ke=
rnel.org/
>
> Yes, it is for enabling fprobe (and fprobe-event) on more architectures.
> I don't think it's possible to change everything at once. So, it will be
> changed step by step. At the first step, I will replace pt_regs with
> ftrace_regs, and make bpf_trace.c and fprobe_event depends on
> FTRACE_WITH_REGS.

Just a small note that, strictly speaking,
CONFIG_DYNAMIC_FTRACE_WITH_REGS=3Dy is not enough. fprobe_init() would
also need a way to set FTRACE_OPS_FL_SAVE_REGS conditionally. (you
could be on an arch that supports saving either regs or args and if
you don't set FTRACE_OPS_FL_SAVE_REGS you'd go through the args
trampoline and get a ftrace_regs that doesn't hold a pt_regs)

