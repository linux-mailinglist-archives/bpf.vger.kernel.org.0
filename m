Return-Path: <bpf+bounces-78538-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F1CDDD12342
	for <lists+bpf@lfdr.de>; Mon, 12 Jan 2026 12:15:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EADB43061DE9
	for <lists+bpf@lfdr.de>; Mon, 12 Jan 2026 11:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2E053559CB;
	Mon, 12 Jan 2026 11:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mQP07lSq"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A66521D00A;
	Mon, 12 Jan 2026 11:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768216258; cv=none; b=DiPqIn3e0W7aOmeVLKQX9twO3GcsuagcA7I+5cipJY4lbvVmZqZF8kwD1QZOps6u65LylT2FMBI/L3IyDv+70iTpK4ttNar3bYxswMgx7+Mumkmhh73DsJnxVkHZ9lVeW6yfuEq1mHqEpjsWow12OfrmuUZjFU2Vz5zu16gphOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768216258; c=relaxed/simple;
	bh=Ck8Nal1RWPaSjUvtBJEQhi5pV2c6uQJ61aNGrgs0VLg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KvQtfuQoygp3/SKCrv61PghxJJVsFfO2OpVIxHfu/EhdokqE5iI52G5F/wxf2EMflUJHkvmwiYblk7o1cOUs0OPpxFu1xhN4Bwv1wwdwZpzAKdaegkVCx1m+AphmIlab+mDdBkUfkgntyJxmyuWGiA/FKPsnxtrhVTlPRVl6qZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mQP07lSq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84BFEC16AAE;
	Mon, 12 Jan 2026 11:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1768216258;
	bh=Ck8Nal1RWPaSjUvtBJEQhi5pV2c6uQJ61aNGrgs0VLg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mQP07lSqAd1ZZY4UAQuvVf8xNA3RT2NmgAi8Q1uhpfxv2/+Sm2XMGYLt3lloxL0OU
	 fObie+GMT73KmhuLlPOnZK6MiYXiei13PDO84xV8tj5b39It1RhljL7zs4Id0bChyT
	 1d65NchCCXABIDC6qEvKsRZL5coR2oiEb4KZcZDk=
Date: Mon, 12 Jan 2026 12:10:55 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Keerthana K <keerthana.kalyanasundaram@broadcom.com>
Cc: stable@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org,
	borisp@nvidia.com, john.fastabend@gmail.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	ajay.kaher@broadcom.com, alexey.makhalov@broadcom.com,
	vamsi-krishna.brahmajosyula@broadcom.com, yin.ding@broadcom.com,
	tapas.kundu@broadcom.com, Kuniyuki Iwashima <kuniyu@google.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v6.6.y 2/2] tls: Use __sk_dst_get() and dst_dev_rcu() in
 get_netdev_for_sock().
Message-ID: <2026011246-monoxide-conjuror-9eac@gregkh>
References: <20260112064554.2969656-1-keerthana.kalyanasundaram@broadcom.com>
 <20260112064554.2969656-3-keerthana.kalyanasundaram@broadcom.com>
 <2026011223-tarnish-mustiness-a6bf@gregkh>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2026011223-tarnish-mustiness-a6bf@gregkh>

On Mon, Jan 12, 2026 at 12:05:50PM +0100, Greg KH wrote:
> On Mon, Jan 12, 2026 at 06:45:54AM +0000, Keerthana K wrote:
> > From: Kuniyuki Iwashima <kuniyu@google.com>
> > 
> > [ Upstream commit c65f27b9c3be2269918e1cbad6d8884741f835c5 ]
> > 
> > get_netdev_for_sock() is called during setsockopt(),
> > so not under RCU.
> > 
> > Using sk_dst_get(sk)->dev could trigger UAF.
> > 
> > Let's use __sk_dst_get() and dst_dev_rcu().
> > 
> > Note that the only ->ndo_sk_get_lower_dev() user is
> > bond_sk_get_lower_dev(), which uses RCU.
> > 
> > Fixes: e8f69799810c ("net/tls: Add generic NIC offload infrastructure")
> > Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> > Reviewed-by: Eric Dumazet <edumazet@google.com>
> > Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>
> > Link: https://patch.msgid.link/20250916214758.650211-6-kuniyu@google.com
> > Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> > Signed-off-by: Sasha Levin <sashal@kernel.org>
> > [ Keerthana: Backport to v6.6.y ]
> > Signed-off-by: Keerthana K <keerthana.kalyanasundaram@broadcom.com>
> > ---
> >  net/tls/tls_device.c | 17 ++++++++++-------
> >  1 file changed, 10 insertions(+), 7 deletions(-)
> 
> This is not in 6.12.y, so we can't take it for 6.6.y yet.  Can you
> please send a 6.12.y version and then a new 6.6.y version?

OH nevermind, you sent this already, my fault, sorry.

greg k-h

