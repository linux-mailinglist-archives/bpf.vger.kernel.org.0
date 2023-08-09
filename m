Return-Path: <bpf+bounces-7326-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2089775716
	for <lists+bpf@lfdr.de>; Wed,  9 Aug 2023 12:29:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A10E281B4C
	for <lists+bpf@lfdr.de>; Wed,  9 Aug 2023 10:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ED4F171C3;
	Wed,  9 Aug 2023 10:29:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0ECF613F
	for <bpf@vger.kernel.org>; Wed,  9 Aug 2023 10:29:25 +0000 (UTC)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 205081982
	for <bpf@vger.kernel.org>; Wed,  9 Aug 2023 03:29:25 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id 5614622812f47-3a6f3ef3155so5182618b6e.1
        for <bpf@vger.kernel.org>; Wed, 09 Aug 2023 03:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1691576964; x=1692181764;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dbRTactPL+UoTh7JhtLP7m2QS4BKZHHCNQWVDx5nQag=;
        b=GEO0/nvBajwIJUPnEU41+WNGwH2DtulMBc4FPYU1jw1eJyQzRO1uSpXBuBH8QLOwCt
         GwhW7UCHdaFTfMpbBv5D8LXISJFDNz6p84oe70QtyPQ0jjTGD/KZxrq2YaTVBZXBmjLX
         O/QMcqR39ySFwSZn+/0ISTfXyj/Fu+13hAe1M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691576964; x=1692181764;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dbRTactPL+UoTh7JhtLP7m2QS4BKZHHCNQWVDx5nQag=;
        b=bmAheEAq3imuZ1EkuCXCidN6IT/rwb/kU39xE+Xz4Q07ryLXt01aH4+AbdaHFPiMwo
         gSujes3QMjnYqXo7rokDBb5A6E1ZdPz2PbNCEThLz3zND2Y7m3TcG5c6DU4fgFSSfMzJ
         rbxuUGkyTl12aoHMDEL5Wvlc1aNGZo47ZQz5N7Yh2tljhwK6tLkn58z2UwPcgsW2l8aX
         CW+OpMlsdgb6LnVhunVdmxZh7pFE4zqPujmfDrQ+z/qxCfI72euazIdD7RmhZoeCHHMt
         Z5vjH/6JqaD60EtHovPP95ODVjODMVhyMphjSJ27gcAVBODkvbnByUEg/nihIROPyLRq
         yqHQ==
X-Gm-Message-State: AOJu0Yxc6xqvpv6IcmYARCdA9mrner53ntdPIegUCR2K7vfH2xeIBDpD
	AiAAsOlGf7cCYc92qeWunNh+hTm+8gnLRFotJe/Scg==
X-Google-Smtp-Source: AGHT+IGZRaNEp0r0k3lBJzbjA9stkGRIasFKmrjd8YKrsWWFriAXqq3HukzU4wsTEvJmwBf0L3B0LsNobh4bY0RjQds=
X-Received: by 2002:aca:2113:0:b0:3a7:4878:235a with SMTP id
 19-20020aca2113000000b003a74878235amr2168484oiz.29.1691576964523; Wed, 09 Aug
 2023 03:29:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <169139090386.324433.6412259486776991296.stgit@devnote2> <169139092722.324433.16681957760325391475.stgit@devnote2>
In-Reply-To: <169139092722.324433.16681957760325391475.stgit@devnote2>
From: Florent Revest <revest@chromium.org>
Date: Wed, 9 Aug 2023 12:29:13 +0200
Message-ID: <CABRcYmJpA7tWk7pNxMy-44aoT9fFByQY3kGiEfKDbOe9WPkmNg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 2/6] tracing: Expose ftrace_regs regardless of CONFIG_FUNCTION_TRACER
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
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Aug 7, 2023 at 8:48=E2=80=AFAM Masami Hiramatsu (Google)
<mhiramat@kernel.org> wrote:
> diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
> index ce156c7704ee..3fb94a1a2461 100644
> --- a/include/linux/ftrace.h
> +++ b/include/linux/ftrace.h
> @@ -112,11 +112,11 @@ static inline int ftrace_mod_get_kallsym(unsigned i=
nt symnum, unsigned long *val
>  }
>  #endif
>
> -#ifdef CONFIG_FUNCTION_TRACER
> -
> -extern int ftrace_enabled;
> -
> -#ifndef CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS
> +/*
> + * If the architecture doesn't support FTRACE_WITH_ARGS or disable funct=
ion

nit: disables*

> + * tracer, define the default(pt_regs compatible) ftrace_regs.
> + */
> +#if !defined(CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS) || !defined(CONFIG_FU=
NCTION_TRACER)

I wonder if we should make things simpler with:

#if defined(HAVE_PT_REGS_COMPAT_FTRACE_REGS) || !defined(CONFIG_FUNCTION_TR=
ACER)

And remove the ftrace_regs definitions that are copy-pastes of this
block in arch specific headers. Then we can enforce in a single point
that HAVE_PT_REGS_COMPAT_FTRACE_REGS holds.

Maybe that's a question for Steven ?

