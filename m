Return-Path: <bpf+bounces-58851-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9596DAC28BE
	for <lists+bpf@lfdr.de>; Fri, 23 May 2025 19:34:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A78CBA2325A
	for <lists+bpf@lfdr.de>; Fri, 23 May 2025 17:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F1A429898C;
	Fri, 23 May 2025 17:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ljrsEygJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87992298271
	for <bpf@vger.kernel.org>; Fri, 23 May 2025 17:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748021666; cv=none; b=NR+udK+M0bliFT5yOJtR6YRH7V1UjFNy7J5CULV8rva9W1BMspVBLk38c2MfDwlRwyVZ15kFAdrW6fudtQ68cqxs0lZjIOCp8518PumgQOavFQKdZI+nm3WCp+hFk7HB+wSLLUWhvbC0dGFqk+URA9F+v18GFpR28QKCe5K0j4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748021666; c=relaxed/simple;
	bh=+7wR1aOIjJQ1iPUOKO3UqokMMfnNqopbQQ7hiwfN6vM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LnkkwPorcqVPPHJBkYbxHHafuWHc+oCGTsejPOt2b3qhoeU+4T7Ozlgbwu0IjS6KidhzQevBd/p+NWOYZv7YceSD0h2sPY3yRXJ/yg9c705r1RPx1V2PArqBAwvM63JBz9QHFSAcVFtQ+x0ONKIhjsrTA4JFBu7mfnaXEZAFQow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ljrsEygJ; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b1396171fb1so50757a12.2
        for <bpf@vger.kernel.org>; Fri, 23 May 2025 10:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748021664; x=1748626464; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uQBogeE8pzxbwI3Vp9b79+QtByQBweZWOgw34mVpx+o=;
        b=ljrsEygJ4DI/tnZ+swhub/tbiqPHKnypvmdkUwo9xUKS/LMQLic/IUfjwm0tlkgxcQ
         81pV56FF0Umi1sMDMCn+OTZR8VLfj45Kbs/5NMkbi4cDgR8uUDyQ0962hcGB64YKn+ng
         r0x4VnWBRvHFfNoHKBm6GpWnn5Bli3K3+tniBk3vapWBNXy0exA43OWEhXFHeZEFo1Nj
         G5rFjnTIQSIGskn/rpG12P4bjBkgTIk8zj0o8aQUmPyOFX3Xs18jnnU8/CshC0CfZceR
         YaWp0FUPCg01ePCq5fUnjvZanLwVqOfc+f1/aU/10sN8PEaaQPN0+/sBmDBzUzhHJXnl
         Jh4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748021664; x=1748626464;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uQBogeE8pzxbwI3Vp9b79+QtByQBweZWOgw34mVpx+o=;
        b=NU1GraM4OEHY2tExbVOGOYYMwJ8gYoK9kMLYrMCxc8VTbpFit/8wlCIwGcm1c/xLyn
         kpmHU32h3NpNepZhiHxNTjlGQFUOWfUPJVhY0iqiiAQVI6jMQ6+F0hmUwJdJqxRsvj04
         ilnp1sYXiAD6rq6W8sQ2xjtipMNiAAkX9O4ajaCMT42fcFZuDhFNB/mlwjaEXYbxM4Wm
         9dZ41OfhhnWJHDKq5IR+mzkqmfQK8nFhBMa/NubqKqx6AO9sgw8UhHxmadE4umqRKIRZ
         sZpLeur4RzRKUVPPY02FgckooXmTjiFaTDFSrSR+NynNMdMCycpizVjYQtL+iJ+26RDf
         K+Ew==
X-Gm-Message-State: AOJu0Yw1GB/oq+elCdMroKr73c6vEJBW0rJmnXf326KKlfdpGYYgDSoi
	NMEt8MSQ7R0ffFPhgu1dmfnE4l1MI9JaphI2HBUbWCYVG6kEOBWrVqsy2BD7Lkjkak5OK7ZRLCw
	wgYGU/VHFUsQdZREkCV6+WMqGoKCmorQibMnP
X-Gm-Gg: ASbGncuXghPylo7GhJ06fgZLcD5Zfe9bP7rUtczneh1ZHwsIHzoTI0qPeFN3xAHovze
	FExZ4px/Qld7tARwqZt3HlWzLyKHmNuqBxiQwNn8FcrGp2U0i9n+eVFYJJMc1l4y934z8rXvtsJ
	eciDZRFgi8uXW/cg/fGMwe2emnP+sm1MPktRtU8NJorKTQ6Dw=
X-Google-Smtp-Source: AGHT+IGgu5JPBpuD/z9ZKL6Y385s/6lxISOQbOYhR2MblM5vhLa4Kd+/M+PvcN98gMZQ5rh9nkeT+ffly1NAKclepjM=
X-Received: by 2002:a17:90b:3c03:b0:310:8d4a:a275 with SMTP id
 98e67ed59e1d1-310e96e7402mr8042152a91.18.1748021663631; Fri, 23 May 2025
 10:34:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250522062116.1885601-1-tony.ambardar@gmail.com>
 <CAEf4BzYuVzgDPAPtp6WPshf369dw3unuCruQADZd3DSrSwUNOQ@mail.gmail.com> <aDAcrlDkePRcC7bw@kodidev-ubuntu>
In-Reply-To: <aDAcrlDkePRcC7bw@kodidev-ubuntu>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 23 May 2025 10:34:11 -0700
X-Gm-Features: AX0GCFuWQT61oaZRBRCZYJoKvuWIIzCDMJsyvOH9uyxVucw8JFj-2dS-WFkkJKc
Message-ID: <CAEf4BzazK2OwLPj-mPT6P4V2H+6hD4bi-QxebmhnGEc9UbHcUA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1] libbpf: Fix inheritance of BTF pointer size
To: Tony Ambardar <tony.ambardar@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 22, 2025 at 11:58=E2=80=AFPM Tony Ambardar <tony.ambardar@gmail=
.com> wrote:
>
> On Thu, May 22, 2025 at 09:37:39AM -0700, Andrii Nakryiko wrote:
> > On Wed, May 21, 2025 at 11:21=E2=80=AFPM Tony Ambardar <tony.ambardar@g=
mail.com> wrote:
> > >
> > > Update btf_new_empty() to copy the pointer size from a provided base =
BTF.
> > > This ensures split BTF works properly and fixes test failures seen on
> > > 32-bit targets:
> > >
> > >   root@qemu-armhf:/usr/libexec/kselftests-bpf# ./test_progs -a btf_sp=
lit
> > >   __test_btf_split:PASS:empty_main_btf 0 nsec
> > >   __test_btf_split:PASS:main_ptr_sz 0 nsec
> > >   __test_btf_split:PASS:empty_split_btf 0 nsec
> > >   __test_btf_split:FAIL:inherit_ptr_sz unexpected inherit_ptr_sz: act=
ual 4 !=3D expected 8
> > >   [...]
> > >   #41/1    btf_split/single_split:FAIL
> > >
> >
> > Hm... can you debug it a little bit, please? I see that
> > btf__pointer_size() on split BTF will do determine_ptr_size() call,
> > which will do
> >
> > if (btf->base_btf && btf->base_btf->ptr_sz > 0)
> >     return btf->base_btf->ptr_sz;
> >
> > So it looks intentional (though I can't claim I remember much of the
> > details by now) that we don't proactively cache btf->ptr_sz when
> > creating a new split BTF, but it should have resolved into base's
> > pointer size. And if it doesn't, let's try to understand why?
> >
>
> Because ptr_sz of new splits is initialized in btf_new_empty() with
>
>     btf->ptr_sz =3D sizeof(void *);
>
> and base BTF ignored. Thus btf->ptr_sz is non-zero, determine_ptr_size()
> does not get called from btf__pointer_size(), and tests pass because BPF
> CI validates only 64-bit targets with no 32-bit coverage.
>
> Even with my patch, the ptr_sz code seems problematic and open to abuse.
> It appears btf__set_pointer_size() can separately apply different ptr
> sizes to base and split BTF, and btf__pointer_size() will likewise return
> them.
>
> Thinking out loud, maybe we just set btf->ptr_sz =3D 0 for all splits. Th=
en
> make btf__set_pointer_size() recur to update only the ultimate base BTF,
> and btf__pointer_size() does the same, calling determine_ptr_size() if
> base BTF ptr_sz =3D=3D 0. That keeps ptr_sz consistent across multiple sp=
lits
> I think. Oh, and then add 32-bit and cross-endian CI targets... :-)
>
> WDYT?

Yes, that eager btf->ptr_sz assignment in btf_new_empty() looks like a
bug, as you said, we should keep it at zero and let either user set it
or it should be inferred from data, eventually.

As for btf__set_pointer_size(), we either need to recursively set it,
as you said. Or, alternatively, only allow to set it through split BTF
if none of base BTFs have it explicitly set already. Not exactly sure
which semantics makes most sense, but I think we should consider both
options and pick the best one.

>
> > > Fixes: ba451366bf44 ("libbpf: Implement basic split BTF support")
> > > Signed-off-by: Tony Ambardar <tony.ambardar@gmail.com>
> > > ---
> > >  tools/lib/bpf/btf.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> > > index 8d0d0b645a75..b1977888b35e 100644
> > > --- a/tools/lib/bpf/btf.c
> > > +++ b/tools/lib/bpf/btf.c
> > > @@ -995,6 +995,7 @@ static struct btf *btf_new_empty(struct btf *base=
_btf)
> > >
> > >         if (base_btf) {
> > >                 btf->base_btf =3D base_btf;
> > > +               btf->ptr_sz =3D base_btf->ptr_sz;
> > >                 btf->start_id =3D btf__type_cnt(base_btf);
> > >                 btf->start_str_off =3D base_btf->hdr->str_len + base_=
btf->start_str_off;
> > >                 btf->swapped_endian =3D base_btf->swapped_endian;
> > > --
> > > 2.34.1
> > >

