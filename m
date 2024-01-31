Return-Path: <bpf+bounces-20863-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1FEC8447B5
	for <lists+bpf@lfdr.de>; Wed, 31 Jan 2024 20:02:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D947284315
	for <lists+bpf@lfdr.de>; Wed, 31 Jan 2024 19:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9729B33CFD;
	Wed, 31 Jan 2024 19:02:11 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7843D3B189
	for <bpf@vger.kernel.org>; Wed, 31 Jan 2024 19:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706727731; cv=none; b=Q6FzKc44TWmtImNDEvqFmmslJcfczPB477DwE0nKtjZbGBWSWYabXtDdfrWVzs2iWnxOrxXhMe2T8QUKqsfGJLbcuXCEx4hJnYqOJFetBUf12PIi4oRjnEIqaetV6lBlDg0gtd9nBqxaCT4g3WPloCeZp+teembE8qJNf4MaDPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706727731; c=relaxed/simple;
	bh=yEdSzNCJd3EYiDxBdMrrzjWfBi9djcuzef6ZSEgmWPs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UX9ozEN3mTClD+RUQRx6FiU27VCRPvoeFaXeUMICKPRtCwCYJm4hOc/wlFN3uMRukwIykpPoaEq/rSw9RWSP6b9QXGrlZ3egZHTsEp+hB13M1kP1ZvgeI/6aMZagM4c1Otvxs/+Bk1/TBKaWs15Rnqa7ls/4W3BLnqErQ5aCQV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6869233d472so674616d6.2
        for <bpf@vger.kernel.org>; Wed, 31 Jan 2024 11:02:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706727728; x=1707332528;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A5bdkigbuy7N+F/Uijz9a8VNffb/p+LEpN18kynpP2M=;
        b=dnGs+J3RqJIb/biTqZGDZ3Pcuwyjl/oXwyZw1g2znkpK2VvmZiEG5Y94fsKDzHTSp7
         p8C2L8RtDkA708gwfJfXVePPURWfrEnh+iVXIKmyN52VYbYOiBdOiXG45hAMMgnyHeBS
         oVdueyp+6mIgoSvT7BuMT6x4UNADp1FwO/eg4e6ZKpeNMbfTL3w6BZlGyYe5QtzgesRR
         w3Oa7tHzkZhRhHyFy51RupgTEL4M42Q7xTrOxmXxXKA2eV0YGe1Imh/iC4G/IDkvvNgd
         5AdclW+1qKgQ0uJIOBeSIJBcITmVGRfL2Cc/sss0p2C8nbUBHuap6dyMKo/mJ/hxhPRZ
         s0nA==
X-Gm-Message-State: AOJu0Yy7FzBqFPFMbmJLrr8qbW2XEjsZVaRSVKpNieqa7kVlDcyFNLb5
	2vd0PppbrzgCm49/OXq+77F6WSHUG0bi1Zlq6e2zQgMN6QgaI623Tv2f6pyUCYE=
X-Google-Smtp-Source: AGHT+IEeP5S/pkX5AQxhNAbmTLSh/uhIxaH/MnJFLyUprEkLc0ypmUIIR5S3tL5ski0P/LL+e7RXEg==
X-Received: by 2002:ad4:5962:0:b0:68c:60d6:a937 with SMTP id eq2-20020ad45962000000b0068c60d6a937mr230191qvb.36.1706727728141;
        Wed, 31 Jan 2024 11:02:08 -0800 (PST)
Received: from maniforge (c-24-1-27-177.hsd1.il.comcast.net. [24.1.27.177])
        by smtp.gmail.com with ESMTPSA id pc19-20020a056214489300b0068c6e9fa24asm738125qvb.10.2024.01.31.11.02.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 11:02:07 -0800 (PST)
Date: Wed, 31 Jan 2024 13:02:05 -0600
From: David Vernet <void@manifault.com>
To: Dave Thaler <dthaler1968@googlemail.com>
Cc: bpf@vger.kernel.org, bpf@ietf.org, Dave Thaler <dthaler1968@gmail.com>
Subject: Re: [PATCH bpf-next] bpf, docs: Clarify which legacy packet
 instructions existed
Message-ID: <20240131190205.GA1051028@maniforge>
References: <20240131033759.3634-1-dthaler1968@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="RVDUcJLDIDs2OQxF"
Content-Disposition: inline
In-Reply-To: <20240131033759.3634-1-dthaler1968@gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)


--RVDUcJLDIDs2OQxF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 30, 2024 at 07:37:59PM -0800, Dave Thaler wrote:
> As discussed in mailing list discussion at
> https://mailarchive.ietf.org/arch/msg/bpf/5LnnKm093cGpOmDI9TnLQLBXyys/
> this patch updates the "Legacy BPF Packet access instructions"
> section to clarify which instructions are deprecated (vs which
> were never defined and so are not deprecated).
>=20
> Signed-off-by: Dave Thaler <dthaler1968@gmail.com>

Acked-by: David Vernet <void@manifault.com>

> ---
>  Documentation/bpf/standardization/instruction-set.rst | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/bpf/standardization/instruction-set.rst b/Docu=
mentation/bpf/standardization/instruction-set.rst
> index af43227b6..cf08337bf 100644
> --- a/Documentation/bpf/standardization/instruction-set.rst
> +++ b/Documentation/bpf/standardization/instruction-set.rst
> @@ -635,7 +635,9 @@ Legacy BPF Packet access instructions
>  -------------------------------------
> =20
>  BPF previously introduced special instructions for access to packet data=
 that were
> -carried over from classic BPF. However, these instructions are
> +carried over from classic BPF. These instructions used an instruction
> +class of BPF_LD, a size modifier of BPF_W, BPF_H, or BPF_B, and a
> +mode modifier of BPF_ABS or BPF_IND.  However, these instructions are
>  deprecated and should no longer be used.  All legacy packet access
>  instructions belong to the "legacy" conformance group instead of the "ba=
sic"
>  conformance group.
> --=20
> 2.40.1
>=20
>=20

--RVDUcJLDIDs2OQxF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZbqZLQAKCRBZ5LhpZcTz
ZP4XAP9ajU67OpR72qyWAYboNvT837yFd0QSmrVt2ts+FwehQQEAov2OkfQQ/FZ7
qi2RY81j38xzo7m3rRCE3e+Ds8KdGQY=
=874j
-----END PGP SIGNATURE-----

--RVDUcJLDIDs2OQxF--

