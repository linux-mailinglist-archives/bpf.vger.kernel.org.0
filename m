Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA04C568970
	for <lists+bpf@lfdr.de>; Wed,  6 Jul 2022 15:30:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233737AbiGFN3N (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 6 Jul 2022 09:29:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233665AbiGFN3M (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 6 Jul 2022 09:29:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 03FF71ADB4
        for <bpf@vger.kernel.org>; Wed,  6 Jul 2022 06:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657114150;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XYgzxfluOfIIjClWUU6GcJbauN/JHiH7jO9rrVTt3Po=;
        b=cLcmt7s04xsAzU95gH7Yrxn4gA42E2wrofGy6eySMNHdCLWCy9vRWLMT9X07T9R8nnZAZ1
        LlP77upyMriCUYLsifnY7Lq5WLgQqr22FbIqLUrIQrfJfO7pztdR7GKAivB9BezxTVRaCQ
        EaTOOfs/dgFovIqvpjEFUaISzcomceI=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-507-CWq0zJo4O6KXEmvpySxLoA-1; Wed, 06 Jul 2022 09:29:06 -0400
X-MC-Unique: CWq0zJo4O6KXEmvpySxLoA-1
Received: by mail-lj1-f197.google.com with SMTP id m16-20020a2e8710000000b0025d46f0cfb1so633570lji.16
        for <bpf@vger.kernel.org>; Wed, 06 Jul 2022 06:29:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:message-id:date:mime-version:user-agent:cc
         :subject:content-language:to:references:in-reply-to
         :content-transfer-encoding;
        bh=XYgzxfluOfIIjClWUU6GcJbauN/JHiH7jO9rrVTt3Po=;
        b=DUaLZ+31HxysXWc9jXzLGplNmTvW7u3zDoKLi5mzz3Qmp7s5maHn4LKy5u837frXXx
         FNj+vq1bYKy0RHCZznRJhxKXhNvni4Pq+pAMJ8dMKvLmJC24ZEfO2aY8D15E/eGsJBJf
         UNIQevt0H43i+QYDaZctg1ElmkOxFbxOjXUwafqtyeoYTiT6ssg02Dhk/SEuQ7mC5U61
         86VedbCj3q8jVVl++AgMyOfVz3w3Hbq7A27THH9FpDHECaPHtGSSM/aC1XR2gVpfNSSN
         IHLILNOWjQBUPO7gdKnmPT2H14n+SQCDGKgq76J2szywM3Dovaoh++O84biI+MCO+Fa5
         8jgg==
X-Gm-Message-State: AJIora+Gz+BgV15++fwEvxpQebHJoGq3cNqGEGb2TYyMZITUGnkSUSQR
        3FGO/OEgF0EJemWFsSs1+oNCPqAtZWR0How4sQhBmWlA4CIXr/c9AF53L665ZP+5b6ZWU4/NISW
        OkHyThW1ERGwj
X-Received: by 2002:ac2:4c52:0:b0:481:ce2:1802 with SMTP id o18-20020ac24c52000000b004810ce21802mr25984172lfk.586.1657114145267;
        Wed, 06 Jul 2022 06:29:05 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uJR12B+FxKgLoUGKMl/E+JKmbsDpjDHnPf8qNy7nyhWtSkNY4BJ97zeI8TEyYf3FoQ6ng/2Q==
X-Received: by 2002:ac2:4c52:0:b0:481:ce2:1802 with SMTP id o18-20020ac24c52000000b004810ce21802mr25984143lfk.586.1657114144928;
        Wed, 06 Jul 2022 06:29:04 -0700 (PDT)
Received: from [192.168.0.50] (87-59-106-155-cable.dk.customer.tdc.net. [87.59.106.155])
        by smtp.gmail.com with ESMTPSA id a26-20020ac25e7a000000b0047dd412c4dbsm6268640lfr.283.2022.07.06.06.29.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Jul 2022 06:29:04 -0700 (PDT)
From:   Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <db07b6af-af12-5913-4b9c-b768d7476e5b@redhat.com>
Date:   Wed, 6 Jul 2022 15:29:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Cc:     brouer@redhat.com, Toke Hoiland-Jorgensen <toke@redhat.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        "xdp-hints@xdp-project.net" <xdp-hints@xdp-project.net>,
        "Lobakin, Alexandr" <alexandr.lobakin@intel.com>,
        Netdev <netdev@vger.kernel.org>
Subject: Re: [PATCH RFC bpf-next 5/9] xdp: controlling XDP-hints from BPF-prog
 via helper
Content-Language: en-US
To:     Larysa Zaremba <larysa.zaremba@intel.com>,
        Jesper Dangaard Brouer <jbrouer@redhat.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
References: <DM4PR11MB54718267242004151337602F97BE9@DM4PR11MB5471.namprd11.prod.outlook.com>
 <b8085a4d-5ede-3cc0-a177-ad97fe08ce25@redhat.com> <YsRvzu4/cTmz8xmm@lincoln>
In-Reply-To: <YsRvzu4/cTmz8xmm@lincoln>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 05/07/2022 19.07, Larysa Zaremba wrote:
> On Mon, Jul 04, 2022 at 08:26:15PM +0200, Jesper Dangaard Brouer wrote:
>>
>>
>> On 04/07/2022 13.00, Zaremba, Larysa wrote:
>>> Toke Høiland-Jørgensen <toke@redhat.com> writes:
>>>>
>>>> Jesper Dangaard Brouer <jbrouer@redhat.com> writes:
>>>>
>>>>> On 29/06/2022 16.20, Toke Høiland-Jørgensen wrote:
>>>>>> Jesper Dangaard Brouer <brouer@redhat.com> writes:
>>>>>>
>>>>>>> XDP BPF-prog's need a way to interact with the XDP-hints. This
>>>>>>> patch introduces a BPF-helper function, that allow XDP BPF-prog's
>>>>>>> to interact with the XDP-hints.
>>>>>>>
>>>>>>> BPF-prog can query if any XDP-hints have been setup and if this is
>>>>>>> compatible with the xdp_hints_common struct. If XDP-hints are
>>>>>>> available the BPF "origin" is returned (see enum
>>>>>>> xdp_hints_btf_origin) as BTF can come from different sources or
>>>>>>> origins e.g. vmlinux, module or local.
>>>>>>
>>>>>> I'm not sure I quite understand what this origin is supposed to be
>>>>>> good for?
>>>>>
>>>>> Some background info on BTF is needed here: BTF_ID numbers are not
>>>>> globally unique identifiers, thus we need to know where it originate
>>>>> from, to make it unique (as we store this BTF_ID in XDP-hints).
>>>>>
>>>>> There is a connection between origin "vmlinux" and "module", which
>>>>> is that vmlinux will start at ID=1 and end at a max ID number.
>>>>> Modules refer to ID's in "vmlinux", and for this to work, they will
>>>>> shift their own numbering to start after ID=max-vmlinux-id.
>>>>>
>>>>> Origin "local" is for BTF information stored in the BPF-ELF object file.
>>>>> Their numbering starts at ID=1.  The use-case is that a BPF-prog
>>>>> want to extend the kernel drivers BTF-layout, and e.g. add a
>>>>> RX-timestamp like [1].  Then BPF-prog can check if it knows module's
>>>>> BTF_ID and then extend via bpf_xdp_adjust_meta, and update BTF_ID in
>>>>> XDP-hints and call the helper (I introduced) marking this as origin
>>>>> "local" for kernel to know this is no-longer origin "module".
>>>>
>>>> Right, I realise that :)
>>>>
>>>> My point was that just knowing "this is a BTF ID coming from a module"
>>>> is not terribly useful; you could already figure that out by just
>>>> looking at the ID and seeing if it's larger than the maximum ID in vmlinux BTF.
>>>>
>>>> Rather, what we need is a way to identify *which* module the BTF ID
>>>> comes from; and luckily, the kernel assigns a unique ID to every BTF
>>>> *object* as well as to each type ID within that object. These can be
>>>> dumped by bpftool:
>>>>
>>>> # bpftool btf
>>>> bpftool btf
>>>> [sudo] password for alrua:
>>>> 1: name [vmlinux]  size 4800187B
>>>> 2: name [serio]  size 2588B
>>>> 3: name [i8042]  size 11786B
>>>> 4: name [rng_core]  size 8184B
>>>> [...]
>>>> 2062: name <anon>  size 36965B
>>>> 	pids bpftool(547298)
>>>>
>>>> IDs 2-4 are module BTF objects, and that last one is the ID of a BTF
>>>> object loaded along with a BPF program by bpftool itself... So we *do*
>>>> in fact have a unique ID, by combining the BTF object ID with the type
>>>> ID; this is what Alexander is proposing to put into the xdp-hints
>>>> struct as well (combining the two IDs into a single u64).
>>
>> Thanks for the explanation. I think I understand it now, and I agree
>> that we should extend/combining the two IDs into a single u64.
>>
>> To Andrii, what is the right terminology when talking about these two
>> different BTF-ID's:
>>
>> - BTF object ID and BTF type ID?
>>
>> - Where BTF *object* ID are the IDs we see above from 'bpftool btf',
>>    where vmlinux=1 and module's IDs will start after 1.
>>
>> - Where BTF *type* ID are the IDs the individual data "types" within a
>>    BTF "object" (e.g. struct xdp_hints_common that BPF-prog's can get
>>    via calling bpf_core_type_id_kernel()).
>>
> 
> AFAIK, that's the most correct way of distinguish one from another in
> conversation.

Good to get confirmed that you agree with these terms.

> 
> Would be still great, if Andrii could confirm that.

Yes, it would :-)

> I should mention that out patch makes bpf_core_type_id_kernel() return
> u64 (BTF obj ID + BTF type ID), but your statement is true for current
> libbpf version.

It sounds useful that your patched bpf_core_type_id_kernel() returns u64
(BTF obj ID + BTF type ID).

I wonder if/how we need to deal with libbpf versions that only returns
the u32 BTF type ID ?

> 
>>
>>> That's correct, concept was previously discussed [1]. The ID of BTF object wasn't
>>> exposed in CO-RE allocations though, we've changed it in the first 4 patches.
>>> The main logic is in "libbpf: factor out BTF loading from load_module_btfs()"
>>> and "libbpf: patch module BTF ID into BPF insns".
>>>
>>> We have a sample that wasn't included eventually, but can possibly
>>> give a general understanding of our approach [2].
>>>
>>> [1] https://lore.kernel.org/all/CAEf4BzZO=7MKWfx2OCwEc+sKkfPZYzaELuobi4q5p1bOKk4AQQ@mail.gmail.com/
>>> [2] https://github.com/alobakin/linux/pull/16/files#diff-c5983904cbe0c280453d59e8a1eefb56c67018c38d5da0c1122abc86225fc7c9
>>>
>> (appreciate the links)
>>
>> I wonder how these BTF object IDs gets resolved for my "local" category?
>> (Origin "local" is for BTF information stored in the BPF-ELF object file)
>>
>> Note: For "local" BTF type IDs BPF-prog resolve these via
>> bpf_core_type_id_local() (why I choose the term "local").
>>
> 
> Every program during CO-RE relocs sees a single local BTF obj, in which
> BTF type IDs start from 1 and correspond to all data types used in
> program. So local BTF obj and type IDs inside are valid only in single
> program, therefore u32 type ID returned by bpf_core_type_id_local() is
> enough.

Sure it makes sense if only a single XDP-prog is running.

For the use-case of multiple XDP-progs (e.g. via libxdp) are running,
where they send info to each-other via metadata area. There it would be
valuable to get a BTF *object* ID associated with these "local" types.

Note that I believe that a TC ingress BPF-prog can also read the
metadata area.

> Local IDs are not resolved, they are just assigned during compilation.
> After program load with CO-RE each local type gets a resolved
> vmlinux/module BTF obj pointer and an ID of a type inside this BTF obj
> that is similar enough.

Yes, but only if __attribute__((preserve_access_index)) is defined on
the "local" BPF-prog struct will libbpf do this matching to kernel
structs, see[1].

  [1] 
https://github.com/xdp-project/bpf-examples/blob/18908873a7f48483ed8bab2d949e8760cff30810/AF_XDP-interaction/af_xdp_kern.c#L37-L40
  [2] 
https://github.com/xdp-project/bpf-examples/tree/master/AF_XDP-interaction


> 
> Both local and target type IDs are mainly needed just for comfortable
> iteration inside libbpf, so they are just a side product that is only
> patched in, if we use bpf_core_type_id_local/target() inside a program
> for testing purposes.

In my use-case[2] I want to extract the "local" BTF ID and update the
BTF ID in metadata area, such that my AF_XDP program can see it.

The use-case is that I have a BPF-prog that want to extend the
kernel-module provided XDP-hints, with an XDP-software RX timestamp, but
only for packets containing HW timestamps. It will (load/setup time)
know BTF obj+type ID via
bpf_core_type_id_kernel(xdp_hints_i40e_timestamp) to match on, and then
extend metadata area, type-cast to "local" struct and record
bpf_ktime_get_ns().  It now need to update BTF ID in XDP-hints metadata
area, to tell AF_XDP userspace prog (or chained XDP/TC BPF-prog) that
layout format have changed.

- My question is: What BTF *object* ID should I use for my "local" u32
BTF type ID ? (returned by bpf_core_type_id_local())

--Jesper

>>
>> p.s. For unknown reasons lore.kernel.org did match Larysa's reply with the
>> patchset thread here[3].
>>
>>   [3] https://lore.kernel.org/bpf/165643378969.449467.13237011812569188299.stgit@firesoul/#r

