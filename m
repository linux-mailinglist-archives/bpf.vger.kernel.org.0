Return-Path: <bpf+bounces-35119-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4078B937CD2
	for <lists+bpf@lfdr.de>; Fri, 19 Jul 2024 21:04:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB28CB21686
	for <lists+bpf@lfdr.de>; Fri, 19 Jul 2024 19:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9E2B148307;
	Fri, 19 Jul 2024 19:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="sCBrLYmt"
X-Original-To: bpf@vger.kernel.org
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D3181482F6
	for <bpf@vger.kernel.org>; Fri, 19 Jul 2024 19:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721415843; cv=none; b=pvuce8CaAEPsDvJwOWT6SxDGQAad6MtPOG0a6T9+yGMmrjYjWeCea3lGIvUy/VoGchsjmE/NlgpXmjPYq74CC9bVpDxmnzST9DC1vGtCTraFP3LZHvWq8hifV2lQeSarb3+Nc1KXj1Tjay58Ofgw7BrIUQVKWP5+kbsAGXgzMyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721415843; c=relaxed/simple;
	bh=A0iviUX8wOJ//+uxeua2jgpbKy1hwpWKHJopxNAqOAw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=di3zeSzrszqWNUlK/tsRpshbpaJ/FcJRZns5LohfikpNvNEyqyF+w+lHxZijy8PrD3ijDzI29bzbCv1Ho3ZdzU7rtw1D/E9RIwBJJEmYsHABbgytQfSgepgdkiPYhH1rYyTKOGoMPgEHBXovGhFw85HMTSoy30mI3d4AOeUjyCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=sCBrLYmt; arc=none smtp.client-ip=185.70.40.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1721415833; x=1721675033;
	bh=A0iviUX8wOJ//+uxeua2jgpbKy1hwpWKHJopxNAqOAw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=sCBrLYmt7rMYj+eeltba/Okq5hM9fro0NWApfF3vwwb2JbcV5eHVcmQUP3mgycdB5
	 ey/awx4kt7Suf2n0UNEkpWJnbr5iksDJrbUGZsKklNvIy2obSqzot9A6ILhJVN7r4q
	 6SxcuUxKfs2jqDYKaiwSBjGhgjjYA/FxHATJrkorrnIuWCfaWUi4X6Tj9hzMQyfbJr
	 sZh2f4xoB+IWiUN2tySBwN7jBu2k7vkqqqXzC+9sSh3iUA9Cu+hDT0zLzOo7e3pQte
	 h6r4BVdXLHg3oEjgxmpw3jJf8nPNu3bzI3PSz+UznilXGVP9ZmgXOcZ0jLusaOZDu8
	 R3dV2Aaf/NFYA==
Date: Fri, 19 Jul 2024 19:03:40 +0000
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
From: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: "bpf@vger.kernel.org" <bpf@vger.kernel.org>, "ast@kernel.org" <ast@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>, "mykolal@fb.com" <mykolal@fb.com>
Subject: Re: [PATCH bpf-next v4] selftests/bpf: use auto-dependencies for test objects
Message-ID: <RkdrrY1xtGQ9wWBvvt9VcpYD9yNVpWy3mkNZKOOKeD4YOFFgHwlJ0Hr_dTKJf629h3rajxYch9Dy0TXJCPOKeGLIEWdKOeH5hvie7HFlnhk=@pm.me>
In-Reply-To: <CAEf4BzYX=sfVGcEYq=KSmnC28cqUsRpN=fCwRuUpOMrYAfzzHg@mail.gmail.com>
References: <VJihUTnvtwEgv_mOnpfy7EgD9D2MPNoHO-MlANeLIzLJPGhDeyOuGKIYyKgk0O6KPjfM-MuhtvPwZcngN8WFqbTnTRyCSMc2aMZ1ODm1T_g=@pm.me> <CAEf4BzYX=sfVGcEYq=KSmnC28cqUsRpN=fCwRuUpOMrYAfzzHg@mail.gmail.com>
Feedback-ID: 27520582:user:proton
X-Pm-Message-ID: 6b6eb047af04aad754970a819b2139190f18e373
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Friday, July 19th, 2024 at 11:18 AM, Andrii Nakryiko <andrii.nakryiko@gm=
ail.com> wrote:

[...]

> Note [test_maps] for all three variants (I expected
> test_maps/test_progs + no_alu32 + cpuv4, just like we see for skel.h).
> Can you please double check what's going on? Looking at timestamps it
> seems like they are actually regenerated, though.

Yeah, this is weird. Will look into it.


> BTW, if you get a chance, see if you can avoid unnecessary EXT-COPY as
> well (probably a bit smarter rule dependency should be set up, e.g.,
> phony target that then depends on actual files or something like
> that).
>=20
> Regardless, this is a massive improvement and seems to work correctly,
> so I've applied this and will wait for follow ups. Thanks a lot!

You're welcome! Happy to see my first patch accepted!

>=20
> BTW, are you planning to look into vmlinux.h optimization as well?

Yes, it seems there is more room for improvements.

I think making changes like this patch is a great way to get familiar
with the codebase, which is what I'm trying to do. Even better if the
changes are actually useful :)




