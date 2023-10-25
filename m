Return-Path: <bpf+bounces-13206-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D134D7D60CE
	for <lists+bpf@lfdr.de>; Wed, 25 Oct 2023 06:18:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 165E5B2119D
	for <lists+bpf@lfdr.de>; Wed, 25 Oct 2023 04:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 103618836;
	Wed, 25 Oct 2023 04:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="j+xsP/qB"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C67FD2D626
	for <bpf@vger.kernel.org>; Wed, 25 Oct 2023 04:18:17 +0000 (UTC)
Received: from out-209.mta0.migadu.com (out-209.mta0.migadu.com [IPv6:2001:41d0:1004:224b::d1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 407D89F
	for <bpf@vger.kernel.org>; Tue, 24 Oct 2023 21:18:16 -0700 (PDT)
Message-ID: <59d468e5-767e-4ab1-a88f-8e51d6243798@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1698207494;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R3ntzb2E9SkW4Xecvck/YzPz0S9snygsjgNkEfyN7n8=;
	b=j+xsP/qBiyNJxLkAp8ZHUGULjldBp1l/9M6Q1UyW8ob6lzSDYpfoR0mqwKl1WTUgTUm2Xi
	Lf2sOMjnyrcoZ4AU7/mFuefTCyq5elZ8oXdbGfxXFXAnY71ND/wcuH+D2564RvfQFyyDbN
	VOt0hUTZ1nsqj4rpKXhxCpshERaRiio=
Date: Tue, 24 Oct 2023 21:18:08 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] selftests/bpf: Add malloc failure checks in
 bpf_iter
Content-Language: en-GB
To: Kui-Feng Lee <sinquersw@gmail.com>,
 Yuran Pereira <yuran.pereira@hotmail.com>
Cc: shuah@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org, mykolal@fb.com, brauner@kernel.org,
 iii@linux.ibm.com, kuifeng@meta.com, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <DB3PR10MB68356D7CDF6005480BE5876CE8DEA@DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM>
 <7d703c4c-1a24-4806-a483-c02efb666059@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <7d703c4c-1a24-4806-a483-c02efb666059@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 10/24/23 7:28 PM, Kui-Feng Lee wrote:
> Thank you for the patches.
>
> I found you have two patches in this set.
> You can generate both patch at once with git format-patch.
> format-patch will give each patch a number in their order.
> For example, the subject of this message will be
>
>   [PATCH bpf-next 2/2] selftest/bpf: Add malloc ....
>
> And, you put both patches in the same directory.  And sent them at once
> by giving the path of the directory. For example,
>
>   git send-email --to=bpf@vger.kernel.org path/to/the/directory/
>
> These patches will be sent in a thread instead of two independent
> messages.


Yuran, second to Kui-Feng's suggestion which is also my original
suggestion although I forgot to explicitly mention that two
patches should be in the same patch set.
I found one issue with the CHECK->ASSERT patch, so please
respin with patch v2 with two patches as the same set.


>
> On 10/24/23 18:52, Yuran Pereira wrote:
>> Since some malloc calls in bpf_iter may at times fail,
>> this patch adds the appropriate fail checks, and ensures that
>> any previously allocated resource is appropriately destroyed
>> before returning the function.
>>
>> This is patch 2 in the sequence should be applied after d1a88d37cecc
>> "selftests/bpf: Convert CHECK macros to ASSERT_* macros in bpf_iter"
>>
>> Patch 1:
>> https://lore.kernel.org/lkml/DB3PR10MB683589A5F705C6CA5BE0D325E8DFA@DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM 
>>
>>
>> Signed-off-by: Yuran Pereira <yuran.pereira@hotmail.com>
>> ---
>>   tools/testing/selftests/bpf/prog_tests/bpf_iter.c | 10 +++++++++-
>>   1 file changed, 9 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c 
>> b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
>> index 526ac4e741ee..c6cf42c64af3 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
>> @@ -700,7 +700,7 @@ static void test_overflow(bool 
>> test_e2big_overflow, bool ret1)
>>           goto free_link;
>>         buf = malloc(expected_read_len);
>> -    if (!buf)
>> +    if (!ASSERT_OK_PTR(buf, "malloc"))
>>           goto close_iter;
>>         /* do read */
>> @@ -871,6 +871,10 @@ static void test_bpf_percpu_hash_map(void)
>>         skel->rodata->num_cpus = bpf_num_possible_cpus();
>>       val = malloc(8 * bpf_num_possible_cpus());
>> +    if (!ASSERT_OK_PTR(val, "malloc")) {
>> +        bpf_iter_bpf_percpu_hash_map__destroy(skel);
>> +        return;
>> +    }
>
> You can just do "goto out;" here.
>
>
>>         err = bpf_iter_bpf_percpu_hash_map__load(skel);
>>       if (!ASSERT_OK_PTR(skel, "bpf_iter_bpf_percpu_hash_map__load"))
>> @@ -1048,6 +1052,10 @@ static void test_bpf_percpu_array_map(void)
>>         skel->rodata->num_cpus = bpf_num_possible_cpus();
>>       val = malloc(8 * bpf_num_possible_cpus());
>> +    if (!ASSERT_OK_PTR(val, "malloc")) {
>> +        bpf_iter_bpf_percpu_array_map__destroy(skel);
>> +        return;
>> +    }
>
> Same here, even it will call free(val), free(val) will do nothing when
> val is NULL.
>
>>         err = bpf_iter_bpf_percpu_array_map__load(skel);
>>       if (!ASSERT_OK_PTR(skel, "bpf_iter_bpf_percpu_array_map__load"))

