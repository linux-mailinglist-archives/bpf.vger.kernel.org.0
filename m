Return-Path: <bpf+bounces-36493-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AC979498F1
	for <lists+bpf@lfdr.de>; Tue,  6 Aug 2024 22:21:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD5531C227C9
	for <lists+bpf@lfdr.de>; Tue,  6 Aug 2024 20:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 075EC155726;
	Tue,  6 Aug 2024 20:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="md1NlrMY"
X-Original-To: bpf@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5011714901A
	for <bpf@vger.kernel.org>; Tue,  6 Aug 2024 20:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722975683; cv=none; b=FTWX9DHnf7ioUy7yufp7clVHpyYor30rr63Prph3ATDNhKlPwJ/FdE2dknBLC7KcGXwbYrojx/UsgFmQHS3AzWe1tQdWeY/mLZC5a4F7Ul1jNTZL/8UzUQ8057VFrPA9M1NMW0TMOQazS3Hfe9mkg6FkrqpIvaCo7XxPS7KPQvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722975683; c=relaxed/simple;
	bh=L8MIOXovRLFSU2CIOJtv9RfcaDy1jGiJVHNa2uYHD7o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X14AgbT/LHNJTtCI8lhijreumKO7hu+txK61crMGMtWb8XH4HZhNEqBTC8q/kb+okzQIfzmEpYwKNupodKqPgftDBn/JAqOTPf3e1RTWo78liAaIXxBBxeLVFmXW9ye0PZ08SqsHwkuEVrSG2UtMIWjtnK8Y1MEH0zDyiAyJBoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=md1NlrMY; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <130c68ca-fcaf-46db-8bc0-19bb8a87ab90@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1722975678;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gDND7TQ4/bBAYAZkRiXbmditHTHsnNM4NtRumlU4FcY=;
	b=md1NlrMYyZRf+OujKB48LKa9M0NHcB0YxP+6Z7ALeAGj4GSaH0YxVth81kceB15BTy9bFw
	ZrDTKDRwqavmsOaP8EzfMgHm9joT57l3jY3Leh3dqWFkWraYqVp7+xyBUpBFzohNi4AAPA
	X34S1e5JGQNAz6MzdrOgAi7GDSP65Og=
Date: Tue, 6 Aug 2024 13:21:13 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [EXTERNAL] Re: perf_event_output payload capture flags?
Content-Language: en-GB
To: Michael Agun <danielagun@microsoft.com>,
 Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: "bpf@vger.kernel.org" <bpf@vger.kernel.org>, "bpf@ietf.org"
 <bpf@ietf.org>, dthaler1968 <dthaler1968@googlemail.com>
References: <CY5PR21MB349314B6ECC4284EA3712FCDD7B42@CY5PR21MB3493.namprd21.prod.outlook.com>
 <7ab6fbc6-2f05-4bb1-9596-855f276ab997@linux.dev>
 <CY5PR21MB3493D67300A4005628E8CB8DD7B42@CY5PR21MB3493.namprd21.prod.outlook.com>
 <CAEf4BzZvMOdL+mL9NxxesyXO-xRCwkJYqQ+GXQVBssF3_jid=w@mail.gmail.com>
 <CY5PR21MB34930570D71160AAD130D7A4D7B32@CY5PR21MB3493.namprd21.prod.outlook.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CY5PR21MB34930570D71160AAD130D7A4D7B32@CY5PR21MB3493.namprd21.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 8/1/24 5:13 PM, Michael Agun wrote:
> Thanks Andrii, I had to confirm I could read it and it looks like that is the same as the docs I have seen. I now see where the capture length is being placed, but am still missing something.
>
> Down near the bottom there is a flag constant BPF_F_CTXLEN_MASK. It appears that is bitfield in the flags value the capture length goes in, but I don't see any other mention of that constant. Do you know where that is documented?

Okay. The following in uapi bpf.h:

/* BPF_FUNC_perf_event_output for sk_buff input context. */
         BPF_F_CTXLEN_MASK               = (0xfffffULL << 32),

That is why I missed it since it is for networking side of perf_event_output.

The networking flavored bpf_perf_event_output tries to output
networking packets plus meta data. It is a little bit different
from tracing side of bpf_perf_event_output.
Unfortunately, we do not have a good documentation for this yet.

>
> Thanks,
> Michael
>
> ________________________________________
> From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> Sent: Monday, July 29, 2024 1:58 PM
> To: Michael Agun <danielagun@microsoft.com>
> Cc: Yonghong Song <yonghong.song@linux.dev>; bpf@vger.kernel.org <bpf@vger.kernel.org>; bpf@ietf.org <bpf@ietf.org>; dthaler1968@googlemail.com <dthaler1968@googlemail.com>
> Subject: Re: [EXTERNAL] Re: perf_event_output payload capture flags?
>
> On Fri, Jul 26, 2024 at 4:45 PM Michael Agun <danielagun@microsoft.com> wrote:
>> CC Dave
>>
>> Thank you.
>>
>> Due to Microsoft policies we avoid reading code with strong licensing (like GPL 2.0).
> Linux UAPI headers are licensed as `GPL-2.0 WITH Linux-syscall-note`,
> and see [0]. Will cite it in full below. Doesn't this mean that it's
> fine to read UAPI definitions?
>
> SPDX-Exception-Identifier: Linux-syscall-note
> SPDX-URL: https://spdx.org/licenses/Linux-syscall-note.html
> SPDX-Licenses: GPL-2.0, GPL-2.0+, GPL-1.0+, LGPL-2.0, LGPL-2.0+,
> LGPL-2.1, LGPL-2.1+, GPL-2.0-only, GPL-2.0-or-later
> Usage-Guide:
>    This exception is used together with one of the above SPDX-Licenses
>    to mark user space API (uapi) header files so they can be included
>    into non GPL compliant user space application code.
>    To use this exception add it with the keyword WITH to one of the
>    identifiers in the SPDX-Licenses tag:
>      SPDX-License-Identifier: <SPDX-License> WITH Linux-syscall-note
> License-Text:
>
>     NOTE! This copyright does *not* cover user programs that use kernel
>   services by normal system calls - this is merely considered normal use
>   of the kernel, and does *not* fall under the heading of "derived work".
>   Also note that the GPL below is copyrighted by the Free Software
>   Foundation, but the instance of code that it refers to (the Linux
>   kernel) is copyrighted by me and others who actually wrote it.
>
>   Also note that the only valid version of the GPL as far as the kernel
>   is concerned is _this_ particular version of the license (ie v2, not
>   v2.2 or v3.x or whatever), unless explicitly otherwise stated.
>
>              Linus Torvalds
>
>
>    [0] https://github.com/torvalds/linux/blob/master/LICENSES/exceptions/Linux-syscall-note
>
>> Is there some other documentation of the flags, or could you explain them in words?
>> Or is that the complete flags description (which is in other documentation) and I am misunderstanding the code below?
>>
>> https://github.com/cilium/cilium/blob/3fa44b59eef792e28f70b1fd23e3e17e426909f5/bpf/lib/dbg.h#L229
>>
>> It looks to me here like the capture length is being OR'd into the flags.
>>
>> Any insights would be appreciated.
>>
>> Thanks,
>> Michael
>>
>> ________________________________________
>> From: Yonghong Song <yonghong.song@linux.dev>
>> Sent: Friday, July 26, 2024 9:58 AM
>> To: Michael Agun <danielagun@microsoft.com>; bpf@vger.kernel.org <bpf@vger.kernel.org>; bpf@ietf.org <bpf@ietf.org>
>> Subject: [EXTERNAL] Re: perf_event_output payload capture flags?
>>
>> [You don't often get email from yonghong.song@linux.dev. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>>
>> On 7/25/24 6:42 PM, Michael Agun wrote:
>>> Are the perf_event_output flags (and what the event blob looks like) documented? Especially for the program type specific perf_event_output functions.
>> The documentation is in uapi/linux/bpf.h header.
>>
>> https://github.com/torvalds/linux/blob/master/include/uapi/linux/bpf.h#L2353-L2397
>>
>>    *         The *flags* are used to indicate the index in *map* for which
>>    *         the value must be put, masked with **BPF_F_INDEX_MASK**.
>>    *         Alternatively, *flags* can be set to **BPF_F_CURRENT_CPU**
>>    *         to indicate that the index of the current CPU core should be
>>    *         used.
>>
>>> I've seen notes in (cilium) code passing payload lengths in the flags, and am specifically interested in how the event blob is constructed for perf events with payload capture.
>> Could you share more details about 'passing payload lengths in the flags'?
>> AFAIK, networking bpf_perf_event_output() actually utilizes bpf_event_output_data(),
>> in which 'flags' semantics has the same meaning as the above.
>>
>>>
>>> Thanks,
>>> Michael

