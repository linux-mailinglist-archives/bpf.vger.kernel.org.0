Return-Path: <bpf+bounces-28303-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A7678B82DE
	for <lists+bpf@lfdr.de>; Wed,  1 May 2024 01:06:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D65F92855D0
	for <lists+bpf@lfdr.de>; Tue, 30 Apr 2024 23:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D14B11A0B05;
	Tue, 30 Apr 2024 23:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F+d8Jm3J"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DEDE17BB15
	for <bpf@vger.kernel.org>; Tue, 30 Apr 2024 23:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714518388; cv=none; b=g89YTX+rHXyDa4Wace+Z4WXYHlIfcS8W3xV3tjQnkjM7k6dnlrZXYGofNwCDJZfVkME92bbNkZUzw1GnqnP3M3bL98BKHhaZp+g7y8pvjHfm/nf4LTxRaVMMvvLKXRDa+x56qnwSWUXxJr78ep13Sr3f2leMWPAX/j8VN4y4j5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714518388; c=relaxed/simple;
	bh=wJ8uo401jXzpZUreepaoNEzriXyVrR2X4lrzmowaz7I=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CjpPaaPsuK5Xm3VUGpSSLkZWAQldN2RO/b/qnt7VljODToE1nWF0oNXWikmAQhkSkqR8dX5rjFZ3gwiWfcc24Ohn5Gg3TDdjGjujspRPf09ucULMJRWi6dWw778zwT4SJ154tCuG5IvbeVSwfHpnpxEiMxjHwFgRR3BwBRLBHCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F+d8Jm3J; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6eff2be3b33so5796757b3a.2
        for <bpf@vger.kernel.org>; Tue, 30 Apr 2024 16:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714518385; x=1715123185; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VlKZ6oSsRHedgBhpd+fMTTEMq/zIjw3X+k/7V706s4c=;
        b=F+d8Jm3JOMc/zW8Y9mGz+rp03DAs7b0UuKKQa48ItfmQ4mRswsUqk6HirifC6+KBvc
         DCgqK9+wmWE0zdfolJ/qdxMc2OytsuCQ8krGv09SmHntNkzg9z9rnDiXNiTMSYKIgo7i
         HVCzKZIaUKM2OqstzzS9yhnAJN9ndD3AtBLmrKXDzGrOhvq/EcZuEr/2nsk6cbE+5vla
         UVoZ6EAiKRyAp5MDYtZmc3cMLsU8MfMRntM3HPRKZMHgmcG5NdW0ATohWU55IhvF8dbH
         PdOKfqEIU1AMny2MJL1UWY/4zB18qde3xnMvCN6qWzOo6WcwCuL1a6UkMePFBn63dDeU
         q6Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714518385; x=1715123185;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VlKZ6oSsRHedgBhpd+fMTTEMq/zIjw3X+k/7V706s4c=;
        b=QwetdfZYWfOMCp66SkxVEZ5dNMkhOqCwV+SvZzE4RKf0utSREpBa+KtcsMV7lUy6Ow
         K/EXjo6ufffCDBVvTcPwc0FXP1dSaLgaf9D2/qxdn77gZuOb8vST6xP1QPU25M6xJY/5
         QJ/KXE4FNT+STTBtJ9TEeo/GOVT+rGouZlAU9TwvcwL7H2SRgV9jed3RYfa7PP8nkaUt
         Z3ory5C0RQ0A6cXxAH9WqeemMwtForDbJ5qq6j7PrSp9gKvLVSGc0fq9rkvzeaeBV+Km
         MZM7tQddKu5zESvk+bDtqpac5Pqapk/A64yIwwcn9Px6rw5kEvjuLm8T49rCcpVoT59E
         5r1w==
X-Forwarded-Encrypted: i=1; AJvYcCUwB8p7VyMyqoRQZWLVKFAkJxHcAtWTxL43XuDDywUJa6NpQ7ImqY0xYJOlLtYbqZ2Uva72c/GkyynvWBm4VagS0CHS
X-Gm-Message-State: AOJu0YyOeX01+BDW8LvZbMO7Ruj8bRbACpcEYoLbKlirFFJoh1WqR3UX
	O7gzplH4CFLcP/1q8w0pDHI0sUDUuP+8JGxoRWVrpqNICKeAa/Bc
X-Google-Smtp-Source: AGHT+IHRLt2XQdqEDwJk5fGqIoLUqE4YFO3koEPBNR4bKn3SdTCydqXNPZL3V3pC0WuCU1uKSKXPfQ==
X-Received: by 2002:a05:6a20:a11a:b0:1af:6164:7c35 with SMTP id q26-20020a056a20a11a00b001af61647c35mr1643632pzk.17.1714518385139;
        Tue, 30 Apr 2024 16:06:25 -0700 (PDT)
Received: from ?IPv6:2604:3d08:6979:1160:313a:f4fd:13d2:b9eb? ([2604:3d08:6979:1160:313a:f4fd:13d2:b9eb])
        by smtp.gmail.com with ESMTPSA id r7-20020a17090ad40700b002acf260e82bsm132602pju.57.2024.04.30.16.06.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 16:06:24 -0700 (PDT)
Message-ID: <c3564a5e0b159d559ecd72ad0849aabfb54a672c.camel@gmail.com>
Subject: Re: [PATCH v2 bpf-next 02/13] libbpf: add btf__distill_base()
 creating split BTF with distilled base BTF
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alan Maguire <alan.maguire@oracle.com>, andrii@kernel.org, ast@kernel.org
Cc: jolsa@kernel.org, acme@redhat.com, quentin@isovalent.com,
 mykolal@fb.com,  daniel@iogearbox.net, martin.lau@linux.dev,
 song@kernel.org,  yonghong.song@linux.dev, john.fastabend@gmail.com,
 kpsingh@kernel.org,  sdf@google.com, haoluo@google.com, houtao1@huawei.com,
 bpf@vger.kernel.org,  masahiroy@kernel.org, mcgrof@kernel.org,
 nathan@kernel.org
Date: Tue, 30 Apr 2024 16:06:23 -0700
In-Reply-To: <20240424154806.3417662-3-alan.maguire@oracle.com>
References: <20240424154806.3417662-1-alan.maguire@oracle.com>
	 <20240424154806.3417662-3-alan.maguire@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-04-24 at 16:47 +0100, Alan Maguire wrote:

Hi Alan,

Looked through the patch, noted a few minor logical inconsistencies.
Agree with Andrii's comments about memory size allocated for dist.ids.
Otherwise this patch makes sense to me.

[...]

> @@ -5217,3 +5223,301 @@ int btf_ext_visit_str_offs(struct btf_ext *btf_ex=
t, str_off_visit_fn visit, void
> =20
>  	return 0;
>  }
> +
> +struct btf_distill_id {
> +	int id;
> +	bool embedded;		/* true if id refers to a struct/union in base BTF
> +				 * that is embedded in a split BTF struct/union.
> +				 */
> +};
> +
> +struct btf_distill {
> +	struct btf_pipe pipe;
> +	struct btf_distill_id *ids;
> +	__u32 query_id;
> +	unsigned int nr_base_types;
> +	unsigned int diff_id;
> +};
> +
> +/* Check if a member of a split BTF struct/union refers to a base BTF
> + * struct/union.  Members can be const/restrict/volatile/typedef
> + * reference types, but if a pointer is encountered, type is no longer
> + * considered embedded.
> + */
> +static int btf_find_embedded_composite_type_ids(__u32 *id, void *ctx)
> +{
> +	struct btf_distill *dist =3D ctx;
> +	const struct btf_type *t;
> +	__u32 next_id =3D *id;
> +
> +	do {
> +		if (next_id =3D=3D 0)
> +			return 0;
> +		t =3D btf_type_by_id(dist->pipe.src, next_id);
> +		switch (btf_kind(t)) {
> +		case BTF_KIND_CONST:
> +		case BTF_KIND_RESTRICT:
> +		case BTF_KIND_VOLATILE:
> +		case BTF_KIND_TYPEDEF:

I think BTF_KIND_TYPE_TAG is missing.

> +			next_id =3D t->type;
> +			break;
> +		case BTF_KIND_ARRAY: {
> +			struct btf_array *a =3D btf_array(t);
> +
> +			next_id =3D a->type;
> +			break;
> +		}
> +		case BTF_KIND_STRUCT:
> +		case BTF_KIND_UNION:
> +			dist->ids[next_id].embedded =3D next_id > 0 &&
> +						      next_id <=3D dist->nr_base_types;

I think next_id can't be zero, otherwise it's kind would be UNKN.
Also, should this be 'next_id < dist->nr_base_types'?

__u32 btf__type_cnt(const struct btf *btf)
{
	return btf->start_id + btf->nr_types;
}

static struct btf *btf_new(const void *data, __u32 size, struct btf *base_b=
tf)
{
	...
	btf->nr_types =3D 0;
	btf->start_id =3D 1;
	...
	if (base_btf) {
		...
		btf->start_id =3D btf__type_cnt(base_btf);
		...
	}
	...
}

int btf__distill_base(const struct btf *src_btf, struct btf **new_base_btf,
		      struct btf **new_split_btf)
{
	...
	dist.nr_base_types =3D btf__type_cnt(btf__base_btf(src_btf));
	...
}

So, suppose there is only one base type:
- it's ID would be 1;
- nr_types would be 1;
- nr_base_types would be 2;
- meaning that split BTF ids would start from 2.

Maybe use .split_start_id instead of .nr_base_types to avoid confusion?

> +			return 0;
> +		default:
> +			return 0;
> +		}
> +
> +	} while (next_id !=3D 0);
> +
> +	return 0;
> +}

