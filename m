Return-Path: <bpf+bounces-54833-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17DE3A73EFA
	for <lists+bpf@lfdr.de>; Thu, 27 Mar 2025 20:47:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B21263BF05F
	for <lists+bpf@lfdr.de>; Thu, 27 Mar 2025 19:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8369C21A436;
	Thu, 27 Mar 2025 19:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jycOJygg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 263CF1C7019
	for <bpf@vger.kernel.org>; Thu, 27 Mar 2025 19:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743104404; cv=none; b=BDiCMZg72J7i6NGDwcEIqrlVpU5EQ07ABWud41QEn8/6X+6ggbyOnFzWbPXsq1SryHAt82zCrQ3BewPnOBZveTLwhIpIYNl1V5F9ZRlG+4MlcMPM7J9cIJWXSQCAQY+N2++IzmhzrVxrgNn5WaMepwpqqaHH9oCND9UUMxNPbr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743104404; c=relaxed/simple;
	bh=JQvZdsq+FrsgXgf1x+XuoMpMUmNwO4Ql/11UA0ptrsw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lyda+LSKmoc6PPk46WbkFGJZ4QyEl6wWamkIR1qtucX5f0ZwlTkSNPZww7Ek42x5xH+0dJfKhZB5O2K7qqf9qByzlQU29D74bmdwG/j4rqIWf+EL/bUUK0DJcXArW5sxCuaBQRBCRhhKgN6T0nzdmEvO1jNcFEYmUmKpBi1/pSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jycOJygg; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-227a8cdd241so34060135ad.3
        for <bpf@vger.kernel.org>; Thu, 27 Mar 2025 12:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743104401; x=1743709201; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tYSrOwtaYfq/mC5cRF7qT5Eh2CvXlTNDlKv7RMkJDiM=;
        b=jycOJyggS5lbaQ0B+PYRTxL7qn6Y78c85CHjIoJmbsUl+5BSvhUU6ght0wci0Wvl0H
         jsBmOlUeJZS7u+LLJhQQ984Fw7XJosLEhhbMIwdlVNmCDztTczeyhnezij+L8yAnyaRF
         23hGngzr/obdva14KdbMn0o63FRoW0JWtfS+QTvGtx6giQE2COito5U7w9e5zzfglnbv
         aEySYDTTgPJ9bu1mR07gIQyzp9S1VIx5Y6y4FRB8R/wHBdifOonOqwttfnWmV8QnyYBS
         Xl4XY90YfWYDD6RUlJuYD5h//nKrhNJpRxcjitqihgfvfZ2kCKjqgGSWn5ZwSng0ZILT
         rUZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743104401; x=1743709201;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tYSrOwtaYfq/mC5cRF7qT5Eh2CvXlTNDlKv7RMkJDiM=;
        b=QApuXWtPeYz2YD8OIn7Sr2RhyK5YtsKrFCY04dnslJtj73b7uTNyE89cq0ywcshRz9
         eUn92Kg57WJ2hXMMdmYkVNPER8mFy8mMaNhe1lObyryNFlOjHrm9al7We/0+CC1+gAjW
         jCAAKUOEuuMlKxwVj4KGsSqSVvZddSM1WGse2rJtW8oJ9ZX9QADErwRELYHxKLpla3Yx
         lh129vsT98kV82qnSpb5Q6ABzhBsmMwwNq2IOv55nxcR5MZLk1o6Y/baSNUf6/Of0QtT
         YB2fwFls2FA0XINd72SClMynbQgJ8ufzyfZ9+w3EqNQByArWRz4KtUnKMh1tVurFwwDd
         UDTg==
X-Forwarded-Encrypted: i=1; AJvYcCU7GPECHV5x165YsK77G+Vbkkky34v7UXSv0nsQ9VJcB++rPSLl52ksX+ssouSBq2aV7mc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4s5wNecLpeXDLqXHHZ3roUfmDnR2CkoPGloiv6dQlvMCc86Fk
	30x+ZFON3VIs535yFLAna7+VmWZfATdDYZzgiWU43pKBTkGn80v2
X-Gm-Gg: ASbGnctHmpHxMvPvFRvkxd224Vn+SiccTq/MC/UrZyHBXjh3lJXXOWFFc5nclBsnvhZ
	LJx4kLL9j2yHtot/F05rMZbfJcasSlensMP4pUcCRRlC1CeCpCGNm+/ZP3NFioL6CQ8HHUZ0rFc
	zlPN+uRWreWrwHrZYFbMpLlEaT8Fx0S3p/69ver/1gzdznhQZQo3KeG7vpXJldCr+pMyWiKMHQk
	o7G4mpb0Om/miu+PYG+WJ/icSfKuPUMlE1ZDbEPu6ixrVndgtnCduZpDHdxdTWsYlRXtD7vDzb+
	SZXGvtcHuQPvrauUM/LgrgcSp7xjgyVwoluFy49R
X-Google-Smtp-Source: AGHT+IFuZHx5xZr2QsxlMY5be3uk7CoLIWgMMDsdC2LzJ5s4euIn+H/H9OJvN3Ke68rtJjOAhWsk5w==
X-Received: by 2002:a17:902:ecd1:b0:220:cd9a:a167 with SMTP id d9443c01a7336-228048833a2mr68833835ad.4.1743104401172;
        Thu, 27 Mar 2025 12:40:01 -0700 (PDT)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73970e22319sm225172b3a.44.2025.03.27.12.40.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Mar 2025 12:40:00 -0700 (PDT)
Message-ID: <d61ff86c079461d8a4885638cead067290e148e3.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2] selftests/bpf: support struct/union presets
 in veristat
From: Eduard Zingerman <eddyz87@gmail.com>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org, 
	ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com, 
	kernel-team@meta.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Date: Thu, 27 Mar 2025 12:39:57 -0700
In-Reply-To: <20250324123455.35888-1-mykyta.yatsenko5@gmail.com>
References: <20250324123455.35888-1-mykyta.yatsenko5@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-03-24 at 12:34 +0000, Mykyta Yatsenko wrote:
> From: Mykyta Yatsenko <yatsenko@meta.com>
>=20
> Extend commit e3c9abd0d14b ("selftests/bpf: Implement setting global
> variables in veristat") to support applying presets to members of
> the global structs or unions in veristat.
> For example:
> ```
> ./veristat set_global_vars.bpf.o  -G "union1.struct3.var_u8_h =3D 0xBB"
> ```
>=20
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---

Thank you for addressing comments from my previous review.
Sorry for the delay, didn't look at patches while travelling.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

> +static int adjust_var_secinfo_tok(char **name_tok, const struct btf *btf=
,
> +				  const struct btf_type *t, struct btf_var_secinfo *sinfo)
> +{
> +	char *name =3D strtok_r(NULL, ".", name_tok);
> +	const struct btf_type *member_type;
> +	const struct btf_member *member;
> +	int member_tid;
> +	__u32 anon_offset =3D 0;
> +
> +	if (!name)
> +		return 0;
> +
> +	member =3D btf_find_member(btf, t, name, &anon_offset);
> +	if (IS_ERR(member)) {
> +		fprintf(stderr, "Could not find member %s\n", name);
> +		return -EINVAL;
> +	}
> +
> +	member_tid =3D btf__resolve_type(btf, member->type);
> +	member_type =3D btf__type_by_id(btf, member_tid);
> +
> +	if (btf_kflag(t)) {
> +		fprintf(stderr, "Bitfield presets are not supported %s\n", name);
> +		return -EINVAL;
> +	}
> +	sinfo->offset +=3D (member->offset + anon_offset) / 8;
> +	sinfo->size =3D member_type->size;
> +	sinfo->type =3D member_tid;

Nit: I'd push this assignment down to `btf_find_member` and avoid
     `&anon_offset` parameter. It would be easier to read this way,
     as all offset manipulations would be in one place.

> +
> +	return adjust_var_secinfo_tok(name_tok, btf, member_type, sinfo);
> +}
> +
> +static int adjust_var_secinfo(struct btf *btf, const struct btf_type *t,
> +			      struct btf_var_secinfo *sinfo, const char *var)
> +{
> +	char expr[256], *saveptr;
> +	const struct btf_type *base_type;
> +	int err;
> +
> +	base_type =3D btf__type_by_id(btf, btf__resolve_type(btf, t->type));
> +	strncpy(expr, var, 256);

Nit: strncpy does not null terminate if strlen(src) =3D=3D N.

> +	strtok_r(expr, ".", &saveptr);
> +	err =3D adjust_var_secinfo_tok(&saveptr, btf, base_type, sinfo);
> +	if (err)
> +		return err;
> +
> +	return 0;
> +}
> +
> +static int set_global_var(struct bpf_object *obj, struct btf *btf,
>  			  struct bpf_map *map, struct btf_var_secinfo *sinfo,
>  			  struct var_preset *preset)
>  {

[...]


