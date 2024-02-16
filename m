Return-Path: <bpf+bounces-22118-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 090A4857251
	for <lists+bpf@lfdr.de>; Fri, 16 Feb 2024 01:14:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EB1D1F22390
	for <lists+bpf@lfdr.de>; Fri, 16 Feb 2024 00:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91703320A;
	Fri, 16 Feb 2024 00:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EExMkWbe"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F1AEC2;
	Fri, 16 Feb 2024 00:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708042454; cv=none; b=ZGbyeduyu6WR7sIcvRJcMaXpYRB5UJa9a2XORCxmj6nr0VyZpBYMTHRvWTNYzI0xRwygS6CkLivu0sv9SeC8o9raw1EDABEGrbolrtooh/EtcrK39c4Q7H3UZ0iws29K9v419ZnJkhYsZFrD1CwpVhaExd41dBAj+j6OEPsutjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708042454; c=relaxed/simple;
	bh=DTuSJ52J8N/bX5W9VU/x7SAXIJrn5eN4LG3JgCE/Q4c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gFcJ9dOR5Ew8R7ZinDqqB4TxQ/YkON7sG9sjbZv6l+xvLpK3YNexiQLliPF+uAERi00GMJoANZpitIDN0zpqv0vaD4NdTWiG0+YHcYoMXdiak0r1uwgMSmNYE0cfsqPemEGtr73zcgIp8/fNu/XXmafWubNwax6cqTEsu/dP21c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EExMkWbe; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-5dca1efad59so1354726a12.2;
        Thu, 15 Feb 2024 16:14:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708042451; x=1708647251; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VP/5h+SFOqXWog8lvjT9gXJwkgwdET6/xnyGoYUrUPc=;
        b=EExMkWbe7Y6IODudWEM1LotiPHfoBUDEviizsvcWknDZQxaYfG5ndlbMCZiCr3R8mW
         vGojo4CmuLs3RQeq3yVjSfUwBcj9kXLyOmQsrbux1A6nnn4HecvPBhx7EeA6Ch328Wja
         AtKa3F549FzbnR49bko2EOflZjaa2SNym54FRp7myyJjPy361we8V7EPhsyG4DTOfsWO
         OeNRzp6u/ktH2IDnyQCuicrK/XtI0l9C9QgnEaEDzfbZt5gB4ofrPihY3fhbR61lZUGa
         G15Uv+rSwjAh2CQWDcp2/P7bn9EmtNpw14up3tgFI2coroH4/aHJMTg8Srp6wTGyq7rH
         2CEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708042451; x=1708647251;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VP/5h+SFOqXWog8lvjT9gXJwkgwdET6/xnyGoYUrUPc=;
        b=TEciIaekf1VnNo24wf1zRo4Va5WIPUfvBl48gr4s0MBC8zyT0G/x/fodxxyzmcReoJ
         Z/NWDm1RSxxXV1Sf9duyCmw0M+M6SbiMMCtumbj7sxAdU8G19b6TfXfAXZyGwYRzDSRB
         zUIEOSSCG4i19eLtKQd39dC3kKtjSDttoJl2JbXBq+MO1rWFyMpV2Wlc0rcnD9hk4QiA
         IA1Ee9H8B+y6B9DzkPTIjhOk71e8zZWWlB4RDC+l5e/dU3jmnuACSUtaIgTSdaRXyK9R
         R+zl4GWbuhdwnEry68XcbBbU4TFEdtiAEJjNIz+lnOAnutlIqI9ZZFikJR/reBQIfQH0
         8eqA==
X-Forwarded-Encrypted: i=1; AJvYcCWlhW7rpU85oebcuEEpKO6xu/yJ5E22JYPUJmULSziquOLIt0mjAhSulAnEvh5scIZT+RfAoo2mXQYaw7bPniDVyh4CTQqwN4tr54qKYe3nfRXZrvxSlBskqnmsgwtuc60gYpGMthKgvdMy9jLmCyibPB7Pbbtex21jkFBOKKzCb5x7Cw==
X-Gm-Message-State: AOJu0YxEdpnnCkNewNxAWe2lMz/Smz5tV6ZYX0egurK0TmQPcQdVbP+7
	N0fvD1oiwc/luWa6NHjaOgISQMVO49O55T6p9mzQ9OR/L3Iq8Zmd66g+h897abBCw1pNXl1Ki+F
	1qgZi+Nfrkg6ZR9W46ogXKWIFt0s=
X-Google-Smtp-Source: AGHT+IFhwxLZc95mR6lY8QS8HgeEDyxXetiOfTmfelxCWBGmp0Tl402/VsSw6kJNGFWHF6XwzY3dALjnGKRo0dbup/0=
X-Received: by 2002:a17:90b:1e0d:b0:299:32f0:8124 with SMTP id
 pg13-20020a17090b1e0d00b0029932f08124mr492527pjb.42.1708042451599; Thu, 15
 Feb 2024 16:14:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240214173950.18570-1-khuey@kylehuey.com> <20240214173950.18570-4-khuey@kylehuey.com>
In-Reply-To: <20240214173950.18570-4-khuey@kylehuey.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 15 Feb 2024 16:13:59 -0800
Message-ID: <CAEf4BzYFbVeVhSjj2wSLfg+qRs5x+yS1Wq9jwLNpJJPPtFiFqQ@mail.gmail.com>
Subject: Re: [RESEND PATCH v5 3/4] perf/bpf: Allow a bpf program to suppress
 all sample side effects
To: Kyle Huey <me@kylehuey.com>
Cc: Kyle Huey <khuey@kylehuey.com>, linux-kernel@vger.kernel.org, 
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Marco Elver <elver@google.com>, 
	Yonghong Song <yonghong.song@linux.dev>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	"Robert O'Callahan" <robert@ocallahan.org>, Song Liu <song@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, linux-perf-users@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 14, 2024 at 9:40=E2=80=AFAM Kyle Huey <me@kylehuey.com> wrote:
>
> Returning zero from a bpf program attached to a perf event already
> suppresses any data output. Return early from __perf_event_overflow() in
> this case so it will also suppress event_limit accounting, SIGTRAP
> generation, and F_ASYNC signalling.
>
> Signed-off-by: Kyle Huey <khuey@kylehuey.com>
> Acked-by: Song Liu <song@kernel.org>
> Acked-by: Jiri Olsa <jolsa@kernel.org>
> Acked-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  kernel/events/core.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 24a718e7eb98..a329bec42c4d 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -9574,6 +9574,11 @@ static int __perf_event_overflow(struct perf_event=
 *event,
>
>         ret =3D __perf_event_account_interrupt(event, throttle);
>
> +#ifdef CONFIG_BPF_SYSCALL
> +       if (event->prog && !bpf_overflow_handler(event, data, regs))
> +               return ret;
> +#endif
> +
>         /*
>          * XXX event_limit might not quite work as expected on inherited
>          * events
> @@ -9623,10 +9628,7 @@ static int __perf_event_overflow(struct perf_event=
 *event,
>                 irq_work_queue(&event->pending_irq);
>         }
>
> -#ifdef CONFIG_BPF_SYSCALL
> -       if (!(event->prog && !bpf_overflow_handler(event, data, regs)))
> -#endif
> -               READ_ONCE(event->overflow_handler)(event, data, regs);
> +       READ_ONCE(event->overflow_handler)(event, data, regs);
>

Sorry, I haven't followed previous discussions, but why can't this
change be done as part of patch 1?

>         if (*perf_event_fasync(event) && event->pending_kill) {
>                 event->pending_wakeup =3D 1;
> --
> 2.34.1
>

