Return-Path: <bpf+bounces-27521-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 149F08AE230
	for <lists+bpf@lfdr.de>; Tue, 23 Apr 2024 12:29:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4B952833AC
	for <lists+bpf@lfdr.de>; Tue, 23 Apr 2024 10:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DDC16BFCA;
	Tue, 23 Apr 2024 10:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JTVIqwdo"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161AA57303
	for <bpf@vger.kernel.org>; Tue, 23 Apr 2024 10:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713868140; cv=none; b=X9xga6U/gYVZiVE/KWIv/og1lYMgB+W05No0m+UZwOLQKzvTiP1EeDlqc7vTns0LD2Qf0k30UitBlLHQJdjCQHvvce5lJB2Rl+rORPB+3HR52tnDuYywHZm0/FtCSRPp7FA0VL9aK/lc5s3QmcR3OnXSUr0CtqazF6c6k45rqRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713868140; c=relaxed/simple;
	bh=77CHWLywqVbYBoo96kKtighZrmy1Kjrudm8xhUsB/wI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=S7B7aDQbqzx/W3wC/qoWwiQti/8rCzpzbdcRHG0JvoB2GaJO83cilmkSLpBE10LDfbIBqNbZbG3pIpkQKeJTjxZv7u/BVxo3u/y6WGIuEI7zwVaRqVAOe+/NFgPfNNHPCYb8OwfxSwP/GYr4b7Jgiqq8MmOHXUn401lsjncE4KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JTVIqwdo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98BE1C2BD11;
	Tue, 23 Apr 2024 10:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713868139;
	bh=77CHWLywqVbYBoo96kKtighZrmy1Kjrudm8xhUsB/wI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=JTVIqwdo5M8h8dwJ+jbE9j9vY5QIPXCUGtw9bQs41R7b8uG2xOfOVEhkD0UJiGTXl
	 cZa+7p+uzhVv5LqjXBQcy9BV5+3HtA55DhTQWIDz+QSd5xUHZD1Op+tmW+fNGgkUJk
	 5WsAtPLMaUXOU4YU00Jz7XmSJahNZ79FIj5hB3a+C0MLH6V1KCKDIk0szXjjsl5LX3
	 gCxtdKS4W/dWZMyIWlqdwXH4FTjCbOSNEvBu43jE1afcr4lVldkp5aN3Tm4gdhcGrP
	 UI3EZH+X4nt2rw5WaG6kd2shIsKwiNTWKfrFiW6Yx6tjdo/i2gac9hb8lkhrmaD3Qh
	 RGXJxadRyHA3A==
Message-ID: <ddac8e767369df15dc421bb613f88463bec30448.camel@kernel.org>
Subject: Re: [PATCH bpf v4 1/2] selftests/bpf: Add F_SETFL for fcntl in
 test_sockmap
From: Geliang Tang <geliang@kernel.org>
To: Martin KaFai Lau <martin.lau@linux.dev>, Jakub Sitnicki
	 <jakub@cloudflare.com>, John Fastabend <john.fastabend@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman
 <eddyz87@gmail.com>,  Mykola Lysenko <mykolal@fb.com>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP Singh
 <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,  Shuah Khan
 <shuah@kernel.org>, bpf@vger.kernel.org
Date: Tue, 23 Apr 2024 18:28:51 +0800
In-Reply-To: <f3f0388e-8884-4371-b96c-80d4ee34592d@linux.dev>
References: <cover.1712639568.git.tanggeliang@kylinos.cn>
	 <e4efa52c26ca5ae97c7e4e7570d8da9cd44df533.1712639568.git.tanggeliang@kylinos.cn>
	 <e2aaa0f0-7641-4d26-9256-1151976235f1@linux.dev> <Zh+E5JlEM6fisrFS@t480>
	 <f3f0388e-8884-4371-b96c-80d4ee34592d@linux.dev>
Autocrypt: addr=geliang@kernel.org; prefer-encrypt=mutual;
 keydata=mQINBGWKTg4BEAC/Subk93zbjSYPahLCGMgjylhY/s/R2ebALGJFp13MPZ9qWlbVC8O+XlU/4reZtYKQ715MWe5CwJGPyTACILENuXY0FyVyjp/jl2u6XYnpuhw1ugHMLNJ5vbuwkc1I29nNe8wwjyafN5RQV0AXhKdvofSIryqm0GIHIH/+4bTSh5aB6mvsrjUusB5MnNYU4oDv2L8MBJStqPAQRLlP9BWcKKA7T9SrlgAr0VsFLIOkKOQPVTCnYxn7gfKogH52nkPAFqNofVB6AVWBpr0RTY7OnXRBMInMHcjVG4I/NFn8Cc7oaGaWHqX/yHAufJKUsldieQVFd7C/SI8jCUXdkZxR0Tkp0EUzkRc/TS1VwWHav0x3oLSy/LGHfRaIC/MqdGVqgCnm6wapUt7f/JHloyIyKJBGBuHCLMpN6n/kNkSCzyZKV7h6Vw1OL518p0U3Optyakoh95KiJsKzcd3At/eftQGlNn5WDflHV1+oMdW2sRgfVDPrYeEcYI5IkTc3LRO6ucpVCm9/+poZSHSXMI/oJ6iXMJE8k3/aQz+EEjvc2z0p9aASJPzx0XTTC4lciTvGj62z62rGUlmEIvU23wWH37K2EBNoq+4Y0AZsSvMzM+CcTo25hgPaju1/A8ErZsLhP7IyFT17ARj/Et0G46JRsbdlVJ/PvX+XIOc2mpqx/QARAQABtCVHZWxpYW5nIFRhbmcgPGdlbGlhbmcudGFuZ0BsaW51eC5kZXY+iQJUBBMBCgA+FiEEZiKd+VhdGdcosBcafnvtNTGKqCkFAmWKTg4CGwMFCRLMAwAFCwkIBwIGFQoJCAsCBBYCAwECHgECF4AACgkQfnvtNTGKqCmS+A/9Fec0xGLcrHlpCooiCnNH0RsXOVPsXRp2xQiaOV4vMsvhG5AHaQLb3v0cUr5JpfzMzNpEkaBQ/Y8Oj5hFOORhTyCZD8tY1aROs8WvbxqvbGXHnyVwqy7Ad
	WelP+0lC0DZW0kPQLeel8XvLnm9Wm3syZgRGxiM/J7PqVcjujUb6SlwfcE3b2opvsHW9AkBNK7v8wGIcmBA3pS1O0/anP/xD5s5L7LIMADVB9MqQdeLdFU+FFdafmKSmcP9A2qKHAvPBUuQo3xoBOZR3DMqXIPkNCBfQGkAx5tm1XYli1u3r5tp5QCRbY5LSkntMNJJh0eWLU8I+zF6NWhqNhHYRD3zc1tiXlG5E0obpX02Dy25SE2zB3abCRdAK30nCI4lMyMCcyaeFqvf6uhiugLiuEPRRRdJDWICOLw6KOFmxWmue1F71k08nj5PQMWQUX3X2K6jiOuoodYwnie/9NsH3DBHIVzVPWASFd6JkZ21i9Ng4ie+iQAveRTCeCCF6VRORJR0R8d7mI9+1eqhNeKzs21gQPVf/KBEIpwPFDjOdTwS/AEQQyhB+5ALeYpNgfKl2p30C20VRfJGBaTc4ReUXh9xbUx5OliV69iq9nIVIyculTUsbrZX81Gz6UlbuSzWc4JclWtXf8/QcOK31wputde7Fl1BTSR4eWJcbE5Iz2yzgQu0IUdlbGlhbmcgVGFuZyA8Z2VsaWFuZ0BrZXJuZWwub3JnPokCVAQTAQoAPhYhBGYinflYXRnXKLAXGn577TUxiqgpBQJlqclXAhsDBQkSzAMABQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAAAoJEH577TUxiqgpaGkP/3+VDnbu3HhZvQJYw9a5Ob/+z7WfX4lCMjUvVz6AAiM2atDyyUoDIv0fkDDUKvqoU9BLU93oiPjVzaR48a1/LZ+RBE2mzPhZF201267XLMFBylb4dyQZxqbAsEhVc9VdjXd4pHYiRTSAUqKqyamh/geIIpJz/cCcDLvX4sM/Zjwt/iQdvCJ2eBzunMfouzryFwLGcOXzxOwZRMOBgVuXrjGVB52kYu1+K90DtclewEgvzWmS9d057CJztJZMXzvHfFAQMgJC7DX4pa
	Yt49pNvhcqLKMGNLPsX06OR4G+4ai0JTTzIlwVJXuo+uZRFQyuOaSmlSjEsiQ/WsGdhILldV35RiFKe/ojQNd4B4zREBe3xT+Sf5keyAmO/TG14tIOCoGJarkGImGgYltTTTM6rIk/wwo9FWshgKAmQyEEiSzHTSnXcGbalD3Do89YRmdG+5eP7HQfsG+VWdn8IH6qgIvSt8GOw6RfSP7omMXvXji1VrbWG4LOFYcsKTN+dGDhl8LmU0y44HejkCzYj/b28MvNTiRVfucrmZMGgI8L5A4ZwQ3Inv7jY13GZSvTb7PQIbqMcb1P3SqWJFodSwBg9oSw21b+T3aYG3z3MRCDXDlZAJONELx32rPMdBva8k+8L+K8gc7uNVH4jkMPkP9jPnVPx+2P2cKc7LXXedb/qQ3MuQINBGWKTg4BEADJxiOtR4SC7EHrUDVkp/pJCQC2wxNVEiJOas/q7H62BTSjXnXDc8yamb+HDO+Sncg9SrSRaXIh+bw9G3rvOiC2aQKB6EyIWKMcuDlD7GbkLJGRoPCA5nSfHSzht2PdNvbDizODhtBy8BOQA6Vb21XOb1k/hfD8Wy6OnvkA4Er61cf66BzXeTEFrvAIW+eUeoYTBAeOOc2m4Y0J28lXhoQftpNGV5DxH9HSQilQZxEyWkNj8oomVJ6Db7gSHre0odlt5ZdB7eCJik12aPIdK5W97adXrUDAclipsyYmZoC1oRkfUrHZ3aYVgabfC+EfoHnC3KhvekmEfxAPHydGcp80iqQJPjqneDJBOrk6Y51HDMNKg4HJfPV0kujgbF3Oie2MVTuJawiidafsAjP4r7oZTkP0N+jqRmf/wkPe4xkGQRu+L2GTknKtzLAOMAPSh38JqlReQ59G4JpCqLPr00sA9YN+XP+9vOHT9s4iOu2RKy2v4eVOAfEFLXq2JejUQfXZtzSrS/31ThMbfUmZsRi8CY3HRBAENX224Wcn6IsXj3K6lfYxImRKWGa
	/4KviLias917DT/pjLw/hE8CYubEDpm6cYpHdeAEmsrt/9dMe6flzcNQZlCBgl9zuErP8Cwq8YNO4jN78vRlLLZ5sqgDTWtGWygi/SUj8AUQHyF677QARAQABiQI7BBgBCgAmFiEEZiKd+VhdGdcosBcafnvtNTGKqCkFAmWKTg4CGwwFCRLMAwAACgkQfnvtNTGKqCkpsw/2MuS0PVhl2iXs+MleEhnN1KjeSYaw+nLbRwd2SdXoVXBquPP9Bgb92T2XilcWObNwfVtD2eDz8eKf3e9aaWIzZRQ3E5BxiQSHXl6bDDNaWJB6I8dd5TW+QnBPLzvqxgLIoYn+2FQ0AtL0wpMOdcFg3Av8MEmMJk6s/AHkL8HselA3+4h8mgoK7yMSh601WGrQAFkrWabtynWxHrq4xGfyIPpq56e5ZFPEPd4Ou8wsagn+XEdjDof/QSSjJiIaenCdDiUYrx1jltLmSlN4gRxnlCBp6JYr/7GlJ9Gf26wk25pb9RD6xgMemYQHFgkUsqDulxoBit8g9e0Jlo0gwxvWWSKBJ83f22kKiMdtWIieq94KN8kqErjSXcpI8Etu8EZsuF7LArAPch/5yjltOR5NgbcZ1UBPIPzyPgcAmZlAQgpy5c2UBMmPzxco/A/JVp4pKX8elTc0pS8W7ne8mrFtG7JL0VQfdwNNn2R45VRf3Ag+0pLSLS7WOVQcB8UjwxqDC2t3tJymKmFUfIq8N1DsNrHkBxjs9m3r82qt64u5rBUH3GIO0MGxaI033P+Pq3BXyi1Ur7p0ufsjEj7QCbEAnCPBTSfFEQIBW4YLVPk76tBXdh9HsCwwsrGC2XBmi8ymA05tMAFVq7a2W+TO0tfEdfAX7IENcV87h2yAFBZkaA==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.0-1 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-04-17 at 17:28 -0700, Martin KaFai Lau wrote:
> On 4/17/24 1:14 AM, Geliang Tang wrote:
> > Hi Martin,
> >=20
> > On Thu, Apr 11, 2024 at 11:10:49AM -0700, Martin KaFai Lau wrote:
> > > On 4/8/24 10:18 PM, Geliang Tang wrote:
> > > > From: Geliang Tang <tanggeliang@kylinos.cn>
> > > >=20
> > > > Incorrect arguments are passed to fcntl() in test_sockmap.c
> > > > when invoking
> > > > it to set file status flags. If O_NONBLOCK is used as 2nd
> > > > argument and
> > > > passed into fcntl, -EINVAL will be returned (See do_fcntl() in
> > > > fs/fcntl.c).
> > > > The correct approach is to use F_SETFL as 2nd argument, and
> > > > O_NONBLOCK as
> > > > 3rd one.
> > > >=20
> > > > In nonblock mode, if EWOULDBLOCK is received, continue
> > > > receiving, otherwise
> > > > some subtests of test_sockmap fail.
> > > >=20
> > > > Fixes: 16962b2404ac ("bpf: sockmap, add selftests")
> > > > Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> > > > Acked-by: Yonghong Song <yonghong.song@linux.dev>
> > > > ---
> > > > =C2=A0=C2=A0 tools/testing/selftests/bpf/test_sockmap.c | 5 ++++-
> > > > =C2=A0=C2=A0 1 file changed, 4 insertions(+), 1 deletion(-)
> > > >=20
> > > > diff --git a/tools/testing/selftests/bpf/test_sockmap.c
> > > > b/tools/testing/selftests/bpf/test_sockmap.c
> > > > index 024a0faafb3b..4feed253fca2 100644
> > > > --- a/tools/testing/selftests/bpf/test_sockmap.c
> > > > +++ b/tools/testing/selftests/bpf/test_sockmap.c
> > > > @@ -603,7 +603,9 @@ static int msg_loop(int fd, int iov_count,
> > > > int iov_length, int cnt,
> > > > =C2=A0=C2=A0=C2=A0		struct timeval timeout;
> > > > =C2=A0=C2=A0=C2=A0		fd_set w;
> > > > -		fcntl(fd, fd_flags);
> > > > +		if (fcntl(fd, F_SETFL, fd_flags))
> > > > +			goto out_errno;
> > > > +
> > > > =C2=A0=C2=A0=C2=A0		/* Account for pop bytes noting each iteration
> > > > of apply will
> > > > =C2=A0=C2=A0=C2=A0		 * call msg_pop_data helper so we need to
> > > > account for this
> > > > =C2=A0=C2=A0=C2=A0		 * by calculating the number of apply
> > > > iterations. Note user
> > > > @@ -678,6 +680,7 @@ static int msg_loop(int fd, int iov_count,
> > > > int iov_length, int cnt,
> > > > =C2=A0=C2=A0=C2=A0					perror("recv
> > > > failed()");
> > > > =C2=A0=C2=A0=C2=A0					goto out_errno;
> > > > =C2=A0=C2=A0=C2=A0				}
> > > > +				continue;
> > >=20
> > > =C2=A0From looking at it again, there is a select() earlier, so it
> > > should not hit
> > > EWOULDBLOCK.
> >=20
> > Can the patch in the attachment be accepted? It can work, but I'm
> > not sure
> > if it has changed the behavior of this test. Anyway, I would like
> > to hear
> > your opinion.
>=20
> I don't know what is the correct expectation also. John and JakubS,
> can you take=20
> a look?

Hello,
New version v5 has been sent. Please review it for me.

Thanks,
-Geliang



