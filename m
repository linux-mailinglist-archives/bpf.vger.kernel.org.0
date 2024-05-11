Return-Path: <bpf+bounces-29580-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 057EB8C2E7F
	for <lists+bpf@lfdr.de>; Sat, 11 May 2024 03:46:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1DA08B22770
	for <lists+bpf@lfdr.de>; Sat, 11 May 2024 01:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3F2C11CBD;
	Sat, 11 May 2024 01:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V4Ar6HUh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11EA1078B
	for <bpf@vger.kernel.org>; Sat, 11 May 2024 01:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715391981; cv=none; b=dKVCSF3hJE9eTllbciQqZr8QlfGcgevl+7da5hqWv3s7+/nsizE4cHwNQjL/WwATHfX07ZCdpOrQ5Lh1487ge64vRxXir1BHgAc3X/orTuzKrCLYQW3+/OdTAUzJSrmcX15YnEb4s5Iy+7s0qMlXUms4jWCpF4DFhhhXWU1PHKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715391981; c=relaxed/simple;
	bh=SIr/Sg6pnZLhyMAqYxhD91coQShDKX0D8xI+ukd7ulQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=e3OVbhhn3E3cp2cet8mnAh9oaU6nX9wqylcaAGpClfN6cYcwq6jvO4KBAHuzqBsMOeAupmNNjDuT2VohyysqGCA76yWhDmONmJOObvEUKqe8QdBd+TxqDlGWuip9sh3pG+XceWOI6hLBTjYc+tR68leBBbsFCEd1fmW8EytUXqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V4Ar6HUh; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5b28c209095so664043eaf.0
        for <bpf@vger.kernel.org>; Fri, 10 May 2024 18:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715391979; x=1715996779; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gTribdY6DEMMmaempmd1m2GlXWKJ83bix584/uuwIug=;
        b=V4Ar6HUh2N7DVIFuY5qeS1n3GCUipawI1a8w+OXZ0nKgOv5x5Nmi5cg3PlePeu24QW
         UQDooHwbMIF2VvTk7lTMrEMwqmLRYTV9lNaq7AFkwHBfe7mzW/QN4JAeAm+mBBnxJuTR
         f1Ne+RE6NyISY+vVVdMkI/4ieYJ2NHrgRdy418SNj/DDYWAI0UR3uLJ1xwwq2IGsJR1z
         CIRcsmD6TpK/aq0brUPxNE837OotEcAs/G18/euet1PI3jr3KZtztEb8E02GbgQBZROd
         9Qirxt0biTmUkioC80cR0Ri1UvrHfC5qSkaw+D0tn5nuWXEDXKsBihVi02qPmEyxzecZ
         YqUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715391979; x=1715996779;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gTribdY6DEMMmaempmd1m2GlXWKJ83bix584/uuwIug=;
        b=Pb2J0PtogneqWaQMz43O39J8TVeQGtLh8nPW6c2r1i1NzTAHhaZiRLlUr4WByk1ZhM
         qKGF6dy1ljfHnq2u9RgUnV8xiEIIdFVrl38ZqxQUrY7n8DVGR4itOOMC3tcVtrJSFiah
         44/8O1xtfs3T+e8a+AThLw1sWsdli52GrPnMC+As9cKbK0ftKg1w8tAm/3S5rM8b891h
         Ju2+lfAvA3fjwonNZakRleg6W0y0U+qs008Zqe2V95JL6wkYz0SJ/Qi5S+fS5Pm3ADOz
         9rvdrdhyzbgQOuVovAK16aODyn0456qFjIOK9YzJm2nXjjNvjz1lZrBvA0EdSqHqGjAD
         RqbQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9TfCS5afpRRz/S9WvEC94jurkVA67kR9sl+WI5PzuMz6Cyq8V2BRhlEh0uB1BNGbhMWyc8N5uyudY1NM8b3taLAAO
X-Gm-Message-State: AOJu0YySSnQTHxKTdVzcjMfm9dNzfV/P0zSXN3tALqUYdYQCjnD92+SY
	92lbK3mG/AaZv/R1/M/a1359Wx4/5xBqwHwxxN6M4pm7JvWGL5Gx
X-Google-Smtp-Source: AGHT+IHn+eC/df6pNNXIdml9KXxAFnY6S+zbY6J4uWW0dqPM/5hFwkuzzh52AeHKWdOHSDPxhv6DqA==
X-Received: by 2002:a05:6870:6113:b0:23c:d140:fe83 with SMTP id 586e51a60fabf-24172f6b2e4mr5298944fac.54.1715391978824;
        Fri, 10 May 2024 18:46:18 -0700 (PDT)
Received: from ?IPv6:2604:3d08:6979:1160::3424? ([2604:3d08:6979:1160::3424])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-639c80f424esm979870a12.22.2024.05.10.18.46.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 18:46:18 -0700 (PDT)
Message-ID: <2e5472ba5b96118b11872a869b251132ca49dabd.camel@gmail.com>
Subject: Re: [PATCH v3 bpf-next 10/11] libbpf,bpf: share BTF
 relocate-related code with kernel
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alan Maguire <alan.maguire@oracle.com>, andrii@kernel.org,
 jolsa@kernel.org,  acme@redhat.com, quentin@isovalent.com
Cc: mykolal@fb.com, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@linux.dev,  song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com,  kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, houtao1@huawei.com,  bpf@vger.kernel.org,
 masahiroy@kernel.org, mcgrof@kernel.org, nathan@kernel.org
Date: Fri, 10 May 2024 18:46:17 -0700
In-Reply-To: <20240510103052.850012-11-alan.maguire@oracle.com>
References: <20240510103052.850012-1-alan.maguire@oracle.com>
	 <20240510103052.850012-11-alan.maguire@oracle.com>
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

> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 821063660d9f..82bd2a275a12 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -274,6 +274,7 @@ struct btf {
>  	u32 start_str_off; /* first string offset (0 for base BTF) */
>  	char name[MODULE_NAME_LEN];
>  	bool kernel_btf;
> +	__u32 *base_map; /* map from distilled base BTF -> vmlinux BTF ids */
>  };
> =20
>  enum verifier_phase {
> @@ -1735,7 +1736,13 @@ static void btf_free(struct btf *btf)
>  	kvfree(btf->types);
>  	kvfree(btf->resolved_sizes);
>  	kvfree(btf->resolved_ids);
> -	kvfree(btf->data);
> +	/* only split BTF allocates data, but btf->data is non-NULL for
> +	 * vmlinux BTF too.
> +	 */
> +	if (btf->base_btf)
> +		kvfree(btf->data);

Is this correct?
I see that btf->data is assigned in three functions:
- btf_parse(): allocated via kvmalloc(), does not set btf->base_btf;
- btf_parse_base(): not allocated passed from caller, either vmlinux
  or module, does not set btf->base_btf;
- btf_parse_module(): allocated via kvmalloc(), does set btf->base_btf;

So, the check above seems incorrect for btf_parse(), am I wrong?

> +	if (btf->kernel_btf)
> +		kvfree(btf->base_map);

Nit: the check could be dropped, the btf->base_map field is
     conditionally set only by btf_parse_module() to an allocated object,
     in all other cases the field is NULL.

>  	kfree(btf);
>  }
> =20
> @@ -1764,6 +1771,90 @@ void btf_put(struct btf *btf)
>  	}
>  }
> =20
> +struct btf *btf_base_btf(const struct btf *btf)
> +{
> +	return btf->base_btf;
> +}
> +
> +struct btf_rewrite_strs {
> +	struct btf *btf;
> +	const struct btf *old_base_btf;
> +	int str_start;
> +	int str_diff;
> +	__u32 *str_map;
> +};
> +
> +static __u32 btf_find_str(struct btf *btf, const char *s)
> +{
> +	__u32 offset =3D 0;
> +
> +	while (offset < btf->hdr.str_len) {
> +		while (!btf->strings[offset])
> +			offset++;
> +		if (strcmp(s, &btf->strings[offset]) =3D=3D 0)
> +			return offset;
> +		while (btf->strings[offset])
> +			offset++;
> +	}
> +	return -ENOENT;
> +}
> +
> +static int btf_rewrite_strs(__u32 *str_off, void *ctx)
> +{
> +	struct btf_rewrite_strs *r =3D ctx;
> +	const char *s;
> +	int off;
> +
> +	if (!*str_off)
> +		return 0;
> +	if (*str_off >=3D r->str_start) {
> +		*str_off +=3D r->str_diff;
> +	} else {
> +		s =3D btf_str_by_offset(r->old_base_btf, *str_off);
> +		if (!s)
> +			return -ENOENT;
> +		if (r->str_map[*str_off]) {
> +			off =3D r->str_map[*str_off];
> +		} else {
> +			off =3D btf_find_str(r->btf->base_btf, s);
> +			if (off < 0)
> +				return off;
> +			r->str_map[*str_off] =3D off;
> +		}

If 'str_map' part would be abstracted as local function 'btf__add_str'
it should be possible to move btf_rewrite_strs() and btf_set_base_btf()
to btf_common.c, right?

Also, linear scan over vmlinux BTF strings seems a bit inefficient,
maybe build a temporary hash table instead and define 'btf__find_str'?

> +		*str_off =3D off;
> +	}
> +	return 0;
> +}
> +
> +int btf_set_base_btf(struct btf *btf, struct btf *base_btf)
> +{
> +	struct btf_rewrite_strs r =3D {};
> +	struct btf_type *t;
> +	int i, err;
> +
> +	r.old_base_btf =3D btf_base_btf(btf);
> +	if (!r.old_base_btf)
> +		return -EINVAL;
> +	r.btf =3D btf;
> +	r.str_start =3D r.old_base_btf->hdr.str_len;
> +	r.str_diff =3D base_btf->hdr.str_len - r.old_base_btf->hdr.str_len;
> +	r.str_map =3D kvcalloc(r.old_base_btf->hdr.str_len, sizeof(*r.str_map),
> +			     GFP_KERNEL | __GFP_NOWARN);
> +	if (!r.str_map)
> +		return -ENOMEM;
> +	btf->base_btf =3D base_btf;
> +	btf->start_id =3D btf_nr_types(base_btf);
> +	btf->start_str_off =3D base_btf->hdr.str_len;
> +	for (i =3D 0; i < btf->nr_types; i++) {
> +		t =3D (struct btf_type *)btf_type_by_id(btf, i + btf->start_id);
> +		err =3D btf_type_visit_str_offs((struct btf_type *)t, btf_rewrite_strs=
, &r);
> +		if (err)
> +			break;
> +	}
> +	kvfree(r.str_map);
> +	return err;
> +}
> +

[...]

> diff --git a/tools/lib/bpf/btf_relocate.c b/tools/lib/bpf/btf_relocate.c
> index 54949975398b..4a1fcb260f7f 100644
> --- a/tools/lib/bpf/btf_relocate.c
> +++ b/tools/lib/bpf/btf_relocate.c
> @@ -5,11 +5,43 @@
>  #define _GNU_SOURCE
>  #endif
> =20
> +#ifdef __KERNEL__
> +#include <linux/bpf.h>
> +#include <linux/bsearch.h>
> +#include <linux/btf.h>
> +#include <linux/sort.h>
> +#include <linux/string.h>
> +#include <linux/bpf_verifier.h>
> +
> +#define btf_type_by_id				(struct btf_type *)btf_type_by_id
> +#define btf__type_cnt				btf_nr_types
> +#define btf__base_btf				btf_base_btf
> +#define btf__name_by_offset			btf_name_by_offset
> +#define btf_kflag				btf_type_kflag
> +
> +#define calloc(nmemb, sz)			kvcalloc(nmemb, sz, GFP_KERNEL | __GFP_NOWAR=
N)
> +#define free(ptr)				kvfree(ptr)
> +#define qsort_r(base, num, sz, cmp, priv)	sort_r(base, num, sz, (cmp_r_f=
unc_t)cmp, NULL, priv)
> +
> +static inline __u8 btf_int_bits(const struct btf_type *t)
> +{
> +	return BTF_INT_BITS(*(__u32 *)(t + 1));
> +}
> +
> +static inline struct btf_decl_tag *btf_decl_tag(const struct btf_type *t=
)
> +{
> +	return (struct btf_decl_tag *)(t + 1);
> +}

Nit: maybe put btf_int_bits() and btf_decl_tag() to include/linux/btf.h?
     There are already a lot of similar definitions there.
     Same for btf_var_secinfos() from btf_common.c.

> +
> +#else
> +
>  #include "btf.h"
>  #include "bpf.h"
>  #include "libbpf.h"
>  #include "libbpf_internal.h"
> =20
> +#endif /* __KERNEL__ */
> +
>  struct btf;
> =20
>  struct btf_relocate {


