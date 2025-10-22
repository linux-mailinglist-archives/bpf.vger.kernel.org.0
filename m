Return-Path: <bpf+bounces-71800-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A57D3BFD284
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 18:25:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46A5818C02C1
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 16:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D13AA3587DC;
	Wed, 22 Oct 2025 16:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tUminb+T"
X-Original-To: bpf@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D2C03587CC
	for <bpf@vger.kernel.org>; Wed, 22 Oct 2025 16:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761149389; cv=none; b=HSUPNL7RyawasbRulAnkJDZGw3pmzKd/YKrce27n3fM5BKhFUvX20cCcdnIlacub/8xzgmYbyyJIfLqSSp7YrZKf4ndCJ8qQHl2pEW2ikAZZiBeirFmm7MJDGoEzPNMaa2eXSsz8dcAIwoE2B7HtOh5WluO9K9W2xdWi1n2WECc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761149389; c=relaxed/simple;
	bh=kCv5GZq3aXFKjf+qpb+MVrtS6nZnSsKamPeJnxcujeI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aDoyiPme32NCnd4D02R6kr3DcVlsfjRDRqgUSyHLhORT5A19jATVU/pGrm5vJaFg4aOWXjpU6ha1aeNkkhUOXw3F8lRT4TjQGGwu4H03tH+mbSURdmikdj5WjZ/G7QLH6LBvoIK5Kpd1uCc6xAVZc2Qx4KLltM+ROjFD6Cy0xX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tUminb+T; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <e2e9b239-784f-411f-bd1b-8fcf103609ff@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761149375;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h+0kkqV8nNznZBElyk26pXakcabrm8PG0JX9d48AtfQ=;
	b=tUminb+TWDKYU6LcCoz+iY2hUJVKaArB5uQrLkFnzOV1rSKYF4nFzcobQJ1tV9sJgp6M5J
	zd3wjncFIrF6ctmnrzNOoL85fSSKUGDjjJbzALthdTP2aCnvFUFGkH50JZjFVaKoYaSHxL
	5pLa08nwYoq8MUhb3s4iv3LwdZ+v7GU=
Date: Thu, 23 Oct 2025 00:08:32 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v4 2/2] bpf: Use per-cpu BPF callchain entry to
 save callchain
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, Song Liu <song@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 "linux-perf-use." <linux-perf-users@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>
References: <20251021160633.3046301-1-chen.dylane@linux.dev>
 <20251021160633.3046301-3-chen.dylane@linux.dev>
 <CAADnVQJ2BrLy1FVEQmnN33ZqNZn0Nge1n6V89=p4NptjQNyHog@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Tao Chen <chen.dylane@linux.dev>
In-Reply-To: <CAADnVQJ2BrLy1FVEQmnN33ZqNZn0Nge1n6V89=p4NptjQNyHog@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2025/10/22 01:28, Alexei Starovoitov 写道:
> On Tue, Oct 21, 2025 at 9:07 AM Tao Chen <chen.dylane@linux.dev> wrote:
>>
>> As Alexei noted, get_perf_callchain() return values may be reused
>> if a task is preempted after the BPF program enters migrate disable
>> mode. Drawing on the per-cpu design of bpf_bprintf_buffers,
>> per-cpu BPF callchain entry is used here.
>>
>> Signed-off-by: Tao Chen <chen.dylane@linux.dev>
>> ---
>>   kernel/bpf/stackmap.c | 98 ++++++++++++++++++++++++++++++++-----------
>>   1 file changed, 73 insertions(+), 25 deletions(-)
>>
>> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
>> index 94e46b7f340..97028d39df1 100644
>> --- a/kernel/bpf/stackmap.c
>> +++ b/kernel/bpf/stackmap.c
>> @@ -31,6 +31,52 @@ struct bpf_stack_map {
>>          struct stack_map_bucket *buckets[] __counted_by(n_buckets);
>>   };
>>
>> +struct bpf_perf_callchain_entry {
>> +       u64 nr;
>> +       u64 ip[PERF_MAX_STACK_DEPTH];
>> +};
>> +
>> +#define MAX_PERF_CALLCHAIN_PREEMPT 3
>> +static DEFINE_PER_CPU(struct bpf_perf_callchain_entry[MAX_PERF_CALLCHAIN_PREEMPT],
>> +                     bpf_perf_callchain_entries);
>> +static DEFINE_PER_CPU(int, bpf_perf_callchain_preempt_cnt);
> 
> This is too much extra memory. Above adds 1k * 3 * num_cpus.
> Let's reuse perf callchains.
> Especially since they're controlled by perf_event_max_stack sysctl.
> See Peter's suggestion in v3.
> And for the future don't respin so quickly.

Ok, let's base our discussion on v3, sorry for the overly rapid version 
iterations impacted the maintainers' review process, i will respin 
slowly, thanks.

-- 
Best Regards
Tao Chen

