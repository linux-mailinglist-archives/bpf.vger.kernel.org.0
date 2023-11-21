Return-Path: <bpf+bounces-15600-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D010A7F3888
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 23:01:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE824B21649
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 22:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E17FA51034;
	Tue, 21 Nov 2023 22:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JCPcPKXP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B56C19E
	for <bpf@vger.kernel.org>; Tue, 21 Nov 2023 14:01:34 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-548d67d30bbso3463964a12.1
        for <bpf@vger.kernel.org>; Tue, 21 Nov 2023 14:01:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700604092; x=1701208892; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZYziiKXAmyKjFv3OtcQJf9YaLr076uoahoGoSYpzcGM=;
        b=JCPcPKXPpPGtEMkgk9l2+Zmdp21zM9UmZHoFb0AljbtAwqnSGZLV3AL1TffmxJyGt+
         7X6sPgPzlJuLOpr97uOdvbqmGjCjYTM2aVIzo8IUeCNJfZ/a+jieQhWZkPbZ9Rt1ytwD
         A+u8+Pvwk7phwmgZ1ZuO8sOa3qRGVbWe1UGu3oJJFkKKTEDqZVvCi7qMBLyQyYnT52mp
         sVd8xr2QxSjxEQgowGWmVSK1DQeMX8DsykgqQQyNpiZEyuCfaBME4JnX4OB2+igzd4N9
         lhdsqS0h9domeMmoGoEEXkFr1E6hGU6pM50GfEwGIVHTjmEE9yHaMMbQhTv07N0CmTLl
         s6+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700604092; x=1701208892;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZYziiKXAmyKjFv3OtcQJf9YaLr076uoahoGoSYpzcGM=;
        b=jfCPcxWw0M2O7foFSWsKn6HBr4zmJCp5peUOg97DlXKkQZJ85FknEfTbogs5QAV0Z3
         2e1x/j5l3Kq71AN50CMlQ5sGAVEtvL8nnwm6Iu+odCE5lPX6NHmWz8ZpNHoeqsoBxG3I
         M1YrZSnXJCkHZE9G+YinzR4GvRH7R34fIWWeTsq5HE7ZiF5sXgLrUUEbMM/dB2ppd/26
         6dLgg/6E9Lpyi0n1Nnritzhid13Pfs0Dvcm+XSe5wJEp88OsOcKBi9TOkfS4p7ViijRB
         Cuuk7vtVcSvDY6GWMfDxfTowkuhmy2kiECVct/PlY4H1HQQxIsoPTvPhLaoADjTTjgrb
         P+GA==
X-Gm-Message-State: AOJu0YzHBi127LFG4VLM8+L6renIpZHB00KMqRMsBYL1TRdto7ut7IMs
	bZbgPv+xNv3A5qr2P8kBqwY+GC1GR9669Nc7PCs=
X-Google-Smtp-Source: AGHT+IGkO6ds+G71EKeVQQ47keXeK+9lq3kqEoRVaq9Jz81VEi17zV9lgbOf27ga64POSqpXkTDYZLLxN5k5l0QVwZw=
X-Received: by 2002:a17:906:3e5b:b0:a00:185a:a150 with SMTP id
 t27-20020a1709063e5b00b00a00185aa150mr153952eji.38.1700604092320; Tue, 21 Nov
 2023 14:01:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231121002221.3687787-1-andrii@kernel.org> <20231121002221.3687787-9-andrii@kernel.org>
 <20231121203806.43i6tytzwdzeoqvg@macbook-pro-49.dhcp.thefacebook.com>
In-Reply-To: <20231121203806.43i6tytzwdzeoqvg@macbook-pro-49.dhcp.thefacebook.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 21 Nov 2023 14:01:21 -0800
Message-ID: <CAEf4BzZANs_dCdaE8kCuJUTFjh1D7JtMpTNV4i9QeCgtHvoX6w@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 08/10] bpf: track aligned STACK_ZERO cases as
 imprecise spilled registers
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@kernel.org, kernel-team@meta.com, 
	Eduard Zingerman <eddyz87@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 21, 2023 at 12:38=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Nov 20, 2023 at 04:22:19PM -0800, Andrii Nakryiko wrote:
> > include it here. But the reduction in states is due to the following
> > piece of C code:
> >
> >         unsigned long ino;
> >
> >       ...
> >
> >         sk =3D s->sk_socket;
> >         if (!sk) {
> >                 ino =3D 0;
> >         } else {
> >                 inode =3D SOCK_INODE(sk);
> >                 bpf_probe_read_kernel(&ino, sizeof(ino), &inode->i_ino)=
;
> >         }
> >         BPF_SEQ_PRINTF(seq, "%-8u %-8lu\n", s->sk_drops.counter, ino);
> >       return 0;
> >
> > You can see that in some situations `ino` is zero-initialized, while in
> > others it's unknown value filled out by bpf_probe_read_kernel(). Before
> > this change both branches have to be validated twice. Once with
>
> I think you wanted to say that the code _after_ both branches converge
> had to be validated twice.
> With or without this patch both branches (ino =3D 0 and probe_read)
> will be validated only once. It's the code that after the branch
> that gets state pruned after this patch.

Yes, correct, it's the common code after two branches that now will
converge, so BPF_SEQ_PRINTF() invocation in this case, I'll improve
the wording.

In practice a slightly modified variant also happens: we
zero-initialize something, then depending on some conditions (error
checking, etc), we overwrite zero-initialized stack slots with some
unknown values that are not precise. Before this change we'll have
STACK_ZERO and STACK_MISC in different branches/code paths, which
would effectively duplicate all subsequent states that needs to be
verified. Now there is a high chance for this STACK_ZERO vs STACK_MISC
to not matter at all. We also can have spilled imprecise SCALAR_VALUE
register instead of STACK_MISC. The principal idea is that STACK_ZERO
promises a lot (that it is precisely zero), while often time those
values are just some integers with values we don't care about.

>
> > (precise) ino =3D=3D 0, due to eager STACK_ZERO logic, and then again f=
or
> > when ino is just STACK_MISC. But BPF_SEQ_PRINTF() doesn't care about
> > precise value of ino, so with the change in this patch verifier is able
> > to prune states from one of the branches, reducing number of total
> > states (and instructions) required for successful validation.
>
> This part is good.

