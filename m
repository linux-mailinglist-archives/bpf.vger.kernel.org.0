Return-Path: <bpf+bounces-2046-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD5747271CC
	for <lists+bpf@lfdr.de>; Thu,  8 Jun 2023 00:34:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F015E2815FC
	for <lists+bpf@lfdr.de>; Wed,  7 Jun 2023 22:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C77A3B3E7;
	Wed,  7 Jun 2023 22:34:36 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E0CD3B3E0
	for <bpf@vger.kernel.org>; Wed,  7 Jun 2023 22:34:36 +0000 (UTC)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 260391725
	for <bpf@vger.kernel.org>; Wed,  7 Jun 2023 15:34:34 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-9788554a8c9so198470566b.2
        for <bpf@vger.kernel.org>; Wed, 07 Jun 2023 15:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686177272; x=1688769272;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R0QDHqZ70OxcNOpfoN0j45kogAntENzMfRiu4/KklpI=;
        b=lh3Qu6hAGLvVRMqYLJ2JT7vPSOAJej7fnNv1HsGv3sAKTaMBgQeZV4CmUHrQFopLtb
         ZtsIuy7gXvojyn6cCYKpJh5jOyyYZm7GvXrIaoEvl57VWNIwEBnxk7165WKTwdPiTN8W
         G0S02TDlzxw6R9v8Xv6vlyApl3ODR1TuY/bIWn+akxSzfusvZCjuAJPhKHBu4mZWNTrZ
         F9Dr73mQzllcsQ908ZCAsfTzkX5DynGLC36Qff2vSXWc2IziQc997wgElP9nlQkSZm4i
         JKQW9wI9WIAFECo3cO+BXTWatmwcroTrC8gzg8+XzFdEmWmYt+lekQTp15qPj368wxxR
         TAaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686177272; x=1688769272;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R0QDHqZ70OxcNOpfoN0j45kogAntENzMfRiu4/KklpI=;
        b=Mi/cJFfw+deHlZnNwxuarXED2p7w4lml4eT1pmIOuFUZyv01WTCsojHdnBfuNyyfCt
         OR8ZOkwhQhWZ42sZbX8LYT1vn9jfrqXzWCwar3FLaRtRP5Fy6aqS8B8NqEeG30vo12vV
         6tUrVkwYCphS0rucmbnuYmuPn+rWkeChNyn9b62uezRFnPs6RaHlV3pJKo1FfkzeBdIb
         Fn8dItS5+AuBk9s7QDsKy7wE/XhbxuBJ7idwq1wM+I/JHi87FIuWFFQ/JH6NBt1LNa7u
         B/oG1yQwfvBXuAfGgA9tIUsmUgqAPiQlOy7hHEuJqvHzKdDn2tBOJ4sN1622+YHtXss0
         L22g==
X-Gm-Message-State: AC+VfDxma91pyBFkg1q4gxsuGH3vY2L8Qhn+7kcBAtSwEVqhEJwd3kax
	jqEMz72YAtnSGUkj7+kMliHDh4gxXNY9pexgipk=
X-Google-Smtp-Source: ACHHUZ7VzOAtY6MRg3cb2yXsTsVtOYAbpYlxCJuzG8OT0SYvpP37mg8OneLr0FPYpxnUb7dtFJoyCpYkKBc+oqFKM0U=
X-Received: by 2002:a17:907:d1c:b0:978:88bc:f225 with SMTP id
 gn28-20020a1709070d1c00b0097888bcf225mr3100078ejc.2.1686177272345; Wed, 07
 Jun 2023 15:34:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230531201936.1992188-1-alan.maguire@oracle.com>
 <20230531201936.1992188-2-alan.maguire@oracle.com> <20230601035354.5u56fwuundu6m7v2@MacBook-Pro-8.local>
 <89787945-c06c-1c41-655b-057c1a3d07dd@oracle.com> <CAADnVQ+2ZuX00MSxAXWcXmyc-dqYtZvGqJ9KzJpstv183nbPEA@mail.gmail.com>
 <CAEf4BzZaUEqYnyBs6OqX2_L_X=U4zjrKF9nPeyyKp7tRNVLMww@mail.gmail.com>
 <CAADnVQKbmAHTHk5YsH-t42BRz16MvXdRBdFmc5HFyCPijX-oNg@mail.gmail.com>
 <CAEf4BzamU4qTjrtoC_9zwx+DHyW26yq_HrevHw2ui-nqr6UF-g@mail.gmail.com>
 <CAADnVQ+_YeLZ0kmF+QueH_xE10=b-4m_BMh_-rct6S8TbpL0hw@mail.gmail.com>
 <CAEf4Bzbtptc9DUJ8peBU=xyrXxJFK5=rkr3gGRh05wwtnBZ==A@mail.gmail.com>
 <CAADnVQJAmYgR91WKJ_Jif6c3ja=OAmkMXoUO9sTnmp-xmnbVJQ@mail.gmail.com>
 <878rcw3k1o.fsf@toke.dk> <35e5f70bbe0890f875e0c24aff0453c25f018ea6.camel@gmail.com>
 <e58d3ec4-dcac-48b8-c6c2-63d131d967d8@meta.com> <45fac5ac0874163031b46388d65de194ed6f27e6.camel@gmail.com>
 <CAEf4BzY9_EiBqM74Gce9-Z5O+uubCY=CUejXr79hDY6SbOvTOg@mail.gmail.com> <24c2b0295ea9b8a3f3fc256e2d7bf004a046ebb1.camel@gmail.com>
In-Reply-To: <24c2b0295ea9b8a3f3fc256e2d7bf004a046ebb1.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 7 Jun 2023 15:34:19 -0700
Message-ID: <CAEf4BzYWSmSoBBcvOaOJ2Y78ZKNEXi5MOcoGONDE5iMGG_K0FQ@mail.gmail.com>
Subject: Re: [RFC bpf-next 1/8] btf: add kind metadata encoding to UAPI
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Yonghong Song <yhs@meta.com>, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@kernel.org>, 
	Alexei Starovoitov <alexei.starovoitov@gmail.com>, Alan Maguire <alan.maguire@oracle.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Quentin Monnet <quentin@isovalent.com>, Mykola Lysenko <mykolal@fb.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jun 7, 2023 at 3:05=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> On Wed, 2023-06-07 at 14:47 -0700, Andrii Nakryiko wrote:
> > On Wed, Jun 7, 2023 at 9:14=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.=
com> wrote:
> > >
> > > On Wed, 2023-06-07 at 08:29 -0700, Yonghong Song wrote:
> > > >
> > > > On 6/7/23 4:55 AM, Eduard Zingerman wrote:
> > > > > On Tue, 2023-06-06 at 13:30 +0200, Toke H=C3=B8iland-J=C3=B8rgens=
en wrote:
> > > > > [...]
> > > > > >
> > > > > > As for bumping the version number, I don't think it's a good id=
ea to
> > > > > > deliberately break compatibility this way unless it's absolutel=
y
> > > > > > necessary. With "absolutely necessary" meaning "things will bre=
ak in
> > > > > > subtle ways in any case, so it's better to make the breakage ob=
vious".
> > > > > > But it libbpf is not checking the version field anyway, that be=
comes
> > > > > > kind of a moot point, as bumping it doesn't really gain us anyt=
hing,
> > > > > > then...
> > > > >
> > > > > It seems to me that in terms of backward compatibility, the abili=
ty to
> > > > > specify the size for each kind entry is more valuable than the
> > > > > capability to add new BTF kinds:
> > > > > - The former allows for extending kind records in
> > > > >    a backward-compatible manner, such as adding a function addres=
s to
> > > > >    BTF_KIND_FUNC.
> > > >
> > > > Eduard, the new proposal is to add new kind, e.g., BTF_KIND_KFUNC, =
which
> > > > will have an 'address' field. BTF_KIND_KFUNC is for kernel function=
s.
> > > > So we will not have size compatibility issue for BTF_KIND_FUNC.
> > >
> > > Well, actually this might be a way to avoid BTF_KIND_KFUNC :)
> > > What I wanted to say is that any use of this feature leads to
> > > incompatibility with current BTF parsers, as either size of existing
> > > kinds would be changed or a new kind with unknown size would be added=
.
> > > It seems to me that this warrants version bump (or some other way to
> > > signal existing parsers that format is incompatible).
> >
> > It is probably too late to have existing KINDs changing their size. If
> > this layout metadata was mandatory from the very beginning, then we
> > could have relied on it for determining new extra fields for
> > BTF_KIND_FUNC.
> >
> > As things stand right now, new BTF_KIND_KFUNC is both a signal of
> > newer format (for kernel-side BTF; nothing changes for BPF object file
> > BTFs, which is great side-effect making backwards compat pain
> > smaller), and is a simpler and safer way to add extra information.
> >
> > >
> > > >
> > > > > - The latter is much more fragile. Types refer to each other,
> > > > >    compatibility is already lost once a new "unknown" tag is intr=
oduced
> > > > >    in a type chain.
> > > > >
> > > > > However, changing the size of existing BTF kinds is itself a
> > > > > backward-incompatible change. Therefore, a version bump may be
> > > > > warranted in this regard.
> > >
> >
> > See above and previous emails. Not having to bump version means we can
> > start emitting this layout info from Clang and pahole with no extra
> > opt-in flags, and not worry about breaking existing tools and apps.
> > This is great, so let's not ruin that property :)
>
> I'm not sure I understand how this would help:
> - If no new kinds are added, absence or presence of metadata section
>   does not matter. Old parsers would ignore it, new parsers would work
>   as old parsers, so there is no added value in generating metadata.
> - As soon as new kind is added old parsers are broken.
>
> What am I missing?

I was arguing both against changing BTF_KIND_FUNC (not adding new
fields to id, not changing its size based on klag, etc) and against
bumping BTF_VERSION to 2.

For kernel-side BTF breakage is unavoidable, unfortunately, either if
we extend BTF_KIND_FUNC with addr or add new kind BTF_KIND_KFUNC. Any
application that would want to open such new kernel BTF would need to
upgrade to latest libbpf to be able to do it.

What I'm trying to avoid is also breaking (unnecessarily) BPF object
file-side BTF generated by Clang. BPF object BTF also has
BTF_KIND_FUNC generated for each entry program and subprogram. So if
we change anything about BTF_KIND_FUNC, we break existing tools, so we
need to be careful about that.


If we are talking about this btf_layout information separately from
extending kernel-side function info. By adding just that, we can keep
both kernel and BPF object BTFs backwards compatible with existing
tooling (unless someone decided to be very strict about checking
BTF_VERSION or btf_header bytes after last known field).


So tl;dr:
  - btf_layout is useful and can be done in a backwards compatible
way, if we don't bump BTF_VERSION;
  - we can start emitting it from Clang and pahole unconditionally, if
done this way;
  - adding addrs to either new BTF_KIND_KFUNC or extending existing
BTF_KIND_FUNC is separate from btf_layout (it just prompted btf_layout
prioritization to help avoid unnecessary tooling breakages in the
future), and I'm leaning towards new BTF_KIND_KFUNC instead of trying
to extend existing BTF_KIND_FUNC.

