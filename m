Return-Path: <bpf+bounces-20363-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D7FF83D220
	for <lists+bpf@lfdr.de>; Fri, 26 Jan 2024 02:40:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 849C0B21A52
	for <lists+bpf@lfdr.de>; Fri, 26 Jan 2024 01:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7D0610F5;
	Fri, 26 Jan 2024 01:39:59 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A443C64F
	for <bpf@vger.kernel.org>; Fri, 26 Jan 2024 01:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706233199; cv=none; b=Ez/KspZYjnQUY/cXEEBxCYkyDv6s9axeQeF+0+PpWyvNO/FLzbpOelmTFVJWbZKfRO/52BM2E7uu7zH3o7qEQI7y16torS2NlgvgLORD4efPjqHxRyT3w1YuOeKMnymQERCQ6hMfmmfbHgEkoksSDFwkQdEOz426bxZLzTKt90I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706233199; c=relaxed/simple;
	bh=yJ9CMkYXFUN6jMJMM3NSfqxCnsIm4HoLVbzO8R74gUQ=;
	h=Subject:To:References:Cc:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=BVFbmk6PsVxBpZgjSGqPvSo1QRja5cSHAwuXoUdhHXhLqvyl2UxMAZew7dxtPsL4GDKT/cPe3kbylEWU4CPPDBr74/uSZDSytM4GTS709ukp/Qodlyf2BsWnHLQTMJ4Pw6SHsklEj5EOYEpeJyyrvS8ehwQxZp+lglxKdHGf+I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8BxHOtqDbNlJAIGAA--.11265S3;
	Fri, 26 Jan 2024 09:39:54 +0800 (CST)
Received: from [10.130.0.149] (unknown [113.200.148.30])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8Bx7c5qDbNlS9kaAA--.50715S3;
	Fri, 26 Jan 2024 09:39:54 +0800 (CST)
Subject: Re: Add missing line break in test_verifier
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
References: <c318466f-ffd7-6bdf-9d95-93a952106bd5@loongson.cn>
 <CAEf4BzYCOFEuLB53v=qsuW3poSE+O4R58U+824riQV1BzF2i_g@mail.gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <e6ecaf05-2a8c-bdca-1b30-3c6b5fb83c6d@loongson.cn>
Date: Fri, 26 Jan 2024 09:39:54 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAEf4BzYCOFEuLB53v=qsuW3poSE+O4R58U+824riQV1BzF2i_g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8Bx7c5qDbNlS9kaAA--.50715S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj9xXoWrur4kXw4kuFW5AF1kGrW5CFX_yoWkArb_Wr
	4UCwnrC3s8ZFnxAF4xK3Zxu395GwsIgrWkCr4DWw13try8t3Z8Ga109F18ZayrWa9xJFZF
	vFsYyF1fAr15CosvyTuYvTs0mTUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUb-8YFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_JrI_Jryl8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AKxVW8
	JVW8Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4
	xG64xvF2IEw4CE5I8CrVC2j2WlYx0EF7xvrVAajcxG14v26r1j6r4UMcIj6xIIjxv20xvE
	14v26r126r1DMcIj6I8E87Iv67AKxVWxJVW8Jr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y4
	8IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC
	6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWw
	C2zVAF1VAY17CE14v26r1Y6r17MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_
	JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJV
	WUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBI
	daVFxhVjvjDU0xZFpf9x07j1_M-UUUUU=



On 01/26/2024 05:59 AM, Andrii Nakryiko wrote:
> On Wed, Jan 24, 2024 at 7:13 PM Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
>>
>> Hi Andrii,
>>
>> There was a line break at the end of printf() in the original patch [1],
>> but it is missing with small change in the git tree. Would you be able
>> to squash below trivial change into the current commit [2]?
>>
>> diff --git a/tools/testing/selftests/bpf/test_verifier.c
>> b/tools/testing/selftests/bpf/test_verifier.c
>> index e1a1dfe8d7fa..df04bda1c927 100644
>> --- a/tools/testing/selftests/bpf/test_verifier.c
>> +++ b/tools/testing/selftests/bpf/test_verifier.c
>> @@ -1527,7 +1527,7 @@ static void do_test_single(struct bpf_test *test,
>> bool unpriv,
>>          int i, err;
>>
>>          if ((test->flags & F_NEEDS_JIT_ENABLED) && jit_disabled) {
>> -               printf("SKIP (requires BPF JIT)");
>> +               printf("SKIP (requires BPF JIT)\n");
>
> Yeah, my bad, missed adding \n when fixing up message. I don't think
> we can fix this up anymore, would you be able to send this as a proper
> patch and we can apply this?

OK, will do it as soon as possible.

Thanks,
Tiezhu


