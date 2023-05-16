Return-Path: <bpf+bounces-655-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C88070524E
	for <lists+bpf@lfdr.de>; Tue, 16 May 2023 17:36:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 859381C20E49
	for <lists+bpf@lfdr.de>; Tue, 16 May 2023 15:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D37C31103;
	Tue, 16 May 2023 15:35:39 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0562828C3F
	for <bpf@vger.kernel.org>; Tue, 16 May 2023 15:35:38 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4D845FEB
	for <bpf@vger.kernel.org>; Tue, 16 May 2023 08:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1684251332;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CcyRieVlUfnyzXKTzR5d4JdkM5K3TgxrxW94yInGt+Q=;
	b=gOLfRPLBvvF+acIjbiD0LF5gv2tq7ElpnTF+pj7x4YH/G3/Cd4j89muqHD7GhkJ0jYZFTe
	8uHe/kSP2ammn6L2cyJ7LVYHEuv2rsjtsQIxetBzLpoRx6lQj5V9l4DMm/0TaqAn1XhIWv
	C7qwag83TjaS3rUUdm5p/zjUXYqpAkY=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-7-3DiVCLPvNU6fBXsJm9Vgtw-1; Tue, 16 May 2023 11:35:31 -0400
X-MC-Unique: 3DiVCLPvNU6fBXsJm9Vgtw-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-969f12b2818so1200241966b.1
        for <bpf@vger.kernel.org>; Tue, 16 May 2023 08:35:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684251330; x=1686843330;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:cc:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CcyRieVlUfnyzXKTzR5d4JdkM5K3TgxrxW94yInGt+Q=;
        b=Ib4glf/1dSx5264snhkvd0V5SN9NGMeSWRBhDlLNHL1o5wWZKI1mKyK+Mtu+cieXUP
         k8qKJXScdDCAlX2uN0tqtPM8aGzKdm9PAyJUINNzh0Edr7TnlyFzm0ZTvNoVcmdz3UBW
         gt6yewFspiuCOdEtibAwcjj8pvE+i0SlzAG8QHE3C3uQgYn86vl6lc9ST2Y5lLI6/CAO
         BBl2KTLB+3Yy+CO3EYztNZCAT+MZa8e5/GZidczUnEbu0RsbVoWNpx0Mcw12gIJN+GHI
         7aBIADHaeAaJxMO+uVnUvBdQkbUjIOc4QdelSwabtRFcOP1wiwA2egDxL5UxFLIlwSxe
         74yQ==
X-Gm-Message-State: AC+VfDzzdAxFxOCzmEhmi9HZXEAhuHiEcZq4FDeqWIW17Lpg5yXzwj3u
	sktP535KXitmfEtwMNzqivQZaG2dEuG5BV/lIQ201g0mGC/ofQjU9jg3k/dYk7n3fApK/e0qpF+
	iYhUsDBWoYeiv
X-Received: by 2002:a17:907:7241:b0:96a:f688:db6d with SMTP id ds1-20020a170907724100b0096af688db6dmr9440478ejc.39.1684251330702;
        Tue, 16 May 2023 08:35:30 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ57HOpAvaM/nwXSOEpBnwKQLHKhU91w24YzKezDzveXbLZUSTWHiqd71UBuqaWRBls0iTWibg==
X-Received: by 2002:a17:907:7241:b0:96a:f688:db6d with SMTP id ds1-20020a170907724100b0096af688db6dmr9440452ejc.39.1684251330293;
        Tue, 16 May 2023 08:35:30 -0700 (PDT)
Received: from [192.168.42.222] (194-45-78-10.static.kviknet.net. [194.45.78.10])
        by smtp.gmail.com with ESMTPSA id og40-20020a1709071de800b0095807ab4b57sm11264399ejc.178.2023.05.16.08.35.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 May 2023 08:35:29 -0700 (PDT)
From: Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <a37db72f-2e83-c838-7c81-8f01a5a0df32@redhat.com>
Date: Tue, 16 May 2023 17:35:27 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Cc: brouer@redhat.com, Jesper Dangaard Brouer <jbrouer@redhat.com>,
 bpf@vger.kernel.org, Stanislav Fomichev <sdf@google.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>,
 KP Singh <kpsingh@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
 Jesse Brandeburg <jesse.brandeburg@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Alexander Lobakin <alexandr.lobakin@intel.com>,
 Magnus Karlsson <magnus.karlsson@gmail.com>,
 Maryam Tahhan <mtahhan@redhat.com>, xdp-hints@xdp-project.net,
 netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND bpf-next 14/15] net, xdp: allow metadata > 32
Content-Language: en-US
To: Alexander Lobakin <aleksander.lobakin@intel.com>,
 Larysa Zaremba <larysa.zaremba@intel.com>
References: <20230512152607.992209-1-larysa.zaremba@intel.com>
 <20230512152607.992209-15-larysa.zaremba@intel.com>
 <ee1ad4f2-34ab-4377-14d5-532cb0687180@redhat.com> <ZGJnFxzDTV2qE4zZ@lincoln>
 <b9a879b2-bb62-ba18-0bdd-5c126a1086a9@intel.com>
In-Reply-To: <b9a879b2-bb62-ba18-0bdd-5c126a1086a9@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 16/05/2023 14.37, Alexander Lobakin wrote:
> From: Larysa Zaremba<larysa.zaremba@intel.com>
> Date: Mon, 15 May 2023 19:08:39 +0200
> 
>> On Mon, May 15, 2023 at 06:17:02PM +0200, Jesper Dangaard Brouer wrote:
>>>
>>> On 12/05/2023 17.26, Larysa Zaremba wrote:
>>>> From: Aleksander Lobakin<aleksander.lobakin@intel.com>
>>>>
>>>> When using XDP hints, metadata sometimes has to be much bigger
>>>> than 32 bytes. Relax the restriction, allow metadata larger than 32 bytes
>>>> and make __skb_metadata_differs() work with bigger lengths.
>>>>
>>>> Now size of metadata is only limited by the fact it is stored as u8
>>>> in skb_shared_info, so maximum possible value is 255.
 >>>
>>> I'm confused, IIRC the metadata area isn't stored "in skb_shared_info".
>>> The maximum possible size is limited by the XDP headroom, which is also
>>> shared/limited with/by xdp_frame.  I must be reading the sentence wrong,
>>> somehow.
 >
> skb_shared_info::meta_size  is u8. Since metadata gets carried from
> xdp_buff to skb, this check is needed (it's compile-time constant anyway).
> Check for headroom is done separately already (two sentences below).
> 

Damn, argh, for SKBs the "meta_len" is stored in skb_shared_info, which
is located on another cacheline.
That is a sure way to KILL performance! :-(

But only use for SKBs that gets created from xdp with metadata, right?



>> It's not 'metadata is stored as u8', it's 'metadata size is stored as u8' :)
>> Maybe I should rephrase it better in v2.

Yes, a rephrase will be good.

--Jesper



static inline u8 skb_metadata_len(const struct sk_buff *skb)
{
	return skb_shinfo(skb)->meta_len;
}


