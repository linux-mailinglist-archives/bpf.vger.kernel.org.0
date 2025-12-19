Return-Path: <bpf+bounces-77169-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 236D8CD1186
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 18:17:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CD7DC30358D4
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 17:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67C7B264627;
	Fri, 19 Dec 2025 17:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d+Eonq36"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0312DF13E
	for <bpf@vger.kernel.org>; Fri, 19 Dec 2025 17:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766164340; cv=none; b=YLoqfSJyafCluTFegjzLBohWnHPpGA3OFHXik8jTAhFcFIVFO9YVBAswsIr+a1peNeAiO55TRW23vqqsHkSf8A6o7EGxC+7oUEhn2pilR7JCuyR99k4ZWFmW4bemvU4NZC+RftMAG1Sim4pKrA9F2yYtGAn0fDTKOvwxYCs/+K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766164340; c=relaxed/simple;
	bh=IwgCX/desKqJnFShVuyh8qSItDtM+v/X7V0tHhGHCz0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ichZvmUYkjm35KFmEsj/zKs0ioaSH4As5SAckCa0LQ/6eyFXyvWv8D+dzoSLbLEdTkco6PkIhq8RqGvE+tzJIdefBA8wO6YLW2VBg6EhfFqEgJy9Q6jLBJV3HIXQC64VRRgNSaOe/wnmS2XjL5iUugdXEjDVBrZKSLnhy2AO+dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d+Eonq36; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2a0833b5aeeso26272305ad.1
        for <bpf@vger.kernel.org>; Fri, 19 Dec 2025 09:12:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766164337; x=1766769137; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uULcv7ICwnR6nYdwrDJVv47/hu/F+/lJdYCjOCCFpBA=;
        b=d+Eonq36hcB3Zi/0UsaJwhScu1n3VOiD4PlLqE4SgJeIR1p1EZFTxypwBaofBSlCQU
         qA/7EGMbkbwke8B/lBB0J1Mzuh0llJ15axIWKFH3aMsJmyTZXKEugVw4hofHn41CjeoL
         C0uOu0K7UkNstZq0ssdZ9ntdY3qcmhbGbi9tYhVSeFMOdWV3mCLhL2Ntg0+mQiU7dMRe
         MwGzEXaYPPizqCqz5mfEG8vHVlJSkhP5CgxIEqTyXr33BGGxvqvF3t0qvID3GISrMegf
         z2As8ftM94+sKQudCPxAYf1xEDAJGmJzcLFUmE3byzQVRk4cgol9GHB2UcraRe5RtQNk
         DEEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766164337; x=1766769137;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uULcv7ICwnR6nYdwrDJVv47/hu/F+/lJdYCjOCCFpBA=;
        b=deouY4fmiS43bTXe1n3FJ7D1rNxoYk/DQKtNmW2WMTu6V/dNdYMKvKfdm6DdNd0mUy
         tllljS3HCzGNvDp8oxFMpaaQAnXpZJ1kHCZX9KVYfdLINd9f8+AtSTETFwFbll43g8HS
         F5tKQ47mygvcDAW0+BwNqYBYodUuyJHg9O46T3ldpD93pR4363KTeT5Zf1lcJPg4UktB
         m10+VFQmUfcIB/BPQH23x/ZRjTG8Arv+LgE50ugSQ7tBs6jNoyGpqqmKm/uTGmzRCrNS
         F1V0KcZwMfBkrjATYqapKoFDmUwwmVjotlMnmqLNhJWHF1JDbTYYm72XAVkzCPhtayRy
         efsg==
X-Forwarded-Encrypted: i=1; AJvYcCWviNcTYgowgt29hOI9MVBX9HRK4tQeAC/FubWUv1wrKUaOzrtwGx/urZwLjVp1E/+OhPQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf8rpFQnIXWGyyqsgSgYgZzRfqYJuF996V0SErUQB8D/gYgOI7
	PX3+dZaqQyP8xi5/dJJn2kSazH4mFQAp+KkN07i16aPGBSIp/zflNFnSU0dOhwFmSO0HPr5rivj
	PB8AeS/SoRpQKg6kg3FR2PE3Oj5UmfC0=
X-Gm-Gg: AY/fxX723I2supNu/Uf6RcR0QLN/b9p8H6VOHoWz5HOxpSCBlo9UsUZHV66zxH6317A
	T6CdmwKqETQRHKmnU38dI5BebXiYi+8SjOjJZAvlNjSg7YoJBml6AhE+vdVWr+Q0DbPaWO1wMLa
	xf6YPmG3nsl57G0A1rIVkzaiLmA3eFiR3h68Q/hQ/sFmoG8th/UZNW7v1JaTMwlhzn3hP08Zi4h
	mNXchiyMP7WvvSefKO1oE6oYz5Cb9v/9or976bw+Mzexqv/CpKotJ7Kwijg9LhA61qyPs8=
X-Google-Smtp-Source: AGHT+IFOjJ7NcsqSrKpclwjn1G0ltA7I6QrfsjuAtrZaR2jPozBv8zEd626F6INyF2Sq4KZfyRXopGYqbCaln0yyarU=
X-Received: by 2002:a17:90b:3b44:b0:34a:b1ea:6648 with SMTP id
 98e67ed59e1d1-34e92121c5fmr2985922a91.2.1766164337120; Fri, 19 Dec 2025
 09:12:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251218113051.455293-1-dolinux.peng@gmail.com>
 <20251218113051.455293-4-dolinux.peng@gmail.com> <CAEf4Bzb0HEFsJ7KG6upatR792baKTKFV6n+91dHdXNL174ud5Q@mail.gmail.com>
 <CAErzpmunAv0MLnYSMxXEtvQ+7nvOwzeBphVMzMCgysZDdnaMFg@mail.gmail.com>
In-Reply-To: <CAErzpmunAv0MLnYSMxXEtvQ+7nvOwzeBphVMzMCgysZDdnaMFg@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 19 Dec 2025 09:12:04 -0800
X-Gm-Features: AQt7F2oAugV-kcI4ijZ-KFdyt8UdHLiJVITUtTfKhDvqxAU6OQEL4G9BUqv8SZs
Message-ID: <CAEf4BzbRN-L9GVRwx1sMnwn46gR1YoaV2kDt4Y3CTyPH+2HHXw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v10 03/13] tools/resolve_btfids: Support BTF
 sorting feature
To: Donglin Peng <dolinux.peng@gmail.com>
Cc: ast@kernel.org, eddyz87@gmail.com, zhangxiaoqin@xiaomi.com, 
	ihor.solodrai@linux.dev, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	pengdonglin <pengdonglin@xiaomi.com>, Alan Maguire <alan.maguire@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 18, 2025 at 7:42=E2=80=AFPM Donglin Peng <dolinux.peng@gmail.co=
m> wrote:
>
> On Fri, Dec 19, 2025 at 7:09=E2=80=AFAM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Thu, Dec 18, 2025 at 3:31=E2=80=AFAM Donglin Peng <dolinux.peng@gmai=
l.com> wrote:
> > >
> > > From: pengdonglin <pengdonglin@xiaomi.com>
> > >
> > > This introduces a new BTF sorting phase that specifically sorts
> > > BTF types by name in ascending order, so that the binary search
> > > can be used to look up types.
> > >
> > > Cc: Eduard Zingerman <eddyz87@gmail.com>
> > > Cc: Alexei Starovoitov <ast@kernel.org>
> > > Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> > > Cc: Alan Maguire <alan.maguire@oracle.com>
> > > Cc: Ihor Solodrai <ihor.solodrai@linux.dev>
> > > Cc: Xiaoqin Zhang <zhangxiaoqin@xiaomi.com>
> > > Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
> >
> > Signed-off-by is supposed to use properly spelled full name, this
> > should be "Donglin Peng", right?
>
> Sorry, I will fix this in the next version. The reason is that our
> company's Gerrit only accepts "pengdonglin" and does not
> accept "Donglin Peng".
>
> >
> > > Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> > > ---
> > >  tools/bpf/resolve_btfids/main.c | 68 +++++++++++++++++++++++++++++++=
++
> > >  1 file changed, 68 insertions(+)
> > >
> > > diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfi=
ds/main.c
> > > index 3e88dc862d87..659de35748ec 100644
> > > --- a/tools/bpf/resolve_btfids/main.c
> > > +++ b/tools/bpf/resolve_btfids/main.c
> > > @@ -848,6 +848,71 @@ static int dump_raw_btf(struct btf *btf, const c=
har *out_path)
> > >         return 0;
> > >  }
> > >
> > > +/*
> > > + * Sort types by name in ascending order resulting in all
> > > + * anonymous types being placed before named types.
> > > + */
> > > +static int cmp_type_names(const void *a, const void *b, void *priv)
> > > +{
> > > +       struct btf *btf =3D (struct btf *)priv;
> > > +       const struct btf_type *ta =3D btf__type_by_id(btf, *(__u32 *)=
a);
> > > +       const struct btf_type *tb =3D btf__type_by_id(btf, *(__u32 *)=
b);
> > > +       const char *na, *nb;
> > > +
> > > +       na =3D btf__str_by_offset(btf, ta->name_off);
> > > +       nb =3D btf__str_by_offset(btf, tb->name_off);
> > > +       return strcmp(na, nb);
> > > +}
> > > +
> > > +static int sort_btf_by_name(struct btf *btf)
> > > +{
> > > +       __u32 *permute_ids =3D NULL, *id_map =3D NULL;
> > > +       int nr_types, i, err =3D 0;
> > > +       __u32 start_id =3D 1, id;
> > > +
> > > +       if (btf__base_btf(btf))
> > > +               start_id =3D btf__type_cnt(btf__base_btf(btf));
> > > +       nr_types =3D btf__type_cnt(btf) - start_id;
> > > +       if (nr_types < 2)
> > > +               goto out;
> >
> > why this check, will anything break if you don't do it?
>
> Because I think that if there are zero or only one type,
> there is no need to sort.

There is also no need to special-case and add more checks just for
these corner cases. Keep it simple.


>
> >
> > > +
> > > +       permute_ids =3D calloc(nr_types, sizeof(*permute_ids));
> > > +       if (!permute_ids) {
> > > +               err =3D -ENOMEM;
> > > +               goto out;
> > > +       }
> > > +
> > > +       id_map =3D calloc(nr_types, sizeof(*id_map));
> > > +       if (!id_map) {
> > > +               err =3D -ENOMEM;
> > > +               goto out;
> > > +       }
> > > +
> > > +       for (i =3D 0, id =3D start_id; i < nr_types; i++, id++)
> > > +               permute_ids[i] =3D id;
> > > +
> > > +       qsort_r(permute_ids, nr_types, sizeof(*permute_ids), cmp_type=
_names, btf);
> > > +
> > > +       for (i =3D 0; i < nr_types; i++) {
> > > +               id =3D permute_ids[i] - start_id;
> > > +               id_map[id] =3D i + start_id;
> > > +       }
> > > +
> > > +       err =3D btf__permute(btf, id_map, nr_types, NULL);
> > > +       if (err)
> > > +               pr_err("FAILED: btf permute: %s\n", strerror(-err));
> > > +
> > > +out:
> > > +       free(permute_ids);
> > > +       free(id_map);
> > > +       return err;
> > > +}
> > > +
> > > +static int btf2btf(struct object *obj)
> >
> > what's the point of having this function?
>
> Sorting BTF is a type of `btf2btf` process. There may be other
> types of `btf2btf` processes, which could be grouped together
> here. If we currently don't care about these other processes,
> I will retain only `sort_btf_by_name` in the next version.

Let's have sort as is, when necessary we can refactor this into
logical steps further (or perhaps sorting will be its own logical
step, I don't know, but let's not over design it just yet)

>
> >
> > > +{
> > > +       return sort_btf_by_name(obj->btf);
> > > +}
> > > +
> > >  static inline int make_out_path(char *buf, u32 buf_sz, const char *i=
n_path, const char *suffix)
> > >  {
> > >         int len =3D snprintf(buf, buf_sz, "%s%s", in_path, suffix);
> > > @@ -906,6 +971,9 @@ int main(int argc, const char **argv)
> > >         if (load_btf(&obj))
> > >                 goto out;
> > >
> > > +       if (btf2btf(&obj))
> > > +               goto out;
> > > +
> > >         if (elf_collect(&obj))
> > >                 goto out;
> > >
> > > --
> > > 2.34.1
> > >

