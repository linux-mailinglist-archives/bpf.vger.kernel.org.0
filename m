Return-Path: <bpf+bounces-36792-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00ADA94D709
	for <lists+bpf@lfdr.de>; Fri,  9 Aug 2024 21:14:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1197D1C22468
	for <lists+bpf@lfdr.de>; Fri,  9 Aug 2024 19:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9368015AD90;
	Fri,  9 Aug 2024 19:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gy4xOsOk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3CB213AA38
	for <bpf@vger.kernel.org>; Fri,  9 Aug 2024 19:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723230875; cv=none; b=DLYIwlSaAD9K6uTnGb7sWgHVpRSx6wLDNO+zgfS6QDLS21PnlOyLf+ekvgno6EyoXippRQLPfvWXTHiodAvwMgJjyKo6iTHZxR+mtcESx6jzI12dBVLG74MDENHHJlJPGlLhoeLHwAZ5sM4JzQi2BFjF1sfqrHK8auzZlA/YiwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723230875; c=relaxed/simple;
	bh=QTwrGMH/ZK5+bUJ31t9nf7/A+rGh57Zgr65RU5vNMYI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gkxE23C6nv9eNQE7uyLLzJkq11/lCO4OEdiXsmkdOyrKMCD8YfCzOGFYQdrBG6yfUmn/ZDZxTJt1bvVSj+/H+pZ0GUyC/elpaHI8v3672pTkXP6GAWKS8q06XY8r8vvKpA1jJ4EUNBh/Mt1wToDmH0MFP3rLWiooWoBotJARr1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gy4xOsOk; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1fc4fccdd78so20711055ad.2
        for <bpf@vger.kernel.org>; Fri, 09 Aug 2024 12:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723230873; x=1723835673; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DiZ9pLIpWoEX7m20bsoFVi1emGaCnlVdjT8ezXO1tcg=;
        b=gy4xOsOkob4vc8GeyQFIaGZUJAAB+2mlYl1kMEfSxFWA7fRQN6cx8rIaEbm9ZN8LuL
         yjhUnkecsqiWS2uXwGWcSDCTAAcB+s6aWZw/519pcjQtFJVkt8wuFNMk/3Byb45GBv3K
         ojhROlbECoIMqrXNyjjwTdk3Iec0OG9QSyBL5CqHDvkesOr1kOrOBG1ni0tUMc5ewO8v
         z1jbnv8ioikr7Sc6VHSL7pOzK8nnqDQp6FK+VhwQ0ds354FImY0FNTFK+DskQ5EQd5Bd
         tBwYv3zfn25n0PuLhzoNufFOS683K0TutcEH0EKx2jnvAGHcwslX2eM5nbaExNRlhmIS
         tcOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723230873; x=1723835673;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DiZ9pLIpWoEX7m20bsoFVi1emGaCnlVdjT8ezXO1tcg=;
        b=eqvEJ7kYjmNEd1Go7OjoOOrvalHTe5HZe1zREwxQopJeSERJC3nerSlMjFJQrbgV/b
         8LUlt5/iOmxGpzwsna7NjcANAYgzaTHM4hqOF7WmNxCxp6rE3+mX6sjbP2zU7zaMk7/s
         aUPp1rpkIjosNLBRBLDiLMqV8hWBHOUdYMr8sy640xZemAs+TYfFb//5j87SosreBr8B
         OTRnGhFEfYRI9CZ/0FR6/YIBIY3elCXVd2oET5XVI/0/JcHR3XKft9sJUQbO9nFUYym0
         jNWluRLf6O669A/SR4/ni72ROBGS/86J4n2BmnGDQesNVX6RPKZa8RSmObIs9k6KHyEx
         /o+w==
X-Forwarded-Encrypted: i=1; AJvYcCXYD51X835N+4nzJgcEuqFMv8esa8KBPKl9pI2NGCXCb0KmHBTRRGstEsO9DbdVkRd6izmWpgwHS02GlKbK5YqBePsx
X-Gm-Message-State: AOJu0YyWJ3f0Cq/Q5Y3mzigUTiZxc78njCI6ehSpYQrgdXfHXIaML+fq
	r8lHN2QOJxcQh+XG6OGcx/foWf7yTHbOsmNFXyxVfU2f69E7NYOq
X-Google-Smtp-Source: AGHT+IFKLxfu9Qe5mSUPhVcWaTAPLJt0jbDStkqh9UJiy5tVTsp4fFzr+T0K2ApWdJYJPyhiXX4YxA==
X-Received: by 2002:a17:902:e742:b0:1fb:8e00:e5e8 with SMTP id d9443c01a7336-200ae4db9bemr30276355ad.10.1723230873009;
        Fri, 09 Aug 2024 12:14:33 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-200bba3f475sm945255ad.258.2024.08.09.12.14.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 12:14:32 -0700 (PDT)
Message-ID: <2689ece2c10e234a2326ad4406439ad7c8d35a03.camel@gmail.com>
Subject: Re: [PATCH bpf-next 2/3] bpf: allow passing struct bpf_iter_<type>
 as kfunc arguments
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
 ast@kernel.org,  daniel@iogearbox.net, martin.lau@kernel.org
Cc: tj@kernel.org, void@manifault.com
Date: Fri, 09 Aug 2024 12:14:27 -0700
In-Reply-To: <20240808232230.2848712-3-andrii@kernel.org>
References: <20240808232230.2848712-1-andrii@kernel.org>
	 <20240808232230.2848712-3-andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 (3.52.3-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-08-08 at 16:22 -0700, Andrii Nakryiko wrote:
> There are potentially useful cases where a specific iterator type might
> need to be passed into some kfunc. So, in addition to existing
> bpf_iter_<type>_{new,next,destroy}() kfuncs, allow to pass iterator
> pointer to any kfunc.
>=20
> We employ "__iter" naming suffix for arguments that are meant to accept
> iterators. We also enforce that they accept PTR -> STRUCT btf_iter_<type>
> type chain and point to a valid initialized on-the-stack iterator state.
>=20
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---

In current form this allows the following usage:

    SEC("?socket")
    __success
    int testmod_seq_getter_good(const void *ctx)
    {
    	struct bpf_iter_testmod_seq it;
    	s64 sum =3D 0;
   =20
    	bpf_iter_testmod_seq_new(&it, 100, 100);
    	sum *=3D bpf_iter_testmod_seq_value(0, &it);
    	bpf_iter_testmod_seq_destroy(&it);
   =20
    	return sum;
    }

Do we want to ensure that iterator is not drained before the call to
bpf_iter_testmod_seq_value()?

Otherwise this patch lgtm.

[...]


