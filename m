Return-Path: <bpf+bounces-27330-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84DA68AC02B
	for <lists+bpf@lfdr.de>; Sun, 21 Apr 2024 18:51:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD7EC2815F4
	for <lists+bpf@lfdr.de>; Sun, 21 Apr 2024 16:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17CF81BF2F;
	Sun, 21 Apr 2024 16:51:42 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 435C6199A1
	for <bpf@vger.kernel.org>; Sun, 21 Apr 2024 16:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713718301; cv=none; b=Fp7okzFvo2rFlw9DvR2SVDggPG5t6bf7Oz19PemHsoV+ieE0PLD9Umr9clIYPX7uGQbtn34UhfNZjo4wPlsPFUBKsCl2XX5uTHvRXyMzCd/kJzdPbnlaP5hNaeDA7qD4PX96R2LqnOjL4vmjBdXnpexHYK/uojdlCyATwDMJGg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713718301; c=relaxed/simple;
	bh=g/I1arjbT3CLbCljm5lrKj9NAs5UeT3pqG8g+I0VcFA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pjiemYJPx+zyj7LqPGVP3lJBneAGR50pPWAwB7aUgmpJmf6bI2wlUsZoF1KFTOkz7kzGWYwdZvTyRhi/8dD/nbMLlrI1lgkvLDczSnd4WNaGQJcE/Jn8YL/ziidNxpcWb7wcTwIhd2clZSP3aD9Z14vzojMVjVvE7aTEh/KNXK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-61b6200fcb5so2837147b3.2
        for <bpf@vger.kernel.org>; Sun, 21 Apr 2024 09:51:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713718299; x=1714323099;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T9lqeLBu6LX+yy0/r6cQpd22J0xctj4Y1RYJ9rxYpDU=;
        b=FXY4jT3WR7E8F5rvqJU8MBBy/yx6P8MSA6Sose+LzWuTvdxKlrjx6vO7p+cM+jSXUu
         mi0epGp77FE/99V1ONbYyvFpCR3A+XHbkJ725OjYo3RsxP7cazBgSpzeI9xA8NXm9aYo
         Mr4hE/5gdjF582Siw8qSyA0tIu4XRD0gH+KyPMZGjaDXBmjEh80Y/EXLcBXosBv98AIA
         Ahk2Kr5tuLo+lV4W25QBNpth9MJDfc9j3EazeWXVfz+Pagr6EVOmr5Fk2StTvORA1k0i
         N551UNWsjim1zlziHCkDy4Zo85/AmNqaxNeka+fPiYGZ8zlae+4cl7nW+icNmephhxAc
         2LHg==
X-Forwarded-Encrypted: i=1; AJvYcCWWlaWjsQ1uft5MgtyhApFM/Xso2B/XchGLjFWcTYXY+BRd71kv/cEqZoleSGOzzpdZYIG8Tzl2XhFJk0N6Cd1SHjYe
X-Gm-Message-State: AOJu0Yz/B9iJ5xBmc/df0Lk6pVdsnD/i4iSRaDuB+nJiCHmSnmuOgNfp
	/hG8i5CbHDukKYylzfUJyRqd3URopeCsJuysddWoPX+AcC14zSy7
X-Google-Smtp-Source: AGHT+IEi1LhlBS3gAx+IhPx4Kk2Fsb3UsxSEfKj3v6sIm47Rbpjxtzhi+tu4dIIbS7XGqW0xF+TZzg==
X-Received: by 2002:a05:690c:3386:b0:615:bb7:d59c with SMTP id fl6-20020a05690c338600b006150bb7d59cmr11727249ywb.22.1713718297593;
        Sun, 21 Apr 2024 09:51:37 -0700 (PDT)
Received: from maniforge (c-76-136-75-40.hsd1.il.comcast.net. [76.136.75.40])
        by smtp.gmail.com with ESMTPSA id bx7-20020a05690c080700b006185b34ab9dsm1611540ywb.125.2024.04.21.09.51.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Apr 2024 09:51:37 -0700 (PDT)
Date: Sun, 21 Apr 2024 11:51:34 -0500
From: David Vernet <void@manifault.com>
To: dthaler1968@googlemail.com
Cc: bpf@ietf.org, bpf@vger.kernel.org
Subject: Re: BPF ISA Security Considerations section
Message-ID: <20240421165134.GA9215@maniforge>
References: <093301da933d$0d478510$27d68f30$@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8RgQ+LtZBrdRcnfK"
Content-Disposition: inline
In-Reply-To: <093301da933d$0d478510$27d68f30$@gmail.com>
User-Agent: Mutt/2.2.13 (00d56288) (2024-03-09)


--8RgQ+LtZBrdRcnfK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 20, 2024 at 09:08:56AM -0700, dthaler1968@googlemail.com wrote:
> Per
> https://authors.ietf.org/en/required-content#security-considerations,
> the BPF ISA draft is required to have a Security Considerations
> section before it can become an RFC.
>=20
> Below is strawman text that tries to strike a balance between
> discussing security issues and solutions vs keeping details out of
> scope that belong in other documents like the "verifier expectations
> and building blocks for allowing safe execution of untrusted BPF
> programs" document that is a separate item on the IETF WG charter.
>=20
> Proposed text:

Hi Dave,

Thanks for writing this up. Overall it looks great, just had one comment
below.

> > Security Considerations
> >
> > BPF programs could use BPF instructions to do malicious things with
> > memory, CPU, networking, or other system resources. This is not
> > fundamentally different  from any other type of software that may run o=
n a device. Execution
> > environments should be carefully designed to only run BPF programs
> > that are trusted or verified, and sandboxing and privilege level
> > separation are key strategies for limiting security and abuse
> > impact. For example, BPF verifiers are well-known and widely
> > deployed and are responsible for ensuring that BPF programs will
> > terminate within a reasonable time, only interact with memory in
> > safe ways, and adhere to platform-specified API contracts. The
> > details are out of scope of this document (but see [LINUX] and
> > [PREVAIL]), but this level of verification can often provide a
> > stronger level of security assurance than for other software and
> > operating system code.
> >
> > Executing programs using the BPF instruction set also requires
> > either an interpreter or a JIT compiler to translate them to
> > hardware processor native instructions. In general, interpreters are
> > considered a source of insecurity (e.g., gadgets susceptible to
> > side-channel attacks due to speculative execution) and are not
> > recommended.

Do we need to say that it's not recommended to use JIT engines? Given
that this is explaining how BPF programs are executed, to me it reads a
bit as saying, "It's not recommended to use BPF." Is it not sufficient
to just explain the risks?

Thanks,
David

--8RgQ+LtZBrdRcnfK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZiVEFgAKCRBZ5LhpZcTz
ZJiOAQCJjS2nHo1vKFz9W/2hwvAyzdsoGJq6emMCW5iLnGMzdQD/bgNd6ThIKv31
V9KCfu5JvQU0qltJgifhXBmvzPeeego=
=2EEt
-----END PGP SIGNATURE-----

--8RgQ+LtZBrdRcnfK--

