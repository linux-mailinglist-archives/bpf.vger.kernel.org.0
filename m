Return-Path: <bpf+bounces-72931-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B0358C1DB49
	for <lists+bpf@lfdr.de>; Thu, 30 Oct 2025 00:44:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E71FF4E10E0
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 23:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5227C31B10F;
	Wed, 29 Oct 2025 23:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GwFEiEah"
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6680431A81C
	for <bpf@vger.kernel.org>; Wed, 29 Oct 2025 23:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761781471; cv=none; b=bXtzE4nWONj40kGolmZIolsesFt5o3cRXDpJenXl8fN9utP2lX1fZmuFgpl1Aog0y2MgUn4jXqzwSYyMck54DJvxIfQ3/wscX85I5nYKC4G7kPQwRQlTf9maR6tPHg6LVPIoi9CRcvB1Hy7/BsjOZtC1pxZEJvnzHtk4BFl98vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761781471; c=relaxed/simple;
	bh=C14yLC6DsL60xkjRCmGeFPk3Gn5KURyJgVCcNTU66fU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ME/hd2qWfjm7k3fnj0gn5dwLhWHvaFgu7ombi7sObhZCWFFeyMyR/j+4w8m7zk3QyYl71wjGqddAZcmJHeFL3G4XlHK42IXV14UbHkRnwxZJwFqiw4majf0sxxCiGplfE0xF+FcRKqp2YeHRPvLyJa/dlr+G/5InmlBU6BbLx3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GwFEiEah; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-945a42fd465so18853139f.3
        for <bpf@vger.kernel.org>; Wed, 29 Oct 2025 16:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761781469; x=1762386269; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C14yLC6DsL60xkjRCmGeFPk3Gn5KURyJgVCcNTU66fU=;
        b=GwFEiEah8BDlzxvMA50AAe7BwLeYSjyJI4GAA+G0PQJuwuiHhpnHsI5xO2Exe5dB54
         tmiVrGG5vw1pjUhmHDYcp93+qI2dTXm1gp/8256+gIzvC7G0pGOKoSh52nTNnRuZICYn
         B/80q2vJLpNj3v/lCxTu0lXlnAqk3p1NH2B1klbUjD3PbYItpIP98LT2xMHSmc5Mvf5U
         U+YyWGLYKgXg3rpqisy9ozRBzS2XkhuGesMa4aJVjZh4s2IBGscb+ntOzAspDIheB/pt
         67tgoXN7eSi8eBW5dzUv8kDuB4aop/Myc4r0bggYSEEBJheG5TtFMbZlwoLxyXxbwoJo
         o+7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761781469; x=1762386269;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C14yLC6DsL60xkjRCmGeFPk3Gn5KURyJgVCcNTU66fU=;
        b=kPBxMKEou+9vstPlHHm9cerw3INN32nzrQm0hIjqMf7Qx8C8zXlzGS4ATsPOMZp84y
         4QrnV20j2NqtIynAzyODImk0EdNBqlAMG4irOlqP00tU5xX9ul3UvrpoYvaMujzX835L
         i8Hk/sqWkJVgmDXutwa+uF3BttOVpzdcseHCfUIboetUxFLDY+RBqF2CJS1ds7aiX8TM
         amrCg2gbTJsPKF0QOfSfrjH6FNn+1n1WKAupDPUNM41UppSliLyobLW8Y/9sW+nPTggX
         HZVEAxjZ0JZVJgZmqILN401MzpCMo54Q/hBi1gWZXPm6qXnyqHgIsPA+L+5zcCWjJSk7
         sQhw==
X-Forwarded-Encrypted: i=1; AJvYcCUElJ54VwqXcRwma2hRhhEsMUPKfEMspOO60byM7RM3jQe7lIkkfpbsraGEJummaC9Ds3Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YybdqK6j5Edv9KneL1MMV+oyoDzQFN0hzXz+iOT7M8T/xEjyFYr
	lKiOMYXFVRIhmqduAjZ/4N2rPK1g0cgPo2dySpUkvNSY4VEPtAHngDQZNBMKy9pA3GYu+ZpEJqq
	C48WPcdhb1N7VLQstf6w5ZC7MuMwKTs4=
X-Gm-Gg: ASbGncvOcFKWsqbkfUXuAStemPgHwe/CKlvL291vhM0GWnZJNFLGE+dasjWpR9QqkD/
	v8C1nhpjMB3KrIcnwrHGMhMh6jxmvsBzA33gvTMhzj39rFF/mbppS1MIsXEbu5Uke/JUdzoXfwL
	FypTmbMPK1tr70sIKBm7Ra8kzgFF8zLG9gvpV6gNzk7mNAKu1hlQHMAENOx3A022uGCkEHn0BVI
	JMYffYVLjgYfhFlzDKSS73W6HCdTXQC79XFQ081gjtzBm+pLmsbJvq53uc=
X-Google-Smtp-Source: AGHT+IF051QtcmqoluW3Zbt6+K5qGMnPgAEPPNdIeK5IV4SWt6/GI3ng/eThxjoKwT+TXLjEFXmmdl07QJrrQEd1DKg=
X-Received: by 2002:a05:6e02:1a44:b0:42f:94f5:4662 with SMTP id
 e9e14a558f8ab-432f9036ee7mr65960145ab.18.1761781469434; Wed, 29 Oct 2025
 16:44:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251025065310.5676-1-kerneljasonxing@gmail.com>
 <20251025065310.5676-2-kerneljasonxing@gmail.com> <aQI3TfFZPPaWQOS/@boxer>
In-Reply-To: <aQI3TfFZPPaWQOS/@boxer>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 30 Oct 2025 07:43:53 +0800
X-Gm-Features: AWmQ_bnb6zOVaQ7G9s4oKpQ3eRGnQtV4E_7f8NgI0IC-42GOSl7f17rWn3b6mng
Message-ID: <CAL+tcoBwKd9v6A8j_6wgN7y8Y-_4N6VM-Pdnv4x49eUx5RcGag@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] xsk: avoid using heavy lock when the pool is
 not shared
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, bjorn@kernel.org, magnus.karlsson@intel.com, 
	jonathan.lemon@gmail.com, sdf@fomichev.me, ast@kernel.org, 
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com, 
	horms@kernel.org, andrew+netdev@lunn.ch, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025 at 11:48=E2=80=AFPM Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> On Sat, Oct 25, 2025 at 02:53:09PM +0800, Jason Xing wrote:
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > The commit f09ced4053bc ("xsk: Fix race in SKB mode transmit with
> > shared cq") uses a heavy lock (spin_lock_irqsave) for the shared
> > pool scenario which is that multiple sockets share the same pool.
> >
> > It does harm to the case where the pool is only owned by one xsk.
> > The patch distinguishes those two cases through checking if the xsk
> > list only has one xsk. If so, that means the pool is exclusive and
> > we don't need to hold the lock and disable IRQ at all. The benefit
> > of this is to avoid those two operations being executed extremely
> > frequently.
>
> Even with a single CQ producer we need to have related code within
> critical section. One core can be in process context via sendmsg() and
> for some reason xmit failed and driver consumed skb (destructor called).
>
> Other core can be at same time calling the destructor on different skb
> that has been successfully xmitted, doing the Tx completion via driver's
> NAPI. This means that without locking the SPSC concept would be violated.
>
> So I'm afraid I have to nack this.

But that will not happen around cq->cached_prod. All the possible
places where cached_prod is modified are in the process context. I've
already pointed out the different subtle cases in patch [2/2].

SPSC is all about the global state of producer and consumer that can
affect both layers instead of local or cached ones. So that's why we
can apply a lockless policy in this patch when the pool is exclusive
and why we can use a smaller lock as patch [2/2] shows.

As to how to prevent the case like Jakub mentioned, so far I cannot
find a good solution unless introducing a new option that limits one
xsk binding to only one unique pool. But probably it's not worth it.
It's the reason why I will scrap this patch in V2.

Thanks,
Jason

