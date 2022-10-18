Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF1056032B5
	for <lists+bpf@lfdr.de>; Tue, 18 Oct 2022 20:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbiJRSrt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 18 Oct 2022 14:47:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbiJRSrr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 18 Oct 2022 14:47:47 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96EB69F363
        for <bpf@vger.kernel.org>; Tue, 18 Oct 2022 11:47:46 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id y1-20020a17090322c100b001853a004c1bso9692614plg.19
        for <bpf@vger.kernel.org>; Tue, 18 Oct 2022 11:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=k9ThAbL4FEX2oqVofGCR66I5SU53wjQz+bnaLKDgTW4=;
        b=tZCR7af6nMXjf7bYkQX98SiQ7zSghQjULCBmEmSDkThSH7V4VyWu0g3rjEr/1NFRcf
         iQc6yS1PthBtVG1eu4tFhhWDGdoahmTFpmFOJFDSXGFXczxNfamVTRr2EEVZYYDfns8o
         5bs7yDT8q9/fJsIdoboGgrXqC1hVNai94QZIO6EItVDp1Z0ojrZxNxjjn1x/Nfvcqcri
         ARRaaAsNtUwcgHVnZuFLDJwkDwij25nzlVhhlmCMqmYjYb7mZkSPnSTPqZVDl3tOduIR
         tG0q1ncfpW8h5nEN2nqpNlYmWV4r2XQPqofXtVa6UEJayAo6szH17VO8KZX5lgUKFnqO
         x7Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k9ThAbL4FEX2oqVofGCR66I5SU53wjQz+bnaLKDgTW4=;
        b=AuQs8WRXdHl25+k33YlukDPEi6uy6SSTWkPH70z1BaNIpYm7WHBRNJHRFiT+PuXA84
         LRo3a71lQNq+7GxMkEV8X6pYE87DbEbPdUKwKjA6Ky5a28Pf1P4CT7wIn7daBuWP+jDa
         TV8WwA/qlvX/n5ZzmSQkNRqPl/5Bq5KGBuG7Sma7P4gwRWNQsXB6dpCEH0Kx5xRAHiE9
         zJx9YjeRySnH+S3F5MKrDRhfj2nBzfNkW9bVMnOpq4k+3Vh+TKOwBtF1QlGFfo+OTTMs
         PHOzG4GtNGSEdnPFIyTya+Lj39Lh+zz/fVdxJDThO/0i3xRb43weajPFtotCyobUwrPA
         b1Ww==
X-Gm-Message-State: ACrzQf2g2oDlb6WelRjv8WY+Y8RKzRAZeKa03SrWFPfDpXedaCGhsvFY
        IGoY5kR2P7UAig+fZJmPR1fxO0I=
X-Google-Smtp-Source: AMsMyM48b7Dg/uLjLBzSWqaQBMeqOy8OZnjBlIFBu9+7Jh8rRr2epHdAObe0NbrCuF7Z3BpD+mVRRYg=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:90a:fee:b0:20a:fbef:3e76 with SMTP id
 101-20020a17090a0fee00b0020afbef3e76mr5213092pjz.11.1666118866223; Tue, 18
 Oct 2022 11:47:46 -0700 (PDT)
Date:   Tue, 18 Oct 2022 11:47:44 -0700
In-Reply-To: <20221018035646.1294873-2-andrii@kernel.org>
Mime-Version: 1.0
References: <20221018035646.1294873-1-andrii@kernel.org> <20221018035646.1294873-2-andrii@kernel.org>
Message-ID: <Y0700LilBVP2D39B@google.com>
Subject: Re: [PATCH bpf-next 1/3] libbpf: clean up and refactor BTF fixup step
From:   sdf@google.com
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 10/17, Andrii Nakryiko wrote:
> Refactor libbpf's BTF fixup step during BPF object open phase. The only
> functional change is that we now ignore BTF_VAR_GLOBAL_EXTERN variables
> during fix up, not just BTF_VAR_STATIC ones, which shouldn't cause any
> change in behavior as there shouldn't be any extern variable in data
> sections for valid BPF object anyways.

> Otherwise it's just collapsing two functions that have no reason to be
> separate, and switching find_elf_var_offset() helper to return entire
> symbol pointer, not just its offset. This will be used by next patch to
> get ELF symbol visibility.

> While refactoring, also "normalize" debug messages inside
> btf_fixup_datasec() to follow general libbpf style and print out data
> section name consistently, where it's available.

> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Acked-by: Stanislav Fomichev <sdf@google.com>

Left a couple of questions below.

> ---
>   tools/lib/bpf/libbpf.c | 95 ++++++++++++++++++------------------------
>   1 file changed, 41 insertions(+), 54 deletions(-)

> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 8c3f236c86e4..a25eb8fe7bf2 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -1461,15 +1461,12 @@ static int find_elf_sec_sz(const struct  
> bpf_object *obj, const char *name, __u32
>   	return -ENOENT;
>   }

> -static int find_elf_var_offset(const struct bpf_object *obj, const char  
> *name, __u32 *off)
> +static Elf64_Sym *find_elf_var_sym(const struct bpf_object *obj, const  
> char *name)
>   {
>   	Elf_Data *symbols = obj->efile.symbols;
>   	const char *sname;
>   	size_t si;

> -	if (!name || !off)
> -		return -EINVAL;
> -
>   	for (si = 0; si < symbols->d_size / sizeof(Elf64_Sym); si++) {
>   		Elf64_Sym *sym = elf_sym_by_idx(obj, si);

> @@ -1483,15 +1480,13 @@ static int find_elf_var_offset(const struct  
> bpf_object *obj, const char *name, _
>   		sname = elf_sym_str(obj, sym->st_name);
>   		if (!sname) {
>   			pr_warn("failed to get sym name string for var %s\n", name);
> -			return -EIO;
> -		}
> -		if (strcmp(name, sname) == 0) {
> -			*off = sym->st_value;
> -			return 0;
> +			return ERR_PTR(-EIO);
>   		}
> +		if (strcmp(name, sname) == 0)
> +			return sym;
>   	}

> -	return -ENOENT;
> +	return ERR_PTR(-ENOENT);
>   }

>   static struct bpf_map *bpf_object__add_map(struct bpf_object *obj)
> @@ -2850,57 +2845,62 @@ static int compare_vsi_off(const void *_a, const  
> void *_b)
>   static int btf_fixup_datasec(struct bpf_object *obj, struct btf *btf,
>   			     struct btf_type *t)
>   {
> -	__u32 size = 0, off = 0, i, vars = btf_vlen(t);
> -	const char *name = btf__name_by_offset(btf, t->name_off);
> -	const struct btf_type *t_var;
> +	__u32 size = 0, i, vars = btf_vlen(t);
> +	const char *sec_name = btf__name_by_offset(btf, t->name_off);
>   	struct btf_var_secinfo *vsi;
> -	const struct btf_var *var;
> -	int ret;
> +	int err;

> -	if (!name) {
> +	if (!sec_name) {
>   		pr_debug("No name found in string section for DATASEC kind.\n");
>   		return -ENOENT;
>   	}

> -	/* .extern datasec size and var offsets were set correctly during
> -	 * extern collection step, so just skip straight to sorting variables
> +	/* extern-backing datasecs (.ksyms, .kconfig) have their size and
> +	 * variable offsets set at the previous step, so we skip any fixups
> +	 * for such sections
>   	 */
>   	if (t->size)
>   		goto sort_vars;

> -	ret = find_elf_sec_sz(obj, name, &size);
> -	if (ret || !size) {
> -		pr_debug("Invalid size for section %s: %u bytes\n", name, size);
> +	err = find_elf_sec_sz(obj, sec_name, &size);
> +	if (err || !size) {
> +		pr_debug("sec '%s': invalid size %u bytes\n", sec_name, size);

nit: do we want to log err instead here? it seems like the size will be
zero on error anyway, so probably not worth logging it?

>   		return -ENOENT;
>   	}

>   	t->size = size;

>   	for (i = 0, vsi = btf_var_secinfos(t); i < vars; i++, vsi++) {
> +		const struct btf_type *t_var;
> +		struct btf_var *var;
> +		const char *var_name;
> +		Elf64_Sym *sym;
> +
>   		t_var = btf__type_by_id(btf, vsi->type);
>   		if (!t_var || !btf_is_var(t_var)) {
> -			pr_debug("Non-VAR type seen in section %s\n", name);
> +			pr_debug("sec '%s': unexpected non-VAR type found\n", sec_name);
>   			return -EINVAL;
>   		}

>   		var = btf_var(t_var);
> -		if (var->linkage == BTF_VAR_STATIC)
> +		if (var->linkage == BTF_VAR_STATIC || var->linkage ==  
> BTF_VAR_GLOBAL_EXTERN)
>   			continue;

> -		name = btf__name_by_offset(btf, t_var->name_off);
> -		if (!name) {
> -			pr_debug("No name found in string section for VAR kind\n");
> +		var_name = btf__name_by_offset(btf, t_var->name_off);
> +		if (!var_name) {
> +			pr_debug("sec '%s': failed to find name of DATASEC's member #%d\n",
> +				 sec_name, i);
>   			return -ENOENT;
>   		}

> -		ret = find_elf_var_offset(obj, name, &off);
> -		if (ret) {
> -			pr_debug("No offset found in symbol table for VAR %s\n",
> -				 name);
> +		sym = find_elf_var_sym(obj, var_name);
> +		if (IS_ERR(sym)) {
> +			pr_debug("sec '%s': failed to find ELF symbol for VAR '%s'\n",
> +				 sec_name, var_name);
>   			return -ENOENT;
>   		}

> -		vsi->offset = off;
> +		vsi->offset = sym->st_value;
>   	}

>   sort_vars:
> @@ -2908,13 +2908,16 @@ static int btf_fixup_datasec(struct bpf_object  
> *obj, struct btf *btf,
>   	return 0;
>   }

> -static int btf_finalize_data(struct bpf_object *obj, struct btf *btf)
> +static int bpf_object_fixup_btf(struct bpf_object *obj)
>   {
> -	int err = 0;
> -	__u32 i, n = btf__type_cnt(btf);
> +	int i, n, err = 0;

> +	if (!obj->btf)
> +		return 0;
> +
> +	n = btf__type_cnt(obj->btf);

qq: why do s/__u32/int/ here? btf__type_cnt seems to be returning u32?

>   	for (i = 1; i < n; i++) {
> -		struct btf_type *t = btf_type_by_id(btf, i);
> +		struct btf_type *t = btf_type_by_id(obj->btf, i);

>   		/* Loader needs to fix up some of the things compiler
>   		 * couldn't get its hands on while emitting BTF. This
> @@ -2922,28 +2925,12 @@ static int btf_finalize_data(struct bpf_object  
> *obj, struct btf *btf)
>   		 * the info from the ELF itself for this purpose.
>   		 */
>   		if (btf_is_datasec(t)) {
> -			err = btf_fixup_datasec(obj, btf, t);
> +			err = btf_fixup_datasec(obj, obj->btf, t);
>   			if (err)
> -				break;
> +				return err;
>   		}
>   	}

> -	return libbpf_err(err);
> -}
> -
> -static int bpf_object__finalize_btf(struct bpf_object *obj)
> -{
> -	int err;
> -
> -	if (!obj->btf)
> -		return 0;
> -
> -	err = btf_finalize_data(obj, obj->btf);
> -	if (err) {
> -		pr_warn("Error finalizing %s: %d.\n", BTF_ELF_SEC, err);
> -		return err;
> -	}
> -
>   	return 0;
>   }

> @@ -7233,7 +7220,7 @@ static struct bpf_object *bpf_object_open(const  
> char *path, const void *obj_buf,
>   	err = err ? : bpf_object__check_endianness(obj);
>   	err = err ? : bpf_object__elf_collect(obj);
>   	err = err ? : bpf_object__collect_externs(obj);
> -	err = err ? : bpf_object__finalize_btf(obj);
> +	err = err ? : bpf_object_fixup_btf(obj);
>   	err = err ? : bpf_object__init_maps(obj, opts);
>   	err = err ? : bpf_object_init_progs(obj, opts);
>   	err = err ? : bpf_object__collect_relos(obj);
> --
> 2.30.2

