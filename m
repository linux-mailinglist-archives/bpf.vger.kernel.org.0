Return-Path: <bpf+bounces-54864-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10123A74F39
	for <lists+bpf@lfdr.de>; Fri, 28 Mar 2025 18:29:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18355188FE5C
	for <lists+bpf@lfdr.de>; Fri, 28 Mar 2025 17:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0056F1D86ED;
	Fri, 28 Mar 2025 17:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mxhbVUiO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C5781A08B1
	for <bpf@vger.kernel.org>; Fri, 28 Mar 2025 17:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743182959; cv=none; b=bHO3udW62FB389oQUvxqFjRGoKJWlApn3q2iWZ0VEOAwHwVyNzGamlnheCoa8APiFVDNf9fBlRQ1fi79OZk2uo+RZR5RknaWZiMPSva0+QMBRLFcg8Xg3Tyl5cX4dvrww/yrI+Y6L+x2h+vlIcLAQd9o3wAZ44oEJq5v+uDbAX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743182959; c=relaxed/simple;
	bh=F2XBGPntS64CFIQZOkcJRkWFezPKMXkMZ/Wv6bmQdcU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QJSJKcTnk365F4MpDIrbyH4BQJwskxrMGmRkE9Bsi+HzieSxQElVyBRkkLKkHSXjeabKKzanp1ToLWF3T25cnq986dnWfBBw25pIXt/VIzG6Em68qmdk142Q7qzuLUU5wtGsXoPy6uuDteXhNeoHNaPEikSCifKNpdGPmNPXdrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mxhbVUiO; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-301493f461eso3102683a91.3
        for <bpf@vger.kernel.org>; Fri, 28 Mar 2025 10:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743182956; x=1743787756; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nfQMRNomMjIl/8WkyoEZcGgwH2FfbujbB3aZexxzKVg=;
        b=mxhbVUiOyBM87WLo62nD9VebGeD+mKaBxuVUaatDEvT0utgB5lK53dWF7GoZ53TDws
         NDfFixaz/UovKmYPW0cZSdsbGw5MAZzv8aOIPkUsOoolGps7tz0Hxyr+QmB6csqGvxzU
         1oUG9T00pV8MSI2WCOYIQYH+qdqlTNLM857J6kG3Dv5pYL48uq68pLgSz8cNvM0OjUaH
         GYRluZyRad52ZXuyxhFUjQUvoUZjHypl+DyBdzpwlavbp/K+4zAy+5hv5bBzOxyi0wGy
         Ak6537Z2FtfAwME8krSJlkiG046y9eZjOocfGJt7+hYeJUHeotk2wjCac6kW5++DHFzB
         oVcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743182956; x=1743787756;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nfQMRNomMjIl/8WkyoEZcGgwH2FfbujbB3aZexxzKVg=;
        b=SpKni0OABCBqEy+ZpJ5fECuAOuEZIC7k++nJSdUbeOIibkkOZWi7mNnEIwrnJfj3Md
         lidAoF5ivLjEItH9UOd+/Ma3DNxCKLPlxmjlCjejHEYBesio6A2LAYJGZm+fqTZkL+kg
         ZBQpBI7Y12wFhGpHyllwG/pxe3Glfbd6y00KHHtzchmKUlL/Ut8BOkgcG0wwIs868Ydh
         73jB1Q1KYm1AZ5jOyG70c3NcfQOBzBCUy+vjPyd/8ASsB3U07dNEo8aBLSXGODQT+2He
         nGTnxIbTy22Tsx1l+n7e1zpr7TakgtQXUwPnu+3vOpBxnJJ/UqjO76J+oQ5PT4mUH9PW
         DLGw==
X-Gm-Message-State: AOJu0YwKabT20o26Oa2S77uPapuEtx7IyR7m6CHN2+ln8WwK3tRSsVU1
	l7UhwXGNp7pazRwIvxSbIEMt5ebMiAxVFkftuuL5lVfo1MqtH4Up
X-Gm-Gg: ASbGnctbk3IpWTW9GVYFGahXycGmOoakJkLe8AzuQwpZuF0aHy7KHmPDiHJhiYGwzDf
	wEUD652xL0uB0POV6GIk4vobMAqYDTmqeUouCJ8F4SKobU2f9wj50KJGPJIcQohfef6hcPO1euT
	QaFNL+JRGJQx4gMrsD1tsw/rkdTpA7LxmZeWmfDoyB/IJvGKqmxawVICJRRyBCfzIz9RJs8R3py
	G+gmo5avqiHSFYz1DaSwayg4ArvLstAlocCL2KcttpCb8w7g8UrM9US/0d1Wz7vkQpMIrHQha9F
	qaB3SCJZasEVmFv3H7arnDpGuclwvnjLctqmdNKv
X-Google-Smtp-Source: AGHT+IHULmUY1GRn93xLX5FuwWtZWs6ao/vpCVbotJzgEehHKGwvrwQ+Y/7maY6bsMe14WEHoRMOgg==
X-Received: by 2002:a17:90b:3a85:b0:2ff:5ec1:6c6a with SMTP id 98e67ed59e1d1-305320b1e26mr159851a91.18.1743182956149;
        Fri, 28 Mar 2025 10:29:16 -0700 (PDT)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3039dcf48fcsm4533268a91.0.2025.03.28.10.29.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Mar 2025 10:29:15 -0700 (PDT)
Message-ID: <d3edc724c733fc656eb61f98c9a78273ebd28df9.camel@gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: add getters for BTF.ext func and line
 info
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Mykyta Yatsenko
	 <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, 	kafai@meta.com, kernel-team@meta.com, Mykyta
 Yatsenko <yatsenko@meta.com>
Date: Fri, 28 Mar 2025 10:29:10 -0700
In-Reply-To: <CAEf4BzY_rbdXFDyYN=s7c25R5kwpBX5-zxQd8Q+6wX2N0r6Uhw@mail.gmail.com>
References: <20250326180714.44954-1-mykyta.yatsenko5@gmail.com>
	 <CAEf4BzY_rbdXFDyYN=s7c25R5kwpBX5-zxQd8Q+6wX2N0r6Uhw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-03-28 at 10:14 -0700, Andrii Nakryiko wrote:

[...]

> As Eduard mentioned, I don't think `void *` is a good interface. We
> have bpf_line_info_min and bpf_func_info_min structs in
> libbpf_internal.h. We have never changed those types, so at this point
> I feel comfortable enough to expose them as API types. Let's drop the
> _min suffix, and move definitions to btf.h?
>=20
> The only question is whether to document that each record could be
> bigger in size than sizeof(struct bpf_func_info) (and similarly for
> bpf_line_info), and thus user should always care about
> func_info_rec_size? Or, to keep it ergonomic and simple, and basically
> always return sizeof(struct bpf_func_info) data (and if it so happens
> that we'll in the future have different record sizes, then we'll
> create a local trimmed representation for user; it's a pain, but we
> won't be really stuck from API compatibility standpoint).

There is also an option to do:

    const struct bpf_line_info *bpf_program__line_info(const struct bpf_pro=
gram *prog, u32 idx)

and hide the rec_size.
But yes, simply assuming the array of `struct bpf_line_info` looks reasonab=
le.

[...]


