Return-Path: <bpf+bounces-7370-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B207776412
	for <lists+bpf@lfdr.de>; Wed,  9 Aug 2023 17:38:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCC061C212F2
	for <lists+bpf@lfdr.de>; Wed,  9 Aug 2023 15:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 776F41BB22;
	Wed,  9 Aug 2023 15:38:32 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5297818AE1
	for <bpf@vger.kernel.org>; Wed,  9 Aug 2023 15:38:32 +0000 (UTC)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF9172D70
	for <bpf@vger.kernel.org>; Wed,  9 Aug 2023 08:38:12 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id 5614622812f47-3a7781225b4so4344545b6e.3
        for <bpf@vger.kernel.org>; Wed, 09 Aug 2023 08:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1691595491; x=1692200291;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Or+4Q7ioH1LO85WlhMl+Hf8sfqeAwfesSr6HY/tLZlg=;
        b=dZcu+9OCCvDLKeSC8+efZ2t+vflJAufUebNBSxKiPMXcivRTCQnANXkWc+eUMIOfP5
         niV3udOO9xEsykqD1etTNR21tWhoh0SdlANcSTLtFgIor0e+TCSi4toemI4fNBG24Tcs
         mm9be/Lb7kIaAwrSUVBkeEXK+XV7nwreJY1i0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691595491; x=1692200291;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Or+4Q7ioH1LO85WlhMl+Hf8sfqeAwfesSr6HY/tLZlg=;
        b=hQwwpxDIeumxfNA1o1d4p38ywloLXh/QZ2/z0/hf/vzNL65Q5rz7yNArliGnHxj1yb
         L6Cg7hYSJrNNDLLjvgtd8bg0Ps9aYV5sA6lqAkabkmPoBnWrU/8s9INW2zCRQkYHS5oX
         fBaT9iwQmNpoKLHPbOQlwDfnv5zwx0qTfsq4olPMtKGFUAeMmhRkJKYDOkftI9PTx6hI
         spOtZsyuAS/03fimFOfZ6jfN7QzvLbZN7uXI9sMG9D7gIlrEnPq2tq2NzRtiwb4BMK+M
         KDciFuC1sSHZVLDW5irBFQRNBPHjLZUEVW033hf2wV0X8ntCKFdIu4OewAllZukZ0NEK
         LMdA==
X-Gm-Message-State: AOJu0Yzroso3CLv8F8OHpImntjBuE69r07Qq0QZ9oCyGWK9xb+3ryigN
	mQq30QPrdEa6PJ+eXRbAYWi3ncsv21ZgN0ORLCyNQkY6SX1FHPP8
X-Google-Smtp-Source: AGHT+IH+aYrEIoM4XMzeEh0db0LKZFpFauBuv8UFazpm8vaS77/zQP9gsRXuMtjL++12niCEpG3Eo4HXLokCZLkpirY=
X-Received: by 2002:a05:6808:23c7:b0:3a7:8e1b:9d65 with SMTP id
 bq7-20020a05680823c700b003a78e1b9d65mr3596640oib.47.1691595491693; Wed, 09
 Aug 2023 08:38:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <169139090386.324433.6412259486776991296.stgit@devnote2>
 <169139095066.324433.15514499924371317690.stgit@devnote2> <CABRcYm+8-zYRGjKSPtWQ8_Vq2649=vi71fGvFx2aWM1tnOMYQQ@mail.gmail.com>
 <20230809234512.e3c39b8fffcc6297262f8fc8@kernel.org>
In-Reply-To: <20230809234512.e3c39b8fffcc6297262f8fc8@kernel.org>
From: Florent Revest <revest@chromium.org>
Date: Wed, 9 Aug 2023 17:38:00 +0200
Message-ID: <CABRcYm+24OLedwiLGj1RyvVg22R5NduORVsYZfXSA_OX5F+riA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 4/6] tracing/fprobe: Enable fprobe events with CONFIG_DYNAMIC_FTRACE_WITH_ARGS
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
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Aug 9, 2023 at 4:45=E2=80=AFPM Masami Hiramatsu <mhiramat@kernel.or=
g> wrote:
> > > --- a/kernel/trace/trace_fprobe.c
> > > +++ b/kernel/trace/trace_fprobe.c
> > > @@ -132,25 +132,30 @@ static int
> > >  process_fetch_insn(struct fetch_insn *code, void *rec, void *dest,
> > >                    void *base)
> > >  {
> > > -       struct pt_regs *regs =3D rec;
> > > -       unsigned long val;
> > > +       struct ftrace_regs *fregs =3D rec;
> > > +       unsigned long val, *stackp;
> > >         int ret;
> > >
> > >  retry:
> > >         /* 1st stage: get value from context */
> > >         switch (code->op) {
> > >         case FETCH_OP_STACK:
> > > -               val =3D regs_get_kernel_stack_nth(regs, code->param);
> > > +               stackp =3D (unsigned long *)ftrace_regs_get_stack_poi=
nter(fregs);
> > > +               if (((unsigned long)(stackp + code->param) & ~(THREAD=
_SIZE - 1)) =3D=3D
> > > +                   ((unsigned long)stackp & ~(THREAD_SIZE - 1)))
> >
> > Maybe it'd be worth extracting a local
> > "ftrace_regs_get_kernel_stack_nth_addr" helper function and/or
> > "ftrace_regs_within_kernel_stack" ?
>
> Yeah, maybe we can make it a generic inline function in linux/ftrace.h.

Or even just above this function if there are low chances it would get
used elsewhere :)

