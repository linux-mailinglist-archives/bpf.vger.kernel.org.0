Return-Path: <bpf+bounces-47157-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C80EC9F5BE7
	for <lists+bpf@lfdr.de>; Wed, 18 Dec 2024 01:54:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0895188D77B
	for <lists+bpf@lfdr.de>; Wed, 18 Dec 2024 00:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5341B2628D;
	Wed, 18 Dec 2024 00:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G2lrcLtH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548DC2572
	for <bpf@vger.kernel.org>; Wed, 18 Dec 2024 00:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734483273; cv=none; b=kjuIOmgOttUBPVnvW01Eiplvzrdg8NvxrXpvT4BU6wx2OQ8NwMS2J//muyVl8oa1ai5RNDF/P1uhKxnOhAlHtQs0glwb+qVyJX9PLzqEzeQQPTXfeISk/QyhpEkG4zw8bbeHdhHZOZ+2HKqTMcACjNtLg6O9V7zOXZ5fuxlgfUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734483273; c=relaxed/simple;
	bh=qFEUHjYFyVbDhNvjgUDJOz711mZJCKiTyV+OT2JsO2I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tNsUjPMNgH3ExlWWRqWrROGZ9/0/P5WSy88mZdIEnBaH5NzzmKsy2E8WZgwM3zM2ny8rFNuBHi2u0H6pclooaJ07j6gjDlbgn6Vv6m4iw4nvx+A2cuevqqMGn5TKTmT0DEDB8kvciXX7ZRQiY6ywzXcroZYxuu4z72MMWMCsZCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G2lrcLtH; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3a9d0c28589so52265ab.0
        for <bpf@vger.kernel.org>; Tue, 17 Dec 2024 16:54:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734483271; x=1735088071; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vvpdmlnbvNyjwHZf76pbDfjmJncAJiI50qIYmlkFWhs=;
        b=G2lrcLtHoNxdC0KsVOv46UDh5pfwEJgMdLPc72rj5COGyH1pJ/9J9VkG8j9qL9cSbO
         QdsLMwo2H9yKWyy25jgDSGInmL6Kird+QWaXRGJs11RLPjqsLfoVsBLtZIFrahHks5ze
         v3HABMVCkDbpAviAXLu2ENr5eaE2/dTG68ckChb4e60htzU47X0fwW0Sh4ryeM6psKcZ
         Q9rkMTDp5qhNAxOYl3VtUT0tcdYpKnuThzsl7i073HSb74qTo7X519Sx1rOMrrWt2M7k
         yzsE/qNMss1JkhHaVGZRcQBujTJdYj0NxxoRMandQPTPk9QEyux1H+ajxYYfP1i/LRIc
         Meig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734483271; x=1735088071;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vvpdmlnbvNyjwHZf76pbDfjmJncAJiI50qIYmlkFWhs=;
        b=Y8LYmUnbMtcSCwJ88YyvfTptQGN4zXl2kpAGJ/Nt8oB7YncXYY4KkxqGgnDTOhyUxp
         /kXqIw+dKS+wUT8qxLIIvIAv6PrReaqcqtYjukZGWbpKZvsFW2VTyvbWO8AQ/2gqgLNm
         uJnYqgdfFThyd/5dBfJaO1voeZAIGz+wBjdJ2Z2wV/kSpY+zPvwzHw9pLuQX3gNg3vbH
         Ao2TCGdAZofhrbPCLiVChK7ve9Q9GilMu9Mxxhod+enhFoQrqAV8u9KWj6Ms9CrnUFlR
         c2uwAc8fuK/ToQ9NJcILMjZBuSkQCzR2UpxxXn6k2/uWjzb1YoKcXbCn3hHMdxr+o8Rq
         2Mbg==
X-Forwarded-Encrypted: i=1; AJvYcCWoBVPu96rcuOajKmq4CtlRYODbe4CdAo1JNQwWosy/MidF+BWwWjurgZlMEc3yqdi+xv4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6dx5+NnItCHdT0g2h3Y3Uajlfq+hUqdNkHVbGHnZBoyERLB2O
	CjPZSfh2W/6vnWMQKNHkta0CQQojzaD/0is9jkbTMJIbjLEJnTWwagy7PWvXLRvxmf/55bYdvj9
	u6oF8AqUfRshv6QEgijIftz7aGmAJuPJ0yEot
X-Gm-Gg: ASbGncujne5v1zhIJ+HtnpbGGy8D9WWX67rZTOt6//FYxEj0N3VAqAmICqlmJ5gBqUX
	iefLjc2nhXAe4YOxDMALvgEvaAy0AANs5nyyLrUQ=
X-Google-Smtp-Source: AGHT+IEoTRmSrfTLob8bBnU0BLl9Mr4cn15d1XMTSUV5F1B2wnA9XXGqLTQNrwEm5b7QOJKp0qMAP56nopgrXwZmSjc=
X-Received: by 2002:a05:6e02:3c88:b0:3a7:c962:95d1 with SMTP id
 e9e14a558f8ab-3be34c58afamr427125ab.5.1734483271260; Tue, 17 Dec 2024
 16:54:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241217115610.371755-1-james.clark@linaro.org> <20241217115610.371755-6-james.clark@linaro.org>
In-Reply-To: <20241217115610.371755-6-james.clark@linaro.org>
From: Ian Rogers <irogers@google.com>
Date: Tue, 17 Dec 2024 16:54:19 -0800
Message-ID: <CAP-5=fU7RNzvzxBcAQy3RT9Ge3YtqPhDonupNWS7Wgb8HGQkGg@mail.gmail.com>
Subject: Re: [PATCH 5/5] perf docs: arm_spe: Document new discard mode
To: James Clark <james.clark@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, "Liang, Kan" <kan.liang@linux.intel.com>, 
	John Garry <john.g.garry@oracle.com>, Mike Leach <mike.leach@linaro.org>, 
	Leo Yan <leo.yan@linux.dev>, Graham Woodward <graham.woodward@arm.com>, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 17, 2024 at 3:56=E2=80=AFAM James Clark <james.clark@linaro.org=
> wrote:
>
> Document the flag, hint what it's used for and give an example with
> other useful options to get minimal output.
>
> Signed-off-by: James Clark <james.clark@linaro.org>
> ---
>  tools/perf/Documentation/perf-arm-spe.txt | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/tools/perf/Documentation/perf-arm-spe.txt b/tools/perf/Docum=
entation/perf-arm-spe.txt
> index de2b0b479249..588eead438bc 100644
> --- a/tools/perf/Documentation/perf-arm-spe.txt
> +++ b/tools/perf/Documentation/perf-arm-spe.txt
> @@ -150,6 +150,7 @@ arm_spe/load_filter=3D1,min_latency=3D10/'
>    pct_enable=3D1        - collect physical timestamp instead of virtual =
timestamp (PMSCR.PCT) - requires privilege
>    store_filter=3D1      - collect stores only (PMSFCR.ST)
>    ts_enable=3D1         - enable timestamping with value of generic time=
r (PMSCR.TS)
> +  discard=3D1           - enable SPE PMU events but don't collect sample=
 data - see 'Discard mode' (PMBLIMITR.FM =3D DISCARD)
>
>  +++*+++ Latency is the total latency from the point at which sampling st=
arted on that instruction, rather
>  than only the execution latency.
> @@ -220,6 +221,16 @@ Common errors
>
>     Increase sampling interval (see above)
>
> +Discard mode
> +~~~~~~~~~~~~
> +
> +SPE PMU events can be used without the overhead of collecting sample dat=
a if
> +discard mode is supported (optional from Armv8.6). First run a system wi=
de SPE
> +session (or on the core of interest) using options to minimize output. T=
hen run
> +perf stat:
> +
> +  perf record -e arm_spe/discard/ -a -N -B --no-bpf-event -o - > /dev/nu=
ll &
> +  perf stat -e SAMPLE_FEED_LD

Perhaps clarify this should be an ARM SPE event? It seems strange to
have one perf command affect a later one, the purpose of things like
event multiplexing is to hide the hardware limits. I'd prefer if the
last bit was like:
```
Then run perf stat with an SPE event on the same PMU:

perf record -e arm_spe/discard/ -a -N -B --no-bpf-event -o - > /dev/null &
perf stat -e arm_spe/SAMPLE_FEED_LD/
``

Thanks,
Ian

