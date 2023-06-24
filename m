Return-Path: <bpf+bounces-3362-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C442E73C9CE
	for <lists+bpf@lfdr.de>; Sat, 24 Jun 2023 11:02:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF7F6281CA3
	for <lists+bpf@lfdr.de>; Sat, 24 Jun 2023 09:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FE2A20EE;
	Sat, 24 Jun 2023 09:02:35 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D3D81367
	for <bpf@vger.kernel.org>; Sat, 24 Jun 2023 09:02:35 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69A3D18B
	for <bpf@vger.kernel.org>; Sat, 24 Jun 2023 02:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1687597351;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TlP2BVcQn03b4N3Vfnv2JBUz1UUdr9/ElEd0wsgEsos=;
	b=WRalVKZatyuJqjlz8UeDn+l8vYFSCuXqfuGQ+Gid78eFEkG2fIuhC96GIze600BoxCWU32
	kdeGJz3WOt+asXURtU0No4+/tykeYTp2XUR9GtpSKIrNNnfrmrRFGDA5peSs+QPcJInq/5
	Cky72/G2LLyQ8TjAVljdjEk9Aq3mkfM=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-512-T8rLrhY2N8OluskBWE2XqA-1; Sat, 24 Jun 2023 05:02:29 -0400
X-MC-Unique: T8rLrhY2N8OluskBWE2XqA-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-51bfc9242fdso628050a12.1
        for <bpf@vger.kernel.org>; Sat, 24 Jun 2023 02:02:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687597349; x=1690189349;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:cc:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TlP2BVcQn03b4N3Vfnv2JBUz1UUdr9/ElEd0wsgEsos=;
        b=IoZPfXAIF0qvW82VJWln0JizAe/3RbqXu6OJp+JQs+GHRRv0kUJQy1dPHwd/4wWpBc
         5B0t+0lq/JBIdlMS1HKFCIrCeCkXcdReI+hJHSa1/KDn2wZVn176+IbGOFq29FrANae6
         2gjGc2jW1JYuE4mjFAfDrzJ/MMBSYyxsO3rOcHXydZ6mYmvy2Hp7ZODoCbi/UXRDcxh0
         xG+aC1cKlcXWUB+YWYzRW+qRqTR8J8aB6Fmwh/0whxlRNAxT0ehtV/RwX+UuJRVrxPJ0
         DMwqlW8B5sEqb5atML0KFVFIuUx/QhFU/xMzifBgt9sWzqqyerTvE/7XRCoFFJO2H+jq
         J3eA==
X-Gm-Message-State: AC+VfDybDbVuvA2Zac22pZrBQOL4+5D1KGYf+WStuMKNXP8pevIdgPOi
	I5yzqN8E7Y35e4faxg90+677u0d4EJm6tN4O0A+tFkeLQ7fu3UZ6aBpgFAOG4vGgtSGHJZkXKbN
	gQ9oi1/l4HoZm
X-Received: by 2002:a17:907:7f1e:b0:989:1f66:e42f with SMTP id qf30-20020a1709077f1e00b009891f66e42fmr12083031ejc.62.1687597348776;
        Sat, 24 Jun 2023 02:02:28 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6rX9nKQ/6jeI2c308HrgACFLv0fQdBSt6UoiFoefTo79cZHwMfmp/LK+12IYGEmy9HYiV8vQ==
X-Received: by 2002:a17:907:7f1e:b0:989:1f66:e42f with SMTP id qf30-20020a1709077f1e00b009891f66e42fmr12083006ejc.62.1687597348344;
        Sat, 24 Jun 2023 02:02:28 -0700 (PDT)
Received: from [192.168.42.222] (194-45-78-10.static.kviknet.net. [194.45.78.10])
        by smtp.gmail.com with ESMTPSA id b11-20020a170906194b00b00986e6a7d230sm641704eje.168.2023.06.24.02.02.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Jun 2023 02:02:27 -0700 (PDT)
From: Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <435d1630-c3f4-97fb-b6fe-9795d1f0bf33@redhat.com>
Date: Sat, 24 Jun 2023 11:02:26 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Cc: brouer@redhat.com, bpf@vger.kernel.org, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
 song@kernel.org, yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
 haoluo@google.com, jolsa@kernel.org, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@kernel.org>, "Karlsson, Magnus" <magnus.karlsson@intel.com>,
 "xdp-hints@xdp-project.net" <xdp-hints@xdp-project.net>
Subject: Re: [RFC bpf-next v2 03/11] xsk: Support XDP_TX_METADATA_LEN
Content-Language: en-US
To: Stanislav Fomichev <sdf@google.com>,
 Jesper Dangaard Brouer <jbrouer@redhat.com>
References: <20230621170244.1283336-1-sdf@google.com>
 <20230621170244.1283336-4-sdf@google.com>
 <57b9fc14-c02e-f0e5-148d-a549ebab6cf6@brouer.com>
 <CAKH8qBsk3MDbx2PyU-_+tDV4C0R6J_wzxi9Co6ekHv_tWzp7Tw@mail.gmail.com>
 <c936bd6c-7060-47da-d522-747b49bee8a0@redhat.com>
 <CAKH8qBsqdE7=4JC8LfkL4gV9eQHEZjMpBSen2a+4q2Y7DpiOow@mail.gmail.com>
In-Reply-To: <CAKH8qBsqdE7=4JC8LfkL4gV9eQHEZjMpBSen2a+4q2Y7DpiOow@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 23/06/2023 19.41, Stanislav Fomichev wrote:
> On Fri, Jun 23, 2023 at 3:24 AM Jesper Dangaard Brouer
> <jbrouer@redhat.com> wrote:
>>
>>
>>
>> On 22/06/2023 19.55, Stanislav Fomichev wrote:
>>> On Thu, Jun 22, 2023 at 2:11 AM Jesper D. Brouer <netdev@brouer.com> wrote:
>>>>
>>>>
>>>> This needs to be reviewed by AF_XDP maintainers Magnus and Bjørn (Cc)
>>>>
>>>> On 21/06/2023 19.02, Stanislav Fomichev wrote:
>>>>> For zerocopy mode, tx_desc->addr can point to the arbitrary offset
>>>>> and carry some TX metadata in the headroom. For copy mode, there
>>>>> is no way currently to populate skb metadata.
>>>>>
>>>>> Introduce new XDP_TX_METADATA_LEN that indicates how many bytes
>>>>> to treat as metadata. Metadata bytes come prior to tx_desc address
>>>>> (same as in RX case).
>>>>
>>>>    From looking at the code, this introduces a socket option for this TX
>>>> metadata length (tx_metadata_len).
>>>> This implies the same fixed TX metadata size is used for all packets.
>>>> Maybe describe this in patch desc.
>>>
>>> I was planning to do a proper documentation page once we settle on all
>>> the details (similar to the one we have for rx).
>>>
>>>> What is the plan for dealing with cases that doesn't populate same/full
>>>> TX metadata size ?
>>>
>>> Do we need to support that? I was assuming that the TX layout would be
>>> fixed between the userspace and BPF.
>>
>> I hope you don't mean fixed layout, as the whole point is adding
>> flexibility and extensibility.
> 
> I do mean a fixed layout between the userspace (af_xdp) and devtx program.
> At least fixed max size of the metadata. The userspace and the bpf
> prog can then use this fixed space to implement some flexibility
> (btf_ids, versioned structs, bitmasks, tlv, etc).
> If we were to make the metalen vary per packet, we'd have to signal
> its size per packet. Probably not worth it?

Existing XDP metadata implementation also expand in a fixed/limited
sized memory area, but communicate size per packet in this area (also
for validation purposes).  BUT for AF_XDP we don't have room for another
pointer or size in the AF_XDP descriptor (see struct xdp_desc).


> 
>>> If every packet would have a different metadata length, it seems like
>>> a nightmare to parse?
>>>
>>
>> No parsing is really needed.  We can simply use BTF IDs and type cast in
>> BPF-prog. Both BPF-prog and userspace have access to the local BTF ids,
>> see [1] and [2].
>>
>> It seems we are talking slightly past each-other(?).  Let me rephrase
>> and reframe the question, what is your *plan* for dealing with different
>> *types* of TX metadata.  The different struct *types* will of-cause have
>> different sizes, but that is okay as long as they fit into the maximum
>> size set by this new socket option XDP_TX_METADATA_LEN.
>> Thus, in principle I'm fine with XSK having configured a fixed headroom
>> for metadata, but we need a plan for handling more than one type and
>> perhaps a xsk desc indicator/flag for knowing TX metadata isn't random
>> data ("leftover" since last time this mem was used).
> 
> Yeah, I think the above correctly catches my expectation here. Some
> headroom is reserved via XDP_TX_METADATA_LEN and the flexibility is
> offloaded to the bpf program via btf_id/tlv/etc.
> 
> Regarding leftover metadata: can we assume the userspace will take
> care of setting it up?
> 
>> With this kfunc approach, then things in-principle, becomes a contract
>> between the "local" TX-hook BPF-prog and AF_XDP userspace.   These two
>> components can as illustrated here [1]+[2] can coordinate based on local
>> BPF-prog BTF IDs.  This approach works as-is today, but patchset
>> selftests examples don't use this and instead have a very static
>> approach (that people will copy-paste).
>>
>> An unsolved problem with TX-hook is that it can also get packets from
>> XDP_REDIRECT and even normal SKBs gets processed (right?).  How does the
>> BPF-prog know if metadata is valid and intended to be used for e.g.
>> requesting the timestamp? (imagine metadata size happen to match)
> 
> My assumption was the bpf program can do ifindex/netns filtering. Plus
> maybe check that the meta_len is the one that's expected.
> Will that be enough to handle XDP_REDIRECT?

I don't think so, using the meta_len (+ ifindex/netns) to communicate
activation of TX hardware hints is too weak and not enough.  This is an
implicit API for BPF-programmers to understand and can lead to implicit
activation.

Think about what will happen for your AF_XDP send use-case.  For
performance reasons AF_XDP don't zero out frame memory.  Thus, meta_len
is fixed even if not used (and can contain garbage), it can by accident
create hard-to-debug situations.  As discussed with Magnus+Maryam
before, we found it was practical (and faster than mem zero) to extend
AF_XDP descriptor (see struct xdp_desc) with some flags to
indicate/communicate this frame comes with TX metadata hints.

>>
>> BPF-prog API bpf_core_type_id_local:
>>    - [1]
>> https://github.com/xdp-project/bpf-examples/blob/master/AF_XDP-interaction/af_xdp_kern.c#L80
>>
>> Userspace API btf__find_by_name_kind:
>>    - [2]
>> https://github.com/xdp-project/bpf-examples/blob/master/AF_XDP-interaction/lib_xsk_extend.c#L185
>>
> 


