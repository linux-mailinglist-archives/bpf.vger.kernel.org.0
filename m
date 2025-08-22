Return-Path: <bpf+bounces-66312-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 67B82B324BB
	for <lists+bpf@lfdr.de>; Fri, 22 Aug 2025 23:50:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6768E7B2442
	for <lists+bpf@lfdr.de>; Fri, 22 Aug 2025 21:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 475FE2836A3;
	Fri, 22 Aug 2025 21:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LppX9B/w"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D1121256B
	for <bpf@vger.kernel.org>; Fri, 22 Aug 2025 21:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755899410; cv=none; b=aPRWSGedCH8Cn1VyW9XrSIJQn1d3csPISdaLlY8QH8Fmdvf6jsNcnAr1vvDcgD0gTmiszBEpecPV3T4DLoxJZ6sg4ajGB4+DjBxjLDtsPP6qXkrZ4r9jgS+mQoZi1Jy2bnHPPUjuQqcRv6TtOm/oLFi4yABFvtAVQuRQ4X/hwLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755899410; c=relaxed/simple;
	bh=RjRtUCe6MGajpLoOZhcCcZZgEBrc/c6mJHd7874M0+o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WBOG6e3dnXZmsWIFlXsbBD6HyeTTJu8l6oIbI5ITKszq9Gij/h7QIIEDPw1j3OSUZk9VLpoXSBl/icpCq6lHPhQCTIvLEEeKnzTHAOo+pBYphr+Zfwc08pftQY6DUJ+4U4vJUWvsmicBmRRU5qDMXWYYbHLRmcJhxR+22id1by4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LppX9B/w; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3252589a47cso760120a91.0
        for <bpf@vger.kernel.org>; Fri, 22 Aug 2025 14:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755899409; x=1756504209; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oMIwu801P2O5YdpBrJn11dxjDnd7sa1LhXUuNxkjd5w=;
        b=LppX9B/wlHqVCAeU8NJxXQUQvA+ifIGwfs+JFcywlt5AhWDKQSY11GkWefG7kfenBH
         01YoqZQrmXMECpxI6LOs/OZB5lfpIJ11EhnhGGk97c525M9kwE/sRvZjfYYC4s+7i+Dz
         MV2o7qlKT+Ik3SFiw3flKLj20c2KEF30nhT9Xx2oOy2OhEQDaoB8md2vS4AEB7ACXgqH
         z0LNskt8+//NsyTbjKdcYPnyT9Ory+MleDwmesmkRAKfamS8Z5AHj2Zzuu3hg/RYefHa
         reiZ6FtMWs2tIPGZ/bysYsy2TiWVOLGhwDXSAnCOPctnly4mWghMgmEKoU4FoMq+UN6E
         KeIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755899409; x=1756504209;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oMIwu801P2O5YdpBrJn11dxjDnd7sa1LhXUuNxkjd5w=;
        b=BMHLVkGjQTsyV7TeU4nStwzBIusU3cyWgo+HnF+rrHC+1GSamM6bns9uX1JFAGx0gI
         2h1DhHU2TrZC8XPnHoidd8u+suxMygGUD+3FeP4bWMjtHXGSR9oI+iUVWdRprvYmCOkv
         vdiadJAmDe0OV3hEZb4W74PV3bI85DyWmgCRXBIwXQ+TYB9KOzVDAl31y1UiMR5i44Ki
         5kUMEIAMWhZVgVjhjk+rEFOoG6aAU9sqh+jPlkUU2xz5JwJWqghFW73augJZVN7qF4NV
         oC0S3evYUmO9hKllboWUEFMmPFlx0KAadX+8xkmazsPob47FA0GVXcpSfvXnpYwQCvCo
         o9FQ==
X-Gm-Message-State: AOJu0YzrNlBas3Y8iQ/p4Mj2Eg8xj7C2CdMUG6jr+Bx66z1Tjy6+5UQV
	ASxYBK0U4Vtia/YuDYr5j1kqNQ8nh9eaxRelK8NRpintf14Qj4Ej/QhVwJ0680Zz
X-Gm-Gg: ASbGncsTBITzs4wD59PEsaqwY37vzg59q8wvJWYNXfUkqtKpJCmEP/TWUK7HFZAuoMY
	UaE3JqCs0fwCk9M4rfFxFWeMsOSv4SYzPP8SWyDIrhEvqcTZQbbn8cXJCbcItdwONTVu9msiYee
	uqjpKHk623b0HIFW6sx3gv6jav5NY0DS5vSWMsJg4I0/fOL7cZ28IzehW9rpWVRVrhmMN0QDNV5
	zhlYb6l0LGWaY2FUtqbE+DK1ec0Irm5j0U/g8TFzgszLTdy3BEW6jHgpD7qJjRa6geOG6HwettN
	KfgvPCY2j631oszrGNUCjp3yFTuakrbuouqPROlqNHuhSqc4LZ73nKG7atmhSY8MVcNhzoXWW32
	TkPbBe5URhH0JQe6raCc=
X-Google-Smtp-Source: AGHT+IGgK4TYHWU8sESvxJNj7gv7GeZ4MOF2DEOFYtyy+dNJqwUlye9VsCzopmCx9zeSgtB6c2nOPA==
X-Received: by 2002:a17:90b:1e07:b0:325:2a77:bf5d with SMTP id 98e67ed59e1d1-3252a77c098mr4143980a91.0.1755899408586;
        Fri, 22 Aug 2025 14:50:08 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b49cbb9ce4dsm658628a12.46.2025.08.22.14.50.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 14:50:08 -0700 (PDT)
Message-ID: <8834d8df16f050ec9e906a850c894b481dfa022c.camel@gmail.com>
Subject: Re: [PATCH v4 bpf-next 1/2] bpf: improve the general precision of
 tnum_mul
From: Eduard Zingerman <eddyz87@gmail.com>
To: Nandakumar Edamana <nandakumar@nandakumar.co.in>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann	 <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Jakub Sitnicki	 <jakub@cloudflare.com>, Harishankar Vishwanathan	
 <harishankar.vishwanathan@gmail.com>
Date: Fri, 22 Aug 2025 14:50:01 -0700
In-Reply-To: <20250822170821.2053848-1-nandakumar@nandakumar.co.in>
References: <20250822170821.2053848-1-nandakumar@nandakumar.co.in>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-08-22 at 22:38 +0530, Nandakumar Edamana wrote:
> This commit addresses a challenge explained in an open question ("How
> can we incorporate correlation in unknown bits across partial
> products?") left by Harishankar et al. in their paper:
> https://arxiv.org/abs/2105.05398
>=20
> When LSB(a) is uncertain, we know for sure that it is either 0 or 1,
> from which we could find two possible partial products and take a
> union. Experiment shows that applying this technique in long
> multiplication improves the precision in a significant number of cases
> (at the cost of losing precision in a relatively lower number of
> cases).
>=20
> This commit also removes the value-mask decomposition technique
> employed by Harishankar et al., as its direct incorporation did not
> result in any improvements for the new algorithm.
>=20
> Signed-off-by: Nandakumar Edamana <nandakumar@nandakumar.co.in>
> ---

I was looking a bit into why the new algo loses to current algo in
some cases, and came up with the following explanation of why this
algo does not produce "perfect" answer.

To compute a most precise result one needs to consider all possible
sums that constitute a final answer, e.g. for 0bxx1 * 0b111 possible
sums are:

  111 + 1110 + 11100
  111 + 0000 + 11100
  111 + 1110 + 00000
  111 + 0000 + 00000

tnum_union of these sums is 00xx0xx1, while new algo produces
00xxxxx1. This happens because 'x' bits in intermediate results
"poison" it a bit by accumulating and reducing overall precision.

It is not practical to do such sum tree exploration, of course,
but I stumbled upon the following simple optimization:

  @@ -17,7 +17,7 @@ struct tnum tnum_union(struct tnum a, struct tnum b)
          return TNUM(v & ~mu, mu);
   }
  =20
  -struct tnum tnum_mul_new(struct tnum a, struct tnum b)
  +struct tnum __tnum_mul_new(struct tnum a, struct tnum b)
   {
          struct tnum acc =3D TNUM(0, 0);
  =20
  @@ -43,6 +43,14 @@ struct tnum tnum_mul_new(struct tnum a, struct tnum b)
          return acc;
   }
  =20
  +struct tnum tnum_mul_new(struct tnum a, struct tnum b)
  +{
  +       struct tnum ab =3D __tnum_mul_new(a, b);
  +       struct tnum ba =3D __tnum_mul_new(b, a);
  +
  +       return __builtin_popcountl(ab.mask) < __builtin_popcountl(ba.mask=
) ? ab : ba;
  +}
  +

For the 8-bit case I get the following stats (using the same [1] as
before):

  Patch as-is                 Patch with above modification
  -----------                 -----------------------------
  Tnums  : 6560
  New win: 30086328    70 %   31282549    73 %
  Old win: 1463809      3 %   907850       2 %
  Same   : 11483463    27 %   10843201    25 %


Looks a bit ugly, though.
Wdyt?

[1] https://github.com/eddyz87/tnum_mul_compare/blob/master/README.md

[...]

