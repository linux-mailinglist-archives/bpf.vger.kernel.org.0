Return-Path: <bpf+bounces-78212-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 78346D01CEB
	for <lists+bpf@lfdr.de>; Thu, 08 Jan 2026 10:23:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ACA3B3008F98
	for <lists+bpf@lfdr.de>; Thu,  8 Jan 2026 09:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDFA53EDD4D;
	Thu,  8 Jan 2026 09:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LDyljAdi"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 512A63A63E0
	for <bpf@vger.kernel.org>; Thu,  8 Jan 2026 09:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767863280; cv=none; b=rJ+5GTdDDXVibaZ/JqWbNaslaa5dzlusPLi+7rbDN/PVyqfXpifkeHyfZHMJmmSeJoe8Hi/4+yReR0NOU0aUJWay01k3k+OB3Dq5cQQ2wJOVfkgpVvhGMhe8Oqvtrr99USUIXb3BpT3Iy24hAuoIlgsPRiaWYq4IxdO1/4tcbWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767863280; c=relaxed/simple;
	bh=EcQMbFRqCCUt+PdLgwmmmiL3uuXJ8DSVtKR8dQ9uhG0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a3k0fDRBynI8T6gZ1VdUYMhBVMRQpn9IKXLFKSIDDHwh6M3tiBykgt6nHAs9WPaE0BGqeGExN41teiLKHiSLdhd8uuN/g7rPAJkcD1dKrCdF0RiSMUJEZShpw+iO9zlZl5QnGzSh4RJplY4r9YbS1P8Byy4LiRekJ/vznVf6DwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LDyljAdi; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7c95936e43cso1154876a34.0
        for <bpf@vger.kernel.org>; Thu, 08 Jan 2026 01:07:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767863271; x=1768468071; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rkTLgIk5KrHlnn8sSgveH34RTajKbioDLcNlqwR3F5M=;
        b=LDyljAdi0tWRTawnRtHNSfegxTeKHbKHb6vdjM0N+Wvs8qq3qQIJcFGwKFd60fC6q0
         XaLLqXAJTYKLA/SZKmXGGDUBgNTe0YFgr4hTdbnAQiuvYUd5qw3Hc6u6D1+P68VRi7Nr
         mY2L7hScTK+88ofOd7DcDNq10lyC9ZE6YFk5Wv2QcvzpQBu20Oj25beEQp6Aa9edYncV
         pYUXd7M3/8rfr32i3QrCnAAxwCI0ZCSZDQx7KU3PoiUjOosay7ySDK+w6L60MZPPrcp5
         c+o5tA8ABDmfiKcj7zBbmnHOW3UZNzMQnNC9R1+eLIynSnBt5u1NYR57GYtqz3f3zkYY
         J/8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767863271; x=1768468071;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rkTLgIk5KrHlnn8sSgveH34RTajKbioDLcNlqwR3F5M=;
        b=YW1WjB4cK4q5H5SVFLOhy/i1gN7VD+iOd7bWDDomjpRfSITDJsnhYNw+4rYphkuvXN
         XktPJv4fm7VRSdIn+wDjXhU6SaY0YdPXFPPirFe3x1K/MR+SqvKxUKdX9r1BgBmYdIqn
         UVRmgXjM41dB28Cd5mdCfHWaVvqkRhWonl/xhLLwbisoArMqDe4fLfGqRqfovagMJI61
         dQ7sF/JoUm93cSe/yzy9oDFLSzaPVA63+G0yHtv2vBdrQIpYeFc/92cTtT6zpbd2MIgi
         Tv0+m+zV9gL+gp6WxgV+hZzXUUQpCMqs2EEmIGW5sSZdVZfvw2nXPyYq2SlasamcWE0i
         iq1w==
X-Forwarded-Encrypted: i=1; AJvYcCXV3PcDjevFUQ0Jw3eRRGIVS3uhsMs1kAb+46zzolaGOqRKTcamJ+U2gtpWJgPAVafxllc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLLZeiA45IPGlRzPf0ugcc6F8LDItEBK188QZORn1Gb2FgUIa3
	3xMZXBcWf03Y2jolNbluABb96Rdj6JE+1FVb4rVIlRcL7TW8BAxpVtwidCqO5Y2QjY2pMCDVqwh
	u+Sv7ONB7xlF0ZRYIFis7A06hHeJn29w=
X-Gm-Gg: AY/fxX55s4LTSwepvlKYFQDm3OAsSNFlaxtRFNtUUUHsJutkdW5f+lEOEkLsQJ0v6Jk
	zlA2Y+IehzgezI06C0mMXID6B3O2+wfolsBf4V/pzOIajbCcKR1wPPu/EUydN1L9a81eBPWzCaw
	7bq7d8yk/fHpoLU66KfD1lkkmAagDJQPviXxyycXx5ezDqyvdGrPiwnCJg131UMLGrWwcxpxkHa
	RA8rw8VhMsG1SbiKnu//Zx0OIcRlunQNjW4ARu3UP/lqgugCX0VkR4CnhRyDJ2ZwjFyEGTb
X-Google-Smtp-Source: AGHT+IFBo8zNIrl5j2mohTMd2uNoYwsPPGHofB19QKh2LY79gcOhIgQg6/uoivaFX++yrCsun8LJVjDzUsWItkno0Gs=
X-Received: by 2002:a05:6820:4806:b0:65b:29af:b56b with SMTP id
 006d021491bc7-65f54efb18amr1447679eaf.34.1767863271099; Thu, 08 Jan 2026
 01:07:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260104012125.44003-1-kerneljasonxing@gmail.com>
 <20260104012125.44003-3-kerneljasonxing@gmail.com> <9f0fffcd-8e2a-4ae1-b89d-ae73dba9e1be@redhat.com>
In-Reply-To: <9f0fffcd-8e2a-4ae1-b89d-ae73dba9e1be@redhat.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 8 Jan 2026 17:07:14 +0800
X-Gm-Features: AQt7F2pgMp0e7-268Bxr47VfBc0T8fY326idWgf-BRHx2clhCS_An9Xn84B51Lw
Message-ID: <CAL+tcoCLqr1HjnPZ5BvgEzE04C+KPbTvUe79Vy-=d5KEbmqZuw@mail.gmail.com>
Subject: Re: [PATCH net-next v6 2/2] xsk: move cq_cached_prod_lock to avoid
 touching a cacheline in sending path
To: Paolo Abeni <pabeni@redhat.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	bjorn@kernel.org, magnus.karlsson@intel.com, maciej.fijalkowski@intel.com, 
	jonathan.lemon@gmail.com, sdf@fomichev.me, ast@kernel.org, 
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 8, 2026 at 4:55=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wrot=
e:
>
> On 1/4/26 2:21 AM, Jason Xing wrote:
> > diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
> > index 6bf84316e2ad..cd5125b6af53 100644
> > --- a/net/xdp/xsk_buff_pool.c
> > +++ b/net/xdp/xsk_buff_pool.c
> > @@ -91,7 +91,7 @@ struct xsk_buff_pool *xp_create_and_assign_umem(struc=
t xdp_sock *xs,
> >       INIT_LIST_HEAD(&pool->xsk_tx_list);
> >       spin_lock_init(&pool->xsk_tx_list_lock);
> >       spin_lock_init(&pool->cq_prod_lock);
> > -     spin_lock_init(&pool->cq_cached_prod_lock);
> > +     spin_lock_init(&xs->cq_tmp->cq_cached_prod_lock);
> >       refcount_set(&pool->users, 1);
>
> Very minor nit: moving the init later, after:
>
>         pool->cq =3D xs->cq_tmp;
>
> would avoid touching a '_tmp' field, which looks strange.
>
> Please do not resubmit just for this. Waiting a little longer for
> Magnus, Maciej or Stanislav ack.

Got it. Thanks for the review.

Thanks,
Jason

>
> /P
>

