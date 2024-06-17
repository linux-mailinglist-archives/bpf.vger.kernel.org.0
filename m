Return-Path: <bpf+bounces-32346-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F412D90BC62
	for <lists+bpf@lfdr.de>; Mon, 17 Jun 2024 22:52:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F3461F23BAB
	for <lists+bpf@lfdr.de>; Mon, 17 Jun 2024 20:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 245A91991D3;
	Mon, 17 Jun 2024 20:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eUfhxj/g"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C45D1991BA;
	Mon, 17 Jun 2024 20:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718657532; cv=none; b=cOcTYzU2U145MuyvqOVTZumTL8u7V3jdI2tvh1u3WzCvaQ5Yz0F3hAQ5W9rrvpTDeJKgQUgA0b1+g/+/JVgl4balgFGdfUyb1fqDs2uZPjX73Y6fW7On/c10N/nFOPvRP32u9Oa1eXflJyrbp1ZANggJVCPt8e7VKDwSmBYsAPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718657532; c=relaxed/simple;
	bh=zcanO53Fs25ZrkOYOW+fdqjtQubKpTDDsW2xHLAmWxg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PSleVUEE7OI3pYVid8PXUunoGgD+edloC1cIUJj8t1xTm4kyROJyjZPpd/vdyNEPpu/Si5osFJ03x6CUEZaWI5k8ehSMdsiy4TtjkGM/vwhsKOxpmnp5G/7b2WkwcvDxMLyavGrZ4LoBMl+6BHnzBRjMkSkiEPED4ztmux0zPcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eUfhxj/g; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-6e40d54e4a3so3551719a12.0;
        Mon, 17 Jun 2024 13:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718657530; x=1719262330; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oli3uuF089SJltioD/IUi09aQNwzfe30s6Lej3nfrwk=;
        b=eUfhxj/ghSta6zEPPcWObPQ3QG8UABi9svPdysymcTxp00J8DZv/8ceGDHwWqER7sK
         O7mptO0XRs9xNCSl8Sl7nAMrDgxGuHWrdV9tooTbP+NGyyCXOYMb/CG4XfOa3X68UxC8
         ino9tG56XEdxehUBBA/zz1G4WAi89jscEaEKXlt4XvzdPhWKUYzwY9zXTsd9ig6Tvjdi
         whpjB3KufbrqwchrHwsoo9eIPn3ueMiVQ3fW3ekiJXMGl1Gqjxl36kgusOS+uve5O4GZ
         ilWVnvA2AzKjkUmNquGV0/9f2QxnpAQRT41nt2du0Z06zHEC+7JCHPvDR8qCHs86XIe1
         7HEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718657530; x=1719262330;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oli3uuF089SJltioD/IUi09aQNwzfe30s6Lej3nfrwk=;
        b=MesJ/YcbFnfzjcCia7wMWUQY6JMxTsnI8iHXqYVAaTKxZEpbFSOdHabqsVxXRleKvE
         zN0bg4C/XOYVHZI62xyw2A0BIPOQdfWycvyC/V6DHXylRAjpPAV6aUMa8C24RIStfqxX
         R3yF+kF1E5D6ezPR/R9zgqR8PdqQWrcqumXdPKHa581Unr5DZykASgqyOvKWtQwq3M5g
         OUhNdbgEkNpAjZ1J/rumKu9DT5u9uyuB0QUholIqVmXmkYuAs/AEL/qoJ6Znu/9pVpDL
         ncB1TSLaaoSAMxYgIFGlapnG+dQLDum3o9mo9PTSLvB/lRHRFLnbzE1mIG+zgPTBa4Zs
         fu3g==
X-Forwarded-Encrypted: i=1; AJvYcCWuok+IoV/NzKPawCZnOXnmfYABBeVfwFxjQWSdMvnyXnUG2Wgq27Jcc4UwUIKnS9x+bes4KVuvmlG5kiKaMa69vEpk5pyVNuCcPTskLv4SFJJAv8IJmCcf5w5jjEpxeQFs
X-Gm-Message-State: AOJu0YwsgPgbOyfuqWohJctuX1lSJf1y/hIvoWjIgDyAFobn5BgPk50a
	KNmMDDDC/9f/T+1NMyuKcRWLhB3+ejgy0rMytp/s20/vXhWDaytN2fDnbCeXznxuJdw+4FcxDXY
	V7RmCaWlejy6aNc6Myc0xZcXX6DI=
X-Google-Smtp-Source: AGHT+IEJIrTstkbjjscGXgnjLbg7YsaEEQf0FR7mXNw/ZyrDzBusBygI7mkE9NEVXFWohHASoEy88+jouqYSRE3SBf4=
X-Received: by 2002:a17:90a:65ca:b0:2c4:dc4d:83da with SMTP id
 98e67ed59e1d1-2c4dc4d8460mr9652820a91.10.1718657530367; Mon, 17 Jun 2024
 13:52:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240616002958.2095829-1-dolinux.peng@gmail.com> <0c0ef20c-c05e-4db9-bad7-2cbc0d6dfae7@oracle.com>
In-Reply-To: <0c0ef20c-c05e-4db9-bad7-2cbc0d6dfae7@oracle.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 17 Jun 2024 13:51:58 -0700
Message-ID: <CAEf4BzY=7vxFsF14c=xYN0FmNo35+9z5dHrgdB5UB67nigy+ew@mail.gmail.com>
Subject: Re: [PATCH] libbpf: checking the btf_type kind when fixing variable offsets
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Donglin Peng <dolinux.peng@gmail.com>, ast@kernel.org, daniel@iogearbox.net, 
	song@kernel.org, andrii@kernel.org, eddyz87@gmail.com, haoluo@google.com, 
	yonghong.song@linux.dev, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 17, 2024 at 4:30=E2=80=AFAM Alan Maguire <alan.maguire@oracle.c=
om> wrote:
>
> On 16/06/2024 01:29, Donglin Peng wrote:
> > I encountered an issue when building the test_progs using the repositor=
y[1]:
> >
> > $ clang --version
> > Ubuntu clang version 17.0.6 (++20231208085846+6009708b4367-1~exp1~20231=
208085949.74)
> > Target: x86_64-pc-linux-gnu
> > Thread model: posix
> > InstalledDir: /usr/bin
> >
> > $ pwd
> > /work/Qemu/x86_64/linux-6.10-rc2/tools/testing/selftests/bpf/
> >
> > $ make test_progs V=3D1
> > ...
> > /work/Qemu/x86_64/linux-6.10-rc2/tools/testing/selftests/bpf/tools/sbin=
/bpftool
> > gen object
> > /work/Qemu/x86_64/linux-6.10-rc2/tools/testing/selftests/bpf/ip_check_d=
efrag.bpf.linked2.o
> > /work/Qemu/x86_64/linux-6.10-rc2/tools/testing/selftests/bpf/ip_check_d=
efrag.bpf.linked1.o
> > libbpf: failed to find symbol for variable 'bpf_dynptr_slice' in sectio=
n
> > '.ksyms'
> > Error: failed to link
> > '/work/Qemu/x86_64/linux-6.10-rc2/tools/testing/selftests/bpf/ip_check_=
defrag.bpf.linked1.o':
> > No such file or directory (2)
> > make: *** [Makefile:656:
> > /work/Qemu/x86_64/linux-6.10-rc2/tools/testing/selftests/bpf/ip_check_d=
efrag.skel.h]
> > Error 254
> >
> > After investigation, I found that the btf_types in the '.ksyms' section=
 have a kind of
> > BTF_KIND_FUNC instead of BTF_KIND_VAR:
> >
> > $ bpftool btf dump file ./ip_check_defrag.bpf.linked1.o
> > ...
> > [2] DATASEC '.ksyms' size=3D0 vlen=3D2
> >         type_id=3D16 offset=3D0 size=3D0 (FUNC 'bpf_dynptr_from_skb')
> >         type_id=3D17 offset=3D0 size=3D0 (FUNC 'bpf_dynptr_slice')
> > ...
> > [16] FUNC 'bpf_dynptr_from_skb' type_id=3D82 linkage=3Dextern
> > [17] FUNC 'bpf_dynptr_slice' type_id=3D85 linkage=3Dextern
> > ...
> >
> > To fix this, we can a add check for the kind.
> >
> > [1] https://github.com/eddyz87/bpf/tree/binsort-btf-dedup
> > Link: https://lore.kernel.org/all/4f551dc5fc792936ca364ce8324c0adea3816=
2f1.camel@gmail.com/
> >
>
> The fix makes sense; what I was trying to figure out is why we're only
> seeing this now with the above repo.
>
> So as I understand it, the reason the kfuncs end up in the .ksyms
> section is due to the "__weak __ksym" tagging recently added to
> vmlinux.h construction from BTF via
>
> 770abbb5a25a ("bpftool: Support dumping kfunc prototypes from BTF")
>
> We see as noted
>
> [112] DATASEC '.ksyms' size=3D0 vlen=3D2
>         type_id=3D84 offset=3D0 size=3D0 (FUNC 'bpf_dynptr_from_skb')
>         type_id=3D90 offset=3D0 size=3D0 (FUNC 'bpf_dynptr_slice')
>
> So that makes sense, but prior to the above series, we also tagged
> kfuncs in this way before via bpf_kfuncs.h. So there should be no
> difference there.
>
> And with an upstream kernel I don't run into this problem.
>
> The only thing I could come up with is we were usually lucky; when we
> misinterpreted the func as a var and looked its type up, we got
>
>                 int var_linkage =3D btf_var(vt)->linkage;
>
> ...and were lucky it never equalled 1 (BTF_VAR_GLOBAL_ALLOCATED):
>
>                 /* no need to patch up static or extern vars */
>                 if (var_linkage !=3D BTF_VAR_GLOBAL_ALLOCATED)
>                         continue;
>
> In the case of a function, the above btf_var(vt) would really be
> pointing at the struct btf_type immediately after the relevant
> function's struct btf_type (since unlike variables, functions don't have
> metadata following them). So the only way we'd trip this bug would be if
> the struct btf_type following the func was had a name_off value that
> happened to equal 1 (BTF_VAR_GLOBAL_ALLOCATED).
>
> So maybe the sorting changes to BTF order resulted in us tripping on
> this bug, but regardless the fix seems right to me.
>
> > Fixes: 8fd27bf69b86 ("libbpf: Add BPF static linker BTF and BTF.ext sup=
port")
> > Signed-off-by: Donglin Peng <dolinux.peng@gmail.com>
>
> A few small things below, but
>
> Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
>
> > ---
> >  tools/lib/bpf/linker.c | 11 +++++++++--
> >  1 file changed, 9 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/lib/bpf/linker.c b/tools/lib/bpf/linker.c
> > index 0d4be829551b..7f5fc9ac4ad6 100644
> > --- a/tools/lib/bpf/linker.c
> > +++ b/tools/lib/bpf/linker.c
> > @@ -2213,10 +2213,17 @@ static int linker_fixup_btf(struct src_obj *obj=
)
> >               vi =3D btf_var_secinfos(t);
> >               for (j =3D 0, m =3D btf_vlen(t); j < m; j++, vi++) {
> >                       const struct btf_type *vt =3D btf__type_by_id(obj=
->btf, vi->type);
> > -                     const char *var_name =3D btf__str_by_offset(obj->=
btf, vt->name_off);
> > -                     int var_linkage =3D btf_var(vt)->linkage;
> > +                     const char *var_name;
> > +                     int var_linkage;
> >                       Elf64_Sym *sym;
> >
> > +                     /* should be a variable */
> > +                     if (btf_kind(vt) !=3D BTF_KIND_VAR)
>
> nit: could use if (!btf_is_var(vt)) here instead. It might also be worth
> reworking the comment to acknowledge that we can legitimately have a
> function in this section; i.e. something like
>
>                         /* could be a variable or function */
>
> We handle the func case elsewhere in libbpf (see add_dummy_ksym_var()).

Let's go a half-step further and validate that we see either VAR or
FUNC and for anything unexpected error out loudly, so this is brought
to someone's attention sooner?

Something like:

if (btf_is_func(vt))
    continue; /* FUNC doesn't need adjustment */
if (!btf_is_var(vt)) {
    pr_warn(<helpful and descriptive enough message about unexpected type>)=
;
    return -EINVAL;
}

(use btf_kind_str() for error string, btw)

pw-bot: cr

>
>
> > +                             continue;
> > +
> > +                     var_name =3D btf__str_by_offset(obj->btf, vt->nam=
e_off);
> > +                     var_linkage =3D btf_var(vt)->linkage;
> > +
> >                       /* no need to patch up static or extern vars */
> >                       if (var_linkage !=3D BTF_VAR_GLOBAL_ALLOCATED)
> >                               continue;

