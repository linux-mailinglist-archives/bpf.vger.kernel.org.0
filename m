Return-Path: <bpf+bounces-3247-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C47B473B4F3
	for <lists+bpf@lfdr.de>; Fri, 23 Jun 2023 12:13:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D29F281AF2
	for <lists+bpf@lfdr.de>; Fri, 23 Jun 2023 10:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4024C6119;
	Fri, 23 Jun 2023 10:11:49 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3878F47
	for <bpf@vger.kernel.org>; Fri, 23 Jun 2023 10:11:48 +0000 (UTC)
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BDC2449E
	for <bpf@vger.kernel.org>; Fri, 23 Jun 2023 03:11:21 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id af79cd13be357-76246351f0cso38989285a.1
        for <bpf@vger.kernel.org>; Fri, 23 Jun 2023 03:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687515060; x=1690107060;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9P/n3MhrSfoNR3/6mU+dwnY9YqLdGf1sUb14ysI8UbM=;
        b=WzeqLwy5cf2p4wtJSvkcYxB0ezugdZfOzx9EhbYlTZeaaA/hMgIYQNQP9sTronghyG
         mUrD0rmiEk/0zbXOIP8prewEVs9vnqsq18a+So3tDIWHpBDdKTP76q29HGKiQKqxxPmN
         9hJdXnmg05uXDi8oNYFtTquJb7RghIzblDDIgweyR1+gKhbJrBTrLsR2ZSLbCzv7cwj8
         KKr7YHmmRYJ5hVRCpGlChWVVgCSGk7rASV9U4mJQ6vnAtFHcqYD2aaho4SADBmQkhKk+
         TmIVgQ51leFAPnus3t4dGkRlR0rgbEoLEc3ocXq/kPPyla/lJbZnYtJiFEN4b/BRWam4
         HpLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687515060; x=1690107060;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9P/n3MhrSfoNR3/6mU+dwnY9YqLdGf1sUb14ysI8UbM=;
        b=HOnxZgW3uQ/pXCLAfKOmddKA6p2ZlOaU05lqVYYj3lJZ6/3P4oYWQthM9bA5W3kJX5
         OvPDVAIgWTRmmDHp3BJD4rjGheMHXp/SNbUnnabJaJj8xdrq0Y4Xn4TBewuDsQaoHRb/
         QFfPxj0NNuv7knoMaRFVgiZkD4IsOvl4F2MPQjaJZdsZKyHFFRsltmSeIWlJUcT0CKy4
         owKh0dg6WrpMihOFdzAOex27ZOiIVZP9Q3sO+QfZE/SOj82xxRYJFcVssfTFa0wyurgQ
         MwFHp8cFgd9a+jq26V1b3UGxMgM9xSZYdX1yCT5dYxEsTwuXFSV7AguUHRQJ/fAsI3vk
         zCsw==
X-Gm-Message-State: AC+VfDwiSSRV5VmWJEPVu7IEtjWcG/oqH1eG2Kz5V3RkZQO6EsuB05Q0
	qvZWebNO9oAjqDwZBglCxBk1nU2W9Ro7iIChhz8=
X-Google-Smtp-Source: ACHHUZ521FxFEkJfnv16zztFKwHyTrHi2ZyGiC6z2Kd2etwfVuwwv0THZcRv/6DuneO234aGgSCec1L8eTw9cNF+6TY=
X-Received: by 2002:ad4:5ded:0:b0:632:27c1:23fc with SMTP id
 jn13-20020ad45ded000000b0063227c123fcmr4620872qvb.39.1687515059713; Fri, 23
 Jun 2023 03:10:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230621120012.3883-1-laoar.shao@gmail.com> <CAADnVQJizR0kMaQxKvs8tgvedPVExcHNFgDde28M7TgtzeEjkw@mail.gmail.com>
In-Reply-To: <CAADnVQJizR0kMaQxKvs8tgvedPVExcHNFgDde28M7TgtzeEjkw@mail.gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Fri, 23 Jun 2023 18:10:23 +0800
Message-ID: <CALOAHbAjVotSPDP9r90yAxFn0XzaVJgkvSSL-X9WTtjcd6VDXw@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next] bpf: Fix an error in verifying a field in a union
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

On Fri, Jun 23, 2023 at 7:42=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Jun 21, 2023 at 5:00=E2=80=AFAM Yafang Shao <laoar.shao@gmail.com=
> wrote:
> >
> > We are utilizing BPF LSM to monitor BPF operations within our container
> > environment. When we add support for raw_tracepoint, it hits below
> > error.
> >
> > ; (const void *)attr->raw_tracepoint.name);
> > 27: (79) r3 =3D *(u64 *)(r2 +0)
> > access beyond the end of member map_type (mend:4) in struct (anon) with=
 off 0 size 8
> >
> > It can be reproduced with below BPF prog.
> >
> > SEC("lsm/bpf")
> > int BPF_PROG(bpf_audit, int cmd, union bpf_attr *attr, unsigned int siz=
e)
> > {
> >         switch (cmd) {
> >         case BPF_RAW_TRACEPOINT_OPEN:
> >                 bpf_printk("raw_tracepoint is %s", attr->raw_tracepoint=
.name);
> >                 break;
> >         default:
> >                 break;
> >         }
> >         return 0;
> > }
> >
> > The reason is that when accessing a field in a union, such as bpf_attr,=
 if
> > the field is located within a nested struct that is not the first membe=
r of
> > the union, it can result in incorrect field verification.
> >
> >   union bpf_attr {
> >       struct {
> >           __u32 map_type; <<<< Actually it will find that field.
> >           __u32 key_size;
> >           __u32 value_size;
> >          ...
> >       };
> >       ...
> >       struct {
> >           __u64 name;    <<<< We want to verify this field.
> >           __u32 prog_fd;
> >       } raw_tracepoint;
> >   };
> >
> > Considering the potential deep nesting levels, finding a perfect soluti=
on
> > to address this issue has proven challenging. Therefore, I propose a
> > solution where we simply skip the verification process if the field in
> > question is located within a union.
> >
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > ---
> >  kernel/bpf/btf.c | 13 +++++++++----
> >  1 file changed, 9 insertions(+), 4 deletions(-)
> >
> > diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> > index bd2cac057928..79ee4506bba4 100644
> > --- a/kernel/bpf/btf.c
> > +++ b/kernel/bpf/btf.c
> > @@ -6129,7 +6129,7 @@ enum bpf_struct_walk_result {
> >  static int btf_struct_walk(struct bpf_verifier_log *log, const struct =
btf *btf,
> >                            const struct btf_type *t, int off, int size,
> >                            u32 *next_btf_id, enum bpf_type_flag *flag,
> > -                          const char **field_name)
> > +                          const char **field_name, bool *in_union)
> >  {
> >         u32 i, moff, mtrue_end, msize =3D 0, total_nelems =3D 0;
> >         const struct btf_type *mtype, *elem_type =3D NULL;
> > @@ -6188,6 +6188,8 @@ static int btf_struct_walk(struct bpf_verifier_lo=
g *log, const struct btf *btf,
> >                 return -EACCES;
> >         }
> >
> > +       if (BTF_INFO_KIND(t->info) =3D=3D BTF_KIND_UNION && !in_union)
> > +               *in_union =3D true;
> >         for_each_member(i, t, member) {
> >                 /* offset of the field in bytes */
> >                 moff =3D __btf_member_bit_offset(t, member) / 8;
> > @@ -6372,7 +6374,7 @@ static int btf_struct_walk(struct bpf_verifier_lo=
g *log, const struct btf *btf,
> >                  * that also allows using an array of int as a scratch
> >                  * space. e.g. skb->cb[].
> >                  */
> > -               if (off + size > mtrue_end) {
> > +               if (off + size > mtrue_end && !in_union) {
>
> Just allow it for (flag & PTR_UNTRUSTED).
> We set it when we start walking BTF_KIND_UNION.
> No need for extra bool.

It seems we can't check the flag, because it clears the flag when it
enters btf_struct_walk()[1].
We only set it when we find a nested union, but we don't set this flag
when the btf_type itself is a union. So that can't apply to `union
bpf_attr`.

[1]. https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/tree/=
kernel/bpf/btf.c#n6140

--=20
Regards
Yafang

