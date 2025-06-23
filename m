Return-Path: <bpf+bounces-61271-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E84B5AE3997
	for <lists+bpf@lfdr.de>; Mon, 23 Jun 2025 11:13:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDFDA3ACB66
	for <lists+bpf@lfdr.de>; Mon, 23 Jun 2025 09:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C59C2231848;
	Mon, 23 Jun 2025 09:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mgWBpimR"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4107A63A9;
	Mon, 23 Jun 2025 09:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750670020; cv=none; b=gnKvh0DzulX85Ykp2LdBUkPjVyTVIGvXbb8hehmbFI4YR9C6PSNrxiz3jFE7Nn36Uklvqt17iDCIJ4ckBdj+OC2paSyxwjdTbkDXIjpiKr3UzueGBQzyQdRf238n15PtzkAMgr46G1R7KEuk5TR3E+0fp7dTTW8rFAdLI5K1Pi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750670020; c=relaxed/simple;
	bh=RTVxXN6hamB6NbmGHb4qVkmVeYkaZYrVdp1uWVXZ/1I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NHj5hfFm0+xSOMOGE5Y9qsE3yjBpCyXfkhdzBQUfvQH/ZvSzK/8KDLPpjDyZWaCTOXYyO+6p+bF9TYa7DIvMTF7X1nr9MTw8mbihsr8Ou8uyV21t5svLRmks1b3RKxPSz78CNMIDP0d4rp7d+X/YV9SAHFzmWyIYES2L6kcRFNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mgWBpimR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C40FC4CEEA;
	Mon, 23 Jun 2025 09:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750670019;
	bh=RTVxXN6hamB6NbmGHb4qVkmVeYkaZYrVdp1uWVXZ/1I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mgWBpimR8E9uhTlt4hZIczqIdcAbcaY3eFGsR86weBsCjs6/8xoMoTJWdLj4D1hbX
	 mcZfB2qpvq5KM7dr4Q6nHXYLPriYrVTGvrmv7IG0nk3JU2v7r+cDsBWxcYtXcFdbIU
	 y3Yw3iXjROYk6Utzf/YbnrBqgcTh/3d0DzDtVy8E=
Date: Mon, 23 Jun 2025 11:13:37 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Paul Chaignon <paul.chaignon@gmail.com>
Cc: stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
	netdev@vger.kernel.org, bpf@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>, Tom Herbert <tom@herbertland.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH stable 5.10,5.15 2/2] bpf: Fix L4 csum update on IPv6 in
 CHECKSUM_COMPLETE
Message-ID: <2025062302-oxford-squiggle-5fa3@gregkh>
References: <0bd9e0321544730642e1b068dd70178d5a3f8804.1750171422.git.paul.chaignon@gmail.com>
 <2ce92c476e4acba76002b69ad71093c5f8a681c6.1750171422.git.paul.chaignon@gmail.com>
 <2025062357-grove-crisply-a3b2@gregkh>
 <aFkYtN3WK19iK0-d@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aFkYtN3WK19iK0-d@mail.gmail.com>

On Mon, Jun 23, 2025 at 11:04:52AM +0200, Paul Chaignon wrote:
> On Mon, Jun 23, 2025 at 10:46:47AM +0200, Greg Kroah-Hartman wrote:
> > On Tue, Jun 17, 2025 at 05:49:21PM +0200, Paul Chaignon wrote:
> > > [ Upstream commit ead7f9b8de65632ef8060b84b0c55049a33cfea1 ]
> > > [ Note: Fixed conflict due to unrelated comment change. ]
> > 
> > This does not apply to the 5.15.y tree at all, due to:
> > 
> > > -		inet_proto_csum_replace_by_diff(ptr, skb, to, is_pseudo, false);
> > > +		inet_proto_csum_replace_by_diff(ptr, skb, to, is_pseudo, is_ipv6);
> > 
> > This chunk.
> > 
> > Can you fix that up and resend just this one?
> 
> It requires the 1/2 patch to apply correctly. I've tested them on the
> tip of 5.15.y (1c700860e8bc). Or is there some reason not to backport
> the 1/2 patch?

Argh, my fault, I applied patch 1/2 to 5.4.y and 5.10.y, not 5.15.y.
I'll go fix that up now, sorry for the noise.

greg "drowning in backports" k-h

