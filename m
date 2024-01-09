Return-Path: <bpf+bounces-19262-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E0ED8289BC
	for <lists+bpf@lfdr.de>; Tue,  9 Jan 2024 17:11:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 907FC1C2280D
	for <lists+bpf@lfdr.de>; Tue,  9 Jan 2024 16:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 794243A1A0;
	Tue,  9 Jan 2024 16:10:56 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E00374C5
	for <bpf@vger.kernel.org>; Tue,  9 Jan 2024 16:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-427c4bf6017so25059111cf.0
        for <bpf@vger.kernel.org>; Tue, 09 Jan 2024 08:10:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704816653; x=1705421453;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OjHBEaHdSWTXb4kkRiKmuiZT+NrTmZbIpDxetZWh61Q=;
        b=TarB4hQCDhezduTAYiCDKDOheNeI+kowp6QoZc0VNs/vjSPx38KughUIodZBr9fvkd
         Hl3dhxFP18hX11opz3yCnGzPGQeOCWCwUEf58P85BPHNU9LUZvNbUZJGvn7IikHplWWO
         DIixVWjbI+oaUzvB6k1PzwYrzn+p9ZI/0m6MZajVhY8lpAfx/SIIHwIBRxcgaySDuAfo
         gUvt90lK4WZFZFuPG70/2Kf5tbZZYE4H0I0XE7lzSKstC6h2wxFV5f0Oo6Iz4XQD/sLh
         yC7JDVy64p7QWKZ1009o3iXZzAhMJ7NhfRa4kr2ltEusd9xFFcd0Ci7nObXju9uSSOgx
         kUnQ==
X-Gm-Message-State: AOJu0YyXs32XFwcBo0DHS5h5BhxfSuBrcOIf+xUPzy2IZ/pvUTPZiUk1
	uuMF4bEF4tl2fJb9loJFSuw=
X-Google-Smtp-Source: AGHT+IGBqw1cmDw2DclhEzdS/UFv8UIi6ctTp3CrKjlzcyvgrEiB//yI4t6hxIL8RvF8CvT3nJ61Lw==
X-Received: by 2002:ac8:588a:0:b0:425:8a27:4bef with SMTP id t10-20020ac8588a000000b004258a274befmr8169503qta.34.1704816653533;
        Tue, 09 Jan 2024 08:10:53 -0800 (PST)
Received: from maniforge (c-24-1-27-177.hsd1.il.comcast.net. [24.1.27.177])
        by smtp.gmail.com with ESMTPSA id ch6-20020a05622a40c600b004299d5ee4f9sm984072qtb.13.2024.01.09.08.10.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 08:10:53 -0800 (PST)
Date: Tue, 9 Jan 2024 10:10:49 -0600
From: David Vernet <void@manifault.com>
To: Dave Thaler <dthaler1968=40googlemail.com@dmarc.ietf.org>
Cc: bpf@vger.kernel.org, bpf@ietf.org, Dave Thaler <dthaler1968@gmail.com>
Subject: Re: [Bpf] [PATCH bpf-next] Introduce concept of conformance groups
Message-ID: <20240109161049.GA79024@maniforge>
References: <20240108214231.5280-1-dthaler1968@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="y9U2/K0VhlYetP/p"
Content-Disposition: inline
In-Reply-To: <20240108214231.5280-1-dthaler1968@gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)


--y9U2/K0VhlYetP/p
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 08, 2024 at 01:42:31PM -0800, Dave Thaler wrote:
> The discussion of what the actual conformance groups should be
> is still in progress, so this is just part 1 which only uses
> "legacy" for deprecated instructions and "basic" for everything
> else.  Subsequent patches will add more groups as discussion
> continues.
>=20
> Signed-off-by: Dave Thaler <dthaler1968@gmail.com>

Acked-by: David Vernet <void@manifault.com>

--y9U2/K0VhlYetP/p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZZ1wCQAKCRBZ5LhpZcTz
ZNvkAP4k0oNAU9M55irsV/VVDiH+6Jk3IUpHNEA3MvR/N7yy4QD/XGn/Ezb0dxXK
OhwWh6U96BYhqEKNoC54oUxYATkVhAA=
=TSRE
-----END PGP SIGNATURE-----

--y9U2/K0VhlYetP/p--

