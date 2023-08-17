Return-Path: <bpf+bounces-7970-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5B5477F28C
	for <lists+bpf@lfdr.de>; Thu, 17 Aug 2023 10:57:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 717DB281E3C
	for <lists+bpf@lfdr.de>; Thu, 17 Aug 2023 08:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1BD7100B2;
	Thu, 17 Aug 2023 08:57:38 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6D2FC0D
	for <bpf@vger.kernel.org>; Thu, 17 Aug 2023 08:57:38 +0000 (UTC)
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 969042D40
	for <bpf@vger.kernel.org>; Thu, 17 Aug 2023 01:57:37 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-565ea1088fbso1771931a12.2
        for <bpf@vger.kernel.org>; Thu, 17 Aug 2023 01:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692262657; x=1692867457;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3047fudLxdi1mO3onS+rLwsUyqFYfYLDKfiuZG4YUJM=;
        b=HJi/DlthHTk4VrLUlzPyhRI7bxeadkjObc5oNJKYFy9eYWno7RTr7MkHbC7AqqRrQy
         WIf23ddt+p8PwFW92IqOejdVm01tJw2gdu54JH9Q2z1EuuuNF7KoqL9bYtfHq+DR/Lg4
         NV6asjA8HFr/zxWH2ZacRMwaJ9YlT5KSrj8mw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692262657; x=1692867457;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3047fudLxdi1mO3onS+rLwsUyqFYfYLDKfiuZG4YUJM=;
        b=aSg+zX0FhB8eyGvKP0wXtmtTAvPoJ2n/N1vm+0N9wFE9vD1FCWcyXumw79XgCSRTUn
         UgI85sc6Lt/Xa9AAt4cfjTmNMBlTNvfxY98I2idKbwVYpaJ0l3DgaxnlYVSwHbfAflnT
         6Uj2uRCZC8Mf5CpY6QNT7J1wM2FmZziILsodaZYc3d8Q4GCojHsa5hxZSz7xF21NlOMe
         Vm4pDnJLbgKFcze+vs2FwiFjD0vmvvxTjXpUjgbafAb7Hg7TpvErqrhWPB+sRewLniIU
         FvOVVzM16YLOubAQ/tBSStFfSlCbkE2nkG7CtWwLPMEdBJILjRMXPjb3aXi/FL5Ztp6F
         31+w==
X-Gm-Message-State: AOJu0Ywx9RZKDea3gM3VIGF4b+N1W/c7zoxadkPx9kfnsrG+JjRbHpjl
	BzrGbRFsCj101YFeoqR955BrJi4OR+VOATsL4euDEQ==
X-Google-Smtp-Source: AGHT+IHvsMZnwwNnaI1QyczKPAq0kpcZmxmcPZ8yv+5Kpilk9edjm2psrQLXI4TMLyfn8Fm/yzzYV0A8bXR9NKZIihk=
X-Received: by 2002:a17:90a:c086:b0:269:1e3f:a54d with SMTP id
 o6-20020a17090ac08600b002691e3fa54dmr3685525pjs.10.1692262657084; Thu, 17 Aug
 2023 01:57:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <169181859570.505132.10136520092011157898.stgit@devnote2> <169181861911.505132.8322840504168319403.stgit@devnote2>
In-Reply-To: <169181861911.505132.8322840504168319403.stgit@devnote2>
From: Florent Revest <revest@chromium.org>
Date: Thu, 17 Aug 2023 10:57:26 +0200
Message-ID: <CABRcYmLhVxRwMYWjTE855WMg5fV+O1tLz8HJmy_6G6LK5ZEtVA@mail.gmail.com>
Subject: Re: [PATCH v3 2/8] fprobe: Use fprobe_regs in fprobe entry handler
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
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -2467,7 +2467,7 @@ static int __init bpf_event_init(void)
>  fs_initcall(bpf_event_init);
>  #endif /* CONFIG_MODULES */
>
> -#ifdef CONFIG_FPROBE
> +#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS

Shouldn't this be #if defined(CONFIG_FPROBE) &&
defined(CONFIG_DYNAMIC_FTRACE_WITH_REGS) ?

I believe one could build a kernel with FTRACE_WITH_REGS and without
FPROBE and then this code would have undefined references to fprobe
functions, wouldn't it ?

And then patch 7 should be "Enable kprobe_multi feature even if
FTRACE_WITH_REGS is disabled"

