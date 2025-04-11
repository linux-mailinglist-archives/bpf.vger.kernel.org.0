Return-Path: <bpf+bounces-55775-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6511A8653D
	for <lists+bpf@lfdr.de>; Fri, 11 Apr 2025 20:06:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0FD93BEEA8
	for <lists+bpf@lfdr.de>; Fri, 11 Apr 2025 18:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D41832586C3;
	Fri, 11 Apr 2025 18:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DYZNOUby"
X-Original-To: bpf@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F118F205513
	for <bpf@vger.kernel.org>; Fri, 11 Apr 2025 18:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744394794; cv=none; b=Y7KJzfUy+1Wu3GHgQ2+7i80BaKsU2OAAnMRpjaidCxoxVR//NZ23e7XZTmS4ibN7HZ7x3JbwnCLSPfy8JPDH7qXzDna1/Ph9fu9dszuxeziufSGQ9TOLGI+dtu+w+tSvmtPfP2RG5zFDuhq3bsb9IS3ATyi4jlh20xrEJpfg/AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744394794; c=relaxed/simple;
	bh=pFSO6nty3UJovVNd0O7FS9TzM3lm8+2TlM7Ecsy3ggQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VdnXMpaIE449/0yNRnZPWyTPGtEfQQg4o+6CFVxHXGibTZJiszK+ZRPvK2nW3txs83SQqck3KmtIf4gXB887MBNT36nN3r2Lc5dZyagsXUZlS5BjGcvIgQYerexRR9fnGsF5omNigSVa6lONyqLAyoYLASRYSU9YhMQI43F1aW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DYZNOUby; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <f5c0d16e-73bc-4421-a634-099ea1eae4f7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1744394780;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pFSO6nty3UJovVNd0O7FS9TzM3lm8+2TlM7Ecsy3ggQ=;
	b=DYZNOUbyeb3turkGheM/YRt9P9F83INeFx4BMhWUDbFXvJvng66gn7mrq1expkSGERxi9f
	cDNZlyr/wKeqQxhkLQ/3W6+XRoJX/UZLGWg272R/t9d1jR+BQBhWNxxpP1nRvZ4hmzHqNF
	7bQOqGKRR2XsRBEgPY/eHg87MVfuVJg=
Date: Fri, 11 Apr 2025 11:06:07 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] bpf: Allow error injection for
 update_socket_protocol
To: Geliang Tang <geliang@kernel.org>, Gang Yan <gang_yan@foxmail.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, mptcp@lists.linux.dev
References: <tmcxv429u9-tmgrokbfbm@nsmail7.0.0--kylin--1>
 <tencent_EB51CDCA4E189E271032DFEC7E042B752008@qq.com>
 <dee07a8c-aed2-4125-a4f0-1bd76ca1e4ac@linux.dev>
 <1cc54fa0f517f387563263bb90ef1628244778df.camel@kernel.org>
Content-Language: en-GB
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <1cc54fa0f517f387563263bb90ef1628244778df.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 4/9/25 2:17 AM, Geliang Tang wrote:
> Hi Yonghong,
>
> On Sun, 2024-08-25 at 21:05 -0700, Yonghong Song wrote:
>> On 8/25/24 8:29 PM, Gang Yan wrote:
>>> Hi Alexei:
>>> It's my honor to recieve your reply. The response to your concerns
>>> is attached below
>>> for your review.
>>> On Mon, Aug 26, 2024 at 10:57:12AM +0800, Gang Yan wrote:
>>>> On Thu, Aug 22, 2024 at 8:33 AM Jakub Kicinski wrote:
>>>>> On Thu, 22 Aug 2024 14:08:57 +0800 Gang Yan wrote:
>>>>>> diff --git a/net/socket.c b/net/socket.c
>>>>>> index fcbdd5bc47ac..63ce1caf75eb 100644
>>>>>> --- a/net/socket.c
>>>>>> +++ b/net/socket.c
>>>>>> @@ -1695,6 +1695,7 @@ __weak noinline int
>>>>>> update_socket_protocol(int family, int type, int protocol)
>>>>>> {
>>>>>> return protocol;
>>>>>> }
>>>>>> +ALLOW_ERROR_INJECTION(update_socket_protocol, ERRNO);
>>>>> IDK if this falls under BPF or directly net, but could you
>>>>> explain
>>>>> what test will use this? I'd prefer not to add test hooks into
>>>>> the
>>>>> kernel unless they are exercised by in-tree tests.
>>>> This looks unnecessary.
>>>> update_socket_protocol is already registered as fmodret.
>>>> There is even selftest that excises this feature:
>>>> tools/testing/selftests/bpf/progs/mptcpify.c
>>>>
>>>> It doesn't need to be part of the error-inject.
>>> The 'update_socket_protocol' is a BPF interface designed primarily
>>> to
>>> fix the socket protocol from TCP protocol to MPTCP protocol without
>>> requiring modifications to user-space application codes. However,
>>> when attempting to achieve this using the BCC tool in user-space,
>>> the BCC tool doesn't support 'fmod_ret'. Therefore, this patch aims
>>> to
>>> further expand capabilities, enabling the 'kprobe' method can
>>> overriding
>>> the update_socket_protocol interface.
>> Gang Yan, could you explore to add fmod_ret support in bcc? It should
>> be
>> similar to kfunc/kretfunc support. I am happy to review your patches.
> It took us some time to add this support in bcc, and we have recently
> completed it in [1]. We would be grateful if you could help review
> these patches.

Sounds good. I will take a look.

>
> Thanks,
> -Geliang
>
> [1]
> https://github.com/iovisor/bcc/pull/5274
>
>> Thanks,
>> Yonghong
>>
>>> As a Python developer, the BCC tool is a commonly utilized
>>> instrument for
>>> interacting with the kernel. If the kernel could permit the use of
>>> an
>>> error-inject method to modify the `update_socket_protocol`, it
>>> would significantly
>>> benefit the subsequent promotion and development of MPTCP
>>> applications.
>>> Thank you for considering this enhancement.
>>>
>>> Best wishes!
>>> Gang Yan
>>>
>>>
>


