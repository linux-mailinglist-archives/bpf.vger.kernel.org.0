Return-Path: <bpf+bounces-63549-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 33A13B08325
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 04:52:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 652AB58164A
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 02:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA2031E0083;
	Thu, 17 Jul 2025 02:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W+LQnLWG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0835D1B4244;
	Thu, 17 Jul 2025 02:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752720736; cv=none; b=BeFlhri0xvpkIwysYHYAgQRjLiv/IiThVesFPGXzx5iKvY6qu1Xsx1JdJi2oBsBo2uvHBH444l7kBu5YAOUMz+qqtxga/2Ng5t9zkmQUXJjXdTcv+SaQfLcti8CEtZKJVituXPt06XU9+gsq3EqpgpeCCZPaaC2dx1Mj5vNBE4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752720736; c=relaxed/simple;
	bh=+lJpU2mXa0TyzC21P9ldpmZXpfExs2ldRnSoRpZsCXM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=dQe4Aw6Eed7vOvWB4l2vOvayTHjPGII0pKGZi9yZNbtnJUmOWUv8LGxwPhB7RU0XLEG672Cahuehre+mKDdBQe+YXkq+p+r6XOimZWZKNfCaC44OmY0c/7dUvuAC73QZhPLTA2HNn+TB777Xky5VzYq/iB4j6Ni+YLb1ixcLhcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W+LQnLWG; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e8275f110c6so452805276.2;
        Wed, 16 Jul 2025 19:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752720734; x=1753325534; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+lJpU2mXa0TyzC21P9ldpmZXpfExs2ldRnSoRpZsCXM=;
        b=W+LQnLWGIpkjPqZMyd/7C1dbqBtImkEpuytl/HxRzrrQ322ihDL249WKxIXBZt7Q5K
         aGC9S1eKnOHNwhVCpV+PbpSYD8cqEcPCTxuJxLrs8pl6jpIop5vhbbv5lUd0lgPEzOho
         Bw41ci7/08afQdJN7AsycwBoqWtRCRCpOTGpE3Yn+aUHhRFJMzTmPq59ZG0ERCp+Vq8q
         D9zK/5O0heYEe4dSjwcVN1715VRGZ/rads8jMuciIHQR2ovaztryGZTb0u3pW0Yon8qf
         s2YR7mXsv3piE93e+VludkjNneR/OkB7Z2Vvu3M4gRAGR5i886PCufBSyBdVl0LzlLo/
         qbcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752720734; x=1753325534;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+lJpU2mXa0TyzC21P9ldpmZXpfExs2ldRnSoRpZsCXM=;
        b=Gf3VJ8Qmqg8fWzMIBXLygOOJnPVi578MpdSdptt7W5WvNC6Wy3FNNL2Lo8rCOYS+aF
         QcMIej8Zkf/FAkLifIPwsD7xLDmrQghYGClatkZqELONNY/fo5W9o1V7vU2QIdHFoI9a
         CO43O1FQDHPjPuL2yECLGWnU7H7xBq7B+Wk/usobqzCTjZYJhzqy6shY8QdSxOcVAQlL
         nmosv2sL9+CT5SHG2a1ApEYKi0gXLOabFidBMv3B8mVY4sshDhzoFVyrMTFMyZCH80cH
         1rR4ddFkJPTxIgz6Km8TbRmWCu7RFtE7H/TUP3+fHtef68V8pY0UijzqjN6esUerZE6Z
         mlGA==
X-Forwarded-Encrypted: i=1; AJvYcCW0+jpcag802F7O3gRwjCRRWwND1dGNeDkb8R2ohd5aHO+SSH6TzcSHEwU36cOSShiXym8=@vger.kernel.org, AJvYcCXtldKn4aY+xRx9HO4w4qALgZYeLv3nKGB0oCGLlAoBZV5gm4fkSj2UPHjy7SwT59hwbnhpqwC1@vger.kernel.org
X-Gm-Message-State: AOJu0YxJMSMQ/ADZ1wodloj+0wdFW3AiW00VQWmkIejd1q2Ug5Y7VG9x
	U+aOl+AXLFXgUQuh6a7SV9ydrFS49i098qt1C2rWZE68rCqPVyWO8Fd7
X-Gm-Gg: ASbGncusrdoh1BuAKXmDnW8JQWeVCGKhpgoWStaObvOz/HOa2QwyOpLWDPw+eSSmgoc
	A6E+PyHipi2AiXSZ6ueCoviOJwDS7RspozPNUqzOlNUsOzPLEl8cqBGBpYlC4Xylbi7RmNYLPI7
	JaGP16t1oxKB7upyy0FVeRBU/oe0h6GDcKX9+W9i7FvdCF6x/kecnmvdryZy/ujgEIBU9LzW/ER
	wNGrJP3A5tG1x4IwEk81uXJ5MpeUIh7TqukwWpkx+FiYs+KrGPgWIdmF0Yy8ziGJVGfjgoRN7qH
	zpOtOTiLy0ylHzi0x82TCbWIBBeUIBNb0HPeRaYaWj6BPvTFmuO/uwY0Nk96fLjmKiaGoZA5zyR
	yAy3MNMsD5KAAamk61oEQTngA/jerhpTqWHeUf10g+5hyynP9XtXewTn1sGmyCzIpgs3FYw==
X-Google-Smtp-Source: AGHT+IGIv/PNECzN/AP4YQUb37vr5VvmtdSKCMT8TaKIQLlfNS+FyLaApcES2IWkhCWdaq47lrXErg==
X-Received: by 2002:a05:6902:2602:b0:e8b:bd41:c781 with SMTP id 3f1490d57ef6-e8bc255e3e9mr6502842276.11.1752720733738;
        Wed, 16 Jul 2025 19:52:13 -0700 (PDT)
Received: from localhost (23.67.48.34.bc.googleusercontent.com. [34.48.67.23])
        by smtp.gmail.com with UTF8SMTPSA id 3f1490d57ef6-e8bb928f0edsm1502225276.34.2025.07.16.19.52.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 19:52:13 -0700 (PDT)
Date: Wed, 16 Jul 2025 22:52:12 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 bjorn@kernel.org, 
 magnus.karlsson@intel.com, 
 maciej.fijalkowski@intel.com, 
 jonathan.lemon@gmail.com, 
 sdf@fomichev.me, 
 ast@kernel.org, 
 daniel@iogearbox.net, 
 hawk@kernel.org, 
 john.fastabend@gmail.com, 
 joe@dama.to, 
 willemdebruijn.kernel@gmail.com, 
 bpf@vger.kernel.org, 
 netdev@vger.kernel.org, 
 Jason Xing <kernelxing@tencent.com>
Message-ID: <6878655ca06c7_9aa0c294c5@willemb.c.googlers.com.notmuch>
In-Reply-To: <CAL+tcoCMQhaZdvbR1p50tuVk0RUdqAiRgjDrO0b+EO1XvM=2qw@mail.gmail.com>
References: <20250716122725.6088-1-kerneljasonxing@gmail.com>
 <20250716145645.194db702@kernel.org>
 <CAL+tcoByyPQX+L3bbAg1hC4YLbnuPrLKidgqKqbyoj0Sny7mxQ@mail.gmail.com>
 <20250716164312.40a18d2f@kernel.org>
 <CAL+tcoA1LMjxKgQb4WZZ8LeipbGU038is21M_y+kc93eoUpBCA@mail.gmail.com>
 <20250716175248.4f626bdb@kernel.org>
 <CAL+tcoCMQhaZdvbR1p50tuVk0RUdqAiRgjDrO0b+EO1XvM=2qw@mail.gmail.com>
Subject: Re: [PATCH net-next v2] xsk: skip validating skb list in xmit path
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jason Xing wrote:
> On Thu, Jul 17, 2025 at 8:52=E2=80=AFAM Jakub Kicinski <kuba@kernel.org=
> wrote:
> >
> > On Thu, 17 Jul 2025 08:06:48 +0800 Jason Xing wrote:
> > > To be honest, this patch really only does one thing as the commit
> > > says. It might look very complex, but if readers take a deep look t=
hey
> > > will find only one removal of that validation for xsk in the hot pa=
th.
> > > Nothing more and nothing less. So IMHO, it doesn't bring more compl=
ex
> > > codes here.
> > >
> > > And removal of one validation indeed contributes to the transmissio=
n.
> > > I believe there remain a number of applications using copy mode
> > > currently. And maintainers of xsk don't regard copy mode as orphane=
d,
> > > right?
> >
> > First of all, I'm not sure the patch is correct. The XSK skbs can hav=
e
> > frags, if device doesn't support or clears _SG we should linearize,
> > right?
> =

> But note that there is one more function __skb_linearize() after
> skb_needs_linearize() in the validate_xmit_skb(). __skb_linearize()
> tests many members of skbs, which are not used to check the skbs from
> xsk. For xsk, it's very simple (please see xsk_build_skb())

For single frame xsk skb_needs_linearize will be false and thus
__skb_linearize is not called?

More generally, I would also think that the cost of the
validate_xmit_skb checks are quite cheap in the xsk case where they
are all false. On the assumption that the touched cachelines are
likely warm.
 =

> >
> > Second, we don't understand where the win is coming from, the numbers=

> > you share are a bit vague. What's so expensive about a few skbs
> =

> To be more accurate, it's not "a few" but "so many" because of the
> high pps reaching more than 1,000,000. So if people run the xdpsock to
> test it, it's not hard to see most of time is spent during the skb
> allocation process.

Right, the alloc or memcpy more than the validate?

> > accesses? Maybe there's an optimization possible to the validation,
> > which would apply more broadly, instead of skipping it for one trivia=
l
> > case.
> >
> > Third, I asked you to compare with AF_PACKET, because IIUC it should
> > have similar properties as AF_XDP in copy mode. So why not use that?
> =

> I haven't run into AF_PACKET so far. At least, I can confirm that xsk
> doesn't need it from my side. The whole logic of validation apparently
> is not designed for xsk case...
> =

> >
> > Lastly, the patch is not all that bad, sure. But the experience of
> > supporting generic XDP is a very mixed. All the paths that pretend
> > to do XDP on skbs have a bunch of quirks and bugs. I'd prefer that
> > we push back more broadly on any sort of pretend XDP.
> =

> Well, sorry, I feel a bit upset when reading this because as I
> insisted before not everyone can use the advanced zerocopy mode.
> =

> Thanks,
> Jason



