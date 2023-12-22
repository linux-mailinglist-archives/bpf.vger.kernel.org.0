Return-Path: <bpf+bounces-18574-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C9FC81C273
	for <lists+bpf@lfdr.de>; Fri, 22 Dec 2023 01:53:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F309A1F25AAE
	for <lists+bpf@lfdr.de>; Fri, 22 Dec 2023 00:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CF641873;
	Fri, 22 Dec 2023 00:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F7bMi2UG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32ADF1844
	for <bpf@vger.kernel.org>; Fri, 22 Dec 2023 00:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40d41555f9dso7940615e9.2
        for <bpf@vger.kernel.org>; Thu, 21 Dec 2023 16:53:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703206386; x=1703811186; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Ev0yx+zSWuWnYukCfgE+/Vfv6VmpR6GaBijlHfGytw=;
        b=F7bMi2UGEE4a2ep86avOoewjc3z2QGPF8TN2RbRf5gLUZnlupx2vBca1yahh7b7MFa
         ywPTbj+DqZMbiI6A2JSlIDlrkpsuXgtu23xcMU5y6avj2Z9vlDSodlNcvxiUWYK7w+Cd
         hbh7++6KF4jwW5YZe+RonnQj4u0JJFbYC71azg50T2XfgOEgynj0corO+lIfQA3aXxbL
         VI5KjJHP5lMTOHTe2HQf2mSzD8r2bgx8unbYR95nAUen9+/cwfW29rS4bUyF+UEUkvI/
         KRljvVP4AyedUg+Ydld3hxW+eQbaU7J3swrCzzA0hw3AGCbF/867cr2hzdxUuB6iG/za
         yIbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703206386; x=1703811186;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9Ev0yx+zSWuWnYukCfgE+/Vfv6VmpR6GaBijlHfGytw=;
        b=DVmRz46GVIGVewvAlGfrOXR9SolTvtV6pBByXF+7ZT/4CyUL/Jpsw/hkbMX0OZkluY
         cWuVl978Rne/IxQhmqJmrxcBucGb/vZIcTDk+QdCDely14l8zHHWhNOWBuLaxkaUrtML
         0e9qHLX+c0EQ9jnlOTR96B/5lqrwrN3bQu71YkLQJaWg/D3Fg2eHahuoZjXiRCzoFT0v
         v2DSsm2XdutseeHPgSd8N9k90KKo04pirhfMyBErrISQ71tcNJpKVXbO0NBkGRl6+00u
         uA49rnGlONpa2NjFevE+JKS9nbGy3LJgGtK6vr1KFoCPkC2x3zsmJZUCiG3e3EIUdRBl
         +Yuw==
X-Gm-Message-State: AOJu0YwJ/t/9RtnWP42E6VfXbgNK8LbdzdQvTkEW5pPTzf1GkuwYBirR
	di49O1IxdktWhBSh5vHuy5tDuK7wtiZaiGl1BLc=
X-Google-Smtp-Source: AGHT+IGfO1yF3PBBC9L0IqSZnppA7kKSUX+FYfec/JuogE+iqtl7CaJHl6qXUWnrqMo2hkb08d4sP9jjMc0Og7QXOb0=
X-Received: by 2002:a05:600c:33aa:b0:40d:3a34:82ef with SMTP id
 o42-20020a05600c33aa00b0040d3a3482efmr292375wmp.136.1703206386034; Thu, 21
 Dec 2023 16:53:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <421d18942d6ad28625530a8b3247595dc05eb100.1703110747.git.dxu@dxuuu.xyz>
 <62ytcwvqvnd5wiyaic7iedfjlnh5qfclqqbsng3obx7rbpsrqv@3bjpvcep4zme>
 <ZYP40EN9U9GKOu7x@krava> <CAADnVQJL7Yodi67f2A79Pah-Uek+WX66CVs=tAFAoYsh+t+3_Q@mail.gmail.com>
 <fecae4fe-b804-c7f5-1854-66af2f16a44a@oracle.com> <CAADnVQ+9PZvTc034oHa=7yQFPtyV=Yvjqef2+r97SyKFOgV=RA@mail.gmail.com>
 <yx7o3e4lep5fonxw26kltlbzysos3e5t4y54xwx6oiafggwfpg@b4kpw72xyhch>
In-Reply-To: <yx7o3e4lep5fonxw26kltlbzysos3e5t4y54xwx6oiafggwfpg@b4kpw72xyhch>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 21 Dec 2023 16:52:54 -0800
Message-ID: <CAADnVQL=8q_SxXkpUcwzkNzT8dqM0xufDLAeUojuHD9PBF4CkA@mail.gmail.com>
Subject: Re: [PATCH dwarves] pahole: Inject kfunc decl tags into BTF
To: Daniel Xu <dxu@dxuuu.xyz>
Cc: Alan Maguire <alan.maguire@oracle.com>, Jiri Olsa <olsajiri@gmail.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Quentin Monnet <quentin@isovalent.com>, 
	Andrii Nakryiko <andrii.nakryiko@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 21, 2023 at 10:18=E2=80=AFAM Daniel Xu <dxu@dxuuu.xyz> wrote:
>
> Hi Alexei,
>
> On Thu, Dec 21, 2023 at 10:07:33AM -0800, Alexei Starovoitov wrote:
> > On Thu, Dec 21, 2023 at 9:43=E2=80=AFAM Alan Maguire <alan.maguire@orac=
le.com> wrote:
> > >
> > > On 21/12/2023 17:05, Alexei Starovoitov wrote:
> > > > On Thu, Dec 21, 2023 at 12:35=E2=80=AFAM Jiri Olsa <olsajiri@gmail.=
com> wrote:
> > > >> you need to pick up only 'BTF_ID(func, ...)' IDs that belongs to S=
ET8 lists,
> > > >> which are bounded by __BTF_ID__set8__<name> symbols, which also pr=
ovide size
> > > >
> > > > +1
> > > >
> > > >>>
> > > >>> Maybe we need a codemod from:
> > > >>>
> > > >>>         BTF_ID(func, ...
> > > >>>
> > > >>> to:
> > > >>>
> > > >>>         BTF_ID(kfunc, ...
> > > >>
> > > >> I think it's better to keep just 'func' and not to do anything spe=
cial for
> > > >> kfuncs in resolve_btfids logic to keep it simple
> > > >>
> > > >> also it's going to be already in pahole so if we want to make a fi=
x in future
> > > >> you need to change pahole, resolve_btfids and possibly also kernel
> > > >
> > > > I still don't understand why you guys want to add it to vmlinux BTF=
.
> > > > The kernel has no use in this additional data.
> > > > It already knows about all kfuncs.
> > > > This extra memory is a waste of space from kernel pov.
> > > > Unless I am missing something.
> > > >
> > > > imo this logic belongs in bpftool only.
> > > > It can dump vmlinux BTF and emit __ksym protos into vmlinux.h
> > > >
> > >
> > > If the goal is to have bpftool detect all kfuncs, would having a BPF
> > > kfunc iterator that bpftool could use to iterate over registered kfun=
cs
> > > work perhaps?
> >
> > The kernel code ? Why ?
> > bpftool can do the same thing as this patch. Iterate over set8 in vmlin=
ux elf.
>
> I think you're right for vmlinux -- bpftool can look at the elf file on
> a running system. But I'm not sure it works for modules.
>
> IIUC, the actual module ELF can go away while the kernel holds onto the
> memory (as with initramfs). And even if that wasn't the case, in
> containerized environments you may not be able to always see
> /lib/modules or similar.

Indeed. Access to .ko files may be difficult even for full root
without containers.

What is vmlinux BTF before/after for our current set of kfuncs ?

