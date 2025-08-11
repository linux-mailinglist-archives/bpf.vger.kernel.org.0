Return-Path: <bpf+bounces-65373-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87174B21532
	for <lists+bpf@lfdr.de>; Mon, 11 Aug 2025 21:13:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 375233B760D
	for <lists+bpf@lfdr.de>; Mon, 11 Aug 2025 19:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDE122E2830;
	Mon, 11 Aug 2025 19:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TrKpYHq+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f67.google.com (mail-ej1-f67.google.com [209.85.218.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F261A2C325B
	for <bpf@vger.kernel.org>; Mon, 11 Aug 2025 19:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754939618; cv=none; b=ocsiYE1tLjFxuAsMs2ryp6VRjr6MrurR8Howg/e2/PyFiBhgYbQHwmRLLDDJ/Wu0e8aNMqyySPEsWC4xck+E5yNDZ+IGZvUqaE1aN6clM0Y3l8KcVCSQy537+hlt+wT+eQJxGdhfRWyiFQ6uGwGbz6mM+iKt1S6+4ttuzYnT3og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754939618; c=relaxed/simple;
	bh=mzddLA8ovLFMr0yyaCYSH+dESKpwAg+txMGpFiWjq/4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KiHosMCdT+s4nq+0jBkVIB44VB4RMt8uoHptCpcrp/d4XddaECv4aUF6VXKMxjRLjC5/Z29phJWFXwZHQDF/DRvaoNGPhl1R6pOHlZpQ8Kk5U85cKLU+XlHkDjNvdI5qQXeN8UzHpBR1qbiWszjhLBfa0HS1CxELIG7Uv3fnGqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TrKpYHq+; arc=none smtp.client-ip=209.85.218.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f67.google.com with SMTP id a640c23a62f3a-af93c3bac8fso670323566b.2
        for <bpf@vger.kernel.org>; Mon, 11 Aug 2025 12:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754939615; x=1755544415; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zj/B8LKzoSNaB24S1XGvGsgKEH2VyksT1d7iS6VRhWY=;
        b=TrKpYHq+JWY4t4dkvLZJzpW1vk6dCBccdLxpNDWnSkPVCWKutXkvaeGTZ23Y6Kls9V
         EKaw/GKL+r2m5xNTA1gjHFyvvI3JVV9Ju6O2tC1Ry774JPrW85AJm5iDFwCdg7xS9IEC
         WZGe79lOO9QV6DYVGc5Ke+7ovDoowgoHhrecSJs4q3ZcHJm1lBW7A6qpb+FoW2x+KF6p
         eyyxQRp1QBmPw8xj/O8TJBsnKurQgZFPwhGr3e7vJX1BTV+5taZUYAOYrB/YMtyV0ttl
         saaFePm8C7w3Urf02ESOs6nVfqnfF19jYSIhi4CxwY5NfPMFFzBsVdILSA4KXzrpNrhT
         ax0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754939615; x=1755544415;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zj/B8LKzoSNaB24S1XGvGsgKEH2VyksT1d7iS6VRhWY=;
        b=RQ3t7yKI8HcW11yKGLnt1sOMhKiEAxi7mxgJ9o7UHXhDKz+TY/7LnWuw4J3bChA0Fy
         uqpd+ywSWX5p8FfUCNfkATfJNq8V19FVlnnfXPmlcSOc3hSEa7Z3k+TvDMdfgI85+8bn
         jtVkq3AEagaRc0dtSb8s2XX3CsKX+owQskW+noT4yV7eqxI8Psu4UkkwuJEvKA9aZA+R
         Un/3oFo+vVBNb/OzkP0SCh4LT3f97ektoPYCEoiPok0wy9kcwuaDT7NhEUbTBw5yXQRS
         Yd3fajHRpltMGUEKAkrUADVZbeYAeHvS6MlsEnybPy6WJmK3DgWnZ0vtYQDHR3Mzc8oi
         x4Og==
X-Gm-Message-State: AOJu0YyCzxvrPJBhSX3NhzkojqjpwDeQy543hAe1gwLptITNcQVtWWYv
	YIj4JJePolViWVs3WAyzdpMI2sszc7eLPolAGC9Elt/9XJcPtLaNbKjK2uO6i3uaKG6eQOkM5uz
	EWuy9LueFUSsp+Z9Rb6O6o4+z+q2bbDO819rGQxY=
X-Gm-Gg: ASbGncsEm7FxbZdGUcMaLETGzgp4Hhz/PbPTmqPEQRSrLVDtgbvFme1uAn/v1/aRI17
	izMwKNRGJHfKhHvYhzrO2njGA/EpeHVSIm21ccyeUc43D2iEji1YkcfTEByFWKHDqEXIj3a3MLR
	/rKvhEo1wT81K9opUX3nJ/ibvGbTiSmuZcvb5AGxUDUsnN5M9uoqThgkYPBPnSQjK0LMO4TUFrl
	JUggx7nVWqZfRg3p5lBVe7M91w+87sTXWc7b+DU
X-Google-Smtp-Source: AGHT+IGkkJe2v3PJQ+RZKzzw3X4oea9/4ehmT22t4YfvbDcJAKSZUDKDdgTQwT5jdVb87NjXHRZ/4r6Qg7OPVJ3fl64=
X-Received: by 2002:a17:906:3ace:b0:af9:21cb:23d4 with SMTP id
 a640c23a62f3a-af9c64f456emr1070235166b.36.1754939614725; Mon, 11 Aug 2025
 12:13:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250811175045.1055202-1-memxor@gmail.com>
In-Reply-To: <20250811175045.1055202-1-memxor@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Mon, 11 Aug 2025 21:12:58 +0200
X-Gm-Features: Ac12FXxJ55q9G_IY_D-MF_VAoKYnkO58xgoF86QJMEwU_KYLgVt3Ydpl4jiEnD0
Message-ID: <CAP01T7761TJC+-A3hnGXuz=7qsWFTCaf4Y+opti2pcvAE6E4YA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 0/2] Remove use of current->cgns bpf_cgroup_from_id
To: bpf@vger.kernel.org, tj@kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Dan Schatzberg <dschatzberg@meta.com>, kkd@meta.com, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 11 Aug 2025 at 19:50, Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
>
> bpf_cgroup_from_id currently ends up doing a check on whether the cgroup
> being looked up is a descendant of the root cgroup of the current task's
> cgroup namespace. This leads to unreliable results since this kfunc can
> be invoked from any arbitrary context, for any arbitrary value of
> current. Fix this by removing namespace-awarness in the kfunc, and
> include a test that detects such a case and fails without the fix.
>

The CI failure is probably because of the ugly unshare(2), I will fix
and respin.

> Kumar Kartikeya Dwivedi (2):
>   bpf: Do not limit bpf_cgroup_from_id to current's namespace
>   selftests/bpf: Add a test for bpf_cgroup_from_id lookup in non-root
>     cgns
>
>  include/linux/cgroup.h                        |  2 +-
>  kernel/bpf/cgroup_iter.c                      |  2 +-
>  kernel/bpf/helpers.c                          |  2 +-
>  kernel/cgroup/cgroup.c                        |  7 ++-
>  .../selftests/bpf/prog_tests/cgrp_kfunc.c     | 48 +++++++++++++++++++
>  .../selftests/bpf/progs/cgrp_kfunc_success.c  | 12 +++++
>  6 files changed, 69 insertions(+), 4 deletions(-)
>
>
> base-commit: fa479132845e94b60068fad01c2a9979b3efe2dc
> --
> 2.47.3
>

