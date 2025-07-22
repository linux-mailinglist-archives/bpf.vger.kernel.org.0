Return-Path: <bpf+bounces-64111-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD066B0E568
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 23:26:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E00173A74A0
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 21:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21F87286409;
	Tue, 22 Jul 2025 21:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jMYukLBO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51BB5285C8B
	for <bpf@vger.kernel.org>; Tue, 22 Jul 2025 21:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753219572; cv=none; b=EpOOJ9EV8dPrHenIzaEnpHd7r6x8cF2DhjhNSmJLZ8tyAMgSE1zf/eimyqPJ1ZMYIphTS8ryi90HEEQ8uVvX45J6GwtUUs9hL9j3FCb3ALbnVo5kUPFTlIMWfE+OLhxS3ezt2JmIRJcRpMs0CbhjFxkEIhuLEv4VkV3lbjf3Z3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753219572; c=relaxed/simple;
	bh=yEEc81/Wls2pxx7bWTMxpLt5kBHi45NMqmaS7+rp4f8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=B8f+3IN3JxT8Nt0Lm2ntk0WkZ1z4f6kGRZFbp771oY16TlLfKdWYSJwZXyd1GXrcE/R21gLXeioJlfrVJTFIUCxg5B9mqKaM6oq43EaIMyKSf8HLOapnBl+Tg8YdiF/tDkE8yyM77sSv0CfsJhhR40XDYPsX8k5Qckr50FQdOl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jMYukLBO; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7494999de5cso4097187b3a.3
        for <bpf@vger.kernel.org>; Tue, 22 Jul 2025 14:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753219570; x=1753824370; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5Xi6o7ZPHnMj+DWI+AP2zE1BHZ30fBaSJpSGh9UtanE=;
        b=jMYukLBOsm+1GjBwZ7sYjHkvrUkASdZZpygzu1/lGmA8Thkk/GV5YZVfJQdS5v5imC
         i/czGw+uCb8Q6pfnwJhhci344cpnGlJ8OEFsp0yoILXof9ElxxC696bjsEUWAl1iCB/N
         2Pypb9kRaj/jMagc7AW8spJI/RuzFjYsAqlytgHcrq53iaXW9SGQtts9efpM7KvvGyhJ
         +3gKKVOXzHlI+h5EmRHhgMhggS517ON5P8XJUHb0BioDBZd7f3zGyO4uSWNcOvz4QIbW
         Yq0Yjc4eQbehAizYLak0divGCus2Uz5p75lrs3sA9MVeAxMn/TdqWB4+zSAXiKx0dZSO
         CINw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753219570; x=1753824370;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5Xi6o7ZPHnMj+DWI+AP2zE1BHZ30fBaSJpSGh9UtanE=;
        b=H44XC6BwkOPBbqKl08OvjZ++oCVANCULb8LHiWiWvlxYWCRs4mGL9a1VNpiJ0yh555
         kvAwlDAdkGTjs9hQrNBf1SSIWJOkRj8Nrs0oyHHlI4nBqSrxnZolXZf2w5daA3bfd/wt
         OgqjYoEYhhwJNH9NaLxQu+9LKPXaarYI0c8gqPsOCsLyw8TQNYNJ7gnbhd+ieoFaKdv8
         6T8q4lmSQ+s9IZyWv5bHSqygPFe5E5MUMH1O8hb0K8SomqoMDYMVr6ivmaz/9KUUIGzx
         nG7UoS+B2sR6CBY41IzfXv7omXdHMHpQbpeoTzXWdvLccU25IGGaOTbPtLOMGHocTcOf
         1+dw==
X-Gm-Message-State: AOJu0Yw69Fb/y4xhZZCmkijMdpfcl5xvFY4dLqVr5olzKB1nlRALHExh
	Io0XtJ+xAEsb43dD3HSVi8lqO/dXIk4IhiOdnyUKIoWSvyMPqpfER5I7AWSKKDwV85M=
X-Gm-Gg: ASbGncsC+a8y1qVRIC2GzrdEy6iSzU0zDpVou2tVxGoSkkLQ80L1o1TGvcAZyHlS1Se
	t9pIn48r2/GBpLGVW0fEYYnppEFbDEUdA1aF9Y1MVA7ONlgcn5Thhd09mleWLWGB9clWm0NIUYI
	wmzQvXUvfXc7VjhLMUrzj3fsik36wn49V+VfjFEpQa1wQ4to8F93dnMqy3ADgM07MnO6ZbA6xAl
	rqD1qBwX4UupWDps8lmMdR96zNVGvBxHkQ8y1z0a0Ur/+kt56WXWytum5ZOQhalfmamGT6LBqYX
	qqIpeT9rVzCUQQG8ZmlpvTGgeOMNMWpZaxA4CtNXCnyWdn69xaX4iYj6Oi1h9hn38cLPUSQ6NJK
	R59hEx2GfgDZI44dR2YEUilQNDtTk
X-Google-Smtp-Source: AGHT+IENY5phNow9WvwP4HmTiPitDcb+vQf0wi+IVYP7ZidmXk+PkLWoSNiXJH6VKjXP2TSnLC8bWg==
X-Received: by 2002:a05:6a20:6a0d:b0:232:3141:588e with SMTP id adf61e73a8af0-23d49126626mr486885637.37.1753219569590;
        Tue, 22 Jul 2025 14:26:09 -0700 (PDT)
Received: from ?IPv6:2620:10d:c096:14a::281? ([2620:10d:c090:600::1:e6e1])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3f2ff88cf8sm7702948a12.49.2025.07.22.14.26.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 14:26:09 -0700 (PDT)
Message-ID: <85160df58a2081647aefec10930336ab55595124.camel@gmail.com>
Subject: Re: [PATCH bpf-next 2/4] selftests/bpf: Update reg_bound range
 refinement logic
From: Eduard Zingerman <eddyz87@gmail.com>
To: Paul Chaignon <paul.chaignon@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann	 <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Yonghong Song	 <yonghong.song@linux.dev>
Date: Tue, 22 Jul 2025 14:26:07 -0700
In-Reply-To: <aIAAooxj5uS8BHed@mail.gmail.com>
References: <cover.1752934170.git.paul.chaignon@gmail.com>
	 <4636f494d90da3627e955d62e54a7927c6b2b92e.1752934170.git.paul.chaignon@gmail.com>
	 <8dc4b79af360bb6121c6b96a2c351bd060bfca29.camel@gmail.com>
	 <aIAAooxj5uS8BHed@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-07-22 at 23:20 +0200, Paul Chaignon wrote:
> On Mon, Jul 21, 2025 at 02:29:47PM -0700, Eduard Zingerman wrote:
> > On Sat, 2025-07-19 at 16:22 +0200, Paul Chaignon wrote:
> > > This patch updates the range refinement logic in the reg_bound test t=
o
> > > match the new logic from the previous commit. Without this change, te=
sts
> > > would fail because we end with more precise ranges than the tests
> > > expect.
> > >=20
> > > Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
> > > ---
> >=20
> > Acked-by: Eduard Zingerman <eddyz87@gmail.com>
>=20
> Thanks for the review!
>=20
> >=20
> > >  .../testing/selftests/bpf/prog_tests/reg_bounds.c  | 14 ++++++++++++=
++
> > >  1 file changed, 14 insertions(+)
> > >=20
> > > diff --git a/tools/testing/selftests/bpf/prog_tests/reg_bounds.c b/to=
ols/testing/selftests/bpf/prog_tests/reg_bounds.c
> > > index 39d42271cc46..e261b0e872db 100644
> > > --- a/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
> > > +++ b/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
> > > @@ -465,6 +465,20 @@ static struct range range_refine(enum num_t x_t,=
 struct range x, enum num_t y_t,
> > >  		return range_improve(x_t, x, x_swap);
> > >  	}
> > > =20
> > > +	if (!t_is_32(x_t) && !t_is_32(y_t) && x_t !=3D y_t) {
> >=20
> > Nit: I'd swap x and y if necessary, to avoid a second branch.
>=20
> That works, but we'd have to swap them back before we hit range_improve
> below.

I missed the part that x_t/range need to be returned,
please ignore my suggestions, patch is good as it is.

[...]

