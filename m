Return-Path: <bpf+bounces-7608-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6316F77995B
	for <lists+bpf@lfdr.de>; Fri, 11 Aug 2023 23:26:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 219901C20B2D
	for <lists+bpf@lfdr.de>; Fri, 11 Aug 2023 21:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15192329C5;
	Fri, 11 Aug 2023 21:25:52 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E066F11700
	for <bpf@vger.kernel.org>; Fri, 11 Aug 2023 21:25:51 +0000 (UTC)
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D28F171F;
	Fri, 11 Aug 2023 14:25:49 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-579de633419so25887877b3.3;
        Fri, 11 Aug 2023 14:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691789148; x=1692393948;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FISt7eMS+MX6qoPjTvfVYa6E6zsF10b72UweTYY1pv8=;
        b=iWHEBLBK9jM/jNgN8pbENIRFcK5n1pS3UtGOs5EgDxYB5/cne600fDaVf57OpSIgHW
         iEDu1IV+OM2HHzQ83uvcbrOoQ/+B8DXL3Z9Tnz0kRfvhRCdBFDU29lliX6sIipyY/Y5p
         6pq4DdstVObG8LO+FWJEXiF3ZyC3H75BGt4JjR0cfk74Q+o5t47gjP1pjyAq0hWwUCNr
         i/9PnUHcubnH8mAEr9JQgWkWHUoZE2eRZT4dQjS9ZhVbJEeGxwg4t7XyVIZdAeLrVt6Y
         ft7B91TlBtguins4+wPdQSPXJEG5etA2a3I8ZiBCAjohL6zW9p3WRaIbZWRbI9KvnJFs
         Q4rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691789148; x=1692393948;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FISt7eMS+MX6qoPjTvfVYa6E6zsF10b72UweTYY1pv8=;
        b=TQYZlXsP9GOwpHa/HbJFLaYQqjQgGu9LBEwUcTYhGikE1t9+1VXaWxwDG2H1ShrIaA
         AGkqc05dT/DPCt6yVhfm2/dT0EaWSRA4l7gfmGSbFDeD5x9TugxFZRGCl5sRvo3BPjWw
         agPQ6fU+0lWxgNFo7kuWmeBIbMBYbHsllTt6ILXRS5QzKuG0Vc3Z/ZcdGRFl9z4DnQzb
         jPr2wbjczlUZilneeY+SGfgYhSddkzwMEvZx6B495+mjDCffiJhphaQwzrJcn2dVXQSU
         DFm9l29w4Z09OMEst+la9dY3OQIWXP3M6iq3eWKafvE2ZWn/LDROBeBaASMnxgkwBXuE
         3LVg==
X-Gm-Message-State: AOJu0YypHWP4Ru1WNsqU5I4PZvbS/g0mvoxnCz2yz1Sw/SasHgm8lZ9b
	AZVucTD1q0IIMEWI4W2LVDg=
X-Google-Smtp-Source: AGHT+IFkxrx2Tzz7Edsvy/h0S4qSIVsAmn6YcsHcfQwpYp12w4oM91xbu04SejY/5HfQ0KHhl180gw==
X-Received: by 2002:a81:6c87:0:b0:586:9cbb:eef4 with SMTP id h129-20020a816c87000000b005869cbbeef4mr3222100ywc.2.1691789147870;
        Fri, 11 Aug 2023 14:25:47 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:aee5:311a:9c43:b97b? ([2600:1700:6cf8:1240:aee5:311a:9c43:b97b])
        by smtp.gmail.com with ESMTPSA id em3-20020a05690c2b0300b005869e1d8c41sm1221497ywb.29.2023.08.11.14.25.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Aug 2023 14:25:47 -0700 (PDT)
Message-ID: <11bb526e-27b3-2313-2d9f-c58e69e5feab@gmail.com>
Date: Fri, 11 Aug 2023 14:25:45 -0700
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
To: David Vernet <void@manifault.com>, Martin KaFai Lau <martin.lau@linux.dev>
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
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <20230811201914.GD542801@maniforge>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 8/11/23 13:19, David Vernet wrote:
> On Fri, Aug 11, 2023 at 10:35:03AM -0700, Martin KaFai Lau wrote:
>> On 8/10/23 4:15 PM, Stanislav Fomichev wrote:
>>> On 08/10, David Vernet wrote:
>>>> On Thu, Aug 10, 2023 at 03:46:18PM -0700, Stanislav Fomichev wrote:
>>>>> On 08/10, David Vernet wrote:
>>>>>> Currently, if a struct_ops map is loaded with BPF_F_LINK, it must also
>>>>>> define the .validate() and .update() callbacks in its corresponding
>>>>>> struct bpf_struct_ops in the kernel. Enabling struct_ops link is useful
>>>>>> in its own right to ensure that the map is unloaded if an application
>>>>>> crashes. For example, with sched_ext, we want to automatically unload
>>>>>> the host-wide scheduler if the application crashes. We would likely
>>>>>> never support updating elements of a sched_ext struct_ops map, so we'd
>>>>>> have to implement these callbacks showing that they _can't_ support
>>>>>> element updates just to benefit from the basic lifetime management of
>>>>>> struct_ops links.
>>>>>>
>>>>>> Let's enable struct_ops maps to work with BPF_F_LINK even if they
>>>>>> haven't defined these callbacks, by assuming that a struct_ops map
>>>>>> element cannot be updated by default.
>>>>>
>>>>> Any reason this is not part of sched_ext series? As you mention,
>>>>> we don't seem to have such users in the three?
>>>>
>>>> Hi Stanislav,
>>>>
>>>> The sched_ext series [0] implements these callbacks. See
>>>> bpf_scx_update() and bpf_scx_validate().
>>>>
>>>> [0]: https://lore.kernel.org/all/20230711011412.100319-13-tj@kernel.org/
>>>>
>>>> We could add this into that series and remove those callbacks, but this
>>>> patch is fixing a UX / API issue with struct_ops links that's not really
>>>> relevant to sched_ext. I don't think there's any reason to couple
>>>> updating struct_ops map elements with allowing the kernel to manage the
>>>> lifetime of struct_ops maps -- just because we only have 1 (non-test)
>>
>> Agree the link-update does not necessarily couple with link-creation, so
>> removing 'link' update function enforcement is ok. The intention was to
>> avoid the struct_ops link inconsistent experience (one struct_ops link
>> support update and another struct_ops link does not) because consistency was
>> one of the reason for the true kernel backed link support that Kui-Feng did.
>> tcp-cc is the only one for now in struct_ops and it can support update, so
>> the enforcement is here. I can see Stan's point that removing it now looks
>> immature before a struct_ops landed in the kernel showing it does not make
>> sense or very hard to support 'link' update. However, the scx patch set has
>> shown this point, so I think it is good enough.
> 
> Sorry for sending v2 of the patch a bit prematurely. Should have let you
> weigh in first.
> 
>> For 'validate', it is not related a 'link' update. It is for the struct_ops
>> 'map' update. If the loaded struct_ops map is invalid, it will end up having
>> a useless struct_ops map and no link can be created from it. I can see some
> 
> To be honest I'm actually not sure I understand why .validate() is only
> called for when BPF_F_LINK is specified. Is it because it could break
> existing programs if they defined a struct_ops map that wasn't valid
> _without_ using BPF_F_LINK? Whether or not a map is valid should inform
> whether we can load it regardless of whether there's a link, no? It
> seems like .init_member() was already doing this as well. That's why I
> got confused and conflated the two.

With the previous solution (without link), you can not update the values
of a struct_ops map directly.
You have to delete the existing value before update it.
Updating a value would register a value, a function set,
to the implementation of a struct_ops type. Deleting a value
would unregister the value. So, the validation can be performed
in the registration function.

For BPF_LINK, it provides a solution to update a function
set atomically.  You doesn't have to unregister an existing
one before installing a new one. That is why validate functions
are invented.

init_member() handles/validates per-member value.  It can not detect
what is necessary but absent.  validate() has a full set of function
pointers (all members), so it is able to determine if something
necessary is missing.

> 
>> struct_ops subsystem check all the 'ops' function for NULL before calling
>> (like the FUSE RFC). I can also see some future struct_ops will prefer not
>> to check NULL at all and prefer to assume a subset of the ops is always
>> valid. Does having a 'validate' enforcement is blocking the scx patchset in
>> some way? If not, I would like to keep this for now. Once it is removed,
> 
> No, it's not blocking scx at all. scx, as with any other struct_ops
> implementation, could and does just implement these callbacks. As
> Kui-Feng said in [0], this is really just about enabling a sane default
> to improve usability. If a struct_ops implementation actually should
> have implemented some validation but neglected to, that would be a bug
> in exactly the same manner as if it had implemented .validate(), but
> neglected to check some corner case that makes the map invalid.
> 
> [0]: https://lore.kernel.org/lkml/887699ea-f837-6ed7-50bd-48720cea581c@gmail.com/
> 
>> there is no turning back.
> 
> Hmm, why there would be no turning back from this? This isn't a UAPI
> concern, is it? Whether or not a struct_ops implementation needs to
> implement .validate() or can just rely on the default behavior of "no
> .validate() callback implies the map is valid" is 100% an implementation
> detail that's hidden from the end user. This is meant to be a UX
> improvement for a developr defining a struct bpf_struct_ops instance in
> the main kernel, not someone defining an instance of that struct_ops
> (e.g. struct tcp_congestion_ops) in a BPF prog.
> 

