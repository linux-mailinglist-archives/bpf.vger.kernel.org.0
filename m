Return-Path: <bpf+bounces-16162-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93B107FDD91
	for <lists+bpf@lfdr.de>; Wed, 29 Nov 2023 17:48:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A0B42828E2
	for <lists+bpf@lfdr.de>; Wed, 29 Nov 2023 16:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 008D03B2A4;
	Wed, 29 Nov 2023 16:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C0X/KgAr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAAE8A8
	for <bpf@vger.kernel.org>; Wed, 29 Nov 2023 08:48:43 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-54b8276361cso25382a12.0
        for <bpf@vger.kernel.org>; Wed, 29 Nov 2023 08:48:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701276522; x=1701881322; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4FoXckHtY9mbHcduW+jUCe5arR3X2BF/Pn9a/rzYqSE=;
        b=C0X/KgAr3bT4F6MlSSBae8185+cTEHKnxiK34REJUlJzYvueEVmzdTRT1g9Qmg3qrI
         hqsUKdN7XLlAtq61N0MY7LeydENMgOE6zOq7/YgGGPTjqMEcPWYTAnLWrJqqrOm0PzNN
         g7HKpqiOesqtwpC+/xOiF6y9X1zI0PLUga1bJBMW9dgcRy4wIensCBtfQf5GbsVYtvS+
         XIao2wkQhy8qIoh78HfjFNueex2JF0w19jBuvLNyY7N0nlY2F6MqSATId19swgqqwYKZ
         Ep4anZBY5FG5M5KrVVG7PqANVDz/1U/1iWocV2La0JQjN7HpPK34SuHXnrWd1pi1y378
         XWAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701276522; x=1701881322;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4FoXckHtY9mbHcduW+jUCe5arR3X2BF/Pn9a/rzYqSE=;
        b=GzaHsOq9F8gC2taGYso5LgG+VPBGiMbzr5NHwzjYbdU9D7lvyoCuMzd48X2dGAKyve
         PXlwIJNqeS89lDafCEuT0m/GkyU81lH1NLJD2DdeA/yttqz76ulDWLS0n/bM9hLvktab
         74NVeLEWgrUCL1G2yqVqojK8W+oeJKv9sSJq6onZCj5ZdFecb6YN9yGE3E6bUPNyW9g4
         7ybNW3mk5gkBhCkjVEJmkkarDCcOABf4Vyivy9lLkODNUWODf+cWASX1HI1y0UDhCkK5
         VHybov4fUHkXcs0GcsEgdJJrTu08F/NJYnP1NXmGpgqpM7LWkgZ2yTjoTLfjgjQMw1B0
         YELQ==
X-Gm-Message-State: AOJu0YwbbP9U37Qa+Js4pTF0T58jgnWyKDr3WB8tOgr6XshSRLuL2VqP
	bgWNw4vLR+Z0m3bQgWwfPgen/s6IitQWYtQ6cSg02CP0mzm3sQ==
X-Google-Smtp-Source: AGHT+IGtiuTr9OwGumExf54y6EAIBr4cYIgU0j2FrfI9DhYEWDHIMWL5AKWTKhHYwYGhqgV9NIUbERGEBjRumFyqOOM=
X-Received: by 2002:a17:906:bcef:b0:a02:609a:5c6c with SMTP id
 op15-20020a170906bcef00b00a02609a5c6cmr14298094ejb.44.1701276522005; Wed, 29
 Nov 2023 08:48:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231126015045.1092826-1-andreimatei1@gmail.com>
 <20231126015045.1092826-2-andreimatei1@gmail.com> <CAEf4BzacRRwzdQH8LuQkV695=rm65jnv1bX2n9gks6G+wGAw6w@mail.gmail.com>
In-Reply-To: <CAEf4BzacRRwzdQH8LuQkV695=rm65jnv1bX2n9gks6G+wGAw6w@mail.gmail.com>
From: Andrei Matei <andreimatei1@gmail.com>
Date: Wed, 29 Nov 2023 11:48:30 -0500
Message-ID: <CABWLses9f6izTmODQf_hKwhvH54-vpWrzWHP_KRG=n8gRWpp-w@mail.gmail.com>
Subject: Re: [PATCH bpf v2 1/2] bpf: fix accesses to uninit stack slots
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, sunhao.th@gmail.com, eddyz87@gmail.com, 
	kernel-team@dataexmachina.dev
Content-Type: text/plain; charset="UTF-8"

[...]

> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index af2819d5c8ee..f9546dd73f3c 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -1685,10 +1685,12 @@ static int resize_reference_state(struct bpf_func_state *state, size_t n)
> >         return 0;
> >  }
> >
> > -static int grow_stack_state(struct bpf_func_state *state, int size)
> > +/* Possibly update state->allocated_stack to be at least size bytes. Also
> > + * possibly update the function's high-water mark in its bpf_subprog_info.
> > + */
> > +static int grow_stack_state(struct bpf_verifier_env *env, struct bpf_func_state *state, int size)
> >  {
> >         size_t old_n = state->allocated_stack / BPF_REG_SIZE, n = size / BPF_REG_SIZE;
>
> shouldn't this be rounding up? (size + BPF_REG_SIZE - 1) / BPF_REG_SIZE?

You're saying this was always broken, regardless of the current patch, right? I
think you're right, but that seems like a bug that should have been
caught somehow; I'm surprised no programs crashed the verifier. Perhaps in
practice all stack accesses are 8-byte aligned, so the rounding doesn't matter?

I'll spend a bit of time reading code and come back.

[...]

