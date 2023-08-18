Return-Path: <bpf+bounces-8087-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BE1F780FEC
	for <lists+bpf@lfdr.de>; Fri, 18 Aug 2023 18:10:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4375028234D
	for <lists+bpf@lfdr.de>; Fri, 18 Aug 2023 16:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48E9E19BB5;
	Fri, 18 Aug 2023 16:10:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 169CF182B5
	for <bpf@vger.kernel.org>; Fri, 18 Aug 2023 16:10:33 +0000 (UTC)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92F03E42
	for <bpf@vger.kernel.org>; Fri, 18 Aug 2023 09:10:31 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-52564f3faf7so1334291a12.1
        for <bpf@vger.kernel.org>; Fri, 18 Aug 2023 09:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692375030; x=1692979830;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pswfkD5JyWp/6ErftNc2Uq0gJWrY9NQ401kjBFpmFQo=;
        b=leXq1DZvcYFLpQar2B/419Dn+MO2WqTYOEWb+R/bFehwvKzkAzU3Xi5jzc/PaE2xb8
         7X4iGaDtYfOTvFo415k5kWu95kHSo2wgxXlHACQLQA/FAAqPF+WJRuHFu4NgsNfzOE+F
         +cfSW6gKtVBWVehB1YBkmhOCLTG8UcTKlOvbbaCGN0zABVfmvlwtl0+sosWTb+v4Wyu7
         NinSPCI0qg8fN62kQGYFzltu+0FtbrxPO04fxySmuFHv6hbKE+xUXbqTWp6tSJxraffO
         fKY36TMzXi1leEw3Iyc7QR9poBe2DpNI4NSWJeaN8mHyk1lZnzqvUYl+OMvuDko3DE+4
         G9FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692375030; x=1692979830;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pswfkD5JyWp/6ErftNc2Uq0gJWrY9NQ401kjBFpmFQo=;
        b=M+W0eiPIiKHQ96jvpCVns1l0+l2HYT2tq3qi4EOSshkdauc34qwDcvJzEU5MPoGAq3
         x/ruZ1Ds8nrrCk36GEBhfebAphkJEQB9LIxkzYECS+oHjp7+cM32Zg97v64geR7KSnrM
         QOpI4udyp1YIf+dir0m3kNb9a0UWjREIcvd4GQ3eK7hBvJJMQ6QKB07nqDXxGSMhIpsr
         EDb4EFx0WAcZOkKCRTeLsmw+6q1fs6DR+eHBLyhDV0uDTrDnQWW8Z4RE03aevfWcEYXL
         Z7w/odBobSsb3LK+kv2DVLd113NW09qmK4zApmW9luQWXWPDbJ+1CgMim+jWf/HPwJxp
         c1hg==
X-Gm-Message-State: AOJu0YwjigCYVaE5cnHuQw7Xqaa9POKrPHsYajOmbIxY7LzXEnGy/q84
	ixCJmLJio/UsnUD6+kfLKbY=
X-Google-Smtp-Source: AGHT+IH+naRxCqDdyVu5Y7o1M9KQiH2vjPSMGbYjEZzKJ8CIQBCoO/DFOFLZVNJT65+oIYF3abNLeQ==
X-Received: by 2002:a17:907:75e6:b0:987:5761:2868 with SMTP id jz6-20020a17090775e600b0098757612868mr2265074ejc.11.1692375029837;
        Fri, 18 Aug 2023 09:10:29 -0700 (PDT)
Received: from krava ([83.240.60.227])
        by smtp.gmail.com with ESMTPSA id le26-20020a170907171a00b0099316c56db9sm1345499ejc.127.2023.08.18.09.10.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 09:10:29 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 18 Aug 2023 18:10:26 +0200
To: Dave Marchevsky <davemarchevsky@fb.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH v3 bpf-next 1/2] libbpf: Support triple-underscore
 flavors for kfunc relocation
Message-ID: <ZN+X8iGcF7KS9UA0@krava>
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
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

lgtm

Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka


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

