Return-Path: <bpf+bounces-12920-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13B677D2102
	for <lists+bpf@lfdr.de>; Sun, 22 Oct 2023 06:33:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1315281796
	for <lists+bpf@lfdr.de>; Sun, 22 Oct 2023 04:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C0EBA4D;
	Sun, 22 Oct 2023 04:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jLcwGMrK"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCBFD36A
	for <bpf@vger.kernel.org>; Sun, 22 Oct 2023 04:33:10 +0000 (UTC)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2EE1E7
	for <bpf@vger.kernel.org>; Sat, 21 Oct 2023 21:33:08 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-53e07db272cso3183307a12.3
        for <bpf@vger.kernel.org>; Sat, 21 Oct 2023 21:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697949187; x=1698553987; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=He3p+UcPgeCrb2TGsr1X7fQogUsFhk3Zuj9el3EALoI=;
        b=jLcwGMrKUyD3a/pvVXKPhGmPO8opt8TnElgLsUssCJxht0i8QErFEHwU2FzBLSJU/q
         x5ABKII1cBdzL4B7BO6hshESvxb/H4AHiLm/cu1TgHbzsA2dyDOTrRMiVLKKkOGRCUiy
         FBI03dl5p0lEPIj2h0Jgr7WQpuJwBTcT63X2U8OrqcTOiYduO/FgH+i7XAZ7fU6LwbV/
         uekgem494qLka+5qFEnavHwJVqWslywg+69aL1Wp4SvrM/+KE1H7POarVOFfP/sNJxRA
         l6nhiQzoyzuYvUCD6y53q3ZZv87LFHpE9zH6L0KAbUYGDn0C5MHt3lXoct4D4HcwONFq
         Ej4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697949187; x=1698553987;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=He3p+UcPgeCrb2TGsr1X7fQogUsFhk3Zuj9el3EALoI=;
        b=b3swXaMbpFGOsHJ7S3mfjv/avnueZziKTv3nPWtyPFt/fZ8kh6CwBPwkeVyPo9CdlW
         bygOl2BaVm7wWIptv8RZOvtCjOQJhvVuSzR5i3rsxmfyje+Wg6cjYvr5kWnP6rKFU+JU
         LhzD/S+fPaC22f4WVYnjt/HnccyE+AeMQszhVJ+CIeWmFHW0ONbDql1PntrSo9/DF41J
         cuwQs47rPBHBqNIwMkDa7bzotn2uzVoz6QcXhJtpttHTsBsSCjtjPBjCZ965liwfpXh2
         +w6m5qkuWdHRiUFoUXle5CJdfCvYTzqYf9vFPV0EwhItKFNbGoYHP7yqtkHCrViwKnxU
         Z+qQ==
X-Gm-Message-State: AOJu0YwkjjLrR7NvkXBFfMlsVzUYDmTm5OBtuIRHH4uXRBpN9A3jDcFq
	7tubOdmmQmHeh2kOhWLnwC9RL5regxcT5n0fM2c=
X-Google-Smtp-Source: AGHT+IEez3zKIk1ZonwSrgzfAimPXtLhnoP+oy3tdq4Hk85ihJyHRsYS8MkYBfYxisMWTrivbWidgA5KwfGWSkuZcl4=
X-Received: by 2002:a17:907:703:b0:9b6:50cd:a222 with SMTP id
 xb3-20020a170907070300b009b650cda222mr4941499ejb.54.1697949187354; Sat, 21
 Oct 2023 21:33:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231019042405.2971130-1-andrii@kernel.org> <65335006882f9_6c4082082a@john.notmuch>
In-Reply-To: <65335006882f9_6c4082082a@john.notmuch>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Sat, 21 Oct 2023 21:32:55 -0700
Message-ID: <CAEf4Bza2cxVOS3XSLkhkE605nS5=_6vsk3EW-q3EX1owLp8fVg@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 0/7] BPF register bounds logic and testing improvements
To: John Fastabend <john.fastabend@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 20, 2023 at 9:14=E2=80=AFPM John Fastabend <john.fastabend@gmai=
l.com> wrote:
>
> Andrii Nakryiko wrote:
> > This patch set adds a big set of manual and auto-generated test cases
> > validating BPF verifier's register bounds tracking and deduction logic.=
 See
> > details in the last patch.
> >
> > To make this approach work, BPF verifier's logic needed a bunch of
> > improvements to handle some cases that previously were not covered. Thi=
s had
> > no implications as to correctness of verifier logic, but it was incompl=
ete
> > enough to cause significant disagreements with alternative implementati=
on of
> > register bounds logic that tests in this patch set implement. So we nee=
d BPF
> > verifier logic improvements to make all the tests pass.
> >
> > This is a first part of work with the end goal intended to extend regis=
ter
> > bounds logic to cover range vs range comparisons, which will be submitt=
ed
> > later assuming changes in this patch set land.
> >
> > See individual patches for details.
>
> Nice, I'm about half way through this I'll continue on Monday. The two ro=
unds
> of convergence was interesting I didn't expect that. Looks good to me tho=
ugh
> so far.
>

Great, thanks for reviewing! I found an incompleteness in BPF_JEQ and
BPF_JNE handling in reg_bounds selftests, but it is not exposed on
range vs const comparisons (I found it only when I started testing
range vs range). So I might update this revision with slight changes
on selftest side, but kernel side so far looks good and I don't plan
any adjustments in this patch set.

I do have further generalization coming up that supports range vs
range comparisons and is_branch_taken() logic, so keep in mind that
this is just a first part :)

> Thanks for doing this I've wanted this cleaned up for awhile!

No problems, this was fun, and once range vs range logic lands I'll
have peace of mind :)

>
> >
> > v1->v2:
> >   - fix compilation when building selftests with llvm-16 toolchain (CI)=
.
> >
> > Andrii Nakryiko (7):
> >   bpf: improve JEQ/JNE branch taken logic
> >   bpf: derive smin/smax from umin/max bounds
> >   bpf: enhance subregister bounds deduction logic
> >   bpf: improve deduction of 64-bit bounds from 32-bit bounds
> >   bpf: try harder to deduce register bounds from different numeric
> >     domains
> >   bpf: drop knowledge-losing __reg_combine_{32,64}_into_{64,32} logic
> >   selftests/bpf: BPF register range bounds tester
> >
> >  kernel/bpf/verifier.c                         |  175 +-
> >  .../selftests/bpf/prog_tests/reg_bounds.c     | 1668 +++++++++++++++++
> >  2 files changed, 1791 insertions(+), 52 deletions(-)
> >  create mode 100644 tools/testing/selftests/bpf/prog_tests/reg_bounds.c
> >
> > --
> > 2.34.1
> >
> >
>
>

