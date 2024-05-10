Return-Path: <bpf+bounces-29549-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A3808C2C70
	for <lists+bpf@lfdr.de>; Sat, 11 May 2024 00:08:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7BC5DB20977
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 22:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40DD713CFB5;
	Fri, 10 May 2024 22:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R4IZR4DK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 766DC13CFA3
	for <bpf@vger.kernel.org>; Fri, 10 May 2024 22:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715378898; cv=none; b=AhS37QoIu9RGCecrunSBzJkS6A/not0GE430vwPQE2ACGPju5p5UML8wZ1aDhHNseFYYAdiSdDfTzDy9kIKsHQhb2P6n+t0tMKN6Wh1MlFtNNWywWtWgXZ5yoQzUaxD1bAeLCMSetRCnnmKa4qxbewE4sEkXIl/UU2W8jDf4jQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715378898; c=relaxed/simple;
	bh=fjW6oxc88WRoz/BjQ41bVNGpxXAwYoOECIm6E+NxdME=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=u/SQxMkTNPefoiWv958OVObGsWI5Z2KIRsZ8NGDJZk7t/bb6gZA6p5fv+TYVKr3hZLRWY5i3BoJzWMTNHYLQCcTrD0uFKUbp7aqSwrIIxn+qsS2tPGF51ArZPD+4MekYpLSjeK6V/r6W3O6njNEw6MXTKCuiDy8uiqzhs+KI/3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R4IZR4DK; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6f4e59081e6so784727b3a.3
        for <bpf@vger.kernel.org>; Fri, 10 May 2024 15:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715378897; x=1715983697; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zppurhRsYA/OAqCNTXyic2tfejepzbqSWOnuoq/TwWw=;
        b=R4IZR4DKJ3q9nO+qqGbqpp3xBjoFeZj18DRZEbkLwylvIU4ymCWMuCT3wuVbrWgcHe
         4ITdlShPJZwsT0lrvR9PMDyhf7HLRDjYoK8FR3zTvFt/psgSF8LR9GpHZWZXrYTSPhlg
         +hc+w4Xuwbz1m0mEyKX6j2wx32exOl5008H3dR0LFnPJ8w8WP0edWGBHds9x8lWV0jnb
         8gPVWpxtmQCVq7UpddQn5+OzqcJ9iYqQhsaBXPaXhhRlKiw2N9dGqlSLiVxpXdmIUj6Z
         EDf4sG8W0cKsDGoJ40VTkCywLflHOO9FOeyor6SayFfaD0vUW6Phy4923WVkUAM7MZv0
         qiow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715378897; x=1715983697;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zppurhRsYA/OAqCNTXyic2tfejepzbqSWOnuoq/TwWw=;
        b=g8PJ/uLir/FzPhTeS7hiU0fMJnejxRdQ4kbgT7JvAB5p//gX7DNmP0IKndt0LokojT
         FzLyjCGJgRwCZxdDF78NuvseHip+jEN/3wlblkraoFgskmG59xvl4xaB6fBMRmIfTPEC
         a5esZ4FLncRRxdqtka+bcPipwKCMqqL71GFNnFceiEp1A1PCjPJG+NDAYD1hH6na/X//
         UTCKvL1Bbs7spcM4Kg2UV1lXa3sETxNFEGaV9EbxBkCyq/pHUtC9ZjupqJbkNOVtA6kc
         55YnKmZXfkw8GToEz8K1ZDwh2gqx7DkQHSLlMChacaysYDatK3btC96y3ev+EE/M1+Vj
         /whQ==
X-Forwarded-Encrypted: i=1; AJvYcCWfgAQJl8q0yc/Hy6mW/cBvXlbnFGk32RUd/GLU53cl9Yim6E8Tu5sAUTcuuXvSgORzc/c7sOEGNryydIvcuxL2Fvol
X-Gm-Message-State: AOJu0Yykl21gWtgzudvUdGv4KfxHP3fhzQIKmEzoPB1cW/EpDIuoX1os
	RqkyzBjj4cnW0H4GrXDxac78XOJvP3Io8JPaC4sUYCtxARdmkQfn
X-Google-Smtp-Source: AGHT+IH1JjojdwahWDX9IDZKMNbaqhkzOu7mbENHFsDkZkLEMjKhEpdl6dZAvKcr94x6vZqCiWaWNQ==
X-Received: by 2002:a05:6a20:9f0b:b0:1af:df89:4e6a with SMTP id adf61e73a8af0-1afdf895185mr3517005637.51.1715378896779;
        Fri, 10 May 2024 15:08:16 -0700 (PDT)
Received: from ?IPv6:2604:3d08:6979:1160::3424? ([2604:3d08:6979:1160::3424])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2b301d3sm3393385b3a.205.2024.05.10.15.08.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 15:08:16 -0700 (PDT)
Message-ID: <62a51fcaddbf5eb8552a96e6a24ded83f8f9fa49.camel@gmail.com>
Subject: Re: [PATCH bpf-next v5 7/9] selftests/bpf: Test kptr arrays and
 kptrs in nested struct fields.
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kui-Feng Lee <sinquersw@gmail.com>, Kui-Feng Lee <thinker.li@gmail.com>,
  bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev,
 song@kernel.org,  kernel-team@meta.com, andrii@kernel.org
Cc: kuifeng@meta.com
Date: Fri, 10 May 2024 15:08:15 -0700
In-Reply-To: <d2b9a943-ca26-404d-899a-c7651ce18a42@gmail.com>
References: <20240510011312.1488046-1-thinker.li@gmail.com>
	 <20240510011312.1488046-8-thinker.li@gmail.com>
	 <d8f2fa21a9af5bfcb2acb1addecea435285c40e6.camel@gmail.com>
	 <d2b9a943-ca26-404d-899a-c7651ce18a42@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-05-10 at 14:59 -0700, Kui-Feng Lee wrote:
>=20
> For the sake of completeness, would it be possible to create a test
> > case where there are several struct arrays following each other?
> > E.g. as below:
> >=20
> > struct foo {
> >    ... __kptr *a;
> >    ... __kptr *b;
> > }
> >=20
> > struct bar {
> >    ... __kptr *c;
> > }
> >=20
> > struct {
> >    struct foo foos[3];
> >    struct bar bars[2];
> > }
> >=20
> > Just to check that offset is propagated correctly.
>=20
> Sure!

Great, thank you

> > Also, in the tests below you check that a pointer to some object could
> > be put into an array at different indexes. Tbh, I find it not very
> > interesting if we want to check that offsets are correct.
> > Would it be possible to create an array of object kptrs,
> > put specific references at specific indexes and somehow check which
> > object ended up where? (not necessarily 'bpf_cpumask').
>=20
> Do you mean checking index in the way like the following code?
>=20
>   if (array[0] !=3D ref0 || array[1] !=3D ref1 || array[2] !=3D ref2 ....=
)
>     return err;

Probably, but I'd need your help here.
There goal is to verify that offsets of __kptr's in the 'info' array
had been set correctly. Where is this information is used later on?
E.g. I'd like to trigger some action that "touches" __kptr at index N
and verify that all others had not been "touched".
But this "touch" action has to use offset stored in the 'info'.

[...]

