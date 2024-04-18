Return-Path: <bpf+bounces-27125-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 201498A956B
	for <lists+bpf@lfdr.de>; Thu, 18 Apr 2024 10:55:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3206B21D66
	for <lists+bpf@lfdr.de>; Thu, 18 Apr 2024 08:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F0BE15AAB2;
	Thu, 18 Apr 2024 08:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bij8uIww"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B438D15AABC
	for <bpf@vger.kernel.org>; Thu, 18 Apr 2024 08:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713430529; cv=none; b=N1nA+RbRTC65um3GVxxk+qaEgOxY44WO/LgmN9XrtX/n1q/AsXbSpq9wLSKHTSmkzO5t6EZm/ZV4WgYZvuoM8kazzBgxB20ZUnEIdYvM9cuL/soPU0OqFJaY7a1nq2dkRAkZRd6Mzc5smSwDfOY5w1bvRaBDao7AZtJDYUVVgDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713430529; c=relaxed/simple;
	bh=/tb4QbVu8c2QRsgW5XBC6GGQL9b2y9oos5e54hq7gZs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PuboodJuYXzj0GhoQS3HvunfZsx6vi1ncTB+Amq/p0UxNtBn+VktgU6BzP9c6++dZXjTpxjT1AeOUqDun/cPbSnUUdWPfr3/3Gyo0sUqUQV66zI/jLmVu71dg92dIN3x25IZNo1trpZUw+kntg4x4FqQb16XRFa6/dwdGj9QHW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Bij8uIww; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713430526;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4YlIQQIdea0zY9K7SGuaix12g/A/bXwMZDxEbsfa9Qo=;
	b=Bij8uIwwNBNiHMR6O+FRre2z71cJC/yzmozHpGBGCay6QZooWzuNFooiKtRHIptOPxWMe6
	cybF0DOcAgF39Ubu3lpfYoIgf7AHWRLwEGdzGXZTGbLp/vv9PyYfxFwtKHfo37UYRnmejy
	1X74KTnYOJyY2LpjSPlZ19qU2OZLAD8=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-186-wuq51ssHPo6JCUFphyRQkA-1; Thu, 18 Apr 2024 04:55:25 -0400
X-MC-Unique: wuq51ssHPo6JCUFphyRQkA-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-56fd91d9ec0so352235a12.1
        for <bpf@vger.kernel.org>; Thu, 18 Apr 2024 01:55:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713430524; x=1714035324;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4YlIQQIdea0zY9K7SGuaix12g/A/bXwMZDxEbsfa9Qo=;
        b=fPa2U0Qb9biZ7vGMVSqzyqyO2mInbSqCdkNDQG857ePE+A3A7G573S8XLaPy7fnQgj
         RY+7ros7Dr96gKnZv1lMWxBAJT9gGrlWVonuNkqhFUE6ErDk9lPJ38Ka1R6HaoQMPkMX
         jGi88dg8Z4K2zjvtYAzZeh231bEiYcZh3tsLnwMIPQwzwfrzPLb1qw6u4R9Ki7wiJBkO
         0tFGNO6RuAd7v8h4Jzk9tWyRvJ+blm1qWrFn4po1VX64bkTXVoR3zGThamE3SWAXV1Ew
         4WFtW2hjtIH9FeOJjmSrexPLd9XMesryM+l4zK2xUFujwLB/ZVJuO7syM0TMelswqkjk
         2j6g==
X-Forwarded-Encrypted: i=1; AJvYcCXPpIazWyJZb7jjjnwuyLeQw2GhBY1vO2qqRHzFQNxgilhW0yoSue8QSZluG+aAqUcygN8s7NNt8nkIja4uMnhFRj7s
X-Gm-Message-State: AOJu0Yw98UJuk9fTjITL7vg/t6EwUpJk7/ZUolT25eZfi3R7CAy5bCL4
	OBBdVgXUdhjyGMzRXwnRAOkXVf3tUGo28ccbUwGktcxjqhlzUfei+TBG7N9ffXFS/5pCzqVNxyK
	GUgDwz8LMnprJzGKGFZaNK2cwDA1exeSMeqSNS3OB1rKMDlkpg3qfp46Y80/sf4gQXJuHYnHdLc
	OYNIAPL6Hv27TzwpzkagpR/UQl
X-Received: by 2002:a50:d70b:0:b0:566:d333:45e8 with SMTP id t11-20020a50d70b000000b00566d33345e8mr1330868edi.20.1713430524363;
        Thu, 18 Apr 2024 01:55:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFxI+7tuc8Le9HhsVxIWdWWRsOFfxFhBkIX4vcIcKLU6knTudbsJ0kY7SSOQ7z7lM64duYb3lMTtZqcPMqH8sc=
X-Received: by 2002:a50:d70b:0:b0:566:d333:45e8 with SMTP id
 t11-20020a50d70b000000b00566d33345e8mr1330856edi.20.1713430523993; Thu, 18
 Apr 2024 01:55:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240416-bpf_wq-v1-0-c9e66092f842@kernel.org> <20240416-bpf_wq-v1-16-c9e66092f842@kernel.org>
 <CAPhsuW46OYRj2TrqSeD4bPTN3bxbpj7DaFJnc3g0a--Gkjj2AQ@mail.gmail.com>
In-Reply-To: <CAPhsuW46OYRj2TrqSeD4bPTN3bxbpj7DaFJnc3g0a--Gkjj2AQ@mail.gmail.com>
From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date: Thu, 18 Apr 2024 10:55:11 +0200
Message-ID: <CAO-hwJJ7e-h7RwPGPe=GZf6F5+WpWyHcLHqBFiv-3HRafdZjeA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 16/18] selftests/bpf: add checks for bpf_wq_set_callback()
To: Song Liu <song@kernel.org>
Cc: Benjamin Tissoires <bentiss@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 18, 2024 at 5:25=E2=80=AFAM Song Liu <song@kernel.org> wrote:
>
> On Tue, Apr 16, 2024 at 7:11=E2=80=AFAM Benjamin Tissoires <bentiss@kerne=
l.org> wrote:
> [...]
>
> > +SEC("?tc")
> > +__log_level(2)
> > +__failure
> > +/* check that the first argument of bpf_wq_set_callback()
> > + * is a correct bpf_wq pointer.
> > + */
> > +__msg("mark_precise: frame0: regs=3Dr1 stack=3D before")
>
> This line and some other "mark_precise" lines are causing issues for
> test_progs-no_alu32 in the CI. I can reproduce it in my local tests.
>

Indeed. I can also reproduce locally. Here, it only happens for
test_wq_init_nomap() and test_wq_init_wrong_map().
TBH, I'm not sure what "precise" means, I just copied the checks from
timer_failures.c.

>
> I am not quite sure what is the best fix. Maybe we can just
> remove it.

Given that most of the code is shared with timer, but given that we
are working with kfuncs, we are not using the same r0 registers.
So yeah, I would think we could rely on the timer tests for precise,
and drop them here...

Cheers,
Benjamin

>
>
> Thanks,
> Song
>
> > +__msg(": (85) call bpf_wq_set_callback_impl#") /* anchor message */
> > +__msg("off 1 doesn't point to 'struct bpf_wq' that is at 0")
> > +long test_wrong_wq_pointer_offset(void *ctx)
> > +{
> > +       int key =3D 0;
> > +       struct bpf_wq *wq;
> > +
> > +       wq =3D bpf_map_lookup_elem(&array, &key);
> > +       if (!wq)
> > +               return 1;
> > +
> > +       if (bpf_wq_init(wq, &array, 0))
> > +               return 2;
> > +
> > +       if (bpf_wq_set_callback((void *)wq + 1, wq_cb_sleepable, 0))
> > +               return 3;
> > +
> > +       return -22;
> > +}
> >
> > --
> > 2.44.0
> >
>


