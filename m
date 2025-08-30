Return-Path: <bpf+bounces-67060-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F4111B3CDF3
	for <lists+bpf@lfdr.de>; Sat, 30 Aug 2025 19:14:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B00A1898741
	for <lists+bpf@lfdr.de>; Sat, 30 Aug 2025 17:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DFCD2C2368;
	Sat, 30 Aug 2025 17:14:06 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from plesk.hostmyservers.fr (plesk.hostmyservers.fr [45.145.164.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F74B21D596;
	Sat, 30 Aug 2025 17:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.164.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756574046; cv=none; b=eUevmMFk0HTJ4ZsUWw0145b0MPJtycg/NbbGqEuIzcr5GbWEvjnbJ7hvhNJudIZ44fsHJtGvFasvAICk1NMTOiV8Cgj0oegEQ7WpUJ68SPKFF0/kU2TuClTTl5HfBer2jCpM6PcUfRPKu6qvTjAvUj7lvcLiJx1ZqNZnb9ppTr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756574046; c=relaxed/simple;
	bh=BFV2qBykmA4dQmwoWq0L3nklRNp3WIWQ5UhnVa+lq/s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WcTIRy/h9nCavAkFtRqbdReGnU32CNVioVRnXEQ7/Of8txpYPCOP5H24I0p/WOLdmuJYjK6P3U9bj18yTR/wz/zWwk6iTR5zk4wZSNeiki0gEw+a5/RSI4vGbd8yNrLocKn2YQ+odoXvzt5yNuxaoKwFfeYtWsAmFD9cO+S0fWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arnaud-lcm.com; spf=pass smtp.mailfrom=arnaud-lcm.com; arc=none smtp.client-ip=45.145.164.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arnaud-lcm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arnaud-lcm.com
Received: from [IPV6:2a0d:e487:419e:c142:105:2b06:c3cd:a390] (unknown [IPv6:2a0d:e487:419e:c142:105:2b06:c3cd:a390])
	by plesk.hostmyservers.fr (Postfix) with ESMTPSA id 887504014C;
	Sat, 30 Aug 2025 17:13:52 +0000 (UTC)
Authentication-Results: Plesk;
        spf=pass (sender IP is 2a0d:e487:419e:c142:105:2b06:c3cd:a390) smtp.mailfrom=contact@arnaud-lcm.com smtp.helo=[IPV6:2a0d:e487:419e:c142:105:2b06:c3cd:a390]
Received-SPF: pass (Plesk: connection is authenticated)
Message-ID: <c2d982c2-9593-4ac7-91d6-635b94f52d4e@arnaud-lcm.com>
Date: Sat, 30 Aug 2025 19:13:50 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v5 2/2] bpf: fix stackmap overflow check in
 __bpf_get_stackid()
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Song Liu <song@kernel.org>
Cc: Yonghong Song <yonghong.song@linux.dev>,
 Martin KaFai Lau <martin.lau@linux.dev>, Andrii Nakryiko
 <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Eduard <eddyz87@gmail.com>, Hao Luo <haoluo@google.com>,
 John Fastabend <john.fastabend@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
 KP Singh <kpsingh@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>,
 syzbot+c9b724fbb41cf2538b7b@syzkaller.appspotmail.com,
 syzkaller-bugs <syzkaller-bugs@googlegroups.com>
References: <20250826212229.143230-1-contact@arnaud-lcm.com>
 <20250826212352.143299-1-contact@arnaud-lcm.com>
 <CAADnVQ+6bV3h3i-A1LHbEk=nY_PMx69BiogWjf5GtGaLxWSQVg@mail.gmail.com>
 <CAPhsuW5P4sOHmMCmVTZw2vfuz7Rny-xkhuPkRBitfoATQkm=eA@mail.gmail.com>
 <CAADnVQK=3xigzt-pCat5OF29xT_F7-5rXDOMG+_FLSS0jRoWsQ@mail.gmail.com>
Content-Language: en-US
From: "Lecomte, Arnaud" <contact@arnaud-lcm.com>
In-Reply-To: 
 <CAADnVQK=3xigzt-pCat5OF29xT_F7-5rXDOMG+_FLSS0jRoWsQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: <175657403517.22626.17757478870134396004@Plesk>
X-PPP-Vhost: arnaud-lcm.com


On 30/08/2025 02:28, Alexei Starovoitov wrote:
> On Fri, Aug 29, 2025 at 11:50 AM Song Liu <song@kernel.org> wrote:
>> On Fri, Aug 29, 2025 at 10:29 AM Alexei Starovoitov
>> <alexei.starovoitov@gmail.com> wrote:
>> [...]
>>>>   static long __bpf_get_stackid(struct bpf_map *map,
>>>> -                             struct perf_callchain_entry *trace, u64 flags)
>>>> +                             struct perf_callchain_entry *trace, u64 flags, u32 max_depth)
>>>>   {
>>>>          struct bpf_stack_map *smap = container_of(map, struct bpf_stack_map, map);
>>>>          struct stack_map_bucket *bucket, *new_bucket, *old_bucket;
>>>> @@ -263,6 +263,8 @@ static long __bpf_get_stackid(struct bpf_map *map,
>>>>
>>>>          trace_nr = trace->nr - skip;
>>>>          trace_len = trace_nr * sizeof(u64);
>>>> +       trace_nr = min(trace_nr, max_depth - skip);
>>>> +
>>> The patch might have fixed this particular syzbot repro
>>> with OOB in stackmap-with-buildid case,
>>> but above two line looks wrong.
>>> trace_len is computed before being capped by max_depth.
>>> So non-buildid case below is using
>>> memcpy(new_bucket->data, ips, trace_len);
>>>
>>> so OOB is still there?
>> +1 for this observation.
>>
>> We are calling __bpf_get_stackid() from two functions: bpf_get_stackid
>> and bpf_get_stackid_pe. The check against max_depth is only needed
>> from bpf_get_stackid_pe, so it is better to just check here.
> Good point.
Nice catch, thanks !
>
>> I have got the following on top of patch 1/2. This makes more sense to
>> me.
>>
>> PS: The following also includes some clean up in __bpf_get_stack.
>> I include those because it also uses stack_map_calculate_max_depth.
>>
>> Does this look better?
> yeah. It's certainly cleaner to avoid adding extra arg to
> __bpf_get_stackid()
>
Are Song patches going to be applied then ?  Or should I raise a new 
revision
  of the patch with Song's modifications with a Co-developped tag ?
Thanks for your guidance in advance,
Arnaud


