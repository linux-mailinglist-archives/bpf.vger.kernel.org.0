Return-Path: <bpf+bounces-7972-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF10D77F28E
	for <lists+bpf@lfdr.de>; Thu, 17 Aug 2023 10:58:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7492F281C37
	for <lists+bpf@lfdr.de>; Thu, 17 Aug 2023 08:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C66D100BD;
	Thu, 17 Aug 2023 08:57:53 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C533FC0D
	for <bpf@vger.kernel.org>; Thu, 17 Aug 2023 08:57:53 +0000 (UTC)
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AB832724
	for <bpf@vger.kernel.org>; Thu, 17 Aug 2023 01:57:52 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-26b0b4a7ccbso4248846a91.2
        for <bpf@vger.kernel.org>; Thu, 17 Aug 2023 01:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692262672; x=1692867472;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sd4pXZRJFepy7HbsMJqodX8ExP3gHP5syyoC+b4r7r8=;
        b=EF395AAkyWIxDY8M9y7l3rJFiqK21IwFJmg7Gip1v96Zyqbw7JqaV9W+YJ7BzMn1/m
         hAgNUlzwu/uz0+/2X8LwSeb2UweioCieQg84unNtz+3Vr0OJf/IuTZRmMvlpHc45wJRQ
         YcxAemoQfb64LOZQ3p0bD69uZlhUQhL7lb46g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692262672; x=1692867472;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sd4pXZRJFepy7HbsMJqodX8ExP3gHP5syyoC+b4r7r8=;
        b=ZDULv0ZlEW6UuHf5sQGjRYUJ6isMEUOZQJzvyNtfSj2Ni95ORq33XcfspKoeTkmttt
         7H1xIi9u7c+8wv6EwCGh5BuHMIgeUbWIBBTm1noZrNr4+G65qR8Cjavre8cUOEMlxgUd
         zbN3FPuiyGTgqmNvI97GK+kk5mxjAu6Nib8MQ82/kd5FhbMvJnwhZCxTR8SKQnxhsFda
         KK/KFQ2JFuW6X8swqDdcAqDpvFNNk6C+dPqIcAIU8LbLO0deUkYhkbewhbV6x757ELyb
         yYEep4r9LUTQK8Gs4MdTcFP+fY85x/EXbybeCQrvbWgAymNz9tbBXJ8UkaOCrm5bLEJf
         i04w==
X-Gm-Message-State: AOJu0YzSTrPpnMzm8WMu45mLMmvNqEZu78kzbvdBZ4SVfvZsGCkRw+Fg
	POuoCbd+ufYEKnlahONqjUMFE2NJLaein4KcQ6E4hg==
X-Google-Smtp-Source: AGHT+IHCS6EaPpJKh3OX0fWBxFrZ2fH45kKnSc5tSKg0I+jNCBcSeZpbCvNQyUQX09GibYeF9xVGhxwvDo2mdyH4AKo=
X-Received: by 2002:a17:90a:d145:b0:26c:f6db:ad77 with SMTP id
 t5-20020a17090ad14500b0026cf6dbad77mr3281951pjw.2.1692262671688; Thu, 17 Aug
 2023 01:57:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <169181859570.505132.10136520092011157898.stgit@devnote2> <169181864347.505132.7098838654251139622.stgit@devnote2>
In-Reply-To: <169181864347.505132.7098838654251139622.stgit@devnote2>
From: Florent Revest <revest@chromium.org>
Date: Thu, 17 Aug 2023 10:57:40 +0200
Message-ID: <CABRcYmK2-jiDOrTqjgg41t0T2-Uf1jbsuiV0xT37M=5cVCB+Zw@mail.gmail.com>
Subject: Re: [PATCH v3 4/8] fprobe: rethook: Use ftrace_regs in fprobe exit
 handler and rethook
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
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
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Aug 12, 2023 at 7:37=E2=80=AFAM Masami Hiramatsu (Google)
<mhiramat@kernel.org> wrote:
>
> diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
> index 976fd594b446..d56304276318 100644
> --- a/kernel/trace/Kconfig
> +++ b/kernel/trace/Kconfig
> @@ -57,6 +57,13 @@ config HAVE_DYNAMIC_FTRACE_WITH_ARGS
>          This allows for use of ftrace_regs_get_argument() and
>          ftrace_regs_get_stack_pointer().
>
> +config HAVE_PT_REGS_TO_FTRACE_REGS_CAST
> +       bool
> +       help
> +        If this is set, the memory layout of the ftrace_regs data struct=
ure
> +        is the same as the pt_regs. So the pt_regs is possible to be cas=
ted
> +        to ftrace_regs.

What would you think of introducing a:

#ifdef HAVE_PT_REGS_TO_FTRACE_REGS_CAST
static_assert(sizeof(struct pt_regs) =3D=3D sizeof(struct ftrace_regs);
#endif // HAVE_PT_REGS_TO_FTRACE_REGS_CAST

somewhere in ftrace.h just as a small extra safety net ? It doesn't
exactly guarantee all we want but it should give an early warning of
mistakes.

