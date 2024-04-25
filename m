Return-Path: <bpf+bounces-27856-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAB8E8B2985
	for <lists+bpf@lfdr.de>; Thu, 25 Apr 2024 22:15:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DDCC9B21C54
	for <lists+bpf@lfdr.de>; Thu, 25 Apr 2024 20:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6561153510;
	Thu, 25 Apr 2024 20:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RiOZ0Y39"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F006111721;
	Thu, 25 Apr 2024 20:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714076123; cv=none; b=MGkRcvJOys9Q5xO2hE2Amq8AgtChvrMXTUzU5+rKXTPBuETwPHRgFjqplrfg857DMoQnlfgW3+/mbfRTaSO/rhTkWGZNn75aQRweNw/WB93FTG4VtSSFMI0EDhlPIE9p7TA9qAwySJ7P3fnLkK+vFfERFJ3wyuCPJUiyuxpQOEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714076123; c=relaxed/simple;
	bh=xYGOzTpuQf6pjTCwOELSz/wvC1LVCrKnsNk0lGS7Hp0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=po5UCCmrDBl/5SdqPqokO8trcl+xt4e3rmx5RtMkFwGFThvKdtCptbQBxVMjsxv3MWYS6g1snIZLxdrphdZuqxwv5C0UN/9ITmyXUOyX9E7fhha68DKHJMWDr3B6Lp+0e2z6QCGTPQGWKn9LJyHQbKzxo989Z44tsYmfAaP8TvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RiOZ0Y39; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6ed2170d89fso1794767b3a.1;
        Thu, 25 Apr 2024 13:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714076121; x=1714680921; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BYCsbda2zu1J7DpGS9lO6SKkv8cJq4Yl/A7+mKv9cC4=;
        b=RiOZ0Y39bnGJM9WwDaS5quBSvfCeJ4t6AtMvAWfVgV/UXjfkAMLoKP0fuT9KjFUYRH
         0PNxPWhMQvEOJxs8rDwl6v8TD8sHw7Ia0GO8BgXMflIBb/1VNFE+ptvA2lNBZoApMMv3
         n8L/WN8gUbwYFJ0+J6KwkPgLVBJvbLutHJ9grLN21JqcWrWHQ25lNBUG7I8n+C5QZqJB
         qE6oTYgAC3NHNdTqf/7WwhrrH2sl30yOJ+iqC+72wIJypaWOhHwHljkU1h69VqDYnWGD
         pmUlbVxLIVbjVgEXSK8SoPtANvSI8FSqVz43P2XViCgLseOWVJyvcoEX+HX+C6xWBW2X
         B7XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714076121; x=1714680921;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BYCsbda2zu1J7DpGS9lO6SKkv8cJq4Yl/A7+mKv9cC4=;
        b=QYWVZZik2GkTAmnxkkteyrQvx/1AjVufULRPVCMRk/781IUNGvPLp5Hezu6TqgF51H
         6iWj+cXHgiu3tka7hWB+aPDIN+KbeSgvWpdkXlNy4h10nTgEmc3ZU+XxOoQWzIuRhIv0
         IKs0FY0Yt17Hfw7kINJ5T1vdANtMkbWuU+h5SzJ3eh49lrLF46/iBBNQtEU8HsXR1q5X
         O69UqCrav9Vam3KQXpGXGXqxRne3xpm3Kh7dJ31Rd650d8pUtMJQJweFYlJD6K9XDmBs
         9tVOp9W8vKG91WGnuWuCI1K+2+WMQ/3WTRsobjM7/30okWNMHwUOTbFuz6tXDjAeWY8w
         Epzw==
X-Forwarded-Encrypted: i=1; AJvYcCWlYe8r8X5lCdf3YjelS81Czp5OTcETK20kdSJkcGv9/0Q6EpUoUNpnb1DrNYmpm2AiFeNiZEDXaSeMqHy72jx/LPdty7ALfh6JNpVMoGyEtfrGKL2viuX3Z/ar/O+q9TudzB16xYgOoPFA2kOp4QABQiQ6M6vuLXaZpUx08C+ucCIQAg/f
X-Gm-Message-State: AOJu0YwvtiaxaVylGV7gZs2R/xZ2Oxizd9yLsfUN65cFMizHnAoavBSh
	iF4+i5uA9hg0GE+rXHBgdFWtwhakId0efbCUfu5T7v3eePLJrrJqMSUmcUk+4eCKJBK+tnr3/n1
	91XCiSavF+gSUGlhyqg/cTRol40E=
X-Google-Smtp-Source: AGHT+IG10Pr0V7SdVmulnMKJAaTui9tfB3zOWuGD/xcMwfyxG/hQ8HS2HJITy97vLhzRa21EhmsmNb4ADMI7FA3Jzk4=
X-Received: by 2002:a17:90a:9304:b0:2af:c3ea:8122 with SMTP id
 p4-20020a17090a930400b002afc3ea8122mr1125308pjo.7.1714076120857; Thu, 25 Apr
 2024 13:15:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <171318533841.254850.15841395205784342850.stgit@devnote2> <171318575984.254850.17464878774926779209.stgit@devnote2>
In-Reply-To: <171318575984.254850.17464878774926779209.stgit@devnote2>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 25 Apr 2024 13:15:08 -0700
Message-ID: <CAEf4BzZz_4RGyam5GW6Do3Z-sCtk2Cj2D6rYyciYOcJihKdDww@mail.gmail.com>
Subject: Re: [PATCH v9 36/36] fgraph: Skip recording calltime/rettime if it is
 not nneeded
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Florent Revest <revest@chromium.org>, linux-trace-kernel@vger.kernel.org, 
	LKML <linux-kernel@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	bpf <bpf@vger.kernel.org>, Sven Schnelle <svens@linux.ibm.com>, 
	Alexei Starovoitov <ast@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Alan Maguire <alan.maguire@oracle.com>, Mark Rutland <mark.rutland@arm.com>, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Guo Ren <guoren@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 15, 2024 at 6:25=E2=80=AFAM Masami Hiramatsu (Google)
<mhiramat@kernel.org> wrote:
>
> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>
> Skip recording calltime and rettime if the fgraph_ops does not need it.
> This is a kind of performance optimization for fprobe. Since the fprobe
> user does not use these entries, recording timestamp in fgraph is just
> a overhead (e.g. eBPF, ftrace). So introduce the skip_timestamp flag,
> and all fgraph_ops sets this flag, skip recording calltime and rettime.
>
> Suggested-by: Jiri Olsa <olsajiri@gmail.com>
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>  Changes in v9:
>   - Newly added.
> ---
>  include/linux/ftrace.h |    2 ++
>  kernel/trace/fgraph.c  |   46 +++++++++++++++++++++++++++++++++++++++---=
----
>  kernel/trace/fprobe.c  |    1 +
>  3 files changed, 42 insertions(+), 7 deletions(-)
>
> diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
> index d845a80a3d56..06fc7cbef897 100644
> --- a/include/linux/ftrace.h
> +++ b/include/linux/ftrace.h
> @@ -1156,6 +1156,8 @@ struct fgraph_ops {
>         struct ftrace_ops               ops; /* for the hash lists */
>         void                            *private;
>         int                             idx;
> +       /* If skip_timestamp is true, this does not record timestamps. */
> +       bool                            skip_timestamp;
>  };
>
>  void *fgraph_reserve_data(int idx, int size_bytes);
> diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
> index 7556fbbae323..a5722537bb79 100644
> --- a/kernel/trace/fgraph.c
> +++ b/kernel/trace/fgraph.c
> @@ -131,6 +131,7 @@ DEFINE_STATIC_KEY_FALSE(kill_ftrace_graph);
>  int ftrace_graph_active;
>
>  static struct fgraph_ops *fgraph_array[FGRAPH_ARRAY_SIZE];
> +static bool fgraph_skip_timestamp;
>
>  /* LRU index table for fgraph_array */
>  static int fgraph_lru_table[FGRAPH_ARRAY_SIZE];
> @@ -475,7 +476,7 @@ void ftrace_graph_stop(void)
>  static int
>  ftrace_push_return_trace(unsigned long ret, unsigned long func,
>                          unsigned long frame_pointer, unsigned long *retp=
,
> -                        int fgraph_idx)
> +                        int fgraph_idx, bool skip_ts)
>  {
>         struct ftrace_ret_stack *ret_stack;
>         unsigned long long calltime;
> @@ -498,8 +499,12 @@ ftrace_push_return_trace(unsigned long ret, unsigned=
 long func,
>         ret_stack =3D get_ret_stack(current, current->curr_ret_stack, &in=
dex);
>         if (ret_stack && ret_stack->func =3D=3D func &&
>             get_fgraph_type(current, index + FGRAPH_RET_INDEX) =3D=3D FGR=
APH_TYPE_BITMAP &&
> -           !is_fgraph_index_set(current, index + FGRAPH_RET_INDEX, fgrap=
h_idx))
> +           !is_fgraph_index_set(current, index + FGRAPH_RET_INDEX, fgrap=
h_idx)) {
> +               /* If previous one skips calltime, update it. */
> +               if (!skip_ts && !ret_stack->calltime)
> +                       ret_stack->calltime =3D trace_clock_local();
>                 return index + FGRAPH_RET_INDEX;
> +       }
>
>         val =3D (FGRAPH_TYPE_RESERVED << FGRAPH_TYPE_SHIFT) | FGRAPH_RET_=
INDEX;
>
> @@ -517,7 +522,10 @@ ftrace_push_return_trace(unsigned long ret, unsigned=
 long func,
>                 return -EBUSY;
>         }
>
> -       calltime =3D trace_clock_local();
> +       if (skip_ts)

would it be ok to add likely() here to keep the least-overhead code path li=
near?

> +               calltime =3D 0LL;
> +       else
> +               calltime =3D trace_clock_local();
>
>         index =3D READ_ONCE(current->curr_ret_stack);
>         ret_stack =3D RET_STACK(current, index);
> @@ -601,7 +609,8 @@ int function_graph_enter_regs(unsigned long ret, unsi=
gned long func,
>         trace.func =3D func;
>         trace.depth =3D ++current->curr_ret_depth;
>
> -       index =3D ftrace_push_return_trace(ret, func, frame_pointer, retp=
, 0);
> +       index =3D ftrace_push_return_trace(ret, func, frame_pointer, retp=
, 0,
> +                                        fgraph_skip_timestamp);
>         if (index < 0)
>                 goto out;
>
> @@ -654,7 +663,8 @@ int function_graph_enter_ops(unsigned long ret, unsig=
ned long func,
>                 return -ENODEV;
>
>         /* Use start for the distance to ret_stack (skipping over reserve=
) */
> -       index =3D ftrace_push_return_trace(ret, func, frame_pointer, retp=
, gops->idx);
> +       index =3D ftrace_push_return_trace(ret, func, frame_pointer, retp=
, gops->idx,
> +                                        gops->skip_timestamp);
>         if (index < 0)
>                 return index;
>         type =3D get_fgraph_type(current, index);
> @@ -732,6 +742,7 @@ ftrace_pop_return_trace(struct ftrace_graph_ret *trac=
e, unsigned long *ret,
>         *ret =3D ret_stack->ret;
>         trace->func =3D ret_stack->func;
>         trace->calltime =3D ret_stack->calltime;
> +       trace->rettime =3D 0;
>         trace->overrun =3D atomic_read(&current->trace_overrun);
>         trace->depth =3D current->curr_ret_depth;
>         /*
> @@ -792,7 +803,6 @@ __ftrace_return_to_handler(struct ftrace_regs *fregs,=
 unsigned long frame_pointe
>                 return (unsigned long)panic;
>         }
>
> -       trace.rettime =3D trace_clock_local();
>         if (fregs)
>                 ftrace_regs_set_instruction_pointer(fregs, ret);
>
> @@ -808,6 +818,8 @@ __ftrace_return_to_handler(struct ftrace_regs *fregs,=
 unsigned long frame_pointe
>                         continue;
>                 if (gops =3D=3D &fgraph_stub)
>                         continue;
> +               if (!trace.rettime && !gops->skip_timestamp)

In addition to the above, do you mind adding unlikely() here as well?

> +                       trace.rettime =3D trace_clock_local();
>
>                 gops->retfunc(&trace, gops, fregs);
>         }

[...]

