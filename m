Return-Path: <bpf+bounces-78215-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 63097D02619
	for <lists+bpf@lfdr.de>; Thu, 08 Jan 2026 12:28:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C79D530F4D58
	for <lists+bpf@lfdr.de>; Thu,  8 Jan 2026 11:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 120B848A2A8;
	Thu,  8 Jan 2026 10:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V+EuXV8O"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A4D4611ED
	for <bpf@vger.kernel.org>; Thu,  8 Jan 2026 10:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767868803; cv=none; b=n4koBq8TUlWSFvNeYell0ZagNIYhxZsky7QdeAkhkJvPmxTavl7wRvv+ogUU+mFPDMrav2OeWSwFmEVlCqb0PHH7pGgz+ZNdpxCsn5KlnX5SdzJJLG3KBthgAzvMuU1VfQuMCUHzb1QQn/mjMibPhhTHQ/MO9LQ0DkH+dhj/NKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767868803; c=relaxed/simple;
	bh=9rxcaH0XqfpFzaFSC2tVEZqpmrAprad3wZiQ8PdrRiU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LXzfrkvMpvV9fz6fLH4qVCyKxvOoUDJ5O9akvQ/dmK3s2ulvXCU8MFKIjvqTiljMF4/IVIKS1H13kz4TjhmzSjV4poOKd3TFnuiDL8kei7rdWy2kurPeDj0p/3hswR+Ca0EuHC/d8C1dnzipcJMDa32r9zeVFvOX0UH1DrSW8To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V+EuXV8O; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-65063a95558so4271345a12.0
        for <bpf@vger.kernel.org>; Thu, 08 Jan 2026 02:39:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767868792; x=1768473592; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R67t3/y7Vy0NRDZFClRFUWiyayd2hkScl9Wg2asEBDA=;
        b=V+EuXV8OGX4zWncqRwcokOxWbm3Xf4Y+hIetkMJDTFK8IYlaP4SoUUw7Nc9YomOx20
         AyEk0UwS1XW6NLUtswzk0XGbuNNloDI10XXcMH9crlsV077DVJlMXcWIZ0ilZ9SdQUIP
         T8d2oGfqe9LURelcV3ccSfTPOKO3OAv7f03mtTT4uBJzU1/9Xvj6ca3jsht5LoJWpvod
         gmlSsr7H8qcsX1LCF7Jw8iSxanoZPvlQDhjJOjXy5vlB4kX9mKM47wYvs3/oRGlsTwpk
         2VgiRxncejRCG2r7Wag1S6hnwwlUdeOLHh0uRzjXVpftQajUBd5Jw13e3uOwl1oQeADH
         5fFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767868792; x=1768473592;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=R67t3/y7Vy0NRDZFClRFUWiyayd2hkScl9Wg2asEBDA=;
        b=OS3B+URcRebKJee99o3CCSqTuPZiEawDUlgzIv0roQ2/f8g1LnGoSajiqxPWQ3LEOy
         07vPpAu/IhouphkoWIK0bEi2jQ58T3l/4OhZp5TcXAvEZPbmoIBHFmzmj327yDPxFQh2
         NOCBmGEpvx0ZYSIkzIZd+R0wH18H2/ZUAkzR0dUiXCQaUCiKh2wvh3JXO440LWuC7Uo6
         VdY0no+2WYf9zcmUhkSViO7UTnis1qwGRX/SOvXWQpj9Q2p4LnofztVinwk40lkwUg0W
         yJSLEs7d8vMKF6VAr7OnJa5OV1eghl/LKxk9KYNhImPivTuWToG9v0+ozZfTZy18lsra
         bU2A==
X-Gm-Message-State: AOJu0YzbBi89+3XsnZlDLKVtsjpGLy9kNALBBSRh0YFUf4IFdQCyuzPA
	AII7TI5G6ZkJ7DJNY/a36lswSQnuN/XXwbtc+9Xg4Lh7BVK54lo4keWShGUwfsnfLw++n3aNlpl
	6DNYtzTdKC8PWteXmd+2QuVNBxTXwhCI=
X-Gm-Gg: AY/fxX7xDGiU8TzETDtN7m4iZeszr+bFFHB7QwXO3e0TvrIS8G2JCTQIFclNypsZsk6
	oDqm7gqlmwOaug8cw1kjlkk+EziA1a3P/bvPDqcdenxes4POzHQS3HSAxVoCJKXngPJ1csV57Xj
	Tjg6CO5Utl/Fx0rCMZS9WzvWTk9AtsGVFhs/KJaR8rObb34Uw7W+3RKtbSsiRyTLzI7YAdprXB3
	LwLoGaliIL1dqMb11wSplBEztHXn7MlB3emGJ+mq4WThsJK6ptLB+vA7FJXqD+Mrlw2NOWKbHB/
	jWjBhnFyasA=
X-Google-Smtp-Source: AGHT+IGCYQyz/RLKT3W08NRV/2R7Cn1ezLmmZAOZrvocGXcs8stVuZq68/ef3tFY440YfK/htzas+forWJ4jial60mE=
X-Received: by 2002:a05:6402:270a:b0:647:54ba:6c42 with SMTP id
 4fb4d7f45d1cf-65097dcd9fdmr4950878a12.4.1767868791586; Thu, 08 Jan 2026
 02:39:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260107203941.1063754-1-puranjay@kernel.org> <20260107203941.1063754-4-puranjay@kernel.org>
 <d64c1ff42310fc6c6284add088e598df078559cb.camel@gmail.com>
In-Reply-To: <d64c1ff42310fc6c6284add088e598df078559cb.camel@gmail.com>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Thu, 8 Jan 2026 10:39:37 +0000
X-Gm-Features: AQt7F2p3MvIxgq1GLJh4piVYbZ8TRVj2WWcZFZnv8FQbNY_3OjsmbfkuExaAucI
Message-ID: <CANk7y0gJjhRmgVo5jmEHx53WWCz5BBEYp7XXqo+9Nz2oH5zACA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/3] selftests/bpf: Update expected output for
 sub64_partial_overflow test
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 8, 2026 at 6:59=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> On Wed, 2026-01-07 at 12:39 -0800, Puranjay Mohan wrote:
> > Update the expected regex pattern for the sub64_partial_overflow test.
> > With BPF_SUB now supporting linked register tracking, the verifier
> > output shows R3=3Dscalar(id=3D1-1) instead of R3=3Dscalar() because r3 =
is
> > now tracked as linked to r0 with an offset of -1.
> >
> > Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> > ---
>
> W/o this patch selftests fail after patch #1, right?
> We usually keep such test fixes in verifier patches.
> Such that selftests are passing after each commit,
> This makes any potential git bisect simpler.

Yes, I will merge this with the first patch in v2.

>
> >  tools/testing/selftests/bpf/progs/verifier_bounds.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tools/testing/selftests/bpf/progs/verifier_bounds.c b/tool=
s/testing/selftests/bpf/progs/verifier_bounds.c
> > index 411a18437d7e..560531404bce 100644
> > --- a/tools/testing/selftests/bpf/progs/verifier_bounds.c
> > +++ b/tools/testing/selftests/bpf/progs/verifier_bounds.c
> > @@ -1477,7 +1477,7 @@ __naked void sub64_full_overflow(void)
> >  SEC("socket")
> >  __description("64-bit subtraction, partial overflow, result in unbound=
ed reg")
> >  __success __log_level(2)
> > -__msg("3: (1f) r3 -=3D r2 {{.*}} R3=3Dscalar()")
> > +__msg("3: (1f) r3 -=3D r2 {{.*}} R3=3Dscalar(id=3D1-1)")
> >  __retval(0)
> >  __naked void sub64_partial_overflow(void)
> >  {

