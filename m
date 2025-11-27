Return-Path: <bpf+bounces-75651-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DFB7C8FBF0
	for <lists+bpf@lfdr.de>; Thu, 27 Nov 2025 18:44:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 569704E16D4
	for <lists+bpf@lfdr.de>; Thu, 27 Nov 2025 17:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 755132ED15F;
	Thu, 27 Nov 2025 17:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oDEn/Y1w"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE79221578;
	Thu, 27 Nov 2025 17:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764265490; cv=none; b=K14AXcDFij7UfclIRmynbadMC0dlszmveX0Y6WeAI+C7az/iuEKOrA4MhTn0keYOFMIH2dfRi32EbuIKEKtEBwi/8/sIrg+JzQ+h1inyGz84SzqLd0kN5fFGRJV9GubBPywr7YloSIMYF7/r6AB4Mc1vr604VpjnqQRXdBzcz3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764265490; c=relaxed/simple;
	bh=PCig0TlE1/7HjSUqQmxYUxonIx5qBBnBYKIG5+S8sDU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fUqzPYuQJtvEwrqFSJKHyHuHxoyW7T9nyVsAuIGKAb5mCssRboyK0Qtl6LcniVrRLwy/Ft86TJUPlycFEvlZbAivOOnj8HShlY0uix2DmAu4pBnS+lz68QYjshPwgdVi9gVU2F08zsCdIowXwHuLnpt4Qlv5IfGmg0cOOIPF0BU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oDEn/Y1w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D967C4CEF8;
	Thu, 27 Nov 2025 17:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764265489;
	bh=PCig0TlE1/7HjSUqQmxYUxonIx5qBBnBYKIG5+S8sDU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=oDEn/Y1wIUJ4/sNue4uFg3GuYGWztvq08+Uc7x+aWXbt6FQP6zfJiTakoI2bw1duw
	 2y1yD37g/uaAPZCsn3miAk45tlqUjCd3XB/JCjQbOhBn5k5kgC/j4QVvKEeOInfwK7
	 kZZCwqUq2VLpjCTWBwjqJEluiw0VNn5gEWQ/vRBv+mNP3i3/KreU3N/tnNKjbKSC88
	 NmQZNbLwaE8YLifr/LAtAAYhK44IwqyaOQKWPCSLxq/QnapS+EyMyTP3aClvPC1hI2
	 d7xUFaqtXoF0Ol0yV23OeuJhUrEeEi1D18Ei1dxk8U9PKh2cTjU+ErG9oDpRG9JZX9
	 m92V5W4TAVUnA==
Message-ID: <e44f70bf-8f50-4a4b-97b8-eaf988aabced@kernel.org>
Date: Thu, 27 Nov 2025 17:44:47 +0000
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
 <fbd98bd0-a89c-4903-af06-fd1f2fb4ae16@kernel.org>
 <aSTDLrUqeZ3xwEhA@google.com>
 <2c94add3-3cb6-41e9-8031-619c996aaf18@oracle.com>
 <aSdH4ODr0qSrTqvp@google.com>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <aSdH4ODr0qSrTqvp@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2025-11-26 10:33 UTC-0800 ~ Namhyung Kim <namhyung@kernel.org>
> Hello,
> 
> On Tue, Nov 25, 2025 at 09:03:38AM +0000, Alan Maguire wrote:
>> On 24/11/2025 20:42, Namhyung Kim wrote:
>>> On Thu, Nov 20, 2025 at 09:24:49AM +0000, Quentin Monnet wrote:
>>>> 2025-11-19 17:56 UTC-0800 ~ Namhyung Kim <namhyung@kernel.org>
>>>>> Hello,
>>>>>
>>>>> On Tue, Oct 28, 2025 at 10:20:22AM +0000, Alan Maguire wrote:
>>>>>> On 28/10/2025 09:05, Quentin Monnet wrote:
>>>>>>> 2025-10-27 11:27 UTC-0700 ~ Namhyung Kim <namhyung@kernel.org>
>>>>>>>> On Mon, Oct 27, 2025 at 11:41:01AM +0000, Quentin Monnet wrote:
>>>>>>>>> 2025-10-26 21:01 UTC-0700 ~ Namhyung Kim <namhyung@kernel.org>
>>>>>>>>>> Hello,
>>>>>>>>>>
>>>>>>>>>> I'm seeing a build failure like below in Fedora 40 and others.  I'm not
>>>>>>>>>> sure if it's reported already but it failed to build perf tools due to
>>>>>>>>>> errors in the bootstrap bpftool.
>>>>>>>>>>
>>>>>>>>>>     CC      /build/util/bpf_skel/.tmp/bootstrap/sign.o
>>>>>>>>>>   sign.c:16:10: fatal error: openssl/opensslv.h: No such file or directory
>>>>>>>>>>      16 | #include <openssl/opensslv.h>
>>>>>>>>>>         |          ^~~~~~~~~~~~~~~~~~~~
>>>>>>>>>>   compilation terminated.
>>>>>>>>>>   make[3]: *** [Makefile:256: /build/util/bpf_skel/.tmp/bootstrap/sign.o] Error 1
>>>>>>>>>>   make[3]: *** Waiting for unfinished jobs....
>>>>>>>>>>   make[2]: *** [Makefile.perf:1213: /build/util/bpf_skel/.tmp/bootstrap/bpftool] Error 2
>>>>>>>>>>   make[1]: *** [Makefile.perf:289: sub-make] Error 2
>>>>>>>>>>   make: *** [Makefile:76: all] Error 2
>>>>>>>>>>
>>>>>>>>>> I think it's from the recent signing change.  I'm not familiar with
>>>>>>>>>> openssl but I guess there's a proper feature check for it.  Is this a
>>>>>>>>>> known issue?
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> Hi Namhyung,
>>>>>>>>
>>>>>>>> Hello!
>>>>>>>>
>>>>>>>>>
>>>>>>>>> This looks related to the program signing change indeed, commit
>>>>>>>>> 40863f4d6ef2 ("bpftool: Add support for signing BPF programs")
>>>>>>>>> introduced a dependency on OpenSSL's development headers for bpftool.
>>>>>>>>> It's not gated behind a feature check. On Fedora, I think the headers
>>>>>>>>> come with openssl-devel, do you have this package installed?
>>>>>>>>
>>>>>>>> No I don't, but I guess it should be able to build on such systems.  Or
>>>>>>>> is it required for bpftool?  Anyway I feel like it should have a feature
>>>>>>>> check and appropriate error messages.
>>>>>>>>
>>>>>>>
>>>>>>> +Cc KP
>>>>>>>
>>>>>>> We usually have feature checks when optional features bring in new
>>>>>>> dependencies for bpftool, but we haven't discussed it this time. My
>>>>>>> understanding was that program signing is important enough that it
>>>>>>> should always be present in newer versions of bpftool, making OpenSSL
>>>>>>> one of the required dependencies going forward.
>>>>>>>
>>>>>>> We don't currently have feature checks to tell when required
>>>>>>> dependencies are missing for bpftool (it's just the build failing, in
>>>>>>> that case). I know perf does a great job at it, we could look into it
>>>>>>> for bpftool, too.
>>>>>>>
>>>>>>
>>>>>> One issue here is that some distros package openssl v3 such that the
>>>>>> #include files are in /usr/include/openssl3 and libraries in
>>>>>> /usr/lib64/openssl3 so that older versions can co-exist. Maybe we could
>>>>>> figure out a feature test that handles that too?
>>>>>
>>>>> What's the state of this?  Is the fix in the bpf tree now?
>>>>
>>>>
>>>> Hi Namhyung, Alan just submitted a v2 of his patch (targetting
>>>> bpf-next), see:
>>>>
>>>> https://lore.kernel.org/all/20251120084754.640405-2-alan.maguire@oracle.com/
>>>  
>>> Hello Quentin,
>>>
>>> I'm afraid it doesn't fix my issue.  It seems to fix another problem
>>> about the error API.  But I still see the build failure.
>>>
>>
>> This header file is delivered by openssl-devel (could be openssl-dev on
>> some distros). Looking at [1], it seems like that package has been a
>> requirement to build kernels from 4.3 on. Is it missing on your system,
>> installed to an unusual path like /usr/include/opensslv3, or is the
>> package perhaps missing some header files?
> 
> I think some of my test environments don't have openssl dev packages.
> I didn't know it was required for kernel builds but it wasn't for perf.
> If you guys require it for bpftool, maybe I can make perf disable BPF
> support in case openssl is missing.


Hi, yes OpenSSL is a required dependency for bpftool going forward,
sorry to hear it doesn't work well with your environment. I think
there's already an option to turn off BPF skeletons in perf, I'd try
running the Makefile with BUILD_BPF_SKEL=0 maybe.

Quentin

