Return-Path: <bpf+bounces-77171-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 31DE0CD12B6
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 18:36:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D7C513064E7E
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 17:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA6BD321457;
	Fri, 19 Dec 2025 17:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MLKU7yLG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83E828000B
	for <bpf@vger.kernel.org>; Fri, 19 Dec 2025 17:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766165627; cv=none; b=dwWL0iv4lb5vyXMmLw40JLfmhIsShInJd7kfvli5fDhZRSCNjiX+J7EBTe+0Dj5uYkrD7nmkiv8NN5dVkbWWr5abgnPPXwWjSHaTE2mF+DJ6O7Ok3zpPWWfWxObC5H2rj19lZTLU5P6gfYAQ/6WKLo+PmbpPj8ceK1SVo+QNDzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766165627; c=relaxed/simple;
	bh=Wp9dvyQc5b4fKPj/ppJJGcHwI7aHrNXXtCqRZDMDfLc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YzL3/IlZUjqs4wr2yh9y+vW+vvaTCTklwzrnpdSvpRp2MORIu/Ri8zfNpJbbLMTY4YKnnOilMFwTIpNWSdX6QSz59cECagwufjdqI+hLxaFF9NIyPXlDlLpl+ROK8MQwodea4PJN8yyJen0M6cfu+PZSZzomjp8QTDlVcB32hwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MLKU7yLG; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-34c213f7690so1674015a91.2
        for <bpf@vger.kernel.org>; Fri, 19 Dec 2025 09:33:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766165625; x=1766770425; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3XQo7dGOmkHB3+XIsEQmeuUqmsc0sT5SKqjNnHs3t0o=;
        b=MLKU7yLGEaOk9o8YZmlTgVI+3ntbwB6ZL/1xGncPsFkSeAbuNNMLUN/O0TVX0LHkDx
         WK1Og5ojCREnPDp2fyMFzs53lCd+MVo2/c4XjqZG0RT5X+WbrwsgwghKXuBWVCIrwS7y
         1lIeb+0Qgm4/1AIkywoaxnqcLW+pIhbWFmbKokuBpkr0ppWufxRYLObG5JRTqepzWvNw
         XEgY7Fysp2V63045MfxKxcZUN2m7a27YyIWoGadVWa8sd4twShQT9KDGcjHlhrBDPcQX
         KJ87o7uV1OiidmeMrGczc93WqxDeb9hOVpwI1ejT0709lnArHMsQq/btYsY9X/JGOmkv
         3j2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766165625; x=1766770425;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3XQo7dGOmkHB3+XIsEQmeuUqmsc0sT5SKqjNnHs3t0o=;
        b=tDoqUE0xgKHhJpEV+ZZxQw4cFkPVS7dMHVbe8Zfct8KH1eVickQhr2+MyC4I1LrKct
         pbIwPD6bjngwPl8KacRQt5gHaXhU3/MFCyPD/D2QE3SlsId07KdSZOjSCO7Mamq3kWMJ
         odkjKjoCxko4o+qUX8k4+W6R7Zp8c9sD8E7uqorNn5t0xm0E5dDGfQD36z1ss+7cT+ga
         OpMBLQpPLQniOwh0J6hOgrw0FN9poXltK15ifzhUGvKS7QZgxelbP5Vcn9Voj1C4plwW
         AQSUWQs+roNOXUDMFMVJJivH5styfwEkyPT5x86nve279zjhukAsSxxdxzjFa9QHhPji
         v7OQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+l8peu2neLKH3CElGxEJPEAcdaLVP0HBIPR03ijlA4wtcp5T98yZN6YbuhTpCgbA6fQI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6eFXBvP2Q85ff6gu0/R2cDM65mkyxo7XElzFKsgHJhFr78ubm
	QlxoGbqViQP59+/EjhWpZHus5C6Y/siO0urbO/iqw/h0pdPxCuLZHJSwJF+GX6+UXcB3z91l2tP
	ZNb49EuWY1pqBne1y0zqPPAIyyzWYAJ9Qnw==
X-Gm-Gg: AY/fxX7BOyU2Wa+yGEulA7Ueo8BQ+QRPn0KWiD6jDMmNX5CaFCiG5ULrLmKJiwF+S46
	k1FijiHZXAJTeFuLI0Gr7x2GsHMRG7peFovkDoixifYCPPquWV9otmpW1fXk0GCd3fZQYlv/Z4z
	0IW2BvyQZKJWF7H9Vd7Z0PlsQ7WEhKeolNX69tSy71shArY7NIju98M4hm/GPne0qM+rSkFCuXW
	tih8i7coDUOkszylMynir4Y/TIw1lIyb92fG5Ex5kWpBKEFbEqMbQ6DLE779e0bIrXBYZE=
X-Google-Smtp-Source: AGHT+IEndU4zVWsr5cUx/dXwsS2A7v0OVYEX4c106047SxGvDi1w/rPO0eL182RwhV0RuJ4bzhaXlaaerfYmanc/yaI=
X-Received: by 2002:a17:90b:1b0b:b0:34a:b8fc:f1d1 with SMTP id
 98e67ed59e1d1-34e921ae410mr3479444a91.24.1766165625016; Fri, 19 Dec 2025
 09:33:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251218113051.455293-1-dolinux.peng@gmail.com>
 <20251218113051.455293-6-dolinux.peng@gmail.com> <CAEf4BzY+gnT9aET_NDOkzX2iBwLednyK4xGe4S6JmhzN0C5GoA@mail.gmail.com>
 <CAErzpmusyOMQTcoWiT7nNa=gOAOHgdRYqVb+Dc24BaqjzzeRYw@mail.gmail.com>
In-Reply-To: <CAErzpmusyOMQTcoWiT7nNa=gOAOHgdRYqVb+Dc24BaqjzzeRYw@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 19 Dec 2025 09:33:33 -0800
X-Gm-Features: AQt7F2oxZ5SvqVZTV1BH1fkOjIZHKQXdUcrWKclof2tDN2RdJhAH9rP2eD3rvoo
Message-ID: <CAEf4BzY=3KWxZ1F98sE-zB0g-HKz87HJ5msBYESZ0Ri0jN=WCg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v10 05/13] libbpf: Verify BTF Sorting
To: Donglin Peng <dolinux.peng@gmail.com>
Cc: ast@kernel.org, eddyz87@gmail.com, zhangxiaoqin@xiaomi.com, 
	ihor.solodrai@linux.dev, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	pengdonglin <pengdonglin@xiaomi.com>, Alan Maguire <alan.maguire@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 18, 2025 at 9:06=E2=80=AFPM Donglin Peng <dolinux.peng@gmail.co=
m> wrote:
>
> On Fri, Dec 19, 2025 at 7:44=E2=80=AFAM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Thu, Dec 18, 2025 at 3:31=E2=80=AFAM Donglin Peng <dolinux.peng@gmai=
l.com> wrote:
> > >
> > > From: pengdonglin <pengdonglin@xiaomi.com>
> > >
> >
> > typo in subject: "Sorting" -> "sorting", it looks weird capitalized lik=
e that
>
> Thanks, I will do it.
>
> >
> > > This patch checks whether the BTF is sorted by name in ascending
> > > order. If sorted, binary search will be used when looking up types.
> > >
> > > Cc: Eduard Zingerman <eddyz87@gmail.com>
> > > Cc: Alexei Starovoitov <ast@kernel.org>
> > > Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> > > Cc: Alan Maguire <alan.maguire@oracle.com>
> > > Cc: Ihor Solodrai <ihor.solodrai@linux.dev>
> > > Cc: Xiaoqin Zhang <zhangxiaoqin@xiaomi.com>
> > > Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
> > > ---
> > >  tools/lib/bpf/btf.c | 41 +++++++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 41 insertions(+)
> > >
> > > diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> > > index 2facb57d7e5f..c63d46b7d74b 100644
> > > --- a/tools/lib/bpf/btf.c
> > > +++ b/tools/lib/bpf/btf.c
> > > @@ -899,6 +899,46 @@ int btf__resolve_type(const struct btf *btf, __u=
32 type_id)
> > >         return type_id;
> > >  }
> > >
> > > +/*
> > > + * Assuming that types are sorted by name in ascending order.
> > > + */
> >
> > Unnecessary comment, and no, btf_compare_type_names() itself makes no
> > such assumption, it just compares two provided types by name. Drop the
> > comment, please.
> >
> > > +static int btf_compare_type_names(__u32 *a, __u32 *b, const struct b=
tf *btf)
> > > +{
> > > +       struct btf_type *ta =3D btf_type_by_id(btf, *a);
> > > +       struct btf_type *tb =3D btf_type_by_id(btf, *b);
> > > +       const char *na, *nb;
> > > +
> > > +       na =3D btf__str_by_offset(btf, ta->name_off);
> > > +       nb =3D btf__str_by_offset(btf, tb->name_off);
> > > +       return strcmp(na, nb);
> > > +}
> >
> > you use this function only in one place, there is no real point having
> > it, especially that it uses **a pointer to type ID** as an
> > interface... just inline its logic in that one loop below
> >
> > > +
> > > +static void btf_check_sorted(struct btf *btf)
> > > +{
> > > +       const struct btf_type *t;
> > > +       __u32 i, k, n;
> > > +       __u32 sorted_start_id;
> > > +
> > > +       if (btf->nr_types < 2)
> > > +               return;
> >
> > why special casing? does it not work with nr_types =3D 0 or nr_types =
=3D 1?
>
> No. I just think it doesn't make any sense to check the sorting
> of BTF with zero or only one type.
>

Look, I don't know how to emphasize this enough. Any special case like
this is nothing good, it adds more cases to consider and raises
questions why generic case code doesn't handle such special cases. It
implies that generic case handling might have some unhandled corner
case that we are trying to short-circuit with early exits like this.
It just basically means we don't trust our code, in a sense. It's just
unnecessary and thus sloppy. Don't do this unnecessarily.

> >
> > > +
> > > +       sorted_start_id =3D 0;
> >
> > nit: initialize in declaration
>
> Thanks, I will do it.
>
> >
> >
> > > +       n =3D btf__type_cnt(btf);
> > > +       for (i =3D btf->start_id; i < n; i++) {
> > > +               k =3D i + 1;
> > > +               if (k < n && btf_compare_type_names(&i, &k, btf) > 0)
> > > +                       return;
> > > +               if (sorted_start_id =3D=3D 0) {
> > > +                       t =3D btf_type_by_id(btf, i);
> > > +                       if (t->name_off)
> >
> > I'd check actual string, not name_off. Technically, you can have empty
> > string with non-zero name_off, so why assume anything here?
>
> Thanks, I will do it.
>
> >
> > > +                               sorted_start_id =3D i;
> > > +               }
> > > +       }
> > > +
> > > +       if (sorted_start_id)
> > > +               btf->sorted_start_id =3D sorted_start_id;
> >
> > You actually made code more complicated by extracting that
> > btf_compare_type_names(). Compare to:
> >
> > n =3D btf__type_cnt(btf);
> > btf->sorted_start_id =3D 0;
> > for (i =3D btf->start_id + 1; i < n; i++) {
> >    struct btf_type *t1 =3D btf_type_by_id(btf, i - 1);
> >    struct btf_type *t2 =3D btf_type_by_id(btf, i);
> >    const char *n1 =3D btf__str_by_offset(btf, t1->name_off);
> >    const char *n2 =3D btf__str_by_offset(btf, t2->name_off);
> >
> >    if (strcmp(n1, n2) > 0)
> >         return;
> >    if (btf->sorted_start_id =3D=3D 0 && n1[0] !=3D '\0')
> >         btf->sorted_start_id =3D i - 1;
> > }
>
> Thanks. I believe we shouldn't directly assign a value to
> `btf->sorted_start_id` within the for loop, because
> `btf->sorted_start_id` might be non-zero even when the
> BTF isn't sorted.

Ah, right, we'd need to reset btf->sorted_start_id to zero in that
strcmp(n1, n2) > 0 branch. Using btf->sorted_start_id directly is not
the main point here, though, feel free to use a local variable, but
don't add unnecessary helper functions which don't do much, but
obscure the logic unnecessarily.

>
> >
> >
> > No extra k<n checks, no extra type_by_id lookups. It's minimalistic
> > and cleaner. And if it so happens that we get single type BTF that is
> > technically sorted, it doesn't matter, we always fallback to faster
> > linear search anyways.
> >
> > Keep it simple.
>
> Thank you. I will adopt this method in the next version.
>
> >
> > > +}
> > > +
> > >  static __s32 btf_find_by_name_bsearch(const struct btf *btf, const c=
har *name,
> > >                                                 __s32 start_id, __s32=
 end_id)
> > >  {
> > > @@ -1147,6 +1187,7 @@ static struct btf *btf_new(const void *data, __=
u32 size, struct btf *base_btf, b
> > >         err =3D err ?: btf_sanity_check(btf);
> > >         if (err)
> > >                 goto done;
> > > +       btf_check_sorted(btf);
> > >
> > >  done:
> > >         if (err) {
> > > --
> > > 2.34.1
> > >

