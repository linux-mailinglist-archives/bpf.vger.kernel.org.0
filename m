Return-Path: <bpf+bounces-39508-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63CE897418C
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 20:02:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E44ED1F26B3A
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 18:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04D5119E802;
	Tue, 10 Sep 2024 18:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="i9Z6OuPM"
X-Original-To: bpf@vger.kernel.org
Received: from out-176.mta0.migadu.com (out-176.mta0.migadu.com [91.218.175.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD8479B84
	for <bpf@vger.kernel.org>; Tue, 10 Sep 2024 18:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725991363; cv=none; b=FtRNCHqrdpKtJvqIJUWxlmPBzNttQGF7UoxMrBkpddx6WDjEA4Ihmmeonn5aQrAnbji3IwISqqwy6okA68YqdeJCLU3xNC0r2XJ46JlqMoktTRJAPG3Rnr5iBULBZJSWSQqnmmby57lftrhlY9oK5YyRdeaNmasNhGMx21FXYOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725991363; c=relaxed/simple;
	bh=iuE3T94G6uRYx5lJP01PK3jCtP90hm1UXt1vCDw/9/w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oAU8R1b5+gwY9sCgSVdiwtCwcSV7HlGxnk+eOnwIwyQR9WiQ9dIbju0FWGlGpofS5y5S1h1sb2DWTnS8tNv5Nq8yI+sg3XlhkOlbVZjtTOt4Hj0j8y5nT/IMD7/DDn4SqJukpLgf4zMCm4sXEjR8WBRuvkC2+9kH4El0n3qI4a4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=i9Z6OuPM; arc=none smtp.client-ip=91.218.175.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <b1619bd1-807a-44b7-bfe7-fc053a8122eb@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725991358;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AGNEc+6AgMpi4iLzBNEpw7v3QYyvXgx+aeBZJ7ozxBY=;
	b=i9Z6OuPMfR2Hkt4+dV17HgPSMA1gs9zWgHc1O3D253FF2wnB7e8Tw1FZe300BgLWKQjZxz
	xTwYnTCv9URlL3aiQvnfaw0GJGwOJMPbVenGHTlYVqSIi16NlgDSZ7yojlrfww9KL/o3fB
	jsMoe4kA1cUYoisZdj3SRal13eKrA9A=
Date: Tue, 10 Sep 2024 11:02:33 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: Kernel oops caused by signed divide
Content-Language: en-GB
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Zac Ecob <zacecob@protonmail.com>, Daniel Borkmann
 <daniel@iogearbox.net>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>
References: <tPJLTEh7S_DxFEqAI2Ji5MBSoZVg7_G-Py2iaZpAaWtM961fFTWtsnlzwvTbzBzaUzwQAoNATXKUlt0LZOFgnDcIyKCswAnAGdUF3LBrhGQ=@protonmail.com>
 <CAADnVQ+o1jPQwxP9G9Xb=ZSEQDKKq1m1awpovKWdVRMNf8sgdg@mail.gmail.com>
 <1058c69c-3e2c-4c0b-b777-2b0460f443f9@linux.dev>
 <CAADnVQJPnCvttM+yitHbLRNoPUPs6EK+5VG=-SDP3LVdD70jyg@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAADnVQJPnCvttM+yitHbLRNoPUPs6EK+5VG=-SDP3LVdD70jyg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 9/10/24 8:21 AM, Alexei Starovoitov wrote:
> On Tue, Sep 10, 2024 at 7:21 AM Yonghong Song <yonghong.song@linux.dev> wrote:
>>
>> On 9/9/24 10:29 AM, Alexei Starovoitov wrote:
>>> On Mon, Sep 9, 2024 at 10:21 AM Zac Ecob <zacecob@protonmail.com> wrote:
>>>> Hello,
>>>>
>>>> I recently received a kernel 'oops' about a divide error.
>>>> After some research, it seems that the 'div64_s64' function used for the 'MOD'/'REM' instructions boils down to an 'idiv'.
>>>>
>>>> The 'dividend' is set to INT64_MIN, and the 'divisor' to -1, then because of two's complement, there is no corresponding positive value, causing the error (at least to my understanding).
>>>>
>>>>
>>>> Apologies if this is already known / not a relevant concern.
>>> Thanks for the report. This is a new issue.
>>>
>>> Yonghong,
>>>
>>> it's related to the new signed div insn.
>>> It sounds like we need to update chk_and_div[] part of
>>> the verifier to account for signed div differently.
>> In verifier, we have
>>     /* [R,W]x div 0 -> 0 */
>>     /* [R,W]x mod 0 -> [R,W]x */
> the verifier is doing what hw does. In this case this is arm64 behavior.

Okay, I see. I tried on a arm64 machine it indeed hehaves like the above.

# uname -a
Linux ... #1 SMP PREEMPT_DYNAMIC Thu Aug  1 06:58:32 PDT 2024 aarch64 aarch64 aarch64 GNU/Linux
# cat t2.c
#include <stdio.h>
#include <limits.h>
int main(void) {
   volatile long long a = 5;
   volatile long long b = 0;
   printf("a/b = %lld\n", a/b);
   return 0;
}
# cat t3.c
#include <stdio.h>
#include <limits.h>
int main(void) {
   volatile long long a = 5;
   volatile long long b = 0;
   printf("a%%b = %lld\n", a%b);
   return 0;
}
# gcc -O2 t2.c && ./a.out
a/b = 0
# gcc -O2 t3.c && ./a.out
a%b = 5

on arm64, clang18 compiled binary has the same result

# clang -O2 t2.c && ./a.out
a/b = 0
# clang -O2 t3.c && ./a.out
a%b = 5

The same source code, compiled on x86_64 with -O2 as well,
it generates:
   Floating point exception (core dumped)

>
>> What the value for
>>     Rx_a sdiv Rx_b -> ?
>> where Rx_a = INT64_MIN and Rx_b = -1?
> Why does it matter what Rx_a contains ?

It does matter. See below:

on arm64:

# cat t1.c
#include <stdio.h>
#include <limits.h>
int main(void) {
   volatile long long a = LLONG_MIN;
   volatile long long b = -1;
   printf("a/b = %lld\n", a/b);
   return 0;
}
# clang -O2 t1.c && ./a.out
a/b = -9223372036854775808
# gcc -O2 t1.c && ./a.out
a/b = -9223372036854775808

So the result of a/b is LLONG_MIN

The same code will cause exception on x86_64:

$ uname -a
Linux ... #1 SMP Wed Jun  5 06:21:21 PDT 2024 x86_64 x86_64 x86_64 GNU/Linux
[yhs@devvm1513.prn0 ~]$ gcc -O2 t1.c && ./a.out
Floating point exception (core dumped)
[yhs@devvm1513.prn0 ~]$ clang -O2 t1.c && ./a.out
Floating point exception (core dumped)

So this is what we care about.

So I guess we can follow arm64 result too.

>
> What cpus do in this case?

See above. arm64 produces *some* result while x64 cause exception.
We do need to special handle for LLONG_MIN/(-1) case.

>
>> Should we just do
>>     INT64_MIN sdiv -1 -> -1
>> or some other values?
>>

