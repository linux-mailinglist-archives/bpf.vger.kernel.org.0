Return-Path: <bpf+bounces-17495-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B62BC80E771
	for <lists+bpf@lfdr.de>; Tue, 12 Dec 2023 10:22:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E60181C20D34
	for <lists+bpf@lfdr.de>; Tue, 12 Dec 2023 09:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC2C6584DA;
	Tue, 12 Dec 2023 09:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c/psbpJY"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530EF58137;
	Tue, 12 Dec 2023 09:22:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 031C3C433C9;
	Tue, 12 Dec 2023 09:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702372948;
	bh=y2xsGb6RdvYsGGAGFOAQIzQJ6okr5i37jR6Lpnt+43M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c/psbpJYEtYuZTuyXHJYvdka47RF94LB1JwEiJqaCq8YO02yaAkQwWAA6h6sm65Lv
	 uwGeEhiMRXz+lJNZeFdSCV76zkKw7BPgKub/g+75bZp4L80iJt+p8M+b0Ob24tCD6R
	 aXxO3B6ajO10HKbB8POwK6y7BybkjlF/eYo6HrJ8WZTz7OjSMKig1CISScmJrtO4fp
	 wyha1ZLLOrlVb1fjkO+06DypQiRhFyVNNHC22SXwNsN4wWn4rJyUcxyx8tmzbYXOtf
	 3/nU8Kq9P3sNAFejXy1tEzei4kSSVvIfd10FYKemXQxLDeqJFd3vzh3/2zr6kjER9q
	 U8PY9Ra9FA2WA==
Date: Tue, 12 Dec 2023 09:22:21 +0000
From: Will Deacon <will@kernel.org>
To: Kyle Huey <me@kylehuey.com>
Cc: Kyle Huey <khuey@kylehuey.com>, linux-kernel@vger.kernel.org,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	Marco Elver <elver@google.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Robert O'Callahan <robert@ocallahan.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v3 2/4] perf/bpf: Remove unneeded
 uses_default_overflow_handler.
Message-ID: <20231212092221.GB28174@willie-the-truck>
References: <20231211045543.31741-1-khuey@kylehuey.com>
 <20231211045543.31741-3-khuey@kylehuey.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231211045543.31741-3-khuey@kylehuey.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Sun, Dec 10, 2023 at 08:55:41PM -0800, Kyle Huey wrote:
> Now that struct perf_event's orig_overflow_handler is gone, there's no need
> for the functions and macros to support looking past overflow_handler to
> orig_overflow_handler.
> 
> This patch is solely a refactoring and results in no behavior change.
> 
> Signed-off-by: Kyle Huey <khuey@kylehuey.com>
> ---
>  arch/arm/kernel/hw_breakpoint.c   |  8 ++++----
>  arch/arm64/kernel/hw_breakpoint.c |  4 ++--
>  include/linux/perf_event.h        | 16 ++--------------
>  3 files changed, 8 insertions(+), 20 deletions(-)

Acked-by: Will Deacon <will@kernel.org>

Will

