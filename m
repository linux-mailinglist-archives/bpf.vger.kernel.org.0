Return-Path: <bpf+bounces-71728-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BC78BFC5F2
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 16:05:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 339C84EA1DF
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 14:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 506BA34AB13;
	Wed, 22 Oct 2025 14:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QqqcCtzz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7565530DD13
	for <bpf@vger.kernel.org>; Wed, 22 Oct 2025 14:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761141798; cv=none; b=SE753r6DcIct5XyRuTIuqv9dkVuLBMlk3nLKSPpFoURmy3WtU9KOPG9TZn8rI85v9pSF8e4Fz03QfJYJt897iT360ef1i9+9RfJqt0qt0ZmIlf88rt9xfBKyvG5RRp4+vTrTbF+aiZYanLtebvUAdBz5uS+OdCrAwGEeP+67lOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761141798; c=relaxed/simple;
	bh=RYrZ8Yamml9Zafp2Vffp2jpM19SBIBFOsukyiLH/wmc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Wp/+4BSXCf71RRmtHoBSBKhJ6WJlersjmU8T+kUG5R/z++eu1CDw8eRZMOL9uQxsf7l0LOKnVEqjHn0QhWRIJwtdE/MUXtcMBUVUGy7r9aLNXU5/CNDo6RVE/885NQDaWSk4aG7lTALvjGIvVJHF8nKKtXZAsqJT/K1maYcwxhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QqqcCtzz; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-79ef9d1805fso6335863b3a.1
        for <bpf@vger.kernel.org>; Wed, 22 Oct 2025 07:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761141795; x=1761746595; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RYrZ8Yamml9Zafp2Vffp2jpM19SBIBFOsukyiLH/wmc=;
        b=QqqcCtzzfHjon7YHtn+HSlVDaa+8jYFaswHk57pj89BmPGdBSBzTivYrCetJ28L5pU
         cLf/YNuEMSaHUitUZDt2ba6xpcvojklnl7y+O8rv7ohZDH22wMelIUaqop7Ty4lsTw7U
         kK7NpvBI3+74kLfwvumYEKEiSi3lLj3vQYs+Br7BVkr7ik4Os2ZKdcoh5k5zVSzEQKQC
         2Uk5D9t6ScxNUhGMMn2XurxsP5tVaNbsXBsJO+73v0jpDFhgrUlSprtrEK1EAHynIc3l
         PlpOdCQchtq6J6T0hJo+gxBgu7axtVHtGamUbLw9H98e3m9PEmeottF81SFlrgzAZqUz
         KwWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761141795; x=1761746595;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RYrZ8Yamml9Zafp2Vffp2jpM19SBIBFOsukyiLH/wmc=;
        b=l9KGOeCNW38XRt3hDXMKjpV7HxZvjJ7SC937dCXVmo6SNqyDgMLP+uXEGiHlrqZV4v
         dLpSHiiSede0m5sUdJ4nXYdfeE1QlGQ0o2HlfFRvPQpFxrGa1bW6IkFGP6Z0g5etc40t
         VZP9p1NUbmG4LQFv1RMxJ9NGVppDXh8YWdCiJ4XuszUJDMmt0C3S+LRSLEaHSMJHUto3
         fOsP7cIT+ufZ4fwFLS09vpvaDGeBXutQbJe3d0EGPN3a4c8xHAKmHsLbXAoOXpA6BCc1
         Ir0TfnF9xsQ66hwDk/iqXU0Ib3fBQxVVMTLNLYGBA6dB0h/a6nYVR5/YPsJz1ieYNBa1
         DoaA==
X-Gm-Message-State: AOJu0YzfFZPM/q85CVfX2fVsCRLKJh6fuAXsmo53HIwoUer3OZrFO8xK
	rIU0cJXiPB86pT/9kR0sL4xK81epu+Fo3OzaMFx93ZXKVTgGXflxB2J/YbRMKIQ2
X-Gm-Gg: ASbGncutsyc+LnddDRrpIckbZTJ7Y83EGcNeL+4q8bhoemDlAYZwT0Z1msScMDF/PtQ
	zCxAOIs3eN+IpRBTpRTpWUuVc7xefPP/QeRMwQoCGQS35xadDp2bnXdxOaLvuHZxZghVsMeuu3z
	l6+6RbHTioMr+udUevw2O1dJ44lowQr4NwcVwe1XFUiMSuh/ZGg0sJhmCi72sqVTncSBcXYsH7V
	8hCFbVokzlI8pOuAvrpyYaawQwicGxj6cdQo/XDaUjeOUU/5v5I/PGRmVL6hD4Lh+B0B9s0112o
	U5UF8usMcOtfaQjDr/jlMDQQtA4Y+abD6SAwI8BWbdY7IUbgw7QfOfoEZj1G6seoddVQ45GVLvh
	9G2M0MY0LGUVrWTe9APFn/YWA8k8Jm8gZsGTZTJAA3PtDSZ+xRkMOJVubyqSCBlp8GNKMdOh+fl
	REH+7PHJk=
X-Google-Smtp-Source: AGHT+IFEk9ATQVPBGKgvn8rYQw1fztZJSAUccuVE7kMD/+C+fLHdsu7G8Oam+jMnUB/g/40ulAs56w==
X-Received: by 2002:a05:6a21:328a:b0:334:8dcb:567b with SMTP id adf61e73a8af0-334a8643d4amr29204315637.52.1761141794395;
        Wed, 22 Oct 2025 07:03:14 -0700 (PDT)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33dfb573f97sm2796652a91.1.2025.10.22.07.03.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 07:03:13 -0700 (PDT)
Message-ID: <d5babd1d0a1ff4b1d5f11a95bde7881f7c970272.camel@gmail.com>
Subject: Re: [PATCH v6 bpf-next 05/17] selftests/bpf: add selftests for new
 insn_array map
From: Eduard Zingerman <eddyz87@gmail.com>
To: Anton Protopopov <a.s.protopopov@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko	 <andrii@kernel.org>, Anton Protopopov <aspsk@isovalent.com>,
 Daniel Borkmann	 <daniel@iogearbox.net>, Quentin Monnet <qmo@kernel.org>,
 Yonghong Song	 <yonghong.song@linux.dev>
Date: Wed, 22 Oct 2025 07:03:10 -0700
In-Reply-To: <aPjlANnS+hj09w2s@mail.gmail.com>
References: <20251019202145.3944697-1-a.s.protopopov@gmail.com>
	 <20251019202145.3944697-6-a.s.protopopov@gmail.com>
	 <9660d7d3d3348bdf84c0a1a2861b66db9e2cc980.camel@gmail.com>
	 <aPjfuZd+370hXFLJ@mail.gmail.com>
	 <0e98a654792b6ab8002b0cf7ddf604e20b2f8f5e.camel@gmail.com>
	 <aPjlANnS+hj09w2s@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-10-22 at 14:06 +0000, Anton Protopopov wrote:

[...]

> > > > > diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_insn_arra=
y.c b/tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c
> > > > > new file mode 100644
> > > > > index 000000000000..a4304ef5be13
> > > > > --- /dev/null
> > > > > +++ b/tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c
> > > >=20
> > > > [...]
> > > >=20
> > > > > +static void check_bpf_no_lookup(void)
> > > >=20
> > > > This one can be moved to prog_tests/bpf_insn_array.c, I think.
> > >=20
> > > A typo? (This is a patch for the prog_tests/bpf_insn_array.c)
> >=20
> > Yes, I mean progs/verifier_gotox.c, the one with inline assembly.
>=20
> I think it should stay here. There will be other usages of the
> instruction array, and neither should allow operations on it from
> a BPF prog (indirect calls, static keys).

It will be functionally identical and like 3x-4x time shorter in that file.

