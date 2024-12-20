Return-Path: <bpf+bounces-47377-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ACAF9F88FE
	for <lists+bpf@lfdr.de>; Fri, 20 Dec 2024 01:32:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8967318957B4
	for <lists+bpf@lfdr.de>; Fri, 20 Dec 2024 00:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FD8653AC;
	Fri, 20 Dec 2024 00:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kGcCfzU7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F8644A01;
	Fri, 20 Dec 2024 00:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734654763; cv=none; b=Gf/uX015tvHWPnsNcA9biWqJMJ12KaM7pJBWHJZGWiukP8oC+Xeut/ozWcQQf3pynjnd5kcYP0m3rxcFF2Lqrcjllty4zgRZE8dgXFSKzq3R4m9H2HAvKtABH9q+O5SmSIAZDbVwv76T3+giYLArqOCrHqUDkUbSyzWDcWGcNHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734654763; c=relaxed/simple;
	bh=jpW1z9wsZ6tpydVQ6ASWZYHf15zbtxRU+8O0DGX17/E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yt/3MlNCJ3zYYqGg0VvXyWBoC2O+Nf7fNRTAyARpw/KNdw1mM9SzEsG3F16peTaqyBGhqqwxYJEiZzQdeCSNaM6nYEaTegEMzTezC9z+cWu026+Eih3Rrl8UvCtNdSJJPumHxo/h2UbjtzbsXpWXbMV1gcl/GwQL4kW6LJdZbco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kGcCfzU7; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6ef81222be7so12905787b3.3;
        Thu, 19 Dec 2024 16:32:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734654761; x=1735259561; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WutTWyrybLI+fmU655iC2YG3AkdeI1eLWjV4lRXYlA8=;
        b=kGcCfzU7Kib6TDPl0vyiDop9Ib7H9tOPRZrgDOwhYnYYupLcHColrflj7wggJwOAdr
         0pLShUeRS59Tshw+9NtJtmHT+X/1plYCiTYwSCWgkqSDrHKTrsvIv7gFodEcGLR9Kodw
         Xwmgbt5DFL9PAYx6Nvu1vitWX/0mnk34IsU6DPyDaLHsfjOAbpqW+MF8frZYcPwBNyk2
         EqtRNX93t6e7mbU/Ez+vNR4DdLFuyMge0G0YDFPd0MOuP+YO4Vu6BlPk3kyqJ6LuLtKl
         LHJq7bvhNvTEA/eAmtqnXvZe3SOy7Tplvv6PXun8gBOE28WZYZcOX2cWkjPtrrKTUEN4
         a7Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734654761; x=1735259561;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WutTWyrybLI+fmU655iC2YG3AkdeI1eLWjV4lRXYlA8=;
        b=RwPgFED+6RFqUrYFM4bhGmDMesfke2nnmE8OTahUY0tY+iW8hxxeBw/VrBWiFYcUpE
         zT5UW8ikqu+TvVjp5/qofDH4wZmtCL8BEX4Uk/x3SBWOZ/Y74OSv6RlMeXWIkfk6VFOM
         h2Afw9B4TEs0SE7imEwirchKIsnz907EbNdgUnYfUpwi7OE9Nu4lxKLV6qhfGrfSiUc1
         5u/AidXtOqYPdbw7KLuTZRCCj0EIB0lM0Vqti7CS3H0uDZs3yfjYx7aB0f0fL+LaSjuI
         HGUFu7Rozk79TTTX6opLrJC5F41OqmOrG22+VN3bWTWwjUzroG9CSWtG6mY31Drj8nW2
         nFLQ==
X-Forwarded-Encrypted: i=1; AJvYcCWdA+F7Ta8Oe0YSTeQXsRC582vqXSt6dHZXknBaYSImiWjWbhJdrTOGdy2i6kW4/cPn6+H+ZsLs@vger.kernel.org, AJvYcCXkjNgPy3j7ErAmp14S8aiM4fIgLHwXKoGL0AaClEnqMZrfyL5CmO9R0N9bjZDJ45enrys=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzo0KqbFBEM283xD7qYY5x7Clp6jxOHUkr89rHABRbpRj8/pmSX
	Z2g6GdXGcKBrkiMAt9oeh+8wd/BdpH7mjRljJU7fYebD+LV+f3Z5ayFrW7DW+WZf9L76Z6Wjv+d
	j2r5+ZKD1V+S4P/JmazOZMM8jaUU=
X-Gm-Gg: ASbGncuntliD8IkAkaKI5ATz7T94uvmqpmkMd3vsN9xlfNDgptw14nBeTKCUOflfEO3
	IVWvHxpvQNu9Jzf62f4xVldtCDraTE02PQl+QZw==
X-Google-Smtp-Source: AGHT+IH4SiTa6/AlF6a7caQc7DQbFSbsJzOAgHp0qDbx5u8ZC5zSjVU2oAqDxSjQXtwYK2Ea+taV58wMqgEvtGWJu6s=
X-Received: by 2002:a05:690c:4884:b0:6e9:e097:7191 with SMTP id
 00721157ae682-6f3f80e57d8mr7325937b3.9.1734654760869; Thu, 19 Dec 2024
 16:32:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241213232958.2388301-1-amery.hung@bytedance.com>
 <20241213232958.2388301-7-amery.hung@bytedance.com> <fd856afb-7ff5-4928-8ba1-22e68c0913e7@linux.dev>
In-Reply-To: <fd856afb-7ff5-4928-8ba1-22e68c0913e7@linux.dev>
From: Amery Hung <ameryhung@gmail.com>
Date: Thu, 19 Dec 2024 16:32:30 -0800
Message-ID: <CAMB2axMQUQjP1nAAe-dJ5G92W_BQMmiBWa5LV=v9pdO90cmP5A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 06/13] bpf: net_sched: Add basic bpf qdisc kfuncs
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Amery Hung <amery.hung@bytedance.com>, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, alexei.starovoitov@gmail.com, 
	martin.lau@kernel.org, sinquersw@gmail.com, toke@redhat.com, jhs@mojatatu.com, 
	jiri@resnulli.us, stfomichev@gmail.com, ekarani.silvestre@ccc.ufcg.edu.br, 
	yangpeihao@sjtu.edu.cn, xiyou.wangcong@gmail.com, yepeilin.cs@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 18, 2024 at 11:37=E2=80=AFPM Martin KaFai Lau <martin.lau@linux=
.dev> wrote:
>
> On 12/13/24 3:29 PM, Amery Hung wrote:
> > Add basic kfuncs for working on skb in qdisc.
> >
> > Both bpf_qdisc_skb_drop() and bpf_kfree_skb() can be used to release
> > a reference to an skb. However, bpf_qdisc_skb_drop() can only be called
> > in .enqueue where a to_free skb list is available from kernel to defer
> > the release. bpf_kfree_skb() should be used elsewhere. It is also used
> > in bpf_obj_free_fields() when cleaning up skb in maps and collections.
> >
> > bpf_skb_get_hash() returns the flow hash of an skb, which can be used
> > to build flow-based queueing algorithms.
> >
> > Finally, allow users to create read-only dynptr via bpf_dynptr_from_skb=
().
> >
> > Signed-off-by: Amery Hung <amery.hung@bytedance.com>
> > ---
> >   net/sched/bpf_qdisc.c | 77 ++++++++++++++++++++++++++++++++++++++++++=
-
> >   1 file changed, 76 insertions(+), 1 deletion(-)
> >
> > diff --git a/net/sched/bpf_qdisc.c b/net/sched/bpf_qdisc.c
> > index a2e2db29e5fc..28959424eab0 100644
> > --- a/net/sched/bpf_qdisc.c
> > +++ b/net/sched/bpf_qdisc.c
> > @@ -106,6 +106,67 @@ static int bpf_qdisc_btf_struct_access(struct bpf_=
verifier_log *log,
> >       return 0;
> >   }
> >
> > +__bpf_kfunc_start_defs();
> > +
> > +/* bpf_skb_get_hash - Get the flow hash of an skb.
> > + * @skb: The skb to get the flow hash from.
> > + */
> > +__bpf_kfunc u32 bpf_skb_get_hash(struct sk_buff *skb)
> > +{
> > +     return skb_get_hash(skb);
> > +}
> > +
> > +/* bpf_kfree_skb - Release an skb's reference and drop it immediately.
> > + * @skb: The skb whose reference to be released and dropped.
> > + */
> > +__bpf_kfunc void bpf_kfree_skb(struct sk_buff *skb)
> > +{
> > +     kfree_skb(skb);
> > +}
> > +
> > +/* bpf_qdisc_skb_drop - Drop an skb by adding it to a deferred free li=
st.
> > + * @skb: The skb whose reference to be released and dropped.
> > + * @to_free_list: The list of skbs to be dropped.
> > + */
> > +__bpf_kfunc void bpf_qdisc_skb_drop(struct sk_buff *skb,
> > +                                 struct bpf_sk_buff_ptr *to_free_list)
> > +{
> > +     __qdisc_drop(skb, (struct sk_buff **)to_free_list);
> > +}
> > +
> > +__bpf_kfunc_end_defs();
> > +
> > +#define BPF_QDISC_KFUNC_xxx \
> > +     BPF_QDISC_KFUNC(bpf_skb_get_hash, KF_TRUSTED_ARGS) \
> > +     BPF_QDISC_KFUNC(bpf_kfree_skb, KF_RELEASE) \
> > +     BPF_QDISC_KFUNC(bpf_qdisc_skb_drop, KF_RELEASE) \
> > +
> > +BTF_KFUNCS_START(bpf_qdisc_kfunc_ids)
> > +#define BPF_QDISC_KFUNC(name, flag) BTF_ID_FLAGS(func, name, flag)
> > +BPF_QDISC_KFUNC_xxx
> > +#undef BPF_QDISC_KFUNC
> > +BTF_ID_FLAGS(func, bpf_dynptr_from_skb, KF_TRUSTED_ARGS)
> > +BTF_KFUNCS_END(bpf_qdisc_kfunc_ids)
> > +
> > +#define BPF_QDISC_KFUNC(name, _) BTF_ID_LIST_SINGLE(name##_ids, func, =
name)
>
>
> > +BPF_QDISC_KFUNC_xxx
> > +#undef BPF_QDISC_KFUNC
> > +
> > +static int bpf_qdisc_kfunc_filter(const struct bpf_prog *prog, u32 kfu=
nc_id)
> > +{
> > +     if (kfunc_id =3D=3D bpf_qdisc_skb_drop_ids[0])
> > +             if (strcmp(prog->aux->attach_func_name, "enqueue"))
>
> The kfunc is registered for all BPF_PROG_TYPE_STRUCT_OPS. Checking func_n=
ame
> alone is not enough, e.g. another future struct_ops may have the "enqueue=
" ops.
>
> Checking the btf type of "struct Qdisc_ops" is better. Something like the
> following (untested):
>

Got it. I will add a structp_ops type check in the filter.

> diff --git i/include/linux/bpf.h w/include/linux/bpf.h
> index c81ac98db439..cf3133f81e7f 100644
> --- i/include/linux/bpf.h
> +++ w/include/linux/bpf.h
> @@ -1809,6 +1809,7 @@ struct bpf_struct_ops {
>         void *cfi_stubs;
>         struct module *owner;
>         const char *name;
> +       const struct btf_type *type;
>         struct btf_func_model func_models[BPF_STRUCT_OPS_MAX_NR_MEMBERS];
>   };
>
> diff --git i/kernel/bpf/bpf_struct_ops.c w/kernel/bpf/bpf_struct_ops.c
> index d9e0af00580b..5c2ca5a84384 100644
> --- i/kernel/bpf/bpf_struct_ops.c
> +++ w/kernel/bpf/bpf_struct_ops.c
> @@ -432,6 +432,8 @@ int bpf_struct_ops_desc_init(struct bpf_struct_ops_de=
sc
> *st_ops_desc,
>                 goto errout;
>         }
>
> +       st_ops->type =3D t;
> +
>         return 0;
>
>   errout:
> diff --git i/net/sched/bpf_qdisc.c w/net/sched/bpf_qdisc.c
> index 1caa9f696d2d..94e45ea59fef 100644
> --- i/net/sched/bpf_qdisc.c
> +++ w/net/sched/bpf_qdisc.c
> @@ -250,6 +250,11 @@ BPF_QDISC_KFUNC_xxx
>
>   static int bpf_qdisc_kfunc_filter(const struct bpf_prog *prog, u32 kfun=
c_id)
>   {
> +
> +       if (bpf_Qdisc_ops.type !=3D btf_type_by_id(prog->aux->attach_btf,
> +                                                prog->aux->attach_btf_id=
))
> +               return -EACCES;
> +
>         if (kfunc_id =3D=3D bpf_qdisc_skb_drop_ids[0]) {
>                 if (strcmp(prog->aux->attach_func_name, "enqueue"))
>                         return -EACCES;
>
>
> st_ops->type (and a few others) was refactored to bpf_struct_ops_desc whe=
n
> adding the kernel module support. I think adding st_ops->type back should=
 be enough.
>
> Also, a bike shedding here, from looking at patch 7 and patch 8 which lim=
it a
> set of kfuncs to a particular ops. I think using btf_id_set_contains() is=
 more
> inline to other verifier usages.
>
> BTF_SET_START(qdisc_enqueue_kfunc_set)
> BTF_ID(func, bpf_qdisc_skb_drop)
> BTF_ID(func, bpf_qdisc_watchdog_schedule)
> BTF_SET_END(qdisc_enqueue_kfunc_set)
>
> BTF_SET_START(qdisc_dequeue_kfunc_set)
> BTF_ID(func, bpf_qdisc_bstats_update)
> BTF_ID(func, bpf_qdisc_watchdog_schedule)
> BTF_SET_END(qdisc_dequeue_kfunc_set)
>
> BTF_SET_START(qdisc_common_kfunc_set)
> BTF_ID(func, bpf_skb_get_hash)
> BTF_ID(func, bpf_kfree_skb)
> BTF_SET_END(qdisc_common_kfunc_set)
>

I will change the style of kfunc ops availability check to the one you
suggested.

Thanks,
Amery

> > +                     return -EACCES;
> > +
> > +     return 0;
> > +}
> > +
> > +static const struct btf_kfunc_id_set bpf_qdisc_kfunc_set =3D {
> > +     .owner =3D THIS_MODULE,
> > +     .set   =3D &bpf_qdisc_kfunc_ids,
> > +     .filter =3D bpf_qdisc_kfunc_filter,
> > +};
> > +
> >   static const struct bpf_verifier_ops bpf_qdisc_verifier_ops =3D {
> >       .get_func_proto         =3D bpf_qdisc_get_func_proto,
> >       .is_valid_access        =3D bpf_qdisc_is_valid_access,
> > @@ -209,6 +270,20 @@ static struct bpf_struct_ops bpf_Qdisc_ops =3D {
> >
> >   static int __init bpf_qdisc_kfunc_init(void)
> >   {
> > -     return register_bpf_struct_ops(&bpf_Qdisc_ops, Qdisc_ops);
> > +     int ret;
> > +     const struct btf_id_dtor_kfunc skb_kfunc_dtors[] =3D {
> > +             {
> > +                     .btf_id       =3D bpf_sk_buff_ids[0],
> > +                     .kfunc_btf_id =3D bpf_kfree_skb_ids[0]
> > +             },
> > +     };
> > +
> > +     ret =3D register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS, &bpf_=
qdisc_kfunc_set);
> > +     ret =3D ret ?: register_btf_id_dtor_kfuncs(skb_kfunc_dtors,
> > +                                              ARRAY_SIZE(skb_kfunc_dto=
rs),
> > +                                              THIS_MODULE);
> > +     ret =3D ret ?: register_bpf_struct_ops(&bpf_Qdisc_ops, Qdisc_ops)=
;
> > +
> > +     return ret;
> >   }
> >   late_initcall(bpf_qdisc_kfunc_init);
>

