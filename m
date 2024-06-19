Return-Path: <bpf+bounces-32478-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45DCF90E086
	for <lists+bpf@lfdr.de>; Wed, 19 Jun 2024 02:14:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0AE9280E2A
	for <lists+bpf@lfdr.de>; Wed, 19 Jun 2024 00:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53F20EC5;
	Wed, 19 Jun 2024 00:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PZVnqIHL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942D8380
	for <bpf@vger.kernel.org>; Wed, 19 Jun 2024 00:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718756039; cv=none; b=tekTKEo/9/dK/PihKMOk3Ijm1wPVt/Kdqkfc7ejpVdDFsFc8xhJq/4ZPYnzxy+1ZoVcvGsZrkUl/1BulCsnnXg6N5/ZrNVoGvY9Fd8FW3tHVwAHv77ii6ocejOK//1LAQxhtXHuw9dlWa40E8ziQwDu41hPwBJQKGbNI2gIBqv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718756039; c=relaxed/simple;
	bh=2ontXAFZusya7isbXpIymZaeFpmQ+ThMbpxcQNNP2Jk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sC9hdgVwsLNEzh3FT5RoJ35fEHqC1/Le5mw6oaildflPiyKPmjVKgwgEXEeqTzA/R+yv/JM2JESriuW1tuSeg9d01sZqbfirRpB2a9LDGryEjDlRY3GMJGoHRcIxPXbhow/2ti30jx2dp1EZT5LbAKKEN7ufX/hgwpLkII1cHyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PZVnqIHL; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-70436048c25so4703373b3a.0
        for <bpf@vger.kernel.org>; Tue, 18 Jun 2024 17:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718756038; x=1719360838; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YKIpRJdnbHeBdU1Th/OIEtNKkOjt9hAMXtTyZKDYRPI=;
        b=PZVnqIHLXtBKVFk/RF/wx/PWYxKE+qVdeJ0ZA21FvRsFXjIj/H82svsREykdhheCbv
         0iChnMpLUBMHwzy1X9USBvCNGajzMrmFlKcduNxKtnAqi3W1YxQXx7Y+QxrAHYC1OJaU
         5jIV3j6jyESupiJoTxC8WOKnUfNaRmrKsmhyrVTwVVy/ssN3nmyuIql2z32j8/ssUI6/
         /KRRuwtzz33lsBjyZQ0Du9Re33dC4gyKRffLfLXHn8MoIX7oT4cAul8ASYVKP8DZbel9
         09RuzuQcGm+3T2hMBqDQjNyWqv8NjSyHkjLUzJNla8JWgy8oYdf38Mx6BH9W8fjUjkPz
         Hfmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718756038; x=1719360838;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YKIpRJdnbHeBdU1Th/OIEtNKkOjt9hAMXtTyZKDYRPI=;
        b=REp5wQqXtf1v6DBar57gC2bP7gsxRqPUQj85IQsLwRE6AEZfrSpC/iYk6vYmrIkq+y
         1s1tnNYH93yc+RjC8yJIi5/kFsci+1qxpTp6Q00D/EHk7xoMTQ0vjVLrNvJAvOBSQeJD
         8rU8R6Jh/fuc+5K/4Kbro7p0GE2ctHv6k7bzwGySZXpolqyOVN6SX6fec88O+eRsDrjS
         sVz1lgzW4zxIgMoq98XubuJrsYsa/f8oKhQGNl3otjO1E74Svg9A/ktYLzGr6MRkBWWB
         Fbz3WKA6zwgv9xEZzSMfNHJoOif43wOnPCl4bW1UCnTYPK96Bf4G5/ONkxmesh+7JNoO
         2gvA==
X-Forwarded-Encrypted: i=1; AJvYcCVR5GdNJNR2nJR8qn87W7GnlXcstR1XvhsXXkHRDIWoBdCafbP61K5nDXbFhIDtC171mlkXmj20jMtMiH7r+lT2KtxV
X-Gm-Message-State: AOJu0YxYcytokj41IXoIqG8g1FwUh4EKRIPw/lO5x2JMILpsc3zaZiol
	d+FvKQNgAUTxj9DMYujVBZjrxOgUtQ8a33jP5Txb0wBMYQCTD7fTGZY5cgka
X-Google-Smtp-Source: AGHT+IE5ISJ67P0JH8cYG5f8r8MKSNuxmm9xfFG6cTtwcDOh/317PIRMKz8Rks5Ora+/IWDfqYhWkw==
X-Received: by 2002:a05:6a20:121e:b0:1af:9ec6:afbd with SMTP id adf61e73a8af0-1bcbb3e0d56mr1007696637.11.1718756037682;
        Tue, 18 Jun 2024 17:13:57 -0700 (PDT)
Received: from [192.168.0.31] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705cc91f699sm9486663b3a.36.2024.06.18.17.13.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 17:13:57 -0700 (PDT)
Message-ID: <914a56c08065a07553a31138a890d772600cee68.camel@gmail.com>
Subject: Re: [PATCH bpf 1/2] bpf: Fix the corner case where may_goto is a
 1st insn.
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
Cc: daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org, 
	memxor@gmail.com, zacecob@protonmail.com, kernel-team@fb.com
Date: Tue, 18 Jun 2024 17:13:52 -0700
In-Reply-To: <20240618184219.20151-1-alexei.starovoitov@gmail.com>
References: <20240618184219.20151-1-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-06-18 at 11:42 -0700, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
>=20
> When the following program is processed by the verifier:
> L1: may_goto L2
>     goto L1
> L2: w0 =3D 0
>     exit
>=20
> the may_goto insn is first converted to:
> L1: r11 =3D *(u64 *)(r10 -8)
>     if r11 =3D=3D 0x0 goto L2
>     r11 -=3D 1
>     *(u64 *)(r10 -8) =3D r11
>     goto L1
> L2: w0 =3D 0
>     exit

[...]

>=20
> Reported-by: Zac Ecob <zacecob@protonmail.com>
> Closes: https://lore.kernel.org/bpf/CAADnVQJ_WWx8w4b=3D6Gc2EpzAjgv+6A0rid=
nMz2TvS2egj4r3Gw@mail.gmail.com/
> Fixes: 011832b97b31 ("bpf: Introduce may_goto instruction")
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---

A tricky corner case indeed.
We should probably switch to normal basic blocks one day...

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

