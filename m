Return-Path: <bpf+bounces-18820-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2012822505
	for <lists+bpf@lfdr.de>; Tue,  2 Jan 2024 23:56:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45E35283FCB
	for <lists+bpf@lfdr.de>; Tue,  2 Jan 2024 22:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB0211772A;
	Tue,  2 Jan 2024 22:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="adbvCft1"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3567917722;
	Tue,  2 Jan 2024 22:56:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 907A8C433AD;
	Tue,  2 Jan 2024 22:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704236201;
	bh=cTTLkJmUd5KEDKlkeLL/giFhyl+3S6zv/Patir4c9RY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=adbvCft1gut8I2XFhx1YZlBA4N9ozFtlcqBOYmTZZrtWuKRPuZK5uAN36x5eDY7dw
	 CTSUda5I+qeWm3D2O0VTnunbP+M6zgYa3ZfiYVg6VkdfxPucrTszHTK84Uql4FYj5T
	 9PLuJgR0DCS8NCj/5TOpBgIeINgmNUtq0ij/UDKW/+ZeV+FBJQdgGtgsbo2yHGO5gu
	 bUXjKrIe222YdEBVtm8tXRHBeoiYOvckoDqJ2yuT3/akyt6ObnuUTE2s60l/iYExFs
	 IiRXhUecMpfVTVr2LuRAV7MrK6daHDiT878jfET+hfuzmK7PAG1bXrV2UL9ioPrHDt
	 /b/rmSV/bTLgg==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-50e7b51b0ceso6298087e87.1;
        Tue, 02 Jan 2024 14:56:41 -0800 (PST)
X-Gm-Message-State: AOJu0YxazJ9HGKhr9lm5JYTUxGbC1DnZSP/tsCWJCYJBSMgksfFWW9PP
	8TfgVhv9loO3rQSKEAadhApbxopydhR1plvY79Y=
X-Google-Smtp-Source: AGHT+IHYKq2FoEpo6VOvI09ucZK2lMO7saDPqyXdSq4MlZkLMJzNI9Ad4vCPSTtypfkwUmgnw7SvkkEvTJYXc+SgOIs=
X-Received: by 2002:a05:6512:4cb:b0:50e:4b79:b825 with SMTP id
 w11-20020a05651204cb00b0050e4b79b825mr67874lfq.20.1704236199757; Tue, 02 Jan
 2024 14:56:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231211045543.31741-1-khuey@kylehuey.com> <20231211045543.31741-3-khuey@kylehuey.com>
 <20231212092221.GB28174@willie-the-truck>
In-Reply-To: <20231212092221.GB28174@willie-the-truck>
From: Song Liu <song@kernel.org>
Date: Tue, 2 Jan 2024 14:56:28 -0800
X-Gmail-Original-Message-ID: <CAPhsuW4JU-D9S8VZfXuGJGy4RxmEMf2=pTwhCo6NRptf8i3x2Q@mail.gmail.com>
Message-ID: <CAPhsuW4JU-D9S8VZfXuGJGy4RxmEMf2=pTwhCo6NRptf8i3x2Q@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] perf/bpf: Remove unneeded uses_default_overflow_handler.
To: Will Deacon <will@kernel.org>
Cc: Kyle Huey <me@kylehuey.com>, Kyle Huey <khuey@kylehuey.com>, linux-kernel@vger.kernel.org, 
	Andrii Nakryiko <andrii.nakryiko@gmail.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Marco Elver <elver@google.com>, 
	Yonghong Song <yonghong.song@linux.dev>, "Robert O'Callahan" <robert@ocallahan.org>, 
	Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, 
	Catalin Marinas <catalin.marinas@arm.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, linux-arm-kernel@lists.infradead.org, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 12, 2023 at 1:22=E2=80=AFAM Will Deacon <will@kernel.org> wrote=
:
>
> On Sun, Dec 10, 2023 at 08:55:41PM -0800, Kyle Huey wrote:
> > Now that struct perf_event's orig_overflow_handler is gone, there's no =
need
> > for the functions and macros to support looking past overflow_handler t=
o
> > orig_overflow_handler.
> >
> > This patch is solely a refactoring and results in no behavior change.
> >
> > Signed-off-by: Kyle Huey <khuey@kylehuey.com>
> > ---
> >  arch/arm/kernel/hw_breakpoint.c   |  8 ++++----
> >  arch/arm64/kernel/hw_breakpoint.c |  4 ++--
> >  include/linux/perf_event.h        | 16 ++--------------
> >  3 files changed, 8 insertions(+), 20 deletions(-)
>
> Acked-by: Will Deacon <will@kernel.org>

Acked-by: Song Liu <song@kernel.org>

