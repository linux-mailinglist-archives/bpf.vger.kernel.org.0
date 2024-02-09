Return-Path: <bpf+bounces-21634-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB7CB84F94D
	for <lists+bpf@lfdr.de>; Fri,  9 Feb 2024 17:07:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A1B51C2532A
	for <lists+bpf@lfdr.de>; Fri,  9 Feb 2024 16:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 411197B3FC;
	Fri,  9 Feb 2024 16:06:50 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78985768F8
	for <bpf@vger.kernel.org>; Fri,  9 Feb 2024 16:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707494810; cv=none; b=hxLcjNyh56oGXGNE1z3ehyPpx2U+A7YSJcpGD+i7/oZZf+UHf00dD56o9+tN8Rr2gXaurhuUAoF5+EmBlMAY+0IaR1nnz8oFTvXOp2yuC1jyQV+XyYLrZYowbURfopX0Qhys4vxpoyPttFeoXG8dH1JypUZ1OeOvrrl7hjbJaOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707494810; c=relaxed/simple;
	bh=Q1rePlirM1GTpypDojMAgz+J9Qv6kDJuBgc8qPPX7pE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gcUpdEKaOQYPIbBaooN7n4/kBNmRVM9up112jT1hSYJBm1xf4PPXx1atF++57tCmL9I8A9zx+oEL2/pUP/CBqvEYPj2zyZi5V4XJzFRbUgOHw+gNB3po4rfPI6L9bqJzbFFRRvxO9TpacFme4FuL0TIiuXlhZ56FYPri5nrmBgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-68873473ce6so5384686d6.0
        for <bpf@vger.kernel.org>; Fri, 09 Feb 2024 08:06:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707494807; x=1708099607;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q1rePlirM1GTpypDojMAgz+J9Qv6kDJuBgc8qPPX7pE=;
        b=oFaw1jhke4LiUuQE1OnF6UWf3/4UhNYbNukFa0jNw6yKX5gcWbhvjWX4wgXkoDnWv4
         6SaTOzH1zMJPXRRriprcTORp3+Tz0hzJkxYR6MhWqwuLb45f5G6Jyrf6XEhPjm5VhxK2
         bj1QLVs4EvWKOOXzbqVzNEM+peXU3rqKyyEaE8jvjfG95hJQfOXjmtqg5JVBuPcws7Dh
         huxK7NGMpAtZZPnP161Y11LmaD4JLx+tLA8aTvv4Mr8nm56UpS0iGjjlw7R9zjdpj1l9
         ScpRG3Q9Rb5cV0W34K0jbzweUNwCra8ctFwJJepEnXqSz03Agromk5NxqZEa4X6HszZI
         xAqA==
X-Gm-Message-State: AOJu0YxG+wpOxeB9ZUfjuKn5RnxvseoxPVazC3nSzWxREdzFcGK0hQke
	JOdYkpRMBKudXM1jzLPxJGLZenp16CU/s+TuYC+T7ZKwkupcSYH0
X-Google-Smtp-Source: AGHT+IGvfMKzShVAoGa7pB4DWTnX04g/D9FeD2HAF19ScWIBImSI7OoumXl7uilIXtWZlMZZlZSFhg==
X-Received: by 2002:a0c:e382:0:b0:68c:9109:b5e2 with SMTP id a2-20020a0ce382000000b0068c9109b5e2mr1685240qvl.30.1707494807192;
        Fri, 09 Feb 2024 08:06:47 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWsxR3c30PG3bFYkTvHzgC2k9Sx6F017T1G3A5nQNtQJOnXywn/Mh5jQbWMlatyZDUz+Q5klnPMBtmktUxwlfK4EZJ86chNaUiztx2ao0vJa+DueihdXEV4WdF5WagVEpHSXE4geq+0OnHJJKoIqmZvxtRIq97tThXLvWrTtLVCk/5SMPZH3+8sswrHkesfe7zdJ2UCGykbQpJZjiGr/S1wvBNktM/ae+61x73xY6Jf5hg45ZnXNs0w6ItRTcpMauMa7bFNrzNzK6fETD6LtUbNGqPcONhpfpBYrkUffon+rHkO3EuxOzrhe5sfRe48CA==
Received: from maniforge.lan (c-24-1-27-177.hsd1.il.comcast.net. [24.1.27.177])
        by smtp.gmail.com with ESMTPSA id qp5-20020a056214598500b0068cac993878sm941877qvb.115.2024.02.09.08.06.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 08:06:46 -0800 (PST)
Date: Fri, 9 Feb 2024 10:06:43 -0600
From: David Vernet <void@manifault.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	martin.lau@kernel.org, memxor@gmail.com, eddyz87@gmail.com,
	tj@kernel.org, brho@google.com, hannes@cmpxchg.org,
	linux-mm@kvack.org, kernel-team@fb.com
Subject: Re: [PATCH bpf-next 01/16] bpf: Allow kfuncs return 'void *'
Message-ID: <20240209160643.GA975217@maniforge.lan>
References: <20240206220441.38311-1-alexei.starovoitov@gmail.com>
 <20240206220441.38311-2-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="e8HMK8mEfo6j+O3H"
Content-Disposition: inline
In-Reply-To: <20240206220441.38311-2-alexei.starovoitov@gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)


--e8HMK8mEfo6j+O3H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 06, 2024 at 02:04:26PM -0800, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
>=20
> Recognize return of 'void *' from kfunc as returning unknown scalar.
>=20
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>

Acked-by: David Vernet <void@manifault.com>

--e8HMK8mEfo6j+O3H
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZcZNkwAKCRBZ5LhpZcTz
ZN7ZAQCNqR9PwN8kZw7l7MA/OPxA0VAuoyLZwhVSjhYoM69CFQD/V47UJqwVvo2R
euVjAUL19njxWiPjdgvEQ2s1dXwnDgc=
=oji0
-----END PGP SIGNATURE-----

--e8HMK8mEfo6j+O3H--

