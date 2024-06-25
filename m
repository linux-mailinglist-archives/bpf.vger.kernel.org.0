Return-Path: <bpf+bounces-33070-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 547C1916DB0
	for <lists+bpf@lfdr.de>; Tue, 25 Jun 2024 18:04:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85B701C22CAF
	for <lists+bpf@lfdr.de>; Tue, 25 Jun 2024 16:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F69F17107C;
	Tue, 25 Jun 2024 16:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hFkQ6LF5"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879B21607A4;
	Tue, 25 Jun 2024 16:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719331432; cv=none; b=jQd7lbjsnHZ1xj+ocLCeivz/TrJcP3tTMRaGxYZizWEr6X4MdHEVPF9hnBT6Y72Y4l85WrII2fU1Bl5qfknhP8LAY1yU8ZHoLXgOBmmMJfxdcraaPLZVuj0zIthn6GST1cZhfc5q+PqBxBVHsEYn331SlMXkj2iCxwUf7kFiTCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719331432; c=relaxed/simple;
	bh=Y8zvoHUAQ6E9tju5DAZj3duYamVhaNp9orEJwp6fjSg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FuRMx/C+9RBkcVjrqWe73zUYaG6xWpXo66O/DzseE1sP5ZQ+IpzOW3a8GI5b6+O0aEoRBKuynrnCxdxr4hgzMpoCggjdi/D8/0V2lYUIUPArzVbOBJzF0F4ESXYc/bc5FCwG0abGPmdXMpVbDv16w0uWjW+6wApiBwtc5uPhPfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hFkQ6LF5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92C8AC32781;
	Tue, 25 Jun 2024 16:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719331432;
	bh=Y8zvoHUAQ6E9tju5DAZj3duYamVhaNp9orEJwp6fjSg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hFkQ6LF56fezBbXVsx6mY+PbtHpcuJypoJdE4yZI4kCqvQ4ZkOkmrhzNnbK386YcL
	 Wo/AP184WAE6JUtJ1hMOKKYPd3/Jfx+vDVHoh2KprzBJHXCGTrVc3jkTM5tA3+Uqei
	 h0p+nBYOt1BzjP2blvXAlaLZExNV4/jJ7WAebLeKR6ZmVNzQ7JO0tuXBpS5LYTvEhw
	 AWW3xH+La49wTVUk6PatO2UhbSiLbYnoJMbmabF/6rTLkMN3wyJPzHfX7laVz2KUty
	 wlPRoAmex6f04cjFA68TYrFAMXpMKK82HAD+5898PONWaeiAt+JBPcp1kGPJghzdQR
	 b5N0/mpy9ULzQ==
Date: Tue, 25 Jun 2024 17:03:46 +0100
From: Mark Brown <broonie@kernel.org>
To: Benjamin Tissoires <bentiss@kernel.org>
Cc: Thinker Li <thinker.li@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
	Networking <netdev@vger.kernel.org>, Jiri Kosina <jikos@kernel.org>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	linux-input@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the bpf-next tree
Message-ID: <72caa9df-5806-4729-ae54-b185e557e707@sirena.org.uk>
References: <ZnB9X1Jj6c04ufC0@sirena.org.uk>
 <CAFVMQ6R8ZZE+9jWM1vhEuz2PsLyCgKhpaVD377TKEu4AfGO_iA@mail.gmail.com>
 <ud5j6hbozgg6em43volidpffykdtd2lpf32etmdiyksorl2cb4@whtseaibw2xw>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="TPBmgX5q1nLjiXwu"
Content-Disposition: inline
In-Reply-To: <ud5j6hbozgg6em43volidpffykdtd2lpf32etmdiyksorl2cb4@whtseaibw2xw>
X-Cookie: Results vary by individual.


--TPBmgX5q1nLjiXwu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 25, 2024 at 05:54:47PM +0200, Benjamin Tissoires wrote:
> On Jun 24 2024, Thinker Li wrote:

> > However, I suggest you implement ".update" if you think it is
> > reasonable for HID,
> > although it is not a MUST-BE. ".update" provides a good feature that
> > user space programs
> > can update an implementation on the flight.

> FWIW, Mark handles linux-next, so not sure he has deep knowledge of
> HID-BPF, and not sure he wants too :)

Only holiday cover but yes.

--TPBmgX5q1nLjiXwu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZ66mEACgkQJNaLcl1U
h9BQogf+LEeo7TZubksELi3+Li3QTObF77QLOOuzIkAiep5ZV5i0Q0T21TTB3E0E
cCF661ItvcruzKYpIUbrki0hloiTe9m4LqFKn/Cavgy2vtH75z0tI7mfe2tBd5q3
9M1TDaLJ0i/+CwMwAS5Yxg/l3X4qpOjEsKFvVvQY1yOTpybqHwFc0bwcZPCdQ6wp
qAgowFcBx1PR+oUlRtMDqWRqd+8/0mudj7XdgE4Po7r1FO3iRMYhwZxkvXUldMNd
0pd/JHnvl+FQGORRb/CvaEAQJVPcOAYrWzF5zP4qEh9LmHu++d3gdJNAkshMNbbc
sQAzyr09r750cYq7fBtOT5jBLhyEJg==
=MFwz
-----END PGP SIGNATURE-----

--TPBmgX5q1nLjiXwu--

