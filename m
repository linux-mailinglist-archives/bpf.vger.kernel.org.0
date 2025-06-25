Return-Path: <bpf+bounces-61625-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DC02AE92C7
	for <lists+bpf@lfdr.de>; Thu, 26 Jun 2025 01:37:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D0703BEA10
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 23:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33F732D3ED4;
	Wed, 25 Jun 2025 23:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ox5ajdJG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5801D28727B;
	Wed, 25 Jun 2025 23:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750894666; cv=none; b=OhIZW9+EmA/R+QiVr9xA2x5SMBGfsgFKp3JVVb2bwyt25zwav9mIAk5Qo40WsL/ZQbCoaOiLG0xeUHTx5SBcLFLf6xvRF+bS5rvbtzp1QEzBO8ptPTUwkFXG+7sADUt8C8eugwYIbXjx8EFZp2hifbdgco7HV6p2QEElN+uNn3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750894666; c=relaxed/simple;
	bh=xHrTYbF92chgZYeYWlQJGbK8QUmCthZ4uep2qydiOjs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eeVNgR0rCd3j/MVrCnS/9mipP9s6bMsXOmuJLCRyS3FBpjW/Z2uJvQVSJYRr0aK7JfOksqfeaUYjS8Su1ZhQDpweGLxkpSJkfCmfRwIBRfH21GgH2syGXzlNr0IiqwEPI3ysi+IEz5H6uuO3kRywnEGL3A4gdJkmcJOQKs97yjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ox5ajdJG; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-747c2cc3419so456212b3a.2;
        Wed, 25 Jun 2025 16:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750894665; x=1751499465; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6KLByGxx/RM99lGy5OggoUQdzdk3RoTvXMgy9x4lPEg=;
        b=Ox5ajdJGHO3ZYBbse/qBvawDWIbKWBtF+nmERFIDngoZ1L5MfLOz43CWoFIoQMeeMI
         nudPdp9GKmBPPVEw3FxNwyYVOf+uyjsBe+5ptixI2/eUC6dzw+WvmBPQNHeyHdbsj4cA
         XeywlMPsIvpLX5YhigWdD2IcypCElSGVbMBQx3D3TIRKEGuvcLmOXCZ5gwoSEwBlQErV
         ZHD3nYNre9YT0p+sCsMyw/aogF7RrHFHMQcsRBmPJ+VyO9FlNxyq5T0/R6Teh7S04U9J
         YejDVxeL4kVp1+q0vqG4GQPa3WHeieWNB7dBwrU2PAA1qzGwXB/fUwLX1HMbAUE2Bf/9
         ri8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750894665; x=1751499465;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6KLByGxx/RM99lGy5OggoUQdzdk3RoTvXMgy9x4lPEg=;
        b=lVngaHeaxJYEfJMw7yiblCySEPFKvj11rh1StffteknMWk2Pi9JogqbfoQ24RnrDTR
         sXGy9JjeVAoGcvQTW5fm0qyix1s4fgXhW9y+Ov56mIy4a46N1lbgxRV3YbNt4n+G9NSb
         791ghSY538w3jtYwOWFTnslrxV8ZM1td6BE4ekTDyhYsO+2j4U2GR6+rPVnznZw92Eet
         gklO4ol5YJva02pD5IPo3dngkJabYRYE08VN/OO/Nr+Vhecg+TCzWQR9Q9nbZVFZKmrL
         LbVhp76dOmV3rYg1nb9WmRZyPLJReBOc6Jnfly3EmYm5VyT6ASLSEP0e/m3sp0XPSY5W
         sk3Q==
X-Forwarded-Encrypted: i=1; AJvYcCVyUkFccb9cbKhgGVY2LsirScFFQBxGOj5W1UBFr9x1yvW11qL0ystthb2+oGXuZEm0ejM1cA+j@vger.kernel.org, AJvYcCXCWnzPRq8ofnWMoqOchsFgiH6duIFuQVd94KY1F6ZuYB+MAwepmaoYKhHRy+5UCfkw8Ns=@vger.kernel.org, AJvYcCXYRan755KT8PwQ5b4pylTv0GhABRPHUDQpnkfhsidMvdV53LdI3dKW7aSswK7iJHFGr4cjWrFga/K66y3j@vger.kernel.org
X-Gm-Message-State: AOJu0Ywe9uGKjNT6mQ5RRM/vVIqGckbNEFUescLmqnOGRINRNMpjuOsm
	69n0BU5MIdufvISbk5pit17vYjRTlpfiPSDwhrCqUQchcPJ/E12Sloo=
X-Gm-Gg: ASbGncsH3sUaHfA/SqFlUv8hRS9VYkZC3OcTgRlWV4agb0kkh0C2gcyrXgcKQrEfzYC
	R6FxIDPFjhfQcE0v2gKX/Zm1s+stcjpjQAphD6YkpVi9DNeCVcN3BneqYpzmGdGrtClj6Cf0S4L
	fHutTgv9jqY9Ulyu60ylT50aoCKJd9wlfZNEMLIcKy1C+EixCPPjWmcsR1YO4k+wt+aeZ9Z5+qP
	oLwBUTSdQqPDJOcUBYFPmbhFBEJSY6p5glU3xct/R4vrZjG9Zpdf/VzVAyoUIPgEnPufBSOkNT1
	fkUk5IbXZPCItsIfAj8d4NKLcYQOUxOFTQyRjfXzmFUP1hUz9DwiMMgABqa3TeQwROga5qWg1cL
	wKeUqk68gUPs+ZfROy5pY1nc=
X-Google-Smtp-Source: AGHT+IEbTrXZnKzgaak+y3ylQdeGUZLfweU3Yku499AWI/Fx0tzO6a4rPiAUBrxl3OBx2DLznkvPwQ==
X-Received: by 2002:a17:902:dac6:b0:234:e7bb:963b with SMTP id d9443c01a7336-238240d1b55mr93770915ad.16.1750894664511;
        Wed, 25 Jun 2025 16:37:44 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-237d867b438sm141528705ad.176.2025.06.25.16.37.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 16:37:44 -0700 (PDT)
Date: Wed, 25 Jun 2025 16:37:43 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jason Xing <kerneljasonxing@gmail.com>,
	syzbot <syzbot+e67ea9c235b13b4f0020@syzkaller.appspotmail.com>,
	andrii@kernel.org, ast@kernel.org, bjorn@kernel.org,
	bpf@vger.kernel.org, daniel@iogearbox.net, davem@davemloft.net,
	edumazet@google.com, horms@kernel.org, jonathan.lemon@gmail.com,
	linux-kernel@vger.kernel.org, maciej.fijalkowski@intel.com,
	magnus.karlsson@intel.com, netdev@vger.kernel.org,
	pabeni@redhat.com, sdf@fomichev.me, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bpf?] [net?] possible deadlock in xsk_notifier (3)
Message-ID: <aFyIRxuBrpRsB0iF@mini-arch>
References: <685af3b1.a00a0220.2e5631.0091.GAE@google.com>
 <CAL+tcoB0as6+5VOk9nu0M_OH4TqT6NjDZBZmgQgdQcYx0pciCw@mail.gmail.com>
 <aFwQZhpWIxVLJ1Ui@mini-arch>
 <CAL+tcoCmiT9XXUVGwcT1NB6bLVK69php-oH+9UL+mH6_HYxGhA@mail.gmail.com>
 <aFwZ5WWj835sDGpS@mini-arch>
 <aFxgg4rCQ8tfM9dw@mini-arch>
 <20250625140357.6203d0af@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250625140357.6203d0af@kernel.org>

On 06/25, Jakub Kicinski wrote:
> On Wed, 25 Jun 2025 13:48:03 -0700 Stanislav Fomichev wrote:
> > > > I'm still learning the af_xdp. Sure, I'm interested in it, just a bit
> > > > worried if I'm capable of completing it. I will try then.  
> > > 
> > > SG, thanks! If you need more details lmk, but basically we need to reorder
> > > netdev_lock_ops() and mutex_lock(lock: &xs->mutex)+XSK_READY check.
> > > And similarly for cleanup (out_unlock/out_release) path.  
> > 
> > Jakub just told me that I'm wrong and it looks similar to commit
> > f0433eea4688 ("net: don't mix device locking in dev_close_many()
> > calls"). So this is not as easy as flipping the lock ordering :-(
> 
> I don't think registering a netdev from NETDEV_UP even of another
> netdev is going to play way with instance locks and lockdep.
> This is likely a false positive but if syzbot keeps complaining
> we could:
> 
> diff --git a/drivers/net/wan/lapbether.c b/drivers/net/wan/lapbether.c
> index 995a7207bdf8..f357a7ac70ac 100644
> --- a/drivers/net/wan/lapbether.c
> +++ b/drivers/net/wan/lapbether.c
> @@ -81,7 +81,7 @@ static struct lapbethdev *lapbeth_get_x25_dev(struct net_device *dev)
>  
>  static __inline__ int dev_is_ethdev(struct net_device *dev)
>  {
> -       return dev->type == ARPHRD_ETHER && strncmp(dev->name, "dummy", 5);
> +       return dev->type == ARPHRD_ETHER && !netdev_need_ops_lock(dev);
>  }
>  
> IDK what the dummy hack is there for, it's been like that since 
> git begun..

Agreed. The driver itlself looks interesting. IIUC, when loaded, it
unconditionally creates virtual netdev for any eth device in the init
ns. A bit surprised that syzbot enables it, none of my machines have it
enabled.

