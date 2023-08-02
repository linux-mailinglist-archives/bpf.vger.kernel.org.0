Return-Path: <bpf+bounces-6670-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B79DE76C335
	for <lists+bpf@lfdr.de>; Wed,  2 Aug 2023 04:58:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 720CA281AD0
	for <lists+bpf@lfdr.de>; Wed,  2 Aug 2023 02:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22127A4C;
	Wed,  2 Aug 2023 02:57:54 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C51A3D
	for <bpf@vger.kernel.org>; Wed,  2 Aug 2023 02:57:53 +0000 (UTC)
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A559026B6
	for <bpf@vger.kernel.org>; Tue,  1 Aug 2023 19:57:50 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id 6a1803df08f44-63d30b90197so38035706d6.0
        for <bpf@vger.kernel.org>; Tue, 01 Aug 2023 19:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690945070; x=1691549870;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+HKOX0SmM/81J9ViK7C4z7y3ufvWQ8Xy7+xzjB8omWY=;
        b=fKG7YpruR2bzXSZ3hDHkwj8+SbasooscZHzn3Q2TcDyj5WSjDgTIjLyEMLzwEZDY4i
         JLZ7gnBPjPbinh4FDqgHL5YAtuRaw0GLyGe7o14xE5E81KdBlcAw2bdMpz2u4ibDVxQH
         m1NzDisSBsxdB8NeMauDvE1NoTbQ5mUcCo5Jwnk1UWAD1UeV6+5cyefTM/PCBX8DH58h
         ZoIRh6e4Yvs+4Zz+trWq5SHU373DGpDznJOZq+2ujkn0UxBHi3wADkJgkHfOzEZwAeaP
         ul+tT6qsp9pMT4EaChgrpORnjc7VxsAWvtX/tIJBJJF7qZo+gw8PPLef/TgB7Aqb0PEv
         S2uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690945070; x=1691549870;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+HKOX0SmM/81J9ViK7C4z7y3ufvWQ8Xy7+xzjB8omWY=;
        b=LntncDkRtJsFZjuYCFMnucgfOBd2VA5uJImddscgxi1PKQPqiLp+9Arhg9TJBBVPnx
         ZdIv9bGskUBmwGoYuuUrh0pzSn/ZndncF9QBia9ecMhy15ZXWp1cIfBDGEL8EDHVYwC0
         yDvoCPP7+MwHh6loTe90cCmLvzdZx31dAU/GAL7fzPG+q6Vwai0wCLCowl1wC31ctPys
         sLlRPitfye9fCGrZJzNOIQ48qvuRsrfiw+6NvTy0TygO55SbYmSc568jD5KVCZT+OjDL
         tF4KnmPAFiX3aU5aGXgd9+eiOP7cSojot5eKzZAX8KR8B7WgT2pv5DXASSzJPOONyIIE
         HDRw==
X-Gm-Message-State: ABy/qLZiyAkXg85T9gAofG0qt9ZzR5cAHxDSF8fCqj5Em4uAkykFIvHx
	LcGHNe9ju4tGHT4SILD8ni3lsfBbvamknGw4xGY=
X-Google-Smtp-Source: APBJJlERBo2D3tK4E05NfV5Q+oJjXPnWyNLaVxyluims0GAyYuI9iVOXR4UElQtAtaII4OBX5GpjY5Z+TYN6Eh0fg6M=
X-Received: by 2002:a0c:dd0b:0:b0:63d:212e:8ae7 with SMTP id
 u11-20020a0cdd0b000000b0063d212e8ae7mr13988989qvk.14.1690945069758; Tue, 01
 Aug 2023 19:57:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230801142912.55078-1-laoar.shao@gmail.com> <3f56b3b3-9b71-f0d3-ace1-406a8eeb64c0@linux.dev>
 <CALOAHbAnyorNdYAp1FretQcqEp_j6mQ93ATwx02auLTYnL_0KQ@mail.gmail.com> <CAADnVQKwY+j6JrxJ4dc1M7yhkSf958ubSH=WB7dKmHt9Ac9gQQ@mail.gmail.com>
In-Reply-To: <CAADnVQKwY+j6JrxJ4dc1M7yhkSf958ubSH=WB7dKmHt9Ac9gQQ@mail.gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Wed, 2 Aug 2023 10:57:13 +0800
Message-ID: <CALOAHbDsuWrJLfdSvxReEgRvKpwKo+Z0sN0sNLXMUeFJ7GHg0A@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 0/3] bpf: Add new bpf helper bpf_for_each_cpu
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: David Vernet <void@manifault.com>, Yonghong Song <yonghong.song@linux.dev>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Aug 2, 2023 at 10:46=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Aug 1, 2023 at 7:34=E2=80=AFPM Yafang Shao <laoar.shao@gmail.com>=
 wrote:
> >
> > >
> > > In kernel, we have a global variable
> > >     nr_cpu_ids (also in kernel/bpf/helpers.c)
> > > which is used in numerous places for per cpu data struct access.
> > >
> > > I am wondering whether we could have bpf code like
> > >     int nr_cpu_ids __ksym;
> > >
> > >     struct bpf_iter_num it;
> > >     int i =3D 0;
> > >
> > >     // nr_cpu_ids is special, we can give it a range [1, CONFIG_NR_CP=
US].
> > >     bpf_iter_num_new(&it, 1, nr_cpu_ids);
> > >     while ((v =3D bpf_iter_num_next(&it))) {
> > >            /* access cpu i data */
> > >            i++;
> > >     }
> > >     bpf_iter_num_destroy(&it);
> > >
> > >  From all existing open coded iterator loops, looks like
> > > upper bound has to be a constant. We might need to extend support
> > > to bounded scalar upper bound if not there.
> >
> > Currently the upper bound is required by both the open-coded for-loop
> > and the bpf_loop. I think we can extend it.
> >
> > It can't handle the cpumask case either.
> >
> >     for_each_cpu(cpu, mask)
> >
> > In the 'mask', the CPU IDs might not be continuous. In our container
> > environment, we always use the cpuset cgroup for some critical tasks,
> > but it is not so convenient to traverse the percpu data of this cpuset
> > cgroup.  We have to do it as follows for this case :
> >
> > That's why we prefer to introduce a bpf_for_each_cpu helper. It is
> > fine if it can be implemented as a kfunc.
>
> I think open-coded-iterators is the only acceptable path forward here.
> Since existing bpf_iter_num doesn't fit due to sparse cpumask,
> let's introduce bpf_iter_cpumask and few additional kfuncs
> that return cpu_possible_mask and others.
>
> We already have some cpumask support in kernel/bpf/cpumask.c
> bpf_iter_cpumask will be a natural follow up.

I will think about it. Thanks for your suggestion.

--=20
Regards
Yafang

