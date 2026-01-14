Return-Path: <bpf+bounces-78805-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F257ED1BFBB
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 02:45:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 35B6A302413A
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 01:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2AD92BE647;
	Wed, 14 Jan 2026 01:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SSAHHl+A"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3590173
	for <bpf@vger.kernel.org>; Wed, 14 Jan 2026 01:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768355076; cv=none; b=UTq0+970L8JY6ypqpV3ZZkN+YpzZK0P92+PscvLWRkNACFrZOXFlJSOMVpKECvS6huaBHFsCRlF8/IO7JyFWBfBNBGIxNjSk9GrTprwfKbJCrJyKSoWWG/uR+Xs61iOxkYGtR7SHmv/xVmkq4OEOC39bNIB5qhnflqnXtBeNDtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768355076; c=relaxed/simple;
	bh=NICmuFwiaGlZoWXXJMKpEaXEwCBRWjG3jjHmgUf9pQk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aa3uqpR4trrelHznLZXDiRv2FT6GWKt42RCTSxtKwU4nAG+yBIh/v3M2zRH/9h3sxRopiXfflY0qbLuSX7+3aEBC/HaGIIaAPEiNMcVgFum01bWwLkG3iZOYG4pEX4BL+NllxE1ta72BnILPaqagoaX1UT8iHvMCM/ZXWrWoer8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SSAHHl+A; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b871b6e0c70so451961566b.2
        for <bpf@vger.kernel.org>; Tue, 13 Jan 2026 17:44:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768355070; x=1768959870; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IejZACQDcmCoFGRkMjcbmxdOzAscm7NFhocsZ8KggpA=;
        b=SSAHHl+Awz242P0/bMJ4H4WWbC0BE7qzbZ5WGlXELN+dMPoL+zrY1fVu5wdkgQa+/f
         OfsEsf45rpY2BNZbYcbhHZCHtW9oyycy5Gvc8z0ulLcdeIXWwyX1e8sn5zR1xzU7Durm
         Qoh6AuKO4JyxETaYNoudKSerLxjDGiXBgL5pWqDgNGElRzpC8sgw1YBAxC+xBBAhmhoC
         gXdMs05N61IqTbheqDnlWjkj/Rmu011n7R0yVw1NvahWy3PIQ3bDjaCHGoVkiRO8hkuw
         xzsqgy/g+iODaqivbiyEnCxmn2j2FtVJ/CLjEG99aGlOfKQXTNdc47Gf6ixHs4rN5bPj
         BSPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768355070; x=1768959870;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IejZACQDcmCoFGRkMjcbmxdOzAscm7NFhocsZ8KggpA=;
        b=InOqF5QXOqRMoKimDZFwP4xNknb9ECtl3uh/VG2WGpY/66KXpv3316k/GC0XnadKGA
         UENGLgT3qU1b6X5aVO5rCvAmIgXCpTVVxaEPOwVk+sd7h+7lpJOCFXV+4ayIUR/0tOxm
         AEXEZKHNbSwvfIZG7jO8ixIOvpkThZvM2NJQEwSEnuSosGf2AawmXnyJoJbofYRzt8IY
         doKA85MFrlb0LTlK/0sLk7nKhIK0hgxNPH/Ogvol+zbAlsmpEtnA+BsNIN5TVocOVxS9
         LyPyE0Z09FNEylW6xpHcZQ0rTG8WO5sSnPhKOiUlfJZ5xSR8QoomrzEqgqK2KGXzGgy4
         8/LQ==
X-Forwarded-Encrypted: i=1; AJvYcCUnJj4kC8iZrOgALWFXfTw56RMssl5MH6Lv+3kwihhhVFobLSU1sSnfGb4Kpfscd0vMthg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHZYbsHv13/BWJoHDhyCiTZg3ZxVs98KwVC9QBtEL8uWuCSsZ2
	HtOKwzv5wUbWfjShCin+j0sAlxCoiBxe4bjPoPa/xuTMrf0V5TXma53bN7JpHyncZaa8M6tklQ2
	aN9mScTpgOwzmHFERoPK1+pGBw/rAWn1vKV7dPQY=
X-Gm-Gg: AY/fxX7Xn82uabo7sFVOTxDfKM7rwkqyy0HpdVpqCpw8rh42PrBvRhVZui3NUVtlPMj
	5UeVWG3bMZKo4Hz+gSYj054HuuYWkc+zxLVfPHrgE9VgD+nQ4Ec4PZRHVD1U5pAp5HLaz+sIN08
	4vASooa+AAFVCRVo4JC98QmCq2QWbQXfaibBQ7+IGzTryk6aUsh0mCGClsGPrWsIu8kupyd0JJC
	6uMqBrqYE6JNi+RvH1LXqrYgNmMv1bqW4Mu9xpqn5zFJOA+fbqloDprg4j9iWJRQQ3PznFZQzuQ
	E1UipWM=
X-Received: by 2002:a17:907:724b:b0:b87:15a7:85ee with SMTP id
 a640c23a62f3a-b876127693emr74254966b.47.1768355069967; Tue, 13 Jan 2026
 17:44:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260109130003.3313716-1-dolinux.peng@gmail.com>
 <20260109130003.3313716-4-dolinux.peng@gmail.com> <CAEf4BzZZ3xaCURCUJsUDH=_eLj31XKeXy34x-jczyM862Cw=TQ@mail.gmail.com>
In-Reply-To: <CAEf4BzZZ3xaCURCUJsUDH=_eLj31XKeXy34x-jczyM862Cw=TQ@mail.gmail.com>
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Wed, 14 Jan 2026 09:44:19 +0800
X-Gm-Features: AZwV_Qg8j3aqfSg_A5SK_JpNnVBP4jUM7CIl000QK9o-W0bPuJ0tfUO7_lMRRpM
Message-ID: <CAErzpmtvKM41=_VXcRAQknbcc_Hjna71FbMd+XYXWxANBPxoqQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v12 03/11] tools/resolve_btfids: Support BTF
 sorting feature
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: ast@kernel.org, eddyz87@gmail.com, zhangxiaoqin@xiaomi.com, 
	ihor.solodrai@linux.dev, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	Donglin Peng <pengdonglin@xiaomi.com>, Alan Maguire <alan.maguire@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 14, 2026 at 8:29=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Fri, Jan 9, 2026 at 5:00=E2=80=AFAM Donglin Peng <dolinux.peng@gmail.c=
om> wrote:
> >
> > From: Donglin Peng <pengdonglin@xiaomi.com>
> >
> > This introduces a new BTF sorting phase that specifically sorts
> > BTF types by name in ascending order, so that the binary search
> > can be used to look up types.
> >
> > Cc: Eduard Zingerman <eddyz87@gmail.com>
> > Cc: Alexei Starovoitov <ast@kernel.org>
> > Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> > Cc: Alan Maguire <alan.maguire@oracle.com>
> > Cc: Ihor Solodrai <ihor.solodrai@linux.dev>
> > Cc: Xiaoqin Zhang <zhangxiaoqin@xiaomi.com>
> > Signed-off-by: Donglin Peng <pengdonglin@xiaomi.com>
> > Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> > ---
> >  tools/bpf/resolve_btfids/main.c | 64 +++++++++++++++++++++++++++++++++
> >  1 file changed, 64 insertions(+)
> >
> > diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids=
/main.c
> > index df39982f51df..343d08050116 100644
> > --- a/tools/bpf/resolve_btfids/main.c
> > +++ b/tools/bpf/resolve_btfids/main.c
> > @@ -850,6 +850,67 @@ static int dump_raw_btf(struct btf *btf, const cha=
r *out_path)
> >         return 0;
> >  }
> >
> > +/*
> > + * Sort types by name in ascending order resulting in all
> > + * anonymous types being placed before named types.
> > + */
> > +static int cmp_type_names(const void *a, const void *b, void *priv)
> > +{
> > +       struct btf *btf =3D (struct btf *)priv;
> > +       const struct btf_type *ta =3D btf__type_by_id(btf, *(__u32 *)a)=
;
> > +       const struct btf_type *tb =3D btf__type_by_id(btf, *(__u32 *)b)=
;
> > +       const char *na, *nb;
> > +
> > +       na =3D btf__str_by_offset(btf, ta->name_off);
> > +       nb =3D btf__str_by_offset(btf, tb->name_off);
> > +       return strcmp(na, nb);
>
> let's disambiguate the case when strcmp() =3D=3D 0:
>
> int r =3D strcmp(na, nb);
> if (r !=3D 0)
>     return r;
>
> /* preserve original relative order of anonymous or same-named types */
> return *(__u32 *)a < *(__u32 *)b ? -1 : 1;

Thanks, I see.

>
> (please send as a follow up)

Ok.

>
>
> > +}
> > +
> > +static int sort_btf_by_name(struct btf *btf)
> > +{
> > +       __u32 *permute_ids =3D NULL, *id_map =3D NULL;
> > +       int nr_types, i, err =3D 0;
> > +       __u32 start_id =3D 0, start_offs =3D 1, id;
> > +
> > +       if (btf__base_btf(btf)) {
> > +               start_id =3D btf__type_cnt(btf__base_btf(btf));
> > +               start_offs =3D 0;
>
> with the above cmp_type_names disambiguation sorting becomes stable,
> so you won't need this start_offs thing here, you can safely compare
> VOID with any other type and it will stay the very first one

Great, I will fix it in v13 of this patch.

>
> (please include in the follow up as well)

Okay, thanks.

>
>
>
> > +       }
> > +       nr_types =3D btf__type_cnt(btf) - start_id;
> > +
> > +       permute_ids =3D calloc(nr_types, sizeof(*permute_ids));
> > +       if (!permute_ids) {
> > +               err =3D -ENOMEM;
> > +               goto out;
> > +       }
> > +
> > +       id_map =3D calloc(nr_types, sizeof(*id_map));
> > +       if (!id_map) {
> > +               err =3D -ENOMEM;
> > +               goto out;
> > +       }
> > +
> > +       for (i =3D 0, id =3D start_id; i < nr_types; i++, id++)
> > +               permute_ids[i] =3D id;
> > +
> > +       qsort_r(permute_ids + start_offs, nr_types - start_offs,
> > +               sizeof(*permute_ids), cmp_type_names, btf);
> > +
> > +       for (i =3D 0; i < nr_types; i++) {
> > +               id =3D permute_ids[i] - start_id;
> > +               id_map[id] =3D i + start_id;
> > +       }
> > +
> > +       err =3D btf__permute(btf, id_map, nr_types, NULL);
> > +       if (err)
> > +               pr_err("FAILED: btf permute: %s\n", strerror(-err));
> > +
> > +out:
> > +       free(permute_ids);
> > +       free(id_map);
> > +       return err;
> > +}
> > +
> >  static inline int make_out_path(char *buf, u32 buf_sz, const char *in_=
path, const char *suffix)
> >  {
> >         int len =3D snprintf(buf, buf_sz, "%s%s", in_path, suffix);
> > @@ -1025,6 +1086,9 @@ int main(int argc, const char **argv)
> >         if (load_btf(&obj))
> >                 goto out;
> >
> > +       if (sort_btf_by_name(obj.btf))
> > +               goto out;
> > +
> >         if (elf_collect(&obj))
> >                 goto out;
> >
> > --
> > 2.34.1
> >

