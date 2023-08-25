Return-Path: <bpf+bounces-8706-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5C0E7890B4
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 23:50:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CA16281910
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 21:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE417198A2;
	Fri, 25 Aug 2023 21:50:03 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB508193B2
	for <bpf@vger.kernel.org>; Fri, 25 Aug 2023 21:50:03 +0000 (UTC)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BAED26B2;
	Fri, 25 Aug 2023 14:50:02 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-31c5cac3ae2so1060630f8f.3;
        Fri, 25 Aug 2023 14:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693000200; x=1693605000;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cINYXeZKT6Qzjs4rB6QKsa26hETCQhkT6ut7CBIDbos=;
        b=KLS5gIxCGWPdL99OH1mH59psZ9Ey6yCTIcTR1iqbOxcqmLV3lR+gLrHumu6HCu6TF9
         cVh6Evi81y931inKfhZX/SDVXSA5Zt6idn5Pii1YESrhnLoWm9GrfDzwtNdgfayu1o4o
         KjiDC97LzPNrfEy5OaJBfZ+floD7mntSLLpRNBxG/qCQCPyPVfduaRMIirnllV8AeGQM
         FNRF3x6OGhwaWNjMByUVNKfCM990pp7FyvWcrDUeJdNlO7pm6OsIj2yl3/pzQkj1ZIH3
         GBnNLXD4C1eeWwFpAEyHBZCoONxBGWbCVbnYepQovon4p0mHWk/VoUyOPCDO7I8kXJyZ
         0sGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693000200; x=1693605000;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cINYXeZKT6Qzjs4rB6QKsa26hETCQhkT6ut7CBIDbos=;
        b=EtWkP5lBMJQoVix6sHgvsVGT7tK81GNoAD/C+2/qXjgFdNYjWQdsjR31tBFXFr+Udk
         pXgfQYl/pUaQkGMXf9A8PUsVmbgmgMMQwp8uYt1ye3w+Xrwnc9OYgSfnfp1v0rWs6CVL
         3b0qKyhvO1PBqkdNtmpMRER7mVbl16cnEZC0hli6yksXQJJeRB0iFLPLjqYUdJ3kGExc
         bP7b3km2k4sDqzn6CMSk86mO83aw3gX7FT565Dp72XrKue8svQK1boMGP+1ERU7B7CoD
         j97ooP3kWHp/1uk26nIYsuU3WwzL54xzgYKWK5RfmJCg9k9OIw7IHbjLM7xtbpknucpd
         7vjQ==
X-Gm-Message-State: AOJu0Yz4rAO/zu+P1NmsCV7pMPnPU4G09EIUnf9xY2gVjmQFe3HnQW0S
	o+xMeOCaXF+5U27TONBd0/9DvTGSMTKOSXKwOyQ=
X-Google-Smtp-Source: AGHT+IH1jGiQ0aUQ/YV08xIp3r2bAqvPlfqwWjtnuTQgbEmC5MMFOZZTN37c8SjldmRDu5uUY3vHgUfFBsFKp8b9awo=
X-Received: by 2002:a5d:4a12:0:b0:317:49a2:1f89 with SMTP id
 m18-20020a5d4a12000000b0031749a21f89mr14661990wrq.1.1693000200321; Fri, 25
 Aug 2023 14:50:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <169280372795.282662.9784422934484459769.stgit@devnote2> <169280378611.282662.4078983611827223131.stgit@devnote2>
In-Reply-To: <169280378611.282662.4078983611827223131.stgit@devnote2>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 25 Aug 2023 14:49:48 -0700
Message-ID: <CAEf4Bzb9CBnQp1_bEW-DOhw9rpDj6jt79DMmsKL2L4a_4ts9gQ@mail.gmail.com>
Subject: Re: [PATCH v4 5/9] ftrace: Add ftrace_partial_regs() for converting
 ftrace_regs to pt_regs
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Florent Revest <revest@chromium.org>, linux-trace-kernel@vger.kernel.org, 
	LKML <linux-kernel@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	bpf <bpf@vger.kernel.org>, Sven Schnelle <svens@linux.ibm.com>, 
	Alexei Starovoitov <ast@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Alan Maguire <alan.maguire@oracle.com>, Mark Rutland <mark.rutland@arm.com>, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Aug 23, 2023 at 8:16=E2=80=AFAM Masami Hiramatsu (Google)
<mhiramat@kernel.org> wrote:
>
> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>
> Add ftrace_partial_regs() which converts the ftrace_regs to pt_regs.
> If the architecture defines its own ftrace_regs, this copies partial
> registers to pt_regs and returns it. If not, ftrace_regs is the same as
> pt_regs and ftrace_partial_regs() will return ftrace_regs::regs.
>
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> Acked-by: Florent Revest <revest@chromium.org>
> ---
>  Changes in v3:
>   - Fix to use pt_regs::regs instead of x.
>   - Return ftrace_regs::regs forcibly if HAVE_PT_REGS_COMPAT_FTRACE_REGS=
=3Dy.
>   - Fix typo.
>   - Fix to copy correct registers to the pt_regs on arm64.
>  Changes in v4:
>   - Change the patch order in the series so that fprobe event can use thi=
s.
> ---
>  arch/arm64/include/asm/ftrace.h |   11 +++++++++++
>  include/linux/ftrace.h          |   17 +++++++++++++++++
>  2 files changed, 28 insertions(+)
>
> diff --git a/arch/arm64/include/asm/ftrace.h b/arch/arm64/include/asm/ftr=
ace.h
> index ab158196480c..5ad24f315d52 100644
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
> +       memcpy(regs->regs, fregs->regs, sizeof(u64) * 9);
> +       regs->sp =3D fregs->sp;
> +       regs->pc =3D fregs->pc;
> +       regs->regs[29] =3D fregs->fp;
> +       regs->regs[30] =3D fregs->lr;

I see that orig_x0 from pt_regs is used on arm64 to get syscall's
first parameter. And it seems like this ftrace_regs to pt_regs
conversion doesn't touch orig_x0 at all. Is it maintained/preserved
somewhere else, or will we lose the ability to get the first syscall's
argument?

Looking at libbpf's bpf_tracing.h, other than orig_x0, I think all the
other registers are still preserved, so this seems to be the only
potential problem.


> +       return regs;
> +}
> +
>  int ftrace_regs_query_register_offset(const char *name);
>
>  int ftrace_init_nop(struct module *mod, struct dyn_ftrace *rec);
> diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
> index c0a42d0860b8..a6ed2aa71efc 100644
> --- a/include/linux/ftrace.h
> +++ b/include/linux/ftrace.h
> @@ -165,6 +165,23 @@ static __always_inline struct pt_regs *ftrace_get_re=
gs(struct ftrace_regs *fregs
>         return arch_ftrace_get_regs(fregs);
>  }
>
> +#if !defined(CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS) || \
> +       defined(CONFIG_HAVE_PT_REGS_TO_FTRACE_REGS_CAST)
> +
> +static __always_inline struct pt_regs *
> +ftrace_partial_regs(struct ftrace_regs *fregs, struct pt_regs *regs)
> +{
> +       /*
> +        * If CONFIG_HAVE_PT_REGS_TO_FTRACE_REGS_CAST=3Dy, ftrace_regs me=
mory
> +        * layout is the same as pt_regs. So always returns that address.
> +        * Since arch_ftrace_get_regs() will check some members and may r=
eturn
> +        * NULL, we can not use it.
> +        */
> +       return &fregs->regs;
> +}
> +
> +#endif /* !CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS || CONFIG_HAVE_PT_REGS_T=
O_FTRACE_REGS_CAST */
> +
>  /*
>   * When true, the ftrace_regs_{get,set}_*() functions may be used on fre=
gs.
>   * Note: this can be true even when ftrace_get_regs() cannot provide a p=
t_regs.
>
>

