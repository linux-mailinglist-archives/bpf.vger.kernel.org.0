Return-Path: <bpf+bounces-72131-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 52773C075DD
	for <lists+bpf@lfdr.de>; Fri, 24 Oct 2025 18:43:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 827BD4F5C40
	for <lists+bpf@lfdr.de>; Fri, 24 Oct 2025 16:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B8631B118;
	Fri, 24 Oct 2025 16:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jv6rnE4O"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80292773E3
	for <bpf@vger.kernel.org>; Fri, 24 Oct 2025 16:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761324170; cv=none; b=DebhKYU5sxYfnpRQ6l7k64JEmtifHcVT1w+0yMeQTJln6PAJfTBER6C1zDV916eOx13ykmP+KoQM9ulCD0rWGinje7o7BYxOuaofkdhZJEdTUTBACI7IP/v7rC+AMOiszMJX0yEbBLhGw+hwaPR3oXF2cuVew5D21gRN8ZZleOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761324170; c=relaxed/simple;
	bh=XCG2ROo5yx2j/lCya4feq7KMFbmA4NnnoVPsjapjI+s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=smfilyvN5L1IyTcPN7jWyuQDIzGrpiVXFVfDQWjmo5Ob1vYnU01GlcsR8bZLM1XU53tMMnLXoaqmoLCCNhkCdfjxotgzp+j4OiznCQ9FrlsEvVUF84rtlHVsP/cN4fbqmCw6s437FJWppU5SVDp1HdstKJU/RoImPowUCQYv2aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jv6rnE4O; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-71d71bcab6fso21861237b3.0
        for <bpf@vger.kernel.org>; Fri, 24 Oct 2025 09:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761324168; x=1761928968; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XCG2ROo5yx2j/lCya4feq7KMFbmA4NnnoVPsjapjI+s=;
        b=Jv6rnE4O489yNON0a//rg/V4tpKHTHVrhrYPeQXtwcoAFgWUASEGfr0vegr36dOBmC
         X2XgCiKln7qhK73yweadAU/5qZOX7H38pTMus3xHNuG2IupX0ziStQhOP09so281y5Zk
         3FxOQvPiJNWclLlEKVVAlysn/XpTFtdp7Z8O2ETeD7ZRcSL21JmfWp2MBQI9A/U7t0XM
         zeUVXDKgG+udcQAU/NAStgKrrpRCjahSIKT0PnYqfWqIRCfOi3d2utZU8vnh9OJBVMo0
         6BsTMSPZr19QV6nGG7shExaz+/oLvVyz8uZTGRrkLDQOl8Ynr6SI10CW5+0MWZy9GGdS
         9VOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761324168; x=1761928968;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XCG2ROo5yx2j/lCya4feq7KMFbmA4NnnoVPsjapjI+s=;
        b=MPSS6+RnYd+fOKkDCr4NDRJGxjKVmYgHJKQb8OEfXMmbi/T/WSWuyMYX2pl7e2LHqF
         L8JcRoP8P0O5/dz4oed1nwUkI4e2m4RrW9qxjZKGqSFa6/E6v/wlQ/HLG2Zzj3YTfJNn
         dO19gwel9Q4cjYPMzFwM4ZeSFPtPeTxKlyTngmL3NNt2JctFixvqYmXy1YoxHmvl8QEb
         jI4cbtFLyzN1bSjHwB9uC4y7jCvKDab6Ytxq+jlv4BvotOiL/ldzHt11J7Dd6Lf2UHNL
         2J+CYKkr0++w+vVXMdhLhIvlBD5DL8+fQXvAJGc7FJK670mEKKDxc7q6EI72tVrUkhOq
         FfqQ==
X-Forwarded-Encrypted: i=1; AJvYcCVn7XeqfMFWz2Db91pp1Yi2+cF3BgbdUpo4Z7mWBQV610g69EJ3IBISwGPXRKfxPoys4cc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywq+Apmf6Ozg3kywVogusxSw0fKPBJFTt8Q7qbb7Zscn9KoDyEC
	BaIgjWob+SCqG9xZDbqM8lb0h3FWmubKXviQSvbtlGOO/NdhS9BT7wo87rEnXhsu3fQ91nrKtDQ
	/S2PmxoqcKb9511VnHgD2YX6IhpMlOsI=
X-Gm-Gg: ASbGnctMFyMLD5XdIBVzXOA6ixAdQoIbjSq1Ooixc3evQ807mzaiZQpNdPkE5HgCu4t
	+swjfc7iJOIL55+7S+6J81XnhnoJbLvm3eOFHD65KYU99Z+tE9QhACr6pbx27/ArY06FHgdz4rd
	A3EqtzUrozIF4+iiWvGc5S4dfNZTgLnw9E4oriPYVvGPclY+9cZv4GofkQwBZe0LmLwjvawZGsN
	U5sZAg99IdpymATSyJ8qfjx7TPzUdWDR/hz51WGuLMgedRI4I+SF08S+Vp5
X-Google-Smtp-Source: AGHT+IHrQeO+YuH1CpQ/LHi2wii0qdj03u9/1crSxBS8WcYNkKs7DUuIqxkOM9zO3MqlsRZ/E7zIZQaJCtAFNS2bHxs=
X-Received: by 2002:a53:420c:0:b0:63e:36a7:74cc with SMTP id
 956f58d0204a3-63f435b21b0mr1613698d50.57.1761324167761; Fri, 24 Oct 2025
 09:42:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022175402.211176-1-memxor@gmail.com> <93e428555500f60c3dbcb04b79807d3ffce024c5.camel@gmail.com>
In-Reply-To: <93e428555500f60c3dbcb04b79807d3ffce024c5.camel@gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Fri, 24 Oct 2025 09:42:36 -0700
X-Gm-Features: AS18NWBlAbkkE5DET8_Cc6JpmCZ4xSwFCq0A5xpqI7VeeyQJwSg-_bvVcoLy5YE
Message-ID: <CAMB2axOs7-0=BX5HVwYgvGzDu7z2k7UrnNAopCJ_Fq6Vjj8seg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1] selftests/bpf: Add ABBCCA case for rqspinlock
 stress test
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, kkd@meta.com, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 22, 2025 at 3:04=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Wed, 2025-10-22 at 17:54 +0000, Kumar Kartikeya Dwivedi wrote:
> > Introduce a new mode for the rqspinlock stress test that exercises a
> > deadlock that won't be detected by the AA and ABBA checks, such that we
> > always reliably trigger the timeout fallback. We need 4 CPUs for this
> > particular case, as CPU 0 is untouched, and three participant CPUs for
> > triggering the ABBCCA case.
> >
> > Refactor the lock acquisition paths in the module to better reflect the
> > three modes and choose the right lock depending on the context.
> >
> > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > ---
>
> The overhaul makes sense to me and the code is easy to follow.
> The only nit I have is that test does not fail if deadlock is not detecte=
d.
> E.g. if I remove raw_res_spin_unlock_irqrestore() call in nmi_cb(),
> there are stall splats in dmesg, but test harness reports success.
> I suggest adding some signal that all kthreads terminated successfully.
>
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
>

Maybe it should be another way around? The test must and should have
triggered deadlocks, so if we count how many times the return of
raw_res_spin_lock_irqrestore =3D=3D -EDEADLK or -EITMEDOUT, the number
should be non-zero.

The test looks good to me otherwise.

Reviewed-by: Amery Hung <ameryhung@gmail.com>

> [...]
>

