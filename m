Return-Path: <bpf+bounces-42703-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B62BB9A939E
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 01:02:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F9A8B21E27
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 23:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 237791FDF9C;
	Mon, 21 Oct 2024 23:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VX1PWddo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ECF9198A17
	for <bpf@vger.kernel.org>; Mon, 21 Oct 2024 23:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729551750; cv=none; b=Elu/ma6F+m6+kjWzPaH73NYPmeaMFjuhbHy0qrCnI5jHCA0FFJ99uMuYUPrz2cbaVWWo/WZ3mLvYR44lnwk97cJ1iW1TRKIIQp9vjlx6ywgDQKR5P/vfeD6RH0xMEF3xpN7CcaLZ73KgzVqIkqvV6NiFYf2wFxvweuzw59BuCuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729551750; c=relaxed/simple;
	bh=He4SdKSRNGj9OuToneZJVQtLlMfhNN93kmQ6XVdNxII=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JkBYSofxtbi4mshT/+w+TnqFFVGSpdowcm/b/D5582FF2PqgCb4rjQFDGdRpnUtGpB1OSzXguoeVZM98oHeIUZdi7yGpegF2tdTquOcaFSQxDgQDXrCKadYYrDbHM8hzRZ8DmD71ter+3anLrMCvbwGjTKlBSoETmmS9OOVFuF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VX1PWddo; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-71ec12160f6so1260122b3a.3
        for <bpf@vger.kernel.org>; Mon, 21 Oct 2024 16:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729551747; x=1730156547; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ki/lWo8mHZ3TrB2YhkH93BhiS7I6taUYy9jvTn8upmU=;
        b=VX1PWddoOX6lvZvcYjScJX+KOTMM5F1aYYlPJ85kIDDR7D7lgje59dzKZmJoOKBPE7
         VGW0DhD1QjERG5SSah5TDK+xAbHh/ksx8YgIiYZ1kZBf7q+zFgKS5QObagvkbfdpb6Xm
         264PKTeV1xBBponQjx5uXrlXMrCl2oKSQIkqXK6YMI2qY80twZKFzfxsn7Dgwx6+cPnB
         J2VF1bsNXG+EyBUbk53c5RxURp2dIoE1HzQrK/DnBPT+ykE4oxdjVQRUqT7AgA9X9pcL
         ETIVXHeKlChlVAt78Xx2+Ra6kYXs49B8+jZyOuKV6rfKZHMpwtSFAvNQX/cr/qk1jFIl
         gzTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729551747; x=1730156547;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ki/lWo8mHZ3TrB2YhkH93BhiS7I6taUYy9jvTn8upmU=;
        b=hGzhYsU56r+7xQ4Zh3ggyRAAQ+EmWVay5OTPtMXkBiCAkd0oFBu75qH6r8GgESouBW
         d7Mj78Q+WLtQXgJ7mG6ShNdytZCUviGS4meiFaMvaoJ8+/8xHeZrUwdx6CJ35USXKBJi
         C61YRacOF6d7u7Cci/HzFdwJgnQK8kl+Y0m/J5xRU8Bt4zd9gtZUwv74jNAz8DduWJ61
         iBc1xt2ROj5GrCAy91Nwq7oxa4DP7sgNE0em/i30V/3gsXwEclU+NTuJxH8Hc0YdrbL5
         c+tVe1qayMrtzcqbmkMeUEAi1aAC1Qovjn7lYrskKyNWAh3xIabz3uSHA64ap4WEoB+e
         mWKA==
X-Forwarded-Encrypted: i=1; AJvYcCW9iWDdwAvAhIvAykV4mWjgVf5EjkVbx92ddHgrYO6hatcdFeeSN7bCIOQDVMgQf2qxZAo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwroL+aIL9/Rj4Pza8GfAA9kDBs5yZUz/65MD6TXKD93IwzB0gV
	E68Ukj4PeZMhUULvbNXrfldASyR1iuiHbhI1Vz88zEQfVWteYTqpCMEEkAHikvzF3xfwPNU5AQc
	Ye1nA/dlL1Nh09OqbZzzR+UxNdDI=
X-Google-Smtp-Source: AGHT+IE7skyI75Q+LpDbfeW1djm/URPOZCW3YemT1DSvsuSmTqgCImzSk65QSaghN9ZxS3/qC/56L5nrgyQHsqHyI3s=
X-Received: by 2002:a05:6a00:194a:b0:71e:786c:3fa9 with SMTP id
 d2e1a72fcca58-71ea3085322mr19872183b3a.0.1729551747307; Mon, 21 Oct 2024
 16:02:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241021014004.1647816-1-houtao@huaweicloud.com>
 <20241021014004.1647816-3-houtao@huaweicloud.com> <ZxYOX9_sIrSKGFB2@krava>
In-Reply-To: <ZxYOX9_sIrSKGFB2@krava>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 21 Oct 2024 16:02:14 -0700
Message-ID: <CAEf4BzbFBbTDGSwTdgFJG5poFpCrjjpPO9OujYVZXPxTEUXqeQ@mail.gmail.com>
Subject: Re: [PATCH bpf v2 2/7] bpf: Add assertion for the size of bpf_link_type_strs[]
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Hou Tao <houtao@huaweicloud.com>, bpf@vger.kernel.org, 
	Martin KaFai Lau <martin.lau@linux.dev>, Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Hao Luo <haoluo@google.com>, Yonghong Song <yonghong.song@linux.dev>, 
	Daniel Borkmann <daniel@iogearbox.net>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, John Fastabend <john.fastabend@gmail.com>, 
	Yafang Shao <laoar.shao@gmail.com>, houtao1@huawei.com, xukuohai@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2024 at 1:18=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Mon, Oct 21, 2024 at 09:39:59AM +0800, Hou Tao wrote:
> > From: Hou Tao <houtao1@huawei.com>
> >
> > If a corresponding link type doesn't invoke BPF_LINK_TYPE(), accessing
> > bpf_link_type_strs[link->type] may result in out-of-bound access.
> >
> > To prevent such missed invocations in the future, the following static
> > assertion seems feasible:
> >
> >   BUILD_BUG_ON(ARRAY_SIZE(bpf_link_type_strs) !=3D __MAX_BPF_LINK_TYPE)
> >
> > However, this doesn't work well. The reason is that the invocation of
> > BPF_LINK_TYPE() for one link type is optional due to its CONFIG_XXX
> > dependency and the elements in bpf_link_type_strs[] will be sparse. For
> > example, if CONFIG_NET is disabled, the size of bpf_link_type_strs will
> > be BPF_LINK_TYPE_UPROBE_MULTI + 1.
> >
> > Therefore, in addition to the static assertion, remove all CONFIG_XXX
> > conditions for the invocation of BPF_LINK_TYPE(). If these CONFIG_XXX
> > conditions become necessary later, the fix may need to be revised (e.g.=
,
> > to check the validity of link_type in bpf_link_show_fdinfo()).
> >
> > Signed-off-by: Hou Tao <houtao1@huawei.com>
> > ---
> >  include/linux/bpf_types.h | 6 ------
> >  kernel/bpf/syscall.c      | 2 ++
> >  2 files changed, 2 insertions(+), 6 deletions(-)
> >
> > diff --git a/include/linux/bpf_types.h b/include/linux/bpf_types.h
> > index fa78f49d4a9a..6b7eabe9a115 100644
> > --- a/include/linux/bpf_types.h
> > +++ b/include/linux/bpf_types.h
> > @@ -136,21 +136,15 @@ BPF_MAP_TYPE(BPF_MAP_TYPE_ARENA, arena_map_ops)
> >
> >  BPF_LINK_TYPE(BPF_LINK_TYPE_RAW_TRACEPOINT, raw_tracepoint)
> >  BPF_LINK_TYPE(BPF_LINK_TYPE_TRACING, tracing)
> > -#ifdef CONFIG_CGROUP_BPF
> >  BPF_LINK_TYPE(BPF_LINK_TYPE_CGROUP, cgroup)
> > -#endif
> >  BPF_LINK_TYPE(BPF_LINK_TYPE_ITER, iter)
> > -#ifdef CONFIG_NET
> >  BPF_LINK_TYPE(BPF_LINK_TYPE_NETNS, netns)
> >  BPF_LINK_TYPE(BPF_LINK_TYPE_XDP, xdp)
> >  BPF_LINK_TYPE(BPF_LINK_TYPE_NETFILTER, netfilter)
> >  BPF_LINK_TYPE(BPF_LINK_TYPE_TCX, tcx)
> >  BPF_LINK_TYPE(BPF_LINK_TYPE_NETKIT, netkit)
> >  BPF_LINK_TYPE(BPF_LINK_TYPE_SOCKMAP, sockmap)
> > -#endif
> > -#ifdef CONFIG_PERF_EVENTS
> >  BPF_LINK_TYPE(BPF_LINK_TYPE_PERF_EVENT, perf)
> > -#endif

I'm not sure what's the implication here, but I'd avoid doing that.
But see below.

> >  BPF_LINK_TYPE(BPF_LINK_TYPE_KPROBE_MULTI, kprobe_multi)
> >  BPF_LINK_TYPE(BPF_LINK_TYPE_STRUCT_OPS, struct_ops)
> >  BPF_LINK_TYPE(BPF_LINK_TYPE_UPROBE_MULTI, uprobe_multi)
> > diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> > index 8cfa7183d2ef..9f335c379b05 100644
> > --- a/kernel/bpf/syscall.c
> > +++ b/kernel/bpf/syscall.c
> > @@ -3071,6 +3071,8 @@ static void bpf_link_show_fdinfo(struct seq_file =
*m, struct file *filp)
> >       const struct bpf_prog *prog =3D link->prog;
> >       char prog_tag[sizeof(prog->tag) * 2 + 1] =3D { };
> >
> > +     BUILD_BUG_ON(ARRAY_SIZE(bpf_link_type_strs) !=3D __MAX_BPF_LINK_T=
YPE);

If this is useless, why are you adding it?

Let's instead do a NULL check inside bpf_link_show_fdinfo() to handle
sparsity. And to avoid out-of-bounds, just add

[__MAX_BPF_LINK_TYPE] =3D NULL,

into the definition of bpf_link_type_strs

pw-bot: cr

>
> I wonder it'd be simpler to just kill BPF_LINK_TYPE completely
> and add link names directly to bpf_link_type_strs array..
> it seems it's the only purpose of the BPF_LINK_TYPE macro
>

This seems like a bit too short-sighted approach, let's not go there just y=
et.

> jirka

