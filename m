Return-Path: <bpf+bounces-73961-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DCC3AC40B07
	for <lists+bpf@lfdr.de>; Fri, 07 Nov 2025 16:55:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38B2F188F3A8
	for <lists+bpf@lfdr.de>; Fri,  7 Nov 2025 15:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0FE132E68E;
	Fri,  7 Nov 2025 15:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UTpdB5TR"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60ED02C237E;
	Fri,  7 Nov 2025 15:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762530872; cv=none; b=jZFQpKMjRqaltol7Bw9RrLvIHOSueEbIjcolVpjfJNF37PIk6lAOSKyoUbgFJWn9VLPhdp01oEFWjKfI3bJZNxSuth0RKj6IAagIjLOthhlbOVZEK4Yyte/Kkffn9Hmj4btPQz1Mbkcw46DwgJ4AQfh3N9tQj1PP6fLxjRsecBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762530872; c=relaxed/simple;
	bh=K+CYTJmhXzXtU1VvrV2fmqOB1GMwfv/N3ycEEm7Wqa0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h0T46QSFCfX/+tuIZNK6lFjlLyKRCrf8R1kiJvq7FghbMyuDg3P0Y+cCLlN3iOPm/PGneTTkQ+1audL7veoSK6pFJoCZNvfdhXTxnz1a9SX1MhymZ04LKZt92P2CV+0ChEO2JNPoLQN0dQHfYQZ2bPqChap6O2VYRt8NRtpAtNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UTpdB5TR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83A62C16AAE;
	Fri,  7 Nov 2025 15:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762530872;
	bh=K+CYTJmhXzXtU1VvrV2fmqOB1GMwfv/N3ycEEm7Wqa0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UTpdB5TRgLJ30KkodfimJdie1f/Pphfg7S/pOXZMlb4Tdplr820nZLaVYM8MtnRpC
	 40k6JG25OWjB0+lalrF7WZnXryl4EywsUmhW8x55oTqsDsyeW7jAs6Whxtpzv6lPXA
	 X777lCThGMC67so341CoWBY0Q9aVbDTPWz0xmiaE9k2loCesaB3gQntubOUWaa+zjZ
	 8Ngu2FeRVYXFLZZzlJPGOKXvMWw5Ph9rFSDpNlXVZ53IL5Bady0UHK5wZNYyOm5y3V
	 6gM83txzkgiMo3pEZSQX6YhLSg5/VnPXccFhhuxnxO5gzkc4w3i+A5x0Ujlu1Bq4Lq
	 8/motA70DKhLQ==
Date: Fri, 7 Nov 2025 07:54:30 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, davem@davemloft.net,
 razor@blackwall.org, pabeni@redhat.com, willemb@google.com,
 sdf@fomichev.me, john.fastabend@gmail.com, martin.lau@kernel.org,
 jordan@jrife.io, maciej.fijalkowski@intel.com, magnus.karlsson@intel.com,
 dw@davidwei.uk, toke@redhat.com, yangzhenze@bytedance.com,
 wangdongdong.6@bytedance.com
Subject: Re: [PATCH net-next v4 11/14] netkit: Implement
 rtnl_link_ops->alloc and ndo_queue_create
Message-ID: <20251107075430.6a4f32ff@kernel.org>
In-Reply-To: <12551093-9384-4801-b2d1-a5505a87f9b4@iogearbox.net>
References: <20251031212103.310683-1-daniel@iogearbox.net>
	<20251031212103.310683-12-daniel@iogearbox.net>
	<20251106164106.7b858706@kernel.org>
	<12551093-9384-4801-b2d1-a5505a87f9b4@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 7 Nov 2025 16:01:44 +0100 Daniel Borkmann wrote:
> On 11/7/25 1:41 AM, Jakub Kicinski wrote:
> > On Fri, 31 Oct 2025 22:21:00 +0100 Daniel Borkmann wrote: =20
> >> +static void netkit_get_channels(struct net_device *dev,
> >> +				struct ethtool_channels *channels)
> >> +{
> >> +	channels->max_rx =3D dev->num_rx_queues;
> >> +	channels->max_tx =3D dev->num_tx_queues;
> >> +	channels->max_other =3D 0;
> >> +	channels->max_combined =3D 1;
> >> +	channels->rx_count =3D dev->real_num_rx_queues;
> >> +	channels->tx_count =3D dev->real_num_tx_queues;
> >> +	channels->other_count =3D 0;
> >> +	channels->combined_count =3D 0;
> >>   } =20
> >=20
> > Why do we need to implement get_channels? =20
>=20
> Thanks for the feedback. I think this one was useful imho since it allowed
> for introspection via ethtool on netkit side e.g. the max_rx vs rx_count.

Right, but we have netdev-nl queue-get now which also reports the new
"lease"/"peer" info so it will be much clearer.

Ah, is this because libbpf looks at channels to figure out the queue
count? Can we make it use netdev-nl ?

I guess it could also count the entries in $sysfs/queues/rx-* but that
doesn't express the fact that queue 0 is unusable. Which I suppose the
get_channels implementation was trying to "express" by setting
max_combined=3D1 ? =F0=9F=98=B6=EF=B8=8F

