Return-Path: <bpf+bounces-41455-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4C879972DE
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 19:19:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 025EC1C20D71
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 17:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B0271D27A5;
	Wed,  9 Oct 2024 17:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X+4JQTBY"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC5013F43A;
	Wed,  9 Oct 2024 17:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728494336; cv=none; b=PRK9wFAnGVPeubBwwQ+EFkgfDYYLogl4ZJpsO4oEkIclM6NczmzzxR+nj6zr/H4ICbkRIA4/Mw3amnEA/Z/s0q5YW8sbZLuY0LJelSmx+7gnT8Qk2Gbp9RxdFFC+bSZulUsHdS9K55xUqzgOxN65Ze6wINz2vwwNe8dquSFVnqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728494336; c=relaxed/simple;
	bh=kIETc19XyvfPXak3jYGzq8Y6vHynD/hT0YCmQOmgqDk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tL8hWVtwefnqtb4NXnVAVTr9EF6BEi0wcM3SHsskTpk/Q91gBW52orzaJ1FLREaXjwSvnWpdA1nGQws8YM+RX7Pq0Lf7a7gjTg3SC79Uf4G6ppp7soo8osvxYS6YK/Qt+YucGhHmkbk8sBKDQ9oFmwQVOEMZcDShmYooNlXQbok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X+4JQTBY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 626B3C4CEC3;
	Wed,  9 Oct 2024 17:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728494336;
	bh=kIETc19XyvfPXak3jYGzq8Y6vHynD/hT0YCmQOmgqDk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=X+4JQTBYh/MZYKPrUB2onNKZJfK1pzUXul4h8Acf7ITMvKBXNLq4cag+SGf/sITBK
	 IY5rV02QZ71t6cItRlnfE8ddNH3r1XhWMdAV/st0r44XkRHB1QmQP2G2DhDkhEp52L
	 DjzQcM5BRnc268elJR28X6r9DFvEVdrvC+5DweLT0Q0EhYqvJ4npW5myvdXucvlH1B
	 Z/5ueOO43kvCX46YvndlslYVPlYoDHjPePUs6s6gY6rZxpuKwXnBi9ULhij0FGMJ/4
	 IAvqMaHvzNmrRbGKqSyrR9u0xjFjwUGrnlMX+NDEX2dBRMyodK83t6zOJY6E/8Rayi
	 dh1avwk97UaTw==
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3a377534e00so363775ab.3;
        Wed, 09 Oct 2024 10:18:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUYQJVoGhCa3DMzD0cXSXEw1HZf5jPM1FE9zx6PWljv4L/rXxf3N+aHlxzczV0gBPqQ32rNIR9VHhnLvOj/@vger.kernel.org, AJvYcCUskU2KL17cVEVdmZQdhtw2DYyexThdZ1f3YNFESL119CEDt8GMbFBZAi/FYi1g43UltjBaIBRaG9Gy8DcdzJfgiQ==@vger.kernel.org, AJvYcCV/hzDnJA0oI3f3jWtcZWEKy1LMWICoWsTlI6I05xOC/Fdr0csgdc5uPBbM0ftdjKJ6Y3o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOrwxXy2PlrdLR2shQUGPi2Vq3nCshCv52inHBluwZsodq3XA1
	eXHEpAsg8UBq9Iqj/iTEIIJ7iMNGqm0udtjTF3CGfW6P8pYPa/w7K8cx6WdECwPCk9nqlj3oN6m
	npFPFPkDxdB4+nUJtGko8ZEXoJGE=
X-Google-Smtp-Source: AGHT+IHYKr3MtibCuhIfqINOiTac2JFiK0PnnYE1ex6z3e1u0veE0fV/hQ/P6tHKnKexhifdFdAhk3wCzVAOyKmCuOE=
X-Received: by 2002:a92:ca0a:0:b0:3a1:a163:ba58 with SMTP id
 e9e14a558f8ab-3a397d1d064mr37851245ab.26.1728494335811; Wed, 09 Oct 2024
 10:18:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240916014318.267709-1-wutengda@huaweicloud.com> <20240916014318.267709-2-wutengda@huaweicloud.com>
In-Reply-To: <20240916014318.267709-2-wutengda@huaweicloud.com>
From: Song Liu <song@kernel.org>
Date: Wed, 9 Oct 2024 10:18:44 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6wrwcMYLufVfu-R9OzPBfspJD0w-pZUr68UBRSZExc=A@mail.gmail.com>
Message-ID: <CAPhsuW6wrwcMYLufVfu-R9OzPBfspJD0w-pZUr68UBRSZExc=A@mail.gmail.com>
Subject: Re: [PATCH -next v3 1/2] perf stat: Support inherit events during
 fork() for bperf
To: Tengda Wu <wutengda@huaweicloud.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Namhyung Kim <namhyung@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, kan.liang@linux.intel.com, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 15, 2024 at 6:53=E2=80=AFPM Tengda Wu <wutengda@huaweicloud.com=
> wrote:
>
> bperf has a nice ability to share PMUs, but it still does not support
> inherit events during fork(), resulting in some deviations in its stat
> results compared with perf.
>
> perf stat result:
> $ ./perf stat -e cycles,instructions -- ./perf test -w sqrtloop
>
>    Performance counter stats for './perf test -w sqrtloop':
>
>        2,316,038,116      cycles
>        2,859,350,725      instructions
>
>          1.009603637 seconds time elapsed
>
>          1.004196000 seconds user
>          0.003950000 seconds sys
>
> bperf stat result:
> $ ./perf stat --bpf-counters -e cycles,instructions -- \
>       ./perf test -w sqrtloop
>
>    Performance counter stats for './perf test -w sqrtloop':
>
>           18,762,093      cycles
>           23,487,766      instructions
>
>          1.008913769 seconds time elapsed
>
>          1.003248000 seconds user
>          0.004069000 seconds sys
>
> In order to support event inheritance, two new bpf programs are added
> to monitor the fork and exit of tasks respectively. When a task is
> created, add it to the filter map to enable counting, and reuse the
> `accum_key` of its parent task to count together with the parent task.
> When a task exits, remove it from the filter map to disable counting.
>
> After support:
> $ ./perf stat --bpf-counters -e cycles,instructions -- \
>       ./perf test -w sqrtloop
>
>  Performance counter stats for './perf test -w sqrtloop':
>
>      2,316,252,189      cycles
>      2,859,946,547      instructions
>
>        1.009422314 seconds time elapsed
>
>        1.003597000 seconds user
>        0.004270000 seconds sys
>
> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>

The solution looks good to me. Question on the UI: do we always
want the inherit behavior from PID and TGID monitoring? If not,
maybe we should add a flag for it. (I think we do need the flag).

One nitpick below.

Thanks,
Song

[...]
>
> +struct bperf_filter_value {
> +       __u32 accum_key;
> +       __u8 exited;
> +};
nit:
Can we use a special value of accum_key to replace exited=3D=3D1
case?

> +
>  #endif /* __BPERF_STAT_U_H */
> --
> 2.34.1
>

