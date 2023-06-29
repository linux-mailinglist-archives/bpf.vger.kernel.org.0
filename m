Return-Path: <bpf+bounces-3685-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D54DD741ED8
	for <lists+bpf@lfdr.de>; Thu, 29 Jun 2023 05:47:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFAC71C204E8
	for <lists+bpf@lfdr.de>; Thu, 29 Jun 2023 03:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3329A1FCC;
	Thu, 29 Jun 2023 03:47:36 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F423C10E9
	for <bpf@vger.kernel.org>; Thu, 29 Jun 2023 03:47:35 +0000 (UTC)
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 195E6171E
	for <bpf@vger.kernel.org>; Wed, 28 Jun 2023 20:47:34 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id 6a1803df08f44-635e3ceb152so1764616d6.2
        for <bpf@vger.kernel.org>; Wed, 28 Jun 2023 20:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688010453; x=1690602453;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kOQehtPxuCDA16kVtd/xK3Xl5LiUTWzm7L/9vvVQNOQ=;
        b=N8ZUvlkmLOYC2VCOXuj3Kt+Bj3JXMZZhPX5+uVz9IX4vxlWaESs1GRAT7JS+h99XSy
         3hp33nJaoPZB9o0jjClMv2aqhuJbn+WPct5BECfPjEFIINHKCgmJBspLUQFt2v+w9xP0
         IvGebbLvvNdx8y4Cgt+Tr4vj6m/ZwBj/+U0SAREX6i3emlWMSxExUE/4pMFlwig0s4Li
         t88Y/FrVpgt0tNfzs4BZ5b0+zPuDk9+oRHnzUZg17b8XvYc+X9PwFL8o28EcOScAel89
         RK2MuaoLyPfbqGuJuP7RAw0qR3qj6o3u98sPCy4RTo8j1veadnNZDUfUOV0e8MBqitrz
         Zx3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688010453; x=1690602453;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kOQehtPxuCDA16kVtd/xK3Xl5LiUTWzm7L/9vvVQNOQ=;
        b=P5KkCqR/KamSSKStRvvGYl83tOOZ0O/SEIf7t83MkPK6ZqkhrXVKtDNCVBVK175NAn
         KJENhhEocpqmcKpw3LWCEgLiaCnLMXhb4tuks9jTyYGnhCJren70ypABbEbaf7rNTwWk
         np9B7tN+ghbhPSo4Y9rNlQLaYr4Lmk+aX4sDtB2sobrDMLsN/11oqDGFMKLvi5KpBGaM
         qf8NFIIaPWezbdhHBER9z2sZJzBegtExzbNt+pP0dzt2ddGICSoTQT0pSjlLIO7O2IkB
         nXdLmPWXCjmA42AVyYZLdRDks76rsUHYxJwY515zBUhZKTqqr5LkqZebVkhHEJEctTdE
         u/Fw==
X-Gm-Message-State: AC+VfDy7qi8dtu9K5jr2rPBbl5Fp0TQya4th3rcsj7J+fKe0p7kLNgU5
	y1ghtGE6Bwt+noLPOXpZER3e7dqroiXWOVLlDTA=
X-Google-Smtp-Source: ACHHUZ6MSlZSUBJ7jK8dNn1+qgg/5eQIdn3PnAIJcH3h4cph3bS/FZh79sWhLGzodJ7QDUCrTogd4D4XR+i9MdsUl5A=
X-Received: by 2002:ad4:5bcf:0:b0:635:f201:f714 with SMTP id
 t15-20020ad45bcf000000b00635f201f714mr6666026qvt.34.1688010453041; Wed, 28
 Jun 2023 20:47:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230628115205.248395-1-laoar.shao@gmail.com> <20230628115205.248395-2-laoar.shao@gmail.com>
 <CALOAHbCreRRkLwt0Vyp9rUbL7JVzD5A4CET=jKoUJwAHXPop7g@mail.gmail.com> <CAADnVQK7kriNBmRZ04PvoYbL02acJkLiNWNa7j4bN3oh4M+Png@mail.gmail.com>
In-Reply-To: <CAADnVQK7kriNBmRZ04PvoYbL02acJkLiNWNa7j4bN3oh4M+Png@mail.gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Thu, 29 Jun 2023 11:46:57 +0800
Message-ID: <CALOAHbA-svPRA0Kcp7266xK_5ytP6i9g3V09ZUeVHDdOEUPZUA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Fix an error around PTR_UNTRUSTED
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
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

On Thu, Jun 29, 2023 at 11:35=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Jun 28, 2023 at 8:12=E2=80=AFPM Yafang Shao <laoar.shao@gmail.com=
> wrote:
> >
> > On Wed, Jun 28, 2023 at 7:52=E2=80=AFPM Yafang Shao <laoar.shao@gmail.c=
om> wrote:
> > >
> > > Per discussion with Alexei, the PTR_UNTRUSTED flag should not been
> > > cleared when we start to walk a new struct, because the struct in
> > > question may be a struct nested in a union. We should also check and =
set
> > > this flag before we walk its each member, in case itself is a union.
> > >
> > > Fixes: 6fcd486b3a0a ("bpf: Refactor RCU enforcement in the verifier."=
)
> > > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > > ---
> > >  kernel/bpf/btf.c | 20 +++++++++-----------
> > >  1 file changed, 9 insertions(+), 11 deletions(-)
> > >
> > > diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> > > index 29fe21099298..e0a493230727 100644
> > > --- a/kernel/bpf/btf.c
> > > +++ b/kernel/bpf/btf.c
> > > @@ -6133,7 +6133,6 @@ static int btf_struct_walk(struct bpf_verifier_=
log *log, const struct btf *btf,
> > >         const char *tname, *mname, *tag_value;
> > >         u32 vlen, elem_id, mid;
> > >
> > > -       *flag =3D 0;
> > >  again:
> > >         tname =3D __btf_name_by_offset(btf, t->name_off);
> > >         if (!btf_type_is_struct(t)) {
> > > @@ -6142,6 +6141,14 @@ static int btf_struct_walk(struct bpf_verifier=
_log *log, const struct btf *btf,
> > >         }
> > >
> > >         vlen =3D btf_type_vlen(t);
> > > +       if (BTF_INFO_KIND(t->info) =3D=3D BTF_KIND_UNION && vlen !=3D=
 1)
> > > +               /*
> > > +                * walking unions yields untrusted pointers
> > > +                * with exception of __bpf_md_ptr and other
> > > +                * unions with a single member
> > > +                */
> > > +               *flag |=3D PTR_UNTRUSTED;
> > > +
> > >         if (off + size > t->size) {
> > >                 /* If the last element is a variable size array, we m=
ay
> > >                  * need to relax the rule.
> > > @@ -6302,15 +6309,6 @@ static int btf_struct_walk(struct bpf_verifier=
_log *log, const struct btf *btf,
> > >                  * of this field or inside of this struct
> > >                  */
> > >                 if (btf_type_is_struct(mtype)) {
> > > -                       if (BTF_INFO_KIND(mtype->info) =3D=3D BTF_KIN=
D_UNION &&
> > > -                           btf_type_vlen(mtype) !=3D 1)
> > > -                               /*
> > > -                                * walking unions yields untrusted po=
inters
> > > -                                * with exception of __bpf_md_ptr and=
 other
> > > -                                * unions with a single member
> > > -                                */
> > > -                               *flag |=3D PTR_UNTRUSTED;
> > > -
> > >                         /* our field must be inside that union or str=
uct */
> > >                         t =3D mtype;
> > >
> > > @@ -6476,7 +6474,7 @@ bool btf_struct_ids_match(struct bpf_verifier_l=
og *log,
> > >                           bool strict)
> > >  {
> > >         const struct btf_type *type;
> > > -       enum bpf_type_flag flag;
> > > +       enum bpf_type_flag flag =3D 0;
> > >         int err;
> > >
> > >         /* Are we already done? */
> > > --
> > > 2.39.3
> > >
> >
> > Just noticed that it breaks test_sk_storage_tracing, because skb->sk
> > is in a union:
> >    struct sk_buff {
> >        ...
> >        union {
> >            struct sock             *sk;
> >            int                     ip_defrag_offset;
> >        };
> >        ...
> >    };
> >
> > I will think about it.
>
> It can be whitelisted similar to BTF_TYPE_SAFE_*.

Got it.

> Please add a selftest for the new feature.

Sure, will add it.

--=20
Regards
Yafang

