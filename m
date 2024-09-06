Return-Path: <bpf+bounces-39118-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B59E496F32B
	for <lists+bpf@lfdr.de>; Fri,  6 Sep 2024 13:36:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A5072885DA
	for <lists+bpf@lfdr.de>; Fri,  6 Sep 2024 11:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BE571CB337;
	Fri,  6 Sep 2024 11:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DS+H6fgY"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 999814965B
	for <bpf@vger.kernel.org>; Fri,  6 Sep 2024 11:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725622604; cv=none; b=L39imz3ilsR3Sd7sZoEYDkgsZ6FMvqwpN/jIGs7CDywic/4JO3la8pqsFFfhPDHA0+RIcscNYqbT1hDLcCYSQgIUgo6AIwC1IiTRB+v2BVIh7O026yOLl0tSN8M8hkS+Zi4fmbFPGZTIfrz5Y3qPI3R3OEQxovkIxdOeKiJLDwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725622604; c=relaxed/simple;
	bh=H/3SLq0dvyRb0LeVyF9BgA30UQ44hQlrC2EyAJ37Cwc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e2ySrLzp+BArkxrF1eMnhX/pXdkLdk8fIa2xe6l8pblxLcvPws30/ylRH2bgjujz4D8Ewp+ccdTJP8a8x7YDw99ERpiwJAo7zBqoVSK6EQLOC/ZIANRd0Skv7jCm5t68Lbqv9Ht5OYGsKkgYhcJPMQUB2Lci9s3IOn0IAUgPliY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DS+H6fgY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725622601;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VlxXCUBgluNFhOhUQlRETci2Bz36a3nP0aOKtUXmSaU=;
	b=DS+H6fgYmXjM+Oh7eENp+mFjvf7PrNSLrCYYXn1S36Vy4Pgid8YfhrmKt74l6TJut1cxYj
	lG2q944e87Rz1tmIkXKB7iocF6oao96xHdpqSNPVgcOu/yrQe3dYkBhAjUu9tJ+NNJw6Xd
	K4ZtM7yVdjHGjrILJvelkP4ImN4oc0U=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-88-O1bzlRVSMYyIghArr31Aew-1; Fri, 06 Sep 2024 07:36:40 -0400
X-MC-Unique: O1bzlRVSMYyIghArr31Aew-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-374bfc57e2aso1260211f8f.3
        for <bpf@vger.kernel.org>; Fri, 06 Sep 2024 04:36:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725622599; x=1726227399;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VlxXCUBgluNFhOhUQlRETci2Bz36a3nP0aOKtUXmSaU=;
        b=QUt43HSZhhPNQFM1iFnkrycheFHQ51NL/Ud45gDk4w5kBzpGDhXr1Z82TgD7yVYkyl
         JsFOQwFo1wn1iP8JjXKEEi36iZsTiv1H7LkSTByjeZIfkZCC5y62/nR2gbgydAC4wC+G
         ePpwGy01J5y5m7QIBLcsGlnfPAo0eSccZftCohPeW3Be9ZNOejHogCt0TH+N8GSwCiOD
         GjRDOY1zsB9mfZaPiu8ubs0SQbyUBZ2RoTYBrMCP43ofe5ydKwPH+x0JFfGeRrHzJHH6
         /ryCj/3clJMQQuNn6Sg9ExBB6X4BW2ezIk8j7wuR276JQDu2IB3LjsuA3QahZzmPq41z
         mQFA==
X-Forwarded-Encrypted: i=1; AJvYcCUP7hI9TyHsaaMdGlmhvwbfsVzi8+2edgbRGfc0aOmpJVOc8jjnRBzh9pQFCOQvNXMZfFw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9YLFUMTkMmbIGunSr6dGhFd1EJL46Vc0ni+BgFSH+3mZI8f5Y
	nKEwqwCrNkVIwWeNIuQl0Scg6E+ViLUXlWxEU5SWqen4Qsg25sLuQlD+FpGJI+tnGKp5LZUouS4
	MtHQZfnaIrBxqMhU05LRzKUjVofqRa2Gw23PK45ixQ9194LrXdg==
X-Received: by 2002:a5d:444c:0:b0:374:c6b8:50c3 with SMTP id ffacd0b85a97d-3788960c8c5mr1448824f8f.32.1725622599280;
        Fri, 06 Sep 2024 04:36:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFhvxtr7JBMGDYXn43/Db5EyNacFUtJy69cDUqld7dUH+RRHTkLZupBqCPcA0/x2kPypfjxAg==
X-Received: by 2002:a5d:444c:0:b0:374:c6b8:50c3 with SMTP id ffacd0b85a97d-3788960c8c5mr1448800f8f.32.1725622598548;
        Fri, 06 Sep 2024 04:36:38 -0700 (PDT)
Received: from debian (2a01cb058d23d6009996916de7ed7c62.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:9996:916d:e7ed:7c62])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ca05ccc27sm17942975e9.13.2024.09.06.04.36.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 04:36:37 -0700 (PDT)
Date: Fri, 6 Sep 2024 13:36:35 +0200
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
Message-ID: <ZtrpQzQYR1yylvi0@debian>
References: <20240905165140.3105140-1-idosch@nvidia.com>
 <20240905165140.3105140-6-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240905165140.3105140-6-idosch@nvidia.com>

On Thu, Sep 05, 2024 at 07:51:33PM +0300, Ido Schimmel wrote:
> Unmask the upper DSCP bits when initializing an IPv4 flow key via
> ip_tunnel_init_flow() before passing it to ip_route_output_key() so that
> in the future we could perform the FIB lookup according to the full DSCP
> value.
> 
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
>  net/ipv4/ip_tunnel.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/ipv4/ip_tunnel.c b/net/ipv4/ip_tunnel.c
> index 18964394d6bd..b632c128ecb7 100644
> --- a/net/ipv4/ip_tunnel.c
> +++ b/net/ipv4/ip_tunnel.c
> @@ -293,7 +293,7 @@ static int ip_tunnel_bind_dev(struct net_device *dev)
>  
>  		ip_tunnel_init_flow(&fl4, iph->protocol, iph->daddr,
>  				    iph->saddr, tunnel->parms.o_key,
> -				    RT_TOS(iph->tos), dev_net(dev),
> +				    iph->tos & INET_DSCP_MASK, dev_net(dev),

The net/inet_dscp.h header file is only included in patch 6, while it's
needed here in patch 5.

>  				    tunnel->parms.link, tunnel->fwmark, 0, 0);
>  		rt = ip_route_output_key(tunnel->net, &fl4);
>  
> -- 
> 2.46.0
> 


