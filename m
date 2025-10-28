Return-Path: <bpf+bounces-72506-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 85B15C13BA4
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 10:11:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5BFF756487B
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 09:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BC0D2FABF5;
	Tue, 28 Oct 2025 09:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k6Is/+tq"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6152F99AE;
	Tue, 28 Oct 2025 09:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761642356; cv=none; b=t8mCu/DqXj8Qg8OEi26riJZAgkR+yZk+OrZcaZRkOOF+8KTpv38vKpdtKmQM13d5C+FyjO3Aa2LJvo1zxfKy1PlhJ/qd4vdNFCl+PBPw21fNHxdv6RlJtThennZVZg3y2k+tuK5NzE1upfBFt7NKcqxejzIwJis8HUchF4N7pmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761642356; c=relaxed/simple;
	bh=3im3l8K/9pyuBztfKfPyRxSlqJxJuGXKV429IhMtykI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R6aaZ68Ia4N9pFUwaOkDe4jOZz2XOBNZbSvQntBuQ6s21qh1oqnCNa8ruNWqvvOC6nugobqXfmHvwomiMXiMxWQmtZgwlQnHWP+8ykwTSY3at9vC/125vrCRB8dXT4nHI6H+xnSgj4LT6UFdfEP1ToG5AUV3J0X4cGw214x6adI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k6Is/+tq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 893AFC116B1;
	Tue, 28 Oct 2025 09:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761642355;
	bh=3im3l8K/9pyuBztfKfPyRxSlqJxJuGXKV429IhMtykI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=k6Is/+tqbHhSxYZdkJbXjioTiUf/AjknWNzBey6X7M1UL0mX8giHqVBpqPtNEql1i
	 erNTjoPtKyOVq0PKgQKvj+8dERJt7faLKhHYSNfrfr8LAO9ETxzF2LSiwYX+eZ02Dh
	 C9c2a6zCWbwAzEcgoG9oyI/Op3jcJ+lm1QpnA1gcropgA+FKuLdp3bAnW/kI93Ru6B
	 VKnEbsldC2tasgI6ls41Q0odMYuRsyMz8VhaIkkEo1Q0hU3DKY/YBseNqu55qpSmy5
	 OwHThYUKdDX2M9zAf6pe5Qgk8jIGwAgDnNx8LDZAp9UykLM07wkkux2wDtiGa3yvHl
	 24iFnnLdC45sg==
Message-ID: <d6a63399-361f-4f1c-845c-b69192bfc822@kernel.org>
Date: Tue, 28 Oct 2025 10:05:52 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] bpftool: Build failure due to opensslv.h
To: Namhyung Kim <namhyung@kernel.org>, KP Singh <kpsingh@kernel.org>
Cc: bpf@vger.kernel.org, linux-perf-users@vger.kernel.org
References: <aP7uq6eVieG8v_v4@google.com>
 <2cb226f8-a67c-4bdb-8c59-507c99a46bab@kernel.org>
 <aP-5fUaroYE5xSnw@google.com>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <aP-5fUaroYE5xSnw@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2025-10-27 11:27 UTC-0700 ~ Namhyung Kim <namhyung@kernel.org>
> On Mon, Oct 27, 2025 at 11:41:01AM +0000, Quentin Monnet wrote:
>> 2025-10-26 21:01 UTC-0700 ~ Namhyung Kim <namhyung@kernel.org>
>>> Hello,
>>>
>>> I'm seeing a build failure like below in Fedora 40 and others.  I'm not
>>> sure if it's reported already but it failed to build perf tools due to
>>> errors in the bootstrap bpftool.
>>>
>>>     CC      /build/util/bpf_skel/.tmp/bootstrap/sign.o
>>>   sign.c:16:10: fatal error: openssl/opensslv.h: No such file or directory
>>>      16 | #include <openssl/opensslv.h>
>>>         |          ^~~~~~~~~~~~~~~~~~~~
>>>   compilation terminated.
>>>   make[3]: *** [Makefile:256: /build/util/bpf_skel/.tmp/bootstrap/sign.o] Error 1
>>>   make[3]: *** Waiting for unfinished jobs....
>>>   make[2]: *** [Makefile.perf:1213: /build/util/bpf_skel/.tmp/bootstrap/bpftool] Error 2
>>>   make[1]: *** [Makefile.perf:289: sub-make] Error 2
>>>   make: *** [Makefile:76: all] Error 2
>>>
>>> I think it's from the recent signing change.  I'm not familiar with
>>> openssl but I guess there's a proper feature check for it.  Is this a
>>> known issue?
>>
>>
>> Hi Namhyung,
> 
> Hello!
> 
>>
>> This looks related to the program signing change indeed, commit
>> 40863f4d6ef2 ("bpftool: Add support for signing BPF programs")
>> introduced a dependency on OpenSSL's development headers for bpftool.
>> It's not gated behind a feature check. On Fedora, I think the headers
>> come with openssl-devel, do you have this package installed?
> 
> No I don't, but I guess it should be able to build on such systems.  Or
> is it required for bpftool?  Anyway I feel like it should have a feature
> check and appropriate error messages.
> 

+Cc KP

We usually have feature checks when optional features bring in new
dependencies for bpftool, but we haven't discussed it this time. My
understanding was that program signing is important enough that it
should always be present in newer versions of bpftool, making OpenSSL
one of the required dependencies going forward.

We don't currently have feature checks to tell when required
dependencies are missing for bpftool (it's just the build failing, in
that case). I know perf does a great job at it, we could look into it
for bpftool, too.

Quentin

