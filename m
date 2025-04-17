Return-Path: <bpf+bounces-56206-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 22131A92E42
	for <lists+bpf@lfdr.de>; Fri, 18 Apr 2025 01:23:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2ED57A5B4F
	for <lists+bpf@lfdr.de>; Thu, 17 Apr 2025 23:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22DA82222C3;
	Thu, 17 Apr 2025 23:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TuLpuICq"
X-Original-To: bpf@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA8D22171B
	for <bpf@vger.kernel.org>; Thu, 17 Apr 2025 23:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744932213; cv=none; b=hWYcrSTrHBjCFFO0rHepr+Xili0Oev/njHANkJDuUmGDFLXVqnYdRToROqWtRfAL7jqcf9z4QEF7fZJ8WnKMkSnA0z9VmNMHk51XI+6DqK/ilHGxP7ln3AL0u35OjaD7VWlE3n3/gVhTs2apH2IenqThIMmqs+VwLQtw1CYAx4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744932213; c=relaxed/simple;
	bh=56Zvd8+1iH/WdM2WaiHFPW539+xsK+OCYMpzzdoeU9c=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=Yopo6SnrXL88nwb911MCy92Z6Gw+kP9BOb/krUthHteMukIuELXTLJvE4ua7P4V2kxSr1M5GBdY6O70ThCvGrICp2Nw9UxJvgT7k6z2+j7ao3IQOUsikzpky8ucXHkHAgP3m1JicKzSExBVimqbNGVb8hCWOW1tNVpu0jTJ+fY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TuLpuICq; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1744932208;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GLobkp6mCUCmdfUqbCOrkICt5Ij05MdMklxdUpYWtKc=;
	b=TuLpuICqWY5LkudQCrTjwINjuBgdjPPjd1F6q1ziLNBVsQ7pUWjwVJTPxS355ll18aBf2F
	FgvGiM/4gEWh26XYOX0j4ghATmDZ453LnNEaSHCCo58AkEYLS8FzkayifZ4yzm0dOQrWfl
	TCUR9KwjSR6k3pgW6j8xbzLH/knl4A0=
Date: Thu, 17 Apr 2025 23:23:26 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Ihor Solodrai" <ihor.solodrai@linux.dev>
Message-ID: <221b2fd1f39aea82c3b79116d3de15f226c6cc07@linux.dev>
TLS-Required: No
Subject: Re: [PATCH v2 dwarves 1/2] dwarves: Add github actions to build,
 test
To: "Alan Maguire" <alan.maguire@oracle.com>, acme@kernel.org
Cc: yonghong.song@linux.dev, dwarves@vger.kernel.org, ast@kernel.org,
 andrii@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net,
 song@kernel.org, eddyz87@gmail.com, olsajiri@gmail.com
In-Reply-To: <8f5711430e4f9bb02fd06d3a5b00d46d8643fea1@linux.dev>
References: <20250401092435.1619617-1-alan.maguire@oracle.com>
 <20250401092435.1619617-2-alan.maguire@oracle.com>
 <880e470b221b93882250e759e4a7334b48ec88b6@linux.dev>
 <290e2542-fc51-402f-b84b-00e1f2ca2bfa@oracle.com>
 <8f5711430e4f9bb02fd06d3a5b00d46d8643fea1@linux.dev>
X-Migadu-Flow: FLOW_OUT

On 4/9/25 8:52 AM, Ihor Solodrai wrote:
> On 4/9/25 1:59 AM, Alan Maguire wrote:
>>

>> [...]
>>
>>>> diff --git a/.github/workflows/vmtest.yml b/.github/workflows/vmtest=
.yml
>>>> new file mode 100644
>>>> index 0000000..0f66eed
>>>> --- /dev/null
>>>> +++ b/.github/workflows/vmtest.yml
>>>> @@ -0,0 +1,62 @@
>>>> +name: 'Build kernel run selftests via vmtest'
>>>> +
>>>> +on:
>>>> +  workflow_call:
>>>> +    inputs:
>>>> +      runs_on:
>>>> +        required: true
>>>> +        default: 'ubuntu-24.04'
>>>> +        type: string
>>>> +      arch:
>>>> +        description: 'what arch to test'
>>>> +        required: true
>>>> +        default: 'x86_64'
>>>> +        type: string
>>>> +      kernel:
>>>> +        description: 'kernel version or LATEST'
>>>> +        required: true
>>>> +        default: 'LATEST'
>>>> +        type: string
>>>> +      pahole:
>>>> +        description: 'pahole rev or branch'
>>>> +        required: false
>>>> +        default: 'master'
>>>> +        type: string
>>>> +      llvm-version:
>>>> +        description: 'llvm version'
>>>> +        required: false
>>>> +        default: '18'
>>>> +        type: string
>>>> +jobs:
>>>> +  vmtest:
>>>> +    name: pahole@${{ inputs.arch }}
>>>> +    runs-on: ${{ inputs.runs_on }}
>>>> +    steps:
>>>> +
>>>> +      - uses: actions/checkout@v4
>>>> +
>>>> +      - name: Setup environment
>>>> +        uses: libbpf/ci/setup-build-env@v3
>>>> +        with:
>>>> +          pahole: ${{ inputs.pahole }}
>>>> +          arch: ${{ inputs.arch }}
>>>> +          llvm-version: ${{ inputs.llvm-version }}
>>>
>>> I think I mentioned it before, but libbpf/ci/setup-build-env checks
>>> out and installs pahole too, which is unnecessary here. Have you trie=
d
>>> removing this step from the job?
>>>
>>> You should be able to reuse a piece of SETUP logic from
>>> build-debian.sh to install pahole's dependencies. Although you kernel
>>> build deps are needed too.
>>>
>>
>> Yeah it's the latter that are needed I think.
>>
>>> I could make a change in libbpf/ci/setup-build-env to accept a specia=
l
>>> `pahole` input value or check for env variable to NOT build pahole.
>>> What do you think?
>>
>> That would be great! Something like "pahole: none"?
>
> Yes, something like that. It's a small change. I'll let you know when
> it's done.

Hi Alan. I pushed a change to libbpf/ci today that skips pahole build
and install if 'pahole' is 'none' string. You can now use it.

>
>>
>> I'll probably try and land this more or less as-is as we're hoping to
>> get 1.30 out the door this week, but definitely will follow up with
>> builds with shared library libbpf etc. Thanks for taking a look!
>>
>> Alan

