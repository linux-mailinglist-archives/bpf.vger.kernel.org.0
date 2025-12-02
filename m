Return-Path: <bpf+bounces-75932-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 810F4C9D511
	for <lists+bpf@lfdr.de>; Wed, 03 Dec 2025 00:16:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 744AD4E4A40
	for <lists+bpf@lfdr.de>; Tue,  2 Dec 2025 23:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5BA52FB61C;
	Tue,  2 Dec 2025 23:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SC+q9Cs/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 371B0285CB3
	for <bpf@vger.kernel.org>; Tue,  2 Dec 2025 23:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764717368; cv=none; b=s8uYuiSHv2ICsSvPXK88csKLx/ukVephzkkvmP1PBT06WkDALMsM0H7+H3YY94EjosRrVeVlJ780DazzwF13Hfb0CWNcHvBEAtc3tmsoWo4u34KQnuh9RJbaBGAU5bOKnGAALUWnvldIkJSfOaBzZMRxRuUTvsA8qtLxdnjcOlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764717368; c=relaxed/simple;
	bh=47JougxzyLRfPeKtNtBeFuD//fDNWBKYSggGqC9sPr4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UL0GUsVtawlB4uo2dsX56MfDPEJHZ2udOUU4I3mMcdrQsGiiVZ+EbgtQwMzsj5K0O2t2hS+RjKRJO+5raoAkE559UbWeAq6qELgTWnx9juK/rqWg7hbzrVpNRr/OSoM3oRsZlFbw3tDsb+uPry0m4TyiJnDCVWwfNrqAW1TR96I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SC+q9Cs/; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-297e13bf404so74555ad.0
        for <bpf@vger.kernel.org>; Tue, 02 Dec 2025 15:16:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764717365; x=1765322165; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=50DVMy0iPzcBKBbda9cIbV2YMyijzbaPSI2wUDkfV6I=;
        b=SC+q9Cs/K14wvJ7kLTiZuZlCq7jhedCs21kQkRUy2ou1RPrvsQPJ9fT1FTTp8rNk9R
         2++5sHZ54pkLrhXDpOe7mvKC2JtWyqNtqGCJb0VyjAkTJM4g23xxWNhXmONKsYFIncbt
         sEfGpgAariwoK+//P5qFRbkWbWTuBMz7oFSvIBxCswIX5GAtXigmgOemJ5e3uRUE8fyy
         IZVB8WEAWqEBuNpIIJFiLUNTh5MN4itSWqkHoZzmveXjXOYhzYVU3laMQJdSmGm5XTRO
         6YsbZP0m+fvqIfHwroJL3k6mUwK62Kqi1twJ/hBdlXBCqPi+471Fs6R4XwQiKLvfImYu
         7Xvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764717365; x=1765322165;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=50DVMy0iPzcBKBbda9cIbV2YMyijzbaPSI2wUDkfV6I=;
        b=ULiTr3eudAPOIcjvvJav7ntAejomp0k3kQNSnib/jSzl9R3nvjJnAI39efeI0bzSoB
         5hSrltM20dUIDuoTAPhGbkBH/bgxalrb7HKoCzyIO8tQYU+F3mXmfQwzvMk5q4E8+4pX
         XUXRnPakm0ameJZanl/uEK34tfKm2M8vPMty1qOn63tsxZ7KpKI3IjO3drG8fR6Qu7G+
         yPxjVK7lzPxMVoNq0AmGqk34uYoD+uQv/U/b1XfcznMamTTow1NUa9ojHmGet7CLVQVj
         tF8Uiqexi1w/9kYYiDqL7QaptJCgVR+J+skXhg+OaQmwwTT3NUO/Y6JomaHi2a6dmJwQ
         hp+A==
X-Forwarded-Encrypted: i=1; AJvYcCVd+tLMHDb6spUwSvEiMnDEA5HEUOeIYVt9CMtzKEQdwHhsBBCW2GCK485Se+CUpeZg8Gs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4F1hqXcpr6Z3ziIVqK6ng7slyCKgzSlWqcctM79eLyDus9x8Y
	omKzmtgCCH7XjcXVJfVJdAq2xt+0EnsWVg+ehZMC1SMUteTviCxxG8jEo9VwMgOiRFI5aUnyiSf
	fj8Kb/qng4e+6kexY2lSrPEnt9vROsNlbGmvYiuT5
X-Gm-Gg: ASbGncvYrGz6PmernGfW/CVB3K3/XwcGEOvcQ4pTMv0w5NHLTRfV4z7mSoKIKNLATLR
	gatHCXD6PyAJYZkTD7TYL73V1bC/WcISfAWU3dyAssBCIFZtumFXxsxnnviXELXnHYe4zHai0K2
	9/jBN4bA3CiC+W75j6aulENoDp9RdDbmdEZlmFK/BE46Ogmyd0BUhSLaMobGWmEAYA5/tgbiybk
	Ey4Kt2iHgntW2Q48bHYCa/GG+tcqWjgsLN1s7pGRhIWNaQaHKfun2dlK5Fx4kNLUxli+AVDUjMK
	DLJR5Memu7VM3w/OK0SkZ+5a
X-Google-Smtp-Source: AGHT+IEtBuE8dMkxTWk0sC4VgTcy2fTd4H8KpQmmfnh9lLn7x4CPXcF3p1ST9wc1sX8gwN21gB73EnevpSjDYYQmjvw=
X-Received: by 2002:a17:902:cec8:b0:299:c367:9e02 with SMTP id
 d9443c01a7336-29d67f71595mr480785ad.17.1764717365133; Tue, 02 Dec 2025
 15:16:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251120234804.156340-1-namhyung@kernel.org> <20251120234804.156340-7-namhyung@kernel.org>
In-Reply-To: <20251120234804.156340-7-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Tue, 2 Dec 2025 15:15:53 -0800
X-Gm-Features: AWmQ_bnZbpawHRiOWnRkWKBXay2hQ9O3dtwYzvtFpXbMDeouLJk9PtKM7rmz02s
Message-ID: <CAP-5=fV5_jxOmZP1q3k88Cs9VXG_d9YW0qk8NoUFKgZgp1x73A@mail.gmail.com>
Subject: Re: [PATCH v6 6/6] perf tools: Flush remaining samples w/o deferred callchains
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, James Clark <james.clark@linaro.org>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, 
	Steven Rostedt <rostedt@goodmis.org>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Indu Bhagat <indu.bhagat@oracle.com>, Jens Remus <jremus@linux.ibm.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, linux-trace-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 20, 2025 at 3:48=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> It's possible that some kernel samples don't have matching deferred
> callchain records when the profiling session was ended before the
> threads came back to userspace.  Let's flush the samples before
> finish the session.
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/session.c | 50 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 50 insertions(+)
>
> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> index dc570ad47ccc2c63..4236503c8f6c1350 100644
> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c
> @@ -1295,6 +1295,10 @@ struct deferred_event {
>         union perf_event *event;
>  };
>
> +/*
> + * This is called when a deferred callchain record comes up.  Find all m=
atching
> + * samples, merge the callchains and process them.
> + */
>  static int evlist__deliver_deferred_callchain(struct evlist *evlist,
>                                               const struct perf_tool *too=
l,
>                                               union  perf_event *event,
> @@ -1345,6 +1349,42 @@ static int evlist__deliver_deferred_callchain(stru=
ct evlist *evlist,
>         return ret;
>  }
>
> +/*
> + * This is called at the end of the data processing for the session.  Fl=
ush the
> + * remaining samples as there's no hope for matching deferred callchains=
.
> + */
> +static int session__flush_deferred_samples(struct perf_session *session,
> +                                          const struct perf_tool *tool)
> +{
> +       struct evlist *evlist =3D session->evlist;
> +       struct machine *machine =3D &session->machines.host;
> +       struct deferred_event *de, *tmp;
> +       struct evsel *evsel;
> +       int ret =3D 0;
> +
> +       list_for_each_entry_safe(de, tmp, &evlist->deferred_samples, list=
) {
> +               struct perf_sample sample;
> +
> +               ret =3D evlist__parse_sample(evlist, de->event, &sample);
> +               if (ret < 0) {
> +                       pr_err("failed to parse original sample\n");
> +                       break;
> +               }
> +
> +               evsel =3D evlist__id2evsel(evlist, sample.id);
> +               ret =3D evlist__deliver_sample(evlist, tool, de->event,
> +                                            &sample, evsel, machine);
> +
> +               list_del(&de->list);
> +               free(de->event);
> +               free(de);
> +
> +               if (ret)
> +                       break;
> +       }
> +       return ret;
> +}
> +
>  static int machines__deliver_event(struct machines *machines,
>                                    struct evlist *evlist,
>                                    union perf_event *event,
> @@ -2038,6 +2078,9 @@ static int __perf_session__process_pipe_events(stru=
ct perf_session *session)
>  done:
>         /* do the final flush for ordered samples */
>         err =3D ordered_events__flush(oe, OE_FLUSH__FINAL);
> +       if (err)
> +               goto out_err;
> +       err =3D session__flush_deferred_samples(session, tool);
>         if (err)
>                 goto out_err;
>         err =3D auxtrace__flush_events(session, tool);
> @@ -2384,6 +2427,9 @@ static int __perf_session__process_events(struct pe=
rf_session *session)
>         if (err)
>                 goto out_err;
>         err =3D auxtrace__flush_events(session, tool);
> +       if (err)
> +               goto out_err;
> +       err =3D session__flush_deferred_samples(session, tool);
>         if (err)
>                 goto out_err;
>         err =3D perf_session__flush_thread_stacks(session);
> @@ -2506,6 +2552,10 @@ static int __perf_session__process_dir_events(stru=
ct perf_session *session)
>         if (ret)
>                 goto out_err;
>
> +       ret =3D session__flush_deferred_samples(session, tool);
> +       if (ret)
> +               goto out_err;
> +
>         ret =3D perf_session__flush_thread_stacks(session);
>  out_err:
>         ui_progress__finish();
> --
> 2.52.0.rc2.455.g230fcf2819-goog
>

