Return-Path: <bpf+bounces-11666-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D11857BCFE8
	for <lists+bpf@lfdr.de>; Sun,  8 Oct 2023 21:53:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0DCC28198B
	for <lists+bpf@lfdr.de>; Sun,  8 Oct 2023 19:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D906F18652;
	Sun,  8 Oct 2023 19:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="mCLHaxE2"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D324F12B96
	for <bpf@vger.kernel.org>; Sun,  8 Oct 2023 19:53:07 +0000 (UTC)
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBDACAC
	for <bpf@vger.kernel.org>; Sun,  8 Oct 2023 12:53:05 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-51b4ef5378bso3126502a12.1
        for <bpf@vger.kernel.org>; Sun, 08 Oct 2023 12:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1696794785; x=1697399585; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6Uv8Y0M++mQixpZTlMb33uLQAMyKnaxhqJJACDwT/pw=;
        b=mCLHaxE2ab2ajnYex38vNuN9AqistHyuK55N+d2WFakQm4bQwtCj5vtbSlnWTHil0S
         FSoCAg9MWDQXzqIv7DEAbW6EEPNAaywyg/7rNr+X8LQ30qnVqDyK2nKRthZTmFVEjRFy
         nLsCkTE/KYjP9jQIK35L0TLJcLuzMGSXeHtIgnS4dlWS4g6OcrOt0pJ4q0IeIRxEwTJh
         yiA9B9BNVAtbZhhttbtNxbIvg+HCtsyk3evAF97CBPINAnTIq4kmosPzi4ihkpJ4+hYK
         h2t39+pP89217lvzM1maGc/vnQ4QWKypF5EkVXBE4l7NGlFqgvBtBoDYRJlBQsaDHKDO
         OZWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696794785; x=1697399585;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6Uv8Y0M++mQixpZTlMb33uLQAMyKnaxhqJJACDwT/pw=;
        b=UxXRKzC9LdLabFfokOockt0IN2JeAPrQe7MN3aaWCB3G1bqd4Okxcyisy6EB6YlhXM
         vz+4NRoNEqJ4uAGrxD8sE54DJEKEOIlR+G07GAFNQF3FDSj4vioGKjhZDFUp9gLIFjzE
         Wvq3IG3DNePvx0LQ9VKusQO0amoFsb3+vLs2+omBYtUeBzgWywg+iR/jgKxV8avi/Bid
         h62r8hko+p6+TnyRtli/n/RaNQ0jaKBiyMaq59RHeShMIcAk7eMLE2WHzNU3b9n7iSeU
         flvWf+e9yzuA8MXW+YSc9H5inG4LreWoLZv6u7ab4LvsPaaMoDpOseDTeRlxAQzCmFk7
         ipiQ==
X-Gm-Message-State: AOJu0Yw33oSFCUkJMGPmo2zkbF1mXTOdrP8oLwh7r5RI1jGruYzskMKn
	kxTmfY7mI7D6JsYkVzXjH0gZBw==
X-Google-Smtp-Source: AGHT+IHmvYqxiZYxvjOaXv1owmEpRG5mjS+edfQG0QgyP3o61v9y0A2CZuxDZy4/qGKtNUW7lwQ4rA==
X-Received: by 2002:a17:90b:4f8c:b0:26f:f272:144c with SMTP id qe12-20020a17090b4f8c00b0026ff272144cmr11640942pjb.27.1696794785181;
        Sun, 08 Oct 2023 12:53:05 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:78d2:b862:10a7:d486? ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
        by smtp.gmail.com with ESMTPSA id j5-20020a17090aeb0500b0026f90d7947csm6736541pjz.34.2023.10.08.12.52.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Oct 2023 12:53:04 -0700 (PDT)
Message-ID: <4f2ce89f-a018-4a43-97b6-e9d43020e158@daynix.com>
Date: Mon, 9 Oct 2023 04:52:56 +0900
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/7] net: skbuff: Add tun_vnet_hash flag
Content-Language: en-US
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-kselftest@vger.kernel.org,
 bpf@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, kafai@fb.com,
 songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com,
 kpsingh@kernel.org, rdunlap@infradead.org, willemb@google.com,
 gustavoars@kernel.org, herbert@gondor.apana.org.au,
 steffen.klassert@secunet.com, nogikh@google.com, pablo@netfilter.org,
 decui@microsoft.com, cai@lca.pw, jakub@cloudflare.com, elver@google.com,
 pabeni@redhat.com, Yuri Benditovich <yuri.benditovich@daynix.com>
References: <20231008052101.144422-1-akihiko.odaki@daynix.com>
 <20231008052101.144422-2-akihiko.odaki@daynix.com>
 <CAF=yD-K0RR5XCuPdHS8gPwppM-HAmodSOVBpS=v+j8X7=Su2Rg@mail.gmail.com>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CAF=yD-K0RR5XCuPdHS8gPwppM-HAmodSOVBpS=v+j8X7=Su2Rg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 2023/10/09 3:39, Willem de Bruijn wrote:
> On Sun, Oct 8, 2023 at 7:22 AM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>
>> tun_vnet_hash can use this flag to indicate it stored virtio-net hash
>> cache to cb.
>>
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>> ---
>>   include/linux/skbuff.h | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
>> index 4174c4b82d13..e638f157c13c 100644
>> --- a/include/linux/skbuff.h
>> +++ b/include/linux/skbuff.h
>> @@ -837,6 +837,7 @@ typedef unsigned char *sk_buff_data_t;
>>    *     @truesize: Buffer size
>>    *     @users: User count - see {datagram,tcp}.c
>>    *     @extensions: allocated extensions, valid if active_extensions is nonzero
>> + *     @tun_vnet_hash: tun stored virtio-net hash cache to cb
>>    */
>>
>>   struct sk_buff {
>> @@ -989,6 +990,7 @@ struct sk_buff {
>>   #if IS_ENABLED(CONFIG_IP_SCTP)
>>          __u8                    csum_not_inet:1;
>>   #endif
>> +       __u8                    tun_vnet_hash:1;
> 
> sk_buff space is very limited.
> 
> No need to extend it, especially for code that stays within a single
> subsystem (tun).
> 
> To a lesser extent the same point applies to the qdisc_skb_cb.

I had to extend sk_buff because it does not stay in tun but moves back 
and forth between qdisc and tun.

The new members of sk_buff and qdisc_skb_cb are stored by tun's 
ndo_select_queue(). The control will go back to qdisc after 
ndo_select_queue() function finishes. Eventually tun's ndo_start_xmit() 
will be called by qdisc and consumes the stored members. qdisc is 
required to keep the stored members intact.

tun_vnet_hash is a bit special. It is put into sk_buff because 
ndo_select_queue() is not always called and it may be left 
uninitialized. ndo_start_xmit() may read some garbage from cb's old user 
if it is put into cb.

