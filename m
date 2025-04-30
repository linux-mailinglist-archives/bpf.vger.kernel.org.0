Return-Path: <bpf+bounces-57088-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60FEBAA546A
	for <lists+bpf@lfdr.de>; Wed, 30 Apr 2025 21:04:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66D0A9C85E1
	for <lists+bpf@lfdr.de>; Wed, 30 Apr 2025 19:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B689D269811;
	Wed, 30 Apr 2025 19:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TqgO00p3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC28C148;
	Wed, 30 Apr 2025 19:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746039860; cv=none; b=FMqfTaDHWpeIAY3CBEMNeNbKcYj8xeu8nrpUxII7YMcmyvs6l2rR3fvw5mWzzilpUc+N8JFUwRkiJurJQl9ikiMoWJDJx+aVMhqKXp+deW12GJoHSVWsegJUcxAObXQAXk5f0A2VAIQk9/7IXAdrbWafeKQOgPdbp90CzBEZXB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746039860; c=relaxed/simple;
	bh=JWb9fA4/pTm7XYbZ29bvLGeMmP6Yjmy55Ye3Mdy8qpU=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=mrOKFPVUUeWb/S8Bb4Z26rDraEY0yC34+SpVdBa5d5c2YVFBfFJRWQkLE+e7ZmidAd9O4noTBDfCCqXPiVdnap4dnkPDe7Tw0fArc+AsHDH8/5ihoeawyrOF+EAwaZau93xeji8my7f3fK1lRZo7bbLGDFNC6bRhKjj2r4fbTx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TqgO00p3; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7c5e39d1db2so9092285a.3;
        Wed, 30 Apr 2025 12:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746039857; x=1746644657; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oyY5YMQOyCq9kucbKedI/MA55x5l77eYwgsxeL/I6SU=;
        b=TqgO00p3z74hZyM53ywjEBQxuoHcF2ilTG9wKZkyWQpif1qWc9yTebu/TI4CDIFSpZ
         n83Pw+0Q6J0ygrlCbN4Sb5f23H5RPE+5Piw+Hi1KTOQuKr9R3YTBMh5Qi0+9JNAF+SiS
         KAaiKa/8Z90EcMu3xOMvmpCOEXLQEkswokbBs1psvldKbrxq7pNpYyaB76ArdgV8xR67
         74d0EVTjbLWLNXf82CxQQs+fUahTyfaGjGu7Oatgd30WwB5m9Q1GgalfoueIds3pDGyV
         Pr2P4ewYJEQdS1l+a0C50ZOKG6u4Wvxr41PZXLDPbpvh93w0qvOg/MlDg0xw2AOXd/6e
         58FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746039857; x=1746644657;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oyY5YMQOyCq9kucbKedI/MA55x5l77eYwgsxeL/I6SU=;
        b=DbJRgMWIS9Wp24wf5bIdttheFCIWkbRuLkHbX9Y5Ebte7KEaOFyIJoN6cfHrW8jw/L
         +tmM+zVGb1sUf5ORfbVfon9x8zcFdc2z8IuugdJgoiYcM7FZ9oYOmuthWr/4YJ7ZlAiE
         1pyvzMnYNnaKpWaHTFydI4qqEvbJXLWaDs4KuQDntpOg/O5Yfr/10MfIwvUgXU6cRY+M
         GYccGEul+0kO//efEIrtrz6a5+PCfDyG0WtmAN6mqmVYuW/a0l/Fue/JI35hpy57RJGp
         XQZM0MoQb6bWIv4q4kb7S0xE0FwBaxSMBeSFoUrl0rnEQhpvdT4cs/SjRzwufLCcumQl
         tjCw==
X-Forwarded-Encrypted: i=1; AJvYcCUo1krrIohHfWs0Gpzed2kMlZ1Lt19MYMXZ3WvYvxSJtUnX5dkvTmm303EFGsGRPtHigVS2YKbg@vger.kernel.org, AJvYcCVomyZmHzENLTn8e81+H4wnvcTUGOXJIVczQsdwSFKE81Ffx9CpP0l96be+gSnONfC1Jn8=@vger.kernel.org, AJvYcCX3fhiV0kOK+JCA5kz79yYDfpnNN5l9ZFq2da2USAadop8MVrGQNAJ/ABOikSQYZeA8RChX8SQiwPCWsR8b@vger.kernel.org
X-Gm-Message-State: AOJu0YxHUhwrtCgVD63/3hJmyDamyOZD6EXKfjgftNLgoCXOWR/u/OWG
	fOncWWaZtR+m96+f7rB4K67s7jAPyDMCYrfEEDmtg8h6aQm7nUlHiIlQ/g==
X-Gm-Gg: ASbGncvOw46pcCf10nPmi4fLqldntmGABcx07rbdhDCIfjce+YDbxbQZdNIwx0u/jpt
	bZDt7B+BaCRQjo4rJWYISW0/fC+1S6thZNkEW5waXAmV58w87Zy4deycnB+ekrkJnU4CJdJDk4y
	tovl3Rx68JnpAzgSwtSR7TBHT47Sk86Ld8TrmjZC0gBmqtouT6MiwDUyO0l0ZHdIvF+ARMfyuKt
	7Sl70rOZ/txZRdy3rdhUtq9du40sv1nVk5kaQUMpnWtyyy7DDInBFBS6ehJWi5NpRZ2XpOhubHw
	N/IAAt7r7rfHnTIeMBpbLTIoQnu5+iRlPovmDs5+OaYvejMJ0xQOz1CTCw1Ewmo9uu/LgFpzZVE
	JGReLCN3U7hinvFbexYvM
X-Google-Smtp-Source: AGHT+IE8g0ghP0kLYsq60LgowZeWzqEGMs36Vg84EHLTQr0YwSJ9Wq869sRRrf6f2swFvGa6gkshfw==
X-Received: by 2002:a05:620a:2482:b0:7c5:55f9:4bb2 with SMTP id af79cd13be357-7cac760a9f8mr545706885a.22.1746039857119;
        Wed, 30 Apr 2025 12:04:17 -0700 (PDT)
Received: from localhost (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c958ea0a01sm886102885a.102.2025.04.30.12.04.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 12:04:16 -0700 (PDT)
Date: Wed, 30 Apr 2025 15:04:16 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jon Kohler <jon@nutanix.com>, 
 Daniel Borkmann <daniel@iogearbox.net>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jason Wang <jasowang@redhat.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Alexei Starovoitov <ast@kernel.org>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Simon Horman <horms@kernel.org>, 
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
 "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Message-ID: <681274309ee3_30bc5e29490@willemb.c.googlers.com.notmuch>
In-Reply-To: <2EB0DFB0-E12D-4FFC-89CF-CF286A9CF8E2@nutanix.com>
References: <20250430182921.1704021-1-jon@nutanix.com>
 <68126b09c77f7_3080df29453@willemb.c.googlers.com.notmuch>
 <a6a8625c-9d20-48eb-b894-7bd6673a16d3@iogearbox.net>
 <2EB0DFB0-E12D-4FFC-89CF-CF286A9CF8E2@nutanix.com>
Subject: Re: [PATCH net-next] xdp: add xdp_skb_reserve_put helper
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jon Kohler wrote:
> =

> =

> > On Apr 30, 2025, at 2:40=E2=80=AFPM, Daniel Borkmann <daniel@iogearbo=
x.net> wrote:
> > =

> > !-------------------------------------------------------------------|=

> > CAUTION: External Email
> > =

> > |-------------------------------------------------------------------!=

> > =

> > On 4/30/25 8:25 PM, Willem de Bruijn wrote:
> >> Jon Kohler wrote:
> >>> Add helper for calling skb_{put|reserve} to reduce repetitive patte=
rn
> >>> across various drivers.
> >>> =

> >>> Plumb into tap and tun to start.
> >>> =

> >>> No functional change intended.
> >>> =

> >>> Signed-off-by: Jon Kohler <jon@nutanix.com>
> >>> ---
> >>>  drivers/net/tap.c | 3 +--
> >>>  drivers/net/tun.c | 3 +--
> >>>  include/net/xdp.h | 8 ++++++++
> >>>  net/core/xdp.c    | 3 +--
> >>>  4 files changed, 11 insertions(+), 6 deletions(-)
> >> Subjective, but I prefer the existing code. I understand what
> >> skb_reserve and skb_put do. While xdp_skb_reserve_put adds a layer o=
f
> >> indirection that I'd have to follow.
> >> Sometimes deduplication makes sense, sometimes the indirection adds
> >> more mental load than it's worth. In this case the code savings are
> >> small. As said, subjective. Happy to hear other opinions.
> > =

> > +1, agree with Willem
> =

> That=E2=80=99s a fair point. I was also toying with the idea of somethi=
ng like
> this instead:
> =

> e.g.
> xdp_headroom(xdp) =3D=3D xdp->data - xdp->data_hard_start
> =E2=80=A6 similar to skb_headroom
> =

> xdp_length_base(xdp) =3D=3D xdp->data_end - xdp->data
> =E2=80=A6 similar to xdp_get_buff_len, but doesn=E2=80=99t look at frag=
s
> =

> then we could do:
> skb_reserve(skb, xdp_headroom(xdp));
> skb_put(skb, xdp_length_base(xdp));
> =

> Names TBD of course, but thoughts?
> =

> That way we keep skb_reserve/put just the same, but have
> a nice helper like we do for skb_headroom() already

I like the idea of xdp_headroom and xdk_headlen, similar to
skb_headroom and skb_headlen.




