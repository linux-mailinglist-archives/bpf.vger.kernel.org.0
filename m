Return-Path: <bpf+bounces-77131-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 18B66CCE8E8
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 06:41:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 19250300C165
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 05:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3956617AE11;
	Fri, 19 Dec 2025 05:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dq5g5xdB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1206F1A76BB
	for <bpf@vger.kernel.org>; Fri, 19 Dec 2025 05:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766122884; cv=none; b=cjSfe/fbrApq9wge4KAdXmBO1CUNkJAjWW+tPNLss/1tNUAaHx00aFtJTtjkbq/R7ojyMcNmfZ//y1plLCGpbriuUjLYLzzgxXt/IVn3Fe6Pds5Ax+SH2x0xPIpYMXqy2iAC0LbsnG29KLc4ND8VrLuedQ3+diQi3N11y4noAM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766122884; c=relaxed/simple;
	bh=jjW/QdOP1fdI9aDMIZxzTrgj/KAffD+V0kDiEiXz/m0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TE0EisIL/kOfi98AJcZf4V7982KsV0Icz5Q0WUEL8PRxEwv1zZi7MqwPUmX+iDAQ7sBmv1txe9eCrokmLrrVTNj8ejGepaNVP51k4UpO4Ye8L7GVTkC1RgGvBD5gZMCuu0SGF6UwzmRNkARzfmOiqBCJLqmhPPJxW2xq5qYhFG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dq5g5xdB; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b713c7096f9so230963066b.3
        for <bpf@vger.kernel.org>; Thu, 18 Dec 2025 21:41:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766122881; x=1766727681; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3WFqP8f3W9kAxiPRI+nYdm3hsalPFtfiGP7w/6Wt4aU=;
        b=Dq5g5xdBww2kocceuKTRy0mnnxjKVSkXdzUfvVnvYfAROHWxmFindUA1Jlq6OrrXds
         Kj3Q6DmVRHhD8Zl2kS6uKmCEUWnZIB/+JNOjpfS8DB/v/1PwN1mXIUJJlNv3XhPGAJlT
         F9+wo7Yu6ouHEavDyTBwAD3THowSqCEOgKCQTIzCkmUXxVCBv1UZ77DpxyaZ578SgqKY
         72MWRCS2zzEKvyIFQ78jlLdbPxpxGu2NwIiyXIumkMzJW8RTISKRVDJtFl+HKtmYGm2L
         wXT6PCs+eYVqw60tQDECCg2T/pXC0QUuyrNSmT8bNySot1Nmn9PPBMidkmoDLwE7fjLB
         X79A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766122881; x=1766727681;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3WFqP8f3W9kAxiPRI+nYdm3hsalPFtfiGP7w/6Wt4aU=;
        b=GbHeMIb01+2fCirK0DsuOywIuqd5cBhD3qIVbn7HrFCpYyyVq0fFoNhTbWs+MqWZvb
         /TUOyFIMTdjQO2CHptvfeQDOoMw3Ps+pArguydsngyK/0UgD1xd3+e2SWMzTM21cK45a
         fNBWAZPwZeO5DSpcOI/Mf/eJuZtZc9v4PYLmE0KwUUvzZB8RwjHYQiw1B16gRYZo3zTV
         w76RdtGvbmIuObAJ2JXrWifA00ZinAJr9Y8fq4OJhQCRoFxxwNQftLoltP1UCl9NlXIO
         NtQwl8URdul/dpoppYzjJKd1sQgpouj6WDWRLUgLrodCOcv6NY4whSDHviArWYKQnimi
         RyMQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQxTdUWPZl3m1Gx3JpQo1U/aZm1HeezQLy3Y7Y4tqbOC7G44dRDBbZP1wHMnj+NMLfsIU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwantVPgiwgrPedZvRusMkWkI8ETCgeRUXekFlwEXdXlRmSxl1N
	B/Z56+blWRMXt2mgb8G4tTIuvqQi8r7GzYwPwWc55rp+WlEThvzvd0tECfDQOY3gwvDbp744JpH
	kKpRkrulYp0oB/1Os+Lh/yR6QIVyyQpY=
X-Gm-Gg: AY/fxX5tTUqiw6Cl8+n8X3blw3WBjkWtGcu/YjM/6pD1eqPVKg9CHnDGPADgbQP3F3T
	gAEh2wnRG9xaa2bf/MKiKGn9B0bYYHPB7pGuQb3JM7wUSd0OIlLGYVkE/iYt8oTKXqFUlytfygm
	bja8k3GQ2bWbMb6zuIoPdtkiWn0vboNABdlW8AIruIEE5Q9cvM1oxm/LbuxYwZfC4Eow5AHVFtb
	RU6zSuYWEF0DLpYUDTGzc9IHK4tVa09mWPU7Fzvol/c1D2VeESpkCtdinfkiSR9BmDqBO/N
X-Google-Smtp-Source: AGHT+IFVxczerwSGRn5ZgGzCSEx4GRmVMdHQWpjXTS0XTnBurJF5Ap1ug4RA79mwJmQ8RmNZEVeqmDk+rgLfwLPg/Zo=
X-Received: by 2002:a17:907:3e1c:b0:b70:af93:b32d with SMTP id
 a640c23a62f3a-b80371db10fmr157405466b.53.1766122880981; Thu, 18 Dec 2025
 21:41:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251218113051.455293-1-dolinux.peng@gmail.com>
 <20251218113051.455293-10-dolinux.peng@gmail.com> <CAEf4BzZVFMbP+XXTOedDESKL4jred6vg2L8Dv5C-mmKMp9sicQ@mail.gmail.com>
In-Reply-To: <CAEf4BzZVFMbP+XXTOedDESKL4jred6vg2L8Dv5C-mmKMp9sicQ@mail.gmail.com>
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Fri, 19 Dec 2025 13:41:08 +0800
X-Gm-Features: AQt7F2puPdCDkJrqb3OpBM6cbD-fgchuo9-ovLEWgUwN_LaPkJl3r5iCkorlXZ4
Message-ID: <CAErzpmt85U7ggSpE+2u88C+kh+1JSnvZtW+Qx7c3xDLoHCbNtQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v10 09/13] bpf: Optimize the performance of find_bpffs_btf_enums
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: ast@kernel.org, eddyz87@gmail.com, zhangxiaoqin@xiaomi.com, 
	ihor.solodrai@linux.dev, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	pengdonglin <pengdonglin@xiaomi.com>, Alan Maguire <alan.maguire@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 19, 2025 at 8:02=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, Dec 18, 2025 at 3:31=E2=80=AFAM Donglin Peng <dolinux.peng@gmail.=
com> wrote:
> >
> > From: pengdonglin <pengdonglin@xiaomi.com>
> >
> > Currently, vmlinux BTF is unconditionally sorted during
> > the build phase. The function btf_find_by_name_kind
> > executes the binary search branch, so find_bpffs_btf_enums
> > can be optimized by using btf_find_by_name_kind.
> >
> > Cc: Eduard Zingerman <eddyz87@gmail.com>
> > Cc: Alexei Starovoitov <ast@kernel.org>
> > Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> > Cc: Alan Maguire <alan.maguire@oracle.com>
> > Cc: Ihor Solodrai <ihor.solodrai@linux.dev>
> > Cc: Xiaoqin Zhang <zhangxiaoqin@xiaomi.com>
> > Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
> > Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> > ---
> >  kernel/bpf/inode.c | 42 +++++++++++++++++++-----------------------
> >  1 file changed, 19 insertions(+), 23 deletions(-)
> >
> > diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
> > index 9f866a010dad..050fde1cf211 100644
> > --- a/kernel/bpf/inode.c
> > +++ b/kernel/bpf/inode.c
> > @@ -600,10 +600,18 @@ struct bpffs_btf_enums {
> >
> >  static int find_bpffs_btf_enums(struct bpffs_btf_enums *info)
> >  {
> > +       struct {
> > +               const struct btf_type **type;
> > +               const char *name;
> > +       } btf_enums[] =3D {
> > +               {&info->cmd_t,          "bpf_cmd"},
> > +               {&info->map_t,          "bpf_map_type"},
> > +               {&info->prog_t,         "bpf_prog_type"},
> > +               {&info->attach_t,       "bpf_attach_type"},
> > +       };
> >         const struct btf *btf;
> >         const struct btf_type *t;
> > -       const char *name;
> > -       int i, n;
> > +       int i, id;
> >
> >         memset(info, 0, sizeof(*info));
> >
> > @@ -615,30 +623,18 @@ static int find_bpffs_btf_enums(struct bpffs_btf_=
enums *info)
> >
> >         info->btf =3D btf;
> >
> > -       for (i =3D 1, n =3D btf_nr_types(btf); i < n; i++) {
> > -               t =3D btf_type_by_id(btf, i);
> > -               if (!btf_type_is_enum(t))
> > -                       continue;
> > +       for (i =3D 0; i < ARRAY_SIZE(btf_enums); i++) {
> > +               id =3D btf_find_by_name_kind(btf, btf_enums[i].name,
> > +                                          BTF_KIND_ENUM);
> > +               if (id < 0)
> > +                       goto out;
> >
> > -               name =3D btf_name_by_offset(btf, t->name_off);
> > -               if (!name)
> > -                       continue;
>
> return -ESRCH, why goto at all?
>
> > -
> > -               if (strcmp(name, "bpf_cmd") =3D=3D 0)
> > -                       info->cmd_t =3D t;
> > -               else if (strcmp(name, "bpf_map_type") =3D=3D 0)
> > -                       info->map_t =3D t;
> > -               else if (strcmp(name, "bpf_prog_type") =3D=3D 0)
> > -                       info->prog_t =3D t;
> > -               else if (strcmp(name, "bpf_attach_type") =3D=3D 0)
> > -                       info->attach_t =3D t;
> > -               else
> > -                       continue;
> > -
> > -               if (info->cmd_t && info->map_t && info->prog_t && info-=
>attach_t)
> > -                       return 0;
> > +               t =3D btf_type_by_id(btf, id);
> > +               *btf_enums[i].type =3D t;
>
> nit: drop t local variable, just assign directly:
>
> *btf_enums[i].type =3D btf_type_by_id(btf, id);

Thanks, I will do it.

>
> >         }
> >
> > +       return 0;
> > +out:
> >         return -ESRCH;
> >  }
> >
> > --
> > 2.34.1
> >

