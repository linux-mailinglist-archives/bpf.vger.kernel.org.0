Return-Path: <bpf+bounces-45419-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 132509D552E
	for <lists+bpf@lfdr.de>; Thu, 21 Nov 2024 23:08:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A4AC1F237AC
	for <lists+bpf@lfdr.de>; Thu, 21 Nov 2024 22:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D09541DC198;
	Thu, 21 Nov 2024 22:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vhjdi+93"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f65.google.com (mail-ej1-f65.google.com [209.85.218.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 923BC1DA103
	for <bpf@vger.kernel.org>; Thu, 21 Nov 2024 22:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732226917; cv=none; b=B4ixu1yOdBMz7hxZNWOkkSRGVvjH39y5ws0C5X+Y56TMcS1FRW+fgfxn+xL4uMUUpKJexOWJbh4XoPEZSEAueAjm6g9pnu3AiHt3FeBP/vDCAAgeDNVRUnQlpDimS2FrV8bP4b8e+mHcU2kyHcbu/EVizn7O4cEhBhlIQiFTskI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732226917; c=relaxed/simple;
	bh=GXPHlfS+pCSx3NZTZ94Dnmg/uOxvIA25U+en1jcelHc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lwGz/CJsEdB3AHfzSe7FOp67VojH6ofc+uZt0eSBxIbkbT9BQQG3UTrAZV7HdV4jyYemCW2m19hkbHdvuwFKLC+yeDZPG0sAGzCtBM2g/Zqa7EAONDd+1t0Jma4Zb61sef1WkSS+2WjMpE+gxWHSW3cbRVEnrkvG3irr1ee+ymk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vhjdi+93; arc=none smtp.client-ip=209.85.218.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f65.google.com with SMTP id a640c23a62f3a-a99fa009adcso81570766b.0
        for <bpf@vger.kernel.org>; Thu, 21 Nov 2024 14:08:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732226914; x=1732831714; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AyK1I8eGjpRTfg1HLQ49KvXFgKaOFv/TlOKUUdC85YU=;
        b=Vhjdi+939mkhyu0Tu/FFMl9rW2Jl4u7IHvIVKdpiIBUpfMqjwuA6RdXwEkrBcrudL6
         IzNi5vfe9+xDc19l/nR1IND9VZPGu7y/A2WXqaR4FLZlwdZUfFsEM7RHncZOovA5Xb5A
         pfay0xZxDRYtvabOW8DxAYm3r3KwRiAc55R2UAdtbx+mjcDYXdf/TlWD7tW66OoLyIeQ
         f6I4A1I5ZZTxB8N+kK1Jef8WZNKSEKdRXwj0CANsp88NgYWEHlvnYLFARxaADWd6J2QE
         Po2qJaau38yf7m0fxN8uG3BHzyZaNfRZ7EFHmNp67IGDaGQb1EYOlY7HExeIWxdRrjKH
         tz9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732226914; x=1732831714;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AyK1I8eGjpRTfg1HLQ49KvXFgKaOFv/TlOKUUdC85YU=;
        b=UgmhYY/LYkzNtJp/NVOuRCIciFerRorXd/RAVFCB2fu0W4HVEisSXEZQ/lHZObDrkY
         bypWmTvXgQ04fcnafvjOQkKgXDWClCRyHljTLIF2nH5rqcsMGEzrqdbVaB/rFIfPYptj
         0q/1oXAvycSXgKOY8cCHfCWjCBYi+N6fmKZySDdHthYKIo3UqkgTLsN6a2ab9RFAmymx
         LZlOWcb0Eq4gxRBrNLqteOJM5By8hfTNv9jX9HzKtN71LjNmQuRwMigOlrzonc35Seye
         +ncZMtB2LIDsGQqqwDjcxHgvgwseXbX4iYLUrezTJe0PGRlqliaKoiVMM8wBNpJn2xf6
         LA/A==
X-Gm-Message-State: AOJu0YwYBWyc4krlZA1DDWdAqmssEac4Hz+JfzqNoy15x4U+YGo0Q63m
	RmyNvP7r1CrV/rFgIn/DSdagFY2yDdNdF1GkVsHKdqvTReyABm3qxOOJx8IuGOrk+UQUfatWEPx
	2GtnE4BnYZdwKFRcqN/4W8YhrNpI=
X-Gm-Gg: ASbGncs3i5nKlcFdrSpabRjt9ESeZTrMMH/rbFYbcO9WxGIjqL3QeC29qsnXQaun9f9
	F/Du1IMx1Ujl8TXz+ZFY9M+kyf1hmdMZopQ==
X-Google-Smtp-Source: AGHT+IGnJXc6GIvD03zQsuTWFO05GWQBJWQgE55CpUOWstfynVRLi1kPmyaH/5e1GWSFeRBdQUAcH5gQ7Sn9MDYZl4s=
X-Received: by 2002:a05:6402:2713:b0:5ce:d435:c26d with SMTP id
 4fb4d7f45d1cf-5d020662f88mr262644a12.19.1732226913777; Thu, 21 Nov 2024
 14:08:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241121005329.408873-1-memxor@gmail.com> <20241121005329.408873-8-memxor@gmail.com>
 <8db8d815dc263edd8d3883a770c0bc0ac511dd77.camel@gmail.com>
In-Reply-To: <8db8d815dc263edd8d3883a770c0bc0ac511dd77.camel@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Thu, 21 Nov 2024 23:07:57 +0100
Message-ID: <CAP01T74Jb02yxHT9x72PVCUtGoWVZ09v4nHq_RDKYQG0489VYQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 7/7] selftests/bpf: Add IRQ save/restore tests
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, kkd@meta.com, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 21 Nov 2024 at 21:43, Eduard Zingerman <eddyz87@gmail.com> wrote:
>
> On Wed, 2024-11-20 at 16:53 -0800, Kumar Kartikeya Dwivedi wrote:
> > Include tests that check for rejection in erroneous cases, like
> > unbalanced IRQ-disabled counts, within and across subprogs, invalid IRQ
> > flag state or input to kfuncs, behavior upon overwriting IRQ saved state
> > on stack, interaction with sleepable kfuncs/helpers, global functions,
> > and out of order restore. Include some success scenarios as well to
> > demonstrate usage.
> >
> > #123/1   irq/irq_restore_missing_1:OK
> > #123/2   irq/irq_restore_missing_2:OK
> > #123/3   irq/irq_restore_missing_3:OK
> > #123/4   irq/irq_restore_missing_3_minus_2:OK
> > #123/5   irq/irq_restore_missing_1_subprog:OK
> > #123/6   irq/irq_restore_missing_2_subprog:OK
> > #123/7   irq/irq_restore_missing_3_subprog:OK
> > #123/8   irq/irq_restore_missing_3_minus_2_subprog:OK
> > #123/9   irq/irq_balance:OK
> > #123/10  irq/irq_balance_n:OK
> > #123/11  irq/irq_balance_subprog:OK
> > #123/12  irq/irq_balance_n_subprog:OK
> > #123/13  irq/irq_global_subprog:OK
> > #123/14  irq/irq_restore_ooo:OK
> > #123/15  irq/irq_restore_ooo_3:OK
> > #123/16  irq/irq_restore_3_subprog:OK
> > #123/17  irq/irq_restore_4_subprog:OK
> > #123/18  irq/irq_restore_ooo_3_subprog:OK
> > #123/19  irq/irq_restore_invalid:OK
> > #123/20  irq/irq_save_invalid:OK
> > #123/21  irq/irq_restore_iter:OK
> > #123/22  irq/irq_save_iter:OK
> > #123/23  irq/irq_flag_overwrite:OK
> > #123/24  irq/irq_flag_overwrite_partial:OK
> > #123/25  irq/irq_sleepable_helper:OK
> > #123/26  irq/irq_sleepable_kfunc:OK
> > #123     irq:OK
> > Summary: 1/26 PASSED, 0 SKIPPED, 0 FAILED
> >
> > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > ---
>
> The following error condition is not tested:
> "arg#%d doesn't point to an irq flag on stack".
> Also, I think a few tests are excessive.
> Otherwise looks good.
>

Will add.

> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
>
> [...]
>
> > diff --git a/tools/testing/selftests/bpf/prog_tests/irq.c b/tools/testing/selftests/bpf/prog_tests/irq.c
> > new file mode 100644
> > index 000000000000..496f4826ac37
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/prog_tests/irq.c
> > @@ -0,0 +1,9 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
> > +#include <test_progs.h>
> > +#include <irq.skel.h>
> > +
> > +void test_irq(void)
> > +{
> > +     RUN_TESTS(irq);
> > +}
>
> Nit: tools/testing/selftests/bpf/prog_tests/verifier.c
>      could be used instead of a separate file.
>
> > diff --git a/tools/testing/selftests/bpf/progs/irq.c b/tools/testing/selftests/bpf/progs/irq.c
> > new file mode 100644
> > index 000000000000..5301b66fc752
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/progs/irq.c
> > @@ -0,0 +1,393 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
> > +#include <vmlinux.h>
> > +#include <bpf/bpf_helpers.h>
> > +#include "bpf_misc.h"
> > +
> > +SEC("?tc")
> > +__failure __msg("BPF_EXIT instruction cannot be used inside bpf_local_irq_save-ed region")
>
> Nit: I know this is not a fault of this series, but the error message
>      is sort of confusing. BPF_EXIT is allowed for irq saved region,
>      just it has to be an exit from a sub-program, not a whole program.
>
> > +int irq_restore_missing_1(struct __sk_buff *ctx)
> > +{
> > +     unsigned long flags;
> > +
> > +     bpf_local_irq_save(&flags);
> > +     return 0;
> > +}
>
> [...]
>
> Nit: don't think this test adds much compared to irq_restore_missing_2.
>
> > +{
> > +     unsigned long flags1;
> > +     unsigned long flags2;
> > +     unsigned long flags3;
> > +
> > +     bpf_local_irq_save(&flags1);
> > +     bpf_local_irq_save(&flags2);
> > +     bpf_local_irq_save(&flags3);
> > +     return 0;
> > +}
>
> [...]
>
> > +SEC("?tc")
> > +__success
> > +int irq_balance_n_subprog(struct __sk_buff *ctx)
>
> Nit: don't think this test adds much given irq_balance_n()
>      and irq_balance_subprog().

My idea with both of these was to ensure when the state is copied in
and out on calls and when we're doing one or more than one
save/restore (which links prev_id into active_irq_id etc.) we don't
have problems, so they were definitely testing different scenarios.
But with the move into bpf_verifier_state they will indeed become
redundant, so I'm going to drop them in v2.

>
> > +{
> > +     local_irq_balance_n();
> > +     return 0;
> > +}
>
> [...]
>

