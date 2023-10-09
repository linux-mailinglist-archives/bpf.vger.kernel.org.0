Return-Path: <bpf+bounces-11692-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E95417BD7EF
	for <lists+bpf@lfdr.de>; Mon,  9 Oct 2023 12:05:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 997B1281877
	for <lists+bpf@lfdr.de>; Mon,  9 Oct 2023 10:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 871E9179B6;
	Mon,  9 Oct 2023 10:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="BK+39T5y"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69BDA156D3
	for <bpf@vger.kernel.org>; Mon,  9 Oct 2023 10:05:28 +0000 (UTC)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44DCA9F
	for <bpf@vger.kernel.org>; Mon,  9 Oct 2023 03:05:25 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id 5614622812f47-3ae5ce4a4ceso3166092b6e.1
        for <bpf@vger.kernel.org>; Mon, 09 Oct 2023 03:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1696845924; x=1697450724; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tU1LzqCUZS3h8pX7+UKm34RoTSScep7fx/DPCoe38tw=;
        b=BK+39T5yy4phl4G/9d9cDalQbZaRXrtX8+wNINltCQsBkDF9Fzsv1q107gGFyDbnBA
         TVXlTSPK0Ho+HJq6gd2YstKKmMM5U6QoGoBAX3oANf7yPA4drbmoVdAR2inQVpsCMxAV
         lQfzI9TgHAAOsTCRuhJkms+ODpex6oLKMdhVJRwd7D4YD1BDJyFDimMLjJnkKz25dJSr
         /jSVY3eQczLNFIT1IFI6t/oEKExn3oXv7IpFsmvPypbqMlYT0QSc+Rec5A2uqqdzHA5m
         mb2G+5hY3w3WGdacxUbq4PbDsxGBSPmyXSy2BiKjCEoyND87o7wMlDfspTDvitAfb7E8
         XrcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696845924; x=1697450724;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tU1LzqCUZS3h8pX7+UKm34RoTSScep7fx/DPCoe38tw=;
        b=w0Sgbwks6KlzwEYD4nPnBxIkgXi95bQDjxQ1+PymV1n16+yq0UUd7QXxE1uj2NT4VR
         ugoAfTwD2maU/PPqY+sPvqH2Y+6wC0uI5C+qknmZApzZGUusB/4W9yqtuYLPdoJWLa8F
         tj/B09m+nkmXOQphNcBlOnZrAwC6ub/0bnOXj4am1Zm6Su5tEWnXtu6SVXOM2FXAaOkP
         OAyAUllaDAzW4H5TUghfh0lOGlf6d3PKHCp8oF1l7vOFv8L6CxuQdwYfp55moR3DUNVP
         5zeVGDY7SpQdlNvZLgubghv1nhbrfrbz9HBTUVWyGN9mkQf8DbvS67tBdRbZw4Hyhzd8
         kLng==
X-Gm-Message-State: AOJu0YyPHyLLiaiFTFuzOmvXFQDa9p9+t98O4Qow/MS9BFOD6I04oapb
	j8R6lr+6mlN9WxOM5Ggb8EoUkQ==
X-Google-Smtp-Source: AGHT+IF4H0eU7CwZ4mrgQw3oNKjHU7YW8wcOMrp8fQqVCgy+nOlf1B9uoA+rslI3PUuYyMWBGQ6e4w==
X-Received: by 2002:a05:6808:2a43:b0:3a0:41d4:b144 with SMTP id fa3-20020a0568082a4300b003a041d4b144mr13646173oib.1.1696845924629;
        Mon, 09 Oct 2023 03:05:24 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:78d2:b862:10a7:d486? ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
        by smtp.gmail.com with ESMTPSA id c6-20020a633506000000b0058579ef9577sm7860030pga.79.2023.10.09.03.05.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Oct 2023 03:05:24 -0700 (PDT)
Message-ID: <6a698c99-6f02-4cfb-a709-ba02296a05f7@daynix.com>
Date: Mon, 9 Oct 2023 19:05:17 +0900
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 5/7] tun: Introduce virtio-net hashing feature
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
 <20231008052101.144422-6-akihiko.odaki@daynix.com>
 <CAF=yD-K2MQt4nnfwJrx6h6Nii_rho7j1o6nb_jYaSwcWY45pPw@mail.gmail.com>
 <48e20be1-b658-4117-8856-89ff1df6f48f@daynix.com>
 <CAF=yD-K4bCBpUVtDR_cv=bagRL+vM4Rusez+uHFTb4_kR8XkpA@mail.gmail.com>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CAF=yD-K4bCBpUVtDR_cv=bagRL+vM4Rusez+uHFTb4_kR8XkpA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 2023/10/09 18:54, Willem de Bruijn wrote:
> On Mon, Oct 9, 2023 at 3:44 AM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>
>> On 2023/10/09 17:13, Willem de Bruijn wrote:
>>> On Sun, Oct 8, 2023 at 12:22 AM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>>>
>>>> virtio-net have two usage of hashes: one is RSS and another is hash
>>>> reporting. Conventionally the hash calculation was done by the VMM.
>>>> However, computing the hash after the queue was chosen defeats the
>>>> purpose of RSS.
>>>>
>>>> Another approach is to use eBPF steering program. This approach has
>>>> another downside: it cannot report the calculated hash due to the
>>>> restrictive nature of eBPF.
>>>>
>>>> Introduce the code to compute hashes to the kernel in order to overcome
>>>> thse challenges. An alternative solution is to extend the eBPF steering
>>>> program so that it will be able to report to the userspace, but it makes
>>>> little sense to allow to implement different hashing algorithms with
>>>> eBPF since the hash value reported by virtio-net is strictly defined by
>>>> the specification.
>>>>
>>>> The hash value already stored in sk_buff is not used and computed
>>>> independently since it may have been computed in a way not conformant
>>>> with the specification.
>>>>
>>>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>>>
>>>> @@ -2116,31 +2172,49 @@ static ssize_t tun_put_user(struct tun_struct *tun,
>>>>           }
>>>>
>>>>           if (vnet_hdr_sz) {
>>>> -               struct virtio_net_hdr gso;
>>>> +               union {
>>>> +                       struct virtio_net_hdr hdr;
>>>> +                       struct virtio_net_hdr_v1_hash v1_hash_hdr;
>>>> +               } hdr;
>>>> +               int ret;
>>>>
>>>>                   if (iov_iter_count(iter) < vnet_hdr_sz)
>>>>                           return -EINVAL;
>>>>
>>>> -               if (virtio_net_hdr_from_skb(skb, &gso,
>>>> -                                           tun_is_little_endian(tun), true,
>>>> -                                           vlan_hlen)) {
>>>> +               if ((READ_ONCE(tun->vnet_hash.flags) & TUN_VNET_HASH_REPORT) &&
>>>> +                   vnet_hdr_sz >= sizeof(hdr.v1_hash_hdr) &&
>>>> +                   skb->tun_vnet_hash) {
>>>
>>> Isn't vnet_hdr_sz guaranteed to be >= hdr.v1_hash_hdr, by virtue of
>>> the set hash ioctl failing otherwise?
>>>
>>> Such checks should be limited to control path where possible
>>
>> There is a potential race since tun->vnet_hash.flags and vnet_hdr_sz are
>> not read at once.
> 
> It should not be possible to downgrade the hdr_sz once v1 is selected.

I see nothing that prevents shrinking the header size.

tun->vnet_hash.flags is read after vnet_hdr_sz so the race can happen 
even for the case the header size grows though this can be fixed by 
reordering the two reads.

