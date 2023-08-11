Return-Path: <bpf+bounces-7618-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DDF9779B0F
	for <lists+bpf@lfdr.de>; Sat, 12 Aug 2023 01:13:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EBBD1C20B67
	for <lists+bpf@lfdr.de>; Fri, 11 Aug 2023 23:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55FAD3D39F;
	Fri, 11 Aug 2023 23:12:57 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2301F360FF
	for <bpf@vger.kernel.org>; Fri, 11 Aug 2023 23:12:56 +0000 (UTC)
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6122268C;
	Fri, 11 Aug 2023 16:12:55 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id 3f1490d57ef6-d665467e134so1416017276.2;
        Fri, 11 Aug 2023 16:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691795575; x=1692400375;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tqQKIO5AjXBgh+bVL8rHz/ntbbFiY2j+IWODE6q80SY=;
        b=BHA+6qiR/KO5c0LrxCioBwPP0Feu10S3st1ydRqhYasHt4MsTslciVmFkyeoytZqDQ
         YysSlWb9RQTjmSpKwI4LyEngbqk6PaZwbTSJHkaHrYeaafozWImaN0eyYpv8JTEgxiQQ
         OuL9jyCDMlkkEuEkbh6vJhZv9LhCQ1603HhbI2Tr2CBg8Ua/S3nFt/dWnJLTeWS2wEa+
         lYH4m4rmiJncafA5hMANuSAYCPtMCLUNL4CqI5jlNkS3ghzthQ2xfwT0tCTHBJ3MznXk
         ikCy+NDADbL/aNvRVAtlIGrnQi21t5xZeNWNLmZd6//x0HcrD3d5p7ZUelegr+8ab4oG
         AtzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691795575; x=1692400375;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tqQKIO5AjXBgh+bVL8rHz/ntbbFiY2j+IWODE6q80SY=;
        b=XLEoAxmpp6Btkn/oWB0H3QAho0pNkQMwLIDkG4X9Q33mASj3K4M+6cskD4jKAo4Jqz
         kQD946csutByEpBJVnS7kJwUCecaufKiKliG7kNJOi2+IpmXInK+ytUOXb1HDIhqB6FH
         LjIl+6PokzAm5VPUSfZXwJAn8PCk+HimZm27+tXOfykADlLW8UXms6tq8Jcbb5lL6V6Y
         YcbvLqUzaLcEtnHY7qdoL/rVRFDB8+tx8UDq/ACTNKgAYhBG2cFfCivSka2vvwXGbh38
         zupYfLhFLj+td+zbHzySRSpnCdGRpu5CvG8R5qzib+x1xyS8OJHhdtXoe0y3qAORdmNh
         kSIA==
X-Gm-Message-State: AOJu0YxY6AbEnoIwpCNTuvBLbA6q7pqKA2SsXss+O8nxE5G7SKJ1p9Kk
	wKSmPk1NCY7OpXZlRkyA+TA=
X-Google-Smtp-Source: AGHT+IEVLx3Ju5tLFvKip8p9rSAPh9FRb6yCOuuYtx7PEQ1GF2oRC90D7GhlP+jLea4G6Z61uMzZEw==
X-Received: by 2002:a25:adc4:0:b0:d1c:5049:687b with SMTP id d4-20020a25adc4000000b00d1c5049687bmr3410819ybe.16.1691795575100;
        Fri, 11 Aug 2023 16:12:55 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:680f:f8a3:c49b:84db? ([2600:1700:6cf8:1240:680f:f8a3:c49b:84db])
        by smtp.gmail.com with ESMTPSA id l124-20020a25cc82000000b00d538f9d0f4dsm1184460ybf.18.2023.08.11.16.12.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Aug 2023 16:12:54 -0700 (PDT)
Message-ID: <03f9f9be-620d-a44d-d6a3-8b9084344db5@gmail.com>
Date: Fri, 11 Aug 2023 16:12:52 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH bpf-next] bpf: Support default .validate() and .update()
 behavior for struct_ops links
Content-Language: en-US
To: Martin KaFai Lau <martin.lau@linux.dev>, David Vernet <void@manifault.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
 kpsingh@kernel.org, haoluo@google.com, jolsa@kernel.org,
 linux-kernel@vger.kernel.org, kernel-team@meta.com, tj@kernel.org,
 clm@meta.com, thinker.li@gmail.com, Stanislav Fomichev <sdf@google.com>
References: <20230810220456.521517-1-void@manifault.com>
 <ZNVousfpuRFgfuAo@google.com> <20230810230141.GA529552@maniforge>
 <ZNVvfYEsLyotn+G1@google.com>
 <fe388d79-bdfc-0480-5f4b-1a40016fd53d@linux.dev>
 <20230811201914.GD542801@maniforge>
 <d1fa5eff-b0d2-4388-0513-eaead8542b9f@linux.dev>
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <d1fa5eff-b0d2-4388-0513-eaead8542b9f@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 8/11/23 15:49, Martin KaFai Lau wrote:
> On 8/11/23 1:19 PM, David Vernet wrote:
>> On Fri, Aug 11, 2023 at 10:35:03AM -0700, Martin KaFai Lau wrote:
>>> On 8/10/23 4:15 PM, Stanislav Fomichev wrote:
>>>> On 08/10, David Vernet wrote:
>>>>> On Thu, Aug 10, 2023 at 03:46:18PM -0700, Stanislav Fomichev wrote:
>>>>>> On 08/10, David Vernet wrote:
>>>>>>> Currently, if a struct_ops map is loaded with BPF_F_LINK, it must 
>>>>>>> also
>>>>>>> define the .validate() and .update() callbacks in its corresponding
>>>>>>> struct bpf_struct_ops in the kernel. Enabling struct_ops link is 
>>>>>>> useful
>>>>>>> in its own right to ensure that the map is unloaded if an 
>>>>>>> application
>>>>>>> crashes. For example, with sched_ext, we want to automatically 
>>>>>>> unload
>>>>>>> the host-wide scheduler if the application crashes. We would likely
>>>>>>> never support updating elements of a sched_ext struct_ops map, so 
>>>>>>> we'd
>>>>>>> have to implement these callbacks showing that they _can't_ support
>>>>>>> element updates just to benefit from the basic lifetime 
>>>>>>> management of
>>>>>>> struct_ops links.
>>>>>>>
>>>>>>> Let's enable struct_ops maps to work with BPF_F_LINK even if they
>>>>>>> haven't defined these callbacks, by assuming that a struct_ops map
>>>>>>> element cannot be updated by default.
>>>>>>
>>>>>> Any reason this is not part of sched_ext series? As you mention,
>>>>>> we don't seem to have such users in the three?
>>>>>
>>>>> Hi Stanislav,
>>>>>
>>>>> The sched_ext series [0] implements these callbacks. See
>>>>> bpf_scx_update() and bpf_scx_validate().
>>>>>
>>>>> [0]: 
>>>>> https://lore.kernel.org/all/20230711011412.100319-13-tj@kernel.org/
>>>>>
>>>>> We could add this into that series and remove those callbacks, but 
>>>>> this
>>>>> patch is fixing a UX / API issue with struct_ops links that's not 
>>>>> really
>>>>> relevant to sched_ext. I don't think there's any reason to couple
>>>>> updating struct_ops map elements with allowing the kernel to manage 
>>>>> the
>>>>> lifetime of struct_ops maps -- just because we only have 1 (non-test)
>>>
>>> Agree the link-update does not necessarily couple with link-creation, so
>>> removing 'link' update function enforcement is ok. The intention was to
>>> avoid the struct_ops link inconsistent experience (one struct_ops link
>>> support update and another struct_ops link does not) because 
>>> consistency was
>>> one of the reason for the true kernel backed link support that 
>>> Kui-Feng did.
>>> tcp-cc is the only one for now in struct_ops and it can support 
>>> update, so
>>> the enforcement is here. I can see Stan's point that removing it now 
>>> looks
>>> immature before a struct_ops landed in the kernel showing it does not 
>>> make
>>> sense or very hard to support 'link' update. However, the scx patch 
>>> set has
>>> shown this point, so I think it is good enough.
>>
>> Sorry for sending v2 of the patch a bit prematurely. Should have let you
>> weigh in first.
>>
>>> For 'validate', it is not related a 'link' update. It is for the 
>>> struct_ops
>>> 'map' update. If the loaded struct_ops map is invalid, it will end up 
>>> having
>>> a useless struct_ops map and no link can be created from it. I can 
>>> see some
>>
>> To be honest I'm actually not sure I understand why .validate() is only
>> called for when BPF_F_LINK is specified. Is it because it could break
> 
> Regardless '.validate' must be enforced or not, the ->validate() should 
> be called for the non BPF_F_LINK case also during map update. This 
> should be fixed.

For the case of the TCP congestion control, its validation function is
called by the implementations of ->validate() and ->reg(). I mean it
expects ->reg() to do validation as well.

... SKIP ...

