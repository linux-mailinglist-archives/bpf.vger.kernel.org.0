Return-Path: <bpf+bounces-57833-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE6C6AB076F
	for <lists+bpf@lfdr.de>; Fri,  9 May 2025 03:29:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 467B11C010D7
	for <lists+bpf@lfdr.de>; Fri,  9 May 2025 01:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46D4582C60;
	Fri,  9 May 2025 01:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nNLRLSjk"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B75EF1339A4;
	Fri,  9 May 2025 01:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746754139; cv=none; b=j/TySeQZqBeSRdKIC+8HyUiyFmIoGt8IfWGFHPqo92PaKZ7I63tT4K4ieix24gJ/ozXd55Ee3cxfWgNvpjs6Eb45X59co3B56i43LwVk9hWCreCGbY+Ahs9ltXK2td02JLFoz5AWxWoVQrIhPaqwx+zGARaG2ncaFhRp3LlZoWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746754139; c=relaxed/simple;
	bh=0WX7lzNhoLFaeUZOspWAuZsL5pC/FLkw1kJVG5zFX4g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F3KPGYIxtGMOeqpUw8xuxqPFA+rGROLH1ViWeagBieT41KZ1v6ITlHWfhFtmEPLj+a/lnsvHbljKxxZLI75iwOPyxge1B22Otd/ZjZ7Us/aBKeDnR7V8XLj3kxbJsBhyuPOcq/F/1EJwPgRpCgehoYZHZf+yWrI8iVVO1xBSktE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nNLRLSjk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B521C4CEE7;
	Fri,  9 May 2025 01:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746754139;
	bh=0WX7lzNhoLFaeUZOspWAuZsL5pC/FLkw1kJVG5zFX4g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nNLRLSjkdMcghiY1dVm9t8X+FLaMwq/+/ytJfE38Y5mo9zG77oUcYCnNrTdCicYeK
	 EAxmxfdNh9r1FBOEECYpNWlKVT6MzrnoEmLPuDNDbowb5LprQSL8DGA7Z5x+CszCoE
	 NG8Je+SJkN+YCPlZEiCSkP92pyXDtmsWvVxC2Xsjc4nwTQNkXD5aYhC/RaRzaHm1id
	 ES5jis2R6cy79IjionLUvPNlfEb+0KxbR6OVbN+Hiot+XZ2bibaXjYLObZ5o1Rb/SR
	 M0gpEWtb8YccuNvLoC/99ELt6RBFTQpS6fZhHiDMU7Khsu9TYmRWc5F9/q+xF75fVE
	 QhICrhizMW5Ww==
Date: Thu, 8 May 2025 18:28:57 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jon Kohler <jon@nutanix.com>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, Willem de Bruijn
 <willemdebruijn.kernel@gmail.com>, Zvi Effron <zeffron@riotgames.com>,
 Stanislav Fomichev <stfomichev@gmail.com>, Jason Wang
 <jasowang@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>,
 Simon Horman <horms@kernel.org>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "bpf@vger.kernel.org"
 <bpf@vger.kernel.org>, Jacob Keller <jacob.e.keller@intel.com>
Subject: Re: [PATCH net-next v3] xdp: Add helpers for head length, headroom,
 and metadata length
Message-ID: <20250508182857.2b60301e@kernel.org>
In-Reply-To: <2121D2EF-E554-4DCB-BB6A-93FB3975B064@nutanix.com>
References: <20250506125242.2685182-1-jon@nutanix.com>
	<aBpKLNPct95KdADM@mini-arch>
	<681b603ac8473_1e4406294a6@willemb.c.googlers.com.notmuch>
	<c8ad3f65-f70e-4c6e-9231-0ae709e87bfe@kernel.org>
	<CAC1LvL3nE14cbQx7Me6oWS88EdpGP4Gx2A0Um4g-Vuxk4m_7Rw@mail.gmail.com>
	<062e886f-7c83-4d46-97f1-ebbce3ca8212@kernel.org>
	<681b96abe7ae4_1f6aad294c9@willemb.c.googlers.com.notmuch>
	<B4F050C6-610F-4D04-88D7-7EF581DA7DF1@nutanix.com>
	<e4cf6912-74fb-441f-ad05-82ea99d81020@kernel.org>
	<6FF98F38-2AE5-4000-8827-81369C3FB429@nutanix.com>
	<b99b73e8-0957-45f8-bd54-6c50640706df@kernel.org>
	<20250507171829.3e8f8a76@kernel.org>
	<2121D2EF-E554-4DCB-BB6A-93FB3975B064@nutanix.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 8 May 2025 03:19:42 +0000 Jon Kohler wrote:
> >> I like xdp_linear_len() as it is descriptive/clear. =20
> >=20
> > FWIW I don't feel strongly but my very weak preference would be=20
> > not to merge this. I already know I'll be looking at the definitions
> > every time. Is it obvious to everyone in this thread whether "headroom"
> > includes the metadata length? It's not obvious to me. But the patch
> > seems quite popular so =F0=9F=A4=B7=EF=B8=8F =20
>=20
> Jespers suggestion to have a DOC: on this hopefully will be helpful.
>=20
> I=E2=80=99ll try my hand that that and see what sort of trouble I can get=
 into

I hate to dwell since I already said I don't feel strongly :) but the
doc is orthogonal, it helps people who don't understand the geometry
to understand it. My concern was that I understand the geometry, but
now I will also need to remember what we decided to call "headroom"
since (unlike skbs) XDP has all sort of stuff packed in front of the
packet data :)

