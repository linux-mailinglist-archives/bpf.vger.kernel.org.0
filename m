Return-Path: <bpf+bounces-4767-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 088A874F1CC
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 16:22:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 385FB1C20F66
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 14:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD8EE19BB9;
	Tue, 11 Jul 2023 14:21:56 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F78119BAC
	for <bpf@vger.kernel.org>; Tue, 11 Jul 2023 14:21:56 +0000 (UTC)
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B15F10CA
	for <bpf@vger.kernel.org>; Tue, 11 Jul 2023 07:21:36 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id 6a1803df08f44-635eb5b0320so39332876d6.3
        for <bpf@vger.kernel.org>; Tue, 11 Jul 2023 07:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689085290; x=1691677290;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=glIfDWVQn7vX0FaCCraG21MUbCWXgRacZ/OFue34UN8=;
        b=hXRf5DuMnAHAfI9GQHYzgH7OZXQgcm6rhvOS1HB+DLyqfwoamYkHrrlaTfJzPqvBG+
         UHcIQiN+C8wn4SGt3rrJrrXKDPkeKQ4aPRmjGUhkLqQH2CqPjHhJINX3o2/mWNHzo/iv
         RjRiThaE1serQc3nb/dXQWOQ9umIeAzB6m/WxRHyq4RAKxQ4jwVo3u3GZItdmkTKHc2i
         FTAhKSMEiTNqwBa43RX1lf8npjEkly/jSmIjYXs7MVD4nRm8dGKDIwzfKqP2wYJNNMiz
         AiJeGz418lBztBdZFPXUtILlZe0ozYIFCQagcLkbXpglpXZ3/3OlXFiFmcc3fd8sBgIm
         XanQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689085290; x=1691677290;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=glIfDWVQn7vX0FaCCraG21MUbCWXgRacZ/OFue34UN8=;
        b=ZfhHAx+jlU+BEGMK+EDWNcMhnPhsFJeAPO9Cq69N77QOiSqKAvdbxVfOnv/Tom5Y8G
         nzIReBjIIfYHDtBD/oFOy6i5KsW6BXIGxloeLaAtnz8uKfRdaY1/e63wuigT7GWPCk2B
         htab2WiphVquUDIHtMa/npqsDZ8s+zyrtZEStGkB/Wg7pPn5K4o6Ol69E3xEILCCmjRg
         yH+d9PP0JAQogcCaTlZiWmGfVo7xkT1+M6CFHlC7b8QgVxGPwheercp+FghNbWAI4quL
         qmXlPmSbLm97AbT+L1R0ID6/2YIKIN42uNbEACLBDL1cQ/vmp5gTr5pdZoEMmvuNc7EJ
         rntg==
X-Gm-Message-State: ABy/qLawsjc2pMc7faYWBUwp+ynhr/QWT7aHlNmJ9idj3mOERQP2T9cH
	otkdNrhJHK9M+5UxOvrp13Nw9GUWkGlUzxCJrP1PZo1HDzI=
X-Google-Smtp-Source: APBJJlErPcuN7m/xWbEvEVkjLrNF58NjMHRhjN0G6WkfHeVpu0GGwVTGRfoH3SKRkYiv8Wyn9zeh6k3ODgGTvhLNFhw=
X-Received: by 2002:a0c:f481:0:b0:630:21a6:bb5e with SMTP id
 i1-20020a0cf481000000b0063021a6bb5emr14346490qvm.30.1689085290106; Tue, 11
 Jul 2023 07:21:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230709025912.3837-1-laoar.shao@gmail.com> <20230709025912.3837-2-laoar.shao@gmail.com>
 <ZKw5CdD/TMnPHFQC@google.com>
In-Reply-To: <ZKw5CdD/TMnPHFQC@google.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Tue, 11 Jul 2023 22:20:54 +0800
Message-ID: <CALOAHbC-xD5nbpongrGsA1dU_c10vyg7-1jDZWzUCF6-x_TSBQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/3] bpf: Introduce BTF_TYPE_SAFE_TRUSTED_UNION
To: Stanislav Fomichev <sdf@google.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yhs@fb.com, 
	kpsingh@kernel.org, haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jul 11, 2023 at 12:59=E2=80=AFAM Stanislav Fomichev <sdf@google.com=
> wrote:
>
> On 07/09, Yafang Shao wrote:
> > When we are verifying a field in a union, we may unexpectedly verify
> > another field which has the same offset in this union. So in such case,
> > we should annotate that field as PTR_UNTRUSTED. However, in some cases
> > we are sure some fields in a union is safe and then we can add them int=
o
> > BTF_TYPE_SAFE_TRUSTED_UNION allow list.
> >
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > ---
> >  kernel/bpf/btf.c      | 20 +++++++++-----------
> >  kernel/bpf/verifier.c | 21 +++++++++++++++++++++
> >  2 files changed, 30 insertions(+), 11 deletions(-)
> >
> > diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> > index 3dd47451f097..fae6fc24a845 100644
> > --- a/kernel/bpf/btf.c
> > +++ b/kernel/bpf/btf.c
> > @@ -6133,7 +6133,6 @@ static int btf_struct_walk(struct bpf_verifier_lo=
g *log, const struct btf *btf,
> >       const char *tname, *mname, *tag_value;
> >       u32 vlen, elem_id, mid;
> >
> > -     *flag =3D 0;
> >  again:
> >       if (btf_type_is_modifier(t))
> >               t =3D btf_type_skip_modifiers(btf, t->type, NULL);
> > @@ -6144,6 +6143,14 @@ static int btf_struct_walk(struct bpf_verifier_l=
og *log, const struct btf *btf,
> >       }
> >
> >       vlen =3D btf_type_vlen(t);
> > +     if (BTF_INFO_KIND(t->info) =3D=3D BTF_KIND_UNION && vlen !=3D 1 &=
& !(*flag & PTR_UNTRUSTED))
> > +             /*
> > +              * walking unions yields untrusted pointers
> > +              * with exception of __bpf_md_ptr and other
> > +              * unions with a single member
> > +              */
> > +             *flag |=3D PTR_UNTRUSTED;
> > +
> >       if (off + size > t->size) {
> >               /* If the last element is a variable size array, we may
> >                * need to relax the rule.
> > @@ -6304,15 +6311,6 @@ static int btf_struct_walk(struct bpf_verifier_l=
og *log, const struct btf *btf,
> >                * of this field or inside of this struct
> >                */
> >               if (btf_type_is_struct(mtype)) {
> > -                     if (BTF_INFO_KIND(mtype->info) =3D=3D BTF_KIND_UN=
ION &&
> > -                         btf_type_vlen(mtype) !=3D 1)
> > -                             /*
> > -                              * walking unions yields untrusted pointe=
rs
> > -                              * with exception of __bpf_md_ptr and oth=
er
> > -                              * unions with a single member
> > -                              */
> > -                             *flag |=3D PTR_UNTRUSTED;
> > -
> >                       /* our field must be inside that union or struct =
*/
> >                       t =3D mtype;
> >
> > @@ -6478,7 +6476,7 @@ bool btf_struct_ids_match(struct bpf_verifier_log=
 *log,
> >                         bool strict)
> >  {
> >       const struct btf_type *type;
> > -     enum bpf_type_flag flag;
> > +     enum bpf_type_flag flag =3D 0;
> >       int err;
> >
> >       /* Are we already done? */
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 11e54dd8b6dd..1fb0a64f5bce 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -5847,6 +5847,7 @@ static int bpf_map_direct_read(struct bpf_map *ma=
p, int off, int size, u64 *val)
> >  #define BTF_TYPE_SAFE_RCU(__type)  __PASTE(__type, __safe_rcu)
> >  #define BTF_TYPE_SAFE_RCU_OR_NULL(__type)  __PASTE(__type, __safe_rcu_=
or_null)
> >  #define BTF_TYPE_SAFE_TRUSTED(__type)  __PASTE(__type, __safe_trusted)
> > +#define BTF_TYPE_SAFE_TRUSTED_UNION(__type)  __PASTE(__type, __safe_tr=
usted_union)
> >
> >  /*
> >   * Allow list few fields as RCU trusted or full trusted.
> > @@ -5914,6 +5915,11 @@ BTF_TYPE_SAFE_TRUSTED(struct socket) {
> >       struct sock *sk;
> >  };
> >
>
>
> [..]
>
> > +/* union trusted: these fields are trusted even in a uion */
> > +BTF_TYPE_SAFE_TRUSTED_UNION(struct sk_buff) {
> > +     struct sock *sk;
> > +};
>
> Does it say that sk member of sk_buff is always dereferencable?
> Why is it universally safe?
> In general, I don't really understand why it's safe to statically
> mark the members this way. Shouldn't it depend on the context?

Right. It should depend on the context. Will change it.

--=20
Regards
Yafang

