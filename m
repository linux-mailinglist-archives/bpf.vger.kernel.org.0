Return-Path: <bpf+bounces-10322-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D870D7A51CE
	for <lists+bpf@lfdr.de>; Mon, 18 Sep 2023 20:12:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F02D51C20CA6
	for <lists+bpf@lfdr.de>; Mon, 18 Sep 2023 18:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 012CE26E06;
	Mon, 18 Sep 2023 18:12:35 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3287F2628D
	for <bpf@vger.kernel.org>; Mon, 18 Sep 2023 18:12:33 +0000 (UTC)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB454DB
	for <bpf@vger.kernel.org>; Mon, 18 Sep 2023 11:12:31 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-59bebd5bdadso49195197b3.0
        for <bpf@vger.kernel.org>; Mon, 18 Sep 2023 11:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695060751; x=1695665551; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zc4PgWRxecTtfgDpoCIPBNUaoHzQRk1JqGTxOdAHn4g=;
        b=UCcalSfEMYHX50FcCgvPHGhoMFdZESRduXOV4EUgp0bJ0B09SNN737mPiOTSyX5p6j
         8pt4jK7FcvbU060V+7ry4o0j9mcdp/DU1HVmD9v7FrfVcBsAHGyCz9JUgN+kmKGYFOdN
         SZae+BnOy6W8tEOlETUk9z5uh8wvWkCfiOpKJf5uQDMydp9SmNHNG8dNFnIbHCA3SX8b
         xHQ69diwZdptis4E7mAFRI0bwHyAj20zVo8hpQdzgQq5XEL17Kgbo+Yq/JFpDAX5tD2k
         qZOaZkuLm58UWfYN9gnknmfQK3V/wWkjxMSlOgTvMU6JThjmbeLLW4WXvVvczGau/c8J
         dxXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695060751; x=1695665551;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zc4PgWRxecTtfgDpoCIPBNUaoHzQRk1JqGTxOdAHn4g=;
        b=qXytQkkuUg8DtV1ktOWhUaGypXXKoJa3/vDe6A8Bno6egPqXRQQOlWBvEv8dpaAVok
         67tguYrfESd9ElqCWGdjkka1wjmNDemcqc/zsFSfBX7TUwiZhp1HXY4lpPbr6bXsq5OA
         LnU7dDACFWJEN7ZOnsPqtxepq7Wx+FOwpKojL76NwU8n3q7Wn3Rpf5gcv2tYxhrpRNSt
         B8E5cr25ofIRD4KNWhImkwBv3JOD6kSxQHbWFUB8iynaIqx2T/4eIozCimP9L2eeZ0Gp
         i23IGmDbBsI1Wocv7ngS6UGZQcQfk2IggwjGLdRDOrSYCfpKNNRirNy5s4LUnwue0AjF
         e3Xg==
X-Gm-Message-State: AOJu0YzXaRxKil1VNSzntKgi4U9LAnVfOw6otAz1PmhQh3y+k0y221Yu
	vhtFMszG7xU0dfwwI0v6QMHfZxw+mdY=
X-Google-Smtp-Source: AGHT+IERmmPYt3sNDRZr2YmxFa+ZefhdSpjlXc4gRbaafOdVjETjxmfqIZ/JZsjP21IvKjpDjZj5IA==
X-Received: by 2002:a25:dcc3:0:b0:d62:6514:45b7 with SMTP id y186-20020a25dcc3000000b00d62651445b7mr9354394ybe.37.1695060750954;
        Mon, 18 Sep 2023 11:12:30 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:cd9b:b05b:a4d3:eeda? ([2600:1700:6cf8:1240:cd9b:b05b:a4d3:eeda])
        by smtp.gmail.com with ESMTPSA id d18-20020a256812000000b00d7e339ada01sm2416403ybc.20.2023.09.18.11.12.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Sep 2023 11:12:30 -0700 (PDT)
Message-ID: <11fb1a32-ea91-d9af-0406-50f5f722014f@gmail.com>
Date: Mon, 18 Sep 2023 11:12:29 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH bpf-next v2 2/3] bpf: Fix bpf_throw warning on 32-bit arch
Content-Language: en-US
To: Matthieu Baerts <matthieu.baerts@tessares.net>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org,
 Alexei Starovoitov <ast@kernel.org>
References: <20230918155233.297024-1-memxor@gmail.com>
 <20230918155233.297024-3-memxor@gmail.com>
 <b74e5f1e-d054-42ea-ab69-91c92278a82a@tessares.net>
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <b74e5f1e-d054-42ea-ab69-91c92278a82a@tessares.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 9/18/23 10:09, Matthieu Baerts wrote:
> Hi Kumar,
> 
> On 18/09/2023 17:52, Kumar Kartikeya Dwivedi wrote:
>> On 32-bit architectures, the pointer width is 32-bit, while we try to
>> cast from a u64 down to it, the compiler complains on mismatch in
>> integer size. Fix this by first casting to long which should match
>> the pointer width on targets supported by Linux.
> 
> Thank you for the patch, it fixes the issue on our side!
> 
> (Not sure you need a tested by tag but just in case: )
> 
> Tested-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> 
>> Fixes: ec5290a178b7 ("bpf: Prevent KASAN false positive with bpf_throw")
>> Reported-by: Matthieu Baerts <matthieu.baerts@tessares.net>
>> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
>> ---
>>   kernel/bpf/helpers.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
>> index 7ff2a42f1996..dd1c69ee3375 100644
>> --- a/kernel/bpf/helpers.c
>> +++ b/kernel/bpf/helpers.c
>> @@ -2488,7 +2488,7 @@ __bpf_kfunc void bpf_throw(u64 cookie)
>>   	 * deeper stack depths than ctx.sp as we do not return from bpf_throw,
>>   	 * which skips compiler generated instrumentation to do the same.
>>   	 */
>> -	kasan_unpoison_task_stack_below((void *)ctx.sp);
>> +	kasan_unpoison_task_stack_below((void *)(long)ctx.sp);
> I never know what's the recommended way to fix such issues: casting it
> to 'long' or 'unsigned long'? But it looks like both are used in the
> kernel and 'long' is more often used than the other one so all good I
> suppose.

Shouldn't we have a macro to do this kind of casting if there is not?
Without any comment, it is difficult to know why this extra casting
is here.

> 
>>   	ctx.aux->bpf_exception_cb(cookie, ctx.sp, ctx.bp);
>>   	WARN(1, "A call to BPF exception callback should never return\n");
>>   }
> 
> Cheers,
> Matt

