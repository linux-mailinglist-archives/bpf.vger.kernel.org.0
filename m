Return-Path: <bpf+bounces-31090-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2317A8D6EBF
	for <lists+bpf@lfdr.de>; Sat,  1 Jun 2024 10:04:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 549AE1C23EC4
	for <lists+bpf@lfdr.de>; Sat,  1 Jun 2024 08:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBE6C18C36;
	Sat,  1 Jun 2024 08:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B3W2W45D"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF711BDD0
	for <bpf@vger.kernel.org>; Sat,  1 Jun 2024 08:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717229057; cv=none; b=sbMNWXtRRYbA7yjRIIjqUZKBCR+k9IU5I+PK37Gaub9elhFrVHmv3M4ySJmpV+awJcKQzfuK7N7SfKNwpOgxzgWeST7JjtdM9fvE+/WH7jRE/7gduzl/3fmzZjDlATaLHkIBEt2j4YtZKYKyEkWD3XZQVpH5TAWiAZDMoGxh6jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717229057; c=relaxed/simple;
	bh=K15bat7NiK+H2pU4gGvvbZSHAqH1V2V6BljazMzKUSQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=avuZk//7PcRLYVnAP5iddkvgI7HymUDCrMTffL/BhLBrKt8kobHfDVpg4lpFDlLaNevQe51ByP4jEHxnclxQ9oVn62azA+BJmzPIPfvarhN5S84n1ff0Sd5xYVHz6Jlf+jxevrbR4AaS+wcbDcUy50QhbmsOHOOl9KKD/o95mFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B3W2W45D; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6f6a045d476so2317844b3a.1
        for <bpf@vger.kernel.org>; Sat, 01 Jun 2024 01:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717229055; x=1717833855; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=50WTIsF16HPmDMZ0pC3YAsvEIaTc7msvf9jMCC50aq0=;
        b=B3W2W45Dy+vRd5Cax0eZjXgjKakuohXgGgKGC5i05URizLopxgdNahtSIoyts3fW0n
         diNC3RlcjOsjNYRERXRCl4yhU33EU9Q8/UWu/bQafCvUVw9dnqaQSAEDiL9g/OZE3gpR
         tGQs8QTc9ujwNpxevDjVW38hpBynRuO7HJUGSjkUJQwx1LL8FV8mVcVYnLoN1BlCblVi
         ud1/5j5yzl0e5vbqQ8KXlmMXfWVUAT3wRsBTcdoqvT7iwMEI70IANUDw+JxH9hXRaY0N
         DqnSvK9YyyE5MdrfSMY7vdPSvVygW86u9ipEzIAcrS6QA3BRkA5z9AD80WCcA1+2oLuz
         PRaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717229055; x=1717833855;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=50WTIsF16HPmDMZ0pC3YAsvEIaTc7msvf9jMCC50aq0=;
        b=wK3xaXHHGEPJkYObJelNIYOkI2gjKamKpaZxnlocnu6EF0XEItL91WwG2gdsniqj3Z
         zd3AZSQlKsCbBIIQVE+YgOyFVCYuLOFTrss5pJWuVT/KpO2SPEzechSz/+zoGBWkyg4B
         LH19E/tdskOPApDpmpg8sCVvE268KSY6R8S/oo5xbQoL/MZKgzHOuCZfT6/KvboALpTj
         mopCndTsWIgCEFFBT5Ar7vio94lAOn1tKqx4HlEwgsIUHluD89lVyG0h/67jmQtoTOv/
         qGspe///9vL62ibVYVh1gZA3vePGytvZa/BvQuqkkBcW/tDOfpkg59aNuZydzFANcxgE
         bciw==
X-Forwarded-Encrypted: i=1; AJvYcCVjecarvh0GNGRiueg5EtEePx3salDXLSbssPGz4eCbPUo+6Rk51ig48bJDhmHRkE7ftv7CRfQYPyk+NRrdPjRxsLqz
X-Gm-Message-State: AOJu0Yzsp89Y6t1qPj7skhY2vLaWGrUdDUV4cjzdxUcbvhLtuTwanrCW
	KrTIYtSpJ/v4zrqr5nWOVlsYhJwqz0FRHvZ+dxmBL3M5271Cv/x+
X-Google-Smtp-Source: AGHT+IFcwpDd2NuHaL1i4GK8xUdZFjnLBkYVQWihPPB9Vl2BMCuMWluoLd+1s2Ij+o43MiTXyfKwWg==
X-Received: by 2002:a05:6a20:da95:b0:1b2:565a:4d1c with SMTP id adf61e73a8af0-1b26f137689mr5164527637.24.1717229055233;
        Sat, 01 Jun 2024 01:04:15 -0700 (PDT)
Received: from ?IPv6:2604:3d08:6979:1160::3424? ([2604:3d08:6979:1160::3424])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c1a777fabfsm4671639a91.32.2024.06.01.01.04.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Jun 2024 01:04:14 -0700 (PDT)
Message-ID: <55cad21f33a6e1c77d4001a20400e7a4f879b609.camel@gmail.com>
Subject: Re: [PATCH v5 bpf-next 5/9] libbpf: make btf_parse_elf process
 .BTF.base transparently
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Alan Maguire
	 <alan.maguire@oracle.com>
Cc: andrii@kernel.org, jolsa@kernel.org, acme@redhat.com,
 quentin@isovalent.com,  mykolal@fb.com, ast@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev,  song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com,  kpsingh@kernel.org,
 sdf@google.com, haoluo@google.com, houtao1@huawei.com, 
 bpf@vger.kernel.org, masahiroy@kernel.org, mcgrof@kernel.org,
 nathan@kernel.org
Date: Sat, 01 Jun 2024 01:04:13 -0700
In-Reply-To: <CAEf4BzYrgm8N+scUtTyN2Nx8SRbandTE8n=o6OkPRYYyTd2K_Q@mail.gmail.com>
References: <20240528122408.3154936-1-alan.maguire@oracle.com>
	 <20240528122408.3154936-6-alan.maguire@oracle.com>
	 <CAEf4BzYrgm8N+scUtTyN2Nx8SRbandTE8n=o6OkPRYYyTd2K_Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-05-31 at 11:57 -0700, Andrii Nakryiko wrote:

[...]

> > @@ -1084,53 +1089,38 @@ struct btf *btf__new_split(const void *data, __=
u32 size, struct btf *base_btf)
> >         return libbpf_ptr(btf_new(data, size, base_btf));
> >  }
> >=20
> > -static struct btf *btf_parse_elf(const char *path, struct btf *base_bt=
f,
> > -                                struct btf_ext **btf_ext)
> > +struct elf_sections_info {
> > +       Elf_Data *btf_data;
> > +       Elf_Data *btf_ext_data;
> > +       Elf_Data *btf_base_data;
>=20
> bikeshedding time: elf_sections_info -> btf_elf_data (or
> btf_elf_secs), btf_data -> btf, btf_ext_data -> btf_ext, btf_base_data
> -> btf_base ?

As you and Alan see fit.

[...]

> > -       btf =3D btf_new(btf_data->d_buf, btf_data->d_size, base_btf);
> > +
> > +       if (info.btf_base_data) {
> > +               distilled_base_btf =3D btf_new(info.btf_base_data->d_bu=
f, info.btf_base_data->d_size,
> > +                                            NULL);
>=20
> with the above bikeshedding suggestion, and distilled_base_btf ->
> dist_base_btf, let's get it to be a less verbose single-line statement
>=20
> > +               err =3D libbpf_get_error(distilled_base_btf);
>=20
> boo to using libbpf_get_error() in new code. btf_new() is internal, so
> IS_ERR()/PTR_ERR(), please

Noted.

[...]

> > +       if (distilled_base_btf)
> > +               btf->owns_base =3D true;
>=20
> should we reset this to false when changing base in btf__relocate()?

It should, good catch!

[...]

