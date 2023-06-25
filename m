Return-Path: <bpf+bounces-3398-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D533C73D176
	for <lists+bpf@lfdr.de>; Sun, 25 Jun 2023 16:29:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72C3F280F69
	for <lists+bpf@lfdr.de>; Sun, 25 Jun 2023 14:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BD9863A6;
	Sun, 25 Jun 2023 14:29:18 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562DB6117
	for <bpf@vger.kernel.org>; Sun, 25 Jun 2023 14:29:18 +0000 (UTC)
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA169C9
	for <bpf@vger.kernel.org>; Sun, 25 Jun 2023 07:29:16 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id 6a1803df08f44-62fff19e8fdso16221456d6.1
        for <bpf@vger.kernel.org>; Sun, 25 Jun 2023 07:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687703356; x=1690295356;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3OMAx9JPDl9Ka1+GNK552lqQ2g9YjiCEcp2ZD8EDCn8=;
        b=jDYkAhxicCQG/UDl0STmQg7U+zoHIDBlkxiWo5bejOJQSrEWNm1S+iYJqQY/hFHrEQ
         x+OIRKeED9tyPvJd6uZ168mnGbEQbsq8/PdJZID7wPsiwLYdbBR2UfBZu9n3pceL8PUe
         OcanltVh3NXRhhm9qZvxjKC8A6Qv1X0zdUe4o2yxbFEX0RTFCBgquneWMq/kO8vueH1+
         jtE9MVOGQitx2J19VAtzNtSK3JRTSjd8I9Nm/C04tQTTZnKELdCNwtjCjbci1YszGKj+
         kECgjxZe04PsyGjFlNLAB0+HJ2lmx1Tsjxq7H7f+quMCPKSIoEu//6EquS/1UugvsTsb
         anwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687703356; x=1690295356;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3OMAx9JPDl9Ka1+GNK552lqQ2g9YjiCEcp2ZD8EDCn8=;
        b=U9DuMS7mJCH3AmAMHxy2t0HAuOWWBsykJ6CyBRq25E7zNLkC0qMPYfexjsPvUPLEsI
         OHof+UTWXgEXs5V827TPRHy40ieqd+8nuo5uzXV8FmbRWtNhhoMnJDqwizNV07QnrKhC
         dA7JQHgpZODrA+cev+68KS+6fmHP7fJDa6+rSQPseEE3Ib2ed8RAJdOuVHRv5RqdEZ1C
         NsHsQdIdyGcPApmFeAuk5IVgYHU/OptoWTzq8ybbVyLYOdl/GsNUJkl+9dJ9IPVw+uY1
         yTBfDvzqexzx0sqc6x3KbpYqVdX+Gbvqct9l5aBCvsOPE8Y4w5PHi3Y9dOq9lRINrAWs
         hvyA==
X-Gm-Message-State: AC+VfDyUFNrvL6kh/5vdpzsMgax3Cq5c/gPnHNigWRZuu26uhq0xS0Z0
	QIjinMsZ/3HRF8MquVNiq3tezV4rPjzb7SMn9XU=
X-Google-Smtp-Source: ACHHUZ53xCFE5md1mz17d5r44nGx+HrUgoF3TFVaqu0bj7bDeHmjgem/aASnOmiidmXAdtEqNLuxdlWJROvsOKYIFZ0=
X-Received: by 2002:ad4:5be3:0:b0:616:7977:2460 with SMTP id
 k3-20020ad45be3000000b0061679772460mr28651696qvc.24.1687703355766; Sun, 25
 Jun 2023 07:29:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230621120012.3883-1-laoar.shao@gmail.com> <CAADnVQJizR0kMaQxKvs8tgvedPVExcHNFgDde28M7TgtzeEjkw@mail.gmail.com>
 <CALOAHbAjVotSPDP9r90yAxFn0XzaVJgkvSSL-X9WTtjcd6VDXw@mail.gmail.com> <CAADnVQL+SXd7RfPBii5M8mN9bO8bgpUHKH4haHdza+DgV+bq8w@mail.gmail.com>
In-Reply-To: <CAADnVQL+SXd7RfPBii5M8mN9bO8bgpUHKH4haHdza+DgV+bq8w@mail.gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Sun, 25 Jun 2023 22:28:39 +0800
Message-ID: <CALOAHbBYqMXfxt6658baPyfpoGd4L_d0E7bDpLk73972S7JfLQ@mail.gmail.com>
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

On Fri, Jun 23, 2023 at 11:36=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Jun 23, 2023 at 3:11=E2=80=AFAM Yafang Shao <laoar.shao@gmail.com=
> wrote:
> >
> > On Fri, Jun 23, 2023 at 7:42=E2=80=AFAM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Wed, Jun 21, 2023 at 5:00=E2=80=AFAM Yafang Shao <laoar.shao@gmail=
.com> wrote:
> > > >
> > > > We are utilizing BPF LSM to monitor BPF operations within our conta=
iner
> > > > environment. When we add support for raw_tracepoint, it hits below
> > > > error.
> > > >
> > > > ; (const void *)attr->raw_tracepoint.name);
> > > > 27: (79) r3 =3D *(u64 *)(r2 +0)
> > > > access beyond the end of member map_type (mend:4) in struct (anon) =
with off 0 size 8
> > > >
> > > > It can be reproduced with below BPF prog.
> > > >
> > > > SEC("lsm/bpf")
> > > > int BPF_PROG(bpf_audit, int cmd, union bpf_attr *attr, unsigned int=
 size)
> > > > {
> > > >         switch (cmd) {
> > > >         case BPF_RAW_TRACEPOINT_OPEN:
> > > >                 bpf_printk("raw_tracepoint is %s", attr->raw_tracep=
oint.name);
> > > >                 break;
> > > >         default:
> > > >                 break;
> > > >         }
> > > >         return 0;
> > > > }
> > > >
> > > > The reason is that when accessing a field in a union, such as bpf_a=
ttr, if
> > > > the field is located within a nested struct that is not the first m=
ember of
> > > > the union, it can result in incorrect field verification.
> > > >
> > > >   union bpf_attr {
> > > >       struct {
> > > >           __u32 map_type; <<<< Actually it will find that field.
> > > >           __u32 key_size;
> > > >           __u32 value_size;
> > > >          ...
> > > >       };
> > > >       ...
> > > >       struct {
> > > >           __u64 name;    <<<< We want to verify this field.
> > > >           __u32 prog_fd;
> > > >       } raw_tracepoint;
> > > >   };
> > > >
> > > > Considering the potential deep nesting levels, finding a perfect so=
lution
> > > > to address this issue has proven challenging. Therefore, I propose =
a
> > > > solution where we simply skip the verification process if the field=
 in
> > > > question is located within a union.
> > > >
> > > > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > > > ---
> > > >  kernel/bpf/btf.c | 13 +++++++++----
> > > >  1 file changed, 9 insertions(+), 4 deletions(-)
> > > >
> > > > diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> > > > index bd2cac057928..79ee4506bba4 100644
> > > > --- a/kernel/bpf/btf.c
> > > > +++ b/kernel/bpf/btf.c
> > > > @@ -6129,7 +6129,7 @@ enum bpf_struct_walk_result {
> > > >  static int btf_struct_walk(struct bpf_verifier_log *log, const str=
uct btf *btf,
> > > >                            const struct btf_type *t, int off, int s=
ize,
> > > >                            u32 *next_btf_id, enum bpf_type_flag *fl=
ag,
> > > > -                          const char **field_name)
> > > > +                          const char **field_name, bool *in_union)
> > > >  {
> > > >         u32 i, moff, mtrue_end, msize =3D 0, total_nelems =3D 0;
> > > >         const struct btf_type *mtype, *elem_type =3D NULL;
> > > > @@ -6188,6 +6188,8 @@ static int btf_struct_walk(struct bpf_verifie=
r_log *log, const struct btf *btf,
> > > >                 return -EACCES;
> > > >         }
> > > >
> > > > +       if (BTF_INFO_KIND(t->info) =3D=3D BTF_KIND_UNION && !in_uni=
on)
> > > > +               *in_union =3D true;
> > > >         for_each_member(i, t, member) {
> > > >                 /* offset of the field in bytes */
> > > >                 moff =3D __btf_member_bit_offset(t, member) / 8;
> > > > @@ -6372,7 +6374,7 @@ static int btf_struct_walk(struct bpf_verifie=
r_log *log, const struct btf *btf,
> > > >                  * that also allows using an array of int as a scra=
tch
> > > >                  * space. e.g. skb->cb[].
> > > >                  */
> > > > -               if (off + size > mtrue_end) {
> > > > +               if (off + size > mtrue_end && !in_union) {
> > >
> > > Just allow it for (flag & PTR_UNTRUSTED).
> > > We set it when we start walking BTF_KIND_UNION.
> > > No need for extra bool.
> >
> > It seems we can't check the flag, because it clears the flag when it
> > enters btf_struct_walk()[1].
> > We only set it when we find a nested union, but we don't set this flag
> > when the btf_type itself is a union. So that can't apply to `union
> > bpf_attr`.
>
> We should fix it then. untrusted state shouldn't be cleared.

Got it. Will fix it.

--=20
Regards
Yafang

