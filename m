Return-Path: <bpf+bounces-75936-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 28682C9D953
	for <lists+bpf@lfdr.de>; Wed, 03 Dec 2025 03:35:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1CFD0349BC3
	for <lists+bpf@lfdr.de>; Wed,  3 Dec 2025 02:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CC3E23D294;
	Wed,  3 Dec 2025 02:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="N69gnGij"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8D536D507;
	Wed,  3 Dec 2025 02:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764729326; cv=none; b=N32vfik+v6HPSlPRDM+XHg0Q/kD+n8rmLbcw9gLTjryTo3QQ0ZM4X1LrL/aLEWw/+hrjR3UE2VFkauPu4pc4Khgg/9Pe9pMmSNLfzJHRGJ/o9HPuxgtH29itYIn138ty/8oD1/eVJCR2DZSx+9gqoXayVL9r0ju8h7AJ3L4oP4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764729326; c=relaxed/simple;
	bh=/N1sTSZh/utQqpEOjiTWHdbbwwhYCdldlFmtNCTihxc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WEsP2k1yZK8+/He/o80TV0t7dm1Nyf/DnDT+hLJyQ1sthvz3mmu1KtxEdtV5egg46Z3cejHJSmNWS2lqhrXRE8M29R+PI5QMlIOVfuOIPV66VeVC3njeegh9WXfS+Zx8jbVkpvV/bOuKbRq44XyvTSek8aqWYoHJB2IozOXVaUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=N69gnGij; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=202503; t=1764729322;
	bh=OpcxfvipuC6qAL1Z7PjgPVvorNrlmLKd5wXNYLxG5/E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=N69gnGijybexVWhdYAVW7ERecKg0lybsqUk9hDId8/hrk9AYdHnmOGv+rd1wAsQnc
	 Ff1gF0wopYShIOuIOJylcr/7K+bpGEctlJFcvyIt2G9D40LpOXcScaRBXZLqOgyRql
	 6RN8uSj963MXomI35k3r39nBoPpDLYDQXLmC6Melt0vClsqpgjUXHvCJjGFrJs09pX
	 VXsqudvmSUJGGQxc6SC4kn6blz+509sSHxengLFhPMXHOVtuMDurx9cz3k4rCKcJDv
	 WJVRF7yrKsOEC+gNc+6m31Ku2LXe+AAOxE0l0A/hcWwSMViQRxWhQi1Qp7fpOJgI5g
	 PCORtiQ6alCXA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4dLhZJ6RVnz4w23;
	Wed, 03 Dec 2025 13:35:20 +1100 (AEDT)
Date: Wed, 3 Dec 2025 13:35:20 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov
 <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>,
 Arnaud Lecomte <contact@arnaud-lcm.com>, bpf <bpf@vger.kernel.org>,
 Networking <netdev@vger.kernel.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the tip tree with the bpf-next tree
Message-ID: <20251203133520.10ba2705@canb.auug.org.au>
In-Reply-To: <20251105133159.6303b1ee@canb.auug.org.au>
References: <20251105133159.6303b1ee@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/N/lm28FJl68ZE/B3Wqf=kUv";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/N/lm28FJl68ZE/B3Wqf=kUv
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Wed, 5 Nov 2025 13:31:59 +1100 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>
> Today's linux-next merge of the tip tree got a conflict in:
>=20
>   kernel/bpf/stackmap.c
>=20
> between commit:
>=20
>   e17d62fedd10 ("bpf: Refactor stack map trace depth calculation into hel=
per function")
>=20
> from the bpf-next tree and commit:
>=20
>   c69993ecdd4d ("perf: Support deferred user unwind")
>=20
> from the tip tree.
>=20
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>=20
> --=20
> Cheers,
> Stephen Rothwell
>=20
> diff --cc kernel/bpf/stackmap.c
> index 2365541c81dd,8f1dacaf01fe..000000000000
> --- a/kernel/bpf/stackmap.c
> +++ b/kernel/bpf/stackmap.c
> @@@ -333,9 -310,12 +333,9 @@@ BPF_CALL_3(bpf_get_stackid, struct pt_r
>   			       BPF_F_FAST_STACK_CMP | BPF_F_REUSE_STACKID)))
>   		return -EINVAL;
>  =20
>  -	max_depth +=3D skip;
>  -	if (max_depth > sysctl_perf_event_max_stack)
>  -		max_depth =3D sysctl_perf_event_max_stack;
>  -
>  +	max_depth =3D stack_map_calculate_max_depth(map->value_size, elem_size=
, flags);
>   	trace =3D get_perf_callchain(regs, kernel, user, max_depth,
> - 				   false, false);
> + 				   false, false, 0);
>  =20
>   	if (unlikely(!trace))
>   		/* couldn't fetch the stack trace */
> @@@ -463,15 -446,13 +463,15 @@@ static long __bpf_get_stack(struct pt_r
>   	if (may_fault)
>   		rcu_read_lock(); /* need RCU for perf's callchain below */
>  =20
>  -	if (trace_in)
>  +	if (trace_in) {
>   		trace =3D trace_in;
>  -	else if (kernel && task)
>  +		trace->nr =3D min_t(u32, trace->nr, max_depth);
>  +	} else if (kernel && task) {
>   		trace =3D get_callchain_entry_for_task(task, max_depth);
>  -	else
>  +	} else {
>   		trace =3D get_perf_callchain(regs, kernel, user, max_depth,
> - 					   crosstask, false);
> + 					   crosstask, false, 0);
>  +	}
>  =20
>   	if (unlikely(!trace) || trace->nr < skip) {
>   		if (may_fault)

This is now a conflict between the bpf-next tree and Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/N/lm28FJl68ZE/B3Wqf=kUv
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmkvoegACgkQAVBC80lX
0GwfRwf/SAPdxaT7GmlH18AOpAfzDihf1b2G8frMgXyvHR9TrI4PObUHgTUcz4IU
gTrQJWxr0fxxGAXbPGflg7Ki+vyMSIkivrGCwny4MTs07nlUM8sNyYUR6XbmMLDY
RyMEsMRvysfKXULcPtVtxaCzhAfTPkmdcrrnCByXWm3A6GHt95Mpaiq0j6LaNbv/
tHiL09L0LKr93WZ2GMA5KWNfl7OoTSvCgEe0oAcikCZJMYt2/mT9w7AS7JzmrbYs
cGMFaiQ0dZgP7rxYuvJ1pJt7HHlRJPvG72/90tx/oOK+523odRNpl21csMDhIavY
XmV/ra8wz0WRjGYmzDbj1C03wN3YqQ==
=Ge3i
-----END PGP SIGNATURE-----

--Sig_/N/lm28FJl68ZE/B3Wqf=kUv--

