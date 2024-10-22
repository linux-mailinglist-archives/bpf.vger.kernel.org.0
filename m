Return-Path: <bpf+bounces-42804-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA6E29AB547
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 19:40:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CF7F286137
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 17:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 658B91BDAA9;
	Tue, 22 Oct 2024 17:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TBR+EUlD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9A81BDA9C
	for <bpf@vger.kernel.org>; Tue, 22 Oct 2024 17:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729618835; cv=none; b=GxsaXjxakHZMUhrhkoS4fs+86BUON/ni4M3t6xHbF+OVqPZOvdMoo1eXi4pnL6JwZjkCHmsYroW/wQWM65KDzpFpUh4zx+coUqOn0VoKmZoCZY5zUMCrFRTRf9INIR/p3bYX75DCz1w9/ng8sWjXXoYqqdrPWlHhtThKF7Xu4Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729618835; c=relaxed/simple;
	bh=a7HmSZIht4+Yr0q3n4UnkOAE9jCN1X+Dq7AurIhF8j8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C2AYcjZe8eubFcz6Rpo67n/0uENqt9uO8IDj6EOFwaSwpYx9Yg7P8GEQvhSrYjRgeyv6n3n5UP89tVszcQ6I70GE50TFKuZIN8Enz/qbAwB2uZNEoZjwv45E+b7oTU+0+m1PL2fBuRfzSctv8XDT2kOx3EbG24vCpNPy443G13c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TBR+EUlD; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-71e79f73aaeso4218870b3a.3
        for <bpf@vger.kernel.org>; Tue, 22 Oct 2024 10:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729618834; x=1730223634; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9QPo26H3gbNal6JaJ/elpeQe7/xlcJ22zsgottFXefQ=;
        b=TBR+EUlDCbutOIOo/zWbetM9+oB0BqydHUtwcb3/vMdhSYxAhbCHcDyWeUhoU3kyNZ
         nwcukj1shFsG03c+mdxQUxB3YQi9ul5p5fYfnsVEL2PL2faPnsOzIthib6USYiekN2yy
         r4FIUNjfmpAhNFi5JKAZTRa3yplrd1bbKawOlE+l5Hv/aiyJMcMy4jfpf5HiIQih7XQ6
         keedRUsfsZ7UU/RV0EU/Loq1X+/NGjiLxNi51RIqz6PS+EIcUamDJ4PuGYTkDU6ZrQ+O
         BkLEghK6g/esP1IEDXWn5GS2b47u11lV5TuYC+VilUAD0qnllmLRmwt14CO5Fp4zl5Kv
         m9fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729618834; x=1730223634;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9QPo26H3gbNal6JaJ/elpeQe7/xlcJ22zsgottFXefQ=;
        b=meSZHSZHvEkRreclkx5MC+/crOKdnIkPcHTk23ig34I7+xYTFel41HtAPqiO0tbktE
         xx6ZxXANcMtB/b3+xQMetDDDrx4S1nIOMNIO+rkpNylingcNbsX7Evsb6hgBI/C70BaA
         qPrfKNrgQGC5YnOhLMt2/MkhNcAKIMTTask0B3Ar70iDO/naztEGKEx74aFwkwW9r5yX
         jgJlj0nzGpJOW5QlSmBEcVi81NwK75UBeS7rbV8NxjUxObpyzRNkbrLn9XYBv2TWONni
         fyR7YAU7lAAAhJSveekRhX09RuqSOIwDAnJRrbZTU7b/8JercFrul4IL1rnHeKnhqQ34
         KUAA==
X-Forwarded-Encrypted: i=1; AJvYcCUr61HaemrBCR7L1++DEAmEoXvy97za0ILr804skXNZlui3ljTgxe48W3W4Cqwsd7VzWr0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJsdJelIL1K3CqBvpWiB1RXnK3wtKEyqFhM/728pU1O4ldQRS2
	eB/XJiMRWXW72CVjrvGENa5B9jnsMMSjdOLgTLD+mNOaHbEC0+clyYz1J106ORUyOc/6RjgykPP
	/ZnEy6hL5ypql62M6gUajBoxw0E0=
X-Google-Smtp-Source: AGHT+IF7vn6b8LkvHq/58TL5y7I10p5WfHQ6G7nSoFx2zs8nGkEtVctp1YsD5xnshlGgmAPvg8DTaO+Jff5DHvya9ts=
X-Received: by 2002:a05:6a00:17aa:b0:71e:76ac:4fc4 with SMTP id
 d2e1a72fcca58-72030b7b938mr22490b3a.21.1729618833512; Tue, 22 Oct 2024
 10:40:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241021014004.1647816-1-houtao@huaweicloud.com>
 <20241021014004.1647816-3-houtao@huaweicloud.com> <ZxYOX9_sIrSKGFB2@krava>
 <CAEf4BzbFBbTDGSwTdgFJG5poFpCrjjpPO9OujYVZXPxTEUXqeQ@mail.gmail.com> <437ff5b4-4f38-cb3a-8491-d8c7e5cfb8c6@huaweicloud.com>
In-Reply-To: <437ff5b4-4f38-cb3a-8491-d8c7e5cfb8c6@huaweicloud.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 22 Oct 2024 10:40:21 -0700
Message-ID: <CAEf4BzYb--5BpVuiBYrNdtRh3U6HqD45jndb-f-0YCetTZ5hvw@mail.gmail.com>
Subject: Re: [PATCH bpf v2 2/7] bpf: Add assertion for the size of bpf_link_type_strs[]
To: Hou Tao <houtao@huaweicloud.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, bpf@vger.kernel.org, 
	Martin KaFai Lau <martin.lau@linux.dev>, Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Hao Luo <haoluo@google.com>, Yonghong Song <yonghong.song@linux.dev>, 
	Daniel Borkmann <daniel@iogearbox.net>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, John Fastabend <john.fastabend@gmail.com>, 
	Yafang Shao <laoar.shao@gmail.com>, houtao1@huawei.com, xukuohai@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 22, 2024 at 12:36=E2=80=AFAM Hou Tao <houtao@huaweicloud.com> w=
rote:
>
> Hi,
>
> On 10/22/2024 7:02 AM, Andrii Nakryiko wrote:
> > On Mon, Oct 21, 2024 at 1:18=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> =
wrote:
> >> On Mon, Oct 21, 2024 at 09:39:59AM +0800, Hou Tao wrote:
> >>> From: Hou Tao <houtao1@huawei.com>
> >>>
> >>> If a corresponding link type doesn't invoke BPF_LINK_TYPE(), accessin=
g
> >>> bpf_link_type_strs[link->type] may result in out-of-bound access.
> >>>
> >>> To prevent such missed invocations in the future, the following stati=
c
> >>> assertion seems feasible:
> >>>
> >>>   BUILD_BUG_ON(ARRAY_SIZE(bpf_link_type_strs) !=3D __MAX_BPF_LINK_TYP=
E)
> >>>
> >>> However, this doesn't work well. The reason is that the invocation of
> >>> BPF_LINK_TYPE() for one link type is optional due to its CONFIG_XXX
> >>> dependency and the elements in bpf_link_type_strs[] will be sparse. F=
or
> >>> example, if CONFIG_NET is disabled, the size of bpf_link_type_strs wi=
ll
> >>> be BPF_LINK_TYPE_UPROBE_MULTI + 1.
> >>>
> >>> Therefore, in addition to the static assertion, remove all CONFIG_XXX
> >>> conditions for the invocation of BPF_LINK_TYPE(). If these CONFIG_XXX
> >>> conditions become necessary later, the fix may need to be revised (e.=
g.,
> >>> to check the validity of link_type in bpf_link_show_fdinfo()).
> >>>
> >>> Signed-off-by: Hou Tao <houtao1@huawei.com>
> >>> ---
> >>>  include/linux/bpf_types.h | 6 ------
> >>>  kernel/bpf/syscall.c      | 2 ++
> >>>  2 files changed, 2 insertions(+), 6 deletions(-)
> >>>
> >>> diff --git a/include/linux/bpf_types.h b/include/linux/bpf_types.h
> >>> index fa78f49d4a9a..6b7eabe9a115 100644
> >>> --- a/include/linux/bpf_types.h
> >>> +++ b/include/linux/bpf_types.h
> >>> @@ -136,21 +136,15 @@ BPF_MAP_TYPE(BPF_MAP_TYPE_ARENA, arena_map_ops)
> >>>
> >>>  BPF_LINK_TYPE(BPF_LINK_TYPE_RAW_TRACEPOINT, raw_tracepoint)
> >>>  BPF_LINK_TYPE(BPF_LINK_TYPE_TRACING, tracing)
> >>> -#ifdef CONFIG_CGROUP_BPF
> >>>  BPF_LINK_TYPE(BPF_LINK_TYPE_CGROUP, cgroup)
> >>> -#endif
> >>>  BPF_LINK_TYPE(BPF_LINK_TYPE_ITER, iter)
> >>> -#ifdef CONFIG_NET
> >>>  BPF_LINK_TYPE(BPF_LINK_TYPE_NETNS, netns)
> >>>  BPF_LINK_TYPE(BPF_LINK_TYPE_XDP, xdp)
> >>>  BPF_LINK_TYPE(BPF_LINK_TYPE_NETFILTER, netfilter)
> >>>  BPF_LINK_TYPE(BPF_LINK_TYPE_TCX, tcx)
> >>>  BPF_LINK_TYPE(BPF_LINK_TYPE_NETKIT, netkit)
> >>>  BPF_LINK_TYPE(BPF_LINK_TYPE_SOCKMAP, sockmap)
> >>> -#endif
> >>> -#ifdef CONFIG_PERF_EVENTS
> >>>  BPF_LINK_TYPE(BPF_LINK_TYPE_PERF_EVENT, perf)
> >>> -#endif
> > I'm not sure what's the implication here, but I'd avoid doing that.
> > But see below.
>
> OK.
> >>>  BPF_LINK_TYPE(BPF_LINK_TYPE_KPROBE_MULTI, kprobe_multi)
> >>>  BPF_LINK_TYPE(BPF_LINK_TYPE_STRUCT_OPS, struct_ops)
> >>>  BPF_LINK_TYPE(BPF_LINK_TYPE_UPROBE_MULTI, uprobe_multi)
> >>> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> >>> index 8cfa7183d2ef..9f335c379b05 100644
> >>> --- a/kernel/bpf/syscall.c
> >>> +++ b/kernel/bpf/syscall.c
> >>> @@ -3071,6 +3071,8 @@ static void bpf_link_show_fdinfo(struct seq_fil=
e *m, struct file *filp)
> >>>       const struct bpf_prog *prog =3D link->prog;
> >>>       char prog_tag[sizeof(prog->tag) * 2 + 1] =3D { };
> >>>
> >>> +     BUILD_BUG_ON(ARRAY_SIZE(bpf_link_type_strs) !=3D __MAX_BPF_LINK=
_TYPE);
> > If this is useless, why are you adding it?
>
> It will work after removing these CONFIG_XXX dependencies for
> BPF_LINK_TYPE() invocations.
> >
> > Let's instead do a NULL check inside bpf_link_show_fdinfo() to handle
> > sparsity. And to avoid out-of-bounds, just add
> >
> > [__MAX_BPF_LINK_TYPE] =3D NULL,
> >
> > into the definition of bpf_link_type_strs
>
> Instead of outputting a null string for a link_type which didn't invoke
> BPF_LINK_TYPE, is outputting the numerical value of link->type more
> reasonable as shown below ?

In correctly configured kernel this should never happen. So we can
have WARN() there for the NULL case and just return an error or
something.

>
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 2873302faf39..9a02cd914ed8 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -3073,14 +3073,15 @@ static void bpf_link_show_fdinfo(struct seq_file
> *m, struct file *filp)
>         const struct bpf_link *link =3D filp->private_data;
>         const struct bpf_prog *prog =3D link->prog;
>         char prog_tag[sizeof(prog->tag) * 2 + 1] =3D { };
> +       enum bpf_link_type type;
>
> +       if (type < ARRAY_SIZE(bpf_link_type_strs) &&
> bpf_link_type_strs[type])
> +               seq_printf(m, "link_type:\t%s\n", bpf_link_type_strs[type=
]);
> +       else
> +               seq_printf(m, "link_type:\t[%d]\n", type);
> +
> +       seq_printf(m, "link_id:\t%u\n", link->id);
>
> -       seq_printf(m,
> -                  "link_type:\t%s\n"
> -                  "link_id:\t%u\n",
> -                  bpf_link_type_strs[link->type],
> -                  link->id);
>
> >
> > pw-bot: cr
> >
> >> I wonder it'd be simpler to just kill BPF_LINK_TYPE completely
> >> and add link names directly to bpf_link_type_strs array..
> >> it seems it's the only purpose of the BPF_LINK_TYPE macro
> >>
> > This seems like a bit too short-sighted approach, let's not go there ju=
st yet.
> >
> >> jirka
>

