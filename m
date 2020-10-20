Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B9872941EA
	for <lists+bpf@lfdr.de>; Tue, 20 Oct 2020 20:08:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408954AbgJTSIb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 20 Oct 2020 14:08:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:56169 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387945AbgJTSI3 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 20 Oct 2020 14:08:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603217308;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tYbzd59+8jONE13NYNfdI5cI4F2XnnmBUm6WJUpf2+Y=;
        b=EmYCXprDsyapFv2tqTwqfP2Zj8jdEgX4HvF6wZdnFLBzTlUb27m63XxGfGh2OA0muEZSfY
        7j6IhrObeODREUdNRq2TI+LZCIGgpxklfKAXgKx5+AnPm5+l4AajO8/FwFguW5Su/p5d8R
        v7Gw/I4L+FPI8lCiWA0PLFytd7M0Tdc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-262-1iS1aLxvMC6u4ls0xQbPcg-1; Tue, 20 Oct 2020 14:08:25 -0400
X-MC-Unique: 1iS1aLxvMC6u4ls0xQbPcg-1
Received: by mail-wm1-f69.google.com with SMTP id u207so737557wmu.4
        for <bpf@vger.kernel.org>; Tue, 20 Oct 2020 11:08:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=tYbzd59+8jONE13NYNfdI5cI4F2XnnmBUm6WJUpf2+Y=;
        b=PWb1uXsoeG4//1BwVoQIN+TDYoI8pKoOtTQsC/MSAQ5HnU+Pbf8JoA5t1JWRtvs1E6
         aa8aZrrTk26wdxVCfH3e2VdDp35ujOdM60E6lWsaaFNR/QuhWyJbtdUhOgKc6AFW1Pfs
         Lt4MC/Ue8WObe+CZx1a/rQRfi6nI3kvhnbWRb7Du+5RW2zVZpFCbNOH6n17rp5mJl8iu
         Dtd5yqCwUzEDym0szYqvHNMpsEL3Of8VXmoScHO44rVE57JnMDNQ8Q8qk8w4Khpzd19g
         Otv2v/vEclLGV5Qf/MEwPh22KsTL5fpXCRhMDMhlv5hO4hMdoDfLBPX6gcyXR7vuWxz6
         T17Q==
X-Gm-Message-State: AOAM530Q/quWAaup0UHGPskELF2IHz+9TJQQdENZOCKOzm0qG12CVnq0
        XdDKxh9HwkqqsYUmOlJYY1Lg9qOEnMVEAfH0rwu4hGA1wbeymJDkOLj/uH8Jd8i8YV9sKUxRxYp
        PFVuhkEh4DbHr
X-Received: by 2002:a1c:111:: with SMTP id 17mr4108853wmb.126.1603217303472;
        Tue, 20 Oct 2020 11:08:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxa63yJUlYyrfh0gQEOGZzuXPBWt8Hvi3B9kOjcKh2ifmZqEME33JbT8bSoi85kfyilhjgH6w==
X-Received: by 2002:a1c:111:: with SMTP id 17mr4108817wmb.126.1603217302918;
        Tue, 20 Oct 2020 11:08:22 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 24sm3699630wmg.8.2020.10.20.11.08.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2020 11:08:22 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id DD5DA1838FA; Tue, 20 Oct 2020 20:08:21 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: Re: [PATCH bpf v2 1/3] bpf_redirect_neigh: Support supplying the
 nexthop as a helper parameter
In-Reply-To: <d6967cfe-fd0e-268a-5526-dd03f0e476e6@iogearbox.net>
References: <160319106111.15822.18417665895694986295.stgit@toke.dk>
 <160319106221.15822.2629789706666194966.stgit@toke.dk>
 <d6967cfe-fd0e-268a-5526-dd03f0e476e6@iogearbox.net>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 20 Oct 2020 20:08:21 +0200
Message-ID: <87tuuo22ju.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Daniel Borkmann <daniel@iogearbox.net> writes:

> On 10/20/20 12:51 PM, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> From: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> [...]
>>   BPF_CALL_3(bpf_clone_redirect, struct sk_buff *, skb, u32, ifindex, u6=
4, flags)
>> @@ -2455,8 +2487,8 @@ int skb_do_redirect(struct sk_buff *skb)
>>   		return -EAGAIN;
>>   	}
>>   	return flags & BPF_F_NEIGH ?
>> -	       __bpf_redirect_neigh(skb, dev) :
>> -	       __bpf_redirect(skb, dev, flags);
>> +		__bpf_redirect_neigh(skb, dev, flags & BPF_F_NEXTHOP ? &ri->nh : NULL=
) :
>> +		__bpf_redirect(skb, dev, flags);
>>   out_drop:
>>   	kfree_skb(skb);
>>   	return -EINVAL;
>> @@ -2504,16 +2536,25 @@ static const struct bpf_func_proto bpf_redirect_=
peer_proto =3D {
>>   	.arg2_type      =3D ARG_ANYTHING,
>>   };
>>=20=20=20
>> -BPF_CALL_2(bpf_redirect_neigh, u32, ifindex, u64, flags)
>> +BPF_CALL_4(bpf_redirect_neigh, u32, ifindex, struct bpf_redir_neigh *, =
params,
>> +	   int, plen, u64, flags)
>>   {
>>   	struct bpf_redirect_info *ri =3D this_cpu_ptr(&bpf_redirect_info);
>>=20=20=20
>> -	if (unlikely(flags))
>> +	if (unlikely((plen && plen < sizeof(*params)) || flags))
>> +		return TC_ACT_SHOT;
>> +
>> +	if (unlikely(plen && (params->unused[0] || params->unused[1] ||
>> +			      params->unused[2])))
>
> small nit: maybe fold this into the prior check that already tests non-ze=
ro plen
>
> if (unlikely((plen && (plen < sizeof(*params) ||
>                         (params->unused[0] | params->unused[1] |
>                          params->unused[2]))) || flags))
>          return TC_ACT_SHOT;

Well that was my first thought as well, but I thought it was uglier.
Isn't the compiler smart enough to make those two equivalent?

Anyway, given Jakub's comment, I guess this is moot anyway, as we should
just get rid of the member, no?

-Toke

