Return-Path: <bpf+bounces-50591-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BB398A29E85
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 02:46:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6BA41888F25
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 01:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EFB53FB9C;
	Thu,  6 Feb 2025 01:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KEWRZYBN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3C92AF1D
	for <bpf@vger.kernel.org>; Thu,  6 Feb 2025 01:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738806412; cv=none; b=hgENW7Eli/I81G06eCXPzt6E3/MLlM7Zpglps0vf8QfWHm1eDCPwO/xnN/Dm4L4qhI4yjaDos+dx9LkpsXTDg5GKbhuBZvrVHE9sr9p0CMLigexM1ClBA+APPV2QitvXaKdre9RoJHUgWsowOfONmW3R23MqWwR9q1KQ0kZJBiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738806412; c=relaxed/simple;
	bh=D49LMbK3eVOyfTjk0GqUGKBFxK+O5E1JiASMi0bieos=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W9UsyFLNjseRul3+xb0Di79AZETPkNOrk6gfNJ8snSbSwGq2Wq6UciUCZEJOf4pK0yJcriM0/HJUn36OD+2KGC29QVIKA59DQunc3RQsGRL5K9TBbIORLqAiRRgD5ffyHUgfyoApmY1yHB38dikcXEfO6Bzfj5NqzJ+MqOEm2jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KEWRZYBN; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2f9c69aefdbso638573a91.2
        for <bpf@vger.kernel.org>; Wed, 05 Feb 2025 17:46:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738806410; x=1739411210; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NH02/cgp/XiQoNpa0b8j7TFZPg0Z6/fl1E9oENiAsKE=;
        b=KEWRZYBNj1qEie9hdOKfTwoO/BKhLv9BmU/BxjvWPFvLErXYk74RAb16+HopWDx0nd
         MbrBoSGw0cSmhrZ0D5p714Uhw+SpKoe3W9mPeLbuhD9PDROxeqbWHCx/YzrY5RTkE5x3
         wxqYcHQQ5r+KPgVIlqeZ5d9s2Pyzqous4N8CvSPZHcakkSW7xTDT7WhZ6hpu6SI4+wTM
         1/YyIBO3ciJq9/ssYpcJM8RNQtdYftV9fve/TJzJ6wiF4kI8YE1hRpTUYhBcfdXw9LSA
         5whDjRRRX4ZUsVNFRP25ERmvFBed9ey1TL8vdRW94G79PSgO3DkloWbOEdYSNV4u04YV
         fbdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738806411; x=1739411211;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NH02/cgp/XiQoNpa0b8j7TFZPg0Z6/fl1E9oENiAsKE=;
        b=U82A4V+t73lzsZDMCqzoMCOHKlWYO2sgauUWcm1fSNEvUhCcqkFE7XSbEHl4p3/ZCO
         vtE1+WvSVVaY5MpLoeGyutua11pES4/gmfwCcRbD8UuTGupVR3Oo3OFB7ZhzTSDftNJQ
         8oELmnwjRhob+HLqOpju38Fx4bHETwQOMbxoe5u9b+qtWaHv4+UUO9EvFm56ayGZkEJJ
         RgDdSoy6QGid+nI4Z4CgcbvoOzAeE/EhjhDQJoFeagWG4E+hv9zDBCiYMkfA+S8TJ0Sf
         3d34MO6CMbre17uu0Ddsf/HjQZfe6FDI2jpLu+MVfKiQDLgXGGaL3AnVg7vK1Xbe4jWa
         WiKQ==
X-Forwarded-Encrypted: i=1; AJvYcCWa0Lsd5Vsg7mDRKzJnACyC55cTQ/oFKCj60k1AsatWw3Y/1at33YysJ/O5eDv55JoQEWY=@vger.kernel.org
X-Gm-Message-State: AOJu0YweleKOfTKGA7RRN+skpo5i+O0vtFdCnuZ5Bk6S8HlYloqW7pYB
	jJx37TZFGr9jEG7uKPqVdJs26U8j8HoNMSDPp/ytAwsmgNBa34/UbyjIk5IsCXlyTg4IrvTjMkn
	47HWRt8aipjIx1Yoy5TYoodHHvHQ=
X-Gm-Gg: ASbGncsNhAcGfKMYsjN0Y41s7dy2FD0u3ckw5mwFWVrD82umYm1+42HvnU+Krb4M0O9
	5YhWJP2q9KYx6y7u6NMHh7D1bP1WJaMOXb+Poe8b8qtbvC4u53p7ZkeL+jlw/s8Rz1dRKa4lj6X
	zpGdvK/7VPPHPX
X-Google-Smtp-Source: AGHT+IH34TMYzG0tcNXOtqtfutMjoPc26IQMKqxo5DL8oFST7jDsfwTr8izGJV6ZSqE98hu/kEKGzjN6zV/WHAU4bME=
X-Received: by 2002:a05:6a00:1306:b0:72f:f872:30a7 with SMTP id
 d2e1a72fcca58-73035127555mr6876710b3a.6.1738806410653; Wed, 05 Feb 2025
 17:46:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250203164002.128321-1-mykyta.yatsenko5@gmail.com>
 <CAEf4BzayxsGSj5n3A6HAYgg3QC5xFvNcXrCHgLCqiWMj=0EP6w@mail.gmail.com> <304d5081ef18c3d933d5d0bb79579922d74437a0.camel@gmail.com>
In-Reply-To: <304d5081ef18c3d933d5d0bb79579922d74437a0.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 5 Feb 2025 17:46:36 -0800
X-Gm-Features: AWEUYZkR6NiuEFRXMuC7_6PSsr-F8kMEdEgNbrGsGY4RO-EhSZ4fIZn5jQKvVaY
Message-ID: <CAEf4BzZ9fsstQFo_1exSvWgpD8iJ+4fvQrZN_RiBOYNngStwkA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: implement setting global
 variables in veristat
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org, ast@kernel.org, 
	andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 5, 2025 at 5:29=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> On Wed, 2025-02-05 at 17:06 -0800, Andrii Nakryiko wrote:
>
> [...]
>
> > but main point from me here would be to avoid parsing multiple values,
> > it's better to allow repeated -G uses and treat each value as strictly
> > single variable initialization. So instead of:
> >
> > ./veristat wq.bpf.o  --set-global-vars "a =3D 0; b =3D 1; c =3D 2; d =
=3D 3;"
> >
> > we'll have:
> >
> > ./veristat wq.bpf.o  -G "a =3D 0" -G "b =3D 1" -G "c =3D 2" -G "d =3D 3=
"
> >
> > A touch more verbose for many variables, but not significantly so. On
> > the other hand, less parsing, and less arbitrary choices of what
> > separator (;) to use. WDYT?
> >
> > pw-bot: cr
>
> In a sibling thread I asked about '-g @file' support, allowing to list
> variables in files. This could be worked around as $(cat file) in
> the command line, of course.

What I proposed doesn't interfere with this, it actually helps with
it: each line is treated as a separate `-G <line>` invocation, and
each line initializes a single variable.

>
> [...]
>

