Return-Path: <bpf+bounces-69906-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19FECBA6321
	for <lists+bpf@lfdr.de>; Sat, 27 Sep 2025 22:18:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E5A317A023
	for <lists+bpf@lfdr.de>; Sat, 27 Sep 2025 20:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DE1822A7E4;
	Sat, 27 Sep 2025 20:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DokrMIDw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com [209.85.208.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 152E513B58B
	for <bpf@vger.kernel.org>; Sat, 27 Sep 2025 20:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759004330; cv=none; b=HU235lBAtcgGqmXjC4RjcI9SgOYn7z6zkWDyIWL+X2IlNRKXgk4y3kgsyVoQS7gmUrvH+DNCtn+W6fzOIvSrvTY8bHJWV/hq4Vu3odXqo0OodEzSvAgkAHFUiZEpIobNscRRNi9Zulcy77MDXc/eed2lUuCLQlqp1/CSY4IhJA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759004330; c=relaxed/simple;
	bh=hA5Lf/xXZG6wyQ79p9K/3IjEeL4FhsD29noUikwNH1o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XYLzdvDI44CEuhiondo35PR8LhmjnzoB4mAJorzRISid6ISFWLIWgIiK1/fjFd1gu0nRbV0avq70ynaWPWFBJa1nUYdY20SMVQg3VOIl/w6OVD/KyBc3ikCHuYnsjL2Yd7AAxY7wOOrn1OntmS82iAOk02chNm3p2bA3j6rT4Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DokrMIDw; arc=none smtp.client-ip=209.85.208.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f66.google.com with SMTP id 4fb4d7f45d1cf-634c01ca9dcso2576466a12.3
        for <bpf@vger.kernel.org>; Sat, 27 Sep 2025 13:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759004327; x=1759609127; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hA5Lf/xXZG6wyQ79p9K/3IjEeL4FhsD29noUikwNH1o=;
        b=DokrMIDwVrcATF7rTGG+8PYy/v8VBlkj8800X4eNAhKSC8e//lMjPidzVZdovS+x56
         p2c4aytnC3pkZOxVgGHDMmxmHz2qAketTanzaHGaZjTX0tEjGM+/esEogSTUmOetw0JG
         /rhEABe58vJ0FyiOJrV9G7Lr7F7LcspDYPxaYcSztsGvEQ/1pb1nw1JrvLx2RUc/X7F1
         9M/5n5+UGBGcDX9dDD7yZvjqZm5xuQOXKXgvrnjXE6gTG9jtlZDR7mTwTlID59XWitKN
         rYjg0dedd8tPvueEG8/xEUu125laHMQBiUXp5jbtuK384fsk536oTwhrR6VDAmhINPNS
         BJag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759004327; x=1759609127;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hA5Lf/xXZG6wyQ79p9K/3IjEeL4FhsD29noUikwNH1o=;
        b=pWBu05DiLYKhLzJDOZrpjh9DautbPgs5rbl6AUY6OuREH4ttD2xawoPiyfdG4pXK1w
         Ue6MvZWfQdldcBbw23+MdglFSkImLwqFvtd4Na93rpDszDb4WpVr/9Y9Uom72d6w+XZw
         zpeCL//UPAqULmGvrh+d9ZOl/1rqsqwRUnaI/ykFxkb3yhd4T0VsM21vShZx+BjW1wRM
         XaEI5LGsyjK3pdx4FDozT8m1XTQpQRG0TGIotirLyOcOpTEqABpPlZOZGJDewOl8OOZF
         ti+3gjCdV/waCN/Ubi6o50gxXEYV6ULRKtIJjUQGANARUKBOSx0yfhrKfZub9zSF3Y+r
         r0QA==
X-Gm-Message-State: AOJu0Ywc8gdCJAfH+AiIHC0UAgAqAgR/AJfTggqDL5olp/zOOG2j9E7O
	vWb7IeaN2G7k6hK6/TVFtT/s1LiremvoHIeO40daAaJ21+YHIzIkj/bcLNo4GrTXRvvZzYBteDT
	ygcYlbYlxdhsQ7xRlj/v/H7H7wURW0Zk=
X-Gm-Gg: ASbGnctjjEhzzHaLfSJTIjuSuMVhNH3Raz9oX+PmFtc7TYLvwFhfGjKiD9oA2om2zb3
	vRcb++R8jqItxEB4EX7rvAprn+kyxwMRue59nhhUPfYO+gCQaV5Lzbz5F9YgaMYzVZ7hncWmf/8
	4aZWS1BN9WdIwWxdSxrKNcufmsyQZz9W+4mc/2idzmMBnLi6AtyBYiJFh4KRGJewQTqLUVnns46
	mLNHV4xRvjk3LLXafZvLh3GrjyJpa2luEnVayLf5AKXMcoElm8=
X-Google-Smtp-Source: AGHT+IE75WVSjnQxX2P5N+adOmMN4SxLkfwFcUGIT9MnOAs2PaT6Cw4yBt46g4UzAvOPScbj2oHe1D9wvH8vY+tDaY4=
X-Received: by 2002:a17:907:7f04:b0:b04:626e:f435 with SMTP id
 a640c23a62f3a-b34bb22baf2mr1248201366b.22.1759004327085; Sat, 27 Sep 2025
 13:18:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250926235907.3357831-1-memxor@gmail.com> <CAP01T77czGuJju-Y2r4d=EDq6pnnSPCuLhFA6fcZBPf7EpJQag@mail.gmail.com>
 <CAADnVQJ9QSJVE4WqF7mxtF7+Awyjx-MfOSm0Wg+m-Z_zqxsAeA@mail.gmail.com>
In-Reply-To: <CAADnVQJ9QSJVE4WqF7mxtF7+Awyjx-MfOSm0Wg+m-Z_zqxsAeA@mail.gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Sat, 27 Sep 2025 22:18:10 +0200
X-Gm-Features: AS18NWDfwH2Px4XiYh09YtmUTBKBvbmeyf-ElmhOIh8gssOref8maI49DYc4mEo
Message-ID: <CAP01T74EJugv0uWRiTYkfWAJ46-sVpN-4ViSV-rVFK5FOAeUew@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1] selftests/bpf: Add stress test for rqspinlock
 in NMI
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, kkd@meta.com, 
	Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 27 Sept 2025 at 14:18, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Sat, Sep 27, 2025 at 1:01=E2=80=AFAM Kumar Kartikeya Dwivedi
> <memxor@gmail.com> wrote:
> >
> > On Sat, 27 Sept 2025 at 01:59, Kumar Kartikeya Dwivedi <memxor@gmail.co=
m> wrote:
> > >
> > > Introduce a kernel module that will exercise lock acquisition in the =
NMI
> > > path, and bias toward creating contention such that NMI waiters end u=
p
> > > being non-head waiters. Prior to the rqspinlock fix made in the commi=
t
> > > 0d80e7f951be ("rqspinlock: Choose trylock fallback for NMI waiters"),=
 it
> > > was possible for the queueing path of non-head waiters to get stuck i=
n
> > > NMI, which this stress test reproduces fairly easily with just 3 CPUs=
.
> > >
> > > Both AA and ABBA flavors are supported, and it will serve as a test c=
ase
> > > for future fixes that address this corner case. More information abou=
t
> > > the problem in question is available in the commit cited above. When =
the
> > > fix is reverted, this stress test will lock up the system.
> > >
> > > To enable this test automatically through the test_progs infrastructu=
re,
> > > add a load_module_params API to exercise both AA and ABBA cases when
> > > running the test.
> > >
> > > Note that the test runs for at most 5 seconds, and becomes a noop aft=
er
> > > that, in order to allow the system to make forward progress. In
> > > addition, CPU 0 is always kept untouched by the created threads and
> > > NMIs. The test will automatically scale to the number of available
> > > online CPUs.
> > >
> > > Note that at least 3 CPUs are necessary to run this test, hence skip =
the
> > > selftest in case the environment has less than 3 CPUs available.
> > >
> > > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > > ---
> >
> > This currently won't trigger in BPF CI, as the VMs have two CPUs
> > allocated to them.
> > I was wondering if this is a simple change, otherwise I can rework the
> > module to work with less than 3 CPUs.
>
> It's fine. We can bump CI's cpu count.
>
> But please see the bug spotted by our brand new AI review.
> Despite false positives it's amazing what it catches.
>
> Don't click on "Logs for ai-review" pw entry.
> It's hard to navigate from there.
> Click on "PR summary" and scroll down.

Honored to be the first recipient (thanks for working on this Ihor and Chri=
s).
Should we use a Reported-by: to credit such bugs?
I can also respin as is for now and we can decide later, but we
probably should keep track just for statistics.

