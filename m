Return-Path: <bpf+bounces-75148-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D92DFC731B8
	for <lists+bpf@lfdr.de>; Thu, 20 Nov 2025 10:25:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B33724E5963
	for <lists+bpf@lfdr.de>; Thu, 20 Nov 2025 09:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2119D3115B0;
	Thu, 20 Nov 2025 09:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kq4ULIoD"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F2C3101D3;
	Thu, 20 Nov 2025 09:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763630692; cv=none; b=ClSEEjDxfo3z33HAPsmbM5MpRKSkXWGyIDHCqWrrKSF5FVw+260kxxHEMkA7oC45oYzKtsf3iIsXkGZvyTiskD4OieyZD5xN/1+1WNRfuYvVopa43mxcF/jUcJ89K9Har6uldNKdzERgtWqCSKhtJCqGptt1ouj+Jf4eD1sYbU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763630692; c=relaxed/simple;
	bh=TMWVzmFYWjec4mLQP2TODuChpH7SIx8rCGBCJuEilPc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LAP06y9FRu5GdafHlvO1YiYsSPohWL63ji6ktoNG/gIyNZ3i2FdlNSBhL6uEbUdJdVh8WhhGXHPchr42e19MePbJPf0BxHjvQNXTnAXvnu73qWc7h0hW7mLHK1W0TSoGcy4NzyQGBzSgVdyriuMhNWAbARxQLz2ty9OWA8sUr4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kq4ULIoD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4242EC4CEF1;
	Thu, 20 Nov 2025 09:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763630692;
	bh=TMWVzmFYWjec4mLQP2TODuChpH7SIx8rCGBCJuEilPc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=kq4ULIoDhepGN29DPe4qVLYN9ASWvyCzPIM154ax4KY1aCamFpPBUIXLBaisMaBAd
	 D8ml3zfztNKLxGEMUGWWfneYrz36wJNnMgJWkIMYcm9CtmXR80p0ByKTXgHYTSh78f
	 CEWIb3y3nqN0bd/fy3UEH+wZSLQf8RxXg8wwP0A91CRPjE6Pgla+O8l2j3ncgC/mHR
	 mwLVo9cBooP7LBV8NFWzOkydWCqa5Vyj5zkQH5ADHuXzdb2a//e53ZyYW91FFxyCPL
	 CYWgRzN2fid7ParRvmi7auodlaAOocjIlesW8ZtcWKZNMkSLYMmt+d1wnqJYCgkZcC
	 T7AYOLHGUfojg==
Message-ID: <fbd98bd0-a89c-4903-af06-fd1f2fb4ae16@kernel.org>
Date: Thu, 20 Nov 2025 09:24:49 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] bpftool: Build failure due to opensslv.h
To: Namhyung Kim <namhyung@kernel.org>, Alan Maguire <alan.maguire@oracle.com>
Cc: KP Singh <kpsingh@kernel.org>, bpf@vger.kernel.org,
 linux-perf-users@vger.kernel.org
References: <aP7uq6eVieG8v_v4@google.com>
 <2cb226f8-a67c-4bdb-8c59-507c99a46bab@kernel.org>
 <aP-5fUaroYE5xSnw@google.com>
 <d6a63399-361f-4f1c-845c-b69192bfc822@kernel.org>
 <7c86f05f-2ba3-4f63-8d63-49a3b3370360@oracle.com>
 <aR51ZSicusUssXuU@google.com>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <aR51ZSicusUssXuU@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2025-11-19 17:56 UTC-0800 ~ Namhyung Kim <namhyung@kernel.org>
> Hello,
> 
> On Tue, Oct 28, 2025 at 10:20:22AM +0000, Alan Maguire wrote:
>> On 28/10/2025 09:05, Quentin Monnet wrote:
>>> 2025-10-27 11:27 UTC-0700 ~ Namhyung Kim <namhyung@kernel.org>
>>>> On Mon, Oct 27, 2025 at 11:41:01AM +0000, Quentin Monnet wrote:
>>>>> 2025-10-26 21:01 UTC-0700 ~ Namhyung Kim <namhyung@kernel.org>
>>>>>> Hello,
>>>>>>
>>>>>> I'm seeing a build failure like below in Fedora 40 and others.  I'm not
>>>>>> sure if it's reported already but it failed to build perf tools due to
>>>>>> errors in the bootstrap bpftool.
>>>>>>
>>>>>>     CC      /build/util/bpf_skel/.tmp/bootstrap/sign.o
>>>>>>   sign.c:16:10: fatal error: openssl/opensslv.h: No such file or directory
>>>>>>      16 | #include <openssl/opensslv.h>
>>>>>>         |          ^~~~~~~~~~~~~~~~~~~~
>>>>>>   compilation terminated.
>>>>>>   make[3]: *** [Makefile:256: /build/util/bpf_skel/.tmp/bootstrap/sign.o] Error 1
>>>>>>   make[3]: *** Waiting for unfinished jobs....
>>>>>>   make[2]: *** [Makefile.perf:1213: /build/util/bpf_skel/.tmp/bootstrap/bpftool] Error 2
>>>>>>   make[1]: *** [Makefile.perf:289: sub-make] Error 2
>>>>>>   make: *** [Makefile:76: all] Error 2
>>>>>>
>>>>>> I think it's from the recent signing change.  I'm not familiar with
>>>>>> openssl but I guess there's a proper feature check for it.  Is this a
>>>>>> known issue?
>>>>>
>>>>>
>>>>> Hi Namhyung,
>>>>
>>>> Hello!
>>>>
>>>>>
>>>>> This looks related to the program signing change indeed, commit
>>>>> 40863f4d6ef2 ("bpftool: Add support for signing BPF programs")
>>>>> introduced a dependency on OpenSSL's development headers for bpftool.
>>>>> It's not gated behind a feature check. On Fedora, I think the headers
>>>>> come with openssl-devel, do you have this package installed?
>>>>
>>>> No I don't, but I guess it should be able to build on such systems.  Or
>>>> is it required for bpftool?  Anyway I feel like it should have a feature
>>>> check and appropriate error messages.
>>>>
>>>
>>> +Cc KP
>>>
>>> We usually have feature checks when optional features bring in new
>>> dependencies for bpftool, but we haven't discussed it this time. My
>>> understanding was that program signing is important enough that it
>>> should always be present in newer versions of bpftool, making OpenSSL
>>> one of the required dependencies going forward.
>>>
>>> We don't currently have feature checks to tell when required
>>> dependencies are missing for bpftool (it's just the build failing, in
>>> that case). I know perf does a great job at it, we could look into it
>>> for bpftool, too.
>>>
>>
>> One issue here is that some distros package openssl v3 such that the
>> #include files are in /usr/include/openssl3 and libraries in
>> /usr/lib64/openssl3 so that older versions can co-exist. Maybe we could
>> figure out a feature test that handles that too?
> 
> What's the state of this?  Is the fix in the bpf tree now?


Hi Namhyung, Alan just submitted a v2 of his patch (targetting
bpf-next), see:

https://lore.kernel.org/all/20251120084754.640405-2-alan.maguire@oracle.com/

Quentin

