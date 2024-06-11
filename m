Return-Path: <bpf+bounces-31798-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2081C90387E
	for <lists+bpf@lfdr.de>; Tue, 11 Jun 2024 12:13:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97E921F2657F
	for <lists+bpf@lfdr.de>; Tue, 11 Jun 2024 10:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9751A178381;
	Tue, 11 Jun 2024 10:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OBb+9zB5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0FF8E57E;
	Tue, 11 Jun 2024 10:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718100805; cv=none; b=O6UOkRViTdAkfcat6bgYtRSJk2wcqW/AsFvJwQ7p9xxqwzZvvvmeXXVbibGQUZP39oKKi3KbJsdEiaRdD1cDE9SABiVtDtDR0GR5FBzVDL+edi6BWAkc1gIJDfleYkAR78fKzQTSwPZsrH1NbdAs1IQo3lWrSm80Gxek37tyU30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718100805; c=relaxed/simple;
	bh=NFplBVQS9EeQgek8xEOVuqUTSZBHZKK+8349c2uE6pk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eCJ+/rhji/FEVGnEN4pHPOHA2kpz/zrLgRNb+RYcs/0LtIboy7Vd0bI7PYVB7t7yv9jqWSia1SHRmT2kCBKFhiMYMuXV4+z8nGl/alCJTneV4I6+JQ190uufWFefoS2nMnKxau8l9toyhM4/HUbW5KxM4ZzheY/Wap6HEs7q/jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OBb+9zB5; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-70436048c25so2003371b3a.0;
        Tue, 11 Jun 2024 03:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718100803; x=1718705603; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kBBK9+emp78zSyx4y6b6AylUTB0AMIDwhsId20BEYMs=;
        b=OBb+9zB53q/hJGrH9jrt+fEM0j8WhgMHK/O2KpKYRIi4SJ56a3FaJ/DPfiFdYhDWpw
         qo7JobTDni5boxWNTFIttRuOqeLJOOsBHX4hRRhT+CgYo1TF3Z58m8en05suGJl9uEt6
         gR4z3XmWVtUTX4KOPfW5X8hnwyt3h+oOuxDl+CzJyvJmbGBLy4GKAMqk0wVaEUwiGVZM
         e2pW1jiwztMdTgZ1/81oae3IiN9q1Lwxoq8BkUT9h1s7KyYYGk8i71HHq9aGuvo+4+a1
         tO6FNnRRbgGZ1jwUrfHAM+KQVG1SxcBuXNoxj5gQlZGDpgy6ysLevUw2rwCIqkcVyfC8
         hS6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718100803; x=1718705603;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kBBK9+emp78zSyx4y6b6AylUTB0AMIDwhsId20BEYMs=;
        b=HUNW+SokhCCIGkPNnfmP/wLejDE1C3cR783gHHEk3qmvRYkUhShcFOfg9bH34jrl6/
         RWAeD3f0M8Ww72+I8I+8fYiZHRDrTdTbHvNScdjk7eBRVTPNOlkFKmEWufdNHNAggjP7
         EzQE1rpgnGC567MMGehN4LG1n+BDUTxP2qYHFmkwdZEha0w7k0ClOuYqtGdc8xldQ8GP
         i7toflA0js3Grk1XtquVN+LXH5yE+hd4qMA7YMDZSJgYlKVhZkWUtDeYKpEB38H8dG+L
         76oSDiWjNPRsB/+cKC4EtYTf3J64fd69jGYN3MvxdSghwrFTbczOo82dJKGrkTaANDUQ
         pAEw==
X-Forwarded-Encrypted: i=1; AJvYcCWrIhfPij/kf0d5n8QhEHkwGkzcKCxJ566A21lx+pnbkOjbwOUOVP0twgHEMuyjm/hg0qp3SHP0gUqPmMUnQk240ZUKzB2KG3MVzbzKwTaiEiTezsn9453hKXIap60i/WLL
X-Gm-Message-State: AOJu0YygWoMVTYfaqkzjoYchxmy9MhXZxdfwfi0dIrJITqSj8PWMr8b7
	wUjWaScurGHHwQ8Jby4oIRutfl7cEcmqRHA39dqEP82RKl31xvTp
X-Google-Smtp-Source: AGHT+IFQySRxZTnNzT/5Nb5wCg1EB0869TwkpQUqQpngqaR780caS0qkkRweC1Kb2UxdwMcNdnYnBQ==
X-Received: by 2002:a05:6a20:d49a:b0:1b7:4adb:1dcc with SMTP id adf61e73a8af0-1b74adb1eaemr3821491637.60.1718100802757;
        Tue, 11 Jun 2024 03:13:22 -0700 (PDT)
Received: from [192.168.0.31] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-704228c2c74sm5499728b3a.209.2024.06.11.03.13.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 03:13:22 -0700 (PDT)
Message-ID: <4f551dc5fc792936ca364ce8324c0adea38162f1.camel@gmail.com>
Subject: Re: [RFC PATCH v3] bpf: Using binary search to improve the
 performance of btf_find_by_name_kind
From: Eduard Zingerman <eddyz87@gmail.com>
To: Donglin Peng <dolinux.peng@gmail.com>, ast@kernel.org, andrii
	 <andrii@kernel.org>, alan.maguire@oracle.com, acme@kernel.org
Cc: daniel@iogearbox.net, mhiramat@kernel.org, song@kernel.org,
 andrii@kernel.org,  haoluo@google.com, yonghong.song@linux.dev,
 bpf@vger.kernel.org,  linux-kernel@vger.kernel.org
Date: Tue, 11 Jun 2024 03:13:17 -0700
In-Reply-To: <20240608140835.965949-1-dolinux.peng@gmail.com>
References: <20240608140835.965949-1-dolinux.peng@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2024-06-08 at 07:08 -0700, Donglin Peng wrote:

[...]

> Changes in RFC v3:
>  - Sort the btf types during the build process in order to reduce memory =
usage
>    and decrease boot time.
>=20
> RFC v2:
>  - https://lore.kernel.org/all/20230909091646.420163-1-pengdonglin@sangfo=
r.com.cn
> ---
>  include/linux/btf.h |   1 +
>  kernel/bpf/btf.c    | 160 +++++++++++++++++++++++++++++++++---

I think that kernel part is in a good shape,
please split it as a separate commit.

>  tools/lib/bpf/btf.c | 195 ++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 345 insertions(+), 11 deletions(-)

[...]

> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> index 2d0840ef599a..93c1ab677bfa 100644

I'm not sure that libbpf is the best place to put this functionality,
as there might be different kinds of orderings
(e.g. see a fresh commit to bpftool to output stable vmlinux.h:
 94133cf24bb3 "bpftool: Introduce btf c dump sorting").

I'm curious what Andrii, Alan and Arnaldo think on libbpf vs pahole
for this feature.

Also, I have a selftests build failure with this patch-set
(and I suspect that a bunch of dedup test cases would need an update):

$ pwd
/home/eddy/work/bpf-next/tools/testing/selftests/bpf
$ make -j14 test_progs
...

  GEN-SKEL [test_progs] access_map_in_map.skel.h
Binary files /home/eddy/work/bpf-next/tools/testing/selftests/bpf/access_ma=
p_in_map.bpf.linked2.o and /home/eddy/work/bpf-next/tools/testing/selftests=
/bpf/access_map_in_map.bpf.linked3.o differ
make: *** [Makefile:658: /home/eddy/work/bpf-next/tools/testing/selftests/b=
pf/access_map_in_map.skel.h] Error 1
make: *** Waiting for unfinished jobs....

If this change remains in libbpf, I think it would be great to update
btf_find_by_name_kind() to work the same way as kernel one.

> --- a/tools/lib/bpf/btf.c
> +++ b/tools/lib/bpf/btf.c

[...]

> +static int btf_sort_type_by_name(struct btf *btf)
> +{
> +	struct btf_type *bt;
> +	__u32 *new_type_offs =3D NULL, *new_type_offs_noname =3D NULL;
> +	__u32 *maps =3D NULL, *found_offs;
> +	void *new_types_data =3D NULL, *loc_data;
> +	int i, j, k, type_cnt, ret =3D 0, type_size;
> +	__u32 data_size;
> +
> +	if (btf_ensure_modifiable(btf))
> +		return libbpf_err(-ENOMEM);
> +
> +	type_cnt =3D btf->nr_types;
> +	data_size =3D btf->type_offs_cap * sizeof(*new_type_offs);
> +
> +	maps =3D (__u32 *)malloc(type_cnt * sizeof(__u32));
> +	if (!maps) {
> +		ret =3D -ENOMEM;
> +		goto err_out;
> +	}
> +
> +	new_type_offs =3D (__u32 *)malloc(data_size);
> +	if (!new_type_offs) {
> +		ret =3D -ENOMEM;
> +		goto err_out;
> +	}
> +
> +	new_type_offs_noname =3D (__u32 *)malloc(data_size);
> +	if (!new_type_offs_noname) {
> +		ret =3D -ENOMEM;
> +		goto err_out;
> +	}

What is the point of separating offsets in new_type_offs vs
new_type_offs_noname? It should be possible to use a single offsets
array and have a comparison function that puts all named types before
unnamed.

> +
> +	new_types_data =3D malloc(btf->types_data_cap);
> +	if (!new_types_data) {
> +		ret =3D -ENOMEM;
> +		goto err_out;
> +	}
> +
> +	memset(new_type_offs, 0, data_size);
> +
> +	for (i =3D 0, j =3D 0, k =3D 0; i < type_cnt; i++) {
> +		const char *name;
> +
> +		bt =3D (struct btf_type *)(btf->types_data + btf->type_offs[i]);
> +		name =3D btf__str_by_offset(btf, bt->name_off);
> +		if (!name || !name[0])
> +			new_type_offs_noname[k++] =3D btf->type_offs[i];
> +		else
> +			new_type_offs[j++] =3D btf->type_offs[i];
> +	}
> +
> +	memmove(new_type_offs + j, new_type_offs_noname, sizeof(__u32) * k);
> +
> +	qsort_r(new_type_offs, j, sizeof(*new_type_offs),
> +		btf_compare_type_name, btf);
> +
> +	for (i =3D 0; i < type_cnt; i++) {
> +		found_offs =3D bsearch(&new_type_offs[i], btf->type_offs, type_cnt,
> +					sizeof(__u32), btf_compare_offs);
> +		if (!found_offs) {
> +			ret =3D -EINVAL;
> +			goto err_out;
> +		}
> +		maps[found_offs - btf->type_offs] =3D i;
> +	}
> +
> +	loc_data =3D new_types_data;
> +	for (i =3D 0; i < type_cnt; i++, loc_data +=3D type_size) {
> +		bt =3D (struct btf_type *)(btf->types_data + new_type_offs[i]);
> +		type_size =3D btf_type_size(bt);
> +		if (type_size < 0) {
> +			ret =3D type_size;
> +			goto err_out;
> +		}
> +
> +		memcpy(loc_data, bt, type_size);
> +
> +		bt =3D (struct btf_type *)loc_data;
> +		switch (btf_kind(bt)) {

Please take a look at btf_dedup_remap_types(): it uses newly added
iterator interface to enumerate all ID references in the type.
It could be used here to avoid enumerating every BTF kind.
Also, the d->hypot_map could be used instead of `maps`.
And if so, I think that it should be possible to put this pass before
btf_dedup_remap_types() in order for it to do the remapping.

Alternatively, it might make sense to merge this pass with
btf_dedup_compact_types() in order to minimize number of operations,
e.g. as in my crude attempt:
https://github.com/eddyz87/bpf/tree/binsort-btf-dedup
(fails with similar selftests issue).

> +		case BTF_KIND_PTR:
> +		case BTF_KIND_CONST:
> +		case BTF_KIND_VOLATILE:
> +		case BTF_KIND_RESTRICT:
> +		case BTF_KIND_TYPEDEF:
> +		case BTF_KIND_TYPE_TAG:
> +		case BTF_KIND_FUNC:
> +		case BTF_KIND_VAR:
> +		case BTF_KIND_DECL_TAG:
> +			bt->type =3D btf_get_mapped_type(btf, maps, bt->type);
> +			break;

[...]

