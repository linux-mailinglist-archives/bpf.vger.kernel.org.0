Return-Path: <bpf+bounces-76084-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F69BCA5058
	for <lists+bpf@lfdr.de>; Thu, 04 Dec 2025 19:58:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9C5F7313AE4B
	for <lists+bpf@lfdr.de>; Thu,  4 Dec 2025 18:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B688D30170A;
	Thu,  4 Dec 2025 18:47:12 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD491D63F0;
	Thu,  4 Dec 2025 18:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764874032; cv=none; b=ZQBk92v+UYZQRpnv/gHq949a44g7gRJCRxUciWKesMO4QwbOycpMGpynYlnpPDAb8mQhbHvdRjgW/9iLJDPEn0FkzVjT/GMoxWMeK5CXsi0Tr6o/i1jmstPgCdr31RvXPZ5h83wTu5+GXcI9Ut3nE1LkygjQilZeI+KQnFJccHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764874032; c=relaxed/simple;
	bh=ykAnz4AG1UtwAaAeIQnzglv/0vXJse22g2gS1Y1Ec/0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Oc9VvJ+N3fl5ScodB3erza1d0BQrGaE/JOAmiCIUN7aBUsa/MkcR8OFqtp65rN2YQHRV1kiFTObDst5GX2hrWbv+hoBDJ3oU/jHsMMYFXXAO1sZs2+4QmyjIuxLfQy/gRLZciomlVVAkemMLhoovr7CxKAWv4iE3N2Omlt5kJzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf20.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id D9F201401C3;
	Thu,  4 Dec 2025 18:47:03 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf20.hostedemail.com (Postfix) with ESMTPA id A83A220029;
	Thu,  4 Dec 2025 18:46:53 +0000 (UTC)
Date: Thu, 4 Dec 2025 13:47:58 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Christian Loehle 
 <christian.loehle@arm.com>, Samuel Wu <wusamuel@google.com>, Huang Rui
 <ray.huang@amd.com>, "Gautham R. Shenoy" <gautham.shenoy@amd.com>, Mario
 Limonciello <mario.limonciello@amd.com>, Perry Yuan	 <perry.yuan@amd.com>,
 Jonathan Corbet <corbet@lwn.net>, Viresh Kumar	 <viresh.kumar@linaro.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Len Brown	 <lenb@kernel.org>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann	 <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau	
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu 
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John Fastabend
  <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev	 <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar
 <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung
 Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexander
 Shishkin	 <alexander.shishkin@linux.intel.com>, Ian Rogers
 <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, James Clark
 <james.clark@linaro.org>, kernel-team@android.com,
 linux-pm@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v3 1/2] cpufreq: Replace trace_cpu_frequency with
 trace_policy_frequency
Message-ID: <20251204134758.72b1064b@gandalf.local.home>
In-Reply-To: <2b31224a6cf361a5d2859c84aa1bcdf52916423e.camel@linux.intel.com>
References: <20251201202437.3750901-1-wusamuel@google.com>
	<20251201202437.3750901-2-wusamuel@google.com>
	<f28577c1-ca95-43ca-b179-32e2cd46d054@arm.com>
	<CAJZ5v0hAmgjozeX0egBs_ii_zzKXGPsPBUWwmGD+23KD++Rzqw@mail.gmail.com>
	<2b31224a6cf361a5d2859c84aa1bcdf52916423e.camel@linux.intel.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: A83A220029
X-Stat-Signature: myhtfzdmfrbaajbkk8gsgyzd4kf9koa7
X-Rspamd-Server: rspamout05
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX184+sGIWPK/W02Yj6Xph3ZRsqNhbZ6UjYc=
X-HE-Tag: 1764874013-940494
X-HE-Meta: U2FsdGVkX19ZrTWPbQSJrM9iYSkTJC1g1TAiLlnyJ1nXC4Aa89Y3rTHKxUm/pRuQDVzkFE4gd4NwqOA0DC/sTJrSsSL2L+CMX3dWOIlx7CAyYhofCGhck5SfJ82QPSNlTng3Ns2ytrhfBrupHClBcspB/2f0wRUi/12arfFwjxhrZ8l8JNKzuEQMxDM5oCgtj2sKAaFqygk8mh7cNGk9XYQY92B6w6eX3ICVB9rHec2ZGaYDzRbsu23Y1uB9iLzpw4ACE23YxL8FmyiaGuHWPjupRoyejhvfFXmafF3n6SUnI5svEzoCoI6+2fOMObZO3ShaiFb90mEdFd7GlGA1QRyoS2awh9sdXX8YgulkqjOXxur6FXoDQw==

On Thu, 04 Dec 2025 09:21:13 -0800
srinivas pandruvada <srinivas.pandruvada@linux.intel.com> wrote:

> We have tools using tracing. We may need to check those tools.
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/tools/power/x86/intel_pstate_tracer/intel_pstate_tracer.py?h=next-20251204

I only see this using pstate_sample event.

> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/tools/power/x86/amd_pstate_tracer/amd_pstate_trace.py?h=next-20251204

I only see this using amd_cpu event.

-- Steve

