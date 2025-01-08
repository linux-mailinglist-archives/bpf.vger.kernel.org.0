Return-Path: <bpf+bounces-48303-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AEC7A06694
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2025 21:45:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B0947A38F7
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2025 20:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81B54202F96;
	Wed,  8 Jan 2025 20:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="XIc87G63"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36BAA1FBC99
	for <bpf@vger.kernel.org>; Wed,  8 Jan 2025 20:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736369063; cv=none; b=S1JwFsl3y66wN+qZEfnt9mWpRyDxfZmTMjH0PLNAek4NUfCpJYUk1kNMjhZH7AQp0YJh5hH3Ocy2DrPnzV2YSAcrVcPxR7HZaxJ5KhEKBE6WMWihHoXxOSbPYPHzZqo+J/hvPlGmPDcAi+H/YB7cQiA103MRHAJBO0Td4IpLeL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736369063; c=relaxed/simple;
	bh=WZNXn65RrvToDst6E7iPKL0TSMeYHkCA20MXD0CK+O4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=hoVNh0Um/f2p+Kz0NT3nYXEjFWe92QcEtcHi8cUhr9GexUkfcKgGbZNpq6KLsRwjlhRh+oQTjREUDKRXUNPbkP+OZFGQxL7XCBjQCRFZF0atcZG5OWZc67SyaCw2vVtOUGPyr5B4Z9xdL7QKN5pETclaJp/4Q1yUcBQ0wcsKQQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=XIc87G63; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4361e89b6daso2017345e9.3
        for <bpf@vger.kernel.org>; Wed, 08 Jan 2025 12:44:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1736369059; x=1736973859; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iV0UP4J5tiuBeEXaFc60UnGKplHHrVwPzRvXkUeFMcE=;
        b=XIc87G63eqeOsEQkBtj3kkeHXKDFlvjBQgXwuZtxG1X0JKTVzQuWQx1vyZhGOclmTY
         bv56kbUFTTtn7zpQ3kwrgyKxOK6YuC59GGyz5Z1f0HavPOFQVxoSaUVl/tDmmVDNuopP
         127Fr3gkFFa1UBUN7RZj7otGGcG7Z/0YOdPvcxLEdUnlBoX9H0rjNgIfBfeCqume/6BY
         n1q7noGR05nCCI/75SRfncmDZcJL1bK3bEbmsK5CCuUuNOhgtgoBHn4TruCrRjeLx7Aa
         5fmBzb+OFjw4PDEF7boqCBowZFePEp7k7MxP4cxmokUFCSZSMtAiNAqaHcNgNrUC3927
         0DiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736369059; x=1736973859;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iV0UP4J5tiuBeEXaFc60UnGKplHHrVwPzRvXkUeFMcE=;
        b=MVAZqiG25hlHyN22XfvvxjqegUW+rLx1BK3RV/qI9xgEO5eUJP4ThXnDL4dqV99362
         iugOCUTH5MBjXulSO17bovMPQQtwnCApCH0/stBj6g+gwONUM5RMwO4ho6bnPoqnMxrh
         DDCHWX0ZzTAoX/+Ob/KgDvp1Ey9/PWuR5SFAmVDr1+zEOQah8gDbDH0+Id70EprCILSZ
         TROShZJ9alLXISPc+3Ae71yfmoJ3t0es9sSzbrIfIBWJhSkX0eHouZVYgFBofemMRQv3
         x86HN+VVAs/fiq2Gkb1+vxNfCMO2enbBzCsHXNreWqP9lPdiX/i5gq78DvPqc0C5/ySs
         sMIw==
X-Forwarded-Encrypted: i=1; AJvYcCX2kdcSghTqR1RiPdCdlI6ULUzlpb49pclQhfGwb0VcFcf0HQ/bF3OT5uLrpIQwUcDPG0s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBHmzehchIYVwLC59aX9C3inQMCfdqv8MTxEZsNx4h8iaXaoKn
	vLbyy63PBOe6dOuLmAH9ynKUZtORe2NtsyZv6gGyT7pIahB4YOoxj3vFWcr6JsA=
X-Gm-Gg: ASbGncvDRk5XWNLSjn/e0lwKnAxfV3jYwIdu4d6qCL5FC4Nn12uf5VkDhZ5ow3qwRwz
	Q6IeJwkaA75dk5rTyizjWknGFCdi5tS7QhEqEfXs/xPBVpjf0R6+qRTOzT3kXFiIId8JbNcapLC
	Ao/gRPI8sPgy/1En6zqHLpS7cNCi4PZ+x/m7LhEU//wGX6jkzfNVXEScpikYJBupwKKDNstH92l
	2fjUK0kwiijHvHqHEkKzoJQLsAC9A5loxHmBBVMhVrA
X-Google-Smtp-Source: AGHT+IHr2ztjtCiRPpm7z7td/YEuawf0dqqam+iGmjOaAVp9jwzoHyT8LA/Z8tyGIcciieSGjNo/lg==
X-Received: by 2002:a05:6000:1fa1:b0:385:ed20:3be2 with SMTP id ffacd0b85a97d-38a87355790mr3455641f8f.48.1736369059346;
        Wed, 08 Jan 2025 12:44:19 -0800 (PST)
Received: from localhost ([2a09:bac5:3213:16a0::241:2f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1fa2bdfbsm53005823f8f.102.2025.01.08.12.44.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jan 2025 12:44:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 08 Jan 2025 21:44:17 +0100
Message-Id: <D6WZGKVYV3G4.3P0J28SSHSHOI@cloudflare.com>
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "John Fastabend" <john.fastabend@gmail.com>,
 "Andrii Nakryiko" <andrii@kernel.org>, "Martin KaFai Lau"
 <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>, "Yonghong Song"
 <yonghong.song@linux.dev>, "KP Singh" <kpsingh@kernel.org>, "Stanislav
 Fomichev" <sdf@fomichev.me>, "Hao Luo" <haoluo@google.com>, "Jiri Olsa"
 <jolsa@kernel.org>, <kernel-team@cloudflare.com>
Subject: Re: [PATCH bpf v3 1/2] bpf: Account for early exit of
 bpf_tail_call() and LD_ABS
From: "Arthur Fabre" <afabre@cloudflare.com>
To: "Eduard Zingerman" <eddyz87@gmail.com>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.17.0
References: <20250106171709.2832649-1-afabre@cloudflare.com>
 <20250106171709.2832649-2-afabre@cloudflare.com>
 <3f08fa54c29d5716982194801bfdae93c15a8c27.camel@gmail.com>
In-Reply-To: <3f08fa54c29d5716982194801bfdae93c15a8c27.camel@gmail.com>

On Mon Jan 6, 2025 at 9:31 PM CET, Eduard Zingerman wrote:
> On Mon, 2025-01-06 at 18:15 +0100, Arthur Fabre wrote:
[...]

> This patch is correct as far as I can tell.
>
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>

Thanks for the review!

> [...]
>
> > @@ -18770,6 +18780,21 @@ static int do_check(struct bpf_verifier_env *e=
nv)
> >  					return err;
> > =20
> >  				mark_reg_scratched(env, BPF_REG_0);
> > +
> > +				if (insn->src_reg =3D=3D 0 && insn->imm =3D=3D BPF_FUNC_tail_call)=
 {
> > +					/* Explore both cases: tail_call fails and we fallthrough,
> > +					 * or it succeeds and we exit the current function.
> > +					 */
> > +					if (!push_stack(env, env->insn_idx + 1, env->insn_idx, false))
> > +						return -ENOMEM;
> > +					/* bpf_tail_call() doesn't set r0 on failure / in the fallthrough=
 case.
> > +					 * But it does on success, so we have to mark it after queueing t=
he
> > +					 * fallthrough case, but before prepare_func_exit().
> > +					 */
> > +					__mark_reg_unknown(env, &state->frame[state->curframe]->regs[BPF_=
REG_0]);
> > +					exit =3D BPF_EXIT_TAIL_CALL;
> > +					goto process_bpf_exit_full;
> > +				}
>
> Nit: it's a bit unfortunate, that this logic is inside do_check,
>      instead of check_helper_call() and check_ld_abs().
>      But it makes BPF_EXIT_* propagation simpler.

Agreed, it's unfortunate to add more to do_check().

I tried passing exit / BPF_EXIT_* by pointer to check_helper_call() and
check_ld_abs(), but that still means we need a conditional in do_check()
to see if it's set:

if (exit !=3D NULL)
	oto process_bpf_exit_full;

Happy to switch to that if you think it's cleaner.

[...]

