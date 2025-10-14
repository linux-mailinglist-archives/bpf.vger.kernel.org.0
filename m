Return-Path: <bpf+bounces-70922-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A3445BDB0FC
	for <lists+bpf@lfdr.de>; Tue, 14 Oct 2025 21:32:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 031DA18A0E3B
	for <lists+bpf@lfdr.de>; Tue, 14 Oct 2025 19:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F4742C15A2;
	Tue, 14 Oct 2025 19:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W7xxaZuj"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF89289811;
	Tue, 14 Oct 2025 19:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760470323; cv=none; b=kYYkZNmukTZEVfACigNEM5NvuaYDYimySWNp7U3x8gtCNo0XXFtxQ5Mi2+1DY61JmMhhByUYq1ekiwE/x9Hx1kf4PgLmJVbeC71GFkcLsCsXhWRMbAdPU+7BKPzOjAPLJqy7AEhsl9kaPFhpHni+R07PXSE9fJr/tzntDzb0aRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760470323; c=relaxed/simple;
	bh=iBEy+5YtUp/T62i7bcNjJW06vLT3U4ygCILtkWFHgHg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b0T9RM0UZxJmVUJV+huqUzUSNN/oaUfBHyIxcssrl+KCGDaTvHAwe+z2Dm9uwNKyQC5Ld36N+eWsZRlrXKCyCRmPgAfLRy7Rb/HP92fiZAF37EdEgB53z36WyarMJH6zhYpAqxaZBj5bNB/EZSsa6I7iNuANGifzGiEKHQFXkRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W7xxaZuj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 615C2C4CEE7;
	Tue, 14 Oct 2025 19:32:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760470323;
	bh=iBEy+5YtUp/T62i7bcNjJW06vLT3U4ygCILtkWFHgHg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=W7xxaZujNULBL1tv2wI6zHjtyX5ZnKfy/gen+xLQV3qH+PSrfifdIqqIjsHMCGdnc
	 3kSO9LGhN2++wJYEEf2cr2suIFZ64jXHzM7s3K8fz7xTaWiIvRNJPWtNsmXbclabXi
	 qhXTgQla9R1eTbIHtP0pJ5eesuqqPTn/lEeSs4Wps7M2HeUaA60/8IYJV+3kreZVHf
	 DlaKa6iuWQmjFDod+HLvM2sYCvY277vh6shgrX3/DOE3xFfXLb2HBh/1UMV1KBrV5P
	 kljUuMtTvHCwcp8V/4ND1QzDveuC0/FZhuwTceQnnP5eMx5B66Lx5yaQG52mWWkNYm
	 B5l9N3EqxvBPg==
Date: Tue, 14 Oct 2025 12:32:01 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: =?UTF-8?B?QXNiasO4cm4=?= Sloth =?UTF-8?B?VMO4bm5lc2Vu?=
 <ast@fiberby.net>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov
 <ast@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, Arkadiusz Kubalewski
 <arkadiusz.kubalewski@intel.com>, Daniel Borkmann <daniel@iogearbox.net>,
 Daniel Zahka <daniel.zahka@gmail.com>, Donald Hunter
 <donald.hunter@gmail.com>, Jacob Keller <jacob.e.keller@intel.com>, Jesper
 Dangaard Brouer <hawk@kernel.org>, Jiri Pirko <jiri@resnulli.us>, Joe
 Damato <jdamato@fastly.com>, John Fastabend <john.fastabend@gmail.com>,
 Jonathan Corbet <corbet@lwn.net>, Simon Horman <horms@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdl?=
 =?UTF-8?B?bnNlbg==?= <toke@redhat.com>, Vadim Fedorenko
 <vadim.fedorenko@linux.dev>, Willem de Bruijn <willemb@google.com>,
 bpf@vger.kernel.org, netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: Re: [PATCH net-next 3/6] tools: ynl-gen: use uapi mask definition
 in NLA_POLICY_MASK
Message-ID: <20251014123201.6ecfd146@kernel.org>
In-Reply-To: <bbbdd1a0-2835-44c4-8b9f-942d2309e067@fiberby.net>
References: <20251013165005.83659-1-ast@fiberby.net>
	<20251013165005.83659-4-ast@fiberby.net>
	<20251013175956.7a2fcf6d@kernel.org>
	<bbbdd1a0-2835-44c4-8b9f-942d2309e067@fiberby.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 14 Oct 2025 17:29:30 +0000 Asbj=C3=B8rn Sloth T=C3=B8nnesen wrote:
> On 10/14/25 12:59 AM, Jakub Kicinski wrote:
> > On Mon, 13 Oct 2025 16:50:00 +0000 Asbj=C3=B8rn Sloth T=C3=B8nnesen wro=
te: =20
> >> Currently when generating policies using NLA_POLICY_MASK(), then
> >> we emit a pre-computed decimal mask.
> >>
> >> When render-max is set, then we can re-use the mask definition,
> >> that has been generated in the uapi header. =20
> >=20
> > This will encourage people to render masks in uAPI which just pollutes
> > the uAPI files. =20
>=20
> It might, but is that a problem, given that most flag-sets are rather sma=
ll?

Problem is a strong word. But if the choice is having a constant in
auto-generated code, or pointless, cargo-cult'ed mask values in the=20
uAPI headers - I choose the former.

> Example from include/uapi/linux/wireguard.h:
>  > enum wgpeer_flag {
>  >     WGPEER_F_REMOVE_ME =3D 1U << 0,
>  >     WGPEER_F_REPLACE_ALLOWEDIPS =3D 1U << 1,
>  >     WGPEER_F_UPDATE_ONLY =3D 1U << 2,
>  >     __WGPEER_F_ALL =3D WGPEER_F_REMOVE_ME | WGPEER_F_REPLACE_ALLOWEDIP=
S |
>  >                      WGPEER_F_UPDATE_ONLY
>  > }; =20
>=20
> I agree that a private "WGPEER_F_ALL" would be pollution, but "__WGPEER_F=
_ALL"
> is less likely to accidentally be used by user-space.
>=20
> I get why Jason likes having the __WGPEER_F_ALL in a place where it is ea=
sy
> to review that it has contains all flags, and why he don't like a policy =
like
> NLA_POLICY_MASK(.., 0x7).
>=20
> We could do the mask definition in the kernel code, like many handwritten
> netlink families does, but we still need to keep NETDEV_XDP_ACT_MASK in
> netdev.h or remove it's YNL-GEN header for some time.

It's a transitional problem. People coming from hand-crafted code feel
like they need a human-readable mask. 6mo later once they are
comfortable with YNL codegen they won't care. But, sadly, at that point
it is too late to delete stuff from the uAPI header.

