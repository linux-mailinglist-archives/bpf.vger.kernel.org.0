Return-Path: <bpf+bounces-77492-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BD73CE8434
	for <lists+bpf@lfdr.de>; Mon, 29 Dec 2025 23:03:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 11422302B768
	for <lists+bpf@lfdr.de>; Mon, 29 Dec 2025 22:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7459B3126AF;
	Mon, 29 Dec 2025 22:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rostedt.org header.i=@rostedt.org header.b="pgydrzZb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hUL/be+n"
X-Original-To: bpf@vger.kernel.org
Received: from flow-a4-smtp.messagingengine.com (flow-a4-smtp.messagingengine.com [103.168.172.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92EF7261B9B;
	Mon, 29 Dec 2025 22:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767045623; cv=none; b=I8PkFDQCuhJYvr9fu5ZSHyU8JS6HLoqDNn2Wh2UWc6bmt+k+UfYyyKbrPEHskMg+OhLigxNA6na8WSBlmxBtHm6UROb5PZIoDaxNPCgvROduUTNQMZzr7yPNSPzng7Lii/zIuw/3IwtnuWKZg5UW38NIQfXjUhq1kqUXMmA8/uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767045623; c=relaxed/simple;
	bh=e1ZpqeYV96WGhzswy3N9lCtRQ0ojGzRE3LStGOklIn8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XEXBpcf6k4CX2xUxE4/iyiRSiWwXsIwwqCqQV6xxLCIZMk+g/mb7FmQfjJoyjOQGOUF49bP7ceQbP2NXAYuAnknKJiNekH77f/ozI5kRQn/5eA4MVR97NQqyML5FadRu7gL7nAdIXiPk1a4ysZIexj3C7AqYHf820c5EL2n6xDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rostedt.org; spf=pass smtp.mailfrom=rostedt.org; dkim=pass (2048-bit key) header.d=rostedt.org header.i=@rostedt.org header.b=pgydrzZb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hUL/be+n; arc=none smtp.client-ip=103.168.172.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rostedt.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rostedt.org
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailflow.phl.internal (Postfix) with ESMTP id 08D781380260;
	Mon, 29 Dec 2025 17:00:18 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 29 Dec 2025 17:00:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rostedt.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1767045618;
	 x=1767052818; bh=O0ZJU8DaqzJoW8dJ+OnRjJXbin20aHsOsnu3lVtVS/E=; b=
	pgydrzZbhfxZrfTds1ZaT3udPpLePseKQ0ti+HbUrz1daDYZX/FA+JWmVvDHi5Uy
	KQuDmc982scU8ueDuzTaD4lT2FPTnUQJ4rYfCzWzziaGCj1rbVpZdEV48d7nlBUJ
	INJBpxL3sdWCu2cfhnbMl/j7cxA/t2fZnzX7clVxprGJNymOcBrIQNfqgOe2qQkl
	OuL5kEsHoL0D+xzuQeZZkAldMUg9Y596x3jNwgeHHS2Mzx/buqg2Ie+DqHRkeLK7
	lAbbszayWaunTxWlDrX2RbnInUBS7FKDxq7DoukY4oik+nxWevSwvDzgvvnmsM4L
	8QnJX2RwNzTbQ2IOJEFL7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1767045618; x=
	1767052818; bh=O0ZJU8DaqzJoW8dJ+OnRjJXbin20aHsOsnu3lVtVS/E=; b=h
	UL/be+nAK20snGbOKBc/uFgayhhPWAz60SZWy+BJcWMQBesMo/SNWb7uygeFVwD/
	crOskNtHD4J7ukB4qmoHqbCnHEfrx5b3xgnAZqCGVY9A2WswBRnyPFowKeRKxANa
	dk1iubDd2IDR+aokGCV5/w6BQ60kTCXdLF7p074zao1mdlP0Vv+6wHLp0A04GU1s
	lCZkFY1Xek4stfCLrFJ3eVt7qXFo/iRaxNmAyDMkzizJk0DX3cE8kVTPrc8fWaCS
	MkR56B5EYXwI/lfJ70yXatH+t+ngyWr9vRwbX9W8Deu5guACsdd4pOhyYUyxCiDw
	sYMJuozqeC3WRRMNIDfYA==
X-ME-Sender: <xms:8PlSaf40ZhDJ0bnKyPIf2R69fIwqDPctibIRrkrj7Z7pda6HKBLNYQ>
    <xme:8PlSaQkSTIKEvLNCKfg7-iL09V52gch3CtS7XTc73nGeCYRsgC-9dI_Y7FrTvf-qm
    enyLRBwG-7CVYJhb7i-xQ8gx3ltUyN1yIThzw3xKewuUyCHDMsb>
X-ME-Received: <xmr:8PlSaaFhH_upQzRWw86M2C-liXartwbQ4RX18Z-jR6iYVRZG8V6uH-KD6CdBtaQVp0ZbLdHP>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdejkedvkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfgjfhfogggtgfesthejredtredtvdenucfhrhhomhepufhtvghvvghn
    ucftohhsthgvughtuceoshhtvghvvghnsehrohhsthgvughtrdhorhhgqeenucggtffrrg
    htthgvrhhnpeelteehvdekvdfgfffgvefhgfdutdfgueeuvedujeelvdeluddugefhteeg
    tdetgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hsthgvvhgvnhesrhhoshhtvgguthdrohhrghdpnhgspghrtghpthhtohepgedupdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehrrghfrggvlheskhgvrhhnvghlrdhorhhgpd
    hrtghpthhtoheptghhrhhishhtihgrnhdrlhhovghhlhgvsegrrhhmrdgtohhmpdhrtghp
    thhtohepfihushgrmhhuvghlsehgohhoghhlvgdrtghomhdprhgtphhtthhopehrrgihrd
    hhuhgrnhhgsegrmhgurdgtohhmpdhrtghpthhtohepghgruhhthhgrmhdrshhhvghnohih
    segrmhgurdgtohhmpdhrtghpthhtohepmhgrrhhiohdrlhhimhhonhgtihgvlhhlohesrg
    hmugdrtghomhdprhgtphhtthhopehpvghrrhihrdihuhgrnhesrghmugdrtghomhdprhgt
    phhtthhopegtohhrsggvtheslhifnhdrnhgvthdprhgtphhtthhopehvihhrvghshhdrkh
    humhgrrheslhhinhgrrhhordhorhhg
X-ME-Proxy: <xmx:8PlSaQYGgalNw5SjPdhrKAnCLLFUEoQGrOSVs3tkY2TExqc8clVHjA>
    <xmx:8PlSaRI6B8RsVmiJPWVAQ_ziecOBFE6_QF8KSusnBWzUjhmyYLHHNw>
    <xmx:8PlSaRyHBo-bvTd8HYnRPio7ljvW4x2WArRI8dzfGkLYWwNzAb4mjg>
    <xmx:8PlSaR1Gi1SOcnlTZoZbSP9EfKmkyIm-eBsBp0j0sRwJPqg5aUIV2g>
    <xmx:8vlSaSZc8DEhckn2AumEN10TY2bNWg389EoEctNBAVXwOp63LLBOD0Dk>
Feedback-ID: id06e481b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Dec 2025 17:00:14 -0500 (EST)
Date: Mon, 29 Dec 2025 17:00:21 -0500
From: Steven Rostedt <steven@rostedt.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Christian Loehle <christian.loehle@arm.com>,
 Samuel Wu <wusamuel@google.com>, Huang Rui <ray.huang@amd.com>,
 "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Perry Yuan <perry.yuan@amd.com>, Jonathan Corbet <corbet@lwn.net>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Len Brown <lenb@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>,
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
 James Clark <james.clark@linaro.org>, kernel-team@android.com,
 linux-pm@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v3 1/2] cpufreq: Replace trace_cpu_frequency with
 trace_policy_frequency
Message-ID: <20251229170021.71cc5425@gandalf.local.home>
In-Reply-To: <20251229165212.5bd8508d@gandalf.local.home>
References: <20251201202437.3750901-1-wusamuel@google.com>
	<20251201202437.3750901-2-wusamuel@google.com>
	<f28577c1-ca95-43ca-b179-32e2cd46d054@arm.com>
	<CAJZ5v0hAmgjozeX0egBs_ii_zzKXGPsPBUWwmGD+23KD++Rzqw@mail.gmail.com>
	<20251204114844.54953b01@gandalf.local.home>
	<CAJZ5v0irO1zmh=un+8vDQ8h2k-sHFTpCPCwr=iVRPcozHMRKHA@mail.gmail.com>
	<20251229165212.5bd8508d@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 29 Dec 2025 16:52:12 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Thu, 4 Dec 2025 18:24:57 +0100
> "Rafael J. Wysocki" <rafael@kernel.org> wrote:
> 
> > My concern is that the patch effectively removes one trace point
> > (cpu_frequency) and adds another one with a different format
> > (policy_frequency), updates one utility in the kernel tree and expects
> > everyone else to somehow know that they should switch over.
> > 
> > I know about at least several people who have their own scripts using
> > this tracepoint though.  
> 
> Hi Rafael,
> 
> Can you reach out to those that have scripts that use this trace event to
> see if it can be changed?
> 
> Thanks,

I got a bunch of "Undelivered Mail Returned to Sender". It seems that gmail
thinks my goodmis.org account is now spam :-p

-- Steve


