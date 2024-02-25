Return-Path: <bpf+bounces-22651-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00D23862A07
	for <lists+bpf@lfdr.de>; Sun, 25 Feb 2024 11:56:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E1AD281DCC
	for <lists+bpf@lfdr.de>; Sun, 25 Feb 2024 10:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE60A101D5;
	Sun, 25 Feb 2024 10:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qX6G+1VH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="toyhiaZj"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 301C39445;
	Sun, 25 Feb 2024 10:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708858566; cv=none; b=NkW6IRMOIHj9CKSelxkUcAMoGl4pYRNFPF9ev9mnz5RqiAWMMrFwqekEwupr1/QE7r4NSEx08rXwwLlsCOP6ziSZbH9dLxH/YOAYFq9VJYxzP3UI2kTSHvgkbevEp2riBgLnahe25FqJ7z2Q5D9Fjk+IISJSL7kKYmUoZPXOivs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708858566; c=relaxed/simple;
	bh=sWBNjHc/lxEoqM9i9D+E3W5ASfrVIdwhk37D2V9TxFA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kgngmvUONbv+p6OrzpWm8B5/WV3YAC+akTnqC6nxn8c2diHpjb/kuadZZXc7PsSonh+Uk6krOihslwk754OHuybTxjnoEitj8tfDujU+gDBv/26dDZPT230gwWRT/MCkGlzXDUMpCMVdxmaSX4PvvwKWQTTbHfLPY81iUDJG7y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qX6G+1VH; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=toyhiaZj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708858554;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tAhOjFXIG9xCvbOQNJwE8wF0tLY2hpMIdA10BdIDOfo=;
	b=qX6G+1VHkEsDsE9ouyrQVD2pczeGb3IdO3iIS7gu9YZ4xRGlH4zdEqBd45v0TxaIxcdH4O
	zKFwI3wa2gZc8WeunwG4DhsmP82g7pSqNOSHpPaeH5CW130DzOwBX7qh8jErD0cO194QSE
	jAgxcXh8cNqz9ei6QlLdgNPn+U3Uq1zsYB7sFvDTfMzIjwc7oJgJjZYnk57XHlg+NUnU2u
	prAX09K/gfsoz7b0ofBGms74u+0na4xOEn0AxlnNb0ZwqsBUMV5VY/bAtER8zqs5oSwt8M
	wVAqCqiUmiO7567i3q4Ml7Shy+Wc2dwox9dDmp7RRThLTpQ5s5do0DLqEGiF7Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708858554;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tAhOjFXIG9xCvbOQNJwE8wF0tLY2hpMIdA10BdIDOfo=;
	b=toyhiaZj4uFJa8bdasGrux2vDUqltoqzkAimBy3wcbRRovUKpHj8bai5Wi49N/YPTntSgB
	mlTofppt70ABSpBw==
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Stanislav Fomichev
 <sdf@google.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu
 <joabreu@synopsys.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Maxime
 Coquelin <mcoquelin.stm32@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel
 Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Song Yoong Siang
 <yoong.siang.song@intel.com>, Serge Semin <fancer.lancer@gmail.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org
Subject: Re: [PATCH net] net: stmmac: Complete meta data only when enabled
In-Reply-To: <ZdjLvrBhW+NIcp85@boxer>
References: <20240222-stmmac_xdp-v1-1-e8d2d2b79ff0@linutronix.de>
 <CAKH8qBsCrYuT+18CsydQ5TeauRzu0Hdz7mZQ2c0W7er0KrJnkg@mail.gmail.com>
 <ZdjLvrBhW+NIcp85@boxer>
Date: Sun, 25 Feb 2024 11:55:52 +0100
Message-ID: <87v86c7qyv.fsf@kurt.kurt.home>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hello Maciej,

On Fri Feb 23 2024, Maciej Fijalkowski wrote:
> On Thu, Feb 22, 2024 at 11:53:14AM -0800, Stanislav Fomichev wrote:
>> On Thu, Feb 22, 2024 at 1:45=E2=80=AFAM Kurt Kanzenbach <kurt@linutronix=
.de> wrote:
>> >
>> > Currently using XDP/ZC sockets on stmmac results in a kernel crash:
>> >
>> > |[  255.822584] Unable to handle kernel NULL pointer dereference at vi=
rtual address 0000000000000000
>
> would be good to explain where it comes from, no?

Sure, no problem.

Thanks,
Kurt

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJHBAEBCgAxFiEEvLm/ssjDfdPf21mSwZPR8qpGc4IFAmXbHLgTHGt1cnRAbGlu
dXRyb25peC5kZQAKCRDBk9HyqkZzggvZEACty2xTOmModE7ISEW06ga7SP33J5oF
BsaLFQi7zC5qOZXJRAjhHtKTWjBb9UcWrqY35MnsloeYqICkfSH08Ik9t9WS5u/m
GkqF1AekS5IX1a6xZeASSix7/kA4PLFr07BBkbArQDhTjk+B6R1HM5/w3AnRjhAu
BOFvBXmEMfelBQGxHYeRkVML0kJp8E62yy1DSNtnBQZZHKYU4qzGlimKZKQZ3R03
qF3ItZGvOZhAg3nLhU1pvWAgCHp1Q9hmeK+AU4Zi5iGfrf/BKsmnHByT3TZfEHe5
g/7UlMrUjIllyQoQ7QruXAV1Z+eqD3IvZknQ9fdMQzrW5Pc7TkUweBzMOdVr4HV+
N+aIYNQYFZe1ElPftecTLpHTDLBg5n/g2TJAv+mAIkFrZWxWdB0viwHApX29nlrR
C0Iu/gjTsRn8+uQ6AArMcXd9Ahf1n3hP9MpsLnZIQZBQ1bRgLjrctJ3M0Fi0tt9u
3WOP5hjSlaR7YQzA8ar0bXstvkk3HStVmvww9GbcIi3sOPTz5CcIP1IcH4qjYs5K
JUqYCzCi+o349yCevOLC8hY2uyS2NpfO+vsY0mA6oGwLBB6/oJ9t2t5Rw7VYAXgs
SOjuseQcAu88gVmZHClGweYRcIEJ9M+20YVIShvxQW8/vFbmU+bbwZavBPE3BW5Y
zj8zV/VllRfdGA==
=aFZy
-----END PGP SIGNATURE-----
--=-=-=--

