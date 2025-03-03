Return-Path: <bpf+bounces-53128-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1699CA4CF36
	for <lists+bpf@lfdr.de>; Tue,  4 Mar 2025 00:27:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 832793AAAB4
	for <lists+bpf@lfdr.de>; Mon,  3 Mar 2025 23:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B8AC23AE66;
	Mon,  3 Mar 2025 23:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OWni2hwS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0C622FF4F
	for <bpf@vger.kernel.org>; Mon,  3 Mar 2025 23:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741044447; cv=none; b=U0PvMRy62h7mxqlBABXKdSF44kxjRSAbqzBncWbcpntNoOhjY7cTPt4KCocGsFsUBwRe7CyMO+YwRJ7BVug0NFxllJDLZrMJ6vqJxKDTH4LiV8KPYHl7Z+ZZmlIIeq0sytAhaQM8Iey3KHNvYCxwMUT6EwWknJSnvKDAIdOLQLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741044447; c=relaxed/simple;
	bh=89KtjOS04oLNR04nCTFO1IXu/ahbpRvRTAEY7mn5mN8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G16q1oPokU66i7PdNb0pgY7Kl2R+EPUw07fIVxG8y8NadvXx/VmHZTCeweBd+NDI3Ai97tAbpwHjKvGRiB2q0m11BUCwC4fm0yqCPsYmpFenjCqT7DpQ+NSVLFBaYXvmLP5R0u0sJZ93pVhBdScJHTOoYZKxITzLe3FYv/RyBRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OWni2hwS; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-223594b3c6dso85853945ad.2
        for <bpf@vger.kernel.org>; Mon, 03 Mar 2025 15:27:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741044445; x=1741649245; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UOmc1DrKT7ORHuCgpO7hx4iDq1rxCTNBr3qLFjwDNpc=;
        b=OWni2hwSnEYUx57jXBVTi0DSldbMMJBLWFFYn5OIRAZZGE/Z8SCJ8AU/+SZ9ukamqd
         Ppe09wy84Y1alx/pYQDQ++bmXvKnbfLEFFnkjrCgJ8T5tq1N5ti8FcTrX1CfSQDc3J32
         qeuplKKR00rV9ritC9Q9ZgEkSj3gQDSaj1Of9Q19ulS6CyOVjDpgI4irlC0mNaVK1hho
         Qsb7Il3nGreIG0BSZjTsrx2bMt+uz6k7OGQfXRevzh3FLvs+KE9IOAsOHp1z8pI2bJsI
         CxdAcaKpTz+a6vNblb71f5OfzT2UZBBqm9ZN8K8dDWrazvlaXNTmTnQS3gduYb1fpG88
         ORUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741044445; x=1741649245;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UOmc1DrKT7ORHuCgpO7hx4iDq1rxCTNBr3qLFjwDNpc=;
        b=PwCrTX4xPjk0jejp1yanm0ZgCIqIT8S2ANqq9e/SRorUVSjRGsdWGGodt/8hcKDkj/
         ql1NUHVZHwTm4Y0zFSJP0jDRIon+qvk3HOz2II1GYyB26eofj+UaTjWw7WvVXMd0nsWk
         Bbsidbvmsc3sQRRQQzsUI61Q3QTLypjczGvpeQHPenvIBgDlcgWyeDITL8McENjn5IXO
         Dh5kDm/Tam6GtOQ9ZEPYKF9INZK7fJCYHKMH41BwXiB3Pp1/feAJiN7rfLrOmEbo2gZr
         JeCVqtChdlJLKPv3cqLkNezqrdm10E2Q++0Y/xvVDqzySB72bOKz0/4O9qtbL1k4p747
         Ec1Q==
X-Forwarded-Encrypted: i=1; AJvYcCU6AsADrushZEsKmkguDs6aA2Zbc/vxuB09vLXpU3qDwCL561nogowsG89xW526xK7zJ48=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFpmJxKsmRG6YOJ3R6TonCxj/uxboe9osZKHEA3ZZ2eSaswTZZ
	M2+yztbvuhHfU4meHT00ZPzPbaBa2om0iwgUgV4/7ObJj4DALh8u+WstfwL8Uean8JKB+aUBRDV
	JftLZOCc13I19Vfbu5GaKp2duLQc=
X-Gm-Gg: ASbGnctHmPEKN+wyb2NQQouQ0UoIbBUgzo9XwDNKSdmiIqUe9XjPQY7L7FOY4fbQ5XZ
	YjdcKvKk+InKXtK7xjb6zO9IxBGdTf5lzh8TarEwOQ6bo/VidGMU6J/4GUKQtEu1WqHan+rX4f2
	+Ydx0pG/JU8NYTOaPPMVYzlGy6
X-Google-Smtp-Source: AGHT+IHpPb+bEFTY7xGlezzQ0DUQCsRsPiHE6HdnHqt9jg6cPcMGYFer2UZ0p3ZRaBuaR2nG6jzLi+D4oEbVnr/b5rM=
X-Received: by 2002:a05:6a00:218f:b0:730:75b1:7218 with SMTP id
 d2e1a72fcca58-734ac42ad3bmr22064500b3a.16.1741044445283; Mon, 03 Mar 2025
 15:27:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250228175255.254009-1-mykyta.yatsenko5@gmail.com>
 <20250228175255.254009-3-mykyta.yatsenko5@gmail.com> <5d7fb7202625b999cb77a1e010ba6f7099dbb561.camel@gmail.com>
 <00e385df-7ffc-4fd9-aad8-60dddef300af@gmail.com> <CAEf4Bzat3grecmd_PkmLpN9gAfkuGhmO4o4HmgZWE4sJ9BL+fw@mail.gmail.com>
 <25f64bc2c9dbeb68a0ef21290323954e70e7366b.camel@gmail.com>
In-Reply-To: <25f64bc2c9dbeb68a0ef21290323954e70e7366b.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 3 Mar 2025 15:27:12 -0800
X-Gm-Features: AQ5f1JqgYS1OSERd1CzoP7NiDZTVitz1V7v2DEgAGKXSekWr4dPtqoAdDn2Bvwc
Message-ID: <CAEf4BzYJR0AQdgkDkp4JbOk=rksAnvi=YGOY+sQVzkUQn=qU2A@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/3] libbpf: split bpf object load into prepare/load
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org, ast@kernel.org, 
	andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 3, 2025 at 2:04=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> On Mon, 2025-03-03 at 13:38 -0800, Andrii Nakryiko wrote:
> > On Sat, Mar 1, 2025 at 1:45=E2=80=AFPM Mykyta Yatsenko
> > <mykyta.yatsenko5@gmail.com> wrote:
> > >
> > > On 01/03/2025 08:12, Eduard Zingerman wrote:
> > > > On Fri, 2025-02-28 at 17:52 +0000, Mykyta Yatsenko wrote:
> > > >
> > > > [...]
> > > >
> > > > > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > > > > index 9ced1ce2334c..dd2f64903c3b 100644
> > > > > --- a/tools/lib/bpf/libbpf.c
> > > > > +++ b/tools/lib/bpf/libbpf.c
> > > > > @@ -4858,7 +4858,7 @@ bool bpf_map__autocreate(const struct bpf_m=
ap *map)
> > > > >
> > > > >   int bpf_map__set_autocreate(struct bpf_map *map, bool autocreat=
e)
> > > > >   {
> > > > > -    if (map->obj->state >=3D OBJ_LOADED)
> > > > > +    if (map->obj->state >=3D OBJ_PREPARED)
> > > > >              return libbpf_err(-EBUSY);
> > > > I looked through logic in patches #1 and #2 and changes look correc=
t.
> > > > Running tests under valgrind does not show issues with this feature=
.
> > > > The only ask from my side is to consider doing =3D=3D/!=3D comparis=
ons in
> > > > cases like above. E.g. it seems that `map->obj->state !=3D OBJ_OPEN=
ED`
> > > > is a bit simpler to understand when reading condition above.
> > > > Or maybe that's just me.
> > > I'm not sure about this one.  >=3D or < checks for state relative to
> > > operand more
> > > flexibly,for example `map->obj->state >=3D OBJ_PREPARED` is read as
> > > "is the object in at least PREPARED state". Perhaps, if we add more s=
tates,
> > > these >,< checks will not require any changes, while =3D=3D, !=3D may=
.
> > > I guess this also depends on what we actually want to check here, is =
it that
> > > state at least PREPARED or the state is not initial OPENED.
> > > Not a strong opinion, though, happy to flip code to =3D=3D, !=3D.
> >
> > Those steps are logically ordered, so >=3D and <=3D makes more sense. I=
f
> > we ever add one extra step somewhere in between existing steps, most
> > checks will stay correct, while with equality a lot of them might need
> > to be adjusted to multiple equalities.
>
> As I said, for me personally it is easier to read "can set autocreate
> only in OPENED state", compared to "can't set autocreate if state is
> PREPARED of higher".

The latter, IMO. PREPARED state is when maps are finalized, so if we
got there or beyond, can't modify maps. For progs the similar step is
LOADED.

> But whatever, I'm not a true C programmer anyway :)
>
> [...]
>

