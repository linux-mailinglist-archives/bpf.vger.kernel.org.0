Return-Path: <bpf+bounces-55550-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 88177A82BBC
	for <lists+bpf@lfdr.de>; Wed,  9 Apr 2025 18:03:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62BCF1BA71FA
	for <lists+bpf@lfdr.de>; Wed,  9 Apr 2025 15:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C0D81B0F19;
	Wed,  9 Apr 2025 15:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="u1200SVE"
X-Original-To: bpf@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104DA267B77
	for <bpf@vger.kernel.org>; Wed,  9 Apr 2025 15:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744213942; cv=none; b=b0EFyKjE61PmkhC6Mcm8s1GFqUK+dPTY6Mi7eTj+O71jhhgtwc7KHr1GPsKkA4GmR9St+pksVOunu9Q/3LK8hLSa61Pd61zT3lmXofOx001A49nmzx9eIWD773vQUIB0wRSuTKdu31xx4V6cgzw7kP3CwTKyI+fGigH6FNh8R8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744213942; c=relaxed/simple;
	bh=yqPuxChioM5eOTScbVml1bVn4Avqwl3RX4UXAViXSiY=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=r2ubCm6g9c7YEfncTZ2BMSrvxFQzhDhGWckpY+oIIRKjDxLJ8RHWx9o2YbDatShv0PR0QhbdKR22Rsrc1aTTH+lU6XrJSJ3LV6wIyLQEhhJDFEataHsaq1frTHs1rZs/XtSQr5wZY5Oyl63ycH0rcv+bBmkRPAki6BS6DUcnuDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=u1200SVE; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1744213927;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tcsbzbZiJXvGjlam4ostG3nu+YHu98aIlt4j34i461E=;
	b=u1200SVEC+hJEM6LzjWRecviHM3dk1fEcB+/TRj8Nezw81pju8AR7hSB93OV1Ws5IeLc61
	thdSJaCahCJ6FZkm4CldQT25AbAmo5YE9Cv5KPY71Vz3lTajz7muGqnFfH6kPkKQYPVlGS
	KSqJACgL8ztovzKPYCdU+ZQQwakpyuw=
Date: Wed, 09 Apr 2025 15:52:03 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Ihor Solodrai" <ihor.solodrai@linux.dev>
Message-ID: <8f5711430e4f9bb02fd06d3a5b00d46d8643fea1@linux.dev>
TLS-Required: No
Subject: Re: [PATCH v2 dwarves 1/2] dwarves: Add github actions to build,
 test
To: "Alan Maguire" <alan.maguire@oracle.com>, acme@kernel.org
Cc: yonghong.song@linux.dev, dwarves@vger.kernel.org, ast@kernel.org,
 andrii@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net,
 song@kernel.org, eddyz87@gmail.com, olsajiri@gmail.com
In-Reply-To: <290e2542-fc51-402f-b84b-00e1f2ca2bfa@oracle.com>
References: <20250401092435.1619617-1-alan.maguire@oracle.com>
 <20250401092435.1619617-2-alan.maguire@oracle.com>
 <880e470b221b93882250e759e4a7334b48ec88b6@linux.dev>
 <290e2542-fc51-402f-b84b-00e1f2ca2bfa@oracle.com>
X-Migadu-Flow: FLOW_OUT

On 4/9/25 1:59 AM, Alan Maguire wrote:
>=20
>>>=20[...]
>>> +
>>> +cat tools/testing/selftests/bpf/config \
>>> +    tools/testing/selftests/bpf/config.${INPUTS_ARCH} > .config
>>> +# this file might or might not exist depending on kernel version
>>> +if [[ -f tools/testing/selftests/bpf/config.vm ]]; then
>>> +	cat tools/testing/selftests/bpf/config.vm >> .config
>>> +fi
>>> +make olddefconfig && make prepare
>>> +grep PAHOLE .config
>>> +grep _BTF .config
>>
>> This looks like debugging code, but instead of removing it I think it
>> is useful to dump entire config to the output (hence job log) in case
>> something goes wrong. How about `cat .config` before make
>> olddefconfig?
>>
>
> Sounds good, but would doing it after "make olddefconfig" be more
> informative maybe since some additional values may be set?

I think as long as you know what is being printed it's ok. The config
after olddefconfig is the full expanded config, which is quite big.

> [...]
>
>>> diff --git a/.github/workflows/vmtest.yml b/.github/workflows/vmtest.=
yml
>>> new file mode 100644
>>> index 0000000..0f66eed
>>> --- /dev/null
>>> +++ b/.github/workflows/vmtest.yml
>>> @@ -0,0 +1,62 @@
>>> +name: 'Build kernel run selftests via vmtest'
>>> +
>>> +on:
>>> +  workflow_call:
>>> +    inputs:
>>> +      runs_on:
>>> +        required: true
>>> +        default: 'ubuntu-24.04'
>>> +        type: string
>>> +      arch:
>>> +        description: 'what arch to test'
>>> +        required: true
>>> +        default: 'x86_64'
>>> +        type: string
>>> +      kernel:
>>> +        description: 'kernel version or LATEST'
>>> +        required: true
>>> +        default: 'LATEST'
>>> +        type: string
>>> +      pahole:
>>> +        description: 'pahole rev or branch'
>>> +        required: false
>>> +        default: 'master'
>>> +        type: string
>>> +      llvm-version:
>>> +        description: 'llvm version'
>>> +        required: false
>>> +        default: '18'
>>> +        type: string
>>> +jobs:
>>> +  vmtest:
>>> +    name: pahole@${{ inputs.arch }}
>>> +    runs-on: ${{ inputs.runs_on }}
>>> +    steps:
>>> +
>>> +      - uses: actions/checkout@v4
>>> +
>>> +      - name: Setup environment
>>> +        uses: libbpf/ci/setup-build-env@v3
>>> +        with:
>>> +          pahole: ${{ inputs.pahole }}
>>> +          arch: ${{ inputs.arch }}
>>> +          llvm-version: ${{ inputs.llvm-version }}
>>
>> I think I mentioned it before, but libbpf/ci/setup-build-env checks
>> out and installs pahole too, which is unnecessary here. Have you tried
>> removing this step from the job?
>>
>> You should be able to reuse a piece of SETUP logic from
>> build-debian.sh to install pahole's dependencies. Although you kernel
>> build deps are needed too.
>>
>
> Yeah it's the latter that are needed I think.
>
>> I could make a change in libbpf/ci/setup-build-env to accept a special
>> `pahole` input value or check for env variable to NOT build pahole.
>> What do you think?
>
> That would be great! Something like "pahole: none"?

Yes, something like that. It's a small change. I'll let you know when
it's done.

>
> I'll probably try and land this more or less as-is as we're hoping to
> get 1.30 out the door this week, but definitely will follow up with
> builds with shared library libbpf etc. Thanks for taking a look!
>
> Alan

