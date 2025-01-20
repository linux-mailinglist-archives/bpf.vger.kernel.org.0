Return-Path: <bpf+bounces-49303-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BFC9A1735C
	for <lists+bpf@lfdr.de>; Mon, 20 Jan 2025 20:54:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FE4B3A3328
	for <lists+bpf@lfdr.de>; Mon, 20 Jan 2025 19:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 628E51EF0A0;
	Mon, 20 Jan 2025 19:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="o+rUFHFx"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 537FB1B6D15;
	Mon, 20 Jan 2025 19:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737402879; cv=none; b=AXCnwYgMhWhTtX87eIcTCK7DMjcFvoKLYqG/u/Ezp/XiCV5Ki9mmEyxrMvK9hMG7xumLGAkhUbtmliBpkhmzIt773T2TccsJiatN/9D6siDeXDnuu+yJlbz7Ah4xX8PNBuTBpYUn1W+UD8oDNYWIF/OsUhQNxdOxEarG7mxOCnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737402879; c=relaxed/simple;
	bh=DRMSYE3zECdvkJSIAOg9DSqmlASaadP0qC9BSopSrVA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XxUG3ohK1N+PVNAjN5K4ZsLyDXJBxbkE7SjWb8y4bQYeCktWv/oxo/JQVJaJPnidmHiUHBdhat9rxmBt9hqRB6ZmKG/yPhaTFhhs92xQvbklHPX7+cIKG543QNR8Fgijt0+iNym+CXnbi9PB0SXIYjqTxu2e/vSWhikmE0+VTy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=o+rUFHFx; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=n414qvSkpZPuD3bunFn6W43fcVJ3nBLlMz7IByHtm50=; b=o+rUFHFxTvDzr7Cxr8+hNheNtz
	IJs0Nfmk7QzejjnW5FWr/lrdfzsu6jAsAHRkC1HznCG2gyHO3Luw6xJlAD8dEAveRofhnxfzf7x2+
	OrlUkNe9kMjaZSBJW7CSq7a+6ubK5cPmeLrjo2silWeK+o30yYaOzHTkUONFbEDpEzpSGSCL0p9On
	gXIneDf4PS1KP9Z0G1HJu+MoPJSTW9AoaStnQhSasWBH85jN2bEsyD0bxwAMaLAo5a2WCWY6p3peW
	0QvpAwIn+quflbWBpXwLJqlZIImBWP6j8RBdHtud7HJe8amif9y0d63EP8Mg0AB5F0te9QThjBRpm
	g48Dy3TQ==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1tZxqy-000KXh-KH; Mon, 20 Jan 2025 20:54:32 +0100
Received: from [178.197.248.11] (helo=[192.168.1.114])
	by sslproxy03.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1tZxqx-0007qX-0w;
	Mon, 20 Jan 2025 20:54:31 +0100
Message-ID: <365689f8-12c1-44b3-a351-97e6f54c1928@iogearbox.net>
Date: Mon, 20 Jan 2025 20:54:30 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] samples/bpf: Add a trace tool with perf PMU counters
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Leo Yan <leo.yan@arm.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>,
 James Clark <james.clark@linaro.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
 Quentin Monnet <qmo@kernel.org>
References: <20250119153343.116795-1-leo.yan@arm.com>
 <ee0b3bb3-476b-4792-84e1-c53fa4dbabee@iogearbox.net>
 <20250120185033.GA261349@e132581.arm.com>
 <CAADnVQKrOi1cJrFUXuwacmbWCxR-oKRr_tTiyQJP0=jvnkXO3A@mail.gmail.com>
Content-Language: en-US
From: Daniel Borkmann <daniel@iogearbox.net>
Autocrypt: addr=daniel@iogearbox.net; keydata=
 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
In-Reply-To: <CAADnVQKrOi1cJrFUXuwacmbWCxR-oKRr_tTiyQJP0=jvnkXO3A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 1.0.7/27524/Mon Jan 20 10:37:47 2025)

On 1/20/25 8:38 PM, Alexei Starovoitov wrote:
> On Mon, Jan 20, 2025 at 10:50 AM Leo Yan <leo.yan@arm.com> wrote:
>> On Mon, Jan 20, 2025 at 05:18:23PM +0100, Daniel Borkmann wrote:
>>> On 1/19/25 4:33 PM, Leo Yan wrote:
>>>> Developers might need to profile a program with fine-grained
>>>> granularity.  E.g., a user case is to account the CPU cycles for a small
>>>> program or for a specific function within the program.
>>>>
>>>> This commit introduces a small tool with using eBPF program to read the
>>>> perf PMU counters for performance metrics.  As the first step, the four
>>>> counters are supported with the '-e' option: cycles, instructions,
>>>> branches, branch-misses.
>>>>
>>>> The '-r' option is provided for support raw event number.  This option
>>>> is mutually exclusive to the '-e' option, users either pass a raw event
>>>> number or a counter name.
>>>>
>>>> The tool enables the counters for the entire trace session in free-run
>>>> mode.  It reads the beginning values for counters when the profiled
>>>> program is scheduled in, and calculate the interval when the task is
>>>> scheduled out.  The advantage of this approach is to dismiss the
>>>> statistics noise (e.g. caused by the tool itself) as possible.
>>
>> [...]
>>
>>> Thanks for this work! Few suggestions.. the contents of samples/bpf/ are in process of being
>>> migrated into BPF selftests given they have been bit-rotting for quite some time, so we'd like
>>> to migrate missing coverage into BPF CI (see test_progs in tools/testing/selftests/bpf/). That
>>> could be one option, or an alternative is to extend bpftool for profiling BPF programs (see
>>> 47c09d6a9f67 ("bpftool: Introduce "prog profile" command")).
>>
>> Thanks for suggestions!
>>
>> The naming or info in the commit log might cause confuse.  The purpose
>> of this patch is to measure PMU counters for normal programs (not BPF
>> program specific).  To achieve profiling accuracy, it opens perf event
>> in thread mode, and support function based trace and can be userspace
>> mode only.
>>
>> My understanding for bpftool is for eBPF program specific.  I looked
>> into a bit the commit 47c09d6a9f67, it is nature for integrating the
>> tracing feature for eBPF program specific.  My patch is for tracing
>> normal userspace programs, I am not sure if this is really wanted by
>> bpftool.  I would like to hear opinions from bpftool maintainer before
>> proceeding.

Yes, that suggestion was if it would have been applicable also
for the existing bpftool (BPF program) profiling functionality.

>> My program mainly uses eBPF attaching to uprobe.  selftest/bpf has
>> contained the related functionality testing, actually I refered the
>> test for writing my code :).  So maybe it is not quite useful for
>> merging the code as a test?
>>
>> If both options are not ideal, I would spend time to land the
>> feature in perf tool - the perf tool has supported eBPF backend for
>> reading PMU counters, but it is absent function based profiling.
> 
> We don't add tools to kernel repo. bpftool is an exception
> because it's used during the selftest build.
> 'perf' is another exception for historical reasons.
> 
> This particular feature fits 'perf' the best.

Agree, looks like perf is the best target for integration then.

