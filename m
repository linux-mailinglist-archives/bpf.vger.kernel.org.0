Return-Path: <bpf+bounces-78087-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A72FCFDF15
	for <lists+bpf@lfdr.de>; Wed, 07 Jan 2026 14:29:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 195393068DF7
	for <lists+bpf@lfdr.de>; Wed,  7 Jan 2026 13:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8001C31BCA9;
	Wed,  7 Jan 2026 13:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jO3uMlOk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2395327BE4
	for <bpf@vger.kernel.org>; Wed,  7 Jan 2026 13:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767791962; cv=none; b=VIYF2RD29DVvx2bWT2wlcOoQ70vNwMp+DQrw9Jw8+tGw5bts1Qc02AhzN3eF2RzOthw1q7PAzGt+rS0xqmpbnbyxP8ZK+5J/MLWwhGe9mAeQN0+R5eSNHXQaF1x+843hZGJzwKl5pkbc4wwSMxTUIsP27ju2DdRqKPGWXh5fnAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767791962; c=relaxed/simple;
	bh=Uq9yk0pqa6CErpXggBXldsd56C2yDeubsuwraPJTXIY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gwOWdgJ9d3V3ZhG3DXHL2s0BIiSp0hYvELKCRkMPbwnSopehnUH0fT2lS0SoliQ+hrbuDK2T0gcrYm+lS7EbMabRJQU1xybMyvF/uZJD0BtRAwsuRO/uDeORKGIV/uVTdkgKP5f+8Dqwiyq+VCL55JurkLZ1RvVXT5m5CFNtU5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jO3uMlOk; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-34c708702dfso1553961a91.1
        for <bpf@vger.kernel.org>; Wed, 07 Jan 2026 05:19:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767791959; x=1768396759; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Uq9yk0pqa6CErpXggBXldsd56C2yDeubsuwraPJTXIY=;
        b=jO3uMlOkn7Q1U7WAYSmSF+h4UHxzHCjXoM9YQYfh31SgWg4/O64bKtrzm4ysa79yCB
         zDcw3rBQjRUg8J3hUyFFtvDaHWpnD4jW+iPYrEYNHW8LgR0sYA/IGOkmFRkzMbTx0wCQ
         b5PxwfAx0FR8i3TUsR6UhrzXoLh3bfcjYYONgI/mVj/pRxeuT5wTHIJHNaRbHZOIT8sM
         K70G+heh/FW18t9GMf8euH4nOyuBPQ0PJhVCJ0Ke856bDIsD7NKrLwyGoX+xsN3C3Q1F
         KWJssgDISlbJHQ/QmrziWud4bGOOuwIRwS6XMAyqKa66U6f0VaTfN3YRh8RTT/qX1wbq
         B+9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767791959; x=1768396759;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Uq9yk0pqa6CErpXggBXldsd56C2yDeubsuwraPJTXIY=;
        b=ld+zja9/9aOL2NLBWxKW44Jju6ME4J+EofqEYRMgjhCAFMqeGlgxwnMsoqs2wLBFck
         0ycyUisHq5s8shDY8iNtl/1KYbFa/5fX1sMVt/oANOQCVZdkGCWnfOOAJKMMKtrIi2ai
         YAUHanYJgsPU3F1+ol99XaoQYpNObF2Lvj3FJ8HFbdSgfnphbr9kPw2WqlE3sPz+zd/r
         GR5xGWsb0cDXhqcIFFlZjfooW0mfft+Hhkg2HUr735EMr6yNmSRyKHmltanYNPqyLqM2
         zkCRANw8jjubZ9TkLBY7IB1FVuxRbs/fpY7Jxy+Ir1MR1TbvDXkzwIcMkIO1VxD7AgXj
         ueTA==
X-Forwarded-Encrypted: i=1; AJvYcCU3DioGDPjv17KWSehZRTaS3F3KKsjWeuSCwRHn1J0VF0AtGeGMOazcop57g7lHekcbug4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBoEJYQzAuZ9yNR1AVjU1CdLNUCWxi2ExdAdvaQmWVbEnwNL0d
	fzpBGJK9QlRZJ7cWZ+Jcd2QIB8F3+vXf3mCEKzf7BN8EAr0UD40xbgNc
X-Gm-Gg: AY/fxX4106jcbFwAzEggqZb875iC9eW5unA9nxLnJapShIlj+Zvg8/g5gLtQRjCc8rl
	UO3iev9dXRoKEonL+LosDiqRwgtCw+al4KvZ4K2YtJRSFpAOY4T/EgpJ01uQsBjZMkKDUsZfivF
	9gTOPrkDHRFFOrLyfooLvpz75fN1jnAAf03UG0FyzD02L5ZL6SdBNds03Q4pokbCQ/akcVMhCxJ
	dHXt36ylHcoF9gI61uo3M8A6dVbeErDN1H8am934iC2eBYkpj2tVZ7TYTt+R2cHiIcumFA+moOl
	Qk7rs/Uf5ZMMxwnkOPX63TNg0bsDmG7kCfCYocxJQIu+eRAn3KUfF7LOk4ZcH889tQSUyXDRq01
	PKSrknh4bBsnYa6hhdq5ME1AeCbsSPEws2RU3yDbgSRAcZZL+0BTx/S8TmPN2r6DXmoERuYlnPs
	oZ+9tPOwdiG5o=
X-Google-Smtp-Source: AGHT+IFeDRL/b8QepEuqdVndH+CCmCN1ugMAXxIErciQBd/TK/BwskXiSKTpfxPKZ00Mm2Wqq53x8Q==
X-Received: by 2002:a17:90b:4acf:b0:32e:749d:fcb7 with SMTP id 98e67ed59e1d1-34f68c28379mr2157102a91.13.1767791958715;
        Wed, 07 Jan 2026 05:19:18 -0800 (PST)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34f5fb74435sm5150241a91.14.2026.01.07.05.19.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 05:19:14 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 211B1415FEEC; Wed, 07 Jan 2026 20:19:11 +0700 (WIB)
Date: Wed, 7 Jan 2026 20:19:10 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Ihor Solodrai <ihor.solodrai@linux.dev>,
	Hemanth Malla <vmalla@linux.microsoft.com>, bpf@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
	yonghong.song@linux.dev, john.fastabend@gmail.com,
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
	jolsa@kernel.org, vmalla@microsoft.com, corbet@lwn.net,
	Alan Maguire <alan.maguire@oracle.com>,
	dwarves <dwarves@vger.kernel.org>
Subject: Re: [PATCH bpf-next] bpf, docs: Update pahole to 1.28 for selftests
Message-ID: <aV5dToFzshRdIjgS@archie.me>
References: <1767352415-24862-1-git-send-email-vmalla@linux.microsoft.com>
 <bcd23277-a18e-4bb5-ba76-3416c84511c2@linux.dev>
 <aVjdUjai0lzpMeHv@archie.me>
 <CAEf4BzbAKGJsWov1udk+f5jS-qKSLMY+j76FP-JuWuxjhc0h-A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8GbvbpBfl39DdqHx"
Content-Disposition: inline
In-Reply-To: <CAEf4BzbAKGJsWov1udk+f5jS-qKSLMY+j76FP-JuWuxjhc0h-A@mail.gmail.com>


--8GbvbpBfl39DdqHx
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 05, 2026 at 01:46:52PM -0800, Andrii Nakryiko wrote:
> On Sat, Jan 3, 2026 at 1:11=E2=80=AFAM Bagas Sanjaya <bagasdotme@gmail.co=
m> wrote:
> >
> > On Fri, Jan 02, 2026 at 07:33:50AM -0800, Ihor Solodrai wrote:
> > > Not sure if it's worth it to add this nuance to the QA doc, although
> > > in general we should recommend people running the selftests to use the
> > > latest pahole release. Maybe add a comment?
> >
> > I guess minimum pahole version can be added to
> > Documentation/process/changes.rst.
>=20
> pahole 1.22 is already specified in Documentation/process/changes.rst

Oops, I didn't see that pointer.

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--8GbvbpBfl39DdqHx
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaV5dTgAKCRD2uYlJVVFO
o1kXAP9UlgleGCs3hp35KABPfg2p2+nPRBacjHknZrtTwIG/GgEAyfGQ4DIno+uM
KJeAT/uGjeN9Vkfg3/yhXRR9UYN3CAs=
=SAY7
-----END PGP SIGNATURE-----

--8GbvbpBfl39DdqHx--

