Return-Path: <bpf+bounces-69536-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B6F0B99929
	for <lists+bpf@lfdr.de>; Wed, 24 Sep 2025 13:27:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4A5F64E0299
	for <lists+bpf@lfdr.de>; Wed, 24 Sep 2025 11:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F2D42E7BCC;
	Wed, 24 Sep 2025 11:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q1GHCSDT"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA3F2877DB;
	Wed, 24 Sep 2025 11:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758713268; cv=none; b=Ug4cQ2Tin06vo4mx8WH75TDSKb3mfkWCO67U9JWqhg0dlllA1zqaO9Mas9vL525gYnxv4VKQq3058CdkXcfJpzFE5gfMdXFHTF6sOheEE7hiGxlZD4kFzDcKIv4aWUWVGHiRVna/F6Eu6mbW4MvKKUKpoqEp17l1dx21D3Wma/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758713268; c=relaxed/simple;
	bh=zUOu4ulqC4rhaNoCJYCbjYRifBVTQcO9unlaf/FjJeg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=OLb9nlbV/wEdcB7u3qF/UDp3A/Hy+JkKhYYnBnPKCgEfc31WDaf9zeylWaUX1WP4IPkQNicoC3jij6TtBTno5Uy5pdv1r1Zpj0M21TOZ5stWmJUE2YSLQVulWtKPg9PfWWjGf6DL4/UDVkXem8O17nZgHp2lzmjB7eXA1CE/zGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q1GHCSDT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B269C4CEE7;
	Wed, 24 Sep 2025 11:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758713268;
	bh=zUOu4ulqC4rhaNoCJYCbjYRifBVTQcO9unlaf/FjJeg=;
	h=Date:From:To:Cc:Subject:From;
	b=q1GHCSDT+MOwapCSBbVSBjXHPzxohwqhD6ghy/G3OgJRFIHuv8RGZBjwEygTcy1Q+
	 8G+BWUXA4apBc2GNKhZ6t595GwY3oRBQwgwJI46eTvL9AqVqdMh0TO/pBZ8l9ziGvf
	 n1IpiAWrf1hT9wNWysnO9fiNAgv6f+irKb2rSmxR1s4h8CIwC0af32pWTQM+sFuDkh
	 59SdxUKu/lvo8LA+tiZsrJ7U0eniPbuM4xYy8CH34sepx/QUAYVWbezTTuDwf9nI1F
	 2ZEPETikj7xe9gogAGMflFhT1z3Dsl5xUlbKG5DF/CMPJxbdw0B6EalglN2oa4qaQA
	 gioFM7PK1QLTg==
Date: Wed, 24 Sep 2025 13:27:44 +0200
From: Mark Brown <broonie@kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
	Networking <netdev@vger.kernel.org>
Cc: Amery Hung <ameryhung@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: linux-next: manual merge of the bpf-next tree with the net-next tree
Message-ID: <aNPVsFPIJUbcepia@finisterre.sirena.org.uk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Ms46dy0Odeo4DFZW"
Content-Disposition: inline


--Ms46dy0Odeo4DFZW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the bpf-next tree got a conflict in:

  include/net/xdp.h

between commits:

  1827f773e4168 ("net: xdp: pass full flags to xdp_update_skb_shared_info()=
")
  6bffdc0f88f85 ("net: xdp: handle frags with unreadable memory")

=66rom the net-next tree and commit:

  8f12d1137c238 ("bpf: Clear pfmemalloc flag when freeing all fragments")

=66rom the bpf-next tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --cc include/net/xdp.h
index 6fd294fa6841d,f288c348a6c13..0000000000000
--- a/include/net/xdp.h
+++ b/include/net/xdp.h
@@@ -126,16 -115,11 +126,21 @@@ static __always_inline void xdp_buff_se
  	xdp->flags |=3D XDP_FLAGS_FRAGS_PF_MEMALLOC;
  }
 =20
 +static __always_inline void xdp_buff_set_frag_unreadable(struct xdp_buff =
*xdp)
 +{
 +	xdp->flags |=3D XDP_FLAGS_FRAGS_UNREADABLE;
 +}
 +
 +static __always_inline u32 xdp_buff_get_skb_flags(const struct xdp_buff *=
xdp)
 +{
 +	return xdp->flags;
 +}
 +
+ static __always_inline void xdp_buff_clear_frag_pfmemalloc(struct xdp_buf=
f *xdp)
+ {
+ 	xdp->flags &=3D ~XDP_FLAGS_FRAGS_PF_MEMALLOC;
+ }
+=20
  static __always_inline void
  xdp_init_buff(struct xdp_buff *xdp, u32 frame_sz, struct xdp_rxq_info *rx=
q)
  {

--Ms46dy0Odeo4DFZW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmjT1a8ACgkQJNaLcl1U
h9DXBAf9HJYzJ29925w09ryPHc1ZVs6mgTV3WZnR8ULVwjvt/6M7Y90NQPsqefMT
Ai9auaIqaTiC8tRsLcX74XgHqABq4jjf/gLcKu+zw3GRPO8lFn2lbyFTXenC25J3
60eISD4nmb2vi04U0dNv891ffKuddE0Qq5E8NZYRHVN4hNmTOhuixXvlRESZvzv3
PS9dIysY5DIUlUQPpvho9vNYvI4Vwm4psrcE+03iveELDeMrFjIOlvn3YTCQHEEt
cakP8JjikRglrFev+ZLqqQGjuD/ZJeqA9KdgSWiOBx0wQE5aHMZqgk/6W79crvMi
QyjPYVWN60AGM9Ir9abjALIZRrawEg==
=ez26
-----END PGP SIGNATURE-----

--Ms46dy0Odeo4DFZW--

