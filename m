Return-Path: <bpf+bounces-35248-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 555EC939384
	for <lists+bpf@lfdr.de>; Mon, 22 Jul 2024 20:12:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 827A61C21587
	for <lists+bpf@lfdr.de>; Mon, 22 Jul 2024 18:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65A7C16F8F9;
	Mon, 22 Jul 2024 18:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="peQONMxj"
X-Original-To: bpf@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F07A1DFEF
	for <bpf@vger.kernel.org>; Mon, 22 Jul 2024 18:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721671918; cv=none; b=F3Yj1jE8FNaYM/dpBhVBDVf2HtXo0//LNQ6W2qujrf5RsvphgoIhcohr9pJTNC4UUMl3P3uCq7+v/HrLNY88qfJWAfEtu5goelQGcFLh0r5k2m/WOC4iRz80NhDsc75nF3WNP3UTCIeftNm0ZF8FZmaeVdu1dInvQggPy/gneK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721671918; c=relaxed/simple;
	bh=EEmqBCAGDMciVDpf/RImk7OUYI2tN+ikJBPzjO26udI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cSklweN1AIa4CrCBuP1ssYS9PyMNeK9Zn+lM3E6l2h3sGQSMi6CvNIAGvZjBV/W06k8d+FXFAjG1fTB9zAGuwPYzPlSVZHyX9c77ULzJA+QHQdVowJfNxz++IJyE2Qov8wLGd1VPcPBQrwgpaqrXLaNTfAPJ/5KoC78hoOYIq3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=peQONMxj; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: andrii.nakryiko@gmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1721671914;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qJSTPuNZhgUWmH5AhwyZz4tUxQp+5Dq8K73nvReJjU8=;
	b=peQONMxj4dwdxVn0yN7CpaGPJluHzOq8pDEU/R6FVd/b2hAvU6ssBLVS+T1NG2U0fXw7+y
	ylZBXdS9eDwRl5l66DEO+RgUk0OfuALrIvu+eMhKNKS0tuLm0sTCFoJbIPASxZ3UrZGll0
	WE3+I0H0vtAFmYfWby9Yp154gPLG3ew=
X-Envelope-To: bpf@vger.kernel.org
X-Envelope-To: ast@kernel.org
X-Envelope-To: andrii@kernel.org
X-Envelope-To: daniel@iogearbox.net
X-Envelope-To: kernel-team@fb.com
X-Envelope-To: martin.lau@kernel.org
Message-ID: <01f36361-2f6c-4035-9b03-0565a81a1ade@linux.dev>
Date: Mon, 22 Jul 2024 11:11:49 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v4 2/2] selftests/bpf: Add reg_bounds tests for
 ldsx and subreg compare
Content-Language: en-GB
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 kernel-team@fb.com, Martin KaFai Lau <martin.lau@kernel.org>
References: <20240718052821.3753486-1-yonghong.song@linux.dev>
 <20240718052827.3753696-1-yonghong.song@linux.dev>
 <CAEf4BzYan5bw7O2Li95pO7aFJZEOJc2T3odCk7Vi8s-7Kj3Pxw@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAEf4BzYan5bw7O2Li95pO7aFJZEOJc2T3odCk7Vi8s-7Kj3Pxw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 7/19/24 3:58 PM, Andrii Nakryiko wrote:
> On Wed, Jul 17, 2024 at 10:28 PM Yonghong Song <yonghong.song@linux.dev> wrote:
>> Add a few reg_bounds selftests to test 32/16/8-bit ldsx and subreg comparison.
>> Without the previous patch, all added tests will fail.
>>
>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>> ---
>>   .../selftests/bpf/prog_tests/reg_bounds.c       | 17 +++++++++++++++++
>>   1 file changed, 17 insertions(+)
>>
> wow, I already forgot most of the things in here... :(
>
>> diff --git a/tools/testing/selftests/bpf/prog_tests/reg_bounds.c b/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
>> index eb74363f9f70..cd9bafe9c057 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
>> @@ -441,6 +441,20 @@ static struct range range_refine(enum num_t x_t, struct range x, enum num_t y_t,
>>          if (t_is_32(y_t) && !t_is_32(x_t)) {
>>                  struct range x_swap;
>>
>> +               /* If we know that
>> +                *   - *x* is in the range of signed 32bit value
>> +                *   - *y_cast* range is 32-bit sign non-negative, and
> sign -> signed?
Ack
>
>> +                * then *x* range can be narrowed to the interaction of
> what does it mean "narrowed to the interaction"?

Let us change to '*x* range can be improved with *y_cast*.

>
>> +                * *x* and *y_cast*. Otherwise, if the new range for *x*
>> +                * allows upper 32-bit 0xffffffff then the eventual new
>> +                * range for *x* will be out of signed 32-bit range
>> +                * which violates the origin *x* range.
>> +                */
>> +               if (x_t == S64 && y_t == S32 &&
> tbh, given this is so specific for x_t == S64 and y_T == S32, I'd move
> it out from this if into an independent condition, it doesn't benefit
> from being inside

Okay, I can do this.

>
>> +                   !(y_cast.a & 0xffffffff80000000ULL) && !(y_cast.b & 0xffffffff80000000) &&
> isn't this just a much more convoluted way of checking:
>
> y_cast.a <= 0x7fffffffULL && y_cast.b <= 0x7fffffffULL

Yes, this is indeed simpler. I can use this one.

>
> ? Is & + negation really easier to follow?...
>
>> +                   (long long)x.a >= S32_MIN && (long long)x.b <= S32_MAX)
>> +                       return range_improve(x_t, x, y_cast);
>> +
>>                  /* some combinations of upper 32 bits and sign bit can lead to
>>                   * invalid ranges, in such cases it's easier to detect them
>>                   * after cast/swap than try to enumerate all the conditions
>> @@ -2108,6 +2122,9 @@ static struct subtest_case crafted_cases[] = {
>>          {S32, U32, {(u32)S32_MIN, 0}, {0, 0}},
>>          {S32, U32, {(u32)S32_MIN, 0}, {(u32)S32_MIN, (u32)S32_MIN}},
>>          {S32, U32, {(u32)S32_MIN, S32_MAX}, {S32_MAX, S32_MAX}},
>> +       {S64, U32, {0x0, 0x1f}, {0xffffffff80000000ULL, 0x000000007fffffffULL}},
>> +       {S64, U32, {0x0, 0x1f}, {0xffffffffffff8000ULL, 0x0000000000007fffULL}},
>> +       {S64, U32, {0x0, 0x1f}, {0xffffffffffffff80ULL, 0x000000000000007fULL}},
>>   };
>>
>>   /* Go over crafted hard-coded cases. This is fast, so we do it as part of
>> --
>> 2.43.0
>>

