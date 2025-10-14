Return-Path: <bpf+bounces-70857-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C7E30BD6E58
	for <lists+bpf@lfdr.de>; Tue, 14 Oct 2025 02:53:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AE2014E1D4C
	for <lists+bpf@lfdr.de>; Tue, 14 Oct 2025 00:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE37622068B;
	Tue, 14 Oct 2025 00:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iEJqCu4C"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456322AD2C;
	Tue, 14 Oct 2025 00:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760403214; cv=none; b=SFusq2APdE60UuEirkIDLM354SVURlNKMw+t99nz96JmAcm8yEB+nFeDD9cutQKXxAa4lW38soCgPQQoFANPZG206KikkgdUcp+ok6lnhKOoSAbds58n4jHm0g66Bb4tvHRfa8iTmh8IF5tzc+1mTVpe8J/mMqsR1w7Dzlk5Tdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760403214; c=relaxed/simple;
	bh=mNqwOupU2SMLRLmMQ+NTNloL3ErsCRNSPBF2knNhpzs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nbbWZz0O6AbqpyemKAayLh2kR+p1DMJdTlEZOyTJRncEHUs2OAVbT2LJ3mfbvfXCoiY1ljqwY5SzhvIHJG1rSnLcsUcKm1kw8F3/2rPxmznJpBaUdWxbR2UlB5bfqGSSEGYsk8b51rdPeLgQPmCeK59P38kZt1oQW5+6flBm3B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iEJqCu4C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E16AC4CEE7;
	Tue, 14 Oct 2025 00:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760403213;
	bh=mNqwOupU2SMLRLmMQ+NTNloL3ErsCRNSPBF2knNhpzs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iEJqCu4CYvxOXbhYcebfX/yD2yiUF1DdymhOlUrLI7+R4mLzFc8I8CwupggollCqS
	 74UJ3AppzWj5Je0+8TjaNGl09EFYd8Q91wDT2f06/ic4oxGt1mMR/ZQBAGjqfTAS0Z
	 Mq+heG+P6yDaZTaVbVlG7u+D4QmYDbF7kjS/ZlwK4w+M1KzFe+VTFA1+Xx4rC2dL+n
	 QBb+wyUkx1viBanY3cNhESOk28z6DyTH2daaGdJ1Ic50Zp4XNJTjRsjNHrkb0ColEb
	 gzSkrRU7ETxMPa+4lhC2P8mYvF17d06iSFlnlEmKHWJMUdsvyhMW5+B3KYJmDDKsgP
	 UQvy23vzAB8Fg==
Date: Mon, 13 Oct 2025 17:53:31 -0700
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
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/6] tools: ynl-gen: bitshift the flag values
 in the generated code
Message-ID: <20251013175331.281ec43e@kernel.org>
In-Reply-To: <20251013165005.83659-2-ast@fiberby.net>
References: <20251013165005.83659-1-ast@fiberby.net>
	<20251013165005.83659-2-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 13 Oct 2025 16:49:58 +0000 Asbj=C3=B8rn Sloth T=C3=B8nnesen wrote:
> Instead of pre-computing the flag values within the code generator,
> then move the bitshift operation into the generated code.
>=20
> This IMHO makes the generated code read more like handwritten code.

I like it the way it is. The values are irrelevant.

And returning a string from user_value() is quite ugly.

