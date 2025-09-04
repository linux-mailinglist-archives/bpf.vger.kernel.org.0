Return-Path: <bpf+bounces-67517-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (unknown [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AAD3B449FC
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 00:55:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 924F816B8F5
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 22:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0B7F2F4A08;
	Thu,  4 Sep 2025 22:53:51 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from plesk.hostmyservers.fr (plesk.hostmyservers.fr [45.145.164.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71594273D6C;
	Thu,  4 Sep 2025 22:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.164.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757026431; cv=none; b=iZtcBuVpTPiOmf0MlziSKKh9XTvaAkOOkgaFAkShXRdQ4GeJdey+n80myhyhGUSYwZcsHRFlXobBr+b861DaGJlZQUUJCJhfMt9ZudNSyxOuj1PHGx7vpQurquI/jRRsVtjtqwVrnYMIKXRVtGzDybh+Z4LcSKfGgutFoPBdhng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757026431; c=relaxed/simple;
	bh=qbNI5VHkpI3jZWTclCz4prtW+t8aTKNshNzePv2EdU8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HUefEX+LUTKBX5Nm5TtrfuRcPGtRzxHL6GAEifs/EV0LxOUePPDqGNjJ4qgBPUTrmBBGYKLPLySj7myiw63gmcY6rPeNYjIHI/KeV1EPSVCeeMJ0R6oF7HZqJ1p5QI/pSF/3zYDgR1gQZvgr1PHc29AySpeDlsPaU+vq/CxfTqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arnaud-lcm.com; spf=pass smtp.mailfrom=arnaud-lcm.com; arc=none smtp.client-ip=45.145.164.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arnaud-lcm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arnaud-lcm.com
Received: from [IPV6:2a01:e0a:3e8:c0d0:74c4:9b58:271e:cbdf] (unknown [IPv6:2a01:e0a:3e8:c0d0:74c4:9b58:271e:cbdf])
	by plesk.hostmyservers.fr (Postfix) with ESMTPSA id 3391A41E6B;
	Thu,  4 Sep 2025 22:53:47 +0000 (UTC)
Authentication-Results: Plesk;
        spf=pass (sender IP is 2a01:e0a:3e8:c0d0:74c4:9b58:271e:cbdf) smtp.mailfrom=contact@arnaud-lcm.com smtp.helo=[IPV6:2a01:e0a:3e8:c0d0:74c4:9b58:271e:cbdf]
Received-SPF: pass (Plesk: connection is authenticated)
Message-ID: <090dcc3c-f9a6-4ff8-873f-e0725329a94d@arnaud-lcm.com>
Date: Fri, 5 Sep 2025 00:53:46 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v7 3/3] bpf: fix stackmap overflow check in
 __bpf_get_stackid()
To: Song Liu <song@kernel.org>, alexei.starovoitov@gmail.com,
 yonghong.song@linux.dev
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
 daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com,
 john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org,
 linux-kernel@vger.kernel.org, martin.lau@linux.dev, sdf@fomichev.me,
 syzbot+c9b724fbb41cf2538b7b@syzkaller.appspotmail.com,
 syzkaller-bugs@googlegroups.com
References: <20250903234052.29678-1-contact@arnaud-lcm.com>
 <20250903234325.30212-1-contact@arnaud-lcm.com>
 <f6e9710a-a5bf-4af9-8c0d-d81d28c3040c@kernel.org>
Content-Language: en-US
From: "Lecomte, Arnaud" <contact@arnaud-lcm.com>
In-Reply-To: <f6e9710a-a5bf-4af9-8c0d-d81d28c3040c@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: <175702642777.31109.3208251421253869888@Plesk>
X-PPP-Vhost: arnaud-lcm.com


On 05/09/2025 00:45, Song Liu wrote:
>
> On 9/3/25 4:43 PM, Arnaud Lecomte wrote:
>> Syzkaller reported a KASAN slab-out-of-bounds write in 
>> __bpf_get_stackid()
>> when copying stack trace data. The issue occurs when the perf trace
>>   contains more stack entries than the stack map bucket can hold,
>>   leading to an out-of-bounds write in the bucket's data array.
>>
>> Changes in v2:
>>   - Fixed max_depth names across get stack id
>>
>> Changes in v4:
>>   - Removed unnecessary empty line in __bpf_get_stackid
>>
>> Changs in v6:
>>   - Added back trace_len computation in __bpf_get_stackid
>>
>> Link to v6: 
>> https://lore.kernel.org/all/20250903135348.97884-1-contact@arnaud-lcm.com/
>>
>> Reported-by: syzbot+c9b724fbb41cf2538b7b@syzkaller.appspotmail.com
>> Closes: https://syzkaller.appspot.com/bug?extid=c9b724fbb41cf2538b7b
>> Fixes: ee2a098851bf ("bpf: Adjust BPF stack helper functions to 
>> accommodate skip > 0")
>> Signed-off-by: Arnaud Lecomte <contact@arnaud-lcm.com>
>> Acked-by: Yonghong Song <yonghong.song@linux.dev>
>
> For future patches, please keep the "Changes in vX.." at the end of
Good to know, thanks !
>
> your commit log and after a "---". IOW, something like
>
>
> Acked-by: Yonghong Song <yonghong.song@linux.dev>
>
> ---
>
> changes in v2:
>
> ...
>
> ---
>
> kernel/bpf/stackmap.c | 8 ++++++++
>
>
> In this way, the "changes in vXX" part will be removed by git-am.
>
>> ---
>>   kernel/bpf/stackmap.c | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
>> index 9f3ae426ddc3..29e05c9ff1bd 100644
>> --- a/kernel/bpf/stackmap.c
>> +++ b/kernel/bpf/stackmap.c
>> @@ -369,6 +369,7 @@ BPF_CALL_3(bpf_get_stackid_pe, struct 
>> bpf_perf_event_data_kern *, ctx,
>>   {
>>       struct perf_event *event = ctx->event;
>>       struct perf_callchain_entry *trace;
>> +    u32 elem_size, max_depth;
>>       bool kernel, user;
>>       __u64 nr_kernel;
>>       int ret;
>> @@ -390,11 +391,15 @@ BPF_CALL_3(bpf_get_stackid_pe, struct 
>> bpf_perf_event_data_kern *, ctx,
>>           return -EFAULT;
>>         nr_kernel = count_kernel_ip(trace);
>> +    elem_size = stack_map_data_size(map);
>>         if (kernel) {
>>           __u64 nr = trace->nr;
>>             trace->nr = nr_kernel;
>
> this trace->nr = is useless.
>
>> +        max_depth =
>> +            stack_map_calculate_max_depth(map->value_size, 
>> elem_size, flags);
>> +        trace->nr = min_t(u32, nr_kernel, max_depth);
>>           ret = __bpf_get_stackid(map, trace, flags);
>>             /* restore nr */
>> @@ -407,6 +412,9 @@ BPF_CALL_3(bpf_get_stackid_pe, struct 
>> bpf_perf_event_data_kern *, ctx,
>>               return -EFAULT;
>>             flags = (flags & ~BPF_F_SKIP_FIELD_MASK) | skip;
>> +        max_depth =
>> +            stack_map_calculate_max_depth(map->value_size, 
>> elem_size, flags);
>> +        trace->nr = min_t(u32, trace->nr, max_depth);
>>           ret = __bpf_get_stackid(map, trace, flags);
>
> I missed this part earlier. Here we need to restore trace->nr, just 
> like we did

>
> in the "if (kernel)" branch.
>
Make sense, thanks !
> Thanks,
>
> Song
>
>>       }
>>       return ret;
>
Thanks,
Arnaud

