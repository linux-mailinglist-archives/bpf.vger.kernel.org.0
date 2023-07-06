Return-Path: <bpf+bounces-4209-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D29F7497EA
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 11:05:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E8FF1C20C61
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 09:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8CE05380;
	Thu,  6 Jul 2023 09:04:55 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86934C61
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 09:04:55 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A5DC1BCC
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 02:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1688634293;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JRgRsp2FWtM1ajDRcR2lcgfKwwSkmw5MTCctZvf1Vww=;
	b=FhWXxMFLdH2VHYst23wq/5rDmB553z2kXjS4KfOs9LeDO41PDPNkgpXiy7idVNEQgxpJfS
	2bKmvCAZoWyf6ijGRtFPfa2ANxL/Lry4ZYvVbAW+AW9duCVLIJ+fMStINFbBd/a+0T/e48
	W7mXpsDYYgFLPNZlr+Q+lPcSPMMti1U=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-fmOTADolMu2O3tKQ0M0Qjg-1; Thu, 06 Jul 2023 05:04:52 -0400
X-MC-Unique: fmOTADolMu2O3tKQ0M0Qjg-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-94a356c74e0so33982366b.2
        for <bpf@vger.kernel.org>; Thu, 06 Jul 2023 02:04:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688634291; x=1691226291;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:cc:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JRgRsp2FWtM1ajDRcR2lcgfKwwSkmw5MTCctZvf1Vww=;
        b=KK3nJK7HaRxTF1yorDpxP2odP1gLb1dq+OyMfSqfMlhJEu6z946NEuHcyCL3RVJsda
         MsvBgkqFSrtE3ePwf1Rl/kCAxXU3POcOYCKnSqY+MVh+bAZ1/4jeSgHod7uJViLW0uok
         mUHRcrZiNv1viiSekI3VcGtaZv5oVEXjR260VkUqEcv+YmJIrP0shnDJTsZnXgfps0WQ
         KviQPhMnFBMKO3ehjDJRZdCViQpMUFlgULZJX2OQx05HjcxsWrxRomBzKLHRk93KoC6c
         gp1Jj1rLlmn8OiNagum7qzr2yToeCKl1Q7FeukVRmSdFjfmYR78GoTwNmHay/ErRyCtb
         hRZw==
X-Gm-Message-State: ABy/qLaQpkN7rPUucUJy4fBqqiATeZBtrZYiLLmE7A//8xM5jnqWDMdr
	2bJFTwrZh9/okFiyTj1uJWuA2bwSBhvG/48ECp0/a9I5VACpgxbpjPowMBypoWosqCyQatt7nbH
	Ad7kpocOnHGYm
X-Received: by 2002:a17:906:8f:b0:971:484:6391 with SMTP id 15-20020a170906008f00b0097104846391mr936588ejc.20.1688634291257;
        Thu, 06 Jul 2023 02:04:51 -0700 (PDT)
X-Google-Smtp-Source: APBJJlF8QrUyIfcWvQEKTibW2aZLt9dHEJ0HZEw3k4yx3jJ5selC58HHjh6xvrPIEGa3dNa3lU7qBA==
X-Received: by 2002:a17:906:8f:b0:971:484:6391 with SMTP id 15-20020a170906008f00b0097104846391mr936566ejc.20.1688634290906;
        Thu, 06 Jul 2023 02:04:50 -0700 (PDT)
Received: from [192.168.42.100] (194-45-78-10.static.kviknet.net. [194.45.78.10])
        by smtp.gmail.com with ESMTPSA id s24-20020a170906169800b0096f7500502csm531220ejd.199.2023.07.06.02.04.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jul 2023 02:04:50 -0700 (PDT)
From: Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <3cc1d2ba-e084-8fc4-aa31-856bc532d1a7@redhat.com>
Date: Thu, 6 Jul 2023 11:04:49 +0200
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
 song@kernel.org, yhs@fb.com, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org, David Ahern <dsahern@gmail.com>,
 Jakub Kicinski <kuba@kernel.org>, Willem de Bruijn <willemb@google.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Alexander Lobakin <alexandr.lobakin@intel.com>,
 Magnus Karlsson <magnus.karlsson@gmail.com>,
 Maryam Tahhan <mtahhan@redhat.com>, xdp-hints@xdp-project.net,
 netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Alexander Duyck <alexander.duyck@gmail.com>
Subject: Re: [xdp-hints] Re: [PATCH bpf-next v2 12/20] xdp: Add checksum level
 hint
Content-Language: en-US
To: John Fastabend <john.fastabend@gmail.com>,
 Larysa Zaremba <larysa.zaremba@intel.com>,
 Jesper Dangaard Brouer <jbrouer@redhat.com>
References: <20230703181226.19380-1-larysa.zaremba@intel.com>
 <20230703181226.19380-13-larysa.zaremba@intel.com>
 <64a331c338a5a_628d3208cb@john.notmuch> <ZKPlZ6Z8ni5+ZJCK@lincoln>
 <9cd44759-416c-7274-f805-ee9d756f15b1@redhat.com> <ZKQAPBcIE/iCkiX2@lincoln>
 <64a656273ee15_b20ce2087a@john.notmuch>
In-Reply-To: <64a656273ee15_b20ce2087a@john.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 06/07/2023 07.50, John Fastabend wrote:
> Larysa Zaremba wrote:
>> On Tue, Jul 04, 2023 at 12:39:06PM +0200, Jesper Dangaard Brouer wrote:
>>> Cc. DaveM+Alex Duyck, as I value your insights on checksums.
>>>
>>> On 04/07/2023 11.24, Larysa Zaremba wrote:
>>>> On Mon, Jul 03, 2023 at 01:38:27PM -0700, John Fastabend wrote:
>>>>> Larysa Zaremba wrote:
>>>>>> Implement functionality that enables drivers to expose to XDP code,
>>>>>> whether checksums was checked and on what level.
>>>>>>
>>>>>> Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
>>>>>> ---
>>>>>>    Documentation/networking/xdp-rx-metadata.rst |  3 +++
>>>>>>    include/linux/netdevice.h                    |  1 +
>>>>>>    include/net/xdp.h                            |  2 ++
>>>>>>    kernel/bpf/offload.c                         |  2 ++
>>>>>>    net/core/xdp.c                               | 21 ++++++++++++++++++++
>>>>>>    5 files changed, 29 insertions(+)
>>>>>>
>>>>>> diff --git a/Documentation/networking/xdp-rx-metadata.rst b/Documentation/networking/xdp-rx-metadata.rst
>>>>>> index ea6dd79a21d3..4ec6ddfd2a52 100644
>>>>>> --- a/Documentation/networking/xdp-rx-metadata.rst
>>>>>> +++ b/Documentation/networking/xdp-rx-metadata.rst
>>>>>> @@ -26,6 +26,9 @@ metadata is supported, this set will grow:
>>>>>>    .. kernel-doc:: net/core/xdp.c
>>>>>>       :identifiers: bpf_xdp_metadata_rx_vlan_tag
>>>>>> +.. kernel-doc:: net/core/xdp.c
>>>>>> +   :identifiers: bpf_xdp_metadata_rx_csum_lvl
>>>>>> +
>>>>>>    An XDP program can use these kfuncs to read the metadata into stack
>>>>>>    variables for its own consumption. Or, to pass the metadata on to other
>>>>>>    consumers, an XDP program can store it into the metadata area carried
>>>>>> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
>>>>>> index 4fa4380e6d89..569563687172 100644
>>>>>> --- a/include/linux/netdevice.h
>>>>>> +++ b/include/linux/netdevice.h
>>>>>> @@ -1660,6 +1660,7 @@ struct xdp_metadata_ops {
>>>>>>    			       enum xdp_rss_hash_type *rss_type);
>>>>>>    	int	(*xmo_rx_vlan_tag)(const struct xdp_md *ctx, u16 *vlan_tag,
>>>>>>    				   __be16 *vlan_proto);
>>>>>> +	int	(*xmo_rx_csum_lvl)(const struct xdp_md *ctx, u8 *csum_level);
>>>>>>    };
>>>>>>    /**
>>>>>> diff --git a/include/net/xdp.h b/include/net/xdp.h
>>>>>> index 89c58f56ffc6..61ed38fa79d1 100644
>>>>>> --- a/include/net/xdp.h
>>>>>> +++ b/include/net/xdp.h
>>>>>> @@ -391,6 +391,8 @@ void xdp_attachment_setup(struct xdp_attachment_info *info,
>>>>>>    			   bpf_xdp_metadata_rx_hash) \
>>>>>>    	XDP_METADATA_KFUNC(XDP_METADATA_KFUNC_RX_VLAN_TAG, \
>>>>>>    			   bpf_xdp_metadata_rx_vlan_tag) \
>>>>>> +	XDP_METADATA_KFUNC(XDP_METADATA_KFUNC_RX_CSUM_LVL, \
>>>>>> +			   bpf_xdp_metadata_rx_csum_lvl) \
>>>>>>    enum {
>>>>>>    #define XDP_METADATA_KFUNC(name, _) name,
>>>>>> diff --git a/kernel/bpf/offload.c b/kernel/bpf/offload.c
>>>>>> index 986e7becfd42..a133fb775f49 100644
>>>>>> --- a/kernel/bpf/offload.c
>>>>>> +++ b/kernel/bpf/offload.c
>>>>>> @@ -850,6 +850,8 @@ void *bpf_dev_bound_resolve_kfunc(struct bpf_prog *prog, u32 func_id)
>>>>>>    		p = ops->xmo_rx_hash;
>>>>>>    	else if (func_id == bpf_xdp_metadata_kfunc_id(XDP_METADATA_KFUNC_RX_VLAN_TAG))
>>>>>>    		p = ops->xmo_rx_vlan_tag;
>>>>>> +	else if (func_id == bpf_xdp_metadata_kfunc_id(XDP_METADATA_KFUNC_RX_CSUM_LVL))
>>>>>> +		p = ops->xmo_rx_csum_lvl;
>>>>>>    out:
>>>>>>    	up_read(&bpf_devs_lock);
>>>>>> diff --git a/net/core/xdp.c b/net/core/xdp.c
>>>>>> index f6262c90e45f..c666d3e0a26c 100644
>>>>>> --- a/net/core/xdp.c
>>>>>> +++ b/net/core/xdp.c
>>>>>> @@ -758,6 +758,27 @@ __bpf_kfunc int bpf_xdp_metadata_rx_vlan_tag(const struct xdp_md *ctx, u16 *vlan
>>>>>>    	return -EOPNOTSUPP;
>>>>>>    }
>>>>>> +/**
>>>>>> + * bpf_xdp_metadata_rx_csum_lvl - Get depth at which HW has checked the checksum.
>>>>>> + * @ctx: XDP context pointer.
>>>>>> + * @csum_level: Return value pointer.
>>>>>> + *
>>>>>> + * In case of success, csum_level contains depth of the last verified checksum.
>>>>>> + * If only the outermost checksum was verified, csum_level is 0, if both
>>>>>> + * encapsulation and inner transport checksums were verified, csum_level is 1,
>>>>>> + * and so on.
>>>>>> + * For more details, refer to csum_level field in sk_buff.
>>>>>> + *
>>>>>> + * Return:
>>>>>> + * * Returns 0 on success or ``-errno`` on error.
>>>>>> + * * ``-EOPNOTSUPP`` : device driver doesn't implement kfunc
>>>>>> + * * ``-ENODATA``    : Checksum was not validated
>>>>>> + */
>>>>>> +__bpf_kfunc int bpf_xdp_metadata_rx_csum_lvl(const struct xdp_md *ctx, u8 *csum_level)
>>>>>
>>>>> Istead of ENODATA should we return what would be put in the ip_summed field
>>>>> CHECKSUM_{NONE, UNNECESSARY, COMPLETE, PARTIAL}? Then sig would be,
>>>
>>> I was thinking the same, what about checksum "type".
>>>
>>>>>
>>>>>    bpf_xdp_metadata_rx_csum_lvl(const struct xdp_md *ctx, u8 *type, u8 *lvl);
>>>>>
>>>>> or something like that? Or is the thought that its not really necessary?
>>>>> I don't have a strong preference but figured it was worth asking.
>>>>>
>>>>
>>>> I see no value in returning CHECKSUM_COMPLETE without the actual checksum value.
>>>> Same with CHECKSUM_PARTIAL and csum_start. Returning those values too would
>>>> overcomplicate the function signature.
>>>
>>> So, this kfunc bpf_xdp_metadata_rx_csum_lvl() success is it equivilent to
>>> CHECKSUM_UNNECESSARY?
>>
>> This is 100% true for physical NICs, it's more complicated for veth, bacause it
>> often receives CHECKSUM_PARTIAL, which shouldn't normally apprear on RX, but is
>> treated by the network stack as a validated checksum, because there is no way
>> internally generated packet could be messed up. I would be grateful if you could
>> look at the veth patch and share your opinion about this.
>>
>>>
>>> Looking at documentation[1] (generated from skbuff.h):
>>>   [1] https://kernel.org/doc/html/latest/networking/skbuff.html#checksumming-of-received-packets-by-device
>>>
>>> Is the idea that we can add another kfunc (new signature) than can deal
>>> with the other types of checksums (in a later kernel release)?
>>>
>>
>> Yes, that is the idea.
> 
> If we think there is a chance we might need another kfunc we should add it
> in the same kfunc. It would be unfortunate to have to do two kfuncs when
> one would work. It shouldn't cost much/anything(?) to hardcode the type for
> most cases? I think if we need it later I would advocate for updating this
> kfunc to support it. Of course then userspace will have to swivel on the
> kfunc signature.
> 

I think it might make sense to have 3 kfuncs for checksumming.
As this would allow BPF-prog to focus on CHECKSUM_UNNECESSARY, and then
only call additional kfunc for extracting e.g csum_start  + csum_offset
when type is CHECKSUM_PARTIAL.

We could extend bpf_xdp_metadata_rx_csum_lvl() to give the csum_type
CHECKSUM_{NONE, UNNECESSARY, COMPLETE, PARTIAL}.

  int bpf_xdp_metadata_rx_csum_lvl(*ctx, u8 *csum_level, u8 *csum_type)

And then add two kfunc e.g.
  (1) bpf_xdp_metadata_rx_csum_partial(ctx, start, offset)
  (2) bpf_xdp_metadata_rx_csum_complete(ctx, csum)

Pseudo BPF-prog code:

  err = bpf_xdp_metadata_rx_csum_lvl(ctx, level, type);
  if (!err && type != CHECKSUM_UNNECESSARY) {
      if (type == CHECKSUM_PARTIAL)
          err = bpf_xdp_metadata_rx_csum_partial(ctx, start, offset);
      if (type == CHECKSUM_COMPLETE)
          err = bpf_xdp_metadata_rx_csum_complete(ctx, csum);
  }

Looking at code, I feel we could rename [...]_csum_lvl to csum_type.
E.g. bpf_xdp_metadata_rx_csum_type.

Feel free to disagree,
--Jesper


