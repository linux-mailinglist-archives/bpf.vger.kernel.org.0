Return-Path: <bpf+bounces-8660-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CBE8E788D66
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 18:48:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12D8628163F
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 16:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE25117ADB;
	Fri, 25 Aug 2023 16:48:10 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941E01079A
	for <bpf@vger.kernel.org>; Fri, 25 Aug 2023 16:48:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E72FCC433CB;
	Fri, 25 Aug 2023 16:48:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692982088;
	bh=Q79LYCwbEEcZzJqxzYl+4FUzvrTxSOie7i/yZqWDwTg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ie6Wt0NkLp4XAfqT8VvcAYFfUBhnLm5nzQ48i4VMlrJGX7NpUq5fOg5we1JlSjzD5
	 MyJuy95XrB6ooDD6qqTPgij00M+A/QzdsFyrizv+t1vr6noCySNUecSmMGs0WoVV4Y
	 f+RV1G19RrXva7PAAXzYZbsQGi2JnXwPCUS0UEhxToCieRvPGOXdpw3lg0sn8pFTXq
	 2b4Ckdb8kyjuWV4G+tizpktEIh7lmD+xzPrB2a4MVcEWP/187gJCbbGjZ61S6ILdR6
	 XkGBKEzoolYOoONor6LiupuQvDlX0C6LFZTPIK/9avxW5Uz28FeUNmftMTFWlK9+UF
	 04upIMvDHz66A==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-500913779f5so1738506e87.2;
        Fri, 25 Aug 2023 09:48:08 -0700 (PDT)
X-Gm-Message-State: AOJu0YxRnM9npOYCr4w/0l/pyjh6jgLaBMkeNCOPLtV0g2IhplIcoccA
	IA01jxZhHQJ9kXAFRqvMY/0XC+H7axVSWUleQ2M=
X-Google-Smtp-Source: AGHT+IGSW1A8/Tpphe6fWlm78FsnJvvdIjMAO9DAAkWifGczRpLUkAreq1u3GY30U9ATT7TcYLzs5/MPKUSkjKXR1v4=
X-Received: by 2002:a19:e058:0:b0:4ff:b830:4b69 with SMTP id
 g24-20020a19e058000000b004ffb8304b69mr11319015lfj.6.1692982086875; Fri, 25
 Aug 2023 09:48:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230825164152.165610-1-namhyung@kernel.org> <20230825164152.165610-2-namhyung@kernel.org>
In-Reply-To: <20230825164152.165610-2-namhyung@kernel.org>
From: Song Liu <song@kernel.org>
Date: Fri, 25 Aug 2023 09:47:54 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5u8Rd4XVF27eeW7CPhAdSF+wfnxKwWRnYPDsXV=_9_aA@mail.gmail.com>
Message-ID: <CAPhsuW5u8Rd4XVF27eeW7CPhAdSF+wfnxKwWRnYPDsXV=_9_aA@mail.gmail.com>
Subject: Re: [PATCH 2/3] perf test: Fix perf stat bpf counters test on Intel
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 25, 2023 at 9:41=E2=80=AFAM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> As of now, bpf counters (bperf) don't support event groups.  But the
> default perf stat includes topdown metrics if supported (on recent Intel
> machines) which require groups.  That makes perf stat exiting.
>
>   $ sudo perf stat --bpf-counter true
>   bpf managed perf events do not yet support groups.
>
> Actually the test explicitly uses cycles event only, but it missed to
> pass the option when it checks the availability of the command.
>
> Fixes: 2c0cb9f56020d ("perf test: Add a shell test for 'perf stat --bpf-c=
ounters' new option")
> Cc: stable@vger.kernel.org
> Cc: Song Liu <song@kernel.org>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Reviewed-by: Song Liu <song@kernel.org>

Thanks!
Song

> ---
>  tools/perf/tests/shell/stat_bpf_counters.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/tests/shell/stat_bpf_counters.sh b/tools/perf/tes=
ts/shell/stat_bpf_counters.sh
> index 513cd1e58e0e..a87bb2814b4c 100755
> --- a/tools/perf/tests/shell/stat_bpf_counters.sh
> +++ b/tools/perf/tests/shell/stat_bpf_counters.sh
> @@ -22,10 +22,10 @@ compare_number()
>  }
>
>  # skip if --bpf-counters is not supported
> -if ! perf stat --bpf-counters true > /dev/null 2>&1; then
> +if ! perf stat -e cycles --bpf-counters true > /dev/null 2>&1; then
>         if [ "$1" =3D "-v" ]; then
>                 echo "Skipping: --bpf-counters not supported"
> -               perf --no-pager stat --bpf-counters true || true
> +               perf --no-pager stat -e cycles --bpf-counters true || tru=
e
>         fi
>         exit 2
>  fi
> --
> 2.42.0.rc1.204.g551eb34607-goog
>

