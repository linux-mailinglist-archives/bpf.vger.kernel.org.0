Return-Path: <bpf+bounces-49298-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 86BE9A16FF8
	for <lists+bpf@lfdr.de>; Mon, 20 Jan 2025 17:18:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA43E1687EC
	for <lists+bpf@lfdr.de>; Mon, 20 Jan 2025 16:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1B731E98E6;
	Mon, 20 Jan 2025 16:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="lL1dGlO8"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4022B1E32D7;
	Mon, 20 Jan 2025 16:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737389911; cv=none; b=Wte+r+GP0C9okuwnSf+rysOOD2x7gHuYyRgpCqgx6cPUxFdmkNiaunixh9jPcQOVrKBnXWJg3ca2BciLnorJ4g95VaTJbfQV9GGs9qsq4tlKgQBQKnn/fTIBl2UJjNO8ZfMAsyV4r1sPdhiFpwFeFXDWesM0wFXhLUUMPukEiWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737389911; c=relaxed/simple;
	bh=fLyA2DnpQyaZWyU4QH6dNCbXtl2b8mR4B0tC5hvLyZ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=O9Z/+q06eNcXgxGG00HfhMplW3O8XkgvwR/VYLRfBBw1Z3bt1ixvSms7nA7CEWq2V5yunEF/yk3nCJEl278q7W8Y5pbMf23+6yr1PmE4DDhGETGfjMOxxMihSkopfdXSYipmNJNTW+0WVe/Wc3peqOhmbaMac00sd+je5adskLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=lL1dGlO8; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:To:Subject:MIME-Version:Date:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=AU23UdpEguOEy1G2duBwW07YoTAhSM3Z6nB7TsuSWxY=; b=lL1dGlO87jeTWl9o3qOjVVZKHJ
	gL2gnO+lL8cQ0EqLxVfOXIZPYz8v4RD2E/GUOq2jH7Z5quOy5LrRCbz55QBYp3sWXvNSQ6eyDZ64O
	jTVoodvCuokgefDL/7zFdQ3r4xq8JOJ7sUVsQ1W7orPfboBWSgZ6MORiN6TuXMgaFICdczNlyq6In
	JwafDnefjIhduN7pgjtD7bT3qUpl8BjRAtiqYDlfJaAJ5d1+HnW9POx0nMScY2b+Vj+1vj3gCS7Pm
	ol4RQSLqwwLHJsu2+kLqncA2PLny/RKh/KvQJwjn46WD5v004C8Y7jlW5hxerIF2eG4I/afe7BBHL
	ClhJVb8w==;
Received: from sslproxy04.your-server.de ([78.46.152.42])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1tZuTq-000IbT-01; Mon, 20 Jan 2025 17:18:26 +0100
Received: from [85.1.206.226] (helo=[192.168.1.114])
	by sslproxy04.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1tZuTo-0009MZ-2N;
	Mon, 20 Jan 2025 17:18:24 +0100
Message-ID: <ee0b3bb3-476b-4792-84e1-c53fa4dbabee@iogearbox.net>
Date: Mon, 20 Jan 2025 17:18:23 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] samples/bpf: Add a trace tool with perf PMU counters
To: Leo Yan <leo.yan@arm.com>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>,
 James Clark <james.clark@linaro.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 Quentin Monnet <qmo@kernel.org>
References: <20250119153343.116795-1-leo.yan@arm.com>
Content-Language: en-US
From: Daniel Borkmann <daniel@iogearbox.net>
Autocrypt: addr=daniel@iogearbox.net; keydata=
 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
In-Reply-To: <20250119153343.116795-1-leo.yan@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 1.0.7/27524/Mon Jan 20 10:37:47 2025)

Hi Leo,

On 1/19/25 4:33 PM, Leo Yan wrote:
> Developers might need to profile a program with fine-grained
> granularity.  E.g., a user case is to account the CPU cycles for a small
> program or for a specific function within the program.
> 
> This commit introduces a small tool with using eBPF program to read the
> perf PMU counters for performance metrics.  As the first step, the four
> counters are supported with the '-e' option: cycles, instructions,
> branches, branch-misses.
> 
> The '-r' option is provided for support raw event number.  This option
> is mutually exclusive to the '-e' option, users either pass a raw event
> number or a counter name.
> 
> The tool enables the counters for the entire trace session in free-run
> mode.  It reads the beginning values for counters when the profiled
> program is scheduled in, and calculate the interval when the task is
> scheduled out.  The advantage of this approach is to dismiss the
> statistics noise (e.g. caused by the tool itself) as possible.
> 
> The tool can support function based tracing.  By using the '-f' option,
> users can specify the traced function.  The eBPF program enables tracing
> at the function entry and disables trace upon exit from the function.
> 
> The '-u' option can be specified for tracing user mode only.
> 
> Below are several usage examples.
> 
> Trace CPU cycles for the whole program:
> 
>    # ./trace_counter -e cycles -- /mnt/sort
>    Or
>    # ./trace_counter -e cycles /mnt/sort
>    Create process for the workload.
>    Enable the event cycles.
>    Bubble sorting array of 3000 elements
>    551 ms
>    Finished the workload.
>    Event (cycles) statistics:
>     +-----------+------------------+
>     | CPU[0000] |         29093250 |
>     +-----------+------------------+
>     | CPU[0002] |         75672820 |
>     +-----------+------------------+
>     | CPU[0006] |       1067458735 |
>     +-----------+------------------+
>       Total     :       1172224805
> 
> Trace branches for the user mode only:
> 
>    # ./trace_counter -e branches -u -- /mnt/sort
>    Create process for the workload.
>    Enable the event branches.
>    Bubble sorting array of 3000 elements
>    541 ms
>    Finished the workload.
>    Event (branches) statistics:
>     +-----------+------------------+
>     | CPU[0007] |         88112669 |
>     +-----------+------------------+
>       Total     :         88112669
> 
> Trace instructions for the 'bubble_sort' function:
> 
>    # ./trace_counter -f bubble_sort -e instructions -- /mnt/sort
>    Create process for the workload.
>    Enable the event instructions.
>    Bubble sorting array of 3000 elements
>    541 ms
>    Finished the workload.
>    Event (instructions) statistics:
>     +-----------+------------------+
>     | CPU[0006] |       1169810201 |
>     +-----------+------------------+
>       Total     :       1169810201
>    Function (bubble_sort) duration statistics:
>       Count     :                5
>       Minimum   :        232009928
>       Maximum   :        236742006
>       Average   :        233962040
> 
> Trace the raw event '0x5' (L1D_TLB_REFILL):
> 
>    # ./trace_counter -r 0x5 -u -- /mnt/sort
>    Create process for the workload.
>    Enable the raw event 0x5.
>    Bubble sorting array of 3000 elements
>    540 ms
>    Finished the workload.
>    Event (0x5) statistics:
>     +-----------+------------------+
>     | CPU[0007] |              174 |
>     +-----------+------------------+
>       Total     :              174
> 
> Trace for the function and set CPU affinity for the profiled program:
> 
>    # ./trace_counter -f bubble_sort -x /mnt/sort -e cycles \
> 	-- taskset -c 2 /mnt/sort
>    Create process for the workload.
>    Enable the event cycles.
>    Bubble sorting array of 3000 elements
>    619 ms
>    Finished the workload.
>    Event (cycles) statistics:
>     +-----------+------------------+
>     | CPU[0002] |       1169913056 |
>     +-----------+------------------+
>       Total     :       1169913056
>    Function (bubble_sort) duration statistics:
>       Count     :                5
>       Minimum   :        232054101
>       Maximum   :        236769623
>       Average   :        233982611
> 
> The command above sets the CPU affinity with taskset command.  The
> profiled function 'bubble_sort' is in the executable '/mnt/sort' but not
> in the taskset binary.  The '-x' option is used to tell the tool the
> correct executable path.
> 
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
>   samples/bpf/Makefile             |   7 +-
>   samples/bpf/trace_counter.bpf.c  | 222 +++++++++++++
>   samples/bpf/trace_counter_user.c | 528 +++++++++++++++++++++++++++++++
>   3 files changed, 756 insertions(+), 1 deletion(-)
>   create mode 100644 samples/bpf/trace_counter.bpf.c
>   create mode 100644 samples/bpf/trace_counter_user.c

Thanks for this work! Few suggestions.. the contents of samples/bpf/ are in process of being
migrated into BPF selftests given they have been bit-rotting for quite some time, so we'd like
to migrate missing coverage into BPF CI (see test_progs in tools/testing/selftests/bpf/). That
could be one option, or an alternative is to extend bpftool for profiling BPF programs (see
47c09d6a9f67 ("bpftool: Introduce "prog profile" command")).

