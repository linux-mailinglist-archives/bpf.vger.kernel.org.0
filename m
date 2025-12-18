Return-Path: <bpf+bounces-77053-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CB2ECCDD50
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 23:36:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1369130191AB
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 22:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9993C2E62D9;
	Thu, 18 Dec 2025 22:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jkXHxPdy"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D6727F16C
	for <bpf@vger.kernel.org>; Thu, 18 Dec 2025 22:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766097194; cv=none; b=Tzj9BVelbr8/kfX7NTdqn0i3U8ukPv0KP5zI7mSZlRJX3kiqW4IJkW4B3+ML2vX5iPqBdrxUQUMD7RmWngyqOlNikp7LNiOCxa3oXMkzX21m1+OaheAflkhXC/ZnkhMFmmXNi+BzW03VBsldZM+2wHHS0FNS4ZfUeUyCkr4lPe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766097194; c=relaxed/simple;
	bh=ZumqcG7cU/czmEClLPgTNxkMEDZt1II04YrHoLYqR3g=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dHnJwKOKnEMX+wbVbHUUq3+wRazvwTDLNk8+5Uciiwp5WkWLFkbmy9nMd3zPWYM6CjVcyh4TAU2N0qnOnPBF2OerhqGuW5y/GTeiTIPhi+8fYjSFsvaZAifBYVOYWJg0O5qz7ejklxhC/iGTsf6GWqT1LHvpviRiVcyWpZCrewE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jkXHxPdy; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-bc29d64b39dso629967a12.3
        for <bpf@vger.kernel.org>; Thu, 18 Dec 2025 14:33:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766097192; x=1766701992; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tJ5XqIAtHXY0TlGMu0gwIU/G7ilWxAU9MmyHm3Ol2nU=;
        b=jkXHxPdybFPirCU6SukRPFDhvZNyujzkaFxfJr53Cj4Je679wdPVo5H1GclnvUdK6r
         +EFbh9fui9q/B2cKP/p8XSIleys+sYqnKxS8zkxEee+ub8/USdvJgdAayOxXJi/F+kWu
         9mVzgws/W+rX8fgIGzqMPMhfDtGBMqXSm1ffvejhzTZcz+ZUntTD5F+Y9+mXV318KR/O
         LbGeTNJyz2JzxUP4kklQ0PeG4LEmlq7XIXN1zpIZECLfqgaFoiNbsi89Soph+vIXbPHO
         IMhy1szZ9RMuovNuSzNSoXqwVkdSR5H2iicUKJUiuUFw/WZP8itx/0QSPyNpv+YSSEt2
         XPCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766097192; x=1766701992;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tJ5XqIAtHXY0TlGMu0gwIU/G7ilWxAU9MmyHm3Ol2nU=;
        b=QUi/9Suqd2aj+TbEBFHKTG3Lht8V++g1aCDfLz1S1VSBMIRGwcCgZm9cakuKkSHAht
         6PvFSQhLBkBPo2V1NF7xK7zkprki1mqqygeqXXCVs1lvVkKA5lWVFcPplPAUW6D6synL
         B8qW7FzMavxbVZU+OAnvYgc8vTuivGeEjhjyqTvn0oG0+WrxUYDhq1kL493GuSMK/os0
         BIdcdeh4hp2cVeKrDYL2FK6bCgwrDxo6QCxF/nLQXJD6fB/prii+5KzYbY0tITHbJa0c
         rQVgMMXU2B0YflbehiVu72Tli4AtVa7eCV6SOOkjwh1W0qYLl5+0oW9Q/ra3OLJRjG8E
         7iZw==
X-Forwarded-Encrypted: i=1; AJvYcCWu8+7jVg7+tiTim/ovzcfo5Ilg/FlUKzwxDQGnXCa4v/TvxrrVpDAU41ScJvSog63B5r4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3jKjNvnhvZhi/uJxP0C/gW5UEzgEhaV4DopCYamwYEcmKdVc2
	F4RT4AhFwI8nOUY9nIItwhMnwnIuP0j4r9QrvbitxqJg51ZExdqWV+lR
X-Gm-Gg: AY/fxX7jFfZVIfCYZky32MzVJFIShxjBOkz0PhMh6Pp8ccBy7yVutFzksRO8daNrP9e
	HWdt9bjo5trcBFDhnPr8Vy4pOa58F+1Rto3pMRfrUIZuV7l6QOFOvJNa3+QNGxVIDBU1xQzUQPl
	9aluF9/VLXkeBGEY65MbEYsJxIP68qfVTRtrskMPe+1ypi8wAjFZEc1yD/EtWs9iGXjKnmEVOQq
	ppHRGttUkk/SRXH8cmULjDcurTnrb0ol0ySSJCFRgjEIEcRNd8v3syzzkfcgSUmif53nqPpqQED
	g0IlTm2M0Yos75MfzJn1+LpgcQxgB/T9Q7twXHYKM1CnVQHFjDuPLGSlrkJLy8VK8n9Uif1R3Cw
	Cebxcua/4fccRSYn4/hdRWHlediAiurUXypVqQ2ksajKHExzOBRPezHDCll6SvBUqBxjr/MJezL
	J/zW7gTXpn1OVPVbwo4hA3PVy0mhrJtbjMXVpz5N5d3rGxxZsit2FhU3pxoA==
X-Google-Smtp-Source: AGHT+IESXLiLN/g2wjoS3cjrW0/hs97XSBaGKcOu7zDD9/dCOWiCiX1ehKzz937/rL/MV0g2HjrxzQ==
X-Received: by 2002:a05:7022:793:b0:11b:9386:8257 with SMTP id a92af1059eb24-12172302180mr659836c88.44.1766097191827;
        Thu, 18 Dec 2025 14:33:11 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:4779:aa2b:e8ff:52c4? ([2620:10d:c090:500::5:3eff])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121724dd7f5sm1999886c88.5.2025.12.18.14.33.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 14:33:11 -0800 (PST)
Message-ID: <8fce5fd3524dc58b11250104837e241aa3f25420.camel@gmail.com>
Subject: Re: [PATCH bpf-next v10 11/13] libbpf: Add btf_is_sorted and
 btf_sorted_start_id helpers to refactor the code
From: Eduard Zingerman <eddyz87@gmail.com>
To: Donglin Peng <dolinux.peng@gmail.com>, ast@kernel.org, 
	andrii.nakryiko@gmail.com
Cc: zhangxiaoqin@xiaomi.com, ihor.solodrai@linux.dev, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, pengdonglin
	 <pengdonglin@xiaomi.com>, Alan Maguire <alan.maguire@oracle.com>
Date: Thu, 18 Dec 2025 14:33:10 -0800
In-Reply-To: <20251218113051.455293-12-dolinux.peng@gmail.com>
References: <20251218113051.455293-1-dolinux.peng@gmail.com>
	 <20251218113051.455293-12-dolinux.peng@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-12-18 at 19:30 +0800, Donglin Peng wrote:
> From: pengdonglin <pengdonglin@xiaomi.com>
>=20
> Introduce two new helper functions to clarify the code and no
> functional changes are introduced.
>=20
> Cc: Eduard Zingerman <eddyz87@gmail.com>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> Cc: Alan Maguire <alan.maguire@oracle.com>
> Cc: Ihor Solodrai <ihor.solodrai@linux.dev>
> Cc: Xiaoqin Zhang <zhangxiaoqin@xiaomi.com>
> Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
> ---
>  tools/lib/bpf/btf.c             | 14 ++++++++++++--
>  tools/lib/bpf/libbpf_internal.h |  2 ++
>  2 files changed, 14 insertions(+), 2 deletions(-)
>=20
> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> index b5b0898d033d..571b72bd90b5 100644
> --- a/tools/lib/bpf/btf.c
> +++ b/tools/lib/bpf/btf.c
> @@ -626,6 +626,16 @@ const struct btf *btf__base_btf(const struct btf *bt=
f)
>  	return btf->base_btf;
>  }
> =20
> +int btf_sorted_start_id(const struct btf *btf)
> +{
> +	return btf->sorted_start_id;
> +}

Having this function declared differently in kernel and in libbpf is a
bit confusing. Is it needed in libbpf at all?

> +bool btf_is_sorted(const struct btf *btf)
> +{
> +	return btf->sorted_start_id > 0;
> +}
> +

Please squash this with the first btf_find_by_name_kind() change.

>  /* internal helper returning non-const pointer to a type */
>  struct btf_type *btf_type_by_id(const struct btf *btf, __u32 type_id)
>  {
> @@ -976,11 +986,11 @@ static __s32 btf_find_by_name_kind(const struct btf=
 *btf, int start_id,
>  	if (kind =3D=3D BTF_KIND_UNKN || strcmp(type_name, "void") =3D=3D 0)
>  		return 0;
> =20
> -	if (btf->sorted_start_id > 0 && type_name[0]) {
> +	if (btf_is_sorted(btf) && type_name[0]) {
>  		__s32 end_id =3D btf__type_cnt(btf) - 1;
> =20
>  		/* skip anonymous types */
> -		start_id =3D max(start_id, btf->sorted_start_id);
> +		start_id =3D max(start_id, btf_sorted_start_id(btf));
>  		idx =3D btf_find_by_name_bsearch(btf, type_name, start_id, end_id);
>  		if (unlikely(idx < 0))
>  			return libbpf_err(-ENOENT);
> diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_inter=
nal.h
> index fc59b21b51b5..95e6848396b4 100644
> --- a/tools/lib/bpf/libbpf_internal.h
> +++ b/tools/lib/bpf/libbpf_internal.h
> @@ -250,6 +250,8 @@ const struct btf_type *skip_mods_and_typedefs(const s=
truct btf *btf, __u32 id, _
>  const struct btf_header *btf_header(const struct btf *btf);
>  void btf_set_base_btf(struct btf *btf, const struct btf *base_btf);
>  int btf_relocate(struct btf *btf, const struct btf *base_btf, __u32 **id=
_map);
> +int btf_sorted_start_id(const struct btf *btf);
> +bool btf_is_sorted(const struct btf *btf);
> =20
>  static inline enum btf_func_linkage btf_func_linkage(const struct btf_ty=
pe *t)
>  {

