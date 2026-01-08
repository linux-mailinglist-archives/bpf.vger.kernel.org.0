Return-Path: <bpf+bounces-78174-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D0FFD0095B
	for <lists+bpf@lfdr.de>; Thu, 08 Jan 2026 02:50:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4AEF9301473A
	for <lists+bpf@lfdr.de>; Thu,  8 Jan 2026 01:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 424332236FD;
	Thu,  8 Jan 2026 01:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b1YC8Ea3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006852AE78
	for <bpf@vger.kernel.org>; Thu,  8 Jan 2026 01:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767837045; cv=none; b=V7xksThUEEMhM74r5mqHAvGMFxs3Ubyu82XQa6sENxKmV7RZOIo+gY5odCPJpPZt4Kvd5zr3cgKWa5igqpv+NLqUwRdSwSDWMIfLPiLPr9f5QV5AmUBmwxbp+b/1YHl80e3WAmUMnzi/UrFa71r+FNlaMzU/+dm6tlGjX3lXfXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767837045; c=relaxed/simple;
	bh=jDtU0WJ1wI1MGrELZkPSu9aiak8phjjQKWR+W42SXCE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sQSdOJu61JH5nuy9NsWXAH6awLH4ZZwe5sG+EHEOeDCTGTHaLw017Lku+bx7T5a0E8r2ijrrek+xhCsMwMMdUiXyXZjTXEmMzTWBpI3o0TKZRvAPw/BbTGlWlKaMJ5L7/a05KavQOBBkYo4iSXMqwEczTVOwqcEp0ZGvWf8jrBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b1YC8Ea3; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-64d0d41404cso3975093a12.0
        for <bpf@vger.kernel.org>; Wed, 07 Jan 2026 17:50:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767837042; x=1768441842; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1WRh8cPuLKN8ZFVGzvkPWLUDTZEXppdneEZ29Jpulj4=;
        b=b1YC8Ea3YYKiDFfzJ+kpZyg7GZNRybhGDPq7qdd3pXJhAo/o1jK4FAroBmN0MOSwLj
         MFxp2Zx2IVH2Jv/c2LJm9wNElj796EHO8hdV0nC2BBwCxqxiqw60mushxl4sksWNRH3a
         ILIKq8IQmKOJo74ZwFTv2KARMpKQ8PjOsm3CYxZmVjQZhHai7cao7zCNmdluut/VC6VD
         6h2GuYJg/2iG4hULZQJy6VPCqfK/RiLHdNCLCeU2KYB8VrBtuggj5Y8n8QusZ5jYIYqL
         LS6z/CfJ3Vaon5Ngc4/UaDn8/n7PHnh0Bs3MChOyk+L2cI8I8bZWbus/xS1eZ+KEu91R
         kr4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767837042; x=1768441842;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1WRh8cPuLKN8ZFVGzvkPWLUDTZEXppdneEZ29Jpulj4=;
        b=MXMYfDXK21+RKG8j8EVfsVBhG7d2sTq3f9vriXb+icT0+++wo42zEexJsXPUe+p9iA
         B1U5b7MnkpseqV1ainoU3OCEQcWqRXAo3mEo31p98jfQXj15wu7T1Td16ep2QDZRClj/
         gVTkEdHJj2K0YbgSpuScVXHaABbNjzTxpBsSGIfYZK+tXDugc52vvnisveU0pHfDzJAZ
         Ev1oETFJTi28363CFyoZJjcAUENDuDiiFOEiFTFn8w7nwJJ3xQvwmHSE78jZKZswlK+a
         Gb3YCxjTVe5JnjePLYafGdar91ewE+Smbx789wjyE7+FP5eOmNWEDcw09CJ0vjaO2UWX
         rxqA==
X-Forwarded-Encrypted: i=1; AJvYcCWBixzMR9IoHsNIL1N8JkLE2+2TFxXCPcs4WPZBKpBYnhUvXudb09CGnyqJGNVmzoKcAmA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1oPAjje4s/0UVPCEsE9hHJp8TK4I7PjcfZcO4Qz6rkl9J1RTr
	T1b6lIckPy66d9d4j1tB/BZ5066AmrxzV88GAqKauxMdPtyR2qe75YOfguqjM6IhO10RAstXj9H
	3AyLualK71yEC/UAofjK6ebuc9Vc8nQFBdilaAC8=
X-Gm-Gg: AY/fxX5xzlhLwPw+MExGUANLR0UeIEmJm89l/uFRxCAok8wOe63NOM5IQBwPbe8hHAJ
	LlWP6hqeRLsn4Dsx6ttKjJDy9CMqkUFpNJG7h6lkUjOIlSPeW9qnoM3nMJKGXpa5QHusXPFtB5P
	Sz/xS5mPxPyS//j3wBaA6dlmcPMatzU4wHA5M9iR65lCe09k2XZrDpvE84a8tAEJrLi3HPiGgJm
	Ht28SGoNFfcts83XUlh/diyPcWAZluRue9H9LaRudtmhEMJMaKsOznjhJa4Zr9Qwxh5quk9
X-Google-Smtp-Source: AGHT+IHUX5ayNw/m5Z4kdrCWUAv/pjcbFbhz/Sveo2XoBZZiUks66xU/svNvyic+m9FfEVOPMfhjsmWDNiRA3JWb5eQ=
X-Received: by 2002:a17:907:6093:b0:b73:5cbd:f1d3 with SMTP id
 a640c23a62f3a-b8444f62b97mr403088666b.42.1767837042241; Wed, 07 Jan 2026
 17:50:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251218113051.455293-1-dolinux.peng@gmail.com>
 <20251218113051.455293-6-dolinux.peng@gmail.com> <CAEf4BzY+gnT9aET_NDOkzX2iBwLednyK4xGe4S6JmhzN0C5GoA@mail.gmail.com>
 <CAErzpmusyOMQTcoWiT7nNa=gOAOHgdRYqVb+Dc24BaqjzzeRYw@mail.gmail.com>
 <CAEf4BzY=3KWxZ1F98sE-zB0g-HKz87HJ5msBYESZ0Ri0jN=WCg@mail.gmail.com>
 <CAErzpmsvirekLBRrJYVgmRC0YKWCbo7OyRQXgNYrk83aF-Wz2Q@mail.gmail.com>
 <CAErzpmv99TG_pjyjcQd5xjC7M+yUGs6SNtL9b3nJQAC8z-nafw@mail.gmail.com> <CAEf4BzY79TJ5=s4EJC-TMc+7fow9E+H0qP67h=W=+BVkbc-ocQ@mail.gmail.com>
In-Reply-To: <CAEf4BzY79TJ5=s4EJC-TMc+7fow9E+H0qP67h=W=+BVkbc-ocQ@mail.gmail.com>
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Thu, 8 Jan 2026 09:50:29 +0800
X-Gm-Features: AQt7F2pC7u0dNTvsN8BatOuEAOh2-yBoasd_S-lRi6WO8981b26hBnreg5w5l3I
Message-ID: <CAErzpmuzpBLQSHg+Qh=j9LrYuWdjyLvQV+2Yd75gb6b0Zr_trQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v10 05/13] libbpf: Verify BTF Sorting
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: ast@kernel.org, eddyz87@gmail.com, zhangxiaoqin@xiaomi.com, 
	ihor.solodrai@linux.dev, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	pengdonglin <pengdonglin@xiaomi.com>, Alan Maguire <alan.maguire@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 8, 2026 at 5:51=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Tue, Jan 6, 2026 at 7:45=E2=80=AFPM Donglin Peng <dolinux.peng@gmail.c=
om> wrote:
> >
> > On Sat, Dec 20, 2025 at 10:36=E2=80=AFPM Donglin Peng <dolinux.peng@gma=
il.com> wrote:
> > >
> > >
> > >
> > > On Sat, Dec 20, 2025 at 1:33=E2=80=AFAM Andrii Nakryiko <andrii.nakry=
iko@gmail.com> wrote:
> > > >
> > > > On Thu, Dec 18, 2025 at 9:06=E2=80=AFPM Donglin Peng <dolinux.peng@=
gmail.com> wrote:
> > > > >
> > > > > On Fri, Dec 19, 2025 at 7:44=E2=80=AFAM Andrii Nakryiko
> > > > > <andrii.nakryiko@gmail.com> wrote:
> > > > > >
> > > > > > On Thu, Dec 18, 2025 at 3:31=E2=80=AFAM Donglin Peng <dolinux.p=
eng@gmail.com> wrote:
> > > > > > >
> > > > > > > From: pengdonglin <pengdonglin@xiaomi.com>
> > > > > > >
> > > > > >
> > > > > > typo in subject: "Sorting" -> "sorting", it looks weird capital=
ized like that
> > > > >
> > > > > Thanks, I will do it.
> > > > >
> > > > > >
> > > > > > > This patch checks whether the BTF is sorted by name in ascend=
ing
> > > > > > > order. If sorted, binary search will be used when looking up =
types.
> > > > > > >
> > > > > > > Cc: Eduard Zingerman <eddyz87@gmail.com>
> > > > > > > Cc: Alexei Starovoitov <ast@kernel.org>
> > > > > > > Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> > > > > > > Cc: Alan Maguire <alan.maguire@oracle.com>
> > > > > > > Cc: Ihor Solodrai <ihor.solodrai@linux.dev>
> > > > > > > Cc: Xiaoqin Zhang <zhangxiaoqin@xiaomi.com>
> > > > > > > Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
> > > > > > > ---
> > > > > > >  tools/lib/bpf/btf.c | 41 +++++++++++++++++++++++++++++++++++=
++++++
> > > > > > >  1 file changed, 41 insertions(+)
> > > > > > >
> > > > > > > diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> > > > > > > index 2facb57d7e5f..c63d46b7d74b 100644
> > > > > > > --- a/tools/lib/bpf/btf.c
> > > > > > > +++ b/tools/lib/bpf/btf.c
> > > > > > > @@ -899,6 +899,46 @@ int btf__resolve_type(const struct btf *=
btf, __u32 type_id)
> > > > > > >         return type_id;
> > > > > > >  }
> > > > > > >
> > > > > > > +/*
> > > > > > > + * Assuming that types are sorted by name in ascending order=
.
> > > > > > > + */
> > > > > >
> > > > > > Unnecessary comment, and no, btf_compare_type_names() itself ma=
kes no
> > > > > > such assumption, it just compares two provided types by name. D=
rop the
> > > > > > comment, please.
> > > > > >
> > > > > > > +static int btf_compare_type_names(__u32 *a, __u32 *b, const =
struct btf *btf)
> > > > > > > +{
> > > > > > > +       struct btf_type *ta =3D btf_type_by_id(btf, *a);
> > > > > > > +       struct btf_type *tb =3D btf_type_by_id(btf, *b);
> > > > > > > +       const char *na, *nb;
> > > > > > > +
> > > > > > > +       na =3D btf__str_by_offset(btf, ta->name_off);
> > > > > > > +       nb =3D btf__str_by_offset(btf, tb->name_off);
> > > > > > > +       return strcmp(na, nb);
> > > > > > > +}
> > > > > >
> > > > > > you use this function only in one place, there is no real point=
 having
> > > > > > it, especially that it uses **a pointer to type ID** as an
> > > > > > interface... just inline its logic in that one loop below
> > > > > >
> > > > > > > +
> > > > > > > +static void btf_check_sorted(struct btf *btf)
> > > > > > > +{
> > > > > > > +       const struct btf_type *t;
> > > > > > > +       __u32 i, k, n;
> > > > > > > +       __u32 sorted_start_id;
> > > > > > > +
> > > > > > > +       if (btf->nr_types < 2)
> > > > > > > +               return;
> > > > > >
> > > > > > why special casing? does it not work with nr_types =3D 0 or nr_=
types =3D 1?
> > > > >
> > > > > No. I just think it doesn't make any sense to check the sorting
> > > > > of BTF with zero or only one type.
> > > > >
> > > >
> > > > Look, I don't know how to emphasize this enough. Any special case l=
ike
> > > > this is nothing good, it adds more cases to consider and raises
> > > > questions why generic case code doesn't handle such special cases. =
It
> > > > implies that generic case handling might have some unhandled corner
> > > > case that we are trying to short-circuit with early exits like this=
.
> > > > It just basically means we don't trust our code, in a sense. It's j=
ust
> > > > unnecessary and thus sloppy. Don't do this unnecessarily.
> > >
> > > Thank you for taking the time to explain this so clearly. I=E2=80=99m=
 grateful for
> > > your patience in pushing for rigor =E2=80=94 it=E2=80=99s exactly the=
 kind of scrutiny that
> > > makes the codebase stronger. I=E2=80=99ll make sure to apply this les=
son in future
> > > revisions.
> > >
> > > >
> > > > > >
> > > > > > > +
> > > > > > > +       sorted_start_id =3D 0;
> > > > > >
> > > > > > nit: initialize in declaration
> > > > >
> > > > > Thanks, I will do it.
> > > > >
> > > > > >
> > > > > >
> > > > > > > +       n =3D btf__type_cnt(btf);
> > > > > > > +       for (i =3D btf->start_id; i < n; i++) {
> > > > > > > +               k =3D i + 1;
> > > > > > > +               if (k < n && btf_compare_type_names(&i, &k, b=
tf) > 0)
> > > > > > > +                       return;
> > > > > > > +               if (sorted_start_id =3D=3D 0) {
> > > > > > > +                       t =3D btf_type_by_id(btf, i);
> > > > > > > +                       if (t->name_off)
> > > > > >
> > > > > > I'd check actual string, not name_off. Technically, you can hav=
e empty
> > > > > > string with non-zero name_off, so why assume anything here?
> > > > >
> > > > > Thanks, I will do it.
> > > > >
> > > > > >
> > > > > > > +                               sorted_start_id =3D i;
> > > > > > > +               }
> > > > > > > +       }
> > > > > > > +
> > > > > > > +       if (sorted_start_id)
> > > > > > > +               btf->sorted_start_id =3D sorted_start_id;
> > > > > >
> > > > > > You actually made code more complicated by extracting that
> > > > > > btf_compare_type_names(). Compare to:
> > > > > >
> > > > > > n =3D btf__type_cnt(btf);
> > > > > > btf->sorted_start_id =3D 0;
> > > > > > for (i =3D btf->start_id + 1; i < n; i++) {
> > > > > >    struct btf_type *t1 =3D btf_type_by_id(btf, i - 1);
> > > > > >    struct btf_type *t2 =3D btf_type_by_id(btf, i);
> > > > > >    const char *n1 =3D btf__str_by_offset(btf, t1->name_off);
> > > > > >    const char *n2 =3D btf__str_by_offset(btf, t2->name_off);
> > > > > >
> > > > > >    if (strcmp(n1, n2) > 0)
> > > > > >         return;
> > > > > >    if (btf->sorted_start_id =3D=3D 0 && n1[0] !=3D '\0')
> > > > > >         btf->sorted_start_id =3D i - 1;
> > > > > > }
> > > > >
> > > > > Thanks. I believe we shouldn't directly assign a value to
> > > > > `btf->sorted_start_id` within the for loop, because
> > > > > `btf->sorted_start_id` might be non-zero even when the
> > > > > BTF isn't sorted.
> > > >
> > > > Ah, right, we'd need to reset btf->sorted_start_id to zero in that
> > > > strcmp(n1, n2) > 0 branch. Using btf->sorted_start_id directly is n=
ot
> > > > the main point here, though, feel free to use a local variable, but
> > > > don't add unnecessary helper functions which don't do much, but
> > > > obscure the logic unnecessarily.
> > >
> > > Thanks, I will use a local variable and remove the helper functions.
> >
> > Hi Andrii,
> >
> > I noticed that the code above does not handle the scenario where
> > only the last btf_typein a sorted BTF has a name. So I've added an
> > additional check in the loop as follows:
> >
> > static void btf_check_sorted(struct btf *btf)
> > {
> >         __u32 i, n, named_start_id =3D 0;
> >
> >         n =3D btf__type_cnt(btf);
> >         for (i =3D btf->start_id + 1; i < n; i++) {
> >                 struct btf_type *ta =3D btf_type_by_id(btf, i - 1);
> >                 struct btf_type *tb =3D btf_type_by_id(btf, i);
> >                 const char *na =3D btf__str_by_offset(btf, ta->name_off=
);
> >                 const char *nb =3D btf__str_by_offset(btf, tb->name_off=
);
> >
> >                 if (strcmp(na, nb) > 0)
> >                         return;
> >
> >                 if (named_start_id =3D=3D 0) {
> >                         if (na[0] !=3D '\0')
> >                                 named_start_id =3D i - 1;
> >                         else if (i =3D=3D (n - 1) && nb[0] !=3D '\0') /=
*
> > only the last one has a name */
> >                                 named_start_id =3D i;
> >                 }
>
> good observation!
>
> How about a bit more uniform way?
>
> if (named_start_id =3D=3D 0 && na[0] !=3D '\0')
>     named_start_id =3D i - 1;
> if (named_start_id =3D=3D 0 && nb[0] !=3D '\0')
>     named_start_id =3D i;
>
>
> less nested conditions, and code clearly says that we pick earliest
> non-anon type in a comparison pair as named_start_id

Thanks, I will apply it in the next version.


>
> >         }
> >
> >         if (named_start_id)
> >                 btf->named_start_id =3D named_start_id;
> > }
> >
> > WDYT?
> >
> > >
> > > >
> > > > >
> > > > > >
> > > > > >
> > > > > > No extra k<n checks, no extra type_by_id lookups. It's minimali=
stic
> > > > > > and cleaner. And if it so happens that we get single type BTF t=
hat is
> > > > > > technically sorted, it doesn't matter, we always fallback to fa=
ster
> > > > > > linear search anyways.
> > > > > >
> > > > > > Keep it simple.
> > > > >
> > > > > Thank you. I will adopt this method in the next version.
> > > > >
> > > > > >
> > > > > > > +}
> > > > > > > +
> > > > > > >  static __s32 btf_find_by_name_bsearch(const struct btf *btf,=
 const char *name,
> > > > > > >                                                 __s32 start_i=
d, __s32 end_id)
> > > > > > >  {
> > > > > > > @@ -1147,6 +1187,7 @@ static struct btf *btf_new(const void *=
data, __u32 size, struct btf *base_btf, b
> > > > > > >         err =3D err ?: btf_sanity_check(btf);
> > > > > > >         if (err)
> > > > > > >                 goto done;
> > > > > > > +       btf_check_sorted(btf);
> > > > > > >
> > > > > > >  done:
> > > > > > >         if (err) {
> > > > > > > --
> > > > > > > 2.34.1
> > > > > > >

