Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A1365B2181
	for <lists+bpf@lfdr.de>; Thu,  8 Sep 2022 17:04:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231874AbiIHPEx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 8 Sep 2022 11:04:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232798AbiIHPEt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 8 Sep 2022 11:04:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB91D1DA51
        for <bpf@vger.kernel.org>; Thu,  8 Sep 2022 08:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662649486;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mBJ6ROdPX0g4m7N1nAlcmBG0Oq4I/T9yWEpREjh3gHQ=;
        b=cn+56ZYN5OUNx32QQMZ37hYMTUdg6Dk5J4pWySP44rti7YsB8QjexsqM8Yy268bfC8+uIE
        aehA1aZSETi8zr+uUy0BrX0ABMkemzby+W46QhjylxmDGUladerW8QuDxSt1KrSiPP3DnL
        KVp8y4ez1D+13n2ae7u0Ary9IpvZNXs=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-331-80uL1AbMPLyGuvyHXuwpGg-1; Thu, 08 Sep 2022 11:04:45 -0400
X-MC-Unique: 80uL1AbMPLyGuvyHXuwpGg-1
Received: by mail-lj1-f199.google.com with SMTP id h21-20020a2e9ed5000000b0025d516572f4so5634553ljk.12
        for <bpf@vger.kernel.org>; Thu, 08 Sep 2022 08:04:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:cc:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date;
        bh=mBJ6ROdPX0g4m7N1nAlcmBG0Oq4I/T9yWEpREjh3gHQ=;
        b=EcFpPGhdv/0KDa7blQ47iFcbrtWKGzgagtQdZRh5slOjMYP3tDaK+UdWkgRzwnVfJm
         QH81cniupaAk/OzT9tasxzhrJcvsZlN7TVlgZYjlxIxQCxmQlNJxOOIsB2DKjMLOcRqH
         wg9tiy1f/a5yBem+RzfP9bkdbQ0osOOzszMHzya7nXt8VNhQDoDMvdbQAE+kAeTPBS1c
         5+vA0LTWRkM/TlVCSEIf2cjOCOApVniPoXVSnkBWuExtUuKsNCs1eNWllAvTS+a/cNQH
         L3qdfVwLEqDtED/WqeIVLO5v/jhca+E+pQkytBviMwRquXzN45wsST4XBceFZI33J6oJ
         ZUxQ==
X-Gm-Message-State: ACgBeo0Yzk7GlsW4cOVRdMM7y2Aeh1JPrWzNVzTuWNw5gyzmjwK4ztco
        0tUTJCXCXwDKbKjNXQIBruL0wCkMJ8TJyv+hoW9lvCDax0syxXB3wv8d4yjuE4uxEhqthUkWzcp
        BI04tp0fQl0eh
X-Received: by 2002:a05:651c:1146:b0:261:d36a:7ff8 with SMTP id h6-20020a05651c114600b00261d36a7ff8mr2780204ljo.363.1662649483944;
        Thu, 08 Sep 2022 08:04:43 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7CK20FTdB+XkXWCfE1133Hsl1hhN7e9RFclguwY6lDjHxFzUyQMCb/Elui4yOx7Tl0SSbljg==
X-Received: by 2002:a05:651c:1146:b0:261:d36a:7ff8 with SMTP id h6-20020a05651c114600b00261d36a7ff8mr2780180ljo.363.1662649483588;
        Thu, 08 Sep 2022 08:04:43 -0700 (PDT)
Received: from [192.168.41.81] (83-90-141-187-cable.dk.customer.tdc.net. [83.90.141.187])
        by smtp.gmail.com with ESMTPSA id 139-20020a2e0591000000b0026ace57a971sm1004055ljf.18.2022.09.08.08.04.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Sep 2022 08:04:42 -0700 (PDT)
From:   Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <9aab9ef1-446d-57ab-5789-afffe27801f4@redhat.com>
Date:   Thu, 8 Sep 2022 17:04:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Cc:     brouer@redhat.com, bpf@vger.kernel.org, netdev@vger.kernel.org,
        xdp-hints@xdp-project.net, larysa.zaremba@intel.com,
        memxor@gmail.com, Lorenzo Bianconi <lorenzo@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Daniel Borkmann <borkmann@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        dave@dtucker.co.uk, Magnus Karlsson <magnus.karlsson@intel.com>,
        bjorn@kernel.org
Subject: Re: [PATCH RFCv2 bpf-next 17/18] xsk: AF_XDP xdp-hints support in
 desc options
Content-Language: en-US
To:     Maryam Tahhan <mtahhan@redhat.com>,
        Magnus Karlsson <magnus.karlsson@gmail.com>
References: <166256538687.1434226.15760041133601409770.stgit@firesoul>
 <166256558657.1434226.7390735974413846384.stgit@firesoul>
 <CAJ8uoz3UcC2tnMtG8W6a3HpCKgaYSzSCqowLFQVwCcsr+NKBOQ@mail.gmail.com>
 <b5f0d10d-2d4e-34d6-1e45-c206cb6f5d26@redhat.com>
In-Reply-To: <b5f0d10d-2d4e-34d6-1e45-c206cb6f5d26@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


On 08/09/2022 12.10, Maryam Tahhan wrote:
> On 08/09/2022 09:06, Magnus Karlsson wrote:
>> On Wed, Sep 7, 2022 at 5:48 PM Jesper Dangaard Brouer 
>> <brouer@redhat.com> wrote:
>>>
>>> From: Maryam Tahhan <mtahhan@redhat.com>
>>>
>>> Simply set AF_XDP descriptor options to XDP flags.
>>>
>>> Jesper: Will this really be acceptable by AF_XDP maintainers?
>>
>> Maryam, you guessed correctly that dedicating all these options bits
>> for a single feature will not be ok :-). E.g., I want one bit for the
>> AF_XDP multi-buffer support and who knows what other uses there might
>> be for this options field in the future. Let us try to solve this in
>> some other way. Here are some suggestions, all with their pros and
>> cons.
>>
> 
> TBH it was Jespers question :)

True. I'm generally questioning this patch...
... and indirectly asking Magnus.  (If you noticed, I didn't add my SoB)

>> * Put this feature flag at a known place in the metadata area, for
>> example just before the BTF ID. No need to fill this in if you are not
>> redirecting to AF_XDP, but at a redirect to AF_XDP, the XDP flags are
>> copied into this u32 in the metadata area so that user-space can
>> consume it. Will cost 4 bytes of the metadata area though.
> 
> If Jesper agrees I think this approach would make sense. Trying to
> translate encodings into some other flags for AF_XDP I think will lead
> to a growing set of translations as more options come along.
> The other thing to be aware of is just making sure to clear/zero the 
> metadata space in the buffers at some point (ideally when the descriptor 
> is returned from the application) so when the buffers are used again
> they are already in a "reset" state.

I don't like this option ;-)

First of all because this can give false positives, if "XDP flags copied
into metadata area" is used for something else.  This can easily happen
as XDP BPF-progs are free to metadata for something else.

Second reason, because it would require AF_XDP to always read the
metadata cache-line (and write, if clearing on "return").  Not a good
optioon, given how performance sensitive AF_XDP workloads (at least
benchmarks).

>>
>> * Instead encode this information into each metadata entry in the
>> metadata area, in some way so that a flags field is not needed (-1
>> signifies not valid, or whatever happens to make sense). This has the
>> drawback that the user might have to look at a large number of entries
>> just to find out there is nothing valid to read. To alleviate this, it
>> could be combined with the next suggestion.
>>
>> * Dedicate one bit in the options field to indicate that there is at
>> least one valid metadata entry in the metadata area. This could be
>> combined with the two approaches above. However, depending on what
>> metadata you have enabled, this bit might be pointless. If some
>> metadata is always valid, then it serves no purpose. But it might if
>> all enabled metadata is rarely valid, e.g., if you get an Rx timestamp
>> on one packet out of one thousand.
>>

I like this option better! Except that I have hoped to get 2 bits ;-)

The performance advantage is that the AF_XDP descriptor bits will 
already be cache-hot, and if it indicates no-metadata-hints the AF_XDP 
application can avoid reading the metadata cache-line :-).

When metadata is valid and contains valid XDP-hints can change between 
two packets.  E.g. XDP-hints can be enabled/disabled via ethtool, and 
the content can be enabled/disabled by other ethtool commands, and even 
setsockopt calls (e.g timestamping).  An XDP prog can also choose to use 
the area for something else for a subset of the packets.

It is a design choice in this patchset to avoid locking down the NIC 
driver to a fixed XDP-hints layout, and avoid locking/disabling other 
ethtool config setting to keeping XDP-hints layout stable.  Originally I 
wanted this, but I realized that it would be impossible (and annoying 
for users) if we had to control every config interface to NIC hardware 
offload hints, to keep XDP-hints "always-valid".

--Jesper

>>> Signed-off-by: Maryam Tahhan <mtahhan@redhat.com>
>>> ---
>>>   include/uapi/linux/if_xdp.h |    2 +-
>>>   net/xdp/xsk.c               |    2 +-
>>>   net/xdp/xsk_queue.h         |    3 ++-
>>>   3 files changed, 4 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/include/uapi/linux/if_xdp.h b/include/uapi/linux/if_xdp.h
>>> index a78a8096f4ce..9335b56474e7 100644
>>> --- a/include/uapi/linux/if_xdp.h
>>> +++ b/include/uapi/linux/if_xdp.h
>>> @@ -103,7 +103,7 @@ struct xdp_options {
>>>   struct xdp_desc {
>>>          __u64 addr;
>>>          __u32 len;
>>> -       __u32 options;
>>> +       __u32 options; /* set to the values of xdp_hints_flags*/
>>>   };
>>>
>>>   /* UMEM descriptor is __u64 */
>>> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
>>> index 5b4ce6ba1bc7..32095d78f06b 100644
>>> --- a/net/xdp/xsk.c
>>> +++ b/net/xdp/xsk.c
>>> @@ -141,7 +141,7 @@ static int __xsk_rcv_zc(struct xdp_sock *xs, 
>>> struct xdp_buff *xdp, u32 len)
>>>          int err;
>>>
>>>          addr = xp_get_handle(xskb);
>>> -       err = xskq_prod_reserve_desc(xs->rx, addr, len);
>>> +       err = xskq_prod_reserve_desc(xs->rx, addr, len, xdp->flags);
>>>          if (err) {
>>>                  xs->rx_queue_full++;
>>>                  return err;
>>> diff --git a/net/xdp/xsk_queue.h b/net/xdp/xsk_queue.h
>>> index fb20bf7207cf..7a66f082f97e 100644
>>> --- a/net/xdp/xsk_queue.h
>>> +++ b/net/xdp/xsk_queue.h
>>> @@ -368,7 +368,7 @@ static inline u32 
>>> xskq_prod_reserve_addr_batch(struct xsk_queue *q, struct xdp_d
>>>   }
>>>
>>>   static inline int xskq_prod_reserve_desc(struct xsk_queue *q,
>>> -                                        u64 addr, u32 len)
>>> +                                        u64 addr, u32 len, u32 flags)
>>>   {
>>>          struct xdp_rxtx_ring *ring = (struct xdp_rxtx_ring *)q->ring;
>>>          u32 idx;
>>> @@ -380,6 +380,7 @@ static inline int xskq_prod_reserve_desc(struct 
>>> xsk_queue *q,
>>>          idx = q->cached_prod++ & q->ring_mask;
>>>          ring->desc[idx].addr = addr;
>>>          ring->desc[idx].len = len;
>>> +       ring->desc[idx].options = flags;
>>>
>>>          return 0;
>>>   }
>>>
>>>
>>
> 

