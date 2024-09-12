Return-Path: <bpf+bounces-39764-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C39A977270
	for <lists+bpf@lfdr.de>; Thu, 12 Sep 2024 21:51:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E7651F2551C
	for <lists+bpf@lfdr.de>; Thu, 12 Sep 2024 19:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CB621C233E;
	Thu, 12 Sep 2024 19:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jiTsuioA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4999188001
	for <bpf@vger.kernel.org>; Thu, 12 Sep 2024 19:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726170365; cv=none; b=ORaODGBHaPQrnqiyPgMmNBxRRC476+aGWufVgssObvwnYgEII83dQXOjt4jX/zX8ujWyJ88EnBb42dZWWotclfTkJTclS16X33yH3nKhOC6fk9BTENv1jFUhGZq74mzDYGFjTu7M0k8Ynb6GJKF708fb+SjyBEXF+ztF2IX33N8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726170365; c=relaxed/simple;
	bh=SZ7lCL7bBfHqITtnSZIthLQrMlmoCZpNPEsvgNnKG4E=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lsDsAmmWvvcIwXgWBKIf50dDYp7IFbmj9hVUeiB+3g5kgwQAW8jbqfY7b8E4xl9UmIgJD++lnHB9kt/OifNqZl79bot0QWjUKTw8BNcGib4UzOJ4fAzEpujsVN0FAdLEd/jqub1jYU/Kwc+6E+/U9uoVFp4Zvk8xyyh7hrGyAT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jiTsuioA; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2059204f448so13212185ad.0
        for <bpf@vger.kernel.org>; Thu, 12 Sep 2024 12:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726170363; x=1726775163; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SZ7lCL7bBfHqITtnSZIthLQrMlmoCZpNPEsvgNnKG4E=;
        b=jiTsuioAkqguoMR1ViHOVAa4413LOM8KogRQXP32b/IjZCQLD7qNX4KrleDMzEOBiI
         GdwFg37iUG3bMz9W2kAG9YN+ILvU6GDasw0q9ed+7jgJzVU8AUoQHGLpvDFmc+1+t6nM
         mwlAaknNz1Q2cGLMVKXJwoYMU+BncVOS3HOb0fkVGv3NJOWGc2Tx1VZECjn/bawlAWVp
         mLijl9FA6OHRsl6OkC89bK2JoFgBfL0yx66O2BLmuYT6K6U8QCBaQCHP7POv2L0xfvn/
         Huiw3VoG9LeSbdTeNq30eDYvqwR7l426y1zAzTd0tJKITt33Lp5yLyOHc4IhOyW3vNRD
         rW/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726170363; x=1726775163;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SZ7lCL7bBfHqITtnSZIthLQrMlmoCZpNPEsvgNnKG4E=;
        b=pcS/Ylujl/G72fSD301SPehb6uVUMW2Usyj51dbLxYRodv2dIMt6os5n1I/0QBF8Ic
         RIG8xT8FLJUd4kLW012JswTBSdvRGQZT7VfkO/iniUfoRw4/sVIpO4pkDngAcVRAW84i
         QwsBTW0PVYuTot8Gbtd0uzODIYN62BBBqeYP0CC84SdhE6nIMnZqFIkwwynhf0yUbboH
         MHoch/of522P277JaMcHv2Dalm4xv/3WK/4subYsP1TLzZ1DEdQg+ACFGXmer4T153Q+
         qzRG33WG6+xrNlYWevk7S7INlYn9VA6HeRZEk47G9pgBiNf2ERYIgiaonim4tu8xXddV
         DxjQ==
X-Forwarded-Encrypted: i=1; AJvYcCUiKTChIp0CBSCz2gP0ADcVFnvlI6WNGEvuQCRHdLHqB0J9G1NQn/7q1BdZ3SSxwQAE2VM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMaKvCxHg27gLM+zcSfnr4wrWa1BuUZA7c2GnRI4HUPfeSeBYp
	YRl1wE6UB5+aIri6XasCyIJzlo5yc5hHgFw/onTTnFh2uH3fiLet
X-Google-Smtp-Source: AGHT+IHyJ1PaYElg6DXROJC5ZzObu5NQWqpmEfqDZw5ilE/A/ADgeZHCQ7sgH6xzP9ZCziv8R5ya3g==
X-Received: by 2002:a17:902:cecd:b0:206:b960:2e97 with SMTP id d9443c01a7336-2076e4128femr62596365ad.45.1726170362703;
        Thu, 12 Sep 2024 12:46:02 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2076afdd086sm17533625ad.181.2024.09.12.12.46.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 12:46:02 -0700 (PDT)
Message-ID: <e1229dd76486134e9555d791e4892927f4346bb7.camel@gmail.com>
Subject: Re: [RESEND][PATCH bpf 1/2] bpf: Check the remaining info_cnt
 before repeating btf fields
From: Eduard Zingerman <eddyz87@gmail.com>
To: Thinker Li <thinker.li@gmail.com>
Cc: Hou Tao <houtao@huaweicloud.com>, bpf@vger.kernel.org, Martin KaFai Lau
 <martin.lau@linux.dev>, Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
 Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>, Hao Luo
 <haoluo@google.com>, Yonghong Song <yonghong.song@linux.dev>, Daniel
 Borkmann <daniel@iogearbox.net>, KP Singh <kpsingh@kernel.org>, Jiri Olsa
 <jolsa@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 houtao1@huawei.com, xukuohai@huawei.com
Date: Thu, 12 Sep 2024 12:45:57 -0700
In-Reply-To: <CAFVMQ6Q64aFM7xCW_htrU0dpB+S+eEXYLSeUufTgg_eB5DEN4g@mail.gmail.com>
References: <20240911110557.2759801-1-houtao@huaweicloud.com>
	 <20240911110557.2759801-2-houtao@huaweicloud.com>
	 <16794f86fd1030d923e3ab7356c5ff3617b2b193.camel@gmail.com>
	 <CAFVMQ6Q64aFM7xCW_htrU0dpB+S+eEXYLSeUufTgg_eB5DEN4g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-09-12 at 21:13 +0200, Thinker Li wrote:

[...]

> > > diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> > > index a4e4f8d43ecf..9a4a074d26f5 100644
> > > --- a/kernel/bpf/btf.c
> > > +++ b/kernel/bpf/btf.c
> > > @@ -3592,6 +3592,12 @@ static int btf_find_nested_struct(const struct=
 btf *btf, const struct btf_type *
> > > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0info[i].off +=
=3D off;
> > > =C2=A0=20
> > > =C2=A0 =C2=A0 =C2=A0 =C2=A0if (nelems > 1) {
> > > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* The type of struc=
t size or variable size is u32,
> > > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * so the multiplica=
tion will not overflow.
> > > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 */
> > > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret * nelems > i=
nfo_cnt)
> > > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0return -E2BIG;
> > > +
> > > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0err =3D btf_re=
peat_fields(info, ret, nelems - 1, t->size);
> > > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (err =3D=3D=
 0)
> > > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0ret *=3D nelems;
> >=20
> >=20
> > btf_repeat_fields(struct btf_field_info *info,
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 u32 fiel=
d_cnt, u32 repeat_cnt, u32 elem_size)
> >=20
> > copies field "field_cnt * repeat_cnt" times,
> > in this case field_cnt =3D=3D ret, repeat_cnt =3D=3D nelems - 1,
> > should the check be "ret * (nelems - 1) > info_cnt"?
> >=20
> > I suggest to add info_cnt as a parameter of btf_repeat_fields() and do
> > this check there. So that the check won't be forgotten again if
> > btf_repeat_fields() is used elsewhere. Wdyt?
> >=20
>=20
> Should not this check be moved before the earlier for-loop?

Shouldn't the check for 'ret <=3D 0' be enough to make sure the for-loop
is fine?



