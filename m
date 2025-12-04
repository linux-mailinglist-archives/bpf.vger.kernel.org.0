Return-Path: <bpf+bounces-76083-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F027ACA4FEF
	for <lists+bpf@lfdr.de>; Thu, 04 Dec 2025 19:49:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3ECB830F74D4
	for <lists+bpf@lfdr.de>; Thu,  4 Dec 2025 18:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11B2F2FB998;
	Thu,  4 Dec 2025 18:46:10 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5439153598;
	Thu,  4 Dec 2025 18:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764873969; cv=none; b=kPMKGlVuGRFs58wyRXS0iJLpcsC70w6tOl5vV0MTOXm8o5tAUZvDn9k1eo8ZjC7tVlsdtPLRLZ1VXpUGXa/4gxmJY2N88uHSCTYs2vXJxWnG/A7mFaedYrXxz/BaUc3JTOXOleI97nMVd4senZO0xkbV14qMWh6rFwDib96eBMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764873969; c=relaxed/simple;
	bh=yIqydaEIMrZjWRo8LWEf8jUMkuV3Kir3YBByEcdUGuo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rRUCc6GH7GnNE8mnU7llJlHW9lWB1EneRE+nQMJh4BOdrO9pIld6XSKpAcA9v6o/aFJS0BPNj8YoUUgho+13kLA8KZ9osVuiDCtg6jD60Mr10Bgtu500R54buMqciRgYomMsa7nBeTWY//pbZvOXA+Emahh7QZgrMMJAKAJf9FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf11.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id 170F5B73CC;
	Thu,  4 Dec 2025 18:45:56 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf11.hostedemail.com (Postfix) with ESMTPA id BED922002D;
	Thu,  4 Dec 2025 18:45:45 +0000 (UTC)
Date: Thu, 4 Dec 2025 13:46:50 -0500
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
Message-ID: <20251204134650.2d9fd3ff@gandalf.local.home>
In-Reply-To: <CAJZ5v0irO1zmh=un+8vDQ8h2k-sHFTpCPCwr=iVRPcozHMRKHA@mail.gmail.com>
References: <20251201202437.3750901-1-wusamuel@google.com>
	<20251201202437.3750901-2-wusamuel@google.com>
	<f28577c1-ca95-43ca-b179-32e2cd46d054@arm.com>
	<CAJZ5v0hAmgjozeX0egBs_ii_zzKXGPsPBUWwmGD+23KD++Rzqw@mail.gmail.com>
	<20251204114844.54953b01@gandalf.local.home>
	<CAJZ5v0irO1zmh=un+8vDQ8h2k-sHFTpCPCwr=iVRPcozHMRKHA@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: BED922002D
X-Stat-Signature: 1mm99c6m3astshbq7ckoy9t7qefuxpqj
X-Rspamd-Server: rspamout08
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/CN4d8P+cv3dNHDlW96Ps5lg789OU92zA=
X-HE-Tag: 1764873945-545180
X-HE-Meta: U2FsdGVkX18tqzw2//qpi2ZH6MYa9i57BKgUq3iyQj1qyboQdAeoZjH8fFCCTCLm8t81HhPaHi3TJMeLTMpoL9gKrDiJsFfFUA1lPP3UQoDaar2RgJty3CJrUhFOIQsjtlj3ZfqVM0mI4nwiPOsOA//f06BEghLtT3rLcBJwrCe+vRbQs1ArCz5pVZyI54E4Pyaj+B4QDz5kGYLtQCiZ7Zq7cPXsIgnPEJwQX11m++Ou+Zi1iDx8N75lzk5Dg8ZYo3eCWvnRCCb2ylMEObCk8nfe/indBvgHmAgJMGdgxPF7/ce5QsIBqHICv2eURygXcu3i9Zs4a+JhXIxm9T0J8XTcQchu07V0vBTcdU9QhY5vNMEJeGDoEY2ysZVNl508aqWKc0R5gGaJ/3TMM6IWg7hCpmgx4jQHcU3lQzZ5vH6KsE9P/6M8TSyQdn/+bKg8aY6IoPA7TYvv3MYl/Za58t9XwljexnPMcH2tbpR8LQA=

On Thu, 4 Dec 2025 18:24:57 +0100
"Rafael J. Wysocki" <rafael@kernel.org> wrote:

> > I'm not exactly sure what you mean here. There is an "onchange" trigger you
> > can use to trigger a synthetic event whenever a change happens. But I think
> > the data here wants to know which CPU had its policy change. Hence the CPU
> > mask.  
> 
> IIUC he wants to trace frequency changes per policy, not per CPU
> (because there are cases in which multiple CPUs belong to one policy
> and arguably the frequency doesn't need to be traced for all of them),
> but tooling should know which CPUs belong to the same policy, so it
> should be straightforward to use that knowledge when processing the
> traces.

In case you only care about frequency changes, you could do this:

 # echo 'freq_change u32 state;' > /sys/kernel/tracing/synthetic_events 
 # echo 'hist:keys=common_type:s=state:onchange($s).trace(freq_change,$s)' > /sys/kernel/tracing/events/power/cpu_frequency/trigger 
 # echo 1 > /sys/kernel/tracing/events/synthetic/freq_change/enable 
 # cat /sys/kernel/tracing/trace
# tracer: nop
#
# entries-in-buffer/entries-written: 2833/2833   #P:56
#
#                                _-----=> irqs-off/BH-disabled
#                               / _----=> need-resched
#                              | / _---=> hardirq/softirq
#                              || / _--=> preempt-depth
#                              ||| / _-=> migrate-disable
#                              |||| /     delay
#           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
#              | |         |   |||||     |         |
             sed-596089  [034] d..5. 2687140.288806: freq_change: state=2000000
            bash-596090  [020] d.s4. 2687140.290407: freq_change: state=1900000
          <idle>-0       [028] d.s7. 2687140.290425: freq_change: state=3000000
            bash-596090  [020] d..5. 2687140.291152: freq_change: state=1900000
          <idle>-0       [000] dNs5. 2687140.326526: freq_change: state=1200000
       CPU 3/KVM-10724   [019] d.s5. 2687140.358418: freq_change: state=2100000
       CPU 6/KVM-10727   [021] d.h5. 2687140.394403: freq_change: state=1300000
       CPU 6/KVM-10727   [021] d.h5. 2687140.398403: freq_change: state=1400000
       CPU 6/KVM-10727   [021] d.h5. 2687140.402402: freq_change: state=1500000
       CPU 6/KVM-10727   [021] d.h5. 2687140.406400: freq_change: state=1600000
       CPU 6/KVM-10727   [021] d.h5. 2687140.410404: freq_change: state=1700000
[..]

Which BTW, I'll be giving a talk about synthetic events at OSS in Tokyo ;-)
   (cheap plug!)

https://ossjapan2025.sched.com/event/29FoB/synthetic-events-and-tracing-latency-within-the-kernel-steven-rostedt-google?iframe=yes&w=100%&sidebar=yes&bg=no

-- Steve

