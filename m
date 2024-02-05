Return-Path: <bpf+bounces-21186-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EBCD849206
	for <lists+bpf@lfdr.de>; Mon,  5 Feb 2024 01:22:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA6811F221A3
	for <lists+bpf@lfdr.de>; Mon,  5 Feb 2024 00:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A46229474;
	Mon,  5 Feb 2024 00:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ngNEwYAF"
X-Original-To: bpf@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7C48F51
	for <bpf@vger.kernel.org>; Mon,  5 Feb 2024 00:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707092534; cv=none; b=Zc1X6UUElj0furxjOfXaAQuPJkxpRw5xl+NZjeRQ+kl9Flqw0ljZEsTrkFqda4lQa+v9ZIl71kp1ZPL9Rux7bdMypvD/1HYKTrDjMoNULbWcufliH2J8FFmkau3KItcdVqV+1Rt8dg8DwVSItM3UW7X85/Yv1fmyYQI/OiBV3Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707092534; c=relaxed/simple;
	bh=TGVsFWXSbybD+7JMrDRw6Xo4yjS+fQKrHqTsbsCQUWg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KxLlViiZFTkge0U+WPOZaUpUNqedzLA754jC46b7Tc2o8JOHD79Za1MfRh/sclK0ASGOlPOyI1DKVsfgtbaAHOijkAiqgMwORdMWYO/AwOD4ejGP4RCcMq3EBH6qMuLL4BiOrBBcEhsDCllhwMAFNRawLioetLno//wL3gnaeCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ngNEwYAF; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <3c8ebba7-c449-4f81-be49-41f6b5ea2b64@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707092530;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+5Ch6QC8mvBeUr1N/NvWc9aBhLpyOmqab4NFHqp2HiM=;
	b=ngNEwYAFuKc+1ThaJzyiv4nFd8OYJFWJJzCu0tw5WIDrdmDufpmMoMxruLPylQq05Jym3B
	s/wYHEJdmLVil/CllDHNEcGwKXPPRjmngMNMbyCq3tiFQDDdv5j1AqTQsVluTtTY4p1xvE
	L7g3EcKwYYQK63YDmghvgJbL8dtszRI=
Date: Sun, 4 Feb 2024 16:22:02 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] bpf: merge two CONFIG_BPF entries
Content-Language: en-GB
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>, bpf@vger.kernel.org,
 Andrii Nakryiko <andrii@kernel.org>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, KP Singh <kpsingh@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, linux-kernel@vger.kernel.org
References: <20240204075634.32969-1-masahiroy@kernel.org>
 <25615f41-a725-4276-bc0a-a3e7fe47b864@linux.dev>
 <CAK7LNAQiz1uMxHZ9K9=g=4goQB0TTFrdOcjgN=ZemU6BfYWqnQ@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAK7LNAQiz1uMxHZ9K9=g=4goQB0TTFrdOcjgN=ZemU6BfYWqnQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 2/4/24 3:37 PM, Masahiro Yamada wrote:
> On Mon, Feb 5, 2024 at 3:11 AM Yonghong Song <yonghong.song@linux.dev> wrote:
>>
>> On 2/3/24 11:56 PM, Masahiro Yamada wrote:
>>> 'config BPF' exists in both init/Kconfig and kernel/bpf/Kconfig.
>>>
>>> Commit b24abcff918a ("bpf, kconfig: Add consolidated menu entry for bpf
>>> with core options") added the second one to kernel/bpf/Kconfig instead
>>> of moving the existing one.
>>>
>>> Merge them together.
>>>
>>> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
>>> ---
>>>
>>>    init/Kconfig       | 5 -----
>>>    kernel/bpf/Kconfig | 1 +
>>>    2 files changed, 1 insertion(+), 5 deletions(-)
>>>
>>> diff --git a/init/Kconfig b/init/Kconfig
>>> index 8d4e836e1b6b..46ccad83a664 100644
>>> --- a/init/Kconfig
>>> +++ b/init/Kconfig
>>> @@ -1457,11 +1457,6 @@ config SYSCTL_ARCH_UNALIGN_ALLOW
>>>    config HAVE_PCSPKR_PLATFORM
>>>        bool
>>>
>>> -# interpreter that classic socket filters depend on
>>> -config BPF
>>> -     bool
>>> -     select CRYPTO_LIB_SHA1
>>> -
>>>    menuconfig EXPERT
>>>        bool "Configure standard kernel features (expert users)"
>>>        # Unhide debug options, to make the on-by-default options visible
>>> diff --git a/kernel/bpf/Kconfig b/kernel/bpf/Kconfig
>>> index 6a906ff93006..bc25f5098a25 100644
>>> --- a/kernel/bpf/Kconfig
>>> +++ b/kernel/bpf/Kconfig
>>> @@ -3,6 +3,7 @@
>>>    # BPF interpreter that, for example, classic socket filters depend on.
>>>    config BPF
>>>        bool
>>> +     select CRYPTO_LIB_SHA1
>> Currently, the kernel/bpf directory is guarded with CONFIG_BPF
>>     obj-$(CONFIG_BPF) += bpf/
>> in kernel/bpf/Makefile.
>
> Wrong.
>
> "in kernel/Makefile".
>
>
> Why is it related to this patch?

Sorry, my obvious mistake.

>
>
>
>> Your patch probably works since there are lots of some other BPF related
>> configurations which requires CONFIG_BPF. But maybe we sould
>> keep 'config BPF' in init/Kconfig and remove 'config BPF'
>> in kernel/bpf/Kconfig. This will be less confusing?
>
> Why?

The 'less confusing' part is just my initial feeling. I found
some CGROUP related configs are defined in init/Kconfig but not
under kernel/cgroup directory. So I thought 'config BPF' could
stay in init/Kconfig as well.

But I just did some other checking. For example, 'config NET'
is actually under 'net' directory. So probably you are right,
let us remove the one in init/Kconfig and use the one
in kernel/bpf/Kconfig.

So

Acked-by: Yonghong Song <yonghong.song@linux.dev>

>
>
>
>>>    # Used by archs to tell that they support BPF JIT compiler plus which
>>>    # flavour. Only one of the two can be selected for a specific arch since
>
>

