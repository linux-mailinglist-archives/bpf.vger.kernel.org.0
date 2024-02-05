Return-Path: <bpf+bounces-21236-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB8CD84A1FA
	for <lists+bpf@lfdr.de>; Mon,  5 Feb 2024 19:19:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A8411C231F0
	for <lists+bpf@lfdr.de>; Mon,  5 Feb 2024 18:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B42E447F76;
	Mon,  5 Feb 2024 18:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gq9Ef1aa"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF18945974
	for <bpf@vger.kernel.org>; Mon,  5 Feb 2024 18:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707157137; cv=none; b=HSdwFq5XtP3lBM0pRSw643lXf5lCdq3ITqnZaBS1Nz8bKI09R72b2BSTb7j/kuGL9AfZWJWR1T3Kgp5pB655o8OvxK5gfDC+QvXOieLdCrwlPbSwLtePtfZmIYBLHRFCaMGH9TalWg7y3TdPhBMjcJFZF4qzOafBMoEI9X2xquA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707157137; c=relaxed/simple;
	bh=mLIYAcaN1qQqjfzfcRawYqxnoizodtb9BsmjwCXZ+8A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Me38c8y6f6IRXyGcHYSt5TgLkvutMDZQIqJTD5UflGxsaZXucciTr+e7Gr5v/G96tTto05PyyZHPjrSryPtcYArKZ+nO3iwz/DKECmYr7at6MEdaJNXs/fWKHeHZHr08xSOH6aWk7rx8JrUYngh/3tA/8B8yfCRNZlx4rKcIOuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gq9Ef1aa; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-5ce9555d42eso4184504a12.2
        for <bpf@vger.kernel.org>; Mon, 05 Feb 2024 10:18:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707157135; x=1707761935; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iFGbXnEuNXq/xcw2RxJCyUCGtI8h/zNbVvmgQ40FVCs=;
        b=Gq9Ef1aa4XAbbVuYgr/0QM/rJX6ZQByqs/QKABnTd6YTDCOu/6Y6UclHRSOcfmLpS+
         rkHbsIHU+0iudoaGU9vfZ2h7dA11+F1KwZShYc5a24fnlyP2wT2DoWSyaQlbXTNtSLtY
         XUnVfw8F3iqynaOveHhAEbOZwrkYXxZabs5CDH1CxFVlByRVaVgre9dBfCs0klxuMOCR
         dRGc7hc1qB53h63DilCktGBjrpZIynAwWBjnoOP2T/sopEQeeRdzAvnAWYiRx4wc85eT
         ifZpWKBAux+o+sGBoyHJGKX0vISlB1EPx3iIU1yt7TJJUOgWqZINwZcIKaGulHxGRaxp
         AZXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707157135; x=1707761935;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iFGbXnEuNXq/xcw2RxJCyUCGtI8h/zNbVvmgQ40FVCs=;
        b=Hmi86I5znQG4ah1qbmpQrrdAdXGKeOZUAFzuFwrohg0C9KSF7x+qnw9LwmERHUuv8g
         rbfVv/f0fvdn0s05yvwA4UIET/cw5a9Zm6dAK57rt8YDkAQCE6bZZt7TOY/Cy70NGMC4
         mdI2YGuWl+22XGZRiGn8I3NsiAea52iLbdC137Enp4yw7e/KmLiT5o5qt/yzeejRrgMX
         Sp0Di3A06vtv9VIeCJIw+h5TPx+iXXEDjzKgSye0aHL3ED787f4/g4//z/3ySL5dbFL7
         Gc3v9qzv5k1kHODZCnCtoqhu/s/LS352T2p+n1Aq5st+qS9cq4LqRZGiEUBF56Fl1vfM
         UD3A==
X-Gm-Message-State: AOJu0YxDhyQnHVovGSd2Bt8vWFdZ02S9jU/YjfCS3JYoHqGMpb7yu+1t
	TLloh5O7NiTgXOtC57CYIRngmCqe9FaUE4mlAHD87slETiQtLAL5EpfwFiLFo7HeojKp9hZl8CN
	mIYzuw6+UwsCy8hQAzM+RJvo3/Eo=
X-Google-Smtp-Source: AGHT+IHDth9F0i+Ghou2MlsoKo3CpJ7aH3SnP6N40njpHGS8Ic2MdCLeU1ZaUPGbsuzauHKQvK7bbmXdTt9QElwQH0c=
X-Received: by 2002:a05:6a20:a111:b0:19c:773c:570e with SMTP id
 q17-20020a056a20a11100b0019c773c570emr405998pzk.39.1707157135175; Mon, 05 Feb
 2024 10:18:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240131155607.51157-1-hffilwlqm@gmail.com> <CAEf4BzYsYHi1s_7PZ5QknUg+Oe9drN0OSXbxT06WDB57o0Ju9w@mail.gmail.com>
 <a910fc94-47cd-419e-baf9-5c00140cbc60@linux.dev>
In-Reply-To: <a910fc94-47cd-419e-baf9-5c00140cbc60@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 5 Feb 2024 10:18:43 -0800
Message-ID: <CAEf4BzaA+hhVdh=gGd2uz10ZLPeUKWN2H75MiF93L1AWPJ2O7g@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 0/2] bpf: Add generic kfunc bpf_ffs64()
To: Yonghong Song <yonghong.song@linux.dev>
Cc: Leon Hwang <hffilwlqm@gmail.com>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 4, 2024 at 11:20=E2=80=AFAM Yonghong Song <yonghong.song@linux.=
dev> wrote:
>
>
> On 2/2/24 2:18 PM, Andrii Nakryiko wrote:
> > On Wed, Jan 31, 2024 at 7:56=E2=80=AFAM Leon Hwang <hffilwlqm@gmail.com=
> wrote:
> >> This patchset introduces a new generic kfunc bpf_ffs64(). This kfunc
> >> allows bpf to reuse kernel's __ffs64() function to improve ffs
> >> performance in bpf.
> >>
> > The downside of using kfunc for this is that the compiler will assume
> > that R1-R5 have to be spilled/filled, because that's function call
> > convention in BPF.
> >
> > If this was an instruction, though, it would be much more efficient
> > and would avoid this problem. But I see how something like ffs64 is
> > useful. I think it would be good to also have popcnt instruction and a
> > few other fast bit manipulation operations as well.
> >
> > Perhaps we should think about another BPF ISA extension to add fast
> > bit manipulation instructions?
>
> Sounds a good idea to start the conversion. Besides popcnt, lzcnt
> is also a candidate. From llvm perspective, it would be hard to
> generate ffs64/popcnt/lzcnt etc. from source generic implementation.

I'm curious why? I assumed that if a user used __builtin_popcount()
Clang could just generate BPF's popcnt instruction (assuming the right
BPF cpu version is enabled, of course).

> So most likely, inline asm will be used. libbpf could define
> some macros to make adoption easier. Verifier and JIT will do
> proper thing, either using corresponding arch insns directly or
> verifier will rewrite so JIT won't be aware of these insns.
>
> >
> >> In patch "bpf: Add generic kfunc bpf_ffs64()", there is some data to
> >> confirm that this kfunc is able to save around 10ns for every time on
> >> "Intel(R) Xeon(R) Silver 4116 CPU @ 2.10GHz" CPU server, by comparing
> >> with bpf-implemented __ffs64().
> >>
> >> However, it will be better when convert this kfunc to "rep bsf" in
> >> JIT on x86, which is able to avoid a call. But, I haven't figure out t=
he
> >> way.
> >>
> >> Leon Hwang (2):
> >>    bpf: Add generic kfunc bpf_ffs64()
> >>    selftests/bpf: Add testcases for generic kfunc bpf_ffs64()
> >>
> >>   kernel/bpf/helpers.c                          |  7 +++
> >>   .../testing/selftests/bpf/prog_tests/bitops.c | 54 +++++++++++++++++=
++
> >>   tools/testing/selftests/bpf/progs/bitops.c    | 21 ++++++++
> >>   3 files changed, 82 insertions(+)
> >>   create mode 100644 tools/testing/selftests/bpf/prog_tests/bitops.c
> >>   create mode 100644 tools/testing/selftests/bpf/progs/bitops.c
> >>
> >>
> >> base-commit: c5809f0c308111adbcdbf95462a72fa79eb267d1
> >> --
> >> 2.42.1
> >>

