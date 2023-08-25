Return-Path: <bpf+bounces-8682-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4B7C788F20
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 21:06:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9975D281808
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 19:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BDCB18B19;
	Fri, 25 Aug 2023 19:06:43 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B71F2915
	for <bpf@vger.kernel.org>; Fri, 25 Aug 2023 19:06:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64E18C433CA
	for <bpf@vger.kernel.org>; Fri, 25 Aug 2023 19:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692990401;
	bh=MJ5NMZzSuTQH8aAurHkQo9ASID7AWfUTszzUJGVdnu0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=bxTm9NuBi0aCwnGKgDqOOgAn1W9bTHnG0Y+jjS5n+D1BnUUuUgCpnxWpeS6NjFhrH
	 sXmrwdsLCCmypUlw8pX3eqGVbY2iWcl8C1HPP70bo1O7pN3EQf6P2Ck2YV0VwwGnr9
	 nWBCUH2VQ77kmXk/NJAw5ROV3LwKwVIBMlStCrRLnC0REVmhR8nmSUUFarbMvbHr1U
	 4MKbvQeEiidpeInECGeF/8IkPBVdFh+Ao4pyIpFAURXYpSZexR0qPo6QQG8QjJ+Vrd
	 Zmsgu5gAqev+AMNl+b60dL7fDfUtHs3xm5h1BlK7VatK3mvjROnF6cnmUHV8oWT8GP
	 nF4kUhmSDh7Xw==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-500a8b2b73eso1488570e87.0
        for <bpf@vger.kernel.org>; Fri, 25 Aug 2023 12:06:41 -0700 (PDT)
X-Gm-Message-State: AOJu0Yytfuw6vCt15MP+VUfDW8JsDBXUn5JG41xT0RmViD6EBltMR/4M
	+CrKpNu4+/d6BkWg9EzOCF68SaIws0QuqS5mr8M=
X-Google-Smtp-Source: AGHT+IEw8qvXSQYPvPp/m2NaktoaefqkICz3XQFeVDAertK5ZwjXnfQIt4Ns1mEYfmjb8BmVO7duu15/VtQXIe9BCr8=
X-Received: by 2002:a05:6512:e99:b0:500:7de4:300e with SMTP id
 bi25-20020a0565120e9900b005007de4300emr15135721lfb.58.1692990399449; Fri, 25
 Aug 2023 12:06:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230824201358.1395122-1-andrii@kernel.org> <CAPhsuW6Qw1xOXruC5E7WjxwdMom3BwyU_2NsAjSx7rmFb7e16g@mail.gmail.com>
 <CAEf4BzZQutPNqMkzG7Q_F_TrzSHWOXfmOy38QXZGNDX3bAJX2Q@mail.gmail.com>
In-Reply-To: <CAEf4BzZQutPNqMkzG7Q_F_TrzSHWOXfmOy38QXZGNDX3bAJX2Q@mail.gmail.com>
From: Song Liu <song@kernel.org>
Date: Fri, 25 Aug 2023 12:06:27 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5VMbqKh9kwrNLmgeaMKW=++ZK=Qrm6j0aERU2uTc4Qeg@mail.gmail.com>
Message-ID: <CAPhsuW5VMbqKh9kwrNLmgeaMKW=++ZK=Qrm6j0aERU2uTc4Qeg@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next] libbpf: add basic BTF sanity validation
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 25, 2023 at 11:56=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, Aug 24, 2023 at 2:17=E2=80=AFPM Song Liu <song@kernel.org> wrote:
> >
> > On Thu, Aug 24, 2023 at 1:14=E2=80=AFPM Andrii Nakryiko <andrii@kernel.=
org> wrote:
> > >
> > [...]
> > > +
> > > +static int btf_validate_type(const struct btf *btf, const struct btf=
_type *t, __u32 id)
> > > +{
> > > +       __u32 kind =3D btf_kind(t);
> > > +       int err, i, n;
> > > +
> > > +       err =3D btf_validate_str(btf, t->name_off, "type name", id);
> > > +       if (err)
> > > +               return err;
> > > +
> > > +       switch (kind) {
> > > +       case BTF_KIND_UNKN:
> > > +       case BTF_KIND_INT:
> > > +       case BTF_KIND_FWD:
> > > +       case BTF_KIND_FLOAT:
> > > +               break;
> > > +       case BTF_KIND_PTR:
> > > +       case BTF_KIND_TYPEDEF:
> > > +       case BTF_KIND_VOLATILE:
> > > +       case BTF_KIND_CONST:
> > > +       case BTF_KIND_RESTRICT:
> > > +       case BTF_KIND_FUNC:
> > > +       case BTF_KIND_VAR:
> > > +       case BTF_KIND_DECL_TAG:
> > > +       case BTF_KIND_TYPE_TAG:
> > > +               err =3D btf_validate_id(btf, t->type, id);
> > > +               if (err)
> > > +                       return err;
> >
> > We can "return err;" at the end, and then remove all these "if (err)
> > return err;", right?
>
> in some places, yes, but not where we have loops. And in general I
> find it harder to follow. Keeping each case branch more self-contained
> seems better, personally. I'd prefer to keep it.

We don't really have a loop here. Well, I agree there is benefit to handlin=
g
err !=3D 0 immediately, so I don't have a very strong feeling towards the o=
ther
way.

Reviewed-by: Song Liu <song@kernel.org>

Thanks,
Song

