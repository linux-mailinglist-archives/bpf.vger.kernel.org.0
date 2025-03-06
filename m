Return-Path: <bpf+bounces-53442-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92F33A54096
	for <lists+bpf@lfdr.de>; Thu,  6 Mar 2025 03:20:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFBBA188FD8F
	for <lists+bpf@lfdr.de>; Thu,  6 Mar 2025 02:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 332B918EFDE;
	Thu,  6 Mar 2025 02:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B49STXc9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D882D42A99
	for <bpf@vger.kernel.org>; Thu,  6 Mar 2025 02:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741227652; cv=none; b=Ro52522SsuhpcPHPFw5xKzP2YHiurqgIGkg+nmb7nCyRJrfB/g6UPjEMCp8yuY4wQlgNSK/xeVmwxu8iazhRnHu4B/0b5fCzE+Tqu7Y9xl45yqrjbwjCV13ee5hZOrMbeUGSomqppWUQje1m+mZV+wMcFJThy2ncNaktSHSvfrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741227652; c=relaxed/simple;
	bh=dg7xsJXRrMrxmXHwd4XXt9bshP58Vgfoqc6r7WY+ZvU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oEboDxNwjgOD4xvkI+CI/PGk49WMO6Hqgbcpsa1/YBkqwsI//y02G+dE4G6S/1ew09wsEfHHUi3AjZ10i3zYl5VznTPUQt+d+0uqW27cuFoNZi688LwWb01HrowmJ12aqp+ndsdoxBl2vp4urnK2cC4A2tTwMSql2eIku02Hic8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B49STXc9; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-39129fc51f8so140615f8f.0
        for <bpf@vger.kernel.org>; Wed, 05 Mar 2025 18:20:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741227649; x=1741832449; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JvHY8kN012bWiALssiRDwzEf5vXxsJnuzthiRh+Tr1I=;
        b=B49STXc9d52qPit2eaD6ahKV5TCrvOw9j5oXQRUrkcyf2c7bJSC0uGEi4vrwdhsMgW
         hqs2OmDs3ysZOtLVVF/Kxja9qjtXglzoJXt+ujGJzM1ZgTi00RfmBvjAhR1fmBv1umd3
         0LMARW1R88a5ICc+JS+VmDp9jjx4RRhRIWf8IvVai/qgvP3VwlcnBqUTu9JpSJ9i2rX5
         tHq5Kcb2V1msnnhWFljwuj1aZneMYnVTxsE6vyBOK+4L/fVy8XgQ04fN6VYKe3w1qwce
         1gRZ5IVBkQkjRDNqQFFRY1BRdYk6p7nFyyzQIi8/ENetMGx3sE8NfA4XrJoNL6s/VdXt
         ixsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741227649; x=1741832449;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JvHY8kN012bWiALssiRDwzEf5vXxsJnuzthiRh+Tr1I=;
        b=f6ip6KoOvk4iZ6rgAC3/ZA4wvIAO0E3X5U0zmMaWoigTdLaaSneuEzj5KBWGt1nu0Y
         a7q7SoYvTr7OY7BcGXIO/n2tG9XOjI/nLIuXdFfUQ+lIVwAEpJm+srlEm7lbfgh0i/Qe
         1g9G9jEoWaB2IAVXM/V7f054Jx6VxAameB5+9HXeasVL6BD13bksaL7tcH6a311GSG9E
         gO4pNJXrKxxK3feptRtNLF3Iv+ju2AHsTtgxCZN72CE95DWuH6yf7ty5rTglinaWBF3H
         Pc9g0IC2wSe3XFpVTf/Uwk8njNTyAahwCkGLcmUv9+y5TKrqJ1llbZkdrvRcekHp/2iM
         kLqQ==
X-Forwarded-Encrypted: i=1; AJvYcCVYk9IrAacGgT/ZK1ZTWAQojQkh3+imQoOubJ3dMcHhDr4Bvkm4WLh7QD/b7d258IvaxIA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiaWSTrKWHOWvySq9Qhvg/VSSCsH00lCbfqMqEm66wvZN4OvPZ
	JDBXclkSeO6VqwTBI+dACUUt3urE5iHI8pD06DQtnZGOrAYP7zgjXIUEHk3/mhsOD6zrpUKsbSu
	HImPowX2Pn4yreCEFX+bEHc+6V+Q=
X-Gm-Gg: ASbGncsj0Ih+Mm2K7/03ETxklQ8buurk8m0v2HX6bsMa0/qglY2VLBAOWulAphBg+Df
	GC6gOCPV/Nci9rgOEj9wnz/Ddq7IYRgLeqJcWLYIkXa8LRbmiP9stjHVtzHQFEIkjQn3afZGevR
	QI6gsj0+muUcRrxk5jn4cLfq5IVEx7RAQbqvbYGZCevA==
X-Google-Smtp-Source: AGHT+IHWCfGaoM89S3JtP5llfcRVspoQDlpxcZhNUgXWCX7mT6RowkwlKVMHPiqEcy+EIFTE5UG8rIgxK1TtuoyKmJ4=
X-Received: by 2002:a05:6000:400e:b0:38b:d7d2:12f6 with SMTP id
 ffacd0b85a97d-3911f726f14mr4443226f8f.2.1741227648807; Wed, 05 Mar 2025
 18:20:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250305211235.368399-1-emil@etsalapatis.com> <20250305211235.368399-3-emil@etsalapatis.com>
 <7deb7f8c-d196-ac21-4857-9f8deb65b1f5@huaweicloud.com>
In-Reply-To: <7deb7f8c-d196-ac21-4857-9f8deb65b1f5@huaweicloud.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 5 Mar 2025 18:20:37 -0800
X-Gm-Features: AQ5f1JqWRFit0BFiNUoKLMBiAQwQKTVQjvPEH4-ibFygbGkZEMn3tFhFcAibOnk
Message-ID: <CAADnVQLJ6SNaBVO506oT-b82XU5R+_yh74NJmo-=SqTiHyeE+Q@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] selftests: bpf: add bpf_cpumask_fill selftests
To: Hou Tao <houtao@huaweicloud.com>
Cc: Emil Tsalapatis <emil@etsalapatis.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eddy Z <eddyz87@gmail.com>, 
	Yonghong Song <yonghong.song@linux.dev>, Tejun Heo <tj@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 5, 2025 at 5:57=E2=80=AFPM Hou Tao <houtao@huaweicloud.com> wro=
te:
>
> Hi,
>
> On 3/6/2025 5:12 AM, Emil Tsalapatis wrote:
> > Add selftests for the bpf_cpumask_fill helper that sets a bpf_cpumask t=
o
> > a bit pattern provided by a BPF program.
> >
> > Signed-off-by: Emil Tsalapatis (Meta) <emil@etsalapatis.com>
> > ---
> >  .../selftests/bpf/progs/cpumask_failure.c     |  38 ++++++
> >  .../selftests/bpf/progs/cpumask_success.c     | 114 ++++++++++++++++++
> >  2 files changed, 152 insertions(+)
>
> My local build failed due to the missed declaration of
> "bpf_cpumask_populate" in cpumask_common.h. It reported the following err=
or:
>
> progs/cpumask_success.c:788:8: error: call to undeclared function
> 'bpf_cpumask_populate'; ISO C99 and later do not support implicit fun
> ction declarations [-Wimplicit-function-declaration]
>   788 |         ret =3D bpf_cpumask_populate((struct cpumask *)local,
> &toofewbits, sizeof(toofewbits));
>
> Don't know the reason why CI succeeded.

You need to upgrade pahole to make sure it emits kfuncs into vmlinux.h

>
> > diff --git a/tools/testing/selftests/bpf/progs/cpumask_failure.c b/tool=
s/testing/selftests/bpf/progs/cpumask_failure.c
> > index b40b52548ffb..8a2fd596c8a3 100644
> > --- a/tools/testing/selftests/bpf/progs/cpumask_failure.c
> > +++ b/tools/testing/selftests/bpf/progs/cpumask_failure.c
> > @@ -222,3 +222,41 @@ int BPF_PROG(test_invalid_nested_array, struct tas=
k_struct *task, u64 clone_flag
> >
> >       return 0;
> >  }
> > +
> > +SEC("tp_btf/task_newtask")
> > +__failure __msg("type=3Dscalar expected=3Dfp")
> > +int BPF_PROG(test_populate_invalid_destination, struct task_struct *ta=
sk, u64 clone_flags)
> > +{
> > +     struct bpf_cpumask *invalid =3D (struct bpf_cpumask *)0x123456;
> > +     u64 bits;
> > +     int ret;
> > +
> > +     ret =3D bpf_cpumask_populate((struct cpumask *)invalid, &bits, si=
zeof(bits));
> > +     if (!ret)
> > +             err =3D 2;
> > +
> > +     return 0;
> > +}
> > +
> > +SEC("tp_btf/task_newtask")
> > +__failure __msg("leads to invalid memory access")
> > +int BPF_PROG(test_populate_invalid_source, struct task_struct *task, u=
64 clone_flags)
> > +{
> > +     void *garbage =3D (void *)0x123456;
> > +     struct bpf_cpumask *local;
> > +     int ret;
> > +
> > +     local =3D create_cpumask();
> > +     if (!local) {
> > +             err =3D 1;
> > +             return 0;
> > +     }
> > +
> > +     ret =3D bpf_cpumask_populate((struct cpumask *)local, garbage, 8)=
;
> > +     if (!ret)
> > +             err =3D 2;
> > +
> > +     bpf_cpumask_release(local);
> > +
> > +     return 0;
> > +}
> > diff --git a/tools/testing/selftests/bpf/progs/cpumask_success.c b/tool=
s/testing/selftests/bpf/progs/cpumask_success.c
> > index 80ee469b0b60..5dc0fe9940dc 100644
> > --- a/tools/testing/selftests/bpf/progs/cpumask_success.c
> > +++ b/tools/testing/selftests/bpf/progs/cpumask_success.c
> > @@ -757,6 +757,7 @@ int BPF_PROG(test_refcount_null_tracking, struct ta=
sk_struct *task, u64 clone_fl
> >       mask1 =3D bpf_cpumask_create();
> >       mask2 =3D bpf_cpumask_create();
> >
> > +
> >       if (!mask1 || !mask2)
> >               goto free_masks_return;
>
> An extra newline.
> >
> > @@ -770,3 +771,116 @@ int BPF_PROG(test_refcount_null_tracking, struct =
task_struct *task, u64 clone_fl
> >               bpf_cpumask_release(mask2);
> >       return 0;
> >  }
> > +
> > +SEC("tp_btf/task_newtask")
> > +__success
>
> For tp_btf, bpf_prog_test_run() doesn't run the prog and it just returns
> directly, therefore, the prog below is not exercised at all. How about
> add test_populate_reject_small_mask into cpumask_success_testcases
> firstly, then switch these test cases to use __success() in a following
> patch ?

Good point. I'll revert and wait for respin.

