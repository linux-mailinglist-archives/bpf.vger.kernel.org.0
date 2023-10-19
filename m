Return-Path: <bpf+bounces-12644-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 489517CEE2C
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 04:44:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67A331C20B15
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 02:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACA6CA5C;
	Thu, 19 Oct 2023 02:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Y1DUYQ25"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30CFD38C
	for <bpf@vger.kernel.org>; Thu, 19 Oct 2023 02:44:07 +0000 (UTC)
Received: from out-209.mta1.migadu.com (out-209.mta1.migadu.com [IPv6:2001:41d0:203:375::d1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0796B95
	for <bpf@vger.kernel.org>; Wed, 18 Oct 2023 19:44:05 -0700 (PDT)
Message-ID: <74e172ec-6884-0de9-d8b9-3aa443bb5922@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1697683443;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uugO66rMuiD0CH8+zFqg8RGrF+VFv0UYAoHrbxNRH8Y=;
	b=Y1DUYQ256/ZjQkYv9pxH3m2b1vFqbB2ar8/Q4hnhMVOcaaICBclaMDfAzfxrW1Qb/sJ4Qq
	TOJs96YzKPF/puCb92oiaSGqBAibZ5GzFgZnN6iqpHY9pFU3Uuv1Jyz4YkUReOJRsIR0YH
	IDoOH+2V1ZEk8LG/KOJiixzvqv1PUqQ=
Date: Wed, 18 Oct 2023 19:43:55 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v5 7/9] libbpf: Find correct module BTFs for
 struct_ops maps and progs.
Content-Language: en-US
To: thinker.li@gmail.com
Cc: sinquersw@gmail.com, kuifeng@meta.com, bpf@vger.kernel.org,
 ast@kernel.org, song@kernel.org, kernel-team@meta.com, andrii@kernel.org,
 drosen@google.com
References: <20231017162306.176586-1-thinker.li@gmail.com>
 <20231017162306.176586-8-thinker.li@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20231017162306.176586-8-thinker.li@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 10/17/23 9:23 AM, thinker.li@gmail.com wrote:
> -static int find_ksym_btf_id(struct bpf_object *obj, const char *ksym_name,
> -			    __u16 kind, struct btf **res_btf,
> -			    struct module_btf **res_mod_btf)
> +static int find_module_btf_id(struct bpf_object *obj, const char *kern_name,
> +			      __u16 kind, struct btf **res_btf,
> +			      struct module_btf **res_mod_btf)
>   {
>   	struct module_btf *mod_btf;
>   	struct btf *btf;
> @@ -7710,7 +7728,7 @@ static int find_ksym_btf_id(struct bpf_object *obj, const char *ksym_name,
>   
>   	btf = obj->btf_vmlinux;
>   	mod_btf = NULL;
> -	id = btf__find_by_name_kind(btf, ksym_name, kind);
> +	id = btf__find_by_name_kind(btf, kern_name, kind);
>   
>   	if (id == -ENOENT) {
>   		err = load_module_btfs(obj);
> @@ -7721,7 +7739,7 @@ static int find_ksym_btf_id(struct bpf_object *obj, const char *ksym_name,
>   			/* we assume module_btf's BTF FD is always >0 */
>   			mod_btf = &obj->btf_modules[i];
>   			btf = mod_btf->btf;
> -			id = btf__find_by_name_kind_own(btf, ksym_name, kind);
> +			id = btf__find_by_name_kind_own(btf, kern_name, kind);
>   			if (id != -ENOENT)
>   				break;
>   		}
> @@ -7744,7 +7762,7 @@ static int bpf_object__resolve_ksym_var_btf_id(struct bpf_object *obj,
>   	struct btf *btf = NULL;
>   	int id, err;
>   
> -	id = find_ksym_btf_id(obj, ext->name, BTF_KIND_VAR, &btf, &mod_btf);
> +	id = find_module_btf_id(obj, ext->name, BTF_KIND_VAR, &btf, &mod_btf);
>   	if (id < 0) {
>   		if (id == -ESRCH && ext->is_weak)
>   			return 0;
> @@ -7798,8 +7816,8 @@ static int bpf_object__resolve_ksym_func_btf_id(struct bpf_object *obj,
>   
>   	local_func_proto_id = ext->ksym.type_id;
>   
> -	kfunc_id = find_ksym_btf_id(obj, ext->essent_name ?: ext->name, BTF_KIND_FUNC, &kern_btf,
> -				    &mod_btf);
> +	kfunc_id = find_module_btf_id(obj, ext->essent_name ?: ext->name, BTF_KIND_FUNC, &kern_btf,
> +				      &mod_btf);
>   	if (kfunc_id < 0) {
>   		if (kfunc_id == -ESRCH && ext->is_weak)
>   			return 0;
> @@ -9464,9 +9482,9 @@ static int libbpf_find_prog_btf_id(const char *name, __u32 attach_prog_fd)
>   	return err;
>   }
>   
> -static int find_kernel_btf_id(struct bpf_object *obj, const char *attach_name,
> -			      enum bpf_attach_type attach_type,
> -			      int *btf_obj_fd, int *btf_type_id)
> +static int find_kernel_attach_btf_id(struct bpf_object *obj, const char *attach_name,
> +				     enum bpf_attach_type attach_type,
> +				     int *btf_obj_fd, int *btf_type_id)
>   {
>   	int ret, i;
>   
> @@ -9531,7 +9549,9 @@ static int libbpf_find_attach_btf_id(struct bpf_program *prog, const char *attac
>   		*btf_obj_fd = 0;
>   		*btf_type_id = 1;
>   	} else {
> -		err = find_kernel_btf_id(prog->obj, attach_name, attach_type, btf_obj_fd, btf_type_id);
> +		err = find_kernel_attach_btf_id(prog->obj, attach_name,
> +						attach_type, btf_obj_fd,
> +						btf_type_id);
>   	}
>   	if (err) {
>   		pr_warn("prog '%s': failed to find kernel BTF type ID of '%s': %d\n",
> @@ -12945,9 +12965,9 @@ int bpf_program__set_attach_target(struct bpf_program *prog,
>   		err = bpf_object__load_vmlinux_btf(prog->obj, true);
>   		if (err)
>   			return libbpf_err(err);
> -		err = find_kernel_btf_id(prog->obj, attach_func_name,
> -					 prog->expected_attach_type,
> -					 &btf_obj_fd, &btf_id);
> +		err = find_kernel_attach_btf_id(prog->obj, attach_func_name,
> +						prog->expected_attach_type,
> +						&btf_obj_fd, &btf_id);

Please avoid mixing this level of name changes with the main changes. It is 
quite confusing for the reviewer and it is not mentioned in the commit message 
either.

