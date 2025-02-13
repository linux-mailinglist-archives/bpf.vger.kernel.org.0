Return-Path: <bpf+bounces-51406-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D280FA33EB6
	for <lists+bpf@lfdr.de>; Thu, 13 Feb 2025 13:03:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9CEB3A7B9C
	for <lists+bpf@lfdr.de>; Thu, 13 Feb 2025 12:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 886BF21D3E9;
	Thu, 13 Feb 2025 12:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gFnFW5Ur";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9+v/6FZN"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ADE6227E9A;
	Thu, 13 Feb 2025 12:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739448113; cv=none; b=tHTkkjYfevIrw8HtmvShLwdaZ73ZPgP80Hkt0zY7YvN2XZJouK/4e1KXpwrO3hIdnaJHAjt/0zvW1wUkUJjfMgwkX1yQeU7z1+0KoPUC1GBvQgvBynLEAYIbeWflpx4bEMtnwwcCzgMrm6skTk9dAInOmvEQzC4rr6+u4FJXFRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739448113; c=relaxed/simple;
	bh=LKMHuNPPkuNjr4aP7tRkLW49lzIpoHFE3xxDh7u4ieE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HiMPSC5obgRrq60K1sP/5joHjfM05u7Vlz7XEcyPwqpEoSYSXrgWEGAyHl4EhIW+R0n4i07pmkarwAW8rDIbbyzuFiMvKK3KlLj9IzE3ejrJvBeNn72GAz8RMXOlNvs5PdnKIAVbqqhkC2CrVsNvsYNLDTB3NJwOZIY5bZ6jPAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gFnFW5Ur; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9+v/6FZN; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739448108;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pRi2by4hF7BVnwNBoTgAL9CtmnTqhyTscqUsWMsbLkE=;
	b=gFnFW5UrQOTpQ94swvZhMjxhGMXUmdllUKHeuFDQK0Iv3lEv7WPpWaXIeU5VL+qcOcmSEn
	kGMFK7iK7mxHYqifI8t7JJaghZu2pWmuNoQZl0H/sS7hc2aAzfJY6uTiz/VUKKb7ufyDvV
	GekiQzi55/iKXCpEU4TxkCFiALIeyIQPOqcDMIikhz9AHKLpm+BCrMkwt7jpDMpW6HskPB
	hTRniWF9zZf9BG1JpYfgOZs2UR+ANvzHYViC0g9vGZOrDUFkZONfFBHYpZxzRzJbGw8yny
	M+2fk9vdaXEG3xtJ/5zxxLJkdMMQyeOe1ee5wJ8rxGbSPv4p9zhZC5qrn+aYNA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739448108;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pRi2by4hF7BVnwNBoTgAL9CtmnTqhyTscqUsWMsbLkE=;
	b=9+v/6FZN9iYWg8vy7Kso1fLjYJd3UKBNQLlk/DBk8uSIJsOASKi30BUOPU3IuSdJHsDXLY
	ZN2gspy0UDfIpSBw==
To: "Abdul Rahim, Faizal" <faizal.abdul.rahim@linux.intel.com>, Vladimir
 Oltean <vladimir.oltean@nxp.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, Simon Horman
 <horms@kernel.org>, Russell King <linux@armlinux.org.uk>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, Furong Xu <0x1207@gmail.com>, Russell King
 <rmk+kernel@armlinux.org.uk>, Serge Semin <fancer.lancer@gmail.com>,
 Xiaolei Wang <xiaolei.wang@windriver.com>, Suraj Jaiswal
 <quic_jsuraj@quicinc.com>, Kory Maincent <kory.maincent@bootlin.com>, Gal
 Pressman <gal@nvidia.com>, Jesper Nilsson <jesper.nilsson@axis.com>,
 Andrew Halaney <ahalaney@redhat.com>, Choong Yong Liang
 <yong.liang.choong@linux.intel.com>, Kunihiko Hayashi
 <hayashi.kunihiko@socionext.com>, Vinicius Costa Gomes
 <vinicius.gomes@intel.com>, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org
Subject: Re: [PATCH iwl-next v4 0/9] igc: Add support for Frame Preemption
 feature in IGC
In-Reply-To: <b19357dc-590d-458c-9646-ee5993916044@linux.intel.com>
References: <20250210070207.2615418-1-faizal.abdul.rahim@linux.intel.com>
 <20250210070207.2615418-1-faizal.abdul.rahim@linux.intel.com>
 <20250212220121.ici3qll66pfoov62@skbuf>
 <b19357dc-590d-458c-9646-ee5993916044@linux.intel.com>
Date: Thu, 13 Feb 2025 13:01:46 +0100
Message-ID: <87cyfmnjdh.fsf@kurt.kurt.home>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu Feb 13 2025, Abdul Rahim, Faizal wrote:
> On 13/2/2025 6:01 am, Vladimir Oltean wrote:
>> On Mon, Feb 10, 2025 at 02:01:58AM -0500, Faizal Rahim wrote:
>>> Introduces support for the FPE feature in the IGC driver.
>>>
>>> The patches aligns with the upstream FPE API:
>>> https://patchwork.kernel.org/project/netdevbpf/cover/20230220122343.115=
6614-1-vladimir.oltean@nxp.com/
>>> https://patchwork.kernel.org/project/netdevbpf/cover/20230119122705.730=
54-1-vladimir.oltean@nxp.com/
>>>
>>> It builds upon earlier work:
>>> https://patchwork.kernel.org/project/netdevbpf/cover/20220520011538.109=
8888-1-vinicius.gomes@intel.com/
>>>
>>> The patch series adds the following functionalities to the IGC driver:
>>> a) Configure FPE using `ethtool --set-mm`.
>>> b) Display FPE settings via `ethtool --show-mm`.
>>> c) View FPE statistics using `ethtool --include-statistics --show-mm'.
>>> e) Enable preemptible/express queue with `fp`:
>>>     tc qdisc add ... root taprio \
>>>     fp E E P P
>>=20
>> Any reason why you are only enabling the preemptible traffic classes
>> with taprio, and not with mqprio as well? I see there will have to be
>> some work harmonizing igc's existing understanding of ring priorities
>> with what Kurt did in 9f3297511dae ("igc: Add MQPRIO offload support"),
>> and I was kind of expecting to see a proposal for that as part of this.
>>
>
> I was planning to enable fpe + mqprio separately since it requires extra=
=20
> effort to explore mqprio with preemptible rings, ring priorities, and=20
> testing to ensure it works properly and there are no regressions.

Well, my idea was to move the current mqprio offload implementation from
legacy TSN Tx mode to the normal TSN Tx mode. Then, taprio and mqprio
can share the same code (with or without fpe). I have a draft patch
ready for that. What do you think about it?

Thanks,
Kurt

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJHBAEBCgAxFiEEvLm/ssjDfdPf21mSwZPR8qpGc4IFAmet3yoTHGt1cnRAbGlu
dXRyb25peC5kZQAKCRDBk9HyqkZzgvLKD/9OQPyBrZSv022P25tXUsH7EuBaRKfA
aeLF85hUvtWB9bw1NihFYJsALhL8ouo+CTO9pvlnFlsgtgiB14KLrjShhefXZfTI
Prjpei01Kyb2te+XqjCBmnrz5DriDwUQjDVSxd8WlfuFhm/FquQCp3fATF083LBZ
T7fIsaLnoehBkUj5oMTgFu9EGRD+Pdnq9pQT94pHVPfSc1azLAU8LXzsXqOuCelK
VkM40CJm5hZwRAQz+rl2C6ji7qAukJ7tof61Cj6c6i7jTZAvbZ52QOUlubYNUNsL
yh4fGcYxLIJDp6yZz05Nf3KuEISjRcpxlEQxZF9vcfgSFa8cgwAZdnFdAnG9RH5F
BnO6hhrtoqi9jmDjQbnnROdxeK1zELqhRNmWe7aa6USiiziLg6OHVKBeB9gGQ0B6
F5XuwQjdfb96Mewy4S67FxwN0Ze53X7cqmUfk5WLESArCxrN2LMTuwOCsfYbBgpc
NXeqyFzLrHtvb7nMZkONVsXSAYDqsQ+Q3Ms9DLOUh5+jvn9c8XPEJkNNoG0sQznS
HSGN81QFGjkDACF/D7eiWrA7e6NoJoPMOdeyruHj2ejkZH+0FFA+p7qrWvwytOEx
rT4GG3JqWLcEs/W/1KZbNf7yioJf+kPIxbS7TxBxy+W+dy8DhDA6cJNEspn6uhqw
mbELAM6QhMYsxg==
=HZMH
-----END PGP SIGNATURE-----
--=-=-=--

