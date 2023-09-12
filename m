Return-Path: <bpf+bounces-9703-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E8A279C65D
	for <lists+bpf@lfdr.de>; Tue, 12 Sep 2023 07:58:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 087FC281603
	for <lists+bpf@lfdr.de>; Tue, 12 Sep 2023 05:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 202FB171A5;
	Tue, 12 Sep 2023 05:58:31 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E77AA28E6
	for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 05:58:30 +0000 (UTC)
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E9A2E6F;
	Mon, 11 Sep 2023 22:58:30 -0700 (PDT)
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-d776e1f181bso4550363276.3;
        Mon, 11 Sep 2023 22:58:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694498309; x=1695103109;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IzNC+0OhuunUarOHTZE8fkSETZJ/UvD+n1Tp93c3ctM=;
        b=GYKTrGyW5Iz4sVTwCK/xif4HvPFXCwSDU3/9D+7bq68HGYDfzvSfTFsbf+jSTSbsaA
         COKC6otVZ739Q3vRv1Yp6JEpgKcJlKpAnBCdNDVhUCCyURWz50p6YrK3OOGrxyQqAefW
         Cxj5Y3OU7Di/w4G5O9iUBsnj7KJt1y+dw7Llmp6NITFVuru1rPlt85foep1w/hUxXmZ/
         uWg1cB+OuVwe44EL+aiBFgAAgH/eai8TxLa9zfwm/QttTycvjLV58+ATBlbn5ujwHYj4
         u4Bp0mfb3FelAj0YqEfeSiN46GweJuyScqM+qYmdwCT2M+XcC6n08kWLw1dUbzxOk3Rl
         Pmpw==
X-Gm-Message-State: AOJu0YyXTuPehnKkuYqynt44M0Vxezfh/dNtFScnn/ya0TdI4fJrnSug
	7OR6/liVjKKWBJV46JC98IpbwydyqGQ/YNzPtjOKtqIO
X-Google-Smtp-Source: AGHT+IGqk2pHdFI97hJjtxdveBCMtzd46ihdDOdI5NFuC2aGoVGOHFQcmDZVzP8sL9zzjHf3Mv01sD/ZXnUL4OTKTLw=
X-Received: by 2002:a25:cc4c:0:b0:d7f:374b:638c with SMTP id
 l73-20020a25cc4c000000b00d7f374b638cmr12389850ybf.14.1694498309407; Mon, 11
 Sep 2023 22:58:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230911170559.4037734-1-irogers@google.com>
In-Reply-To: <20230911170559.4037734-1-irogers@google.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Mon, 11 Sep 2023 22:58:18 -0700
Message-ID: <CAM9d7cg4nc5rpW9jL-RPJP7w4Rg8h7t4A-EkHTE9rWF=Nm6bBQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/5] perf parse-events: Remove unused header files
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
> The fnmatch header is now used in the PMU matching logic in pmu.c.
>
> Signed-off-by: Ian Rogers <irogers@google.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

> ---
>  tools/perf/util/parse-events.y | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-event=
s.y
> index 21bfe7e0d944..ef03728b7ea3 100644
> --- a/tools/perf/util/parse-events.y
> +++ b/tools/perf/util/parse-events.y
> @@ -9,11 +9,8 @@
>  #define YYDEBUG 1
>
>  #include <errno.h>
> -#include <fnmatch.h>
> -#include <stdio.h>
>  #include <linux/compiler.h>
>  #include <linux/types.h>
> -#include <linux/zalloc.h>
>  #include "pmu.h"
>  #include "pmus.h"
>  #include "evsel.h"
> --
> 2.42.0.283.g2d96d420d3-goog
>

