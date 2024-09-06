Return-Path: <bpf+bounces-39129-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65D2896F5D5
	for <lists+bpf@lfdr.de>; Fri,  6 Sep 2024 15:52:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EA6C284A8D
	for <lists+bpf@lfdr.de>; Fri,  6 Sep 2024 13:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BD401CF5CB;
	Fri,  6 Sep 2024 13:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gfZQrhn8"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCDF113B5AF
	for <bpf@vger.kernel.org>; Fri,  6 Sep 2024 13:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725630732; cv=none; b=FhR6f9zr+2WLQ1dsByEQX6e63097+AsQFT/gdn3MI2AS0SEXKZa0znirYApJsqZUexsFJXRO+ml/bwGbIJ9TnS5nvDJ02iFLrmMoW8cH2tlXkQsczu0IYk029113L4UIqzAtYQJRTAjEkeRfYezU5BcVtZbpFo/vfBYtgQyhIog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725630732; c=relaxed/simple;
	bh=StSQ8Sopl2KUdJyrUIo0Dn6vw18ljtWli0wJa4rE2V0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rVkgJ7sCzaUshJuuWfh4utCcehmkVlVQWP4wS873gWbHe+tiWbfgrWSy9wj3xmUGYi64Up2mG29BTkcMDKxU3B+GSpYEZyBVXGeGCQWZbSoDh5Yh3YZLYy4r9ZU+EyzNSur9vn3fUKr2L4b/7Twg3zn5jJ2ydNwv0RXtSvvfTXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gfZQrhn8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725630728;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ruf53o5LMxX7Ic6vKOyaHGTrP4g2JJS9oUvDsEuczC0=;
	b=gfZQrhn8klaHa6/pM7ntOvaJr+ZF4SDXwzgchpiUFWwzsKbTSDshAVvGy/PEcmiD9HEjUH
	+VyyGzg69e70Ft41vtOfrwznOdcHx0JqYEpklwQPWeywoh0U0+Bp2Ym9M0+P/i/JbrB3Nd
	hsmXmdk8VTqueWVW9rBMfA7wuW7pZeA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-439-VBCkmIt0MxK2zYILP1re7Q-1; Fri, 06 Sep 2024 09:52:07 -0400
X-MC-Unique: VBCkmIt0MxK2zYILP1re7Q-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-42c7a5563cfso15409445e9.2
        for <bpf@vger.kernel.org>; Fri, 06 Sep 2024 06:52:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725630726; x=1726235526;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ruf53o5LMxX7Ic6vKOyaHGTrP4g2JJS9oUvDsEuczC0=;
        b=rnFSbO38GO/MgEfDyr4cGk3HCE0AKl4IdZ1et62jW/bhIBrdu+WPFOaTVBR3f/m8uk
         QmHQ8KKT0D0/xHe3Pam7eCGsN+MWxHBwg2+0pTdFxf7zLgpFH+X/G96e/X+IDHpKYTqY
         mpQorQt5PYw79Iw3z35odREX6PC6KywWzdXt0PK0LNhU7wEfHPyubS4HqK9BwG0fUcXw
         ZTkJEu2cVWoQVIkcBM0M37oTzop9T5aeImBrFg7Ek9CCjdCeqOUs8P1/iCkrSrlaMZuR
         fSCB0h9FeZQ7837AJgur5pKH1qLC8ku1Ukew01KjtAIBfLeenyyaHBpjU5fi4pURNbkD
         mA7A==
X-Forwarded-Encrypted: i=1; AJvYcCUh00AAzydc+KGbGhAkcu9J1fGVNHoNTQ2IN2q4ibpkKqAJG7nvWhtEa/P7Fx1FOdp/XH0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7B1DMljA8iFxbhYc2HALYzeRs0vO8VOl9AZa0rYqqhoc7l+V4
	SnXk2T+p948Il/Uaz/lB+ysMwdf9jHwtpdhdngspqsYcNpeOJfUDsbCM2BP7NU3r3JkE4J4x977
	OwfO+YKI85aBgAdMMTMwXgN1tsK3g1voHbCzeICtDcRbvTgWUFQ==
X-Received: by 2002:a05:600c:1548:b0:426:6876:83bb with SMTP id 5b1f17b1804b1-42bb01bfbfemr196097955e9.17.1725630726462;
        Fri, 06 Sep 2024 06:52:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHbxix7jHuJHA8DA4R29fRPu2sTpju4N5w6eH7u3Etcr4F/LL0XbUco3ZYW316eqReHUvTwHA==
X-Received: by 2002:a05:600c:1548:b0:426:6876:83bb with SMTP id 5b1f17b1804b1-42bb01bfbfemr196097425e9.17.1725630725658;
        Fri, 06 Sep 2024 06:52:05 -0700 (PDT)
Received: from debian (2a01cb058d23d6009996916de7ed7c62.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:9996:916d:e7ed:7c62])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ca05ccc27sm21412425e9.13.2024.09.06.06.52.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 06:52:05 -0700 (PDT)
Date: Fri, 6 Sep 2024 15:52:03 +0200
From: Guillaume Nault <gnault@redhat.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, dsahern@kernel.org,
	razor@blackwall.org, pablo@netfilter.org, kadlec@netfilter.org,
	marcelo.leitner@gmail.com, lucien.xin@gmail.com,
	bridge@lists.linux.dev, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org, linux-sctp@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH net-next 05/12] ipv4: ip_tunnel: Unmask upper DSCP bits
 in ip_tunnel_bind_dev()
Message-ID: <ZtsJAxqOaan8Adnz@debian>
References: <20240905165140.3105140-1-idosch@nvidia.com>
 <20240905165140.3105140-6-idosch@nvidia.com>
 <ZtrpQzQYR1yylvi0@debian>
 <ZtsHf-TrqA0EWfoj@shredder.lan>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZtsHf-TrqA0EWfoj@shredder.lan>

On Fri, Sep 06, 2024 at 04:45:35PM +0300, Ido Schimmel wrote:
> On Fri, Sep 06, 2024 at 01:36:35PM +0200, Guillaume Nault wrote:
> > On Thu, Sep 05, 2024 at 07:51:33PM +0300, Ido Schimmel wrote:
> > > Unmask the upper DSCP bits when initializing an IPv4 flow key via
> > > ip_tunnel_init_flow() before passing it to ip_route_output_key() so that
> > > in the future we could perform the FIB lookup according to the full DSCP
> > > value.
> > > 
> > > Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> > > ---
> > >  net/ipv4/ip_tunnel.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/net/ipv4/ip_tunnel.c b/net/ipv4/ip_tunnel.c
> > > index 18964394d6bd..b632c128ecb7 100644
> > > --- a/net/ipv4/ip_tunnel.c
> > > +++ b/net/ipv4/ip_tunnel.c
> > > @@ -293,7 +293,7 @@ static int ip_tunnel_bind_dev(struct net_device *dev)
> > >  
> > >  		ip_tunnel_init_flow(&fl4, iph->protocol, iph->daddr,
> > >  				    iph->saddr, tunnel->parms.o_key,
> > > -				    RT_TOS(iph->tos), dev_net(dev),
> > > +				    iph->tos & INET_DSCP_MASK, dev_net(dev),
> > 
> > The net/inet_dscp.h header file is only included in patch 6, while it's
> > needed here in patch 5.
> 
> Thanks. Probably happened when I reordered the patches. However, it
> doesn't affect bisectability since the header is included via include/net/ip.h

Okay, no need for a v2 then.
I'll ack the remaining patches.

And thanks again for your work!


> > >  				    tunnel->parms.link, tunnel->fwmark, 0, 0);
> > >  		rt = ip_route_output_key(tunnel->net, &fl4);
> > >  
> > > -- 
> > > 2.46.0
> > > 
> > 
> 


