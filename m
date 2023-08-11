Return-Path: <bpf+bounces-7601-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C82607796F2
	for <lists+bpf@lfdr.de>; Fri, 11 Aug 2023 20:17:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D636C1C217AF
	for <lists+bpf@lfdr.de>; Fri, 11 Aug 2023 18:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82E1B219EE;
	Fri, 11 Aug 2023 18:17:47 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC5963B6
	for <bpf@vger.kernel.org>; Fri, 11 Aug 2023 18:17:47 +0000 (UTC)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA88B30DC;
	Fri, 11 Aug 2023 11:17:45 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id 46e09a7af769-6bcade59b24so2107113a34.0;
        Fri, 11 Aug 2023 11:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691777865; x=1692382665;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SQqE+Ue+6SpeZj6peJ5HU4cZgn9PU7wnh/lsZj3W1iQ=;
        b=bP46BjbwLyUSTLd5UseGpKJKulLoAVHb8yrj+hq8KneMxIiNdSG32tB+tqPClhBi1+
         9lUl/cNMMKEtWk9WkmZVcp5rcb7+MkXVj6WsNarq8dFmguVPrIw5fSzmeRdRS/a2TNu3
         iTNsv3GHg4L8CBB0B3m51Vd/EtxlqsoHtL8Im5bqIKDyyQRRQ5AkLbNdaI3g3oE+ut5o
         RFPp3wjZcVxk+whE9lhM/x5O5QP2oMaUP/oPbXn0yyepTz7JaRrwryvF1nPfSWvI06C2
         TXVt89FQTizLSOlb7j+7kpcRSnEsq6qoO7zyQa+m/sVfwmjNe+S4mggwVPiTbYMvJhmc
         FfpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691777865; x=1692382665;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SQqE+Ue+6SpeZj6peJ5HU4cZgn9PU7wnh/lsZj3W1iQ=;
        b=Q0YqUriPBbxDk9ZxUX44I2AA6NOoKxBP0V2hE+dmdD5R6nAzDSB0O/ZhpYxjkXOIqK
         69/a3wJ8DXGXGJEf4aRD97kRIorwaLB818njaP2xQqV1/C1lWiuh+j8cXAH8D6T5NHAk
         V9lgZJJamYt3dUBs/1h1QyxMsPpFx1qADraISKhic2PoYmG/cUW4wQ30kqAzvSMFm6Nh
         1F3KssmC+TdgTffKAP8xjSuHriDLfvvoIF/MAdpa8k2hq0w6wfLT4nv78zDZ7y7eCGEy
         Eb5uLUyPrj1QHIiaUCimT+A8aWHHMQe1d9QWukO9sWJA+k1Q0yNObTBHJBgimfeDmpzP
         B/Cw==
X-Gm-Message-State: AOJu0YxRV2ThAZB62AHfvnSN52B38qlGEJnwSk/XlI+vKQsRQRtHevSB
	ltgK5ZPDxjevgfpsoqUgIZw=
X-Google-Smtp-Source: AGHT+IGxYxOAki0vsFy5fBlm1hCjYbjsiF2cAbEAb2gOwu73ZObvcE9q8RJfT/ZAbvfliE2aW1C4KA==
X-Received: by 2002:a05:6830:d6:b0:6bd:b28:fa1 with SMTP id x22-20020a05683000d600b006bd0b280fa1mr2645854oto.32.1691777865245;
        Fri, 11 Aug 2023 11:17:45 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:7743:83c4:3456:7b18? ([2600:1700:6cf8:1240:7743:83c4:3456:7b18])
        by smtp.gmail.com with ESMTPSA id o124-20020a254182000000b00d1f0204c1b6sm1052252yba.27.2023.08.11.11.17.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Aug 2023 11:17:44 -0700 (PDT)
Message-ID: <887699ea-f837-6ed7-50bd-48720cea581c@gmail.com>
Date: Fri, 11 Aug 2023 11:17:43 -0700
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
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <fe388d79-bdfc-0480-5f4b-1a40016fd53d@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 8/11/23 10:35, Martin KaFai Lau wrote:
> On 8/10/23 4:15 PM, Stanislav Fomichev wrote:
>> On 08/10, David Vernet wrote:
>>> On Thu, Aug 10, 2023 at 03:46:18PM -0700, Stanislav Fomichev wrote:
>>>> On 08/10, David Vernet wrote:
>>>>> Currently, if a struct_ops map is loaded with BPF_F_LINK, it must also
>>>>> define the .validate() and .update() callbacks in its corresponding
>>>>> struct bpf_struct_ops in the kernel. Enabling struct_ops link is 
>>>>> useful
>>>>> in its own right to ensure that the map is unloaded if an application
>>>>> crashes. For example, with sched_ext, we want to automatically unload
>>>>> the host-wide scheduler if the application crashes. We would likely
>>>>> never support updating elements of a sched_ext struct_ops map, so we'd
>>>>> have to implement these callbacks showing that they _can't_ support
>>>>> element updates just to benefit from the basic lifetime management of
>>>>> struct_ops links.
>>>>>
>>>>> Let's enable struct_ops maps to work with BPF_F_LINK even if they
>>>>> haven't defined these callbacks, by assuming that a struct_ops map
>>>>> element cannot be updated by default.
>>>>
>>>> Any reason this is not part of sched_ext series? As you mention,
>>>> we don't seem to have such users in the three?
>>>
>>> Hi Stanislav,
>>>
>>> The sched_ext series [0] implements these callbacks. See
>>> bpf_scx_update() and bpf_scx_validate().
>>>
>>> [0]: https://lore.kernel.org/all/20230711011412.100319-13-tj@kernel.org/
>>>
>>> We could add this into that series and remove those callbacks, but this
>>> patch is fixing a UX / API issue with struct_ops links that's not really
>>> relevant to sched_ext. I don't think there's any reason to couple
>>> updating struct_ops map elements with allowing the kernel to manage the
>>> lifetime of struct_ops maps -- just because we only have 1 (non-test)
> 
> Agree the link-update does not necessarily couple with link-creation, so 
> removing 'link' update function enforcement is ok. The intention was to 
> avoid the struct_ops link inconsistent experience (one struct_ops link 
> support update and another struct_ops link does not) because consistency 
> was one of the reason for the true kernel backed link support that 
> Kui-Feng did. tcp-cc is the only one for now in struct_ops and it can 
> support update, so the enforcement is here. I can see Stan's point that 
> removing it now looks immature before a struct_ops landed in the kernel 
> showing it does not make sense or very hard to support 'link' update. 
> However, the scx patch set has shown this point, so I think it is good 
> enough.
> 
> For 'validate', it is not related a 'link' update. It is for the 
> struct_ops 'map' update. If the loaded struct_ops map is invalid, it 
> will end up having a useless struct_ops map and no link can be created 
> from it. I can see some struct_ops subsystem check all the 'ops' 
> function for NULL before calling (like the FUSE RFC). I can also see 
> some future struct_ops will prefer not to check NULL at all and prefer 
> to assume a subset of the ops is always valid. Does having a 'validate' 
> enforcement is blocking the scx patchset in some way? If not, I would 
> like to keep this for now. Once it is removed, there is no turning back.

I am not saying which one is right or wrong, but the followings are some
of my concerns. Just FYI!

The 'validate' change more likes a default implementation that always
return 0.  It is up to struct_ops types to decide how to validate
values. If they decide to always success, this change will save them
a bit of time. In opposite, allowing empty update may make difficulties
to the developers of new struct_ops types. New developers
may spend a lot of time in the code base to figure out that they should 
implement an update function to make it work. A better document may
help. However, checking these function pointers at the first moment is
even better.

> 
>>> struct_ops implementation in-tree doesn't mean we shouldn't improve APIs
>>> where it makes sense.
>>>
>>> Thanks,
>>> David
>>
>> Ack. I guess up to you and Martin. Just trying to understand whether I'm
>> missing something or the patch does indeed fix some use-case :-)
> 
> 

