Return-Path: <bpf+bounces-16335-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5F997FFEB6
	for <lists+bpf@lfdr.de>; Thu, 30 Nov 2023 23:47:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88E562818BA
	for <lists+bpf@lfdr.de>; Thu, 30 Nov 2023 22:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54AA461698;
	Thu, 30 Nov 2023 22:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="lTSJ9oqe"
X-Original-To: bpf@vger.kernel.org
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4074410FC;
	Thu, 30 Nov 2023 14:47:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1701384428;
	bh=8dLRpQZRJvy3YV8A/Ir3qriNVtOM2tI73+ACdhrr2rQ=;
	h=Date:From:To:Cc:Subject:From;
	b=lTSJ9oqeFzhFT3UE4ncKxNBoPrnAkqRQ29/P6OKM5MMD+PWU/8iK2IkAZT6ZaBbtN
	 RwE0ImCLsnrNOaiWrjLebU74Gi4JoF4X4zTYE3UBgU5ODRiiclwVyozQhzqyLTJoj/
	 q37lEhASL3BGtk9QwshjU+k9N4ukFGVnZDKBHR6GsdDJZ3F0Yks8mS9hjkqLMaABJD
	 GmoOg6f4oT9JKjP0EvkXqw6oUHEO1DDh8oF4ksVtrlpZkhw3zY/8LWJwJk0URcQYJS
	 pVQ1UDJh/7J6YUb0Lqk1b7O7NoJh+gUQZKJeKO25l7OjlbvSmdqIvNvsff7Pi/5xU/
	 6OhwYAKEF73KA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4ShBCH3Jthz4xjd;
	Fri,  1 Dec 2023 09:47:07 +1100 (AEDT)
Date: Fri, 1 Dec 2023 09:47:05 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov
 <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, David Miller
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>
Cc: bpf <bpf@vger.kernel.org>, Networking <netdev@vger.kernel.org>, Linux
 Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>, Stanislav Fomichev <sdf@google.com>
Subject: linux-next: manual merge of the bpf-next tree with the net-next
 tree
Message-ID: <20231201094705.1ee3cab8@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/g7K.f..gJSgW3O55nsC/Hs7";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/g7K.f..gJSgW3O55nsC/Hs7
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the bpf-next tree got a conflict in:

  Documentation/netlink/specs/netdev.yaml

between commit:

  839ff60df3ab ("net: page_pool: add nlspec for basic access to page pools")
(and a few following)

from the net-next tree and commit:

  48eb03dd2630 ("xsk: Add TX timestamp and TX checksum offload support")

from the bpf-next tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc Documentation/netlink/specs/netdev.yaml
index 20f75b7d3240,00439bcbd2e3..000000000000
--- a/Documentation/netlink/specs/netdev.yaml
+++ b/Documentation/netlink/specs/netdev.yaml
@@@ -86,112 -97,11 +97,117 @@@ attribute-sets
               See Documentation/networking/xdp-rx-metadata.rst for more de=
tails.
          type: u64
          enum: xdp-rx-metadata
+       -
+         name: xsk-features
+         doc: Bitmask of enabled AF_XDP features.
+         type: u64
+         enum: xsk-flags
 +  -
 +    name: page-pool
 +    attributes:
 +      -
 +        name: id
 +        doc: Unique ID of a Page Pool instance.
 +        type: uint
 +        checks:
 +          min: 1
 +          max: u32-max
 +      -
 +        name: ifindex
 +        doc: |
 +          ifindex of the netdev to which the pool belongs.
 +          May be reported as 0 if the page pool was allocated for a netdev
 +          which got destroyed already (page pools may outlast their netde=
vs
 +          because they wait for all memory to be returned).
 +        type: u32
 +        checks:
 +          min: 1
 +          max: s32-max
 +      -
 +        name: napi-id
 +        doc: Id of NAPI using this Page Pool instance.
 +        type: uint
 +        checks:
 +          min: 1
 +          max: u32-max
 +      -
 +        name: inflight
 +        type: uint
 +        doc: |
 +          Number of outstanding references to this page pool (allocated
 +          but yet to be freed pages). Allocated pages may be held in
 +          socket receive queues, driver receive ring, page pool recycling
 +          ring, the page pool cache, etc.
 +      -
 +        name: inflight-mem
 +        type: uint
 +        doc: |
 +          Amount of memory held by inflight pages.
 +      -
 +        name: detach-time
 +        type: uint
 +        doc: |
 +          Seconds in CLOCK_BOOTTIME of when Page Pool was detached by
 +          the driver. Once detached Page Pool can no longer be used to
 +          allocate memory.
 +          Page Pools wait for all the memory allocated from them to be fr=
eed
 +          before truly disappearing. "Detached" Page Pools cannot be
 +          "re-attached", they are just waiting to disappear.
 +          Attribute is absent if Page Pool has not been detached, and
 +          can still be used to allocate new memory.
 +  -
 +    name: page-pool-info
 +    subset-of: page-pool
 +    attributes:
 +      -
 +        name: id
 +      -
 +        name: ifindex
 +  -
 +    name: page-pool-stats
 +    doc: |
 +      Page pool statistics, see docs for struct page_pool_stats
 +      for information about individual statistics.
 +    attributes:
 +      -
 +        name: info
 +        doc: Page pool identifying information.
 +        type: nest
 +        nested-attributes: page-pool-info
 +      -
 +        name: alloc-fast
 +        type: uint
 +        value: 8 # reserve some attr ids in case we need more metadata la=
ter
 +      -
 +        name: alloc-slow
 +        type: uint
 +      -
 +        name: alloc-slow-high-order
 +        type: uint
 +      -
 +        name: alloc-empty
 +        type: uint
 +      -
 +        name: alloc-refill
 +        type: uint
 +      -
 +        name: alloc-waive
 +        type: uint
 +      -
 +        name: recycle-cached
 +        type: uint
 +      -
 +        name: recycle-cache-full
 +        type: uint
 +      -
 +        name: recycle-ring
 +        type: uint
 +      -
 +        name: recycle-ring-full
 +        type: uint
 +      -
 +        name: recycle-released-refcnt
 +        type: uint
 =20
  operations:
    list:

--Sig_/g7K.f..gJSgW3O55nsC/Hs7
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmVpEOkACgkQAVBC80lX
0GwfMgf/Y1kROolstfCuDvnjO6ADIeEc3IKBtmKNgjjIf0T3bTeb/ZLxhDym70hg
Lfs7Y5AajYBZHPmkt147kNgi+99LvhhL1Ggx2AINKJe6m4rSagoU6RLxg5ywgFO6
VBPU5V614OYM3w6U4cHzeC3mqBpU1CuJcKvm2hzi0IC1V2QXqK65LOgaQltmhfsC
T5KLuJCSWv+5jmFhijMfFrH4Pxv1XHbLHLID3Ko8kls+cvfcWPQLl9NToswXwfVA
AY6cbrWtGOhPAaYgDTP+uCsjc5G+02wlViKPgUfWYIg+7PGouL11pMkPWgfLToY/
LqxId7JLp6rU2KMdDhWVS/v1ija0Zw==
=oTgY
-----END PGP SIGNATURE-----

--Sig_/g7K.f..gJSgW3O55nsC/Hs7--

