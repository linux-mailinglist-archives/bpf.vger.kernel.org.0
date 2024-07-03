Return-Path: <bpf+bounces-33777-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E4909263EF
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2024 16:55:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE24D282FCC
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2024 14:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A9AE17F51E;
	Wed,  3 Jul 2024 14:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="OCsaCSiz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B101317DA03
	for <bpf@vger.kernel.org>; Wed,  3 Jul 2024 14:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720018506; cv=none; b=cAHphYPGziG4pFNURPZayF94SOF9ADaDCwlBywyviQ5Nuc+bhpWt8yEJtImEn3x0xvp1s5bEGGpO7hp6dzfUvYMaUgxVPEvRNK3KHWe+j2dZMdzaJLCjRqONZx+N47YWZ4LY4H9T0UYKd5UOZkUGbWxmGZoKkpk4a364woH+U0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720018506; c=relaxed/simple;
	bh=5L8z/sb3dJfBJ2NzPsTGv1Wac4OQs83G4KhRGhXEd24=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g+g0+3q41FaYvN0Gdj1YVCgAgu+1om+FdricA2eP11GZSeI8vCsmx+Uy8+175WhHlct1igUIIZ75qcpm2fOLNpqmlWgQDjeocX0VpLV6ogScaU8o7Xy6j7lA/wtNmzWOEUWyjce9r1CsVsMIBF9jKZ/yhlDqq4fG4ue+tMI6om8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=OCsaCSiz; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e036d1ce4f7so663790276.0
        for <bpf@vger.kernel.org>; Wed, 03 Jul 2024 07:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1720018504; x=1720623304; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5L8z/sb3dJfBJ2NzPsTGv1Wac4OQs83G4KhRGhXEd24=;
        b=OCsaCSiz4D1Ik66LBtxvko3yf7DrPcnVmBLkeoco3UCSZh6dAkXKd5k8G6qhAjnpZu
         myo87+fYI7//88Ar4uy1v5isc0uOxWmovaugU6Z8I8e4XVp6So/nglamHkYQUfMoTz10
         C7O2cl3XEC9SPV36xOG34/ebc/1z1vsSMAJQvlA3bVGlAzqcXVUZeYY+fime2+0JvTzx
         EsP7eSGidyTJgp9zd8XuUfYKR4/2K1lV3KQX7CHoZMCZTmb3ouGEIAWbyeBqQ3Eeh9nz
         RaLpwOHjvJEZxqGn/z6OsG/Lbr1G3k0P+A62IPe5z8rPhgN7npEikN9qH8BeJ+L+pmk+
         6XDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720018504; x=1720623304;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5L8z/sb3dJfBJ2NzPsTGv1Wac4OQs83G4KhRGhXEd24=;
        b=YKorrg+FqcO5WXnKpuxWntyBs7djBG55uNdI21A5X1FtvmwQ1FJ8fJvDLJpKwBgIj8
         q9LY6Bwf7DIYLKyMReQ8ErpkgrOkkF1pu1YuOjm5frZuBRLfYKxHpEVFEuWMP/uVFjy9
         J/OKtGpMqBmHDGTQErGe8R7Ea1wTFIwBasyFesuG+M/FQ5DP+cal7GGp7l7jOqeH3RA9
         bCydpJG+stGQUfJYUsJrCjiWHPPVfcJECmbRBMrwwO9Z5mkKK47kvovQ0dTv7s6dYwFJ
         Yd8nEQnZXcW1lFs6u9R97l/CYdTMkSpn/mSOYoMSloNkP5r2Z/0chaAxS3nJfB+DJFN6
         P3bQ==
X-Forwarded-Encrypted: i=1; AJvYcCX86WmZSP5zcXZIZfccBrkkoqDrsikK1snmMYB8hy44yLbhbIpc5qe0dt1uYk9k7NyAMgnoajTK+KRv4/nOW4UmCiHJ
X-Gm-Message-State: AOJu0YzL1de4V22iolmU0qqe8UZbxb3z2RRe5X/ei0+fjNYVX4VvzeIL
	BJDSgWM66jmZTQ+/tCfyzHM+Z7IP26NRbqbLnbmQs5OuMwXSHUJSyZA3JPswbVbDLp/fXttww0u
	EpRgweSBl97yB1QhpH1zGCTozIn0g5MTHQuvY
X-Google-Smtp-Source: AGHT+IG6kF95qc2PPcOH4Zj5Qhp/bKkLPuBZZW/n3lb6eoXrdAw6TKe1QICXMqSaa9Tq8kGQ1JWZCMAXsRwfBXLzU+U=
X-Received: by 2002:a25:d08d:0:b0:e03:a382:f1 with SMTP id 3f1490d57ef6-e03ad7f365fmr1319009276.11.1720018503710;
 Wed, 03 Jul 2024 07:55:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240629084331.3807368-1-kpsingh@kernel.org> <20240629084331.3807368-3-kpsingh@kernel.org>
 <87zfqyq07z.fsf@prevas.dk> <F537442F-C6B5-48E7-8492-569D5C3D8B83@kernel.org>
In-Reply-To: <F537442F-C6B5-48E7-8492-569D5C3D8B83@kernel.org>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 3 Jul 2024 10:54:52 -0400
Message-ID: <CAHC9VhQGBuYz9pkVxUrXTgcNab-rh62M-Z727JKONrRy7T+_dA@mail.gmail.com>
Subject: Re: [PATCH v13 2/5] security: Count the LSMs enabled at compile time
To: KP Singh <kpsingh@kernel.org>
Cc: Rasmus Villemoes <rasmus.villemoes@prevas.dk>, linux-security-module@vger.kernel.org, 
	bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Casey Schaufler <casey@schaufler-ca.com>, andrii@kernel.org, keescook@chromium.org, 
	daniel@iogearbox.net, renauld@google.com, revest@chromium.org, 
	song@kernel.org, Kui-Feng Lee <sinquersw@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 3, 2024 at 9:12=E2=80=AFAM KP Singh <kpsingh@kernel.org> wrote:
> > On 3 Jul 2024, at 11:44, Rasmus Villemoes <rasmus.villemoes@prevas.dk> =
wrote:
> > KP Singh <kpsingh@kernel.org> writes:
> >
> >> These macros are a clever trick to determine a count of the number of
> >> LSMs that are enabled in the config to ascertain the maximum number of
> >> static calls that need to be configured per LSM hook.

...

> > Instead of all this trickery with defining temporary, never used again,
> > macros expanding to something with trailing comma or not, what about
> > this simpler (at least in terms of LOC, but IMO also readability)
> > approach:

...

> I actually prefer the version we have now from a readability perspective,=
 it makes it more explicit (the check about the CONFIG_* being enabled and =
counting them). let's keep this as an incremental change that you can propo=
se :) once the patches are merged.

I prefer the original approach by KP as well, let's leave it as-is.
IMO, it's far from the worst of the macro shenanigans in this patchset
(or existing LSM code for that matter).

--=20
paul-moore.com

