Return-Path: <bpf+bounces-42764-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D0399A9D64
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 10:49:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D2CE2831ED
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 08:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCAF018BBA9;
	Tue, 22 Oct 2024 08:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="esX4O3Bt"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f196.google.com (mail-yb1-f196.google.com [209.85.219.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE6CE1714BA;
	Tue, 22 Oct 2024 08:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729586934; cv=none; b=m89aAzwdZgwRhZHm3AkMO05WHuCDjyGE6Qs7bwF60yxJ/aInkOJ34XlmDOoKsunLNzXAzA8vpZ9zalkSgVKtjytf/ZbBlDrP/LL83do7ryiy5QQAq5pF8GwU/8ZVk3Cy26pHjPVPkzbXoIXWugQ3TWrjgm3x67g7kOoZO5OIe80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729586934; c=relaxed/simple;
	bh=BrXgG3mZIvjp5VteprPhQXe2uhCHZoadbc1SbaYA3JE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j5PxKQXMrBwvrEM2ppwNbsLsD0dUx4Sz/UxGpmPODIlaA3SOOmrDvXARORSIuoqshlyVmXO0gkltZg5YjnAy67f3YvpKOOMnGxjILipuN1LwOU84oa6pa6pcypT/dAmSxyv8IRKlvfVLPY62uNmD4qAuSYo7OC1bsP7W3JqWjXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=esX4O3Bt; arc=none smtp.client-ip=209.85.219.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f196.google.com with SMTP id 3f1490d57ef6-e2915f00c12so4960197276.0;
        Tue, 22 Oct 2024 01:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729586932; x=1730191732; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rdf6iyxgoydO05+DI1ZE9WtsllUDQOZhnJERRHa/4XU=;
        b=esX4O3BtFQAAv2nMcR6wcg0WGcIi8IXQKmB7gvTtDY3PDSEO+bftDJIS+56IOJmq3V
         38/07frhXenK1kIJKojNktsroe1hKP0eJceU97j4Qr3eAou/dJ8KqtmFjv+3ApO1uxSA
         d5qIKQMeTHZChWX4iD95vyK75zqGO7dQv9aM6OppcaCF0B1kZfVSsVGn1B/PesHGBaeK
         D0z3FiGhm6jmwsbTi1YFbX3roV/NIl9Ks0hJo1966rAspINE0/vP1n9+MSMfqD2oyiVN
         9illVP+tSGNG9YuNMG7/IehlXkS0UeVvGtkpgyvuPUFgiBJrAYWtX8KSxI1f8f+fRD+L
         +g5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729586932; x=1730191732;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rdf6iyxgoydO05+DI1ZE9WtsllUDQOZhnJERRHa/4XU=;
        b=uNy+HW+dERcHu5dJo9w07xtnTIjyLWB06Ok0d7UyMvaXQ6xf9eI6Yyn84QoGt2/fb/
         gdj/ZwZX3WYGO2SWSqjeTMjUnj9kCKTb6JFhQ4zxw6ulwqldFjiQ7MXm+yh94EQ4Q2T+
         Cnaa/2RFhZA/68fC2lxyxrbL4S1SNH97oDfTrup0cIGth4KbsoE0YfeS0DV8ubxU0LYR
         vMHcDRGIG1doAIMJXMVz7qCf3TAiQjMJA5X3nJ2KhhxRYR64t988gjc8jAzynQFysn+2
         J3Z/GnuQcfly2UgTwxzwkkSWxsTwkl8OqOO/dnLmyFLF+P9kKW+limTsLYBpErqcwZuZ
         3JBw==
X-Forwarded-Encrypted: i=1; AJvYcCUd0xgSjIb6ih+E6+tA78Pi08YMzWuG6ioo3LYZAo7e6HOECWUlAeQD7E8mndBA/3MY8OeJwMVyuNwSgPIh4bMe@vger.kernel.org, AJvYcCVIuEOOAKdu1lENLJBO9/T72oq7g55UmP5hyzldPbeZ2fcNg6KNEDvYMaS/Fkwhy62vHsigQ9OS@vger.kernel.org, AJvYcCXlVijp6BZ/Q1YjLk3b6MwteFcbQtl3S7FHqg+Gy2Umgs1Qqpul/VH64lWxjQH7Tkrotx8=@vger.kernel.org, AJvYcCXtv7J+oPwnAjHdfbzPmtQfOl5ZlTgBlRgDH9rk9GRhQGlWfKhKoomg5q30a+UZKCIx0HGZd+eGiyTrLMa6@vger.kernel.org
X-Gm-Message-State: AOJu0YzMeW1VcRl4Nmm4sq6mlE2FHFqbD5ksYXQxPYBm0nhpuKjnmefo
	Zh8B/6FZAacXTDPZ4BVnfst2DRRv6Ag5KpzxFRRnzdAYBSwPX1jhTPbiuddGaOMb3IO4UFA7aIy
	xv3j4GP+Bk5x6QE0AUe5J6Bs7YYU=
X-Google-Smtp-Source: AGHT+IHPESBrda0KhCPYYllg4/MfLv0BjYbIDe6VspItnYGPEClLzmjPWeiQXptBhW3wuVXNgYoCrmc2BBLEkUbKEUE=
X-Received: by 2002:a05:690c:f91:b0:6de:c0e:20ef with SMTP id
 00721157ae682-6e5bfbdbe14mr128141717b3.7.1729586931792; Tue, 22 Oct 2024
 01:48:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241015140800.159466-1-dongml2@chinatelecom.cn>
 <20241015140800.159466-8-dongml2@chinatelecom.cn> <c6e8f053-32bb-4ebd-871b-af416d0b0531@redhat.com>
 <f792a828-8a61-4a14-bef8-ff318b5a4ac3@redhat.com>
In-Reply-To: <f792a828-8a61-4a14-bef8-ff318b5a4ac3@redhat.com>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Tue, 22 Oct 2024 16:49:47 +0800
Message-ID: <CADxym3b7r-YJ5x==A0wLO1Yuz1dp4E7uMjEzB5EbqfN+eoR3+A@mail.gmail.com>
Subject: Re: [PATCH net-next v3 07/10] net: ip: make ip_route_input_noref()
 return drop reasons
To: Paolo Abeni <pabeni@redhat.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	dsahern@kernel.org, pablo@netfilter.org, kadlec@netfilter.org, 
	roopa@nvidia.com, razor@blackwall.org, gnault@redhat.com, 
	bigeasy@linutronix.de, idosch@nvidia.com, ast@kernel.org, 
	dongml2@chinatelecom.cn, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
	bridge@lists.linux.dev, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2024 at 6:49=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
>
>
> On 10/21/24 12:44, Paolo Abeni wrote:
> > On 10/15/24 16:07, Menglong Dong wrote:
> >> diff --git a/net/core/lwt_bpf.c b/net/core/lwt_bpf.c
> >> index e0ca24a58810..a4652f2a103a 100644
> >> --- a/net/core/lwt_bpf.c
> >> +++ b/net/core/lwt_bpf.c
> >> @@ -98,6 +98,7 @@ static int bpf_lwt_input_reroute(struct sk_buff *skb=
)
> >>              skb_dst_drop(skb);
> >>              err =3D ip_route_input_noref(skb, iph->daddr, iph->saddr,
> >>                                         ip4h_dscp(iph), dev);
> >> +            err =3D err ? -EINVAL : 0;
> >
> > Please introduce and use a drop_reason variable here instead of 'err',
> > to make it clear the type conversion.
>
> Or even better, collapse the 2 statements:
>
>                 err =3D ip_route_input_noref(skb, iph->daddr, iph->saddr,
>                                    ip4h_dscp(iph), dev) ? -EINVAL : 0;
>
> There are other places which could use a similar changes.
>

Yeah, it makes things much more clear.

Thanks!
Menglong Dong

> Thanks,
>
> Paolo
>

