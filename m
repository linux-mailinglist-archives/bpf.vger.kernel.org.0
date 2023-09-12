Return-Path: <bpf+bounces-9705-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B38779C661
	for <lists+bpf@lfdr.de>; Tue, 12 Sep 2023 08:00:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C91E1281559
	for <lists+bpf@lfdr.de>; Tue, 12 Sep 2023 06:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F07B7171A9;
	Tue, 12 Sep 2023 05:59:59 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D5E28E6
	for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 05:59:59 +0000 (UTC)
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F085E6F;
	Mon, 11 Sep 2023 22:59:59 -0700 (PDT)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-5925e580e87so50235047b3.1;
        Mon, 11 Sep 2023 22:59:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694498398; x=1695103198;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YUW3PBCAleAS9w3cdUEQTVpKbtiKssCpvnhKjHCXuM8=;
        b=TUD0VYPmgDvbLI0gy6/dWoxe8BmOlSNbLV2Db504Nkrc5zvXSrRNt4mbQompyEu7vY
         JY3Sh3+r9pjBzCIu3/znl3nBO32J/kLqz1U8RQpfN+dA6ttkO2a836AmAwubfjgmA1cm
         +Toghc1M5Uf2ubmN1Hz0jeOLUIOzZk4CAZnUCr+goBfiG21kr4lw3cyY1P4ys3fJ4Lpr
         Ocn8SCBD1F9qpyDHXnbI+H9JNFaUVJRyvz36jiJ8++q7IDxn0dnoWVzNsJyenr9tY5BH
         fVzAPESn7NSD6NkxxC1D6WtRiO8qi0AlKEaV4u9tew6VDHNoDP1FMnm5kBXeNODGOl9l
         8Azg==
X-Gm-Message-State: AOJu0YyxioXJ5gFJ2+VI0AuZaYisQRKsnTLGt354IsFCmIMnAvp/6AKm
	78CmIhgsSyFPeVz2jl48+HkaE234BA1O79e8ljg=
X-Google-Smtp-Source: AGHT+IEoHNMCHJZyv/uNV5Dj5rKhAEBidmiXQtHUVx5URAcQAqVPTLI/nlQs96VcgrF5crO5El6mX65aKktVUU0Xaec=
X-Received: by 2002:a25:a403:0:b0:d77:ff96:66ae with SMTP id
 f3-20020a25a403000000b00d77ff9666aemr9403254ybi.50.1694498398172; Mon, 11 Sep
 2023 22:59:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230911170559.4037734-1-irogers@google.com> <20230911170559.4037734-2-irogers@google.com>
In-Reply-To: <20230911170559.4037734-2-irogers@google.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Mon, 11 Sep 2023 22:59:47 -0700
Message-ID: <CAM9d7cjDnATz-U60DiZr24rMZ-RPgOdf84Et_1XPwSE4qyk8ag@mail.gmail.com>
Subject: Re: [PATCH v1 2/5] perf parse-events: Make YYDEBUG dependent on doing
 a debug build
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
> parse-events-bison.c. These shouldn't be generated when debugging
> isn't enabled.
>
> Signed-off-by: Ian Rogers <irogers@google.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung


> ---
>  tools/perf/util/parse-events.y | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-event=
s.y
> index ef03728b7ea3..786393106ae6 100644
> --- a/tools/perf/util/parse-events.y
> +++ b/tools/perf/util/parse-events.y
> @@ -6,7 +6,9 @@
>
>  %{
>
> +#ifndef NDEBUG
>  #define YYDEBUG 1
> +#endif
>
>  #include <errno.h>
>  #include <linux/compiler.h>
> --
> 2.42.0.283.g2d96d420d3-goog
>

