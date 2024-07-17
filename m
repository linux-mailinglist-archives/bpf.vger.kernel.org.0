Return-Path: <bpf+bounces-34943-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CB3929336A1
	for <lists+bpf@lfdr.de>; Wed, 17 Jul 2024 08:06:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C50AB22B88
	for <lists+bpf@lfdr.de>; Wed, 17 Jul 2024 06:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9DB511CA1;
	Wed, 17 Jul 2024 06:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tefBEABR"
X-Original-To: bpf@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882C3168BD
	for <bpf@vger.kernel.org>; Wed, 17 Jul 2024 06:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721196391; cv=none; b=VXz9mndxMgzAjAppIW1/MwMWVne18LC2IRSkyhPsSMKFI+p02PDJLf/OxVVAYSYMIcMEUVhRxb/M8gEaOrzm2E/Ju1uNiq1GuzKrVN7Q52mlYiwqbsjP3yRjkKIp810fClVZTWEc0ti2tHBHibviaE3oh6sOc/3gAORNLGkSz4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721196391; c=relaxed/simple;
	bh=x1MOOajBadr7Y6gRb7Likm8PbNYLRWlBbI++omSQZoY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eyzBgEpS6ZY9BXyebuYlOMi1Q1fcWZXaZhAP5a2nfjz7fvZkUwOyLCyxVC7jdzJ4ecNEGNjXa17aQtC5cmQ0vmLD3IaEtUROs7cEuB92jlHJr12/VNTpKcoRMBCIvyaL209YiJQDMUDNI68IJkDhOC4WmVoQDd6RjLZnUDlKanc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tefBEABR; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: eddyz87@gmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1721196386;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6/4EQn7UP8xf77Qpnq/kR7ayCe5Xa20xoWpY9Ps+HvM=;
	b=tefBEABRoMhpi+SjBcRNeMxmC6p8a2ksOkveewaV1hligB9uILsHYLHwjMxgi/sCXeojem
	Fktu2JaRYjA9A1aAZ6rUg+1MQsiUVq1cyO5bWOjol/86clL65tJN+riT/bglELTGwj4O4I
	ntS4lPcqxyyzP15+QX8kWGq+qQCZxB0=
X-Envelope-To: bpf@vger.kernel.org
X-Envelope-To: ast@kernel.org
X-Envelope-To: andrii@kernel.org
X-Envelope-To: daniel@iogearbox.net
X-Envelope-To: kernel-team@fb.com
X-Envelope-To: martin.lau@kernel.org
Message-ID: <e5cf2fb6-a0a9-4224-b709-5ba6be7537e3@linux.dev>
Date: Tue, 16 Jul 2024 23:06:19 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 2/2] selftests/bpf: Add ldsx selftests for
 ldsx and subreg compare
Content-Language: en-GB
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
 Martin KaFai Lau <martin.lau@kernel.org>
References: <20240712234359.287698-1-yonghong.song@linux.dev>
 <20240712234404.288115-1-yonghong.song@linux.dev>
 <5ce8b885e35e780d3ec6e730d9be2b45be3fea05.camel@gmail.com>
 <9ff9b619-aa69-42eb-9c71-39bd5ef425cc@linux.dev>
 <9f7470ba841548b6d534b3886d8c76c4352323e0.camel@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <9f7470ba841548b6d534b3886d8c76c4352323e0.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 7/16/24 5:12 PM, Eduard Zingerman wrote:
> On Tue, 2024-07-16 at 15:38 -0700, Yonghong Song wrote:
>
> [...]
>
>> diff --git a/tools/testing/selftests/bpf/prog_tests/reg_bounds.c b/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
>> index eb74363f9f70..c88602908cfe 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
>> @@ -441,6 +441,22 @@ static struct range range_refine(enum num_t x_t, struct range x, enum num_t y_t,
>>           if (t_is_32(y_t) && !t_is_32(x_t)) {
>>                   struct range x_swap;
>>    
>> +               /* If we know that
>> +                *   - *x* is in the range of signed 32bit value
>> +                *   - *y_cast* range is 32-bit sign non-negative, and
>> +                * then *x* range can be narrowed to the interaction of
>> +                * *x* and *y_cast*. Otherwise, if the new range for *x*
>> +                * allows upper 32-bit 0xffffffff then the eventual new
>> +                * range for *x* will be out of signed 32-bit range
>> +                * which violates the origin *x* range.
>> +                */
>> +               if (x_t == S64 && y_t == S32 &&
>> +                   !(y_cast.a & 0xffffffff80000000ULL) && !(y_cast.b & 0xffffffff80000000) &&
>> +                   (long long)x.a >= S32_MIN && (long long)x.b <= S32_MAX) {
>> +                               return range(S64, max_t(S64, y_cast.a, x.a),
>> +                                            min_t(S64, y_cast.b, x.b));
>> +               }
>> +
>>                   /* some combinations of upper 32 bits and sign bit can lead to
>>                    * invalid ranges, in such cases it's easier to detect them
>>                    * after cast/swap than try to enumerate all the conditions
>> @@ -2108,6 +2124,9 @@ static struct subtest_case crafted_cases[] = {
>>           {S32, U32, {(u32)S32_MIN, 0}, {0, 0}},
>>           {S32, U32, {(u32)S32_MIN, 0}, {(u32)S32_MIN, (u32)S32_MIN}},
>>           {S32, U32, {(u32)S32_MIN, S32_MAX}, {S32_MAX, S32_MAX}},
>> +       {S64, U32, {0x0, 0x1f}, {0xffffffff80000000ULL, 0x000000007fffffffULL}},
>> +       {S64, U32, {0x0, 0x1f}, {0xffffffffffff8000ULL, 0x0000000000007fffULL}},
>> +       {S64, U32, {0x0, 0x1f}, {0xffffffffffffff80ULL, 0x000000000000007fULL}},
>>    };
>>    
>>    /* Go over crafted hard-coded cases. This is fast, so we do it as part of
>>
>> The logic is very similar to kernel implementation but has a difference in generating
>> the final range. In reg_bounds implementation, the range is narrowed by intersecting
>> y_cast and x range which are necessary.
>>
>> In kernel implementation, there is no interection since we only have one register
>> and two register has been compared before.
>>
>> Eduard, could you take a look at the above code?
> I think this change is correct.
> The return clause could be simplified a bit:
>
> 	return range_improve(x_t, x, y_cast);

Indeed. This is much simpler. I will use reg_bounds testing instead of verifier_ldsx testing
in next revision.

>
> [...]

