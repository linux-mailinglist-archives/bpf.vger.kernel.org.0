Return-Path: <bpf+bounces-9706-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ADE2079C663
	for <lists+bpf@lfdr.de>; Tue, 12 Sep 2023 08:00:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 561F428155E
	for <lists+bpf@lfdr.de>; Tue, 12 Sep 2023 06:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D26E171A8;
	Tue, 12 Sep 2023 06:00:18 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB5F28E6
	for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 06:00:17 +0000 (UTC)
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C433E78;
	Mon, 11 Sep 2023 23:00:17 -0700 (PDT)
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-44d48168e2cso1720649137.2;
        Mon, 11 Sep 2023 23:00:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694498416; x=1695103216;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SLhA9tf0heJqm8BqIwdIjIP3qki3/sIyX9kK4EflwYA=;
        b=SgsDcjsGbWhNV271n+DgwC0yi/YGO5qMav+R0ATBpR7/URiaVC2+J1kTERwG0GxPfD
         wBHFEfc5MIrUk/h2Uqgyj0tcqT2J3jy8bJo5l63N17ZZOY2d1pPJ40fluhQnMajVQXc7
         BqVUeiBU0qkmWrgbZRVtNo4jGLHN7YFoEvPgNls8m3ExvN7ueHiZgZHaEEMH9WjBvbEp
         zlSH2Tq7xYNV0qxDnUQpVazlAwb1+JE03QntnAizeeqAsVc0Ly/0AnTgagsgPShmeXZG
         nXrapeU0Mfwh7zpAEf04DWxacSr+OA+kU0aXA9LYm3k/gHnmBeU4TpXbl+2K2q26uW7N
         b1uA==
X-Gm-Message-State: AOJu0YwgVHtii6UnW9q3kS26t1r8Ke/CMTfk8KiRPbDijKRmRM36Y/SQ
	EtdeR2UiXDL1dYhgcNEbJwW3sYzhq0u9LMB4Wak=
X-Google-Smtp-Source: AGHT+IGGt0+1yNFy5ydqrZJtcPvvDNPfr+PsetuD/0i6Ugs3Uy+LGeaKJOIvV68tX3TKNMWOI/HQ+uLGDN5GKz+gZbQ=
X-Received: by 2002:a67:f614:0:b0:44e:93f5:beb6 with SMTP id
 k20-20020a67f614000000b0044e93f5beb6mr11325764vso.29.1694498416546; Mon, 11
 Sep 2023 23:00:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230911170559.4037734-1-irogers@google.com> <20230911170559.4037734-3-irogers@google.com>
In-Reply-To: <20230911170559.4037734-3-irogers@google.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Mon, 11 Sep 2023 23:00:05 -0700
Message-ID: <CAM9d7cgCufCz9ti+j562rf1oNDo3BD7Tdc2bsYijDxBmZBrqFQ@mail.gmail.com>
Subject: Re: [PATCH v1 3/5] perf expr: Make YYDEBUG dependent on doing a debug build
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
> expr-bison.c. These shouldn't be generated when debugging
> isn't enabled.
>
> Signed-off-by: Ian Rogers <irogers@google.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung


> ---
>  tools/perf/util/expr.y | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/tools/perf/util/expr.y b/tools/perf/util/expr.y
> index 6c93b358cc2d..e364790babb5 100644
> --- a/tools/perf/util/expr.y
> +++ b/tools/perf/util/expr.y
> @@ -1,6 +1,8 @@
>  /* Simple expression parser */
>  %{
> +#ifndef NDEBUG
>  #define YYDEBUG 1
> +#endif
>  #include <assert.h>
>  #include <math.h>
>  #include <stdlib.h>
> --
> 2.42.0.283.g2d96d420d3-goog
>

