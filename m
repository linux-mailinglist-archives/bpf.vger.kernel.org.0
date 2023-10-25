Return-Path: <bpf+bounces-13202-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 810067D60BF
	for <lists+bpf@lfdr.de>; Wed, 25 Oct 2023 06:13:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AC711C20DC0
	for <lists+bpf@lfdr.de>; Wed, 25 Oct 2023 04:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EEC1881E;
	Wed, 25 Oct 2023 04:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N+QWvo22"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C992D628
	for <bpf@vger.kernel.org>; Wed, 25 Oct 2023 04:13:15 +0000 (UTC)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8C0A123
	for <bpf@vger.kernel.org>; Tue, 24 Oct 2023 21:13:13 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-53eeb28e8e5so4497a12.1
        for <bpf@vger.kernel.org>; Tue, 24 Oct 2023 21:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698207192; x=1698811992; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8eCeunVYQFz26TpeFcqj1dGeFr6YLbG2VvecTD6jcmQ=;
        b=N+QWvo228ZvKaUY7aUTagS/joWSnX3nR4Lnl+b2bUZjbxw53o8GqZs7EF9QlQImPNR
         279qpHnDFitIBcbksEUuWcBTkIiRlYHhf4HMHREJ2fioh1TY/+HVpdJ5HjENlcKMxPAZ
         sZPPZCVIfGui0oDxGedbTG5sAvAMX0FUf75wCD+CS4deeRwUWBz49vxZaxiQ/ONdqh/b
         Gdrh1jBJnBUs/S5Y9b9ZH3iCE26i7stKkrur0YQ9YTEto4cMF2V9DFO9psEdc7XXzbPa
         l0v1xzq1dRDNPsng4cXgRWsUxLvlyeANEa9Hv5T0CkAAEDMl0dRPasHHaMo/D7GeKN36
         gJIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698207192; x=1698811992;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8eCeunVYQFz26TpeFcqj1dGeFr6YLbG2VvecTD6jcmQ=;
        b=Gmwa5YAOum0X95HupW6Sdby+vYHxO8vdRO4weWBhuFJA7NN3A4fd9JI5hGfuyb2VV4
         Jfevzgu+rNuts3IbeYCX3PstzvllQ7PvfYKcoMC2BDMdn1FetO5bYb9l9OD/1L8IlMIA
         01DXlL5kmhjt8pVAaIiic/0aGK4kRfr3Sf1Cehdorum43uxkhjCYqxmartqA3KoNjmmo
         GnU5n5b+OL0GkMOWckjWiPApsH1CLibztWcX0aFUb1wkPJBScp4mLqfAu91h7550Fi6k
         Ymwqcg5M5kiUdBlHFAzMZx2lBPHfesJhEMh306gTbAFwLGv88RRJ3IIcV2g4igAIe+5J
         L4Ig==
X-Gm-Message-State: AOJu0YwYG9lsmd36XnHqjiv0lVLIOBhjfU148ouLR4Cpv4PSt+ZeALuJ
	5Vpfh2uX8GmFkbx5DEZVlfyx0yZCjs8BQF66RkQy/A==
X-Google-Smtp-Source: AGHT+IGjjh+fWxeo4anfiFOMoaIWtpzw8oF8s8j4lmUc5+wM2iAzeJuvaIXSZNFqXw05ErIllSGqBJYUzHc6H7jFB+k=
X-Received: by 2002:a50:d706:0:b0:53e:7ad7:6d47 with SMTP id
 t6-20020a50d706000000b0053e7ad76d47mr29754edi.5.1698207192107; Tue, 24 Oct
 2023 21:13:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231020204741.1869520-1-namhyung@kernel.org>
In-Reply-To: <20231020204741.1869520-1-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Tue, 24 Oct 2023 21:13:00 -0700
Message-ID: <CAP-5=fWd440mN-tuL-h-9HkeDNcWK8V0jOqBZjXwFb7dhuaWjg@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] perf lock contention: Clear lock addr after use
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-perf-users@vger.kernel.org, Song Liu <song@kernel.org>, 
	Hao Luo <haoluo@google.com>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 20, 2023 at 1:47=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> It checks the current lock to calculated the delta of contention time.
> The address is saved in the tstamp map which is allocated at begining of
> contention and released at end of contention.
>
> But it's possible for bpf_map_delete_elem() to fail.  In that case, the
> element in the tstamp map kept for the current lock and it makes the
> next contention for the same lock tracked incorrectly.  Specificially
> the next contention begin will see the existing element for the task and
> it'd just return.  Then the next contention end will see the element and
> calculate the time using the timestamp for the previous begin.
>
> This can result in a large value for two small contentions happened from
> time to time.  Let's clear the lock address so that it can be updated
> next time even if the bpf_map_delete_elem() failed.
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/bpf_skel/lock_contention.bpf.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/tools/perf/util/bpf_skel/lock_contention.bpf.c b/tools/perf/=
util/bpf_skel/lock_contention.bpf.c
> index 4900a5dfb4a4..b11179452e19 100644
> --- a/tools/perf/util/bpf_skel/lock_contention.bpf.c
> +++ b/tools/perf/util/bpf_skel/lock_contention.bpf.c
> @@ -389,6 +389,7 @@ int contention_end(u64 *ctx)
>
>         duration =3D bpf_ktime_get_ns() - pelem->timestamp;
>         if ((__s64)duration < 0) {
> +               pelem->lock =3D 0;
>                 bpf_map_delete_elem(&tstamp, &pid);
>                 __sync_fetch_and_add(&time_fail, 1);
>                 return 0;
> @@ -422,6 +423,7 @@ int contention_end(u64 *ctx)
>         data =3D bpf_map_lookup_elem(&lock_stat, &key);
>         if (!data) {
>                 if (data_map_full) {
> +                       pelem->lock =3D 0;
>                         bpf_map_delete_elem(&tstamp, &pid);
>                         __sync_fetch_and_add(&data_fail, 1);
>                         return 0;
> @@ -445,6 +447,7 @@ int contention_end(u64 *ctx)
>                                 data_map_full =3D 1;
>                         __sync_fetch_and_add(&data_fail, 1);
>                 }
> +               pelem->lock =3D 0;
>                 bpf_map_delete_elem(&tstamp, &pid);
>                 return 0;
>         }
> @@ -458,6 +461,7 @@ int contention_end(u64 *ctx)
>         if (data->min_time > duration)
>                 data->min_time =3D duration;
>
> +       pelem->lock =3D 0;
>         bpf_map_delete_elem(&tstamp, &pid);
>         return 0;
>  }
> --
> 2.42.0.655.g421f12c284-goog
>

