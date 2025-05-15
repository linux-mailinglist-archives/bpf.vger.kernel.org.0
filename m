Return-Path: <bpf+bounces-58345-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1103AB8EB4
	for <lists+bpf@lfdr.de>; Thu, 15 May 2025 20:19:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6FED168EE5
	for <lists+bpf@lfdr.de>; Thu, 15 May 2025 18:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3BB725C6F4;
	Thu, 15 May 2025 18:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ztCzEw6I"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB0A25B66A
	for <bpf@vger.kernel.org>; Thu, 15 May 2025 18:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747333133; cv=none; b=NuTlx//P9EREZkmHQRLLGC43U1j0NhogwvVqE2vIhLaN7hVE+as+E8RWh8xr6Mb2127fWFICliLtBTAw9t0VPDTianyKhhfttYlsMe6CgTPm7NSss1r4IsTOai2N0VuIa653x6dTE+glx5rnfRh6ReOvbS988zmav8Ypv5uTjzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747333133; c=relaxed/simple;
	bh=3SBz45FoCdX2rAVwgLJMwJm/Tl3yW9BAuoD4CAFzsUI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ig42wpGQVIUtch4WgOfSWOpvmXSu9sNR2EOQpnrLOpygEkyAz0CbIf1v3oyeKpO3ak9tth6SH9RF9G+H4HW4LAVG5xpnICQcltDZMNF6LLaLJYbkcaxkETc3nfnrx2T5PHfkIT/IqDNveFlEKlPr9KjKKzqUj2DV5xwmI9tXwPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ztCzEw6I; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3db82534852so25455ab.0
        for <bpf@vger.kernel.org>; Thu, 15 May 2025 11:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747333130; x=1747937930; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2rGbiTSO7SFrVDmCcDYREcx+d3h1JUwGFxNPYi0cVdQ=;
        b=ztCzEw6IS+0t72TZbHqd5Y3/CP1BQ4wpCDRSObNeGxAwh1HaJsGo+zVWpP3YRZOpNo
         uh6fS9mQkUmjDLTEdDErN+yQjUfj/nVE8A5aCDt7eBb1/nYAFq3g3hhW26otqEeKv0vk
         2jx2vjJ4iAJY9mfXXDEwhCX0E1qIG2JhL32aCSG+4xmyOWtwnU0bDTSck+e1wNuAKM65
         XrPWfSF3xSXKMuHFKV+OyrED/eeRlgwU3oT8cURvsRiYlIdbI/OTNBBEHU2FOLf1Kp7q
         +3fNrbje0SIHKMypLQqqafgkrfkVzXN7iWPbR3lNQ9/MjpSbpRMp10OdG3H/IDVxuMB5
         YD+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747333130; x=1747937930;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2rGbiTSO7SFrVDmCcDYREcx+d3h1JUwGFxNPYi0cVdQ=;
        b=G1RbACO77wXmCsdNccKpcOtr0a27CiFuz8WrysrIk9oHY0vreAuHdV1V6x/XhDvnDD
         vfmIrEZzpziV9BanNsb6gx4Qt2LmUAqIETmAPVoiRrMsmNEGER/iJ6I5eH0Xy3uHj/Ae
         hZ1iW6pl3l0rENPGSCeQY+7ySqZDNDMZr9Pyh16SSW9JCPpJsOCmuCzUUd6uqYr/9o/w
         NRcR23GWPfjXZ4xR44rjDR8SSZyjD+8OSoqdAbtfaHefWmPoqCQVzYRMtPWhZCxT43d9
         W3A6xjUSnCEehsTMP8rE+daQafWzmp7KPEuwsCniSCyfRdZ5kSOYj9kJVWQQ0B/ZJi5/
         RGCQ==
X-Forwarded-Encrypted: i=1; AJvYcCWcoggmL9/UH9rSnCh+2ASU0le4WZ0vPAdr+DRHu5AlXsqWOrwZCsBJEwdGqihdCrRFHDM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMde2EIeACihMPfhNedepzvwY6EpFgkYmWbMQROVmz+QZNz7vI
	9J/4ouJAbkBGBkxk2oubgjTtmx2ctrdc35VjPsHO+GiEUZpU8hAXjFXplEJNYshsR6AyYF1TgWS
	RpmSVM0Jt5JFhpugZpIg0Vj2/4GQNcuIBfMIBggXe
X-Gm-Gg: ASbGncu5N4lCI4x1/gCQ3NP4/bxpj/hXhWEaTZ//r3wswfAs7fmxK5zlSKp3G/+t+O2
	s65R30MpaoCm3EWYmLSgCGjk9ZHa5z9Kupk+/SKdoyNb9+AzOVsWBnWwyLc//QUEaXLHdDVFYK/
	gtd3AUxXVRwIde99V3yl7FAsBRDmy94fOKZ+AkpYhL7xjwnJZ9BNO2Svgci5QQcg==
X-Google-Smtp-Source: AGHT+IGcs2kawo6OdqfIjxqjsI/g20AoKRfUNpKpVRTYjE5Xgove4ZrKHNX2lkUyVTWi8lMmLTRTLM63RbJl0cnT6AQ=
X-Received: by 2002:a05:6e02:b2f:b0:3d9:2af7:d7ef with SMTP id
 e9e14a558f8ab-3db780690c6mr5294515ab.24.1747333130358; Thu, 15 May 2025
 11:18:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250515181042.555189-1-namhyung@kernel.org>
In-Reply-To: <20250515181042.555189-1-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Thu, 15 May 2025 11:18:38 -0700
X-Gm-Features: AX0GCFuU21N0eogG2Zws3gJgWQ-_VqHbZ8Gj4bz03q5Mfr_M1kuRjFpsz0AyX-Q
Message-ID: <CAP-5=fUTXv00r1B=2JQX4nPhZfG+WOQwGrAWmcWAh29fNZz-Kg@mail.gmail.com>
Subject: Re: [PATCH] perf lock contention: Reject more than 10ms delays for safety
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, 
	Song Liu <song@kernel.org>, bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Nit, in the subject line for clarity perhaps rather than "perf lock
contention:" call it "perf lock contention/delay" or "perf lock
delay".

On Thu, May 15, 2025 at 11:10=E2=80=AFAM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> Delaying kernel operations can be dangerous and the kernel may kill
> (non-sleepable) BPF programs running for long in the future.
>
> Limit the max delay to 10ms and update the document about it.
>
>   $ sudo ./perf lock con -abl -J 100000us@cgroup_mutex true
>   lock delay is too long: 100000us (> 10ms)
>
>    Usage: perf lock contention [<options>]
>
>       -J, --inject-delay <TIME@FUNC>
>                             Inject delays to specific locks
>
> Suggested-by: Alexei Starovoitov <ast@kernel.org>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/Documentation/perf-lock.txt | 8 ++++++--
>  tools/perf/builtin-lock.c              | 5 +++++
>  2 files changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/Documentation/perf-lock.txt b/tools/perf/Document=
ation/perf-lock.txt
> index 2d9aecf630422aa6..c17b3e318169f9dc 100644
> --- a/tools/perf/Documentation/perf-lock.txt
> +++ b/tools/perf/Documentation/perf-lock.txt
> @@ -224,8 +224,12 @@ CONTENTION OPTIONS
>         only with -b/--use-bpf.
>
>         The 'time' is specified in nsec but it can have a unit suffix.  A=
vailable
> -       units are "ms" and "us".  Note that it will busy-wait after it ge=
ts the
> -       lock.  Please use it at your own risk.
> +       units are "ms", "us" and "ns".  Currently it accepts up to 10ms o=
f delays
> +       for safety reasons.
> +
> +       Note that it will busy-wait after it gets the lock. Delaying lock=
s can
> +       have significant consequences including potential kernel crashes.=
  Please
> +       use it at your own risk.
>
>
>  SEE ALSO
> diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
> index 41f6f3d2b779b986..3b3ade7a39cad01f 100644
> --- a/tools/perf/builtin-lock.c
> +++ b/tools/perf/builtin-lock.c
> @@ -2537,6 +2537,11 @@ static bool add_lock_delay(char *spec)
>                 return false;
>         }
>
> +       if (duration > 10 * 1000 * 1000) {

nit: It's unfortunate the variable name isn't carrying the time unit.
For example, this could be:
```
if (duration_ns > 10 * NSEC_PER_SEC) {
```
which should hopefully make it clearer what the time units are and
that they aren't messed up.

Thanks,
Ian

> +               pr_err("lock delay is too long: %s (> 10ms)\n", spec);
> +               return false;
> +       }
> +
>         tmp =3D realloc(delays, (nr_delays + 1) * sizeof(*delays));
>         if (tmp =3D=3D NULL) {
>                 pr_err("Memory allocation failure\n");
> --
> 2.49.0.1101.gccaa498523-goog
>

