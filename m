Return-Path: <bpf+bounces-39130-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3585D96F5DF
	for <lists+bpf@lfdr.de>; Fri,  6 Sep 2024 15:53:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 474371C2411B
	for <lists+bpf@lfdr.de>; Fri,  6 Sep 2024 13:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CC2B1CF5C4;
	Fri,  6 Sep 2024 13:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YmElOzuE"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B1561CEAD2
	for <bpf@vger.kernel.org>; Fri,  6 Sep 2024 13:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725630755; cv=none; b=mPv740N3TjQh2/BtAc/EciAUCXekJarPO3mSTxxpx4EaOJ2n7f66hl+KyYsIpfBHDWcjEAxEMSVu2QjwOPXKq5aD+caVjUv5HTGsJZwkOWJ5YIANcKrAOi6IyKHTgX0vhthQ9sdfY9i2DmJZDyVVOdOQmxIGJIWscCuwHJimxto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725630755; c=relaxed/simple;
	bh=q9aU6MLxmooh2pjhdIX2la9jDmWUIouSae2ZL0rKgsM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I4FczU6frcoAltjTqAlgs7CrDPOTA59/q2WUshk30EHasKmfPmfF+nsCOAoA6AiaV5rZheVLW74fYED8e2KAZ2BYWQLHCVkw5ztjM2fASwuATyZ4EIXm47epZz2FC+0rp5x/X818ceuUNle424yxr8UiHddM0z6MLXsNhr7vXAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YmElOzuE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725630752;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=q9aU6MLxmooh2pjhdIX2la9jDmWUIouSae2ZL0rKgsM=;
	b=YmElOzuEZIMloSvfZhWslakP/4yky66hoPwPq7PdYa+6L7T/rA6X6okGUr0jpgfQ6q1Yc8
	trm9GFlARDbWaF99ypIdBmqdZ9gvef0jE/K7lrkmWD3EtnzGnHgnQDvHujCpMs99GNx8tr
	tSdAZnh7N6THiOVY3CYZpgMlU5jhKMw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-394-5Zh1XyREMnit_mEgxj3JOg-1; Fri, 06 Sep 2024 09:52:31 -0400
X-MC-Unique: 5Zh1XyREMnit_mEgxj3JOg-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-374c9b0daf3so1161775f8f.1
        for <bpf@vger.kernel.org>; Fri, 06 Sep 2024 06:52:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725630750; x=1726235550;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q9aU6MLxmooh2pjhdIX2la9jDmWUIouSae2ZL0rKgsM=;
        b=JUzDLQKZ6bSEKtafO/irx9Pn8nVACBjabZkcuFruMSNcugTIjxRfBt9iKso3siVSNs
         AgAC3uXnna4B5Cvh180sN8QyZHexIbYr11RBq3UI/dVT/6xBESlAE3nTkXx7Krhzv3Id
         HY3HRfTX9bGDwcjRCGljmWyAAJN4c1CeZnWS3FpFqa/B8uBV0+4MwR7o1zHUDqavcGMd
         pVG5xVou8H9q6wc+5lpHbIn/byGvP415wbuFWKbl77SJWU2JLmjH3m6sfpG4o3DmvXXL
         hM+aaRBJ4qlb8AY5U0/kCKoaUxweCqailGBEqOPqg8vVCBmsix9jLrhYuCDJjv2wzK28
         fcpg==
X-Forwarded-Encrypted: i=1; AJvYcCXP9Rp1GecoLk51n6EnQsTwdPGUwdAz24TPQeiZPXMNIu7WqsYstwOzsA5i+mZzw0/mHo0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQWQKvToc0EnYOlsCW1faWnkdQRE7pYrzkYQPL8BcvtieLlcFm
	3sbO81YONCR5EfG7yNGYq/bmPXJk3KitmtL0dvBCGcy04kXtTtd3BIRic3OrbchWoMQNwOmG4Zg
	gKpXx5G/sIDyT/bqh1yVm2mZE9pikKLlwf7ngl1yV9fxijDoHFg==
X-Received: by 2002:a5d:5e04:0:b0:374:b5af:710c with SMTP id ffacd0b85a97d-374b5af7510mr12649954f8f.26.1725630750355;
        Fri, 06 Sep 2024 06:52:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE7rIucSxMSJNCM9P3fVpLg+fca1j3lilFUPuCE9KWtPYnhwY3r2Fu3rHNI/1QZKG6cYsZRkg==
X-Received: by 2002:a5d:5e04:0:b0:374:b5af:710c with SMTP id ffacd0b85a97d-374b5af7510mr12649933f8f.26.1725630749848;
        Fri, 06 Sep 2024 06:52:29 -0700 (PDT)
Received: from debian (2a01cb058d23d6009996916de7ed7c62.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:9996:916d:e7ed:7c62])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3788773ea3csm2131461f8f.54.2024.09.06.06.52.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 06:52:29 -0700 (PDT)
Date: Fri, 6 Sep 2024 15:52:27 +0200
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
Message-ID: <ZtsJG3/3syyoQOCH@debian>
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

Reviewed-by: Guillaume Nault <gnault@redhat.com>


