Return-Path: <bpf+bounces-37921-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7041995C64F
	for <lists+bpf@lfdr.de>; Fri, 23 Aug 2024 09:12:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C92B28222C
	for <lists+bpf@lfdr.de>; Fri, 23 Aug 2024 07:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82D044F88C;
	Fri, 23 Aug 2024 07:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="icCA3zmo"
X-Original-To: bpf@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D7955E58
	for <bpf@vger.kernel.org>; Fri, 23 Aug 2024 07:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724397137; cv=none; b=VtvuTE66mJZV9i7ddl6FCWmLJHQP+g2iDOGjx58Xcj73SaujdfBNfM89C/+Qs7bGIAKok9PJ8AqQgq+kT5UgIwmF/E7x63km0yiIRFZOC1s2UiN7y0DqjtqvzW4kjjUb5kLUMimiYfpA86PzTtYniQiyKNosoMd8PCOXY3KUWhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724397137; c=relaxed/simple;
	bh=QjcH1BEuWHmNibEMoZBPcc66J96gyQ7uYowHOvFzxO4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QPivfhP4vjjkeuhAZ72KgGJEwfX67l3FOsKwPuedW6sCAk5QtKZJCm9amDRJhNe3o0yN/yswe1G30UDLA/TcNscjK8nReAn852HA2WWR87X0gNdDK4oBV+I9xWYPs6U+/lw0F5iCZ2M/PdofArCEprWCpFczUSPLtFnK5hz8FbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=icCA3zmo; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <fd2acc68-ca3f-4d83-554b-a2aa89ad7b5c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724397132;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a6n0wnoPAcJF/7kS5yMq3pmT0HLmPp3tJepFRPvQRNc=;
	b=icCA3zmoXUMtT3rgGRychKf9R9fXaktHv8p6kd+QscAiQZaezEF9LHbn5fnhxJFbrC4tOM
	QCYjV/O93mu8Fvq0GGb01ThJ9W8AkBzt+UT1HysrbgAvJRWs/3WEAcRp6SCbB6sCjrT44a
	OMG5ZQ3m2kiISEwhY6U1CFZNdIUSlSc=
Date: Fri, 23 Aug 2024 15:12:06 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] selftests/bpf: Fix incorrect parameters in NULL pointer
 checking
To: Dan Carpenter <dan.carpenter@linaro.org>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eddy Z <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
 bpf <bpf@vger.kernel.org>,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, Hao Ge <gehao@kylinos.cn>
References: <20240820023447.29002-1-hao.ge@linux.dev>
 <02dd26b5-16a0-4732-80e4-c7bf183e965a@linux.dev>
 <58f57d70-a787-4012-8763-cc6eb642ef8a@stanley.mountain>
 <CAADnVQ+iTrTmbMcjt7fR7uTS=1tFcjv=z2CY6fO-4=kkM4YSMw@mail.gmail.com>
 <cc10c08a-a9aa-48e1-896f-46b566930271@stanley.mountain>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Hao Ge <hao.ge@linux.dev>
In-Reply-To: <cc10c08a-a9aa-48e1-896f-46b566930271@stanley.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Hi Dan and Alexei


I apologize for any inconvenience my mistake may have caused to both of you.


On 8/22/24 06:31, Dan Carpenter wrote:
> On Wed, Aug 21, 2024 at 03:07:27PM -0700, Alexei Starovoitov wrote:
>> On Wed, Aug 21, 2024 at 2:50 PM Dan Carpenter <dan.carpenter@linaro.org> wrote:
>>> On Wed, Aug 21, 2024 at 02:03:17PM -0700, Yonghong Song wrote:
>>>> On 8/19/24 7:34 PM, Hao Ge wrote:
>>>>> From: Hao Ge <gehao@kylinos.cn>
>>>>>
>>>>> Smatch reported the following warning:
>>>>>       ./tools/testing/selftests/bpf/testing_helpers.c:455 get_xlated_program()
>>>>>       warn: variable dereferenced before check 'buf' (see line 454)
>>>>>
>>>>> It seems correct,so let's modify it based on it's suggestion.
>>>>>
>>>>> Actually,commit b23ed4d74c4d ("selftests/bpf: Fix invalid pointer
>>>>> check in get_xlated_program()") fixed an issue in the test_verifier.c
>>>>> once,but it was reverted this time.
>>>>>
>>>>> Let's solve this issue with the minimal changes possible.
>>>>>
>>>>> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
>>>>> Closes: https://lore.kernel.org/all/1eb3732f-605a-479d-ba64-cd14250cbf91@stanley.mountain/
>>>>> Fixes: b4b7a4099b8c ("selftests/bpf: Factor out get_xlated_program() helper")
>>>>> Signed-off-by: Hao Ge <gehao@kylinos.cn>
>>>> In the future, please change subject '[PATCH] ...' to '[PATCH bpf-next] ...'
>>>> so CI can properly test it.
>>> It feels like there should be a technical solution to this.  The CI system is
>>> something on AWS and it's too expensive to just check every patch that's sent to
>>> the bpf list?  My understanding is that there are only two bpf trees.
>>>
>>>          if [ "$FIXES_HASH" == "" ] ; then
>>>                  TREE=next
>>>          elif git merge-base --is-ancestor $FIXES_HASH origin/master ; then
>>>                  TREE=linus
>>>          else
>>>                  TREE=next
>>>          fi
>>>
>>> These days the zero day bot people are checking around a thousand git trees.
>>> They pull emails off the various lists and apply them to the right places.  It's
>>> a doable thing.
>> Dan,
>>
>> Various people pointed out that you need to use the proper subject in
>> the patches.
>> You clearly knew that rule and yet you ignored it,
>> and worse still you keep coming up with these excuses.
>> Don't be surprised that people who are supposed to review your patches
>> will take a long time to reply or "forget" about them as you "forget"
>> about patch submission rules.


Perhaps it was referring to me? Regardless, I will reflect on myself and 
make improvements.


> You're emailing the wrong person.  This isn't my patch.  I don't send BPF
> patches.
>
> regards,
> dan carpenter

