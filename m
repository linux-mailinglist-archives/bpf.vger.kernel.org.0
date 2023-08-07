Return-Path: <bpf+bounces-7186-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CE73772C0F
	for <lists+bpf@lfdr.de>; Mon,  7 Aug 2023 19:08:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBB952814CE
	for <lists+bpf@lfdr.de>; Mon,  7 Aug 2023 17:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06F7B125D3;
	Mon,  7 Aug 2023 17:08:05 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2CA3125B3
	for <bpf@vger.kernel.org>; Mon,  7 Aug 2023 17:08:04 +0000 (UTC)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8DEF1A3
	for <bpf@vger.kernel.org>; Mon,  7 Aug 2023 10:08:02 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id 46e09a7af769-6bd011dc2e7so201613a34.3
        for <bpf@vger.kernel.org>; Mon, 07 Aug 2023 10:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691428082; x=1692032882;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=umunrnbPrAood3tmFHCyahEfKYvMse04c234Fl53qEQ=;
        b=f3fTJpaw72tj4wI670TzgKRTgkSRUEErKaf4QqF6Lxe8EmUApowUccfRL7MIHee8rW
         yx6dgZDl6CYg3IIW6r0e6DvKdYhc1fgh2UeasqwLRiYVQZP/SSvYsD1pa6WgMGFY+LxR
         s73mFtoXRJW+aVfHp0UdZXCF7vgNJq9ICZP8MLU+jQT1y6z1zZPMc/OugiEH7+gAb2zm
         /Y6QoNazAWaqormZvZihL2jK8o6SUsKWlxM3OFobN4Va/iqC9bOydCskC4LSlyprmps3
         Y9301zoOjefyt5h3eERK7lGzZSOnsXDkjZgAfAScd5mLFnML68V7CXtp8EYLES0crWol
         bvCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691428082; x=1692032882;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=umunrnbPrAood3tmFHCyahEfKYvMse04c234Fl53qEQ=;
        b=ZI9nGUrUYEiivtgZJTZEeoCo77yPoiLOrKYvvBVjb7w43MBgSueh9FY3SeGE082LAk
         RYWg9RRikJGadOfLPfCITMObLLNUvvDgPOtK1p/ZTGXwb1V/jGnANnsWKR1VQVNkbhjo
         hUBHH42421d6TTTkL3FrLfyfC1JkdSNnAHr6gu/jH7AoiNNHq+bHV41L0La1Yn/TS1jh
         5SjH5V0umSXATQQ4XYuGkTtSVP7m5yWDZqJP/8qCF0maR8FQ6fqYx1vb5kuMgCd7Y2dV
         +QChkmljoN7e25uvmDsghsyXyvqGW2eXmulMca/94srLH29gJ+w0owyw32u+cMrMfeqo
         EYvg==
X-Gm-Message-State: AOJu0YwGGzpUoPC7/S5s6XH1/NS8dvabIdCn8qoX9x01HIogqaZdHQ/0
	B4YNgjsUJvK0LTgQ2UX1EKyGXvNqCu8=
X-Google-Smtp-Source: AGHT+IF0fVOkarvm46vqepIsgSaN72XtdXFL9u2wdp6PfwyGUAWeeWU37YYpatdaa5cwBDldyxq95A==
X-Received: by 2002:a05:6358:922:b0:137:881b:fc73 with SMTP id r34-20020a056358092200b00137881bfc73mr3093550rwi.2.1691428081941;
        Mon, 07 Aug 2023 10:08:01 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:24f0:2f4c:34ea:71b5? ([2600:1700:6cf8:1240:24f0:2f4c:34ea:71b5])
        by smtp.gmail.com with ESMTPSA id a205-20020a0dd8d6000000b005772154dddbsm2784678ywe.24.2023.08.07.10.08.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Aug 2023 10:08:01 -0700 (PDT)
Message-ID: <5f4bbed7-e0d1-e848-d820-e74b551075b4@gmail.com>
Date: Mon, 7 Aug 2023 10:07:59 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH bpf-next] bpf: fix bpf_dynptr_slice() to stop return an
 ERR_PTR.
To: Martin KaFai Lau <martin.lau@linux.dev>, thinker.li@gmail.com
Cc: kuifeng@meta.com, Dan Carpenter <dan.carpenter@linaro.org>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org,
 ast@kernel.org, song@kernel.org, kernel-team@meta.com, andrii@kernel.org
References: <20230803231206.1060485-1-thinker.li@gmail.com>
 <e0e8bf3b-70af-3827-2fa3-30f3d48bcf46@linux.dev>
Content-Language: en-US
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <e0e8bf3b-70af-3827-2fa3-30f3d48bcf46@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 8/4/23 15:26, Martin KaFai Lau wrote:
> On 8/3/23 4:12 PM, thinker.li@gmail.com wrote:
>> From: Kui-Feng Lee <thinker.li@gmail.com>
>>
>> Verify if the pointer obtained from bpf_xdp_pointer() is either an 
>> error or
>> NULL before returning it.
>>
>> The function bpf_dynptr_slice() mistakenly returned an ERR_PTR. 
>> Instead of
>> solely checking for NULL, it should also verify if the pointer 
>> returned by
>> bpf_xdp_pointer() is an error or NULL.
>>
>> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
>> Closes: 
>> https://lore.kernel.org/bpf/d1360219-85c3-4a03-9449-253ea905f9d1@moroto.mountain/
>> Fixes: 66e3a13e7c2c ("bpf: Add bpf_dynptr_slice and 
>> bpf_dynptr_slice_rdwr")
>> Suggested-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
>> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
>> ---
>>   kernel/bpf/helpers.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
>> index 56ce5008aedd..eb91cae0612a 100644
>> --- a/kernel/bpf/helpers.c
>> +++ b/kernel/bpf/helpers.c
>> @@ -2270,7 +2270,7 @@ __bpf_kfunc void *bpf_dynptr_slice(const struct 
>> bpf_dynptr_kern *ptr, u32 offset
>>       case BPF_DYNPTR_TYPE_XDP:
>>       {
>>           void *xdp_ptr = bpf_xdp_pointer(ptr->data, ptr->offset + 
>> offset, len);
>> -        if (xdp_ptr)
>> +        if (!IS_ERR_OR_NULL(xdp_ptr))
> 
> Considering the earlier bpf_dynptr_check_off_len() should have avoided 
> the IS_ERR() case here, I think targeting bpf-next makes sense. Applied.

It is a good point. I think the bpf_dynptr_check_off_len() check is
wrong as well. According to the behavior of the rest of the function,
it should be

     err = bpf_dynptr_check_off_len(ptr, ptr->offset + offset, len);

How do you think?


