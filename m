Return-Path: <bpf+bounces-65059-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7340B1B4BA
	for <lists+bpf@lfdr.de>; Tue,  5 Aug 2025 15:19:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D14991716FA
	for <lists+bpf@lfdr.de>; Tue,  5 Aug 2025 13:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E777F2749C4;
	Tue,  5 Aug 2025 13:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nxs7nYMF"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DBB71400C;
	Tue,  5 Aug 2025 13:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754399938; cv=none; b=r6hHkY+VUIzedFwdfIZYMHSzKZ3daWXM524JNcPP2Zc93fPbYq1iNrySzSdAThJ/3DyrapzbcBZUYfbso9V3iZ0bP8eMjYXkfcGRIh1FWCMySjF2f2rB6AOULFnO2qZkr20Kg1xyKxEkdJNoyWLyKP2gtQAfPZVMM0Drak5k7lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754399938; c=relaxed/simple;
	bh=OHjUicsUZlkHwdg4ugCFnjwS/GSbn89jRg68HJnS6Qk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LEwPIJMkd4tIPRF5hT9St+WnoavlFYMv9w9kmq0ZYyCEGQcSof8n2f00PrKGown/2MB0tdavAWakN64F2v3gbkSxWuMjkZadZfC9b6Jc9sEuhiLBNvS+Y446sRzB1cLZn+/ugZnZEB9M4G+pIPr0dN4+YTHeHIwjFukIK3osLiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nxs7nYMF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEA16C4CEF0;
	Tue,  5 Aug 2025 13:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754399937;
	bh=OHjUicsUZlkHwdg4ugCFnjwS/GSbn89jRg68HJnS6Qk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nxs7nYMFq3438CqMT1f77mM1aIrryHBbO6BYL/iYXWSkNyDDWV+lyQhBCHvt25Ywf
	 CWSpxFCQhJ60nR5bBcOkyZdbnsAkbGtwrrmgVG2oj3kuY5yjqCPsQ4KMqh/GR4/ty8
	 fzBfyCPwOiiSq+5TBPj0s5xR9uPrfbg1JQhyhQOgkKSP6/7Z/pVL5j5Oo+kUV7Y3ch
	 WFAkKvjWQ27h2O5Gu84+0bTduuB83ciHSetN6izAnClt+jlyfdQSUxbUEyYX63XtQ+
	 umltHvloGoi7TfGWm4dfEvj7fDz39kdbp0KF8qDIF7hdOdX6VUoHC8geKg2F4Fz7g6
	 eHW3ahxiK7JJg==
Date: Tue, 5 Aug 2025 15:18:52 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
	Stanislav Fomichev <stfomichev@gmail.com>, bpf@vger.kernel.org,
	netdev@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <borkmann@iogearbox.net>,
	Eric Dumazet <eric.dumazet@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, sdf@fomichev.me,
	kernel-team@cloudflare.com, arthur@arthurfabre.com,
	jakub@cloudflare.com, Jesse Brandeburg <jbrandeburg@cloudflare.com>
Subject: Re: [PATCH bpf-next V2 0/7] xdp: Allow BPF to set RX hints for
 XDP_REDIRECTed packets
Message-ID: <aJIEvK0CU_BqqgPQ@lore-rh-laptop>
References: <aHeKYZY7l2i1xwel@lore-desk>
 <20250716142015.0b309c71@kernel.org>
 <fbb026f9-54cf-49ba-b0dc-0df0f54c6961@kernel.org>
 <20250717182534.4f305f8a@kernel.org>
 <ebc18aba-d832-4eb6-b626-4ca3a2f27fe2@kernel.org>
 <20250721181344.24d47fa3@kernel.org>
 <aIdWjTCM1nOjiWfC@lore-desk>
 <20250728092956.24a7d09b@kernel.org>
 <aIvdlJts5JQLuzLE@lore-rh-laptop>
 <20250801134045.4344cb44@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="66vdEE4zFPmram4Z"
Content-Disposition: inline
In-Reply-To: <20250801134045.4344cb44@kernel.org>


--66vdEE4zFPmram4Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Aug 01, Jakub Kicinski wrote:
> On Thu, 31 Jul 2025 23:18:12 +0200 Lorenzo Bianconi wrote:
> > IIUC the 'set' proposal (please correct me if I am wrong), the eBPF pro=
gram
> > running on the NIC that is receiving the packet from the wire is suppos=
ed
> > to set (or update) the hw metadata info (e.g. RX HASH or RX checksum) in
> > the RX DMA descriptor associated to the packet to be successively consu=
med.
> > Am I right?
>=20
> I was thinking of doing the SET on the veth side. Basically the
> metadata has to be understood by the stack only at the xdp->skb
> transition point. So we can delay the SET until that moment, carrying
> the information in program-specific format.

ack, I am fine to delay the translation of the HW metadata from a HW
specific format (the one contained in the DMA descriptor) to the network one
when they are consumed to create the SKB (the veth driver in this case) but=
 I
guess we need to copy the info contained in the DMA descriptor into a buffer
that is still valid when veth driver consumes them since the DMA descriptor
can be no longer available at that time. Do you agree or am I missing
something?

Regards,
Lorenzo

--66vdEE4zFPmram4Z
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaJIEuQAKCRA6cBh0uS2t
rJbPAQCnVy8nP3hB/qWMJSu1eNJ1JX7a1KpWvpfyQyV0rX2bogD8DmdzDldwqaiM
HpeJWr+DYgj9ZOy59fcG7G3l2SjHoAs=
=KBt3
-----END PGP SIGNATURE-----

--66vdEE4zFPmram4Z--

