Return-Path: <bpf+bounces-71823-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A7E7FBFD5C0
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 18:50:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 683ED560A6F
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 16:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AB2734FF7E;
	Wed, 22 Oct 2025 16:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iavnuc7c"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 260E4274B55
	for <bpf@vger.kernel.org>; Wed, 22 Oct 2025 16:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761149889; cv=none; b=Ao1uOg7ciP5kZXwhsI4aEmJ+nEJQd9A3iCZy+6iOxDW9mW3aP0/zgr12WsuJnWoXLDGIEPs8l0/xXAlRpwaQpsVUNuHHzjLbHsmQE1PnCo3hiB1T59SID/QefJfaMD+qH4tCmhbxRmGAftQvbOdlo9EQtx0DmkdagsngO2syYS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761149889; c=relaxed/simple;
	bh=4jHXjbabXeSFPpF/fqCcgJ6XdNu0nQpkS0GreRBSQ6s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MEnsHDtyzeBAhl+bTQ9tW9GD3yNEsFAR7tFs9yNwwT7Ce+joMR/1WJQKZu0+5gdAV857IeLdam/zGd2mVV40KttGBR0nsmP3i7Z28bCPjQtuNA9ukzsZ9HWfb0eoSa7P2v/7rYkhMWVZfyN9aM5ghYpvLa7atVh//ba4RjnTL7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iavnuc7c; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b6cf07258e8so234476a12.1
        for <bpf@vger.kernel.org>; Wed, 22 Oct 2025 09:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761149887; x=1761754687; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RLP+bpkdPGjagGTgRPPp7+rOmgDtjlSKoZhywvA67RM=;
        b=iavnuc7ceDYkWYY2LGIpqjQXKEQ/HQggb818cJjqa8TfhFd9HtVYKPL5yt5Od7lSbr
         L6U3bQTTj0NLwRLARhG9kv5+ofSW+pru6UcY7/5ugfSk0RPn6gH1uycqPQpwEyNOio4c
         zKQS+JRfkLJGhTCoMjNT6ugt3AL3a+WY+duIwcXSvPJOSnX3GfH5Vj1jBPVkmXWM+Igl
         LJU7TMbIJXUTxs7PZhGMWYns+bblL16qeD5VC6cviObR6suYrNnsGOfQ/NMCFG5PsfIg
         yhLswtxX4cHNInZO7Ojd/fHOCI2MzgG7opQpn0iHnGp2pf5P1EaoSD/QfEh4ovD6GaRR
         NQ2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761149887; x=1761754687;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RLP+bpkdPGjagGTgRPPp7+rOmgDtjlSKoZhywvA67RM=;
        b=kY2AMh8zxf6tkkX6a6K4x8eXJ7EC/X4XygLltWtdhP2CH7ZGjp/tUl/c6Al+MkOgbt
         U1aaDLjsFGI4iWhlmqLk33e+Wvy401S8l9rsyx1QfCvNojYLTN886/4/kiGrb0uTKGRu
         a7gTL7YvTuDJkmId/zwejDZXz6oAKTZxxNNqRI3ykYwErfOF7fLMx5cpOqVN0IuGVl91
         iYJ3PP3UXLoNpEVhTG3JVzC8unrGGNIUaRRrJPf07QYEAD7ZQoROyeQWCBlVFXvDDZrH
         InJTrk0JwTbLBzv4FjKF4kRiItgBc471Fq0b8yxy/ItrB15hSO7pF55jy9pvbWoncyf/
         WGVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUTvhKVM3JvMtUyn3EAKSUKiNUa6qpaauVQgIwO9p4+VXbxS/6FV4SKe31f8qAxcKAU3I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzekkjcFLnFZvgmSGUKwqfH5rVEjt/vzP9VY7HnOiPI8jnYVQsr
	Zzz2hswtmEBTVb42F5nYNEvJ/WWkANmxLodpNRJW04eHEJm7DL3PH5aa
X-Gm-Gg: ASbGncteyULwwRNdmEcHIGxTzu+LDwS4Oit5hHlfxJbYc8TOKqVowjPpCBx3eHTUjV7
	4xCLR/hajiIRHPEVIayWTnzaFhrBYHVeaVe/eok5yt+8xx8+NP6cin0361tIc+FBVgswnvPCVkx
	16nOpNfQ4tbceEwnEVVIZQ2G0gnu6Ofxnh78is2E5QRfwS05L4qP4IXh22BNC6QRLiIkus0LyBU
	KeK4cnG++ZdOIPYdPjWo2kWJ/wq01tuCh8UOBd2fh3EbvnEMm0DBl2OQxpBYxODHDKqV2AmIq0+
	ld6QuctcFFQL+FA4kXNl6DKpqNarmnZlKjB0TX2VXDnp1RA+Ek0dsLyIHy/vnKvFHkprLV/yXMm
	iLRGonRnNA2Ik+5OJTC/yIrm3ViU8IEfNIcTKLqRh3H5hGOOj5tdDRNnjqenQgbzQnkWSfni5MI
	6QfxbM
X-Google-Smtp-Source: AGHT+IHfAOCNJGgUXhdj6sgYkuAO4xsbyh4B6nGpWidzyORSpqM0a8O04rj58jJ6k/uvjC5jyroU0w==
X-Received: by 2002:a17:903:19f0:b0:264:5c06:4d7b with SMTP id d9443c01a7336-290cba4f065mr257718945ad.32.1761149887296;
        Wed, 22 Oct 2025 09:18:07 -0700 (PDT)
Received: from lima-default ([104.28.246.147])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292472193a1sm142156625ad.106.2025.10.22.09.18.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 09:18:06 -0700 (PDT)
Date: Thu, 23 Oct 2025 03:17:58 +1100
From: Alessandro Decina <alessandro.d@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: Alessandro Decina <alessandro.d@gmail.com>, netdev@vger.kernel.org,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Tirthendu Sarkar <tirthendu.sarkar@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>, bpf@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 1/1] i40e: xsk: advance next_to_clean on status
 descriptors
Message-ID: <aPkDtuVgbS4J-Og_@lima-default>
References: <20251021173200.7908-1-alessandro.d@gmail.com>
 <20251021173200.7908-2-alessandro.d@gmail.com>
 <CAL+tcoCwGQyNSv9BZ_jfsia6YFoyT790iknqxG7bB7wVi3C_vQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL+tcoCwGQyNSv9BZ_jfsia6YFoyT790iknqxG7bB7wVi3C_vQ@mail.gmail.com>

On Wed, Oct 22, 2025 at 11:11:01AM +0800, Jason Xing wrote:
> On Wed, Oct 22, 2025 at 1:33 AM Alessandro Decina
> <alessandro.d@gmail.com> wrote:
> > diff --git a/drivers/net/ethernet/intel/i40e/i40e_xsk.c b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> > index 9f47388eaba5..dbc19083bbb7 100644
> > --- a/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> > +++ b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> > @@ -441,13 +441,18 @@ int i40e_clean_rx_irq_zc(struct i40e_ring *rx_ring, int budget)
> >                 dma_rmb();
> >
> >                 if (i40e_rx_is_programming_status(qword)) {
> > +                       u16 ntp;
> > +
> >                         i40e_clean_programming_status(rx_ring,
> >                                                       rx_desc->raw.qword[0],
> >                                                       qword);
> >                         bi = *i40e_rx_bi(rx_ring, next_to_process);
> >                         xsk_buff_free(bi);
> > -                       if (++next_to_process == count)
> > +                       ntp = next_to_process++;
> > +                       if (next_to_process == count)
> >                                 next_to_process = 0;
> > +                       if (next_to_clean == ntp)
> > +                               next_to_clean = next_to_process;
> >                         continue;
> >                 }
> >
> > --
> > 2.43.0
> >
> >
> 
> I'm copying your reply from v1 as shown below so that we can continue
> with the discussion :)
> 
> > It really depends on whether a status descriptor can be received in the
> > middle of multi-buffer packet. Based on the existing code, I assumed it
> > can. Therefore, consider this case:
> >
> > [valid_1st_packet][status_descriptor][valid_2nd_packet]
> >
> > In this case you want to skip status_descriptor but keep the existing
> > logic that leads to:
> >
> >     first = next_to_clean = valid_1st_packet
> >
> > so then you can go and add valid_2nd_packet as a fragment to the first.
> 
> Sorry, honestly, I still don't follow you.
> 
> Looking at the case you provided, I think @first always pointing to
> valid_1st_packet is valid which does not bring any trouble. You mean
> the case is what you're trying to handle?

Yes, I mean this case needs to keep working, so we can't move
next_to_clean unconditionally, we can only move it when
next_to_clean == ntp, which is equivalent to checking that
first == NULL. See below.
 
> You patch updates next_to_clean that is only used at the very
> beginning, so it will not affect @first. Imaging the following case:
> 
>      [status_descriptor][valid_1st_packet][valid_2nd_packet]
> 
> Even if the next_to_clean is updated, the @first still points to
> [status_descriptor] that is invalid and that will later cause the
> panic when constructing the skb.

Exactly - the key is to make sure we never get into this state :)

At the beginning of the function - outside the loop - first is only
assigned if (next_to_process != next_to_clean). This condition means: if
we previously exited the function in the middle of a multi-buffer
packet, we must resume from the start of that packet (next_to_clean) and
process the next fragment in it (next_to_process).

Consider the case you just gave:

> [status_descriptor][valid_1st_mb_packet][valid_2nd_mb_packet]

Assume we enter the function and next_to_process == next_to_clean, we
don't assign first, so first = NULL.

We find the status descriptor: without this patch, we increment
next_to_process, don't increment next_to_clean, say we run out of budget
and break the loop, the next time the function is entered we set first =
status_descriptor because next_to_process != next_to_clean. This is
exactly what we want to avoid.

With this patch upon processing the status descriptor, we see
next_to_clean == ntp, we increment next_to_clean, the next time the
function is entered next_to_process == next_to_clean, first is correctly
set to NULL and the next packet starts from valid_1st_mb_packet.

So I've covered both the scenarios:

a) [status][mb_packet1][mb_packet2]
b) [mb_packet1][status][mb_packet2]

The last case

c) [packet1][packet2][status] is actually just a), because at packet2
we'd find the EOP marker and close off the previous multi-buffer packet.

I hope I was more clear and please check my logic :)

Ciao,
Alessandro

