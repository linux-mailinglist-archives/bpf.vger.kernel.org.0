Return-Path: <bpf+bounces-41104-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDE06992B2A
	for <lists+bpf@lfdr.de>; Mon,  7 Oct 2024 14:12:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C36E2843AF
	for <lists+bpf@lfdr.de>; Mon,  7 Oct 2024 12:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EC741D223E;
	Mon,  7 Oct 2024 12:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t21ZNTTO"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06A71D1F7B;
	Mon,  7 Oct 2024 12:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728303121; cv=none; b=MF+oE3zxE7qq1q/FBeJkSyNH13pxcu+6Jq195YY5yVR2rFHUMl1EQsg8BvooJJ1Ir3dap2HOhVUX+T/q/JyAkKJWxi3+HyJXXzk6htnyCS9KLxoifKcJQb/RA/4Nur9dNTNc3wt6zGOov/MJKKzuSLyNL675A4vDyYd+8COtMq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728303121; c=relaxed/simple;
	bh=GBGf7gNPVrZgFa9G7rsgaUZW0YHGQ90+7nfsWjOtqg0=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OX22Cw4xMxvn01gQ/DrcwmgevttF6aklee6EicaEH7P2APUX+luIvIRDtkukoLfDSH+x3A138/nUjuUAdUV+fs8eOWeb4Cyp6u5HStnjmpO5jw3/64iPuV+gk7eUMup64EPuyDqW4GR9U+9OWps0ALVCrkAaZNOH/XFQh3MtynA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t21ZNTTO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50553C4CEC6;
	Mon,  7 Oct 2024 12:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728303120;
	bh=GBGf7gNPVrZgFa9G7rsgaUZW0YHGQ90+7nfsWjOtqg0=;
	h=From:To:Subject:In-Reply-To:References:Date:From;
	b=t21ZNTTOBeOIaahalhQQpvgROj4yQF9usVoteoi6rgfX7eINgOIDe/LfRuBP4kiu0
	 N4T+/2oVY7rU1HLbUfF95CQ2pFJP40mI2u+Nrt0Bn3pdpIYlx4FGAsqG7vSpUl/8yg
	 ASBwh6GCMRlGHrto7i0YVoxJbnvnbxYacp+zJYWN1aAysTFD3vKa9TaTeZkO45Sor/
	 KXY+5jmwZbCeB9U7IOB4a0fDWNrrNNP4//iMf4ipUpLugWrU/gbu9rlsGdb8hm1Sl0
	 gYdu0wwFef/w7hF3twMSST+iw+mslMmxgqGlQg3cyJ9K6k2kFZ2WoppchutiP+OQOO
	 gJzQSdRskYtOw==
From: Puranjay Mohan <puranjay@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Martin KaFai
 Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John Fastabend
 <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v3 2/2] selftests/bpf: Augment send_signal test
 with remote signaling
In-Reply-To: <20241007103426.128923-3-puranjay@kernel.org>
References: <20241007103426.128923-1-puranjay@kernel.org>
 <20241007103426.128923-3-puranjay@kernel.org>
Date: Mon, 07 Oct 2024 12:11:46 +0000
Message-ID: <mb61po73wcdtp.fsf@kernel.org>
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

Puranjay Mohan <puranjay@kernel.org> writes:

> Add testcases to test bpf_send_signal_task(). In these new test cases,
> the main process triggers the BPF program and the forked process
> receives the signals. The target process's signal handler receives a
> cookie from the bpf program.
>
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> ---
>  .../selftests/bpf/prog_tests/send_signal.c    | 133 +++++++++++++-----
>  .../bpf/progs/test_send_signal_kern.c         |  35 ++++-
>  2 files changed, 130 insertions(+), 38 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/send_signal.c b/tools=
/testing/selftests/bpf/prog_tests/send_signal.c
> index 6cc69900b3106..beb771347a503 100644
> --- a/tools/testing/selftests/bpf/prog_tests/send_signal.c
> +++ b/tools/testing/selftests/bpf/prog_tests/send_signal.c
> @@ -8,17 +8,25 @@ static int sigusr1_received;
>=20=20
>  static void sigusr1_handler(int signum)
>  {
> -	sigusr1_received =3D 1;
> +	sigusr1_received =3D 8;
> +}
> +
> +static void sigusr1_siginfo_handler(int s, siginfo_t *i, void *v)
> +{
> +	sigusr1_received =3D i->si_value.sival_int;

This is incorrect for big-endian archs and I will change this to:

     sigusr1_received =3D (int)(long long)i->si_value.sival_ptr;

This should work on all archs.

>  }
>=20=20
>  static void test_send_signal_common(struct perf_event_attr *attr,
> -				    bool signal_thread)
> +				    bool signal_thread, bool remote)

[...]

Thanks,
Puranjay

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iIoEARYKADIWIQQ3wHGvVs/5bdl78BKwwPkjG3B2nQUCZwPQAxQccHVyYW5qYXlA
a2VybmVsLm9yZwAKCRCwwPkjG3B2nXb9AP93TgrMYdaOsedUSTEZ8TBFBE1C8gE3
uRC0PgWADRlOHwD/ekM6ka1QIfptrjottMYN9u/sU3g/YrKgZ+AsHXK0vgY=
=xM09
-----END PGP SIGNATURE-----
--=-=-=--

