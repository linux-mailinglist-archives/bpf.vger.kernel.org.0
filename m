Return-Path: <bpf+bounces-62484-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55AA2AFAF97
	for <lists+bpf@lfdr.de>; Mon,  7 Jul 2025 11:24:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70D803BD52E
	for <lists+bpf@lfdr.de>; Mon,  7 Jul 2025 09:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 817FE28DB7B;
	Mon,  7 Jul 2025 09:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="JJvAdifd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B82C28D8EA
	for <bpf@vger.kernel.org>; Mon,  7 Jul 2025 09:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751880235; cv=none; b=antugAcUFJgYU5E3J+TT68jWkkt4QSax4cb7YzMD3RXsd5xKitOMzoqJTdjRoaVJZ1I/x8piUDuCYYA6iqln71zOprOgys2Xga5oHF3viFGG6lMa49VfaFeVFIq/+yzlN6FS3+9omc8T5466tSlni7MkMEK/MZ7zCzn0G/zepW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751880235; c=relaxed/simple;
	bh=k486wDDxfr0bcvDQG60f8tWDcYoRzeaxKBRKmoxQRu0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZGa/prUVIqCCwskX21ikwXrOlOalxLIaO4AvDsBB96ZcPwDe1i5aKtY3xhk/v1J0JyCQcVyQLlOf9hDVyZww/Ex+UUr1wqLirPs0CNXmq7t9TEzN04kMnkyzu4TM2D0JwkdL1NcVF4S/ZD4ppL3pt/GmB2VE6xPXxBK0zPuIdYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=JJvAdifd; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3a4f72cba73so2447478f8f.1
        for <bpf@vger.kernel.org>; Mon, 07 Jul 2025 02:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1751880231; x=1752485031; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FqKblBf6CUsGl/mCy2pm5G2S6HLKhv5qOw5Xqk6h5bI=;
        b=JJvAdifdCJS8gaL4vnr6imCCvgawj16Stw7XK8qBuYbfT99MQBe7p4BHiWKDnr7jAU
         fKtc7FxmolHHrPDRy7wLHcNMmkX54UJONHvILH+dPRLkDyHa/knZhK867UiCE2h/ou0i
         UdZeOL/hIDGzRyzCN4lumh+Oqsp9LGUIKXsY2S9e/XESLVXc3BghXI6zuMh+JhXcbXd5
         Ou8G5M+rfmLnOcVcgF9vGGp1RydnCvJKQDc/J0sv8ifWNkcjQQmmziMCs8YI19ZBuaxZ
         oJ1dT5rDy9dUuVx39HOzPY7wWdA5QLZxy+/KsVZhmfnJ0uCby85TLXrcM9CR3fIFrHvW
         +F7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751880231; x=1752485031;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FqKblBf6CUsGl/mCy2pm5G2S6HLKhv5qOw5Xqk6h5bI=;
        b=SgbHgsIEyMC1h9TNM57JA4/oyib7veI+CLYriFepwJCibfE6hKT3tJ7MXDPOv9A0PA
         RXe7vuoUYdm/OKJD20XJ5N0SYvDTXGqMUAVh0eJLEJrf6ra8//7ymYQqGBsZxCsdXpvj
         LdhqnJijg6t8LtoqtwlB5SUtqFZQvw9te4xZ2r7bidpZmYy3KZrg9kmdPuI/hbgv1KYj
         xD7uaFCjvMsncrB+eB+WX8IF31fDar+//MjJsgWKFZeIxRuu2Ls1JwzfwYU+8Dh1sCgh
         hyVt/pWgVgccwPWAmWbbxHMTi4QkkUHj9hlKC3e1/k7w8RcYHP8AXx9afnVmhZGN2qlD
         k/1Q==
X-Forwarded-Encrypted: i=1; AJvYcCXypij03zGQpRNuI1pknE+nAVUWMKKcp1UN/DQ+SVNfyd4XbkmIZj8m41j3TySoXWKA6Do=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcMplhybJBLMsUobolrQ0zKObcEp1x+6dYNm73xomWsE0lcsgy
	ORyGHDbCBLE/PZrAFD3XZp2xcZoIZ+rzwsixJkA2CT0lLy8gsdXdW5Vofpn8ykXqNbQ=
X-Gm-Gg: ASbGncuTWxc6BFpnrX9f6972QPiJkXQl4/q7B4le3LliGkYPlSTBrjRhfETE7scXhCM
	uZr+yaOPmVf4LM6ZAt+W9t1BtOMRQkiJ0O0hjRBOxomuJeQpT9zMSrAx3FafquyFmQ53WNEdrx1
	LaAxiYPOfIFd7A10fn0OYkK4KIQCyzq+cCiI+KtGIaK61zk9C9dI3a9oiYnO2bRMa9r/s00uZ0x
	Ime1JBRkfdOfe+a/31A08urU+q/dOdv8vX0sLBy2fw79gPSDLCus7CBBVUyqXOYq4UbVgZk8Ch9
	iOyOsAXfXclAMel6U4vjIn2U1JxsnTLV0KgqPXQy4hVXlXNFM6qv0d4ytzXWMHGff/j5K5gEhtM
	=
X-Google-Smtp-Source: AGHT+IHJrPNVBlcjf/0VEyIW2RxUb2n+reYTnzi8FGJY00p2BdD7RT52urYWmFfuCMqVzbeCW5Zitg==
X-Received: by 2002:a05:6000:2386:b0:3a5:8977:e0fd with SMTP id ffacd0b85a97d-3b48f763f20mr9641920f8f.0.1751880231361;
        Mon, 07 Jul 2025 02:23:51 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454b1698e24sm105561945e9.34.2025.07.07.02.23.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 02:23:50 -0700 (PDT)
Date: Mon, 7 Jul 2025 11:23:49 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Tejun Heo <tj@kernel.org>, "Paul E . McKenney" <paulmck@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, JP Kobryn <inwardvessel@gmail.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Ying Huang <huang.ying.caritas@gmail.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Alexei Starovoitov <ast@kernel.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, bpf@vger.kernel.org, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH v3] cgroup: llist: avoid memory tears for llist_node
Message-ID: <6isu4w3ri66t7kli43hpw4mehjvhipzndktbxrar3ttccap6jy@q2f2xdimxpga>
References: <20250704180804.3598503-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gsl2hznmnpg6a4vg"
Content-Disposition: inline
In-Reply-To: <20250704180804.3598503-1-shakeel.butt@linux.dev>


--gsl2hznmnpg6a4vg
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH v3] cgroup: llist: avoid memory tears for llist_node
MIME-Version: 1.0

On Fri, Jul 04, 2025 at 11:08:04AM -0700, Shakeel Butt <shakeel.butt@linux.dev> wrote:
> More specifically the rstat updater and the flusher can race and cause
> a scenario where the stats updater skips adding the css to the
> lockless list but the flusher might not see those updates done by the
> skipped updater.  This is benign race and the subsequent flusher will
> flush those stats and at the moment there aren't any rstat users which
> are not fine with this kind of race.

Yes, the updaters and flushers has always been in a race.

> However some future user might want more stricter guarantee, so let's
> add appropriate comments to ease the job of future users.

I believe there should never be such (external) users as updaters
shouldn't be excluded by flushers in principle. (There is the exclusion
for bookkeeping the updated tree paths correctly though.)

So, thanks for the comments, one should be wary of them when considering
the update updated subtree.

Michal

--gsl2hznmnpg6a4vg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaGuSIgAKCRB+PQLnlNv4
CI7wAP4u/qgZyNwgTwsnKQhklrdWHI6kyPoLqOFcM+dj1w9SpwD+IdhdgkfQ/WaU
LR0OIEBPOfWPYJAbpSSCgzEVBHFm8gc=
=Rpm6
-----END PGP SIGNATURE-----

--gsl2hznmnpg6a4vg--

