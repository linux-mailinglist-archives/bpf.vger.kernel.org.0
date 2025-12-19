Return-Path: <bpf+bounces-77134-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EFB89CCE978
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 06:52:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B2558300EE57
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 05:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D067F2D6E52;
	Fri, 19 Dec 2025 05:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IxmUvrOp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B261FF1C4
	for <bpf@vger.kernel.org>; Fri, 19 Dec 2025 05:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766123505; cv=none; b=i1NO6ezo1n+duEplBPGbmYxWUC6bRQ6O8vqZT0NHAzn5mZOshODS7HS8Kpe3QGQBkUH4d8u2clyLI0Ox1K1Xc099UtuQCQu9wEBDFIcdkTqQxclVMH1CJ/61k3dCDaFL7JNzg5u5SOnrrYdo6LWRBJ71FAZ+8cP3QYyz2T1w34Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766123505; c=relaxed/simple;
	bh=pMwqmnGscPOl6KWDprOcLgtp9he9DmvrLtIl8hHsvpU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fG7dan3Nl6GmjEvZ1yzAInLhUcYtBr3BYSV/4TT85SFEpM3Qnor20L0MnOlLHYRA0R6zLKKgIQBHlWnC6zcmhAfYW6qMR6k2SzR/Jt1PHPLOvSoWGM+DxHc/pN4fWOf7Q1Jg8D1NfAIOTs/PJzD71V6Ce5iZ+I8xKTCJSunehBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IxmUvrOp; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-64b9d01e473so331855a12.2
        for <bpf@vger.kernel.org>; Thu, 18 Dec 2025 21:51:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766123502; x=1766728302; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jg4KzDDn5eCP6g4CGe9QqXBGUU+Hn7G0eHz1Fgccg+Y=;
        b=IxmUvrOpPtE7IyQ1bzpGpaJ80hYgnHIQiBFzz7lx2hZ99l+b0cAqcHJWBy7GhwvC2a
         5vrEm7DpgjiTzFvMmeHKzfGCF4R5Lra0um8VittJHeCkUz8WmQcbOVIg4fCCxrVX9ygX
         z7uMVEmlZbDVBp8iL9vtpi2xaThI4c6IPRc7K6NkhMCMwvIxBLbqj8RFv7eE54GViXqW
         FO62gVJ/JjZseL8tO+yLQgQ75aj8UQiv4WuwyM+ymV17qJ8sX9+TWX7GHA2KhGp4biEc
         Ewqj3gs4aDl57a3PbJ9mohezGuCSy4XCFirvaVhvll2dpDE6gH9lFhOZT+wLQw326V2K
         /syg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766123502; x=1766728302;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jg4KzDDn5eCP6g4CGe9QqXBGUU+Hn7G0eHz1Fgccg+Y=;
        b=DgGccwO2DLF7JsS48HQHL5QURJ0smNvGBGFLztBnFPNtI5DG3Db6k9xE9dFxr5M3Me
         CM2WUpubp8yBYBBesUrH/BtFLsSje5yMCOShDJJDrZxKeY0Pd6DZxhTl+jAMafUWHTtk
         2rXM6q6hrSBrcUOKXZpoR+rRAPWK+DBPXTM8xf2GG978I4SdEu7GxBoCJdpcnxOrmFIm
         tfd5IDUkiyA1tZjJuUMTZtLcBlMD+L7B02X4GdM/XqCanh3Z78ul4wfJsMz/R2g/e9+c
         vMcTcwN85nyUpm3g2TEmfG5+Y69SsUGOqxEw7tMBXNvlm8d7T1t4AGUUHwEdN8Ogrx1I
         f25A==
X-Forwarded-Encrypted: i=1; AJvYcCV1d7HOL5Zv5IaLApZJuUh46kqQOdibQ8GMxZbxyt7WBfuZMjwOaBMKvsy8mlFM4IiffbU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLtJZas4vnQ7ZSUSZl1H3LNO1O0jRRQ1WQJEUiWvlpvJKhTzz3
	P2e98EtQ+mfcPZEkp+l6IKbBR/RyUUukNJK2DW7ufO3xapKsT8k1Zyys/GaS2jwwVHBGPTJxjj7
	Le3BSecsZOkwZAePaoEwdpyQvhUoPcVg=
X-Gm-Gg: AY/fxX4FfJ1PxrBCd7fuAVkUiwDDXjKfQS8WDXeFszdFg+fXy7uYzc3+Y6+DnZGHPU/
	2QAyfprPcG16Pg+c/OsL0TzAqek+aG/OtiEsrOZCllC1JbbSdPXYvIWwdMGat2U7B6gJV9AV6P8
	gBwaXosy0nyt9rdFZxXpn/K1DL2JgaXgRGPnmssAkp3fyLJndWFv7ATMRwh6FGGjikw2SY7Z23W
	5TKyOSb+l9dAxlO+0mbZ9XFUqOJaNjSUgrgiWoO17oFh4LJxz2GPuLyiyjfqGL/5o6TqZ6G
X-Google-Smtp-Source: AGHT+IEsKsuMFoyCxpxiWcvFij8vo10TUEx2RydYsbh8sFi0E+qPnLMzGNUrJGkjNmexO+3jdQR2jXkcrUQwPOJa3Os=
X-Received: by 2002:a17:906:7315:b0:b80:1b27:f2fd with SMTP id
 a640c23a62f3a-b80371da6f3mr185958066b.54.1766123501785; Thu, 18 Dec 2025
 21:51:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251218113051.455293-1-dolinux.peng@gmail.com>
 <20251218113051.455293-12-dolinux.peng@gmail.com> <CAEf4BzZGz1k4ma4hYL-nR_e5QQxuzM3Y+VxZNWe_YupeQMj0-w@mail.gmail.com>
In-Reply-To: <CAEf4BzZGz1k4ma4hYL-nR_e5QQxuzM3Y+VxZNWe_YupeQMj0-w@mail.gmail.com>
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Fri, 19 Dec 2025 13:51:30 +0800
X-Gm-Features: AQt7F2pQYnsja1VoZKr3dZxYfjOgxIRt7vGU_P5dr7RrvD24VAd2hs7FcPgG-lk
Message-ID: <CAErzpmuuSfBOomFbre-OBrW5+PHbvxgjrWZApZ=UC2LP0c5kQw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v10 11/13] libbpf: Add btf_is_sorted and
 btf_sorted_start_id helpers to refactor the code
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
> > Introduce two new helper functions to clarify the code and no
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
> >  tools/lib/bpf/btf.c             | 14 ++++++++++++--
> >  tools/lib/bpf/libbpf_internal.h |  2 ++
> >  2 files changed, 14 insertions(+), 2 deletions(-)
> >
>
> It just adds more functions to jump to and check what it's doing. I
> don't think this adds much value, just drop this patch

Could adding the __always_inline be acceptable?

>
>
> > diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> > index b5b0898d033d..571b72bd90b5 100644
> > --- a/tools/lib/bpf/btf.c
> > +++ b/tools/lib/bpf/btf.c
> > @@ -626,6 +626,16 @@ const struct btf *btf__base_btf(const struct btf *=
btf)
> >         return btf->base_btf;
> >  }
> >
> > +int btf_sorted_start_id(const struct btf *btf)
> > +{
> > +       return btf->sorted_start_id;
> > +}
> > +
> > +bool btf_is_sorted(const struct btf *btf)
> > +{
> > +       return btf->sorted_start_id > 0;
> > +}
> > +
> >  /* internal helper returning non-const pointer to a type */
> >  struct btf_type *btf_type_by_id(const struct btf *btf, __u32 type_id)
> >  {
> > @@ -976,11 +986,11 @@ static __s32 btf_find_by_name_kind(const struct b=
tf *btf, int start_id,
> >         if (kind =3D=3D BTF_KIND_UNKN || strcmp(type_name, "void") =3D=
=3D 0)
> >                 return 0;
> >
> > -       if (btf->sorted_start_id > 0 && type_name[0]) {
> > +       if (btf_is_sorted(btf) && type_name[0]) {
> >                 __s32 end_id =3D btf__type_cnt(btf) - 1;
> >
> >                 /* skip anonymous types */
> > -               start_id =3D max(start_id, btf->sorted_start_id);
> > +               start_id =3D max(start_id, btf_sorted_start_id(btf));
> >                 idx =3D btf_find_by_name_bsearch(btf, type_name, start_=
id, end_id);
> >                 if (unlikely(idx < 0))
> >                         return libbpf_err(-ENOENT);
> > diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_int=
ernal.h
> > index fc59b21b51b5..95e6848396b4 100644
> > --- a/tools/lib/bpf/libbpf_internal.h
> > +++ b/tools/lib/bpf/libbpf_internal.h
> > @@ -250,6 +250,8 @@ const struct btf_type *skip_mods_and_typedefs(const=
 struct btf *btf, __u32 id, _
> >  const struct btf_header *btf_header(const struct btf *btf);
> >  void btf_set_base_btf(struct btf *btf, const struct btf *base_btf);
> >  int btf_relocate(struct btf *btf, const struct btf *base_btf, __u32 **=
id_map);
> > +int btf_sorted_start_id(const struct btf *btf);
> > +bool btf_is_sorted(const struct btf *btf);
> >
> >  static inline enum btf_func_linkage btf_func_linkage(const struct btf_=
type *t)
> >  {
> > --
> > 2.34.1
> >

