Return-Path: <bpf+bounces-21281-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2B5384AE69
	for <lists+bpf@lfdr.de>; Tue,  6 Feb 2024 07:33:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E222286E09
	for <lists+bpf@lfdr.de>; Tue,  6 Feb 2024 06:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 135FF127B73;
	Tue,  6 Feb 2024 06:33:18 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09037127B54
	for <bpf@vger.kernel.org>; Tue,  6 Feb 2024 06:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707201197; cv=none; b=r1tY7lmI5kQ0QpKtqEqdZej7OFlmnehjEL1oDIne24sXmKJPHJ59U6nYbHMa17rB4lnwsKrcChQBvan7xvQObYyxvU65Bp55+1J8Lhj3hpnawcePZXbfDfXEZSzExWKreH0pKgA4hTxKarB5gGsJbMj7tZGlR6dLhtBIQsLTjYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707201197; c=relaxed/simple;
	bh=4ET0fyLHVJEsDuQ9gH+PgSGGLVCtzDZ/Qwsv8HecTvM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eDz67yPSvyPrWF/wVD2gNol/PszdHU22hRGe6159yl6Q/LIQNyc/KTBVfs75tCUU+qWe2SWAL2FbVMhyhiKrRACAXvvSyfrQ5uJWEUfJJDiUswA0nrGFlb9aR8/IXx7V4k2IPPcYM9rTHgpKljvHgACZ6aLSnLkM4EpmdFnPlro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-42aa241b91aso45394481cf.1
        for <bpf@vger.kernel.org>; Mon, 05 Feb 2024 22:33:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707201195; x=1707805995;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4ET0fyLHVJEsDuQ9gH+PgSGGLVCtzDZ/Qwsv8HecTvM=;
        b=bptsW5juoVSzRfjtqVgbmYLhd2015nFliSH8Q0XcFVS4/HZA/yb2lUEh1Otgb95kmj
         TXU0glHyOv7LDgC5lAB6gYKNrxKVshyAkLoLUFPi3wx/SfdAfCN8oXkkDI66pNK0VYOd
         fvsftmcKJ0Jw2+eea8idEJBLjgKtkgE433ngw4O0W/3S7PYaHF1KjyUgVf9erqrrUvwE
         Y21Q4V2zvth+hmuZDO8oSdyCDsbSqCaA6K5h2hYvWvxYLX8olDrmP7hKocFJ1Q9XhOmF
         rUN5vb+UDMz83ZKjrzuyLjHIN1SGRIQ+6xcpPi7ahEQ8rfNkc8VdgeND8TkYnDm+aunN
         Hnxg==
X-Gm-Message-State: AOJu0YxdzWHGYXvRPxKmoInfLhz+wOgshvBjUZRN6BgGoNvUjQyu3/1G
	XUHogygYCQXtNw0hGmumTXgun3ftuQwiaqF1aig3usx8VFyAVhj82FY6suZ/hPOnTQ==
X-Google-Smtp-Source: AGHT+IHIRpR2kv+KQ945cd5bHIRJBmHF8XN8dyszKd/8chzZkMG0Hj6hmihDCixwYond2AIV0Y6orQ==
X-Received: by 2002:a05:6214:29e7:b0:68c:67aa:c071 with SMTP id jv7-20020a05621429e700b0068c67aac071mr1707656qvb.18.1707201194807;
        Mon, 05 Feb 2024 22:33:14 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWPTUZ4n807PuML7vdqZPlmkUpyLyTSfKywlu6unlF/na/5RORbbXuuGOMZIo+GxzZlypnAlYydOX1JQSMNqSdMhW/kynkb0asocW0Ex24CfwjCVQ==
Received: from maniforge.lan (c-24-1-27-177.hsd1.il.comcast.net. [24.1.27.177])
        by smtp.gmail.com with ESMTPSA id k17-20020a0cf591000000b0068cabcec402sm752286qvm.134.2024.02.05.22.33.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 22:33:14 -0800 (PST)
Date: Tue, 6 Feb 2024 00:33:12 -0600
From: David Vernet <void@manifault.com>
To: Dave Thaler <dthaler1968=40googlemail.com@dmarc.ietf.org>
Cc: bpf@vger.kernel.org, bpf@ietf.org, Dave Thaler <dthaler1968@gmail.com>
Subject: Re: [Bpf] [PATCH bpf-next] bpf, docs: Fix typos in
 instructions-set.rst
Message-ID: <20240206063312.GA853677@maniforge.lan>
References: <20240206045146.4965-1-dthaler1968@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="c5d2i3HwTslNSlo6"
Content-Disposition: inline
In-Reply-To: <20240206045146.4965-1-dthaler1968@gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)


--c5d2i3HwTslNSlo6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 05, 2024 at 08:51:46PM -0800, Dave Thaler wrote:
> * "imm32" should just be "imm"
> * Add blank line to fix formatting error reported by Stephen Rothwell [0]
>=20
> [0]: https://lore.kernel.org/bpf/20240206153301.4ead0bad@canb.auug.org.au=
/T/#u
>=20
> Signed-off-by: Dave Thaler <dthaler1968@gmail.com>

Acked-by: David Vernet <void@manifault.com>

--c5d2i3HwTslNSlo6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZcHSpwAKCRBZ5LhpZcTz
ZHxeAP455nv23Xpw/MAANLnxpIjuwgPetqhgZ6AIxG+k43yZYQD+IPt+WEGEK+Bj
vgOFFNAgPBu0bC6jODdq1ytVizlX+Q4=
=FRCI
-----END PGP SIGNATURE-----

--c5d2i3HwTslNSlo6--

