Return-Path: <bpf+bounces-20917-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED9FB8450B7
	for <lists+bpf@lfdr.de>; Thu,  1 Feb 2024 06:32:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D14DA1C225D0
	for <lists+bpf@lfdr.de>; Thu,  1 Feb 2024 05:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFBF03CF51;
	Thu,  1 Feb 2024 05:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="prQsizSH"
X-Original-To: bpf@vger.kernel.org
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA1093C47C;
	Thu,  1 Feb 2024 05:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706765517; cv=none; b=QLlXY60EkcXbzr3nj1aWvgyIkpjWGWnm2Nu8aYNVGtSafTw8f7Vcs2zG7hxilmT7A2oaeykmSBdlndW7DHf/djWu8qalJ0dUr5fkCfdxNh0xHVS/BBJM70sn0w1YtTSbiDPdlFzk5Cp8Mbb9JlYNp/jUC0hwGIuH53QTx+XGUpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706765517; c=relaxed/simple;
	bh=WHpCOZePbBwBglVW5QS+vkPT0PP9bu8zGm2jCuH0QLE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rROPxI+/fYCnjW3JWhk2zVUHptrZrWrajlfHpxL+8WbezOkxA2oBzv34p0aNxIoPxdDbXCsKIyQbfjkExjlqb0Wxqb6L4ezEeADi8Te2dWAigtSRLbElUYnKU9CO0AVaQBQSBRbD+fhUNK2OUa6H2pZKFYIVRxOZNJ9UZwahmu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=prQsizSH; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1706765511;
	bh=Wq0OX9iGYMKibk/yBWk9PuT0P3GOtaz4/wfWoStPuyw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=prQsizSHB4wI7s7V/lWkXuWATRv8tET3RHgQM+ydf7ao3/Hno1dOQt/m7QDNIPsOd
	 A5MXTbViJMu/hIsZUmbGOl2cPTpzJJUZBkLjnwPlzshDm9KZpOS6D/N2pPHU+cQ2/2
	 fv8ZH15ztXs5JpsdeXko041lKX7bFU55AmqZp0JPhAIgkizSHh/2/qpLFX7PQE+4cK
	 GciEv/t+jDMCoOpCqw7n/FsLXGrzAKDVjzWM8oC7J8Rcu7dQzfFSsmErN31mMgBhOT
	 exgLgpsggmw5kLKCM8eoR3qwb5GhXGI8WatA84FNxsQsXMWbi9tNz08oNBW/zvUUnT
	 I9qruzEoN7KSQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TQSFg0DYSz4wp0;
	Thu,  1 Feb 2024 16:31:50 +1100 (AEDT)
Date: Thu, 1 Feb 2024 16:31:49 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Daniel Xu <dxu@dxuuu.xyz>, Daniel Borkmann <daniel@iogearbox.net>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 bpf <bpf@vger.kernel.org>, Networking <netdev@vger.kernel.org>, Linux
 Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: Re: linux-next: runtime warnings after merge of the bpf-next tree
Message-ID: <20240201163149.0d02fe46@canb.auug.org.au>
In-Reply-To: <CAADnVQJT8nOiiX90g3Pm7Ud0hzBBjBOQmPtPV1iwUYKMcuBFig@mail.gmail.com>
References: <20240201142348.38ac52d5@canb.auug.org.au>
	<yeujnwul3nd6vhk2pidnh72l5lx4zp4sgup4qzgbe2fpex42yf@2wtt67dvl7s3>
	<CAADnVQJT8nOiiX90g3Pm7Ud0hzBBjBOQmPtPV1iwUYKMcuBFig@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/rVS2M8ZBg49XUBcG0i+RcMC";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/rVS2M8ZBg49XUBcG0i+RcMC
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi all,

On Wed, 31 Jan 2024 20:02:28 -0800 Alexei Starovoitov <alexei.starovoitov@g=
mail.com> wrote:
>
> On Wed, Jan 31, 2024 at 7:55=E2=80=AFPM Daniel Xu <dxu@dxuuu.xyz> wrote:
> >
> > diff --git a/include/linux/btf_ids.h b/include/linux/btf_ids.h
> > index 0fe4f1cd1918..e24aabfe8ecc 100644
> > --- a/include/linux/btf_ids.h
> > +++ b/include/linux/btf_ids.h
> > @@ -227,7 +227,7 @@ BTF_SET8_END(name)
> >  #define BTF_SET_END(name)
> >  #define BTF_SET8_START(name) static struct btf_id_set8 __maybe_unused =
name =3D { 0 };
> >  #define BTF_SET8_END(name)
> > -#define BTF_KFUNCS_START(name) static struct btf_id_set8 __maybe_unuse=
d name =3D { 0 };
> > +#define BTF_KFUNCS_START(name) static struct btf_id_set8 __maybe_unuse=
d name =3D { .flags =3D BTF_SET8_KFUNCS };
> >  #define BTF_KFUNCS_END(name) =20
>=20
> Most likely you're correct.
> Force pushed bpf-next with this fix.

That fixed it for me, thanks.

--=20
Cheers,
Stephen Rothwell

--Sig_/rVS2M8ZBg49XUBcG0i+RcMC
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmW7LMUACgkQAVBC80lX
0Gw6AAgAkhhWhoh7Zm7eJDkxPh29fNJUDPJEluw2WsNh1n2+2xwMBS6Mrsh4f8/d
+lI8AiEvf7G0zr8QHCUbV0oGIeF5ziKkO8zZ7B2MJSQfZerG2LbCjqasjB2on2o5
gWaQrX/PaYN/oox1MAtgEyLWAEnwgDQNM1xXVMACfRyERAdERJC6wKqYqrJPQ44g
GQ8wmaTpXRXFhQc9yni3ZrX0JQEkl97nqyzUvly0Lu2E7fM3okXtvIFRQHlafnmn
z2O/NYTaXMSx7UV35Mg+bJjshOMPeJsp/EhNfbTBtDogo3IGTGk1CNsyIabtMXdN
3qVGz+M514bhN9gXtdqpSOaaqJF9jA==
=GtH/
-----END PGP SIGNATURE-----

--Sig_/rVS2M8ZBg49XUBcG0i+RcMC--

