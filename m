Return-Path: <bpf+bounces-77089-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A6F7DCCE1C4
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 02:01:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8681B301C3FA
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 01:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F4F52264CA;
	Fri, 19 Dec 2025 01:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wrd5D7EU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF001A8F97
	for <bpf@vger.kernel.org>; Fri, 19 Dec 2025 01:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766106104; cv=none; b=nWAJvoWU94awNbEiBEoUODbRMxrYsaqTYZ2X2yk0LMhZtEvTwjLXXqpLOyXKkfI3nAwSgTY6ye04Gbz0EB/cQbvICBDv+vyVVxQKab7tRCltgCL28+3vw4xzvYp4t/f5my23Gb8jiJJpw4Im84AlbhjMn5AeH5IY50hv+yg2YTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766106104; c=relaxed/simple;
	bh=zd3dJV2RaUpsCT+wpuBM0RsuM7StzvZ1idgglYYGZjE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uZ+zQFqomcJte9hFQVJTe8U7PFRHb+boDWRGyFPv9ypqZ2b6sFcW/h/9xcjxdRTLwz/wyy1xW43rWyjnsPPjM8qk1T8WFhsrlwnK86QXx+Yyt4ZWID+8LcNdjxRTlUh/s3k0iypyjFdNqQV+T69BVt9qeuu6X9hBTrjQkdNZ/Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wrd5D7EU; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-34aa62f9e74so1553217a91.1
        for <bpf@vger.kernel.org>; Thu, 18 Dec 2025 17:01:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766106102; x=1766710902; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HiOCn/qWhE9KxakkVdbRY9XP6E8J6PU+UH8uPmU8t8E=;
        b=Wrd5D7EUb365hy3kYgMyTkR0zqinNjwXjGaDSL495ogQ55B2l7akJxeTieq5tP7mG+
         dYJEfBedjZOzUnYeK0gArEDlqNXKLWOnUeq1e8qEZ2bjBIVqWrck2I2xjm7zCWzE5pbK
         zKijvz9ZdFjNr7gg4b3J7oo0E+86eOOq1YwbDApIPhd+5XC6mF7xTOXlsv3hE65oqjOb
         OyJho8cJ065uFnVIZdj6gNEH7ccqzOGY2IOLqJikNKJTqaz0DbEkaxSMYG9ZE7E9bS39
         vBkMeaWAoyZZd0EGqGEcSWfv70gdkG8qtORzfipXLTWxgKyouYZYOX7AtxJ93f0D108R
         eIFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766106102; x=1766710902;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HiOCn/qWhE9KxakkVdbRY9XP6E8J6PU+UH8uPmU8t8E=;
        b=AezEvArzx7wfENh40brHDCvE1mGe+C66EL2Eucb/D6pExxweft4SftSfZEr3SrFuhw
         NYQ9jMGsFz+BewGniBi2NIHGrPm3iN6/2AV5IFE/Z9FY5pqgmQd/21BSMRFY2nRrWLYk
         0GJk8SmdXc1VvAMMf2TIjbLN5fIH33G6DZgn3lgp5d7DAHaeAkMZAj7J4CPW59OkkbME
         4uiM7xNsv7Q37NVxgSCQVsef/jfOHySzDSCNl87VrbTKKOah+5h4TIKoqeI0VdHl8QSt
         uJC8unBxKtNmntJpJjohLIIbyycLvgBHiM/CczxW3W9WVN2uGvoZPXKNrjokhy+7vbqw
         h99Q==
X-Forwarded-Encrypted: i=1; AJvYcCXBV5KF1foHUK+eZSIMncfMJ+r8nweHgjF0JlsGcdfj+26jAKF+8IgJIOXo5VKOlOXOFa0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfhhAh4C+lqPCwQuEvE6omvolgbf4FGb1s+bAw9LmaQgoJLIz3
	tMvH3ux+6crplTr14dfTNubx46ve43sN4tfUkA1sdZjieGpm9eLsQbO6vx9QVFbypIQlRhi9DcA
	LfnQLMqNOl1FmaGrQVtgLUZyOEQlEUwCMWQ==
X-Gm-Gg: AY/fxX7Lt7qs7BaR94FRRFzh9x77ooDIlgIfxBpsbJoDjuM2Hz+RXwXLX75W35jc2D/
	UXAcQCbcZZL7KfbCChw7k2KnDc324L8bpss+2GlVC10dB1Xh0Cw9xUDc49BOQ0pYKFpa61pgceu
	z284r4rHtr3s+J/larJoLg4WityhQjAhsaoCK89JEIla369RfcZn7S44gXgqWbBVic4L93tSlNd
	1w8OhdIcwhXkygNQPMUXKV4yKUR4JT3GFrY4k1ZnGZyTxcIMhPX8NgCacXXFu2bbSB+MNiFjDlt
	JkKJlx5030o=
X-Google-Smtp-Source: AGHT+IG8YsP/HhQaiozDV1h6pW19gs2KtqqFEh/5CoFCr34fgj2o9RqK46v/d+ZtS5svzwntlvU5PXJyOftGBt8A7X0=
X-Received: by 2002:a17:90b:33c9:b0:340:dd2c:a3f5 with SMTP id
 98e67ed59e1d1-34e921235efmr1115534a91.3.1766106101716; Thu, 18 Dec 2025
 17:01:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251218113051.455293-1-dolinux.peng@gmail.com>
 <20251218113051.455293-5-dolinux.peng@gmail.com> <CAEf4BzbSMwW4es5D9i=bpSjALo8u+oW-9vdQ7=DBoTBtMoJ1Tg@mail.gmail.com>
 <d161fb1f8b7a3b994fe3ed4a00e01fc1f1af3513.camel@gmail.com>
 <CAEf4Bzamgpk7Dj2uMrCmVEijvyHKqUguWJU7h+12pSr3S7F1hQ@mail.gmail.com> <e2690b163b823d82565ce2dc6e58fa23c0bf7935.camel@gmail.com>
In-Reply-To: <e2690b163b823d82565ce2dc6e58fa23c0bf7935.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 18 Dec 2025 17:01:27 -0800
X-Gm-Features: AQt7F2rBtQFuqeFqmvGc3klctvni7MxmraVS1KfLiLJvQUl6PyUPwYfG9t3Zxe0
Message-ID: <CAEf4BzbbRP6ftHE0q5cDLJ9EhaSP+Ssy7rMJjFSn2GDrSL8O-Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v10 04/13] libbpf: Optimize type lookup with
 binary search for sorted BTF
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Donglin Peng <dolinux.peng@gmail.com>, ast@kernel.org, zhangxiaoqin@xiaomi.com, 
	ihor.solodrai@linux.dev, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	pengdonglin <pengdonglin@xiaomi.com>, Alan Maguire <alan.maguire@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 18, 2025 at 4:25=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Thu, 2025-12-18 at 16:19 -0800, Andrii Nakryiko wrote:
> > On Thu, Dec 18, 2025 at 4:13=E2=80=AFPM Eduard Zingerman <eddyz87@gmail=
.com> wrote:
> > >
> > > On Thu, 2025-12-18 at 15:29 -0800, Andrii Nakryiko wrote:
> > >
> > > [...]
> > >
> > > > >  static __s32 btf_find_by_name_kind(const struct btf *btf, int st=
art_id,
> > > > >                                    const char *type_name, __u32 k=
ind)
> > > >
> > > > kind is defined as u32 but you expect caller to pass -1 to ignore t=
he
> > > > kind. Use int here.
> > > >
> > > > >  {
> > > > > -       __u32 i, nr_types =3D btf__type_cnt(btf);
> > > > > +       const struct btf_type *t;
> > > > > +       const char *tname;
> > > > > +       __s32 idx;
> > > > > +
> > > > > +       if (start_id < btf->start_id) {
> > > > > +               idx =3D btf_find_by_name_kind(btf->base_btf, star=
t_id,
> > > > > +                                           type_name, kind);
> > > > > +               if (idx >=3D 0)
> > > > > +                       return idx;
> > > > > +               start_id =3D btf->start_id;
> > > > > +       }
> > > > >
> > > > > -       if (kind =3D=3D BTF_KIND_UNKN || !strcmp(type_name, "void=
"))
> > > > > +       if (kind =3D=3D BTF_KIND_UNKN || strcmp(type_name, "void"=
) =3D=3D 0)
> > > > >                 return 0;
> > > > >
> > > > > -       for (i =3D start_id; i < nr_types; i++) {
> > > > > -               const struct btf_type *t =3D btf__type_by_id(btf,=
 i);
> > > > > -               const char *name;
> > > > > +       if (btf->sorted_start_id > 0 && type_name[0]) {
> > > > > +               __s32 end_id =3D btf__type_cnt(btf) - 1;
> > > > > +
> > > > > +               /* skip anonymous types */
> > > > > +               start_id =3D max(start_id, btf->sorted_start_id);
> > > >
> > > > can sorted_start_id ever be smaller than start_id?
> > >
> > > sorted_start_id can be zero, at two callsites for this function
> > > start_id is passed as btf->start_id and 1.
> >
> > Can it with the check above?
> >
> >   if (btf->sorted_start_id > 0 && type_name[0]) {
> >
> >
> > This branch is a known sorted case. That's why all these start_id
> > manipulations look weird and sloppy.
>
> Oops, it cannot.
> But still it feels strange to pass a 'start_id' parameter to a
> function and rely at exact values passed at callsites. Replace the
> parameter with boolean 'own'?

hm.. looking around a bit more, it seems like passed-in start_id might
be useful for iterator-like searches. We don't use that right now, but
maybe we should preserve this behavior? And then max() does make sense
(though "skip anonymous types" is a bit too brief, I'd mention that
start_id might be within the named types intentionally and we need to
jump forward)

>
> > >
> > > >
> > > > > +               idx =3D btf_find_by_name_bsearch(btf, type_name, =
start_id, end_id);
> > > >
> > > > is there ever a time when btf_find_by_name_bsearch() will work with
> > > > different start_id and end_id? why is this not done inside the
> > > > btf_find_by_name_bsearch()?
> > > >
> > >
> > > [...]

