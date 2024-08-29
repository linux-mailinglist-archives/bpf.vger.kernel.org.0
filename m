Return-Path: <bpf+bounces-38391-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A5B6964395
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 13:55:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 468FE282107
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 11:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67A32194080;
	Thu, 29 Aug 2024 11:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N3kVez2i"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647A3193081
	for <bpf@vger.kernel.org>; Thu, 29 Aug 2024 11:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724932495; cv=none; b=i+qpAMTxm8c2gHljsGsoqs9cnXy/gpHBskC5XoQi7XafM4aLEHjBN1tlTAmUNVDx0FYSG6XgqGVMKioQ6ChI2dL29sy1Tv32P+4iM9S4jdSlQ9+TkVz0tdSSFcvPLDqw0fkwm0v2fVoE8X3F20aMsgaRYHIhh2dsSZBYCKI6564=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724932495; c=relaxed/simple;
	bh=3dlnyn8cQAlgxTVlcH28u4JCVZfmHHE1szobMOlIZN4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OxGHPXb6jIxSo/kX9vRo0xrh31XaGgsgZ6drf0wkfNtAXjwyDJujEb4FWS/9LPftYx4ZrtY3YpvMnAk+8FFkjM5hbS58xWyXTKs3knVHxbwfFW9ztCIEqp/rN9t5qpfe16Apr83jGyJPTtsenKczaO+g/XZ05y4aNHoxH3YT1Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N3kVez2i; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724932492;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lJ2FyZrQ5MN+v6+9J0qNtf0BSskC1KanKJ9n3vo/YSc=;
	b=N3kVez2iCxby7xzFW2xGhfW1kZ+g0oZZt4Nf2KAqi+QpZsj1HwyDDh3ZLWaolcDSV+CSod
	JgMT9oZdbg+9tWguO/UKvrVq8nh2p/4SdIhx5Te2PN59nN/Y0lKabqpK0TQyd6+L3CwTpM
	L2f8C0fX1Bpor6I7ia7HNxOgj/j9Rgg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-ND5MnsS9NkCHoCidYvBvVw-1; Thu, 29 Aug 2024 07:54:51 -0400
X-MC-Unique: ND5MnsS9NkCHoCidYvBvVw-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-428fc34f41bso6075075e9.3
        for <bpf@vger.kernel.org>; Thu, 29 Aug 2024 04:54:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724932490; x=1725537290;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lJ2FyZrQ5MN+v6+9J0qNtf0BSskC1KanKJ9n3vo/YSc=;
        b=oiQkx/f8d+HtgjatbsDo3nBMEJKm1ryRGI2Y8avvvpTng74L5l8vThnN3vDYl6ldos
         TviSnV5/y4HY6sb3vOlaahDpMyswfsgji9Rm0CK40MwNmxlrPm4u+KQhLXv0h9wNFMzN
         0wVCHMhHZjZaqwO47616SMVx6s6rplq44k8z8aFU1C2RYEFhUycZ3s+3A/VtVfCkNd4D
         TIGKDAapf5Twjpa0oXqT21FGR7pRaV7jxqyra0BOtAyqu7Vn8dA2x09BIQVk5FQRa/vJ
         PRe3MeJeY0AqXnQ5Se3F4qcdRia4f5IIK3HuzOijrjovrQd9v8U4sc74ZDcP87tdaLKG
         amHw==
X-Forwarded-Encrypted: i=1; AJvYcCWyzKxU3mGK8iW+AhFikIZqWhLrw6baPQ5rxVNQkA7Lmj8iNukyRod8GP8Zo4Bwr/jVdCk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz43qce7xBNMkJ7bLejc1gxgT+JX28N1fbluS6jJkajM+qpLtN3
	j9c2DFlZU6BC7uD8N3eKZKYGX0BoPjq4rWE+6VKKAML4mwdvmccvJthr3ndWEMZPiV6fytZX8MX
	USJoQ4Lhsq5ydXzZj/0EtSxw0YxpY7Z9eDLjjPJcu8BY8MpY6QA==
X-Received: by 2002:a05:600c:1389:b0:428:ea8e:b48a with SMTP id 5b1f17b1804b1-42bb01ae3b1mr20370205e9.8.1724932489823;
        Thu, 29 Aug 2024 04:54:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE8uIiIhNB/s/DXbThEbhYHqwNvr8MtzMKTyQpaFJoJEZiBfcxloGBA17PidNn1QpMyEu7mrw==
X-Received: by 2002:a05:600c:1389:b0:428:ea8e:b48a with SMTP id 5b1f17b1804b1-42bb01ae3b1mr20369875e9.8.1724932488894;
        Thu, 29 Aug 2024 04:54:48 -0700 (PDT)
Received: from debian (2a01cb058918ce00dbd0c02dbfacd1ba.ipv6.abo.wanadoo.fr. [2a01:cb05:8918:ce00:dbd0:c02d:bfac:d1ba])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bb6deb1ebsm15059505e9.3.2024.08.29.04.54.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 04:54:48 -0700 (PDT)
Date: Thu, 29 Aug 2024 13:54:46 +0200
From: Guillaume Nault <gnault@redhat.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, dsahern@kernel.org,
	ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
	john.fastabend@gmail.com, steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au, bpf@vger.kernel.org
Subject: Re: [PATCH net-next 00/12] Unmask upper DSCP bits - part 2
Message-ID: <ZtBhhhBeKj82CkYR@debian>
References: <20240827111813.2115285-1-idosch@nvidia.com>
 <Zs3Y2ehPt3jEABwa@debian>
 <Zs30sZynSw53zQfW@shredder.mtl.com>
 <Zs8Tb2HXO7b9BbYn@shredder.mtl.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zs8Tb2HXO7b9BbYn@shredder.mtl.com>

On Wed, Aug 28, 2024 at 03:09:19PM +0300, Ido Schimmel wrote:
> On Tue, Aug 27, 2024 at 06:45:53PM +0300, Ido Schimmel wrote:
> > On Tue, Aug 27, 2024 at 03:47:05PM +0200, Guillaume Nault wrote:
> > > On Tue, Aug 27, 2024 at 02:18:01PM +0300, Ido Schimmel wrote:
> > > > tl;dr - This patchset continues to unmask the upper DSCP bits in the
> > > > IPv4 flow key in preparation for allowing IPv4 FIB rules to match on
> > > > DSCP. No functional changes are expected. Part 1 was merged in commit
> > > > ("Merge branch 'unmask-upper-dscp-bits-part-1'").
> > > > 
> > > > The TOS field in the IPv4 flow key ('flowi4_tos') is used during FIB
> > > > lookup to match against the TOS selector in FIB rules and routes.
> > > > 
> > > > It is currently impossible for user space to configure FIB rules that
> > > > match on the DSCP value as the upper DSCP bits are either masked in the
> > > > various call sites that initialize the IPv4 flow key or along the path
> > > > to the FIB core.
> > > > 
> > > > In preparation for adding a DSCP selector to IPv4 and IPv6 FIB rules, we
> > > 
> > > Hum, do you plan to add a DSCP selector for IPv6? That shouldn't be
> > > necessary as IPv6 already takes all the DSCP bits into account. Also we
> > > don't need to keep any compatibility with the legacy TOS interpretation,
> > > as it has never been defined nor used in IPv6.
> > 
> > Yes. I want to add the DSCP selector for both families so that user
> > space would not need to use different selectors for different families.
> 
> Another approach could be to add a mask to the existing tos/dsfield. For
> example:
> 
> # ip -4 rule add dsfield 0x04/0xfc table 100
> # ip -6 rule add dsfield 0xf8/0xfc table 100
> 
> The default IPv4 mask (when user doesn't specify one) would be 0x1c and
> the default IPv6 mask would be 0xfc.
> 
> WDYT?

For internal implementation, I find the mask option elegant (to avoid
conditionals). But I don't really like the idea of letting user space
provide its own mask. This would let the user create non-standard
behaviours, likely by mistake (as nobody seem to ever have requested
that flexibility).

I think my favourite approach would be to have the new FRA_DSCP
attribute work identically on both IPv4 and IPv6 FIB rules and keep
the behaviour of the old "tos" field of struct fib_rule_hdr unchanged.

This "tos" field would still work differently for IPv4 and IPv6, as it
always did, but people wanting consistent behaviour could just use
FRA_DSCP instead. Also, FRA_DSCP accepts real DSCP values as defined in
RFCs, while "tos" requires the 2 bits shift. For all these reasons, I'm
tempted to just consider "tos" as a legacy option used only for
backward compatibility, while FRA_DSCP would be the "clean" interface.

Is that approach acceptable for you?


