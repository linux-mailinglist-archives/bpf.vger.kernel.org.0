Return-Path: <bpf+bounces-33153-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 31340918087
	for <lists+bpf@lfdr.de>; Wed, 26 Jun 2024 14:06:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48BA41C21BFF
	for <lists+bpf@lfdr.de>; Wed, 26 Jun 2024 12:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB6B3180A83;
	Wed, 26 Jun 2024 12:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HGqQ64zO"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445C617E445
	for <bpf@vger.kernel.org>; Wed, 26 Jun 2024 12:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719403568; cv=none; b=S4xWuAiXRs/KQZa+9p6Owcr9bv1/qXt+fFmRTVdtqqt8Kh9CJl4iKqDoGgXiuW7NBsAV6dBNKMM1TTi0NSnVFkB8h4WtIYHYfkRvsB7heEKzYHDvOaiVhL5Yr6wKoL7X/n9lfxjSGoimDLsVJqXmIBCtdKcHZDjD8fLjm4XL82w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719403568; c=relaxed/simple;
	bh=h38fC5Y++ViFMwMuR5CML7i+WuF/fKIzBL/U9h45ahI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=D34otKUwCDV2FOrR7aO4VtKPmbEgrmWN9LQKMBAa+nbGQl2a1hVxDu4mRAAtVUhR/cQsZZ969YI7rW+Sui0j0Hq1x2N5mmJ+/xix+mql7J/5RdCQvYUr+Gwy16gC+l3kYCJL2HRNztpPpwYvafvi37NnUZnqVDyXOCTblIJpNRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HGqQ64zO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D73FC2BD10;
	Wed, 26 Jun 2024 12:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719403567;
	bh=h38fC5Y++ViFMwMuR5CML7i+WuF/fKIzBL/U9h45ahI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=HGqQ64zOHsOYXT2mkM5v1rhWCBbQ61XnvPUogk1UB/c8fNCtoz+aYCRhIT2e+JfX3
	 G9bzo4V0jEmHGhIh5Tq60j39RuhluIS1YpBfho6ClcO+EHpFIBAi5HKy49WgCsw4PQ
	 qklgIIGw9J98wkuQ+r9kQ9kmF2if5ddm6I5GBmK7ozGOODCgrk2AoAnSKAV8mlhmNW
	 /kv6/yG0n9tU5uCrTa5qrYF76U2UFEVTx5iAp/JaEt/6aP+w+/TW/sq07pfOSaBjKm
	 BMvjwmmz28Krr05Do65Kyt7eMOheWs2qRIU5e5NPGaly3VTKa8kNAGa65sw083k71h
	 IBcn1pTq1G3RA==
From: Puranjay Mohan <puranjay@kernel.org>
To: Leon Hwang <hffilwlqm@gmail.com>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 maciej.fijalkowski@intel.com, jakub@cloudflare.com, pulehui@huawei.com,
 hffilwlqm@gmail.com, kernel-patches-bot@fb.com, puranjay12@gmail.com
Subject: Re: [PATCH v5 bpf-next 2/3] bpf, arm64: Fix tailcall hierarchy
In-Reply-To: <20240623161528.68946-3-hffilwlqm@gmail.com>
References: <20240623161528.68946-1-hffilwlqm@gmail.com>
 <20240623161528.68946-3-hffilwlqm@gmail.com>
Date: Wed, 26 Jun 2024 12:05:47 +0000
Message-ID: <mb61pwmmbykmc.fsf@kernel.org>
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

Leon Hwang <hffilwlqm@gmail.com> writes:

> This patch fixes a tailcall issue caused by abusing the tailcall in
> bpf2bpf feature on arm64 like the way of "bpf, x64: Fix tailcall
> hierarchy".
>
> On arm64, when a tail call happens, it uses tail_call_cnt_ptr to
> increment tail_call_cnt, too.
>
> At the prologue of main prog, it has to initialize tail_call_cnt and
> prepare tail_call_cnt_ptr.
>
> At the prologue of subprog, it pushes x26 register twice, and does not
> initialize tail_call_cnt.
>
> At the epilogue, it pops x26 twice, no matter whether it is main prog or
> subprog.
>
> Fixes: d4609a5d8c70 ("bpf, arm64: Keep tail call count across bpf2bpf calls")
> Signed-off-by: Leon Hwang <hffilwlqm@gmail.com>

Acked-by: Puranjay Mohan <puranjay@kernel.org>

Thanks,
Puranjay

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iIoEARYKADIWIQQ3wHGvVs/5bdl78BKwwPkjG3B2nQUCZnwEHBQccHVyYW5qYXlA
a2VybmVsLm9yZwAKCRCwwPkjG3B2nYnaAQCTkqzKyH7aLY7mkM1vEEZ6ObOq73i4
+VjkAb7Cf5PtEQEAsp0lC/tzJNHGqGtMWPm9gx0tgg2tTZyVQSI4K83sYQ0=
=co0l
-----END PGP SIGNATURE-----
--=-=-=--

