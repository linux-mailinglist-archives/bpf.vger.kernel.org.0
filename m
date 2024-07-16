Return-Path: <bpf+bounces-34934-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A34DA933449
	for <lists+bpf@lfdr.de>; Wed, 17 Jul 2024 00:39:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2249D1F22E34
	for <lists+bpf@lfdr.de>; Tue, 16 Jul 2024 22:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81034143748;
	Tue, 16 Jul 2024 22:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FEwDZayO"
X-Original-To: bpf@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1FA7143733
	for <bpf@vger.kernel.org>; Tue, 16 Jul 2024 22:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721169550; cv=none; b=m31OD++u4P7kGkzcCy8+Tz1Wmf7retes+ilWyI68Gl7uS2Hsm+RSV5xniea5/8ZzBXBsz0n8fiRQ6YyxHzhfgeUDBm0CT5LPm+Q8EJ0N6yIn9i7ikmvgl22L+FoIhF1aG+MJhqFHYlvuUW2iJquOaJ+OKwFDea7uGIJklWJ5efk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721169550; c=relaxed/simple;
	bh=lg/VZbdGo7i2Sbe5Os7CdRhB4raCxA4mQLei9RkV27M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B+uJcuhvO7k58YYfuUJwgEyCUXok2rLukxmvpbOkK/ZLvtswT6mUg/OU4vplDGocOgcBxsTcdK80nFAzQqV3LE7bpPzZgnqCdcSYG79YZRXFMa3Mw2bKWys6VroTeOSmO416NtebeAJ8mpwPJYgWByrrFRoUvUkqTZdij1hlRjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FEwDZayO; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: eddyz87@gmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1721169546;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=adSuNhKHwTyhfnEU8/n38c2qXjQUmEwHm82Lf94o7BQ=;
	b=FEwDZayOvtf9lP9GRSxbqk2qDkc80sNVK9CfT/v5LlwxNZyzGE/ca8EWmknSyUUoKuPq4a
	p6UqV01+o7TS759dAp/7K+EU37Y2rwiTneJpkvYCAXzZVTB9FnMkmIZIlau0mNqUdPJe8G
	LDLAHpR4eVXN6l/m60YheKlccp6J3q4=
X-Envelope-To: bpf@vger.kernel.org
X-Envelope-To: ast@kernel.org
X-Envelope-To: andrii@kernel.org
X-Envelope-To: daniel@iogearbox.net
X-Envelope-To: kernel-team@fb.com
X-Envelope-To: martin.lau@kernel.org
Message-ID: <9ff9b619-aa69-42eb-9c71-39bd5ef425cc@linux.dev>
Date: Tue, 16 Jul 2024 15:38:56 -0700
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
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <5ce8b885e35e780d3ec6e730d9be2b45be3fea05.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 7/15/24 5:44 PM, Eduard Zingerman wrote:
> On Fri, 2024-07-12 at 16:44 -0700, Yonghong Song wrote:
>
> Note: it feels like these test cases should be a part of the
>        reg_bounds.c:test_reg_bounds_crafted(), e.g.:
>
>    diff --git a/tools/testing/selftests/bpf/prog_tests/reg_bounds.c b/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
>    index eb74363f9f70..4918414f8e36 100644
>    --- a/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
>    +++ b/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
>    @@ -2108,6 +2108,7 @@ static struct subtest_case crafted_cases[] = {
>            {S32, U32, {(u32)S32_MIN, 0}, {0, 0}},
>            {S32, U32, {(u32)S32_MIN, 0}, {(u32)S32_MIN, (u32)S32_MIN}},
>            {S32, U32, {(u32)S32_MIN, S32_MAX}, {S32_MAX, S32_MAX}},
>    +       {S64, U32, {0x0, 0x1f}, {0xffffffff80000000ULL, 0x00000000ffffffffULL}},
>     };
>     
>     /* Go over crafted hard-coded cases. This is fast, so we do it as part of
>
> Which produces the following log:
>
>    VERIFIER LOG:
>    ========================
>    ...
>    21: (ae) if w6 < w7 goto pc+3         ; R6=scalar(id=1,smin=0xffffffff80000000,smax=0xffffffff)
>                                            R7=scalar(id=2,smin=smin32=0,smax=umax=smax32=umax32=31,var_off=(0x0; 0x1f))
>    ...
>    from 21 to 25: ... R6=scalar(id=1,smin=smin32=0,smax=umax=smax32=umax32=30,var_off=(0x0; 0x1f))
>                       R7=scalar(id=2,smin=umin=smin32=umin32=1,smax=umax=smax32=umax32=31,var_off=(0x0; 0x1f)
>    25: ... R6=scalar(id=1,smin=smin32=0,smax=umax=smax32=umax32=30,var_off=(0x0; 0x1f))
>            R7=scalar(id=2,smin=umin=smin32=umin32=1,smax=umax=smax32=umax32=31,var_off=(0x0; 0x1f))
>    ...
>
> However, this would require adjustments to reg_bounds.c logic to
> include this new range rule.

I added some logic in reg_bounds.c.

diff --git a/tools/testing/selftests/bpf/prog_tests/reg_bounds.c b/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
index eb74363f9f70..c88602908cfe 100644
--- a/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
+++ b/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
@@ -441,6 +441,22 @@ static struct range range_refine(enum num_t x_t, struct range x, enum num_t y_t,
         if (t_is_32(y_t) && !t_is_32(x_t)) {
                 struct range x_swap;
  
+               /* If we know that
+                *   - *x* is in the range of signed 32bit value
+                *   - *y_cast* range is 32-bit sign non-negative, and
+                * then *x* range can be narrowed to the interaction of
+                * *x* and *y_cast*. Otherwise, if the new range for *x*
+                * allows upper 32-bit 0xffffffff then the eventual new
+                * range for *x* will be out of signed 32-bit range
+                * which violates the origin *x* range.
+                */
+               if (x_t == S64 && y_t == S32 &&
+                   !(y_cast.a & 0xffffffff80000000ULL) && !(y_cast.b & 0xffffffff80000000) &&
+                   (long long)x.a >= S32_MIN && (long long)x.b <= S32_MAX) {
+                               return range(S64, max_t(S64, y_cast.a, x.a),
+                                            min_t(S64, y_cast.b, x.b));
+               }
+
                 /* some combinations of upper 32 bits and sign bit can lead to
                  * invalid ranges, in such cases it's easier to detect them
                  * after cast/swap than try to enumerate all the conditions
@@ -2108,6 +2124,9 @@ static struct subtest_case crafted_cases[] = {
         {S32, U32, {(u32)S32_MIN, 0}, {0, 0}},
         {S32, U32, {(u32)S32_MIN, 0}, {(u32)S32_MIN, (u32)S32_MIN}},
         {S32, U32, {(u32)S32_MIN, S32_MAX}, {S32_MAX, S32_MAX}},
+       {S64, U32, {0x0, 0x1f}, {0xffffffff80000000ULL, 0x000000007fffffffULL}},
+       {S64, U32, {0x0, 0x1f}, {0xffffffffffff8000ULL, 0x0000000000007fffULL}},
+       {S64, U32, {0x0, 0x1f}, {0xffffffffffffff80ULL, 0x000000000000007fULL}},
  };
  
  /* Go over crafted hard-coded cases. This is fast, so we do it as part of

The logic is very similar to kernel implementation but has a difference in generating
the final range. In reg_bounds implementation, the range is narrowed by intersecting
y_cast and x range which are necessary.

In kernel implementation, there is no interection since we only have one register
and two register has been compared before.

Eduard, could you take a look at the above code?

>
> [...]
>
>> +SEC("socket")
>> +__description("LDSX, S8, subreg compare")
>                       ^^^ ^^^
>
> Nit: test_progs parsing logic for -t option is too simplistic to
>       understand comas inside description, for example here is happens
>       after the command below:
>
>         # ./test_progs-cpuv4 -t "verifier_ldsx/LDSX, S8, subreg compare"
>         #455/1   verifier_ldsx/LDSX, S8:OK
>         #455/2   verifier_ldsx/LDSX, S8 @unpriv:OK
>         #455/3   verifier_ldsx/LDSX, S16:OK
>         #455/4   verifier_ldsx/LDSX, S16 @unpriv:OK
>         #455/5   verifier_ldsx/LDSX, S32:OK
>         ...
>
>       As far as I understand, this happens because test_progs tries to
>       match words LDSX, S8 and "subreg compare" separately.
>
>       This does not happen when comas are not used in the description
>       (or if description is omitted in favor of the C function name of the test
>        (it is not possible to do -t verifier_ldsx/ldsx_s8_subreg_compare
>         if __description is provided)).

There are around 10 (or more) verifier_*.c files which has ',' in their
description. So I think we should add ',' support in test_progs infrastructure
w.r.t. description tag. I think this can be a follow up.

>> +__success __success_unpriv
>> +__naked void ldsx_s8_subreg_compare(void)
>> +{
>> +	asm volatile (
>> +	"call %[bpf_get_prandom_u32];"
>> +	"*(u64 *)(r10 - 8) = r0;"
>> +	"w6 = w0;"
>> +	"if w6 > 0x1f goto l0_%=;"
>> +	"r7 = *(s8 *)(r10 - 8);"
>> +	"if w7 > w6 goto l0_%=;"
>> +	"r1 = 0;"
>> +	"*(u64 *)(r10 - 8) = r1;"
>> +	"r2 = r10;"
>> +	"r2 += -8;"
>> +	"r1 = %[map_hash_48b] ll;"
>> +	"call %[bpf_map_lookup_elem];"
>> +	"if r0 == 0 goto l0_%=;"
>> +	"r0 += r7;"
>> +	"*(u64 *)(r0 + 0) = 1;"
>> +"l0_%=:"
>> +	"r0 = 0;"
>> +	"exit;"
>> +	:
>> +	: __imm(bpf_get_prandom_u32),
>> +	  __imm_addr(map_hash_48b),
>> +	  __imm(bpf_map_lookup_elem)
>> +	: __clobber_all);
>> +}
> [...]

