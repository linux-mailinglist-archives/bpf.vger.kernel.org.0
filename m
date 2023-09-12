Return-Path: <bpf+bounces-9708-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 783BC79C669
	for <lists+bpf@lfdr.de>; Tue, 12 Sep 2023 08:00:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 334BF28156F
	for <lists+bpf@lfdr.de>; Tue, 12 Sep 2023 06:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 681B9171AA;
	Tue, 12 Sep 2023 06:00:49 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2290728E6
	for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 06:00:49 +0000 (UTC)
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0AB5AF;
	Mon, 11 Sep 2023 23:00:48 -0700 (PDT)
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-d80089712e5so6199951276.1;
        Mon, 11 Sep 2023 23:00:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694498448; x=1695103248;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VUILU1E0+FdlFdLUANe6gniGaPM89l1IGPrpgMyRN5I=;
        b=IRltfIMM1TXrcViGkNG/VK96IsT8nn517HsTaBAcVNPZhllEPrcf5LpVyrV/16Ejb6
         0Zo39/6wnk59EIQKH4ys6UGC4QNP9YB/5pLtLQkQskPVWYUBhtWglNJB8kz+uMbIT/4Q
         I3qm401yQCQN6rRVbmO/iasgbO3/LDhaS+GtlROGx2JPACVdDAkCEzOAcRc3B7TuUsS1
         /5da9rKMNpSKgqCE6vVDd41NgR6cgGxN8oslTgAN+v1RLSRPjbtZsN/BCu/txU3xk49u
         wLF3QkXD/WVLedc2CdezxKcGGP4hqhRnvqKMFH2TiiFdXzeqUjynYQ5SZYeDiCGnCkAf
         OmZA==
X-Gm-Message-State: AOJu0Yzor37LZBmzTkYR9Nc1wza50RF/2dgkX7k/7V4sWeVUKiCa1H7p
	zTaW9/70N0oP5GihcozBs2a4DV6zZM6nVY6+RSYb22S2hk0=
X-Google-Smtp-Source: AGHT+IF/lQdOP9qBizGBb21/Z1f2teVHR7FJHFpnrBDMARdoZAr7FlCDkEC5rQJErcxnOmRKhjLH+VTclPBLLqIxCAI=
X-Received: by 2002:a25:dc11:0:b0:d09:22c0:138d with SMTP id
 y17-20020a25dc11000000b00d0922c0138dmr2062829ybe.7.1694498447808; Mon, 11 Sep
 2023 23:00:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230911170559.4037734-1-irogers@google.com> <20230911170559.4037734-5-irogers@google.com>
In-Reply-To: <20230911170559.4037734-5-irogers@google.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Mon, 11 Sep 2023 23:00:36 -0700
Message-ID: <CAM9d7cjj9V+tmrF_=8YgnxiLVGcGYKLZ-4pNgEgQM+3XSCHrsQ@mail.gmail.com>
Subject: Re: [PATCH v1 5/5] perf bpf-filter: Add YYDEBUG
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
> bpf-filter-bison.c. Conditionally enabled only for debug builds.
>
> Signed-off-by: Ian Rogers <irogers@google.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung


> ---
>  tools/perf/util/bpf-filter.y | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/tools/perf/util/bpf-filter.y b/tools/perf/util/bpf-filter.y
> index 5dfa948fc986..0e4d6de3c2ad 100644
> --- a/tools/perf/util/bpf-filter.y
> +++ b/tools/perf/util/bpf-filter.y
> @@ -3,6 +3,10 @@
>
>  %{
>
> +#ifndef NDEBUG
> +#define YYDEBUG 1
> +#endif
> +
>  #include <stdio.h>
>  #include <string.h>
>  #include <linux/compiler.h>
> --
> 2.42.0.283.g2d96d420d3-goog
>

