Return-Path: <bpf+bounces-53778-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D49ECA5B597
	for <lists+bpf@lfdr.de>; Tue, 11 Mar 2025 02:04:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6345D3AC74C
	for <lists+bpf@lfdr.de>; Tue, 11 Mar 2025 01:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD42B1DF252;
	Tue, 11 Mar 2025 01:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="e+QjfMHc"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC6B8821;
	Tue, 11 Mar 2025 01:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741655068; cv=none; b=LLqKMhCVYsmX54kqANqifO3UQnWgO+uJnrR5GDKy046+SJrwL8+wvE0Sz1yn5NrO52PwMNmToVAAk8LKieKGTkT6ib9vfTG13WkHNcXOT/ppl/NbmgQLIfu/S90Xb2XuAKXBPOfgG/qelaAQ8mo86MgspY5Xu+iUMYeWCYgrHY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741655068; c=relaxed/simple;
	bh=WN5aRO51rgkoecwp/I5S3MO/oSkd8e+OEIbfwtXNJvI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=KK9GGpSUTe/nheNpOExZPQMz+4sNcwVf3gD5/8fjLlU11UzjykmLD8zmdG4NPkwZTTtA1k2wSU3v/1OIVuBn0tz4liHojf/G66QgTQD90EZch0Lnlgiu+fJILnDLDv1R3+HRw9lCRH7H5qTrNjeI1iCxflV5MXFsm5w3bm49+gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=e+QjfMHc; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1741655063;
	bh=0D/euKKF0UPH3RqK0kJcXY+4ZkJS4h6U/TzArE7xHZc=;
	h=Date:From:To:Cc:Subject:From;
	b=e+QjfMHckv1dwYrvqAbgpCVlev7dSi5H3uCSy76pnOoCtGe+UsMO1LVHo01mKMy47
	 DLLtnsd3VWT52fPb/r9N5ocb24XioH3RfhOBD4uo4LFIIcR5GyJIMVD/0jZjbZEBa4
	 VNO5Vd+g0wz1GCsBIeWuEBxVYKt8F9gRVj9ICAj5Hvl7VBkFdmsn39TdWWdTiDoh+X
	 RcPbES1S2ipTYF6JQD6fPMyMP9wwPMsOi269nG3b230hhaJwBwDl/9+t7bVIUDm7aA
	 6k1gmjjhki8cM7U0AzTegLu+Z6l9kL2CfNBSRtIjZFMTLPMv7JCalnKC+U9j/b/W/H
	 Aoq/TcmLToiYg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4ZBbBb0RgBz4wcw;
	Tue, 11 Mar 2025 12:04:22 +1100 (AEDT)
Date: Tue, 11 Mar 2025 12:04:22 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov
 <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>
Cc: bpf <bpf@vger.kernel.org>, Networking <netdev@vger.kernel.org>, Linux
 Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>, Luiz Capitulino <luizcap@redhat.com>
Subject: linux-next: manual merge of the bpf-next tree with the mm tree
Message-ID: <20250311120422.1d9a8f80@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/TfXnkI6bo6dF_yfrL+Kgukd";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/TfXnkI6bo6dF_yfrL+Kgukd
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the bpf-next tree got a conflict in:

  mm/page_owner.c

between commit:

  a5bc091881fd ("mm: page_owner: use new iteration API")

from the mm-unstable branch of the mm tree and commit:

  8c57b687e833 ("mm, bpf: Introduce free_pages_nolock()")

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

diff --cc mm/page_owner.c
index 849d4a471b6c,90e31d0e3ed7..000000000000
--- a/mm/page_owner.c
+++ b/mm/page_owner.c
@@@ -297,11 -293,17 +297,17 @@@ void __reset_page_owner(struct page *pa
 =20
  	page_owner =3D get_page_owner(page_ext);
  	alloc_handle =3D page_owner->handle;
 +	page_ext_put(page_ext);
 =20
- 	handle =3D save_stack(GFP_NOWAIT | __GFP_NOWARN);
+ 	/*
+ 	 * Do not specify GFP_NOWAIT to make gfpflags_allow_spinning() =3D=3D fa=
lse
+ 	 * to prevent issues in stack_depot_save().
+ 	 * This is similar to try_alloc_pages() gfp flags, but only used
+ 	 * to signal stack_depot to avoid spin_locks.
+ 	 */
+ 	handle =3D save_stack(__GFP_NOWARN);
 -	__update_page_owner_free_handle(page_ext, handle, order, current->pid,
 +	__update_page_owner_free_handle(page, handle, order, current->pid,
  					current->tgid, free_ts_nsec);
 -	page_ext_put(page_ext);
 =20
  	if (alloc_handle !=3D early_handle)
  		/*

--Sig_/TfXnkI6bo6dF_yfrL+Kgukd
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmfPjBYACgkQAVBC80lX
0GwKYgf/RkW3S+s1DhIZXp7EFYkH3UMltg2+hR6K6ZopeQ9SrV+mdwCMY506EWNP
CYCxbiIKdxvkpfi26Kqo+/rkywGN124asToRlz6n3qv+QPGoE5sTzAE+P7ynMn+x
s4JgIOdxXNoSGKXhghED4XkzDXtUxgS5sTTx0zaoH3DVc0mkkU5zlqfzjr1dUU71
1GupL9Xv01ftuwIVJt1Upiid00rMxDaIQjynGEGeBqkI0s0eM3pxC1PuF3bbJvj0
NdxGzlLUZbIVJEqx22O+wrY1q1U1soPKyhgClBPgFRI9Le5FSwfPjwQVVlnMpIIB
4ljCCuVHgvaZq/lxkNXb+8FtlIzP/w==
=dCv+
-----END PGP SIGNATURE-----

--Sig_/TfXnkI6bo6dF_yfrL+Kgukd--

