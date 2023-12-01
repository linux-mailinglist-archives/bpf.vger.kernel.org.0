Return-Path: <bpf+bounces-16453-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FB13801389
	for <lists+bpf@lfdr.de>; Fri,  1 Dec 2023 20:26:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E7031C20C98
	for <lists+bpf@lfdr.de>; Fri,  1 Dec 2023 19:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87B7E4F60A;
	Fri,  1 Dec 2023 19:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AF6WMzBV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 585E2FF
	for <bpf@vger.kernel.org>; Fri,  1 Dec 2023 11:26:23 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-54bfd4546fbso2952104a12.1
        for <bpf@vger.kernel.org>; Fri, 01 Dec 2023 11:26:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701458782; x=1702063582; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WZHIUxJ1bCWBAd6+e7sWPrQQdQsnqvAjkP3eNMiUjN0=;
        b=AF6WMzBVRC640hcv149b9wVz0TSQ8jOuIMveu02CJqpqD8C3DMLgGLduPdsQYR2r3i
         bFCUN356k5+B56ACGnD1k2s32dKqkQQ9jMWyfhYOG/2F+LiunYr8VotyPF6jmigQVDoZ
         nSxkJJY9+v+Zald0BvoLFUKUtlyNuS6uhBtJhwbIM8D3Xm9ndgsmWALguYtaIVRlW7BO
         mnz1YMxs+63FLxtd0sEreo/dIaAu6Efn4DLeZ79ytWcs0SclCu2/E1HZG+79yqSXUQ/y
         s3SsypYeSPrRfsN5/6SZ1n+B/zeeI96iVtiDr/Gnpgc3pIcZt5m8BFT5sRJIB0tiwbHI
         XUaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701458782; x=1702063582;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WZHIUxJ1bCWBAd6+e7sWPrQQdQsnqvAjkP3eNMiUjN0=;
        b=LIt2jKp3AIlYUWnirTH59CrLgMylvnIBQ26+cYjCYn/SYPJDP4damqd40hfPvdCQwZ
         8sHnl94r1kXcFH36WBJR25b9iXa2tlWVoJTUYlPp3MaKAj3vFKZ/blHRmduYLMhYhAFY
         nCGHBBMq2XlxgDxlQMX/svKk7hV0S1Dy1LDDp1NWY8lHc2x2u7NTlvEjyQfzjrt28Ezj
         eqBrMbx7PSSOCLG4+wT8sfvw9AideAAO7toRsxAffC1SJGXQ/VH01b2mRJJf+KgZNT9d
         G6Vj1ZcTXFLc+yGo3u6v8r6WpHZu+czagS8Ew20KbzGK7Vl4Vqh93P0nrolY9iOv7cCh
         epgA==
X-Gm-Message-State: AOJu0YxwgIVL6BXkx3vBGpnmHL5cKbU24PUSja0K3B6z+xuHPoTgLKTC
	FtIcG1vYXoXpKavWGGqLuecOURfQbzTwEPcY2D0=
X-Google-Smtp-Source: AGHT+IF4TFTJpxRGRT8bsHku8pO6SMwRK63fjEN70epDG3mUYHOu45zCBw0owOqSQYGneiLQuCxSNAU1mrzU0gFh8D4=
X-Received: by 2002:a17:906:5198:b0:a19:a19b:78d6 with SMTP id
 y24-20020a170906519800b00a19a19b78d6mr848470ejk.153.1701458781753; Fri, 01
 Dec 2023 11:26:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231201013006.910349-1-andrii@kernel.org> <68fc1915f6d0fec5d4503052dfabe0f0f9fb6d91.camel@gmail.com>
 <CAEf4BzYgdX4m15fV9Xujk8RRDbwNH5zWuV6Wb+k2+NXigJ5nNA@mail.gmail.com> <583eb34882904c94f74a737650c20ac2d2fe18fa.camel@gmail.com>
In-Reply-To: <583eb34882904c94f74a737650c20ac2d2fe18fa.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 1 Dec 2023 11:26:09 -0800
Message-ID: <CAEf4BzacfRnmmYV+_qKhFX0Ydw7zmsJjm_YxVNHDWxF6E9Pd-Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: validate eliminated global
 subprog is not freplaceable
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 1, 2023 at 11:20=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Fri, 2023-12-01 at 11:17 -0800, Andrii Nakryiko wrote:
> [...]
> > > Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> >
> > Oops, didn't see your reply before sending v2. But there will be v3 any=
way :)
>
> np
>
> [...]
> > > Nit: the log is not printed if verbose tests execution is requested.
> >
> > I'm not sure I understand. What do you expect to happen that's not
> > happening in verbose mode?
>
> I tried running this test -vvv and it did not print verification log
> (admittedly this is the case with many tests in prog_tests/*.c).

I think that's the test_loader.c feature, plus maybe some other tests
support this. This is not expected to magically work for all tests.
But also in this case we explicitly intercept the log, so it would be
too much trouble to both intercept and print it at the same time, IMO.
But if this assertion fails, we'll see the log, which is the most
important part. Also one can use veristat to get the log.

>
> [...]
>
> > > Nit/question:
> > >   Why change prototype from (void) to (int) here and elsewhere?
> > >   Does not seem necessary for test logic.
> >
> > I had some troubles attaching freplace initially, but my freplace
> > skills were rusty :) I can try undoing this and leaving it as is.
>
> No strong opinion, just curious.

I undid it, it all works now. As I said, I had freplace troubles and
was poking around with different aspects.

