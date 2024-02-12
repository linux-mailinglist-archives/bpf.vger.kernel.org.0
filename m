Return-Path: <bpf+bounces-21746-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D1294851A0E
	for <lists+bpf@lfdr.de>; Mon, 12 Feb 2024 17:53:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7080A1F240C1
	for <lists+bpf@lfdr.de>; Mon, 12 Feb 2024 16:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92E993D0D0;
	Mon, 12 Feb 2024 16:53:09 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC8143E479
	for <bpf@vger.kernel.org>; Mon, 12 Feb 2024 16:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707756789; cv=none; b=CsjaFl7DcO5SjvIZcUucN2sle/HAH6oXcG8tvZ6WyUpy8Dp7WzSksat31alfDSJi+GR18hYxmaOLmzIU57pLuTaO3b646kz25sZO7cGYs0fUZJ+m3EiU36hzwGnRCKrfloDMwDcDdvtPdX958z7lTeSF9Wv04+Pr3Gk/cijIToc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707756789; c=relaxed/simple;
	bh=YCQLDJ435CVRJG5t8wWJLeBuhdcsdJDj0KTpK/8lZfo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OimyMtVpmD/WULP+kZtECFlt5f1GjSveOenalJO81G7IjlSObzygxBv65fzitcaeAxGGjqcyVX1JGPxYoltOoaxCJpAtQct+TGwHXQpI6UZ82d5h9XtIVAymnI6KwaZR3wV5bNmLV5i4L8GIpq3Fu1e5TsB5me9JIE+mQ8a8or8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-78406c22dc7so206054585a.0
        for <bpf@vger.kernel.org>; Mon, 12 Feb 2024 08:53:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707756786; x=1708361586;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tKlNJFBlbv/SqInEJ9PA3lYX3aqm7Zmsue3DpSilFUs=;
        b=k3m7x5qCiMFZUVmIGZcjzBV/K3sVllBN0CkAEOrx1tcRu0vwpXthkM4QGy5mg2CrAk
         vOTK5ns92yVcXwDY8DsJpWCHoTvslnyhPTbXZO2GLuApZok9ZmYdKv1HT+CupqOxr3nH
         uYW3kzdqoEeHj/noomvA6I7t+XNlm88wtqNYSt9dyL2ppivgpjaVebbH1tyJhs0zN6Cw
         CRLvcz585jGjhbncE3xHwluaSIchpMtnu5vQPUTIrSSxP0rngsj4sssTZ4Jaf/aEnTAE
         EGjFqG+A3VZkqCEhrVVvWwdM108qZAUSKP4NueTkXPnNXTQP1JdiYsVi1wrvM1QEG1FP
         1RdQ==
X-Gm-Message-State: AOJu0Yx/a6d1aFl9mogjE3hENZ2tOXBi/B0qNZyaw2lV6fzc42PBP0h4
	xxY6xdUhNXoCEElbxHiu7NtJDg1HEzRWbXcnCJpsvlr2GbFdCLfr
X-Google-Smtp-Source: AGHT+IGBHsVKubyYM741ciDKVLbEJa3yjdtGfq/0IQ6c3X/AEo4FwnOn6BBpOyInmrATlwstesmK9g==
X-Received: by 2002:a05:620a:1599:b0:784:37fe:820d with SMTP id d25-20020a05620a159900b0078437fe820dmr7321268qkk.59.1707756786620;
        Mon, 12 Feb 2024 08:53:06 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUZ0Y8YweAtbC8gL1MKS6DNcNst7Q/YzD2LnifuwiTRb29Gfnv0k68EiletmsNp6ALl9X4V/U5wxyEIXPsObKnnK3ldMus8J83EOQRJl/t1s8Xf8qo=
Received: from maniforge.lan (c-24-1-27-177.hsd1.il.comcast.net. [24.1.27.177])
        by smtp.gmail.com with ESMTPSA id qs19-20020a05620a395300b00785c0c857acsm2185977qkn.49.2024.02.12.08.53.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 08:53:06 -0800 (PST)
Date: Mon, 12 Feb 2024 10:53:04 -0600
From: David Vernet <void@manifault.com>
To: Hari Bathini <hbathini@linux.ibm.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [PATCH] bpf: fix warning for bpf_cpumask in verifier
Message-ID: <20240212165304.GA2200361@maniforge.lan>
References: <20240208100115.602172-1-hbathini@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="umMO/ieJxn2aR9MP"
Content-Disposition: inline
In-Reply-To: <20240208100115.602172-1-hbathini@linux.ibm.com>
User-Agent: Mutt/2.2.12 (2023-09-09)


--umMO/ieJxn2aR9MP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 08, 2024 at 03:31:15PM +0530, Hari Bathini wrote:
> Compiling with CONFIG_BPF_SYSCALL & !CONFIG_BPF_JIT throws the below
> warning:
>=20
>   "WARN: resolve_btfids: unresolved symbol bpf_cpumask"
>=20
> Fix it by adding the appropriate #ifdef.

Thanks for the fix!

> Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>

Acked-by: David Vernet <void@manifault.com>

--umMO/ieJxn2aR9MP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZcpM7wAKCRBZ5LhpZcTz
ZMwCAQDQR3qZRrS7EIImjUP0JKXW9vKo7sqdUhyP8Nc3fZHu8wD/Sg7Qf7evgZ1e
a5N1NG1YWUsZNnXdRAWvcDpWmi94Pgg=
=YoRs
-----END PGP SIGNATURE-----

--umMO/ieJxn2aR9MP--

