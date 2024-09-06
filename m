Return-Path: <bpf+bounces-39121-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D703996F3DA
	for <lists+bpf@lfdr.de>; Fri,  6 Sep 2024 13:58:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F2B71C21E54
	for <lists+bpf@lfdr.de>; Fri,  6 Sep 2024 11:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C84571CBEBA;
	Fri,  6 Sep 2024 11:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DoX4tc6j"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A11E11CBE81
	for <bpf@vger.kernel.org>; Fri,  6 Sep 2024 11:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725623887; cv=none; b=EM9C8FupRapAPGw/g3SzojGvmmHhLkwU7xAlSyx8lfVVmq5x0nI5Il4/BfWPefxW229B7FjQ9bQIrXuptHIDKAqJLJqQ6WDXcrnFr+dmWm7vA62z7EHkqHpDkQdE/DBwwsX4gpR3DnAfhASsNwf3ggRCrTEsYbze9EEvOdQNu3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725623887; c=relaxed/simple;
	bh=gwhd6YSUYn0QtaTSPyGtnWCa/URckQRSKwJmnGcYxmQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hzF2jUnbCvktkWBxh+9va4TfxJ2iAIg0Xwb6C24Nn1oAqrYWo43IWqZZTb2tlheapzBR1QyLRRm4ViYgAqtGZWq804faEoNST+FESKqMrxk5JIBAgbvITAZWoS96saPr/Y22GNIw4gpR1WfuG7EQxDXZnpvC55rF0WG6aE2b4TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DoX4tc6j; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725623883;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gwhd6YSUYn0QtaTSPyGtnWCa/URckQRSKwJmnGcYxmQ=;
	b=DoX4tc6jNvq1Z3TvK5Aw585LPe3zWgvlgPgSUy315GKI+fUNeD6Vuih0/eKdaIJSNvdpT9
	g7ROwvCgpFT12oLqg3gokVnupB5rcEdAQTJiYm3kQnmB1iMAMr1WHPrbBc2gEQ0wd/JGGy
	P8FdwL+HKGcGjEIn8Jsui5PNG8Xz7os=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-zrEMy4wBNXOcj3x4nLQilw-1; Fri, 06 Sep 2024 07:58:02 -0400
X-MC-Unique: zrEMy4wBNXOcj3x4nLQilw-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-42bb6f7e7adso16209185e9.0
        for <bpf@vger.kernel.org>; Fri, 06 Sep 2024 04:58:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725623881; x=1726228681;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gwhd6YSUYn0QtaTSPyGtnWCa/URckQRSKwJmnGcYxmQ=;
        b=sxwjSst7h7iCjy6q55oct7Gj2Qe9LmKWV2EXzmIDJl+Dgii4ouF+aAAsRTuua7j/Et
         CTtL7tEAiAzpuMVvq5lmtxLvIx2BwXkfEJt2xk7cC0dTIFYLNQKQ3j4EFduw/juTkk0+
         ZyvTfoSQ+uPH8B0/QPIKlYiKpjScVCMsBFvmi7L750kuamtFRjF/FD+yPitTUxsCEtMA
         WgFq6POqPIE5at7bNj/RSserz2zKHH/9RIlovEFQ6J7ATfUfXb5l3Yl92yEFru5IOIrY
         ueBmvs55BdLDDXgzaC4yrQ1hyYR4W3EFNxpFsvyN7qsy4EHWrohBRbCS+ZkFlQ/UI7QM
         0C2A==
X-Forwarded-Encrypted: i=1; AJvYcCWjYUu8NS/uqOVzvlBCKlVCiPd2e6KdEJ7GTj8lGqAAbOV0+Dll1C8SqbkSOMEIY7M3dtw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqaxUWWZeJ44sOf4iQ80JKGsZKGZJ1jKiNFk8lV7ZExt5rFBAn
	XQpJx2sgUG5AA1wWerpKkBRE86vrRmeeafP6vCG4ZJv10qYviMGLPpkdmET+A+NNVK1HGFxMTad
	PGXFDsPp1XnW19soHrwqPj+zB2JhuuUB1RQeyEuzVDYWKq54pLg==
X-Received: by 2002:a05:600c:1911:b0:426:5c9b:dee6 with SMTP id 5b1f17b1804b1-42c9f9d2fb3mr17165895e9.26.1725623881176;
        Fri, 06 Sep 2024 04:58:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGyiezqnLnx60jEifhUTR30wzAxyOM3WxR1xMKMuwhfruZ0dS+mmwcm4hHOxDzegTtb9NCsoQ==
X-Received: by 2002:a05:600c:1911:b0:426:5c9b:dee6 with SMTP id 5b1f17b1804b1-42c9f9d2fb3mr17165555e9.26.1725623880591;
        Fri, 06 Sep 2024 04:58:00 -0700 (PDT)
Received: from debian (2a01cb058d23d6009996916de7ed7c62.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:9996:916d:e7ed:7c62])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42c9bb7d3c6sm31634815e9.1.2024.09.06.04.57.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 04:58:00 -0700 (PDT)
Date: Fri, 6 Sep 2024 13:57:58 +0200
From: Guillaume Nault <gnault@redhat.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, dsahern@kernel.org,
	razor@blackwall.org, pablo@netfilter.org, kadlec@netfilter.org,
	marcelo.leitner@gmail.com, lucien.xin@gmail.com,
	bridge@lists.linux.dev, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org, linux-sctp@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH net-next 09/12] netfilter: nft_flow_offload: Unmask upper
 DSCP bits in nft_flow_route()
Message-ID: <ZtruRrAazfhcwHJs@debian>
References: <20240905165140.3105140-1-idosch@nvidia.com>
 <20240905165140.3105140-10-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240905165140.3105140-10-idosch@nvidia.com>

On Thu, Sep 05, 2024 at 07:51:37PM +0300, Ido Schimmel wrote:
> Unmask the upper DSCP bits when calling nf_route() which eventually
> calls ip_route_output_key() so that in the future it could perform the
> FIB lookup according to the full DSCP value.

Reviewed-by: Guillaume Nault <gnault@redhat.com>


