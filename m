Return-Path: <bpf+bounces-37487-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63C1495672B
	for <lists+bpf@lfdr.de>; Mon, 19 Aug 2024 11:34:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9C821F22E28
	for <lists+bpf@lfdr.de>; Mon, 19 Aug 2024 09:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8737915B97A;
	Mon, 19 Aug 2024 09:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eqrUq6v9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FAA415B57A
	for <bpf@vger.kernel.org>; Mon, 19 Aug 2024 09:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724060049; cv=none; b=iBSTEQhTwF83eQXSBMeN3uYJTTlpKi0vf264YlSzRfYfOJoXJLljx6TCvuxEdZcP/836Mnq06P9mcPE8Zni9k4BlJQdDxVmz3i3H2cf9uhJO5XTM1dnZL6BfgK7C/fnByFRzDfaR8pvliPiAkyqhkxMGAXyV9WpFeNRACfpjaog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724060049; c=relaxed/simple;
	bh=SpUtl05BeCGOM/1Lkbq/9mp5CcEOrFAlx+xbPz3AkRQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HBlJOi0XpdGwYWiq2BR6JZ1bio6hLpVuFxg50bNUxTe/rlFISxs3fXvN52VvMCmllrLKg4nosAD3uAKz1wHznisgzSmLneDYv+MKVQnD2ZRpU2cWJ3zgQWz9VmhfMlotVHGrchQRyrxFNez16c3k64k/TzzvNcS6WnDCPuOTsZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eqrUq6v9; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-78f86e56b4cso366818a12.3
        for <bpf@vger.kernel.org>; Mon, 19 Aug 2024 02:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1724060047; x=1724664847; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lL9HyxhiOHw1ksx03a4JZenwbuQJWQ+/lpC+EZL1Mdo=;
        b=eqrUq6v9yImy+6bOdnGikaEulfNDYq6iwh+p3MEZKEMvGDdTwsK/2NNOoHbhtOq8mG
         0xBAi9KwMUxaFfohkqg+u2JOC/jOi7+5G0YoL4pUENiCWH66shgAQdFvO1pcRbGCT0Ok
         +fjDYdUu6GD39byrD/gu4dJgDq+d4lVhxsnnA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724060047; x=1724664847;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lL9HyxhiOHw1ksx03a4JZenwbuQJWQ+/lpC+EZL1Mdo=;
        b=em90UnSNvRVSNa3eITll0ualfeUM+LWkvhH8r92F2nejPfn+qZ2df0ndfcBMKtcaeH
         B1+o/7gClNCDakf0147OtEU1zLXU+wBt2dBzY2SYH+SFwquTsVKzcEDTsWjgFcX53Og3
         Urm4KcvCnNMJeEU3IZQbrlsxEik+xYSfqdc+YudYGOxOZz4svlbc939c7nN6Gn4RmQPI
         vERWi7FC5nRwWArJbdFLQjUYFjfaLXzZuvW+YWXpFyPSwPhyvk3RLlqkEi3wTXxU8Hk6
         vRvLd0P9md+o4ia6y6iDBoGzTfLKIKzqTTO5S1/1tQ+0ifUB2oc9ugk9qESoNx9lATAJ
         iuFQ==
X-Forwarded-Encrypted: i=1; AJvYcCULPTi8nb0TGZVZ/F2fhDPi+q5+obgZuB1ZTTFijg0wSs7il5QiSYMyPhJVF+4oLgMWyCI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yybn8IpXp0NXA5V2dPHBJyIvwZ2bP97NiJWJAIewnTTtLe9Ziuw
	pzw2vHyJvHpW5MgQTxhLt5179C+k1KQjPhiBux4ELm4OjLSWIeSNpp+KbyGeMX4=
X-Google-Smtp-Source: AGHT+IEUw2ClrCHZwzq1ZRV562eGADDxdcjSOnOQEZkmnCKWFyddq0xvCP5HqungbQ1iEQ/0y/yZeQ==
X-Received: by 2002:a05:6a21:6d90:b0:1c4:f30e:97ff with SMTP id adf61e73a8af0-1c90509322amr8886710637.9.1724060046565;
        Mon, 19 Aug 2024 02:34:06 -0700 (PDT)
Received: from [192.168.104.75] ([223.118.50.121])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201f0303285sm59630475ad.26.2024.08.19.02.33.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Aug 2024 02:34:06 -0700 (PDT)
Message-ID: <84629569-c5e3-4900-aa54-82be24369f74@linuxfoundation.org>
Date: Mon, 19 Aug 2024 03:33:56 -0600
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] selftests: fix relative rpath usage
To: Eugene Syromiatnikov <esyr@redhat.com>
Cc: linux-kselftest@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>,
 Shuah Khan <shuah@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Peter Zijlstra <peterz@infradead.org>, "Paul E. McKenney"
 <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, Artem Savkov <asavkov@redhat.com>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240812165650.GA5102@asgard.redhat.com>
 <3667e585-ecaa-4664-9e6e-75dc9de928e8@linuxfoundation.org>
 <20240813163348.GA30739@asgard.redhat.com>
 <c946c5c4-366a-4772-81d9-dc5984777cfd@linuxfoundation.org>
 <20240814122513.GA18728@asgard.redhat.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240814122513.GA18728@asgard.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/14/24 06:25, Eugene Syromiatnikov wrote:
> On Wed, Aug 14, 2024 at 05:14:08AM -0600, Shuah Khan wrote:
>> On 8/13/24 10:33, Eugene Syromiatnikov wrote:
>>> On Mon, Aug 12, 2024 at 05:03:45PM -0600, Shuah Khan wrote:
>>>> On 8/12/24 10:56, Eugene Syromiatnikov wrote:
>>>>> The relative RPATH ("./") supplied to linker options in CFLAGS is resolved
>>>>> relative to current working directory and not the executable directory,
>>>>> which will lead in incorrect resolution when the test executables are run
>>>> >from elsewhere.  Changing it to $ORIGIN makes it resolve relative
>>>>> to the directory in which the executables reside, which is supposedly
>>>>> the desired behaviour.  This patch also moves these CFLAGS to lib.mk,
>>>>> so the RPATH is provided for all selftest binaries, which is arguably
>>>>> a useful default.
>>>>
>>>> Can you elaborate on the erros you would see if this isn't fixed? I understand
>>>> that check-rpaths tool - howebver I would like to know how it manifests and
>>>
>>> One would be unable to execute the test binaries that require additional
>>> locally built dynamic libraries outside the directories in which they reside:
>>>
>>>      [build@builder selftests]$ alsa/mixer-test
>>>      alsa/mixer-test: error while loading shared libraries: libatest.so: cannot open shared object file: No such file or directory
>>>
>>>> how would you reproduce this problem while running selftests?
>>>
>>> This usually doesn't come up in a regular selftests usage so far, as they
>>> are usually run via make, and make descends into specific test directories
>>> to execute make the respective make targets there, triggering the execution
>>> of the specific test bineries.
>>>
>>
>> Right. selftests are run usually via make and when they are installed run through
>> a script which descends into specific test directories where the tests are installed.
>>
>> Unless we see the problem using kselftest use-case, there is no reason the make changes.
> 
> The reason has been outlined in the commit message: relative paths in
> RPATH/RUNPATH are incorrect and ought to be fixed.
> 
>> Sorry I am not going be taking these patches.
> 
> I see, by the same token, kernel maintainers reject any patches that fix
> compilation/build warnings, I guess.
> 

No - compilation and build warnings are accepted. This doesn't fall into that
case. As you mentioned you can't reproduce this using the kselftest use-cases.

Hence the reason to reject.

thanks,
-- Shuah


