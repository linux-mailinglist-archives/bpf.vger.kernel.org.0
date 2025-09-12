Return-Path: <bpf+bounces-68277-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A6B9B559B2
	for <lists+bpf@lfdr.de>; Sat, 13 Sep 2025 00:47:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A8711D61E84
	for <lists+bpf@lfdr.de>; Fri, 12 Sep 2025 22:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D86D261B71;
	Fri, 12 Sep 2025 22:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XVsU0TVh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166852DC789
	for <bpf@vger.kernel.org>; Fri, 12 Sep 2025 22:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757717231; cv=none; b=BxsNLet7BkHNxF3a2iIwYcDaXGEgbKsuZgjsdYW0GJOB0MKsM1InAWu+CA7i9tMppTS04dwbO69JB6fNftBLezUyikBVm8olKo20i//NFy2j/WmWjbbkT71qThvzCYJwbWVDc1NhzmZznskkjF16nmZpcfwltc0RNah2lHKl/JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757717231; c=relaxed/simple;
	bh=9pMsaDDGP7ICjYGAty/aA8pf1xFXH8i9ABuPk5ju5eY=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=VaU2hdI02ftYRuXsDOxsbeTh7GKoNG42q81tMI9pMlRqP42t0yiQ17CyzIF0fSR8CEb1IFCp6BWxOevj75Q7+LSxlyFrVyNVsoTUb4JKgBAYJKFzKa6zqi4pwOWApAn/hrGYO6iOiJMymSaaGOleAzJXZXNIJwlig6oeUhAl7A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XVsU0TVh; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-7251e6b2f9eso13730086d6.1
        for <bpf@vger.kernel.org>; Fri, 12 Sep 2025 15:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757717229; x=1758322029; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NJ/pl+f3thiBMb4Cv5ZWKExz21u3qyu2oVy+k1eNuog=;
        b=XVsU0TVh3rYg4ton9HkB1oGGarFMQoGGYdexw64csLIXbKUXYl1c1yq9VPL6dfhXET
         6dQtjH0Q4Jp68nctS5NZnWp24EiTBRfRdOCaITMD0dKuYtvnUKUbRiA/3KmvFQIbAWKJ
         1dJKlavjN0wkw+fToJVVCQ1GR2RNFJIyvvN8UXn8pJ//2EFa3/m2DQVO3VLmbJMtC9Oc
         ELsbeIBIqgjVy2WPiSISCeDCS130WSWpZGNmmO6sBD1ehsBBlOjIt6x08bnY3pnmpG4Q
         bwC6VFY7DO6IYPEQ81XrlyksDh7P6vqNbSa1qmZ7GQi5AhSXwEC5PmGHx5X2lOoC+b02
         kC4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757717229; x=1758322029;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NJ/pl+f3thiBMb4Cv5ZWKExz21u3qyu2oVy+k1eNuog=;
        b=HjFxLN9nTj4kHf0YMHAOV32BymNc+tRc0UMEV3NHMw0DfeTlxfDGRX0/6TEOU4Y3ov
         g9KxChsrtOK/KUSVIaBA8fki/GeF1dB/IIORbBlMHm5gFFac5pUQyPtCDodHatS+x3BO
         Qm8FVkWvvD0zVh53GnGcwrdJZDMQKSIvMPwv5ccQdVhMDlw8hZGCtj0OJIGvmDDWLjIQ
         jS7fBBgubF0ZhfGFFpD024VSJfo3xgOFdXUjifeprJ5qwpPuJW/tys5thsYK3vLvbvaF
         p18/7F63Qb3Sfy3wlWarZAYT14Z6oreS5sZQtqcFqap9nL/xFjVqOE6T6GsSCaGsDEJI
         MrUQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2zMrsojyX8P+qAsaHuRqDoEJ5e4r7lwrW+1G4dHz/H9c3YouqbHkMSQqq//BrR2enuAo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZz32iTQD7vG2E0Yqkkk+WeXg0eRkM/W0QWZsk6ce7uymLDWju
	r2r6lGwepWm4lusSYkJhdrUragKVz/L2WzWFP1Lvn7wNL6DfhzdAJip2W2jCSw==
X-Gm-Gg: ASbGncsGqdKtAjFw2ur5Bg8DA1LQ4hQWhW+hcuK/HALSyKiLJCGe+z80NjbET6bX7M4
	dzw76+t/lwmwUXp4IsegfnPukghH2eH5C1jpoR+HdHU/ahE1ltXEUa3Ri+oAvupkCRAmKhINGal
	QKRcidxfUSbn7FOvDNSHrnmQhX70eLb9R/SGJhwZrAoxE1vurwnR2JToqr1FsfV+jdHt39j8HV6
	S+t5NugP5NOxwWx8Zo7SCJBF631+eBrAZM3GKrwAnPDFJbuQB7tEpWvlwcFH7Au4KH3IRbcHuWr
	7ueJ7iROkGH2SnKWogPTjI5c7CtL7xOKdm0QkH9qLO6Wn3NbbKKpQ3mD//SY+W+opX3DyAzQamE
	98/HlXeJyoBzpjXfdjM/wRfAfTwiy3W4mnLsLl9S90LLSUrvnVAZYeSTyg0ylvJKNl+M8itdiiA
	i+UsY5RiPf8Wsu
X-Google-Smtp-Source: AGHT+IHeSCuf2aaELxMVnROZkC4BFrna2zlrWNPJtf03Ug/WdV73lPsgYOHakOnfQfcP1ZG0uyn0NQ==
X-Received: by 2002:a05:6214:1310:b0:70f:5a6d:a253 with SMTP id 6a1803df08f44-767c4012078mr58868856d6.49.1757717228884;
        Fri, 12 Sep 2025 15:47:08 -0700 (PDT)
Received: from gmail.com (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-763c0c64a86sm34312096d6.68.2025.09.12.15.47.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 15:47:08 -0700 (PDT)
Date: Fri, 12 Sep 2025 18:47:08 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Stanislav Fomichev <stfomichev@gmail.com>, 
 =?UTF-8?B?VG9iaWFzIELDtmht?= <tobias.boehm@hetzner-cloud.de>
Cc: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 bpf@vger.kernel.org, 
 Marcus Wichelmann <marcus.wichelmann@hetzner-cloud.de>, 
 netdev@vger.kernel.org, 
 willemdebruijn.kernel@gmail.com, 
 william.xuanziyang@huawei.com
Message-ID: <willemdebruijn.kernel.38eb3bd85943@gmail.com>
In-Reply-To: <aMSCm_t9g0WSyB8k@mini-arch>
References: <4bfab93d-f1ce-4aa7-82fe-16972b47972c@hetzner-cloud.de>
 <aMSCm_t9g0WSyB8k@mini-arch>
Subject: Re: [BUG?] bpf_skb_net_shrink does not unset encapsulation flag
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Stanislav Fomichev wrote:
> On 09/10, Tobias B=C3=B6hm wrote:
> > Hi,
> > =

> > when decapsulating VXLAN packets with bpf_skb_adjust_room and redirec=
ting to
> > a tap device I observed unexpected segmentation.
> > =

> > In my setup there is a sched_cls program attached at the ingress path=
 of a
> > physical NIC with GRO enabled. Packets are redirected either directly=
 for
> > plain traffic, or decapsulated beforehand in case of VXLAN. Decapsula=
tion is
> > done by bpf_skb_adjust_room with BPF_F_ADJ_ROOM_DECAP_L3_IPV4.
> > =

> > For both kinds of traffic GRO on the physical NIC works as expected
> > resulting in merged packets.
> > =

> > Large non-decapsulated packets are transmitted directly on the tap in=
terface
> > as expected. But surprisingly, decapsulated packets are being segment=
ed
> > again before transmission.
> > =

> > When analyzing and comparing the call chains I observed that
> > netif_skb_features returns different values for the different kind of=

> > traffic.
> > =

> > The tap devices have the following features set:
> > =

> >     dev->features        =3D   0x1558c9
> >     dev->hw_enc_features =3D 0x10000001
> > =

> > For the non-decapsulated traffic netif_skb_features returns 0x1558c9 =
but for
> > the decapsulated traffic it returns 0x1. This is same value as the re=
sult of
> > "dev->features & dev->hw_enc_features".
> > =

> > In netif_skb_features this operation effectively happens in case
> > skb->encapsulation is set. Inspecting the skb in both cases showed th=
at in
> > case of decapsulation the skb->encapsulation flag was indeed still se=
t.
> > =

> > I wonder if there is a reason that the skb->encapsulation flag is not=
 unset
> > in bpf_skb_net_shrink when BPF_F_ADJ_ROOM_DECAP_* flags are present? =
Since
> > skb->encapsulation is set in bpf_skb_net_grow when adding space for
> > encapsulation my expectation would be that the flag is also unset whe=
n doing
> > the opposite operation.
> =

> + Willem and netdev for visibility.

I think it just has not been implemented before.

The encap path is more strict. Besides setting skb->encapsulation, it
also initializes the inner_.. helpers.

The decap path does not do this, it expects IPIP packets to arrive
from the network, without the stack detecting them as such or
setting skb->encapsulation.

We must preserve that behavior. But we additionally can detect skbs
with encapsulation fields configured, and convert those.

The encap path also explicit UDP_L4 and GRE flags to update GSO
packets. For VXLAN decap, we probably need the same?



