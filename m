Return-Path: <bpf+bounces-22461-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ADE785E9DE
	for <lists+bpf@lfdr.de>; Wed, 21 Feb 2024 22:18:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9F8F2845AD
	for <lists+bpf@lfdr.de>; Wed, 21 Feb 2024 21:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86F561272A1;
	Wed, 21 Feb 2024 21:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="gOZfXO9i";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="gOZfXO9i"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ADE37CF03
	for <bpf@vger.kernel.org>; Wed, 21 Feb 2024 21:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.223.129.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708550322; cv=none; b=lS44DL7wr8CoI7i5xmEsn3pwtleQ+9j5SV6Sy2yrrAvCTLNN5UeOjIfoepmgpirkhgBbpjssNp8sMtqHTB7OruWhaQZHQavTcy9AcS5SbHnjaIj3gtwXHhfByA/PzZREInp6WQu2ijy/a6L4FgMxUkWyvkrAjtxL3CTjMeiGVpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708550322; c=relaxed/simple;
	bh=3LFIlXmiXmji4HAIqdUrDIeqlkMWJggmYRijtoL79tk=;
	h=Date:From:To:Cc:Message-ID:References:MIME-Version:In-Reply-To:
	 Subject:Content-Type; b=PGds3t1vsIm/fNAkjS5YvKW2F/yuM8vXSJK4RmIjl9+y4UxkD372HJ5rncf7S4LQ0jVluNV/wM7ZbtBUzQYByeXxwHeLkGgdn7ory3MdnM6C/biStOUfrS8t/Xrg1C3qoVzGTQtU3zrFzBpHxe1H6tvsSAKLSM9OHKCMAec5O90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=ietf.org; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=gOZfXO9i; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=gOZfXO9i; arc=none smtp.client-ip=50.223.129.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 8BC05C151520
	for <bpf@vger.kernel.org>; Wed, 21 Feb 2024 13:18:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1708550319; bh=3LFIlXmiXmji4HAIqdUrDIeqlkMWJggmYRijtoL79tk=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=gOZfXO9i7u91Dc4B6IolU3D2XBF4bQKeXyOWv5O3LJltLoOJpGRBy34T/AgmgUoN5
	 aq9Qt1WwOLhXfsOfwG3A36xKHjg2bbfIRnEjQXLL9DbZr0i19KVAMSF/2PuImFFI59
	 YLxMUI8eLdYNTtLSjoMHExAqIyWL6uLCXg3qatEQ=
X-Mailbox-Line: From bpf-bounces@ietf.org  Wed Feb 21 13:18:39 2024
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 67D18C151981;
	Wed, 21 Feb 2024 13:18:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1708550319; bh=3LFIlXmiXmji4HAIqdUrDIeqlkMWJggmYRijtoL79tk=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=gOZfXO9i7u91Dc4B6IolU3D2XBF4bQKeXyOWv5O3LJltLoOJpGRBy34T/AgmgUoN5
	 aq9Qt1WwOLhXfsOfwG3A36xKHjg2bbfIRnEjQXLL9DbZr0i19KVAMSF/2PuImFFI59
	 YLxMUI8eLdYNTtLSjoMHExAqIyWL6uLCXg3qatEQ=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 22C4AC1516E9
 for <bpf@ietfa.amsl.com>; Wed, 21 Feb 2024 13:18:38 -0800 (PST)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -1.406
X-Spam-Level: 
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9bCtGUaMHiPH for <bpf@ietfa.amsl.com>;
 Wed, 21 Feb 2024 13:18:37 -0800 (PST)
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com
 [209.85.222.170])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 46130C151065
 for <bpf@ietf.org>; Wed, 21 Feb 2024 13:18:37 -0800 (PST)
Received: by mail-qk1-f170.google.com with SMTP id
 af79cd13be357-7875c347a03so66018985a.0
 for <bpf@ietf.org>; Wed, 21 Feb 2024 13:18:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708550316; x=1709155116;
 h=user-agent:in-reply-to:content-disposition:mime-version:references
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ID/ziJ7Zytmbi5/TXUvVVX5nRNJLW72pg8yXzjl8H34=;
 b=RNfyHa1bIwEOyUbA8A9dH057qxvJu/5hbfmiLXwt+tA5aRwfyUBDgBzkKwjtDq4sMw
 sP6C/dEuiuQcofZEjYmDiz0YV8mgptfBdfw1UqpZSvo2xhGjqJAsM/AB+HQfDbbOeE68
 gkRoltlthe391VBuMSA7Q/Z+mnNLzJU8/dvdI+3PR3cPhD9Yj/gVdRKg1LIdxIv2hRfQ
 kWP7rZ5Fab5uSlQeb6Dhiyf/fOmEfGt/C3uFw2ofmcQUNELkK3sAIg6QEsdVbsrTRcq3
 cumfvewcBqEZQiSSCfDkzUQmi9EKPIUvN4pFgJzAbD+AaqrM2P+uSokDvzZvI7MKWCz4
 uFrg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUDqetrO0qwhz05a/0gB1KfulExeri9/MU8WblY1YkKq1yKlbFphNMaFcyUZGA72pcPAQES8ZGSd9BJ/Do=
X-Gm-Message-State: AOJu0Yz1PXqrkFoWZOzZEoyjFFBR2THUbXnyJ4t3dyHLRrH4JYgLDwlW
 CHE3OuremQQMQdTL5bHQkzSV6POFo7cBtgThrSBY8EYX1tJC90lu
X-Google-Smtp-Source: AGHT+IFgSf39/YHeCVwUAD0jRSVYnf9BkNWRlIlbdWVSBSz9tuBoaUPCPHCGba1Wqjbn0ZdW+hy61A==
X-Received: by 2002:a05:620a:10b4:b0:787:2641:1642 with SMTP id
 h20-20020a05620a10b400b0078726411642mr21805286qkk.41.1708550316170; 
 Wed, 21 Feb 2024 13:18:36 -0800 (PST)
Received: from maniforge (c-24-1-27-177.hsd1.il.comcast.net. [24.1.27.177])
 by smtp.gmail.com with ESMTPSA id
 i9-20020a05620a248900b0078790872f9bsm547250qkn.33.2024.02.21.13.18.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Feb 2024 13:18:35 -0800 (PST)
Date: Wed, 21 Feb 2024 15:18:33 -0600
From: David Vernet <void@manifault.com>
To: Dave Thaler <dthaler1968=40googlemail.com@dmarc.ietf.org>
Cc: bpf@vger.kernel.org, bpf@ietf.org, Dave Thaler <dthaler1968@gmail.com>
Message-ID: <20240221211833.GD57258@maniforge>
References: <20240221191725.17586-1-dthaler1968@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240221191725.17586-1-dthaler1968@gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/AzMdgnPqOHExs-UdVT3sgYpnfls>
Subject: Re: [Bpf] [PATCH bpf-next v4] bpf,
 docs: Add callx instructions in new conformance group
X-BeenThere: bpf@ietf.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf/>
List-Post: <mailto:bpf@ietf.org>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
Content-Type: multipart/mixed; boundary="===============8675833930507747852=="
Errors-To: bpf-bounces@ietf.org
Sender: "Bpf" <bpf-bounces@ietf.org>


--===============8675833930507747852==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6cUh12TpXuQolOFP"
Content-Disposition: inline


--6cUh12TpXuQolOFP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024 at 11:17:25AM -0800, Dave Thaler wrote:
> * Add a "callx" conformance group
> * Add callx row to table
> * Update helper function to section to be agnostic between BPF_K vs
>   BPF_X
> * Rename "legacy" conformance group to "packet"
>=20
> Based on mailing list discussion at
> https://mailarchive.ietf.org/arch/msg/bpf/l5tNEgL-Wo7qSEuaGssOl5VChKk/
>=20
> Only src=3D0 is currently listed for callx. Neither clang nor gcc
> use src=3D1 or src=3D2, and both use exactly the same semantics for
> src=3D0 which was agreed between them (Yonghong and Jose). Since src=3D0
> semantics are agreed upon by both and is already implemented, src=3D0
> is documented as implemented.

If the semantics for src=3D0 were already decided for both clang and gcc,
then this seems fine to me. Agreed as well with leaving src > 0 for
later, as Alexei said on the v3 thread. We can decide how to best deal
with indirect calls at a later time.

Alexei -- is this acceptable?

> v1->v2: Incorporated feedback from Will Hawkins
>=20
> v2->v3: Use "dst" not "imm" field
>=20
> v3->v4: Only use src=3D0
>=20
> Signed-off-by: Dave Thaler <dthaler1968@gmail.com>
> ---
>  .../bpf/standardization/instruction-set.rst   | 29 ++++++++++++-------
>  1 file changed, 18 insertions(+), 11 deletions(-)
>=20
> diff --git a/Documentation/bpf/standardization/instruction-set.rst b/Docu=
mentation/bpf/standardization/instruction-set.rst
> index bdfe0cd0e..a68445899 100644
> --- a/Documentation/bpf/standardization/instruction-set.rst
> +++ b/Documentation/bpf/standardization/instruction-set.rst
> @@ -127,7 +127,7 @@ This document defines the following conformance group=
s:
>  * divmul32: includes 32-bit division, multiplication, and modulo instruc=
tions.
>  * divmul64: includes divmul32, plus 64-bit division, multiplication,
>    and modulo instructions.
> -* legacy: deprecated packet access instructions.
> +* packet: deprecated packet access instructions.
> =20
>  Instruction encoding
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> @@ -404,9 +404,10 @@ BPF_JSET  0x4    any  PC +=3D offset if dst & src
>  BPF_JNE   0x5    any  PC +=3D offset if dst !=3D src
>  BPF_JSGT  0x6    any  PC +=3D offset if dst > src        signed
>  BPF_JSGE  0x7    any  PC +=3D offset if dst >=3D src       signed
> -BPF_CALL  0x8    0x0  call helper function by address  BPF_JMP | BPF_K o=
nly, see `Helper functions`_
> +BPF_CALL  0x8    0x0  call_by_address(imm)             BPF_JMP | BPF_K o=
nly
> +BPF_CALL  0x8    0x0  call_by_address(dst)             BPF_JMP | BPF_X o=
nly
>  BPF_CALL  0x8    0x1  call PC +=3D imm                   BPF_JMP | BPF_K=
 only, see `Program-local functions`_
> -BPF_CALL  0x8    0x2  call helper function by BTF ID   BPF_JMP | BPF_K o=
nly, see `Helper functions`_
> +BPF_CALL  0x8    0x2  call_by_btfid(imm)               BPF_JMP | BPF_K o=
nly
>  BPF_EXIT  0x9    0x0  return                           BPF_JMP | BPF_K o=
nly
>  BPF_JLT   0xa    any  PC +=3D offset if dst < src        unsigned
>  BPF_JLE   0xb    any  PC +=3D offset if dst <=3D src       unsigned
> @@ -414,6 +415,11 @@ BPF_JSLT  0xc    any  PC +=3D offset if dst < src   =
     signed
>  BPF_JSLE  0xd    any  PC +=3D offset if dst <=3D src       signed
>  =3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D  =3D=3D=3D  =3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =20
> +where
> +
> +* call_by_address(value) means to call a helper function by the address =
specified by 'value' (see `Helper functions`_ for details)
> +* call_by_btfid(value) means to call a helper function by the BTF ID spe=
cified by 'value' (see `Helper functions`_ for details)
> +
>  The BPF program needs to store the return value into register R0 before =
doing a
>  ``BPF_EXIT``.
> =20
> @@ -438,8 +444,9 @@ specified by the 'imm' field. A > 16-bit conditional =
jump may be
>  converted to a < 16-bit conditional jump plus a 32-bit unconditional
>  jump.
> =20
> -All ``BPF_CALL`` and ``BPF_JA`` instructions belong to the
> -base32 conformance group.
> +The ``BPF_CALL | BPF_X`` instruction belongs to the callx
> +conformance group.  All other ``BPF_CALL`` instructions and all
> +``BPF_JA`` instructions belong to the base32 conformance group.
> =20
>  Helper functions
>  ~~~~~~~~~~~~~~~~
> @@ -447,13 +454,13 @@ Helper functions
>  Helper functions are a concept whereby BPF programs can call into a
>  set of function calls exposed by the underlying platform.
> =20
> -Historically, each helper function was identified by an address
> -encoded in the imm field.  The available helper functions may differ
> -for each program type, but address values are unique across all program =
types.
> +Historically, each helper function was identified by an address.
> +The available helper functions may differ for each program type,
> +but address values are unique across all program types.
> =20
>  Platforms that support the BPF Type Format (BTF) support identifying
> -a helper function by a BTF ID encoded in the imm field, where the BTF ID
> -identifies the helper name and type.
> +a helper function by a BTF ID, where the BTF ID identifies the helper
> +name and type.
> =20
>  Program-local functions
>  ~~~~~~~~~~~~~~~~~~~~~~~
> @@ -660,4 +667,4 @@ carried over from classic BPF. These instructions use=
d an instruction
>  class of BPF_LD, a size modifier of BPF_W, BPF_H, or BPF_B, and a
>  mode modifier of BPF_ABS or BPF_IND.  However, these instructions are
>  deprecated and should no longer be used.  All legacy packet access
> -instructions belong to the "legacy" conformance group.
> +instructions belong to the "packet" conformance group.
> --=20
> 2.40.1
>=20
> --=20
> Bpf mailing list
> Bpf@ietf.org
> https://www.ietf.org/mailman/listinfo/bpf

--6cUh12TpXuQolOFP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZdZoqQAKCRBZ5LhpZcTz
ZBLqAP9kJcvc0C8Y3Ohy+uu0IPIKBYrNnanKPknT4lOLf0shegD/d6d/6fnKdDY4
V9ATG08rbJ5UyhiDHkQ3nctrZ9/+7QA=
=heNs
-----END PGP SIGNATURE-----

--6cUh12TpXuQolOFP--


--===============8675833930507747852==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

--===============8675833930507747852==--


