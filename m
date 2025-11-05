Return-Path: <bpf+bounces-73549-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CAA3C33812
	for <lists+bpf@lfdr.de>; Wed, 05 Nov 2025 01:47:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9FD044F32B7
	for <lists+bpf@lfdr.de>; Wed,  5 Nov 2025 00:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F63023958A;
	Wed,  5 Nov 2025 00:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="akw19Abp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7108237707
	for <bpf@vger.kernel.org>; Wed,  5 Nov 2025 00:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762303595; cv=none; b=mPiQO2/ZJ4j3hhpn/C1LNz9oMbfqBpoKFuA7jGgBBEzbG+R59SoJBTMJBc9nTCWXkl3AEp+w6AKpGa1XB1/oMef/8Z5Yk1W6UpD5URIzFJflAFdlItvnTBiG058vWL0XsHool/n1cBMg6ZzJirqHYC+EzoNPcQO43GAdUveZPEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762303595; c=relaxed/simple;
	bh=QK7dX00M8Jg/onYsQPjhAdFQtssDUJ0UQljG+F4NwI4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B4TxQwWO+1pFiqvjb6mULUnshCFd1VDCI0NWfYGlPwWwekOtr30b5a2X+vDGMgAhh9OIi3/NEwpcOGjY1QvqhjbDvWG565lFxxIib76PywrbBdV+zMcDzcj2lnpFJdr1QfoNBvIqXuWDVTxea+UN5dSn4p/9SCOh8zb17mJdhIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=akw19Abp; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-340299fe579so6045656a91.2
        for <bpf@vger.kernel.org>; Tue, 04 Nov 2025 16:46:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762303593; x=1762908393; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xXdfuXEyYCSjpACOy8ivhFG7mh9YLIGOopMLdxt74zc=;
        b=akw19AbpzHDaXfBCRYfqUGDx8coKx6J97HywA1LD29sdhvk3TAzmK3BkXHb/1FslKu
         q4rF6J4tyGFnVHec6iyqUbKmoVKNMUNVOtjNinztQ02Z7pdYE3Tyz9RkFOuCm65odbZ3
         q3UKK0VRzFRTBkB4VugdduWlM60mIUcmWnVs/g3aEXn2oIG9SUWJshylpwXVe9TBi9qo
         hrWO6TGV/0jaWc4yDVnFxXzHnY+Nq1MNWrfESd0hpIlZWW24oLHq9NvYdJCGV8Go4dTw
         EzwnZzCT0bRbOfP7k9J3KPgV4fXEAW3Vh4m2zk9cXw46EY4Hu7SdfoeTcm9z0+9YWWIi
         AYcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762303593; x=1762908393;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xXdfuXEyYCSjpACOy8ivhFG7mh9YLIGOopMLdxt74zc=;
        b=TC2SJvIbNUes9cJjlqgBQ4S4+42VYKXSjcYwAV8Lu6IIS4SaMwkicmwPo4MHPgpGiN
         XsJHzYLaByRjDh9i5UUo5C1u/fQOK5RCfz5lCNEJwt+NLC3L2Sq6q2DeOLnMh6VCU1JV
         KCD9CQJSNcgJsl4avpPcZtphtail+EulxxdxmeHH0WdUIXksDXPDylTyY9s1nxHAJtxa
         MQ0b7drJsty5jYWaNkiNt3saW6wLnUQCoEp8Vab+S1BqedyF1dd2bgIgtka7WrN7IsZs
         1N0yIEfgkuIGoii8aDARZU15OfrB+XATDdj5sR5B+xXdpSVLACUlDVMvSgURm3ZH+ZTe
         8bmA==
X-Gm-Message-State: AOJu0Yw8dlTHiporsejjjJ/CroNJ/TD+M+cwCevT/qYax6Pv02uRD3rP
	xFA06jV61sd8lsF2cJ043PJ4rqgYQE5KrTwyyBnvtzaaSkYkK4hvVvXJJSmEunaY62PNe9E+sLQ
	s+Np6XDhpyqHQoOn037bJd2Add/6Li6U=
X-Gm-Gg: ASbGncvbrhT3r/VizRE+2L3b/ThXyasbmBInkgkzV8Nr66K0d77tsBj/0G1w5a2cbIX
	DXiS44SmYHk6ekgqRb0gnRhJQ5xoC5g5iacUUBABDSpMLVdrKNMwJExtEvFI6woIxQK+iNxCOxa
	nyz5ir09XbWTIvl55JdTFyAxPMPKHEQ+3vW7/s6kpj6CHrlr56TTidiVb3gFCG9NNuOBiXev8Ax
	sml8tsw+6NiwAmn7KzCAQAVprVOC9ao/kqZkqv8A2L0P4XPkpW898PWgRDXJwzONpkXeeZIWMbG
X-Google-Smtp-Source: AGHT+IHqrPTO438NQAMkf/XDaqLLvBN91MM/ltPzOSvF9R3C/E74okJU9TRrQTl4J+eFhQEFIVIoxZMoj6Dwi1L5XuA=
X-Received: by 2002:a17:90b:582e:b0:32e:6fae:ba52 with SMTP id
 98e67ed59e1d1-341a6c1e406mr1412213a91.6.1762303593093; Tue, 04 Nov 2025
 16:46:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251104172652.1746988-1-ameryhung@gmail.com> <20251104172652.1746988-5-ameryhung@gmail.com>
 <CAEf4BzbqEsZbO4AjKn7iRQCzKVSD0db9WdG7uKXMCA_4ueFYig@mail.gmail.com> <CAMB2axNi1SRT5=SuRZJayt+az6GM63w++T6stwHEHXHfdMce_Q@mail.gmail.com>
In-Reply-To: <CAMB2axNi1SRT5=SuRZJayt+az6GM63w++T6stwHEHXHfdMce_Q@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 4 Nov 2025 16:46:17 -0800
X-Gm-Features: AWmQ_bnqCa_p9Fq8mNorYc26Xaa218oJDAFar8ROmG6oXG-GVkull2R4bCd_zuU
Message-ID: <CAEf4BzaQ=z8qG0q5UgquzPuF5LwWB2wqUHtdnL72kN2PkmK_9Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 4/7] libbpf: Add support for associating BPF
 program with struct_ops
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, tj@kernel.org, martin.lau@kernel.org, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 4, 2025 at 3:39=E2=80=AFPM Amery Hung <ameryhung@gmail.com> wro=
te:
>
> On Tue, Nov 4, 2025 at 3:27=E2=80=AFPM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Tue, Nov 4, 2025 at 9:27=E2=80=AFAM Amery Hung <ameryhung@gmail.com>=
 wrote:
> > >
> > > Add low-level wrapper and libbpf API for BPF_PROG_ASSOC_STRUCT_OPS
> > > command in the bpf() syscall.
> > >
> > > Signed-off-by: Amery Hung <ameryhung@gmail.com>
> > > ---
> > >  tools/lib/bpf/bpf.c      | 19 +++++++++++++++++++
> > >  tools/lib/bpf/bpf.h      | 21 +++++++++++++++++++++
> > >  tools/lib/bpf/libbpf.c   | 30 ++++++++++++++++++++++++++++++
> > >  tools/lib/bpf/libbpf.h   | 16 ++++++++++++++++
> > >  tools/lib/bpf/libbpf.map |  2 ++
> > >  5 files changed, 88 insertions(+)
> > >
> > > diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
> > > index b66f5fbfbbb2..21b57a629916 100644
> > > --- a/tools/lib/bpf/bpf.c
> > > +++ b/tools/lib/bpf/bpf.c
> > > @@ -1397,3 +1397,22 @@ int bpf_prog_stream_read(int prog_fd, __u32 st=
ream_id, void *buf, __u32 buf_len,
> > >         err =3D sys_bpf(BPF_PROG_STREAM_READ_BY_FD, &attr, attr_sz);
> > >         return libbpf_err_errno(err);
> > >  }
> > > +
> > > +int bpf_prog_assoc_struct_ops(int prog_fd, int map_fd,
> > > +                             struct bpf_prog_assoc_struct_ops_opts *=
opts)
> > > +{
> > > +       const size_t attr_sz =3D offsetofend(union bpf_attr, prog_ass=
oc_struct_ops);
> > > +       union bpf_attr attr;
> > > +       int err;
> > > +
> > > +       if (!OPTS_VALID(opts, bpf_prog_assoc_struct_ops_opts))
> > > +               return libbpf_err(-EINVAL);
> > > +
> > > +       memset(&attr, 0, attr_sz);
> > > +       attr.prog_assoc_struct_ops.map_fd =3D map_fd;
> > > +       attr.prog_assoc_struct_ops.prog_fd =3D prog_fd;
> > > +       attr.prog_assoc_struct_ops.flags =3D OPTS_GET(opts, flags, 0)=
;
> > > +
> > > +       err =3D sys_bpf(BPF_PROG_ASSOC_STRUCT_OPS, &attr, attr_sz);
> > > +       return libbpf_err_errno(err);
> > > +}
> > > diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
> > > index e983a3e40d61..1f9c28d27795 100644
> > > --- a/tools/lib/bpf/bpf.h
> > > +++ b/tools/lib/bpf/bpf.h
> > > @@ -733,6 +733,27 @@ struct bpf_prog_stream_read_opts {
> > >  LIBBPF_API int bpf_prog_stream_read(int prog_fd, __u32 stream_id, vo=
id *buf, __u32 buf_len,
> > >                                     struct bpf_prog_stream_read_opts =
*opts);
> > >
> > > +struct bpf_prog_assoc_struct_ops_opts {
> > > +       size_t sz;
> > > +       __u32 flags;
> > > +       size_t :0;
> > > +};
> > > +#define bpf_prog_assoc_struct_ops_opts__last_field flags
> > > +
> > > +/**
> > > + * @brief **bpf_prog_assoc_struct_ops** associates a BPF program wit=
h a
> > > + * struct_ops map.
> > > + *
> > > + * @param prog_fd FD for the BPF program
> > > + * @param map_fd FD for the struct_ops map to be associated with the=
 BPF program
> > > + * @param opts optional options, can be NULL
> > > + *
> > > + * @return 0 on success; negative error code, otherwise (errno is al=
so set to
> > > + * the error code)
> > > + */
> > > +LIBBPF_API int bpf_prog_assoc_struct_ops(int prog_fd, int map_fd,
> > > +                                        struct bpf_prog_assoc_struct=
_ops_opts *opts);
> > > +
> > >  #ifdef __cplusplus
> > >  } /* extern "C" */
> > >  #endif
> > > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > > index fbe74686c97d..260e1feaa665 100644
> > > --- a/tools/lib/bpf/libbpf.c
> > > +++ b/tools/lib/bpf/libbpf.c
> > > @@ -13891,6 +13891,36 @@ int bpf_program__set_attach_target(struct bp=
f_program *prog,
> > >         return 0;
> > >  }
> > >
> > > +int bpf_program__assoc_struct_ops(struct bpf_program *prog, struct b=
pf_map *map,
> > > +                                 struct bpf_prog_assoc_struct_ops_op=
ts *opts)
> > > +{
> > > +       int prog_fd;
> > > +
> > > +       prog_fd =3D bpf_program__fd(prog);
> > > +       if (prog_fd < 0) {
> > > +               pr_warn("prog '%s': can't associate BPF program witho=
ut FD (was it loaded?)\n",
> > > +                       prog->name);
> > > +               return -EINVAL;
> > > +       }
> > > +
> > > +       if (prog->type =3D=3D BPF_PROG_TYPE_STRUCT_OPS) {
> > > +               pr_warn("prog '%s': can't associate struct_ops progra=
m\n", prog->name);
> > > +               return -EINVAL;
> > > +       }
> > > +
> > > +       if (map->fd < 0) {
> >
> > heh, this is a bug. we use create_placeholder_fd() to create fixed FDs
> > associated with maps, and later we replace them with the real
> > underlying BPF map kernel objects. It's all details, but the point is
> > that this won't detect map that wasn't created. Use bpf_map__fd()
> > instead, it handles that correctly.
>
> I saw quite a few libbpf API doing this check (e.g., bpf_map__pin(),
> bpf_link__update_map(), bpf_map__attach_struct_ops()). Should we also
> fix them?

yep, probably :)

>
> >
> > > +               pr_warn("map '%s': can't associate BPF map without FD=
 (was it created?)\n", map->name);
> > > +               return -EINVAL;
> > > +       }
> > > +
> > > +       if (!bpf_map__is_struct_ops(map)) {
> > > +               pr_warn("map '%s': can't associate non-struct_ops map=
\n", map->name);
> > > +               return -EINVAL;
> > > +       }
> > > +
> > > +       return bpf_prog_assoc_struct_ops(prog_fd, map->fd, opts);
> > > +}
> > > +
> > >  int parse_cpu_mask_str(const char *s, bool **mask, int *mask_sz)
> > >  {
> > >         int err =3D 0, n, len, start, end =3D -1;
> > > diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> > > index 5118d0a90e24..45720b7c2aaa 100644
> > > --- a/tools/lib/bpf/libbpf.h
> > > +++ b/tools/lib/bpf/libbpf.h
> > > @@ -1003,6 +1003,22 @@ LIBBPF_API int
> > >  bpf_program__set_attach_target(struct bpf_program *prog, int attach_=
prog_fd,
> > >                                const char *attach_func_name);
> > >
> > > +struct bpf_prog_assoc_struct_ops_opts; /* defined in bpf.h */
> > > +
> > > +/**
> > > + * @brief **bpf_program__assoc_struct_ops()** associates a BPF progr=
am with a
> > > + * struct_ops map.
> > > + *
> > > + * @param prog BPF program
> > > + * @param map struct_ops map to be associated with the BPF program
> > > + * @param opts optional options, can be NULL
> > > + *
> > > + * @return error code; or 0 if no error occurred.
> >
> > we normally specify returns like so:
> >
> > @return 0, on success; negative error code, otherwise
> >
> > keep it consistent?
>
> Okay. Will change.
>
> BTW. The return comment is copied from bpf_program__set_attach_target().

well, we should strive for consistency :)

>
> >
> > > + */
> > > +LIBBPF_API int
> > > +bpf_program__assoc_struct_ops(struct bpf_program *prog, struct bpf_m=
ap *map,
> > > +                             struct bpf_prog_assoc_struct_ops_opts *=
opts);
> > > +
> > >  /**
> > >   * @brief **bpf_object__find_map_by_name()** returns BPF map of
> > >   * the given name, if it exists within the passed BPF object
> > > diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> > > index 8ed8749907d4..84fb90a016c9 100644
> > > --- a/tools/lib/bpf/libbpf.map
> > > +++ b/tools/lib/bpf/libbpf.map
> > > @@ -451,4 +451,6 @@ LIBBPF_1.7.0 {
> > >         global:
> > >                 bpf_map__set_exclusive_program;
> > >                 bpf_map__exclusive_program;
> > > +               bpf_prog_assoc_struct_ops;
> > > +               bpf_program__assoc_struct_ops;
> > >  } LIBBPF_1.6.0;
> > > --
> > > 2.47.3
> > >

