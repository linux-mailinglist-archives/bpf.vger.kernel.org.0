Return-Path: <bpf+bounces-65932-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFEBAB2B4C6
	for <lists+bpf@lfdr.de>; Tue, 19 Aug 2025 01:32:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A962C1690FE
	for <lists+bpf@lfdr.de>; Mon, 18 Aug 2025 23:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C35CC21A436;
	Mon, 18 Aug 2025 23:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HFsaKaf6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D3D3451BA
	for <bpf@vger.kernel.org>; Mon, 18 Aug 2025 23:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755559887; cv=none; b=PYpIxD+vFPBo4R10dr2GY81UycxqCngMxG5Te1aUoamzjtpE7jcMWcJlaUdvyMcJbghb1NRj7z8ykzbiudTRdXlPMkqzw9+g+KgGy0Blx0wxIh4h85kf4j7SBKnEgLOlityEWKMz/9XgJz+t37T5JqNG2Q/pmgDKIf4xgxgAE8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755559887; c=relaxed/simple;
	bh=PSl/FfY12yBb5BdtIvBjG5d6I7AXITAOzHrX2jFXSbk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gwsjY7A44U+gN3wGqrJ3hNujSdw7lXS2/cb+EYFDAaJISxb8KXWUOPNcTIXBU2SCN3YcCJpwbLR0wJ/UpuCM/Q8Td+VbidlnWU+5TNsqqsOagHqkpp9EfHDU5yR0vs2C4tmGWpkOVyTAkim+nA7/pm+rsYWDgtVpwI94YZLf5lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HFsaKaf6; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-32326e5f058so3382527a91.3
        for <bpf@vger.kernel.org>; Mon, 18 Aug 2025 16:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755559885; x=1756164685; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QsCtnCoblRs2RCAx3bOgR7IBYOxvM+3Z75U2o+7oIps=;
        b=HFsaKaf6M68yK8PNkle5yBKttP/oK+5L5r3vvVp45n/8WfdOSlKYAf/O7KLGzn40c6
         yUagXX/zv+mINOBe7lzICvhBy3dY76ZFhKwIHibGAZwrwMg8VgxX2cDdx4/ZBpgQ51Mu
         aInDWMl+th6wuJFb8XyQg7A8JCLNTsySMICvH6hDQNLNK9w1NQx1GWHxleD2zybn063h
         BoIX8/CIaoKVXu0Wuo+1E3diUohy2wIDLlcBeykfm4YripC4g15g3W8q+AUJ1PqL1LzV
         TbdijESFFKi1NxqtGkBlerJfBuU0TnSN7JaKvkhcd42ye8trl0HASK6XfuUtSsSs4feN
         MnTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755559885; x=1756164685;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QsCtnCoblRs2RCAx3bOgR7IBYOxvM+3Z75U2o+7oIps=;
        b=RlCCSZA9O/poaMaHfJEinjw7oxMSidDfnvciPEIqmkB7RYcm9gcWTYwEKq9/oazU3N
         5rsrnWk1P2fr8ma5u/o9HH7Sc/gu8H2Jz7nNKsaMF8UTr2Y4UBO+aiSYpYypNZTgjXbX
         sNNe+3NM6IsN2VW3qBGKgAfd/VfHUnLjG8WJN+TeRT60w2n6FEX/s+2IoQIyINzVI946
         wrzrwZkYUl9YJ6ttp3v0JzyWry7Ls8x7gEpzzm8SkBsIdRrIMeKrf0+YkNd4hQAVsd/L
         9zf2WY0bKTcW4cddMkTVVUTKDXl0KwCvAY1/N9RSCvyiwAqVUFwMO0coodW/dbqLKU0V
         6Mkg==
X-Gm-Message-State: AOJu0YzcF3CBwQnvxc5rF0AEKvEuLg85hVzurUiZ4ap/2mWIN6Migx2t
	rXOj+GeNciSEtbGfZZTQgHZYd5gzUkNL+6OrSiFd4B6jFxRzR4QAY/SX
X-Gm-Gg: ASbGncvVw2AG0gIF+ffD7e2Z4GngQ36pnykixx1uCJVoVQ6j1gh6UMVcBQff9ZLsGDv
	XOAyyVd0TkKxfYWeekodFp4Ik+Xh22J07pCy2fepKoltJ3hRYTJjfr44CL9ODxQuWQl0sCdUkrQ
	/bzbVoFwwLUJeDU9x3IEoVMTkL2wnxWqa2yeITiD81sTCDeknLsbmWBgS31fRog70A+6BBV7ZkM
	PVH1xJkH5wT7g7GgG/5vtVzJxcKxYDtfJykRyg3HB0uzD5o+K5HU52v9CAQkrcoNJe2oE2NUfkK
	LYfkhaJWHgzVD9oEzil6Xgipi+JoE5lzqfPHDjB+puL8XgORkut91osa3HbS58soOF5CeTHLSIR
	sNXTUc2yVi5WBXgMkjA0qipawd59gH9AM4RvYbfE=
X-Google-Smtp-Source: AGHT+IGw9QNeWOPGbYJ7zM3GJfOiDYH4smz1pkGtJW5rSxlRUrwgv3DIUhg9tCVKvix8SGCghdlOOA==
X-Received: by 2002:a17:90b:4a:b0:321:87fa:e1f1 with SMTP id 98e67ed59e1d1-32476b04bbamr722015a91.22.1755559885069;
        Mon, 18 Aug 2025 16:31:25 -0700 (PDT)
Received: from ?IPv6:2620:10d:c096:14a::8c7? ([2620:10d:c090:600::1:2a59])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-323311677e5sm12459614a91.26.2025.08.18.16.31.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 16:31:24 -0700 (PDT)
Message-ID: <9dc06420f42f7310717dfa5be3c8af56939991c3.camel@gmail.com>
Subject: Re: [PATCH v2 bpf-next] bpf: improve the general precision of
 tnum_mul
From: Eduard Zingerman <eddyz87@gmail.com>
To: Nandakumar Edamana <nandakumar@nandakumar.co.in>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann	 <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>
Date: Mon, 18 Aug 2025 16:31:23 -0700
In-Reply-To: <3b7b2ed1-bce1-49da-b83c-2ca46850062c@nandakumar.co.in>
References: <20250815140510.1287598-1-nandakumar@nandakumar.co.in>
	 <8a7d2401b39257b3dde8cdf67cdb4c382611bfee.camel@gmail.com>
	 <3b7b2ed1-bce1-49da-b83c-2ca46850062c@nandakumar.co.in>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-08-19 at 04:58 +0530, Nandakumar Edamana wrote:
>
> On 19/08/25 04:44, Eduard Zingerman wrote:
>
> >
> > [...]
> >
> >
> > >
> > > @@ -155,6 +163,14 @@ struct tnum tnum_intersect(struct tnum a, struct=
 tnum b)
> > > =C2=A0	return TNUM(v & ~mu, mu);
> > > =C2=A0}
> > >
> > > +struct tnum tnum_union(struct tnum a, struct tnum b)
> > > +{
> > > +	u64 v =3D a.value & b.value;
> > > +	u64 mu =3D (a.value ^ b.value) | a.mask | b.mask;
> > >
> >
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0^^^^^^^^^^^^^^^^^^^
> >
> > Could you please add a comment here, saying something like:
> > "mask also includes any bits that are different between 'a' and 'b'"?
> >
> =C2=A0Thanks for the suggestion. Shall I send it as PATCH v3?

Yes, alongside a simple selftest, please.
Maybe wait a bit more for others to comment.

