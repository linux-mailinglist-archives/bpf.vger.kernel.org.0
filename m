Return-Path: <bpf+bounces-21229-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88E30849DC4
	for <lists+bpf@lfdr.de>; Mon,  5 Feb 2024 16:14:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28E9B1F2333B
	for <lists+bpf@lfdr.de>; Mon,  5 Feb 2024 15:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 383562C6AC;
	Mon,  5 Feb 2024 15:14:06 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF302C68C
	for <bpf@vger.kernel.org>; Mon,  5 Feb 2024 15:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707146045; cv=none; b=SfbmFfNbSig9bxtEMZh2SS4yOelQhaFeDkFtHVW8ENrwtuBeVXC50CF36RHr16B4gyxV1FGdsxvTtoFIL4GefVx+51GGlM8UBDEqm2RPL8CEAUdEMZnTiPwa07L/zKVYcWKAQd7CtBu+SLIkv8J6NvohD8RzU9NpMi1Gpww8hEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707146045; c=relaxed/simple;
	bh=rE4Y5qRebnxxnj3XcZWGjeL8GE7yUO654H44+vCDHZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KxtsDZFLdHPXzJNrtxYWDrk/L9GI7znwmpcqmPMVuxFrPwxUlZaE31awulxuUdX9U2pd1FLXpC/PQ8xuOuTyRv7WfZzI/OKaOLWIH736J9i3y3ovrW05MgWEO8vlFr7IHOleWHF8vJ3AWXnnkWrTRkxccJfJG+0AIakJ4ywL0S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-2196dd318feso1096121fac.2
        for <bpf@vger.kernel.org>; Mon, 05 Feb 2024 07:14:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707146043; x=1707750843;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rE4Y5qRebnxxnj3XcZWGjeL8GE7yUO654H44+vCDHZk=;
        b=D5MCtqz+XPkoMWPC4LnDlTwmMBqi7S+l64fb4mAdaqoulo998e7NH2eLCKYdFLmkN/
         t0ApaxMwPOqaZp+3koANfbzFJcgWrdnewgaeZE9gYtIRL7PmU7lYj2t0LtP40YyNb+bJ
         Zm4CtDFFflkwvFV8dPnC/poLQZfY4mv8+43iJUa1ZdW2oHwcAJZrL3r/HkqETTnfTUnN
         OkXGHYsKggrqUdMDKjj+cV24nOHfuW+/sqyLjIOnL3VfpkEAFwfM2QD7nK0qxI8vQKka
         KvFUDXtkxb3CebdiVR5wmxzh/FQFPrKbq576GeDikTs+e5MWAO5DM5nr54OGXBRIiLkD
         WQqw==
X-Gm-Message-State: AOJu0YxqpOLaTQ3uXAtSsxkOVEOlA0jsfnCS+ZJ3aC/yOy2De0Pu3/OO
	PX9UaQwKn3FcTCN52s1XvRv7OieCi27zQCwqIGuF1O3z6PhjmYAH
X-Google-Smtp-Source: AGHT+IGmbKff2vVF9nHlXPPHnQKGWi9TvR8Jmme7watK5qROLTI/XZHwFl+tV6pQzKc6whKQGtcwxg==
X-Received: by 2002:a05:6871:4311:b0:219:6cd9:3e26 with SMTP id lu17-20020a056871431100b002196cd93e26mr5440585oab.23.1707146043172;
        Mon, 05 Feb 2024 07:14:03 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWQ1NpSBPG5lFlzk1fMi7wUPrZtSPA/qk9v+wWzbHzI4iNtpGIvDMzp33CS4pUdXOBbw5Yb2c9iz9VBSVT8aoSLIczr645VLi9tKcSng3Hyb/Kkx/AV8V9AP9Zjer3o4qpJSaQnUjjOGRs4zVUxJeim28KvqN8Ttiv+bNMnKJS1xmtbK0VAVj6IDyaa5AhTCiun6BbLeHuJczUUJ7DXeEv4XhVlJ84PRFOdIgwsu6LZx62ebS7AbSPbr0Ls4g==
Received: from maniforge (c-24-1-27-177.hsd1.il.comcast.net. [24.1.27.177])
        by smtp.gmail.com with ESMTPSA id c4-20020a0ce7c4000000b0068c55087a1asm53438qvo.74.2024.02.05.07.14.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 07:14:02 -0800 (PST)
Date: Mon, 5 Feb 2024 09:14:00 -0600
From: David Vernet <void@manifault.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, Yafang Shao <laoar.shao@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Transfer RCU lock state between
 subprog calls
Message-ID: <20240205151400.GE120243@maniforge>
References: <20240205055646.1112186-1-memxor@gmail.com>
 <20240205055646.1112186-2-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wKy4UBWIzWPNlPEn"
Content-Disposition: inline
In-Reply-To: <20240205055646.1112186-2-memxor@gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)


--wKy4UBWIzWPNlPEn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 05, 2024 at 05:56:45AM +0000, Kumar Kartikeya Dwivedi wrote:
> Allow transferring an imbalanced RCU lock state between subprog calls
> during verification. This allows patterns where a subprog call returns
> with an RCU lock held, or a subprog call releases an RCU lock held by
> the caller. Currently, the verifier would end up complaining if the RCU
> lock is not released when processing an exit from a subprog, which is
> non-ideal if its execution is supposed to be enclosed in an RCU read
> section of the caller.
>=20
> Instead, simply only check whether we are processing exit for frame#0
> and do not complain on an active RCU lock otherwise. We only need to
> update the check when processing BPF_EXIT insn, as copy_verifier_state
> is already set up to do the right thing.
>=20
> Suggested-by: David Vernet <void@manifault.com>
> Tested-by: Yafang Shao <laoar.shao@gmail.com>
> Acked-by: Yonghong Song <yonghong.song@linux.dev>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

Acked-by: David Vernet <void@manifault.com>

--wKy4UBWIzWPNlPEn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZcD7OAAKCRBZ5LhpZcTz
ZCmmAQC/AtgnwxJybYDYlZR5+BdSOWcBk9UrXEo0ChzQF46OrAD+MRMl6SJ/SWwM
yKGS3uxZAezH25H65dvk9EGX4/zFUgg=
=4SPl
-----END PGP SIGNATURE-----

--wKy4UBWIzWPNlPEn--

