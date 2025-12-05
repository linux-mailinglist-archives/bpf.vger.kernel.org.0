Return-Path: <bpf+bounces-76103-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2959ACA728B
	for <lists+bpf@lfdr.de>; Fri, 05 Dec 2025 11:29:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1696830E3C7F
	for <lists+bpf@lfdr.de>; Fri,  5 Dec 2025 10:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9314231B804;
	Fri,  5 Dec 2025 10:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qYr8+xBZ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75BDF2F7442;
	Fri,  5 Dec 2025 10:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764930488; cv=none; b=QzxwN3AgE+vxe3CPmvsASv+2FETMLtKXrtdw24pB5/wEHs6HD8WmJ/OGQ+xrqHka4S0A2/IeBIxQNu5h2OXhISZwP+aUxHz7K6Qv9QvljEDwFZ8nd2gmO9QIxVhQEqD5Uy71zGtaIaGy5ZcjeJ+TSNz2vm37m4n6/FXtyMpTv4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764930488; c=relaxed/simple;
	bh=pkvT43jmHMZGx+gMf8vBonhQo51AMhf1P7oAkHfkYX0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gtAFps5pJCE+ATPMNaUctmXC7S1XGiFUSc3TS1u+70wz2zWXRJOccjSmNfv8KGlpE4qveA9fmd9QAG73kbGP2Nu1fvhhXmc6xAZzyIWLXnuzAo7Zworc8nDfLwwk15djWHGSFMkNbx8rM4C145hoZFjYNNwEOdA5fEavT54FBiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qYr8+xBZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BACEBC4CEF1;
	Fri,  5 Dec 2025 10:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764930487;
	bh=pkvT43jmHMZGx+gMf8vBonhQo51AMhf1P7oAkHfkYX0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qYr8+xBZSun+hkYWbe4wozkXTtknFZa+HkldPsyfOnnY3ZQEiqYTIh0h7Ef9fxayQ
	 bIxF4lYK/uq3wKNYTGDvSOlm96vLPCTo/L/AIr/HHPRKjXf1ZsORCtFC9vJK1aNDt7
	 PwLe3TiufThXN+0kONSMWn5Q6B1oH4M2VKrasLLCglhuXk1Ou0nRiPSutJDd2mnR3e
	 F8+EJvyjOz7EvhoVyiNzciV6Px8Vrj8aYhJa9ch7d8c1dMbspJxLkv5nbwSjSR3Lwe
	 JgskYqpDT8TvVR9GJyd3cJo+Y3yFs3JW+19JjjmYNdIUrDmnmXmr9zznnOfuQ3SExH
	 gwx+Op3hZek6w==
Message-ID: <4e7f40fc-114c-4786-86f7-532dce6cb04c@kernel.org>
Date: Fri, 5 Dec 2025 10:28:03 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] tools/build: Add a feature test for libopenssl
To: Ian Rogers <irogers@google.com>, Namhyung Kim <namhyung@kernel.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: bpf@vger.kernel.org, James Clark <james.clark@linaro.org>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org,
 KP Singh <kpsingh@kernel.org>
References: <20251203232924.1119206-1-namhyung@kernel.org>
 <CAP-5=fU=G75jpsG-X6pa8_rdKapxVc615CqvcdSPBFesj02D6A@mail.gmail.com>
 <aTGz9kFQk2xNvsbC@x1> <aTIeuLOcc6c7RWUz@google.com>
 <CAP-5=fVRjs9Dw=_8B9NRkWxgZKn_yg5XEYXhc_UNi9HGz-R23Q@mail.gmail.com>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <CAP-5=fVRjs9Dw=_8B9NRkWxgZKn_yg5XEYXhc_UNi9HGz-R23Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

2025-12-04 22:27 UTC-0800 ~ Ian Rogers <irogers@google.com>
> On Thu, Dec 4, 2025 at 3:52 PM Namhyung Kim <namhyung@kernel.org> wrote:
>>
>> On Thu, Dec 04, 2025 at 01:16:54PM -0300, Arnaldo Carvalho de Melo wrote:
>>> On Wed, Dec 03, 2025 at 04:34:56PM -0800, Ian Rogers wrote:
>>>> On Wed, Dec 3, 2025 at 3:29 PM Namhyung Kim <namhyung@kernel.org> wrote:
>>>>>
>>>>> It's used by bpftool and the kernel build.  Let's add a feature test so
>>>>> that perf can decide what to do based on the availability.
>>>>
>>>> It seems strange to add a feature test that bpftool is missing and
>>>> then use it only in the perf build. The signing of bpf programs isn't
>>>
>>> It is strange indeed, I agree that since we don't use BPF signing at
>>> this point in the perf BPf skels, then we could just bootstrap a bpftool
>>> without such feature and continue building the existing features.
>>>
>>> Adding the bpftool maintainer to the CC list, Quentin?
>>
>> I've already talked to Quentin and they want libopenssl as a
>> requirement.
>>
>> https://lore.kernel.org/linux-perf-users/e44f70bf-8f50-4a4b-97b8-eaf988aabced@kernel.org/
> 
> You can have libopenssl as a requirement and have a bootstrap bpftool
> that doesn't require it, as the bootstrap version only provides
> minimal features typically to just build bpftool. You can also have
> libopenssl as a requirement and have a feature test that fails in the
> bpftool build saying you are missing a requirement. Having the perf
> build detect that a feature for the bpftool dependency is missing is
> fine as we can then recommend installing bpftool or the missing
> dependency, but doing this without bpftool also doing something just
> seems inconsistent.
> 
> Thanks,
> Ian


From bpftool's perspective, it doesn't really make sense to skip the
OpenSSL dependency for the bootstrap version, given that we want to ship
the main binary with the signing feature: so you could build a bootstrap
version without signing, but you won't be able to use it to build the
final binary because, well, you miss a required dependency.

This being said, if it really makes it easier for you to build perf, I'd
be open to adjusting the bootstrap version, as long as it doesn't affect
the final bpftool build. It might lead to further headaches if someone
needs to sign the BPF programs when building perf in the future though.

I'm also OK with adding a dependency check with a simple build error for
bpftool, although we don't currently do it for other required
dependencies in bpftool.

Quentin

