Return-Path: <bpf+bounces-77061-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 75844CCDF8C
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 00:38:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D8C9330762CE
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 23:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CCDC33EAE3;
	Thu, 18 Dec 2025 23:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FomH+iL8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60AE133A6F7
	for <bpf@vger.kernel.org>; Thu, 18 Dec 2025 23:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766100593; cv=none; b=CtAsu1s+12/9SfUGtbXROjyJ6jqLgDeejMLZssOH/PWuQhyXk+Qtjem55m1A3z69bH2fes8q0BstlNjRQU2ublxINIlmUpS6epy0j5yUkglXM+rT6jd8kQxjS9P9Bfu8eoXaMCtd4Wy5HaiLFTwCZ9wbLBUU+k+vgcLAvGArgag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766100593; c=relaxed/simple;
	bh=CkOlCzdOfYG8sKOr7R1+4JM1LdlvpLIRZLsdJlp1KLY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EVtOWxmWnDX222XyR/Jux+SNjtgiDOb3uOtzTKnQGqluAh4+CjtNGX2MRhtbPI73FDzUqz4FLKrOt0nZrC3ba5iW6RyeqPZBcOkOFal9VIzbDxc3QVbbFZZn3oGVbfS3Uk3Xcq0E8UQj+g/ibALFfbMUo5u1yWdBmJmseYoM2Vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FomH+iL8; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-34c84ec3b6eso1490702a91.3
        for <bpf@vger.kernel.org>; Thu, 18 Dec 2025 15:29:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766100592; x=1766705392; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h8eQHRVT+zWK9Sl9nF4z2sWh+JKjJpeek1TymHyqfgo=;
        b=FomH+iL8pqw3FxXEkCOGs/iiE+Ns7MI9HHj1k4Hb87NO8XFrCcleGkfP8Uc8cBnqHX
         mpGP2yWjFrtH2hb/XfGY4GVl7sCsi8sFmyutmW68crr+O+CKRURFTnyozxkNqr6T0WHI
         3s186SfAkU+oXYYw7m64LKY21VYhhTtbwouIO38S1KLSPlxTOopTxDRJGaR0+1y0CnGX
         aMotvAySbC0EmcaBBm0z+k/jwqbFVxFdlMNW8ilKrBFqv4r4d9HfJz4c3DLMM+vUuHc1
         gtvKJqDt5CMuIwta5dCMI27w7Zel22PkOfGpB4pjmoYPI/PISV4dkJuWWbwT1PbNaHeY
         CwPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766100592; x=1766705392;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=h8eQHRVT+zWK9Sl9nF4z2sWh+JKjJpeek1TymHyqfgo=;
        b=RrFJIoKnhF64m3rdADTnaMJsffbrPY5XyxCTqmc5LutiIufR+lFhzbGJzvS2QRypJJ
         pBLNazVDPb2W2wmh/9j8Z4EhhsyW85XAZJVwCLzNUJvh4daUlTEaiDGRpvUPw2yNZeHi
         Jp0aollB6iIWVXl+sqzIWEd34UeZ4Epw3VdRX88P1gf6z3/lLHTGZwGEyIYYI600o38G
         z9lcdH6h9kkkKf22hbXRrXUgv9TFkqpNQE2aZ/cxjzHF+dnjXek3/uc34sUvypNY+3su
         K8QuiyQ+ktAlfDKHqG4m/cTQ9tDUSpo754l95QrrTtp9+gDrumiggwTvlhbRSptVOWdJ
         PDUQ==
X-Forwarded-Encrypted: i=1; AJvYcCVOZfDCcFy6n7tvIbfucKMetF7iE7oocaqy/Eu9tBjYNjsr6gfSntrIxle6R3dI8tZZt/Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhiB65EmtFDc1ee25LHBLTk7gQe33wLnoxvZYLKfA/YFzZgMCY
	/bWIjooXhDR4iwQJY5Zf5++fi41qsar+YwXsipPSanzhAbhZ2qtydfMAH/KoDy2ABILyoS/sUps
	D50cEwGXsQoqVbp21DUq0C1JTdAukzes=
X-Gm-Gg: AY/fxX7UuW0J1QWdLi9DOWGhTlMNbehy43mvVsyf+GVYyOmv0ajDm8jwq5K1G7I5JAw
	Wj6Sk3iqiaysqVQuXrbHFBU6tYEbA7NvGEQOKUR1vi80n/9pPnpggKPu1Phea2fN0Csvb3RYq2Y
	IokXfOgAmdvvtD1yjJf4LH12NsPgEw8qoNBWeBAMuLMYsokC8IbzXW/iGdNtaiPvZDwRXgXl0H5
	NMfYdlEYAMccxBkjwa7yyBX+2ATjmYTyUPUEYMpjuTPRYQbmtikXbFWbOh0NoPKyV6lvb4OLPQG
	5d2qKDTvD+0=
X-Google-Smtp-Source: AGHT+IHJ2wRb+7UIvtSQi1HqEqgWPCIQxBy7awRoFbJHnw2/9AGKrmDPfPtuOoQuxWMOhDrB4eHtoKKBigHNkIYWrsw=
X-Received: by 2002:a17:90b:1810:b0:34a:b8fc:f1d8 with SMTP id
 98e67ed59e1d1-34e921ec5c8mr803082a91.37.1766100591474; Thu, 18 Dec 2025
 15:29:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251218113051.455293-1-dolinux.peng@gmail.com> <20251218113051.455293-5-dolinux.peng@gmail.com>
In-Reply-To: <20251218113051.455293-5-dolinux.peng@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 18 Dec 2025 15:29:38 -0800
X-Gm-Features: AQt7F2oBNSo4wn2bJi56ZmlVF_Gufsv7M7MOlj0d98Jkdt-cVMd0vgxZ_MAmkmU
Message-ID: <CAEf4BzbSMwW4es5D9i=bpSjALo8u+oW-9vdQ7=DBoTBtMoJ1Tg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v10 04/13] libbpf: Optimize type lookup with
 binary search for sorted BTF
To: Donglin Peng <dolinux.peng@gmail.com>
Cc: ast@kernel.org, eddyz87@gmail.com, zhangxiaoqin@xiaomi.com, 
	ihor.solodrai@linux.dev, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	pengdonglin <pengdonglin@xiaomi.com>, Alan Maguire <alan.maguire@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 18, 2025 at 3:31=E2=80=AFAM Donglin Peng <dolinux.peng@gmail.co=
m> wrote:
>
> From: pengdonglin <pengdonglin@xiaomi.com>
>
> This patch introduces binary search optimization for BTF type lookups
> when the BTF instance contains sorted types.
>
> The optimization significantly improves performance when searching for
> types in large BTF instances with sorted types. For unsorted BTF, the
> implementation falls back to the original linear search.
>
> Cc: Eduard Zingerman <eddyz87@gmail.com>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> Cc: Alan Maguire <alan.maguire@oracle.com>
> Cc: Ihor Solodrai <ihor.solodrai@linux.dev>
> Cc: Xiaoqin Zhang <zhangxiaoqin@xiaomi.com>
> Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
> ---
>  tools/lib/bpf/btf.c | 103 ++++++++++++++++++++++++++++++++++----------
>  1 file changed, 80 insertions(+), 23 deletions(-)
>

[...]

> +       l =3D start_id;
> +       r =3D end_id;
> +       while (l <=3D r) {
> +               m =3D l + (r - l) / 2;
> +               t =3D btf_type_by_id(btf, m);
> +               tname =3D btf__str_by_offset(btf, t->name_off);
> +               ret =3D strcmp(tname, name);
> +               if (ret < 0) {
> +                       l =3D m + 1;
> +               } else {
> +                       if (ret =3D=3D 0)
> +                               lmost =3D m;
> +                       r =3D m - 1;
> +               }
>         }

this differs from what we discussed in [0], you said you'll use that
approach. Can you please elaborate on why you didn't?

  [0] https://lore.kernel.org/bpf/CAEf4Bzb3Eu0J83O=3DY4KA-LkzBMjtx7cbonxPzk=
iduzZ1Pedajg@mail.gmail.com/

>
> -       return libbpf_err(-ENOENT);
> +       return lmost;
>  }
>
>  static __s32 btf_find_by_name_kind(const struct btf *btf, int start_id,
>                                    const char *type_name, __u32 kind)

kind is defined as u32 but you expect caller to pass -1 to ignore the
kind. Use int here.

>  {
> -       __u32 i, nr_types =3D btf__type_cnt(btf);
> +       const struct btf_type *t;
> +       const char *tname;
> +       __s32 idx;
> +
> +       if (start_id < btf->start_id) {
> +               idx =3D btf_find_by_name_kind(btf->base_btf, start_id,
> +                                           type_name, kind);
> +               if (idx >=3D 0)
> +                       return idx;
> +               start_id =3D btf->start_id;
> +       }
>
> -       if (kind =3D=3D BTF_KIND_UNKN || !strcmp(type_name, "void"))
> +       if (kind =3D=3D BTF_KIND_UNKN || strcmp(type_name, "void") =3D=3D=
 0)
>                 return 0;
>
> -       for (i =3D start_id; i < nr_types; i++) {
> -               const struct btf_type *t =3D btf__type_by_id(btf, i);
> -               const char *name;
> +       if (btf->sorted_start_id > 0 && type_name[0]) {
> +               __s32 end_id =3D btf__type_cnt(btf) - 1;
> +
> +               /* skip anonymous types */
> +               start_id =3D max(start_id, btf->sorted_start_id);

can sorted_start_id ever be smaller than start_id?

> +               idx =3D btf_find_by_name_bsearch(btf, type_name, start_id=
, end_id);

is there ever a time when btf_find_by_name_bsearch() will work with
different start_id and end_id? why is this not done inside the
btf_find_by_name_bsearch()?

> +               if (unlikely(idx < 0))
> +                       return libbpf_err(-ENOENT);

pass through error returned from btf_find_by_name_bsearch(), why redefining=
 it?

> +
> +               if (unlikely(kind =3D=3D -1))
> +                       return idx;
> +
> +               t =3D btf_type_by_id(btf, idx);
> +               if (likely(BTF_INFO_KIND(t->info) =3D=3D kind))

use btf_kind(), but this whole extra check is just unnecessary, this
should be done in the loop below. We talked about all this already,
why do I feel like I'm being ignored?..

> +                       return idx;

drop all these likely and unlikely micro optimizations, please


> +
> +               for (idx++; idx <=3D end_id; idx++) {
> +                       t =3D btf__type_by_id(btf, idx);
> +                       tname =3D btf__str_by_offset(btf, t->name_off);
> +                       if (strcmp(tname, type_name) !=3D 0)
> +                               return libbpf_err(-ENOENT);
> +                       if (btf_kind(t) =3D=3D kind)
> +                               return idx;
> +               }
> +       } else {
> +               __u32 i, total;
>
> -               if (btf_kind(t) !=3D kind)
> -                       continue;
> -               name =3D btf__name_by_offset(btf, t->name_off);
> -               if (name && !strcmp(type_name, name))
> -                       return i;
> +               total =3D btf__type_cnt(btf);
> +               for (i =3D start_id; i < total; i++) {
> +                       t =3D btf_type_by_id(btf, i);
> +                       if (kind !=3D -1 && btf_kind(t) !=3D kind)

nit: kind < 0, no need to hard-code -1

> +                               continue;
> +                       tname =3D btf__str_by_offset(btf, t->name_off);
> +                       if (strcmp(tname, type_name) =3D=3D 0)
> +                               return i;
> +               }
>         }
>
>         return libbpf_err(-ENOENT);
>  }
>

[...]

