Return-Path: <bpf+bounces-40851-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA3EF98F580
	for <lists+bpf@lfdr.de>; Thu,  3 Oct 2024 19:45:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1EAC28407E
	for <lists+bpf@lfdr.de>; Thu,  3 Oct 2024 17:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0857A1AAE1E;
	Thu,  3 Oct 2024 17:44:12 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 611AB1A76D0
	for <bpf@vger.kernel.org>; Thu,  3 Oct 2024 17:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727977451; cv=none; b=FwlKlrHLJ8/KDNRR970YzIZE+4gJLeFynO8Fnh2pQRolAOVLK4K/KXoBX1DSwopRawVD/ufborn90PykX8DTsxXTL4m79SI2Om2yeFsJ8FTfLoNpG9s5BieQ7D2bMJEnrgb/VJAn9Ui2XHKYxZE3QWxXIuDpGh0by5nTHduUqpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727977451; c=relaxed/simple;
	bh=Fbqzv3DLnY0dlp+iZmhwBn8zDL4quIp8PWLSY4XlwiI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pFBPa4/yO8jJeRqt17OWFNRKzj/Vst5NKoBJei05ZiF4P1LGDjbObg6IqOXsh/h0EAvkq2zO3nvGLXXwGZd5TefD9Q2Xd9NkR/wy1izCuXePgqpGYAjeM2H8tJY+Tta224nt+WbwRlS0Ac8RR6Inz7ZWjiww0yRXnlttU2n3Fx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2e0a950e2f2so1094485a91.2
        for <bpf@vger.kernel.org>; Thu, 03 Oct 2024 10:44:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727977450; x=1728582250;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MhFGD9qaArYI0YugOiEdl7nLMw56MKiQn/jNaLV/xgY=;
        b=vwk3GohGiOBhldqUaFzLEJ0tzGKllB6v9TFW9qZBN6hLlae1gTXcrK8FBc/wOiVm0w
         t4lnFWUpnGevcSLksLJR+k10pRO3R/e8Hb8p4rL4F2SJgIkvPEmGmfbavKNi2JtEYS7V
         Qlbv+1tYIRNeFy8Q8IvPJrGOxhvDsNpXQ7ccGhtXHOvlrPUG8ifQyhsyor5Uyr6Jnbaa
         qtxbrAyRw37ov4YMrxVdZrZ7vTOYx8pOeLN3RqIyhSNyw1H7w/V9HgSXbv8QRwibfXGm
         P11bQDcpgEd5+oXmk9OwZASg6pNkBcWS7vvvKwdhkYewhIXwjGtzg9oENRfYVl4Lm2XK
         krPQ==
X-Forwarded-Encrypted: i=1; AJvYcCVeDXsZzUXjF2x2ro1iax65rRMukkfMWk3hV2+piqZlzMlpGq4E7oSLEcDgveDE+RuxpaY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKrN5g5kQPXSEyIOzhdKfERrx5xK0irnrrOg5KmilbXsPVPj8Q
	P3QwXiM59FV9ttWXUpU0PmE685BUNsIorYEHUXLt7WEPyCrqcZdBIlRQl+HeL2RP9FfZeLKeNFs
	f0BMdhjzlVIFek445zuaNH9kwWQ4=
X-Google-Smtp-Source: AGHT+IHrLa6YcPARv6Kv0a+zoWQ1Ojz5SkzEpWNf3XBjdd40/m3Av3GGZQWJ8OTcamoRsJSWMsN1qKKoE8dE8UKZf70=
X-Received: by 2002:a17:90a:a10d:b0:2c9:81fd:4c27 with SMTP id
 98e67ed59e1d1-2e184681375mr8556257a91.14.1727977449696; Thu, 03 Oct 2024
 10:44:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241002180956.1781008-1-namhyung@kernel.org> <94bdb7a4cb0f83adf655d98a5c5f5df5299b960d2af54c87eba08de9646d0e42@mail.kernel.org>
 <CAM9d7cjGh5+5Cgw-5Nc5oO88HgJz33BUuMGYREExEgWXND3B_A@mail.gmail.com> <96728576-f323-4eba-a1b0-5c73d357efac@meta.com>
In-Reply-To: <96728576-f323-4eba-a1b0-5c73d357efac@meta.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Thu, 3 Oct 2024 10:43:57 -0700
Message-ID: <CAM9d7cjsUDLuhKfTMU1+-UCCe0CNkvAOoCx0tZW-QaKxL41uTw@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 0/3] bpf: Add kmem_cache iterator and kfunc
To: Daniel Xu <dlxu@meta.com>
Cc: "bot+bpf-ci@kernel.org" <bot+bpf-ci@kernel.org>, kernel-ci <kernel-ci@meta.com>, 
	"andrii@kernel.org" <andrii@kernel.org>, "daniel@iogearbox.net" <daniel@iogearbox.net>, 
	"martin.lau@linux.dev" <martin.lau@linux.dev>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Daniel,

On Wed, Oct 2, 2024 at 6:01=E2=80=AFPM Daniel Xu <dlxu@meta.com> wrote:
>
> Hi Namhyung,
>
> On 10/2/24 17:18, Namhyung Kim wrote:
> > Hello,
> >
> > On Wed, Oct 2, 2024 at 12:06=E2=80=AFPM <bot+bpf-ci@kernel.org> wrote:
> >>
> >> Dear patch submitter,
> >>
> >> CI has tested the following submission:
> >> Status:     FAILURE
> >> Name:       [v4,bpf-next,0/3] bpf: Add kmem_cache iterator and kfunc
> >> Patchwork:  https://patchwork.kernel.org/project/netdevbpf/list/?serie=
s=3D894947&state=3D*
> >> Matrix:     https://github.com/kernel-patches/bpf/actions/runs/1114935=
0866
> >>
> >> Failed jobs:
> >> test_progs-aarch64-gcc: https://github.com/kernel-patches/bpf/actions/=
runs/11149350866/job/30988341564
> >
> > I'm not sure if it's because of my change.  It seems to have failed
> > on unrelated tests.  Can you please double check?
>
> I ran some queries on the BPF CI dataset (unfortunately not public) and
> I found at least one other instance of this failure [0].
>
> I've also manually triggered a re-run and now it passes.
> So it's probably not related to your change.
>
> I'll try to find the right person to debug it further.

Thanks a lot for taking care of this!
Namhyung

>
> [0]:
> https://github.com/kernel-patches/bpf/actions/runs/11010557218/job/305736=
07777
>

