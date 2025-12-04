Return-Path: <bpf+bounces-76075-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E7A3CA4C8A
	for <lists+bpf@lfdr.de>; Thu, 04 Dec 2025 18:34:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CE02C303848E
	for <lists+bpf@lfdr.de>; Thu,  4 Dec 2025 17:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AD5B2F692D;
	Thu,  4 Dec 2025 17:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XRcrsxzJ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178082F39BC
	for <bpf@vger.kernel.org>; Thu,  4 Dec 2025 17:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764869110; cv=none; b=rzn2rP4v4cp45nfpzAxfVZu2s6mo/+K9udOKA4JqrqNXYt7/lDjOjqD2Z5/qVrvW+yuf3yw33vYQkzffzXuw2xXBE25htnneSSfiPZLViOGa2v+2qfY1qSoBXnARtQAROJLMSoI+M7SXXLBH9LdR8BTd9xY1OBVsPEt0gSQi4bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764869110; c=relaxed/simple;
	bh=w4DudhomAtyMI1TwgWxj2bPlJOA+LZwDMSH+WEth98E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ut5bgTsz6f7OdecHAAirljWfEVnnKYal1/xLXMSl1lbeNOl9Cu2GUyrp1uZKyPpt9LPq/42m4UzE+ELYNRpEV20FjMwphsh7L23g5xBuIlVAV7EEEGayRZ/DDHbhrHJZ5eBek3OiUXSeAzYb07EC4P8OWyiGmVGGZjWiseqhIZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XRcrsxzJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7DBAC2BC86
	for <bpf@vger.kernel.org>; Thu,  4 Dec 2025 17:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764869109;
	bh=w4DudhomAtyMI1TwgWxj2bPlJOA+LZwDMSH+WEth98E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=XRcrsxzJVKTpceabtl5pcstGUoqpNlTZAMm3EaW9HxGW3FGnaB9cfRtL7hH2y9mz0
	 cUl6F/DP3vmzVZGX6t2ePNsiD5o/+0Z5pvudbQT017kN+oamwD3ZuzN9IZmzOWuCRR
	 DB/8u7FK9ZkmYDUSL5tR4LOkA+2bro+kOxsYjGkdPC7ucKA4E5lmZCsiuGn7V59xtc
	 D5euXb4Rhp6SaVQQ9xGXKeZjptIFhc5f/kdmp7p1lTJ/rkD+BI0scZxd2BXw0grxD7
	 LNpJj8NKljMOjpxy19K2azKLPVTB0eMeT2jV/bJQNU58dpGJ78WMUlXtEcT/2qW3nL
	 MN5zGDf4D2yqg==
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-45066bee74aso377981b6e.2
        for <bpf@vger.kernel.org>; Thu, 04 Dec 2025 09:25:09 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXQzdOq+57O8cqwIA2naUZhK2hBuX3kccanz027DyCBSq3rc2iamYT8BrcRB0M6xNAe6jU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8EYnLs9G5rquu9gJxKmE5P0m1v55LPSguFidrTzQI8mo+bzax
	DIptILlaRn3ELjVuC8u5iiOQIBzsuYYOxaAFZ9G6YVi8vxme/DIIU7DMTu4B6QiIka+BOHaWisP
	u8aLuB+0xjzwqCN0C8CUU1cojlWSQHPQ=
X-Google-Smtp-Source: AGHT+IFdqRMTGYpfrIBkL/94H/4UVZLUsxsDPuVlgRIpWLfDNTMjGKr6U2rZEn17oThUm6ZKuIH5u+kR3ynMKeZ2BJA=
X-Received: by 2002:a05:6808:1308:b0:44d:badf:f41a with SMTP id
 5614622812f47-4536e52b830mr3093125b6e.32.1764869108561; Thu, 04 Dec 2025
 09:25:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251201202437.3750901-1-wusamuel@google.com> <20251201202437.3750901-2-wusamuel@google.com>
 <f28577c1-ca95-43ca-b179-32e2cd46d054@arm.com> <CAJZ5v0hAmgjozeX0egBs_ii_zzKXGPsPBUWwmGD+23KD++Rzqw@mail.gmail.com>
 <20251204114844.54953b01@gandalf.local.home>
In-Reply-To: <20251204114844.54953b01@gandalf.local.home>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 4 Dec 2025 18:24:57 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0irO1zmh=un+8vDQ8h2k-sHFTpCPCwr=iVRPcozHMRKHA@mail.gmail.com>
X-Gm-Features: AWmQ_bmbIJSS9C0PX7f-im5Va5YR_TWQXMQtQLR9w9H1jR--rFQSko9z5SAsOhM
Message-ID: <CAJZ5v0irO1zmh=un+8vDQ8h2k-sHFTpCPCwr=iVRPcozHMRKHA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] cpufreq: Replace trace_cpu_frequency with trace_policy_frequency
To: Steven Rostedt <rostedt@goodmis.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Christian Loehle <christian.loehle@arm.com>, 
	Samuel Wu <wusamuel@google.com>, Huang Rui <ray.huang@amd.com>, 
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>, Mario Limonciello <mario.limonciello@amd.com>, 
	Perry Yuan <perry.yuan@amd.com>, Jonathan Corbet <corbet@lwn.net>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown <lenb@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	kernel-team@android.com, linux-pm@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 4, 2025 at 5:48=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org>=
 wrote:
>
> On Thu, 4 Dec 2025 15:57:41 +0100
> "Rafael J. Wysocki" <rafael@kernel.org> wrote:
>
> > > perf timechart seem to do per-CPU reporting though?
> > > So this is broken by not emitting an event per-CPU? At least with a s=
imple s/cpu_frequency/policy_frequency/
> > > like here.
> > > Similar for the bpf samples technically...
> >
> > This kind of boils down to whether or not tracepoints can be regarded
> > as ABI and to what extent.
>
> They are an ABI and they are not an ABI. It really boils down to "if you
> break the ABI but no user space notices, did you really break the ABI?" t=
he
> answer is "no". But if user space notices, then yes you did. But it is
> possible to still fix user space (I did this with powertop).

My concern is that the patch effectively removes one trace point
(cpu_frequency) and adds another one with a different format
(policy_frequency), updates one utility in the kernel tree and expects
everyone else to somehow know that they should switch over.

I know about at least several people who have their own scripts using
this tracepoint though.

> >
> > In this particular case, I'm not sure I agree with the stated motivatio=
n.
> >
> > First of all, on systems with one CPU per cpufreq policy (the vast
> > majority of x86, including AMD, and the ARM systems using the CPPC
> > driver AFAICS), the "issue" at hand is actually a non-issue and
> > changing the name of the tracepoint alone would confuse things in user
> > space IIUC.  Those need to work the way they do today.
>
> If the way the tracepoint changes, it's best to change the name too.
> Tooling can check to see which name is available to determine how to
> process the traces.

If it is updated to do so, yes, but in the meantime?

> >
> > On systems with multiple CPUs per cpufreq policy there is some extra
> > overhead related to the cpu_frequency tracepoint, but the if someone
> > is only interested in the "policy" frequency, they can filter out all
> > CPUs belonging to the same policy except for one from the traces,
> > don't they?
>
> I'm not exactly sure what you mean here. There is an "onchange" trigger y=
ou
> can use to trigger a synthetic event whenever a change happens. But I thi=
nk
> the data here wants to know which CPU had its policy change. Hence the CP=
U
> mask.

IIUC he wants to trace frequency changes per policy, not per CPU
(because there are cases in which multiple CPUs belong to one policy
and arguably the frequency doesn't need to be traced for all of them),
but tooling should know which CPUs belong to the same policy, so it
should be straightforward to use that knowledge when processing the
traces.

