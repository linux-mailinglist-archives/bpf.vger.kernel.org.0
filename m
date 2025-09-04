Return-Path: <bpf+bounces-67516-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9643FB44A09
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 00:59:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EC051C87804
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 22:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE99C2F4A08;
	Thu,  4 Sep 2025 22:52:36 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from plesk.hostmyservers.fr (plesk.hostmyservers.fr [45.145.164.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27FBE2F069E;
	Thu,  4 Sep 2025 22:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.164.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757026356; cv=none; b=NeX/WpQB2cGGRojdZtgm7F6Z2utQ6sNzLtiEPofoHxasQZJSmzdcpxpz3qoFw7xVk6yzClFOt7a+jecNkcBtrRNXNcyWq1t1j8p3ZXq50ZjuEgHSBpGZjEqH5ceQhDlZAnl1tLt6x7CKDFc5EddMq8f+zNNTdsuFOeC7l1c+1Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757026356; c=relaxed/simple;
	bh=Qx2E6EgBXwH1eGb+7uc1DPCtgGXckrFKQIHQJ7+0IWU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pRUPKhnj7XCI+edIy3bI2O+Xu0Sps6JdrX/T10TnXCTrvYyCHwSDh2cnepLJslwraTnHt4NrYjgxJoWXXUYWQJsQ8ppLFy/ecrEd3ixEB9P6CfZ66RXBaGE6oJyn41uCzb6i56MW+tn4DRSRGksvgk+HkX5yKyHaYu+p/cj28ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arnaud-lcm.com; spf=pass smtp.mailfrom=arnaud-lcm.com; arc=none smtp.client-ip=45.145.164.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arnaud-lcm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arnaud-lcm.com
Received: from [IPV6:2a01:e0a:3e8:c0d0:74c4:9b58:271e:cbdf] (unknown [IPv6:2a01:e0a:3e8:c0d0:74c4:9b58:271e:cbdf])
	by plesk.hostmyservers.fr (Postfix) with ESMTPSA id 7AD0E41C88;
	Thu,  4 Sep 2025 22:52:31 +0000 (UTC)
Authentication-Results: Plesk;
        spf=pass (sender IP is 2a01:e0a:3e8:c0d0:74c4:9b58:271e:cbdf) smtp.mailfrom=contact@arnaud-lcm.com smtp.helo=[IPV6:2a01:e0a:3e8:c0d0:74c4:9b58:271e:cbdf]
Received-SPF: pass (Plesk: connection is authenticated)
Message-ID: <31e8303f-5878-4027-a67a-770089cefbe1@arnaud-lcm.com>
Date: Fri, 5 Sep 2025 00:52:29 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v7 2/3] bpf: clean-up bounds checking in
 __bpf_get_stack
To: Song Liu <song@kernel.org>, alexei.starovoitov@gmail.com,
 yonghong.song@linux.dev
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
 daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com,
 john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org,
 linux-kernel@vger.kernel.org, martin.lau@linux.dev, sdf@fomichev.me,
 syzbot+c9b724fbb41cf2538b7b@syzkaller.appspotmail.com,
 syzkaller-bugs@googlegroups.com
References: <20250903233910.29431-1-contact@arnaud-lcm.com>
 <20250903234052.29678-1-contact@arnaud-lcm.com>
 <05b2c226-9a09-4541-a18c-8a21898846d0@kernel.org>
Content-Language: en-US
From: "Lecomte, Arnaud" <contact@arnaud-lcm.com>
In-Reply-To: <05b2c226-9a09-4541-a18c-8a21898846d0@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: <175702635210.29788.16105405578676765233@Plesk>
X-PPP-Vhost: arnaud-lcm.com


On 05/09/2025 00:40, Song Liu wrote:
>
> On 9/3/25 4:40 PM, Arnaud Lecomte wrote:
>> Clean-up bounds checking for trace->nr in
>> __bpf_get_stack by limiting it only to
>> max_depth.
>>
>> Signed-off-by: Arnaud Lecomte <contact@arnaud-lcm.com>
>> Cc: Song Lui <song@kernel.org>
>
> Typo in my name, which is "Song Liu".
>
> This looks right.
>
> Acked-by: Song Liu <song@kernel.org>
>
Oops sorry !
>> ---
>>   kernel/bpf/stackmap.c | 9 +++++----
>>   1 file changed, 5 insertions(+), 4 deletions(-)
>>
>> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
>> index ed707bc07173..9f3ae426ddc3 100644
>> --- a/kernel/bpf/stackmap.c
>> +++ b/kernel/bpf/stackmap.c
>> @@ -462,13 +462,15 @@ static long __bpf_get_stack(struct pt_regs 
>> *regs, struct task_struct *task,
>>       if (may_fault)
>>           rcu_read_lock(); /* need RCU for perf's callchain below */
>>   -    if (trace_in)
>> +    if (trace_in) {
>>           trace = trace_in;
>> -    else if (kernel && task)
>> +        trace->nr = min_t(u32, trace->nr, max_depth);
>> +    } else if (kernel && task) {
>>           trace = get_callchain_entry_for_task(task, max_depth);
>> -    else
>> +    } else {
>>           trace = get_perf_callchain(regs, 0, kernel, user, max_depth,
>>                          crosstask, false);
>> +    }
>>         if (unlikely(!trace) || trace->nr < skip) {
>>           if (may_fault)
>> @@ -477,7 +479,6 @@ static long __bpf_get_stack(struct pt_regs *regs, 
>> struct task_struct *task,
>>       }
>>         trace_nr = trace->nr - skip;
>> -    trace_nr = (trace_nr <= num_elem) ? trace_nr : num_elem;
>>       copy_len = trace_nr * elem_size;
>>         ips = trace->ip + skip;
>

