Return-Path: <bpf+bounces-70920-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0040DBDB0CF
	for <lists+bpf@lfdr.de>; Tue, 14 Oct 2025 21:24:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FEAF1928507
	for <lists+bpf@lfdr.de>; Tue, 14 Oct 2025 19:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 946ED2C08A1;
	Tue, 14 Oct 2025 19:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c1hFUaec"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B5D235072;
	Tue, 14 Oct 2025 19:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760469884; cv=none; b=M2OCaSmYDhAe3dc6fztLUgGoIUZ9p2wADgn0K5nO+Bf7Xaic2Z+u4EOZtp3lC+lICre9aFCKfhbBxmOVYMHVA7Pj4N5aN8TeXSukbnhY6nG847zzZQ9Y61+cciaCFsY3J9eU4VMqFwN5D0dsyyvlFZj8c4PX1KX/ItOY5qXX+XI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760469884; c=relaxed/simple;
	bh=QGe+pGQFHQbcVEStq8maDcz98J92lr2mU5ZxO9m81Ic=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JA0JcWin9QyTEOEi6hTCOIwCsatFStGiCmQwmpM9cafwUaxzWniR6Xo2KdFBsncsb6N3691zMSg7cYhdmTYYeRZ8ZFlYBFpevmJO0Wt4pNKTPh5ScgkrPRSy8M4AEg8ZCilTDCH7x9Su1AtjrSxM/M5JfbGskHEeJKFD2ioKZ6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c1hFUaec; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55FA8C4CEE7;
	Tue, 14 Oct 2025 19:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760469883;
	bh=QGe+pGQFHQbcVEStq8maDcz98J92lr2mU5ZxO9m81Ic=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=c1hFUaecXpGdRIVnyNf6AJezyzSHTo+5Ej+80A7exJEqoYR364SYaCcz7LnJ+QSk1
	 F9WDSbc4bmJ+MQ+TFd4enzMBwZSi5517S/NSoGsDgAR57IIoXBqzHsIN+yDl1LBt5/
	 jpm7gsg7M1sTw4UyMjEpl/MrcEfbHdgFKMYCm6hT4q9JY2XmPGHJwm3kDpZS4cRCGd
	 9YKGVEHdWOQOctFV9BMWUUOk93VtoyppcLex8yls5DBzRBEDx26Q/gOW2NR6CHV/SY
	 pVDHjgmPgo2r/upnopBU2sDSLn23RYrMOg30dm25/WiQY4nUBlmBN8Xo48Vg39AZ+I
	 Q9oh3urG2S0FQ==
Date: Tue, 14 Oct 2025 12:24:41 -0700
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
Message-ID: <20251014122441.27e2d267@kernel.org>
In-Reply-To: <d3f1427f-e8bc-4ab0-bf15-171b701325b9@fiberby.net>
References: <20251013165005.83659-1-ast@fiberby.net>
	<20251013165005.83659-2-ast@fiberby.net>
	<20251013175331.281ec43e@kernel.org>
	<d3f1427f-e8bc-4ab0-bf15-171b701325b9@fiberby.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 14 Oct 2025 16:49:22 +0000 Asbj=C3=B8rn Sloth T=C3=B8nnesen wrote:
> On 10/14/25 12:53 AM, Jakub Kicinski wrote:
> > On Mon, 13 Oct 2025 16:49:58 +0000 Asbj=C3=B8rn Sloth T=C3=B8nnesen wro=
te: =20
> >> Instead of pre-computing the flag values within the code generator,
> >> then move the bitshift operation into the generated code.
> >>
> >> This IMHO makes the generated code read more like handwritten code. =20
> >=20
> > I like it the way it is. The values are irrelevant. =20
>=20
> Bit-shifting seams like the preferred way across the uAPI headers.
>=20
> Would you be open to hexadecimal notation, if not bit-shifting?
>=20
> Currently NLA_POLICY_MASK() is generated with a hexadecimal mask, and
> with these patches, if render-max is not set. If using literal values
> then we should properly consistently generate them as either decimal
> or hexadecimal. I prefer hexadecimal over decimal.

Hm, hex could do. For the bit/1 << x i really don't like that the values
are not aligned to columns, so they visually mix in with the names.=20
But aligning them would be more LoC than it's worth.

hex could be a reasonable compromise, but I make no promise that I will
like it once I see the result :)

> > And returning a string from user_value() is quite ugly. =20
> It only returns a string, when as_c is set, I am happy to duplicate
> some code instead, and add a dedicated method always returning a string,
> but can we please agree on the generated output, before implementation?

nlspec.py was supposed to be a library that abstracts away things like
default values not being present, and simplifies indexing. So having a
"give me a format for C as result" arg is not great for layering.
That kind of logic belongs in the caller.=20

Regarding LoC - great code is concise, but that doesn't mean that
making code shorter always makes it better.

