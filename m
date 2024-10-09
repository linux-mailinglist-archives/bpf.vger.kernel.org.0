Return-Path: <bpf+bounces-41417-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71CC0996FBF
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 17:31:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2200C281A9B
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 15:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC9001E1C27;
	Wed,  9 Oct 2024 15:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OmxXkUaE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEFDF1E1A29;
	Wed,  9 Oct 2024 15:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728487276; cv=none; b=DkibC247Vc7+UgeKuspmwPzlUMWSP3+ZLXFXbWcCfmE8jaVD/Kf7U1ZhsyU3ku6nxWPco7CSHeOQc2Tt/r2ozXLir6pJADug+1r4BQlkp6PXyRB3qMMrIVFx8ccGGaBhTNGKkUkuReaLW5NeLZlVCKnwgU0bxlGdmJeAmDYoEP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728487276; c=relaxed/simple;
	bh=m2EgZEpLKsurnu1KfvL67QdBNjFqJUFkS0WFntfgbc8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hYASa3hmtr2EREY51kZhFg5ZoCGuofYYiwZtB4cZHNnOeU7PPT7M0IB+XZ8WTp6vldqLr1tF0V77yFFkVx3Fe4HS2ydSWAnxPXNxziFWKZN+s5RQS16z+OHecc2P1afgswmKIQy8hU/wlURpkN1nUM0bouwjRulRT9fSxfIDUAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OmxXkUaE; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3a3a309154aso1444865ab.2;
        Wed, 09 Oct 2024 08:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728487273; x=1729092073; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WYFx1+jm9C+kJjx2suHj28i7T4NiuCW9l32ZHsnAVlc=;
        b=OmxXkUaEQpwXbrk4hvEmnGW0oOTwD03rlXbAN/oMU/7g95faPPEdqNWXYIiYMRM0Uc
         TeQVfCwQkPnn4TTdWdeckuQijK01Tqi+zDBrw2fM4M3nkcbWH6A3nTd+TPDVWTOGz2A9
         L4mGG59W5y4YiLgthpzTTmTDbcxDMWZP9VmCDZ14a0pCSgZ54X97yan4/lmoT0rAZGOZ
         Q+jZa8b/Nn2Ow5lx9Yly9P02TmOICSbh9OVixV5nxg2ziUQTpMtcNCeVN5hh//zWoqmn
         9PH8dc7WDjrAUOK28eQzXbw42GN4mNjoKzPl7L6exe+SdBRwLA57nAPvIT2kng8Dw7EJ
         XctA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728487273; x=1729092073;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WYFx1+jm9C+kJjx2suHj28i7T4NiuCW9l32ZHsnAVlc=;
        b=bl4UtB+jHV0z2j+E3KzWGZaB2y9aAu4kNct59GoVdeoxO0eunwgQCrF2Pwh36/aI+C
         Lcdjs+oR4wQS3kzEeMD3p2MnlnzQ9GBIgUbP7fbXUzcLv5C4NAK+uKeg9IpqDirMwX3Y
         4y96FzArb3qHv+VQWsgwLi1pZn3stSCr3aBx5fqPYbnSeGzPuKSKp3Msg8GwCnJhAQRq
         XMxRtGDdDsDYzyXhH5FXbELE77JsbMjaNkQ3rba/1EuHlYpY4dNQqN5mmuGFxn4FYki1
         Ol7/sFOxJvk5k1s5Rok1G8v2U2cz3VdyXjjrqjpDekAFHw7UzU/Wlq8mwUAuCR6eeeUg
         KduQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8skULot/ebTDe1qJqu+UzBKnr/Qe62GIX1Ha6p3V/SNHtGsthceJ96PWzWJMeVfxfvL4=@vger.kernel.org, AJvYcCVGW08l7S16MMQ9akac8F2ZySj2uHi6RdMUxEh3SdSUVZGQgkcu5bG9VDbL2bbUhtr6ojE6ZbjY@vger.kernel.org
X-Gm-Message-State: AOJu0Yxb71cWxIKDsSjGDSJ2yHZaciv0oOThefugV4n/cB9nQYKg6Zw1
	buuzoOGPp7YsmXkFUvGs1C7p4FTVkf2s+WUGoXfkKilCK9QOtf/hdCiPOpP3m5/EvisPRp58g0h
	s3R2htAd97eEvlPJbz+WsgZWgFrU=
X-Google-Smtp-Source: AGHT+IGqh7wvqUpdqQaSWjvgJG5tzZzy+V3FPejiojTGBO9KR1n5PWvk34mxlDmVtK/VU2MMs5zM+SxddhCk2vSBR+U=
X-Received: by 2002:a92:cd87:0:b0:3a0:9aff:5047 with SMTP id
 e9e14a558f8ab-3a397d17aeamr33950885ab.22.1728487272833; Wed, 09 Oct 2024
 08:21:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008095109.99918-1-kerneljasonxing@gmail.com>
 <67057d89796b_1a41992944c@willemb.c.googlers.com.notmuch> <CAL+tcoBGQZWZr3PU4Chn1YiN8XO_2UXGOh3yxbvymvojH3r13g@mail.gmail.com>
 <CAL+tcoC48XCmc3G7Xpb_0=maD1Gi0OLkNbUp4ugwtj69ANPaAw@mail.gmail.com>
 <6b10ed31-c53f-4f99-9c23-e1ba34aa0905@linux.dev> <CAL+tcoBL22WsUbooOv6XXcGGugNyogiDhOpszGR_yj-pCdvCkA@mail.gmail.com>
 <CAL+tcoD47VfZJFPJcQOgPsQuGA=jPfKU2548fJp2NBH14gEoHA@mail.gmail.com>
 <9c5b405c-9b3d-4c1f-b278-303fe24c7926@linux.dev> <CAL+tcoDDmcPQVUMN-AoGFC4SsmRwdVN+q0MAu+gAWY92Xy_zEA@mail.gmail.com>
 <fd159d60-fe59-4bfa-b143-2432671681b5@linux.dev> <CAL+tcoCX4ayowenaT9pBTqGzKQ=pH9BdRPa=1QB2PiJ=+yFxSg@mail.gmail.com>
 <662873cb-a897-464e-bdb3-edf01363c3b2@linux.dev>
In-Reply-To: <662873cb-a897-464e-bdb3-edf01363c3b2@linux.dev>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 9 Oct 2024 23:20:36 +0800
Message-ID: <CAL+tcoAPH=KG9eTYY2KeQh7udeBUyEazG_miTbiwe0Ph0-ssdw@mail.gmail.com>
Subject: Re: [PATCH net-next 0/9] net-timestamp: bpf extension to equip
 applications transparently
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org, 
	willemb@google.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"

> It's more like this:
>
> diff --git a/include/net/sock.h b/include/net/sock.h
> index c58ca8dd561b..93f931dcc4cc 100644
> --- a/include/net/sock.h
> +++ b/include/net/sock.h
> @@ -234,6 +234,14 @@ struct sock_common {
>   struct bpf_local_storage;
>   struct sk_filter;
>
> +enum {
> +       SOCKETOPT_TS_REQUESTOR = 0,
> +       CMSG_TS_REQUESTOR,
> +       BPFPROG_TS_REQUESTOR,
> +
> +       __MAX_TS_REQUESTOR,
> +};
> +
>   /**
>     *    struct sock - network layer representation of sockets
>     *    @__sk_common: shared layout with inet_timewait_sock
> @@ -444,7 +452,7 @@ struct sock {
>          socket_lock_t           sk_lock;
>          u32                     sk_reserved_mem;
>          int                     sk_forward_alloc;
> -       u32                     sk_tsflags;
> +       u32                     sk_tsflags[__MAX_TS_REQUESTOR];
>          __cacheline_group_end(sock_write_rxtx);
>
>          __cacheline_group_begin(sock_write_tx);
>
>
> And use existing SOF_TIMESTAMPING_* for each element in the array. Not
> sure that struct sock is the best place though, as some timestamping
> requests may be on per-packet basis for protocols other than TCP.
>
> Again, I'm just thinking out loud, kinda wild idea.

Thanks. I see.

Requestor or requester? I don't know.

For now, __MAX_TS_REQUESTOR can be two, one is used for the old
implementation, the other one is used for BPF extension.

One irrelevant question is if we need CMSG_TS_REQUESTOR to split the
old tsflags into two because the cmsg relies on sk->sk_tsflags which
works well.

The whole idea is very interesting and inspiring to me! It could be a
good way to go. But as you said, the memory can be a blocker. And
where exactly we should add in struct sock is another problem because
the size of this array could be different if we add more requestors in
the future.

I think I can write in the next version based on this idea
(sk_tsflags[MAX] array has two requestor members at the current stage)
and then seek for other experts' opinions.

+Willem, I'd like to know if you are for or against this idea?

Thanks,
Jason

