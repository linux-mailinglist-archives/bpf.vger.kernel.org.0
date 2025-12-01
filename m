Return-Path: <bpf+bounces-75836-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 615DFC99015
	for <lists+bpf@lfdr.de>; Mon, 01 Dec 2025 21:24:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C43B33A4C2C
	for <lists+bpf@lfdr.de>; Mon,  1 Dec 2025 20:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4734C25C804;
	Mon,  1 Dec 2025 20:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="asZWEBqg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36EFA2580F2
	for <bpf@vger.kernel.org>; Mon,  1 Dec 2025 20:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764620683; cv=none; b=HMH2vlIhmlCMKQk60d+w49lSUA88sliBla2hKxHMcPAf/jECHO7ns6Gk8nGwm3uXxHMwlj5RBslgv3oX26D/evifbcrbwa2dnp564/KnHo0m3pHuwXwUyorBnVJZHTPN80kMyw32PBeWpBq2ZWh0hMBVZL7WCVa5IRHbtKzCHEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764620683; c=relaxed/simple;
	bh=bmdKaakeQ2qlcuEhbrkLXTodGhStl+ks2cn8ATYCSVI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=pJGxcXY6UFykNyPWvWMJhXljQo7G3T2WoABUImhqcRI1xV1bRVZ2b9OAmKvCp2L20tsH538qWzlkGagOMS6fGAvIeDKrC6VbZ2nopjRatE7o7cHQTG8aiH9LJ0F+iHaYh6A/oCg+QEov5uvwLiKPD30IKgPG1m6kqsPvsC+SVhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wusamuel.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=asZWEBqg; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wusamuel.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-7b82c2c2ca2so7008725b3a.1
        for <bpf@vger.kernel.org>; Mon, 01 Dec 2025 12:24:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764620681; x=1765225481; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YzqoNXMXlB4QJuJKljRGPzXCEDAwQxd0nRjFUhyDteI=;
        b=asZWEBqg0OVXYDYqEEowkqjQIVUXT2p3sNf3apfL2564vqeAkiX0+op88NGOefKmGY
         BGkFmCk1G+usBkqxGIOfBLdqi9VSCsdqTWEDhLsA7FijXGpM5cE6dqbbH+znAviqQcGZ
         UsVPOoUXja1asDcPPMU012kRx2sipPRRhaOaEdQ7EanyqwP1+GN7Gv9hPGbl3Q3J0vCM
         T5ckMWlCftr5t1Rgtwm314nXNCvrArj8smWXQX960EWyeMBqmMDE15CJHUzdDl+M3RM7
         8sO4A4K9CS1pXercpC8Ham7IyWSUB9L0hIFIc08xF9ZqKxswncmCVyvg53Sd8kV7lw2d
         tT8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764620681; x=1765225481;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YzqoNXMXlB4QJuJKljRGPzXCEDAwQxd0nRjFUhyDteI=;
        b=gXB2haDZK8ippYYZ+3gP6Xurw+1bNFU6Qkcf8PCICBF91smL3tcQdK9eORvwG9J/Hc
         R9GkQtF52Fp/4sr+Vfnzku2BuE2HclipH4EnoeMU4TOXJaaTCXEQHsPWPynGqe9DRtOl
         U+kTs8naVSoWxTadBUKQmeAt8VNLxC42LhA0sTjYxrkmTlPA2zm7CFQ3ZXGpHZ4f3yn5
         knP3YMN1eL2j2r5XsaaIFaMWYGRECpeL0H0+37AIl/cNpeDZL+Xe9GDbFn8nzFBY96kg
         d1fW4Icj5sBqrt5Tt8lfixt1a7TJiQcbHL8SEsSSC2fWuss89002vBRdUCCM5AnNxymd
         cNjw==
X-Forwarded-Encrypted: i=1; AJvYcCUxw71H49Tpv2lG4JKJq3A80+EO2LLpx53GIui/INH4wuefxdWyzomLcsUAWXn4pcWJBsw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9/wB7bBNqVtofmxvSLmsuTiIt8AFidJ5vLroY5wfC/ZUU+81Z
	Krh67G25L48YBvEjP3qoIfKUIZrh4WCpjhREpjNoI+Q8v2jG7VORWUYZ3Gmmq8WvXr+SkXsshMN
	jv5xyRRBYPqc+tQ==
X-Google-Smtp-Source: AGHT+IHQtXFI85eOaGUKtju1E/nUDbxu3Y7hb2mE4p5OtpKvdfJvDAKU8ETybSkma52IvfdGC2Jcz9q0XskSpA==
X-Received: from dlbrx19.prod.google.com ([2002:a05:7022:1713:b0:11a:41d0:afac])
 (user=wusamuel job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7022:5f11:b0:119:e569:f268 with SMTP id a92af1059eb24-11c9d718e24mr15581153c88.17.1764620681325;
 Mon, 01 Dec 2025 12:24:41 -0800 (PST)
Date: Mon,  1 Dec 2025 12:24:33 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.107.ga0afd4fd5b-goog
Message-ID: <20251201202437.3750901-1-wusamuel@google.com>
Subject: [PATCH v3 0/2] Replace trace_cpu_frequency with trace_policy_frequency
From: Samuel Wu <wusamuel@google.com>
To: Huang Rui <ray.huang@amd.com>, "Gautham R. Shenoy" <gautham.shenoy@amd.com>, 
	Mario Limonciello <mario.limonciello@amd.com>, Perry Yuan <perry.yuan@amd.com>, 
	Jonathan Corbet <corbet@lwn.net>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
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
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>
Cc: christian.loehle@arm.com, Samuel Wu <wusamuel@google.com>, kernel-team@android.com, 
	linux-pm@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

This series replaces the cpu_frequency trace event with a new trace event,
policy_frequency. Since by definition all CPUs in a policy are of the same
frequency, we can emit a frequency change per policy instead of per CPU.
This saves some compute and memory from the kernel side, while simplifying
analysis from the post-processing of the trace log side.

Any process that relied on cpu_frequency trace event needs to switch to the
new policy_frequency trace event in order to maintain functionality. The
decision of replacing instead of adding the trace event is intentional. Since
emitting once per policy instead of once per CPU is anyways a semantics change
that would require a tooling update, the trace event was also appropriately
renamed. The presence of the policy_frequency event in a trace log is a clear
and obvious signal for tooling to determine kernel version and which trace
event to parse.

1/2: Replaces trace_cpu_frequency with trace_policy_frequency
2/2: Corresponding documentation patch that updates references to
     cpu_frequency with policy_frequency

Changes in v3:
- Resending v2 properly (accidentally ommited cover letter in v2)

Changes in v2:
- Replaced trace_cpu_frequency with trace_policy_frequency (per Christian
  and Viresh)
- Updated references to cpu_frequency in documentation with
  policy_frequency
- v1 link: https://lore.kernel.org/all/20251112235154.2974902-1-wusamuel@google.com

Samuel Wu (2):
  cpufreq: Replace trace_cpu_frequency with trace_policy_frequency
  cpufreq: Documentation update for trace_policy_frequency

 Documentation/admin-guide/pm/amd-pstate.rst   | 10 ++++----
 Documentation/admin-guide/pm/intel_pstate.rst | 14 +++++------
 Documentation/trace/events-power.rst          |  2 +-
 drivers/cpufreq/cpufreq.c                     | 14 ++---------
 drivers/cpufreq/intel_pstate.c                |  6 +++--
 include/trace/events/power.h                  | 24 ++++++++++++++++---
 kernel/trace/power-traces.c                   |  2 +-
 samples/bpf/cpustat_kern.c                    |  8 +++----
 samples/bpf/cpustat_user.c                    |  6 ++---
 tools/perf/builtin-timechart.c                | 12 +++++-----
 10 files changed, 54 insertions(+), 44 deletions(-)

-- 
2.52.0.107.ga0afd4fd5b-goog


