Return-Path: <bpf+bounces-42827-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 492349AB7D5
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 22:43:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04B24283C3A
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 20:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44D141CCEDD;
	Tue, 22 Oct 2024 20:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d17qkWdq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 489A21CCED5
	for <bpf@vger.kernel.org>; Tue, 22 Oct 2024 20:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729629720; cv=none; b=UNOt+lAXpY76sxvHNZtkMvN1rz4+1fDt53aTT8fUZuzMcjXHC2oyrCOJ4mV7pBrX57KNTzHJgFdhcGEOdR1MhdnC3kaR7Qqc7SCQuGcEujxnuD09xl7IoWl/BQleHJ3w5k2uoLOppQKldItIt6FTd22q3uzwcj8Tj8AlVe4y2Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729629720; c=relaxed/simple;
	bh=wOsQ9jvreRec9M9i06Vh4iNIEpo/QJBLlV6ReTKX4to=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IHs1q4aWXrLCunYUJAGv5PWs8CoSuGP84rsOnkjd44mQYIz2Tsy635c/QwVAlqb1e14171Apar13vFQcW3X53q9sTYgmRfzxW1kDHPc/AYj+WpIM8Fs/Bepxq/XygRVtKQ2uXmMTwoYES/tpOq3WIuEzdoclzaqarCT8fu9xQbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d17qkWdq; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7d916b6a73aso3853770a12.1
        for <bpf@vger.kernel.org>; Tue, 22 Oct 2024 13:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729629718; x=1730234518; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Ogy9dPbjGKOfd2gPInuhSn542wZ/y/q/Uu7+p5vqUA=;
        b=d17qkWdq0QCIIZQ6Jh2A4oWbfEem9+koCI27yz+Ehrui35/+aptVklm8OQrrC7G/pk
         9AvrsYuRDrGUiKHagC5PpEhdgtbtwwifNvrPA/xRZdQiWSpltZ1M4gp+VNezLdNMJPFO
         LJ2sK+A0tKI4ZftxlmFi1W0SX1WHqyteAmTkLSMuppNg8wu4LJuQ3S5gxHbRwlSIAGJ2
         DIeru/FBR8+WgyhDd0DLmCK2UPciij1NU1r5t7EOUHugNGVsWck7Iu0NTQgOXW/siJlB
         DdVtxVv4IyueaFSQyUGqPq/foxiF9TF1tZIiSA3MgYIdvLLGFQZ/cAWkirsGbr6nV9uC
         dw2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729629718; x=1730234518;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Ogy9dPbjGKOfd2gPInuhSn542wZ/y/q/Uu7+p5vqUA=;
        b=P9T+ncdrjasveEFRWruU9Cs9r1fdO48gTpOjje6DhdLQH7EVceCImUCyOA8n3niK8/
         U57wkyqeIDwbKZP4/3ceAdAq8JqSzLeogL8Gc/WuWsHrppO+pWLUYAJXGbOumDCVwmbt
         Cu6M0KrH5vgu3hcr2m5ywORTarPxHusJ3zkDOoj5Mv7mv5Mb6qPxyEm6ryDAroM4C2g9
         +700fYt0NBl/O5WYoTRM1cJL4OLWjFKkrwSdfGm85Tlj442lvJY5zfg0AK0ay7rF/0NS
         V2idlBQd5URCMmyG7VHXnBZRQFWUh9IIX/uqpGx3WCKkKzeVZ8SiNUAAvwpVUNZfiyTd
         1ISg==
X-Forwarded-Encrypted: i=1; AJvYcCVdiLmILRWkwFL2QdFCo8MM8WkBVL0VT8Dadj5x6hvT6r3kjEdAOsPjKbF8lsUQURCqNc4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUlnnIRcVtViqARSfIz9No0Hypf9zM1L7IOvbltUfo8RDXdvqA
	KXnyFQxWIDi4FInbsP1MOMjotlfCHDFVQVEUf4IrqCr+97nKDp3ukHlb965iki4cBcTvpDHozyM
	xOLJC57EDH6xz9Fs8Y0Rd2CJ3u7w=
X-Google-Smtp-Source: AGHT+IFcEIKq0xIK+QmDJFvC+/1zm1yVxiD/BiRZzhYvzFcDd9EymdzBYI+XkMsUeeNgaPPVQ0zC4tJXZZVEnj+G66U=
X-Received: by 2002:a05:6a20:cf8c:b0:1d8:f1f4:f4ee with SMTP id
 adf61e73a8af0-1d978aebd78mr409140637.8.1729629718532; Tue, 22 Oct 2024
 13:41:58 -0700 (PDT)
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
 <CAADnVQJ7U_amDRZGRGo8dR37R-EMidjuxHswBGm0LnwAWwgH=w@mail.gmail.com>
In-Reply-To: <CAADnVQJ7U_amDRZGRGo8dR37R-EMidjuxHswBGm0LnwAWwgH=w@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 22 Oct 2024 13:41:46 -0700
Message-ID: <CAEf4Bzad3aL6EQyeM0Yir5CyxX3_ZojzJUxP4eQdQH3TcT48qw@mail.gmail.com>
Subject: Re: [PATCH bpf v2 2/7] bpf: Add assertion for the size of bpf_link_type_strs[]
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
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

On Tue, Oct 22, 2024 at 1:27=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Oct 22, 2024 at 10:40=E2=80=AFAM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Tue, Oct 22, 2024 at 12:36=E2=80=AFAM Hou Tao <houtao@huaweicloud.co=
m> wrote:
> > >
> > > Hi,
> > >
> > > On 10/22/2024 7:02 AM, Andrii Nakryiko wrote:
> > > > On Mon, Oct 21, 2024 at 1:18=E2=80=AFAM Jiri Olsa <olsajiri@gmail.c=
om> wrote:
> > > >> On Mon, Oct 21, 2024 at 09:39:59AM +0800, Hou Tao wrote:
> > > >>> From: Hou Tao <houtao1@huawei.com>
> > > >>>
> > > >>> If a corresponding link type doesn't invoke BPF_LINK_TYPE(), acce=
ssing
> > > >>> bpf_link_type_strs[link->type] may result in out-of-bound access.
> > > >>>
> > > >>> To prevent such missed invocations in the future, the following s=
tatic
> > > >>> assertion seems feasible:
> > > >>>
> > > >>>   BUILD_BUG_ON(ARRAY_SIZE(bpf_link_type_strs) !=3D __MAX_BPF_LINK=
_TYPE)
> > > >>>
> > > >>> However, this doesn't work well. The reason is that the invocatio=
n of
> > > >>> BPF_LINK_TYPE() for one link type is optional due to its CONFIG_X=
XX
> > > >>> dependency and the elements in bpf_link_type_strs[] will be spars=
e. For
> > > >>> example, if CONFIG_NET is disabled, the size of bpf_link_type_str=
s will
> > > >>> be BPF_LINK_TYPE_UPROBE_MULTI + 1.
> > > >>>
> > > >>> Therefore, in addition to the static assertion, remove all CONFIG=
_XXX
> > > >>> conditions for the invocation of BPF_LINK_TYPE(). If these CONFIG=
_XXX
> > > >>> conditions become necessary later, the fix may need to be revised=
 (e.g.,
> > > >>> to check the validity of link_type in bpf_link_show_fdinfo()).
> > > >>>
> > > >>> Signed-off-by: Hou Tao <houtao1@huawei.com>
> > > >>> ---
> > > >>>  include/linux/bpf_types.h | 6 ------
> > > >>>  kernel/bpf/syscall.c      | 2 ++
> > > >>>  2 files changed, 2 insertions(+), 6 deletions(-)
> > > >>>
> > > >>> diff --git a/include/linux/bpf_types.h b/include/linux/bpf_types.=
h
> > > >>> index fa78f49d4a9a..6b7eabe9a115 100644
> > > >>> --- a/include/linux/bpf_types.h
> > > >>> +++ b/include/linux/bpf_types.h
> > > >>> @@ -136,21 +136,15 @@ BPF_MAP_TYPE(BPF_MAP_TYPE_ARENA, arena_map_=
ops)
> > > >>>
> > > >>>  BPF_LINK_TYPE(BPF_LINK_TYPE_RAW_TRACEPOINT, raw_tracepoint)
> > > >>>  BPF_LINK_TYPE(BPF_LINK_TYPE_TRACING, tracing)
> > > >>> -#ifdef CONFIG_CGROUP_BPF
> > > >>>  BPF_LINK_TYPE(BPF_LINK_TYPE_CGROUP, cgroup)
> > > >>> -#endif
> > > >>>  BPF_LINK_TYPE(BPF_LINK_TYPE_ITER, iter)
> > > >>> -#ifdef CONFIG_NET
> > > >>>  BPF_LINK_TYPE(BPF_LINK_TYPE_NETNS, netns)
> > > >>>  BPF_LINK_TYPE(BPF_LINK_TYPE_XDP, xdp)
> > > >>>  BPF_LINK_TYPE(BPF_LINK_TYPE_NETFILTER, netfilter)
> > > >>>  BPF_LINK_TYPE(BPF_LINK_TYPE_TCX, tcx)
> > > >>>  BPF_LINK_TYPE(BPF_LINK_TYPE_NETKIT, netkit)
> > > >>>  BPF_LINK_TYPE(BPF_LINK_TYPE_SOCKMAP, sockmap)
> > > >>> -#endif
> > > >>> -#ifdef CONFIG_PERF_EVENTS
> > > >>>  BPF_LINK_TYPE(BPF_LINK_TYPE_PERF_EVENT, perf)
> > > >>> -#endif
> > > > I'm not sure what's the implication here, but I'd avoid doing that.
> > > > But see below.
> > >

I'll just elaborate a bit why I wouldn't remove #ifdef guards. This
BPF_LINK_TYPE() macro magic can be used to define some extra data
structures that are specific to link type. E.g., some sort of
bpf_<type>_link_lops references or something along those lines. Having
BPF_LINK_TYPE() definition when the kernel actually doesn't implement
that link will be PITA in that case, generating references to
non-existent data structures.

> > > OK.
> > > >>>  BPF_LINK_TYPE(BPF_LINK_TYPE_KPROBE_MULTI, kprobe_multi)
> > > >>>  BPF_LINK_TYPE(BPF_LINK_TYPE_STRUCT_OPS, struct_ops)
> > > >>>  BPF_LINK_TYPE(BPF_LINK_TYPE_UPROBE_MULTI, uprobe_multi)
> > > >>> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> > > >>> index 8cfa7183d2ef..9f335c379b05 100644
> > > >>> --- a/kernel/bpf/syscall.c
> > > >>> +++ b/kernel/bpf/syscall.c
> > > >>> @@ -3071,6 +3071,8 @@ static void bpf_link_show_fdinfo(struct seq=
_file *m, struct file *filp)
> > > >>>       const struct bpf_prog *prog =3D link->prog;
> > > >>>       char prog_tag[sizeof(prog->tag) * 2 + 1] =3D { };
> > > >>>
> > > >>> +     BUILD_BUG_ON(ARRAY_SIZE(bpf_link_type_strs) !=3D __MAX_BPF_=
LINK_TYPE);
> > > > If this is useless, why are you adding it?
> > >
> > > It will work after removing these CONFIG_XXX dependencies for
> > > BPF_LINK_TYPE() invocations.
> > > >
> > > > Let's instead do a NULL check inside bpf_link_show_fdinfo() to hand=
le
> > > > sparsity. And to avoid out-of-bounds, just add
> > > >
> > > > [__MAX_BPF_LINK_TYPE] =3D NULL,
> > > >
> > > > into the definition of bpf_link_type_strs
> > >
> > > Instead of outputting a null string for a link_type which didn't invo=
ke
> > > BPF_LINK_TYPE, is outputting the numerical value of link->type more
> > > reasonable as shown below ?
> >
> > In correctly configured kernel this should never happen. So we can
> > have WARN() there for the NULL case and just return an error or

Actually, it seems like this is a void-returning function, so yeah,
instead of returning an error we can just emit an integer value. But
we should definitely have a WARN_ONCE().

> > something.
>
> I don't understand why this patch is needed.
> Is it solving a theoretical problem ?
>
> Something like the kernel managed to create a link
> with link->type =3D=3D BPF_LINK_TYPE_CGROUP,
> but CONFIG_CGROUP_BPF was not defined somehow ?
>

It's just too easy to forget to add
BPF_LINK_TYPE(BPF_LINK_TYPE_<newlinktype>, ...) into
include/linux/bpf_types.h when adding a new type of BPF link. So Hou
is following up with changes that will make it easier to spot these
omissions in the future.

> There is no out-of-bounds or access to empty
> bpf_link_type_strs[link->type] as far as I can tell.
>
> What am I missing?

