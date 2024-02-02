Return-Path: <bpf+bounces-21100-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 35CC0847C20
	for <lists+bpf@lfdr.de>; Fri,  2 Feb 2024 23:16:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5595B21E14
	for <lists+bpf@lfdr.de>; Fri,  2 Feb 2024 22:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B3F683A10;
	Fri,  2 Feb 2024 22:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mFKRP5Qi"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C0A8592A
	for <bpf@vger.kernel.org>; Fri,  2 Feb 2024 22:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706912177; cv=none; b=e0G7pZ34EbO/rhSgseaR2W7CRcX6wAnOKElkedVfIkWhWYMfDsd7lp2XxniB1yGXZMGLZJCB/HhUGU78q1GRpeRRlGbvA2+D9Wu1ENBz10IJa/oaEZ+tUEU6iZmz5ae5bjmpyU8xbUT6VVZNmJ9yZ9ACUvofqn1333HqQP4Qdio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706912177; c=relaxed/simple;
	bh=c2KTCAA3vs7qeILMYQjr3lG57YEWzX6xwTSRT/OVEQk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=POZC10n62N3bExXxauC4WAkB4v47s3VOVIml5p7DO/hXof6SFMF0wPcaBGGbO4tJqninibq30mpymg7Q8fYq95YaCzBLfJLCN1yuf0/AOMwzHdbRYNsuAAxqRPzK3lnADCOADzIu3EfFpM+nVdlyS9xOjBFC/Nc/4AtTyMrGnz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mFKRP5Qi; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6de2f8d6fb9so1922829b3a.1
        for <bpf@vger.kernel.org>; Fri, 02 Feb 2024 14:16:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706912175; x=1707516975; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MvQ3YUTg0J9/CVxRuK0h21N+7TU1foe+apKNNuMuoxY=;
        b=mFKRP5Qi2ghQquEdlK2iA7E/1vzowoC0QY6GwbDb7aRbIQMkfuIdTp0kI1W2xzfF1N
         XKvoW3ACvvAzVRZBz04fP1UJ16uiRthlz0wDf6rqJJ8P0zDxxkh0iAzKIeA3qvz7tPeY
         hSaGJxL1j7GcL9R/ijt+dCwkOXoqWwsXnJAwB1QfYB4ur07X3s+yMZFxkjRYDQvrslY2
         6bAx+T77zpCfq8iu95Eklc2p0/DoJK6/esqFD/BXLO21cG45QJ1pFCaQrD7BAyCTleec
         EXt9H52MCqTPh1Evg6HInASDbcHlVwNDNX6d1KD7Qri/HhDFGgMnejqRfA6WmYjBvSB4
         pl1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706912175; x=1707516975;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MvQ3YUTg0J9/CVxRuK0h21N+7TU1foe+apKNNuMuoxY=;
        b=m1mEKYBbcON0njmvycqMis2J2NhhOYb27+2K5sQ+JFOFvPTNZkkn6iXNPFIiDHr7BW
         I5+y98y0NNMYNZoj8W5dwCA2iHpJl4n8TQ3ASFO1pSb+9oCrcdWlHd0qcRirq4QZNVXO
         ZRI6TfRGj27d/MSCVoLJSL2n2zNJ1a3IZskJoScesDyLdG31ANrNfETxeNV8HN2plNnY
         DnXrdNyLv08bgKXxe8AeO71rKqCpIWVT9IxFm/UNFbBCdCUNyVabD39JfyIQQxMfkuPb
         g1FjEhk5Ff+7ce6t2mXv7P65V1ba97NiEeQc5fz7m7Ic86h3MjQ8q1BdxqheNt2xgZ04
         gepg==
X-Gm-Message-State: AOJu0YwwDV6zTERFv+FYri1UilOQ3ISKUIR0gbavBuBxjv+y7qkb29rt
	3vIfeoKrm5WSlnsedStpIwhmz+A95/Y3umoQdzaUtNtr9+fEiSMgbFY3OYzdbh1jMcSW/10dETj
	Mz+2XDJdjHY5skGhILWZl5IgeDofHF4DR
X-Google-Smtp-Source: AGHT+IGBasZYVLhNrSqQLbUxu4b+eGwz6YhslEG/xBs/E+SN/xhmr0R+U5UQi86kBPHCa7yInByPIswjQyX4C/Zy4lw=
X-Received: by 2002:aa7:8543:0:b0:6d9:b5ba:7802 with SMTP id
 y3-20020aa78543000000b006d9b5ba7802mr6850442pfn.26.1706912175230; Fri, 02 Feb
 2024 14:16:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130230510.791-1-git@brycekahle.com> <01046526-c9b1-4d7b-b6b3-296c1bda1903@oracle.com>
In-Reply-To: <01046526-c9b1-4d7b-b6b3-296c1bda1903@oracle.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 2 Feb 2024 14:16:03 -0800
Message-ID: <CAEf4Bzb8zopBkfSxynV4DwzODgvPeM_M9rDJ+BtrfriW+TyAZA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4] bpftool: add support for split BTF to gen min_core_btf
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Bryce Kahle <git@brycekahle.com>, bpf@vger.kernel.org, quentin@isovalent.com, 
	ast@kernel.org, daniel@iogearbox.net, Bryce Kahle <bryce.kahle@datadoghq.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 31, 2024 at 10:47=E2=80=AFAM Alan Maguire <alan.maguire@oracle.=
com> wrote:
>
> On 30/01/2024 23:05, Bryce Kahle wrote:
> > From: Bryce Kahle <bryce.kahle@datadoghq.com>
> >
> > Enables a user to generate minimized kernel module BTF.
> >
> > If an eBPF program probes a function within a kernel module or uses
> > types that come from a kernel module, split BTF is required. The split
> > module BTF contains only the BTF types that are unique to the module.
> > It will reference the base/vmlinux BTF types and always starts its type
> > IDs at X+1 where X is the largest type ID in the base BTF.
> >
> > Minimization allows a user to ship only the types necessary to do
> > relocations for the program(s) in the provided eBPF object file(s). A
> > minimized module BTF will still not contain vmlinux BTF types, so you
> > should always minimize the vmlinux file first, and then minimize the
> > kernel module file.
> >
> > Example:
> >
> > bpftool gen min_core_btf vmlinux.btf vm-min.btf prog.bpf.o
> > bpftool -B vm-min.btf gen min_core_btf mod.btf mod-min.btf prog.bpf.o
>
> This is great! I've been working on a somewhat related problem involving
> split BTF for modules, and I'm trying to figure out if there's overlap
> with what you've done here that can help in either direction. I'll try
> and describe what I'm doing. Sorry if this is a bit of a diversion,
> but I just want to check if there are potential ways your changes could
> facilitate other scenarios in the future.
>
> The problem I'm trying to tackle is to enable split BTF module
> generation to be more resilient to underlying kernel BTF changes;
> this would allow for example a module that is not built with the kernel
> to generate BTF and have it work even if small changes in vmlinux occur.
> Even a small change in BTF ids in base BTF is enough to invalidate the
> associated split BTF, so the question is how to make this a bit less
> brittle. This won't be needed for modules built along with the kernel,
> but more for cases like a package delivering a kernel module.
>
> The way this is done is similar to what you're doing - generating
> minimal base vmlinux BTF along with the module BTF. In my case however
> the minimization is not driven by CO-RE relocations; rather it is driven
> by only adding types that are referenced by module BTF and any other
> associated types needed. We end up with minimal base BTF that is carried
> along with the module BTF (in a .BTF.base_minimal section) and this
> minimal BTF will be used to later reconcile module BTF with the running
> kernel BTF when the module is loaded; it essentially provides the
> additional information needed to map to current vmlinux types.
>
> In this approach, minimal vmlinux BTF is generated via an additional
> option to pahole which adds an extra phase to BTF deduplication between
> module and kernel. Once we have found the candidate mappings for
> deduplication, we can look at all base BTF references from module BTF
> and recursively add associated types to the base minimal BTF. Finally we
> reparent the split BTF to this minimal base BTF. Experiments show most
> modules wind up with base minimal BTF of around 4000 types, so the
> minimization seems to work well. But it's complex.
>
> So what I've been trying to work out is if this dedup complexity can be
> eliminated with your changes, but from what I can see, the membership in
> the minimal base BTF in your case is driven by the CO-RE relocations
> used in the BPF program. Would there do you think be a future where we
> would look at doing base minimal BTF generation by other criteria (like
> references from the module BTF)? Thanks!

Hm... I might be misremembering or missing something, but the problem
you are solving doesn't seem to be related to BTF minimization. I also
forgot why you need BTF deduplication, I vaguely remember we needed to
remember "expectations" of types that module BTF references in vmlinux
BTF, but I fail to remember why we needed dedup... Perhaps we need a
BPF office hours session to go over details again?

>
> Alan
>
> > v3->v4:
> > - address style nit about start_id initialization
> > - rename base to src_base_btf (base_btf is a global var)
> > - copy src_base_btf so new BTF is not modifying original vmlinux BTF
> >
> > Signed-off-by: Bryce Kahle <bryce.kahle@datadoghq.com>
> > ---
> >  .../bpf/bpftool/Documentation/bpftool-gen.rst | 18 ++++++++++-
> >  tools/bpf/bpftool/gen.c                       | 32 +++++++++++++++----
> >  2 files changed, 42 insertions(+), 8 deletions(-)
> >
> > diff --git a/tools/bpf/bpftool/Documentation/bpftool-gen.rst b/tools/bp=
f/bpftool/Documentation/bpftool-gen.rst
> > index 5006e724d..e067d3b05 100644
> > --- a/tools/bpf/bpftool/Documentation/bpftool-gen.rst
> > +++ b/tools/bpf/bpftool/Documentation/bpftool-gen.rst
> > @@ -16,7 +16,7 @@ SYNOPSIS
> >
> >       **bpftool** [*OPTIONS*] **gen** *COMMAND*
> >
> > -     *OPTIONS* :=3D { |COMMON_OPTIONS| | { **-L** | **--use-loader** }=
 }
> > +     *OPTIONS* :=3D { |COMMON_OPTIONS| | { **-B** | **--base-btf** } |=
 { **-L** | **--use-loader** } }
> >
> >       *COMMAND* :=3D { **object** | **skeleton** | **help** }
> >
> > @@ -202,6 +202,14 @@ OPTIONS
> >  =3D=3D=3D=3D=3D=3D=3D
> >       .. include:: common_options.rst
> >
> > +     -B, --base-btf *FILE*
> > +               Pass a base BTF object. Base BTF objects are typically =
used
> > +               with BTF objects for kernel modules. To avoid duplicati=
ng
> > +               all kernel symbols required by modules, BTF objects for
> > +               modules are "split", they are built incrementally on to=
p of
> > +               the kernel (vmlinux) BTF object. So the base BTF refere=
nce
> > +               should usually point to the kernel BTF.
> > +
> >       -L, --use-loader
> >                 For skeletons, generate a "light" skeleton (also known =
as "loader"
> >                 skeleton). A light skeleton contains a loader eBPF prog=
ram. It does
> > @@ -444,3 +452,11 @@ ones given to min_core_btf.
> >    obj =3D bpf_object__open_file("one.bpf.o", &opts);
> >
> >    ...
> > +
> > +Kernel module BTF may also be minimized by using the -B option:
> > +
> > +**$ bpftool -B 5.4.0-smaller.btf gen min_core_btf 5.4.0-module.btf 5.4=
.0-module-smaller.btf one.bpf.o**
> > +
> > +A minimized module BTF will still not contain vmlinux BTF types, so yo=
u
> > +should always minimize the vmlinux file first, and then minimize the
> > +kernel module file.
> > diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
> > index ee3ce2b80..57691f766 100644
> > --- a/tools/bpf/bpftool/gen.c
> > +++ b/tools/bpf/bpftool/gen.c
> > @@ -1630,6 +1630,7 @@ static int do_help(int argc, char **argv)
> >               "       %1$s %2$s help\n"
> >               "\n"
> >               "       " HELP_SPEC_OPTIONS " |\n"
> > +             "                    {-B|--base-btf} |\n"
> >               "                    {-L|--use-loader} }\n"
> >               "",
> >               bin_name, "gen");
> > @@ -1695,14 +1696,14 @@ btfgen_new_info(const char *targ_btf_path)
> >       if (!info)
> >               return NULL;
> >
> > -     info->src_btf =3D btf__parse(targ_btf_path, NULL);
> > +     info->src_btf =3D btf__parse_split(targ_btf_path, base_btf);
> >       if (!info->src_btf) {
> >               err =3D -errno;
> >               p_err("failed parsing '%s' BTF file: %s", targ_btf_path, =
strerror(errno));
> >               goto err_out;
> >       }
> >
> > -     info->marked_btf =3D btf__parse(targ_btf_path, NULL);
> > +     info->marked_btf =3D btf__parse_split(targ_btf_path, base_btf);
> >       if (!info->marked_btf) {
> >               err =3D -errno;
> >               p_err("failed parsing '%s' BTF file: %s", targ_btf_path, =
strerror(errno));
> > @@ -2139,12 +2140,29 @@ static int btfgen_remap_id(__u32 *type_id, void=
 *ctx)
> >  /* Generate BTF from relocation information previously recorded */
> >  static struct btf *btfgen_get_btf(struct btfgen_info *info)
> >  {
> > -     struct btf *btf_new =3D NULL;
> > +     struct btf *btf_new =3D NULL, *src_base_btf_new =3D NULL;
> >       unsigned int *ids =3D NULL;
> > +     const struct btf *src_base_btf;
> >       unsigned int i, n =3D btf__type_cnt(info->marked_btf);
> > -     int err =3D 0;
> > +     int start_id, err =3D 0;
> > +
> > +     src_base_btf =3D btf__base_btf(info->src_btf);
> > +     start_id =3D src_base_btf ? btf__type_cnt(src_base_btf) : 1;
> >
> > -     btf_new =3D btf__new_empty();
> > +     /* clone BTF to sanitize a copy and leave the original intact */
> > +     if (src_base_btf) {
> > +             const void *raw_data;
> > +             __u32 sz;
> > +
> > +             raw_data =3D btf__raw_data(src_base_btf, &sz);
> > +             src_base_btf_new =3D btf__new(raw_data, sz);
> > +             if (!src_base_btf_new) {
> > +                     err =3D -errno;
> > +                     goto err_out;
> > +             }
> > +     }
> > +
> > +     btf_new =3D btf__new_empty_split(src_base_btf_new);
> >       if (!btf_new) {
> >               err =3D -errno;
> >               goto err_out;
> > @@ -2157,7 +2175,7 @@ static struct btf *btfgen_get_btf(struct btfgen_i=
nfo *info)
> >       }
> >
> >       /* first pass: add all marked types to btf_new and add their new =
ids to the ids map */
> > -     for (i =3D 1; i < n; i++) {
> > +     for (i =3D start_id; i < n; i++) {
> >               const struct btf_type *cloned_type, *type;
> >               const char *name;
> >               int new_id;
> > @@ -2213,7 +2231,7 @@ static struct btf *btfgen_get_btf(struct btfgen_i=
nfo *info)
> >       }
> >
> >       /* second pass: fix up type ids */
> > -     for (i =3D 1; i < btf__type_cnt(btf_new); i++) {
> > +     for (i =3D start_id; i < btf__type_cnt(btf_new); i++) {
> >               struct btf_type *btf_type =3D (struct btf_type *) btf__ty=
pe_by_id(btf_new, i);
> >
> >               err =3D btf_type_visit_type_ids(btf_type, btfgen_remap_id=
, ids);
>

