Return-Path: <bpf+bounces-7922-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 988D777E7BF
	for <lists+bpf@lfdr.de>; Wed, 16 Aug 2023 19:37:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D2F2281BA9
	for <lists+bpf@lfdr.de>; Wed, 16 Aug 2023 17:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 634F6174CF;
	Wed, 16 Aug 2023 17:37:36 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A08E10949
	for <bpf@vger.kernel.org>; Wed, 16 Aug 2023 17:37:35 +0000 (UTC)
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83E3D270D
	for <bpf@vger.kernel.org>; Wed, 16 Aug 2023 10:37:34 -0700 (PDT)
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-76d535567afso230651585a.1
        for <bpf@vger.kernel.org>; Wed, 16 Aug 2023 10:37:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692207453; x=1692812253;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nQTNcxYIfovI6om9fzIBo8hLVHnwtHcjnIRbvQPUEZc=;
        b=eVJpsgm+9I3bwOA1WpSDIdRV8Iv2oVyIk5fyAkVSK7r+y1zi666ozKL3q1ADuZD9C9
         rYnqWRz7qHIitcGESu2UR0TJLYXws245OYq+6KKBv6LhKTa8KQ80D4fTfeqbnkmBmRUo
         neK/F2591D4yp9iYZ2lMxOg5AunZXUmTVUBR+ATOwCmb8F8KsXCj7fkVS5KhWI33eUoh
         eoCwmP3iHlLK0S9zTgufjA5kQF+QWKoKnWqXxk+WzPvt8cWqfP9VJhnD7CoSy1U1nygY
         hTqZSycC0JyBS+mcL8ZAUMqwgM5xrXy16RMaHVEglFB1TopxlMsKlPU1lSgk7QxX80qE
         ytHw==
X-Gm-Message-State: AOJu0YwcsSw07wgZUYUNlO1ZebsIkelfF6XerJ5RGrSNjJuQwdVU5s1+
	1dCNLBZ3ZQd5HPQ87jKnwNc=
X-Google-Smtp-Source: AGHT+IETfh3+TMhQVTgUPAm4ieH4glZqPtchQHmU7QLGgBhRw2kwGJYe/v1jcp7t3vN3oyIXwuWQGg==
X-Received: by 2002:a05:620a:16d4:b0:76c:a010:25a2 with SMTP id a20-20020a05620a16d400b0076ca01025a2mr2410261qkn.63.1692207453493;
        Wed, 16 Aug 2023 10:37:33 -0700 (PDT)
Received: from maniforge ([2620:10d:c091:400::5:6eb])
        by smtp.gmail.com with ESMTPSA id f5-20020a05620a15a500b0076c70eccd05sm4547785qkk.108.2023.08.16.10.37.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 10:37:33 -0700 (PDT)
Date: Wed, 16 Aug 2023 12:37:31 -0500
From: David Vernet <void@manifault.com>
To: Dave Marchevsky <davemarchevsky@fb.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH v2 bpf-next 1/2] libbpf: Support triple-underscore
 flavors for kfunc relocation
Message-ID: <20230816173731.GA814797@maniforge>
References: <20230816165813.3718580-1-davemarchevsky@fb.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230816165813.3718580-1-davemarchevsky@fb.com>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Aug 16, 2023 at 09:58:12AM -0700, Dave Marchevsky wrote:
> The function signature of kfuncs can change at any time due to their
> intentional lack of stability guarantees. As kfuncs become more widely
> used, BPF program writers will need facilities to support calling
> different versions of a kfunc from a single BPF object. Consider this
> simplified example based on a real scenario we ran into at Meta:
> 
>   /* initial kfunc signature */
>   int some_kfunc(void *ptr)
> 
>   /* Oops, we need to add some flag to modify behavior. No problem,
>     change the kfunc. flags = 0 retains original behavior */
>   int some_kfunc(void *ptr, long flags)
> 
> If the initial version of the kfunc is deployed on some portion of the
> fleet and the new version on the rest, a fleetwide service that uses
> some_kfunc will currently need to load different BPF programs depending
> on which some_kfunc is available.
> 
> Luckily CO-RE provides a facility to solve a very similar problem,
> struct definition changes, by allowing program writers to declare
> my_struct___old and my_struct___new, with ___suffix being considered a
> 'flavor' of the non-suffixed name and being ignored by
> bpf_core_type_exists and similar calls.
> 
> This patch extends the 'flavor' facility to the kfunc extern
> relocation process. BPF program writers can now declare
> 
>   extern int some_kfunc___old(void *ptr)
>   extern int some_kfunc___new(void *ptr, int flags)
> 
> then test which version of the kfunc exists with bpf_ksym_exists.
> Relocation and verifier's dead code elimination will work in concert as
> expected, allowing this pattern:
> 
>   if (bpf_ksym_exists(some_kfunc___old))
>     some_kfunc___old(ptr);
>   else
>     some_kfunc___new(ptr, 0);
> 
> Changelog:
> 
> v1 -> v2: https://lore.kernel.org/bpf/20230811201346.3240403-1-davemarchevsky@fb.com/
>   * No need to check obj->externs[i].essent_name before zfree (Jiri)
>   * Use strndup instead of replicating same functionality (Jiri)
>   * Properly handle memory allocation falure (Stanislav)
> 
> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
> ---
>  tools/lib/bpf/libbpf.c | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index b14a4376a86e..8899abc04b8c 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -550,6 +550,7 @@ struct extern_desc {
>  	int btf_id;
>  	int sec_btf_id;
>  	const char *name;
> +	char *essent_name;
>  	bool is_set;
>  	bool is_weak;
>  	union {
> @@ -3770,6 +3771,7 @@ static int bpf_object__collect_externs(struct bpf_object *obj)
>  	struct extern_desc *ext;
>  	int i, n, off, dummy_var_btf_id;
>  	const char *ext_name, *sec_name;
> +	size_t ext_essent_len;
>  	Elf_Scn *scn;
>  	Elf64_Shdr *sh;
>  
> @@ -3819,6 +3821,14 @@ static int bpf_object__collect_externs(struct bpf_object *obj)
>  		ext->sym_idx = i;
>  		ext->is_weak = ELF64_ST_BIND(sym->st_info) == STB_WEAK;
>  
> +		ext_essent_len = bpf_core_essential_name_len(ext->name);
> +		ext->essent_name = NULL;
> +		if (ext_essent_len != strlen(ext->name)) {
> +			ext->essent_name = strndup(ext->name, ext_essent_len);
> +			if (!ext->essent_name)
> +				return -ENOMEM;
> +		}
> +
>  		ext->sec_btf_id = find_extern_sec_btf_id(obj->btf, ext->btf_id);
>  		if (ext->sec_btf_id <= 0) {
>  			pr_warn("failed to find BTF for extern '%s' [%d] section: %d\n",
> @@ -7624,7 +7634,8 @@ static int bpf_object__resolve_ksym_func_btf_id(struct bpf_object *obj,
>  
>  	local_func_proto_id = ext->ksym.type_id;
>  
> -	kfunc_id = find_ksym_btf_id(obj, ext->name, BTF_KIND_FUNC, &kern_btf, &mod_btf);
> +	kfunc_id = find_ksym_btf_id(obj, ext->essent_name ?: ext->name, BTF_KIND_FUNC, &kern_btf,
> +				    &mod_btf);
>  	if (kfunc_id < 0) {
>  		if (kfunc_id == -ESRCH && ext->is_weak)
>  			return 0;
> @@ -7642,6 +7653,9 @@ static int bpf_object__resolve_ksym_func_btf_id(struct bpf_object *obj,
>  		pr_warn("extern (func ksym) '%s': func_proto [%d] incompatible with %s [%d]\n",
>  			ext->name, local_func_proto_id,

Should we do ext->essent_name ?: ext->name here or in the below pr's as
well? Hmm, maybe it would be more clear to keep the full name.

>  			mod_btf ? mod_btf->name : "vmlinux", kfunc_proto_id);
> +
> +		if (ext->is_weak)
> +			return 0;

Could you clarify why we want this check? Don't we want to fail if the
prototype of the actual (essent) symbol we resolve to doesn't match
what's in the BPF prog? If we do want to keep this, should we do the
check above the pr_warn()?

>  		return -EINVAL;
>  	}
>  
> @@ -8370,6 +8384,10 @@ void bpf_object__close(struct bpf_object *obj)
>  
>  	zfree(&obj->btf_custom_path);
>  	zfree(&obj->kconfig);
> +
> +	for (i = 0; i < obj->nr_extern; i++)
> +		zfree(&obj->externs[i].essent_name);
> +
>  	zfree(&obj->externs);
>  	obj->nr_extern = 0;
>  
> -- 
> 2.34.1
> 
> 

