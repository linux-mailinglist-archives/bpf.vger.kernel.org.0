Return-Path: <bpf+bounces-74410-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95009C57C20
	for <lists+bpf@lfdr.de>; Thu, 13 Nov 2025 14:45:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25C50503298
	for <lists+bpf@lfdr.de>; Thu, 13 Nov 2025 13:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AAB0352927;
	Thu, 13 Nov 2025 13:26:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from plesk.hostmyservers.fr (plesk.hostmyservers.fr [45.145.164.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF8093446AA;
	Thu, 13 Nov 2025 13:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.164.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763040382; cv=none; b=V8N7R2Q+R7GpwRVCppEhHtEJUwBAOusdqIXRBm2WK00gBRu1Vh/TKEyGvORu2NIS0XosjMOVo80WOppyWO+U1Z8N43wYceCUCEnuQWT5rh7rURJq87FIzmnsrE3hpfj7x98y/ivBbqTJSfkvsWSazu7rRqUTfVi2PoBx7ihewg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763040382; c=relaxed/simple;
	bh=Rh3bzVGApBGQbzZkTO2BFKFs3NSxoPrIjQ2As0xPEjo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b2kiqgTLE2DHbbrqFwRFNw0aEDx53ouZUdI3cHz4ICVSPKEYtSCfOxCWhOeRDQQG7I9nsV3Ka8gMDHoUhJ6j8q9Qz0vG1dAuV9aQAbYFjyGevyT0WlkN9+80fFFNLbgiRwJsRKsxPfh7d1TlJdO+5EfsgBEU1ntatYCPSypgNSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arnaud-lcm.com; spf=pass smtp.mailfrom=arnaud-lcm.com; arc=none smtp.client-ip=45.145.164.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arnaud-lcm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arnaud-lcm.com
Received: from [192.168.7.227] (54-240-197-234.amazon.com [54.240.197.234])
	by plesk.hostmyservers.fr (Postfix) with ESMTPSA id 7BF1A40C10;
	Thu, 13 Nov 2025 13:26:11 +0000 (UTC)
Authentication-Results: Plesk;
        spf=pass (sender IP is 54.240.197.234) smtp.mailfrom=contact@arnaud-lcm.com smtp.helo=[192.168.7.227]
Received-SPF: pass (Plesk: connection is authenticated)
Message-ID: <43aa4ed3-d9c0-4f60-b850-d345cb85fe41@arnaud-lcm.com>
Date: Thu, 13 Nov 2025 13:26:10 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3] bpf: Clamp trace length in __bpf_get_stack to
 fix OOB write
To: Brahmajit Das <listout@listout.xyz>
Cc: syzbot+d1b7fa1092def3628bd7@syzkaller.appspotmail.com, andrii@kernel.org,
 ast@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net,
 eddyz87@gmail.com, haoluo@google.com, john.fastabend@gmail.com,
 jolsa@kernel.org, kpsingh@kernel.org, linux-kernel@vger.kernel.org,
 martin.lau@linux.dev, netdev@vger.kernel.org, sdf@fomichev.me,
 song@kernel.org, syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
References: <691231dc.a70a0220.22f260.0101.GAE@google.com>
 <20251111081254.25532-1-listout@listout.xyz>
 <3f79436c-d343-46ff-8559-afb7da24a44d@arnaud-lcm.com>
 <kjjn3mvfp2gf5iyeyukthgluayrkefonfmqbugrsreeeqfwde5@rxrzxrsobt54>
Content-Language: en-US
From: "Lecomte, Arnaud" <contact@arnaud-lcm.com>
In-Reply-To: <kjjn3mvfp2gf5iyeyukthgluayrkefonfmqbugrsreeeqfwde5@rxrzxrsobt54>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: <176304037239.10917.10498323386673519218@Plesk>
X-PPP-Vhost: arnaud-lcm.com


On 13/11/2025 12:49, Brahmajit Das wrote:
> On 12.11.2025 08:40, 'Lecomte, Arnaud' via syzkaller-bugs wrote:
>> I am a not sure this is the right solution and I am scared that by
>> forcing this clamping, we are hiding something else.
>> If we have a look at the code below:
>> ```
>>
>> |
>>
>> 	if (trace_in) {
>> 		trace = trace_in;
>> 		trace->nr = min_t(u32, trace->nr, max_depth);
>> 	} else if (kernel && task) {
>> 		trace = get_callchain_entry_for_task(task, max_depth);
>> 	} else {
>> 		trace = get_perf_callchain(regs, kernel, user, max_depth,
>> 					crosstask, false, 0);
>> 	} ``` trace should be (if I remember correctly) clamped there. If not, it
>> might hide something else. I would like to have a look at the return for
>> each if case through gdb. |
> Hi Arnaud,
> So I've been debugging this the reproducer always takes the else branch
> so trace holds whatever get_perf_callchain returns; in this situation.
>
> I mostly found it to be a value around 4.
>
> In some case the value would exceed to something 27 or 44, just after
> the code block
>
> 	if (unlikely(!trace) || trace->nr < skip) {
> 		if (may_fault)
> 			rcu_read_unlock();
> 		goto err_fault;
> 	}
>
> So I'm assuming there's some race condition that might be going on
> somewhere.
Which value ? trace->nr ?
> I'm still debugging bug I'm open to ideas and definitely I could be
> wrong here, please feel free to correct/point out.

I should be able to have a look tomorrow evening as I am currently a bit 
overloaded
with my work.

Thanks,
Arnaud


