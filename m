Return-Path: <bpf+bounces-7371-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5E67776450
	for <lists+bpf@lfdr.de>; Wed,  9 Aug 2023 17:46:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FBA9281DC8
	for <lists+bpf@lfdr.de>; Wed,  9 Aug 2023 15:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B39F51BB32;
	Wed,  9 Aug 2023 15:45:41 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9103619BB4
	for <bpf@vger.kernel.org>; Wed,  9 Aug 2023 15:45:41 +0000 (UTC)
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A54EC268F
	for <bpf@vger.kernel.org>; Wed,  9 Aug 2023 08:45:40 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-26929bf95b6so2872226a91.3
        for <bpf@vger.kernel.org>; Wed, 09 Aug 2023 08:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1691595940; x=1692200740;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1lHU70UFZyVAuqrHVgw5FV5NyicmTtalyDZ2DL/xB2w=;
        b=g2Rd9S7zT+idb4+47/ERHXouRZBGGOCRT73xhqFGwMP6fyjn+TW12P8qJf7k/gkzsZ
         qC+W+EGEm+lTfjfiAxZHImGpnz5xkd8u3O+bVyrp7enLupSgiue0ZfeOWelvCA8L2j4c
         KuDJtiR16TYtdY5pM+6ZP5azoRI4F7RwNiM3E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691595940; x=1692200740;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1lHU70UFZyVAuqrHVgw5FV5NyicmTtalyDZ2DL/xB2w=;
        b=eelRzEq59xD6hTa6HDd5Ih9WKToJfPKTnj+ncdMQ1gvJ6zGYhhwlWAhH0GVhYAjBtV
         EaqiTIU1U0pHeIduslOCIae3C0hzz4kan145I+gN/cUxaDFWJOJ1wJuHyG2G5kOgPKK1
         3l2Da3aongIwb2m5Bp8NlpvrV1yMBUHbqOTeT6tHRaPJvGZ6UsWqQK9pCRWTQzNL+PCM
         1kzVZf6vRt+CaTXAOfxaL3FZRWpA7ja3D5iAdQOGQvB8uCVTeS3EqFfo9yiIAXtwxMcP
         UiJR/O19Hs3AbV2/u8chixQ4JhnUdz8hUYaI0+kOp619NqUNxkuBSX4S+gPP3l1GvhWU
         UGtQ==
X-Gm-Message-State: AOJu0YzvSqQTUNvRNA//HbDMSXlFNXbMOH2Q/pr3t/7ZPDn8leZRKMBk
	GV1unHPtcqW3Yts1WIhE/IVb8QJEPuKcJH5wXWXWfw==
X-Google-Smtp-Source: AGHT+IHBZ4kYatHyLUGoLTHddPeNNj7sZ1QQclLt+arjVPf9Gkn4NPvdYAJ+X39a6ovMtsxWY04+thZMWC7k84sDJso=
X-Received: by 2002:a17:90a:6c05:b0:268:c5c7:f7ed with SMTP id
 x5-20020a17090a6c0500b00268c5c7f7edmr2316230pjj.30.1691595940141; Wed, 09 Aug
 2023 08:45:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <169139090386.324433.6412259486776991296.stgit@devnote2>
 <169139093899.324433.3739544465888158332.stgit@devnote2> <CABRcYmK6X6okNKNu9ZjgLEO+JMGL42j7idE8QPZ_EpYA9S9UZQ@mail.gmail.com>
 <20230809234318.08784e46d0b7d88c1bccedbe@kernel.org>
In-Reply-To: <20230809234318.08784e46d0b7d88c1bccedbe@kernel.org>
From: Florent Revest <revest@chromium.org>
Date: Wed, 9 Aug 2023 17:45:29 +0200
Message-ID: <CABRcYmLe05UiK+-mCq5LA0d1Xomdpb+R_5A5HLBLbuBqfBCwUA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 3/6] fprobe: rethook: Use fprobe_regs in fprobe
 exit handler and rethook
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
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Aug 9, 2023 at 4:43=E2=80=AFPM Masami Hiramatsu <mhiramat@kernel.or=
g> wrote:
>
> > I think there are two things that can be meant with "rethook uses ftrac=
e_regs":
> >
> > - rethook callbacks receive a ftrace_regs (that's what you do further d=
own)
> > - rethook can hook to a traced function using a ftrace_regs (that's
> > what you use in fprobe now)
> >
> > But I think the second proposition shouldn't imply that rethook_hook
> > can _only_ hook to ftrace_regs. For the kprobe use case, I think there
> > should also be a rethook_hook_pt_regs() that operates on a pt_regs. We
> > could have a default implementation of rethook_hook that calls into
> > the other (or vice versa) on HAVE_FTRACE_REGS_COMPATIBLE_WITH_PT_REGS
> > but I think it's good to separate these two APIs
>
> Yeah, so for simplying the 2nd case, I added this dependency.
>
> diff --git a/arch/Kconfig b/arch/Kconfig
> index aff2746c8af2..e321bdb8b22b 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -201,6 +201,7 @@ config KRETPROBE_ON_RETHOOK
>         def_bool y
>         depends on HAVE_RETHOOK
>         depends on KRETPROBES
> +       depends on HAVE_PT_REGS_COMPAT_FTRACE_REGS || !HAVE_DYNAMIC_FTRAC=
E_WITH_ARGS
>         select RETHOOK
>
> This is the point why I said that "do not remove kretprobe trampoline".
> If there is arch dependent kretprobe trampoline, kretprobe does not use
> the rethook for hooking return. And eventually I would like to remove
> kretprobe itself (replace it with fprobe + rethook). If so, I don't want
> to pay more efforts on this part, and keep kretprobe on rethook as it is.

What are your thoughts on kprobe + rethook though ?

If that's something you think is worth having, then in this case, it
seems that having a rethook_hook_pt_regs() API would help users.

If that's a frankenstein use case you don't want to support then I
agree we can live without this API and get away with the cast
protected by the depends on HAVE_PT_REGS_COMPAT_FTRACE_REGS...

