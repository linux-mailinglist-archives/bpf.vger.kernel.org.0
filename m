Return-Path: <bpf+bounces-28682-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 177F68BD0B6
	for <lists+bpf@lfdr.de>; Mon,  6 May 2024 16:50:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB8691F220E0
	for <lists+bpf@lfdr.de>; Mon,  6 May 2024 14:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 179CF155398;
	Mon,  6 May 2024 14:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i5z66Dbe"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FFA6153583
	for <bpf@vger.kernel.org>; Mon,  6 May 2024 14:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715006990; cv=none; b=gj4toq40X19ezwEPwURD1q6hFbx7hRbP63srPetZPxB2VRSoox1brUFD3BZUzs63FhVpj79FBkeBiVslixGHrhJwhBPMQTo20aNC1NFFhCm3+KFNl9dGdE2Ey2DtN1jywtkkxxEp5w16zh33sX8fP9++XcMxsXbY2YAET5BmuxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715006990; c=relaxed/simple;
	bh=wFEAgz9DoEMtNEfhF2whHUgl+SQ1hbYNvw0LVwBJMHI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jy+Zl+7GiB+5s/Jsx9V98ORoB535uG6XBM860WW69+ohbN+1KWZu17IZtjgTTiA4K9dgBbj4P+Aei4jXNCxyDw1oiswDgZnoPdHkneKib/LdOE+izimieqYC3S0783G3Yw9rhS6zMKYnUdY32Z72sC6mPG8clrGeMzDBifr4TTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i5z66Dbe; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715006988;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ouwyK0typuZ1ow/pNC/Gp96v2+HGSiLFxZMM2D2vdpo=;
	b=i5z66DbeM7ExaCLJMcGHwWdaMlSUede8CvlwCTlHRwHn7ui7SFUIA36XxWTMLM3tgM30bJ
	nfVCnLXzwXyh95OOCCikMDvyH41+pfv2hXlwKs4IaulMa5PL5h6S59PQzjZdzuwFBSEecu
	aHPCdMAlFn2Jub6ysVsGMm2aB5qSdow=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-219-WAecL6woNUie1QQfQDGzqA-1; Mon, 06 May 2024 10:49:46 -0400
X-MC-Unique: WAecL6woNUie1QQfQDGzqA-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-41e9feb655eso4831535e9.1
        for <bpf@vger.kernel.org>; Mon, 06 May 2024 07:49:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715006984; x=1715611784;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ouwyK0typuZ1ow/pNC/Gp96v2+HGSiLFxZMM2D2vdpo=;
        b=A08tlAgUEZSUKR/zfGJb5jkA19P3VGXu3MDRBARQ75XqFw6wTpIcDISRCfgQ0uV1Nf
         ukgelJwWBcbrvRnHoC7mOBNp1WTkewbZ5wYTjy/rc0IJwrQV5vHOf0jIWIRfBoin2fSa
         sxQMIPiAJ44MXJPyesHNYwIINcHk2LCcdwX4vwEG+qiWxKk6LGK/W2R3yKTqiACFVpGR
         6HHNzMIyMWfL0n1LoOfJ5A501BrX8qqQDgCtBdUX7Hz0dN5xdP3WU9FH07+DIWzw9ij8
         nW0LuYxwWhc6UlIzMsncZAPgplyeix2asN6koUwwY1/I27tiNfJNRsVMLTf9zVp6hKG5
         oWqg==
X-Forwarded-Encrypted: i=1; AJvYcCXM75EtqIbbZIw5vP+dPEeK/Tw8TOu8ly7dEIYWs7qC2PbY0u/93i2wTnrlek4pZl3OY5oEiI7/r06L+fVm92Jv8yom
X-Gm-Message-State: AOJu0Yx5NT7jl8Ji5j7ebFCbywd4FXUlUm7dQkgvS+hA5tMbnsqgmb9/
	fhHRDMbTbcz6SBtfsEBjSH4uF+w1lRkmCZjWJc+qoXkPE7Md7YYZLAxFKx8W0+Ck1BJkchrr2In
	Wtjp2uT48qqNX953f5mrU5WKbCARNuVSDj9bmxhN3NhhPzhV64g==
X-Received: by 2002:a05:600c:4743:b0:41b:ca55:2e2c with SMTP id w3-20020a05600c474300b0041bca552e2cmr8502329wmo.17.1715006983659;
        Mon, 06 May 2024 07:49:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFMEmpLMRChpFtoTgMDV3aoqDMFyufxEAAMjuwb6gH8jVd4UbrgetEx8t9mH1iRsKhjutk0Nw==
X-Received: by 2002:a05:600c:4743:b0:41b:ca55:2e2c with SMTP id w3-20020a05600c474300b0041bca552e2cmr8502298wmo.17.1715006983060;
        Mon, 06 May 2024 07:49:43 -0700 (PDT)
Received: from localhost (net-93-151-202-124.cust.dsl.teletu.it. [93.151.202.124])
        by smtp.gmail.com with ESMTPSA id cw1-20020a056000090100b0034dec80428asm10817755wrb.67.2024.05.06.07.49.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 07:49:42 -0700 (PDT)
Date: Mon, 6 May 2024 16:49:40 +0200
From: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To: syzbot <syzbot+f534bd500d914e34b59e@syzkaller.appspotmail.com>
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
	daniel@iogearbox.net, davem@davemloft.net, edumazet@google.com,
	hawk@kernel.org, john.fastabend@gmail.com, kuba@kernel.org,
	linux-kernel@vger.kernel.org, lorenzo@kernel.org,
	netdev@vger.kernel.org, pabeni@redhat.com,
	syzkaller-bugs@googlegroups.com, toke@redhat.com
Subject: Re: [syzbot] [bpf?] [net?] WARNING in __xdp_reg_mem_model
Message-ID: <ZjjuBCk33QtxLrAm@lore-desk>
References: <0000000000004cc3030616474b1e@google.com>
 <000000000000ae301f0617a4a52c@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vAieqiNxGUQydHCv"
Content-Disposition: inline
In-Reply-To: <000000000000ae301f0617a4a52c@google.com>


--vAieqiNxGUQydHCv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> syzbot has bisected this issue to:
>=20
> commit 2b0cfa6e49566c8fa6759734cf821aa6e8271a9e
> Author: Lorenzo Bianconi <lorenzo@kernel.org>
> Date:   Mon Feb 12 09:50:54 2024 +0000
>=20
>     net: add generic percpu page_pool allocator
>=20
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D151860d498=
0000
> start commit:   f99c5f563c17 Merge tag 'nf-24-03-21' of git://git.kernel.=
o..
> git tree:       net
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=3D171860d498=
0000
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D131860d4980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D6fb1be60a193d=
440
> dashboard link: https://syzkaller.appspot.com/bug?extid=3Df534bd500d914e3=
4b59e
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D17ac600b180=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D1144b797180000
>=20
> Reported-by: syzbot+f534bd500d914e34b59e@syzkaller.appspotmail.com
> Fixes: 2b0cfa6e4956 ("net: add generic percpu page_pool allocator")
>=20
> For information about bisection process see: https://goo.gl/tpsmEJ#bisect=
ion
>=20

Looking at the code, the root cause of the issue is the WARN(1) in
__xdp_reg_mem_model routine. __mem_id_init_hash_table() can fail just if rht
allocation fails. Do we really need this WARN(1)? It has been introduced in=
 the
commit below:

commit 8d5d88527587516bd58ff0f3810f07c38e65e2be
Author: Jesper Dangaard Brouer <brouer@redhat.com>
Date:   Tue Apr 17 16:46:12 2018 +0200

    xdp: rhashtable with allocator ID to pointer mapping

Regards,
Lorenzo

--vAieqiNxGUQydHCv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZjjuBAAKCRA6cBh0uS2t
rHE8AP9aiQe9PRxjbu8EA3OAzA4evmD4DeMhokGWsZjanPp69QD/Qr+N4crIXk/4
h4vZ5Fo/cpxn4NjaaMLCYwTl/2NQ5Qw=
=QBb4
-----END PGP SIGNATURE-----

--vAieqiNxGUQydHCv--


