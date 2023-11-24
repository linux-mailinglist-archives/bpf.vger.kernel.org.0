Return-Path: <bpf+bounces-15815-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A3A07F7778
	for <lists+bpf@lfdr.de>; Fri, 24 Nov 2023 16:17:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C852C282203
	for <lists+bpf@lfdr.de>; Fri, 24 Nov 2023 15:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBE0E2E823;
	Fri, 24 Nov 2023 15:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wv0XtX0F"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2240D56;
	Fri, 24 Nov 2023 07:17:00 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-5bdb0be3591so1513866a12.2;
        Fri, 24 Nov 2023 07:17:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700839020; x=1701443820; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kbYkj/MUb8Tinc4tiE527OQTke01/qOYcdwrRK6oPJM=;
        b=Wv0XtX0FwHrRG4sz6U0DfLIZCxkmqJbvBWNxm/dii/vDbvddk51aUcPREaFuHyDspp
         JwqK/rTVELejDiBdz+oXnWt0XC+6KXlnL6fY48cQyW6iDkvqukIlAuJhePkBMHArzmC2
         uLf/TA7L0qhz5Hj0CIExNDmvlQhcH3bik7Fh6QzSELAgsIiYwfxhe/+b2jjLSEXiu7I3
         uR6BYhbXN3S9kiOKAECYYJiFOCc2Vfng28F/nL7GnGlV2QfUogtgN//C6PAcCOXY0D39
         lh+1Yue8+m81WlJNLH4dP4txpdrusMCWKo7LR6tPz+xWRQed6Es4POIxPRMMhvxDCutA
         4HcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700839020; x=1701443820;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kbYkj/MUb8Tinc4tiE527OQTke01/qOYcdwrRK6oPJM=;
        b=heigNdlzCuCZU0XdxH44nBZSApGzjgj6lSRvEyuE4x1jjLA/7Xm8xygtmjwbycW6Uu
         0m3BIWmujYJvex5Xi39aw5dsiqSzfJXcb4UyZiHsBCOAEeEgryx/g0sFsF0p0rtjR/1W
         vTZ4B6UWjbVtGJDGHAE0QE7/wnmoP/eX1CkJMALYKikCUAf24zM6LYOFFvxvleu/fu7W
         5CjLT/PePA5glRXY8ujJkEv7hKb/4hlkXd96vNab2DSkG8wF0hkLcRrTdNQjspv2tq0n
         UW+2UojwCPbak/OV/9yQ8+W+MZ0ForsvMLC98/opVUn548vgpQD3x3EUuH4K+KmAdt0A
         U1WA==
X-Gm-Message-State: AOJu0YxUF23GU9Gd43wpd1KRnfKN77IQJ2da0HqdSciyzcJh5JQZV9f9
	m83+Lsc1J9xDIMlvTa3TVjbmIYpzhRuNZw==
X-Google-Smtp-Source: AGHT+IGobWuLr2+kExZj4I/rzGTgITQ/z7jzKeFi5F8SMoGR33sZns3EfXQZHQeGNdjAWuGHJLX7EQ==
X-Received: by 2002:a17:90b:3a82:b0:285:34a1:8beb with SMTP id om2-20020a17090b3a8200b0028534a18bebmr3567902pjb.15.1700839019881;
        Fri, 24 Nov 2023 07:16:59 -0800 (PST)
Received: from libra05 ([143.248.188.128])
        by smtp.gmail.com with ESMTPSA id 32-20020a630c60000000b005c19c586cb7sm3207918pgm.33.2023.11.24.07.16.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 24 Nov 2023 07:16:59 -0800 (PST)
Date: Sat, 25 Nov 2023 00:16:53 +0900
From: Yewon Choi <woni9911@gmail.com>
To: Magnus Karlsson <magnus.karlsson@gmail.com>
Cc: =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Jonathan Lemon <jonathan.lemon@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	threeearcat@gmail.com
Subject: Re: xdp/xsk.c: missing read memory barrier in xsk_poll()
Message-ID: <20231124151651.GA26062@libra05>
References: <20231124070005.GA10393@libra05>
 <CAJ8uoz1s_TqemsQSsu4=pH147d9M1y-cy5G1VCLkM9g3pFj93w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJ8uoz1s_TqemsQSsu4=pH147d9M1y-cy5G1VCLkM9g3pFj93w@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)

On Fri, Nov 24, 2023 at 02:50:04PM +0100, Magnus Karlsson wrote:
> On Fri, 24 Nov 2023 at 08:00, Yewon Choi <woni9911@gmail.com> wrote:
> >
> > Hello,
> >
> > We found some possibility of missing read memory barrier in xsk_poll(),
> > so we would like to ask to check it.
> >
> > commit e6762c8b adds two smp_rmb() in xsk_mmap(), which are paired with
> > smp_wmb() in XDP_UMEM_REG and xsk_init_queue each. The later one is
> > added in order to prevent reordering between reading of q and reading
> > of q->ring.
> > One example in simplied code is:
> >
> > xsk_mmap():
> >         if (offset == XDP_PGOFF_RX_RING) {
> >                 q = READ_ONCE(xs->rx);
> >         }
> >         ...
> >         if (!q)
> >                 return -EINVAL;
> >
> >         /* Matches the smp_wmb() in xsk_init_queue */
> >         smp_rmb();
> >         ...
> >         return remap_vmalloc_range(vma, q->ring, 0);
> >
> > Also, the similar logic exists in xsk_poll() without smp_rmb().
> >
> > xsk_poll():
> >         ...
> >         if (xs->rx && !xskq_prod_is_empty(xs->rx))
> >                 mask |= EPOLLIN | EPOLLRDNORM;
> >         if (xs->tx && xsk_tx_writeable(xs))
> >                 mask |= EPOLLOUT | EPOLLWRNORM;
> >
> > xskq_prod_is_empty():
> >         return READ_ONCE(q->ring->consumer) && ...
> >
> > To be consistent, I think that smp_rmb() is needed between
> > xs->rx and !xsq_prod_is_empty() and the same applies for xs->tx.
> >
> > Could you check this please?
> > If a patch is needed, we will send them.
> 
> Yes, you are correct that the current code would need an smp_rmb().
> However, an unbound socket should never be allowed to enter the
> xsk_poll() code in the first place since it is pointless to poll a
> socket that has not been bound. This error was introduced in the
> commit below:
> 
> commit 1596dae2f17ec5c6e8c8f0e3fec78c5ae55c1e0b
> Author: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> Date:   Wed Feb 15 15:33:09 2023 +0100
> 
>     xsk: check IFF_UP earlier in Tx path
> 
> When an AF_XDP socket has been bound, it is guaranteed to have been
> set up in the correct way and a memory barrier has already been
> executed in the xsk_bind call. It would be great if you could submit a
> patch, but I suggest that you do something like this instead of
> introducing an smp_rmb():
> 
>     if (xsk_check_common(xs))
>         goto out;
>     :
>     :
> 
>     if (xs->rx && !xskq_prod_is_empty(xs->rx))
>         mask |= EPOLLIN | EPOLLRDNORM;
>     if (xs->tx && xsk_tx_writeable(xs))
>         mask |= EPOLLOUT | EPOLLWRNORM;
> 
> out:
>     rcu_read_unlock();
>     return mask;
> 

I didn't grab that semantic fully, thank you for pointing it out.
As you suggested, it seems that the part right below skip_tx also should
be skipped.
Additionally, I think read ordering will be guaranteed by smp_rmb()
in xsk_check_common().

I'll write a patch after making sure it, just in case of my mistake.

Thank you for your reply.

> Thank you for spotting this!
> 
> /Magnus
> 

Best Regards,
Yewon Choi

