Return-Path: <bpf+bounces-32188-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B0B9908EC7
	for <lists+bpf@lfdr.de>; Fri, 14 Jun 2024 17:31:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1AD1FB28568
	for <lists+bpf@lfdr.de>; Fri, 14 Jun 2024 15:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 817FE15E5CB;
	Fri, 14 Jun 2024 15:19:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1224158A29;
	Fri, 14 Jun 2024 15:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.27.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718378370; cv=none; b=DwzxAn6YcPWsAlm8YEwz+Y3b/G8Vxysp+sb8teMDV0A+nt3Svtbl6Fnw8XuH//2gI8B5dnhQMwlflDJaAQAZPAQ0lZNp9RvFZkvd/alOVv54rQ/ZsCeEExOrtz2SEUnlwtmHs3GsjEMJRU2EJ/T4Y0Cmb6laoYhzitNFIFJFHuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718378370; c=relaxed/simple;
	bh=9ltlPdlPXJjT3XQ3Y1utAMDtxGpQCjIg/lMX679BHL4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kShd2bVpCHxJYCOKyCSRFTnSh1yYogF0cxj43KOpN3NSteE7823nKDId6QYvjfEifMeCxCXxskMXRk2aywzal01WRb4JeldnWbIj/nNOCR8C0RPHVrHFhiwNWAuGAs9wG7Q7lG7Lqvwo57qzOcEPX7dTAd8f3r/2B8+mDPuZ73I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=gnumonks.org; arc=none smtp.client-ip=213.95.27.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gnumonks.org
Received: from [78.30.37.63] (port=58314 helo=gnumonks.org)
	by ganesha.gnumonks.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <pablo@gnumonks.org>)
	id 1sI8hr-007H1t-EP; Fri, 14 Jun 2024 17:19:13 +0200
Date: Fri, 14 Jun 2024 17:19:09 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: bpf@vger.kernel.org, kadlec@netfilter.org, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netfilter-devel@vger.kernel.org, netdev@vger.kernel.org,
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	martin.lau@linux.dev, eddyz87@gmail.com,
	lorenzo.bianconi@redhat.com, toke@redhat.com, fw@strlen.de,
	hawk@kernel.org, horms@kernel.org, donhunte@redhat.com,
	memxor@gmail.com
Subject: Re: [PATCH v4 bpf-next 0/3] netfilter: Add the capability to offload
 flowtable in XDP layer
Message-ID: <Zmxfbf-4htvHKj1T@calendula>
References: <cover.1716987534.git.lorenzo@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1716987534.git.lorenzo@kernel.org>
X-Spam-Score: -1.8 (-)

On Wed, May 29, 2024 at 03:04:29PM +0200, Lorenzo Bianconi wrote:
> Introduce bpf_xdp_flow_lookup kfunc in order to perform the lookup of
> a given flowtable entry based on the fib tuple of incoming traffic.
> bpf_xdp_flow_lookup can be used as building block to offload in XDP
> the sw flowtable processing when the hw support is not available.

Akced-by: Pablo Neira Ayuso <pablo@netfilter.org>

