Return-Path: <bpf+bounces-77070-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B4942CCE08B
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 01:13:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2F21B30288F1
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 00:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEE4878C9C;
	Fri, 19 Dec 2025 00:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HG90lv5P"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF45A74BE1
	for <bpf@vger.kernel.org>; Fri, 19 Dec 2025 00:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766103204; cv=none; b=iy9kDGZpJVwQOvVMUWlvSFlMHli2jNz42HOVx9QXY1VNhL1fml8bT9xwCKMkhuTLunSRl3BvwTB0TtEkRg+vEXnGA728n9PjAq9P9GgKxF9IvF1CfYCiGom850fioqZZI3uqbyy4ztaVkz6HHt24Sy2SC1Z0uCV4hhJrB6hL2bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766103204; c=relaxed/simple;
	bh=aYKLhc3Hz8SkxjLDku4eXUpNpv2RY/naTmhgwHP3FdA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VR197jJ9a/ewpARNvN2Su0OR0WzFaFfQAsusgyQgCIKnAqWZYSE82deiRyoNVB7Wm9wnS1bdG7bBcFXA42D6ntBalCVh8JHouoYqiLy/cnF821+U1Ce7Z4PmsdZz77/PE/3UUhvYoUTb2RyZKxmWeTMu8/xBQdAit1o7OvjwgCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HG90lv5P; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-bddba676613so863444a12.2
        for <bpf@vger.kernel.org>; Thu, 18 Dec 2025 16:13:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766103202; x=1766708002; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XdN/ds6EcBkR7Ux9OCh+kabrLHiyGejt8AfEH4KpjhQ=;
        b=HG90lv5Py0cgLoUZ0Nk13NROCvaga6duz/DUxLJJlWrLS8/Aj5o6pJdBcYhzofg81I
         KvQSJxtMI9JDAo6y5a1bkWjFiEmrKS99M2LeQj1eVE/8t03eY7DHczMYzVFKIkFwhxO3
         KaAJadsA/68igPZ9oM0AqBBA2kycbtycjos+4pInYPLsXD0pmDchBRC/LnC8NOAxJEwJ
         3yOcN6WgMvG1G0bFE4d4vp/1E4Nn2mQTMCvPYKxJB4C3mg+sEs1qnLALQRIicuk3AKvz
         LYB4eAaj/WTt5CG2j0q77CU0ViLKXhfD1anp3tbT0S59urOc68NPa2Aw+G6Mj37aPvZ5
         b2jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766103202; x=1766708002;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XdN/ds6EcBkR7Ux9OCh+kabrLHiyGejt8AfEH4KpjhQ=;
        b=lAbIzGHF6jLyP/uycmTVSuaiVju/sunia/b30uWZS78vFh5/I/x11Sdr855Ldehz2P
         C+EDBKkHqVl0FCojf5b1Tl/aSeTe2N0eXkmF00ZJRRX0Zy8xW6Jqmk21pLgr9hLLeX84
         hIdDgSt17Getua0/vwSyuse/LSsgLchZnDmEjzww9V2FrKmyxImuEHefBQGSMyL6ppgE
         z6EwRD2ar+SAK9wMlfAGtB8Qx9w0blpEAVIr7TwwHNM+lKW1kFwD8aSPEUG0zDolVMqJ
         s/cZAUBEvxOUDyF4mxsf8F/WXP2BP56+0m3k8FmISRB0IQ78QIHZ8iSWJltA51Vr4PNj
         sGKA==
X-Forwarded-Encrypted: i=1; AJvYcCWkfFEFx4ycBRAIkAMhZVNyVyEwWPskdAxrO+OEPq5JpGvheXYq2wCpAgmf/M5MLzkTces=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkICK7Y+bI3Jcj7JGChJ/kpSbK/htN1InAyrSXFE20PpMnoiQ2
	NS6FBYB3AQhwFcpgYUiRb3sL33krBCkrvw+dI+TrX5jnxXTIKXA9c3OR
X-Gm-Gg: AY/fxX4nDrTxGQUlPQ62tZcNcrqR8feM/DLQHT/wNC/Euk1tORouTil4Wrk/pIPdH5b
	yFAIK6vggrh+KEKXOVON+g/a6H1gNPgxozVpminI7CqMICraWsa1+c6Tqr5so3EvZlw+SdFKuL7
	DAYpfGSnp1OigMcuRMtMZJJA+sOSNK5vBEfXGpL5/HUaW+eGf9eHN1K9Xw9H441yXRK/xUf635D
	iJertTYKe3bQycE3mDVHuJSFl+pZYeIk1fUNuk9VKmESJ2sbCEtudP4QQaPC/uNPF6WkvFW3yk9
	hi+KO8MJJ0qvjCf/yC+KZ+8Q55ETLA0BxatSgFz3yd1Q2avef4HXaK/5c2CuilpgRFKk7qk95o3
	I2//dGz20kmgu5HN0swYl8q03VNM57nEOzGiSMezKEGpNjpJcD5cWrodmRBCAwAUF2kI+ryDCow
	d8i8xDnglLb/KU8abmCVo7UItWy+QhB6kuPUsa
X-Google-Smtp-Source: AGHT+IGVjWqMrh0VFaeQHhADGn31vNui62ui79B3aTbtZB3loarqrakFixDYDXDwdRW4T80wDa5NuA==
X-Received: by 2002:a05:7022:4089:b0:11b:9386:8264 with SMTP id a92af1059eb24-121722ed029mr1048397c88.41.1766103201897;
        Thu, 18 Dec 2025 16:13:21 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:4779:aa2b:e8ff:52c4? ([2620:10d:c090:500::5:3eff])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1217253c23csm2548035c88.9.2025.12.18.16.13.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 16:13:21 -0800 (PST)
Message-ID: <d161fb1f8b7a3b994fe3ed4a00e01fc1f1af3513.camel@gmail.com>
Subject: Re: [PATCH bpf-next v10 04/13] libbpf: Optimize type lookup with
 binary search for sorted BTF
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Donglin Peng
	 <dolinux.peng@gmail.com>
Cc: ast@kernel.org, zhangxiaoqin@xiaomi.com, ihor.solodrai@linux.dev, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, pengdonglin
	 <pengdonglin@xiaomi.com>, Alan Maguire <alan.maguire@oracle.com>
Date: Thu, 18 Dec 2025 16:13:19 -0800
In-Reply-To: <CAEf4BzbSMwW4es5D9i=bpSjALo8u+oW-9vdQ7=DBoTBtMoJ1Tg@mail.gmail.com>
References: <20251218113051.455293-1-dolinux.peng@gmail.com>
	 <20251218113051.455293-5-dolinux.peng@gmail.com>
	 <CAEf4BzbSMwW4es5D9i=bpSjALo8u+oW-9vdQ7=DBoTBtMoJ1Tg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-12-18 at 15:29 -0800, Andrii Nakryiko wrote:

[...]

> >  static __s32 btf_find_by_name_kind(const struct btf *btf, int start_id=
,
> >                                    const char *type_name, __u32 kind)
>=20
> kind is defined as u32 but you expect caller to pass -1 to ignore the
> kind. Use int here.
>=20
> >  {
> > -       __u32 i, nr_types =3D btf__type_cnt(btf);
> > +       const struct btf_type *t;
> > +       const char *tname;
> > +       __s32 idx;
> > +
> > +       if (start_id < btf->start_id) {
> > +               idx =3D btf_find_by_name_kind(btf->base_btf, start_id,
> > +                                           type_name, kind);
> > +               if (idx >=3D 0)
> > +                       return idx;
> > +               start_id =3D btf->start_id;
> > +       }
> >=20
> > -       if (kind =3D=3D BTF_KIND_UNKN || !strcmp(type_name, "void"))
> > +       if (kind =3D=3D BTF_KIND_UNKN || strcmp(type_name, "void") =3D=
=3D 0)
> >                 return 0;
> >=20
> > -       for (i =3D start_id; i < nr_types; i++) {
> > -               const struct btf_type *t =3D btf__type_by_id(btf, i);
> > -               const char *name;
> > +       if (btf->sorted_start_id > 0 && type_name[0]) {
> > +               __s32 end_id =3D btf__type_cnt(btf) - 1;
> > +
> > +               /* skip anonymous types */
> > +               start_id =3D max(start_id, btf->sorted_start_id);
>=20
> can sorted_start_id ever be smaller than start_id?

sorted_start_id can be zero, at two callsites for this function
start_id is passed as btf->start_id and 1.

>=20
> > +               idx =3D btf_find_by_name_bsearch(btf, type_name, start_=
id, end_id);
>=20
> is there ever a time when btf_find_by_name_bsearch() will work with
> different start_id and end_id? why is this not done inside the
> btf_find_by_name_bsearch()?
>=20

[...]

