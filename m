Return-Path: <bpf+bounces-76069-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B28B6CA4B30
	for <lists+bpf@lfdr.de>; Thu, 04 Dec 2025 18:12:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8672F3008BD7
	for <lists+bpf@lfdr.de>; Thu,  4 Dec 2025 17:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1602233E358;
	Thu,  4 Dec 2025 16:48:04 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9993330B39;
	Thu,  4 Dec 2025 16:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764866883; cv=none; b=Fg1UUnXbJClUJm775YkuL5n0CkDnw9ycZL18EneMNQmWXGLrc+bkizwir30G6WNkXpVKkOPBUUWM7Sc78F1kiKOW151nL9ysStCJqYdOkBYYn4jC/FmG0PjIg/U0JZdw1uExucdI9xSv6SHoAEQ8PBTWJ7dBc9EmQXJe7qtJFF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764866883; c=relaxed/simple;
	bh=EkE0z2zzbR4yC9MaoW/nOBpvKzurJl2cMHIPauvwvLA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kv8zSqZyEC4iE9J5BpKp9lFnbZ1YWwwZ54uK8z+yNQ8XeB7rfayoyMEI/wpgj6XdQDO1xfdtn6564TuS52iWO4YtPolc/iLl1S0t2YXNFxX7XGLRj4K9sRUxnVhtSZG5S2+owLiftOLuEFNhBv/64oKxpdmWfLZgLJ5B/ZdV92Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf14.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id E73521602CA;
	Thu,  4 Dec 2025 16:47:49 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf14.hostedemail.com (Postfix) with ESMTPA id CBA7434;
	Thu,  4 Dec 2025 16:47:39 +0000 (UTC)
Date: Thu, 4 Dec 2025 11:48:44 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Christian Loehle <christian.loehle@arm.com>, Samuel Wu
 <wusamuel@google.com>, Huang Rui <ray.huang@amd.com>, "Gautham R. Shenoy"
 <gautham.shenoy@amd.com>, Mario Limonciello <mario.limonciello@amd.com>,
 Perry Yuan <perry.yuan@amd.com>, Jonathan Corbet <corbet@lwn.net>, Viresh
 Kumar <viresh.kumar@linaro.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Srinivas Pandruvada
 <srinivas.pandruvada@linux.intel.com>, Len Brown <lenb@kernel.org>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John Fastabend
 <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar
 <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung
 Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexander
 Shishkin <alexander.shishkin@linux.intel.com>, Ian Rogers
 <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, James Clark
 <james.clark@linaro.org>, kernel-team@android.com,
 linux-pm@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v3 1/2] cpufreq: Replace trace_cpu_frequency with
 trace_policy_frequency
Message-ID: <20251204114844.54953b01@gandalf.local.home>
In-Reply-To: <CAJZ5v0hAmgjozeX0egBs_ii_zzKXGPsPBUWwmGD+23KD++Rzqw@mail.gmail.com>
References: <20251201202437.3750901-1-wusamuel@google.com>
	<20251201202437.3750901-2-wusamuel@google.com>
	<f28577c1-ca95-43ca-b179-32e2cd46d054@arm.com>
	<CAJZ5v0hAmgjozeX0egBs_ii_zzKXGPsPBUWwmGD+23KD++Rzqw@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout06
X-Rspamd-Queue-Id: CBA7434
X-Stat-Signature: 5naxe6mx6ihc16m76ezutr5ep85hrf9p
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/J21Ccxet+KzrR4vtWh4885+nU0w2MNEY=
X-HE-Tag: 1764866859-645779
X-HE-Meta: U2FsdGVkX1+rIpoHDJmodDidRgnpgmXUk6kj76YJY9MmykbmTefvXvCnzhEWKuoD9usqsAAM1Ymp7UfIQETAvreqSDSvT0WOAF/NGAANWxHTF50AhOPFovpQT4TEj3VZ6JEcABbCAXAoz4LQg+rmH20p978O8vW7XUllbyUwPzpeDoIb830LrRJRmp76OAVhoCFOVK5cP3gx/SRNk7EInEmMsnRzTgi+o73h/QhXju7UNIAUdhIsgiN83m/meDZ8h7SxUAkR4H6YU4s6qGDLaAFGUu2nHlnRKmQ8digVjDTfSxIrBpaYASPH7g7WXJ5Y/Qwgc8WvVJYjVCED+yWcHyfe47kK2KsE

On Thu, 4 Dec 2025 15:57:41 +0100
"Rafael J. Wysocki" <rafael@kernel.org> wrote:

> > perf timechart seem to do per-CPU reporting though?
> > So this is broken by not emitting an event per-CPU? At least with a simple s/cpu_frequency/policy_frequency/
> > like here.
> > Similar for the bpf samples technically...  
> 
> This kind of boils down to whether or not tracepoints can be regarded
> as ABI and to what extent.

They are an ABI and they are not an ABI. It really boils down to "if you
break the ABI but no user space notices, did you really break the ABI?" the
answer is "no". But if user space notices, then yes you did. But it is
possible to still fix user space (I did this with powertop).

> 
> In this particular case, I'm not sure I agree with the stated motivation.
> 
> First of all, on systems with one CPU per cpufreq policy (the vast
> majority of x86, including AMD, and the ARM systems using the CPPC
> driver AFAICS), the "issue" at hand is actually a non-issue and
> changing the name of the tracepoint alone would confuse things in user
> space IIUC.  Those need to work the way they do today.

If the way the tracepoint changes, it's best to change the name too.
Tooling can check to see which name is available to determine how to
process the traces.

> 
> On systems with multiple CPUs per cpufreq policy there is some extra
> overhead related to the cpu_frequency tracepoint, but the if someone
> is only interested in the "policy" frequency, they can filter out all
> CPUs belonging to the same policy except for one from the traces,
> don't they?

I'm not exactly sure what you mean here. There is an "onchange" trigger you
can use to trigger a synthetic event whenever a change happens. But I think
the data here wants to know which CPU had its policy change. Hence the CPU
mask.

-- Steve

