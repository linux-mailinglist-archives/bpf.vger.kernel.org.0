Return-Path: <bpf+bounces-6635-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79EB276C04C
	for <lists+bpf@lfdr.de>; Wed,  2 Aug 2023 00:19:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06199281AC3
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 22:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA339275D2;
	Tue,  1 Aug 2023 22:19:11 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C811B263C4
	for <bpf@vger.kernel.org>; Tue,  1 Aug 2023 22:19:11 +0000 (UTC)
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BD2719BE;
	Tue,  1 Aug 2023 15:19:10 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2b9c66e2e36so3570841fa.1;
        Tue, 01 Aug 2023 15:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690928348; x=1691533148;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JTAMEGR1dMpo1RcXFwVXc0ZdDqdu7mLFbtcnsS1mOvo=;
        b=BQ5mn6aE4p8kMPhYMcGlf6MKuupZ/deXnrjxgXW6aZ8uPO2X/qqFxv66c0YDdKbR7D
         trhgVhnWLEpXSLu25uPPyCn0oBJZ7vXG0/Bo/9cAbRQPArVK/Ykwhcix5SjNA5gaPOtn
         VUm6EWBnlUoZSc/z9aZwoeoVdQqRKhFsAOo+8mOR8GvzdOHdWA1yY/rg01AU7juBJVfv
         pyvgxeIbLRjo3yUfD//X5W3B98p5h8TyFwiAbjGzfr7dtA0KIdFTbDQBclX3RipYOjcB
         h8Y1jzm/I9DLD+DifdO9pkjb+fJw1c59mrj9gcfi7o09LfQO5NDHdVx+KNyWKqyGR8O9
         ulgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690928348; x=1691533148;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JTAMEGR1dMpo1RcXFwVXc0ZdDqdu7mLFbtcnsS1mOvo=;
        b=SoyiaUnp7cmYw+axJu9dgSV72AXejrPaXWnZkhYMFros15P+dasQRLHJ4XCRusoaR7
         anMcddK/5Nx+YgebDRv3plMfdl7hiiFvuAIQQA4rHC4jwWY/c1GmHb8mgcJq3DgdNA4g
         Tz6trNGekRSlT+grY4vhdAYKKfev6caTQyN3pV4jaUT9gf2BKRIraRMWKZxcfNpQY7xr
         J23q4r/no3fDXyNbTqFhlh5cxsbd+tpF40OLmjVngCa5yWs3ap9dBv17lo/jEzLvbwid
         6R0JGb4cJ0kSi9sFxM25k5mFjWXi3KPxACt3VWwF6o9WUI8EiR00w2i1mesYnlJgVYTd
         UbKA==
X-Gm-Message-State: ABy/qLYLTchMoMSsfscB+72a8M3yPoMO1pwFUN5sTsSadR3WfHNXb0VR
	uhibbUFzsvcMMeeky/yPkeTN1Kr+K+YFXryrS6wT0Bf9VfI=
X-Google-Smtp-Source: APBJJlHxUytOlKOoYniNbutlh4326I9M+ivY7drMz4gfXwFzhRZ6LEBJX3gxOWV01gVioABmW0v8DMtNJ4m9lTE7tkY=
X-Received: by 2002:a05:651c:3d9:b0:2b9:d965:fbf2 with SMTP id
 f25-20020a05651c03d900b002b9d965fbf2mr1344478ljp.22.1690928348104; Tue, 01
 Aug 2023 15:19:08 -0700 (PDT)
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
 <20230801113240.4e625020@gandalf.local.home>
In-Reply-To: <20230801113240.4e625020@gandalf.local.home>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 1 Aug 2023 15:18:56 -0700
Message-ID: <CAADnVQ+N7b8_0UhndjwW9-5Vx2wUVvojujFLOCFr648DUv-Y2Q@mail.gmail.com>
Subject: Re: [PATCH v4 3/9] bpf/btf: Add a function to search a member of a struct/union
To: Steven Rostedt <rostedt@goodmis.org>
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, linux-trace-kernel@vger.kernel.org, 
	LKML <linux-kernel@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	bpf <bpf@vger.kernel.org>, Sven Schnelle <svens@linux.ibm.com>, 
	Alexei Starovoitov <ast@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Alan Maguire <alan.maguire@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Aug 1, 2023 at 8:32=E2=80=AFAM Steven Rostedt <rostedt@goodmis.org>=
 wrote:
>
> On Tue, 1 Aug 2023 11:20:36 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
>
> > The solution was to come up with ftrace_regs, which just means it has a=
ll
> > the registers to extract the arguments of a function and nothing more. =
Most
>
> This isn't 100% true. The ftrace_regs may hold a fully filled pt_regs. As
> the FTRACE_WITH_REGS callbacks still get passed a ftrace_regs pointer. Th=
ey
> will do:
>
>         void callback(..., struct ftrace_regs *fregs) {
>                 struct pt_regs *regs =3D ftrace_get_regs(fregs);
>
>
> Where ftrace_get_regs() will return the pt_regs only if it is fully fille=
d.
> If it is not, then it returns NULL. This was what the x86 maintainers
> agreed with.

arch/arm64/include/asm/ftrace.h:#define arch_ftrace_get_regs(regs) NULL

Ouch. That's very bad.
We care a lot about bpf running well on arm64.

If you guys decide to convert fprobe to ftrace_regs please
make it depend on kconfig or something.
bpf side needs full pt_regs.
It's not about access to args.
pt_regs is passed from bpf prog further into all kinds of perf event
functions including stack walking.
I think ORC unwinder might depend on availability of all registers.
Other perf helpers might need it too. Like perf_event_output.
bpf progs need to access arguments, no doubt about that.
If ftrace_regs have them exactly in the same offsets as in pt_regs
that might work transparently for bpf progs, but, I'm afraid,
it's not the case on all archs.
So we need full pt_regs to make sure all paths are still working.

Adding Jiri and others.

