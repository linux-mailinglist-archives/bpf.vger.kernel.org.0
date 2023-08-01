Return-Path: <bpf+bounces-6640-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7CC076C12F
	for <lists+bpf@lfdr.de>; Wed,  2 Aug 2023 01:44:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 108241C2111A
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 23:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52747134BE;
	Tue,  1 Aug 2023 23:44:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 248BA125C0
	for <bpf@vger.kernel.org>; Tue,  1 Aug 2023 23:44:39 +0000 (UTC)
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5652C1B1;
	Tue,  1 Aug 2023 16:44:38 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2b74fa5e7d7so94579011fa.2;
        Tue, 01 Aug 2023 16:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690933476; x=1691538276;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VwrhWFrL0STvLWQ/w2Am6pHectUZNMaxuCR7s7TmsPs=;
        b=BVZd6vuNbd5uEEFwbFF8xxtnbvzhTqsFMkwqnapndb/x4MMANmKzVC87oRfVxKSdZ7
         iWigSJ4l4baVJdsbp+zwwTmxyMxoWXzejvZ0v0r7C3TFCWb/zjz4O74nHi+RXSPs31Ch
         iriv142DyY8aLsvq8gPKFNQjLj1J75t3GvXyK+voPQVNeh6sD7WXfExRd4NkVBuH/peq
         FPUmJhah5QOHpaL2OZo6AQdnQc0BImoRhoE/j1eJIiRXqd5r1hYENB/jw1/0Q9dDVX+s
         yKrxgEl/hxcLvSQb4BVupC0DXr85if/LbuI4JFj0/6VJr2CLM/C/3f+/mi1i/ODyIQg5
         UA+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690933476; x=1691538276;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VwrhWFrL0STvLWQ/w2Am6pHectUZNMaxuCR7s7TmsPs=;
        b=OI2nHNF4FGK3qTVBkRfwqJWAmmuceG9EtrvsuRExKrRq48coX4R6RSsCKgYp08OKnx
         BpIWHJZ8UDlVnbN+aCayelYqQ691NGI51uUVIJmQKGyku8cnH8+BuDJdHXfPUip5TGHi
         cBfE5NXqqtBx6S+tPzcQkmGw92ejg2V/4SlhBc7exORBBPS0tpKoi+XxPF+XrhCQwzta
         TAKulkLfeN0yGjUys6VpIz39pp9gDugHL5MzTkYuRzu98tMLLTo1V+qe8dMJOG1gGwZV
         LfYUEEau7gZ3pnp+McqSwibnvWtgqVCWkO1I8i1upOMk9ZlG41ACojjOz06FJyGus43d
         1wBA==
X-Gm-Message-State: ABy/qLZXx+jF4+7JS4bX4nZir0T0qVNhffdvuA9abLX3SPP1WoN2qhe3
	YDIT4wAw//HEyzh/aVYSeCYAxXOsiHJEmB9SDbU=
X-Google-Smtp-Source: APBJJlGgjHvM7HlL8CTFgXK+BeAFXQBa/Y6rrShLDW4K5b1rEe1Iav5Nl5zoU693Yn5fZYIXEChETxsmaoPrpL56Q10=
X-Received: by 2002:a2e:2e0c:0:b0:2b9:2e85:2f9b with SMTP id
 u12-20020a2e2e0c000000b002b92e852f9bmr3788105lju.2.1690933475988; Tue, 01 Aug
 2023 16:44:35 -0700 (PDT)
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
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 1 Aug 2023 16:44:24 -0700
Message-ID: <CAADnVQ+WPw0pfGAk+z=hCVrSmCBkKuh8GJm-5bkq5Ow7Md3sGA@mail.gmail.com>
Subject: Re: [PATCH v4 3/9] bpf/btf: Add a function to search a member of a struct/union
To: Steven Rostedt <rostedt@goodmis.org>
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, linux-trace-kernel@vger.kernel.org, 
	LKML <linux-kernel@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	bpf <bpf@vger.kernel.org>, Sven Schnelle <svens@linux.ibm.com>, 
	Alexei Starovoitov <ast@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Alan Maguire <alan.maguire@oracle.com>, Mark Rutland <mark.rutland@arm.com>, 
	Florent Revest <revest@chromium.org>, Peter Zijlstra <peterz@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Aug 1, 2023 at 4:09=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org>=
 wrote>
> Then I recommend that you give up using fprobes and just stick with kprob=
es
> as that's guaranteed to give you full pt_regs (at the overhead of doing
> things like filing in flags and such). And currently for arm64, fprobes c=
an
> only work with ftrace_regs, without the full pt_regs.

bpf doesn't attach to fprobes directly. That was never requested.
But Jiri's work to support multi attach
https://lore.kernel.org/bpf/20220316122419.933957-1-jolsa@kernel.org/
was a joint effort with Masami that relied on fprobe multi attach api.
register_fprobe_ips() in particular, because the promise you guys
give us that callback will get pt_regs as
described in Documentation/trace/fprobe.rst.
From bpf side we don't care that such pt_regs is 100% filled in or
only partial as long as this pt_regs pointer is valid for perf_event_output
and stack walking that consume pt_regs.
I believe that was and still is the case for both x86 and arm64.

The way I understood Masami's intent is to change that promise and
fprobe callback will receive ftrace_regs that is incompatible with
pt_regs and that's obviously bad.
What you're suggesting "give up on using fprobe" is not up to us.
We're not using them. We care about register_fprobe_ips() and what
callback receives. Whatever internal changes to fprobe you're doing
are ok as long as the callback receives valid pt_regs (even partially fille=
d).

