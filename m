Return-Path: <bpf+bounces-59692-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB48DACE6F4
	for <lists+bpf@lfdr.de>; Thu,  5 Jun 2025 01:04:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDE4C188F822
	for <lists+bpf@lfdr.de>; Wed,  4 Jun 2025 23:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CD5726B2A9;
	Wed,  4 Jun 2025 23:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rn2j89AA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C5526AA85
	for <bpf@vger.kernel.org>; Wed,  4 Jun 2025 23:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749078265; cv=none; b=mNuFosWRVd352r7KnlLbuvZwAPFXBIfHlgHW56XUB0u2VJ8e9TDb3nU3RsU2of1kLZ87zHh46/3FavKteOjgyTaEJfF+KJqaIYi4zf+EyuVWPBKB56qvQK1lc/I6dBpxTZ6OK52JJDlXAAEu1FJWSMIkbQJ8rXjVcBC7JQa6x/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749078265; c=relaxed/simple;
	bh=exRGgbwr9yCyeN9A0lefWzXikKL4jaZ58HpeXk6pkoc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MgIljPKvA70tPNW/TrN5qr21FUfNDX6gz+Cr2bpu76Rl9WuYIZZjKXoELk3PI3xvDrON3JOA+/hEGvUROhk1WsfPGKyO4EihBEukSqE5n5xrCRPhvszr+OnN4Zs9w/IokBV9V8Z3+odx+P4Nhl4sRgMEP1eLijJBM4pa9ZIze6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rn2j89AA; arc=none smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-4e58a9bb8fcso118258137.2
        for <bpf@vger.kernel.org>; Wed, 04 Jun 2025 16:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749078261; x=1749683061; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AmWygWroaE3CgfzylRy20SRQE724eqiHcqgPFBV3jdc=;
        b=rn2j89AA1+ggWl/NrdUsr4E2vTn+Im0wURmdRqbt1JlGT9hd17tdubdhDHU7FDkHib
         wCTmK9VhgFrAFR3OBFsWSS6QhtaGsJ3vXZGFzTCaiFLWd73sX84uTzc4GxX7vsSX7Mfs
         zVZBj8SCaUQIWqt17oDDMC/hNEsK90426Uor6rKrOyFVZDhAZxkbECjIzVCRv8KLYnwy
         1sTIIMPtfORJRyBB4Zk4br9BSdsFY4qGdtiKaT0gj9Yy4zb2/7UQPKtO8mQl/eMIa8Vj
         mc8qcgK9Y3Y06FCyzX4r5Bkx0kHK0hm8xjZfw1p5Nc4br8/w7bFH2nfyM2H5+sdwJ33D
         8JWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749078261; x=1749683061;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AmWygWroaE3CgfzylRy20SRQE724eqiHcqgPFBV3jdc=;
        b=SqOK+FbyUI4ml7KWlNuoOSW2vkxIS4XsD1xeORxpCz+4lF58j4pZpY54Y33whS94Ci
         kAYoPabUT8K26mxEl///1U375uCJbY0hu+mSirw93Zhal0qjM6alQgp+n0Zs9ZeKwF3A
         w/vjlIuoVAcPHVMHa8kvTXA+vZP24bQ12/L9piLsuz0Ui/Rn4vX794nUSzmSsIHP2m1f
         2oWdHGRw1/8YM3iwA7Dj6a1OfKLHAta86dHEwHacQ1e5u+r9oiQAG1CjfsX07X8eqf+y
         fdTu0+ZDmteybdaPCalGk/Phrux7lz0htzvS5I+1eDn+oZTRY9aG+sy/ZJtEde1l1hWV
         3I+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXUSsi0Ft1cslS9bQxqxJemjxYUNh8NykUR60nTZITwnxB2RW4oI+4mp8LZgVdHrAe6EwE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQJTPpP3X5PYQsVje7OlPBGtKjXDOyAZKbyAVh98qJAELCQmWx
	u+EFQn++vH6f3I167q6uNl9A68d0uPuIzXsIJw20ewNvYCxAHqZBKSPv/poVxCV4gb0QViHWRiH
	PymFBkK4gFgV/MbKLhJu+dCYe/4VnklJtTUrDQ8ip
X-Gm-Gg: ASbGnct9whgCwWCUWEhYoWPQ/llolffBzuCJOweTj73RyqoV7PEYZqBkWDU1CT/qQh8
	jmLFLQ36dzHbpqlWGKvxEdrMVQymmMuf6IuBrjdZPQBjxFiJqkSMzwwiZF9Vp5SuCvHzZ+uuSdf
	jGPa+OltWkEIYaZsHIxsj7cTtSxFgkXY8SSc6/fzOkO5w=
X-Google-Smtp-Source: AGHT+IHMQ0HEf1QGjZKS2FKHFK7WceR4QcvBJZVnXk0gSCJXLZWNY34EB7jNoARv3FwK/IDiJPQd/DA4fgwGFkmqZWo=
X-Received: by 2002:a05:6102:4406:b0:4e6:e126:6238 with SMTP id
 ada2fe7eead31-4e746ce24bcmr4227663137.3.1749078260388; Wed, 04 Jun 2025
 16:04:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250521222725.3895192-1-blakejones@google.com>
 <20250521222725.3895192-3-blakejones@google.com> <aD9Xxhwqpm8BDeKe@google.com>
 <CAP_z_Cj_8uTBGzaoFmi1f956dXi1qDnF4kqc49MSn0jDHYFfxg@mail.gmail.com>
 <aD9sxuFwwxwHGzNi@google.com> <CAP_z_Cg+mPpdzxg-d+VV5J9t7vTTNXQmKLdnfuNETm1H40OA+g@mail.gmail.com>
 <aD9yte49C_BM5oA9@google.com> <CAP_z_Cg0ZCfvEFpJpvhuRcUkjV_paCODw2J61D3YQMm7dg0aGg@mail.gmail.com>
 <aEC9UqkKeEj4on3M@google.com> <aEDEw7bCDAtEXfGC@x1>
In-Reply-To: <aEDEw7bCDAtEXfGC@x1>
From: Blake Jones <blakejones@google.com>
Date: Wed, 4 Jun 2025 16:04:09 -0700
X-Gm-Features: AX0GCFuBtJRBiLPJLWcckQqQphG1Vff1V02DcY2BL7rNUhiI2R9BuvLLkZ8arFw
Message-ID: <CAP_z_CjQktMSMVhgX1gBkBh+0sAnWwAjUfBgJ1he1oaR7ULeRg@mail.gmail.com>
Subject: Re: [PATCH 2/3] perf: collect BPF metadata from existing BPF programs
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Song Liu <song@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Chun-Tse Shao <ctshao@google.com>, Zhongqiu Han <quic_zhonhan@quicinc.com>, 
	James Clark <james.clark@linaro.org>, Charlie Jenkins <charlie@rivosinc.com>, 
	Andi Kleen <ak@linux.intel.com>, Dmitry Vyukov <dvyukov@google.com>, Leo Yan <leo.yan@arm.com>, 
	Yujie Liu <yujie.liu@intel.com>, Graham Woodward <graham.woodward@arm.com>, 
	Yicong Yang <yangyicong@hisilicon.com>, Ben Gainey <ben.gainey@arm.com>, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 4, 2025 at 3:12=E2=80=AFPM Arnaldo Carvalho de Melo <acme@kerne=
l.org> wrote:
> So, the comment in:
>
> tools/perf/util/bpf-event.c
>
> Is:
>
>  * Synthesize PERF_RECORD_KSYMBOL and PERF_RECORD_BPF_EVENT for one bpf
>  * program. One PERF_RECORD_BPF_EVENT is generated for the program. And
>  * one PERF_RECORD_KSYMBOL is generated for each sub program.
>
> which is not so nicely worded tho :-\
>
> "One KSYMBOL per program", followed by "one KSYMBOL per sub program".
>
> But that matches the referenced:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/k=
ernel/events/core.c?h=3Dv6.15#n9825

Indeed, we get one KSYMBOL per subprogram, but one BPF_EVENT per program.
(I found that the term "subprogram" is used inconsistently; sometimes it
includes the main program, while other times it doesn't. In the case of
that comment, and the function perf_event__synthesize_one_bpf_prog, it does
include the main program, which has sub_id =3D 0.)

> So, for these bpf_metadata_ variables, would that be strictly per
> program or would it be perf 'sub program'?

These BPF metadata records would be generated for each subprogram.

My goal here is to allow PERF_RECORD_SAMPLE events with IPs in BPF code
to be associated with any metadata that describes that code. As the
comment points out, each subprogram gets its own PERF_RECORD_KSYMBOL event,
and that event indicates where the subprogram's starting and ending
addresses are. With one PERF_RECORD_BPF_METADATA event per subprogram, it's
then straightforward to associate the metadata with a range of IPs.

If I only generated the metadata records per program rather than per
subprogram, I could only associate them with a PERF_RECORD_BPF_EVENT event.
That event has the full program's tag, but it doesn't have a list of the
subprogram tags for that program. So it doesn't have enough information on
its own to construct the relevant list of virtual address ranges. And I'd
be quite concerned about assuming that the BPF_EVENT events immediately
follow their related KSYMBOL events, especially for events generated while
the system was generating SAMPLE events.

Blake

> Couldn't get an answer from looking at tools/bpf/bpftool/prog.c, but
> seems to be with progs, not subprogs, i.e. just the PERF_RECORD_KSYMBOL
> associated with progs (not subprogs) will have those variables.
>
> But then it seems those variables _are_ associated with at least one
> PERF_RECORD_KSYMBOL, right?

