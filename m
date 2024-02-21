Return-Path: <bpf+bounces-22452-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9BF585E52C
	for <lists+bpf@lfdr.de>; Wed, 21 Feb 2024 19:05:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AFC51F2431E
	for <lists+bpf@lfdr.de>; Wed, 21 Feb 2024 18:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E47484A26;
	Wed, 21 Feb 2024 18:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="aXZvL9cn";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="aXZvL9cn"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B418526A
	for <bpf@vger.kernel.org>; Wed, 21 Feb 2024 18:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.223.129.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708538726; cv=none; b=BPHjNF6bnEJybvhZafmslI6q/rVMEQC3uo1EvlPJldcs9du7WjbW5zfcfNTpnBRxI+UyQqpIAIhv9lgG2P06zznKNpla0n7H3+SwL1r07mb0S20DbKyC/hVzvmxshb7bolURO/GjARp5B+mRlpJKY2WDGTIpQwv5yv+2VR6NGGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708538726; c=relaxed/simple;
	bh=Am6dzX5G/C/Y3FV9qeDJy2XIF6EqZysVoERVPpOmrWU=;
	h=Date:From:To:Cc:Message-ID:References:MIME-Version:In-Reply-To:
	 Subject:Content-Type; b=AAFvKCFvo8ZsqQSq6gYgduucQ8xAY7cg1MUyh3H60CiTPLNVJwV2xHnLE7CmPWhEQCSak5hxXy5NsnW4YFzZWDOrjfmG7qBYscT9zxCIokKYqtekQ0HezcISWY10koGiRGQh6uJgzgx9As/wsv0JTVBHoWSDgErAUP8yS6tXbBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=ietf.org; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=aXZvL9cn; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=aXZvL9cn; arc=none smtp.client-ip=50.223.129.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id CA2F0C1519B0
	for <bpf@vger.kernel.org>; Wed, 21 Feb 2024 10:05:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1708538723; bh=Am6dzX5G/C/Y3FV9qeDJy2XIF6EqZysVoERVPpOmrWU=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=aXZvL9cnIRR161NhUiERU7MXqFDHVgef7FDgoHQ4Up6Dzxjuez0tHONUYHVcQEsOY
	 tkCnG0c+bDlhYDSWqc1SDCkdd04Wp+lpzHlzE92wlAuTyp8HgaaSlk3KeFDQACv3in
	 2fuep9NTft0e/N031xoxN0U1cR8/aVeAg3wK6fJ4=
X-Mailbox-Line: From bpf-bounces@ietf.org  Wed Feb 21 10:05:23 2024
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 8DE2EC151095;
	Wed, 21 Feb 2024 10:05:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1708538723; bh=Am6dzX5G/C/Y3FV9qeDJy2XIF6EqZysVoERVPpOmrWU=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=aXZvL9cnIRR161NhUiERU7MXqFDHVgef7FDgoHQ4Up6Dzxjuez0tHONUYHVcQEsOY
	 tkCnG0c+bDlhYDSWqc1SDCkdd04Wp+lpzHlzE92wlAuTyp8HgaaSlk3KeFDQACv3in
	 2fuep9NTft0e/N031xoxN0U1cR8/aVeAg3wK6fJ4=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id CA18CC14F682
 for <bpf@ietfa.amsl.com>; Wed, 21 Feb 2024 10:05:21 -0800 (PST)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -1.41
X-Spam-Level: 
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yOb6qtH8-a6N for <bpf@ietfa.amsl.com>;
 Wed, 21 Feb 2024 10:05:21 -0800 (PST)
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com
 [209.85.222.175])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 01F33C15109A
 for <bpf@ietf.org>; Wed, 21 Feb 2024 10:04:51 -0800 (PST)
Received: by mail-qk1-f175.google.com with SMTP id
 af79cd13be357-7838af983c1so502673085a.3
 for <bpf@ietf.org>; Wed, 21 Feb 2024 10:04:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708538691; x=1709143491;
 h=user-agent:in-reply-to:content-disposition:mime-version:references
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JFIe19FxTTUPuCH+XczS86n4xV6RfFNLZdyGHBXG52M=;
 b=n1CtTkHb4Bdo89sq2T7vc6YkKXG8kdQD56i0w/bbKQ6d5xe5yUKrSre4brHkI+x01l
 M2Dm5xJQOoNkVGCcJWw5Zhr/YZM3vNxRUpi65GRTkjohrzqwY2IvlAWzsCQu+t4IxcJ0
 iXDr9rZE9y8CQrvafdE+mOVDm39vpz9y+k3M8QDduVuHs5DTl0QTLNAxQNo5bRNcu1SU
 aql2tosoFhpPb6o0Vsx+7UznPhyGMeDhJDompZ+HipWzdo9hbCMkI1Fv56W8XnV6qxl1
 bevablfYiuWa7e+brsLdCb9/PyyUXJ8LHRNpYAKuEJ/cSyq8u3g5DfNiKFwLKRjBCP2c
 8k7A==
X-Forwarded-Encrypted: i=1;
 AJvYcCU0rPRP47GHdA9U5yPNhN1JxlpAVWbThRoYKLUl1aRspvtGUTHJK9rlwDRWjNR4bvsBsk+hV1H8fcyc4c0=
X-Gm-Message-State: AOJu0YyDAgAUeN7uMrQRI/RuIM9kmna1+OAC7Ga6DYFY9drv4jEUQTUS
 pWDTzwDkvsMzZSjG6nXq3pbjXK9CDYI9lALPqmUWCm6C6f+ODwED
X-Google-Smtp-Source: AGHT+IENPvJ/nAGR5/0XLSjN1w1+0a61oGAZxPvDnMf6dB5fguiKA3IqkCMVeB0eAq125wzem2HyiA==
X-Received: by 2002:a05:620a:3b8f:b0:787:8bab:33fb with SMTP id
 ye15-20020a05620a3b8f00b007878bab33fbmr2120501qkn.2.1708538690869; 
 Wed, 21 Feb 2024 10:04:50 -0800 (PST)
Received: from maniforge (c-24-1-27-177.hsd1.il.comcast.net. [24.1.27.177])
 by smtp.gmail.com with ESMTPSA id
 x5-20020ae9e905000000b007874c78435bsm4343608qkf.112.2024.02.21.10.04.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Feb 2024 10:04:50 -0800 (PST)
Date: Wed, 21 Feb 2024 12:04:48 -0600
From: David Vernet <void@manifault.com>
To: Dave Thaler <dthaler1968=40googlemail.com@dmarc.ietf.org>
Cc: bpf@vger.kernel.org, bpf@ietf.org, Dave Thaler <dthaler1968@gmail.com>
Message-ID: <20240221180448.GC57258@maniforge>
References: <20240221173535.16601-1-dthaler1968@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240221173535.16601-1-dthaler1968@gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/it7_lqhvjuhwNmZbND3CWUf9xc0>
Subject: Re: [Bpf] [PATCH bpf-next] bpf,
 docs: Fix typos in instruction-set.rst
X-BeenThere: bpf@ietf.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf/>
List-Post: <mailto:bpf@ietf.org>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
Content-Type: multipart/mixed; boundary="===============2305382836399052338=="
Errors-To: bpf-bounces@ietf.org
Sender: "Bpf" <bpf-bounces@ietf.org>


--===============2305382836399052338==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fFnP5GICa4ClFIbf"
Content-Disposition: inline


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


--===============2305382836399052338==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

--===============2305382836399052338==--


