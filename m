Return-Path: <bpf+bounces-76793-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D42D1CC5808
	for <lists+bpf@lfdr.de>; Wed, 17 Dec 2025 00:40:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8EB3F303EF47
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 23:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F0F533FE0A;
	Tue, 16 Dec 2025 23:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A2N0ZXLU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B522630E0C5
	for <bpf@vger.kernel.org>; Tue, 16 Dec 2025 23:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765928312; cv=none; b=MP0wykyIpu1o2TrK7/t3tOSJATAimAfXUkq+36JFpnUEEy8d2zN9v8YsVTjFZEPp9Qts3KJGQVSzWakZteyHqeAax2ToCDnHNtsXwAphm284HCtDj6CgB12453XQgkXg9PqOOwjb4IWU+MnA6oXGTs/lPbJrsGFi0bG+rOX1+EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765928312; c=relaxed/simple;
	bh=AdW0f66WScMl4TLSsRL6ZvXBYMpAxMuwrgD/u7bnqok=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=vFt+g9Na1Jrjxm0CYmknAraBpeguw5ZI+oCOt6yM/KlbFwHOTJxZPpE7SBxywwK/Kpn4pjNEW+5Ceaai7oW06ogwsTpxrXMPV8QW69Lui2k+gyiCTbRdTbpLqJzYPmiwXjGOPLrhrR1Vu0OydUO/x1DGCw64qUIhnnW9Fo92uCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A2N0ZXLU; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7bc0cd6a13aso20896b3a.0
        for <bpf@vger.kernel.org>; Tue, 16 Dec 2025 15:38:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765928310; x=1766533110; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=L9mPN7ZX3b0VVFpkw2VwIzJQTyCoyugmXEoolVBpW/k=;
        b=A2N0ZXLUlDW8VIgyacqd8vE6tkhAvVtvgqyNXaEOfl86hQu2eA5dM1MNShqk4Nyinf
         Aabn39FvZWdHgw10o6e0UFgTEsNjgqvIbOUa8VV6h5P/MhVzrhSUtyC4LU3TwT5VhW26
         eHG9EVyatuYD0J+t5a7uN6SIksF/b0dhS5MpsQdPxNvE+9HvZABJICw+etWEHCTPoR4B
         i4ldxsZJSBzTZyRK3HWLIJJgOfxaWOAy67dfdGvHMjaprSx030n422ak8lCg3G4LPQvG
         GUl8IJxmuWLUd10VytxVOUaArdEFkxLF6UHRVPjvHBkbBaB4YRmMSBGdmaC10Vc2NbIL
         YkYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765928310; x=1766533110;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L9mPN7ZX3b0VVFpkw2VwIzJQTyCoyugmXEoolVBpW/k=;
        b=Rxeqjx/uhWvctpiXabClfNG2H0GmBSLfca3X8LOm33F3GMmEWUKogNzz439bhuonHs
         ekovGyx0lsW+KifdvoKSi8Ks61fZvImlhFv9SEUF7pf8efSZGbgiJnlwvVnnNIyZtn5B
         HaVMLsXSF3MjavhRDdOqfYwkEgqC/R6Zy+gQ/pmD4BNWQSrV5YWfl8Fqs6ktZ2+r+vF1
         Vo69Wd4DIQU2BkOp+3k1tGLeo/DJqSBcLSX747/b44HARD2ODiK5FTrzL2AcgpjMidk9
         Pov6S6JgQmIB4uG+r2cLQRuZno9ROBDN4mxCNZXEwv5Y4szsqNqZi/7hjzX0MxSZZcd6
         SiDA==
X-Forwarded-Encrypted: i=1; AJvYcCULECu+Qmp5FW9XTt+6CZxIYyD7QjFlXcR31wh+rYhJ/wHcwW+NXtt5CFZLPkkLUfVUq0c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlAEBQEf3zDFND52l/jklyizUcENKNvRBqLC6D4OIYLWVdCh0P
	IGDYvM9HP5/K/GSONjcnpQhuaOJTL4reFXfXkQ+DLdCqv4LLF3x0mGDt
X-Gm-Gg: AY/fxX5XvbwgPqIHkajJTubYd1Pg8XZu6Ih35Azc8CRmu4s9MeOo8LKs34yjuP0C3N7
	nSyQMyfYyizkrtew5OsT2NZ+7vjFE/on0vqFxJjiVR4wjV6ifNoyc0/di5DcuwJZ5Ya2A4VBt5W
	k5JYi1BNEG3W9RWEg8AxhKl3FJ+XhWhf57jRkEjCu07XkYjX3mikxQWYmWZw+HhtqHYR/qAQTKu
	xnYmnm7rg1KUi90YoeR5wHyPbbZrfRQanhFRwWcd/OngNBxxcTgh25/FJHwqsfySvIf0I2V3zbe
	zDecHWkUJyRRa3KefFU0hIHDFjt44CtGg7iE5EMsG/yWmbfUIeJYxZThRm5woCSdK9NXyOGEIR5
	c91JMOE6LA1OSxsy/AXoLA1ues/JMDWJVxE6g2QyRhTQZhYHANEuB/90bSHT2UoZ0rf8dlCHRWt
	0WjyefS1qv8iToyz2Tt2g=
X-Google-Smtp-Source: AGHT+IELEQ9URSI73RnKJwejo8ZEhXb2+SrzYJ5UvV/Xx1bXEPoCY4qfNSKQQA4ImmEL1Rk21uZ/Ww==
X-Received: by 2002:a05:6a00:6c9b:b0:7b8:8d43:fcde with SMTP id d2e1a72fcca58-7f667931f55mr14184760b3a.8.1765928309910;
        Tue, 16 Dec 2025 15:38:29 -0800 (PST)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7fcbbbd89a1sm636312b3a.52.2025.12.16.15.38.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 15:38:29 -0800 (PST)
Message-ID: <cb0afb795b4dc8feae51985af71b7f8b1548826f.camel@gmail.com>
Subject: Re: [PATCH bpf-next v9 04/10] libbpf: Optimize type lookup with
 binary search for sorted BTF
From: Eduard Zingerman <eddyz87@gmail.com>
To: Donglin Peng <dolinux.peng@gmail.com>, ast@kernel.org, 
	andrii.nakryiko@gmail.com
Cc: zhangxiaoqin@xiaomi.com, ihor.solodrai@linux.dev, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, pengdonglin
	 <pengdonglin@xiaomi.com>, Alan Maguire <alan.maguire@oracle.com>
Date: Tue, 16 Dec 2025 15:38:26 -0800
In-Reply-To: <20251208062353.1702672-5-dolinux.peng@gmail.com>
References: <20251208062353.1702672-1-dolinux.peng@gmail.com>
	 <20251208062353.1702672-5-dolinux.peng@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-12-08 at 14:23 +0800, Donglin Peng wrote:

[...]

Lgtm, one question below.

>  static __s32 btf_find_by_name_kind(const struct btf *btf, int start_id,
>  				   const char *type_name, __u32 kind)
>  {
> -	__u32 i, nr_types =3D btf__type_cnt(btf);
> +	const struct btf_type *t;
> +	const char *tname;
> +	__s32 idx;
> +
> +	if (start_id < btf->start_id) {
> +		idx =3D btf_find_by_name_kind(btf->base_btf, start_id,
> +			type_name, kind);
> +		if (idx >=3D 0)
> +			return idx;
> +		start_id =3D btf->start_id;
> +	}
> =20
> -	if (kind =3D=3D BTF_KIND_UNKN || !strcmp(type_name, "void"))
> +	if (kind =3D=3D BTF_KIND_UNKN || strcmp(type_name, "void") =3D=3D 0)
>  		return 0;
> =20
> -	for (i =3D start_id; i < nr_types; i++) {
> -		const struct btf_type *t =3D btf__type_by_id(btf, i);
> -		const char *name;
> +	if (btf->sorted_start_id > 0) {
> +		__s32 end_id =3D btf__type_cnt(btf) - 1;
> +
> +		/* skip anonymous types */
> +		start_id =3D max(start_id, btf->sorted_start_id);
> +		idx =3D btf_find_by_name_bsearch(btf, type_name, start_id, end_id);
> +		if (unlikely(idx < 0))
> +			return libbpf_err(-ENOENT);
> +
> +		if (unlikely(kind =3D=3D -1))
> +			return idx;
> +
> +		t =3D btf_type_by_id(btf, idx);
> +		if (likely(BTF_INFO_KIND(t->info) =3D=3D kind))
> +			return idx;
> +
> +		for (idx++; idx <=3D end_id; idx++) {
> +			t =3D btf__type_by_id(btf, idx);
> +			tname =3D btf__str_by_offset(btf, t->name_off);
> +			if (strcmp(tname, type_name) !=3D 0)
> +				return libbpf_err(-ENOENT);
> +			if (btf_kind(t) =3D=3D kind)
                            ^^^^^^^^^^^^^^^^^^^
                Is kind !=3D -1 check missing here?

> +				return idx;
> +		}
> +	} else {
> +		__u32 i, total;
> =20
> -		if (btf_kind(t) !=3D kind)
> -			continue;
> -		name =3D btf__name_by_offset(btf, t->name_off);
> -		if (name && !strcmp(type_name, name))
> -			return i;
> +		total =3D btf__type_cnt(btf);
> +		for (i =3D start_id; i < total; i++) {
> +			t =3D btf_type_by_id(btf, i);
> +			if (kind !=3D -1 && btf_kind(t) !=3D kind)
> +				continue;
> +			tname =3D btf__str_by_offset(btf, t->name_off);
> +			if (tname && strcmp(tname, type_name) =3D=3D 0)

Nit: no need for `tname &&` part, as we found out.

> +				return i;
> +		}
>  	}
> =20
>  	return libbpf_err(-ENOENT);
>  }
> =20
> +/* the kind value of -1 indicates that kind matching should be skipped *=
/
> +__s32 btf__find_by_name(const struct btf *btf, const char *type_name)
> +{
> +	return btf_find_by_name_kind(btf, btf->start_id, type_name, -1);
> +}
> +
>  __s32 btf__find_by_name_kind_own(const struct btf *btf, const char *type=
_name,
>  				 __u32 kind)
>  {

[...]

