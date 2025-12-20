Return-Path: <bpf+bounces-77249-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B2367CD30B8
	for <lists+bpf@lfdr.de>; Sat, 20 Dec 2025 15:25:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 130D530181B9
	for <lists+bpf@lfdr.de>; Sat, 20 Dec 2025 14:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D5E1299931;
	Sat, 20 Dec 2025 14:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eXkQfQvt"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378B828C874
	for <bpf@vger.kernel.org>; Sat, 20 Dec 2025 14:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766240730; cv=none; b=Cf6xdiyf2XQFbjvQt1ZSS+d9ovgBukF0rzTDWQJHi2UYNyYTxnGhxGNNcYWRS/v1toZRaobSqZMAZhd988dKVujAlovurrcvycG9SXCbAUgqtlajAVjQS591RfSONStB1p5TKc8LZ5u08bKyZHD9owF8OCRD+/KUIEQQ9xx7D7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766240730; c=relaxed/simple;
	bh=ZwcOZljqx7n3FvngLyGGvSdUSEa1Yx2M4We0YIvwBZo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jPJh0pdHkCdPuc4cBUApvVeg+42A0gv+olkkXa7gY225aLgZlHCmS7M44FrmRcJxyNp2yCw984iKA7yYGtEY79ZfiYWxF1Y6Zfo8hxmzALMpwvhUYVXljHTMUNskAT2XBgcSE+7ZCWGClQ+SWZ+fpdgFnsAk+YY3wxVJ+daztPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eXkQfQvt; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b73161849e1so601406966b.2
        for <bpf@vger.kernel.org>; Sat, 20 Dec 2025 06:25:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766240727; x=1766845527; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pi8qrPkIVipBmVR3eY0AmCM8P7aIH2ee759mdfrcNc4=;
        b=eXkQfQvt58Q0aZEs5QjC/zR9OVQgcZLYYd8KDKz2+OM0tN+5FuYes46tLsuNLSwbgU
         qUCkgQeDZKzRZD11SBjy2eACXnzWxbQ0VCXYUsSFs09usNw+1pQNj2uVV8dHgTwQxokv
         06QpiS9BqzvdP/qxW6+7nlQIptgQa2tyf+S8DzV2yTyN6niO4gYeRtTIxRMJlg37xwgY
         NnFhPLjdHdIh/LYoiK+7RmW/BElS3JxZzD4/OizUqkPjtYmaT9JQZylQCfODrUfIINGG
         7uW1GeP1hxCO8EturW+6HN7lqVLvpg8iv2RR5z0e2LvTNpLFesAOgapEW+iPsbLt5KkJ
         KUTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766240727; x=1766845527;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pi8qrPkIVipBmVR3eY0AmCM8P7aIH2ee759mdfrcNc4=;
        b=Hpbx9HVYSJ3+DdV2SOUMap3Pb4/Qys4I3ITzMRr1CKXYQ6QCVgJh9YyziazC+v+hgI
         4qKG0cOrNv0UTBhbaspG3MnfUBrSBlNpy4usISeWEjXPHgY8trx3p2IEge8NuFYjyFsr
         A1xOaKh4dZvuZYH78z/nRaGvD9AMDDJYRlj/3gdLc5R3ZDh4zdoK13o2knmvIEYQ8GBZ
         LZDzD/WM9FyYBv+hnvkStpHCQX2XXGGkVpcmfYNtj/coYPWs0fFaco7Iy0PlGNHuS2WY
         2R7UdP4uBzeA9fQoXLJuC+RCWwOwYZKDQxXq9dYQwT87BczhZ+RPG73vCA7JGG0Lj+6h
         xVPw==
X-Forwarded-Encrypted: i=1; AJvYcCW5DOk3KOFLPEN5aiXeggKcO6LI9dsGx8EWF+cjjnHar4bkS6JARp3L91GHVVzY4pFh8bs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhVQLxvl7tsSzeGDv+BImxqesWFMvtkqvuEPbp7dzjIAeMkt7+
	7bMOp40m6eRxTGSQXQou3SNwPkmlYhavQnXHTWaOTtD+5d8RGahBjAViHCybFmylx3aRkfL9DAM
	7OPifK8LJzkOj9sg/MdlrgttAn7YOax0=
X-Gm-Gg: AY/fxX5eGitDVB14FRwEvp+BujqTZ0Hqy9NyapJkt1pu1iJakWEw4iZTJrNFHhgGc/4
	cbV3Hg7nL3chOUgXumi63k3gfdJsj734J1mCbMw4/wwGmdX/lQeI8TqQFhr7JlbQHjbUAKjRO8t
	VHVDEq5b4ZYcQ95kLop2+KlISo9GHpx3sDNNYx67o7NiFRKg9OLicklSDSVBM3lb0tv7+PFHCyC
	9ByFYSvIHF2WQhopmjZsRtv9a8q8XI3TWduTZwp66VZSs/lpGCjikLnU87lvbwWA+uAUiAL
X-Google-Smtp-Source: AGHT+IGiWJjsCA+8SZzuP006pCmgab0r35vcgcaWL5+MZszb+qdxWz90h1vvqhmkyzN1FG0+b/iks+iO/TRiqtgEKlM=
X-Received: by 2002:a17:907:7ea2:b0:b79:a827:4c4a with SMTP id
 a640c23a62f3a-b8036f1308cmr610914966b.15.1766240727257; Sat, 20 Dec 2025
 06:25:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251218113051.455293-1-dolinux.peng@gmail.com>
 <20251218113051.455293-13-dolinux.peng@gmail.com> <CAEf4BzYwEywc2y8VV=1s2gjrQxsHZzOipNiCeKGTK0bjnqj7LQ@mail.gmail.com>
In-Reply-To: <CAEf4BzYwEywc2y8VV=1s2gjrQxsHZzOipNiCeKGTK0bjnqj7LQ@mail.gmail.com>
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Sat, 20 Dec 2025 22:25:15 +0800
X-Gm-Features: AQt7F2phsreejUEV3cGreFZ26EBNuDgJhsOmETAZnRPuedCwtQaRmxDbSzozOUQ
Message-ID: <CAErzpmu0achwAo7V6N04GkDL4ofoQBwKiQ0Siq8v9HOKYRv3RQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v10 12/13] btf: Add btf_is_sorted to refactor the code
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: ast@kernel.org, eddyz87@gmail.com, zhangxiaoqin@xiaomi.com, 
	ihor.solodrai@linux.dev, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	pengdonglin <pengdonglin@xiaomi.com>, Alan Maguire <alan.maguire@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 19, 2025 at 8:05=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, Dec 18, 2025 at 3:31=E2=80=AFAM Donglin Peng <dolinux.peng@gmail.=
com> wrote:
> >
> > From: pengdonglin <pengdonglin@xiaomi.com>
> >
> > Introduce a new helper function to clarify the code and no
> > functional changes are introduced.
> >
> > Cc: Eduard Zingerman <eddyz87@gmail.com>
> > Cc: Alexei Starovoitov <ast@kernel.org>
> > Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> > Cc: Alan Maguire <alan.maguire@oracle.com>
> > Cc: Ihor Solodrai <ihor.solodrai@linux.dev>
> > Cc: Xiaoqin Zhang <zhangxiaoqin@xiaomi.com>
> > Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
> > ---
> >  include/linux/btf.h | 1 +
> >  kernel/bpf/btf.c    | 9 +++++++--
> >  2 files changed, 8 insertions(+), 2 deletions(-)
> >
>
> let's drop, this is not necessary

Okay, I will drop it.

>
>
> > diff --git a/include/linux/btf.h b/include/linux/btf.h
> > index 2d28f2b22ae5..947ed2abf632 100644
> > --- a/include/linux/btf.h
> > +++ b/include/linux/btf.h
> > @@ -221,6 +221,7 @@ bool btf_is_vmlinux(const struct btf *btf);
> >  struct module *btf_try_get_module(const struct btf *btf);
> >  u32 btf_nr_types(const struct btf *btf);
> >  u32 btf_sorted_start_id(const struct btf *btf);
> > +bool btf_is_sorted(const struct btf *btf);
> >  struct btf *btf_base_btf(const struct btf *btf);
> >  bool btf_type_is_i32(const struct btf_type *t);
> >  bool btf_type_is_i64(const struct btf_type *t);
> > diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> > index 3aeb4f00cbfe..0f20887a6f02 100644
> > --- a/kernel/bpf/btf.c
> > +++ b/kernel/bpf/btf.c
> > @@ -555,6 +555,11 @@ u32 btf_sorted_start_id(const struct btf *btf)
> >         return btf->sorted_start_id ?: (btf->start_id ?: 1);
> >  }
> >
> > +bool btf_is_sorted(const struct btf *btf)
> > +{
> > +       return btf->sorted_start_id > 0;
> > +}
> > +
> >  /*
> >   * Assuming that types are sorted by name in ascending order.
> >   */
> > @@ -649,9 +654,9 @@ s32 btf_find_by_name_kind(const struct btf *btf, co=
nst char *name, u8 kind)
> >                         return idx;
> >         }
> >
> > -       if (btf->sorted_start_id > 0 && name[0]) {
> > +       if (btf_is_sorted(btf) && name[0]) {
> >                 /* skip anonymous types */
> > -               s32 start_id =3D btf->sorted_start_id;
> > +               s32 start_id =3D btf_sorted_start_id(btf);
> >                 s32 end_id =3D btf_nr_types(btf) - 1;
> >
> >                 idx =3D btf_find_by_name_bsearch(btf, name, start_id, e=
nd_id);
> > --
> > 2.34.1
> >

