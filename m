Return-Path: <bpf+bounces-8642-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D44F1788D00
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 18:12:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1180C1C20FE6
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 16:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CDFE1773C;
	Fri, 25 Aug 2023 16:12:15 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53BDE2571
	for <bpf@vger.kernel.org>; Fri, 25 Aug 2023 16:12:15 +0000 (UTC)
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDD401A6
	for <bpf@vger.kernel.org>; Fri, 25 Aug 2023 09:12:13 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-56a55c0f8b1so622651a12.0
        for <bpf@vger.kernel.org>; Fri, 25 Aug 2023 09:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692979933; x=1693584733;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iYfnmVl0jR/3Cs9h4eIxS2wjr6yR3DPQqFq/3LncF7k=;
        b=QFbnh1wmRTqXWOJeQYmwJaojukZCLyiBMiTKNopr+7CveeO2lQMV+EV+kG+Vx0v2y2
         V4eCK4kQD9wfQrs7NX/r+60aZo6ipw6kvmzDeJxz8zxjn3EAP6o3Iz4a1ez75/fFDykN
         1TrcH+aGIcyq3wcPcrT4hW1zphbyX6J3VINk8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692979933; x=1693584733;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iYfnmVl0jR/3Cs9h4eIxS2wjr6yR3DPQqFq/3LncF7k=;
        b=bSZ/5UBrnmnMepX+AiYki6jJtymE1Mt8DIERuONk4Q/hyOUUN/iA+RbH4s0qZJsPYz
         b1TkopiruTM9pd739dRuUM4J9/qOMonInJh2J1kk3tLU6BfX/c/RXEP2sBnEnjXXN4aQ
         X62M65Rnscwex57VXCaT/kR7pXWWoMMGeIIeJFFQqprqdrtkVitND1bKUaZQwlktCaEN
         djD3nqXM7xOrxdESkmDYBt/Kx7tgzmdu2fUoBUN6Cfm8/Mbc5aw1m0/VVls8yEjafal6
         rh7Cqrpqz0SDE0ixuadCsWfQpeYvu+J1vYp/FlRFCHUoj0+q8uVY+lz2XDCW4VFD7RyY
         Aqkg==
X-Gm-Message-State: AOJu0YxVkP6jAS3v+lWNZ8q0JQCj6yHFBahBXiHt4gXLtaYFJnoHz2YB
	J/CLCoZMi5FL58nzbe7EdxGQEOdS8JhzqnXaAo0adg==
X-Google-Smtp-Source: AGHT+IHa1afA+N+wXb1aYhgjkfrZlAddyzbUP7Mom1/uH0U2fOpHMMEZ4yGnZpurZozI9wPJAHv1bVnaNdlENLUL16s=
X-Received: by 2002:a17:90b:1986:b0:269:851:4f00 with SMTP id
 mv6-20020a17090b198600b0026908514f00mr14045766pjb.35.1692979933334; Fri, 25
 Aug 2023 09:12:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <169280372795.282662.9784422934484459769.stgit@devnote2> <169280377434.282662.7610009313268953247.stgit@devnote2>
In-Reply-To: <169280377434.282662.7610009313268953247.stgit@devnote2>
From: Florent Revest <revest@chromium.org>
Date: Fri, 25 Aug 2023 18:12:01 +0200
Message-ID: <CABRcYmLCDTMCQMViP56eT13YEW247acDqQUmXY=pf4qTS_4aUw@mail.gmail.com>
Subject: Re: [PATCH v4 4/9] fprobe: rethook: Use ftrace_regs in fprobe exit
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
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Aug 23, 2023 at 5:16=E2=80=AFPM Masami Hiramatsu (Google)
<mhiramat@kernel.org> wrote:
>
> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>
> Change the fprobe exit handler and rethook to use ftrace_regs data struct=
ure
> instead of pt_regs. This also introduce HAVE_PT_REGS_TO_FTRACE_REGS_CAST
> which means the ftrace_regs's memory layout is equal to the pt_regs so
> that those are able to cast. Only if it is enabled, kretprobe will use
> rethook since kretprobe requires pt_regs for backward compatibility.
>
> This means the archs which currently implement rethook for kretprobes nee=
ds to
> set that flag and it must ensure struct ftrace_regs is same as pt_regs.
> If not, it must be either disabling kretprobe or implementing kretprobe
> trampoline separately from rethook trampoline.
>
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Acked-by: Florent Revest <revest@chromium.org>

