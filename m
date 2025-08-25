Return-Path: <bpf+bounces-66402-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 272D7B34739
	for <lists+bpf@lfdr.de>; Mon, 25 Aug 2025 18:24:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F180D1A8881F
	for <lists+bpf@lfdr.de>; Mon, 25 Aug 2025 16:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A288A3002C7;
	Mon, 25 Aug 2025 16:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aeQ2uEn8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D10BD2FF64F
	for <bpf@vger.kernel.org>; Mon, 25 Aug 2025 16:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756139067; cv=none; b=H6+dTWIcZvVVhN50A4Gadhf7Achyl310h/LI2tZkqe3lAI1qFoWyxZRZAmxyUHRY3Shk7H+cID/RvDLxc7kk6pPAcmHYbYxOCeAWymAtLrginW+KwRpkaI0yHT1F7OwfgLWbUVn3K//dEUVzUAOq2EtHCNyAXICJOI2PGSVt3EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756139067; c=relaxed/simple;
	bh=cScOO7BLGJ9pGCAb4W+aUT+sRDk6URJxkVs8G4qUTrk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kujAN0trIRDIkizE7PdB+WvSnqhx/mbLxpH/xDU7vT3z1Xz0dW3TGvnl//lNzkMvyHPipK1aPLT0B6te1/Yah9y1IVcdsdrBDsggLJ1FqQ8B76u6VoNZdXEeS+MJc5Sj1YsatVz6CLbXMUHF1BPi5QZ3VSR69p8act7h4cNGAbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aeQ2uEn8; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-771e15ce64eso878977b3a.0
        for <bpf@vger.kernel.org>; Mon, 25 Aug 2025 09:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756139065; x=1756743865; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iBQiZLO7GqI3grb9fCCkYuBlOig0hVje3gQbNQlq8n8=;
        b=aeQ2uEn8m/9Cm8CmlLUcvbNOIrS2jDryvSimQFVsNMpQ9sIKB6akEVcIXObjzRLVSB
         vm6NnJP5Adm4yNt+E1rJqkjRh7ntcVx8Uc7aG4r0vWGOKenijNxjZquxm7Vmj4YCMuKA
         7ZKBS+th1iFGSLQlIGymmHKSduKSAzEEPSwI5PvpbHkaxDAntBhyEULho8u3VKkPi+Yd
         8ncPN43qodfY2GHKAG98/18FdZCnJhe67XYnpj7PdAeqrg4KeRhcC4GMmPkwats1ZCOq
         EhVxiLQKMoNWABJrVS+Ti3ioR4Rifrzfnvt1GIJ4gBmFtB7WqbQvRCmOQoiWgBu34W+N
         uCgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756139065; x=1756743865;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iBQiZLO7GqI3grb9fCCkYuBlOig0hVje3gQbNQlq8n8=;
        b=Jt0jH++rnsSOERZGUlJmA6SE7dOJveEuImsH4URUFFjv9sIjqLn9hXwD8A51Lnzaup
         p9c7RzjVLtPOlMsDesXFxDTD7Lumtkwrhif7SsTzFq3Zob4km0jEHHfoZqq0zYCF6hMV
         pRSK8Kb5/lMi/yIDmuHfYljhjDdlwCenpIic06x7AkSv/QCp4YtJ5D7k8EGX7tzstTJV
         Ey0ytv2aT/N/qYDX18Da5bOoVuFqD480ZKGXVxVgGrZRt4yIxnml/SFI1Pm15KGV4Gbz
         m+z4jM0hQ5RRO5poroY/fb8eqvDklork7Ii6DDDJd/bXnVTedVj3mqBkA7wyJLMYNUGJ
         Vb4w==
X-Gm-Message-State: AOJu0YzyxuHKGPTqLTIf/g9Nw9XgCZk5AtE/sfGivcCQ5qJKUy8SCw3e
	m3emNMO14qd67E9gg35V8tWsWIvaa5j9rn9E8W2Rrq69nHjQk6AyA624JiVSodM4
X-Gm-Gg: ASbGncvohUQXNbL/GcLpumZrznN/FCzCjgkZHakI4cKI+5bkjTud4HJpZdc0uh/mu8F
	F4AlRaHCXM1b6ZcOyGcz80ewnuljWTMq0yXC+EUi2dcr+R9uTIwF17lDh0guuwZ/fwiQE8G52W6
	4kWh7fIzOGvZ9DULB2ylbGCmxO3JVwl4t2+YilOiI5moCLwcJBCX3R8eN5QNMud0rjsW+nakxO4
	0yLmgoTvrTriMDN5rHWxUsyZlkHAl5IfWeJ97fEFaG188FW3Pijm/RFQ0Vu/713twfGJjARDBC1
	ZBAl1EhQxaLLAqNMfheI+psB1roVAPrBeMqHZHVsS1ThBsiCEznicYmpr1Kr1H3Z1aB9gAh9xFr
	xeKN//O1RoiSiHppSgvhlVixphXes
X-Google-Smtp-Source: AGHT+IHnEnwMKsLAxXWd7xDvkck/9co5BRmPK0PGqFOR8DJAD98b2t06TB0Iybs5uzytzNqfHFUXww==
X-Received: by 2002:a05:6a00:3e0d:b0:771:ec91:4b92 with SMTP id d2e1a72fcca58-771ec919de4mr2737131b3a.18.1756139064922;
        Mon, 25 Aug 2025 09:24:24 -0700 (PDT)
Received: from ?IPv6:2620:10d:c096:14a::947? ([2620:10d:c090:600::1:48d8])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-770536cd341sm5422343b3a.72.2025.08.25.09.24.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 09:24:24 -0700 (PDT)
Message-ID: <5d15719140555e1213192aee9078efbd3ee43507.camel@gmail.com>
Subject: Re: [PATCH v4 bpf-next 1/2] bpf: improve the general precision of
 tnum_mul
From: Eduard Zingerman <eddyz87@gmail.com>
To: Nandakumar Edamana <nandakumar@nandakumar.co.in>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann	 <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Jakub Sitnicki	 <jakub@cloudflare.com>, Harishankar Vishwanathan	
 <harishankar.vishwanathan@gmail.com>
Date: Mon, 25 Aug 2025 09:24:22 -0700
In-Reply-To: <132d5874-9a1f-496f-a08c-02b99918aa59@nandakumar.co.in>
References: <20250822170821.2053848-1-nandakumar@nandakumar.co.in>
	 <8834d8df16f050ec9e906a850c894b481dfa022c.camel@gmail.com>
	 <116ef3d2-51a5-444c-ad51-126043649226@nandakumar.co.in>
	 <0ed1ad1d73d2c4468b3a02b3034b7dfd6e693d66.camel@gmail.com>
	 <132d5874-9a1f-496f-a08c-02b99918aa59@nandakumar.co.in>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-08-25 at 09:46 +0530, Nandakumar Edamana wrote:
> Status as of now:
>=20
> DECIDED:
>=20
> 1. Replace the current outer comment for the new tnum_mul() with a
>  =C2=A0 =C2=A0cleaner explanation and the example from the README of the =
test
>  =C2=A0 =C2=A0program.
>=20
> 2. (Related to PATCH 2/2) Drop the trivial tests.
>=20
> UNDECIDED:
>=20
> Instead of just doing tnum_mul(a, b),
>=20
> a) whether to do best(tnum_mul(a, b), tnum_mul(b, a))
> b) whether to do best(best(tnum_mul(a, b), tnum_mul(b, a)),
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 best(tnum_mul_old(a, b), tnum_mul_old(b, a)))

I'd drop both undecided points.

