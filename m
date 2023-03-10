Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 359E76B3D4E
	for <lists+bpf@lfdr.de>; Fri, 10 Mar 2023 12:10:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbjCJLKb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Mar 2023 06:10:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjCJLK2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 10 Mar 2023 06:10:28 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07AC4F1843
        for <bpf@vger.kernel.org>; Fri, 10 Mar 2023 03:09:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678446581;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DhY8swEzic3BRDeOn962HpEZAqi31b2QHSaYbuhFPi4=;
        b=iHCF4kdNDr17oPPtYcRHzmB8Ka40qdGfDkDDkpOMEPpSKg1snIQQ+F4qynJcE55bbJL2Em
        1DOAGPL6ZAWO5X57w2/q9/Ob3qbrGWN/kloeyJaLu3WwZUT9iytrw4XEQxsJn+n8URMOjp
        L+oe3WR3diQn8VUX9OdAb1hvjklZvT4=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-d2OS3mmFOP6zL4t1jr-JxQ-1; Fri, 10 Mar 2023 06:09:37 -0500
X-MC-Unique: d2OS3mmFOP6zL4t1jr-JxQ-1
Received: by mail-ed1-f72.google.com with SMTP id v11-20020a056402348b00b004ce34232666so7212604edc.3
        for <bpf@vger.kernel.org>; Fri, 10 Mar 2023 03:09:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678446576;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:cc:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DhY8swEzic3BRDeOn962HpEZAqi31b2QHSaYbuhFPi4=;
        b=PH0ION0hEOzSCMLTmLETIVlP2/ZkspJraH1CUDLTIZuvc9Pwce8o0o8h1zslqhrc6J
         FCyac0QZohhIniTYAUPnu3RYc0HUYJEG25Yp/XzIDuFudunHgPYn/HFAU7Um2hJW0crt
         pVmykenTcfQVioPHvr4qUvX3s2q5324kMxikpHLIQV8oRVmkdSssVbJ2vtC94T7Uc5zb
         BhsDJM6b8E6nz5IuDfWNnAti5alBiCnFEKQikIEfyyG/YVxVj326ztyIWYlqKlKqRaFz
         SojefOzEXiwSx9MRHJteeKecpkyX1+CxrMHgSWO+Dfa9kwd4dMqO/eAaEGS9E8b0/su1
         +2fQ==
X-Gm-Message-State: AO0yUKX+9jNV2B88OmqZwIfZPx1j2P4bZ7R/Bi3v/HiaU2la4eGRM37y
        WnPAlLASQK9Q9YJCBr1/WSbUzAHDje1q/gT9oaTdZbQ7dxMIoa47DY6pzrhBNBWxuPfbA64z1Pi
        +NGHzryDQNgT1
X-Received: by 2002:a17:907:8b98:b0:8b1:76dd:f5f6 with SMTP id tb24-20020a1709078b9800b008b176ddf5f6mr32247171ejc.50.1678446576711;
        Fri, 10 Mar 2023 03:09:36 -0800 (PST)
X-Google-Smtp-Source: AK7set/IyvTr/Bz1Ili6wk+haaqEFH3ago1D6Su/6s/njVzf8eMW5dU9LSJc0q3rNiYMu1f8SAd0kw==
X-Received: by 2002:a17:907:8b98:b0:8b1:76dd:f5f6 with SMTP id tb24-20020a1709078b9800b008b176ddf5f6mr32247147ejc.50.1678446576360;
        Fri, 10 Mar 2023 03:09:36 -0800 (PST)
Received: from [192.168.42.100] (nat-cgn9-185-107-15-52.static.kviknet.net. [185.107.15.52])
        by smtp.gmail.com with ESMTPSA id qp17-20020a170907207100b008df7d2e122dsm830136ejb.45.2023.03.10.03.09.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Mar 2023 03:09:35 -0800 (PST)
From:   Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <3c70e01d-f685-e341-64f8-8eb4e8bd46fc@redhat.com>
Date:   Fri, 10 Mar 2023 12:09:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Cc:     brouer@redhat.com, Magnus Karlsson <magnus.karlsson@gmail.com>,
        =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@kernel.org>,
        lsf-pc@lists.linux-foundation.org, bpf@vger.kernel.org,
        "xdp-hints@xdp-project.net" <xdp-hints@xdp-project.net>
Subject: Re: [LSF/MM/BPF TOPIC] XDP metadata for TX
Content-Language: en-US
To:     Stanislav Fomichev <sdf@google.com>,
        Jesper Dangaard Brouer <jbrouer@redhat.com>
References: <Y/fnZkXQdc8lkP7q@google.com> <874jrcklvf.fsf@toke.dk>
 <CAKH8qBsoTiVja8=EXTcfJNYpF7JjgPoD=Wi4JBX5PGbggn=S4g@mail.gmail.com>
 <878rgjjipq.fsf@toke.dk>
 <CAKH8qBstQb0CS1Q-dcx_jeZM2sKSMH3PHFww6=6Hy+3wJ-NL+Q@mail.gmail.com>
 <CAJ8uoz0jnavFxMJ8tgb4+-+OsCPqVJQez8ULOTM2a60D4RmJ7A@mail.gmail.com>
 <b09048d9-217e-ca3f-3d17-e82c146cd2df@redhat.com>
 <CAKH8qBuviabUfBTFg3gOfpkWc+oFvFP-NcV4g2ipn7D=C2u_2g@mail.gmail.com>
In-Reply-To: <CAKH8qBuviabUfBTFg3gOfpkWc+oFvFP-NcV4g2ipn7D=C2u_2g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 09/03/2023 19.04, Stanislav Fomichev wrote:
> On Tue, Mar 7, 2023 at 11:32 AM Jesper Dangaard Brouer
>>
>> On 03/03/2023 08.42, Magnus Karlsson wrote:
>>> On Mon, 27 Feb 2023 at 21:16, Stanislav Fomichev <sdf@google.com> wrote:
>>>> On Mon, Feb 27, 2023 at 6:17 AM Toke Høiland-Jørgensen <toke@kernel.org> wrote:
>>>>> Stanislav Fomichev <sdf@google.com> writes:
>>>>>> On Thu, Feb 23, 2023 at 3:22 PM Toke Høiland-Jørgensen <toke@kernel.org> wrote:
>>>>>>>
>>>>>>> Stanislav Fomichev <sdf@google.com> writes:
>>>>>>>
>>>>>>>> I'd like to discuss a potential follow up for the previous "XDP RX
>>>>>>>> metadata" series [0].
>>>>>>>>
>>>>>>>> Now that we can access (a subset of) packet metadata at RX, I'd like to
>>>>>>>> explore the options where we can export some of that metadata on TX. And
>>>>>>>> also whether it might be possible to access some of the TX completion
>>>>>>>> metadata (things like TX timestamp).
>>>>>>>>
>>
>> IMHO it makes sense to see TX metadata as two separate operations.
>>
>>    (1) Metadata written into the TX descriptor.
>>    (2) Metadata read when processing TX completion.
>>
>> These operations happen at two different points in time. Thus likely
>> need different BPF hooks.   Having BPF-progs running at each of these
>> points in time, will allow us to e.g. implement BQL (which is relevant
>> to XDP queuing effort).
> 
> I guess for (2) the question here is: is it worth having a separate
> hook? Or will a simple traceepoint as Toke suggested be enough? For
> BQL purposes, we can still attach a prog to that tracepoint, right?
> 

Yes, see below, I'm hoping for (2) we can avoid separate hook, and
leverage xdp_return_frame() somehow.

For (1) "write into the TX descriptor" it happens so late it the TX
path, that I don't think we can avoid a driver TX hook.  Even if we come
up with a common struct that drivers can consume hints from, we will
still need to modify the drivers to do the translation into the hardware
specific TX desc format.  If we have to modify the drivers anyhow, then
adding a TX BPF-hook would likely be worthwhile to the flexibility this
creates.


>>>>>>>> I'm currently trying to understand whether the same approach I've used
>>>>>>>> on RX could work at TX. By May I plan to have a bunch of options laid
>>>>>>>> out (currently considering XSK tx/compl programs and XDP tx/compl
>>>>>>>> programs) so we have something to discuss.
>>>>>>>
>>>>>>> I've been looking at ways of getting a TX-completion hook for the XDP
>>>>>>> queueing stuff as well. For that, I think it could work to just hook
>>>>>>> into xdp_return_frame(), but if you want to access hardware metadata
>>>>>>> it'll obviously have to be in the driver. A hook in the driver could
>>>>>>> certainly be used for the queueing return as well, though, which may
>>>>>>> help making it worth the trouble :)
>>>>>>
>>>>>> Yeah, I'd like to get to completion descriptors ideally; so nothing
>>>>>> better than a driver hook comes to mind so far :-(
>>
>> As Toke mentions, I'm also hoping we could leverage or extend the
>> xdp_return_frame() call.  Or implicitly add the "hook" at the existing
>> xdp_return_frame() call. This is about operation (2) *reading* some
>> metadata at TX completion time.
> 
> Ack, noted, thx. Although, at least for mlx5e_free_xdpsq_desc, I don't
> see it being called for the af_xdp tx path. But maybe that's something
> we can amend in a couple of places (so xdp_return_frame would handle
> most xdp cases, and some new tbd func for af_xdp tx)?
> 

Looking at mlx5e_free_xdpsq_desc() it have switch handling the different 
frame types.  It wouldn't be much work to as you say to amend code and 
add e.g. a tracepoint/hook catching more frame types (both xdp and af_xdp).

>> Can this be mapped to the RX-kfuncs approach(?), by driver extending
>> (call/structs) with pointer to TX-desc + adaptor info and BPF-prog/hook
>> doing TX-kfuncs calls into driver (that knows how to extract completion
>> data).
> 
> Yeah, that seems like a natural thing to do here.

Great. I hope drivers will no have hidden or freed the TX completion
descriptor before our BPF-prog will get a chance to read this data.

>>
>> [...]
>>>>> Well, to me XDP_REDIRECT is the most interesting one (see above). I
>>>>> think we could even drop the XDP_TX case and only do this for
>>>>> XDP_REDIRECT, since XDP_TX is basically a special-case optimisation.
>>>>> I.e., it's possible to XDP_REDIRECT back to the same device, the frames
>>>>> will just take a slight detour up through the stack; but that could also
>>>>> be a good thing if it means we'll have to do less surgery to the drivers
>>>>> to implement this for two paths.
>>>>>
>>>>> It does have the same challenge as you outlined above, though: At that
>>>>> point the TX descriptor probably doesn't exist, so the driver NDO will
>>>>> have to do something else with the data; but maybe we can solve that
>>>>> without moving the hook into the driver itself somehow?
>>>>
>>>> Ah, ok, yeah, I was putting XDP_TX / XDP_REDIRECT under the same
>>>> "transmit something out of xdp_rx hook" umbrella. We can maybe come up
>>>> with a skb-like-private metadata layout (as we've discussed previously
>>>> for skb) here as well? But not sure it would solve all the problems?
>>
>> This is operation (1) writing metadata into the TX descriptor.
>> In this case we have a metadata mapping problem, from RX on one device
>> driver to TX on another device driver. As you say, we also need to map
>> this SKBs, which have a fairly static set of metadata.
>>
>> For the most common metadata offloads (like TX-checksum, TX-vlan) I
>> think it makes sense to store those in xdp_frame area (use for SKB
>> mapping) and re-use these when at TX writing into the TX descriptor.
> 
> [..]
> 
>> BUT there are also metadata TX offloads offloads, like asking for a
>> specific Launch-Time for at packet, that needs a more flexible approach.
> 
> Why can't these go into the same "common" xdp_frame area?
> 

For several reasons:

  1. The "common" area in xdp_frame will be size constrained.

  2. The Launch-Time for a packet is not something we *read* from the RX
     descriptor, thus having room to store it in common area seems
     strange.

  3. The Launch-Time for a packet is something we likely calculate on the
     fly based on "time queue" state at our TX-hook egress. See TC-BPF
     code example for FQ-pacing here[1].

  4. We likely need a XDP queueing layer (Toke's work) to handle the HW
     limitations of Launch-Time feature, as HW it limited how far in the
     future we can schedule data (for chips i210 and i225 see[2]).

[1] 
https://github.com/xdp-project/bpf-examples/blob/master/traffic-pacing-edt/edt_pacer_vlan.c

[2] 
https://github.com/xdp-project/xdp-project/blob/master/areas/tsn/code01_follow_qdisc_TSN_offload.org

>>>> I'm thinking of an af_xdp case where it wants to program something
>>>> similar to tso/encap/tunneling offload (assuming af_xdp will get 4k+
>>>> support) or a checksum offload. Exposing access to the driver tx hooks
>>>> seems like the easiest way to get there?
>>>>
>>>>>> - AF_XDP TX - this one needs something deep in the driver (due to tx
>>>>>> zc) to populate the descriptors?
>>>>>
>>>>> Yeah, this one is a bit more challenging, but having a way to process
>>>>> AF_XDP frames in the kernel before they're sent out would be good in any
>>>>> case (for things like policing what packets an AF_XDP application can
>>>>> send in a cloud deployment, for instance). Would be best if we could
>>>>> consolidate the XDP_REDIRECT and AF_XDP paths, I suppose...
>>>>>
>>
>> I agree, it would be best if we can consolidate the XDP_REDIRECT and
>> AF_XDP paths, else we have to re-implement the same for AF_XDP xmit path
>> (and maintain both paths). I also agree that being able to police what
>> packets an AF_XDP application can send is a useful feature (e.g. cloud
>> deployments).
>>
>> Looking forward to collaborate on this work!
>> --Jesper
> 
> Thank you for the comments! So it looks like two things we potentially
> need to do/agree upon:
>
> 1. User-facing API. One hook + tracepoint vs two hooks (and at what
> level: af_xdp vs xdp). I'll try to focus on that first (waiting for
> af_xdp patches that Magnus mentioned).
>

Yes, I think we need to dig into the code and to figure out what options 
are doable.  Balancing the future maintenance cost.

> 2. Potentially internal refactoring to consolidate XDP_REDIRECT+AF_XDP
> (seems like something we should be able to discuss as we go; aka
> implementation details)
> 

Sounds like we have a plan going forward :-)

--Jesper

