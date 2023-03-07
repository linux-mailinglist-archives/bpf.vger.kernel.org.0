Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF4EA6AF606
	for <lists+bpf@lfdr.de>; Tue,  7 Mar 2023 20:44:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230221AbjCGTol (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 Mar 2023 14:44:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231319AbjCGToU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 7 Mar 2023 14:44:20 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D7693525C
        for <bpf@vger.kernel.org>; Tue,  7 Mar 2023 11:32:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678217534;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AIuniFfEXi61jmMfGHDfmaGpyYk61RiVautVdGF/TR4=;
        b=EURzxzC3c1BAP8kFlzKqlJ3WriwTg/TXsTa/hL89OA2NgHSQEOcX4KrvyQM7CWm9jBqNga
        dagWR/0iyIQJRNxpU6lKQpZi67mJ4r9oNIt5KAlD8HOQ9UaSo7JtjGmZUo8sIxC+LNnuyd
        VOHj+ec6CyVs5ROpTadwOUeHn6BmQag=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-367-zI9pwdJ8N76lsTmnC_7HzA-1; Tue, 07 Mar 2023 14:32:12 -0500
X-MC-Unique: zI9pwdJ8N76lsTmnC_7HzA-1
Received: by mail-ed1-f72.google.com with SMTP id w7-20020a056402268700b004bbcdf3751bso20219418edd.1
        for <bpf@vger.kernel.org>; Tue, 07 Mar 2023 11:32:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678217531;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:cc:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AIuniFfEXi61jmMfGHDfmaGpyYk61RiVautVdGF/TR4=;
        b=ijVDQZipCd7JeOf9uYIOpHdNPlffLc2OJ3yVAjBOFVGDzi8pC1Tn6s45vtR0B91Lla
         z9Nd+Nbj4x8inBYyjWm1aUrdgNLnfzcMoOqAB0zrZDGAGodGkWXHWmVlrpDXfX6MC4CN
         XmT/hGmck0qQC5DE+MmnGOA8Db37/L/aOa/7t8T5abm+trsV6bJDxCmguHCHHnV//M/g
         iffy+NfhAKCtQgjJEtJjsiGHx9TptBLWL4ICogMzoDLmtGxPyOUoU57BtOAWN8O4X2nX
         yVbf9iO9Dyngfo4ISmQTbWX6hO83o0SfsHgppuvJylO4zuDKwpfdz3Y10ZTaiNiJoH3e
         5Q6Q==
X-Gm-Message-State: AO0yUKUrLByv09ZsfaUpl1qfBcqjwxiYLOD6RiDS9nQjmXKhDVla9tsb
        qU/UACePHSZuqWmebVrOcUe1TvOzLw9yUpV8F6tkF5rgYWPjhcPdh8YZMkOE5eRdMX/FFxj72ui
        4muL6kAogoS9GreLz+4SW
X-Received: by 2002:a17:906:7c4a:b0:8b2:abcc:8d9e with SMTP id g10-20020a1709067c4a00b008b2abcc8d9emr15284192ejp.26.1678217530913;
        Tue, 07 Mar 2023 11:32:10 -0800 (PST)
X-Google-Smtp-Source: AK7set9dPfo2qJVTTxxYUvZrsQNn2ml+kuqlUiduVx85VS0PNgUMBG+NiXqcbqi7NA4mG32jsyjYbw==
X-Received: by 2002:a17:906:7c4a:b0:8b2:abcc:8d9e with SMTP id g10-20020a1709067c4a00b008b2abcc8d9emr15284173ejp.26.1678217530576;
        Tue, 07 Mar 2023 11:32:10 -0800 (PST)
Received: from [192.168.42.100] (nat-cgn9-185-107-15-52.static.kviknet.net. [185.107.15.52])
        by smtp.gmail.com with ESMTPSA id qw15-20020a170906fcaf00b008d57e796dcbsm6458977ejb.25.2023.03.07.11.32.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Mar 2023 11:32:09 -0800 (PST)
From:   Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <b09048d9-217e-ca3f-3d17-e82c146cd2df@redhat.com>
Date:   Tue, 7 Mar 2023 20:32:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Cc:     brouer@redhat.com,
        =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@kernel.org>,
        lsf-pc@lists.linux-foundation.org, bpf@vger.kernel.org,
        "xdp-hints@xdp-project.net" <xdp-hints@xdp-project.net>
Subject: Re: [LSF/MM/BPF TOPIC] XDP metadata for TX
Content-Language: en-US
To:     Magnus Karlsson <magnus.karlsson@gmail.com>,
        Stanislav Fomichev <sdf@google.com>
References: <Y/fnZkXQdc8lkP7q@google.com> <874jrcklvf.fsf@toke.dk>
 <CAKH8qBsoTiVja8=EXTcfJNYpF7JjgPoD=Wi4JBX5PGbggn=S4g@mail.gmail.com>
 <878rgjjipq.fsf@toke.dk>
 <CAKH8qBstQb0CS1Q-dcx_jeZM2sKSMH3PHFww6=6Hy+3wJ-NL+Q@mail.gmail.com>
 <CAJ8uoz0jnavFxMJ8tgb4+-+OsCPqVJQez8ULOTM2a60D4RmJ7A@mail.gmail.com>
In-Reply-To: <CAJ8uoz0jnavFxMJ8tgb4+-+OsCPqVJQez8ULOTM2a60D4RmJ7A@mail.gmail.com>
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


On 03/03/2023 08.42, Magnus Karlsson wrote:
> On Mon, 27 Feb 2023 at 21:16, Stanislav Fomichev <sdf@google.com> wrote:
>> On Mon, Feb 27, 2023 at 6:17 AM Toke Høiland-Jørgensen <toke@kernel.org> wrote:
>>> Stanislav Fomichev <sdf@google.com> writes:
>>>> On Thu, Feb 23, 2023 at 3:22 PM Toke Høiland-Jørgensen <toke@kernel.org> wrote:
>>>>>
>>>>> Stanislav Fomichev <sdf@google.com> writes:
>>>>>
>>>>>> I'd like to discuss a potential follow up for the previous "XDP RX
>>>>>> metadata" series [0].
>>>>>>
>>>>>> Now that we can access (a subset of) packet metadata at RX, I'd like to
>>>>>> explore the options where we can export some of that metadata on TX. And
>>>>>> also whether it might be possible to access some of the TX completion
>>>>>> metadata (things like TX timestamp).
>>>>>>

IMHO it makes sense to see TX metadata as two separate operations.

  (1) Metadata written into the TX descriptor.
  (2) Metadata read when processing TX completion.

These operations happen at two different points in time. Thus likely
need different BPF hooks.   Having BPF-progs running at each of these
points in time, will allow us to e.g. implement BQL (which is relevant
to XDP queuing effort).


>>>>>> I'm currently trying to understand whether the same approach I've used
>>>>>> on RX could work at TX. By May I plan to have a bunch of options laid
>>>>>> out (currently considering XSK tx/compl programs and XDP tx/compl
>>>>>> programs) so we have something to discuss.
>>>>>
>>>>> I've been looking at ways of getting a TX-completion hook for the XDP
>>>>> queueing stuff as well. For that, I think it could work to just hook
>>>>> into xdp_return_frame(), but if you want to access hardware metadata
>>>>> it'll obviously have to be in the driver. A hook in the driver could
>>>>> certainly be used for the queueing return as well, though, which may
>>>>> help making it worth the trouble :)
>>>>
>>>> Yeah, I'd like to get to completion descriptors ideally; so nothing
>>>> better than a driver hook comes to mind so far :-(

As Toke mentions, I'm also hoping we could leverage or extend the
xdp_return_frame() call.  Or implicitly add the "hook" at the existing
xdp_return_frame() call. This is about operation (2) *reading* some
metadata at TX completion time.
Can this be mapped to the RX-kfuncs approach(?), by driver extending
(call/structs) with pointer to TX-desc + adaptor info and BPF-prog/hook
doing TX-kfuncs calls into driver (that knows how to extract completion
data).


[...]
>>> Well, to me XDP_REDIRECT is the most interesting one (see above). I
>>> think we could even drop the XDP_TX case and only do this for
>>> XDP_REDIRECT, since XDP_TX is basically a special-case optimisation.
>>> I.e., it's possible to XDP_REDIRECT back to the same device, the frames
>>> will just take a slight detour up through the stack; but that could also
>>> be a good thing if it means we'll have to do less surgery to the drivers
>>> to implement this for two paths.
>>>
>>> It does have the same challenge as you outlined above, though: At that
>>> point the TX descriptor probably doesn't exist, so the driver NDO will
>>> have to do something else with the data; but maybe we can solve that
>>> without moving the hook into the driver itself somehow?
>>
>> Ah, ok, yeah, I was putting XDP_TX / XDP_REDIRECT under the same
>> "transmit something out of xdp_rx hook" umbrella. We can maybe come up
>> with a skb-like-private metadata layout (as we've discussed previously
>> for skb) here as well? But not sure it would solve all the problems?

This is operation (1) writing metadata into the TX descriptor.
In this case we have a metadata mapping problem, from RX on one device
driver to TX on another device driver. As you say, we also need to map
this SKBs, which have a fairly static set of metadata.

For the most common metadata offloads (like TX-checksum, TX-vlan) I
think it makes sense to store those in xdp_frame area (use for SKB
mapping) and re-use these when at TX writing into the TX descriptor.

BUT there are also metadata TX offloads offloads, like asking for a
specific Launch-Time for at packet, that needs a more flexible approach.


>> I'm thinking of an af_xdp case where it wants to program something
>> similar to tso/encap/tunneling offload (assuming af_xdp will get 4k+
>> support) or a checksum offload. Exposing access to the driver tx hooks
>> seems like the easiest way to get there?
>>
>>>> - AF_XDP TX - this one needs something deep in the driver (due to tx
>>>> zc) to populate the descriptors?
>>>
>>> Yeah, this one is a bit more challenging, but having a way to process
>>> AF_XDP frames in the kernel before they're sent out would be good in any
>>> case (for things like policing what packets an AF_XDP application can
>>> send in a cloud deployment, for instance). Would be best if we could
>>> consolidate the XDP_REDIRECT and AF_XDP paths, I suppose...
>>>

I agree, it would be best if we can consolidate the XDP_REDIRECT and
AF_XDP paths, else we have to re-implement the same for AF_XDP xmit path
(and maintain both paths). I also agree that being able to police what
packets an AF_XDP application can send is a useful feature (e.g. cloud
deployments).

Looking forward to collaborate on this work!
--Jesper

