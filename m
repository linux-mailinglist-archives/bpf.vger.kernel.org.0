Return-Path: <bpf+bounces-21175-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 972618490BB
	for <lists+bpf@lfdr.de>; Sun,  4 Feb 2024 22:36:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF71BB221EB
	for <lists+bpf@lfdr.de>; Sun,  4 Feb 2024 21:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD30B28E3F;
	Sun,  4 Feb 2024 21:36:48 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160FD2C68A
	for <bpf@vger.kernel.org>; Sun,  4 Feb 2024 21:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707082608; cv=none; b=JErt+zARjDS/Lb35wrjOHcD/7YrQM18AHfCkbw3ge8L9vvw2cAgy4joXZ+SUqqfaNyNaK4AR3BhMQ42HjL2EfFA8qDkStR/DKGqMQhkLJ0ifZ2ZvJr0+TWolBF9TRrL8e5ZH1CgnCUz5685RtI8cb4gZPHMNqXGDzOxyVh60mSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707082608; c=relaxed/simple;
	bh=zPS/82xWXPG8gi2Gze5queBzLxJN/p6s/znuDnngU2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LBkSdJ7VJvf0C9t0fiHXvwqMnuwY0qKgs918x8JIS3qwWlSFOCRTURm4YWTHIFCeTKpFWcA0Ws6DQKyXyAG9U6ykeDimDLlFtVvUny0pmY0R6CypqfpzphEsg4bhqt0TBZWc2v6igP+oVXdx/Q/KKwi6xAS1q8PQosBlX3rBMUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-783da8920e5so247674585a.1
        for <bpf@vger.kernel.org>; Sun, 04 Feb 2024 13:36:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707082606; x=1707687406;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zPS/82xWXPG8gi2Gze5queBzLxJN/p6s/znuDnngU2Q=;
        b=r18uCwjGhpUI3ClmHn/aQ/0KAnewGFXQkaweLdN3S+58/7N+lWRfBgfwmpKz0HquYu
         gT9rzKYzjIgitYHZAurqQtUdDZcVNu1I/tVoPBsj2ek+0BSzbq0zYMJ5OOxfkxi55U7w
         THVFGxz6yGAy6PqtKU4G7A7XREwLvfzfcMRwuq94hBoPKMJkm3HOKCxTXmiu8yKDXHK8
         sJVITqyuQcyC4ZflzNgoM7ugsjMqRjwJ+QWu18xR1fusLzEH5suzjVeBKbIuMwx8ORXd
         OsOt9FHtzQ2thHhdP92GJJx6Z3oGlBBsObAKBkY5ZMWTKr+kciDdfAULdyUTGBfnH1tj
         eT8w==
X-Gm-Message-State: AOJu0Yzpx6jqBapZpVmzd/n6d2FJZW8Ahlb0XeoaEyq0qRJlxcsS1n6+
	dH4HfQlljO4z4I8CqA4/E9UBI3Qxu0+jh5p+cBKXLUerg7xq5a9w
X-Google-Smtp-Source: AGHT+IFzP+CxRKmDDUgQnTgVPOqLufZOGacieDkj/y3PUUDBKJoJ0fhQHUR/lD9cZuM2EsZlxVNb6A==
X-Received: by 2002:a05:620a:16bc:b0:784:b12:ba1c with SMTP id s28-20020a05620a16bc00b007840b12ba1cmr8272061qkj.78.1707082605904;
        Sun, 04 Feb 2024 13:36:45 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCX54toGHPWUPJUdfl/FPOF/lgx4fCTtsofbOnmVFomtLjxI8Ydn4I5xQhzNkT9prXyqbiVmnlvTseZv8uCBky9eetatrEXPxeAz4dBWSML+vqmoqMXce3Qmne2dFdtujG5P5uJEj/HXIfPkKZr/Ht4EeHanb8bWuaAs/bFaa2m9SaYhvAssWr+lDRrMpTNNPP9MYYYQBlaZH99AMg9xsQ==
Received: from maniforge (c-24-1-27-177.hsd1.il.comcast.net. [24.1.27.177])
        by smtp.gmail.com with ESMTPSA id i17-20020a05620a145100b00783268da8f0sm2452193qkl.40.2024.02.04.13.36.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Feb 2024 13:36:45 -0800 (PST)
Date: Sun, 4 Feb 2024 15:36:42 -0600
From: David Vernet <void@manifault.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Barret Rhoden <brho@google.com>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH bpf-next v1 2/2] selftests/bpf: Add test for static
 subprog call in lock cs
Message-ID: <20240204213642.GC120243@maniforge>
References: <20240204120206.796412-1-memxor@gmail.com>
 <20240204120206.796412-3-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ooEBAw3+deDDYTjZ"
Content-Disposition: inline
In-Reply-To: <20240204120206.796412-3-memxor@gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)


--ooEBAw3+deDDYTjZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 04, 2024 at 12:02:06PM +0000, Kumar Kartikeya Dwivedi wrote:
> Add selftests for static subprog calls within bpf_spin_lock critical
> section, and ensure we still reject global subprog calls. Also test the
> case where a subprog call will unlock the caller's held lock, or the
> caller will unlock a lock taken by a subprog call, ensuring correct
> transfer of lock state across frames on exit.
>=20
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

Same nit as Yonghong again to just slightly improve the error message in
the verifier. Otherwise LGTM, thanks.

Acked-by: David Vernet <void@manifault.com>

--ooEBAw3+deDDYTjZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZcADagAKCRBZ5LhpZcTz
ZLH9AQCOVl1CkjhLlNBL4T26l6rXJPQXByR73mJtJefGH5nhFgEA2OJN2OigtQmf
l/seI6r+WplOli/cSFaHvgPK/y2ItgM=
=W/yS
-----END PGP SIGNATURE-----

--ooEBAw3+deDDYTjZ--

