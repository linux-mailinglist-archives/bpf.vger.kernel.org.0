Return-Path: <bpf+bounces-45800-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7CBB9DB1A9
	for <lists+bpf@lfdr.de>; Thu, 28 Nov 2024 04:03:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46951B21D30
	for <lists+bpf@lfdr.de>; Thu, 28 Nov 2024 03:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01B508289A;
	Thu, 28 Nov 2024 03:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ks8Ossef"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3830D4F21D
	for <bpf@vger.kernel.org>; Thu, 28 Nov 2024 03:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732763031; cv=none; b=gR4miuPPpiHoTqP4cfkEbLoLxYaSQQdd2I6HUqunCV60waKFWTacMtvQMdc0uI5X7nA0zDCyEFEekZvk1ecE/USE1SIPcjBwhIP3Mi2veVCVkQQluWh0QsPLwJQDctdtawf+GIX2qNLaJM1T6oJUVhygK/XjKrcLlhFBj1PveP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732763031; c=relaxed/simple;
	bh=5TF2Fn4X4X/upV+WaXolPRvnICBchhqljxQbzyr5Adw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=R3w12RHUJ77V6eK6cweeM4g4yrx+GAcpK1CBo8RUJT8+v2fBMkojUuVueJToM+d6w3StArd7GWE3nRb56b7U4bq8vXYWhTC5/+B+V7V1UXcMfc0KCzudZpVDdDn2fdWbcH6TuZ4WNH0v0g9WrePy1mMKBTqNIDHBgqnZOQBfba0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ks8Ossef; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7fc41dab8e3so217183a12.3
        for <bpf@vger.kernel.org>; Wed, 27 Nov 2024 19:03:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732763029; x=1733367829; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8VBeDhqUhEHJ7OIYNelLGKh2pnhYPxUtvNBCJTyNGx4=;
        b=Ks8Ossef5MJ61s9LNGZD+jtA2J317gTGoSIxa0BBh1SoniWBBF3LFZvCxseHDoOZ96
         w9IgxbJxKBekMLiPMTPR+IVA4L+ktjyaCs4U2SpC0anih/pGXbBunKnPxx+l3/kIMGql
         U9b7xoQX2ibxD9BaHCGVRKhEVpioXWwRfedI+uhGQtY+eURPtt/6OKMd5G660owexgL7
         Atf97NGY3OhzXxtlAopSVtr38697bCAVYwqXXTjgGZwhOSE1Gk5yTvW6ixvfVulCnhPP
         JWFKawVp2zrZnAvL9MR4AwSkIZuiurw0b4Z64NLw/eG4/oqUNyhrMzjErDtSQd8eEMd3
         Q+yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732763029; x=1733367829;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8VBeDhqUhEHJ7OIYNelLGKh2pnhYPxUtvNBCJTyNGx4=;
        b=Jx0smmwYQGTTfmYwgEHi2Grx7sy8RBQKA2iekWmf5CKe1OiniV3hQWvqu9rwipaK33
         GDKuG2aRsaaMfbvrmi/BImZ0h07+fHk2IXdbcPdCknB+tb8zJCO0I78ux+K3fk/yfXNh
         5Dhoe+9CqYffSQ/EIUM+g877wpCn7d4ND99756vv3Zx35jsuB4HGT2eYsoyCh0ub/XT9
         24o/qHqbIN6EucmJaxVbeCHmpqYr/x9ucg1PU1bv/BmJq4lqwIVCCeajQqB1zOJXXEpI
         0i9YhWLI3gEfa+y4drINB8TGxOjuKaXm6oEZ6/BrmUbyFJH/c4Hx3yQh9ZCht4W38CM9
         Nggw==
X-Gm-Message-State: AOJu0Yz0QYU/uw/g02CfaarWs+1t09AWvzpKu2d3PdrekYcC8mSMhFPF
	wBciDBwgcYvm9ZUHo+NdqTxAfi0/PtW+35MtpipeozPRk1m3qHKY
X-Gm-Gg: ASbGncs7djERgWDK6L7655qh7SA4nLB5l9ldEQVQwdTa6nk/DelwpxhnjS6cIf7MZKS
	R8QlyFh3hV0b+TgfAmFyMVneq1tfldsyBl8hV+cYqZL6n+rRVjuRRNl0xFSx/c4yV/MIxGpIY0I
	cXsuHjUHwgvHHKxJUvz+L7uStJYqDUviX0cQI6aq2xc82/rJuTsvKD2NizpzMSXDMEUNLtUm/Vl
	DHy1MUg2rtQADE83QOxonjem/o51wbwB3RdHL/kX23FAeM=
X-Google-Smtp-Source: AGHT+IGgjSq3ApoYmB7OGM5YUkmYaY/TNcMr/9K/TsqARCX6gmsh/ZzEayh0+1uvCsouNq/A38qymA==
X-Received: by 2002:a05:6a20:a10a:b0:1d9:2b12:4165 with SMTP id adf61e73a8af0-1e0e0ac35d1mr7823378637.13.1732763029338;
        Wed, 27 Nov 2024 19:03:49 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72541849bfasm330506b3a.195.2024.11.27.19.03.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 19:03:48 -0800 (PST)
Message-ID: <3cc26b1923426203b3d0df91ebb1638c0e492696.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 1/7] bpf: Consolidate locks and reference
 state in verifier state
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, kkd@meta.com, Alexei Starovoitov <ast@kernel.org>, 
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Martin KaFai Lau	 <martin.lau@kernel.org>,
 kernel-team@fb.com
Date: Wed, 27 Nov 2024 19:03:44 -0800
In-Reply-To: <CAP01T77t=FmvzyeCJ_3Bp+8D0-Z4GGUHNeGbNBmSY6xFXi-ZgA@mail.gmail.com>
References: <20241127165846.2001009-1-memxor@gmail.com>
	 <20241127165846.2001009-2-memxor@gmail.com>
	 <a4690c29ca3b5f34945cd507def7e0c6ecdec9e1.camel@gmail.com>
	 <CAP01T77t=FmvzyeCJ_3Bp+8D0-Z4GGUHNeGbNBmSY6xFXi-ZgA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.1 (3.54.1-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-11-28 at 03:54 +0100, Kumar Kartikeya Dwivedi wrote:

[...]

> > > --- a/kernel/bpf/log.c
> > > +++ b/kernel/bpf/log.c
> > > @@ -756,6 +756,7 @@ static void print_reg_state(struct bpf_verifier_e=
nv *env,
> > >  void print_verifier_state(struct bpf_verifier_env *env, const struct=
 bpf_func_state *state,
> > >                         bool print_all)
> > >  {
> > > +     struct bpf_verifier_state *vstate =3D env->cur_state;
> >=20
> > This is not always true.
> > For example, __mark_chain_precision does 'print_verifier_state(env, fun=
c, true)'
> > for func obtained as 'func =3D st->frame[fr];' where 'st' iterates over=
 parents
> > of env->cur_state.
>=20
> Looking through the code, I'm thinking the only proper fix is
> explicitly passing in the verifier state, I was hoping there would be
> a link from func_state -> verifier_state but it is not the case.
> Regardless, explicitly passing in the verifier state is probably cleaner.=
 WDYT?

Seems like it is (I'd also pass the frame number, instead of function
state pointer, just to make it clear where the function state comes from,
but feel free to ignore this suggestion).

[...]


