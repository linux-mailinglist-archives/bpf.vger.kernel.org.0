Return-Path: <bpf+bounces-8075-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B2697780EF8
	for <lists+bpf@lfdr.de>; Fri, 18 Aug 2023 17:20:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B83341C21644
	for <lists+bpf@lfdr.de>; Fri, 18 Aug 2023 15:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0FDA18C33;
	Fri, 18 Aug 2023 15:20:09 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A41D18C23
	for <bpf@vger.kernel.org>; Fri, 18 Aug 2023 15:20:09 +0000 (UTC)
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B62BE4206
	for <bpf@vger.kernel.org>; Fri, 18 Aug 2023 08:19:59 -0700 (PDT)
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-64a5bc52b0aso5361156d6.3
        for <bpf@vger.kernel.org>; Fri, 18 Aug 2023 08:19:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692371999; x=1692976799;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0TuopDLunLViGSEZBKISfsVFStzMT8GaGi+OETWU1E0=;
        b=Lufi0PXQJ6uDN0FojPZ/3yBaoDwe++j+SIERrVGEpuhr3TwDXWrB9u3LFdBWWf8q7z
         Z3tyuLoL06jsx2LuXAS6jRGkQwe6JgxZh1yo/GqwVDApVADdE/EmZBwZha+QyqxnLU7i
         F4ehsSISlycXuj7j7mbTtKKjWMtFYPfdSTzABT4kYldjnJoiNu3cmvuCeg/4dfgdqSzC
         CC6kKDY7vrfaxOvbFHXpkVO7ectjGMVAdTYzqEHksZX3Gbv2n8uGSKc94+okmSnD1t+5
         fGhcej9g/Cno2+9goYfHmDnba2t9JEyYmtsTbWzACLlCZ1q1ZnmvAXH/xMFe/fRXWVLV
         7sqQ==
X-Gm-Message-State: AOJu0YzaI24t69aZ68La8qF0IaKebQnh65V8CGGJ4HFJayO5Mn3vzIIt
	lnMttBru7xsZs58pN5EMZHsFLBqEYmsu/g==
X-Google-Smtp-Source: AGHT+IFVZ80V0TmWo9obQwsXUOUZuzFZP9isoQZw1kHEFQzCZJtihO/HLhj0HaoKSfhaNEb44Lg01w==
X-Received: by 2002:a0c:b2d2:0:b0:636:60c6:2034 with SMTP id d18-20020a0cb2d2000000b0063660c62034mr3227950qvf.38.1692371998671;
        Fri, 18 Aug 2023 08:19:58 -0700 (PDT)
Received: from maniforge ([2620:10d:c091:400::5:766])
        by smtp.gmail.com with ESMTPSA id i8-20020a0cf388000000b0063d5d173a51sm752577qvk.50.2023.08.18.08.19.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 08:19:58 -0700 (PDT)
Date: Fri, 18 Aug 2023 10:19:55 -0500
From: David Vernet <void@manifault.com>
To: Dave Marchevsky <davemarchevsky@fb.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH v3 bpf-next 1/2] libbpf: Support triple-underscore
 flavors for kfunc relocation
Message-ID: <20230818151955.GA14411@maniforge>
References: <20230817225353.2570845-1-davemarchevsky@fb.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230817225353.2570845-1-davemarchevsky@fb.com>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Aug 17, 2023 at 03:53:52PM -0700, Dave Marchevsky wrote:
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
> v2 -> v3: https://lore.kernel.org/bpf/20230816165813.3718580-1-davemarchevsky@fb.com/
>   * Move if (ext->is_weak) test above pr_warn to match existing similar behavior
>     (David Vernet)
> 
> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>

LGTM, thanks for working on this.

Acked-by: David Vernet <void@manifault.com>

> ---
>  tools/lib/bpf/libbpf.c | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index b14a4376a86e..2178b28878e2 100644
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
> @@ -7639,6 +7650,9 @@ static int bpf_object__resolve_ksym_func_btf_id(struct bpf_object *obj,
>  	ret = bpf_core_types_are_compat(obj->btf, local_func_proto_id,
>  					kern_btf, kfunc_proto_id);
>  	if (ret <= 0) {
> +		if (ext->is_weak)
> +			return 0;
> +
>  		pr_warn("extern (func ksym) '%s': func_proto [%d] incompatible with %s [%d]\n",
>  			ext->name, local_func_proto_id,
>  			mod_btf ? mod_btf->name : "vmlinux", kfunc_proto_id);
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

