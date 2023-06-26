Return-Path: <bpf+bounces-3481-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BD2C73E81D
	for <lists+bpf@lfdr.de>; Mon, 26 Jun 2023 20:23:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6EB21C209BC
	for <lists+bpf@lfdr.de>; Mon, 26 Jun 2023 18:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 414F513AC6;
	Mon, 26 Jun 2023 18:23:00 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A25134CE
	for <bpf@vger.kernel.org>; Mon, 26 Jun 2023 18:22:59 +0000 (UTC)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7638A1987
	for <bpf@vger.kernel.org>; Mon, 26 Jun 2023 11:22:32 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4fb7acaa7a5so1286539e87.1
        for <bpf@vger.kernel.org>; Mon, 26 Jun 2023 11:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687803712; x=1690395712;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=12lFLZLSXgkTkPCwfgRZ92qmdnntBBAXAquDS6NIEKA=;
        b=g8MLf+sl/ULmpq0gRZB3a+3fdE3HZa2AqIRHimNYL88+AvOU2TDLZOG2Nu0+kaC1k7
         7Gmke7r/v6/25XkOYGY2BIcNbtxlpcsLQzabKPk2J1wPdu1PNXXHV6bPEtVDH/6Ehx7Z
         xyF2OYyzBINiv82ab7lmOW0cAJzEqwJh2hMxYBpBHIPFBjBv1Gwzv/rEZTZEbhQfGXjO
         gu2XEYdrN+hkUfgcRjK1fj4uH/XKn74fvozWUyNTZqtOm7xXh9OB0FdYgg9q7mTFgnho
         H7KBDhsVFztwblWXv8DJNBwlaOZzjthtq1+oCbnNH6p4zLq/ZOKDEWWU9HVVOcy7y+fo
         y5VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687803712; x=1690395712;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=12lFLZLSXgkTkPCwfgRZ92qmdnntBBAXAquDS6NIEKA=;
        b=kGzPS50JLWkbt+ly70fLv8BFDxPhq7yWVtb0JWtayfGUf80Fo7Hsm/xoc42h+1kbnB
         RuVWnSELC+DO7r6qr+ORBcYK7jAKalzBt3T77WB9g7t8vPUIDYerMF0kvepBhjjBpdhi
         tuaTMHxD2Vlt2OtL+IVle9BfYm/d2mjbBL7Cq7PLt/tUYcQUmLfQ2h4bsibsSnWgX4Iz
         1GXIMW8RMsYjzzt8tga+NUO3759pI0LyAWR06VbGxEuuCwDm2SwXF3LN29X8M/TiJiG4
         WwHlxEiWeEuHtvNU+vN9KsqqVrPGJL9xFS5km+khpqRJmgKtp0feyG+V7iPpAcjPgv4O
         WV8A==
X-Gm-Message-State: AC+VfDwfNO2cSQ5phzEUIlJBncZua0273Jz92DxNBMm1VfjbPvHP6vJl
	pHWVjeilAkAr/1MPkRr3itg4mi9deYE6OIgynzE=
X-Google-Smtp-Source: ACHHUZ4DaZkApmQpKbPGLs4vvVVKzMLlU3JnEE79MNDaLnmEXQnBqojBBn5a1/xrgpfICEr3Fz4jEBPzlfFSMigvkzQ=
X-Received: by 2002:a05:6512:281f:b0:4fb:772a:af19 with SMTP id
 cf31-20020a056512281f00b004fb772aaf19mr2166440lfb.34.1687803711954; Mon, 26
 Jun 2023 11:21:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230620083550.690426-1-jolsa@kernel.org> <20230620083550.690426-14-jolsa@kernel.org>
 <CAEf4BzZpq96QUsWitv+TBuaE2ehy0PKuEvq0rYgjOQj6jegTGQ@mail.gmail.com> <ZJeV48zw9C1h/mYs@krava>
In-Reply-To: <ZJeV48zw9C1h/mYs@krava>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 26 Jun 2023 11:21:40 -0700
Message-ID: <CAEf4BzZ_n14aXgqEjv2=hFUHMLOseZ2WdtHfiBD1VeGaBspi4w@mail.gmail.com>
Subject: Re: [PATCHv2 bpf-next 13/24] libbpf: Add uprobe multi link detection
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Jun 24, 2023 at 6:18=E2=80=AFPM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Fri, Jun 23, 2023 at 01:40:20PM -0700, Andrii Nakryiko wrote:
> > On Tue, Jun 20, 2023 at 1:38=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wr=
ote:
> > >
> > > Adding uprobe-multi link detection. It will be used later in
> > > bpf_program__attach_usdt function to check and use uprobe_multi
> > > link over standard uprobe links.
> > >
> > > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > > ---
> > >  tools/lib/bpf/libbpf.c          | 29 +++++++++++++++++++++++++++++
> > >  tools/lib/bpf/libbpf_internal.h |  2 ++
> > >  2 files changed, 31 insertions(+)
> > >
> > > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > > index e42080258ec7..3d570898459e 100644
> > > --- a/tools/lib/bpf/libbpf.c
> > > +++ b/tools/lib/bpf/libbpf.c
> > > @@ -4815,6 +4815,32 @@ static int probe_perf_link(void)
> > >         return link_fd < 0 && err =3D=3D -EBADF;
> > >  }
> > >
> > > +static int probe_uprobe_multi_link(void)
> > > +{
> > > +       struct bpf_insn insns[] =3D {
> > > +               BPF_MOV64_IMM(BPF_REG_0, 0),
> > > +               BPF_EXIT_INSN(),
> > > +       };
> > > +       int prog_fd, link_fd, err;
> > > +
> > > +       prog_fd =3D bpf_prog_load(BPF_PROG_TYPE_KPROBE, NULL, "GPL",
> > > +                               insns, ARRAY_SIZE(insns), NULL);
> >
> > I thought we needed to specify expected_attach_type (BPF_TRACE_UPROBE_M=
ULTI)?
>
> hm it should.. I guess it worked because of the KPROBE/UPROBE
> typo you found in the patch earlier, will check
>
> >
> > > +       if (prog_fd < 0)
> > > +               return -errno;
> > > +
> > > +       /* No need to specify attach function. If the link is not sup=
ported
> > > +        * we will get -EOPNOTSUPP error before any other check is pe=
rformed.
> >
> > what will actually return this -EOPNOTSUPP? I couldn't find this in
> > the code quickly, can you please point me where?
>
>         #else /* !CONFIG_UPROBES */
>         int bpf_uprobe_multi_link_attach(const union bpf_attr *attr, stru=
ct bpf_prog *prog)
>         {
>                 return -EOPNOTSUPP;
>         }

that's a new code in new kernel that doesn't have CONFIG_UPROBES. What
about old kernels? They will return -EINVAL, no? Which we will assume
means "yep, multi-uprobe BPF link is supported", which would be wrong.
Or am I missing something?

>
> >
> > > +        */
> > > +       link_fd =3D bpf_link_create(prog_fd, -1, BPF_TRACE_UPROBE_MUL=
TI, NULL);
> > > +       err =3D -errno; /* close() can clobber errno */
> > > +
> > > +       if (link_fd >=3D 0)
> > > +               close(link_fd);
> > > +       close(prog_fd);
> > > +
> > > +       return link_fd < 0 && err !=3D -EOPNOTSUPP;
> > > +}
> > > +
> > >  static int probe_kern_bpf_cookie(void)
> > >  {
> > >         struct bpf_insn insns[] =3D {
> > > @@ -4911,6 +4937,9 @@ static struct kern_feature_desc {
> > >         [FEAT_SYSCALL_WRAPPER] =3D {
> > >                 "Kernel using syscall wrapper", probe_kern_syscall_wr=
apper,
> > >         },
> > > +       [FEAT_UPROBE_LINK] =3D {
> > > +               "BPF uprobe multi link support", probe_uprobe_multi_l=
ink,
> > > +       },
> > >  };
> > >
> > >  bool kernel_supports(const struct bpf_object *obj, enum kern_feature=
_id feat_id)
> > > diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_i=
nternal.h
> > > index 22b0834e7fe1..a257eb81af25 100644
> > > --- a/tools/lib/bpf/libbpf_internal.h
> > > +++ b/tools/lib/bpf/libbpf_internal.h
> > > @@ -354,6 +354,8 @@ enum kern_feature_id {
> > >         FEAT_BTF_ENUM64,
> > >         /* Kernel uses syscall wrapper (CONFIG_ARCH_HAS_SYSCALL_WRAPP=
ER) */
> > >         FEAT_SYSCALL_WRAPPER,
> > > +       /* BPF uprobe_multi link support */
> > > +       FEAT_UPROBE_LINK,
> >
> > UPROBE_MULTI_LINK, we might have non-multi link in the future as well
>
> ok
>
> thanks,
> jirka

