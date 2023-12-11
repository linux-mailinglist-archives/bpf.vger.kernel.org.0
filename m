Return-Path: <bpf+bounces-17404-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 70B7C80CE34
	for <lists+bpf@lfdr.de>; Mon, 11 Dec 2023 15:20:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 015C3B20FA8
	for <lists+bpf@lfdr.de>; Mon, 11 Dec 2023 14:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02303487A9;
	Mon, 11 Dec 2023 14:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OneVFLLw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25FB135B3
	for <bpf@vger.kernel.org>; Mon, 11 Dec 2023 06:20:46 -0800 (PST)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-1f5bd86ceb3so3285522fac.2
        for <bpf@vger.kernel.org>; Mon, 11 Dec 2023 06:20:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702304445; x=1702909245; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=b7rlHaKQWXujUJWBukOmFO3U6X3+0Q326b+lP9WNi7o=;
        b=OneVFLLwm5ISbB3UeBCiQfBfizvB07+GHl1CP4ToDmvTwWInWx0eRQ2HT4xjkiUW4U
         /QwvRIks95q4yESEtbu6iM1YP0C7J8LkjXlhnNoP0zJo9xVzb2XLYTNAIOE5OuwpEa2A
         WWvgkLVIEBuDnYEcwegYYNrfdfKk9isuNYBVjyZNKoO1tpL9KsE8B1hJEEaxJSmoB3yp
         wtgsKYkK5pnaM5QnWGpS7FL9VqtDTmmQkRJ60BGYYwCgV6xTHtrzh20f+WcFUXlcPu1E
         on5BzuK/IdgwlJVGKk12c/EWZAn/DiYrQOy/I2fnXF/1nNMFk3j/9EidE4lxsbrFvBdN
         LJmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702304445; x=1702909245;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b7rlHaKQWXujUJWBukOmFO3U6X3+0Q326b+lP9WNi7o=;
        b=r6zTNZskUU6yNIxr8hdfu47tCcZjDuC5Sfkm03hmQKT0KVVG6r9f1ADfpagKXOFmyZ
         8oiXKnAiaJ2LmAwO6O0vk+pUn0OTo7CnLTdzcLzT+64EDAGZmcnWDR4z+9b2jfJMuVxV
         0SKdiji/963yjisR/jmLwB+bxRkK56hmUJyWQFT3UdiktvP2PsQsZRB6FQATT9oEQ5zY
         1L+VXjEUVtxGwB7tRY8UOZzDyJ0MVTyyNcv6L9/2kuweZ9ONu83IFm9ozap/sI/itRuM
         UMOZgbA20chcexyHy16khnDTfSQ0tyzD65JRMqI/QEhp4GqW5ukgwVE1cRfQ5EmKq32v
         JKcw==
X-Gm-Message-State: AOJu0Yz9eFlvsncdb8zZKfnpuCloQbP+tTWXrVF0cQDHQAXeKDlEj7QT
	+g5yzT+3VVSibe4I39ZnTb49M5cp54BaZlS4Lnk3xQ==
X-Google-Smtp-Source: AGHT+IH5sir+QHLUZSjR236YJEi+mk4L/A4SMauTvkuuWPhpch7FibrTpRcY7a9kuBELNV5WVBRkKorL015slNGOXvo=
X-Received: by 2002:a05:6871:7a02:b0:1fa:ede6:4691 with SMTP id
 pc2-20020a0568717a0200b001faede64691mr5487118oac.27.1702304445002; Mon, 11
 Dec 2023 06:20:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231211045543.31741-1-khuey@kylehuey.com> <20231211045543.31741-2-khuey@kylehuey.com>
In-Reply-To: <20231211045543.31741-2-khuey@kylehuey.com>
From: Marco Elver <elver@google.com>
Date: Mon, 11 Dec 2023 15:20:05 +0100
Message-ID: <CANpmjNPvZ=S5Afn9DR7nG2UFstqz5t1gBznTh4yezVv7k1+m9w@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] perf/bpf: Call bpf handler directly, not through
 overflow machinery
To: Kyle Huey <me@kylehuey.com>
Cc: Kyle Huey <khuey@kylehuey.com>, linux-kernel@vger.kernel.org, 
	Andrii Nakryiko <andrii.nakryiko@gmail.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	"Robert O'Callahan" <robert@ocallahan.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, linux-perf-users@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 11 Dec 2023 at 05:55, Kyle Huey <me@kylehuey.com> wrote:
>
> To ultimately allow bpf programs attached to perf events to completely
> suppress all of the effects of a perf event overflow (rather than just the
> sample output, as they do today), call bpf_overflow_handler() from
> __perf_event_overflow() directly rather than modifying struct perf_event's
> overflow_handler. Return the bpf program's return value from
> bpf_overflow_handler() so that __perf_event_overflow() knows how to
> proceed. Remove the now unnecessary orig_overflow_handler from struct
> perf_event.
>
> This patch is solely a refactoring and results in no behavior change.
>
> Signed-off-by: Kyle Huey <khuey@kylehuey.com>
> Suggested-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  include/linux/perf_event.h |  6 +-----
>  kernel/events/core.c       | 28 +++++++++++++++-------------
>  2 files changed, 16 insertions(+), 18 deletions(-)
>
> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index 5547ba68e6e4..312b9f31442c 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -810,7 +810,6 @@ struct perf_event {
>         perf_overflow_handler_t         overflow_handler;
>         void                            *overflow_handler_context;
>  #ifdef CONFIG_BPF_SYSCALL
> -       perf_overflow_handler_t         orig_overflow_handler;
>         struct bpf_prog                 *prog;
>         u64                             bpf_cookie;
>  #endif
> @@ -1337,10 +1336,7 @@ __is_default_overflow_handler(perf_overflow_handler_t overflow_handler)
>  #ifdef CONFIG_BPF_SYSCALL
>  static inline bool uses_default_overflow_handler(struct perf_event *event)
>  {
> -       if (likely(is_default_overflow_handler(event)))
> -               return true;
> -
> -       return __is_default_overflow_handler(event->orig_overflow_handler);
> +       return is_default_overflow_handler(event);
>  }
>  #else
>  #define uses_default_overflow_handler(event) \
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index b704d83a28b2..54f6372d2634 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -9515,6 +9515,12 @@ static inline bool sample_is_allowed(struct perf_event *event, struct pt_regs *r
>         return true;
>  }
>
> +#ifdef CONFIG_BPF_SYSCALL
> +static int bpf_overflow_handler(struct perf_event *event,
> +                               struct perf_sample_data *data,
> +                               struct pt_regs *regs);
> +#endif

To avoid more #ifdefs we usually add a stub, something like:

#ifdef ...
static int bpf_overflow_handler(...);
#else
static inline int bpf_overflow_handler(...) { return 0; }
#endif

Then you can avoid more #ifdefs below, esp. when it surrounds an
if-statement it easily leads to confusion or subtle bugs in future
changes. The compiler will optimize out the constants and the
generated code will be the same.

>  /*
>   * Generic event overflow handling, sampling.
>   */
> @@ -9584,7 +9590,10 @@ static int __perf_event_overflow(struct perf_event *event,
>                 irq_work_queue(&event->pending_irq);
>         }
>
> -       READ_ONCE(event->overflow_handler)(event, data, regs);
> +#ifdef CONFIG_BPF_SYSCALL
> +       if (!(event->prog && !bpf_overflow_handler(event, data, regs)))
> +#endif
> +               READ_ONCE(event->overflow_handler)(event, data, regs);
>
>         if (*perf_event_fasync(event) && event->pending_kill) {
>                 event->pending_wakeup = 1;
> @@ -10394,9 +10403,9 @@ static void perf_event_free_filter(struct perf_event *event)
>  }
>
>  #ifdef CONFIG_BPF_SYSCALL
> -static void bpf_overflow_handler(struct perf_event *event,
> -                                struct perf_sample_data *data,
> -                                struct pt_regs *regs)
> +static int bpf_overflow_handler(struct perf_event *event,
> +                               struct perf_sample_data *data,
> +                               struct pt_regs *regs)
>  {
>         struct bpf_perf_event_data_kern ctx = {
>                 .data = data,
> @@ -10417,10 +10426,8 @@ static void bpf_overflow_handler(struct perf_event *event,
>         rcu_read_unlock();
>  out:
>         __this_cpu_dec(bpf_prog_active);
> -       if (!ret)
> -               return;
>
> -       event->orig_overflow_handler(event, data, regs);
> +       return ret;
>  }
>
>  static int perf_event_set_bpf_handler(struct perf_event *event,
> @@ -10456,8 +10463,6 @@ static int perf_event_set_bpf_handler(struct perf_event *event,
>
>         event->prog = prog;
>         event->bpf_cookie = bpf_cookie;
> -       event->orig_overflow_handler = READ_ONCE(event->overflow_handler);
> -       WRITE_ONCE(event->overflow_handler, bpf_overflow_handler);
>         return 0;
>  }
>
> @@ -10468,7 +10473,6 @@ static void perf_event_free_bpf_handler(struct perf_event *event)
>         if (!prog)
>                 return;
>
> -       WRITE_ONCE(event->overflow_handler, event->orig_overflow_handler);
>         event->prog = NULL;
>         bpf_prog_put(prog);
>  }
> @@ -11928,13 +11932,11 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
>                 overflow_handler = parent_event->overflow_handler;
>                 context = parent_event->overflow_handler_context;
>  #if defined(CONFIG_BPF_SYSCALL) && defined(CONFIG_EVENT_TRACING)
> -               if (overflow_handler == bpf_overflow_handler) {
> +               if (parent_event->prog) {
>                         struct bpf_prog *prog = parent_event->prog;
>
>                         bpf_prog_inc(prog);
>                         event->prog = prog;
> -                       event->orig_overflow_handler =
> -                               parent_event->orig_overflow_handler;
>                 }
>  #endif
>         }
> --
> 2.34.1
>

