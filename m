Return-Path: <bpf+bounces-11667-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E27557BCFFC
	for <lists+bpf@lfdr.de>; Sun,  8 Oct 2023 22:04:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EA2028170C
	for <lists+bpf@lfdr.de>; Sun,  8 Oct 2023 20:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 284B41A59B;
	Sun,  8 Oct 2023 20:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="xWuhtOwH"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B961A58A
	for <bpf@vger.kernel.org>; Sun,  8 Oct 2023 20:04:24 +0000 (UTC)
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70CF7B3
	for <bpf@vger.kernel.org>; Sun,  8 Oct 2023 13:04:22 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-1dd54aca17cso2919328fac.3
        for <bpf@vger.kernel.org>; Sun, 08 Oct 2023 13:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1696795462; x=1697400262; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wk4ID+9Y2woSlIo9KG7KQPxOKMdKteazTwjUAl7uvHc=;
        b=xWuhtOwHbOEuuqEvdG/xCV9PaV7GlwXKl8ia80sSCWwIR1eQ8nEa8acaC37fDPVm3P
         xBlVBOGV5fvR4EQlP3XoZODoJxOQkACGgoXekrFGGi+a6n17NW+H7VUM+6wjgyxWtl9I
         q01PcPZFYO1IOzF0nC3KcPq62/J6zskijRWk020awePtmHjWGfXP0VafiMdqySdp7kpI
         nXuCuVheylTP5Muv+Kyc+rPrYwcG2zE2SFgf+cArebc/FqYL8YAVnotyO9bzvTcnBxWq
         ThxaXHyblTU23DtHjQ9n7Tw2Zw5Fh3KqRJd4/rZ8fYZ/vOZ+usMzF4QQo5RQv6e08v3k
         FQSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696795462; x=1697400262;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wk4ID+9Y2woSlIo9KG7KQPxOKMdKteazTwjUAl7uvHc=;
        b=mE+cWEfpGx0GdQxNs+zlVaXV0HVMevdwXdZ4geAUTseISkfr0bz2c830596E/Bpzm7
         Iv49znve+GmWM1WVWeecUDjjWXsXHSjiT+EQw7/j/T+i7cX+krI7Fm7m7KesC2gbv5NK
         fu/SUGaxLpRPlAAQ2Rzo03A4A7E8/BVII++gL5FQWsqLVsVZgi6cG9ZWqNw+9bexmpjK
         fkgb1+Q+cphkqU3rbdphtRSMr38JQhTS81TIsilKtO76R8gJZDiZlJwESxOqpBHKsnp0
         4vCq+lGkkuapvf/E8xEXx1mtfJsgixxKsxJSJCgUZuDLIcno1CzNMtMLToPZ7VsPboRm
         +y7g==
X-Gm-Message-State: AOJu0Yy7TNP5gJxoot+IBZNrI3/hNOqTjxP5PyK5JYhJe9ccwghJB2zd
	s4JcSOFj9erEA9nLcPYn1NGeDA==
X-Google-Smtp-Source: AGHT+IFvrlaD3FcoyeoteZn8QYo3hLgQzaE/npYrh01teNLQxeArDL4tW+jIm7E9x3F4Eq/sg5G4MA==
X-Received: by 2002:a05:6870:d606:b0:1d6:5649:a88e with SMTP id a6-20020a056870d60600b001d65649a88emr17607839oaq.37.1696795461716;
        Sun, 08 Oct 2023 13:04:21 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:78d2:b862:10a7:d486? ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
        by smtp.gmail.com with ESMTPSA id c16-20020aa78810000000b00690d1269691sm4895954pfo.22.2023.10.08.13.04.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Oct 2023 13:04:21 -0700 (PDT)
Message-ID: <8f4ad5bc-b849-4ef4-ac1f-8d5a796205e9@daynix.com>
Date: Mon, 9 Oct 2023 05:04:14 +0900
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
 decui@microsoft.com, jakub@cloudflare.com, elver@google.com,
 pabeni@redhat.com, Yuri Benditovich <yuri.benditovich@daynix.com>
References: <20231008052101.144422-1-akihiko.odaki@daynix.com>
 <20231008052101.144422-6-akihiko.odaki@daynix.com>
 <CAF=yD-LdwcXKK66s5gvJNOH8qCWRt3SvEL-GkkVif=kkOaYGhg@mail.gmail.com>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CAF=yD-LdwcXKK66s5gvJNOH8qCWRt3SvEL-GkkVif=kkOaYGhg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 2023/10/09 4:07, Willem de Bruijn wrote:
> On Sun, Oct 8, 2023 at 7:22 AM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>
>> virtio-net have two usage of hashes: one is RSS and another is hash
>> reporting. Conventionally the hash calculation was done by the VMM.
>> However, computing the hash after the queue was chosen defeats the
>> purpose of RSS.
>>
>> Another approach is to use eBPF steering program. This approach has
>> another downside: it cannot report the calculated hash due to the
>> restrictive nature of eBPF.
>>
>> Introduce the code to compute hashes to the kernel in order to overcome
>> thse challenges. An alternative solution is to extend the eBPF steering
>> program so that it will be able to report to the userspace, but it makes
>> little sense to allow to implement different hashing algorithms with
>> eBPF since the hash value reported by virtio-net is strictly defined by
>> the specification.
>>
>> The hash value already stored in sk_buff is not used and computed
>> independently since it may have been computed in a way not conformant
>> with the specification.
>>
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>> ---
> 
>> +static const struct tun_vnet_hash_cap tun_vnet_hash_cap = {
>> +       .max_indirection_table_length =
>> +               TUN_VNET_HASH_MAX_INDIRECTION_TABLE_LENGTH,
>> +
>> +       .types = VIRTIO_NET_SUPPORTED_HASH_TYPES
>> +};
> 
> No need to have explicit capabilities exchange like this? Tun either
> supports all or none.

tun does not support VIRTIO_NET_RSS_HASH_TYPE_IP_EX, 
VIRTIO_NET_RSS_HASH_TYPE_TCP_EX, and VIRTIO_NET_RSS_HASH_TYPE_UDP_EX.

It is because the flow dissector does not support IPv6 extensions. The 
specification is also vague, and does not tell how many TLVs should be 
consumed at most when interpreting destination option header so I chose 
to avoid adding code for these hash types to the flow dissector. I doubt 
anyone will complain about it since nobody complains for Linux.

I'm also adding this so that we can extend it later. 
max_indirection_table_length may grow for systems with 128+ CPUs, or 
types may have other bits for new protocols in the future.

> 
>>          case TUNSETSTEERINGEBPF:
>> -               ret = tun_set_ebpf(tun, &tun->steering_prog, argp);
>> +               bpf_ret = tun_set_ebpf(tun, &tun->steering_prog, argp);
>> +               if (IS_ERR(bpf_ret))
>> +                       ret = PTR_ERR(bpf_ret);
>> +               else if (bpf_ret)
>> +                       tun->vnet_hash.flags &= ~TUN_VNET_HASH_RSS;
> 
> Don't make one feature disable another.
> 
> TUNSETSTEERINGEBPF and TUNSETVNETHASH are mutually exclusive
> functions. If one is enabled the other call should fail, with EBUSY
> for instance.
> 
>> +       case TUNSETVNETHASH:
>> +               len = sizeof(vnet_hash);
>> +               if (copy_from_user(&vnet_hash, argp, len)) {
>> +                       ret = -EFAULT;
>> +                       break;
>> +               }
>> +
>> +               if (((vnet_hash.flags & TUN_VNET_HASH_REPORT) &&
>> +                    (tun->vnet_hdr_sz < sizeof(struct virtio_net_hdr_v1_hash) ||
>> +                     !tun_is_little_endian(tun))) ||
>> +                    vnet_hash.indirection_table_mask >=
>> +                    TUN_VNET_HASH_MAX_INDIRECTION_TABLE_LENGTH) {
>> +                       ret = -EINVAL;
>> +                       break;
>> +               }
>> +
>> +               argp = (u8 __user *)argp + len;
>> +               len = (vnet_hash.indirection_table_mask + 1) * 2;
>> +               if (copy_from_user(vnet_hash_indirection_table, argp, len)) {
>> +                       ret = -EFAULT;
>> +                       break;
>> +               }
>> +
>> +               argp = (u8 __user *)argp + len;
>> +               len = virtio_net_hash_key_length(vnet_hash.types);
>> +
>> +               if (copy_from_user(vnet_hash_key, argp, len)) {
>> +                       ret = -EFAULT;
>> +                       break;
>> +               }
> 
> Probably easier and less error-prone to define a fixed size control
> struct with the max indirection table size.

I made its size variable because the indirection table and key may grow 
in the future as I wrote above.

> 
> Btw: please trim the CC: list considerably on future patches.

I'll do so in the next version with the TUNSETSTEERINGEBPF change you 
proposed.

