Return-Path: <bpf+bounces-29517-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2C8E8C2A68
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 21:15:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BA24281F52
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 19:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DAF94F5ED;
	Fri, 10 May 2024 19:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T1dte88C"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7192F50243
	for <bpf@vger.kernel.org>; Fri, 10 May 2024 19:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715368496; cv=none; b=GYPvSLDoVMrfbW19tEXKIEeUrWqOccirtXHhF4tcMotNbd44KE7YFa/UC8+e1HZFMFsf0a4nMAEgiE1YriaqwPCAjFz82JCJ3ydMXm8bHNAOhWrr/aStxDt7KqubuOGdrPaeFZVMutLwuxmzQOqyeSXueZ96Xk4oxjFmoXqO7mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715368496; c=relaxed/simple;
	bh=jq2vHCB3aQz7qfvymqJ1erbrHfI7IZkWKjCUNRe1cxk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=daoHPodl+Cyx1nLC0kOk5OeGnuXddNU19JuEr3mrfP4tG0o3TW0diDebMeFbjtHfkke/f7WyQYmuipIcLF9bTt6qM78PHDebMJNUBeQYKpak1P6pGGBYrBnQLomKoBMpi2xYiKur3yoPx8Fn3HSs9QnDgpH8AtXahKjG6/8hhFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T1dte88C; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1edf506b216so18114845ad.2
        for <bpf@vger.kernel.org>; Fri, 10 May 2024 12:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715368495; x=1715973295; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/b76JURsJN4Nap1Hi981zV/WlmF0U6bYtJygU8YbYYY=;
        b=T1dte88C7gcP/a2N3tYoIoRsz7r8wonKRDq7yLUzegXKhmcRD/Y+i/oUvVukkFQ6bX
         srBczJKfWo+yC7tboqC+DYWpu7x45YWT2wHa+vkkYLNSjjg7JDys7c162mKcil5cCQXA
         Y0V3UpsUtDrkZcZ8oNzu/08v2gfH+yazX66MQXiKaofq9gFT89UeUAvj2wcrf5O0eK3I
         vC0ZcWkBOpItEPuobiixteryi68CIk00zGi45Q6Jz1wtlqqVKxDa5gjDh3fTJGcJUJFB
         hEmtCyNk8cJ2QLEoSQdv0NW0f0pRL05ueR5tIEa2NmPXyijziGu7zx8WC4shUlrP1XuL
         yitA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715368495; x=1715973295;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/b76JURsJN4Nap1Hi981zV/WlmF0U6bYtJygU8YbYYY=;
        b=TCetB6JKZWzE/xEGMg2e4wHZ91p9iQiY0TOT73d7nR1m02GhC+O9ITIcs5vcHOERnm
         B9F4F3RPDCE5K4YkTyC0rh5l4GuJgao0M8KBUB3fSVcTA4TaEMEm1irzu8ADvh4TJPjz
         nZoCMkRDzRnC3zQmfHQznT4Y9u/FVqhFsU0Ab3ACMHYUSJHq3J9dXl3ygWqBVgmu5Ojz
         mIS82a5PptxZz++qk4LGFaxU1WnD3TyFexief9pqQBrfyR5o5E5OIHWX7zz/7Qj/BriM
         wMRw2HogCkl6froT5uzJWr4nBIYqg/DbxM4ngwaZqwh+F7DWQPOqYS4rmlUySXlvCTLw
         P7ng==
X-Forwarded-Encrypted: i=1; AJvYcCV7bSIR2EiFoPIO6lWP4kfPhqjqdzqltG6M9unFC5h59ETtDeK6g1+ZfE0x+NbDeGrggoWC8dC4gMb3gOkk0rA7xsX/
X-Gm-Message-State: AOJu0YxdYJR42ytbTUXE01FgDM4TnuGiD5vnivcKHGI+TU/o3OomIQ27
	GO19v2PIZN1HNmmVfLOpCOMpaVdhbrPpUCylaysNCT0SAZU+XDjL
X-Google-Smtp-Source: AGHT+IFvLS6h4WneZKetlqw1VOjXnvM94vMc+e9QFRwK3AIcJF1D/U0Q9vdlQGlSsuYcpBp5uf5/7w==
X-Received: by 2002:a17:903:1250:b0:1ea:26bf:928 with SMTP id d9443c01a7336-1ef44161501mr43167495ad.50.1715368494536;
        Fri, 10 May 2024 12:14:54 -0700 (PDT)
Received: from ?IPv6:2604:3d08:6979:1160::3424? ([2604:3d08:6979:1160::3424])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0c139465sm35789105ad.269.2024.05.10.12.14.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 12:14:54 -0700 (PDT)
Message-ID: <cdc19260a1d1e37649f64bab731c21cb4e5422ff.camel@gmail.com>
Subject: Re: [PATCH v3 bpf-next 01/11] libbpf: add btf__distill_base()
 creating split BTF with distilled base BTF
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alan Maguire <alan.maguire@oracle.com>, andrii@kernel.org,
 jolsa@kernel.org,  acme@redhat.com, quentin@isovalent.com
Cc: mykolal@fb.com, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@linux.dev,  song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com,  kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, houtao1@huawei.com,  bpf@vger.kernel.org,
 masahiroy@kernel.org, mcgrof@kernel.org, nathan@kernel.org
Date: Fri, 10 May 2024 12:14:52 -0700
In-Reply-To: <20240510103052.850012-2-alan.maguire@oracle.com>
References: <20240510103052.850012-1-alan.maguire@oracle.com>
	 <20240510103052.850012-2-alan.maguire@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-05-10 at 11:30 +0100, Alan Maguire wrote:

[...]

Hi Alan,

A two minor notes below, otherwise I think this looks good.

[...]

> +static int btf_add_distilled_type_ids(__u32 *id, void *ctx)
> +{
> +	struct btf_distill *dist =3D ctx;
> +	struct btf_type *t =3D btf_type_by_id(dist->pipe.src, *id);
> +	int err;
> +
> +	if (!*id)
> +		return 0;
> +	/* split BTF id, not needed */
> +	if (*id >=3D dist->split_start_id)
> +		return 0;
> +	/* already added ? */
> +	if (BTF_ID(dist->ids[*id]) > 0)
> +		return 0;
> +
> +	/* only a subset of base BTF types should be referenced from split
> +	 * BTF; ensure nothing unexpected is referenced.
> +	 */
> +	switch (btf_kind(t)) {
> +	case BTF_KIND_INT:
> +	case BTF_KIND_FLOAT:
> +	case BTF_KIND_FWD:
> +	case BTF_KIND_ARRAY:
> +	case BTF_KIND_STRUCT:
> +	case BTF_KIND_UNION:
> +	case BTF_KIND_TYPEDEF:
> +	case BTF_KIND_ENUM:
> +	case BTF_KIND_ENUM64:
> +	case BTF_KIND_PTR:
> +	case BTF_KIND_CONST:
> +	case BTF_KIND_RESTRICT:
> +	case BTF_KIND_VOLATILE:
> +	case BTF_KIND_FUNC_PROTO:

I think BTF_KIND_TYPE_TAG should be in this list.

> +		dist->ids[*id] |=3D *id;
> +		break;
> +	default:
> +		pr_warn("unexpected reference to base type[%u] of kind [%u] when creat=
ing distilled base BTF.\n",
> +			*id, btf_kind(t));
> +		return -EINVAL;
> +	}

[...]

> +static int btf_add_distilled_types(struct btf_distill *dist)
> +{
> +	bool adding_to_base =3D dist->pipe.dst->start_id =3D=3D 1;
> +	int id =3D btf__type_cnt(dist->pipe.dst);
> +	struct btf_type *t;
> +	int i, err =3D 0;
> +
> +	/* Add types for each of the required references to either distilled
> +	 * base or split BTF, depending on type characteristics.
> +	 */
> +	for (i =3D 1; i < dist->split_start_id; i++) {
> +		const char *name;
> +		int kind;
> +
> +		if (!BTF_ID(dist->ids[i]))
> +			continue;
> +		t =3D btf_type_by_id(dist->pipe.src, i);
> +		kind =3D btf_kind(t);
> +		name =3D btf__name_by_offset(dist->pipe.src, t->name_off);
> +
> +		/* Named int, float, fwd struct, union, enum[64] are added to
> +		 * base; everything else is added to split BTF.
> +		 */
> +		switch (kind) {
> +		case BTF_KIND_INT:
> +		case BTF_KIND_FLOAT:
> +		case BTF_KIND_FWD:
> +		case BTF_KIND_STRUCT:
> +		case BTF_KIND_UNION:
> +		case BTF_KIND_ENUM:
> +		case BTF_KIND_ENUM64:
> +			if ((adding_to_base && !t->name_off) || (!adding_to_base && t->name_o=
ff))
> +				continue;
> +			break;
> +		default:
> +			if (adding_to_base)
> +				continue;
> +			break;
> +		}
> +		if (dist->ids[i] & BTF_EMBEDDED_COMPOSITE) {
> +			/* If a named struct/union in base BTF is referenced as a type
> +			 * in split BTF without use of a pointer - i.e. as an embedded
> +			 * struct/union - add an empty struct/union preserving size
> +			 * since size must be consistent when relocating split and
> +			 * possibly changed base BTF.
> +			 */
> +			err =3D btf_add_composite(dist->pipe.dst, kind, name, t->size);
> +		} else if (btf_is_eligible_named_fwd(t)) {
> +			/* If not embedded, use a fwd for named struct/unions since we
> +			 * can match via name without any other details.
> +			 */
> +			switch (kind) {
> +			case BTF_KIND_STRUCT:
> +				err =3D btf__add_fwd(dist->pipe.dst, name, BTF_FWD_STRUCT);
> +				break;
> +			case BTF_KIND_UNION:
> +				err =3D btf__add_fwd(dist->pipe.dst, name, BTF_FWD_UNION);
> +				break;
> +			case BTF_KIND_ENUM:
> +				err =3D btf__add_enum(dist->pipe.dst, name, sizeof(int));

I think that the size of the enum should be read from base BTF.
When inspecting BTF generated for selftests kernel config there
are 14 enums with size=3D1.

> +				break;
> +			case BTF_KIND_ENUM64:
> +				err =3D btf__add_enum(dist->pipe.dst, name, sizeof(__u64));
> +				break;
> +			default:
> +				pr_warn("unexpected kind [%u] when creating distilled base BTF.\n",
> +					btf_kind(t));
> +				return -EINVAL;
> +			}
> +		} else {
> +			err =3D btf_add_type(&dist->pipe, t);
> +		}
> +		if (err < 0)
> +			break;
> +		dist->ids[i] =3D id++;
> +	}
> +	return err;
> +}

[...]

