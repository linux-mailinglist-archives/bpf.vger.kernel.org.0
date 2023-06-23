Return-Path: <bpf+bounces-3283-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E924373BBC9
	for <lists+bpf@lfdr.de>; Fri, 23 Jun 2023 17:36:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A774B281C31
	for <lists+bpf@lfdr.de>; Fri, 23 Jun 2023 15:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D572C2FD;
	Fri, 23 Jun 2023 15:36:13 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D08C2CB
	for <bpf@vger.kernel.org>; Fri, 23 Jun 2023 15:36:13 +0000 (UTC)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D5832122
	for <bpf@vger.kernel.org>; Fri, 23 Jun 2023 08:36:08 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-51bde6a8c20so827795a12.0
        for <bpf@vger.kernel.org>; Fri, 23 Jun 2023 08:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687534567; x=1690126567;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lRqxa9sF3sSbLzhznpLy4M87eUMpQ5HrnIrH5zNuvz0=;
        b=So0R3NszF/LZ8e8rDvdrlFTg+0tUF6v0pt+ZDTLnGcQ5G3KM+uXaF3VXPHFyfX8G54
         d/YKc6AQyosmh1OTu9wSLgGpyrFgKFX0Okk9ePspbuDwoYTtMNBh1BaErK6pGgdfy4bW
         nR8y6bVS9DBh2rOIxrbr09T/+q0TW0rqwVfadGu9nVp5IlE4YdOzj3ZEfdXHJxzOxkc3
         5oaY8E41fxUrOgDVJ+uSwX29h/0lxXKLKdYGlYz/lLbcVZilTm6EBsiK2yHCyDX2SOv0
         ZscgkBHunbrpSdT95uYP0Vac7ok/8Sn58C7F/yEMUWeLqK/U/FDLCajePxJHyFp3JlgR
         dLUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687534567; x=1690126567;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lRqxa9sF3sSbLzhznpLy4M87eUMpQ5HrnIrH5zNuvz0=;
        b=lSNKQsDJggM3Vcs4oxc8lxRmWbxoCEbmKJOR/V/rpZb1ICoWeETnS8sSamgQk/WPdj
         AOqa64jpMI5FqVqTMLLOsrSI47qqovcFBRHGj9qzy4T09A+JRRz2mWJK6sssVKbUn+18
         nuTOTmPnOa4achFuxMgeHHL15cP1woejoB9zbz6mEQZtNiPzLHi1KAdIdE4OKX6HXfWe
         4ouX3IoU4NlWQTetTpDCDYcegtFlieN6k2D0Kb8or4U3VWZ2GagYXe91jmm0Ssg0mnE+
         rDPVMtNLcDbfzZM/7pT0eQuuWrvWhDiW8wYOVAY8iqVRDbAwtppD4xis61/TT+IJJiWI
         6ucw==
X-Gm-Message-State: AC+VfDx+jZK8Zt1qjelWLatmeW6QUsJ9Bv7F3xdei4hxN3b+CzsSG7Rk
	kkLZtJAPKFVnWkmPU01fHNVDkE03rsN06m+uJN4=
X-Google-Smtp-Source: ACHHUZ6FOMR0xmvwrgdl6LwhgpcKwQKiLVxZ1ybZOufWYpKms5kk6o7EUmzjFx+OnHzs3I2P7HJyOv//QrJIpuRzaN0=
X-Received: by 2002:a05:6402:4cf:b0:514:a4cd:85d7 with SMTP id
 n15-20020a05640204cf00b00514a4cd85d7mr13639564edw.26.1687534566716; Fri, 23
 Jun 2023 08:36:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230621120012.3883-1-laoar.shao@gmail.com> <CAADnVQJizR0kMaQxKvs8tgvedPVExcHNFgDde28M7TgtzeEjkw@mail.gmail.com>
 <CALOAHbAjVotSPDP9r90yAxFn0XzaVJgkvSSL-X9WTtjcd6VDXw@mail.gmail.com>
In-Reply-To: <CALOAHbAjVotSPDP9r90yAxFn0XzaVJgkvSSL-X9WTtjcd6VDXw@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 23 Jun 2023 08:35:55 -0700
Message-ID: <CAADnVQL+SXd7RfPBii5M8mN9bO8bgpUHKH4haHdza+DgV+bq8w@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next] bpf: Fix an error in verifying a field in a union
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

On Fri, Jun 23, 2023 at 3:11=E2=80=AFAM Yafang Shao <laoar.shao@gmail.com> =
wrote:
>
> On Fri, Jun 23, 2023 at 7:42=E2=80=AFAM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Wed, Jun 21, 2023 at 5:00=E2=80=AFAM Yafang Shao <laoar.shao@gmail.c=
om> wrote:
> > >
> > > We are utilizing BPF LSM to monitor BPF operations within our contain=
er
> > > environment. When we add support for raw_tracepoint, it hits below
> > > error.
> > >
> > > ; (const void *)attr->raw_tracepoint.name);
> > > 27: (79) r3 =3D *(u64 *)(r2 +0)
> > > access beyond the end of member map_type (mend:4) in struct (anon) wi=
th off 0 size 8
> > >
> > > It can be reproduced with below BPF prog.
> > >
> > > SEC("lsm/bpf")
> > > int BPF_PROG(bpf_audit, int cmd, union bpf_attr *attr, unsigned int s=
ize)
> > > {
> > >         switch (cmd) {
> > >         case BPF_RAW_TRACEPOINT_OPEN:
> > >                 bpf_printk("raw_tracepoint is %s", attr->raw_tracepoi=
nt.name);
> > >                 break;
> > >         default:
> > >                 break;
> > >         }
> > >         return 0;
> > > }
> > >
> > > The reason is that when accessing a field in a union, such as bpf_att=
r, if
> > > the field is located within a nested struct that is not the first mem=
ber of
> > > the union, it can result in incorrect field verification.
> > >
> > >   union bpf_attr {
> > >       struct {
> > >           __u32 map_type; <<<< Actually it will find that field.
> > >           __u32 key_size;
> > >           __u32 value_size;
> > >          ...
> > >       };
> > >       ...
> > >       struct {
> > >           __u64 name;    <<<< We want to verify this field.
> > >           __u32 prog_fd;
> > >       } raw_tracepoint;
> > >   };
> > >
> > > Considering the potential deep nesting levels, finding a perfect solu=
tion
> > > to address this issue has proven challenging. Therefore, I propose a
> > > solution where we simply skip the verification process if the field i=
n
> > > question is located within a union.
> > >
> > > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > > ---
> > >  kernel/bpf/btf.c | 13 +++++++++----
> > >  1 file changed, 9 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> > > index bd2cac057928..79ee4506bba4 100644
> > > --- a/kernel/bpf/btf.c
> > > +++ b/kernel/bpf/btf.c
> > > @@ -6129,7 +6129,7 @@ enum bpf_struct_walk_result {
> > >  static int btf_struct_walk(struct bpf_verifier_log *log, const struc=
t btf *btf,
> > >                            const struct btf_type *t, int off, int siz=
e,
> > >                            u32 *next_btf_id, enum bpf_type_flag *flag=
,
> > > -                          const char **field_name)
> > > +                          const char **field_name, bool *in_union)
> > >  {
> > >         u32 i, moff, mtrue_end, msize =3D 0, total_nelems =3D 0;
> > >         const struct btf_type *mtype, *elem_type =3D NULL;
> > > @@ -6188,6 +6188,8 @@ static int btf_struct_walk(struct bpf_verifier_=
log *log, const struct btf *btf,
> > >                 return -EACCES;
> > >         }
> > >
> > > +       if (BTF_INFO_KIND(t->info) =3D=3D BTF_KIND_UNION && !in_union=
)
> > > +               *in_union =3D true;
> > >         for_each_member(i, t, member) {
> > >                 /* offset of the field in bytes */
> > >                 moff =3D __btf_member_bit_offset(t, member) / 8;
> > > @@ -6372,7 +6374,7 @@ static int btf_struct_walk(struct bpf_verifier_=
log *log, const struct btf *btf,
> > >                  * that also allows using an array of int as a scratc=
h
> > >                  * space. e.g. skb->cb[].
> > >                  */
> > > -               if (off + size > mtrue_end) {
> > > +               if (off + size > mtrue_end && !in_union) {
> >
> > Just allow it for (flag & PTR_UNTRUSTED).
> > We set it when we start walking BTF_KIND_UNION.
> > No need for extra bool.
>
> It seems we can't check the flag, because it clears the flag when it
> enters btf_struct_walk()[1].
> We only set it when we find a nested union, but we don't set this flag
> when the btf_type itself is a union. So that can't apply to `union
> bpf_attr`.

We should fix it then. untrusted state shouldn't be cleared.

