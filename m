Return-Path: <bpf+bounces-52212-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 390E8A3FF75
	for <lists+bpf@lfdr.de>; Fri, 21 Feb 2025 20:11:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A7067AEFDD
	for <lists+bpf@lfdr.de>; Fri, 21 Feb 2025 19:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB6281FBCB9;
	Fri, 21 Feb 2025 19:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RWsm056G"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2DA71FBC86;
	Fri, 21 Feb 2025 19:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740165101; cv=none; b=nXfBcVi5Du4a2SNENgMTRBrtL7e6JXQKwZ95x43Uy8no6Mb7ypGMcf7kRjOHDi8YMgzvAO6Z4vhSF1R7NNMVZidgs+gZiKd0awC02PcjO92BWJc0gYqvb0rNPgr+Zr6GTMz8hkWmOrjsjW0h+rfM5GvY0HsUDHIzeZ+MAaZ96n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740165101; c=relaxed/simple;
	bh=PbOVlAJxc2Xo/N/P0W8qPuZ2rlzfngj6tfrP4tI1Wi8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s6ERdBydRY2ouP6nPlvYcIanIwwJp9q6J+RpwwYxtX79k+rLqLLS+W7wgv38fhT7MX0KVZoYxMfYSk0SuKNOKDh4QMbmIwXhKttKrXNHEvF0WQDewbbUkMl/79ynCUaKQ9LDtQKsSShpiGDI0POZ8OVUNjmgU4Fxqy3j89DH9VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RWsm056G; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e53ef7462b6so2180189276.3;
        Fri, 21 Feb 2025 11:11:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740165099; x=1740769899; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8E9n7lWg37arGJJBC+cFoacQWq59M2kbyurzH/Jx9BE=;
        b=RWsm056Gj+M89TGBUSKi5TS4kF407Gy7rzosC8eRedf5B448pFBd9lEEgPUPiqXMOs
         p+o2EXDHKKy8ucRi8t7tVonWtkZamQy6xnawpwimM3mMjI/bIZUv6S6DRjKd2ZlNi3HI
         0va+BqwyFkL85tDWCIUepM3TvvhlnQ8zAD0/tPi6IZ4idrbOuH3J4ZiV76aS43BJFhp/
         XTsM4WtYju8uExF1ppj9/B7e+2US8clU/avBa11R7WddSq3YJ2NSJppFlTLzAlBx7QUd
         6Wmy9BXVargr4j0ciNeIxH23yfLOrirdGfLSXCBwEQ9mgYErk+zyH2Sua1rWbi94zGfE
         oDEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740165099; x=1740769899;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8E9n7lWg37arGJJBC+cFoacQWq59M2kbyurzH/Jx9BE=;
        b=SPGj3APSAHnN6+DyWkHEKmMJiTC5TF/gvXLSJR0TvncKTu2yx/XOzyhMo9/M+Vpf2w
         6iwL9cnpmRwqG2gZtPOCTAPAkvFm6yZOM1RU6idK8MlEBTiHPHF8qOuaZr8gFSo5lCBe
         dmNvQaWsN5A17on+IdMqsIGps0xd2HbpW404Rl/z2QszM3wEWKuiRl7lz09vlw7qQCgB
         UzwB/kyS2hZSUuQAbiXgawZJTGbStGNglxAojcuICq3vNi7ZSx1EDBGIS5U8M2pt1yK2
         hQ1Va92d99K1We1AIjRQHzH4qzAdcl7W2cuixr8qwsS0Nz42Jm0kg43fxkGuzPxduka7
         XOaQ==
X-Forwarded-Encrypted: i=1; AJvYcCWeA2jYpUOT1jA4x1xh6iF54+WbhldxeClyrSWFnd1IeLRNx8tx0zKuRVpMJWou/EYMeA8GFEE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVelpzZ3MlIKZvpBUYp8GEzvGkITeADTzeXFLnE6flFf9iX/hZ
	QtpfWolEk4iUMeK2YEEowSoXY3PxBWUElH7NbWsGoEa/Dqe4NCoby+U+iuCnqi0itIuVgZRXdn4
	We3Sku237kYPMoKq6toOK+q8OPgU=
X-Gm-Gg: ASbGncv69LpP0kCKdAE20jZ7kNZha3kwTvKYrLH/7cZxNmPZqPorjCsFdbQ8iiCquPQ
	pyN6hXwGH3igDM01xgg3Ah3kBQ4oHL0TW5PWP6Uhbg0DwBbq/CD1k3inGSzY1y+TbPbrhjL1O1r
	gbd33BO4U=
X-Google-Smtp-Source: AGHT+IGre0sL6f6AjeXhGCxk71jxb9oVlxD0klSPR2BHx+8faiZPu2VZao6IQ/2JO5iMSP+2hS19EYhA1XX2CTg34bM=
X-Received: by 2002:a05:6902:2484:b0:e5d:df2b:3b13 with SMTP id
 3f1490d57ef6-e5e2466eeddmr3394741276.32.1740165098684; Fri, 21 Feb 2025
 11:11:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250220134503.835224-1-maciej.fijalkowski@intel.com>
 <20250220134503.835224-3-maciej.fijalkowski@intel.com> <0e66379b-3b37-4bbd-9e9d-1f934cb1fdc8@gmail.com>
 <Z7iUMK1XePvptYc5@boxer>
In-Reply-To: <Z7iUMK1XePvptYc5@boxer>
From: Amery Hung <ameryhung@gmail.com>
Date: Fri, 21 Feb 2025 11:11:27 -0800
X-Gm-Features: AWEUYZn2R-uTdT5C5RdOUUI2ZkhwlCn2_q-y0AbttoPyV7nxGfNMKOeQ-XZ-WXY
Message-ID: <CAMB2axNJjsytoFrYF=PdsOOWE-bbficZa-54C9YHT5JFu5PFBQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/3] bpf: add kfunc for skb refcounting
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, netdev@vger.kernel.org, magnus.karlsson@intel.com, 
	martin.lau@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 21, 2025 at 6:57=E2=80=AFAM Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> On Thu, Feb 20, 2025 at 03:25:03PM -0800, Amery Hung wrote:
> >
> >
> > On 2/20/2025 5:45 AM, Maciej Fijalkowski wrote:
> > > These have been mostly taken from Amery Hung's work related to bpf qd=
isc
> > > implementation. bpf_skb_{acquire,release}() are for increment/decreme=
nt
> > > sk_buff::users whereas bpf_skb_destroy() is called for map entries th=
at
> > > have not been released and map is being wiped out from system.
> > >
> > > Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> > > ---
> > >   net/core/filter.c | 62 ++++++++++++++++++++++++++++++++++++++++++++=
+++
> > >   1 file changed, 62 insertions(+)
> > >
> > > diff --git a/net/core/filter.c b/net/core/filter.c
> > > index 2ec162dd83c4..9bd2701be088 100644
> > > --- a/net/core/filter.c
> > > +++ b/net/core/filter.c
> > > @@ -12064,6 +12064,56 @@ __bpf_kfunc int bpf_sk_assign_tcp_reqsk(stru=
ct __sk_buff *s, struct sock *sk,
> > >   __bpf_kfunc_end_defs();
> > > +__diag_push();
> > > +__diag_ignore_all("-Wmissing-prototypes",
> > > +             "Global functions as their definitions will be in vmlin=
ux BTF");
> > > +
> > > +/* bpf_skb_acquire - Acquire a reference to an skb. An skb acquired =
by this
> > > + * kfunc which is not stored in a map as a kptr, must be released by=
 calling
> > > + * bpf_skb_release().
> > > + * @skb: The skb on which a reference is being acquired.
> > > + */
> > > +__bpf_kfunc struct sk_buff *bpf_skb_acquire(struct sk_buff *skb)
> > > +{
> > > +   if (refcount_inc_not_zero(&skb->users))
> > > +           return skb;
> > > +   return NULL;
> > > +}
> > > +
> > > +/* bpf_skb_release - Release the reference acquired on an skb.
> > > + * @skb: The skb on which a reference is being released.
> > > + */
> > > +__bpf_kfunc void bpf_skb_release(struct sk_buff *skb)
> > > +{
> > > +   skb_unref(skb);
> > > +}
> > > +
> > > +/* bpf_skb_destroy - Release an skb reference acquired and exchanged=
 into
> > > + * an allocated object or a map.
> > > + * @skb: The skb on which a reference is being released.
> > > + */
> > > +__bpf_kfunc void bpf_skb_destroy(struct sk_buff *skb)
> > > +{
> > > +   (void)skb_unref(skb);
> > > +   consume_skb(skb);
> > > +}
> > > +
> > > +__diag_pop();
> > > +
> > > +BTF_KFUNCS_START(skb_kfunc_btf_ids)
> > > +BTF_ID_FLAGS(func, bpf_skb_acquire, KF_ACQUIRE | KF_RET_NULL)
> > > +BTF_ID_FLAGS(func, bpf_skb_release, KF_RELEASE)
> > > +BTF_KFUNCS_END(skb_kfunc_btf_ids)
> > > +
> > > +static const struct btf_kfunc_id_set skb_kfunc_set =3D {
> > > +   .owner =3D THIS_MODULE,
> > > +   .set   =3D &skb_kfunc_btf_ids,
> > > +};
> > > +
> > > +BTF_ID_LIST(skb_kfunc_dtor_ids)
> > > +BTF_ID(struct, sk_buff)
> > > +BTF_ID_FLAGS(func, bpf_skb_destroy, KF_RELEASE)
> > > +
> > >   int bpf_dynptr_from_skb_rdonly(struct __sk_buff *skb, u64 flags,
> > >                            struct bpf_dynptr *ptr__uninit)
> > >   {
> > > @@ -12117,6 +12167,13 @@ static const struct btf_kfunc_id_set bpf_kfu=
nc_set_tcp_reqsk =3D {
> > >   static int __init bpf_kfunc_init(void)
> > >   {
> > > +   const struct btf_id_dtor_kfunc skb_kfunc_dtors[] =3D {
> > > +           {
> > > +                   .btf_id       =3D skb_kfunc_dtor_ids[0],
> > > +                   .kfunc_btf_id =3D skb_kfunc_dtor_ids[1]
> > > +           },
> > > +   };
> > > +
> > >     int ret;
> > >     ret =3D register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_CLS, &bpf_k=
func_set_skb);
> > > @@ -12133,6 +12190,11 @@ static int __init bpf_kfunc_init(void)
> > >     ret =3D ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_XDP, &bpf_=
kfunc_set_xdp);
> > >     ret =3D ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_CGROUP_SOC=
K_ADDR,
> > >                                            &bpf_kfunc_set_sock_addr);
> > > +   ret =3D ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_CLS,=
 &skb_kfunc_set);
> > > +
> > > +   ret =3D ret ?: register_btf_id_dtor_kfuncs(skb_kfunc_dtors,
> > > +                                            ARRAY_SIZE(skb_kfunc_dto=
rs),
> > > +                                            THIS_MODULE);
> >
> > I think we will need to deal with two versions of skb dtors here. Both =
qdisc
> > and cls will register dtor associated for skb. The qdisc one just call
> > kfree_skb(). While only one can exist for a specific btf id in the kern=
el if
> > I understand correctly. Is it possible to have one that work
> > for both use cases?
>
> Looking at the current code it seems bpf_find_btf_id() (which
> btf_parse_kptr() calls) will go through modules and return the first matc=
h
> against sk_buff btf but that's currently a wild guess from my side. So
> your concern stands as we have no mechanism that would distinguish the
> dtors for same btf id.
>
> I would have to take a deeper look at btf_parse_kptr() and find some way
> to associate dtor with its module during registering and then use it
> within btf_find_dtor_kfunc(). Would this be sufficient?
>

That might not be enough. Ultimately, if the user configures both
modules to be built-in, then there is no way to tell where a trusted
skb kptr in a bpf program is from.

Two possible ways to solve this:

1. Make the dtor be able to tell whether the skb is from qdisc or cls.
Since we are both in the TC layer, maybe we can use skb->cb for this?

2. Associate KF_ACQUIRE kfuncs with the corresponding KF_RELEASE
kfuncs somehow. Carry this additional information as the kptr
propagates in the bpf world so that we know which dtor to call. This
seems to be overly complicated.


> >
> > >     return ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_CLS, =
&bpf_kfunc_set_tcp_reqsk);
> > >   }
> > >   late_initcall(bpf_kfunc_init);
> >

