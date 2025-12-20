Return-Path: <bpf+bounces-77240-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AAF5ECD2ACF
	for <lists+bpf@lfdr.de>; Sat, 20 Dec 2025 09:44:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4AB873016DCB
	for <lists+bpf@lfdr.de>; Sat, 20 Dec 2025 08:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 007DF2F8BC3;
	Sat, 20 Dec 2025 08:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HOA3/ML2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39CA2475E3
	for <bpf@vger.kernel.org>; Sat, 20 Dec 2025 08:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766220255; cv=none; b=csv13FL4UXEJAgwK1sWoSjfjxwYFrcSXZa3HdsmPocbGWSsSaA0buk+MiX5+nRgyLlYq9+oiJV+vaR6MbIkGjuDW1uCWzgN/KRInWTFOj15/CDpkqgKHVE4VhOqVeDcuHCS+6WcGWJuo2S5T9n8+7mv13H1csab7mcAo2iICLuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766220255; c=relaxed/simple;
	bh=+KWzCX6XWOAiQyRj81J883FglF1aYJ8IO06/SQuNGVM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dxm6EoqUdJ61EUsJUNqxJgo0qc3LFo47xBqK838ymyWjPTUYKGdOJaZ6Wa38FgIwegUrx+tYGp8HCn+mFTjU799wKfQrGtTN2ugVZfqmeyGMnsVBas/+1v03H1Ocq8reb0gZYhB0eqKVLlDjnlHSp1zS1M5WsZh5nMQhvfoVelg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HOA3/ML2; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-64bea6c5819so1401977a12.3
        for <bpf@vger.kernel.org>; Sat, 20 Dec 2025 00:44:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766220252; x=1766825052; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SggO6FcztSmTzx7LTMahzfN4ZV4u16SbUYDPevB0s+w=;
        b=HOA3/ML2p/QysmgQhx5p7SXuGL2xsED4YR5T/Gru51XT/PzIReUj9nB463qEnSVteP
         zJemhztfphdsDVJ1ulZfO+LOfiZqyv7JpFKK1cDV8pSuaRotgutiLQkcU8oDsMeWjNDh
         gNFjJPTlSQRDe4HV1aTQ/vNBwewDJY/VJTZdw3JAKl3H4bwcMCajYL1eAkDqjs6Ixwjl
         QGCpiu4nG74Q+g32dh6RIt+KGdaerIzvN4QGc1zUIA50fx5Os9lw3q6Q0H2tE4u0SB/V
         f1zhHZP2NBFmFzM6xJAwbwfj/OwafHn8J9lQ8b9Li3oZDcCIQAAHIgNOwglVB/2FeQ7X
         7qzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766220252; x=1766825052;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SggO6FcztSmTzx7LTMahzfN4ZV4u16SbUYDPevB0s+w=;
        b=mYw3LxqoZH1ypZCU0mEygAqURu+XECmVAooCoeIxWnllLNWIRk8Vjcz/B8GLk0dUdR
         q4Zk353z+AxDkCJLuiO/9UAzhFj71R7lm0O86itfHpR2yT5/Ifz9jHV9uHStbg7oGy74
         WDxniPYxrUmoQotm4yYjt0stArE0nX6flXRetdoN0rD034cexCM0O5FS/qCs1vb9xeOH
         AbKgcX5SkMyJNC0KyoZqCJz7iXnTojCL91vXzSVFq/ttE4oQ7L2mtl5uiMDAGjxz+ctz
         Vz4UTyi7NoiF+ygKw+KFkqjHdIPn0h82mjYltZAw5rxgdbuNCpmsEnfPIZ2K1cfinUxg
         gFMw==
X-Forwarded-Encrypted: i=1; AJvYcCWh1B3yrXz0/PUHBzsQjtYYBfIohFuc4O7FRRu8zA03VL9EqZQqlj1dUo1cKH1hmWw3xCU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw142oSdZIiQnrTQs1jo3FqXVRwR8vveKrbRtJvuriNd0s0NYf/
	xfoLm1kUk14GO8Dq15oYmVjdY9rBN7ZDhd1A72AV0RtgT0HucbEmqJMV7ZUBne3Ur04pQUqhgLz
	+duTnXRlP9kEXA+IrvMNXHmj7y8xWMGs=
X-Gm-Gg: AY/fxX6nsDuuYglGOAHqHxRPHQSVtpW52DIIqbUCGx4/hHFBB8YztnDOwZQ/Tdwhllf
	xAeMUUm5LUjAwR3g9vC+BFjPXPbRzDT5GyurCW+PbYSxfocf2D9VszIp3gMkS/INv0npMIytJxg
	gploHqpRTw/wJz1piYPjdn6MHTsa7tHZizv32W/PL8XHSsz60kxUNmSKMQR2A5zTAIkl0KYwWk/
	T7YofCPyUGwEEvs6sg/MkIoLEMacG9CaQ7iJ4t3ZXoYbatveuBUNSoCqRBLrqZXx+fu4D67
X-Google-Smtp-Source: AGHT+IFY2HLKPl+fmQSjUQgfLxjhngbyJCNBl6cU0gse+ukHE3gb6EZBeKd3AMSDE4BEEts8oqdlOa6Mr4POSzhD8c8=
X-Received: by 2002:a17:906:c109:b0:b80:325d:99e2 with SMTP id
 a640c23a62f3a-b803705ddb6mr554652266b.33.1766220252014; Sat, 20 Dec 2025
 00:44:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251218113051.455293-1-dolinux.peng@gmail.com>
 <20251218113051.455293-4-dolinux.peng@gmail.com> <CAEf4Bzb0HEFsJ7KG6upatR792baKTKFV6n+91dHdXNL174ud5Q@mail.gmail.com>
 <CAErzpmunAv0MLnYSMxXEtvQ+7nvOwzeBphVMzMCgysZDdnaMFg@mail.gmail.com> <CAEf4BzbRN-L9GVRwx1sMnwn46gR1YoaV2kDt4Y3CTyPH+2HHXw@mail.gmail.com>
In-Reply-To: <CAEf4BzbRN-L9GVRwx1sMnwn46gR1YoaV2kDt4Y3CTyPH+2HHXw@mail.gmail.com>
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Sat, 20 Dec 2025 16:44:00 +0800
X-Gm-Features: AQt7F2rpx-f9bJv3N6Q-JGZjRgQxtjy9h2XUQMivsocuGNAiSQIpvEheM2r1d0I
Message-ID: <CAErzpmuCgR+q8Yndb9bd_W7GO8H4rUv7oEJpeZtwd12tkMU8QA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v10 03/13] tools/resolve_btfids: Support BTF
 sorting feature
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: ast@kernel.org, eddyz87@gmail.com, zhangxiaoqin@xiaomi.com, 
	ihor.solodrai@linux.dev, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	pengdonglin <pengdonglin@xiaomi.com>, Alan Maguire <alan.maguire@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 20, 2025 at 1:12=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, Dec 18, 2025 at 7:42=E2=80=AFPM Donglin Peng <dolinux.peng@gmail.=
com> wrote:
> >
> > On Fri, Dec 19, 2025 at 7:09=E2=80=AFAM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Thu, Dec 18, 2025 at 3:31=E2=80=AFAM Donglin Peng <dolinux.peng@gm=
ail.com> wrote:
> > > >
> > > > From: pengdonglin <pengdonglin@xiaomi.com>
> > > >
> > > > This introduces a new BTF sorting phase that specifically sorts
> > > > BTF types by name in ascending order, so that the binary search
> > > > can be used to look up types.
> > > >
> > > > Cc: Eduard Zingerman <eddyz87@gmail.com>
> > > > Cc: Alexei Starovoitov <ast@kernel.org>
> > > > Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> > > > Cc: Alan Maguire <alan.maguire@oracle.com>
> > > > Cc: Ihor Solodrai <ihor.solodrai@linux.dev>
> > > > Cc: Xiaoqin Zhang <zhangxiaoqin@xiaomi.com>
> > > > Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
> > >
> > > Signed-off-by is supposed to use properly spelled full name, this
> > > should be "Donglin Peng", right?
> >
> > Sorry, I will fix this in the next version. The reason is that our
> > company's Gerrit only accepts "pengdonglin" and does not
> > accept "Donglin Peng".
> >
> > >
> > > > Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> > > > ---
> > > >  tools/bpf/resolve_btfids/main.c | 68 +++++++++++++++++++++++++++++=
++++
> > > >  1 file changed, 68 insertions(+)
> > > >
> > > > diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_bt=
fids/main.c
> > > > index 3e88dc862d87..659de35748ec 100644
> > > > --- a/tools/bpf/resolve_btfids/main.c
> > > > +++ b/tools/bpf/resolve_btfids/main.c
> > > > @@ -848,6 +848,71 @@ static int dump_raw_btf(struct btf *btf, const=
 char *out_path)
> > > >         return 0;
> > > >  }
> > > >
> > > > +/*
> > > > + * Sort types by name in ascending order resulting in all
> > > > + * anonymous types being placed before named types.
> > > > + */
> > > > +static int cmp_type_names(const void *a, const void *b, void *priv=
)
> > > > +{
> > > > +       struct btf *btf =3D (struct btf *)priv;
> > > > +       const struct btf_type *ta =3D btf__type_by_id(btf, *(__u32 =
*)a);
> > > > +       const struct btf_type *tb =3D btf__type_by_id(btf, *(__u32 =
*)b);
> > > > +       const char *na, *nb;
> > > > +
> > > > +       na =3D btf__str_by_offset(btf, ta->name_off);
> > > > +       nb =3D btf__str_by_offset(btf, tb->name_off);
> > > > +       return strcmp(na, nb);
> > > > +}
> > > > +
> > > > +static int sort_btf_by_name(struct btf *btf)
> > > > +{
> > > > +       __u32 *permute_ids =3D NULL, *id_map =3D NULL;
> > > > +       int nr_types, i, err =3D 0;
> > > > +       __u32 start_id =3D 1, id;
> > > > +
> > > > +       if (btf__base_btf(btf))
> > > > +               start_id =3D btf__type_cnt(btf__base_btf(btf));
> > > > +       nr_types =3D btf__type_cnt(btf) - start_id;
> > > > +       if (nr_types < 2)
> > > > +               goto out;
> > >
> > > why this check, will anything break if you don't do it?
> >
> > Because I think that if there are zero or only one type,
> > there is no need to sort.
>
> There is also no need to special-case and add more checks just for
> these corner cases. Keep it simple.

Thanks, I agree and and will fix it.

>
>
> >
> > >
> > > > +
> > > > +       permute_ids =3D calloc(nr_types, sizeof(*permute_ids));
> > > > +       if (!permute_ids) {
> > > > +               err =3D -ENOMEM;
> > > > +               goto out;
> > > > +       }
> > > > +
> > > > +       id_map =3D calloc(nr_types, sizeof(*id_map));
> > > > +       if (!id_map) {
> > > > +               err =3D -ENOMEM;
> > > > +               goto out;
> > > > +       }
> > > > +
> > > > +       for (i =3D 0, id =3D start_id; i < nr_types; i++, id++)
> > > > +               permute_ids[i] =3D id;
> > > > +
> > > > +       qsort_r(permute_ids, nr_types, sizeof(*permute_ids), cmp_ty=
pe_names, btf);
> > > > +
> > > > +       for (i =3D 0; i < nr_types; i++) {
> > > > +               id =3D permute_ids[i] - start_id;
> > > > +               id_map[id] =3D i + start_id;
> > > > +       }
> > > > +
> > > > +       err =3D btf__permute(btf, id_map, nr_types, NULL);
> > > > +       if (err)
> > > > +               pr_err("FAILED: btf permute: %s\n", strerror(-err))=
;
> > > > +
> > > > +out:
> > > > +       free(permute_ids);
> > > > +       free(id_map);
> > > > +       return err;
> > > > +}
> > > > +
> > > > +static int btf2btf(struct object *obj)
> > >
> > > what's the point of having this function?
> >
> > Sorting BTF is a type of `btf2btf` process. There may be other
> > types of `btf2btf` processes, which could be grouped together
> > here. If we currently don't care about these other processes,
> > I will retain only `sort_btf_by_name` in the next version.
>
> Let's have sort as is, when necessary we can refactor this into
> logical steps further (or perhaps sorting will be its own logical
> step, I don't know, but let's not over design it just yet)

Okay, I will invoke sort_btf_by_name directly in the next version.

>
> >
> > >
> > > > +{
> > > > +       return sort_btf_by_name(obj->btf);
> > > > +}
> > > > +
> > > >  static inline int make_out_path(char *buf, u32 buf_sz, const char =
*in_path, const char *suffix)
> > > >  {
> > > >         int len =3D snprintf(buf, buf_sz, "%s%s", in_path, suffix);
> > > > @@ -906,6 +971,9 @@ int main(int argc, const char **argv)
> > > >         if (load_btf(&obj))
> > > >                 goto out;
> > > >
> > > > +       if (btf2btf(&obj))
> > > > +               goto out;
> > > > +
> > > >         if (elf_collect(&obj))
> > > >                 goto out;
> > > >
> > > > --
> > > > 2.34.1
> > > >

