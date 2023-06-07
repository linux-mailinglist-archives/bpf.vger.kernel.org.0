Return-Path: <bpf+bounces-2042-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 891017270B5
	for <lists+bpf@lfdr.de>; Wed,  7 Jun 2023 23:48:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0D341C20E9D
	for <lists+bpf@lfdr.de>; Wed,  7 Jun 2023 21:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D014B3B8BF;
	Wed,  7 Jun 2023 21:48:00 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92F03AE79
	for <bpf@vger.kernel.org>; Wed,  7 Jun 2023 21:48:00 +0000 (UTC)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C8DA1BFA
	for <bpf@vger.kernel.org>; Wed,  7 Jun 2023 14:47:58 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-51496f57e59so2056766a12.2
        for <bpf@vger.kernel.org>; Wed, 07 Jun 2023 14:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686174477; x=1688766477;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UMiBZbCTvXtLjJPjWPvh5MkXxGgEvI1CUX185xABSGI=;
        b=nIKc+0+F2jS2IPn9e7Kh4ySNhhzJ3bbNXnAKpv8eX8gmKQFysSMqSRtwZi+WLXmvJG
         bT8OJiJRqgd9ASBVuXrRQ9Toakm37PWQyHVjJTYRGxjmdSWv7DP4dxx0yaG+CbCLGnGE
         YBsYCfIodhVQCPf7j3kxFimW/1Vw15Q+4IY7T6bx76Cpjs+a3sYXIRJvjdJczgoBFknn
         /PvjsXiwqafJn1Cdbhp0eO4HXhwrp3SyPDOdSKbm7/mpOdxKZvLR82YnyKjsstVIw9Q7
         iLIu2L1gzLUyJJ0I6s6C5KMNjr9OIRwyKIiTGwJIjdWHWVCfdeLSQSsfcy8jwNRVVu0o
         VOgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686174477; x=1688766477;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UMiBZbCTvXtLjJPjWPvh5MkXxGgEvI1CUX185xABSGI=;
        b=NTq3Cm5a8MJwbyNeC6oUCtU9+9JrmPH77Lq4yI1Rndd97hboHfAkU6Guki/CR6qGvI
         0RjdUk9LZM6zNmFvPXngffMp2UnAJlWOThDiP/Br1rh7it3WcEWTO41e7P0xMTYD+7/W
         whpIAPZvTQBl0kaJKU/nvj+/ev2T160jx5viQob1BK/5um+/2/srcuOHUNHAd7Lw78eo
         Iqv7b0cNNu6Prb1dnju9vFz9m42zvcaSPieA5dkw8eZWWWuuM35Kqn2CrMEwJnkBo+Qs
         wTS+QSiRDX3YJhXUkBuw78u0naSSiL6tNBGPyD+E3OZ9XplWigQohNx6qg9uaI/3oTw8
         UKMg==
X-Gm-Message-State: AC+VfDyIDsz0tvI063zse8Mm5yx0dg1Uca68ZYLWZhslGaAMeXQgM3sn
	mqby5lWqtdzPi7nGkCu1vcnGbxWTFY1aPkyRNBY=
X-Google-Smtp-Source: ACHHUZ5vhicOqf4T0z5lPf4bHwSiqntOw/2i5pJVfKdh+i+dZ2AIdkm1q2Ob5cjr5Q7SgXJ0h905YsSV4JCqac2fohU=
X-Received: by 2002:aa7:c0d7:0:b0:50c:451b:d0f0 with SMTP id
 j23-20020aa7c0d7000000b0050c451bd0f0mr5262677edp.37.1686174476780; Wed, 07
 Jun 2023 14:47:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230531201936.1992188-1-alan.maguire@oracle.com>
 <20230531201936.1992188-2-alan.maguire@oracle.com> <20230601035354.5u56fwuundu6m7v2@MacBook-Pro-8.local>
 <89787945-c06c-1c41-655b-057c1a3d07dd@oracle.com> <CAADnVQ+2ZuX00MSxAXWcXmyc-dqYtZvGqJ9KzJpstv183nbPEA@mail.gmail.com>
 <CAEf4BzZaUEqYnyBs6OqX2_L_X=U4zjrKF9nPeyyKp7tRNVLMww@mail.gmail.com>
 <CAADnVQKbmAHTHk5YsH-t42BRz16MvXdRBdFmc5HFyCPijX-oNg@mail.gmail.com>
 <CAEf4BzamU4qTjrtoC_9zwx+DHyW26yq_HrevHw2ui-nqr6UF-g@mail.gmail.com>
 <CAADnVQ+_YeLZ0kmF+QueH_xE10=b-4m_BMh_-rct6S8TbpL0hw@mail.gmail.com>
 <CAEf4Bzbtptc9DUJ8peBU=xyrXxJFK5=rkr3gGRh05wwtnBZ==A@mail.gmail.com>
 <CAADnVQJAmYgR91WKJ_Jif6c3ja=OAmkMXoUO9sTnmp-xmnbVJQ@mail.gmail.com>
 <878rcw3k1o.fsf@toke.dk> <35e5f70bbe0890f875e0c24aff0453c25f018ea6.camel@gmail.com>
 <e58d3ec4-dcac-48b8-c6c2-63d131d967d8@meta.com> <45fac5ac0874163031b46388d65de194ed6f27e6.camel@gmail.com>
In-Reply-To: <45fac5ac0874163031b46388d65de194ed6f27e6.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 7 Jun 2023 14:47:44 -0700
Message-ID: <CAEf4BzY9_EiBqM74Gce9-Z5O+uubCY=CUejXr79hDY6SbOvTOg@mail.gmail.com>
Subject: Re: [RFC bpf-next 1/8] btf: add kind metadata encoding to UAPI
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Yonghong Song <yhs@meta.com>, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@kernel.org>, 
	Alexei Starovoitov <alexei.starovoitov@gmail.com>, Alan Maguire <alan.maguire@oracle.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Quentin Monnet <quentin@isovalent.com>, Mykola Lysenko <mykolal@fb.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jun 7, 2023 at 9:14=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> On Wed, 2023-06-07 at 08:29 -0700, Yonghong Song wrote:
> >
> > On 6/7/23 4:55 AM, Eduard Zingerman wrote:
> > > On Tue, 2023-06-06 at 13:30 +0200, Toke H=C3=B8iland-J=C3=B8rgensen w=
rote:
> > > [...]
> > > >
> > > > As for bumping the version number, I don't think it's a good idea t=
o
> > > > deliberately break compatibility this way unless it's absolutely
> > > > necessary. With "absolutely necessary" meaning "things will break i=
n
> > > > subtle ways in any case, so it's better to make the breakage obviou=
s".
> > > > But it libbpf is not checking the version field anyway, that become=
s
> > > > kind of a moot point, as bumping it doesn't really gain us anything=
,
> > > > then...
> > >
> > > It seems to me that in terms of backward compatibility, the ability t=
o
> > > specify the size for each kind entry is more valuable than the
> > > capability to add new BTF kinds:
> > > - The former allows for extending kind records in
> > >    a backward-compatible manner, such as adding a function address to
> > >    BTF_KIND_FUNC.
> >
> > Eduard, the new proposal is to add new kind, e.g., BTF_KIND_KFUNC, whic=
h
> > will have an 'address' field. BTF_KIND_KFUNC is for kernel functions.
> > So we will not have size compatibility issue for BTF_KIND_FUNC.
>
> Well, actually this might be a way to avoid BTF_KIND_KFUNC :)
> What I wanted to say is that any use of this feature leads to
> incompatibility with current BTF parsers, as either size of existing
> kinds would be changed or a new kind with unknown size would be added.
> It seems to me that this warrants version bump (or some other way to
> signal existing parsers that format is incompatible).

It is probably too late to have existing KINDs changing their size. If
this layout metadata was mandatory from the very beginning, then we
could have relied on it for determining new extra fields for
BTF_KIND_FUNC.

As things stand right now, new BTF_KIND_KFUNC is both a signal of
newer format (for kernel-side BTF; nothing changes for BPF object file
BTFs, which is great side-effect making backwards compat pain
smaller), and is a simpler and safer way to add extra information.

>
> >
> > > - The latter is much more fragile. Types refer to each other,
> > >    compatibility is already lost once a new "unknown" tag is introduc=
ed
> > >    in a type chain.
> > >
> > > However, changing the size of existing BTF kinds is itself a
> > > backward-incompatible change. Therefore, a version bump may be
> > > warranted in this regard.
>

See above and previous emails. Not having to bump version means we can
start emitting this layout info from Clang and pahole with no extra
opt-in flags, and not worry about breaking existing tools and apps.
This is great, so let's not ruin that property :)

