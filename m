Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 831DE6032D6
	for <lists+bpf@lfdr.de>; Tue, 18 Oct 2022 20:52:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbiJRSw2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 18 Oct 2022 14:52:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiJRSw1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 18 Oct 2022 14:52:27 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1E961090
        for <bpf@vger.kernel.org>; Tue, 18 Oct 2022 11:52:26 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id h2-20020a170902f54200b0018553a8b797so3808893plf.9
        for <bpf@vger.kernel.org>; Tue, 18 Oct 2022 11:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=n5EM215kBrb1rN2kMttY1PkLsQ43EWzqRERv1fdoh6I=;
        b=CkuqRgh/662fGfaIVkRVy7YCT2d70E5tt+1H1yVHP0Pufv3/bUDTclI3CyiTHjQX7P
         9imJz7pqgcsY3v+E2aeZ25whXVEbPhyATg3PTESyDQVtqgxK3FUeKrdBHt8XoZUGlxxX
         EiFCcpUgNa0QQZO402r6Fv53OY2PHFZrvKfCU9HTSKvd0VF+yElsU3LKm93tGlZf9QqR
         rXsJdMIxXUbBaEB46TRmw0NA+KXqdgtLptc7bGUrF6nNqdSrANahLh/EDUajNt8M/2uu
         Ty147GtI8ymAgXYSgbC1WQJtmiAQp5jmNnsYVIrj9wS1bIqZWqCZ5fj7aV3DV47Xydtl
         osaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n5EM215kBrb1rN2kMttY1PkLsQ43EWzqRERv1fdoh6I=;
        b=zDlXE7sYvSvIjXTClyZlPQD7F7bI3+wh8SA2ZSsrhq351OxvpfTOdBKwS8kXQPxETI
         ToGCDpYOFuwVaiOUrekIUgH1F6iTUvQDy5ohN5isXz2ACQV2x1QTgjCPCsvTfN1VdaqT
         l05FvN0h+PzhUpn/BWJ+MWBGEwKk9UX2X0bTsJSXR7ahsX47zWOZtNrdxp/+J2wvFY3W
         mY/wTVIUwzifIrIq7Ilh6Je59gUeTbYYdkxhU3cFSQtXlTcA4o1SKH44vb3PNth/wdSk
         s7HCOezS9uD2W6z3x5uMKqZk/OKkgTPcE9Duzk7LWARv1vB0Ls7JxzPx2hZi1OIdzElB
         Y/tw==
X-Gm-Message-State: ACrzQf3XZqtQsIvl26n8JRdQh3rsXA0GVnAe8O6xqGm8nsVNp/ja5oXN
        l4RSHhm8PrNdBL8JN8t5p0/UgsA=
X-Google-Smtp-Source: AMsMyM47ebAsEzwUAn3OZUYRv/xH9LjApLNEV+4bV+n1QnwW9qMixUy+IK32XKVdt8Kv1KgsuqwwQZ8=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a05:6a00:23c6:b0:563:a1e9:eab8 with SMTP id
 g6-20020a056a0023c600b00563a1e9eab8mr4762833pfc.16.1666119146322; Tue, 18 Oct
 2022 11:52:26 -0700 (PDT)
Date:   Tue, 18 Oct 2022 11:52:24 -0700
In-Reply-To: <20221018035646.1294873-3-andrii@kernel.org>
Mime-Version: 1.0
References: <20221018035646.1294873-1-andrii@kernel.org> <20221018035646.1294873-3-andrii@kernel.org>
Message-ID: <Y0716CgEDxLQFSOJ@google.com>
Subject: Re: [PATCH bpf-next 2/3] libbpf: only add BPF_F_MMAPABLE flag for
 data maps with global vars
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
> Teach libbpf to not add BPF_F_MMAPABLE flag unnecessarily for ARRAY maps
> that are backing data sections, if such data sections don't expose any
> variables to user-space. Exposed variables are those that have
> STB_GLOBAL or STB_WEAK ELF binding and correspond to BTF VAR's
> BTF_VAR_GLOBAL_ALLOCATED linkage.

> The overall idea is that if some data section doesn't have any variable  
> that
> is exposed through BPF skeleton, then there is no reason to make such
> BPF array mmapable. Making BPF array mmapable is not a free no-op
> action, because BPF verifier doesn't allow users to put special objects
> (such as BPF spin locks, RB tree nodes, linked list nodes, kptrs, etc;
> anything that has a sensitive internal state that should not be modified
> arbitrarily from user space) into mmapable arrays, as there is no way to
> prevent user space from corrupting such sensitive state through direct
> memory access through memory-mapped region.

> By making sure that libbpf doesn't add BPF_F_MMAPABLE flag to BPF array
> maps corresponding to data sections that only have static variables
> (which are not supposed to be visible to user space according to libbpf
> and BPF skeleton rules), users now can have spinlocks, kptrs, etc in
> either default .bss/.data sections or custom .data.* sections (assuming
> there are no global variables in such sections).

> The only possible hiccup with this approach is the need to use global
> variables during BPF static linking, even if it's not intended to be
> shared with user space through BPF skeleton. To allow such scenarios,
> extend libbpf's STV_HIDDEN ELF visibility attribute handling to
> variables. Libbpf is already treating global hidden BPF subprograms as
> static subprograms and adjusts BTF accordingly to make BPF verifier
> verify such subprograms as static subprograms with preserving entire BPF
> verifier state between subprog calls. This patch teaches libbpf to treat
> global hidden variables as static ones and adjust BTF information
> accordingly as well. This allows to share variables between multiple
> object files during static linking, but still keep them internal to BPF
> program and not get them exposed through BPF skeleton.

> Note, that if the user has some advanced scenario where they absolutely
> need BPF_F_MMAPABLE flag on .data/.bss/.rodata BPF array map despite
> only having static variables, they still can achieve this by forcing it
> through explicit bpf_map__set_map_flags() API.

> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Acked-by: Stanislav Fomichev <sdf@google.com>

Left a nit for spelling and the same 'log err vs size' question.


> ---
>   tools/lib/bpf/libbpf.c | 95 ++++++++++++++++++++++++++++++++++--------
>   1 file changed, 77 insertions(+), 18 deletions(-)

> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index a25eb8fe7bf2..c25d7a4f5704 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -1577,7 +1577,38 @@ static char *internal_map_name(struct bpf_object  
> *obj, const char *real_name)
>   }

>   static int
> -bpf_map_find_btf_info(struct bpf_object *obj, struct bpf_map *map);
> +map_fill_btf_type_info(struct bpf_object *obj, struct bpf_map *map);
> +
> +/* Internal BPF map is mmap()'able only if at least one of corresponding
> + * DATASEC's VARs are to be exposed through BPF skeleton. I.e., it's a  
> GLOBAL
> + * variable and it's not marked as __hidden (which turns it into,  
> effectively,
> + * a STATIC variable).
> + */
> +static bool map_is_mmapable(struct bpf_object *obj, struct bpf_map *map)
> +{
> +	const struct btf_type *t, *vt;
> +	struct btf_var_secinfo *vsi;
> +	int i, n;
> +
> +	if (!map->btf_value_type_id)
> +		return false;
> +
> +	t = btf__type_by_id(obj->btf, map->btf_value_type_id);
> +	if (!btf_is_datasec(t))
> +		return false;
> +
> +	vsi = btf_var_secinfos(t);
> +	for (i = 0, n = btf_vlen(t); i < n; i++, vsi++) {
> +		vt = btf__type_by_id(obj->btf, vsi->type);
> +		if (!btf_is_var(vt))
> +			continue;
> +
> +		if (btf_var(vt)->linkage != BTF_VAR_STATIC)
> +			return true;
> +	}
> +
> +	return false;
> +}

>   static int
>   bpf_object__init_internal_map(struct bpf_object *obj, enum  
> libbpf_map_type type,
> @@ -1609,7 +1640,12 @@ bpf_object__init_internal_map(struct bpf_object  
> *obj, enum libbpf_map_type type,
>   	def->max_entries = 1;
>   	def->map_flags = type == LIBBPF_MAP_RODATA || type == LIBBPF_MAP_KCONFIG
>   			 ? BPF_F_RDONLY_PROG : 0;
> -	def->map_flags |= BPF_F_MMAPABLE;
> +
> +	/* failures are fine because of maps like .rodata.str1.1 */
> +	(void) map_fill_btf_type_info(obj, map);
> +
> +	if (map_is_mmapable(obj, map))
> +		def->map_flags |= BPF_F_MMAPABLE;

>   	pr_debug("map '%s' (global data): at sec_idx %d, offset %zu,  
> flags %x.\n",
>   		 map->name, map->sec_idx, map->sec_offset, def->map_flags);
> @@ -1626,9 +1662,6 @@ bpf_object__init_internal_map(struct bpf_object  
> *obj, enum libbpf_map_type type,
>   		return err;
>   	}

> -	/* failures are fine because of maps like .rodata.str1.1 */
> -	(void) bpf_map_find_btf_info(obj, map);
> -
>   	if (data)
>   		memcpy(map->mmaped, data, data_sz);

> @@ -2540,7 +2573,7 @@ static int bpf_object__init_user_btf_map(struct  
> bpf_object *obj,
>   		fill_map_from_def(map->inner_map, &inner_def);
>   	}

> -	err = bpf_map_find_btf_info(obj, map);
> +	err = map_fill_btf_type_info(obj, map);
>   	if (err)
>   		return err;

> @@ -2848,6 +2881,7 @@ static int btf_fixup_datasec(struct bpf_object  
> *obj, struct btf *btf,
>   	__u32 size = 0, i, vars = btf_vlen(t);
>   	const char *sec_name = btf__name_by_offset(btf, t->name_off);
>   	struct btf_var_secinfo *vsi;
> +	bool fixup_offsets = false;
>   	int err;

>   	if (!sec_name) {
> @@ -2855,20 +2889,33 @@ static int btf_fixup_datasec(struct bpf_object  
> *obj, struct btf *btf,
>   		return -ENOENT;
>   	}

> -	/* extern-backing datasecs (.ksyms, .kconfig) have their size and
> -	 * variable offsets set at the previous step, so we skip any fixups
> -	 * for such sections
> +	/* Extern-backing datasecs (.ksyms, .kconfig) have their size and
> +	 * variable offsets set at the previous step. Further, not every
> +	 * extern BTF VAR has corresponding ELF symbol preserved, so we skip

[..]

> +	 * all fixups altogether for such sections and go straight to storting
> +	 * VARs within their DATASEC.

nit: s/storting/sorting/

>   	 */
> -	if (t->size)
> +	if (strcmp(sec_name, KCONFIG_SEC) == 0 || strcmp(sec_name, KSYMS_SEC)  
> == 0)
>   		goto sort_vars;

> -	err = find_elf_sec_sz(obj, sec_name, &size);
> -	if (err || !size) {
> -		pr_debug("sec '%s': invalid size %u bytes\n", sec_name, size);
> -		return -ENOENT;
> -	}
> +	/* Clang leaves DATASEC size and VAR offsets as zeroes, so we need to
> +	 * fix this up. But BPF static linker already fixes this up and fills
> +	 * all the sizes and offsets during static linking. So this step has
> +	 * to be optional. But the STV_HIDDEN handling is non-optional for any
> +	 * non-extern DATASEC, so the variable fixup loop below handles both
> +	 * functions at the same time, paying the cost of BTF VAR <-> ELF
> +	 * symbol matching just once.
> +	 */
> +	if (t->size == 0) {
> +		err = find_elf_sec_sz(obj, sec_name, &size);
> +		if (err || !size) {
> +			pr_debug("sec '%s': invalid size %u bytes\n", sec_name, size);

nit: same suggestion here - let's log err instead?

> +			return -ENOENT;
> +		}

> -	t->size = size;
> +		t->size = size;
> +		fixup_offsets = true;
> +	}

>   	for (i = 0, vsi = btf_var_secinfos(t); i < vars; i++, vsi++) {
>   		const struct btf_type *t_var;
> @@ -2900,7 +2947,19 @@ static int btf_fixup_datasec(struct bpf_object  
> *obj, struct btf *btf,
>   			return -ENOENT;
>   		}

> -		vsi->offset = sym->st_value;
> +		if (fixup_offsets)
> +			vsi->offset = sym->st_value;
> +
> +		/* if variable is a global/weak symbol, but has restricted
> +		 * (STV_HIDDEN or STV_INTERNAL) visibility, mark its BTF VAR
> +		 * as static. This follows similar logic for functions (BPF
> +		 * subprogs) and influences libbpf's further decisions about
> +		 * whether to make global data BPF array maps as
> +		 * BPF_F_MMAPABLE.
> +		 */
> +		if (ELF64_ST_VISIBILITY(sym->st_other) == STV_HIDDEN
> +		    || ELF64_ST_VISIBILITY(sym->st_other) == STV_INTERNAL)
> +			var->linkage = BTF_VAR_STATIC;
>   	}

>   sort_vars:
> @@ -4222,7 +4281,7 @@ bpf_object__collect_prog_relos(struct bpf_object  
> *obj, Elf64_Shdr *shdr, Elf_Dat
>   	return 0;
>   }

> -static int bpf_map_find_btf_info(struct bpf_object *obj, struct bpf_map  
> *map)
> +static int map_fill_btf_type_info(struct bpf_object *obj, struct bpf_map  
> *map)
>   {
>   	int id;

> --
> 2.30.2

