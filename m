Return-Path: <bpf+bounces-53451-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 227DCA54187
	for <lists+bpf@lfdr.de>; Thu,  6 Mar 2025 05:09:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5542E16C49C
	for <lists+bpf@lfdr.de>; Thu,  6 Mar 2025 04:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8B61199FD0;
	Thu,  6 Mar 2025 04:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RrK3TW6k"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F6610E4;
	Thu,  6 Mar 2025 04:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741234158; cv=none; b=bizKQTz0vfyWfRibvh5Joy+K+idGmwqHm2TT3qtsGHv2mwaXK/vHScJvhJReBe5FnMqat7P1xCYIZzs2WWBdlCOxgDAHFVe2GNhWCJZnQXI4z8Lwn14uw+Cxci4kg6EWi+/KMY9Pu5hohA/FcJxrxnUPPJSjSWqs1Dn313YiVLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741234158; c=relaxed/simple;
	bh=x74w67W34OQptxN3LPm8CIC7Z4OFwaIkZJXaQojOmCM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f1nvKyaWF/oavxaq3k7cQdlfjYHPATFyKymBBO4FpbHpptnsrsdNos/pWWfxF6sb7KIkn4aMIJblMpm6JL3zT567rEO/ZEpQlRTJ/3aQsKrrGKnGFo4UUKB55YmSVcwzLOBZzUDRdZXRWwd5UexQt3qqMhhzUDRWdgUsWjneZCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RrK3TW6k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87A7EC4CEEC;
	Thu,  6 Mar 2025 04:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741234157;
	bh=x74w67W34OQptxN3LPm8CIC7Z4OFwaIkZJXaQojOmCM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=RrK3TW6k8jCmE9SMXm3BjkjaDgi6PjyWTU7V7i1P7my3eJbBsJ4zFSvy2J2WdJvSq
	 LsNSt/4SNGSeoMp6ZiBfP/gC36U2RyDTqcBDqHcvGpxl02k+w0oMP6hZMQClGW76Lr
	 hz76beGrTuP1FW/yGS74plB+SEMAsPv5QIfQgvzU71s2zRo5RukAAw6xEEfQ5GQMug
	 +g3FU83oTgbSW5vCGfpq1k9Fab8C8i+r8CQSIl9pQd/hMklRnGDv12vfEq+F06/F0X
	 Hl6C874N6mf+j+YXtAaOy+KHKXNPAIOTCBTJzqecNrrxpthYLlsrvr7M2OR6E4tR1B
	 JKPaQBfYWIIMw==
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3d2a8c2467eso878995ab.3;
        Wed, 05 Mar 2025 20:09:17 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVFiuoCgrxedm8njx0r2DKDUoG5BXasgA5gsGV8WQbeCUHFUeE5HaRke64sSvwx+qIpgStpoS4/e5ziliWd@vger.kernel.org, AJvYcCX70D3tbrz3vcUbinHL+mX3lQey2gEanmLm5XqdLIeMr0I/FwqkkGHuSRsRFCcMOOCGImo=@vger.kernel.org, AJvYcCXGwezxaSWXMnVK/uiRwQDXzbDwqj4bWDdvxeZ8Kqf/Yv2F61M25deaE624I1EZ2Ut9zL9Q/foxCtUgOLSf2N7hWw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxgfcfAP/7YPZKE73Lh64VEdiURERr1r67Le8nNe/ujUnOZsu8A
	hMgg/JksDn1koihZ2Ev8cT/o93bneSY/qaqym9Llj/zWfYVryU3XqCSAhiKBXa9pRuR7p8AgX+A
	c20ZRC5pyUjn7iU5nmfUN2bPyEAo=
X-Google-Smtp-Source: AGHT+IEmDOOxeBHFQa9OZvTsVcR5AGwXqMRh1cfpfkq1/wgjcTDDOmPc1dKGpJVbfhuckJVX7xYmX+JAm58dQA+THTA=
X-Received: by 2002:a05:6e02:194b:b0:3d3:f2cc:fb5 with SMTP id
 e9e14a558f8ab-3d42b87f6d4mr69379005ab.2.1741234156954; Wed, 05 Mar 2025
 20:09:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250305232838.128692-1-namhyung@kernel.org>
In-Reply-To: <20250305232838.128692-1-namhyung@kernel.org>
From: Song Liu <song@kernel.org>
Date: Wed, 5 Mar 2025 20:09:05 -0800
X-Gmail-Original-Message-ID: <CAPhsuW6TCv=F69gdZvdzw4wQgnHepVGW_+6gxpmXJu7RYEL9xQ@mail.gmail.com>
X-Gm-Features: AQ5f1JqAApBugwFi0TWTLJ3o6_IvcpgCU4HzlAsD4-0ty14Xou4kxA1bnvvaut4
Message-ID: <CAPhsuW6TCv=F69gdZvdzw4wQgnHepVGW_+6gxpmXJu7RYEL9xQ@mail.gmail.com>
Subject: Re: [PATCH] perf report: Do not process non-JIT BPF ksymbol events
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org, 
	Kevin Nomura <nomurak@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 5, 2025 at 3:28=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> The length of PERF_RECORD_KSYMBOL for BPF is a size of JITed code so
> it'd be 0 when it's not JITed.  The ksymbol is needed to symbolize the
> code when it gets samples in the region but non-JITed code cannot get
> samples.  Thus it'd be ok to ignore them.
>
> Actually it caused a performance issue in the perf tools on old ARM
> kernels where it can refuse to JIT some BPF codes.  It ended up
> splitting the existing kernel map (kallsyms).  And later lookup for a
> kernel symbol would create a new kernel map from kallsyms and then
> split it again and again. :(
>
> Probably there's a bug in the kernel map/symbol handling in perf tools.
> But I think we need to fix this anyway.
>
> Reported-by: Kevin Nomura <nomurak@google.com>
> Cc: Song Liu <song@kernel.org>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Acked-by: Song Liu <song@kernel.org>

