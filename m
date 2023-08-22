Return-Path: <bpf+bounces-8281-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2658B784830
	for <lists+bpf@lfdr.de>; Tue, 22 Aug 2023 19:04:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41EC21C20A44
	for <lists+bpf@lfdr.de>; Tue, 22 Aug 2023 17:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F26F2B568;
	Tue, 22 Aug 2023 17:04:49 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B6E2B544
	for <bpf@vger.kernel.org>; Tue, 22 Aug 2023 17:04:49 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 365E2133
	for <bpf@vger.kernel.org>; Tue, 22 Aug 2023 10:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1692723887;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TEgNeZPj39Kw7MVmbPZsbxIfgYFliNhNFngISWetR44=;
	b=N7Uwb+i1/0Rpg0yBbp9zDk/8fcvgYVzYMjZkacMRhZng8St3mvLkpB/ZWE9wZUCHVP7yiW
	gfP44UxVq4a+JAl2pVKAlSsElbdMtgzP7xIaQKN+EfMc5wnz6f2LFn+K5xNXR5LJDBthxM
	zsk2oYB//LND30DNyRvTf1ghUVLcxxI=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-368-u049NfsEPUuSYeNtXa-hCA-1; Tue, 22 Aug 2023 13:04:45 -0400
X-MC-Unique: u049NfsEPUuSYeNtXa-hCA-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-5256fdb3e20so3003251a12.3
        for <bpf@vger.kernel.org>; Tue, 22 Aug 2023 10:04:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692723885; x=1693328685;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:cc:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TEgNeZPj39Kw7MVmbPZsbxIfgYFliNhNFngISWetR44=;
        b=EyoDnCBogS3U6t5VzEka/GK04ZhRG4XSggVihDNr/PSQjal+G3XpBAT0qJRsdBLr9r
         5aYRgPy31zbHZ3AsZrVYeMGkpcaw5dlzYqA5n6L27WYR3Ur7pADzqFspM1I4+IFsrkH0
         SS6eMU9a3PA9bGdKhnH5MWpxPxlfAVK+ZIE/EH89tBhlvy1Mfm/Qk9HNl89bwfzVXOjH
         3ufYTN/dTBfucp6VEFjHAf7AEKipbNFZDqsNRVzogcsZnd8zlC03U0NbbCbssxH3wKco
         c6AcyeiK/jbG3nyFt1swcT4ormV5otylsnb3rX2Mx3cgasx29cMO2tVEccBcmtfHYz6u
         dm6g==
X-Gm-Message-State: AOJu0YzDjpd8ZutAa1qR7Rs8GZTZuS4nGu6I2B7e1GsLvu86qWDJOYzS
	R/r3bmwbtuD/gzEfqq0ov4Zv/zqVTN2bIX91Hs/RIw9n6+FPp5cAnSaLyVWPBZ67Qhp/iuID0PJ
	T1bYlwFC29zz4
X-Received: by 2002:a17:906:28c:b0:991:b292:699 with SMTP id 12-20020a170906028c00b00991b2920699mr8160746ejf.5.1692723884782;
        Tue, 22 Aug 2023 10:04:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHdAW5cs00hSSc6VELg45Fxbu/aooBU85HmENqNFqL09wSP2lrcb4OOyMQlZyEmPhK51xmY9g==
X-Received: by 2002:a17:906:28c:b0:991:b292:699 with SMTP id 12-20020a170906028c00b00991b2920699mr8160728ejf.5.1692723884472;
        Tue, 22 Aug 2023 10:04:44 -0700 (PDT)
Received: from [192.168.42.222] (83-90-141-187-cable.dk.customer.tdc.net. [83.90.141.187])
        by smtp.gmail.com with ESMTPSA id lt27-20020a170906fa9b00b00992b1c93279sm8474361ejb.110.2023.08.22.10.04.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Aug 2023 10:04:43 -0700 (PDT)
From: Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <b3d2080d-e593-283b-cf97-d39256cfd4e9@redhat.com>
Date: Tue, 22 Aug 2023 19:04:41 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Cc: brouer@redhat.com, bpf@vger.kernel.org, netdev@vger.kernel.org,
 Samuel Dobron <sdobron@redhat.com>, Ondrej Lichtner <olichtne@redhat.com>,
 Rick Alongi <ralongi@redhat.com>
Subject: Re: [PATCH bpf-next 4/6] samples/bpf: Remove the xdp1 and xdp2
 utilities
Content-Language: en-US
To: =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>
References: <20230822142255.1340991-1-toke@redhat.com>
 <20230822142255.1340991-5-toke@redhat.com>
 <721e5240-ab19-507a-c80e-ce5d133c0a9f@kernel.org> <87cyzf9fsp.fsf@toke.dk>
In-Reply-To: <87cyzf9fsp.fsf@toke.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 22/08/2023 18.56, Toke Høiland-Jørgensen wrote:
> Jesper Dangaard Brouer <hawk@kernel.org> writes:
> 
>> On 22/08/2023 16.22, Toke Høiland-Jørgensen wrote:
>>> The functionality of these utilities have been incorporated into the
>>> xdp-bench utility in xdp-tools. Remove the unmaintained versions in
>>> samples.
>>>
>>
>> I think it will be worth our time if we give some examples of how the
>> removed utility translates to some given xdp-bench commands.  There is
>> not a 1-1 mapping.
>>
>> XDP driver changes need to be verified on physical NIC hardware, so
>> these utilities are still being run by QA.  I know Red Hat, Intel and
>> Linaro QA people are using these utilities.  It will save us time if we
>> can reference a commit message instead of repeatable describing this.
>> E.g. for Intel is it often contingent workers that adds a tested-by
>> (that all need to update their knowledge).
> 
> I did think about putting that in the commit message for these, but I
> figured it was too obscure a place to put it, compared to (for instance)
> putting it into the xdp-bench man page.
> 
> If you prefer to have it in the commit message as well, I can respin
> adding it - WDYT?
> 

It is super nice that xdp-bench already have a man page, but I was 
actually looking at this and it was a bit overwhelming (520 lines) 
explaining every possible option.

I really think its worth giving examples in the commit, to ease the 
transition to this new tool.

--Jesper
p.s. man page is generated from the readme [1]:
  [1] 
https://github.com/xdp-project/xdp-tools/blob/master/xdp-bench/README.org


