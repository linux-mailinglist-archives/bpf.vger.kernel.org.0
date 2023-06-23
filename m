Return-Path: <bpf+bounces-3250-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EAC073B536
	for <lists+bpf@lfdr.de>; Fri, 23 Jun 2023 12:24:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C94F281A48
	for <lists+bpf@lfdr.de>; Fri, 23 Jun 2023 10:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E755F6126;
	Fri, 23 Jun 2023 10:24:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1E0610D
	for <bpf@vger.kernel.org>; Fri, 23 Jun 2023 10:24:26 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD53F10C1
	for <bpf@vger.kernel.org>; Fri, 23 Jun 2023 03:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1687515863;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lMqGdUEQSvr6augTCZP2DW4zK3VdpXi2du9+8sZEAvU=;
	b=GQm7D6SLpBF81Z5x7OeEkHoHzQRNPXvblG18hto5qRAU5GOdwVn1igmkx+ZooOPNgXNzhC
	zLOLGXmpBHhMBebGF7gWHRTeQ0Bx0QpCkoaDzvTn07jVvafXzYWSp/Cn43nAmTSR1P1QBk
	acbxlhdUm0r9lON7uPad2JSFJMkMEYA=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-13-fLW96jjkP_alHbp8EAf-CA-1; Fri, 23 Jun 2023 06:24:22 -0400
X-MC-Unique: fLW96jjkP_alHbp8EAf-CA-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-4f618172ed6so353210e87.3
        for <bpf@vger.kernel.org>; Fri, 23 Jun 2023 03:24:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687515861; x=1690107861;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:cc:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lMqGdUEQSvr6augTCZP2DW4zK3VdpXi2du9+8sZEAvU=;
        b=aMkQ3CP6oTfZ2+R/8jtd1M8YdoQSoQSlVjTUGWLky8jk0ANDShXfbZkIDc7iRbtYYp
         q+tC4zP1TVxVrjrBTpZkNcp7aDwFo1Jhq1C9+pKWW0G/DReOscOn3Ab8i3UGpzG1WvWS
         7aisCfi18vAZdtowwtAMmCsjwJ0Sd86K66IW7iHF7lg0cMK6BYEm8pMj36mfFVoJys5V
         eZgPwd8vXuAwYVB0t9uYwH0zvkvOij3JzsQqcHk7/2vjKUELkih1B8HAoVX2fvAa7vvr
         +QFddJLmci5AAE1WAnqh59WpAU3HpoaDwKLp2FrnMlChSmNHugR7GqB5AXjb3tsEitWH
         62Dg==
X-Gm-Message-State: AC+VfDxbPm53QEFSKvLa0aJFh7FMjLZJx5GSH6c4o2QPTyeYhMH1y5x3
	0W0t10Ot8f3STbVOXZ0eqhs+U5z/2Rgcc5TwF1sWhTM3yTMCT82kdYDqhpRt1aGLFhdTYu/1Jxy
	pkSA//lm+I8YG
X-Received: by 2002:a05:6512:522:b0:4f8:71bf:a259 with SMTP id o2-20020a056512052200b004f871bfa259mr8927047lfc.67.1687515861180;
        Fri, 23 Jun 2023 03:24:21 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6brWFmYCLLecmzWb3m20jfo709OVopCEMLWppkXzINAFB4wTuTdklaoLSZ2XR7zLHDf1pLRg==
X-Received: by 2002:a05:6512:522:b0:4f8:71bf:a259 with SMTP id o2-20020a056512052200b004f871bfa259mr8927035lfc.67.1687515860859;
        Fri, 23 Jun 2023 03:24:20 -0700 (PDT)
Received: from [192.168.42.222] (194-45-78-10.static.kviknet.net. [194.45.78.10])
        by smtp.gmail.com with ESMTPSA id f24-20020a7bc8d8000000b003f907bdeef3sm1917945wml.26.2023.06.23.03.24.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Jun 2023 03:24:20 -0700 (PDT)
From: Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <c936bd6c-7060-47da-d522-747b49bee8a0@redhat.com>
Date: Fri, 23 Jun 2023 12:24:18 +0200
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
To: Stanislav Fomichev <sdf@google.com>
References: <20230621170244.1283336-1-sdf@google.com>
 <20230621170244.1283336-4-sdf@google.com>
 <57b9fc14-c02e-f0e5-148d-a549ebab6cf6@brouer.com>
 <CAKH8qBsk3MDbx2PyU-_+tDV4C0R6J_wzxi9Co6ekHv_tWzp7Tw@mail.gmail.com>
In-Reply-To: <CAKH8qBsk3MDbx2PyU-_+tDV4C0R6J_wzxi9Co6ekHv_tWzp7Tw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 22/06/2023 19.55, Stanislav Fomichev wrote:
> On Thu, Jun 22, 2023 at 2:11 AM Jesper D. Brouer <netdev@brouer.com> wrote:
>>
>>
>> This needs to be reviewed by AF_XDP maintainers Magnus and Bjørn (Cc)
>>
>> On 21/06/2023 19.02, Stanislav Fomichev wrote:
>>> For zerocopy mode, tx_desc->addr can point to the arbitrary offset
>>> and carry some TX metadata in the headroom. For copy mode, there
>>> is no way currently to populate skb metadata.
>>>
>>> Introduce new XDP_TX_METADATA_LEN that indicates how many bytes
>>> to treat as metadata. Metadata bytes come prior to tx_desc address
>>> (same as in RX case).
>>
>>   From looking at the code, this introduces a socket option for this TX
>> metadata length (tx_metadata_len).
>> This implies the same fixed TX metadata size is used for all packets.
>> Maybe describe this in patch desc.
> 
> I was planning to do a proper documentation page once we settle on all
> the details (similar to the one we have for rx).
> 
>> What is the plan for dealing with cases that doesn't populate same/full
>> TX metadata size ?
> 
> Do we need to support that? I was assuming that the TX layout would be
> fixed between the userspace and BPF.

I hope you don't mean fixed layout, as the whole point is adding
flexibility and extensibility.

> If every packet would have a different metadata length, it seems like
> a nightmare to parse?
> 

No parsing is really needed.  We can simply use BTF IDs and type cast in
BPF-prog. Both BPF-prog and userspace have access to the local BTF ids,
see [1] and [2].

It seems we are talking slightly past each-other(?).  Let me rephrase
and reframe the question, what is your *plan* for dealing with different
*types* of TX metadata.  The different struct *types* will of-cause have
different sizes, but that is okay as long as they fit into the maximum
size set by this new socket option XDP_TX_METADATA_LEN.
Thus, in principle I'm fine with XSK having configured a fixed headroom
for metadata, but we need a plan for handling more than one type and
perhaps a xsk desc indicator/flag for knowing TX metadata isn't random
data ("leftover" since last time this mem was used).

With this kfunc approach, then things in-principle, becomes a contract
between the "local" TX-hook BPF-prog and AF_XDP userspace.   These two
components can as illustrated here [1]+[2] can coordinate based on local
BPF-prog BTF IDs.  This approach works as-is today, but patchset
selftests examples don't use this and instead have a very static
approach (that people will copy-paste).

An unsolved problem with TX-hook is that it can also get packets from
XDP_REDIRECT and even normal SKBs gets processed (right?).  How does the
BPF-prog know if metadata is valid and intended to be used for e.g.
requesting the timestamp? (imagine metadata size happen to match)

--Jesper

BPF-prog API bpf_core_type_id_local:
  - [1] 
https://github.com/xdp-project/bpf-examples/blob/master/AF_XDP-interaction/af_xdp_kern.c#L80

Userspace API btf__find_by_name_kind:
  - [2] 
https://github.com/xdp-project/bpf-examples/blob/master/AF_XDP-interaction/lib_xsk_extend.c#L185


