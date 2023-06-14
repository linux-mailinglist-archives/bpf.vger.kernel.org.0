Return-Path: <bpf+bounces-2606-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85267730A00
	for <lists+bpf@lfdr.de>; Wed, 14 Jun 2023 23:48:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D0BB281058
	for <lists+bpf@lfdr.de>; Wed, 14 Jun 2023 21:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7E33134CC;
	Wed, 14 Jun 2023 21:48:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5721134C0
	for <bpf@vger.kernel.org>; Wed, 14 Jun 2023 21:48:24 +0000 (UTC)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1FF2268C;
	Wed, 14 Jun 2023 14:48:22 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-51a1d539ffaso291727a12.0;
        Wed, 14 Jun 2023 14:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686779301; x=1689371301;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z4aA7epvssoPGg5rKcRh6aIf+fYOU5PxCzsadmXXnuA=;
        b=qFzhXfcLqCB2MSCLrlFYYTIxeaK5Z94fsXhWGJoebSatJORl6vk8BDQ4siY2DXEgOt
         o9o3qkvC9tcvTTreGFSz5R2gm6l8Zfme2nX9DuU05b1Nt2Updfx8hApStrSWgZ1YPs0R
         LaLpYMLvTuEySyVGl0vjkvo4yUM8PEdVqPO/guESDel1KF3TbryqXQSqXO3nCmkV3x4r
         U5Hiz257+vR7OszPDKgm3cA6EHxr5LVrecE+Zr9mzi2y2I7kSHOf3MEP+BXxHtvNizW1
         oTJ3pW3Y1LYJYKt7m5jNqcj0Izsx5PWQ1SqL9M00CBEYN8iNsPLx7ompRdJ1TR3vi+Wt
         JxGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686779301; x=1689371301;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z4aA7epvssoPGg5rKcRh6aIf+fYOU5PxCzsadmXXnuA=;
        b=Ix+T11qaZWQL2sC2/s3jNt8A0vubzO8qOjRjsIJV6KXXbxGdSaRusiyPZnaLsO4Wnu
         GF8DSOb46IYFi6yvXgDwm80GAEGt2/kViLSGKQ3j7zO+itOY0732tW3yjJvoogJOC/H+
         PA6eLfu0VpR9jKOZ5F4yXzzAm9EEMGbxXmG+Mi/cktT6OPYj0kUx/AxfsmzwrS2lwKea
         ulRo9XZ4OqK6MtxrlO/Uq2z1UPLyOk4U2X+3nuc66cBdVVoP9ZvG6aywIvNZdwmI6yDT
         Ef+CtTvztIwTmfHrHKP2UgENAoZNA3lmVl7lJ6CbYuUvmquohYZP3NuVWVOfP6VUBh99
         LGiw==
X-Gm-Message-State: AC+VfDx3nRxbo/6DS02oKJBWD9r2qMTfnULoXvImy1g3kl1IookVSVp7
	lk+KLLqBpL389RdOeT7cLEUWRw0hz/fJ8smhi17k5sFJC/s=
X-Google-Smtp-Source: ACHHUZ4dAD8KrNsvAoAwgxrkO665PN2j4lts/r2C6YriF4GjM2RHOgVk1Vh7//pO//qNwmKoXWTTnQjHAOVuJKVpJiI=
X-Received: by 2002:a05:6402:2683:b0:4ea:a9b0:a518 with SMTP id
 w3-20020a056402268300b004eaa9b0a518mr3028443edd.17.1686779301148; Wed, 14 Jun
 2023 14:48:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJc0_fwx6MQa+Uozk+PJB0qb3JP5=9_WcCjOb8qa34u=DVbDmQ@mail.gmail.com>
 <2023061453-guacamole-porous-8a0e@gregkh>
In-Reply-To: <2023061453-guacamole-porous-8a0e@gregkh>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 14 Jun 2023 14:48:09 -0700
Message-ID: <CAADnVQLuHTNPEuXpSUgkNHoK1-X8KxU=spdYWB2bMp6icS+j0g@mail.gmail.com>
Subject: Re: BPF regression in 5.10.168 and 5.15.93 impacting Cilium
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Robert Kolchmeyer <rkolchmeyer@google.com>, stable <stable@vger.kernel.org>, 
	regressions@lists.linux.dev, Martin KaFai Lau <kafai@fb.com>, 
	Alexei Starovoitov <ast@kernel.org>, Sasha Levin <sashal@kernel.org>, Paul Chaignon <paul@isovalent.com>, 
	Meena Shanmugam <meenashanmugam@google.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jun 14, 2023 at 1:57=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Wed, Jun 14, 2023 at 11:23:52AM -0700, Robert Kolchmeyer wrote:
> > Hi all,
> >
> > I believe 5.10.168 and 5.15.93 introduced a regression that impacts
> > the Cilium project. Some information on the nature of the regression
> > is available at https://github.com/cilium/cilium/issues/25500. The
> > primary symptom seems to be the error `BPF program is too large.`
> >
> > My colleague has found that reverting the following two commits:
> >
> > 8de8c4a "bpf: Support <8-byte scalar spill and refill"
> > 9ff2beb "bpf: Fix incorrect state pruning for <8B spill/fill"
> >
> > resolves the regression.
> >
> > If we revert these in the stable tree, there may be a few changes that
> > depend on those that also need to be reverted, but I'm not sure yet.
> >
> > Would it make sense to revert these changes (and any dependent ones)
> > in the 5.10 and 5.15 trees? If anyone has other ideas, I can help test
> > possible solutions.
>
> Can you actually test if those reverts work properly for you and if
> there are other dependencies involved?
>
> And is this issue also in 6.1.y and Linus's tree?  If not, why not, are
> we just missing a commit?  We can't revert something from a stable
> release if you are going to hit the same issue when moving to a new
> release, right?
>
> thanks,
>
> greg k-h

Before jumping to reverts..
how is it fixed in 6.0+ kernels?

"BPF program is too large" can probably be worked around on the cilium side=
.
The kernel cannot guarantee that a particular program will
always be verifiable. We find safety bugs in the verifier and often
enough the fixes to such issues make the verifier work harder to prove
the safety of the program.
This is one of such cases. These two commits are necessary.
Reverting them will prevent loading of valid programs.
So reverts is a dangerous path.
The best is to identify the other patches from 6.0+ and backport them.
The second best path is to bump 1M limit to something higher to
mitigate "more work by the verifier".

