Return-Path: <bpf+bounces-64297-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 337BAB11190
	for <lists+bpf@lfdr.de>; Thu, 24 Jul 2025 21:24:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 565F617AACB
	for <lists+bpf@lfdr.de>; Thu, 24 Jul 2025 19:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C67B9260578;
	Thu, 24 Jul 2025 19:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cKu5yNE9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D0220126A
	for <bpf@vger.kernel.org>; Thu, 24 Jul 2025 19:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753385069; cv=none; b=T50rk8VACiUq5IWO4R8rdN/B1FbZAF0KwMx9t0v3RyYl1bpqU7PkrarrM9o5F97HljrTmrmWVsLjSseqyUah2chJQEXF3RUCmQnfiurxA/qetWQZS0BXTCyXCj8Xsk0XToLm9jLg5CELRc994SkBcMjk7NPO7eGTZoOhx3wP390=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753385069; c=relaxed/simple;
	bh=qBFtwBs6VZFt4JV3LxBpMpCg74ZUY7NgsyH73TgygR8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cLPnBIL9AXV3UEH4y7WaoF+qAAtkGvyucrLKNB4aF0qIazTunx2pDX4jFHroOAiQthDLkiAJMyDzNFGGSs0glLqu1tN8eNamuQM9bQgtDjPQ4yGLbkcjR7NTDeqVslFzacRkizafPjh90XabunIdOTo/Xa4ZTjGo7HMtg2B/0u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cKu5yNE9; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b39011e5f8eso1329131a12.0
        for <bpf@vger.kernel.org>; Thu, 24 Jul 2025 12:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753385067; x=1753989867; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qBFtwBs6VZFt4JV3LxBpMpCg74ZUY7NgsyH73TgygR8=;
        b=cKu5yNE9bt4B7EXkqEdb7Z6AKB/KWBbumxIC3FqCeeXO8zvmBQpRDROAlvGGEWl7/X
         s1BAMRwM8UzEr1D7N0UxaqTXyZwYwrFI0MyQ0i+PZNlev5poEF6RMK1jOdnEKKRKMUOZ
         pmYU/wf9ShZh9cwVNlEPadsiG8QjHsbusHQCZAn/2l5oTgBtNbbFXyNeHKbNxltgH6Ks
         JxjW1ddtURzGTAdLok1S17iAiqXxh8Drhkpmlb+O90UVw/pFiaybSaIq1OPNzyGajg+s
         ps2EPTLEBIYG6snNU8pPGTzqWu6C2EP9fkl13UOaKu/kS8uw3LdHJxOgPHt+dJpsZgTl
         Rwjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753385067; x=1753989867;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qBFtwBs6VZFt4JV3LxBpMpCg74ZUY7NgsyH73TgygR8=;
        b=QTz8gm6TSpEhHrkff3gj4W7XTau6Z366jj3ABoePKqUo7DEL6xE56XZrUg6JyG1yTc
         8i973LZnkYpRZqAfCatT5P3kniIIHlhRF0WuPFKWHVjgPfKQFwrKTUTgJ3nBBDWBWNqv
         p99wNXqDc1r4UTJftoS6c9XUm2o4/31wu87O/eDbyPyaIvIFanKpvMyrjB380j8fzisF
         EZgLX+1msOIFNUxGUa/8pgQ72XLiY6CCxUwIh/+zOM6PUNjvDwcYUd0L84BwT/iX0wcM
         3oqlBe43Yyw2zlmlSxLKB0Ih0HPTQttTPQsRn9NFLZ5fyqM8OVPAYUXiRz0JGxjoDPOU
         ArPw==
X-Forwarded-Encrypted: i=1; AJvYcCVUv2Nq1yxNDCMSeE95UwgeayFHtpCMvaT2UMaVEhr+7eERXmpuLN2dxxFQMJOOINYUDxo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yym8l0Wv2stnyBw+iwXKA02hoIVM8qSewfe0h/5VhdKv1DALMCH
	3GM9PCSBG/XvRm+UJwamR8b+BqRlKAYsmL73S4VtfzgffTUzMXACLx/Nqh+fpltc
X-Gm-Gg: ASbGncv8ppWKZ17d5+6sGqRDKAzpnP+duVaSOGab9Q/w4sFHKpoXLXpdlWsJ/rkWXHm
	u5B6IEUHoQU60PzOZA7zrxTGZ6a0GBh3WQAJfDLeboE2M5CcLtiBDpm95rJH6rdENP68d0XfYes
	0OhCEk1VWWzJ7BrGkiYI9r4B0Ksu1ppqDzpNKLJajI8hATjxfX8UgcEeC43UfIGI3gV1bllzbVo
	xvTCh0aEjEiYZ9+FU9EZOG7iJHXxKWSsVvqw/DWuCwJYFKuBKr/EigBk5yA3N5yGUKtviMsNEpA
	GJ/1h/6+1DmS8L05mVxBpmSZHNigb9eclhRsPmuz8DtqA3UCpvMPKHFwzuIyxM5ZgrofkwelJ3h
	JCCSEMthlEuNAblTdF3ocuDHpgPYr
X-Google-Smtp-Source: AGHT+IE4NBBarHq/iV7tx61XWY649a0yrhXio6gBZ2Et1SAGxyfkiETkSc4hSkz74nC3g+uivEWjFg==
X-Received: by 2002:a17:90a:c2cb:b0:315:cc22:68d9 with SMTP id 98e67ed59e1d1-31e50859244mr10821075a91.31.1753385067253;
        Thu, 24 Jul 2025 12:24:27 -0700 (PDT)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3f6c09b532sm1946404a12.25.2025.07.24.12.24.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 12:24:26 -0700 (PDT)
Message-ID: <05db8df3b7df1628bf9c62c7ed0d8450fccb91df.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 4/4] selftests/bpf: Test invariants on JSLT
 crossing sign
From: Eduard Zingerman <eddyz87@gmail.com>
To: Paul Chaignon <paul.chaignon@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>,  Andrii Nakryiko <andrii@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, Shung-Hsi Yu <shung-hsi.yu@suse.com>
Date: Thu, 24 Jul 2025 12:24:23 -0700
In-Reply-To: <c1c843a647300feb510920c13d2d4d2003c56e0d.1753364265.git.paul.chaignon@gmail.com>
References: <cover.1753364265.git.paul.chaignon@gmail.com>
	 <c1c843a647300feb510920c13d2d4d2003c56e0d.1753364265.git.paul.chaignon@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-07-24 at 15:44 +0200, Paul Chaignon wrote:
> The improvement of the u64/s64 range refinement fixed the invariant
> violation that was happening on this test for BPF_JSLT when crossing the
> sign boundary.
>=20
> After this patch, we have one test remaining with a known invariant
> violation. It's the same test as fixed here but for 32 bits ranges.
>=20
> Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

