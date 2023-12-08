Return-Path: <bpf+bounces-17094-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C23AF809A35
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 04:23:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72297282262
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 03:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4338C3FD4;
	Fri,  8 Dec 2023 03:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iBXk5hTI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C274E10CA
	for <bpf@vger.kernel.org>; Thu,  7 Dec 2023 19:23:35 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-40c07ed92fdso17213205e9.3
        for <bpf@vger.kernel.org>; Thu, 07 Dec 2023 19:23:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702005814; x=1702610614; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=N3aAY+JDjgYmq98gNQCxYl2P93YTjavqCcs5brodI+w=;
        b=iBXk5hTI3UHCnyzlPJjeKqZsmcrZIKI585V7urU02NP7/RwJIjhHCzuviAijpva+Uc
         GMTkQSebLb7ygLnTE2ryVSKNNK9YF6XrIE23mzOETSo1b+DEz4KtsmBVjfEyFEXMkCYR
         xyXxxiLKdPtrAkPcANxSRKEqBVNkTxaO+5EdxbXgvLaECxIq39ILsqpHqXWDBJjgosiD
         3bxlUnBnTDlH96CYSUm+kYonGhcRJNgnPzIl54kU84/0WD9jWWhRQ4HJl/oCbTCr2QX6
         DmegOxJzJN6usam7v/vuvTQZXHu/BXMKi7n/8b2q8YdEc8gDnKUo7I+iK4zGp0xbeKfx
         li8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702005814; x=1702610614;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N3aAY+JDjgYmq98gNQCxYl2P93YTjavqCcs5brodI+w=;
        b=AC39ChlgxliEN/QnnipBel9lrYi0t3qDmoiMfPkEJCc+iHb09kTXoA0ZK+xlUgl6Rp
         viBWH88IFPsUzv8xBAANwU0/h4OVJOcLhUZIIRndFrTok3OLwEmBTOsOB8Ep42rL/cDd
         lhI8tgqYrB5srS9rtp1Kz6RxyRbFPu6XpvQ2JsZIxeUWCbfA0DNvooe55bbe/t0kUxoh
         G4LDT9wBG5vRkmMU4V5i2csEhBqA4twzB3PTReONka6aaH4s+rNIwmyZwYBs4lmFrM/e
         tEzvHTEA/dwE6cGLfWroyveIFEAfp7+BBMSEPJz0/H/zUOCeXX2LlYcSY3fAgyz9R23p
         Wp+Q==
X-Gm-Message-State: AOJu0Yx99BtI7922utJwWRnWnP8B2agLpcSTEmOWv6h6LszA3MsKSBIq
	Ez+4KKrdD4BmvwkteGMTz4+ymxBSWEfkzCNmS2w=
X-Google-Smtp-Source: AGHT+IFmVVfeJyNaoWtbZK3xhgezgRpgC9Wy5Ik+/m0+JDRBDBUejvMOMlBHUcYM8fb0UAHLDnxCzy1JzofkKT6qsdc=
X-Received: by 2002:a05:600c:3d9a:b0:40b:5e59:b7d8 with SMTP id
 bi26-20020a05600c3d9a00b0040b5e59b7d8mr1930077wmb.181.1702005813721; Thu, 07
 Dec 2023 19:23:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231204153919.11967-1-andreimatei1@gmail.com>
 <CAEf4BzZ57kAWYDBwpxxAsWRyo5fvnHf5-R+OZuPSd1L-viQDig@mail.gmail.com>
 <CABWLsetTu3fBcJaVhC8D-ZDBR0n4HM5xkhk1pA9KA+_-nZy9cw@mail.gmail.com>
 <CAEf4BzYhn7wD102_5E0jqiP4yH7prb-RyTTHaF_3fuVPVN--Og@mail.gmail.com>
 <CABWLses4A1W4kMAqiEd8drL6PKiK7egk_btT7OH3C=LxC4vefQ@mail.gmail.com> <CAEf4Bzb6+dF5r4rvcPakoVS_+GOXVs=3wgPEvFMoiGxwB0evqA@mail.gmail.com>
In-Reply-To: <CAEf4Bzb6+dF5r4rvcPakoVS_+GOXVs=3wgPEvFMoiGxwB0evqA@mail.gmail.com>
From: Andrei Matei <andreimatei1@gmail.com>
Date: Thu, 7 Dec 2023 22:23:21 -0500
Message-ID: <CABWLseupmKtmQX4SnRF0r9taU4QNwQunU+f79QFQ1V4KXo=TKA@mail.gmail.com>
Subject: Re: [PATCH bpf V2 1/1] bpf: fix verification of indirect var-off
 stack access
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org, sunhao.th@gmail.com
Content-Type: text/plain; charset="UTF-8"

[...]

> >
> > Ack. Still, if you don't mind entertaining me further, two more questions:
> >
> > 1. What do you make of the code in check_mem_size_reg() [1] where we do
> >
> > if (reg->umin_value == 0) {
> >   err = check_helper_mem_access(env, regno - 1, 0,
> >         zero_size_allowed,
> >         meta);
> >
> > followed by
> >
> > err = check_helper_mem_access(env, regno - 1,
> >       reg->umax_value,
> >       zero_size_allowed, meta);
> >
> > [1] https://github.com/torvalds/linux/blob/bee0e7762ad2c6025b9f5245c040fcc36ef2bde8/kernel/bpf/verifier.c#L7486-L7489
> >
> > What's the point of the first check_helper_mem_access() call - the
> > zero-sized one
> > (given that we also have the second, broader, check)? Could it be
> > simply replaced by a
> >
> > if (reg->umin_value == 0 && !zero_sized_allowed)
> >     err = no_bueno;
> >
>
> Maybe Kumar (cc'ed) can chime in as well, but I suspect that's exactly
> this, and kind of similar to the min_off/max_off discussion we had. So
> yes, I suspect the above simple and straightforward check would be
> much more meaningful and targeted.

I plan on trying this in a bit; sounds like you're encouraging it.

>
> I gotta say that the reg->smin_value < 0 check is confusing, though,
> I'm not sure why we are mixing smin and umin/umax in this change...

When you say "in this change", you mean in the existing code, yeah?  I'm not
familiar enough with the smin/umin tracking to tell if `reg->smin_value >= 0`
(the condition that the function tests first) implies that
`reg->smin_value == reg->umin_value` (i.e. the fact that we're currently mixing
smin/umin in check_mem_size_reg() is confusing, but benign).  Is that true? If
so, are you saying that check_mem_size_reg() should exclusively use smin/smax?


[...]

