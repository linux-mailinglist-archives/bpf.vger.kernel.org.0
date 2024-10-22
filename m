Return-Path: <bpf+bounces-42823-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B85F69AB794
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 22:27:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41F84283E89
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 20:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CDC21CC142;
	Tue, 22 Oct 2024 20:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DRJIkhXc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498D913E41A
	for <bpf@vger.kernel.org>; Tue, 22 Oct 2024 20:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729628833; cv=none; b=r1Uy5etm50nK4d+7XqQ6WlFb0XxncSOse30JZWyrK7cOzkpR2DrZ5Q7LETvFyGz+OkU04q7jAbduFyZLb4gcykE/zqYgAag8mCCVumTPf7yOlusJVyUFnPnSGqdOO61nZzj5d1yq68b1rFACqCuPFAK2inSZfgUVObM5uDQPI1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729628833; c=relaxed/simple;
	bh=Z1uBKsrP6KMjIP8HXQEIgcjHk6Oh7n4fFJ8Nz6/OE1s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GLl16ILMw6Ji8FS5ZmKnJJz4b3eOwOMwsiG+8Ln9ZqVdwVD6PDM49qu+6J3QVw2YaCsUfjbMR4YuSkaUjlihnAeZY2DXWMlz0/EOQyLoOs2+rL/+/Q0GBnLYI6/Z/4lSqEkVwGifFOFFW3HET7gNhy4CoLuV3DHxVxaO04CXjZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DRJIkhXc; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43168d9c6c9so40666375e9.3
        for <bpf@vger.kernel.org>; Tue, 22 Oct 2024 13:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729628829; x=1730233629; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7qdBhkmK7Is9LgBbSAzM14vCVKef/fVQAF0w0A2mM8E=;
        b=DRJIkhXcN5vnPggP7FbziOIWgusEBDV33F5wTapyR4jjpnYn5DrLbhRB9JdGo4AaOu
         PtHLjxe3+sYIk/AVeqW6Ea8mg/GntSkiJWaGUCHDy7QyO6g3ylo0sGG4LQ3/XvsftraC
         aehFvQTbShylDoKg6Y9lkkbNnaSDwq4yqyjEiiEHj7tE/bsJiUQk/fThTNAjyTABsAmz
         DomZ+mUmIjiGTh33hahW75OA5c7C0dnW4NcGc9OPzJBiSqVU5ahyL6qVM1vqK0vhLgO6
         99QFMqCMmGQzCa99NPgHgbi/PjVZAV6VhD2GxoxCSnVnKN2JLU4WwukR5+zmvDEhxqCQ
         /W/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729628829; x=1730233629;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7qdBhkmK7Is9LgBbSAzM14vCVKef/fVQAF0w0A2mM8E=;
        b=w5n2cBrYF75PxP1VZL8XEKc4Be3OGFpd9oMesI/g3OjE4D81PLEDGk+8WhAaOzHb5c
         QHtqX2HUo7B4BcYvPsqI8+g6MF8wlkqNY6jMMv3B866c6Q6I9HYq02O99kxyNKAzNWdP
         S0CyqZomW9Qhhprv5Yr+XnfLyBt/qoKjXt6BKrER7nLTua3e9+ayc0l6nbLMVT4Hgddx
         npWslCPk/v6WQCAaaPIS5OPwn/RK6RPbWrgjKarHvGPKRgEQ3bN6h5L5aRY6p89F5TMF
         vvi4DSoesx8oSL4fFNy7umeB4lzbZDwsr7M3EOznJhkCq25lpXJ8/XhGiSzILSISXaZT
         VItw==
X-Forwarded-Encrypted: i=1; AJvYcCUEwFpf3DMzDluUA8ykni8KuaH82hJSOjoT2q+bVfRYOiXPRnopyiEyikQD5m3K6RgJF1k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaqiWwYdaoPpIEbfrb4C7/oi0GBgAeiigvGnt01N6RV/xyupFQ
	8xjijznTnpaTjfHJdAFbZeq1+1Bz0V/vgXNEcLXNL7I0D3tmpXVs9PJ4rngbd3q8uylpObdoiaZ
	GWCMYbHadHDKCMqdJVXz6OVz7cO4=
X-Google-Smtp-Source: AGHT+IG0N0Tcsx5+R0tKLyjPKnLwKILW5DmZ5VdMspebSAavjaqCLkgPev4lLwgfyfHqGx1KhfoaaFlYt7kJtxh5TD8=
X-Received: by 2002:adf:f052:0:b0:37e:d92f:c14a with SMTP id
 ffacd0b85a97d-37efcf7e9fcmr93749f8f.42.1729628829435; Tue, 22 Oct 2024
 13:27:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241021014004.1647816-1-houtao@huaweicloud.com>
 <20241021014004.1647816-3-houtao@huaweicloud.com> <ZxYOX9_sIrSKGFB2@krava>
 <CAEf4BzbFBbTDGSwTdgFJG5poFpCrjjpPO9OujYVZXPxTEUXqeQ@mail.gmail.com>
 <437ff5b4-4f38-cb3a-8491-d8c7e5cfb8c6@huaweicloud.com> <CAEf4BzYb--5BpVuiBYrNdtRh3U6HqD45jndb-f-0YCetTZ5hvw@mail.gmail.com>
In-Reply-To: <CAEf4BzYb--5BpVuiBYrNdtRh3U6HqD45jndb-f-0YCetTZ5hvw@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 22 Oct 2024 13:26:58 -0700
Message-ID: <CAADnVQJ7U_amDRZGRGo8dR37R-EMidjuxHswBGm0LnwAWwgH=w@mail.gmail.com>
Subject: Re: [PATCH bpf v2 2/7] bpf: Add assertion for the size of bpf_link_type_strs[]
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Hou Tao <houtao@huaweicloud.com>, Jiri Olsa <olsajiri@gmail.com>, 
	bpf <bpf@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Hao Luo <haoluo@google.com>, Yonghong Song <yonghong.song@linux.dev>, 
	Daniel Borkmann <daniel@iogearbox.net>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, John Fastabend <john.fastabend@gmail.com>, 
	Yafang Shao <laoar.shao@gmail.com>, Hou Tao <houtao1@huawei.com>, 
	Xu Kuohai <xukuohai@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 22, 2024 at 10:40=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Tue, Oct 22, 2024 at 12:36=E2=80=AFAM Hou Tao <houtao@huaweicloud.com>=
 wrote:
> >
> > Hi,
> >
> > On 10/22/2024 7:02 AM, Andrii Nakryiko wrote:
> > > On Mon, Oct 21, 2024 at 1:18=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com=
> wrote:
> > >> On Mon, Oct 21, 2024 at 09:39:59AM +0800, Hou Tao wrote:
> > >>> From: Hou Tao <houtao1@huawei.com>
> > >>>
> > >>> If a corresponding link type doesn't invoke BPF_LINK_TYPE(), access=
ing
> > >>> bpf_link_type_strs[link->type] may result in out-of-bound access.
> > >>>
> > >>> To prevent such missed invocations in the future, the following sta=
tic
> > >>> assertion seems feasible:
> > >>>
> > >>>   BUILD_BUG_ON(ARRAY_SIZE(bpf_link_type_strs) !=3D __MAX_BPF_LINK_T=
YPE)
> > >>>
> > >>> However, this doesn't work well. The reason is that the invocation =
of
> > >>> BPF_LINK_TYPE() for one link type is optional due to its CONFIG_XXX
> > >>> dependency and the elements in bpf_link_type_strs[] will be sparse.=
 For
> > >>> example, if CONFIG_NET is disabled, the size of bpf_link_type_strs =
will
> > >>> be BPF_LINK_TYPE_UPROBE_MULTI + 1.
> > >>>
> > >>> Therefore, in addition to the static assertion, remove all CONFIG_X=
XX
> > >>> conditions for the invocation of BPF_LINK_TYPE(). If these CONFIG_X=
XX
> > >>> conditions become necessary later, the fix may need to be revised (=
e.g.,
> > >>> to check the validity of link_type in bpf_link_show_fdinfo()).
> > >>>
> > >>> Signed-off-by: Hou Tao <houtao1@huawei.com>
> > >>> ---
> > >>>  include/linux/bpf_types.h | 6 ------
> > >>>  kernel/bpf/syscall.c      | 2 ++
> > >>>  2 files changed, 2 insertions(+), 6 deletions(-)
> > >>>
> > >>> diff --git a/include/linux/bpf_types.h b/include/linux/bpf_types.h
> > >>> index fa78f49d4a9a..6b7eabe9a115 100644
> > >>> --- a/include/linux/bpf_types.h
> > >>> +++ b/include/linux/bpf_types.h
> > >>> @@ -136,21 +136,15 @@ BPF_MAP_TYPE(BPF_MAP_TYPE_ARENA, arena_map_op=
s)
> > >>>
> > >>>  BPF_LINK_TYPE(BPF_LINK_TYPE_RAW_TRACEPOINT, raw_tracepoint)
> > >>>  BPF_LINK_TYPE(BPF_LINK_TYPE_TRACING, tracing)
> > >>> -#ifdef CONFIG_CGROUP_BPF
> > >>>  BPF_LINK_TYPE(BPF_LINK_TYPE_CGROUP, cgroup)
> > >>> -#endif
> > >>>  BPF_LINK_TYPE(BPF_LINK_TYPE_ITER, iter)
> > >>> -#ifdef CONFIG_NET
> > >>>  BPF_LINK_TYPE(BPF_LINK_TYPE_NETNS, netns)
> > >>>  BPF_LINK_TYPE(BPF_LINK_TYPE_XDP, xdp)
> > >>>  BPF_LINK_TYPE(BPF_LINK_TYPE_NETFILTER, netfilter)
> > >>>  BPF_LINK_TYPE(BPF_LINK_TYPE_TCX, tcx)
> > >>>  BPF_LINK_TYPE(BPF_LINK_TYPE_NETKIT, netkit)
> > >>>  BPF_LINK_TYPE(BPF_LINK_TYPE_SOCKMAP, sockmap)
> > >>> -#endif
> > >>> -#ifdef CONFIG_PERF_EVENTS
> > >>>  BPF_LINK_TYPE(BPF_LINK_TYPE_PERF_EVENT, perf)
> > >>> -#endif
> > > I'm not sure what's the implication here, but I'd avoid doing that.
> > > But see below.
> >
> > OK.
> > >>>  BPF_LINK_TYPE(BPF_LINK_TYPE_KPROBE_MULTI, kprobe_multi)
> > >>>  BPF_LINK_TYPE(BPF_LINK_TYPE_STRUCT_OPS, struct_ops)
> > >>>  BPF_LINK_TYPE(BPF_LINK_TYPE_UPROBE_MULTI, uprobe_multi)
> > >>> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> > >>> index 8cfa7183d2ef..9f335c379b05 100644
> > >>> --- a/kernel/bpf/syscall.c
> > >>> +++ b/kernel/bpf/syscall.c
> > >>> @@ -3071,6 +3071,8 @@ static void bpf_link_show_fdinfo(struct seq_f=
ile *m, struct file *filp)
> > >>>       const struct bpf_prog *prog =3D link->prog;
> > >>>       char prog_tag[sizeof(prog->tag) * 2 + 1] =3D { };
> > >>>
> > >>> +     BUILD_BUG_ON(ARRAY_SIZE(bpf_link_type_strs) !=3D __MAX_BPF_LI=
NK_TYPE);
> > > If this is useless, why are you adding it?
> >
> > It will work after removing these CONFIG_XXX dependencies for
> > BPF_LINK_TYPE() invocations.
> > >
> > > Let's instead do a NULL check inside bpf_link_show_fdinfo() to handle
> > > sparsity. And to avoid out-of-bounds, just add
> > >
> > > [__MAX_BPF_LINK_TYPE] =3D NULL,
> > >
> > > into the definition of bpf_link_type_strs
> >
> > Instead of outputting a null string for a link_type which didn't invoke
> > BPF_LINK_TYPE, is outputting the numerical value of link->type more
> > reasonable as shown below ?
>
> In correctly configured kernel this should never happen. So we can
> have WARN() there for the NULL case and just return an error or
> something.

I don't understand why this patch is needed.
Is it solving a theoretical problem ?

Something like the kernel managed to create a link
with link->type =3D=3D BPF_LINK_TYPE_CGROUP,
but CONFIG_CGROUP_BPF was not defined somehow ?

There is no out-of-bounds or access to empty
bpf_link_type_strs[link->type] as far as I can tell.

What am I missing?

