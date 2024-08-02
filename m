Return-Path: <bpf+bounces-36260-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 09E38945728
	for <lists+bpf@lfdr.de>; Fri,  2 Aug 2024 06:43:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A59031F245F5
	for <lists+bpf@lfdr.de>; Fri,  2 Aug 2024 04:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CBC81CAAF;
	Fri,  2 Aug 2024 04:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bQFBpWyH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 827D81EB4AE
	for <bpf@vger.kernel.org>; Fri,  2 Aug 2024 04:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722573776; cv=none; b=aDcu1d6VHJ+MY8HuznW8dh4FUS5brTmm0GHFr/xVvKJPJGy5hthGMPjLbrC39Xit0ggwQun/+yDrLENdjR+rPSxiwkOwPkeHmYDZbjPTQWCj3o96uLhd8bhr9GHETNe5Tdx7gfTwLIdx+ATVsG/l/gO7N4t1J6pm5jzhR9e3JSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722573776; c=relaxed/simple;
	bh=YIqwnuzbHimCc+FieogmwoJaDzo2kjkarw00yppY+3M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BmOqVfBY9LsYZnaij9/w5J3UFCtbgxZEBZuyN9h3lu+ydTCbDCVdadtmurunu8XbS3ZLwcFXbSpg0iauQUAuvZsh+N1nHw48ydl07WUWIQt9c9UE9YKMTVA+CMTcuWhC7BYM9Zr9bOcIM6/YGFqJd2U/Y2por9BQWeLsGDMZikY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bQFBpWyH; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e0b286b922eso5728828276.1
        for <bpf@vger.kernel.org>; Thu, 01 Aug 2024 21:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722573774; x=1723178574; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2t5TEEdzOJADNZ42CoMQ2M/vREphD3nyDM5+bmAwOP4=;
        b=bQFBpWyHK765Bwu4qfWe6BUT6QQJTLukka6y5yd2zCGhRdL0P7peUkrVAzAduOxV9f
         oP6CCx0h9lV+ZPNUJlOqzCIyD47PXAQu6jMweaaot6vIjIlUpafuPt33BgRul6ZjHVI7
         DQDX3ap1KnxGefvuaXKFoc0hYhWbpWmuNlY1sOgyVYDuF1xoeukYzHbWBtNR7/gHxnDh
         blct+8ltdn4C0gNq6q9pa5ZoN6nYtiEZfOu5fhEQ6l9mQN75jf/fk5qpOkDO1cwKvj7U
         GvV/K9TcWIzbhfzB+JB9qBZ/gfCBgZoWCs2dJs+Rtwj0cR4eZzlU4J9ctZBhkHPRLy+9
         urYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722573774; x=1723178574;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2t5TEEdzOJADNZ42CoMQ2M/vREphD3nyDM5+bmAwOP4=;
        b=jiFdorZ96ayOATxPBUR8ZNCwn4T8ReKsGC+AYuEYQ0VdoDwvBPXTl+3bA3qVSTlPSd
         xiBCJHhetauLHI7L4sWQNiGXzdc85zqX/PjHRV/NaBiprxikQI6bn23M8DCG0fZYjkx0
         nqIay2VSTdMGQuSzGtFmIOTKI1STI1vgT0JgvQ46GXtG6w07eybzZrOwvvVtjQ+xvUaM
         rLak7jShFn7SKaOjspQkxJtMEh0Rq7DdxPLyMIxw5ix07801XIWi/Q9owdufdyY6v3V7
         kXipSsapIQmKGSEcwXBBcq6d/lSY5Td/FtMJ1fnepDg7niVWIDdPsqn9lTSAFTfNLfYP
         2DIQ==
X-Gm-Message-State: AOJu0Yy/5+y3nx5VItm/TLVCuSQ4nwALiN6EjayrHAW9Rg/GqNVQd9AG
	otywZ27HF8LEv3/wF9lZjo3ByuPoIeiZJFiuj9kRdGTmM1GdaqLs
X-Google-Smtp-Source: AGHT+IHUyIeHQycSSuPG+ty+Zx/QHj+PvTVR4mzgeQPGau+uL++IEVOzh1FcnWAimsll/xrkZrqAVw==
X-Received: by 2002:a05:6902:2b02:b0:e0b:c864:3e01 with SMTP id 3f1490d57ef6-e0bde464339mr2901205276.47.1722573774430;
        Thu, 01 Aug 2024 21:42:54 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:10ed:40b:8a2e:9686? ([2600:1700:6cf8:1240:10ed:40b:8a2e:9686])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e0be53044bbsm115495276.4.2024.08.01.21.42.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Aug 2024 21:42:54 -0700 (PDT)
Message-ID: <2e7a5a22-56bb-4afb-8b71-0232a075e9c6@gmail.com>
Date: Thu, 1 Aug 2024 21:42:52 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v4 5/6] selftests/bpf: Monitor traffic for
 sockmap_listen.
To: Stanislav Fomichev <sdf@fomichev.me>, Kui-Feng Lee <thinker.li@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev,
 song@kernel.org, kernel-team@meta.com, andrii@kernel.org,
 geliang@kernel.org, kuifeng@meta.com
References: <20240731193140.758210-1-thinker.li@gmail.com>
 <20240731193140.758210-6-thinker.li@gmail.com> <Zqqn7oPuZJ7dobVU@mini-arch>
Content-Language: en-US
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <Zqqn7oPuZJ7dobVU@mini-arch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/31/24 14:09, Stanislav Fomichev wrote:
> On 07/31, Kui-Feng Lee wrote:
>> Enable traffic monitor for each subtest of sockmap_listen.
>>
>> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
>> ---
>>   tools/testing/selftests/bpf/prog_tests/sockmap_listen.c | 9 +++++++++
>>   1 file changed, 9 insertions(+)
>>
>> diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
>> index 9ce0e0e0b7da..2030472fb8e8 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
>> @@ -1926,14 +1926,23 @@ static void test_udp_unix_redir(struct test_sockmap_listen *skel, struct bpf_map
>>   {
>>   	const char *family_name, *map_name;
>>   	char s[MAX_TEST_NAME];
>> +	struct netns_obj *netns;
>>   
>>   	family_name = family_str(family);
>>   	map_name = map_type_str(map);
>>   	snprintf(s, sizeof(s), "%s %s %s", map_name, family_name, __func__);
>>   	if (!test__start_subtest(s))
>>   		return;
>> +
>> +	netns = netns_new("test", true);
>> +	if (!ASSERT_OK_PTR(netns, "netns_new"))
>> +		return;
> 
> [..]
> 
>> +	system("ip link set lo up");
> 
> Let's do this in netns_new? We almost always want it in a new ns. The
> tests that don't need a loopback can do "lo down".
Agree!

