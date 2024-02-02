Return-Path: <bpf+bounces-21106-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C82F9847C85
	for <lists+bpf@lfdr.de>; Fri,  2 Feb 2024 23:47:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8282E282721
	for <lists+bpf@lfdr.de>; Fri,  2 Feb 2024 22:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D04F3126F1F;
	Fri,  2 Feb 2024 22:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="XND1OWS7";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="hyBl3OVN"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E5D5FF01
	for <bpf@vger.kernel.org>; Fri,  2 Feb 2024 22:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.223.129.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706914036; cv=none; b=ZAp3QTdlO0m3KE0E44GZawFfKAYJuVcPnYGbm38YZq2VjBOnVBgWty3BmXg4PfyXKQggwxJM7WHK7iDwc6NmsNeWRDQM9IK/v74eKM6b859jvsiniYXlWPxk+9TwAHBBu0UNLGtmUkxSfLD/Tn/B2OY9MZLsVnSpgSXLbRVymp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706914036; c=relaxed/simple;
	bh=FYNTIWrdPWG6eyM+GRSLwf8xzJin5fv7v4cAo/arIiE=;
	h=Date:From:To:Cc:Message-ID:References:MIME-Version:In-Reply-To:
	 Subject:Content-Type; b=rWHeKLfezvefsGDafdBjK8Tpxaa0z0AH7vfjVKOaivgTtbK1HIMDIIkVEbmTvKgudE6rSNXH3Fv/0t2i598ObG5Ov0GHRmNLuxN+uViYQRCVNqNNkR6iTrXUijYkLOiA4zmu7tyzsaZQNEhklmE7bIikt+osP+4GONF2eIxxc+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=ietf.org; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=XND1OWS7; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=hyBl3OVN; arc=none smtp.client-ip=50.223.129.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 0329BC14CE30
	for <bpf@vger.kernel.org>; Fri,  2 Feb 2024 14:47:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1706914034; bh=FYNTIWrdPWG6eyM+GRSLwf8xzJin5fv7v4cAo/arIiE=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=XND1OWS74PxCa1OkfrPf2K9XAkcExmWOqgo0F1VTqJz6obYcueTUvQ7SkOgv8w1yw
	 nfnqTCYY3EsU4mkcwG+ctA1S6WL+12pGkq0Dz6kU41hyoOy4DNLAvlMShy8J8HTA7l
	 FciYbrKiAkt85sMg5Cx+d7Ls8hYYtAhZQZWFGGAU=
X-Mailbox-Line: From bpf-bounces@ietf.org  Fri Feb  2 14:47:13 2024
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 9D0B7C14F6B4;
	Fri,  2 Feb 2024 14:47:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1706914033; bh=FYNTIWrdPWG6eyM+GRSLwf8xzJin5fv7v4cAo/arIiE=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=hyBl3OVNM2OpR2Fmzpqfq379lzPhDfb5h7KF69HapktJivpTkg5J6Emd5FKAZb7Pj
	 EJxOIE8qb9odN/SjIRdsnMI9Jh0B4yh4ZJ158jZj+xXsXS1acshDzBsgsrG0tLMhkT
	 DiwzpV5fePo4hUV1MzyZs8zAAtjxvl6bGZ4bYfFo=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id B86AAC14F6B4
 for <bpf@ietfa.amsl.com>; Fri,  2 Feb 2024 14:47:12 -0800 (PST)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -1.41
X-Spam-Level: 
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ww8g11SDFmu5 for <bpf@ietfa.amsl.com>;
 Fri,  2 Feb 2024 14:47:10 -0800 (PST)
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com
 [209.85.219.46])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id A6ADFC14F68A
 for <bpf@ietf.org>; Fri,  2 Feb 2024 14:47:10 -0800 (PST)
Received: by mail-qv1-f46.google.com with SMTP id
 6a1803df08f44-68c8d3c445fso2040196d6.1
 for <bpf@ietf.org>; Fri, 02 Feb 2024 14:47:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706914029; x=1707518829;
 h=user-agent:in-reply-to:content-disposition:mime-version:references
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hrIqKBXYRJ2iii7fOSRikAKu8sNmRspAkC6/qmp0zQo=;
 b=qDrkWXfohOLZoEBPWCSBVESDIOJ4kpfPPLeLVLr002Ui+GDMELoPYVdjKjLb4EWNwK
 5jOhA2cRM04eUrVi7EmiOzX7f6xAwSlX+ASaUw4pS5A1tPXpdSqjvDp0+DxBz7x4D2TP
 yjFEsv5HBXM/Xr0L3vpv2ISguEJWBZpYHyxo1SI+l3iqN0c5kMKfPsh10GIecMZx42Ie
 K/WjzfzJ7f9dwHs5C8mrnBX0THMb75BN60OODo/IYvDxVC+NzS20quMwYTrz8k3sxlsO
 KfaUkSLT0Zl3R99CgZnQWcFknum7izx2yibZhXCTdwlo9bVJZSXRD8pzx7HV6LvLQ6CU
 gI0Q==
X-Gm-Message-State: AOJu0YwiOOReHj5AkdgVKp/4UCxTgI7HNR4FhFJD6ef3JCc4GvWsh3zX
 vS/Ij2FSVrxDyviTzHLt7K+15qg7748rJsZ6tpO1lN0OC8ckXNkD
X-Google-Smtp-Source: AGHT+IHjF4zDjT4o+jA3HvGBg1KWYLjcY0RjXcXALz0lW7xnTbCnauUA66XiSY1P6VZaZr/818TrMg==
X-Received: by 2002:a0c:e3c9:0:b0:68c:61fc:680a with SMTP id
 e9-20020a0ce3c9000000b0068c61fc680amr3293035qvl.25.1706914029609; 
 Fri, 02 Feb 2024 14:47:09 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCV6d6du1kh3wM4g1hCsPSg/Os6OcZa7Kk0BXGPAfe6SZczQ9g8Lxd3rlXLMDnqihMuXHZTLxGn+TAmyF2RbQYlkqFtZzIB15A3kON9++3VPvn998Q==
Received: from maniforge (c-24-1-27-177.hsd1.il.comcast.net. [24.1.27.177])
 by smtp.gmail.com with ESMTPSA id
 od17-20020a0562142f1100b0068c89d8eb53sm674898qvb.81.2024.02.02.14.47.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Feb 2024 14:47:09 -0800 (PST)
Date: Fri, 2 Feb 2024 16:47:06 -0600
From: David Vernet <void@manifault.com>
To: Dave Thaler <dthaler1968=40googlemail.com@dmarc.ietf.org>
Cc: bpf@vger.kernel.org, bpf@ietf.org, Dave Thaler <dthaler1968@gmail.com>
Message-ID: <20240202224706.GA2244152@maniforge>
References: <20240202221110.3872-1-dthaler1968@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240202221110.3872-1-dthaler1968@gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/NzwkB044XPXJEge8cwJgzo9loZ8>
Subject: Re: [Bpf] [PATCH bpf-next v3] bpf,
 docs: Expand set of initial conformance groups
X-BeenThere: bpf@ietf.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf/>
List-Post: <mailto:bpf@ietf.org>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
Content-Type: multipart/mixed; boundary="===============1322443478744215392=="
Errors-To: bpf-bounces@ietf.org
Sender: "Bpf" <bpf-bounces@ietf.org>


--===============1322443478744215392==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Ili3dk1y5KBFrdpt"
Content-Disposition: inline


--Ili3dk1y5KBFrdpt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 02, 2024 at 02:11:10PM -0800, Dave Thaler wrote:
> This patch attempts to update the ISA specification according
> to the latest mailing list discussion about conformance groups,
> in a way that is intended to be consistent with IANA registry
> processes and IETF 118 WG meeting discussion.
>=20
> It does the following:
> * Split basic into base32 and base64 for 32-bit vs 64-bit base
>   instructions
> * Split division/multiplication/modulo instructions out of base groups
> * Split atomic instructions out of base groups
>=20
> There may be additional changes as discussion continues,
> but there seems to be consensus on the principles above.
>=20
> v1->v2: fixed typo pointed out by David Vernet
>=20
> v2->v3: Moved multiplication to same groups as division/modulo
>=20
> Signed-off-by: Dave Thaler <dthaler1968@gmail.com>

Acked-by: David Vernet <void@manifault.com>

Thanks!

--Ili3dk1y5KBFrdpt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZb1w6gAKCRBZ5LhpZcTz
ZGZvAQCC3wAzgaIuCEelr2aHX1bGY6YEKeTuuy75tRwNRbMT3QEAl2VdjeACdKCY
uictak+1vbD3uH7X9TbYwBsFwJ001AM=
=lXeP
-----END PGP SIGNATURE-----

--Ili3dk1y5KBFrdpt--


--===============1322443478744215392==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

--===============1322443478744215392==--


