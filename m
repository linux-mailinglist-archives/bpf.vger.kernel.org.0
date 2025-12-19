Return-Path: <bpf+bounces-77118-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 086EDCCE4D6
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 03:53:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 742543011791
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 02:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70AA72877EA;
	Fri, 19 Dec 2025 02:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gjo4eNzV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 278681885A5
	for <bpf@vger.kernel.org>; Fri, 19 Dec 2025 02:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766112806; cv=none; b=AcbRiP4y20ZRhEaZMAL1A2DCLpSKVcCDT+MxjX+VvYQlYSZKlVb+CEUoF//Ygr2d/4qD2R0Vua6zp1VgXb9pjJv6SAQ9hKThTnb/jIfDLndxxKuxIGMXj8fFJGRpIock8BtfEPIQrKutN9RehclriiPhOjjTm3HpFm04uFmahdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766112806; c=relaxed/simple;
	bh=rFzWaj7kYqjjFJCcRm1VVPakvZUq783NZWKrRXqkBk0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ee3qzrDJMw7HajqV2hIU+WcCiosXyWZivL3SZM8ZAquDd8mpMLTHehayDuQVQ2SeDAxcEpUjd0E526WNhc2kpXUj33yF1VbxKOcAqmWELua6t6zPcjcgah89n9875q7+4fXaZnDzaICY6LrZj9fMPIOT4/gjMbsKXgILcHD/EOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gjo4eNzV; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b7ce5d6627dso82486666b.2
        for <bpf@vger.kernel.org>; Thu, 18 Dec 2025 18:53:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766112802; x=1766717602; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PS3HwyQrZxvKM3plwpPweCJI8T5isKuKcpejOQkhCXk=;
        b=Gjo4eNzVcwn+mIe0YwnU3Gt8RNJGkbAurL6dxEHm70yQDnK3gPlTWJOdIODKV/ElY8
         nXtiCyRhOn7eGAxCzbKxQEw/eWsJryg6KxobuU1DPDE5qTHBtzUkv3oDexVHAiM25T2m
         ssvewxHr6dTSR51YwauVzELlPWLIKub1nOoh7nwdp0cT/jaTXWrDoQde+DtQJRvbFhR+
         /7orCPJnIK6W0+LL15LrOuuKSnd5sn20n+NmKHJXYUhIxNa/KyJRUv7p0djK6Hcu1KQO
         bhFMZD2UVtdxGSZQre5UwEkrO8A3Zw7wxG/Ef+uBx6xNjnjnTNLVlOixoA8RZQWuthUl
         1+hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766112802; x=1766717602;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PS3HwyQrZxvKM3plwpPweCJI8T5isKuKcpejOQkhCXk=;
        b=i14Pnd5c8c5PbK9v+UMUzA+w4kzapg+GW8zHFo70pQyaGLFloiUHNxd574kV+6KvUu
         2YZI9B/GSdhmiO2V0MH/dW7CD5w/neQSDYrpfPfepwc81380agOJpq39MOGjddvzCK3L
         eJB+gsw6rejpE2gT+Kjr9QVk7TnUHWXB6eeI4g4nppyJ9rYuATdzZYiWtxwI2vyRthfi
         5rMynGBCfETSBYzSvPwrppAZqxXEzDYN3HzT/MPygToMJgt2n4OaM4vkAi3zbSERYFGM
         Yp+Gl/q/robqYEQ2jCV7cohuUbWlPY+MKfGuD0ajVbmQtRReqsAGfUiy0zpvn3ipWBmY
         8kzw==
X-Forwarded-Encrypted: i=1; AJvYcCVCtZBhlgNXDJlbdNrT3VS521CLYJb3fDduhVZFqldoBEQR3SkgxLuOBSwJdY9Is/PT1XI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjjBt3uzGwrs0f94roNn9D4HWbXzzqRVHyNbpQYOkEY2Rtq9Go
	82HtAE2nvxqGApd08b1gq93yGBlYxKxTnPD6fHZtjEk0POfi/QY8Ebyq6ZC0X6RBND1GeINsHTs
	JgzBuArtdZ3mZzS/IGIQVtvgfUhebPzU=
X-Gm-Gg: AY/fxX4hSFZaExXFbHajkyHhABLuXG2t//FchlD0Tls8tZLrt4beUn1r0LNEIQWUjVU
	toW0oAFg0kOXGZKPETsSIwT8N/qqumVC/Jyo7+A3C2nqVtPK+LCsuihViBBIZHzEsGSbQ3HGcqy
	zH+kNf+VAg438O1qhElncmlkvEvO/ncbwPGCKGGHYj4pFcJ3mJ58LEXl5pITXhcji24tb7ON+wQ
	b/X5dqqJvyaTI5jYVhZ563q7AQ/fwQupd86GrkAv/fLDdaGkNfYtOS73qnI4x/KrAa1kPCl
X-Google-Smtp-Source: AGHT+IFlLoOljgENFO28ybZWRP0IDlfx+LskW/UuJ+lxrfaKJNw4jVegcvArxulDbOJID+kafrLIZAgn8aPiFOIfhqA=
X-Received: by 2002:a17:906:d555:b0:b71:1164:6a8b with SMTP id
 a640c23a62f3a-b8036f0a399mr109680566b.7.1766112802265; Thu, 18 Dec 2025
 18:53:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251218113051.455293-1-dolinux.peng@gmail.com>
 <20251218113051.455293-5-dolinux.peng@gmail.com> <CAEf4BzbSMwW4es5D9i=bpSjALo8u+oW-9vdQ7=DBoTBtMoJ1Tg@mail.gmail.com>
In-Reply-To: <CAEf4BzbSMwW4es5D9i=bpSjALo8u+oW-9vdQ7=DBoTBtMoJ1Tg@mail.gmail.com>
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Fri, 19 Dec 2025 10:53:10 +0800
X-Gm-Features: AQt7F2qrKRe-n4IYC2gA7ISaym3O_e6mQwketqla1J146ZnnKmCn-_kV0unfmRU
Message-ID: <CAErzpmv1N1JA+=c6xxdYTqANqSBRaRauD2wzZiwUS+VeWQG14A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v10 04/13] libbpf: Optimize type lookup with
 binary search for sorted BTF
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: ast@kernel.org, eddyz87@gmail.com, zhangxiaoqin@xiaomi.com, 
	ihor.solodrai@linux.dev, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	pengdonglin <pengdonglin@xiaomi.com>, Alan Maguire <alan.maguire@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 19, 2025 at 7:29=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, Dec 18, 2025 at 3:31=E2=80=AFAM Donglin Peng <dolinux.peng@gmail.=
com> wrote:
> >
> > From: pengdonglin <pengdonglin@xiaomi.com>
> >
> > This patch introduces binary search optimization for BTF type lookups
> > when the BTF instance contains sorted types.
> >
> > The optimization significantly improves performance when searching for
> > types in large BTF instances with sorted types. For unsorted BTF, the
> > implementation falls back to the original linear search.
> >
> > Cc: Eduard Zingerman <eddyz87@gmail.com>
> > Cc: Alexei Starovoitov <ast@kernel.org>
> > Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> > Cc: Alan Maguire <alan.maguire@oracle.com>
> > Cc: Ihor Solodrai <ihor.solodrai@linux.dev>
> > Cc: Xiaoqin Zhang <zhangxiaoqin@xiaomi.com>
> > Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
> > ---
> >  tools/lib/bpf/btf.c | 103 ++++++++++++++++++++++++++++++++++----------
> >  1 file changed, 80 insertions(+), 23 deletions(-)
> >
>
> [...]
>
> > +       l =3D start_id;
> > +       r =3D end_id;
> > +       while (l <=3D r) {
> > +               m =3D l + (r - l) / 2;
> > +               t =3D btf_type_by_id(btf, m);
> > +               tname =3D btf__str_by_offset(btf, t->name_off);
> > +               ret =3D strcmp(tname, name);
> > +               if (ret < 0) {
> > +                       l =3D m + 1;
> > +               } else {
> > +                       if (ret =3D=3D 0)
> > +                               lmost =3D m;
> > +                       r =3D m - 1;
> > +               }
> >         }
>
> this differs from what we discussed in [0], you said you'll use that
> approach. Can you please elaborate on why you didn't?
>
>   [0] https://lore.kernel.org/bpf/CAEf4Bzb3Eu0J83O=3DY4KA-LkzBMjtx7cbonxP=
zkiduzZ1Pedajg@mail.gmail.com/

Yes. As mentioned in the v8 changelog [1], the binary search approach
you referenced was implemented in versions v6 and v7 [2]. However,
testing revealed a slight performance regression. The root cause was
an extra strcmp operation introduced in v7, as discussed in [3]. Therefore,
in v8, I reverted to the approach from v5 [4] and refactored it for clarity=
.

Benchmark results show that v8 achieves a 4.2% performance improvement
over v7. If we don't care the performance gain, I will revert to the approa=
ch
in v7 in the next version.

[1] https://lore.kernel.org/bpf/20251126085025.784288-1-dolinux.peng@gmail.=
com/
[2] https://lore.kernel.org/all/20251119031531.1817099-1-dolinux.peng@gmail=
.com/
[3] https://lore.kernel.org/all/CAEf4BzaqEPD46LddJHO1-k5KPGyVWf6d=3DduDAxG1=
q=3DjykJkMBg@mail.gmail.com/
[4] https://lore.kernel.org/all/20251106131956.1222864-4-dolinux.peng@gmail=
.com/

>
> >
> > -       return libbpf_err(-ENOENT);
> > +       return lmost;
> >  }
> >
> >  static __s32 btf_find_by_name_kind(const struct btf *btf, int start_id=
,
> >                                    const char *type_name, __u32 kind)
>
> kind is defined as u32 but you expect caller to pass -1 to ignore the
> kind. Use int here.

Thanks, I will fix it.

>
> >  {
> > -       __u32 i, nr_types =3D btf__type_cnt(btf);
> > +       const struct btf_type *t;
> > +       const char *tname;
> > +       __s32 idx;
> > +
> > +       if (start_id < btf->start_id) {
> > +               idx =3D btf_find_by_name_kind(btf->base_btf, start_id,
> > +                                           type_name, kind);
> > +               if (idx >=3D 0)
> > +                       return idx;
> > +               start_id =3D btf->start_id;
> > +       }
> >
> > -       if (kind =3D=3D BTF_KIND_UNKN || !strcmp(type_name, "void"))
> > +       if (kind =3D=3D BTF_KIND_UNKN || strcmp(type_name, "void") =3D=
=3D 0)
> >                 return 0;
> >
> > -       for (i =3D start_id; i < nr_types; i++) {
> > -               const struct btf_type *t =3D btf__type_by_id(btf, i);
> > -               const char *name;
> > +       if (btf->sorted_start_id > 0 && type_name[0]) {
> > +               __s32 end_id =3D btf__type_cnt(btf) - 1;
> > +
> > +               /* skip anonymous types */
> > +               start_id =3D max(start_id, btf->sorted_start_id);
>
> can sorted_start_id ever be smaller than start_id?
>
> > +               idx =3D btf_find_by_name_bsearch(btf, type_name, start_=
id, end_id);
>
> is there ever a time when btf_find_by_name_bsearch() will work with
> different start_id and end_id? why is this not done inside the
> btf_find_by_name_bsearch()?

Because the start_id could be specified by the caller.

>
> > +               if (unlikely(idx < 0))
> > +                       return libbpf_err(-ENOENT);
>
> pass through error returned from btf_find_by_name_bsearch(), why redefini=
ng it?

Thanks, I will fix it.

>
> > +
> > +               if (unlikely(kind =3D=3D -1))
> > +                       return idx;
> > +
> > +               t =3D btf_type_by_id(btf, idx);
> > +               if (likely(BTF_INFO_KIND(t->info) =3D=3D kind))
>
> use btf_kind(), but this whole extra check is just unnecessary, this

Thanks, I will do it.

> should be done in the loop below. We talked about all this already,
> why do I feel like I'm being ignored?..

Sorry for the confusion, and absolutely not ignoring you.

>
> > +                       return idx;
>
> drop all these likely and unlikely micro optimizations, please

Thanks, I will do it.

>
>
> > +
> > +               for (idx++; idx <=3D end_id; idx++) {
> > +                       t =3D btf__type_by_id(btf, idx);
> > +                       tname =3D btf__str_by_offset(btf, t->name_off);
> > +                       if (strcmp(tname, type_name) !=3D 0)
> > +                               return libbpf_err(-ENOENT);
> > +                       if (btf_kind(t) =3D=3D kind)
> > +                               return idx;
> > +               }
> > +       } else {
> > +               __u32 i, total;
> >
> > -               if (btf_kind(t) !=3D kind)
> > -                       continue;
> > -               name =3D btf__name_by_offset(btf, t->name_off);
> > -               if (name && !strcmp(type_name, name))
> > -                       return i;
> > +               total =3D btf__type_cnt(btf);
> > +               for (i =3D start_id; i < total; i++) {
> > +                       t =3D btf_type_by_id(btf, i);
> > +                       if (kind !=3D -1 && btf_kind(t) !=3D kind)
>
> nit: kind < 0, no need to hard-code -1

Good, I will fix it.

>
> > +                               continue;
> > +                       tname =3D btf__str_by_offset(btf, t->name_off);
> > +                       if (strcmp(tname, type_name) =3D=3D 0)
> > +                               return i;
> > +               }
> >         }
> >
> >         return libbpf_err(-ENOENT);
> >  }
> >
>
> [...]

