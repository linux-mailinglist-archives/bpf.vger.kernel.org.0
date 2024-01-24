Return-Path: <bpf+bounces-20241-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8181F83AEC4
	for <lists+bpf@lfdr.de>; Wed, 24 Jan 2024 17:54:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2AC31C22752
	for <lists+bpf@lfdr.de>; Wed, 24 Jan 2024 16:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E9BB7E57D;
	Wed, 24 Jan 2024 16:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nSLH5KLA"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E657A720;
	Wed, 24 Jan 2024 16:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706115231; cv=none; b=IfRMsixpJe1eyly7WXHQq1bESaKqCZrG1mGR480WGhvQ6GfSFa2GzsYNUJGYrTlG+p0pcxAYN+iGsT+rGcqRoXcb6HC1ICdjd/tnnsvq4Kk9woUlriALFP5n+Dy0T0RTTfhm7RAkc5p+ofDhs2bPf51npPIghocpqIwt1veH6Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706115231; c=relaxed/simple;
	bh=NezhQgITHK/gMdeQm+g/azFDFFougWnoVBBRRHG6wmM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZFQrWDWP/CP6J1doLsTNQ8CJt3DodnRC1TebXzotJ+yByj31o30cW6c2d2OHv+WjeESW/rW49mL9gX+0Yz0U8Liw++G8ql/dpqcOSlZupIOJeOF1bcFL7Vxv/H/7GdBbFyslFEMcS1ANTXk/kR5YDqCh8qGb48JZF6ynzk1Hr4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nSLH5KLA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9B2DC433C7;
	Wed, 24 Jan 2024 16:53:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706115231;
	bh=NezhQgITHK/gMdeQm+g/azFDFFougWnoVBBRRHG6wmM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nSLH5KLAFUAG67HFMYy0D5quAvrHQz55T7gezzS2H2txhkbBuGMMgBoWSAzyJUZf2
	 hjtFK8SEa+vOYrhWSi3Z2gX5R28ucUz58p4bhmFf3uGvf8oaqCCw0XjqHZRGkQkirW
	 kMNKWIlpndRlOHLFB7f9i0E8ffutMDEo08iYhleUJEkQ+r4XoSANnIIQxJqGZl/aw2
	 LxFxiu6EXyCrNPjtR66ezAMbehUKzdyKY8W7TOpl5EmtrIJXeVIAQTTG/nLAmHGX5e
	 fFavF2RjbAcmZa93aNgsL+v92SwI0kO8cSvJe9EKkbb0yuIcCQ+t++4pDFKobFMFDf
	 Ey1ENBBrF3PwA==
Date: Wed, 24 Jan 2024 08:53:49 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
 <andrii@kernel.org>, <netdev@vger.kernel.org>, <magnus.karlsson@intel.com>,
 <bjorn@kernel.org>, <echaudro@redhat.com>, <lorenzo@kernel.org>,
 <martin.lau@linux.dev>, <tirthendu.sarkar@intel.com>,
 <john.fastabend@gmail.com>, <horms@kernel.org>
Subject: Re: [PATCH v5 bpf 03/11] xsk: fix usage of multi-buffer BPF helpers
 for ZC XDP
Message-ID: <20240124085349.3e610e24@kernel.org>
In-Reply-To: <ZbD8TWLihi4SZTwR@boxer>
References: <20240122221610.556746-1-maciej.fijalkowski@intel.com>
	<20240122221610.556746-4-maciej.fijalkowski@intel.com>
	<20240123175317.730c2e21@kernel.org>
	<ZbD8TWLihi4SZTwR@boxer>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 24 Jan 2024 13:02:21 +0100 Maciej Fijalkowski wrote:
> > nit: this has just one caller, why not inline these 3 lines? =20
>=20
> we usually rely on compiler to do that, we have the rule "no inlines in
> source files", no?

I mean Ctrl-x Ctrl-v the code, the function has 3 LoC and one caller.
And a semi-meaningless name. I'm not sure why this code was factored
out.

> > nit: prefix the function name, please =20
>=20
> will rename to bpf_xdp_shrink_data(). Thanks for taking a look!

=F0=9F=91=8D=EF=B8=8F

