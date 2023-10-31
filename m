Return-Path: <bpf+bounces-13649-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 263337DC3FB
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 02:53:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A77B9281684
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 01:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0E3FEBF;
	Tue, 31 Oct 2023 01:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hzSmA0uN"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82433A54
	for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 01:53:45 +0000 (UTC)
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [IPv6:2001:41d0:1004:224b::ba])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 594C0102
	for <bpf@vger.kernel.org>; Mon, 30 Oct 2023 18:53:43 -0700 (PDT)
Message-ID: <ff0e6978-adb5-db47-5968-5af4924aadba@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1698717221;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J404lBE3F3LpLQxmNZ01hqhYTMjQYaA4yglqsMZM/zk=;
	b=hzSmA0uNLfTUXZAGTyn8/DIxLhJCQZdej1DEmyKwahkwrKCpugfxXcVmXGqyHUrC48OmWS
	850bh4cHlQ61NfPTPefTauIG4QRqjGPrzIlCZdFJ7+FcM0UJatSMi5pjvWTMQdchOoiPTL
	J58nzb7ZANb+TL4QFAf+Gr9mRisSyi0=
Date: Mon, 30 Oct 2023 18:53:37 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v8 06/10] bpf: pass attached BTF to the
 bpf_struct_ops subsystem
Content-Language: en-US
To: thinker.li@gmail.com
Cc: sinquersw@gmail.com, kuifeng@meta.com, bpf@vger.kernel.org,
 ast@kernel.org, song@kernel.org, kernel-team@meta.com, andrii@kernel.org,
 drosen@google.com
References: <20231030192810.382942-1-thinker.li@gmail.com>
 <20231030192810.382942-7-thinker.li@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20231030192810.382942-7-thinker.li@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 10/30/23 12:28 PM, thinker.li@gmail.com wrote:
> From: Kui-Feng Lee <thinker.li@gmail.com>
> 
> Giving a BTF, the bpf_struct_ops knows the right place to look up type info
> associated with a type ID. This enables a user space program to load a
> struct_ops object linked to a struct_ops type defined by a module, by
> providing the module BTF (fd).

This describes about the struct_ops map creation change (by adding 
value_type_btf_obj_fd)? It could be described more clearly in the commit 
message, like specify the value_type_btf_obj_fd addition and how it is used in 
the struct_ops map creation.

> 
> The bpf_prog includes attach_btf in aux which is passed along with the
> bpf_attr when loading the program. The purpose of attach_btf is to
> determine the btf type of attach_btf_id. The attach_btf_id is then used to
> identify the traced function for a trace program. In the case of struct_ops
> programs, it is used to identify the struct_ops type of the struct_ops
> object that a program is attached to.

Does attach_btf_obj_fd also work?

[ ... ]

> diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
> index 256516aba632..db2bbba50e38 100644
> --- a/kernel/bpf/bpf_struct_ops.c
> +++ b/kernel/bpf/bpf_struct_ops.c
> @@ -694,6 +694,7 @@ static void __bpf_struct_ops_map_free(struct bpf_map *map)
>   		bpf_jit_uncharge_modmem(PAGE_SIZE);
>   	}
>   	bpf_map_area_free(st_map->uvalue);
> +	btf_put(st_map->st_ops_desc->btf);
>   	bpf_map_area_free(st_map);
>   }
>   
> @@ -735,16 +736,31 @@ static struct bpf_map *bpf_struct_ops_map_alloc(union bpf_attr *attr)
>   	const struct btf_type *t, *vt;
>   	struct module *mod = NULL;
>   	struct bpf_map *map;
> +	struct btf *btf;
>   	int ret;
>   
> -	st_ops_desc = bpf_struct_ops_find_value(btf_vmlinux, attr->btf_vmlinux_value_type_id);
> -	if (!st_ops_desc)
> -		return ERR_PTR(-ENOTSUPP);
> +	if (attr->value_type_btf_obj_fd) {
> +		/* The map holds btf for its whole life time. */

It took me a while to parse this comment and connect it with the 
btf_put(st_map->st_ops_desc->btf) in the __bpf_struct_ops_map_free() above.

It is now like "btf" owns "struct_ops_desc" which also stores a pointer pointing 
back to itself, like "btf->struct_ops_desc->btf". The struct_ops_desc->btf was 
not initialized by st_map but st_map will increment its refcount much later.

Can btf be directly stored in the st_map->btf instead and map_alloc holds the 
refcnt of st_map->btf and btf_put(st_map->btf) in map_free?


> +		btf = btf_get_by_fd(attr->value_type_btf_obj_fd);
> +		if (IS_ERR(btf))
> +			return ERR_PTR(PTR_ERR(btf));
> +
> +		if (btf != btf_vmlinux) {
> +			mod = btf_try_get_module(btf);
> +			if (!mod) {
> +				ret = -EINVAL;
> +				goto errout;
> +			}
> +		}
> +	} else {
> +		btf = btf_vmlinux;
> +		btf_get(btf);
> +	}
>   
> -	if (st_ops_desc->btf != btf_vmlinux) {
> -		mod = btf_try_get_module(st_ops_desc->btf);
> -		if (!mod)
> -			return ERR_PTR(-EINVAL);
> +	st_ops_desc = bpf_struct_ops_find_value(btf, attr->btf_vmlinux_value_type_id);
> +	if (!st_ops_desc) {
> +		ret = -ENOTSUPP;
> +		goto errout;
>   	}
>   
>   	vt = st_ops_desc->value_type;


