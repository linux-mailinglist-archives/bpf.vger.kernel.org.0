Return-Path: <bpf+bounces-61452-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 907F1AE720F
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 00:05:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C55B1893465
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 22:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1EF025A355;
	Tue, 24 Jun 2025 22:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DUkvfUmW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11942307483
	for <bpf@vger.kernel.org>; Tue, 24 Jun 2025 22:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750802708; cv=none; b=tegmj3J7CQlEX7nvExrzbCTKshuPX6Fz7Z+NtMcgD4rEMd43WNEYcolhebOGofZCfmPpe8JgcMf/qxxuF3YlwyYiT3jrLbbxzbkSHRDSgXGtzdFuh16BOgn3GmudSi+nz8ezqBnI7veO4mId6wRD+Jy5Z2t4VcGlpISp1zCwXs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750802708; c=relaxed/simple;
	bh=hHM6oMxz6rRobrXek4MYYJ//JcY+VifSf02iHZB6Xl8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Cldxt59I/zJ4xbtfvUReqggmdGa7Pdhp+AnaN/EGUDcSQyi1Fd/VdngidAvXT1H0o8BjSHH5RbcpZCmsIcQgi2Wx8mRA5uosigA7KPQ5AScgdKJNs8/ZbPI2NnrD2rzt501XA4vjxsd3ZWzuxesWPHDpq1sEXfl4wWdXgj0Wpws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DUkvfUmW; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-74801bc6dc5so213781b3a.1
        for <bpf@vger.kernel.org>; Tue, 24 Jun 2025 15:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750802706; x=1751407506; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JP6DZ0V6JA2NRMtHzc3fUkJdLhuO8YJxwgaRF9tmA+Q=;
        b=DUkvfUmW++vcvzZCDj3ltFOCgA5VvVv8GCwOUeOFQpAOajZrPaF8J3tZ0FdrD288OB
         rjkOzcLI81w4dOgZKsOiJZeWpjy+4pc19sq3vYch59d6mFbNHqRYRRfUrM7mpcr4o6oT
         UEjOLnne2ufCUhFuOlcWpk4JnoO13saIHnSGMDlgk7FUzJZahGqcAi4J0L/DkcwzEF4x
         s/gDqLw3KMXnzGqnYk1q2doKdKeSMaENQg5XS4blYlIEzqNOvEKh6s0qL+Rp76W8FrYS
         X3OZ3xdIBbeUC9wY9PYNGsxUUH66gKyAaT+K4PpKsnMNeZqHSEwNm5TtGMBtY52TBRTG
         Or3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750802706; x=1751407506;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JP6DZ0V6JA2NRMtHzc3fUkJdLhuO8YJxwgaRF9tmA+Q=;
        b=BvkciTUH+LQS7UCvVPS+sJW8lEhY3tpiAPa6cOPrMuQZmanmZ5ennjFdhfDnrHDYA2
         guOQbp+rLdOtzac8OY+8/0e5e2+zKh+4QlezStyVWYpEWfYyudBCZqIz0wls1wq8kkYF
         vUESAfbz15CB6eWBSrMWqKSanOUBpDDWm64MU7TDf/N78xGbJkyaRSCjYb4vE90RCOBd
         zmWq8u7N9UzzA3cY7dofwNOCxi2hqyVWmwFbSnxIE0buEVJeenPBsU4nDRymRQmUcoKk
         esYCPgnWFO8sRnfWuZUf/dBaWmmTrIp30YRntpOew0l5GxI7lyyCcJegFrMRI52aphev
         2HTQ==
X-Gm-Message-State: AOJu0Yx0OVjHCpfDLD6TfJRiZZkkc9mHfGb5ytSiAiNBLz9eTfGU84Vv
	Ive2dB0wEOtEIsurPdPHHLvUB6tDv9ApPj035wxWvQrA/dMmXjv41+rq
X-Gm-Gg: ASbGncur0wD8Sg4kQUn2uN1WZuh8GtkP0caEoC/uVsKwbxw00SwT+R0v9CAn0ENbUo0
	RSJbCtYLz8JE9kj8bizYMLFTEO1RmyRnLZFjRqT80Y4NNR6X7Q8tzSpyFOZs64NVlH9KaQKd7r5
	NLF2QzrvK0RJNQW5F/xQo2qMeuZVmsspVhS8S1eNQVkyrbyKrNQiiEICfMbuXJ4C4yZPKCUfqF6
	1u0qSwzOgG+ix73TUn+9jw1ElL7n92r6mwAG5sElA+dgNG30hpIUkBaTa/Kg1W9V0Qa9yP8SXww
	UL6B0OEKO5OtjnBNxPuESakrvQy9cKLZOnTuM1AAtldBRUfK0TwiQlSXBCfvhQhHZ/Uz16ri/7d
	F4jNPat/kfQ==
X-Google-Smtp-Source: AGHT+IGwswXr3XxdOBxGeAK3VdDKsOjWcG7+lDVNVcqpERKhL91roYryJyuKhhf3w5MuwKpQWIbWrA==
X-Received: by 2002:a05:6a00:2396:b0:736:5969:2b6f with SMTP id d2e1a72fcca58-74ad4c0266cmr816275b3a.6.1750802706174;
        Tue, 24 Jun 2025 15:05:06 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:9b77:d425:d62:b7ce? ([2620:10d:c090:500::6:f262])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-749b5e08cfbsm2838645b3a.18.2025.06.24.15.05.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 15:05:05 -0700 (PDT)
Message-ID: <1a9fbc392e1745c36670674eaab32cb27735ab7e.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 3/4] selftests/bpf: allow tests from
 verifier.c not to drop CAP_SYS_ADMIN
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau	 <martin.lau@linux.dev>, Kernel Team <kernel-team@fb.com>,
 Yonghong Song	 <yonghong.song@linux.dev>
Date: Tue, 24 Jun 2025 15:05:04 -0700
In-Reply-To: <CAADnVQK8e7SqSRDab8xw1onFHe6YoBnTqoXJ+Pjg-_bDk5=sXA@mail.gmail.com>
References: <20250624191009.902874-1-eddyz87@gmail.com>
	 <20250624191009.902874-4-eddyz87@gmail.com>
	 <CAADnVQK8e7SqSRDab8xw1onFHe6YoBnTqoXJ+Pjg-_bDk5=sXA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-06-24 at 14:55 -0700, Alexei Starovoitov wrote:
> On Tue, Jun 24, 2025 at 12:10=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.=
com> wrote:
> >=20
> > Originally prog_tests/verifier.c was developed to run tests ported
> > from test_verifier binary. test_verifier runs tests with CAP_SYS_ADMIN
> > dropped, hence this behaviour was copied in prog_tests/verifier.c.
> > BPF_OBJ_GET_NEXT_ID BPF syscall command fails w/o CAP_SYS_ADMIN and
> > this prevents libbpf from loading module BTFs.
>=20
> You need this only because of 'bpf_kfunc_trusted_num_test' access
> in patch 4?

Yes.

> Can you use kernel kfunc instead?

Should be able to.

> This needs more thought.
> s/RUN/RUN_FULL_CAPS/ just because of kfunc in the bpf_testmod
> doesn't look like a good long term approach.
>=20
> I thought we agreed to relax BPF_OBJ_GET_NEXT_ID to allow for CAP_BPF.
> Probably even unpriv can do it.
> Just knowing a set of prog, map, bpf IDs is not a security threat.
>=20
> BPF_BTF_GET_FD_BY_ID can also be allowed for unpriv,
> since one can do it already from /sys/kernel/btf/

Makes sense to me.

> > This commit adds an optout from capability drop.
> >=20
> > Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> > ---
> >  .../testing/selftests/bpf/prog_tests/verifier.c | 17 +++++++++++------
> >  1 file changed, 11 insertions(+), 6 deletions(-)
> >=20
> > diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/=
testing/selftests/bpf/prog_tests/verifier.c
> > index c9da06741104..cedb86d8f717 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/verifier.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
> > @@ -115,14 +115,16 @@ struct test_val {
> >  __maybe_unused
> >  static void run_tests_aux(const char *skel_name,
> >                           skel_elf_bytes_fn elf_bytes_factory,
> > -                         pre_execution_cb pre_execution_cb)
> > +                         pre_execution_cb pre_execution_cb,
> > +                         bool drop_sysadmin)
>=20
> I have an allergic reaction to bool arguments.
>=20
> >         run_tests_aux("verifier_array_access",
> >                       verifier_array_access__elf_bytes,
> > -                     init_array_access_maps);
> > +                     init_array_access_maps,
> > +                     true);
>=20
> This is not readable without looking at the argument name.

I'll drop this change in v2.

