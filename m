Return-Path: <bpf+bounces-63500-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B20ECB08115
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 01:43:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA23D17BC23
	for <lists+bpf@lfdr.de>; Wed, 16 Jul 2025 23:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9758A2EF671;
	Wed, 16 Jul 2025 23:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oLvFNJs0"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A72E2620D2;
	Wed, 16 Jul 2025 23:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752709394; cv=none; b=qoIOEe/hDQa8KScUmd6GnpV3CXOiw/a6SxG6CfJ06D/JwCpTRbGfPM5i6PrYsOqw/2a2t0txXGn1Zjv88G68moRazBFHm94LuqGdThtPhkKCY0dk1Yt04GXBjc4CTfSYAffBnTWt6j5T6VXnGdXVJ+/YNri/YM7ALOFDYyuLLes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752709394; c=relaxed/simple;
	bh=R2h7ZBT6eJL2QpW4zJlbPvVWUaSaTj1mNjwx4J1T4Xw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bx7LDz9lG1XLR+0dqGB1HmYHDeEE+lGfseQ7v5BZe+UpKN0UHNLnpurMjFcbGXqGTidEPP9aO3kWTyi91c56cHvD+0NNd7M97xVWqxJgHjr+rFo363Y3Tgmwnn9jURc5DGCH0a/9bgmzFkpo6Vfhhg/M5taG33fNIhNLf86dg1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oLvFNJs0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 044CDC4CEE7;
	Wed, 16 Jul 2025 23:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752709393;
	bh=R2h7ZBT6eJL2QpW4zJlbPvVWUaSaTj1mNjwx4J1T4Xw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oLvFNJs0FYdRSU/nquJVvNQikIkoH76ZJAXZ2jTxU0tw6gRwpQtz8QJnudDTbYK5H
	 C8sfn03AG3z2RtT/lMKYckNudQgQTLADgwInMfVHIifNhKswriYsz10/CJX8t8V/Ny
	 IDSrqGyjcgAQqbK/RFI2qOFM2dvhSGP//G5acB4Z9BHWcPd4vfIIPzKTcg+hbk31L7
	 JHUCrRSbkoZ/GLmpCyOSdL3GXcG6DZsxU+83Ux4VQtR655EvG+MmAvMxLC7hGMkGsG
	 mniFYr0MBQeho/Aye8FQm1lGrQyuhWw8MZbNxkG38IvAgOYbITZUxzejqGivTxwtH5
	 1pIfLPtPUCEWQ==
Date: Wed, 16 Jul 2025 16:43:12 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 bjorn@kernel.org, magnus.karlsson@intel.com, maciej.fijalkowski@intel.com,
 jonathan.lemon@gmail.com, sdf@fomichev.me, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 joe@dama.to, willemdebruijn.kernel@gmail.com, bpf@vger.kernel.org,
 netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Subject: Re: [PATCH net-next v2] xsk: skip validating skb list in xmit path
Message-ID: <20250716164312.40a18d2f@kernel.org>
In-Reply-To: <CAL+tcoByyPQX+L3bbAg1hC4YLbnuPrLKidgqKqbyoj0Sny7mxQ@mail.gmail.com>
References: <20250716122725.6088-1-kerneljasonxing@gmail.com>
	<20250716145645.194db702@kernel.org>
	<CAL+tcoByyPQX+L3bbAg1hC4YLbnuPrLKidgqKqbyoj0Sny7mxQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 17 Jul 2025 07:37:42 +0800 Jason Xing wrote:
> On Thu, Jul 17, 2025 at 5:56=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> =
wrote:
> > On Wed, 16 Jul 2025 20:27:25 +0800 Jason Xing wrote: =20
> > > This patch only does one thing that removes validate_xmit_skb_list()
> > > for xsk. =20
> >
> > Please no, I understand that it's fun to optimize the fallback paths
> > but it increases the complexity of the stack. =20
>=20
> Are you suggesting to remove this description? And I see you marked it
> as 'rejected', so it seems that I should use the V1 patch which
> doesn't increase the complexity.

No, I'm questioning optimizing the copy mode AF_XDP in the first place.

