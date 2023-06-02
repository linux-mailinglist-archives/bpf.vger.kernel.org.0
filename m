Return-Path: <bpf+bounces-1636-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A1AC71F730
	for <lists+bpf@lfdr.de>; Fri,  2 Jun 2023 02:40:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EA69281948
	for <lists+bpf@lfdr.de>; Fri,  2 Jun 2023 00:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADABD10E9;
	Fri,  2 Jun 2023 00:40:25 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C822EA8
	for <bpf@vger.kernel.org>; Fri,  2 Jun 2023 00:40:25 +0000 (UTC)
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1ED598
	for <bpf@vger.kernel.org>; Thu,  1 Jun 2023 17:40:23 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4f5f728c4aaso1543097e87.0
        for <bpf@vger.kernel.org>; Thu, 01 Jun 2023 17:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685666422; x=1688258422;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dQMTJIvAFBPt09MlJkqvyf/bjWfG6tXJNp9yIk7PCK8=;
        b=UbzLfnuif+D45QDh6i8QMn2cB2GqhMB46o2TthSxOdKlSueB51NB77iH14oJyYzkMZ
         WlSFeVWQNvImOOb1H8H9SMjxXCyji1F51EnsWtCdTAkyErUaMtM62Zky2dzH5peLXjwC
         NXBsJNv0GWE+pv8gqAFmDp4w6OuvX2nZTE/sYJC9OsbA1AgPC5aPppLX/0vgdCSPKzb8
         Ne+Zs0XE3WNsEv1uLYGHlH579sYPkKOd/+kiN6A03R9p26gGlv9NvPYuviOdNLnmGzax
         hasQSBLzVZdvQXvHkzXbr7+4kYvLKx4kOpF6E7oMl7o9VtqPikzw8VUsu16PaoiBF0RU
         X6nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685666422; x=1688258422;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dQMTJIvAFBPt09MlJkqvyf/bjWfG6tXJNp9yIk7PCK8=;
        b=B7mRMcn68hASaf62yC//u6TJpJ/Z6lAd/TRo49ZtWQOKRGUZRxV8o8/dglscpIKSDy
         rNDL2PEDoktXoXwGI89siyWust+y8WY7BafB4q5F5kL3Kcv/aRQWleMWqtF8BGGQmOyP
         4tzkLzhl4UKtVKd50+KDXa7fXhD2rN72/GV0cRYoAPxcJ3xCdBTopZpIffRdROtYAtCB
         30AW95oVwJGH/UdZ6jV+mLiWS5yg4hsRJRsavonlYfQJ4fuKxN7tVMvYC0MTQeTOWPbb
         T5LnhiCz8MrZ4POmbB8ITZZ7HyaRAZNm6JoUKJ3pZrhkvWgIMo1T1DpzvXn4ztFXCoiO
         +Wkg==
X-Gm-Message-State: AC+VfDxx7u+gksgqYjmKIDUBY3qExbsiFGsmsGuIrCwFZV95Sc21ay6D
	q0NNuen2VnWdyQ6AdgH31Xuuec4Ub/Af3qhDT6s=
X-Google-Smtp-Source: ACHHUZ7D8ch92NrvkggFdd+t4SwzeSIrKx5Lw57Qy0NAm/0lSFaMQpa4pPGbp2yOrIpHpgFRTh7w6IcT7H8PYwlZsfQ=
X-Received: by 2002:ac2:5e75:0:b0:4f4:7a5:e800 with SMTP id
 a21-20020ac25e75000000b004f407a5e800mr346948lfr.10.1685666421480; Thu, 01 Jun
 2023 17:40:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230531110511.64612-1-aspsk@isovalent.com> <20230531110511.64612-2-aspsk@isovalent.com>
 <20230531182429.wb5kti4fvze34qiz@MacBook-Pro-8.local> <ZHhJUN7kQuScZW2e@zh-lab-node-5>
 <CAADnVQ+67FF=JsxTDxoo2XL8zSh5Y3xptGee8vBj8OwP3b=aew@mail.gmail.com>
 <ZHjhBFLLnUcSy9Tt@zh-lab-node-5> <CAADnVQLXFyhACfZP3bze8PUa43Fnc-Nn_PDGYX2vOq3i8FqKbA@mail.gmail.com>
In-Reply-To: <CAADnVQLXFyhACfZP3bze8PUa43Fnc-Nn_PDGYX2vOq3i8FqKbA@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 1 Jun 2023 17:40:10 -0700
Message-ID: <CAADnVQ+FzCiQLbFaJihr8tuJXxjFNZqYs75cyhSDjds8nYBj4A@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: add new map ops ->map_pressure
To: Anton Protopopov <aspsk@isovalent.com>, Martin KaFai Lau <martin.lau@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, Joe Stringer <joe@isovalent.com>, 
	John Fastabend <john.fastabend@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jun 1, 2023 at 11:24=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Jun 1, 2023 at 11:17=E2=80=AFAM Anton Protopopov <aspsk@isovalent=
.com> wrote:
> > >
> > > LRU logic doesn't kick in until the map is full.
> >
> > In fact, it can: a reproducable example is in the self-test from this p=
atch
> > series. In the test N threads try to insert random values for keys 1..3=
000
> > simultaneously. As the result, the map may contain any number of elemen=
ts,
> > typically 100 to 1000 (never full 3000, which is also less than the map=
 size).
> > So a user can't really even closely estimate the number of elements in =
the LRU
> > map based on the number of updates (with unique keys). A per-cpu counte=
r
> > inc/dec'ed from the kernel side would solve this.
>
> That's odd and unexpected.
> Definitely something to investigate and fix in the LRU map.
>
> Pls cc Martin in the future.
>
> > > If your LRU map is not full you shouldn't be using LRU in the first p=
lace.
> >
> > This makes sense, yes, especially that LRU evictions may happen randoml=
y,
> > without a map being full. I will step back with this patch until we inv=
estigate
> > if we can replace LRUs with hashes.
> >
> > Thanks for the comments!

Thinking about it more...
since you're proposing to use percpu counter unconditionally for prealloc
and percpu_counter_add_batch() logic is batched,
it could actually be acceptable if it's paired with non-api access.
Like another patch can add generic kfunc to do __percpu_counter_sum()
and in the 3rd patch kernel/bpf/preload/iterators/iterators.bpf.c
for maps can be extended to print the element count, so the user can have
convenient 'cat /sys/fs/bpf/maps.debug' way to debug maps.

But additional logic of percpu_counter_add_batch() might get in the way
of debugging eventually.
If we want to have stats then we can have normal per-cpu u32 in basic
struct bpf_map that most maps, except array, will inc/dec on update/delete.
kfunc to iterate over percpu is still necessary.
This way we will be able to see not only number of elements, but detect
bad usage when one cpu is only adding and another cpu is deleting elements.
And other cpu misbalance.

but debugging and stats is a slippery slope. These simple stats won't be
enough and people will be tempted to add more and more.
So I agree that there is a need for bpf map observability,
but it is not clear whether hard coded stats is the solution.

