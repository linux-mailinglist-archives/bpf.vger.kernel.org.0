Return-Path: <bpf+bounces-78814-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B6280D1C1E2
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 03:21:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0F6C7301503A
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 02:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D0782F363C;
	Wed, 14 Jan 2026 02:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VaorH3gH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45133286D5D
	for <bpf@vger.kernel.org>; Wed, 14 Jan 2026 02:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768357290; cv=none; b=UJhgGLjyxNFUOHhgjGCJyEvxD+agF0Cahm+vVacnMv1MZBAidWh5aked3GgPzk7squDQ5Q+tNzcG7rkrwW+u3BEpjdxFYkUlv5noheD/45icPwafbxrxeF/ORT825Gcf6CerSr0yDmM02udT9ktiZrMuv01BUehz0D2mXZcYe3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768357290; c=relaxed/simple;
	bh=LlG1Qb/jUyeWDfR0la12kjMhvK9v7r3IO2/Yg3yqj+4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=abO/P8NvVu1QOmICbf5R3FziTjwzrN6VUxjEBvsvLmMi+CbbSYsHIX5YQLvPqZ8ezPX/DKccuIl0980C5B1UM6DEZwGIdc+77/6IWVGy5eiPdOxRVhAiUQr5k3i71G1vdSjYTG8k5YR5qcDSEJETPdVs2FmSa77fzmu4d4I2Z3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VaorH3gH; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-64d30dc4ed7so16141787a12.0
        for <bpf@vger.kernel.org>; Tue, 13 Jan 2026 18:21:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768357288; x=1768962088; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9CtFeJnPREY9GlftSI0+3WecRd+pRDNwry7iC84AqLc=;
        b=VaorH3gHKw5Q1fA+sIxN3VS/Kn5c9vZct48xfGydmQHjOTYBhR6JIFpg7wGCgIuNlA
         oiw6D/lpFDLlFucueR3pLMa3vfjLyLp4NSewDFSGDUMd8NXofzQS5pH8j9a2sHHo/g49
         OJKTidtMVJ+0BUFLsLwH8kHcl3D5m37UCxbLa/YMbINFzSMGshek6VrziCnrBLaUE2CV
         UpWLtERRppFIOjQHxI4GC65DC/39RXNGB1HS6xzjS9cZeUFjKyVNAcNxohuyEu5rW2oJ
         BE+mySYTnX98FKqgbrwZE70XN5Dy6cr5q+p8scDYYtaSwX73p/pwzizWzpXnKpIRasEc
         6WvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768357288; x=1768962088;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9CtFeJnPREY9GlftSI0+3WecRd+pRDNwry7iC84AqLc=;
        b=v5OouHaMpiqD6W7eDnZK2JvgkvHL4EBtG/4gCDL1c4FW4fQA+IRlpLfIPU4IqYLC4b
         8V1FKpGDI5vyxN3GMe5s5RutLBxhHtRL1TuGMQWaD5Y0AwEdJ5t/dxO2Ip8GVNH0x9kQ
         Hsas8yTqmMA311pvpe5il67vedgwn35xPsWeGxJOesiC5bioWgMA6h7a47sxAPDGN9fM
         z2Eup1dk33s5DxZbJkjsu7lUBkPQj5j8YVFOO2gabxYWQ4lAPV/t/W4qOZu5oYIzXaPn
         CxuKJ4yhQYpdB95CrdtTf774cf1ICYYxZRPs8oPIHNSFecdCETZRt0LSPhTKR0gDO+kU
         YHXA==
X-Forwarded-Encrypted: i=1; AJvYcCXdi96jnop3V8Ut1JuE1fWXG4M1jkjNCClRa+P3Zu7Y6lrWgdX/lJ/WPa1QgvQNgE+gqpM=@vger.kernel.org
X-Gm-Message-State: AOJu0YySKMeBNAe5Nt/0EQYwB1GZrqsZG1FZPVesva52bFVN2j3kuFGD
	LLR2StEUhMXhuf7s1SDUym8PJimhUpjRybEnuyl3xFfIqS5YJVx6uHX8a0k5vFVq2wNarJJReEE
	QXqN/fuSmLy+blsbmfq3FfyzKFRwDUXs=
X-Gm-Gg: AY/fxX4tdUp0fC9myZk/BJxtDlp5TI5oG2ikcfbxVA5TN+VCA0JVloeMdH+mZzEAm/I
	mcA91hn5HKsjyrlId8M1SKxH0lEznQ+nYO/l515XHI9ig+xyWzECQX5njWa2XlG+gos37BjdLcl
	e0C8LCJyPg4VKKKAZf+uvUSS6gR1qndSZeyQGV2ijEIEnty6NQym5F0toM/jCLdpfS8jXQ5S+6G
	mzf/+IUESvVGGqnMgRFZLSgRykXyJ0PVZu3Abjgmol/c0mGh98x26WQZ+D2OHv72ycn7syW
X-Received: by 2002:a17:907:94ca:b0:b72:a899:169f with SMTP id
 a640c23a62f3a-b8760fe881emr96932366b.4.1768357287571; Tue, 13 Jan 2026
 18:21:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260109130003.3313716-1-dolinux.peng@gmail.com>
 <20260109130003.3313716-5-dolinux.peng@gmail.com> <CAEf4BzZkNdZuSWb+G98LDSn3gL22p+g7-dHqFVH6jcqUsrKYVA@mail.gmail.com>
 <CAErzpmvj0JM_TuYwR0FPbZ_jNAqqeq1dRK1n6r_nGiEzjQ8oDg@mail.gmail.com>
In-Reply-To: <CAErzpmvj0JM_TuYwR0FPbZ_jNAqqeq1dRK1n6r_nGiEzjQ8oDg@mail.gmail.com>
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Wed, 14 Jan 2026 10:21:16 +0800
X-Gm-Features: AZwV_Qh8UK6YQ7Ge6ztokYHeGcjn0PX9h_smBDhNt0fZUOxKSSVEo4oHFud4f08
Message-ID: <CAErzpmshz6pG1_0q4bH4Y2D90xZmrtR1r6AXetubaFK5JjqvgQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v12 04/11] libbpf: Optimize type lookup with
 binary search for sorted BTF
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: ast@kernel.org, eddyz87@gmail.com, zhangxiaoqin@xiaomi.com, 
	ihor.solodrai@linux.dev, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	Donglin Peng <pengdonglin@xiaomi.com>, Alan Maguire <alan.maguire@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 14, 2026 at 9:49=E2=80=AFAM Donglin Peng <dolinux.peng@gmail.co=
m> wrote:
>
> On Wed, Jan 14, 2026 at 8:29=E2=80=AFAM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Fri, Jan 9, 2026 at 5:00=E2=80=AFAM Donglin Peng <dolinux.peng@gmail=
.com> wrote:
> > >
> > > From: Donglin Peng <pengdonglin@xiaomi.com>
> > >
> > > This patch introduces binary search optimization for BTF type lookups
> > > when the BTF instance contains sorted types.
> > >
> > > The optimization significantly improves performance when searching fo=
r
> > > types in large BTF instances with sorted types. For unsorted BTF, the
> > > implementation falls back to the original linear search.
> > >
> > > Cc: Eduard Zingerman <eddyz87@gmail.com>
> > > Cc: Alexei Starovoitov <ast@kernel.org>
> > > Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> > > Cc: Alan Maguire <alan.maguire@oracle.com>
> > > Cc: Ihor Solodrai <ihor.solodrai@linux.dev>
> > > Cc: Xiaoqin Zhang <zhangxiaoqin@xiaomi.com>
> > > Signed-off-by: Donglin Peng <pengdonglin@xiaomi.com>
> > > ---
> > >  tools/lib/bpf/btf.c | 90 +++++++++++++++++++++++++++++++++----------=
--
> > >  1 file changed, 66 insertions(+), 24 deletions(-)
> > >
> >
> > [...]
> >
> > >  static __s32 btf_find_by_name_kind(const struct btf *btf, int start_=
id,
> > > -                                  const char *type_name, __u32 kind)
> > > +                                  const char *type_name, __s32 kind)
> > >  {
> > > -       __u32 i, nr_types =3D btf__type_cnt(btf);
> > > +       const struct btf_type *t;
> > > +       const char *tname;
> > > +       __s32 idx;
> > > +
> > > +       if (start_id < btf->start_id) {
> > > +               idx =3D btf_find_by_name_kind(btf->base_btf, start_id=
,
> > > +                                           type_name, kind);
> > > +               if (idx >=3D 0)
> > > +                       return idx;
> > > +               start_id =3D btf->start_id;
> > > +       }
> > >
> > > -       if (kind =3D=3D BTF_KIND_UNKN || !strcmp(type_name, "void"))
> > > +       if (kind =3D=3D BTF_KIND_UNKN || strcmp(type_name, "void") =
=3D=3D 0)
> > >                 return 0;
> > >
> > > -       for (i =3D start_id; i < nr_types; i++) {
> > > -               const struct btf_type *t =3D btf__type_by_id(btf, i);
> > > -               const char *name;
> > > +       if (btf->named_start_id > 0 && type_name[0]) {
> > > +               start_id =3D max(start_id, btf->named_start_id);
> > > +               idx =3D btf_find_type_by_name_bsearch(btf, type_name,=
 start_id);
> > > +               for (; idx < btf__type_cnt(btf); idx++) {
> >
> > I hope the compiler will optimize out btf__type_cnt() and won't be
> > recalculating it all the time, but I'd absolutely make sure by keeping
> > nr_types local variable which you deleted for some reason. Please
> > include in your follow up.
>
> Thanks, I will optimize it.
>
> >
> > > +                       t =3D btf__type_by_id(btf, idx);
> > > +                       tname =3D btf__str_by_offset(btf, t->name_off=
);
> > > +                       if (strcmp(tname, type_name) !=3D 0)
> > > +                               return libbpf_err(-ENOENT);
> > > +                       if (kind < 0 || btf_kind(t) =3D=3D kind)
> > > +                               return idx;
> > > +               }
> > > +       } else {
> > > +               __u32 i, total;
> > >
> > > -               if (btf_kind(t) !=3D kind)
> > > -                       continue;
> > > -               name =3D btf__name_by_offset(btf, t->name_off);
> > > -               if (name && !strcmp(type_name, name))
> > > -                       return i;
> > > +               total =3D btf__type_cnt(btf);
> >
> > and here you have a local total pre-calculated. Just move it outside
> > of this if/else and use in both branches
>
> Thanks, I will fix it.
>
> >
> > (I adjusted this trivially while applying, also unified idx,i -> id

Thank you for fixing it.

>
> Thanks, I will fix it in v13.
>
> >
> >
> > > +               for (i =3D start_id; i < total; i++) {
> > > +                       t =3D btf_type_by_id(btf, i);
> > > +                       if (kind > 0 && btf_kind(t) !=3D kind)
> > > +                               continue;
> > > +                       tname =3D btf__str_by_offset(btf, t->name_off=
);
> > > +                       if (strcmp(tname, type_name) =3D=3D 0)
> > > +                               return i;
> > > +               }
> > >         }
> > >
> >
> > [...]

