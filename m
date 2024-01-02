Return-Path: <bpf+bounces-18819-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CC9A822504
	for <lists+bpf@lfdr.de>; Tue,  2 Jan 2024 23:56:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0D2EB218F7
	for <lists+bpf@lfdr.de>; Tue,  2 Jan 2024 22:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D411317731;
	Tue,  2 Jan 2024 22:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O97ADtH/"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 608FC17725;
	Tue,  2 Jan 2024 22:56:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B43E5C433CA;
	Tue,  2 Jan 2024 22:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704236176;
	bh=p56agRjSKKcueVcq0lbWdo8QWJunCZKI+nGr/1RWnZE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=O97ADtH/0ZL4RXc3DGoqpfQTzd5jHFbwSmqr3CI42EGJLHJVUVvPy3EOmJS4i+dPj
	 kjrbLpL2u37ZttXBQuv6iWKHLwCpCNg122YIVic805S7Vg8Tdf0FTAGZpaeS6NofmI
	 3zEWiKPcAthIGzuBxJJZy/n9RdsX5H+o14zpAGj6q438qx2D9o+IeAzCABjyxn5uxH
	 EWWm6FofJ1aUQAtYdnY9p0X0iFsDvRkK2JZ36ElZdxNkJyw51RoQRUiJw4QKV/A+PO
	 4Hz/tAr9QxfNfDkgYD2nQdwuPtTar+bQ/pA2FIe9Q3dL+YPqhs8G3YzbZm4UPAQvON
	 MNKkalq2odgsw==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-50e80d40a41so7587404e87.1;
        Tue, 02 Jan 2024 14:56:16 -0800 (PST)
X-Gm-Message-State: AOJu0Yze8a4kwssiEkeogQEe/jaSIX7+I0kN3gZVj5i44AgaN5w69Ofa
	bZOTIwmVY5O42b4YAgxb2Ex31fUZV/19fCMiNE4=
X-Google-Smtp-Source: AGHT+IH6y1y1oMGuZDAR00hO0U/xTUP9x4e0Dks+Zd8ibcKe06uba2fLJN8WCHHPYHntmEhkyDoGmNTol/lkfbhr7CM=
X-Received: by 2002:a19:6550:0:b0:50e:30b3:b8ff with SMTP id
 c16-20020a196550000000b0050e30b3b8ffmr6957406lfj.16.1704236174949; Tue, 02
 Jan 2024 14:56:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231211045543.31741-1-khuey@kylehuey.com> <20231211045543.31741-2-khuey@kylehuey.com>
In-Reply-To: <20231211045543.31741-2-khuey@kylehuey.com>
From: Song Liu <song@kernel.org>
Date: Tue, 2 Jan 2024 14:56:03 -0800
X-Gmail-Original-Message-ID: <CAPhsuW6VqD=zie6Y6JPALp3egMSYWF6UysS+bQG_61t=6v4fxQ@mail.gmail.com>
Message-ID: <CAPhsuW6VqD=zie6Y6JPALp3egMSYWF6UysS+bQG_61t=6v4fxQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] perf/bpf: Call bpf handler directly, not through
 overflow machinery
To: Kyle Huey <me@kylehuey.com>
Cc: Kyle Huey <khuey@kylehuey.com>, linux-kernel@vger.kernel.org, 
	Andrii Nakryiko <andrii.nakryiko@gmail.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Marco Elver <elver@google.com>, 
	Yonghong Song <yonghong.song@linux.dev>, "Robert O'Callahan" <robert@ocallahan.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, linux-perf-users@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 10, 2023 at 8:55=E2=80=AFPM Kyle Huey <me@kylehuey.com> wrote:
>
> To ultimately allow bpf programs attached to perf events to completely
> suppress all of the effects of a perf event overflow (rather than just th=
e
> sample output, as they do today), call bpf_overflow_handler() from
> __perf_event_overflow() directly rather than modifying struct perf_event'=
s
> overflow_handler. Return the bpf program's return value from
> bpf_overflow_handler() so that __perf_event_overflow() knows how to
> proceed. Remove the now unnecessary orig_overflow_handler from struct
> perf_event.
>
> This patch is solely a refactoring and results in no behavior change.
>
> Signed-off-by: Kyle Huey <khuey@kylehuey.com>
> Suggested-by: Namhyung Kim <namhyung@kernel.org>

Acked-by: Song Liu <song@kernel.org>

