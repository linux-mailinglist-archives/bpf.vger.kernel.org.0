Return-Path: <bpf+bounces-26412-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62D1E89F293
	for <lists+bpf@lfdr.de>; Wed, 10 Apr 2024 14:46:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C9B7282074
	for <lists+bpf@lfdr.de>; Wed, 10 Apr 2024 12:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA0C415B55C;
	Wed, 10 Apr 2024 12:45:49 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67CF158DB9;
	Wed, 10 Apr 2024 12:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712753149; cv=none; b=pwFcqdp/TPgbLmtge9pfcY7DyR25sUImWc4GSLRcK7jpIFtKZW4Twoue0w8p81TxKc6EN+5tBIrss4QgPM6TH8GFKFfd1zD79Ah4kJ5P7h4i8hmYYEEu6TbgnLWFYSAOZzY3AoqZikHdndly7Nt+4eRb0dc2eGiGhGVqDdx+Pd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712753149; c=relaxed/simple;
	bh=tD4QkZOAj61aCZGjCPwk6wEvCiQTwcMYYHOPnCN8QvY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=caLjvBYQF2gG3KQLDtNgX6WwWMt01kt1OgJZjkCueVgqJ+Hzi2qgyPubdIwSXUpOXUgmJZqmMxqY4GJam2GHX37zvw0hXNbk7zLRPd/F0/LOWtXLx/6kx265ISAtQtHl24xL6t6M8x5L+UPdLEekUrc5crJ+3gXJPXVcEQOP7Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a51beae2f13so478433466b.1;
        Wed, 10 Apr 2024 05:45:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712753146; x=1713357946;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0v050svZEeKX6xCxDWehqmojLYZEjuvnVFUXjaedZaw=;
        b=oM4wLB39UtR0jl7LNNK73uySSZsDUcXqjMr08JwAQt6iA5zVWcmCEQ7AuUwNbHul51
         fQ1yoIGjLgCKmo7oFhqLj1YoRCHm87qmCyN0KBfYLBmx63QT6ckzbzTwJgkYizU1MdgZ
         xtXdvlSsOEsPEOz9F6Vjk7fG4kkUdePf34+jeQ90vINYOLzn4qB0MG3ndybCijEaotFp
         rRiP9dMFzp+iEHPyO2UgJyaJ5wIisRqAIjVJwpwlURkl777dUfDr7WySAMpmZ+tNRpaV
         qmdP+afNTN1QIE5bDvOG9thW/L2uHyTFg15YbEs5s5UcbkdVtpCQP5Icf3uN+4XFFT2+
         AQ2Q==
X-Forwarded-Encrypted: i=1; AJvYcCWqEHAnxPxseS6ZbAWYAiPOsM5ePTbpU97taATHRGZEoK8MWtko540Y93K2Yo+D7lN1/aMGyHxjL5+bNS8pcZzVwrxe5vahnog6sz7bYnrUkHWZyHkNmCNX59gn66+8KZXEtjmwbreaMRDkMY7FSPvQpq3WeMJekiwUQf8jcfoN8TTx2OMxCdTtWQIC0D9GzwsWSQrgPWGkUfg=
X-Gm-Message-State: AOJu0YwWsSuTyF+03FPZ9BsTbv2sKbxotTbpw1eVBw4NrVLTgSGu3bBn
	3zTC4U73YTorMM/g1IaewTfAA2SK22WXk96VqNzcs67e0qEBlfKn
X-Google-Smtp-Source: AGHT+IGHTIvSnYbc16oL+rmZ6uXCsyNfTppKX/R1tU+P7ojp/FGa9JEJ+FKYxGWNNfYEH5ZZNCyv/A==
X-Received: by 2002:a17:907:7da8:b0:a51:dd50:6a with SMTP id oz40-20020a1709077da800b00a51dd50006amr2008839ejc.66.1712753145630;
        Wed, 10 Apr 2024 05:45:45 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-007.fbsv.net. [2a03:2880:30ff:7::face:b00c])
        by smtp.gmail.com with ESMTPSA id jg18-20020a170907971200b00a51a60bf400sm6765658ejc.76.2024.04.10.05.45.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 05:45:45 -0700 (PDT)
Date: Wed, 10 Apr 2024 05:45:41 -0700
From: Breno Leitao <leitao@debian.org>
To: Ido Schimmel <idosch@idosch.org>
Cc: aleksander.lobakin@intel.com, kuba@kernel.org, davem@davemloft.net,
	pabeni@redhat.com, edumazet@google.com, elder@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, nbd@nbd.name,
	sean.wang@mediatek.com, Mark-MC.Lee@mediatek.com,
	lorenzo@kernel.org, taras.chornyi@plvision.eu,
	ath11k@lists.infradead.org, ath10k@lists.infradead.org,
	linux-wireless@vger.kernel.org, geomatsi@gmail.com,
	kvalo@kernel.org, quic_jjohnson@quicinc.com, leon@kernel.org,
	dennis.dalessandro@cornelisnetworks.com,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	bpf@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>,
	Simon Horman <horms@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	amcohen@nvidia.com
Subject: Re: [PATCH net-next v4 2/9] net: create a dummy net_device allocator
Message-ID: <ZhaJ9WkG2OYXkvGo@gmail.com>
References: <20240409125738.1824983-1-leitao@debian.org>
 <20240409125738.1824983-3-leitao@debian.org>
 <ZhZzjNDRaHtdYjDg@shredder>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZhZzjNDRaHtdYjDg@shredder>

On Wed, Apr 10, 2024 at 02:10:04PM +0300, Ido Schimmel wrote:
> On Tue, Apr 09, 2024 at 05:57:16AM -0700, Breno Leitao wrote:
> > It is impossible to use init_dummy_netdev together with alloc_netdev()
> > as the 'setup' argument.
> > 
> > This is because alloc_netdev() initializes some fields in the net_device
> > structure, and later init_dummy_netdev() memzero them all. This causes
> > some problems as reported here:
> > 
> > 	https://lore.kernel.org/all/20240322082336.49f110cc@kernel.org/
> > 
> > Split the init_dummy_netdev() function in two. Create a new function called
> > init_dummy_netdev_core() that does not memzero the net_device structure.
> > Then have init_dummy_netdev() memzero-ing and calling
> > init_dummy_netdev_core(), keeping the old behaviour.
> > 
> > init_dummy_netdev_core() is the new function that could be called as an
> > argument for alloc_netdev().
> > 
> > Also, create a helper to allocate and initialize dummy net devices,
> > leveraging init_dummy_netdev_core() as the setup argument. This function
> > basically simplify the allocation of dummy devices, by allocating and
> > initializing it. Freeing the device continue to be done through
> > free_netdev()
> > 
> > Suggested-by: Jakub Kicinski <kuba@kernel.org>
> > Signed-off-by: Breno Leitao <leitao@debian.org>
> 
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> 
> We were about to submit another user of init_dummy_netdev() when I
> noticed this patch. Converted the code to use alloc_netdev_dummy() [1]
> and it seems to be working fine. Will submit after your patch is
> accepted.

Thanks. It seems that this patch is close to get accepted. Let's see...

> See a few minor comments below.
> 
> [...]
> 
> > +/**
> > + *	init_dummy_netdev	- init a dummy network device for NAPI
> > + *	@dev: device to init
> > + *
> > + *	This takes a network device structure and initialize the minimum
> 
> s/initialize/initializes/
> 
> > + *	amount of fields so it can be used to schedule NAPI polls without
> > + *	registering a full blown interface. This is to be used by drivers
> > + *	that need to tie several hardware interfaces to a single NAPI
> > + *	poll scheduler due to HW limitations.
> > + */
> > +void init_dummy_netdev(struct net_device *dev)
> > +{
> > +	/* Clear everything. Note we don't initialize spinlocks
> > +	 * are they aren't supposed to be taken by any of the
> 
> I assume you meant s/are/as/ ?

Thanks for the feedback, I agree with all of them.

Since these lines were not introduced by this patch, and this patch is
just moving code (and comments) around, I would add a new patch to the
patch series fixing the grammar errors.

