Return-Path: <bpf+bounces-71274-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DC38CBEC993
	for <lists+bpf@lfdr.de>; Sat, 18 Oct 2025 09:51:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B4E7D4E06DF
	for <lists+bpf@lfdr.de>; Sat, 18 Oct 2025 07:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CD41287247;
	Sat, 18 Oct 2025 07:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Y2qR6SgL"
X-Original-To: bpf@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B511282EB
	for <bpf@vger.kernel.org>; Sat, 18 Oct 2025 07:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760773905; cv=none; b=P2Wj9ymgKFprP3L8gd1UHxVlNLGdogrF8PHC6tEaPEkMRJIKl8OIKeQH9xyxDtwF1k4xhSpPeFhX/q/lQ5Xr9KdQdPNU+qQQ5I2sv/pveIiHSYi+aOxJXFwL4DM3DtKf2HbayVE1RKgZU5piCCZilMTEhQkpDgfOo8yM7dIDGmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760773905; c=relaxed/simple;
	bh=YDaatv130rfc9YWd+DrPk6GZoVEeS24QutfZ+cuZR60=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i9TEUu/9zekqi26eIjsaiPjKqrmSd13729JT0eZFrqjDDnMSMHV980ZQUTwIrARUXOFXy8p8ZI478Yc6r3u5+KS4ct2Zh+n74mD2RifrgM3QQOuGihESmnQHHF7wbOzoOGi1+8t95CPV8YfJ9xQOHO0x3lza8dQTMs3+gPt5ie0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Y2qR6SgL; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <abd75aed-9ff2-4e6d-8fec-2b118264efa9@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760773898;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UzIpLxhpXHd7W2m8i5xoFIEHI3nftwPx3RFrt+zivx4=;
	b=Y2qR6SgLX/fevxvhax5l9j1nNiPMyAzIjswtZ/PyI81C4v9mK2TYwh/cGOx+r8/PD575cP
	vitqOxHpHWSIzpZLxeUAdGLJM6bCqNLwnJBf+o9RFFeqoGY6q5+qrIuuZhs7G4kAsmvxPR
	1WK48uBsFzLbfw89fu9B2z4A+aLy83s=
Date: Sat, 18 Oct 2025 15:51:22 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH bpf-next v2 2/2] bpf: Pass external callchain entry to
 get_perf_callchain
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, Song Liu <song@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 "linux-perf-use." <linux-perf-users@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>
References: <20251014100128.2721104-1-chen.dylane@linux.dev>
 <20251014100128.2721104-3-chen.dylane@linux.dev> <aO4-jAA5RIUY2yxc@krava>
 <CAADnVQLoF49pu8CT81FV1ddvysQzvYT4UO1P21fVxnafnO5vrQ@mail.gmail.com>
 <CAEf4BzbAt_3co0s-+DspnHuJryG2DKPLP9OwsN0bWWnbd5zsmQ@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Tao Chen <chen.dylane@linux.dev>
In-Reply-To: <CAEf4BzbAt_3co0s-+DspnHuJryG2DKPLP9OwsN0bWWnbd5zsmQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2025/10/17 04:39, Andrii Nakryiko 写道:
> On Tue, Oct 14, 2025 at 8:02 AM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
>>
>> On Tue, Oct 14, 2025 at 5:14 AM Jiri Olsa <olsajiri@gmail.com> wrote:
>>>
>>> On Tue, Oct 14, 2025 at 06:01:28PM +0800, Tao Chen wrote:
>>>> As Alexei noted, get_perf_callchain() return values may be reused
>>>> if a task is preempted after the BPF program enters migrate disable
>>>> mode. Drawing on the per-cpu design of bpf_perf_callchain_entries,
>>>> stack-allocated memory of bpf_perf_callchain_entry is used here.
>>>>
>>>> Signed-off-by: Tao Chen <chen.dylane@linux.dev>
>>>> ---
>>>>   kernel/bpf/stackmap.c | 19 +++++++++++--------
>>>>   1 file changed, 11 insertions(+), 8 deletions(-)
>>>>
>>>> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
>>>> index 94e46b7f340..acd72c021c0 100644
>>>> --- a/kernel/bpf/stackmap.c
>>>> +++ b/kernel/bpf/stackmap.c
>>>> @@ -31,6 +31,11 @@ struct bpf_stack_map {
>>>>        struct stack_map_bucket *buckets[] __counted_by(n_buckets);
>>>>   };
>>>>
>>>> +struct bpf_perf_callchain_entry {
>>>> +     u64 nr;
>>>> +     u64 ip[PERF_MAX_STACK_DEPTH];
>>>> +};
>>>> +
> 
> we shouldn't introduce another type, there is perf_callchain_entry in
> linux/perf_event.h, what's the problem with using that?

perf_callchain_entry uses flexible array, DEFINE_PER_CPU seems do not
create buffer for this, for ease of use, the size of the ip array has 
been explicitly defined.

struct perf_callchain_entry {
         u64                             nr;
         u64                             ip[]; /* 
/proc/sys/kernel/perf_event_max_stack */
};

> 
>>>>   static inline bool stack_map_use_build_id(struct bpf_map *map)
>>>>   {
>>>>        return (map->map_flags & BPF_F_STACK_BUILD_ID);
>>>> @@ -305,6 +310,7 @@ BPF_CALL_3(bpf_get_stackid, struct pt_regs *, regs, struct bpf_map *, map,
>>>>        bool user = flags & BPF_F_USER_STACK;
>>>>        struct perf_callchain_entry *trace;
>>>>        bool kernel = !user;
>>>> +     struct bpf_perf_callchain_entry entry = { 0 };
>>>
>>> so IIUC having entries on stack we do not need to do preempt_disable
>>> you had in the previous version, right?
>>>
>>> I saw Andrii's justification to have this on the stack, I think it's
>>> fine, but does it have to be initialized? it seems that only used
>>> entries are copied to map
>>
>> No. We're not adding 1k stack consumption.
> 
> Right, and I thought we concluded as much last time, so it's a bit
> surprising to see this in this patch.
> 

Ok, I feel like I'm missing some context from our previous exchange.

> Tao, you should go with 3 entries per CPU used in a stack-like
> fashion. And then passing that entry into get_perf_callchain() (to
> avoid one extra copy).
>

Got it. It is more clearer, will change it in v3.

>>
>> pw-bot: cr


-- 
Best Regards
Tao Chen

