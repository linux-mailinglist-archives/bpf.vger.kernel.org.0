Return-Path: <bpf+bounces-9707-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5352379C666
	for <lists+bpf@lfdr.de>; Tue, 12 Sep 2023 08:00:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D9662815A7
	for <lists+bpf@lfdr.de>; Tue, 12 Sep 2023 06:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00A8A171A9;
	Tue, 12 Sep 2023 06:00:35 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F4928E6
	for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 06:00:34 +0000 (UTC)
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EA46E6F;
	Mon, 11 Sep 2023 23:00:34 -0700 (PDT)
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-d7260fae148so4720990276.1;
        Mon, 11 Sep 2023 23:00:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694498433; x=1695103233;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uDoTwLrmKoaof/JBEdXQtP7jXktkcDfzwol6kevEdW8=;
        b=IarhDHeF7n5n70eyxZKmlYaKBBcGoWyf0ELfvDj26eLkp+CHXP53hqrf/JyXjDtCsB
         6/H9YrTWiGn6sLeBHUG0za/rWEqpXxHIDzD1G+h9dEXQNc86DBAODbj8KSeQb8FUFHHU
         QBR+oD6GsHPz124Ol6zJnTOjEKT6iFyyTN1I91OINV0q5ePaS0DKuMpu//FnbG8BuvQ4
         2q1O/NiQOrLe8Hpy54hMq2n5NblVl3v7rr3nWT6Y91Bdz1brGwPTc4eCurHGfLRCJ2kZ
         0BpYgyr6sxBmFkcBAj7+s8kCt199tCfxbOi/Ii5wFctNBY79JFMeOvniWQyTc+mjqddZ
         pqPg==
X-Gm-Message-State: AOJu0YyxDQr2SZIj17+8juhl1+DFvvuRmFqY5iVQdOGApugJQc+6zXk3
	/fB+mK9DpZqr7WsNQ0RJLWmf11SZ4zstv0iJyMw=
X-Google-Smtp-Source: AGHT+IEeQqeGHD5ch9foXElxvq/LQHou9Bk52NTpKY74rsmw/sFu7nNbCODY6AX5F8jHKO87v6ruNzIC/O+pWfwD758=
X-Received: by 2002:a25:ab33:0:b0:d05:59cd:a89d with SMTP id
 u48-20020a25ab33000000b00d0559cda89dmr11590307ybi.30.1694498433253; Mon, 11
 Sep 2023 23:00:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230911170559.4037734-1-irogers@google.com> <20230911170559.4037734-4-irogers@google.com>
In-Reply-To: <20230911170559.4037734-4-irogers@google.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Mon, 11 Sep 2023 23:00:22 -0700
Message-ID: <CAM9d7ciY9Od8mLg7Qd2cy+RObH5dCKRe3A-DzVt66QWgzDfdKQ@mail.gmail.com>
Subject: Re: [PATCH v1 4/5] perf pmu: Add YYDEBUG
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	James Clark <james.clark@arm.com>, Gaosheng Cui <cuigaosheng1@huawei.com>, 
	Rob Herring <robh@kernel.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 11, 2023 at 10:06=E2=80=AFAM Ian Rogers <irogers@google.com> wr=
ote:
>
> YYDEBUG enables line numbers and other error helpers in the generated
> pmu-bison.c. Conditionally enabled only for debug builds.
>
> Signed-off-by: Ian Rogers <irogers@google.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung


> ---
>  tools/perf/util/pmu.y | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/tools/perf/util/pmu.y b/tools/perf/util/pmu.y
> index 600c8c158c8e..198907a8a48a 100644
> --- a/tools/perf/util/pmu.y
> +++ b/tools/perf/util/pmu.y
> @@ -5,6 +5,10 @@
>
>  %{
>
> +#ifndef NDEBUG
> +#define YYDEBUG 1
> +#endif
> +
>  #include <linux/compiler.h>
>  #include <linux/list.h>
>  #include <linux/bitmap.h>
> --
> 2.42.0.283.g2d96d420d3-goog
>

