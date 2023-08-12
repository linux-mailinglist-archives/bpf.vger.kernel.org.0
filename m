Return-Path: <bpf+bounces-7661-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70DF277A235
	for <lists+bpf@lfdr.de>; Sat, 12 Aug 2023 22:03:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8D431C20915
	for <lists+bpf@lfdr.de>; Sat, 12 Aug 2023 20:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F20838C0C;
	Sat, 12 Aug 2023 20:03:32 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA00D7472
	for <bpf@vger.kernel.org>; Sat, 12 Aug 2023 20:03:32 +0000 (UTC)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B837C5
	for <bpf@vger.kernel.org>; Sat, 12 Aug 2023 13:03:02 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-99bc9e3cbf1so634829366b.0
        for <bpf@vger.kernel.org>; Sat, 12 Aug 2023 13:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691870477; x=1692475277;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ieXyfX669Ncl8XSh/fpJV+/UV6oVsD80j4MCIT+cCTw=;
        b=EUlfe6hRG8Jv8RB2ezqSdhhAzkEzdC4zMIeneYF1F3w67FQAr55KcWCSLF66clcU7e
         EbAjIcazcNegpTLqmZo9xSgme9RU2EJmNram1ebDp7ZMQAblxIRzOce01Hg6k4yNyNje
         4IMh1TSiV+SUG6npFYcdmHp9D2eERlTo0KVSiMjv0dOeNWMkGnZ6kUdq5E8T9/1NJtUg
         s7nlhZ9d/K/V4QdrjPowheu1OK1Jv+QhxbyNf0nEDU4QS0YlLaX05fnW6Y9KIIyLFgZS
         7px32kpxpz8vhNkwX9KLWijsiYxwJhqTL5tqfM9HXD1ty94RGoEz6sxD7nJgcq+XKhgX
         tzDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691870477; x=1692475277;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ieXyfX669Ncl8XSh/fpJV+/UV6oVsD80j4MCIT+cCTw=;
        b=ZuufMrMSK5c+kZN7sirt7FpnzfKBWVCxKWuOA7e5xANZouc8r8S5Mor43882GC19r9
         AFI8rdtLFHvwAzTlmeV3eDPIno/HrzFE/XYcZby6GvjVPSPvdBVHwspOPpry/oB9BFwH
         Wgp2bb6idw9y44VF/wfPgFFcbjixfhaqVu4n4yvm9SUhfVO+o9u5AKEkzI1MYG1qpxV1
         YfAxZtxMW2fbKejaAsTc0JgHZwG4umvaATRfdYGHHGdZpcsjM+dHpPsaYHiwvnHedVDR
         zNnZs5qmBA9HbXsBo9Eo20m1oEbPDfamRWdakJ9RbnR67ASdxUgN7H43R/YEx0GaQRid
         xocQ==
X-Gm-Message-State: AOJu0Yx2C4tlTALy/Zo70OGB8op2GKTdAkYSaMdTPTL1HFFfR7K/whIc
	ORR6gYrZcfRJ0Q2SDQSYNlg=
X-Google-Smtp-Source: AGHT+IFIRvAdmgre7n0YSz78nLQehiv25zR1eqnaRiZkc9+7mAqPZDOoKbUn3Ruy7o8wTaVTzbsUAg==
X-Received: by 2002:a17:907:6095:b0:974:fb94:8067 with SMTP id ht21-20020a170907609500b00974fb948067mr11404726ejc.23.1691870476552;
        Sat, 12 Aug 2023 13:01:16 -0700 (PDT)
Received: from krava (ip-94-113-247-30.net.vodafone.cz. [94.113.247.30])
        by smtp.gmail.com with ESMTPSA id d11-20020aa7c1cb000000b005232ea6a330sm3562079edp.2.2023.08.12.13.01.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Aug 2023 13:01:15 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Sat, 12 Aug 2023 22:01:13 +0200
To: Dave Marchevsky <davemarchevsky@fb.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Kernel Team <kernel-team@fb.com>, Tejun Heo <tj@kernel.org>,
	dvernet@meta.com
Subject: Re: [PATCH bpf-next 1/2] libbpf: Support triple-underscore flavors
 for kfunc relocation
Message-ID: <ZNflCUQTKbJFCAe6@krava>
References: <20230811201346.3240403-1-davemarchevsky@fb.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230811201346.3240403-1-davemarchevsky@fb.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Aug 11, 2023 at 01:13:45PM -0700, Dave Marchevsky wrote:
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
> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
> ---
>  tools/lib/bpf/libbpf.c | 21 ++++++++++++++++++++-
>  1 file changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 17883f5a44b9..8949d489a35f 100644
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
> +			ext->essent_name = malloc(ext_essent_len + 1);
> +			memcpy(ext->essent_name, ext->name, ext_essent_len);
> +			ext->essent_name[ext_essent_len] = '\0';

could we use strndup in here?

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
>  			mod_btf ? mod_btf->name : "vmlinux", kfunc_proto_id);
> +
> +		if (ext->is_weak)
> +			return 0;
>  		return -EINVAL;
>  	}
>  
> @@ -8370,6 +8384,11 @@ void bpf_object__close(struct bpf_object *obj)
>  
>  	zfree(&obj->btf_custom_path);
>  	zfree(&obj->kconfig);
> +
> +	for (i = 0; i < obj->nr_extern; i++)
> +		if (obj->externs[i].essent_name)
> +			zfree(&obj->externs[i].essent_name);

no need to check the pointer, free will take care of that

jirka

> +
>  	zfree(&obj->externs);
>  	obj->nr_extern = 0;
>  
> -- 
> 2.34.1
> 
> 

