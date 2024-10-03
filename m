Return-Path: <bpf+bounces-40879-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CC5798F9E3
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 00:32:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8499284853
	for <lists+bpf@lfdr.de>; Thu,  3 Oct 2024 22:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C77611C2459;
	Thu,  3 Oct 2024 22:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J2/wo1i7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C87A7147C96
	for <bpf@vger.kernel.org>; Thu,  3 Oct 2024 22:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727994769; cv=none; b=qwFfyfQjyCvUZ2WrZPbAa4i15teZgF+5BRb1UMx2xM+tp1+akq+O3M4KyPx1XI7Fl/XiDon8rAr6AEpacIeHtaQQBBSMxgD9p2Z9PSZtogbYuCyHqlGcaSg60lrLurNSjJDVVa77vW7oAsvBiNN4a/5Ae4sfk2FbeHAXqbVxenE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727994769; c=relaxed/simple;
	bh=Owm13sFSj0+W9wfx1atqZ1nYSulKFrbIjuGeISMDDMs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ss98wk0iGEKY9HZq4horoca831DbC5/HJTl2LiHzv+xgjCwtebi3Cvk1A5MauZVA8Axj7OrYjaNfhJrY+XUx5YMkvmsekUWM4cI0Dt0zw2HPmogwlIZWtossovFdOi8eMceJj7JjYHarjQsUQ8vFVOlJm5GaYiPK93a1mL51MIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J2/wo1i7; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a8d6d0fe021so237933766b.1
        for <bpf@vger.kernel.org>; Thu, 03 Oct 2024 15:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727994766; x=1728599566; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Owm13sFSj0+W9wfx1atqZ1nYSulKFrbIjuGeISMDDMs=;
        b=J2/wo1i7bdtySuVyvncBqnmewP1FhLrodwCFNmtQmpZmFDE54GfRMiWCoJXhR+1B8E
         5fmMxGs+W9DN/rMrAIQOrB4/n5w9pGGutjwbYtikSL5ur4vJTdECTj8hy84J+G+j96fU
         3kgfT0WxJ/QWzp1EdiWYnrsHm1eEHvA65x9Ms813yrdOwDtliKL/08026k1lFzZdFLaF
         pT4m6lsjBTWtOS5pQ1wLNTdF5gkF5JUiFUgfFxUd+s8bTl1eoqYHr9/2PmViXVSuEl9e
         dw5fXTTAdfgxQ+zmouPMWBUjv+EkMzwgITFh6BeyaU5Ce1MCHtAIQbrSckiudE2ajCKT
         O2Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727994766; x=1728599566;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Owm13sFSj0+W9wfx1atqZ1nYSulKFrbIjuGeISMDDMs=;
        b=cREkTuBemBWKb/nZC3BZolYtUsvIrewINQX1HfTSbh2HjDzR88pwf2Su1yHx2M3nRQ
         Jh0Q2urdW4rttqFyjkPJQn0KUx7Skj4oQXLeuWGhEstr9c7uXlyN9TdVV9ENS57bLL2k
         O4JdqTO47t705Z6BwqzbODijmiJvSQvzj/g3e+SSMU6mzBakB/+xUrYHUxPEbOdJ0jEq
         A4KxvBIGZwgJ1M62uve6y2yd5P1nEdq5yd/BmydI+U/sHujRMjvZWklnZ8cOhrL5s17W
         fUobk3+n6aQgwGUSwCAu3dOmG0CV60ksZZKE2wiOaBW/NqZSn5JRKDgfFslJORt3sNCw
         1l2Q==
X-Forwarded-Encrypted: i=1; AJvYcCWwbsL3vEvLF+EWswN7qJlCvjszTHHq0e1E4ywVbO9kRDrm2dhzL8uX4PyQTu8iRQ6xyds=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLdAZ3opuqv5TfmWo4MVYqAjAcjDaN45SuIegFaxNEWOHVJw49
	fHLu40619rWNSLE1PP01Jpc9OOz24ZqZFkc2D/lRR8+lnTdOgFGxFKBzhTaGwfCiLE7lvZ6+u1w
	LDjRVsoMEDZBZWWAPz0bqEJ3GFXyHa9pP
X-Google-Smtp-Source: AGHT+IGVCuF5S3sYYsm6F74ZKHvG1w/WSBFgh6ENXPz0tK55FobITrQfUgzmMEt9qYU21dvBa3FKggi7cxBQv+xtDPo=
X-Received: by 2002:a17:907:f783:b0:a86:7924:11bd with SMTP id
 a640c23a62f3a-a991bdc1a44mr66506266b.41.1727994765809; Thu, 03 Oct 2024
 15:32:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240926234506.1769256-1-yonghong.song@linux.dev>
 <20240926234526.1770736-1-yonghong.song@linux.dev> <CAADnVQ+v3u=9PEHQ0xJEf6wSRc2iR928Sc+6CULh390i3TDR=w@mail.gmail.com>
 <CAP01T77-bU5Ewu79QLJDTnt_E8h_VFHuABOD5=oct7_TC_yYGQ@mail.gmail.com>
 <CAP01T76UnVfn3x7zZH4vJgZMGv_Ygewxg=9gUA-xuOa7pwGr3A@mail.gmail.com>
 <CAADnVQ+caNh8+fgCj2XeZDrXniYif5Y+rw6vsMOojBO3Qwk+Nw@mail.gmail.com>
 <CAADnVQKLWi_TfpbiYb1vPMYMqPOPWPS-RGbB0FksEQW5i36poQ@mail.gmail.com>
 <CAP01T77q_H31mPXPQV4xHifutxxFeuoD8eg75C717MZ=OOeHew@mail.gmail.com>
 <CAADnVQLfWgpu6WvZRCFo39YHJ=zSSQWcOnaCOqdfyCg8uRoddg@mail.gmail.com>
 <CAP01T77G63MGvomrd3563bgBcNKUZg0Jc=GGmcGO0zPLS0hcHA@mail.gmail.com>
 <CAADnVQ+z-s07V_KU91+zGRB3qXGR9nr3w1dMBfCEEgunyes7EA@mail.gmail.com>
 <8b6c1eb1-de43-4ddb-b2b6-48256bdacddb@linux.dev> <CAP01T77k7bqTx_VRhnUjcOcGDp-y=zJHzKi7S-+domZjhEGfzQ@mail.gmail.com>
 <CAADnVQ+UByKkpVSg4tC-hoV7DstEYE11WxJ4nbGj27emZ2PFmA@mail.gmail.com> <a3116710-7e55-42ce-abd2-7becee9c275f@linux.dev>
In-Reply-To: <a3116710-7e55-42ce-abd2-7becee9c275f@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 3 Oct 2024 15:32:34 -0700
Message-ID: <CAADnVQKO1=ywkfULmSE=15dFU4Ovn3OMVbnGpkah5noeDnwtgw@mail.gmail.com>
Subject: Re: yet another approach Was: [PATCH bpf-next v3 4/5] bpf, x86: Add
 jit support for private stack
To: Yonghong Song <yonghong.song@linux.dev>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Kernel Team <kernel-team@fb.com>, 
	Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 3, 2024 at 1:44=E2=80=AFPM Yonghong Song <yonghong.song@linux.d=
ev> wrote:
>
> > Looks like the idea needs more thought.
> >
> > in_task_stack() won't recognize the private stack,
> > so it will look like stack overflow and double fault.
> >
> > do you have CONFIG_VMAP_STACK ?
>
> Yes, my above test runs fine withCONFIG_VMAP_STACK. Let me guard private =
stack support with
> CONFIG_VMAP_STACK for now. Not sure whether distributions enable
> CONFIG_VMAP_STACK or not.

Good! but I'm surprised it makes a difference.
Please still root cause the crash without VMAP_STACK.

We need to do a lot more homework here before proceeding.
Look at arch/x86/kernel/dumpstack_64.c
At least we need new stack_type for priv stack.
stack_type_unknown doesn't inspire confidence.
Need to make sure stack trace is still reliable with priv stack.
Though it may look appealing from performance pov.
We may need to go back to r9 approach with push/pop around calls,
since that is surely keeping unwinder happy
while this approach will have to teach unwinder.

