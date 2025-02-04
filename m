Return-Path: <bpf+bounces-50369-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CFB9DA26A8C
	for <lists+bpf@lfdr.de>; Tue,  4 Feb 2025 04:18:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63595166094
	for <lists+bpf@lfdr.de>; Tue,  4 Feb 2025 03:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13555155300;
	Tue,  4 Feb 2025 03:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g10+NeRY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32DBB25A642;
	Tue,  4 Feb 2025 03:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738639077; cv=none; b=stFQU1oB4sOo3impbBsO6BVdqmtEHIIW7iLbvMWJxvRYiM1MiVr96hB8JPRHluDJgr/QnoanMo/Xfc1U947b6SIUzaxrGtXFp1I/giD0aeFvonWHAnQ2SGvbXxOBEj9guj1n2G+SQ9mN3HXD4MtDK+HnQdhk4C+0XnliJxjOrI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738639077; c=relaxed/simple;
	bh=oQmqnX1vMsdL26/Sj0ggkmLweLyaggnCmK+4HX6xhS4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XGESfctzZCd3LZTZwf6R44SA0bFZkE/WILG7fL8c41ydrlm3ZPKkxOxDXH1ayTzd7hHuvnVTLh9ysZKlhuLbSNU+FLVVRvXcWp9hPd2eIBPx5JFEBU6w5zzurZJHwRNBy9phnefIZ50eKeMx3ZvjN9TRW5jNm7xw6A9G0FmIV7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g10+NeRY; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-21631789fcdso80217555ad.1;
        Mon, 03 Feb 2025 19:17:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738639075; x=1739243875; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=m9iUMCX2C7oQF8m71KELy1Ls84UETZKEN4RnBwVVdcM=;
        b=g10+NeRYYXw5PfI42MdgLm51QEv39SyPbr9Y71LALaFx8WlRCpvxiONIGNwBfiV+X0
         MC08QUF43MAzF2cEryz01AtVCkEf1pR11QwKscPg96bI5K0d3fniAkdbZGfMYj3xeqBs
         V1FZT694UJ3Gh9ULkAcKFNIIX0vI7jFpa2kJm8xNEiLgEGvCz3ixcAW7Czy4B5Di6otx
         sjQ7/agbgWKojoyQset/uV4pGPu88TNpgkh2ASCgpZJnTyKxN7e8/SH4fL7IbWvpaLG7
         PeP2BdCmxdJJ3NxGrj3sLJUlQJYoFOTYuBXba7T7BEsOZWG9JSwjMWbxsG0N8ayby0R1
         Qvwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738639075; x=1739243875;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m9iUMCX2C7oQF8m71KELy1Ls84UETZKEN4RnBwVVdcM=;
        b=Gy8HVdZqnJ46hTeMPo+nCFunodJ232f2sJpMMxgtrxKzGHx6HL07g31OrPG8zrCoxc
         tjDZEvKypOKWtxQM0drte0hA4DYvTVSSbFw3Lj7p2zQMG0eBfnYZAicoM8BbTKPqZscw
         mTBB2C4TKYKFedoH6v7XYnRHe9Sb9E0PweQohABAh0++DIghch4jdC3nr/igd3i4Fn8b
         R7h4vcmhQEam6/h1o+cCzm1js95CdY0TPE1F5ppSDX+S8QeE39e5qfm/g4IXhPRMj+59
         ugjzzcqB/y5LxPrvtF9juwRaH34FoCPFNtVKXuDK74thO1mRdeyIVY9CbT8kimYncitk
         Ml/Q==
X-Forwarded-Encrypted: i=1; AJvYcCXpvfJv9XrASTFBPJgla7mkjaK4nkvqwBPXcBx5MGOThs0s+u+sVpT316BDXfPACDbvrr9dUdupXH5pxNY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwChu7ar7u99u9dIk3oxehLJbeo33RlUxFeoLw35iFBitrpuJC
	5yAs2f/Jox6ZBoQcsLS15s6whnlto2vbxR6Fg/0A8CX4TY9EAirD
X-Gm-Gg: ASbGncvR0kuxLaVCH4j8JEvtfvtQ4C8VVlGmg56xH6GWOZYXGFNlF+zd8WRP3+eKfSl
	YGbD9vgjlU6eoUAoASYufHg+nicDoPDaj2zdCWarzLi2YiribDFQf+Q/3eD2mkF0oa8UxdEWgZ/
	emkg2SEI6DlJYFpch0Wi5fdfbkx4KFX6aqEZLpbIqZ8pHM+WKTy63Ah1yxQ5s8fFoYt9yqTUh9U
	yz78+rYZRAQx5pDlSFzLVBnaDwk/jYdYUWhDkx8Ckze4BrfoBGW7mJn4FO3wdITMbuD1xgy6eTb
	SxYAu9BqCnL/U/Q=
X-Google-Smtp-Source: AGHT+IEOQ4l1+0gNWPgwePYCg04LFtGZeL/PCR/SxdNj30enmmO/H+Xf2sufgBGuvAjA3jk7PgArfA==
X-Received: by 2002:a17:903:11cd:b0:216:84f0:e33c with SMTP id d9443c01a7336-21f01d137edmr19952205ad.20.1738639073666;
        Mon, 03 Feb 2025 19:17:53 -0800 (PST)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f0225f31csm3776365ad.39.2025.02.03.19.17.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 19:17:52 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 823F84209E79; Tue, 04 Feb 2025 10:17:50 +0700 (WIB)
Date: Tue, 4 Feb 2025 10:17:50 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: rsworktech@outlook.com, Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next] bpf: Add comment about helper freeze
Message-ID: <Z6GG3t4N_Heg4tPU@archie.me>
References: <20250204-bpf-helper-freeze-v1-1-46efd9ff20dc@outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ZWP0/47uozAhcX1F"
Content-Disposition: inline
In-Reply-To: <20250204-bpf-helper-freeze-v1-1-46efd9ff20dc@outlook.com>


--ZWP0/47uozAhcX1F
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 04, 2025 at 10:00:21AM +0800, Levi Zim via B4 Relay wrote:
> -	/* */
> +	/* This helper list is effectively frozen. If you are trying to	\
> +	 * add a new helper, you should add a kfunc instead which has	\
> +	 * less stability guarantees. See Documentation/bpf/kfuncs.rst	\
> +	 */
> =20

The wording looks good, thanks!

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--ZWP0/47uozAhcX1F
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZ6GG2gAKCRD2uYlJVVFO
o272AQDceVI1bUC3ePm58LCNWojwYH+3nVgfsw9jZUvAf4pNjAEA8ceMxwepSdkx
hcsy8qRtOV0Ao9YSYPPhlWPqsXVHNwQ=
=qdKn
-----END PGP SIGNATURE-----

--ZWP0/47uozAhcX1F--

