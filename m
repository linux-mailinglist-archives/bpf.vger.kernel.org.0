Return-Path: <bpf+bounces-22451-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D06A785E52B
	for <lists+bpf@lfdr.de>; Wed, 21 Feb 2024 19:05:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3CA36B24086
	for <lists+bpf@lfdr.de>; Wed, 21 Feb 2024 18:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F207C85269;
	Wed, 21 Feb 2024 18:04:53 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16EDA84FAD
	for <bpf@vger.kernel.org>; Wed, 21 Feb 2024 18:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708538693; cv=none; b=GAlZfik+caHx9BG2TEURCFVUc0NvKfDcOQHDq1Fb5vs548j7lMV5S9nJqxXq1UTwFwnYnyy724SjU1C7ab38TaKzvSibmoLqQKENy9vikncBiwf00Gcl6iXV989KU9Q5xbVibssG675xUL+cY1DcXsBA66XIMmELXip2+s8A2rU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708538693; c=relaxed/simple;
	bh=bsB/zWA5/uB9ODIKcIsgzTrGhUWH0cUPO7WxTLXnx8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gJPof/DPa3xxLLQ8aORERCpWm7zsrPN+vlLvf68OWKNwilUQmUc/awcPHnR80tf8RiQrBJeZihaPp/Y9sb65cyVunncpb0d25/uRVh35U7cHl6D1j2//e5bQ6g8HkCrGPoqWNhhCN+C9iNX9u0Nz04WOswN1rFRywYMdDulFy+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-78717221b97so469914085a.0
        for <bpf@vger.kernel.org>; Wed, 21 Feb 2024 10:04:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708538691; x=1709143491;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JFIe19FxTTUPuCH+XczS86n4xV6RfFNLZdyGHBXG52M=;
        b=kz1/Jw+4SVkzxLDVoJncG+OiaDYASLyiNGDs5rexGu/ef61dxWNI02/kBRT6GSidF6
         XbSsfKtO3rKfiYl6SPSNUmHmfKmAEYUD4rZjun8ZmPNWGO/aVKzrfH8D449DqnW32NZx
         NM+zvlOcQS1EgIcItCSXS8JILlPaTbW2jm6W26ajDg06okKw/hJ6fJT3I8i7Sexumw+q
         t9GJs9NE+eTUPI8cy2UPWtxQ0SGb22Wxkd5T/1MucFu4U7+rnBDIrWhKBzqJo5Y41pbD
         HvdrF0yHXWh5/bVYgDYcPxnqlBhMynHodKFgzTgv2FRxNthTfBMhyKrF0vzXCcVjvzau
         gwvg==
X-Gm-Message-State: AOJu0Yyv/iwuQAUXZgo+sDuPH1MoQWWj+ndY9Vo31FbNPUSfPRZivEK0
	0Ax8Fbe7ULiX9lSSUUx4u66o6GiZgkjzB+CiJZdNStWVeDB/V42p
X-Google-Smtp-Source: AGHT+IENPvJ/nAGR5/0XLSjN1w1+0a61oGAZxPvDnMf6dB5fguiKA3IqkCMVeB0eAq125wzem2HyiA==
X-Received: by 2002:a05:620a:3b8f:b0:787:8bab:33fb with SMTP id ye15-20020a05620a3b8f00b007878bab33fbmr2120501qkn.2.1708538690869;
        Wed, 21 Feb 2024 10:04:50 -0800 (PST)
Received: from maniforge (c-24-1-27-177.hsd1.il.comcast.net. [24.1.27.177])
        by smtp.gmail.com with ESMTPSA id x5-20020ae9e905000000b007874c78435bsm4343608qkf.112.2024.02.21.10.04.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 10:04:50 -0800 (PST)
Date: Wed, 21 Feb 2024 12:04:48 -0600
From: David Vernet <void@manifault.com>
To: Dave Thaler <dthaler1968=40googlemail.com@dmarc.ietf.org>
Cc: bpf@vger.kernel.org, bpf@ietf.org, Dave Thaler <dthaler1968@gmail.com>
Subject: Re: [Bpf] [PATCH bpf-next] bpf, docs: Fix typos in
 instruction-set.rst
Message-ID: <20240221180448.GC57258@maniforge>
References: <20240221173535.16601-1-dthaler1968@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fFnP5GICa4ClFIbf"
Content-Disposition: inline
In-Reply-To: <20240221173535.16601-1-dthaler1968@gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)


--fFnP5GICa4ClFIbf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024 at 09:35:35AM -0800, Dave Thaler wrote:
> * "BPF ADD" should be "BPF_ADD".
> * "src" should be "src_reg" in several places.  The latter is the field n=
ame
>   in the instruction.  The former refers to the value of the register, or=
 the
>   immediate.
> * Add '' around field names in one sentence, for consistency with the rest
>   of the document.
>=20
> Signed-off-by: Dave Thaler <dthaler1968@gmail.com>

Thanks for the cleanup.

Acked-by: David Vernet <void@manifault.com>

> ---
>  .../bpf/standardization/instruction-set.rst   | 72 +++++++++----------
>  1 file changed, 36 insertions(+), 36 deletions(-)
>=20
> diff --git a/Documentation/bpf/standardization/instruction-set.rst b/Docu=
mentation/bpf/standardization/instruction-set.rst
> index 868d9f617..56b5e7dad 100644
> --- a/Documentation/bpf/standardization/instruction-set.rst
> +++ b/Documentation/bpf/standardization/instruction-set.rst
> @@ -178,7 +178,7 @@ Unused fields shall be cleared to zero.
>  As discussed below in `64-bit immediate instructions`_, a 64-bit immedia=
te
>  instruction uses two 32-bit immediate values that are constructed as fol=
lows.
>  The 64 bits following the basic instruction contain a pseudo instruction
> -using the same format but with opcode, dst_reg, src_reg, and offset all =
set to zero,
> +using the same format but with 'opcode', 'dst_reg', 'src_reg', and 'offs=
et' all set to zero,
>  and imm containing the high 32 bits of the immediate value.

nit: Can we make sure these columns are all wrapped to 80 characters?
This can be done in a follow-up for the whole document later.

--fFnP5GICa4ClFIbf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZdY7QAAKCRBZ5LhpZcTz
ZJkbAQCUAoaW1Aa3jLUDL2FkKnIl4DawSRdtjmIHkFIMJl0hnQEApU9Jz3lPOxY+
wsnEfTnun652D8I3VOvJjZhp06Y8Ywk=
=glFy
-----END PGP SIGNATURE-----

--fFnP5GICa4ClFIbf--

