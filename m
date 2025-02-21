Return-Path: <bpf+bounces-52130-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3700A3E9A5
	for <lists+bpf@lfdr.de>; Fri, 21 Feb 2025 02:07:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06F6116FFA2
	for <lists+bpf@lfdr.de>; Fri, 21 Feb 2025 01:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9E9035966;
	Fri, 21 Feb 2025 01:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IMITTjhB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E103594E;
	Fri, 21 Feb 2025 01:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740100058; cv=none; b=kUsaJjuh9rxBgshJRQEfiQgYEm7ojUCUgEUeeWM3//S4kQEcfwqHivW5bloFkhHLzpIK5tRy2Z03sFe2j0hNll34r1h5+UwS970JYlWHa7GCgPBlBEnMEELbVLbOt5+AzV8LMUfWbLXOPDF2dvOVriFTzLI1IWbSNE5m7CnCU6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740100058; c=relaxed/simple;
	bh=2g8oNieasSQT1QPvU7TEQo0RSe+QF1XO8YP8P7wA2co=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fBEwqboYJAOyzADo7JNiSl/Ge24WFbHy/u6q61zOpkDAEwPs1eLxSzn44oMhggB/BpkGYokti0C5E31mX3bD4TQARM4r7fH4Tewh4PjzGbknMmVByE75jDLEZHocytuAWTGJ2KeiIizs4yqZFr5YadVvPPSldgDAO8lRTFnTASo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IMITTjhB; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2fcc99efe9bso2509765a91.2;
        Thu, 20 Feb 2025 17:07:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740100056; x=1740704856; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xoj4+GfmmJXx597AEiArFiq+jfsACOsOdKSiW+SWgWI=;
        b=IMITTjhBFmOVXEqWOTUM4k083NOEVYPO8FXVgRKhEFCYifyoZnXKQLr6B+z1Qr19tt
         o9enzdNeuFhRdIUWq9i0Kk43QDQ7j+HU1PkW8Q+8/lX+ZNiwi5jm7oNqqZVBzNwFnnHd
         EU+e4lMUBdolM4e51HTWKBD1JHVNcOOWFwKzjj4lglJo0uEi1SeAIlixmpPo4cGAFL1Z
         HoAffTx5dIj1Ty6ziuvf+eBuIf8X39BmsOoxaIzjUDljEVazMrhg2QgMZjnGobQcBs1/
         Kzzri32gPrxolGvQR2Pzu8kOHIlNEqOfKR0eTikdlzrqnmvkT1wFSjvT+2kd3Ud+JP+o
         H/pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740100056; x=1740704856;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xoj4+GfmmJXx597AEiArFiq+jfsACOsOdKSiW+SWgWI=;
        b=lKYqNmG8Ia8qctFBDu6KykUsxv9HTU9TrXwl7ux7llakDnlJUkM7nOL54LnNMcp4I2
         3LBPK4aWlXNYeKaBuREz+WvJOf15xW6pX14E485BuJzmdkW56hp1HNy2bCoOLEB6tHhh
         ZdDVPG70nMfKrfUPNOoqBvVFXGSasM68pKZfgh7kNOkvlRDrNRztlSzOF9p3c1Z00HNq
         jHeOqyfwgS584IZuq6Wzo+B9XuMAl4IGh2uwyOGdPzkpVC1Tdd4z0PjFMq+k/61N+gMN
         4xItvO5LvriZsftakW1bFIsw/QoWPEZS9IJTg8z+cswagNU0PqgUtlIMEl7sv9Ft9jsX
         IqwA==
X-Forwarded-Encrypted: i=1; AJvYcCURePCSR4VIpRwoRcOttEQjgOAVyVRzPsSGxChSGSjc73vhYs070AuH+51Loh875ByCzMdmgFfXUsCTVuel@vger.kernel.org, AJvYcCVxnRkofv9bu1YqXdKMY/j8zRmCldqg9/B0Y3k+dnWvR/oc+zEG9lFEPsmHfiYS3C7ROrI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSaiFBbM455QyMteeBuuUERYb4zhXsJNVvrcGzixNCUE7E3e56
	P/ZJKXrSLoz3deHfclVnWRUyUxH+saFu2I589AvU5NqR5ga5vIz8QFOFmLXkbQCW1Xe97sP6TzE
	ygvulIIOv7NGtCwEHVoxLNGlQU/0=
X-Gm-Gg: ASbGnctHouebHjWvfbn+Ih+XfRvgUR8GJBqQ934EvX6jtsT+MHMdgy/bGFWSGZgsKUS
	KRh0q/GNAnH4xulwd6Upo0cAbsR9RPs8CiQdk3La8ZnYdoPT7Ne7QqUHIYZs5LLYe9GMTGtfmGX
	JGNTQfmEac2rW6
X-Google-Smtp-Source: AGHT+IE1x5MV8fPXVRSn8nvItza1FwLhDZR/wmkfbON5BEbuV+Qy5Rdnel/iXrp2rYviXo5ZN56X5Q3o0So8P6HOjK4=
X-Received: by 2002:a17:90b:5201:b0:2ee:c6c8:d89f with SMTP id
 98e67ed59e1d1-2fce86af0b9mr1721474a91.14.1740100055928; Thu, 20 Feb 2025
 17:07:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250212153912.24116-1-chen.dylane@gmail.com> <2b025df3-144b-4909-a2b4-66356540f71c@gmail.com>
 <598a7d089936b18472937679d4131286f102cb18.camel@gmail.com>
In-Reply-To: <598a7d089936b18472937679d4131286f102cb18.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 20 Feb 2025 17:07:24 -0800
X-Gm-Features: AWEUYZklNpNYJotUClQoF-3pgJL_VeYuQKw0D528FsdEtUwuATrGIy81FBXFwvQ
Message-ID: <CAEf4BzYsGnhmnhkHdUPN8yBfbv57R9h4N2R8RcqdjhmHWvJVkg@mail.gmail.com>
Subject: Re: [PATCH RESEND bpf-next v7 0/4] Add prog_kfunc feature probe
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Tao Chen <chen.dylane@gmail.com>, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, haoluo@google.com, jolsa@kernel.org, qmo@kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 18, 2025 at 2:51=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Mon, 2025-02-17 at 13:21 +0800, Tao Chen wrote:
> > =E5=9C=A8 2025/2/12 23:39, Tao Chen =E5=86=99=E9=81=93:
> > > More and more kfunc functions are being added to the kernel.
> > > Different prog types have different restrictions when using kfunc.
> > > Therefore, prog_kfunc probe is added to check whether it is supported=
,
> > > and the use of this api will be added to bpftool later.
> > >
> > > Change list:
> > > - v6 -> v7:
> > >    - wrap err with libbpf_err
> > >    - comments fix
> > >    - handle btf_fd < 0 as vmlinux
> > >    - patchset Reviewed-by: Jiri Olsa <jolsa@kernel.org>
> > > - v6
> > >    https://lore.kernel.org/bpf/20250211111859.6029-1-chen.dylane@gmai=
l.com
> > >
> > > - v5 -> v6:
> > >    - remove fd_array_cnt
> > >    - test case clean code
> > > - v5
> > >    https://lore.kernel.org/bpf/20250210055945.27192-1-chen.dylane@gma=
il.com
> > >
> > > - v4 -> v5:
> > >    - use fd_array on stack
> > >    - declare the scope of use of btf_fd
> > > - v4
> > >    https://lore.kernel.org/bpf/20250206051557.27913-1-chen.dylane@gma=
il.com/
> > >
> > > - v3 -> v4:
> > >    - add fd_array init for kfunc in mod btf
> > >    - add test case for kfunc in mod btf
> > >    - refactor common part as prog load type check for
> > >      libbpf_probe_bpf_{helper,kfunc}
> > > - v3
> > >    https://lore.kernel.org/bpf/20250124144411.13468-1-chen.dylane@gma=
il.com
> > >
> > > - v2 -> v3:
> > >    - rename parameter off with btf_fd
> > >    - extract the common part for libbpf_probe_bpf_{helper,kfunc}
> > > - v2
> > >    https://lore.kernel.org/bpf/20250123170555.291896-1-chen.dylane@gm=
ail.com
> > >
> > > - v1 -> v2:
> > >    - check unsupported prog type like probe_bpf_helper
> > >    - add off parameter for module btf
> > >    - check verifier info when kfunc id invalid
> > > - v1
> > >    https://lore.kernel.org/bpf/20250122171359.232791-1-chen.dylane@gm=
ail.com
> > >
> > > Tao Chen (4):
> > >    libbpf: Extract prog load type check from libbpf_probe_bpf_helper
> > >    libbpf: Init fd_array when prog probe load
> > >    libbpf: Add libbpf_probe_bpf_kfunc API
> > >    selftests/bpf: Add libbpf_probe_bpf_kfunc API selftests
> > >
> > >   tools/lib/bpf/libbpf.h                        |  19 ++-
> > >   tools/lib/bpf/libbpf.map                      |   1 +
> > >   tools/lib/bpf/libbpf_probes.c                 |  86 +++++++++++---
> > >   .../selftests/bpf/prog_tests/libbpf_probes.c  | 111 +++++++++++++++=
+++
> > >   4 files changed, 201 insertions(+), 16 deletions(-)
> > >
> >
> > Ping...
> >
> > Hi Andrii, Eduard,
> >
> > I've revised the previous suggestions. Please review it again. Thanks.
> >
>
> I tried the test enumerating all kfuncs in BTF and doing
> libbpf_probe_bpf_kfunc for BPF_PROG_TYPE_{KPROBE,XDP}.
> (Source code at the end of the email).
>
> The set of kfuncs returned for XDP looks correct.
> The set of kfuncs returned for KPROBE contains a few incorrect entries:
> - bpf_xdp_metadata_rx_hash
> - bpf_xdp_metadata_rx_timestamp
> - bpf_xdp_metadata_rx_vlan_tag
>
> This is because of a different string reported by verifier for these
> three functions.
>
> Ideally, I'd write some script looking for
> register_btf_kfunc_id_set(BPF_PROG_TYPE_***, kfunc_set)
> calls in the kernel source code and extracting the prog type /
> functions in the set, and comparing results of this script with
> output of the test below for all program types.
> But up to you if you'd like to do such rigorous verification or not.
>
> Otherwise patch-set looks good to me, for all patch-set:
>
> Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>

Shouldn't we fix the issue with those bpf_xdp_metadata_* kfuncs? Do
you have details on what different string verifier reports?

>
> --- 8< -----------------------------------------------------
>
> static const struct {
>         const char *name;
>         int code;
> } program_types[] =3D {
> #define _T(n) { #n, BPF_PROG_TYPE_ ## n }
>         _T(KPROBE),
>         _T(XDP),
> #undef _T
> };
>
> void test_libbpf_probe_kfuncs_many(void)
> {
>         int i, kfunc_id, ret, id;
>         const struct btf_type *t;
>         struct btf *btf =3D NULL;
>         const char *kfunc;
>         const char *tag;
>
>         btf =3D btf__parse("/sys/kernel/btf/vmlinux", NULL);
>         if (!ASSERT_OK_PTR(btf, "btf_parse"))
>                 return;
>
>         for (id =3D 0; id < btf__type_cnt(btf); ++id) {
>                 t =3D btf__type_by_id(btf, id);
>                 if (!btf_is_decl_tag(t))
>                         continue;
>                 tag =3D btf__name_by_offset(btf, t->name_off);
>                 if (strcmp(tag, "bpf_kfunc") !=3D 0)
>                         continue;
>                 kfunc_id =3D t->type;
>                 t =3D btf__type_by_id(btf, kfunc_id);
>                 if (!btf_is_func(t))
>                         continue;
>                 kfunc =3D btf__name_by_offset(btf, t->name_off);
>                 printf("[%-6d] %-42s ", kfunc_id, kfunc);
>                 for (i =3D 0; i < ARRAY_SIZE(program_types); ++i) {
>                         ret =3D libbpf_probe_bpf_kfunc(program_types[i].c=
ode, kfunc_id, -1, NULL);
>                         if (ret < 0)
>                                 printf("%-8d  ", ret);
>                         else if (ret =3D=3D 0)
>                                 printf("%8s  ", "");
>                         else
>                                 printf("%8s  ", program_types[i].name);
>                 }
>                 printf("\n");
>         }
>         btf__free(btf);
> }
>
> ----------------------------------------------------- >8 ---
>

