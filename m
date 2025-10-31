Return-Path: <bpf+bounces-73096-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 126C7C22F87
	for <lists+bpf@lfdr.de>; Fri, 31 Oct 2025 03:18:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 471C634F717
	for <lists+bpf@lfdr.de>; Fri, 31 Oct 2025 02:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3818D27AC54;
	Fri, 31 Oct 2025 02:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NETnpgWT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5414627934B
	for <bpf@vger.kernel.org>; Fri, 31 Oct 2025 02:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761877094; cv=none; b=u1Qe6RaBj2okshynGlnGEbzmczgXzf+b5rrTGBkjB5yxQOLu2rZIRLWP6PaGPgkRTXbgDSCTm8LupijA4uqDd/5ntq2l2EBh5Z6GEdvS5SonEbm4+tp4GB/uhb8FZULID0sSQx/t6JHywcvo3hgEIsBM0DOi6FkvBWsKfBVaruM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761877094; c=relaxed/simple;
	bh=2Qz23v1zvkjWWO/0KBTostHDqcO8A9fKu8aLJCvZrxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ArRwBirUaizlGWdFTssuXMqPf+qdDwBspaMbT4sIowWDP7+vFMbVExIHQ/fZnDluXtoRCySrnEAZOCc1XcaPJ4fPvOr6yXtLs3jfAAO7HfCujnCO8PCElGnduGuZHS5RQvvjoqN8nWyMXkJt0KsO6jqibUBJpzOU+7SCr+BopI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NETnpgWT; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-295070beaa4so11104475ad.0
        for <bpf@vger.kernel.org>; Thu, 30 Oct 2025 19:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761877090; x=1762481890; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2Qz23v1zvkjWWO/0KBTostHDqcO8A9fKu8aLJCvZrxw=;
        b=NETnpgWTCdXKoDasEYybumdnAEqR2riF8rD6hk9JLe89jqTxU2orKkZvvNOfw82Vgn
         W5hoLMqs7DLMtWMSrv8vQZR+Ng1GGta2ugjfPkF+vVKzD3RV+VJapSRSL8muzeyiCRGl
         AhP7wltbS+KIlo8QoyU3DrcEz/1pzapjLQLcMcH0a1BAHcsB9Zf0jnASS+6ql7mQaCC2
         KsBMDGciZGewbUXo4sRGwM6JP+l4i3dcEf5A02nY1CQVvfd3szmsxDT7Ezf+lRT3dnRB
         YhIgBvnR/RaBAPgVZNJAHOZEWljnnFSGKBR2sbcpUDRXYfktChrryLRuxh/jsobvgWa2
         eHSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761877090; x=1762481890;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Qz23v1zvkjWWO/0KBTostHDqcO8A9fKu8aLJCvZrxw=;
        b=CqJezcd2cz+10yjigjHHDXLGIHY/fFwIZc736ziXYdhgGQa2c+uyyxYpC54sbPq/Ny
         YCsdrlGtE1cqtrAUUQ2H825nfe45DRH3NNkHSezbetIvC6aPSOW9FzyynDW3p7uy/Oro
         2hkxPIPFwc30J944/fkREJTpT9Mk6m7FFMd/VijQkOCQkTILI2jh2RrzDMFE+zRNBPOm
         mBL7wBYdjwaHyTRkT2GNpeMFxvjutl+RCjtoYUV1A/sCQ21bkWw3AWsD2vPYEvYrG0n/
         fwNsjzUrbl2w8HNCBQ6Fs3siYfa0pvJnz45/9dvXv/7ypSNc44AN4sgv5bdfbKnrxVPe
         Ocag==
X-Forwarded-Encrypted: i=1; AJvYcCXIXAqsDQBafTwmp1WjiJUcDQBDtcxs3Ki2FZA8dkPqrlEOyl+tcfLu3A3iBjgL2ID+Hcg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGADa+dISoqVIhGAhgBpd9Mtt77nkYltLFMfdEH5gyNeBIT2Jj
	/GwA6MjKMUGV8A0ffNjSHMAHeimqNAxvqc4DQsCLv5UNvm8YDkGwieIE
X-Gm-Gg: ASbGnctBp+HoLBbmoVpyIbXc3n082jRLU3ZvRGH6VXPA0uhFqz3sKLmCxnxwzMoTzwA
	EBgtMTv+Z8sh4Oygcu5lAmY0tVQ4aHCuPcCVXY/jDfEP+iMXE8fmK6g6qKFXAvKn3x2/QufW7Qf
	4PDODaAGjna37w8ai0to7EpaHeVDl9MqXFcCLIm3z1qvrHUNhGxvsT2FCX105rlnzobwdbBjHXU
	bP9DSdOYBAYNl3syykzMZ8vyzCNRuQT1gM4orKhdLGUFf6drlU+3N1CrGngm6nI9+p/luJilPT1
	fJUF5y/PQ91BeQeiw+VwPVA3fqlHxJdHw5OE6MhTdGTqQyiBvUPBd7bu5dCRmZYuTAWJ9zDEUn2
	mbp46cOUGvV9DLzVOTRw184vFTBnnmkrUjd8eSK/XWutN76hBkCmpS45cZwC5HhQ3Vc28yAnaKS
	t/
X-Google-Smtp-Source: AGHT+IEz3P0iXAib7Z2cGOdrMtRf7H0zrT15bfpF3CfQuDRY7RsUzDg9OOFcPbi3DmNBqyD6LTgZxg==
X-Received: by 2002:a17:902:cec3:b0:268:1034:ac8b with SMTP id d9443c01a7336-2951a405331mr24147385ad.26.1761877090372;
        Thu, 30 Oct 2025 19:18:10 -0700 (PDT)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2952699d9f1sm4060325ad.87.2025.10.30.19.18.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 19:18:09 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 10DE54209E4A; Fri, 31 Oct 2025 09:18:06 +0700 (WIB)
Date: Fri, 31 Oct 2025 09:18:06 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Networking <netdev@vger.kernel.org>,
	Linux BPF <bpf@vger.kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>
Subject: Re: [PATCH net-next] net: Reorganize networking documentation toctree
Message-ID: <aQQcXjetZJoL8Oy4@archie.me>
References: <20251028113923.41932-2-bagasdotme@gmail.com>
 <20251030175018.01eda2a5@kernel.org>
 <aQQM0Likqs1RFNQ1@archie.me>
 <20251030182251.60e01849@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="BXvm9uCYqYGRGsTM"
Content-Disposition: inline
In-Reply-To: <20251030182251.60e01849@kernel.org>


--BXvm9uCYqYGRGsTM
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2025 at 06:22:51PM -0700, Jakub Kicinski wrote:
> On Fri, 31 Oct 2025 08:11:44 +0700 Bagas Sanjaya wrote:
> > On Thu, Oct 30, 2025 at 05:50:18PM -0700, Jakub Kicinski wrote:
> > > On Tue, 28 Oct 2025 18:39:24 +0700 Bagas Sanjaya wrote: =20
> > > > Current netdev docs has one large, unorganized toctree that makes
> > > > finding relevant docs harder like a needle in a haystack. Split the
> > > > toctree into four categories: networking core; protocols; devices; =
and
> > > > assorted miscellaneous.
> > > >=20
> > > > While at it, also sort the toctree entries and reduce toctree depth=
=2E =20
> > >=20
> > > Looking at the outcome -- I'm not sure we're achieving sufficient
> > > categorization here. It's a hard problem to group these things.
> > > What ends up under Networking devices and Miscellaneous seems
> > > pretty random. Bunch of the entries under there should be in protocols
> > > or core. And at the end of the day if we don't have a very intuitive
> > > categorization the reader has to search anyway. So no point.. =20
> >=20
> > Do you have any categorization suggestions then?
>=20
> No.

OK, thanks!

--=20
An old man doll... just what I always wanted! - Clara

--BXvm9uCYqYGRGsTM
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaQQcVwAKCRD2uYlJVVFO
o+zbAP0fBuQ0lT/TbMuaV0+mS7JJ3Wnvl0OIvrBazmA/rcVQfgD+ILTIpGeEuT/n
oVmkefA17coMJv4DSK7ZhwR81/aqywU=
=XtrN
-----END PGP SIGNATURE-----

--BXvm9uCYqYGRGsTM--

