Return-Path: <bpf+bounces-16626-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D938803ECC
	for <lists+bpf@lfdr.de>; Mon,  4 Dec 2023 20:53:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EC931C20AC1
	for <lists+bpf@lfdr.de>; Mon,  4 Dec 2023 19:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FFAD33085;
	Mon,  4 Dec 2023 19:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lchZRCU8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CCCAD2
	for <bpf@vger.kernel.org>; Mon,  4 Dec 2023 11:52:50 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-40bda47c489so28853695e9.3
        for <bpf@vger.kernel.org>; Mon, 04 Dec 2023 11:52:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701719569; x=1702324369; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=V3AFsn1vLuBgQ6Oa4djS64gIZYk+ctcwaIcDHfEhNE8=;
        b=lchZRCU8rXCaH+7hFnarFEWOmKnhHRKPgVOS0scVzZqZZ5a3grGoQNaXfP4FmYW6/2
         ZQ19bOfIydgWbGanWqFp6PUemu+Yeel581Na/zXSM6t+jTjYnucn9eT/nR0vxT3/M8d8
         S6hYWn4ASxHSxf4570bR5Wwyq3hhiw6px41zvAG84IUDD2uuIrbLPcv38Yu+Kb5py9Ui
         w0sVMAbDlORfG6qLB2x3Q3KKg44UaTO2fvJfaeSOnwP9mn0JRFjK4chnnogNNbCqyI5c
         ZKXK+zN27AMNbTMTXLk345pZ/BRsPWd7u8SEf9Oixr0oEEner7ulO5d7Aygl3pj3MYiF
         8LtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701719569; x=1702324369;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V3AFsn1vLuBgQ6Oa4djS64gIZYk+ctcwaIcDHfEhNE8=;
        b=UIkVqtqsUB7r5NWMAumq1tmHpbFbr5QV8Bci4niSTqSThKdgRM0ZJgIXzqBFxvihYY
         R07+sLMZRvrTi8TPoU2wyYpSUYR6z7z2ju5hsI1FM0JTogvFUkQCLlc4BxaPA2DqlGhZ
         4/175W+U45sXLLUEPNzqGum/ea5WQRj5+/wCbDLtkS8PJnD8W4yjc4J3iCler5yjUpHG
         pmKMqNsSHKygIR92xxTENGK9Us2EiGgVuEc2dZXjqg7nrxHblJG6K/MWC7GdHkSf+rkY
         oAKYFj4XVW5LpjilB+jKEmepstlSpOPxZQm7s9h+fKOvbYfa+QAWTIKPfiueunotLnmv
         BJHQ==
X-Gm-Message-State: AOJu0YycyPnNlDzc+U5AFRQtumr1Uen6LtNC2fI+/kJFSl0/v+SW9iH0
	nJOCEzQ2YiuRtSRs+3ckSGT2aiEz2a05dzUNDYwhzn28H0OmaA==
X-Google-Smtp-Source: AGHT+IF0waVb4HyIfNO5JROLKYXvxdKkhfXZHpXa+qSdo3VpCjukGMMMxxZL/qYKjXHGDe8C3Tr/LpCc0cp08cJJiuU=
X-Received: by 2002:a05:600c:22da:b0:40b:578d:2487 with SMTP id
 26-20020a05600c22da00b0040b578d2487mr3198902wmg.38.1701719568472; Mon, 04 Dec
 2023 11:52:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231204153919.11967-1-andreimatei1@gmail.com> <CAEf4BzZ57kAWYDBwpxxAsWRyo5fvnHf5-R+OZuPSd1L-viQDig@mail.gmail.com>
In-Reply-To: <CAEf4BzZ57kAWYDBwpxxAsWRyo5fvnHf5-R+OZuPSd1L-viQDig@mail.gmail.com>
From: Andrei Matei <andreimatei1@gmail.com>
Date: Mon, 4 Dec 2023 14:52:36 -0500
Message-ID: <CABWLsetTu3fBcJaVhC8D-ZDBR0n4HM5xkhk1pA9KA+_-nZy9cw@mail.gmail.com>
Subject: Re: [PATCH bpf V2 1/1] bpf: fix verification of indirect var-off
 stack access
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, sunhao.th@gmail.com
Content-Type: text/plain; charset="UTF-8"

[...]

> >
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index af2819d5c8ee..b646bdde09cd 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -6816,10 +6816,9 @@ static int check_stack_access_within_bounds(
> >                         return -EACCES;
> >                 }
> >                 min_off = reg->smin_value + off;
> > +               max_off = reg->smax_value + off;
> >                 if (access_size > 0)
> > -                       max_off = reg->smax_value + off + access_size - 1;
> > -               else
> > -                       max_off = min_off;
> > +                       max_off += access_size - 1;
>
> this special casing of access_size == 0 feels wrong (and I mean before
> your patch as well).
>
> Looking at the code, we only really calculate max_off to check that we
> don't go to a non-negative stack offset, e.g., r10+0 or r10+1 (and
> beyond).
>
> So given that, I propose to calculate max_off as an exclusive bound,
> and instead of doing a mostly useless check_stack_slot_within_bounds()
> call for it, just check that max_off is <= 0.
>
> Something like this:
>
> min_off = reg->smin_value + off;
> max_off = reg->smax_value + off + access_size;
> err = check_stack_slot_within_bounds(min_off, state, type);
> if (!err && max_off > 0)
>     err = -EINVAL; /* out of stack access into non-negative offsets */

Dealing with access_size == 0 indeed feels dubious to me, but I'm not entirely
sure that your suggested code is better. min_off being inclusive and
max_off being
exclusive seems surprising. I'll do it if you want, I don't care too much.
We could keep max_off exclusive, and still not call
check_stack_slot_within_bounds() for it:

 min_off = reg->smin_value + off;
 max_off = reg->smax_value + off + access_size - 1;
 err = check_stack_slot_within_bounds(min_off, state, type);
 if (!err && max_off >= 0)
     err = -EINVAL; /* out of stack access into non-negative offsets */

But now max_off can be below min_off, which again seems confusing.

What I'd really like to know is whether this whole zero access_size business
deserves to exist. Do you know what the point of verifying a zero-sized access
is exactly / could we turn 0-byte access into 1-byte accesses and
verify that instead?
Because then there'd be no more special case to consider.

>
>
> Now, one more issue that jumped out at me is that we calculate min/max
> off as a sum of smin/smax values (which are checked to be within
> +/-1<<29, all good so far) *and* insn->off, which can be a full s32,
> it seems. So we are running into overflow/underflow territory with
> using int for min_off/max_off.
>
> While you are at it, can you please use s64 for all these calculations? Thanks!
>
>
> >         }
> >
> >         err = check_stack_slot_within_bounds(min_off, state, type);

Will do.

