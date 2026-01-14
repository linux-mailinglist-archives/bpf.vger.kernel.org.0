Return-Path: <bpf+bounces-78807-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2449AD1BFD6
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 02:50:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 58807301E929
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 01:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B31D129E0E9;
	Wed, 14 Jan 2026 01:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mp//6ZO2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB48D22756A
	for <bpf@vger.kernel.org>; Wed, 14 Jan 2026 01:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768355409; cv=none; b=GaKR9bWoTmseLfwrSuAlk6tFqqgU6mchKPDTYLjIMMmLsERg5s5WAkD6hvktpT/+Nci6jDJ5wR+xpMU/JjqQRlntufvSRvEK6nsOCaLm77w67m2egPbeN/kAHXTRXy04mP4/gDDJrAzF0fmS19F2V9JgBM50tDIhm0zQpevOcBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768355409; c=relaxed/simple;
	bh=oU00+JjrbuMbXODHTnS6leTk9lTfMB/Mom4uQzA2SO0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=skswVep/VOfATQL9zpMCXaOXI+kAOGIj21Fq6KWOV7VUwQgcmZPSnZQSxw7hfG6Kj21OZKLRlZgi1+uUYe9h44wc8eJoHHaX5CW1I6M/ck3xjWV1LK1ZTQfYGGHB6Ve9XK27m0tBlEvmeAzlsS081BwPQTbTirOEK111bDWzAGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mp//6ZO2; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-650854c473fso678209a12.1
        for <bpf@vger.kernel.org>; Tue, 13 Jan 2026 17:50:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768355406; x=1768960206; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nBPbuW61UDGDWSDuj3lFMCrY7WQH55VaD99MvA4uo/Q=;
        b=mp//6ZO2uFjPY/TqnS3Q15wtiItQCuSSPY5UqKTx/lXpTSs168T41+X1XHPPdK/kOY
         NVa+hfpoP5F834bIXDAt05JWD1AKukQnzOQnOvn08EHjF1Tr9kYi9zC5lQWQrYLe3DRM
         TclsEsMJIAJRGomp59LQkpzQplJjqhJR0PuzGuCuQdQitM51QOp6dqiTdsdQCCgrKx7R
         LRthyKK7g/o+Ljq8k245H0NHKdUTpdDF9D8zHriHfYyHqsTr/LmHZUoHCEMgG7oUt+uQ
         IeBaSdOP1tB7l/CgAl7u+pPsoGejqYYEpwPUY2LtUaw6rKW4eIt8nT4EmJlEj3KYXNiT
         CpqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768355406; x=1768960206;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nBPbuW61UDGDWSDuj3lFMCrY7WQH55VaD99MvA4uo/Q=;
        b=ux8m9bBdyRdLAcOXYAObWCPFEExJzKAqBRLmBr8LrtK9zDCfZiHz9j8aTxWhgkFUvx
         2hiCpcrABW4ubtxfwDhknNp6yuCMC2nrk2Azy2m6MMg6K8m6plhvQAaUnoqhXB5QwYV2
         4D23n0PVAQueREYtiik58MznUzwxU97Ci3fR0yZPROxrjNkpPBtqVG3/1TpEXqvE/lUO
         PFin1r4gEM+1FU1kNaLYg0APq6jh/RW1ofVplu1af5kmaR8sX516rj32MsXa4otBBy6C
         HiPbBQVuMFSpl8uuxRY5iq/EJyz32muetDW0NCXOwrqkueaW0H1RfSTXbm3XZJWyNBzK
         9wBQ==
X-Forwarded-Encrypted: i=1; AJvYcCWV2LG/0r6mYI8SHeIu0/acqN2v0YhkkLC4QPPUh7FKcKo3VKk6nClD/H3fi1duVIru8hQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxo4r6NKUHY4MT3dWrzncXM3tnK9N1iVAkwvr4fJ9W6iXqsjmX3
	ef3qrxURcd4N/eiv/TfGgrWg1mXV+RVcr3bEFOlr1Z4Fzp/DzzN1p2I1bo8JSDWXTs49BO7yQde
	sF3FRSaUuhsWWnGMXz1BDlD15KH4HQvY=
X-Gm-Gg: AY/fxX6AqpUvi3Hx8CZ8GC3lPqF34j0jvb7jdBoILYjUXOvbt76UWm5sLu41ho/0DXG
	rqxs+H8K3DokRujrVzNsuxDoX4hAyzz+w9i1rDKecCba44uMJoMHBTEOVhzhlXTaF0q9LpQ3Aev
	xT9ramMu/FZZQhm86rgT3XHrgjn5TDTPxZeMKqmzRxoqeg/DSpJGIcmk8jDE/+qPLGFputEzKTv
	wZarsrCbdXlIPpS0Ze8yp88EYT/v/azEmGXLo8pEqabXl1K6mZCvtkah0TxUO1lmHCBnSuxEaC/
	2mVin7w=
X-Received: by 2002:a17:907:6ea5:b0:b87:59a8:4c8 with SMTP id
 a640c23a62f3a-b8761be4e06mr89281866b.5.1768355404591; Tue, 13 Jan 2026
 17:50:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260109130003.3313716-1-dolinux.peng@gmail.com>
 <20260109130003.3313716-7-dolinux.peng@gmail.com> <CAEf4BzZfm=AxAC6TB_OLcKZeH=M=Z=AFftSoCZg-pJ7ChQyZYA@mail.gmail.com>
In-Reply-To: <CAEf4BzZfm=AxAC6TB_OLcKZeH=M=Z=AFftSoCZg-pJ7ChQyZYA@mail.gmail.com>
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Wed, 14 Jan 2026 09:49:53 +0800
X-Gm-Features: AZwV_Qg0kUt3wH4o_ptrBy3dIs80VpZHLjUmbWIGsif54SxaKG-fR-LwDNZ1_uA
Message-ID: <CAErzpmsKd2E23KgEaX8BDHWHkSoTzSoS5DQ+dn+sK91BH5ZBzw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v12 06/11] btf: Optimize type lookup with binary search
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
> > Improve btf_find_by_name_kind() performance by adding binary search
> > support for sorted types. Falls back to linear search for compatibility=
.
> >
> > Cc: Eduard Zingerman <eddyz87@gmail.com>
> > Cc: Alexei Starovoitov <ast@kernel.org>
> > Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> > Cc: Alan Maguire <alan.maguire@oracle.com>
> > Cc: Ihor Solodrai <ihor.solodrai@linux.dev>
> > Cc: Xiaoqin Zhang <zhangxiaoqin@xiaomi.com>
> > Signed-off-by: Donglin Peng <pengdonglin@xiaomi.com>
> > ---
> >  include/linux/btf.h |  1 +
> >  kernel/bpf/btf.c    | 91 ++++++++++++++++++++++++++++++++++++++++-----
> >  2 files changed, 83 insertions(+), 9 deletions(-)
> >
>
> [...]
>
> >  s32 btf_find_by_name_kind(const struct btf *btf, const char *name, u8 =
kind)
> >  {
> > +       const struct btf *base_btf =3D btf_base_btf(btf);
> >         const struct btf_type *t;
> >         const char *tname;
> > -       u32 i, total;
> > +       s32 idx;
> >
> > -       total =3D btf_nr_types(btf);
> > -       for (i =3D 1; i < total; i++) {
> > -               t =3D btf_type_by_id(btf, i);
> > -               if (BTF_INFO_KIND(t->info) !=3D kind)
> > -                       continue;
> > +       if (base_btf) {
> > +               idx =3D btf_find_by_name_kind(base_btf, name, kind);
> > +               if (idx > 0)
> > +                       return idx;
> > +       }
> >
> > -               tname =3D btf_name_by_offset(btf, t->name_off);
> > -               if (!strcmp(tname, name))
> > -                       return i;
> > +       if (btf->named_start_id > 0 && name[0]) {
> > +               idx =3D btf_find_by_name_kind_bsearch(btf, name);
> > +               for (; idx < btf_nr_types(btf); idx++) {
>
> same nit about inconsistent btf_nr_types() usage between two branches:
> compute once early and use in both branches
>
> (fixed up similarly to libbpf implementation; also fixed up comment style=
 )

Thanks, I will fix it.

>
> > +                       t =3D btf_type_by_id(btf, idx);
> > +                       tname =3D btf_name_by_offset(btf, t->name_off);
> > +                       if (strcmp(tname, name) !=3D 0)
> > +                               return -ENOENT;
> > +                       if (BTF_INFO_KIND(t->info) =3D=3D kind)
> > +                               return idx;
> > +               }
>
> [...]

