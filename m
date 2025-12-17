Return-Path: <bpf+bounces-76807-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E8FF0CC5E2F
	for <lists+bpf@lfdr.de>; Wed, 17 Dec 2025 04:20:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C5B05301E220
	for <lists+bpf@lfdr.de>; Wed, 17 Dec 2025 03:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5994E285041;
	Wed, 17 Dec 2025 03:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VCFlKjlu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2839E3595D
	for <bpf@vger.kernel.org>; Wed, 17 Dec 2025 03:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765941611; cv=none; b=ppqF4AiGogMZqsWUwxL0z+41ydpfCQuqTUaGLWa2g65gmvEfbSlpG/bhH+ysqhEZlEXkhqScvxR8p7bKUJZ31WLxv/+6LirMsORuVqSEcKQa74HtNrpE8Tsq6hBOvdUHEtD2nHwtlf3CaqAO4DTiGY9M27jvpxR2uzChNVCqrAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765941611; c=relaxed/simple;
	bh=vltlcu99mq35FQkwYNebhsQPHV8KIbKd5XmZSDTvq2A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T+pHXTCf2hp+fl7J90GThN5Iytq0Q+KRYZiDF9EazogK+CFLhRnOckAv4n1pVI9iVNyQMaU4ZkSSWMPFUapg+5p9VfrP4A9DBGiTOyQrBXGyXwuUU8s/v2M/ZvjYtU7IAYPC1Ht+Gn1w1Nkdz6hn9V999Vqaai7xZFfV6uJEqDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VCFlKjlu; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b79d6a70fc8so929010366b.0
        for <bpf@vger.kernel.org>; Tue, 16 Dec 2025 19:20:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765941608; x=1766546408; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eJMFkq7VFxSPJo1OL6kE+KuCDmkdiU7jjNYrbrgIQno=;
        b=VCFlKjlutbU9vR5is5tpUrVtzLNz6NioUofdD2fP64vI4xE6bqUVPqlTD/ph8Rce9f
         BNW5muufjrh5eH8Z7MrcKb6ZtSfuX9Ps/okYMSb40Fzh5q2BXAYOUVLyD/nNHEFSB+zo
         P9VrOh0XhgpKpM88ts6RT3dfiC+gBwcR542Dy4b6QjKq5aTS7cJghMt7rzHdglZLzNgJ
         tLj1B0l9OaJq1AxVHFKgC5U+cxPxzuVYPs+S5XCSZ+tfGR018SMn+pvpHyUs8oMFQNcQ
         sFcRe5veVUd1gCa6yxUutOL6aKIcVQlEVcfJWbn92qwJTFVCLxi/sr1Rfcb7/tI6egRY
         X2bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765941608; x=1766546408;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eJMFkq7VFxSPJo1OL6kE+KuCDmkdiU7jjNYrbrgIQno=;
        b=RSxR8nbpVzewwqS9mhvwJ+CKwT7kf7YgSU5/+deg6WOCtVzgIeefk6VeMUXSmNPZC+
         t+ejxLr+gnNC7ljnWPtiiXAHGc4fCHvmzpedX7KzXlwL7P7FMZWjzPQMJmQoIrXjacjx
         6QqDu0oQTbdsFbVah6BjAECLfGDnJzOsvdrCH6MbqyNVKpoPNgqIZtOg0VWMAL6AFmmP
         oSt/Sdoq95jo7dOTy72y5FHXeEfHsxmcO5yPcfABqOR6UPZgzfFsIp2z7OMQaZ7XJks1
         pCrS6WoGeflo6fmbpLzz58CZhpdCx9JhlwOmx+GOkDMSIEiYOFH99LAQMhPJLbaObH3q
         2vsQ==
X-Forwarded-Encrypted: i=1; AJvYcCWK84nH9zUf683VFXUtgmE5vkQQbAEy5nF4Ly34dpL7jCkADZkRP6OOjMH7S8dxyG33BAI=@vger.kernel.org
X-Gm-Message-State: AOJu0YztB/+DtoVFQKJ5MZfzE4B9IomWa4LSLs00+ZaYyXHXx59oTZi+
	W+1nvj9vTp4qUKe3hxcvIGQxZdCZHM+H8x4yJXvG2MyPMQjMn0AN1yAkzTbABqKQzB/HnH7SuKt
	vu4umA9Y5hJGc2JvNOSMh4+4Y7nAtNB0=
X-Gm-Gg: AY/fxX7IPr2Fob+NcL7nrIIZ1gh0VvmqPC1xgZzd41K2S6NGgul6CSc1q0GnSulZryK
	jqNSeg5cxvvdK4y/VMADH5oTjDXLyOBM7MVhxMhPSNfcXcn0tbqFrpgs5v5FnkFcyxCIHr7ovjZ
	pr7MFlnD3kt0fRM4stGAvrsT8OomZMghlOQxP3GDaZRpk8YM3qXrWM4POk64+SjjzRwuUsBGF4T
	hJ0URWobvoR5NPrUbIUT4h1mbAKIk+9NsmWis3OcovtRDpcc8068ydpVgQBUh4WnCQe4jHA
X-Google-Smtp-Source: AGHT+IFDPebcu0Pyh3dVc1+nnAvlkyEB5BdkYnT9bCGY+qOjfT21sbu993LCZbRgIuZ7NZPqMtNUYgoBnGsTJDIb2FY=
X-Received: by 2002:a17:907:93c3:b0:b7d:3aab:5bf2 with SMTP id
 a640c23a62f3a-b7d3aab9320mr948584966b.63.1765941608390; Tue, 16 Dec 2025
 19:20:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251208062353.1702672-1-dolinux.peng@gmail.com>
 <20251208062353.1702672-6-dolinux.peng@gmail.com> <0b9fd098307b5aa15a7d7a3f7f2b01fe63e66a53.camel@gmail.com>
In-Reply-To: <0b9fd098307b5aa15a7d7a3f7f2b01fe63e66a53.camel@gmail.com>
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Wed, 17 Dec 2025 11:19:56 +0800
X-Gm-Features: AQt7F2oIWP3i1SPCBI6vGkN-CNRP3YHUqTjrpNrA_vNNh7TQXQJ68ESYK5OammM
Message-ID: <CAErzpmtHkYY1MWM+bNdOwNKxQTtWTcya22Bp68ZDOOSZtGgaXw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v9 05/10] libbpf: Verify BTF Sorting
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: ast@kernel.org, andrii.nakryiko@gmail.com, zhangxiaoqin@xiaomi.com, 
	ihor.solodrai@linux.dev, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	pengdonglin <pengdonglin@xiaomi.com>, Alan Maguire <alan.maguire@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 17, 2025 at 8:32=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Mon, 2025-12-08 at 14:23 +0800, Donglin Peng wrote:
> > From: pengdonglin <pengdonglin@xiaomi.com>
> >
> > This patch checks whether the BTF is sorted by name in ascending
> > order. If sorted, binary search will be used when looking up types.
> >
> > Cc: Eduard Zingerman <eddyz87@gmail.com>
> > Cc: Alexei Starovoitov <ast@kernel.org>
> > Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> > Cc: Alan Maguire <alan.maguire@oracle.com>
> > Cc: Ihor Solodrai <ihor.solodrai@linux.dev>
> > Cc: Xiaoqin Zhang <zhangxiaoqin@xiaomi.com>
> > Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
> > ---
> >  tools/lib/bpf/btf.c | 46 ++++++++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 45 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> > index 7f150c869bf6..a53d24704857 100644
> > --- a/tools/lib/bpf/btf.c
> > +++ b/tools/lib/bpf/btf.c
> > @@ -899,6 +899,49 @@ int btf__resolve_type(const struct btf *btf, __u32=
 type_id)
> >       return type_id;
> >  }
> >
> > +/*
> > + * Assuming that types are sorted by name in ascending order.
> > + */
> > +static int btf_compare_type_names(const void *a, const void *b, void *=
priv)
>
> This can be declared as ...(u32 a, u32 b, struct btf *btf).

Thanks, I will fix it in the next version.

>
> > +{
> > +     struct btf *btf =3D (struct btf *)priv;
> > +     struct btf_type *ta =3D btf_type_by_id(btf, *(__u32 *)a);
> > +     struct btf_type *tb =3D btf_type_by_id(btf, *(__u32 *)b);
> > +     const char *na, *nb;
> > +
> > +     na =3D btf__str_by_offset(btf, ta->name_off);
> > +     nb =3D btf__str_by_offset(btf, tb->name_off);
> > +     return strcmp(na, nb);
> > +}
> > +
> > +static void btf_check_sorted(struct btf *btf)
> > +{
> > +     const struct btf_type *t;
> > +     int i, k =3D 0, n;
> > +     __u32 sorted_start_id =3D 0;
> > +
> > +     if (btf->nr_types < 2)
> > +             return;
> > +
> > +     n =3D btf__type_cnt(btf) - 1;
> > +     for (i =3D btf->start_id; i < n; i++) {
> > +             k =3D i + 1;
> > +             if (btf_compare_type_names(&i, &k, btf) > 0)
> > +                     return;
> > +             t =3D btf_type_by_id(btf, i);
> > +             if (sorted_start_id =3D=3D 0 &&
> > +                     !str_is_empty(btf__str_by_offset(btf, t->name_off=
)))
>                 ^^^^^^^^
> Nit: broken indentation.

Thanks, I will fix it.

>
> > +                     sorted_start_id =3D i;
> > +     }
> > +
> > +     t =3D btf_type_by_id(btf, k);
>
> Nit: please use 'n' instead of 'k'.

Thanks, I agree, although k equals n at this point.

>      Maybe just change condition in the loop and avoid the second part?
>      E.g.:
>
>        n =3D btf__type_cnt(btf);
>        for (...) {
>          ...
>          if (k < n && btf_compare_type_names(a: &i, b: &k, priv: btf) > 0=
)
>            return;
>          ...
>        }
>
>      A bit shorter/simpler this way.

Great, I agree and will fix it in the next version.

>
> > +     if (sorted_start_id =3D=3D 0 &&
> > +             !str_is_empty(btf__str_by_offset(btf, t->name_off)))
> > +             sorted_start_id =3D k;
> > +     if (sorted_start_id)
> > +             btf->sorted_start_id =3D sorted_start_id;
> > +}
> > +
> >  static __s32 btf_find_by_name_bsearch(const struct btf *btf, const cha=
r *name,
> >                                               __s32 start_id, __s32 end=
_id)
> >  {
> > @@ -935,7 +978,7 @@ static __s32 btf_find_by_name_kind(const struct btf=
 *btf, int start_id,
> >
> >       if (start_id < btf->start_id) {
> >               idx =3D btf_find_by_name_kind(btf->base_btf, start_id,
> > -                     type_name, kind);
> > +                                         type_name, kind);
>
> Nit: shouldn't be in this patch.

Thanks, I will fix it in the next version.

>
> >               if (idx >=3D 0)
> >                       return idx;
> >               start_id =3D btf->start_id;
> > @@ -1147,6 +1190,7 @@ static struct btf *btf_new(const void *data, __u3=
2 size, struct btf *base_btf, b
> >       err =3D err ?: btf_sanity_check(btf);
> >       if (err)
> >               goto done;
> > +     btf_check_sorted(btf);
> >
> >  done:
> >       if (err) {
>

