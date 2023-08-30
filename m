Return-Path: <bpf+bounces-8997-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFAB178DA18
	for <lists+bpf@lfdr.de>; Wed, 30 Aug 2023 20:36:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B2DF28117B
	for <lists+bpf@lfdr.de>; Wed, 30 Aug 2023 18:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 302407484;
	Wed, 30 Aug 2023 18:36:06 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F4A6AA2
	for <bpf@vger.kernel.org>; Wed, 30 Aug 2023 18:36:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 577F5C433CB
	for <bpf@vger.kernel.org>; Wed, 30 Aug 2023 18:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693420564;
	bh=Jjo2G7i5fiDt0J0f1Yxem3njfcz/YLpvvyGU0Ad+Si0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=EjXfH+S9xXDSuCOTjnJcXrPFyadh4+STgnwFrqK+F2OdYvolEaBeuzuAG6mN0YnCi
	 Kro9RdagBMCz1D0g3v1PTnm4nBKVNYM1U5ZzyHaAyYyevHgypUMV9SFTgN6uzv16Xh
	 2z7w3qbaCxrF2WDlQcRjPBMZhrCK1e5fmILs2yY9ZP6qOE7gLRvoKtuisBxegS/IZI
	 hGwh2pLUeDSCRwoccn15kdDklrZrD+7DKT+TUNX5asaZwvfwnQCHkrliBDgL4o098w
	 DyqAEtiW9pg/Qhiu+LM25VnQIPnCDn/zLZj4V0tT5A3G0fwPrWJd6eKgn16f4vI5iw
	 ECEp+krf6qmqQ==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-500bbe3ef0eso1451071e87.1
        for <bpf@vger.kernel.org>; Wed, 30 Aug 2023 11:36:04 -0700 (PDT)
X-Gm-Message-State: AOJu0YykBZkk6li/nY8erPp9zVzycNrBNWyAvfqO1tC9Kpv0vJyNHWU9
	3TPUVB4oqlIJLyvjtJzNd+3PlGtrOEFqGZh2tcc=
X-Google-Smtp-Source: AGHT+IFAEa6ILCXGuvmg3lJ82WZtad3Xt46PSNfiJ+qH1Vxr/1jfCAZ7GwboePM9QEBEZNDrK3eQDPdIO4EcsdATrDs=
X-Received: by 2002:a05:6512:a90:b0:4fd:d254:edc6 with SMTP id
 m16-20020a0565120a9000b004fdd254edc6mr142768lfu.26.1693420562312; Wed, 30 Aug
 2023 11:36:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230830093502.1436694-1-jolsa@kernel.org> <ZO9DvsaOImg4Dt5r@krava>
In-Reply-To: <ZO9DvsaOImg4Dt5r@krava>
From: Song Liu <song@kernel.org>
Date: Wed, 30 Aug 2023 14:35:49 -0400
X-Gmail-Original-Message-ID: <CAPhsuW56Bc_Ynd=uduJ1OwHLZD40GqzrD89W8-AjGKN=bmgzng@mail.gmail.com>
Message-ID: <CAPhsuW56Bc_Ynd=uduJ1OwHLZD40GqzrD89W8-AjGKN=bmgzng@mail.gmail.com>
Subject: Re: [RFC/PATCH bpf-next] bpf: Fix d_path test after last fs update
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Hou Tao <houtao1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 30, 2023 at 9:27=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Wed, Aug 30, 2023 at 11:35:02AM +0200, Jiri Olsa wrote:
> > Recent commit [1] broken d_path test, because now filp_close is not
> > called directly from sys_close, but eventually later when the file
> > is finally released.
> >
> > I can't see any other solution than to hook filp_flush function and
> > that also means we need to add it to btf_allowlist_d_path list, so
> > it can use the d_path helper.
> >
> > But it's probably not very stable because filp_flush is static so it
> > could be potentially inlined.
>
> looks like llvm makes it inlined (from CI)
>
>   Error: #68/1 d_path/basic
>   libbpf: prog 'prog_close': failed to find kernel BTF type ID of 'filp_f=
lush': -3
>
> jirka

I played with it for a bit, but haven't got a good solution. Maybe we shoul=
d
just remove the test for close()?

Thanks,
Song
>
> >
> > Also if we'd keep the current filp_close hook and find a way how to 'wa=
it'
> > for it to be called so user space can go with checks, then it looks
> > like d_path might not work properly when the task is no longer around.

[...]

