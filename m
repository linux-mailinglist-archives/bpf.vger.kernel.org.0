Return-Path: <bpf+bounces-15469-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B8487F2228
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 01:34:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0251F2827EB
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 00:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE332136D;
	Tue, 21 Nov 2023 00:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XBiYjSb1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3044EBA
	for <bpf@vger.kernel.org>; Mon, 20 Nov 2023 16:34:02 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-548b54ed16eso2348970a12.0
        for <bpf@vger.kernel.org>; Mon, 20 Nov 2023 16:34:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700526840; x=1701131640; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4ZStpLQLa1HA3UA/JMphQz5OUxKgIznNcHwcyhdHJYE=;
        b=XBiYjSb188i1opTgGWp12DeTwRojKw1j00I3AVu49xopATS02757mA0DQiF5x2y+SZ
         72blQ0hFWGg5ForeXYS5h5yPFY1SmF2hZeZi6Xnc4gI73pEIiUbOLKpGWdbRk72y74bL
         B1Nn007cQZXeVezbdp7yFGiMjn8IyKTg8nDfd0guhmHTdELoDu5eLQvAuiSFJ839HGzv
         Vn/LYqrdNUWwObgP64g74sbDawNle2Y87t/4EWXQmoDFEZ45NXX+NhslNFvVnFHOvE0Z
         5fAx5hBN9P1lshrsvdmSVQRRsA5O96RD6MRWCVw6weBPj2n+cU5WCo9eOmIxO4pwKP6B
         kxKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700526840; x=1701131640;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4ZStpLQLa1HA3UA/JMphQz5OUxKgIznNcHwcyhdHJYE=;
        b=R0YnR9/XahpKv8EFJ1aoqdGrRrteuSGR9TqP08VURtEDfdr8HZoet5nptGGH27s9wj
         jphdatQOzNZH3xdxJLIpt4dshqhFU67WTJNJLu4qbleuoaEfrt6q30EQcHSeEkY+6wzQ
         67syh4ExEx+Xf80ebZgpEB3D99x5jHK4KgGyVEtVXy3+G53cYFRv4YKy0EgrcakAIZgo
         RrBu3gFiCA7KWrbNOtJTKy5WfELcFHvz04ZhPAw4PyoiB+F4eS7BS3Ggi+E4uewGW6oD
         BgGcupezgIKKjXcqkT29pupFBknCJ98ifC1NZofeModBwx2i7TLsrJNt7KRJzwyFBgCd
         cp7g==
X-Gm-Message-State: AOJu0Yzi5+QVwJgGDoPgzi9AVclq1Va1nHVcxTmMzlopmLJhbWg3GlNP
	JIISUI9thJZ+3LbmS+mJb8jHFwccJgW66hwYYyk=
X-Google-Smtp-Source: AGHT+IHlh0c7ZC/Qie0sBRI+SbaH4s33r4MV/6JiM2JtqSPr9GLD8MjNp2emqddreqVonq3IhhuxZSjCjp6QWarC9NY=
X-Received: by 2002:a17:907:29d5:b0:9c6:19ea:cdd6 with SMTP id
 ev21-20020a17090729d500b009c619eacdd6mr5895058ejc.50.1700526840423; Mon, 20
 Nov 2023 16:34:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231120180452.145849-1-andrii@kernel.org> <CAADnVQKYAD98i-An+KZoTxxxCAJyypMythA+Q-NnGVNfOkq_Zw@mail.gmail.com>
In-Reply-To: <CAADnVQKYAD98i-An+KZoTxxxCAJyypMythA+Q-NnGVNfOkq_Zw@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 20 Nov 2023 16:33:48 -0800
Message-ID: <CAEf4BzYGVqUf3a4S7JGTRrBZKro0bgBWVb1DEGswTe4EH9nGLA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: reduce verboseness of reg_bounds
 selftest logs
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 20, 2023 at 12:57=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Nov 20, 2023 at 10:05=E2=80=AFAM Andrii Nakryiko <andrii@kernel.o=
rg> wrote:
> >
> > Reduce verboseness of test_progs' output in reg_bounds set of tests wit=
h
> > two changes.
> >
> > First, instead of each different operator (<, <=3D, >, ...) being it's =
own
> > subtest, combine all different ops for the same (x, y, init_t, cond_t)
> > values into single subtest. Instead of getting 6 subtests, we get one
> > generic one, e.g.:
> >
> >   #192/53  reg_bounds_crafted/(s64)[0xffffffffffffffff; 0] (s64)<op> 0x=
ffffffff00000000:OK
> >
> > Second, for random generated test cases, treat all of them as a single
> > test to eliminate very verbose output with random values in them. So no=
w
> > we'll just get one line per each combination of (init_t, cond_t),
> > instead of 6 x 25 =3D 150 subtests before this change:
> >
> >   #225     reg_bounds_rand_consts_s32_s32:OK
> >
> > Given we reduce verboseness so much, it makes sense to do a bit more
> > random testing, so we also bump default number of random tests to 100,
> > up from 25. This doesn't increase runtime significantly, especially in
> > parallelized mode.
> >
> > With all the above changes we still make sure that we have all the
> > information necessary for reproducing test case if it happens to fail.
> > That includes reporting random seed and specific operator that is
> > failing. Those will only be printed to console if related test/subtest
> > fails, so it doesn't have any added verboseness implications.
>
> Thanks for the quick fix. Applied.
>
> I also noticed:
> #200     reg_bounds_gen_consts_s64_u64:SKIP
> #201     reg_bounds_gen_consts_u32_s32:SKIP
> #202     reg_bounds_gen_consts_u32_s64:SKIP
> #203     reg_bounds_gen_consts_u32_u32:SKIP
> #204     reg_bounds_gen_consts_u32_u64:SKIP
>
> what is the reason for SKIP ?

Those are "slow tests". If they don't see `SLOW_TESTS=3D1` envvar, they
will mark themselves as skipped. This patch didn't change this
behavior, it was like that before.

