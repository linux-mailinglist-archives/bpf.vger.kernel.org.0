Return-Path: <bpf+bounces-28192-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EEADE8B64FD
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 23:59:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4D001F22849
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 21:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE76E194C70;
	Mon, 29 Apr 2024 21:59:37 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3195D1779BD;
	Mon, 29 Apr 2024 21:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714427977; cv=none; b=mfSzKZGbOtCgBaqdCq5m5LIUR/p8oE8kLWKEAXaA+EYwuo2Ci9TM+nXh4hPjMplWG8xDytlVCZoufIJ1BqB0/H1Ic60b9YB+cJ36RkLs33YkXlqRzr40F8OIwtVvAkzXpcXiR7i0WXkwDhFH3R4Ld3UdTDmkQNbkVmc5m7iBC3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714427977; c=relaxed/simple;
	bh=rWRO8R6xnk+OuFpAl36Z1r6BJDNmfqJ5Xi//0GinZJk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V0Fs3dU6L72rUq7tcP4H4SjzTM6cWWOP4Hi+lg5+y1c3op1TOkTBEj1rPvFYLBBfqcAD/OgFuaAI7zKXyY6dYDxQ+ucvBRjyffi8SXUFxG7IvBceaEU7UaHiohrDsdXNHbMFjt7zWVhEtoJNUaT9HBHU0N6Q+8RWi5poR1oDt7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6ed3cafd766so4534484b3a.0;
        Mon, 29 Apr 2024 14:59:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714427975; x=1715032775;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aNe3S/StQW28fL/SUWajBYlIGZCs7y1KbxaJ6u4cohM=;
        b=cMm+sDuWw2QibzPmZ89nmPV7XoEfq4dsfrZTJGA7wDP6EAB7Dre58rjkHqXj5LPdeq
         PlylSxeOHZ7DJeXx9vlP3PHzA8YeHbcMGPtHgQ1eJs17wfjCjn0DRblWsTWrwnH7ii0R
         c6Ba9OFLtkHEEv05XPjwgy0W89WCS96QXXwekX2AxTT2pp3w83ke+EgU/0xgzyQnSM5L
         kyPIeAui0qzt/nNycHBjjgzVQXxudHHgeinc4MxzJj8p0qITuks+TAKAWZGKbNodhCsh
         NFU2Yuo0FJh/SfvpKT1HFADYv4feq1/LJLJFFIA+5XIAmLp8wXMQ0e6luS0pguHWx4sb
         /u6w==
X-Forwarded-Encrypted: i=1; AJvYcCUCncbh99k0IeHibUfpqW/vKuLfevpiuoAh/LtajNDO4NW2nFLdaEI2Vsns3iJHr+0+v89dNGVns3z2j9Jj9enrG9HTMXf4kh/MoJBleMN2TX+CfqzAGNhecyeFsYko1Rydu5vJiiwjV6BMS+325OxHXjgrB6lOlAmHiXrPwKNuE3gsCA==
X-Gm-Message-State: AOJu0YzymD5+ENKza3r8bQRvBG4Ree1giXE0DYRgqTi3bqyo0jI0xgG9
	FUT8Y1HICfelX8cOjOuASoqlf+pHzC/upC5PBw8siYT5ZS2VKVBCmAQBffQjYTIF7T8BhK/EvJw
	swuxm20mccuKoywr1ZnwMyFFwq4U=
X-Google-Smtp-Source: AGHT+IHH+uSMydzZNnOzbsjOEyfQ5ncz6nNgOUDh6vsHY1oPhWKTz6/cN3vdqNRSEmN+6QRLS2mf5dlvCLlwZCzbkII=
X-Received: by 2002:a05:6a20:7fa0:b0:1a7:aabc:24ae with SMTP id
 d32-20020a056a207fa000b001a7aabc24aemr12260143pzj.18.1714427975509; Mon, 29
 Apr 2024 14:59:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240425220509.1751260-1-yabinc@google.com>
In-Reply-To: <20240425220509.1751260-1-yabinc@google.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Mon, 29 Apr 2024 14:59:23 -0700
Message-ID: <CAM9d7cjQQ3AU7LFXYHEYukwSB9CvFQPtSzg3anfVg=maCP56AA@mail.gmail.com>
Subject: Re: [PATCH] perf/core: Trim dyn_size if raw data is absent
To: Yabin Cui <yabinc@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Yabin,

CC-ing the bpf list.

On Thu, Apr 25, 2024 at 3:05=E2=80=AFPM Yabin Cui <yabinc@google.com> wrote=
:
>
> Currently, perf_tp_event() always allocates space for raw sample data,
> even when the PERF_SAMPLE_RAW flag is not set. This leads to unused
> spaces within generated sample records.
>
> This patch reduces dyn_size when PERF_SAMPLE_RAW is not present,
> ensuring sample records use only the necessary amount of space.

Right, it seems bpf-output and tracepoint events set the flags without
checking PERF_SAMPLE_RAW.  Can you fix the callsites instead?
Or we can add perf_event argument to perf_sample_save_raw_data()
and check the flag inside.

We might reject the output data when it's not opened with the flag.
But I'm afraid it might break some existing BPF programs.

Thanks,
Namhyung

>
> Fixes: 0a9081cf0a11 ("perf/core: Add perf_sample_save_raw_data() helper")
> Signed-off-by: Yabin Cui <yabinc@google.com>
> ---
>  kernel/events/core.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 724e6d7e128f..d68ecdc264d3 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -7688,6 +7688,10 @@ void perf_prepare_sample(struct perf_sample_data *=
data,
>                 data->raw =3D NULL;
>                 data->dyn_size +=3D sizeof(u64);
>                 data->sample_flags |=3D PERF_SAMPLE_RAW;
> +       } else if ((data->sample_flags & ~sample_type) & PERF_SAMPLE_RAW)=
 {
> +               data->dyn_size -=3D data->raw->size + sizeof(u32);
> +               data->raw =3D NULL;
> +               data->sample_flags &=3D ~PERF_SAMPLE_RAW;
>         }
>
>         if (filtered_sample_type & PERF_SAMPLE_BRANCH_STACK) {
> --
> 2.44.0.769.g3c40516874-goog
>

