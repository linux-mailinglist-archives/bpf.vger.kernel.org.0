Return-Path: <bpf+bounces-18839-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BC048225F9
	for <lists+bpf@lfdr.de>; Wed,  3 Jan 2024 01:31:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 744FF1C21BA9
	for <lists+bpf@lfdr.de>; Wed,  3 Jan 2024 00:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F30FB651;
	Wed,  3 Jan 2024 00:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iKK3ljvF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6BC17980
	for <bpf@vger.kernel.org>; Wed,  3 Jan 2024 00:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a27f0963a80so202002366b.0
        for <bpf@vger.kernel.org>; Tue, 02 Jan 2024 16:30:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704241858; x=1704846658; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tebPRqY7w+uMXCIfgLVM1nkPlwrU95Hv1qw0Dz7XkiE=;
        b=iKK3ljvFvAi7j0VX9Co9iCx8RddE5suWvk1DVLdeDnDUJO7WBCFG23Q4cM/Ee+nn5z
         DgWfLjk8CuTyRmeLP5Em+eimRsY/RuVxlag67PQYLCGySTQyHFophclzwmVKUNEyP8Co
         viParuyJ9y95bEoCDDKr8Ymn7geszdNr3aHioNsQn8Vl3M9BmDP6+Y0kr5TrxyJPHdBW
         C9zOGT1m6Rh2WRCRJNiQzqszba1opQ30a3s7Oal9t4CMANB6PvvV8rSUEbroUZAVcRUQ
         W/3LPkuphWL2clpIK8vDuyNu3W/HbizK3ttE/v8LspcLVLYiXXfHsWk16I+tUQfKEGBr
         8JQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704241858; x=1704846658;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tebPRqY7w+uMXCIfgLVM1nkPlwrU95Hv1qw0Dz7XkiE=;
        b=uet9SPLyk303QpjouFug6RABNaqBq6pThSe6vG3gZpjZylOwo325p1kpwes+tdnw7l
         dZsPSqcQqI4BATs2jCVcrTHNSH61tMuBCPwU6Uv6KF19flVDoGM9m6DlT9RcJfHKUCk5
         YWOPncUJUnNV9K6T3Gx9GQhpPH3mQiSOcVelOdt3U0FIfMGcKNNVcVbFeG8RwLXdbIf/
         njE87HA3VZCyxZv5voyZbb6iAd5PvswuHNsI4phSBBpZTkXDiXCz98I3koeUJ/mcj6sN
         5gbyv8lGnYK0lv6GDoPw+c8H31aBm6sBoEk7bzFE8WXveMlir59UyTFJvOA/MLFAR27E
         nYhA==
X-Gm-Message-State: AOJu0YwEzXG2jckKPpXXZ61ak1KuKNDXjYEddYwszNa9wKoUOCDWkUGI
	uK2NF+yq8k+eCBU/WzjBnXmv68KFLhZG7fi9Wumoajra
X-Google-Smtp-Source: AGHT+IG2E+SNQVbueNEYK/bqlHQqSoXe7YNF0VZ7xp3zgTow2yOEjauprF/YA5FNK23+F4JDPwP+8RTUvebDVldeVYc=
X-Received: by 2002:a17:906:e952:b0:a28:97c4:dd07 with SMTP id
 jw18-20020a170906e95200b00a2897c4dd07mr13659ejb.63.1704241858046; Tue, 02 Jan
 2024 16:30:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231220233127.1990417-1-andrii@kernel.org> <20231220233127.1990417-8-andrii@kernel.org>
 <aa5oh3hr4hbq6uk5ejmazunhv4scr6fbmzuxqibilucwprhidy@wsmnjikxm6vu> <CAEf4BzYHrdeGHYuNgiyVUCB3K1RJ6TS3qb_U2tx7i2Sn3W6Etg@mail.gmail.com>
In-Reply-To: <CAEf4BzYHrdeGHYuNgiyVUCB3K1RJ6TS3qb_U2tx7i2Sn3W6Etg@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 2 Jan 2024 16:30:45 -0800
Message-ID: <CAEf4BzZ92W9Td6uvH=XBvUL9iLJHK15Ze9O49XH7s0CdTyPirQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 7/8] libbpf: implement __arg_ctx fallback logic
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 2, 2024 at 9:06=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, Dec 21, 2023 at 5:26=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Wed, Dec 20, 2023 at 03:31:26PM -0800, Andrii Nakryiko wrote:
> > > This limitation was the reason to add btf_decl_tag("arg:ctx"), making
> > > the actual argument type not important, so that user can just define
> > > "generic" signature:
> > >
> > >   __noinline int global_subprog(void *ctx __arg_ctx) { ... }
> >
> > Just realized that we probably need to enforce in both libbpf doing
> > rewrite and in the kernel that __arg_ctx is either valid
> > 'struct correct_type_for_bpf_prog *' or 'void *'.
> >
> > Otherwise the user will get surprising behavior when
> > int foo(struct __sk_buff *ctx __arg_ctx)
> > {
> >   ctx->len;
> > }
> > will get rewritten to 'struct pt_regs *ctx' based on prog type
> > while all asm instructions inside prog were compiled with 'struct __sk_=
buff'
> > and CO_RE performs relocations against that type.
>
> Nothing really prevents users from misusing types even today, so it
> doesn't seem like a common problem, luckily.
>
> But really the problem is that some program types don't have an
> associated struct name at all, but still a valid context. Like for
> LSM/TRACING programs it's a u64[]/u64 *. For tracepoints context is
> defined as just plain u64 (according to bpf_ctx_convert), and so on.
>
> Oh, and there is KPROBE program type, where it's (typedef)
> bpf_user_pt_regs_t, and for backwards compatibility reasons we also
> allow basically non-existing `struct bpf_user_pt_regs_t`.
>
> So it gets messy. Either way, I have a patch set coming up for
> kernel-side __arg_xxx tags support, so let's discuss it there?
>
> >
> > > +static struct {
> > > +     enum bpf_prog_type prog_type;
> > > +     const char *ctx_name;
> > > +} global_ctx_map[] =3D {
> > > +     { BPF_PROG_TYPE_CGROUP_DEVICE,           "bpf_cgroup_dev_ctx" }=
,
> > > +     { BPF_PROG_TYPE_CGROUP_SKB,              "__sk_buff" },
> > > +     { BPF_PROG_TYPE_CGROUP_SOCK,             "bpf_sock" },
> > > +     { BPF_PROG_TYPE_CGROUP_SOCK_ADDR,        "bpf_sock_addr" },
> > > +     { BPF_PROG_TYPE_CGROUP_SOCKOPT,          "bpf_sockopt" },
> > > +     { BPF_PROG_TYPE_CGROUP_SYSCTL,           "bpf_sysctl" },
> > > +     { BPF_PROG_TYPE_FLOW_DISSECTOR,          "__sk_buff" },
> > > +     { BPF_PROG_TYPE_KPROBE,                  "bpf_user_pt_regs_t" }=
,
> > > +     { BPF_PROG_TYPE_LWT_IN,                  "__sk_buff" },
> > > +     { BPF_PROG_TYPE_LWT_OUT,                 "__sk_buff" },
> > > +     { BPF_PROG_TYPE_LWT_SEG6LOCAL,           "__sk_buff" },
> > > +     { BPF_PROG_TYPE_LWT_XMIT,                "__sk_buff" },
> > > +     { BPF_PROG_TYPE_NETFILTER,               "bpf_nf_ctx" },
> > > +     { BPF_PROG_TYPE_PERF_EVENT,              "bpf_perf_event_data" =
},
> > > +     { BPF_PROG_TYPE_RAW_TRACEPOINT,          "bpf_raw_tracepoint_ar=
gs" },
> > > +     { BPF_PROG_TYPE_RAW_TRACEPOINT_WRITABLE, "bpf_raw_tracepoint_ar=
gs" },
> > > +     { BPF_PROG_TYPE_SCHED_ACT,               "__sk_buff" },
> > > +     { BPF_PROG_TYPE_SCHED_CLS,               "__sk_buff" },
> > > +     { BPF_PROG_TYPE_SK_LOOKUP,               "bpf_sk_lookup" },
> > > +     { BPF_PROG_TYPE_SK_MSG,                  "sk_msg_md" },
> > > +     { BPF_PROG_TYPE_SK_REUSEPORT,            "sk_reuseport_md" },
> > > +     { BPF_PROG_TYPE_SK_SKB,                  "__sk_buff" },
> > > +     { BPF_PROG_TYPE_SOCK_OPS,                "bpf_sock_ops" },
> > > +     { BPF_PROG_TYPE_SOCKET_FILTER,           "__sk_buff" },
> > > +     { BPF_PROG_TYPE_XDP,                     "xdp_md" },
> >
> > We already share the .c files (like relo_core.c) between kernel and lib=
bpf
> > let's share here as well to avoid copy paste.
> > All of the above is available in include/linux/bpf_types.h
>
> True, but libbpf sources are built both as part of the kernel repo and
> separately on Github, so we'll need to start syncing
> include/linux/bpf_types.h into tools/include, so that's a bit of
> inconvenience.
>
> But most of all I don't want to do it for a few other reasons.
>
> This table was manually constructed by inspecting struct bpf_ctx_convert =
with:
>
>   bpftool btf dump file /sys/kernel/btf/vmlinux format c | rg
> bpf_ctx_convert -A65 | rg _prog
>
> And it has to be manual because of other program types that don't have
> associated struct for context. So even if there was bpf_types.h, we
> can't use it as is.

Another headache I realized as I was reading someone else's patch is
all the #ifdef CONFIG_xxx checks, which we'd need to fake to even get
a full list of program types. In short, it's more trouble than it's
worth.

>
> But, if your concern is maintainability of this, I don't think that's
> a problem at all. Even if we add a new program type with its own
> struct name for context, we don't even have to extend this table
> (though we might, if we want to), because at that point kernel is
> guaranteed to have in-kernel native support for __arg_ctx, so libbpf
> doesn't have to do type rewriting.
>
> Also, this probably is the first explicit table that shows which
> struct names should be used for global subprog context argument (if
> not using __arg_ctx, of course). Which is not really a reason per se,
> but it beats reading kernel code, and (non-trivially) figuring out
> that one needs to look how struct bpf_ctx_convert is generated, etc.
> Having this explicit table is much easier to link as a reference for
> those special context type names.
>
> >
> > > +             /* clone fn/fn_proto, unless we already did it for anot=
her arg */
> > > +             if (func_rec->type_id =3D=3D orig_fn_id) {
> >
> > It feels that body of this 'if' can be factored out as a separate helpe=
r function.
> >
>
> Sure, I'll try to factor it out.
>
> > > -static int
> > > -bpf_object__load_progs(struct bpf_object *obj, int log_level)
> > > +static int bpf_object_load_progs(struct bpf_object *obj, int log_lev=
el)
> >
> > pls keep __ convention.
>
> replied on another patch, I'll do a conversion to consistent naming in
> the next revision

