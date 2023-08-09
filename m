Return-Path: <bpf+bounces-7329-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDB12775725
	for <lists+bpf@lfdr.de>; Wed,  9 Aug 2023 12:32:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2ACC41C211FE
	for <lists+bpf@lfdr.de>; Wed,  9 Aug 2023 10:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E8FD171C0;
	Wed,  9 Aug 2023 10:31:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E11D1FB3B
	for <bpf@vger.kernel.org>; Wed,  9 Aug 2023 10:31:40 +0000 (UTC)
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54D741FDF
	for <bpf@vger.kernel.org>; Wed,  9 Aug 2023 03:31:39 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-26813478800so3749111a91.1
        for <bpf@vger.kernel.org>; Wed, 09 Aug 2023 03:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1691577099; x=1692181899;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hrsBW/bweVeFGqbEFObsS1CtKLg/RluEI+jdzyDd8LM=;
        b=kp02DhCnBxtJNEdhc8TGr3zPEgGJBqMF/pETbjcWuL0nXrjP+kKw0BOzXHRxFwcyAM
         Vq8Hq5ZfzKbUUdWMo1HU5Fcs0/p6L5bWv0QDn/JdNjf17WFIdtpK+/8ZCMJ/+33eXRRQ
         4pxdlIMTwdRerAi8Zu921N0K3QfZVD6rf2Mg8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691577099; x=1692181899;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hrsBW/bweVeFGqbEFObsS1CtKLg/RluEI+jdzyDd8LM=;
        b=AFZxyTQrS4/trPDmfatcmjk9IAH+hMIYc6tvF/yKHKZli5RI9/dkhTNnXfBYsOeUkb
         KEX3afpVbII3B/P4N/Os56B3V4HdvCM5iSRBqQwXMQyDGij8wmWNa/UcigknTa9GSwOB
         TjkXreqOoQus91iDmY8R5hVBY6EcL3JO0Yzm1M3jVYaUYyQgd9fgmME7Mhjyb+MYUIZp
         10ob70UvfJgP8udjOgwKfQR8RMPNL7GKEFojeQE/gdXVOUMFuswLmsyxosk/YfWG8WWR
         rSYZ7sjUWd+iE9uA2W1S8drbvC457sE6hTmrqivTurVxH+im3M5y0srfmagwfLDniD8w
         xGlA==
X-Gm-Message-State: AOJu0YzZqNUlHVGdcd+ZCqSiRV6w2+hEDexaGvYRfI4B/BCSm3vHwWTn
	Vm771Rw9O5leq/3ta7xdpw61bKmE5aGdsengF4nrXg==
X-Google-Smtp-Source: AGHT+IELEKsPXhWoxXahSRpjgF0fdoA/3cunXQAk8442EDq6G3fDPOSobQiaBDQ1GIXYmi9D3LoxJGNFpIcwYMYj9mI=
X-Received: by 2002:a17:90a:6fc5:b0:268:2f2:cc88 with SMTP id
 e63-20020a17090a6fc500b0026802f2cc88mr898566pjk.12.1691577098828; Wed, 09 Aug
 2023 03:31:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <169139090386.324433.6412259486776991296.stgit@devnote2> <169139096244.324433.7237290521765120297.stgit@devnote2>
In-Reply-To: <169139096244.324433.7237290521765120297.stgit@devnote2>
From: Florent Revest <revest@chromium.org>
Date: Wed, 9 Aug 2023 12:31:27 +0200
Message-ID: <CABRcYmLFwSrfsod6y8-K1memLUZiJeb2so6pD4XaFUpwbLD9AQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 5/6] ftrace: Add ftrace_partial_regs() for
 converting ftrace_regs to pt_regs
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
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Aug 7, 2023 at 8:49=E2=80=AFAM Masami Hiramatsu (Google)
<mhiramat@kernel.org> wrote:
>
> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>
> Add ftrace_partial_regs() which converts the ftrace_regas to pt_regs.

ftrace_regs*

> If the architecture defines its own ftrace_regs, this copies partial
> registers to pt_regs and returns it. If not, ftrace_regs is the same as
> pt_regs and ftrace_partial_regs() will return ftrace_regs::regs.
>
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>  arch/arm64/include/asm/ftrace.h |   11 +++++++++++
>  include/linux/ftrace.h          |   11 +++++++++++
>  2 files changed, 22 insertions(+)
>
> diff --git a/arch/arm64/include/asm/ftrace.h b/arch/arm64/include/asm/ftr=
ace.h
> index ab158196480c..b108cd6718cf 100644
> --- a/arch/arm64/include/asm/ftrace.h
> +++ b/arch/arm64/include/asm/ftrace.h
> @@ -137,6 +137,17 @@ ftrace_override_function_with_return(struct ftrace_r=
egs *fregs)
>         fregs->pc =3D fregs->lr;
>  }
>
> +static __always_inline struct pt_regs *
> +ftrace_partial_regs(const struct ftrace_regs *fregs, struct pt_regs *reg=
s)
> +{
> +       memcpy(regs->regs, fregs->regs, sizeof(u64) * 10);

Are you intentionally copying that tenth value (fregs.direct_tramp)
into pt_regs.regs[9] ? This seems wrong and it looks like it will bite
us back one day. Isn't it one of these cases where we can simply use
sizeof(fregs->regs) ?

> +       regs->sp =3D fregs->sp;
> +       regs->pc =3D fregs->pc;
> +       regs->x[29] =3D fregs->fp;
> +       regs->x[30] =3D fregs->lr;
> +       return regs;
> +}
> +
>  int ftrace_regs_query_register_offset(const char *name);
>
>  int ftrace_init_nop(struct module *mod, struct dyn_ftrace *rec);
> diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
> index 3fb94a1a2461..7f45654441b7 100644
> --- a/include/linux/ftrace.h
> +++ b/include/linux/ftrace.h
> @@ -155,6 +155,17 @@ static __always_inline struct pt_regs *ftrace_get_re=
gs(struct ftrace_regs *fregs
>         return arch_ftrace_get_regs(fregs);
>  }
>
> +#if !defined(CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS) || \
> +       defined(CONFIG_HAVE_PT_REGS_COMPAT_FTRACE_REGS)
> +
> +static __always_inline struct pt_regs *
> +ftrace_partial_regs(const struct ftrace_regs *fregs, struct pt_regs *reg=
s)
> +{
> +       return arch_ftrace_get_regs((struct ftrace_regs *)fregs);
> +}

I don't think this works. Suppose you are on x86, WITH_ARGS, and with
HAVE_PT_REGS_COMPAT_FTRACE_REGS. If you register to ftrace without
FTRACE_OPS_FL_SAVE_REGS you will receive a ftrace_regs from the light
ftrace pre-trampoline that has a CS register equal to 0 and
arch_ftrace_get_regs will return NULL here, which should never happen.

Have you tested your series without registering as FTRACE_OPS_FL_SAVE_REGS =
?

