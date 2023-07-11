Return-Path: <bpf+bounces-4769-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79C0D74F1F8
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 16:23:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AABB91C20ED3
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 14:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D98619BBB;
	Tue, 11 Jul 2023 14:23:02 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BD1A14AB5
	for <bpf@vger.kernel.org>; Tue, 11 Jul 2023 14:23:02 +0000 (UTC)
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B414171B
	for <bpf@vger.kernel.org>; Tue, 11 Jul 2023 07:22:44 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id af79cd13be357-76731802203so528233585a.3
        for <bpf@vger.kernel.org>; Tue, 11 Jul 2023 07:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689085352; x=1691677352;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ic9pAOzgYf8SN+nFTcTDWvREDTXklpxiB+zl6dn5evY=;
        b=p5YIPuAexYvKVb1aLcxtWz3UTZetIhZKoVgoxhCv6G+zCjIl+fEyJwhmWmXF5OxBPW
         mWxzEVoi8wLShGCJaW3XC5hnBobuBRjUBNiB9jm01ddsvPq3/7Z///ksxwnUkP82IuAg
         njpnFNPN3/qLS9KNPboLAa60fWuxHtVmWRp7uA7cs6wh2tHDGy5fbgPpb7efSU2cYw/6
         alarJ7b3xk/YmHWTpNHdc9WaMMolJX3aGzChESNwkhlUaTwkL9/xDsVEOCP3cwqhhsWO
         WAnJvz8r4gdc+SE6FKih2Sg2W0gH3NyONQHEnyVwb9Z4tgAxMU6gItwrM8yDeEfIm8rk
         ItPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689085352; x=1691677352;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ic9pAOzgYf8SN+nFTcTDWvREDTXklpxiB+zl6dn5evY=;
        b=kTZr4aQfewEvdkRNfuAEMfGlyGjHelYqz3JORXN370/fjeRCiRfDTsoHjN+aLFCZTD
         MDfqfgYL2Wsqajyhi/Ub28Z9RJGzCx+E7EtlczEf+ubwbzzfOaxqlmlgV7YOjnOS/msG
         X0CPCzVxrNwoxwV+zDxjwlmgW8tapjLCzex8mw2EYmo5arsQiwrTC8oYjbeR04jcedM7
         i0uOYM2YcfCVcHP2u/l+hHdVQfqcbmM7dWuVVSe+wkkDTxZCnX+8likXYaJ71OfWkAnc
         fx08T6pQQWJ0kos4epTVBk85ISECyvjCRF1E9R7k4VfHr36whZTrEt+EYaogj/j/jvKD
         r4tw==
X-Gm-Message-State: ABy/qLbTblpFDT/2qKwfwG5Z1bVIBTD27DlvBnEqF/yV9DRda8nf7OlY
	JI++Ryd2fsIVCUkq4pKrN/29eLKsIFwqsVrgN/ShrQbKD18=
X-Google-Smtp-Source: APBJJlGZkVfOxDedex8lTwsb+v03NtUhJrmErcuDtuuqHDpaUawU3pBOuUJZhKoRmkfFb2qkXeEVGHeGAdb7WmnNVVw=
X-Received: by 2002:a0c:e345:0:b0:636:64e8:a3a6 with SMTP id
 a5-20020a0ce345000000b0063664e8a3a6mr14098365qvm.62.1689085352141; Tue, 11
 Jul 2023 07:22:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230709025912.3837-1-laoar.shao@gmail.com> <20230709025912.3837-2-laoar.shao@gmail.com>
 <CAADnVQKQzxUGz3Mhr5kQi2Zao7CKryCPG2JWj2dGn07UDM=oeA@mail.gmail.com>
In-Reply-To: <CAADnVQKQzxUGz3Mhr5kQi2Zao7CKryCPG2JWj2dGn07UDM=oeA@mail.gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Tue, 11 Jul 2023 22:21:56 +0800
Message-ID: <CALOAHbDoLzC5OtnQM3pRDMewo4yApLTTqppb2VDgR4043r2V8Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/3] bpf: Introduce BTF_TYPE_SAFE_TRUSTED_UNION
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jul 11, 2023 at 10:56=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Sat, Jul 8, 2023 at 7:59=E2=80=AFPM Yafang Shao <laoar.shao@gmail.com>=
 wrote:
> >
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
> >         const char *tname, *mname, *tag_value;
> >         u32 vlen, elem_id, mid;
> >
> > -       *flag =3D 0;
> >  again:
> >         if (btf_type_is_modifier(t))
> >                 t =3D btf_type_skip_modifiers(btf, t->type, NULL);
> > @@ -6144,6 +6143,14 @@ static int btf_struct_walk(struct bpf_verifier_l=
og *log, const struct btf *btf,
> >         }
> >
> >         vlen =3D btf_type_vlen(t);
> > +       if (BTF_INFO_KIND(t->info) =3D=3D BTF_KIND_UNION && vlen !=3D 1=
 && !(*flag & PTR_UNTRUSTED))
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
> > @@ -6304,15 +6311,6 @@ static int btf_struct_walk(struct bpf_verifier_l=
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
> > @@ -6478,7 +6476,7 @@ bool btf_struct_ids_match(struct bpf_verifier_log=
 *log,
> >                           bool strict)
> >  {
> >         const struct btf_type *type;
> > -       enum bpf_type_flag flag;
> > +       enum bpf_type_flag flag =3D 0;
> >         int err;
> >
> >         /* Are we already done? */
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
> >         struct sock *sk;
> >  };
> >
> > +/* union trusted: these fields are trusted even in a uion */
> > +BTF_TYPE_SAFE_TRUSTED_UNION(struct sk_buff) {
> > +       struct sock *sk;
> > +};
>
> Why is this needed?

Will discard it.

> We already have:
> BTF_TYPE_SAFE_RCU_OR_NULL(struct sk_buff) {
>         struct sock *sk;
> };
>
> > +       /* Clear the PTR_UNTRUSTED for the fields which are in the allo=
w list */
> > +       if (type_is_trusted_union(env, reg, field_name, btf_id))
> > +               flag &=3D ~PTR_UNTRUSTED;
>
> we cannot do this unconditionally.
> The type_is_rcu_or_null() check applies only after
>  in_rcu_cs(env) && !type_may_be_null(reg->type)).

Thanks for the explanation. Will change it.

--=20
Regards
Yafang

