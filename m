Return-Path: <bpf+bounces-39633-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35EB59758F2
	for <lists+bpf@lfdr.de>; Wed, 11 Sep 2024 19:02:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC198287A84
	for <lists+bpf@lfdr.de>; Wed, 11 Sep 2024 17:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCCB81AED3F;
	Wed, 11 Sep 2024 17:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YoZ5O8ph"
X-Original-To: bpf@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7327C1B12D6
	for <bpf@vger.kernel.org>; Wed, 11 Sep 2024 17:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726074128; cv=none; b=WrsV8tzeeftHPz4whm+/VxWq8n4xfdqww1hurXM8QUEpMVat0MOvSa6kJgxTmtBzzMsGMv+PAeUQLuRrY+5gwyn4Hhm6+AitGAVXhOf5ctpDl4t0Qu508KDHKAkGsyZw6P2wxjQQnjtj/qdlBED+xQurQROi5UA4Nq1xs/uUF78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726074128; c=relaxed/simple;
	bh=NHCGG8kTZ58HpAe0h8dEd2z7nqwYXf9TLD7A0x5z4So=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p9AcYP9o9KetC+/cSGwh5An+85HBwy4m7t3BMKDYp2htB34rM55RcSggUrnJD2/crDlLsSggZwURxfWJpwmFQgPninutH3PfdEIOkB7+bh8FbDMPRBLeGuQO8q4QDG4E+zM5ggUoT7BB7bWPgVu3YpCwE6KAQ3fGI4jWmxgwZbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YoZ5O8ph; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <b409b810-8081-4d9b-8333-6a85081f20b8@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1726074120;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3QDWyW+oFXMyTUfKygXJGfUc3y7wM7LVWfgE2RPtjHo=;
	b=YoZ5O8ph7djq3kltLuQi+4X+4oZZt+7d53qW8Xmphow0lTeYcMqLHKirP5+C35XI4We+Kw
	MG/hUOtGOh5nPiwDPKiRTAufM7KMOmuWbSOEKMy1rXJomC/AiJvDk4kdeK8RRw0OG8zeZo
	N10VqbqV0nscAcKxI3+fHW0Ukik8YI4=
Date: Wed, 11 Sep 2024 10:01:54 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 1/2] bpf: Fix a sdiv overflow issue
Content-Language: en-GB
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>,
 Zac Ecob <zacecob@protonmail.com>
References: <20240911044017.2261738-1-yonghong.song@linux.dev>
 <CAADnVQL=s8dZ1qAnMUnFxCY4WRuhcHFOGPRtL8zsEvySZN8ReA@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAADnVQL=s8dZ1qAnMUnFxCY4WRuhcHFOGPRtL8zsEvySZN8ReA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 9/11/24 8:52 AM, Alexei Starovoitov wrote:
> On Tue, Sep 10, 2024 at 9:40 PM Yonghong Song <yonghong.song@linux.dev> wrote:
>> Zac Ecob reported a problem where a bpf program may cause kernel crash due
>> to the following error:
>>    Oops: divide error: 0000 [#1] PREEMPT SMP KASAN PTI
>>
>> The failure is due to the below signed divide:
>>    LLONG_MIN/-1 where LLONG_MIN equals to -9,223,372,036,854,775,808.
>> LLONG_MIN/-1 is supposed to give a positive number 9,223,372,036,854,775,808,
>> but it is impossible since for 64-bit system, the maximum positive
>> number is 9,223,372,036,854,775,807. On x86_64, LLONG_MIN/-1 will
>> cause a kernel exception. On arm64, the result for LLONG_MIN/-1 is
>> LLONG_MIN.
>>
>> So for 64-bit signed divide (sdiv), some additional insns are patched
>> to check LLONG_MIN/-1 pattern. If such a pattern does exist, the result
>> will be LLONG_MIN. Otherwise, it follows normal sdiv operation.
>>
>>    [1] https://lore.kernel.org/bpf/tPJLTEh7S_DxFEqAI2Ji5MBSoZVg7_G-Py2iaZpAaWtM961fFTWtsnlzwvTbzBzaUzwQAoNATXKUlt0LZOFgnDcIyKCswAnAGdUF3LBrhGQ=@protonmail.com/
>>
>> Reported-by: Zac Ecob <zacecob@protonmail.com>
>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>> ---
>>   kernel/bpf/verifier.c | 29 ++++++++++++++++++++++++++---
>>   1 file changed, 26 insertions(+), 3 deletions(-)
>>
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index f35b80c16cda..d77f1a05a065 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -20506,6 +20506,7 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
>>                      insn->code == (BPF_ALU | BPF_DIV | BPF_X)) {
>>                          bool is64 = BPF_CLASS(insn->code) == BPF_ALU64;
>>                          bool isdiv = BPF_OP(insn->code) == BPF_DIV;
>> +                       bool is_sdiv64 = is64 && isdiv && insn->off == 1;
> I suspect signed mod has the same issue.

Okay, you are correct. 64bit mod has the same problem.

On x86_64,

$ cat t10.c
#include <stdio.h>
#include <limits.h>
int main(void) {
   volatile long long a = LLONG_MIN;
   volatile long long b = -1;
   printf("a%%b = %lld\n", a%b);
   return 0;
}
$ gcc -O2 t10.c && ./a.out
Floating point exception (core dumped)

I tried the same thing with bpf inline asm and the kernel crashed.

On arm64,
the compiled binary can run successfully and the result is
a%b = 0

> Also is it only a 64-bit ? 32-bit sdiv/smod are also affected, no?

Yes, 32bit sdiv/smod also affect.

On x86,

$ cat t11.c
#include <stdio.h>
#include <limits.h>
int main(void) {
   volatile int a = INT_MIN;
   volatile int b = -1;
   printf("a/b = %d\n", a/b);
   return 0;
}
$ gcc -O2 t11.c && ./a.out
Floating point exception (core dumped)

On arm64,
   a/b = -2147483648  // INT_MIN
   a%b = 0

>
> pw-bot: cr

