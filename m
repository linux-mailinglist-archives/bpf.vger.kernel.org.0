Return-Path: <bpf+bounces-71831-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 305FBBFD7F1
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 19:13:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 05B634FAB11
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 17:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4103727146A;
	Wed, 22 Oct 2025 17:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QTKs7ur5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40AAE26ED29
	for <bpf@vger.kernel.org>; Wed, 22 Oct 2025 17:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761152421; cv=none; b=FJvdg7QxI1ek73Z8OKuctJ1Nw4sSib1xmV7fNtnEkReXlZxaXTEz/VRnfB1OUaicaiM1daHvR9lBzoX3wE8DnCYiLqffBWR4m3xzydjjnR4Q9RFiDAENKGxSJp6XfC4bANIjeSDpxkXmB7l7w3EVUguXNH+aAftGSXcszmw1RF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761152421; c=relaxed/simple;
	bh=Il9KvT9aOw3nM8rPyw78uVLElJTEq5yc96lYtncXGZA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fQ9LuBkeHIlyoV6eQOLqvV7rKETMmgcSQP/AyQNJwlMMzdhbGq7DTyHirl3mQJiiOSjXcMrJMDC0CoWu/tB+xDIGpwEKUxU1a25Lvu44fLIBXIM6YoReVgNiJ9z2OAFu/75wGN85uzp7GgPfFZ/DPDLuWV6FpZGFx2pcwI3dLDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QTKs7ur5; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-77f5d497692so8771258b3a.1
        for <bpf@vger.kernel.org>; Wed, 22 Oct 2025 10:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761152419; x=1761757219; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Il9KvT9aOw3nM8rPyw78uVLElJTEq5yc96lYtncXGZA=;
        b=QTKs7ur5OPI2gqjg0KUYYcUNAwUx9XZFS36YPagkIGmNavXfPCKnzucd1TGlvJrLsy
         gyK3ueCZKtxI4LY8apkfMqr8Y8p95uGue/DuSOvQuYBY9HoxY/IwaqfXm7ulnSzvEE0j
         y7XT14H3m0s+GUhhKJlve7ks+EFc2YO7sSrrgbR2M/umeE3Rx03cIV0hxHSKT8UtYNBa
         wEXfPXTVFkggnBhk4QdHyPSxvqwTqbRWfxnFZ6yXvRjVyrRN98zUE5sBpE2yeJ8kk0Iv
         QdvLsI9XTfk/fclIh3CiNfcFv6/fP9FZw1No3/9gRrisW8Q37hdcjp6DBs75iQ6WKRlX
         ZluA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761152419; x=1761757219;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Il9KvT9aOw3nM8rPyw78uVLElJTEq5yc96lYtncXGZA=;
        b=qn9521FdFADnu3+0/LL3mnO3g3wdre3b5696Olo/dntMHjBNCfwxVq6CTlL9ogh5xY
         xcjTBVTZ7cO4QHNwXh1gSL7Pk+MbmyINuyLdK742xIbIcqtWeheU5UV/1UoWPlUKKYiq
         d0APo8MfUEdghHH1ftvvJJEvUR2XanwSXQ+r54nJVPOFK2flRDpojHRjgxZAyDlX4D4d
         CC3Uqw925fUJ/kcm/L1eBerA/F7KAlvxqWJ9nVYAhdehMlx+LGTiTiMVWWOzMJLgrtEN
         pY8mpHEUB7KsBOfOJJ6iMcgHfYKbvXFc83uXFjaiShXxKPzgTZqnA5waMA+W3jLoNUUb
         G8Bw==
X-Gm-Message-State: AOJu0Yyz5Dmw2W8Y0EWsXgkReBTezdrM8qdCjpEjaCrEE5xbMDAaVuyd
	cm51ay0+fX76hwOOrcDqnOD+/CpfpPzKYWLt08I/ptAHrQEBA6MATRqa
X-Gm-Gg: ASbGncvz5WQ/KtIN8QyPp1ZZP619vyzJU86cqPjx+qCYkmApXA2dM2fONy4pfoNT11i
	mzvZze+/KcgEslaRaF1Xr/8z1OrLhQkeqYJNgaHf+L8FTugpqJJ4XYvS8RthpiaFDUrtV0E8Y57
	pbb3lqapsyMyH0kksEjOPox3PFGTlbmBUbo9l0X4QVZf7FXHZYeHBZtjOeisXXEOR41KVk/Iie9
	Rpsb29k6zOhqdlOO2gTYYKp81Prw/yUG0/cEVYf3EgKs8FXBDfUti0xLSe7isXYzgZMT3dKyFOO
	XeOBxHPwRrBwR9caEEWg0Dc3v+4tfY2062G+tu+Lcm2HqkfvhRmNBqXb1KeqOq1dhBXoKv9xfHb
	6V1tDz+zwyF3Ioa5oLeR/GlgFhvkrhaezU2a8y5xVfRm84jl+p2RH7zF6TbUk3ezwf0jPUo1Ldj
	vZGbjL8zUSkeB0OzxLbBMQPZRFJ283Z2O/wAU=
X-Google-Smtp-Source: AGHT+IHzRB7ko+7UoZkLb+73trdatEShqD6viR6vMVNkDRdYiI65VYU9xGtzWGYXnu3ehZqKqE8ciQ==
X-Received: by 2002:a05:6a00:9514:b0:781:2271:50df with SMTP id d2e1a72fcca58-7a220ad9c9cmr26296628b3a.19.1761152419324;
        Wed, 22 Oct 2025 10:00:19 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:fa8d:1a05:3c71:d71? ([2620:10d:c090:500::7:b877])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a230123122sm14957323b3a.72.2025.10.22.10.00.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 10:00:19 -0700 (PDT)
Message-ID: <3c14b6ca33d86b34eeba1d820b0654e713136b5c.camel@gmail.com>
Subject: Re: [PATCH v6 bpf-next 05/17] selftests/bpf: add selftests for new
 insn_array map
From: Eduard Zingerman <eddyz87@gmail.com>
To: Anton Protopopov <a.s.protopopov@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko	 <andrii@kernel.org>, Anton Protopopov <aspsk@isovalent.com>,
 Daniel Borkmann	 <daniel@iogearbox.net>, Quentin Monnet <qmo@kernel.org>,
 Yonghong Song	 <yonghong.song@linux.dev>
Date: Wed, 22 Oct 2025 10:00:17 -0700
In-Reply-To: <d5babd1d0a1ff4b1d5f11a95bde7881f7c970272.camel@gmail.com>
References: <20251019202145.3944697-1-a.s.protopopov@gmail.com>
		 <20251019202145.3944697-6-a.s.protopopov@gmail.com>
		 <9660d7d3d3348bdf84c0a1a2861b66db9e2cc980.camel@gmail.com>
		 <aPjfuZd+370hXFLJ@mail.gmail.com>
		 <0e98a654792b6ab8002b0cf7ddf604e20b2f8f5e.camel@gmail.com>
		 <aPjlANnS+hj09w2s@mail.gmail.com>
	 <d5babd1d0a1ff4b1d5f11a95bde7881f7c970272.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-10-22 at 07:03 -0700, Eduard Zingerman wrote:
> On Wed, 2025-10-22 at 14:06 +0000, Anton Protopopov wrote:
>=20
> [...]
>=20
> > > > > > diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_insn_ar=
ray.c b/tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c
> > > > > > new file mode 100644
> > > > > > index 000000000000..a4304ef5be13
> > > > > > --- /dev/null
> > > > > > +++ b/tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c
> > > > >=20
> > > > > [...]
> > > > >=20
> > > > > > +static void check_bpf_no_lookup(void)
> > > > >=20
> > > > > This one can be moved to prog_tests/bpf_insn_array.c, I think.
> > > >=20
> > > > A typo? (This is a patch for the prog_tests/bpf_insn_array.c)
> > >=20
> > > Yes, I mean progs/verifier_gotox.c, the one with inline assembly.
> >=20
> > I think it should stay here. There will be other usages of the
> > instruction array, and neither should allow operations on it from
> > a BPF prog (indirect calls, static keys).
>=20
> It will be functionally identical and like 3x-4x time shorter in that fil=
e.

Wait. I'm being stupid again. There is no simple way to get an FD for
the iarray map when writing a bpf C. So your current implementation
makes most sense. Please disregard this nitpick, the patch is good as
it is.

