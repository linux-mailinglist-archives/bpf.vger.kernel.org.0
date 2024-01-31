Return-Path: <bpf+bounces-20852-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E7B884460E
	for <lists+bpf@lfdr.de>; Wed, 31 Jan 2024 18:25:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 530E21F2D1E7
	for <lists+bpf@lfdr.de>; Wed, 31 Jan 2024 17:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A406F12CDA7;
	Wed, 31 Jan 2024 17:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tdmFp8ru"
X-Original-To: bpf@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95AAA12C54B
	for <bpf@vger.kernel.org>; Wed, 31 Jan 2024 17:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706721913; cv=none; b=KadAyt6rudbrPYoiQ3yWPAG+q0oAO2ElgHAsHfUpIv2ps6TTXM7nQAWWiLn4zEdMszTjLhd9fMEy/IVcMtMrEBT8qWNn3E5cLHzr/HrG3sZv7sOUbn1E2+sYohjEnTIP2zcV6y3VVYxxGyHvWKkdr966tIlF5iHuT8w48tbbgw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706721913; c=relaxed/simple;
	bh=bhOBYUn8A0V57QiMvsyDOgELNf10GO5/ZKhqtO7IKYA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jKLkAVB9YBsXLCHhPiGQ9IKeVnI/NCQJae0AMuokqZNyoJ8bjmjlsfUMP6MD79VlslpGBVYfrMAF6HHQd4EU4r/Bhg/BKCVUOoLcb5jyEde/XrkLZpmh2lTS0mhOqYNxq6nMyzE2UbGiZVWBWJOBRaSqOsFfGdE0z4zQoMUx3bE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tdmFp8ru; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <72a8447c-1bc8-4808-ac96-8523c2c5e66c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1706721908;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SjrL9Z9rb+yaPrSSGYpbHVjJ2807V3zI3XK3D5UmB18=;
	b=tdmFp8ruSTmArQhdsTUV9PcyQd17Ijgylq7y2LrdlmElLSGa4X1AcHr0i2/SyksuTAmc7k
	T8UsEtj9H9DnPVuCALHpK1cjWvPnAJnkGII36b8ly2OYuW9btkaqJC/jkGFqvem7ShNmka
	BB/GrAW3lJ9FTF/6CeJxK9RQlhkzILw=
Date: Wed, 31 Jan 2024 09:25:02 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 5/5] selftests/bpf: fix bench runner SIGSEGV
Content-Language: en-GB
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org,
 daniel@iogearbox.net, martin.lau@kernel.org, kernel-team@meta.com
References: <20240130193649.3753476-1-andrii@kernel.org>
 <20240130193649.3753476-6-andrii@kernel.org>
 <dad95ccc-1e24-4994-ab37-44288d6ff26b@linux.dev>
 <CAEf4BzbdNxWBijaJgmEEjEYjv4aSdH_Sw7AHOm3FiTNDRdnUEg@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAEf4BzbdNxWBijaJgmEEjEYjv4aSdH_Sw7AHOm3FiTNDRdnUEg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 1/31/24 9:17 AM, Andrii Nakryiko wrote:
> On Tue, Jan 30, 2024 at 11:41 PM Yonghong Song <yonghong.song@linux.dev> wrote:
>>
>> On 1/30/24 11:36 AM, Andrii Nakryiko wrote:
>>> Some benchmarks don't anticipate "consumer" and/or "producer" sides. Add
>> For this, you mean some future potential benchmarks, right?
> No, existing ones as well. Like trig-tp and other "trigger"
> benchmarks. I ran into this when I was trying to set consumers to 0
> explicitly, which wasn't allowed due to <= check. Then I fixed the
> check, and I ran into SIGSEGV. So I decided to fix that up.

Some description like this in the commit message will be good.

>
>>> NULL checks in corresponding places and warn about inappropriate
>>> consumer/producer count argument values.
>>>
>>> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
>> Acked-by: Yonghong Song <yonghong.song@linux.dev>
>>
>>> ---
>>>    tools/testing/selftests/bpf/bench.c | 10 +++++++++-
>>>    1 file changed, 9 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/tools/testing/selftests/bpf/bench.c b/tools/testing/selftests/bpf/bench.c
>>> index 73ce11b0547d..36962fc305eb 100644
>>> --- a/tools/testing/selftests/bpf/bench.c
>>> +++ b/tools/testing/selftests/bpf/bench.c
>>> @@ -330,7 +330,7 @@ static error_t parse_arg(int key, char *arg, struct argp_state *state)
>>>                break;
>>>        case 'c':
>>>                env.consumer_cnt = strtol(arg, NULL, 10);
>>> -             if (env.consumer_cnt <= 0) {
>>> +             if (env.consumer_cnt < 0) {
>>>                        fprintf(stderr, "Invalid consumer count: %s\n", arg);
>>>                        argp_usage(state);
>>>                }
>>> @@ -607,6 +607,10 @@ static void setup_benchmark(void)
>>>                bench->setup();
>>>
>>>        for (i = 0; i < env.consumer_cnt; i++) {
>>> +             if (!bench->consumer_thread) {
>>> +                     fprintf(stderr, "benchmark doesn't have consumers!\n");
>>> +                     exit(1);
>>> +             }
>>>                err = pthread_create(&state.consumers[i], NULL,
>>>                                     bench->consumer_thread, (void *)(long)i);
>>>                if (err) {
>>> @@ -626,6 +630,10 @@ static void setup_benchmark(void)
>>>                env.prod_cpus.next_cpu = env.cons_cpus.next_cpu;
>>>
>>>        for (i = 0; i < env.producer_cnt; i++) {
>>> +             if (!bench->producer_thread) {
>>> +                     fprintf(stderr, "benchmark doesn't have producers!\n");
>>> +                     exit(1);
>>> +             }
>>>                err = pthread_create(&state.producers[i], NULL,
>>>                                     bench->producer_thread, (void *)(long)i);
>>>                if (err) {

