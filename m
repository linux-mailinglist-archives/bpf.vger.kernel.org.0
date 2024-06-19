Return-Path: <bpf+bounces-32493-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB84590E285
	for <lists+bpf@lfdr.de>; Wed, 19 Jun 2024 07:03:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D72D2847E1
	for <lists+bpf@lfdr.de>; Wed, 19 Jun 2024 05:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7899D4D8B0;
	Wed, 19 Jun 2024 05:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jbOJNyh7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C2902594;
	Wed, 19 Jun 2024 05:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718773386; cv=none; b=drbdS5gtu/gi8+sV91415ow+lirpjhc3DRyi4VCg5cpO+eBrrYlozM2XUH+kWVQ6PCLTIR7kylQn2b5umZP3TVxBuuvCGZhxrICbR+msVJoZiPV/7fC2rvuO+3aTaCds+u42fLkGIxuY6tOYGUHBb3n4YzzIRxqWEHGyl/FIwik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718773386; c=relaxed/simple;
	bh=lhvqqfGGA0QIMQ8HwR9cPgsgNwiIAmIJK3KvxrW/yR0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n/hpgLssqbmN4Tb2extjsMfqE+AePNXpFZksLX9DRbErkMJcKWcLvG/70nV8q+hWSABw+xZ/pWeG1yR2TU1IqpXJJELF8Za0a2uxpF0Ltpu1oIjjwe5CzvpsmWxYqTDi0+5VIa3lvy1tPsUjQ+Kz0SSg7/etoOEV9OrjoUOnit8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jbOJNyh7; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-57d0eca877cso401493a12.2;
        Tue, 18 Jun 2024 22:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718773382; x=1719378182; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ikuWbO4N3rOl4heKdv6o3L7IaRNt5xUUB7DWas6ol/Y=;
        b=jbOJNyh7VH+RDPTTmPlEBFKrpnN3ma2tCBZnlM+OVhriIT/ygwYYVtspGutB6VlB1M
         F0XWdA1QXUDJWw6BsCkcLqv1MmQ6gqtE/AmVkzzmfmOzecEHmb1ZA8wDZsmhQQh4EvIu
         MWSPezN4RgCZmZtjz5KMVRz6O959EPN5rlSplpVLWNtmQCEWZvKbkjDJWSwsrR43CeSP
         EwpDdByoTMgzFZ1hSOmf4yykWAb+Vy4PvnfeHu7qyV7dq+FjF55K2FHWocSnNwMrSRna
         InlibDqKFqhPGxy5o4PZnbUop5auxzXWw/YN3G01uVS/+nbtMes1YVNYTKRgEZ6wdMj+
         pTpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718773382; x=1719378182;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ikuWbO4N3rOl4heKdv6o3L7IaRNt5xUUB7DWas6ol/Y=;
        b=dbnkq+KGTMBUhHylXkMYp8eKULwltU/kJnTnH3Kmv9POYMzKPLM0oNluoAscCLJISB
         3oY87UvKbvh5Hf39dGVLgt0+zfxgrWqdYjRIuNHSHXr2M0IIcWkurOIYFIQCVKhMSb3J
         XNnC/LvWRlw6uMkZ0knEusF3GmnS0UwpSUXq3bLXfqAWUpy/ipQzSULKtLBTQKIQNX9j
         vlqu+W8JqNsHcoQP4YHSY5m50aYn5Z0AX5zrMc5nAszGwnSH9dzGKUluPrwvKxjoua9z
         Cb+qkRl/lSVM9fz2h8wT8E76uBok+ZXJt/5lpbbGNjPT/NXNey/3KX8g76H+AovEkzaM
         GAHg==
X-Forwarded-Encrypted: i=1; AJvYcCW/Kwq3bdy0OqwNpnqoGvQLdqTglzC8pvI05ptkJ39Y5TrgqVMbnSxQnmAEIbF5sHqKvNSJif0f8E01YrYusGuTBNWz3prErvd1jrQ8XLH7Smkqfju8b9aKW8xGdMwPKDkR
X-Gm-Message-State: AOJu0YzCsH9rJeb90TgSttAW1HOK4WGctyUbBwsQs3fqpTcGtRHS9CFh
	ENIjFu5zCqwwNIPcoGLkr0gGAbZon/9Q0shmzjdJcUC2BYS+G+Vwb/UMag2c1bgZmATQRlZnBA6
	DYBiqtV1d4XVFd20443ITpmVGLAg=
X-Google-Smtp-Source: AGHT+IE2BiDsV+utLSWjYnZgyY9UQHXsBCzqdQy3dxr04YjThqPebZZCiY9kUfa/9GKKQJ0hQhyZfY+1k4iZM9rXQEo=
X-Received: by 2002:a50:d643:0:b0:574:f27a:b3ec with SMTP id
 4fb4d7f45d1cf-57d07e7c4fbmr848818a12.16.1718773382063; Tue, 18 Jun 2024
 22:03:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240616002958.2095829-1-dolinux.peng@gmail.com> <0c0ef20c-c05e-4db9-bad7-2cbc0d6dfae7@oracle.com>
In-Reply-To: <0c0ef20c-c05e-4db9-bad7-2cbc0d6dfae7@oracle.com>
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Wed, 19 Jun 2024 13:02:46 +0800
Message-ID: <CAErzpmud7mhFX=+GXgHkDrqSivAgffGcdga5QuoYXjOxJpZUzQ@mail.gmail.com>
Subject: Re: [PATCH] libbpf: checking the btf_type kind when fixing variable offsets
To: Alan Maguire <alan.maguire@oracle.com>
Cc: ast@kernel.org, daniel@iogearbox.net, song@kernel.org, andrii@kernel.org, 
	eddyz87@gmail.com, haoluo@google.com, yonghong.song@linux.dev, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 17, 2024 at 7:29=E2=80=AFPM Alan Maguire <alan.maguire@oracle.c=
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

Yes, I agree.

>
> > Fixes: 8fd27bf69b86 ("libbpf: Add BPF static linker BTF and BTF.ext sup=
port")
> > Signed-off-by: Donglin Peng <dolinux.peng@gmail.com>
>
> A few small things below, but
>
> Reviewed-by: Alan Maguire <alan.maguire@oracle.com>

Thanks.

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

Thanks, I will update in v2.

>
> We handle the func case elsewhere in libbpf (see add_dummy_ksym_var()).
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

