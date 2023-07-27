Return-Path: <bpf+bounces-6080-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A0A97655A3
	for <lists+bpf@lfdr.de>; Thu, 27 Jul 2023 16:11:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2B541C216B1
	for <lists+bpf@lfdr.de>; Thu, 27 Jul 2023 14:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52E7317757;
	Thu, 27 Jul 2023 14:11:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0E51772B
	for <bpf@vger.kernel.org>; Thu, 27 Jul 2023 14:11:26 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78EDE30E0
	for <bpf@vger.kernel.org>; Thu, 27 Jul 2023 07:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1690467075;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=02H8x558hkZCT5QcK29c6OWGjNlpE3njHKaLGMgzpjQ=;
	b=SFFHd8EmUCMLwTMZELqF2+Yz9czSu+Ehw47kqXvK8cwLLgvzFYcrSBlq1uQau2HhSsJqqo
	LZcQI8LKAeLdJ8RxjXhMI9zCBdSOebVG+htRx+NCX5ZEVS9OUIPTgDd7fg7wiOM1Y+vNOo
	oIqQNOIqAereYhNnnnACRhI1FoUiHT4=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-320-DAs6OwgIOKG-eu2ow3FofA-1; Thu, 27 Jul 2023 10:11:12 -0400
X-MC-Unique: DAs6OwgIOKG-eu2ow3FofA-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-99bcf56a2e9so60021066b.2
        for <bpf@vger.kernel.org>; Thu, 27 Jul 2023 07:11:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690467071; x=1691071871;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:cc:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=02H8x558hkZCT5QcK29c6OWGjNlpE3njHKaLGMgzpjQ=;
        b=IWUdXQg4FqvclxB2l0prhoBRoB1SHwMS2ROvZrH/1hw1/Vl0fGDPBieDaNCmiAcIre
         gyPaugwF4qwXRn6SnQCBLyctDjSqD7MvoPTbxFflX2yhcFfKRm/sQ+S3pH3o09Of7Ln0
         5Ah5cShABO79jW0hQAEHXmztuyQmk0VA3332CBYDYwHEOila4EKqCKtnaXtjaehlcmNd
         MKfN9U5SdgQKv8nXxFXEW7JYGAhBF1tPHtNVw4iXxyFtz955mEulIOzkzP0Y7AhAuSSH
         aK5+d/rPVmedRa2BtLTr/DKaMZX6gwZpUDN1wE0OWsp9FEgNCeXSE/BJpKl25lCVwMZ9
         bKtA==
X-Gm-Message-State: ABy/qLaK4792Plo35IhJb5j8bp6Pgkn7KsD935ZbU6xdMViS9KNaYmMy
	LGbrKMDQw5thL/RFRyvYtHWQpMpF+chTrebJZesLKYcvybmS3tySJIUwhBCPUScUc6YfJyXLT8T
	CopyNKw35+rMt
X-Received: by 2002:a17:906:7a54:b0:99b:4668:865f with SMTP id i20-20020a1709067a5400b0099b4668865fmr2312435ejo.10.1690467071172;
        Thu, 27 Jul 2023 07:11:11 -0700 (PDT)
X-Google-Smtp-Source: APBJJlG7IjqGxmTTXNFgOyjXwTagVILgqatNGoMeAgn/XqtOcq6Hkn97NgBSsfxMxoZ+Mwp8fNZ7Dg==
X-Received: by 2002:a17:906:7a54:b0:99b:4668:865f with SMTP id i20-20020a1709067a5400b0099b4668865fmr2312413ejo.10.1690467070894;
        Thu, 27 Jul 2023 07:11:10 -0700 (PDT)
Received: from [192.168.42.222] (194-45-78-10.static.kviknet.net. [194.45.78.10])
        by smtp.gmail.com with ESMTPSA id gq15-20020a170906e24f00b00982a92a849asm822836ejb.91.2023.07.27.07.11.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jul 2023 07:11:10 -0700 (PDT)
From: Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <50fc375a-27a7-8b6a-3938-f9fcb4f85b06@redhat.com>
Date: Thu, 27 Jul 2023 16:11:08 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Cc: brouer@redhat.com, bpf@vger.kernel.org, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
 song@kernel.org, yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
 haoluo@google.com, jolsa@kernel.org, kuba@kernel.org, toke@kernel.org,
 willemb@google.com, dsahern@kernel.org, magnus.karlsson@intel.com,
 bjorn@kernel.org, maciej.fijalkowski@intel.com, hawk@kernel.org,
 netdev@vger.kernel.org, xdp-hints@xdp-project.net
Subject: Re: [RFC net-next v4 2/8] xsk: add TX timestamp and TX checksum
 offload support
Content-Language: en-US
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Stanislav Fomichev <sdf@google.com>
References: <20230724235957.1953861-1-sdf@google.com>
 <20230724235957.1953861-3-sdf@google.com>
 <64c0369eadbd5_3fe1bc2940@willemb.c.googlers.com.notmuch>
 <ZMBPDe+IhvTQnKQa@google.com>
 <64c056686b527_3a4d294e6@willemb.c.googlers.com.notmuch>
In-Reply-To: <64c056686b527_3a4d294e6@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


On 26/07/2023 01.10, Willem de Bruijn wrote:
> Stanislav Fomichev wrote:
>> On 07/25, Willem de Bruijn wrote:
>>> Stanislav Fomichev wrote:
[...]
>>>> +struct xsk_tx_metadata {
>>>> +	__u32 flags;
>>>> +
>>>> +	/* XDP_TX_METADATA_CHECKSUM */
>>>> +
>>>> +	/* Offset from desc->addr where checksumming should start. */
>>>> +	__u16 csum_start;
>>>> +	/* Offset from csum_start where checksum should be stored. */
>>>> +	__u16 csum_offset;
>>>> +
>>>> +	/* XDP_TX_METADATA_TIMESTAMP */
>>>> +
>>>> +	__u64 tx_timestamp;
>>>> +};
 >>>
>>> Is this structure easily extensible for future offloads,
[...]
> 
> Pacing offload is the other feature that comes to mind. That could
> conceivably use the tx_timestamp field.

I would really like to see hardware offload "pacing" or LaunchTime as
hardware chips i210 and i225 calls it. I looked at the TX descriptor
details for drivers igc (i225) and igb (i210), and documented my finding
here[1], which should help with the code details if someone is motivated
for implementing this (I know of people on xdp-hints list that wanted
this LaunchTime feature).

   [1] 
https://github.com/xdp-project/xdp-project/blob/master/areas/tsn/code01_follow_qdisc_TSN_offload.org#tx-time-to-hardware-driver-igc

AFAIK this patchset uses struct xsk_tx_metadata as both TX and 
TX-Completion, right?.  It would be "conceivable" to reuse tx_timestamp 
field, but it might be confusing for uAPI end-users.  Maybe a union?

--Jesper


