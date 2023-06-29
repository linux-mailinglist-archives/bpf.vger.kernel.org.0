Return-Path: <bpf+bounces-3683-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 062CD741EC3
	for <lists+bpf@lfdr.de>; Thu, 29 Jun 2023 05:36:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2216F280D0A
	for <lists+bpf@lfdr.de>; Thu, 29 Jun 2023 03:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB55D1FC2;
	Thu, 29 Jun 2023 03:36:01 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44001FAD
	for <bpf@vger.kernel.org>; Thu, 29 Jun 2023 03:36:01 +0000 (UTC)
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF23B2961
	for <bpf@vger.kernel.org>; Wed, 28 Jun 2023 20:35:59 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2b6a152a933so2971951fa.1
        for <bpf@vger.kernel.org>; Wed, 28 Jun 2023 20:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688009758; x=1690601758;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MtjWRrQAdegg0v7Gu/Yiufgv2AvWdLD3GmggOzaJVBQ=;
        b=aDnmVndkVnmjALZrMPWrsrKJMDy5DkwgQoUSx3nt01Q5ptLRDdsjYvcKIpToUgkCMy
         TE2/QIDY8GIeZe1vk7R5zpxrDIlsprjzfDuSjHbMmc8aF4dWGji4Uwir+KcJNyu1Uy9h
         PlJ3IEpNPZGMkmTF3hkExL16wfRkuf81dJ5mXeaveb7oUA7quzZRGiKCfkU1dHr+DogN
         Ku96n9toTXOISVLpkuH6NOuMhOQpXHb35zBapYGCitOoS2o7x6L0PRAe8FoRMA1/kxTg
         NI4UcRnlMtsqZ1SOD2TgvgR9XWyA7ddyYmnB1MSuJG6nLmbMdR/ubsVg+DV3QPzuxS3Y
         DpTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688009758; x=1690601758;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MtjWRrQAdegg0v7Gu/Yiufgv2AvWdLD3GmggOzaJVBQ=;
        b=N+1/2cC0wcbLVBAcIppV18jVPz/q6DMxJ3XPfstc/iF9XuK39helPXk9tqjZYLsSGG
         WNF1lcxoEivGwov6Q+1Wwxdvk11NIuzR5JX9nL+GndzTDqNqU6mQsNrcXXqifNtTRldc
         +ZN622IbptHR/c8Z71IlJL//sujIYprC+HoqxI070bMoqrJkqU/De5rzGqZg+RZx1q1/
         +u5l0KD0Lo1/jnsfUW3aYOKYYCCRc+EAWrcGOJhk7lPQaXiC2sbgu1qZTbvStVCoAXHb
         ZCBqP4wjwZz1mNt1NzQvD+249fX2YtCRseUrFwGbKdVEDEfI/wde+LTCjtPOr3DlOInn
         TIxw==
X-Gm-Message-State: AC+VfDwKdSK6OF5oYtJic3x/z9uNFVNA1QnZz9ryFwJNqpIZW+JCXOGO
	Fn3iwtiFKbudQg40e89vIj1dLRTP0wCnqGKa9HE=
X-Google-Smtp-Source: ACHHUZ6T49NAE4FCHikmECFoEggGGnkrVA8SNSxlhXFhzfrmhnc2C7JdiwMfdcQiSxnrBlT00b2qTQQAXnVA6BhhIG4=
X-Received: by 2002:a2e:9014:0:b0:2b6:9c1d:dea3 with SMTP id
 h20-20020a2e9014000000b002b69c1ddea3mr8777911ljg.2.1688009757639; Wed, 28 Jun
 2023 20:35:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230628115205.248395-1-laoar.shao@gmail.com> <20230628115205.248395-2-laoar.shao@gmail.com>
 <CALOAHbCreRRkLwt0Vyp9rUbL7JVzD5A4CET=jKoUJwAHXPop7g@mail.gmail.com>
In-Reply-To: <CALOAHbCreRRkLwt0Vyp9rUbL7JVzD5A4CET=jKoUJwAHXPop7g@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 28 Jun 2023 20:35:45 -0700
Message-ID: <CAADnVQK7kriNBmRZ04PvoYbL02acJkLiNWNa7j4bN3oh4M+Png@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Fix an error around PTR_UNTRUSTED
To: Yafang Shao <laoar.shao@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>, 
	Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jun 28, 2023 at 8:12=E2=80=AFPM Yafang Shao <laoar.shao@gmail.com> =
wrote:
>
> On Wed, Jun 28, 2023 at 7:52=E2=80=AFPM Yafang Shao <laoar.shao@gmail.com=
> wrote:
> >
> > Per discussion with Alexei, the PTR_UNTRUSTED flag should not been
> > cleared when we start to walk a new struct, because the struct in
> > question may be a struct nested in a union. We should also check and se=
t
> > this flag before we walk its each member, in case itself is a union.
> >
> > Fixes: 6fcd486b3a0a ("bpf: Refactor RCU enforcement in the verifier.")
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > ---
> >  kernel/bpf/btf.c | 20 +++++++++-----------
> >  1 file changed, 9 insertions(+), 11 deletions(-)
> >
> > diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> > index 29fe21099298..e0a493230727 100644
> > --- a/kernel/bpf/btf.c
> > +++ b/kernel/bpf/btf.c
> > @@ -6133,7 +6133,6 @@ static int btf_struct_walk(struct bpf_verifier_lo=
g *log, const struct btf *btf,
> >         const char *tname, *mname, *tag_value;
> >         u32 vlen, elem_id, mid;
> >
> > -       *flag =3D 0;
> >  again:
> >         tname =3D __btf_name_by_offset(btf, t->name_off);
> >         if (!btf_type_is_struct(t)) {
> > @@ -6142,6 +6141,14 @@ static int btf_struct_walk(struct bpf_verifier_l=
og *log, const struct btf *btf,
> >         }
> >
> >         vlen =3D btf_type_vlen(t);
> > +       if (BTF_INFO_KIND(t->info) =3D=3D BTF_KIND_UNION && vlen !=3D 1=
)
> > +               /*
> > +                * walking unions yields untrusted pointers
> > +                * with exception of __bpf_md_ptr and other
> > +                * unions with a single member
> > +                */
> > +               *flag |=3D PTR_UNTRUSTED;
> > +
> >         if (off + size > t->size) {
> >                 /* If the last element is a variable size array, we may
> >                  * need to relax the rule.
> > @@ -6302,15 +6309,6 @@ static int btf_struct_walk(struct bpf_verifier_l=
og *log, const struct btf *btf,
> >                  * of this field or inside of this struct
> >                  */
> >                 if (btf_type_is_struct(mtype)) {
> > -                       if (BTF_INFO_KIND(mtype->info) =3D=3D BTF_KIND_=
UNION &&
> > -                           btf_type_vlen(mtype) !=3D 1)
> > -                               /*
> > -                                * walking unions yields untrusted poin=
ters
> > -                                * with exception of __bpf_md_ptr and o=
ther
> > -                                * unions with a single member
> > -                                */
> > -                               *flag |=3D PTR_UNTRUSTED;
> > -
> >                         /* our field must be inside that union or struc=
t */
> >                         t =3D mtype;
> >
> > @@ -6476,7 +6474,7 @@ bool btf_struct_ids_match(struct bpf_verifier_log=
 *log,
> >                           bool strict)
> >  {
> >         const struct btf_type *type;
> > -       enum bpf_type_flag flag;
> > +       enum bpf_type_flag flag =3D 0;
> >         int err;
> >
> >         /* Are we already done? */
> > --
> > 2.39.3
> >
>
> Just noticed that it breaks test_sk_storage_tracing, because skb->sk
> is in a union:
>    struct sk_buff {
>        ...
>        union {
>            struct sock             *sk;
>            int                     ip_defrag_offset;
>        };
>        ...
>    };
>
> I will think about it.

It can be whitelisted similar to BTF_TYPE_SAFE_*.
Please add a selftest for the new feature.

