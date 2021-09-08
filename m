Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B311403A93
	for <lists+bpf@lfdr.de>; Wed,  8 Sep 2021 15:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349390AbhIHN3f (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Sep 2021 09:29:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:42296 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235294AbhIHN3e (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 8 Sep 2021 09:29:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631107706;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5+VIlgjhY3E7eDD9E9D8fJWbDOsIe3FwECfQXT25Vd0=;
        b=KKaQrwlTT0E4T6XRobYRdBFKXPjx4euxDCzU5Jq+cf2vEvI+3i8hAuoQdomfRzetMH/lwW
        lmIsAny71sA477E5t+sf2a+1pJ5LqzXzWl0wDYcN7ECLoVQetaZItzEGWW/YncPmGN4LSI
        bMt9pbI1XNUe6AgkrVcqTRGHadP4vKA=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-390-zDiAwtlOOhWp-IgIko8Www-1; Wed, 08 Sep 2021 09:28:25 -0400
X-MC-Unique: zDiAwtlOOhWp-IgIko8Www-1
Received: by mail-lj1-f198.google.com with SMTP id e10-20020a05651c04ca00b001c99c74e564so977681lji.11
        for <bpf@vger.kernel.org>; Wed, 08 Sep 2021 06:28:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:cc:subject:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5+VIlgjhY3E7eDD9E9D8fJWbDOsIe3FwECfQXT25Vd0=;
        b=SHSP6gI6L8Tcem50Wli4Gndm8k8lfzPjUgwyXpSxmLe8z6ooaimSId12YXunVcLl1u
         iNfx+ctWvLM42Hx9MbGaoJY2sWfAckCtVzqY2tLLMAWzchkugCnWvKne+BGhtUeFWQ0h
         Re5uE7UjTtea2la9SNUeYQitcQSnhe8Pw/gX3AtY3KO+JbdM/icWiHx0XT2wVrK3ogh2
         +dvWryMcJ2b3FHxTOLfGxDjQBjo4VdKsnqFYrtv0qprj5jXBAF+M2nEdE+2qNkkp5pKC
         hB0keq9JpByC58NEK8empL/UXH/mzpv+NMnRFlSoLcC2q9/FpBkrqaAFlP0bEHkiqmnM
         ygLQ==
X-Gm-Message-State: AOAM531ojBbS5VzWfuX+D7W/knS6VQlLBUkYMK3Rg82rt1whm4kxu3+O
        uj2IaOmWR5KtzfH5Zgx0KI0Om4b4xtOINrUOcU9seckSoGtRM/NLagUCRWUBPUcw5UMctOcqsSJ
        xFV/hBXvt/tpE
X-Received: by 2002:ac2:5dc8:: with SMTP id x8mr2654561lfq.31.1631107703825;
        Wed, 08 Sep 2021 06:28:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxescUHN6ctZpnLvgAbYXMnZlUccnRD99JUNbOSDvunE5Yx2rw80rDAHOTCMYDwJs2p7AtJ0A==
X-Received: by 2002:ac2:5dc8:: with SMTP id x8mr2654539lfq.31.1631107703464;
        Wed, 08 Sep 2021 06:28:23 -0700 (PDT)
Received: from [192.168.42.238] (87-59-106-155-cable.dk.customer.tdc.net. [87.59.106.155])
        by smtp.gmail.com with ESMTPSA id g5sm191702lfv.202.2021.09.08.06.28.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Sep 2021 06:28:22 -0700 (PDT)
From:   Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Cc:     brouer@redhat.com,
        =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        BPF-dev-list <bpf@vger.kernel.org>,
        Magnus Karlsson <magnus.karlsson@gmail.com>,
        William Tu <u9012063@gmail.com>, xdp-hints@xdp-project.net,
        Zaremba Larysa <larysa.zaremba@intel.com>,
        Jiri Olsa <jolsa@redhat.com>
Subject: Re: XDP-hints: Howto support multiple BTF types per packet basis?
To:     Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
        Jesper Dangaard Brouer <jbrouer@redhat.com>
References: <60b6cf5b6505e_38d6d208d8@john-XPS-13-9370.notmuch>
 <20210602091837.65ec197a@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
 <YNGU4GhL8fZ0ErzS@localhost.localdomain> <874kdqqfnm.fsf@toke.dk>
 <YNLxtsasQSv+YR1w@localhost.localdomain> <87mtrfmoyh.fsf@toke.dk>
 <YOa4JVEp20JolOp4@localhost.localdomain> <8735snvjp7.fsf@toke.dk>
 <YTA7x6BIq85UWrYZ@localhost.localdomain>
 <190d8d21-f11d-bb83-58aa-08e86e0006d9@redhat.com>
 <YTcGUbRpvWK+633g@localhost.localdomain>
Message-ID: <936bfbdf-e194-b676-d28a-acf526120155@redhat.com>
Date:   Wed, 8 Sep 2021 15:28:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YTcGUbRpvWK+633g@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


On 07/09/2021 08.27, Michal Swiatkowski wrote:
> On Thu, Sep 02, 2021 at 11:17:43AM +0200, Jesper Dangaard Brouer wrote:
>>
>>
>> On 02/09/2021 04.49, Michal Swiatkowski wrote:
>>> On Fri, Jul 09, 2021 at 12:57:08PM +0200, Toke Høiland-Jørgensen wrote:
>>>> Michal Swiatkowski <michal.swiatkowski@linux.intel.com> writes:
>>>>
>>>>>> I would expect that the program would decide ahead-of-time which BTF IDs
>>>>>> it supports, by something like including the relevant structs from
>>>>>> vmlinux.h. And then we need the BTF ID encoded into the packet metadata
>>>>>> as well, so that it is possible to check at run-time which driver the
>>>>>> packet came from (since a packet can be redirected, so you may end up
>>>>>> having to deal with multiple formats in the same XDP program).
>>>>>>
>>>>>> Which would allow you to write code like:
>>>>>>
>>>>>> if (ctx->has_driver_meta) {
>>>>>>     /* this should be at a well-known position, like first (or last) in meta area */
>>>>>>     __u32 *meta_btf_id = ctx->data_meta;
>>>>>>     if (*meta_btf_id == BTF_ID_MLX5) {
>>>>>>       struct meta_mlx5 *meta = ctx->data_meta;
>>>>>>       /* do something with meta */
>>>>>>     } else if (meta_btf_id == BTF_ID_I40E) {
>>>>>>       struct meta_i40e *meta = ctx->data_meta;
>>>>>>       /* do something with meta */
>>>>>>     } /* etc */
>>>>>> }
>>>>>>
>>>>>> and libbpf could do relocations based on the different meta structs,
>>>>>> even removing the code for the ones that don't exist on the running
>>>>>> kernel.
>>>>>
>>>>> This looks nice. In this case we need defintions of struct meta_mlx5 and
>>>>> struct meta_i40e at build time. How are we going to deliver this to bpf
>>>>> core app? This will be available in /sys/kernel/btf/mlx5 and
>>>>> /sys/kernel/btf/i40e (if drivers are loaded). Should we dump this to
>>>>> vmlinux.h? Or a developer of the xdp program should add this definition
>>>>> to his code?
>>>>
>>>> Well, if the driver just defines the struct, the BTF for it will be
>>>> automatically part of the driver module BTF. BPF program developers
>>>> would need to include this in their programs somehow (similar to how
>>>> you'll need to get the type definitions from vmlinux.h today to use
>>>> CO-RE); how they do this is up to them. Since this is a compile-time
>>>> thing it will probably depend on the project (for instance, BCC includes
>>>> a copy of vmlinux.h in their source tree, but you can also just pick out
>>>> the structs you need).
>>>>
>>>>> Maybe create another /sys/kernel/btf/hints with vmlinux and hints from
>>>>> all drivers which support hints?
>>>>
>>>> It may be useful to have a way for the kernel to export all the hints
>>>> currently loaded, so libbpf can just use that when relocating. The
>>>> problem of course being that this will only include drivers that are
>>>> actually loaded, so users need to make sure to load all their network
>>>> drivers before loading any XDP programs. I think it would be better if
>>>> the loader could discover all modules *available* on the system, but I'm
>>>> not sure if there's a good way to do that.
>>>>
>>>>> Previously in this thread someone mentioned this ___ use case in libbpf
>>>>> and proposed creating something like mega xdp hints structure with all
>>>>> available fields across all drivers. As I understand this could solve
>>>>> the problem about defining correct structure at build time. But how will
>>>>> it work when there will be more than one structures with the same name
>>>>> before ___? I mean:
>>>>> struct xdp_hints___mega defined only in core app
>>>>> struct xdp_hints___mlx5 available when mlx5 driver is loaded
>>>>> struct xdp_hints___i40e available when i40e driver is loaded
>>>>>
>>>>> When there will be only one driver loaded should libbpf do correct
>>>>> reallocation of fields? What will happen when both of the drivers are
>>>>> loaded?
>>>>
>>>> I think we definitely need to make this easy for developers so they
>>>> don't have to go and manually track down the driver structs and write
>>>> the disambiguation code etc. I.e., the example code I included above
>>>> that checks the frame BTF ID and does the loading based on it should be
>>>> auto-generated. We already have some precedence for auto-generated code
>>>> in vmlinux.h and the bpftool skeletons. So maybe we could have a command
>>>> like 'bpftool gen_xdp_meta <fields>' which would go and lookup all the
>>>> available driver structs and generate a code helper function that will
>>>> extract the driver structs and generate the loader code? So that if,
>>>> say, you're interested in rxhash and tstamp you could do:
>>>>
>>>> bpftool gen_xdp_meta rxhash tstamp > my_meta.h
>>>>
>>>> which would then produce my_meta.h with content like:
>>>>
>>>> struct my_meta { /* contains fields specified on the command line */
>>>>     u32 rxhash;
>>>>     u32 tstamp;
>>>> }
>>>>
>>>> struct meta_mlx5 {/*generated from kernel BTF */};
>>>> struct meta_i40e {/*generated from kernel BTF */};
>>>>
>>>> static inline int get_xdp_meta(struct xdp_md *ctx, struct my_meta *meta)
>>>> {
>>>>    if (ctx->has_driver_meta) {
>>>>      /* this should be at a well-known position, like first (or last) in meta area */
>>>>      __u32 *meta_btf_id = ctx->data_meta;
>>>>      if (*meta_btf_id == BTF_ID_MLX5) {
>>>>        struct meta_mlx5 *meta = ctx->data_meta;
>>>>        my_meta->rxhash = meta->rxhash;
>>>>        my_meta->tstamp = meta->tstamp;
>>>>        return 0;
>>>>      } else if (meta_btf_id == BTF_ID_I40E) {
>>>>        struct meta_i40e *meta = ctx->data_meta;
>>>>        my_meta->rxhash = meta->rxhash;
>>>>        my_meta->tstamp = meta->tstamp;
>>>>        return 0;
>>>>      } /* etc */
>>>>    }
>>>>    return -ENOENT;
>>>> }
>>>
>>> According to meta_btf_id.
>>
>> In BPF-prog (that gets loaded by libbpf), the BTF_ID_MLX5 and BTF_ID_I40E
>> should be replaced by bpf_core_type_id_kernel() calls.
>>
>> I have a code example here[1], where I use the triple-underscore to lookup
>> btf_id = bpf_core_type_id_kernel(struct sk_buff___local).
>>
>> AFAIK (Andrii correctly me if I'm wrong) It is libbpf that does the bpf_id
>> lookup before loading the BPF-prog into the kernel.
>>
>> For AF_XDP we need to code our own similar lookup of the btf_id. (In that
>> process I imagine that userspace tools could/would read the BTF member
>> offsets and check it against what they expected).
>>
>>
>>   [1] https://github.com/xdp-project/bpf-examples/blob/master/ktrace-CO-RE/ktrace01_kern.c#L34-L57
>>
> Thanks a lot. I tested Your CO-RE example. For defines that are located
> in vmlinux everything works fine (like for sk_buff). When I tried to get
> btf id of structures defined in module (loaded module, structure can be
> find in /sys/kerne/btf/module_name) I always get 0 (not found). Do You
> know if bpf_core_type_id_kernel() should also support modules btf?

This might be caused by git-submodule libbpf being too old in 
xdp-project/bpf-examples repo.  I will investigate closer.


I did notice my bpftool (on my devel box) were tool old, as bpftool 
could not dump info in /sys/kerne/btf/module_name

   # bpftool btf dump file /sys/kernel/btf/igc format raw
   Error: failed to load BTF from /sys/kernel/btf/igc: Unknown error -22

After updating bpftool it does work.

> Based on:
> [1] https://lore.kernel.org/bpf/20201110011932.3201430-5-andrii@kernel.org/
> I assume that modules btfs also are marked as in-kernel, but I can't
> make it works with bpf_core_type_id_kernel(). My clang version is
> 12.0.1, so changes needed by modules btf should be there
> [2] https://reviews.llvm.org/D91489
> 
>>> Do You have an idea how driver should fill this field?
>>
>> (Andrii please correctly me as this is likely wrong:)
>> I imagine that driver will have a pointer to a 'struct btf' object and the
>> btf_id can be read via btf_obj_id() (that just return btf->id).
>> As this also allows driver to take refcnt on the btf-object.
>> Much like Ederson did in [2].
>>
>> Maybe I misunderstood the use of the 'struct btf' object ?
>>
>> Maybe it is the wrong approach? As the patchset[2] exports btf_obj_id() and
>> introduced helper functions that can register/unregister btf objects[3],
>> which I sense might not be needed today, as modules can get their own BTF
>> info automatically today.
>> Maybe this (btf->id) is not the ID we are looking for?
>>
>> [2] https://lore.kernel.org/all/20210803010331.39453-11-ederson.desouza@intel.com/
>> [3]
>> https://lore.kernel.org/all/20210803010331.39453-2-ederson.desouza@intel.com/
>>
> 
> As 'struct btf' object do You mean one module btf with all definitions
> or specific structure btf object?
> 
> In case of Your example [1]. If in driver side there will be call to get
> btf id of sk_buff:
> id = btf_find_by_name_kind(vmlinux_btf, "sk_buff", BTF_KIND_STRUCT);
> this id will be the same as id from Your ktrace01 program. I think this
> is id that we are looking for.

Yes, I think this is the ID we should use.

The 'struct btf' object ID is something else I suspect? Or it is also a 
valid BTF ID?

I wanted to ask Andrii if the IDs are unique across vmlinux and modules?

I suspect as it looks like kern uses the IDR infra[0]:
  [0] https://www.kernel.org/doc/html/latest/core-api/idr.html


>>> hints->btf_id = btf_id_by_name("struct meta_i40e"); /* fill btf id at
>>> config time */
>>
>> Yes, at config time the btf_id can change (and maybe we want to cache the
>> btf_obj_id() lookup to avoid a function call).
>>
>>> btf_id_by_name will get module btf (or vmlinux btf) and search for
>>> correct name for each ids. Does this look correct?
>>>
>>> Is there any way in kernel to get btf id based on name or we have to
>>> write functions for this? I haven't seen code for this case, but maybe I
>>> missed it.
>>
>> There is a function named: btf_find_by_name_kind()
>>
> Thanks, this is what I needed.

