Return-Path: <bpf+bounces-51553-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 799DDA35AD1
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 10:50:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F83818929E6
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 09:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2275624501F;
	Fri, 14 Feb 2025 09:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xfAxKytq"
X-Original-To: bpf@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2FF24BBEC
	for <bpf@vger.kernel.org>; Fri, 14 Feb 2025 09:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739526583; cv=none; b=KB6YidduoPtB/3tCorkU2PQhcCGFNnJAHr3Uc8W0Co9w7x2aevV70cTun75l2gb7lOVvUKDZJQBOYklOqc0vIFsRePmDfPgTX9ccq6vZfiWxo2+OJB2tjTkk8qcsc4pzhyFghgAyD3GHajt8fhw9hJaTevHc8jyUMI1a4h0gif0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739526583; c=relaxed/simple;
	bh=H8ZIWZ9xOzL7gckXgKEIrMMdyMMmlw56PEVis5DstbU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SeWGdQPnVWbsyJJwtSjOSzZr4ZDvHTjOb98eP9h8pIDx69ta3inlkHUUuzbwsdgX3Z4aqqUlss7sefrfw4g6eU6a27JBsKcpYyHYG/e6gjZv1cIZHwQi3eMK8oQcvHODojRxD4SBL8r2DQnKc23+eKT7e3SYjn616KAHNMEBO6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xfAxKytq; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <07590be4-7809-4636-9bbc-3daa4c6efca1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1739526578;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rT+lmbN6kCidrWmfVLZ5HOBUww0M8yoMHTvHtinFHco=;
	b=xfAxKytqqgODa116AjGBmJr6nkWG3XantTHyeH7LulV8rYNOLorQP+O8eKTRI1Ps/EuT/H
	Wc/pqxuizhyhu3D0qdzpFQOCNGNQ+FYt4Cb59cuTy8fHwfvCnod95iFpcIGh4E39FRabtq
	tV4VNq1Q7yGF+Iqt/u3zeE8QoMzV0ko=
Date: Fri, 14 Feb 2025 17:49:30 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RESEND PATCH bpf-next v2 3/4] bpf, bpftool: Generate skeleton
 for global percpu data
Content-Language: en-US
To: bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 yonghong.song@linux.dev, song@kernel.org, eddyz87@gmail.com, qmo@kernel.org,
 dxu@dxuuu.xyz, kernel-patches-bot@fb.com
References: <20250213161931.46399-1-leon.hwang@linux.dev>
 <20250213161931.46399-4-leon.hwang@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <20250213161931.46399-4-leon.hwang@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 14/2/25 00:19, Leon Hwang wrote:
> This patch enhances bpftool to generate skeletons that properly handle
> global percpu variables. The generated skeleton now includes a dedicated
> structure for percpu data, allowing users to initialize and access percpu
> variables more efficiently.
> 
> Changes:
> 
> 1. skeleton structure:
> 
> For global percpu variables, the skeleton now includes a nested
> structure, e.g.:
> 
> struct test_global_percpu_data {
> 	struct bpf_object_skeleton *skeleton;
> 	struct bpf_object *obj;
> 	struct {
> 		struct bpf_map *percpu;
> 	} maps;
> 	// ...
> 	struct test_global_percpu_data__percpu {
> 		int data;
> 		int run;
> 		int data2;
> 	} __aligned(8) *percpu;
> 
> 	// ...
> };
> 
>   * The "struct test_global_percpu_data__percpu" points to initialized
>     data, which is actually "maps.percpu->data".
>   * Before loading the skeleton, updating the
>     "struct test_global_percpu_data__percpu" modifies the initial value
>     of the corresponding global percpu variables.
>   * After loading the skeleton, accessing or updating this struct is not
>     allowed because this struct pointer has been reset as NULL. Instead,
>     users must interact with the global percpu variables via the
>     "maps.percpu" map.
> 
> 2. code changes:
> 
>   * Added support for ".percpu" sections in bpftool's map identification
>     logic.
>   * Modified skeleton generation to handle percpu data maps
>     appropriately.
>   * Updated libbpf to make "percpu" pointing to "maps.percpu->data".
>   * Set ".percpu" struct points to NULL after loading the skeleton.
> 
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> ---
>  tools/bpf/bpftool/gen.c | 47 ++++++++++++++++++++++++++++++++---------
>  1 file changed, 37 insertions(+), 10 deletions(-)
> 
> diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
> index 67a60114368f5..f2bf509248718 100644
> --- a/tools/bpf/bpftool/gen.c
> +++ b/tools/bpf/bpftool/gen.c
> @@ -92,7 +92,7 @@ static void get_header_guard(char *guard, const char *obj_name, const char *suff
>  
>  static bool get_map_ident(const struct bpf_map *map, char *buf, size_t buf_sz)
>  {
> -	static const char *sfxs[] = { ".data", ".rodata", ".bss", ".kconfig" };
> +	static const char *sfxs[] = { ".data", ".rodata", ".percpu", ".bss", ".kconfig" };
>  	const char *name = bpf_map__name(map);
>  	int i, n;
>  
> @@ -117,7 +117,7 @@ static bool get_map_ident(const struct bpf_map *map, char *buf, size_t buf_sz)
>  
>  static bool get_datasec_ident(const char *sec_name, char *buf, size_t buf_sz)
>  {
> -	static const char *pfxs[] = { ".data", ".rodata", ".bss", ".kconfig" };
> +	static const char *pfxs[] = { ".data", ".rodata", ".percpu", ".bss", ".kconfig" };
>  	int i, n;
>  
>  	/* recognize hard coded LLVM section name */
> @@ -148,7 +148,8 @@ static int codegen_datasec_def(struct bpf_object *obj,
>  			       struct btf *btf,
>  			       struct btf_dump *d,
>  			       const struct btf_type *sec,
> -			       const char *obj_name)
> +			       const char *obj_name,
> +			       bool is_percpu)
>  {
>  	const char *sec_name = btf__name_by_offset(btf, sec->name_off);
>  	const struct btf_var_secinfo *sec_var = btf_var_secinfos(sec);
> @@ -228,7 +229,7 @@ static int codegen_datasec_def(struct bpf_object *obj,
>  
>  		off = sec_var->offset + sec_var->size;
>  	}
> -	printf("	} *%s;\n", sec_ident);
> +	printf("	}%s *%s;\n", is_percpu ? " __aligned(8)" : "", sec_ident);
>  	return 0;
>  }
>  
> @@ -279,6 +280,7 @@ static int codegen_datasecs(struct bpf_object *obj, const char *obj_name)
>  	struct bpf_map *map;
>  	const struct btf_type *sec;
>  	char map_ident[256];
> +	bool is_percpu;
>  	int err = 0;
>  
>  	d = btf_dump__new(btf, codegen_btf_dump_printf, NULL, NULL);
> @@ -286,8 +288,11 @@ static int codegen_datasecs(struct bpf_object *obj, const char *obj_name)
>  		return -errno;
>  
>  	bpf_object__for_each_map(map, obj) {
> -		/* only generate definitions for memory-mapped internal maps */
> -		if (!is_mmapable_map(map, map_ident, sizeof(map_ident)))
> +		/* only generate definitions for memory-mapped or .percpu internal maps */
> +		is_percpu = bpf_map__is_internal_percpu(map);
> +		if (!is_mmapable_map(map, map_ident, sizeof(map_ident)) && !is_percpu)
> +			continue;
> +		if (is_percpu && (use_loader || !get_map_ident(map, map_ident, sizeof(map_ident))))
>  			continue;
>  
>  		sec = find_type_for_map(btf, map_ident);
> @@ -303,7 +308,7 @@ static int codegen_datasecs(struct bpf_object *obj, const char *obj_name)
>  			printf("	struct %s__%s {\n", obj_name, map_ident);
>  			printf("	} *%s;\n", map_ident);
>  		} else {
> -			err = codegen_datasec_def(obj, btf, d, sec, obj_name);
> +			err = codegen_datasec_def(obj, btf, d, sec, obj_name, is_percpu);
>  			if (err)
>  				goto out;
>  		}
> @@ -901,8 +906,9 @@ codegen_maps_skeleton(struct bpf_object *obj, size_t map_cnt, bool mmaped, bool
>  				map->map = &obj->maps.%s;	    \n\
>  			",
>  			i, bpf_map__name(map), ident);
> -		/* memory-mapped internal maps */
> -		if (mmaped && is_mmapable_map(map, ident, sizeof(ident))) {
> +		/* memory-mapped or .percpu internal maps */
> +		if (mmaped && (is_mmapable_map(map, ident, sizeof(ident)) ||
> +			       bpf_map__is_internal_percpu(map))) {
>  			printf("\tmap->mmaped = (void **)&obj->%s;\n", ident);
>  		}
>  
> @@ -1434,7 +1440,28 @@ static int do_skeleton(int argc, char **argv)
>  		static inline int					    \n\
>  		%1$s__load(struct %1$s *obj)				    \n\
>  		{							    \n\
> -			return bpf_object__load_skeleton(obj->skeleton);    \n\
> +			int err;					    \n\
> +									    \n\
> +			err = bpf_object__load_skeleton(obj->skeleton);	    \n\
> +			if (err)					    \n\
> +				return err;				    \n\
> +									    \n\
> +		", obj_name);
> +
> +	if (map_cnt) {
> +		bpf_object__for_each_map(map, obj) {
> +			if (!get_map_ident(map, ident, sizeof(ident)))
> +				continue;
> +			if (bpf_map__is_internal(map) &&
> +			    bpf_map__type(map) == BPF_MAP_TYPE_PERCPU_ARRAY) {

bpf_map__is_internal_percpu(map) is recommended to replace
bpf_map__is_internal() and map type checking.

Then, these two "if"s can be combined to one:

if (bpf_map__is_internal_percpu(map) && get_map_ident(map, ident,
sizeof(ident) {

Thanks,
Leon

> +				printf("\tobj->%s = NULL;\n", ident);
> +			}
> +		}
> +	}
> +
> +	codegen("\
> +		\n\
> +			return 0;					    \n\
>  		}							    \n\
>  									    \n\
>  		static inline struct %1$s *				    \n\


