Return-Path: <bpf+bounces-65340-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53B63B20BD4
	for <lists+bpf@lfdr.de>; Mon, 11 Aug 2025 16:27:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5493E3B2AD3
	for <lists+bpf@lfdr.de>; Mon, 11 Aug 2025 14:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6B1E23B606;
	Mon, 11 Aug 2025 14:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e9EQRBI9"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F45F2397A4
	for <bpf@vger.kernel.org>; Mon, 11 Aug 2025 14:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754922253; cv=none; b=ca9RtusyGVl/YWAwqmrIvmKRbvLi2tiLcDqgsAQHOKINpHkQqZ57OqMpiHe6srE2M31Eu8AiMfn3UecFxjf3yboGfCEhmRm4O6gOuKHkUy7A2hn34aWBA2VVl7dkd5p5ehJ1pOeiTYyMufK6B5kDkAm2T3fv3uJdOHIz3ro9Wx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754922253; c=relaxed/simple;
	bh=y54uHbKJnL4X8HbYK5mRijobivOkYRL4IYus4ChAimg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B9U7PzngW99H/Fgxdv0jfQQ+E+nktoAtAPU5lhNKz5KYNfuGWs77oqq2SYfZIm8bGp7Fhe6/f3B9zhzNADOEB1gLFh0wk+qFOCqSOXKTDMN/JboyoL246hvZ6vsC9VKTnmj/39J1FMjEeaW4XUXlj6TjRRgVyl0dYjDzoLrGeWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e9EQRBI9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F22F0C4CEF8
	for <bpf@vger.kernel.org>; Mon, 11 Aug 2025 14:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754922253;
	bh=y54uHbKJnL4X8HbYK5mRijobivOkYRL4IYus4ChAimg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=e9EQRBI90nyUC9yki9qRFcNMEdIoP5viGav7HvYvoK5C073ZYcqJ8vYgAlA0xZ5YZ
	 ySFbhKwDHsHzsiSf+8onqOaqrb4DkAOkCoXzpiG/X9NVX2SteDFi4WlGPldSV6IYig
	 ugHcwBrhiZjtB2sepjyS1w5HAltyx68gUhoVgozcy/3oqYgEhO4h2VE5xWixB3cwFG
	 qpsrQ1Yy3TPIXMt90wPRKDsCnORt8Szto8R7T/f9xRSYPD9OWVGbrFjZlvn8xr6Pzj
	 JR9yHoF8eurK3VKPrngGIjSm3ugsfnsbpJOjbigFpHgMY4qNglSrwnbUp5NDZ9kJm6
	 Sd8QcFP3gNzsQ==
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6154655c8aeso6163292a12.3
        for <bpf@vger.kernel.org>; Mon, 11 Aug 2025 07:24:12 -0700 (PDT)
X-Gm-Message-State: AOJu0YzPJnO3Ev7jydSE2UumS6EJi4E8G/QlbYai0qaykFzVctJknaZg
	3w+Lfufygbfam+cd61/uHca+8Z2Gnwqay5KGt2cUsyElPqtni8rDr4ckQXFkFwyKHcYgPfQbsBq
	HERMS0yC1GwharnLhaboeh1lSbpWnO2gooYsbSPca
X-Google-Smtp-Source: AGHT+IHo9DcI0nz5oLtF5ZoCb/t25wgS4J1gVaS9v5nTyvXcR2nKDXXjxHWOHYnBOZEFJUSXbIX/IMzWeVx+A34LQ88=
X-Received: by 2002:a17:906:9fd0:b0:af9:495b:99e1 with SMTP id
 a640c23a62f3a-af9c65b086cmr1286417966b.43.1754922251592; Mon, 11 Aug 2025
 07:24:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250721211958.1881379-1-kpsingh@kernel.org> <20250721211958.1881379-14-kpsingh@kernel.org>
 <CAADnVQ+3XYyJY_zcQtNPt81zyJwK4zv5oA+SLN9ohoLkD9XyZg@mail.gmail.com>
In-Reply-To: <CAADnVQ+3XYyJY_zcQtNPt81zyJwK4zv5oA+SLN9ohoLkD9XyZg@mail.gmail.com>
From: KP Singh <kpsingh@kernel.org>
Date: Mon, 11 Aug 2025 16:24:00 +0200
X-Gmail-Original-Message-ID: <CACYkzJ48iNq902tRNJ18pd+wyqwdnKJrG40QFZWneRhiwjJDbA@mail.gmail.com>
X-Gm-Features: Ac12FXw7kOiFzTlcYrO8-2DFOyRsceTpCaGTpWBuKZY1oXQujmd8hYWHtiHPMx4
Message-ID: <CACYkzJ48iNq902tRNJ18pd+wyqwdnKJrG40QFZWneRhiwjJDbA@mail.gmail.com>
Subject: Re: [PATCH v2 13/13] selftests/bpf: Add test for signed programs
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, LSM List <linux-security-module@vger.kernel.org>, 
	Blaise Boscaccy <bboscaccy@linux.microsoft.com>, Paul Moore <paul@paul-moore.com>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 29, 2025 at 4:30=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Jul 21, 2025 at 2:20=E2=80=AFPM KP Singh <kpsingh@kernel.org> wro=
te:
> > +
> > +SEC("fexit/bpf_prog_verify_signature")
> > +int BPF_PROG(bpf_sign, struct bpf_prog *prog, union bpf_attr *attr, bo=
ol is_kernel, int ret)
>
> I don't understand why it needs to peek into the kernel to
> verify that it goes well. The exposed uapi should be good enough.
> If the signature was specified and it is loaded fine we're good.
> Double checking the kernel decisions goes too far.
> Especially since this function can be inlined by the compiler.

Fair, I will drop this patch

- KP

