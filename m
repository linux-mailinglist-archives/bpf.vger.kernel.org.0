Return-Path: <bpf+bounces-66487-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CF54B35036
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 02:29:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4B097B1BE9
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 00:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5508A226861;
	Tue, 26 Aug 2025 00:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eBf3V3A+"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C947B21770A;
	Tue, 26 Aug 2025 00:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756168169; cv=none; b=BeEmtgKseespmRm27F/wEioICDIGieIf8eboKaoXx+CYvQgruMEYVAn2Nxf8DnbN6tc906VmhAJD9msdsDV4zwvg0fTGI7/vNjqVAYeTdQv7gvV6CLkTfOA3Wh8VOYO3DTbjGjen3gGBCYDd//UubePCjf5UDhOgMg0r8c1u9nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756168169; c=relaxed/simple;
	bh=c4ka3yXC2saU+nD8TM5QKA1lMGev6UR/uHGFvYeGAjU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=co7MLjG9Dk/dRp/Gv2ph7khOAUF+dymvNO5XFInFudAS5841XMS9c4xhc6fuBMfquAqfxPsXxdMJoBiXEpwzHi1+HPjuWiAd9aQtW3mQJJO9OnUBaaQyK2Ls8VlQd2LaCJH0jkgXttB4x92GO+hwLc7HLu+66SIhGKiY2z6FgFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eBf3V3A+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 007F4C4CEED;
	Tue, 26 Aug 2025 00:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756168169;
	bh=c4ka3yXC2saU+nD8TM5QKA1lMGev6UR/uHGFvYeGAjU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eBf3V3A+/Pv5TqVqSbvqxUV5ZsD3XoxkLUSgS0KIjixHCWFbahgZeJVvJfEn2lPZJ
	 UVne6qjPkC7cELzkOTdsjZUrLJXQfkkeQ37NVkKSXyFVARuEvq5jdQveXlNqPkXj94
	 HI0Sjl/aelzqu4qInpVoK82SO4PPdibCh9XEqzrzJV0M+wG2jb3+s8pZDxL9fm8/NL
	 ompcBY2VZqcDh7G6h41m2RyBv40hJrrm5A41H3XuqVAAmL0AGkVNBIT2oF7MDyQNZi
	 +1nvCoEh6UBJ0Kywj0QRORh0M7dcNg5T+ux/lPF3DIsT+qjUfjlY5nOy13KVZA5OP3
	 t5gZaLORtgwAQ==
Date: Mon, 25 Aug 2025 17:29:28 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 bjorn@kernel.org, magnus.karlsson@intel.com, maciej.fijalkowski@intel.com,
 jonathan.lemon@gmail.com, sdf@fomichev.me, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 horms@kernel.org, andrew+netdev@lunn.ch, bpf@vger.kernel.org,
 netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Subject: Re: [PATCH net-next v2 0/9] xsk: improvement performance in copy
 mode
Message-ID: <20250825172928.234fd75c@kernel.org>
In-Reply-To: <CAL+tcoCxzyBxhCes-4OfBAePpQK3jvSRSBufo0eu6afb4hdSaA@mail.gmail.com>
References: <20250825135342.53110-1-kerneljasonxing@gmail.com>
	<20250825104437.5349512c@kernel.org>
	<CAL+tcoCxzyBxhCes-4OfBAePpQK3jvSRSBufo0eu6afb4hdSaA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 26 Aug 2025 08:01:03 +0800 Jason Xing wrote:
> On Tue, Aug 26, 2025 at 1:44=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> =
wrote:
> > On Mon, 25 Aug 2025 21:53:33 +0800 Jason Xing wrote: =20
> > > copy mode:   1,109,754 pps
> > > batch mode:  2,393,498 pps (+115.6%)
> > > xmit.more:   3,024,110 pps (+172.5%)
> > > zc mode:    14,879,414 pps =20
> >
> > I've asked you multiple times to add comparison with the performance
> > of AF_PACKET. What's the disconnect? =20
>=20
> Sorry for missing the question. I'm not very familiar with how to run the
> test based on AF_PACKET. Could you point it out for me? Thanks.
>=20
> I remember the very initial version of AF_XDP was pure AF_PACKET. So
> may I ask why we expect to see the comparison between them?

Pretty sure I told you this at least twice but the point of AF_XDP
is the ZC mode. Without a comparison to AF_PACKET which has similar
functionality optimizing AF_XDP copy mode seems unjustified.

