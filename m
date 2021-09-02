Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7F693FEB19
	for <lists+bpf@lfdr.de>; Thu,  2 Sep 2021 11:20:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245025AbhIBJSu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Sep 2021 05:18:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59076 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233639AbhIBJSt (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 2 Sep 2021 05:18:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630574270;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UJLAt+CpcJOSUZymcPM/qmFuCf83mxr54RML4d20nn0=;
        b=CFGgsC4fKdgjjuFzxJ968jMaMU43n8toGkKC8tjzErUCyiutKZ47ofBg5FEI4GfwYE1lzH
        Van/Wg6hD+1ZVD/5m1CH4MTLkg+w/XWNterHPjLW5pAz6bgtzHVk9upL3KvRttEyQNys4j
        8X5zFqo9qYlZkE3UKZsspSRX+PYeq6U=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-429-lT44TEkBMLyGSJzyTk-UIg-1; Thu, 02 Sep 2021 05:17:47 -0400
X-MC-Unique: lT44TEkBMLyGSJzyTk-UIg-1
Received: by mail-ej1-f71.google.com with SMTP id q15-20020a17090622cf00b005c42d287e6aso598502eja.18
        for <bpf@vger.kernel.org>; Thu, 02 Sep 2021 02:17:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:cc:subject:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UJLAt+CpcJOSUZymcPM/qmFuCf83mxr54RML4d20nn0=;
        b=JFMrcBnd8Jkk5zUrn3XLZK6F2ZnylqFRDBUPKP2E1/ls/4LWfGyg7hIeA8MjKd6H0S
         x0dfgtLDAgIZsAS69Erc1eYrmNamoEZkCMySvDUialmNYjf2FtFCvozilPPOLZ0Do1gt
         WfzpH+48rRpqqTYpIyXfchPKs4q63ipgmUm72g9bfUUVFPTIQ+TBC7c56ZRVlqhqaIVQ
         AMcqpqrlclXeTrDKB+0Pu7jhZ7q9q0CSXNh6gjxLDP7ZHoTEjfCKmQXtsh7crjIdVuPW
         Du9oNkQcsXarM1OtTaNh58xeCnU3W9WsvrjVLEqhq62MwB9b5Yudb1hLexYhDzCilX/O
         LaBg==
X-Gm-Message-State: AOAM531PT18UyqlKd+siArxel5ikzy0IgThrhnd1ciEqAISl9hquKspO
        YmOaKqERFO93tIs2QWIiGsAKZHMDf1UVivDkoeiUt9kam0g+1W33IZlejHUFPCuRyRtBTgeWY13
        uP7GtdoSX+vY5
X-Received: by 2002:a05:6402:2691:: with SMTP id w17mr2470762edd.339.1630574266479;
        Thu, 02 Sep 2021 02:17:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxu9C8K9v/c+36bN25VCRjqBQ75YkjnpX6tgYqoJsADQcLF8U97wbjlgPO0XPuSE5xheu3oCw==
X-Received: by 2002:a05:6402:2691:: with SMTP id w17mr2470739edd.339.1630574266208;
        Thu, 02 Sep 2021 02:17:46 -0700 (PDT)
Received: from [192.168.42.238] (3-14-107-185.static.kviknet.dk. [185.107.14.3])
        by smtp.gmail.com with ESMTPSA id o3sm657991eju.123.2021.09.02.02.17.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Sep 2021 02:17:45 -0700 (PDT)
From:   Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Cc:     brouer@redhat.com, Jakub Kicinski <kuba@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        BPF-dev-list <bpf@vger.kernel.org>,
        Magnus Karlsson <magnus.karlsson@gmail.com>,
        William Tu <u9012063@gmail.com>, xdp-hints@xdp-project.net,
        Zaremba Larysa <larysa.zaremba@intel.com>,
        Jiri Olsa <jolsa@redhat.com>
Subject: Re: XDP-hints: Howto support multiple BTF types per packet basis?
To:     Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
        =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>
References: <60b12897d2e3f_1cf820896@john-XPS-13-9370.notmuch>
 <8735u3dv2l.fsf@toke.dk> <60b6cf5b6505e_38d6d208d8@john-XPS-13-9370.notmuch>
 <20210602091837.65ec197a@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
 <YNGU4GhL8fZ0ErzS@localhost.localdomain> <874kdqqfnm.fsf@toke.dk>
 <YNLxtsasQSv+YR1w@localhost.localdomain> <87mtrfmoyh.fsf@toke.dk>
 <YOa4JVEp20JolOp4@localhost.localdomain> <8735snvjp7.fsf@toke.dk>
 <YTA7x6BIq85UWrYZ@localhost.localdomain>
Message-ID: <190d8d21-f11d-bb83-58aa-08e86e0006d9@redhat.com>
Date:   Thu, 2 Sep 2021 11:17:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YTA7x6BIq85UWrYZ@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 02/09/2021 04.49, Michal Swiatkowski wrote:
> On Fri, Jul 09, 2021 at 12:57:08PM +0200, Toke Høiland-Jørgensen wrote:
>> Michal Swiatkowski <michal.swiatkowski@linux.intel.com> writes:
>>
>>>> I would expect that the program would decide ahead-of-time which BTF IDs
>>>> it supports, by something like including the relevant structs from
>>>> vmlinux.h. And then we need the BTF ID encoded into the packet metadata
>>>> as well, so that it is possible to check at run-time which driver the
>>>> packet came from (since a packet can be redirected, so you may end up
>>>> having to deal with multiple formats in the same XDP program).
>>>>
>>>> Which would allow you to write code like:
>>>>
>>>> if (ctx->has_driver_meta) {
>>>>    /* this should be at a well-known position, like first (or last) in meta area */
>>>>    __u32 *meta_btf_id = ctx->data_meta;
>>>>    
>>>>    if (*meta_btf_id == BTF_ID_MLX5) {
>>>>      struct meta_mlx5 *meta = ctx->data_meta;
>>>>      /* do something with meta */
>>>>    } else if (meta_btf_id == BTF_ID_I40E) {
>>>>      struct meta_i40e *meta = ctx->data_meta;
>>>>      /* do something with meta */
>>>>    } /* etc */
>>>> }
>>>>
>>>> and libbpf could do relocations based on the different meta structs,
>>>> even removing the code for the ones that don't exist on the running
>>>> kernel.
>>>
>>> This looks nice. In this case we need defintions of struct meta_mlx5 and
>>> struct meta_i40e at build time. How are we going to deliver this to bpf
>>> core app? This will be available in /sys/kernel/btf/mlx5 and
>>> /sys/kernel/btf/i40e (if drivers are loaded). Should we dump this to
>>> vmlinux.h? Or a developer of the xdp program should add this definition
>>> to his code?
>>
>> Well, if the driver just defines the struct, the BTF for it will be
>> automatically part of the driver module BTF. BPF program developers
>> would need to include this in their programs somehow (similar to how
>> you'll need to get the type definitions from vmlinux.h today to use
>> CO-RE); how they do this is up to them. Since this is a compile-time
>> thing it will probably depend on the project (for instance, BCC includes
>> a copy of vmlinux.h in their source tree, but you can also just pick out
>> the structs you need).
>>
>>> Maybe create another /sys/kernel/btf/hints with vmlinux and hints from
>>> all drivers which support hints?
>>
>> It may be useful to have a way for the kernel to export all the hints
>> currently loaded, so libbpf can just use that when relocating. The
>> problem of course being that this will only include drivers that are
>> actually loaded, so users need to make sure to load all their network
>> drivers before loading any XDP programs. I think it would be better if
>> the loader could discover all modules *available* on the system, but I'm
>> not sure if there's a good way to do that.
>>
>>> Previously in this thread someone mentioned this ___ use case in libbpf
>>> and proposed creating something like mega xdp hints structure with all
>>> available fields across all drivers. As I understand this could solve
>>> the problem about defining correct structure at build time. But how will
>>> it work when there will be more than one structures with the same name
>>> before ___? I mean:
>>> struct xdp_hints___mega defined only in core app
>>> struct xdp_hints___mlx5 available when mlx5 driver is loaded
>>> struct xdp_hints___i40e available when i40e driver is loaded
>>>
>>> When there will be only one driver loaded should libbpf do correct
>>> reallocation of fields? What will happen when both of the drivers are
>>> loaded?
>>
>> I think we definitely need to make this easy for developers so they
>> don't have to go and manually track down the driver structs and write
>> the disambiguation code etc. I.e., the example code I included above
>> that checks the frame BTF ID and does the loading based on it should be
>> auto-generated. We already have some precedence for auto-generated code
>> in vmlinux.h and the bpftool skeletons. So maybe we could have a command
>> like 'bpftool gen_xdp_meta <fields>' which would go and lookup all the
>> available driver structs and generate a code helper function that will
>> extract the driver structs and generate the loader code? So that if,
>> say, you're interested in rxhash and tstamp you could do:
>>
>> bpftool gen_xdp_meta rxhash tstamp > my_meta.h
>>
>> which would then produce my_meta.h with content like:
>>
>> struct my_meta { /* contains fields specified on the command line */
>>    u32 rxhash;
>>    u32 tstamp;
>> }
>>
>> struct meta_mlx5 {/*generated from kernel BTF */};
>> struct meta_i40e {/*generated from kernel BTF */};
>>
>> static inline int get_xdp_meta(struct xdp_md *ctx, struct my_meta *meta)
>> {
>>   if (ctx->has_driver_meta) {
>>     /* this should be at a well-known position, like first (or last) in meta area */
>>     __u32 *meta_btf_id = ctx->data_meta;
>>     
>>     if (*meta_btf_id == BTF_ID_MLX5) {
>>       struct meta_mlx5 *meta = ctx->data_meta;
>>       my_meta->rxhash = meta->rxhash;
>>       my_meta->tstamp = meta->tstamp;
>>       return 0;
>>     } else if (meta_btf_id == BTF_ID_I40E) {
>>       struct meta_i40e *meta = ctx->data_meta;
>>       my_meta->rxhash = meta->rxhash;
>>       my_meta->tstamp = meta->tstamp;
>>       return 0;
>>     } /* etc */
>>   }
>>   return -ENOENT;
>> }
> 
> According to meta_btf_id. 

In BPF-prog (that gets loaded by libbpf), the BTF_ID_MLX5 and 
BTF_ID_I40E should be replaced by bpf_core_type_id_kernel() calls.

I have a code example here[1], where I use the triple-underscore to 
lookup btf_id = bpf_core_type_id_kernel(struct sk_buff___local).

AFAIK (Andrii correctly me if I'm wrong) It is libbpf that does the 
bpf_id lookup before loading the BPF-prog into the kernel.

For AF_XDP we need to code our own similar lookup of the btf_id. (In 
that process I imagine that userspace tools could/would read the BTF 
member offsets and check it against what they expected).


  [1] 
https://github.com/xdp-project/bpf-examples/blob/master/ktrace-CO-RE/ktrace01_kern.c#L34-L57

> Do You have an idea how driver should fill this field?

(Andrii please correctly me as this is likely wrong:)
I imagine that driver will have a pointer to a 'struct btf' object and 
the btf_id can be read via btf_obj_id() (that just return btf->id).
As this also allows driver to take refcnt on the btf-object.
Much like Ederson did in [2].

Maybe I misunderstood the use of the 'struct btf' object ?

Maybe it is the wrong approach? As the patchset[2] exports btf_obj_id() 
and introduced helper functions that can register/unregister btf 
objects[3], which I sense might not be needed today, as modules can get 
their own BTF info automatically today.
Maybe this (btf->id) is not the ID we are looking for?

[2] 
https://lore.kernel.org/all/20210803010331.39453-11-ederson.desouza@intel.com/
[3] 
https://lore.kernel.org/all/20210803010331.39453-2-ederson.desouza@intel.com/

> hints->btf_id = btf_id_by_name("struct meta_i40e"); /* fill btf id at
> config time */

Yes, at config time the btf_id can change (and maybe we want to cache 
the btf_obj_id() lookup to avoid a function call).

> btf_id_by_name will get module btf (or vmlinux btf) and search for
> correct name for each ids. Does this look correct?
 >
> Is there any way in kernel to get btf id based on name or we have to
> write functions for this? I haven't seen code for this case, but maybe I
> missed it.

There is a function named: btf_find_by_name_kind()

--Jesper

