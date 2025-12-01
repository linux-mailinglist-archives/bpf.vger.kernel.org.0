Return-Path: <bpf+bounces-75846-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 86448C998A5
	for <lists+bpf@lfdr.de>; Tue, 02 Dec 2025 00:12:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A217734319D
	for <lists+bpf@lfdr.de>; Mon,  1 Dec 2025 23:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7205288C34;
	Mon,  1 Dec 2025 23:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r1fX+fXb"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79C928D850
	for <bpf@vger.kernel.org>; Mon,  1 Dec 2025 23:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764630723; cv=none; b=QkRPJ5tkIXXe4w41gHQMm/ta7Eo2tO3UWk7b0iHN+q+y9rra3IIzm1e1RKFNjt8yWcmR2h3rsfNHEIOheegG2VLakdA2lX20C2yR5nie5bJrb7cCa8MyZGSSrDeKcN3CmXCyGdlmKDIgzwIX0CO2NgmPNAM1wnVp1xDaHiVkAa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764630723; c=relaxed/simple;
	bh=J+kLpkIMy3513Bm09of6YHNMGo8AAMwx8rUXVBwzd2Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Xk5MXHxQQKdTKmHKEUp7VhxQaQk8CgxaIRUDMQYBzQtYi4eaG2YovpOm1t2Vkx60WB7J6wXvbwJ5xBnWJv6A8/a5FssWVU8w/MCDiL/DxeSwL4aMzSzLvGxj3+HUiXHjhQj0vfRd2MO783oTLYKYmoCQg4IzpgmMF7N+Aez0Qvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ynaffit.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r1fX+fXb; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ynaffit.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-ba4c6ac8406so3828913a12.0
        for <bpf@vger.kernel.org>; Mon, 01 Dec 2025 15:12:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764630721; x=1765235521; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:user-agent:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zLM1EPntpvB3fDVLGw42FElIkaQKNx9U9DS+XMsl0fM=;
        b=r1fX+fXbEJlouqcyHm3JSiPgfdPmHqObRKzGGfTP+vyJ3nKoJtwz5YKpRg3V9YNauf
         LJC3PB/m6vlOtnd6FBQ4n0zTD9gxg9kknLe96Dm76uoed9/G8Kph4/zHm1y6bGlTra8J
         8VPPFd3SAwqJ40jYZeBJqtBxf/FlDLTzHB86+H5lmYzCJVbyujwfcpY9HB5Qz7wNzr+D
         81EJU6/vw5rzcH5msgJrtW3unzt/USSSFVzY85OBA5XNxoBwnTqSiSnOEJgRnlsKf2K2
         gcFXi0CAc65NbjnpYgVXpR0vsVmLLNpqZ8jF1Ajf2VfWvRi9UlC8z8fXVCtpRYMqWsrB
         8UDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764630721; x=1765235521;
        h=cc:to:from:subject:message-id:user-agent:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zLM1EPntpvB3fDVLGw42FElIkaQKNx9U9DS+XMsl0fM=;
        b=hJl+J58122RjrN6Knqc55CU1v2hXPDOkmd40K0QUmznGwlI13YeOD8Za1vP3CJpnkj
         QQfEPKE44eFMTk0D08XdF9Jj5DaIZW4zoHuQR6JnVP3/IJFBpanOf3ylD9oErtMJzxBt
         ZPk2Q88HnVbwyhstLTe/HD1Vf8BZ9/0uhV9PkXI5THatQPBm3Cn+NHvOQiBeVbv25MFz
         e0Ev51OsWijTX8k1II4NpBW+EC4HNxknJ6KHN9/MHIz+pohLdxbynGfdNZAZQGKgSOmy
         QVy0HQjH+5+y8pZCyw7j6ZOwelub9Pz4NO7EQXfbESI5VzxfAA1n5iCAPZbUfUXnRBeC
         j1Kg==
X-Forwarded-Encrypted: i=1; AJvYcCXIqJnTJTTf0kJadl74eqLJZF86ADs9vVema43slNgvsILEFRwtm837TPf9hJ5BuOMQz/E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjKPmiASfqcMbKkhg7j2Ot4nPR6ZQ9JLXpGV1GBun/cKWsuyiR
	BHn0UeGzzDIipK4zVzw9U+ik6vxI6YNuefNAaejlYmHvvwDA/nQEXGj1thazY7j7sIF4zQUXy3M
	1bazLtNf8eg==
X-Google-Smtp-Source: AGHT+IE1+zlv+/Ra8/4fDxzAvPN8JlMMEIwYI0833qsjS+sqfkYoQe/VtqWugCSuUH/u1MaLnSztSAazoE5b
X-Received: from dlbcy37.prod.google.com ([2002:a05:7022:ba5:b0:11b:9bdf:e45c])
 (user=ynaffit job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:6898:b0:11b:ceee:a469
 with SMTP id a92af1059eb24-11c9d85feeemr24650965c88.22.1764630720912; Mon, 01
 Dec 2025 15:12:00 -0800 (PST)
Date: Mon, 01 Dec 2025 15:11:45 -0800
In-Reply-To: <20251201202437.3750901-3-wusamuel@google.com> (via kernel-team's
 message of "Mon, 1 Dec 2025 12:24:35 -0800")
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251201202437.3750901-1-wusamuel@google.com> <20251201202437.3750901-3-wusamuel@google.com>
User-Agent: mu4e 1.12.12; emacs 30.1
Message-ID: <dbx88qflajbi.fsf@ynaffit-andsys.c.googlers.com>
Subject: Re: [PATCH v3 2/2] cpufreq: Documentation update for trace_policy_frequency
From: Tiffany Yang <ynaffit@google.com>
To: "'Samuel Wu' via kernel-team" <kernel-team@android.com>
Cc: Huang Rui <ray.huang@amd.com>, "Gautham R. Shenoy" <gautham.shenoy@amd.com>, 
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
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Samuel Wu <wusamuel@google.com>, christian.loehle@arm.com, linux-pm@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes

Hi Sam,

IMO this type of documentation should be in the same patch as the
related change because having a single commit makes it easier to track
(especially if/when these changes are cherry-picked to other
trees). There may be reasons to keep them separate that I'm not thinking
of, so if others disagree, defer to them!


"'Samuel Wu' via kernel-team" <kernel-team@android.com> writes:

> Documentation update corresponding to replace the cpu_frequency trace
> event with the policy_frequency trace event.

> Signed-off-by: Samuel Wu <wusamuel@google.com>
> ---
>   Documentation/admin-guide/pm/amd-pstate.rst   | 10 +++++-----
>   Documentation/admin-guide/pm/intel_pstate.rst | 14 +++++++-------
>   Documentation/trace/events-power.rst          |  2 +-
>   3 files changed, 13 insertions(+), 13 deletions(-)
<snip>

>   A suspend event is used to indicate the system going in and out of the
>   suspend mode:

Otherwise, this change lgtm.

-- 
Tiffany Y. Yang

