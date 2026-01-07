Return-Path: <bpf+bounces-78165-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BE579D0040F
	for <lists+bpf@lfdr.de>; Wed, 07 Jan 2026 22:56:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4DFD430204BC
	for <lists+bpf@lfdr.de>; Wed,  7 Jan 2026 21:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F2022FD7BE;
	Wed,  7 Jan 2026 21:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YbuWF/3c"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2432F39A9
	for <bpf@vger.kernel.org>; Wed,  7 Jan 2026 21:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767822666; cv=none; b=RJ6hJ3cj68Rl6GhuqPeBgs1nnoK6ErOfGH/pyyIp02Q2hJF+7W24obBIWBNBy6OI2P6xny9M+QhjF/F/JUhMQVs/pZovab0YW3PWM2mgThi+WwbQIEzE+5FcIvdmFY5h/qLglkbysRuv5YX2Z20NrBEnZ1foQxieQWSlLf7K2xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767822666; c=relaxed/simple;
	bh=b4QCDpLCeTrPd/VXTyqP+DPm682UhCH+GOiWJxd5Lag=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DlivFont2SPY5kYTwh4eutFugEl0uaxt3Gf+OuB0E0KWocqdQZIoGz5HXLFQapZiRlffeDP7NfaF3MosRjwi8T+EFW/uCViCoOXvCR7rWeoHm7IQEEz8y6vJ0IGvHE2Rof7n9aFIHSmHTCSqTQWJbIl7ulrf8o3fHw4DudR5UB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YbuWF/3c; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2a099233e8dso19955415ad.3
        for <bpf@vger.kernel.org>; Wed, 07 Jan 2026 13:51:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767822664; x=1768427464; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HQ1KBGJPpTj40+OrzrQ/BgQdEdtto5sxRALWAVoXHkw=;
        b=YbuWF/3czFImFN2BfbibvwFgq2uSp6W1ON3XAy0D5aKgMymo13HLOz8H0c34FcrSms
         j0KKez+B/VTYqu+VaJsDWbxF+N09tCPT/lqVv58FODOWz21U3fq5s4h1bRxZMX0XsZVu
         B0tNSNGyFiTNvlYNwA2EeS/rFV22RfggEo6QHQcgvLNdyKnlqcbND6tPX6kbnPlX95Ef
         n8B1W8Crw8HkldpPMBzFgsCt6FZ1xAnFMhlw3feQz1KS4haB52RfczeAcRzsLobItJwX
         RJHue/ZZW0cf4DwMEQCSE+LoTREz6gTl3pAKbi56D+zcPpUN3BQ2OETJzTo+JBBJZK1K
         jM/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767822664; x=1768427464;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HQ1KBGJPpTj40+OrzrQ/BgQdEdtto5sxRALWAVoXHkw=;
        b=kqKB0W+IUrkpz9tfW6BJTPi4/uKJtiJ1I2NsX99mQpxHnFe7N5Y+YLbOygOTRqzbR/
         cQ4RN+vNVAwBwlN9IKzGzkfEz6v1AvTBtXpCT4qbrKlJHG5HcWT3O7fncNkzyLgdsomv
         zkkCP96ObQjdLN1oldc805EdiNiCXNtIVlHRfN+wezskkoEsC0I2oQ3akd+5T84I1pSj
         I73mGb2CUCcnzdZ9M6NUStQasPk+mmWRPYa2Oa0S/JHGDdBd9q0N0+wpY4UOe67jWs4v
         dVzH/fFZayLKxQGcMDcy88PKGb6GjzKH8inn9vIZeZq6DlY5OCImdIzQSanAx9O1B9Fi
         5fdA==
X-Forwarded-Encrypted: i=1; AJvYcCXskgw1OX9zxyNegUr0DQ5R3ahpTelVJ2wEsA+8xlqR93s9g6zoQAtLpxCUx7DV6eJBHWI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAogzUqjDoQwnNPcaVZVdbhds27p/z1MXs+6XnHaR/cRIxUyVL
	1Pp9XaaahAX8R48FZ9hjvYQrDuKbuw7+fg6Jqq0CukY/sw/2XDlt1xxIkadbYVTQ8jtQ63nBr2U
	TOL6FvmkRbMijXI+3ya1BnbhBA7LjRKs=
X-Gm-Gg: AY/fxX5U6P5VgVaU4zi7xs4ndju+R+yMa7QNqQaTsj6seb0EBk5dyPYyNPkhDttErj/
	Z9wTDXu4mWryr7ZSBEWH1R4VBDDQwFycuHrGMh8wM5nKgI29NKdOZH2KmiQqDUxeSa0KepQ90tX
	qfglrIS9UwYZXq/LSMTW5dNVuESbzGmE4b8b9slOdXa+m0+789oVHlNP1owTqz6DejCyg5d2MPB
	pGnOp5MlRnPrEYMiw83rrP4+IK8ozTOse+HYbs4Uoqk9nWRDjwhdjpqBbX7/KY5bpaq7sM=
X-Google-Smtp-Source: AGHT+IGZb2X+to5BfO9rQSjQnzZD4wSCWHW0qVmq5skwC2T7ZNEXW3JqgQ0V9sgdGOpLUNpbFzBL6XDkvQ1+1i9WZgc=
X-Received: by 2002:a17:903:2344:b0:2a0:b467:a7ce with SMTP id
 d9443c01a7336-2a3ee4901d0mr34942495ad.36.1767822664116; Wed, 07 Jan 2026
 13:51:04 -0800 (PST)
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
 <CAErzpmsvirekLBRrJYVgmRC0YKWCbo7OyRQXgNYrk83aF-Wz2Q@mail.gmail.com> <CAErzpmv99TG_pjyjcQd5xjC7M+yUGs6SNtL9b3nJQAC8z-nafw@mail.gmail.com>
In-Reply-To: <CAErzpmv99TG_pjyjcQd5xjC7M+yUGs6SNtL9b3nJQAC8z-nafw@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 7 Jan 2026 13:50:51 -0800
X-Gm-Features: AQt7F2p2jJtm444dDzyPKU2nAS4ZPTFtV8Hjs8PR9sogeGK8aVTGop3arEyba74
Message-ID: <CAEf4BzY79TJ5=s4EJC-TMc+7fow9E+H0qP67h=W=+BVkbc-ocQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v10 05/13] libbpf: Verify BTF Sorting
To: Donglin Peng <dolinux.peng@gmail.com>
Cc: ast@kernel.org, eddyz87@gmail.com, zhangxiaoqin@xiaomi.com, 
	ihor.solodrai@linux.dev, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	pengdonglin <pengdonglin@xiaomi.com>, Alan Maguire <alan.maguire@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 6, 2026 at 7:45=E2=80=AFPM Donglin Peng <dolinux.peng@gmail.com=
> wrote:
>
> On Sat, Dec 20, 2025 at 10:36=E2=80=AFPM Donglin Peng <dolinux.peng@gmail=
.com> wrote:
> >
> >
> >
> > On Sat, Dec 20, 2025 at 1:33=E2=80=AFAM Andrii Nakryiko <andrii.nakryik=
o@gmail.com> wrote:
> > >
> > > On Thu, Dec 18, 2025 at 9:06=E2=80=AFPM Donglin Peng <dolinux.peng@gm=
ail.com> wrote:
> > > >
> > > > On Fri, Dec 19, 2025 at 7:44=E2=80=AFAM Andrii Nakryiko
> > > > <andrii.nakryiko@gmail.com> wrote:
> > > > >
> > > > > On Thu, Dec 18, 2025 at 3:31=E2=80=AFAM Donglin Peng <dolinux.pen=
g@gmail.com> wrote:
> > > > > >
> > > > > > From: pengdonglin <pengdonglin@xiaomi.com>
> > > > > >
> > > > >
> > > > > typo in subject: "Sorting" -> "sorting", it looks weird capitaliz=
ed like that
> > > >
> > > > Thanks, I will do it.
> > > >
> > > > >
> > > > > > This patch checks whether the BTF is sorted by name in ascendin=
g
> > > > > > order. If sorted, binary search will be used when looking up ty=
pes.
> > > > > >
> > > > > > Cc: Eduard Zingerman <eddyz87@gmail.com>
> > > > > > Cc: Alexei Starovoitov <ast@kernel.org>
> > > > > > Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> > > > > > Cc: Alan Maguire <alan.maguire@oracle.com>
> > > > > > Cc: Ihor Solodrai <ihor.solodrai@linux.dev>
> > > > > > Cc: Xiaoqin Zhang <zhangxiaoqin@xiaomi.com>
> > > > > > Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
> > > > > > ---
> > > > > >  tools/lib/bpf/btf.c | 41 +++++++++++++++++++++++++++++++++++++=
++++
> > > > > >  1 file changed, 41 insertions(+)
> > > > > >
> > > > > > diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> > > > > > index 2facb57d7e5f..c63d46b7d74b 100644
> > > > > > --- a/tools/lib/bpf/btf.c
> > > > > > +++ b/tools/lib/bpf/btf.c
> > > > > > @@ -899,6 +899,46 @@ int btf__resolve_type(const struct btf *bt=
f, __u32 type_id)
> > > > > >         return type_id;
> > > > > >  }
> > > > > >
> > > > > > +/*
> > > > > > + * Assuming that types are sorted by name in ascending order.
> > > > > > + */
> > > > >
> > > > > Unnecessary comment, and no, btf_compare_type_names() itself make=
s no
> > > > > such assumption, it just compares two provided types by name. Dro=
p the
> > > > > comment, please.
> > > > >
> > > > > > +static int btf_compare_type_names(__u32 *a, __u32 *b, const st=
ruct btf *btf)
> > > > > > +{
> > > > > > +       struct btf_type *ta =3D btf_type_by_id(btf, *a);
> > > > > > +       struct btf_type *tb =3D btf_type_by_id(btf, *b);
> > > > > > +       const char *na, *nb;
> > > > > > +
> > > > > > +       na =3D btf__str_by_offset(btf, ta->name_off);
> > > > > > +       nb =3D btf__str_by_offset(btf, tb->name_off);
> > > > > > +       return strcmp(na, nb);
> > > > > > +}
> > > > >
> > > > > you use this function only in one place, there is no real point h=
aving
> > > > > it, especially that it uses **a pointer to type ID** as an
> > > > > interface... just inline its logic in that one loop below
> > > > >
> > > > > > +
> > > > > > +static void btf_check_sorted(struct btf *btf)
> > > > > > +{
> > > > > > +       const struct btf_type *t;
> > > > > > +       __u32 i, k, n;
> > > > > > +       __u32 sorted_start_id;
> > > > > > +
> > > > > > +       if (btf->nr_types < 2)
> > > > > > +               return;
> > > > >
> > > > > why special casing? does it not work with nr_types =3D 0 or nr_ty=
pes =3D 1?
> > > >
> > > > No. I just think it doesn't make any sense to check the sorting
> > > > of BTF with zero or only one type.
> > > >
> > >
> > > Look, I don't know how to emphasize this enough. Any special case lik=
e
> > > this is nothing good, it adds more cases to consider and raises
> > > questions why generic case code doesn't handle such special cases. It
> > > implies that generic case handling might have some unhandled corner
> > > case that we are trying to short-circuit with early exits like this.
> > > It just basically means we don't trust our code, in a sense. It's jus=
t
> > > unnecessary and thus sloppy. Don't do this unnecessarily.
> >
> > Thank you for taking the time to explain this so clearly. I=E2=80=99m g=
rateful for
> > your patience in pushing for rigor =E2=80=94 it=E2=80=99s exactly the k=
ind of scrutiny that
> > makes the codebase stronger. I=E2=80=99ll make sure to apply this lesso=
n in future
> > revisions.
> >
> > >
> > > > >
> > > > > > +
> > > > > > +       sorted_start_id =3D 0;
> > > > >
> > > > > nit: initialize in declaration
> > > >
> > > > Thanks, I will do it.
> > > >
> > > > >
> > > > >
> > > > > > +       n =3D btf__type_cnt(btf);
> > > > > > +       for (i =3D btf->start_id; i < n; i++) {
> > > > > > +               k =3D i + 1;
> > > > > > +               if (k < n && btf_compare_type_names(&i, &k, btf=
) > 0)
> > > > > > +                       return;
> > > > > > +               if (sorted_start_id =3D=3D 0) {
> > > > > > +                       t =3D btf_type_by_id(btf, i);
> > > > > > +                       if (t->name_off)
> > > > >
> > > > > I'd check actual string, not name_off. Technically, you can have =
empty
> > > > > string with non-zero name_off, so why assume anything here?
> > > >
> > > > Thanks, I will do it.
> > > >
> > > > >
> > > > > > +                               sorted_start_id =3D i;
> > > > > > +               }
> > > > > > +       }
> > > > > > +
> > > > > > +       if (sorted_start_id)
> > > > > > +               btf->sorted_start_id =3D sorted_start_id;
> > > > >
> > > > > You actually made code more complicated by extracting that
> > > > > btf_compare_type_names(). Compare to:
> > > > >
> > > > > n =3D btf__type_cnt(btf);
> > > > > btf->sorted_start_id =3D 0;
> > > > > for (i =3D btf->start_id + 1; i < n; i++) {
> > > > >    struct btf_type *t1 =3D btf_type_by_id(btf, i - 1);
> > > > >    struct btf_type *t2 =3D btf_type_by_id(btf, i);
> > > > >    const char *n1 =3D btf__str_by_offset(btf, t1->name_off);
> > > > >    const char *n2 =3D btf__str_by_offset(btf, t2->name_off);
> > > > >
> > > > >    if (strcmp(n1, n2) > 0)
> > > > >         return;
> > > > >    if (btf->sorted_start_id =3D=3D 0 && n1[0] !=3D '\0')
> > > > >         btf->sorted_start_id =3D i - 1;
> > > > > }
> > > >
> > > > Thanks. I believe we shouldn't directly assign a value to
> > > > `btf->sorted_start_id` within the for loop, because
> > > > `btf->sorted_start_id` might be non-zero even when the
> > > > BTF isn't sorted.
> > >
> > > Ah, right, we'd need to reset btf->sorted_start_id to zero in that
> > > strcmp(n1, n2) > 0 branch. Using btf->sorted_start_id directly is not
> > > the main point here, though, feel free to use a local variable, but
> > > don't add unnecessary helper functions which don't do much, but
> > > obscure the logic unnecessarily.
> >
> > Thanks, I will use a local variable and remove the helper functions.
>
> Hi Andrii,
>
> I noticed that the code above does not handle the scenario where
> only the last btf_typein a sorted BTF has a name. So I've added an
> additional check in the loop as follows:
>
> static void btf_check_sorted(struct btf *btf)
> {
>         __u32 i, n, named_start_id =3D 0;
>
>         n =3D btf__type_cnt(btf);
>         for (i =3D btf->start_id + 1; i < n; i++) {
>                 struct btf_type *ta =3D btf_type_by_id(btf, i - 1);
>                 struct btf_type *tb =3D btf_type_by_id(btf, i);
>                 const char *na =3D btf__str_by_offset(btf, ta->name_off);
>                 const char *nb =3D btf__str_by_offset(btf, tb->name_off);
>
>                 if (strcmp(na, nb) > 0)
>                         return;
>
>                 if (named_start_id =3D=3D 0) {
>                         if (na[0] !=3D '\0')
>                                 named_start_id =3D i - 1;
>                         else if (i =3D=3D (n - 1) && nb[0] !=3D '\0') /*
> only the last one has a name */
>                                 named_start_id =3D i;
>                 }

good observation!

How about a bit more uniform way?

if (named_start_id =3D=3D 0 && na[0] !=3D '\0')
    named_start_id =3D i - 1;
if (named_start_id =3D=3D 0 && nb[0] !=3D '\0')
    named_start_id =3D i;


less nested conditions, and code clearly says that we pick earliest
non-anon type in a comparison pair as named_start_id

>         }
>
>         if (named_start_id)
>                 btf->named_start_id =3D named_start_id;
> }
>
> WDYT?
>
> >
> > >
> > > >
> > > > >
> > > > >
> > > > > No extra k<n checks, no extra type_by_id lookups. It's minimalist=
ic
> > > > > and cleaner. And if it so happens that we get single type BTF tha=
t is
> > > > > technically sorted, it doesn't matter, we always fallback to fast=
er
> > > > > linear search anyways.
> > > > >
> > > > > Keep it simple.
> > > >
> > > > Thank you. I will adopt this method in the next version.
> > > >
> > > > >
> > > > > > +}
> > > > > > +
> > > > > >  static __s32 btf_find_by_name_bsearch(const struct btf *btf, c=
onst char *name,
> > > > > >                                                 __s32 start_id,=
 __s32 end_id)
> > > > > >  {
> > > > > > @@ -1147,6 +1187,7 @@ static struct btf *btf_new(const void *da=
ta, __u32 size, struct btf *base_btf, b
> > > > > >         err =3D err ?: btf_sanity_check(btf);
> > > > > >         if (err)
> > > > > >                 goto done;
> > > > > > +       btf_check_sorted(btf);
> > > > > >
> > > > > >  done:
> > > > > >         if (err) {
> > > > > > --
> > > > > > 2.34.1
> > > > > >

