Return-Path: <bpf+bounces-77122-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DFEACCE61D
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 04:42:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DB1053027A5F
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 03:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2FF227B348;
	Fri, 19 Dec 2025 03:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L4SPajSY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B55DC1531C8
	for <bpf@vger.kernel.org>; Fri, 19 Dec 2025 03:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766115760; cv=none; b=oxa/JxfuuMyofp0b9cWu/5lEyC1zTVDB8FxkO/a0DEg1R9iE+oDqFseb/em7Q+ClIpK2DgNHMJ1kyHzgsmf4d0sFxAsOrYqU456URjGvFosCtozaiRXEnNeDrGDunnSrdJSzDLlFIyaenpQAm4TJhQJ/uxD0g9Cmag3sr4FG7d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766115760; c=relaxed/simple;
	bh=8CCCSfIIr6YeamAO9ZyYgoaiS+Y90mrsNe5cCo+U2Ho=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jtl5VRUhTNZ2+wP9FD0ohmr2UtsfCDZ5PRQ6Fw/3H/DNYVhCTlqSeX8rqt4P/yohQoHt1/ue7h3aB0XX3EmqAf0r/AnwsksVFgUvk3oN/UesdxXsUO1h7DzUDbfD5bRNbXrlsDgFzqolP8Fjm8vhDnGM4t6y7KvVZvhZ6rwLgH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L4SPajSY; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b79d0a0537bso171575666b.2
        for <bpf@vger.kernel.org>; Thu, 18 Dec 2025 19:42:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766115757; x=1766720557; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dMPwI1HtswxNm+XVges1CThO4QGc0eYiBmbs2IWrlKw=;
        b=L4SPajSYtYJE0n6OP0+VvHfsWi1ES95rWZSFpey6nzf3F4UuSwLTASi8DVtA29Vlpf
         T93kc5Dq2L59o01I3HSpIFlnKc2NWOK942Kr0UpMdRF/wko49NGq2fKB5G197ojkjek7
         BVCbnEoFywjB1VMN4lG1XkVddEOnoycZ02As+JpG5AXQEDZCM7BEdT73YezgFVPkFn7c
         5H1hZsVpmD8jxx1tq67uamBREEP9z3u55As1ao5qVeAIL+XaettTuvEySQYnXsllWgeP
         IVHCfc2x9Sx0a7aTLCYbfgCoFxqhRi3ogT6o4GI7tGAISzFHMv8vZHBreks4Ztm5xsOQ
         ciHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766115757; x=1766720557;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dMPwI1HtswxNm+XVges1CThO4QGc0eYiBmbs2IWrlKw=;
        b=K30q69orCeOsuUKYWfYk3gTed+hOcBpnvK/InqXNqC41r/CgT1fBd0Vj+5tFYGAt2l
         IOUG1xwNv3NPAxmqxB7HTYOw3VmHM5Kl5BNulHwOkCF6XeMbCVIj3rrZ9cH5+mbdbwlz
         nFVeo6moqKyCdso0HLMWn4CiuD3h4XPMd0sTRWM5k/AYzyMjOXsZBLSPJ1Y3+DLAxXOe
         wZm70M3MtgbEbD/3KUpAO1jEpFU437IrTvomtNQa1ulLs7MGxS56VsVz63Xto7WvtP0K
         1qq7I3NUYJxkPMXbD8ksWaBqrrLVM+u0HzpTENztyMXUDQl6kGndIdrRN2o8T3zdc6tY
         V6vA==
X-Forwarded-Encrypted: i=1; AJvYcCXv/QmrHUEn25aaSOuzsdOyEiDFgIfXAtGtcY3Qmq3GojBXyIGbkOHl5/nCktXp7UJnlgI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyedmzJMCoOgDUhEgkwS1bLnWbk2yxzapYfVTp/uXAoMX6r99Gm
	qpsfCT0Osu68L+O/HQZ2ld8VxLbkx8Mu95XWMKaDYR2CdAgledwGVC7EbpduWrkiyAyWEsFNUrA
	v5e2Wxuu37f5UXQi4koHQhxsIwVFdVmU=
X-Gm-Gg: AY/fxX6jvnMi29Jz2uJOZGVgfe3YlFRKhflpToTwtAcnC8R6gncw0n24lFmmIIYWBEo
	PvalaxMzmA4HSBCpOj6xQNZMGBdCZU2ZthQRdA3Yrt/0AxHg0gu1dcsLOEEdb0FXcw95FFdz0Hp
	0NMweXck7uZwoikBjgNyNPH5vc04qnXUF03AgERcYPLdigA5BXRsoVMm7CKp8IU0bT66jNDfFFa
	4s3v3noNdLAnTmotBNU/+oCCd4l/9YIPIIgg1Jj7FlXVoINnnMJeVgQT66njrEhGojbvmD2
X-Google-Smtp-Source: AGHT+IHqtdCAr9CBmXB99IDulL8daqdbvWCcdxdIcO7HVtLV0B4rTxyumys5w9U9o86hE4kypq598DxtbP8kRZJUNtc=
X-Received: by 2002:a17:907:97c4:b0:b70:df0d:e2e9 with SMTP id
 a640c23a62f3a-b8037198d08mr129154366b.44.1766115757150; Thu, 18 Dec 2025
 19:42:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251218113051.455293-1-dolinux.peng@gmail.com>
 <20251218113051.455293-4-dolinux.peng@gmail.com> <CAEf4Bzb0HEFsJ7KG6upatR792baKTKFV6n+91dHdXNL174ud5Q@mail.gmail.com>
In-Reply-To: <CAEf4Bzb0HEFsJ7KG6upatR792baKTKFV6n+91dHdXNL174ud5Q@mail.gmail.com>
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Fri, 19 Dec 2025 11:42:24 +0800
X-Gm-Features: AQt7F2pEKY-qcrqP5xnQI3h-XIsPjIE18M4qBMBYgDYEu7BX31z1711gh3-INR4
Message-ID: <CAErzpmunAv0MLnYSMxXEtvQ+7nvOwzeBphVMzMCgysZDdnaMFg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v10 03/13] tools/resolve_btfids: Support BTF
 sorting feature
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: ast@kernel.org, eddyz87@gmail.com, zhangxiaoqin@xiaomi.com, 
	ihor.solodrai@linux.dev, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	pengdonglin <pengdonglin@xiaomi.com>, Alan Maguire <alan.maguire@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 19, 2025 at 7:09=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, Dec 18, 2025 at 3:31=E2=80=AFAM Donglin Peng <dolinux.peng@gmail.=
com> wrote:
> >
> > From: pengdonglin <pengdonglin@xiaomi.com>
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
> > Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
>
> Signed-off-by is supposed to use properly spelled full name, this
> should be "Donglin Peng", right?

Sorry, I will fix this in the next version. The reason is that our
company's Gerrit only accepts "pengdonglin" and does not
accept "Donglin Peng".

>
> > Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> > ---
> >  tools/bpf/resolve_btfids/main.c | 68 +++++++++++++++++++++++++++++++++
> >  1 file changed, 68 insertions(+)
> >
> > diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids=
/main.c
> > index 3e88dc862d87..659de35748ec 100644
> > --- a/tools/bpf/resolve_btfids/main.c
> > +++ b/tools/bpf/resolve_btfids/main.c
> > @@ -848,6 +848,71 @@ static int dump_raw_btf(struct btf *btf, const cha=
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
> > +}
> > +
> > +static int sort_btf_by_name(struct btf *btf)
> > +{
> > +       __u32 *permute_ids =3D NULL, *id_map =3D NULL;
> > +       int nr_types, i, err =3D 0;
> > +       __u32 start_id =3D 1, id;
> > +
> > +       if (btf__base_btf(btf))
> > +               start_id =3D btf__type_cnt(btf__base_btf(btf));
> > +       nr_types =3D btf__type_cnt(btf) - start_id;
> > +       if (nr_types < 2)
> > +               goto out;
>
> why this check, will anything break if you don't do it?

Because I think that if there are zero or only one type,
there is no need to sort.

>
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
> > +       qsort_r(permute_ids, nr_types, sizeof(*permute_ids), cmp_type_n=
ames, btf);
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
> > +static int btf2btf(struct object *obj)
>
> what's the point of having this function?

Sorting BTF is a type of `btf2btf` process. There may be other
types of `btf2btf` processes, which could be grouped together
here. If we currently don't care about these other processes,
I will retain only `sort_btf_by_name` in the next version.

>
> > +{
> > +       return sort_btf_by_name(obj->btf);
> > +}
> > +
> >  static inline int make_out_path(char *buf, u32 buf_sz, const char *in_=
path, const char *suffix)
> >  {
> >         int len =3D snprintf(buf, buf_sz, "%s%s", in_path, suffix);
> > @@ -906,6 +971,9 @@ int main(int argc, const char **argv)
> >         if (load_btf(&obj))
> >                 goto out;
> >
> > +       if (btf2btf(&obj))
> > +               goto out;
> > +
> >         if (elf_collect(&obj))
> >                 goto out;
> >
> > --
> > 2.34.1
> >

