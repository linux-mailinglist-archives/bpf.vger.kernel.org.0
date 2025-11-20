Return-Path: <bpf+bounces-75194-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 72483C7662D
	for <lists+bpf@lfdr.de>; Thu, 20 Nov 2025 22:36:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4B2BA4E3E95
	for <lists+bpf@lfdr.de>; Thu, 20 Nov 2025 21:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7F6B2698AF;
	Thu, 20 Nov 2025 21:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mtzZcAuf"
X-Original-To: bpf@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227281C84A6
	for <bpf@vger.kernel.org>; Thu, 20 Nov 2025 21:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763674477; cv=none; b=Q02Oz84W29v7hFnuU3WbkXOphngOUr9Hq3lqiRlS/PToNmka54Nvtk+ELVIhZmEr3m2r/080i8HXwpCU7F2g6TR0uAYri42UtSeHCSBiy/q27GiDYU+nX4ZEHxydGAxgLoQ1IslpBFMjDCrHQQR766EijJqDzFvmQ/TgHXM/BhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763674477; c=relaxed/simple;
	bh=N7x50i7KcfSScKRxpRjZwtrC3QRyEo9BV+xbqFxd+sY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LbW/fmF6BH/jeK0OfwJ4Ll0MXStX+sX1x7z6PzLYiL6wqX+zucgjWT8xace2ek5caA0aF58MVOmNJCFjWkFXOmwzXXDx8M5DipfY4S+0b2QDhP1ZEFPApsUe/wZy5Q/ve1xSIRV+TkyE3GRwqdZ+dZpzYfVwSDmavlAnBbATI0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mtzZcAuf; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <854f468a-d178-40f4-aa03-e19ff82a1a35@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763674461;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TY7+IAWtWdlHkX3dX0jOuatNuojKP/f2kh+RpE7l+Og=;
	b=mtzZcAufNiTyUYfd0Lz//De4gQi+dQ4dxoAYLoL5PZ0ybHAVtY/rvgiJPmI9BKTmt47FpK
	PLBIm7kOPNO6E6wcpwBeoHZzPjPsdj4Qstwld8ghMWlkeWunk0lekIkDNyl2DaQeyew06h
	PLA0SLSn/Zzo6IyNN/2ASJZR8BjnSNo=
Date: Thu, 20 Nov 2025 13:34:14 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH v7 3/7] tools/resolve_btfids: Add --btf_sort option
 for BTF name sorting
To: Donglin Peng <dolinux.peng@gmail.com>, ast@kernel.org,
 andrii.nakryiko@gmail.com
Cc: eddyz87@gmail.com, zhangxiaoqin@xiaomi.com, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, Donglin Peng <pengdonglin@xiaomi.com>,
 Alan Maguire <alan.maguire@oracle.com>, Song Liu <song@kernel.org>
References: <20251119031531.1817099-1-dolinux.peng@gmail.com>
 <20251119031531.1817099-4-dolinux.peng@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <20251119031531.1817099-4-dolinux.peng@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 11/18/25 7:15 PM, Donglin Peng wrote:
> From: Donglin Peng <pengdonglin@xiaomi.com>
> 
> This patch introduces a new --btf_sort option that leverages libbpf's
> btf__permute interface to reorganize BTF layout. The implementation
> sorts BTF types by name in ascending order, placing anonymous types at
> the end to enable efficient binary search lookup.
> 
> Cc: Eduard Zingerman <eddyz87@gmail.com>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> Cc: Alan Maguire <alan.maguire@oracle.com>
> Cc: Song Liu <song@kernel.org>
> Cc: Xiaoqin Zhang <zhangxiaoqin@xiaomi.com>
> Signed-off-by: Donglin Peng <pengdonglin@xiaomi.com>
> ---
>  scripts/Makefile.btf            |   2 +
>  scripts/Makefile.modfinal       |   1 +
>  scripts/link-vmlinux.sh         |   1 +
>  tools/bpf/resolve_btfids/main.c | 200 ++++++++++++++++++++++++++++++++
>  4 files changed, 204 insertions(+)
> 
> diff --git a/scripts/Makefile.btf b/scripts/Makefile.btf
> index db76335dd917..d5eb4ee70e88 100644
> --- a/scripts/Makefile.btf
> +++ b/scripts/Makefile.btf
> @@ -27,6 +27,7 @@ pahole-flags-$(call test-ge, $(pahole-ver), 130) += --btf_features=attributes
>  
>  ifneq ($(KBUILD_EXTMOD),)
>  module-pahole-flags-$(call test-ge, $(pahole-ver), 128) += --btf_features=distilled_base
> +module-resolve_btfid-flags-y = --distilled_base
>  endif
>  
>  endif
> @@ -35,3 +36,4 @@ pahole-flags-$(CONFIG_PAHOLE_HAS_LANG_EXCLUDE)		+= --lang_exclude=rust
>  
>  export PAHOLE_FLAGS := $(pahole-flags-y)
>  export MODULE_PAHOLE_FLAGS := $(module-pahole-flags-y)
> +export MODULE_RESOLVE_BTFID_FLAGS := $(module-resolve_btfid-flags-y)
> diff --git a/scripts/Makefile.modfinal b/scripts/Makefile.modfinal
> index 542ba462ed3e..4481dda2f485 100644
> --- a/scripts/Makefile.modfinal
> +++ b/scripts/Makefile.modfinal
> @@ -40,6 +40,7 @@ quiet_cmd_btf_ko = BTF [M] $@
>  		printf "Skipping BTF generation for %s due to unavailability of vmlinux\n" $@ 1>&2; \
>  	else								\
>  		LLVM_OBJCOPY="$(OBJCOPY)" $(PAHOLE) -J $(PAHOLE_FLAGS) $(MODULE_PAHOLE_FLAGS) --btf_base $(objtree)/vmlinux $@; \
> +		$(RESOLVE_BTFIDS) -b $(objtree)/vmlinux $(MODULE_RESOLVE_BTFID_FLAGS) --btf_sort $@;	\
>  		$(RESOLVE_BTFIDS) -b $(objtree)/vmlinux $@;		\
>  	fi;
>  
> diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
> index 433849ff7529..f21f6300815b 100755
> --- a/scripts/link-vmlinux.sh
> +++ b/scripts/link-vmlinux.sh
> @@ -288,6 +288,7 @@ if is_enabled CONFIG_DEBUG_INFO_BTF; then
>  	if is_enabled CONFIG_WERROR; then
>  		RESOLVE_BTFIDS_ARGS=" --fatal_warnings "
>  	fi
> +	${RESOLVE_BTFIDS} ${RESOLVE_BTFIDS_ARGS} --btf_sort "${VMLINUX}"
>  	${RESOLVE_BTFIDS} ${RESOLVE_BTFIDS_ARGS} "${VMLINUX}"
>  fi
>  
> diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/main.c
> index d47191c6e55e..dc0badd6f375 100644
> --- a/tools/bpf/resolve_btfids/main.c
> +++ b/tools/bpf/resolve_btfids/main.c
> @@ -768,6 +768,195 @@ static int symbols_patch(struct object *obj)
>  	return err < 0 ? -1 : 0;
>  }
>  
> +/* Anonymous types (with empty names) are considered greater than named types
> + * and are sorted after them. Two anonymous types are considered equal. Named
> + * types are compared lexicographically.
> + */
> +static int cmp_type_names(const void *a, const void *b, void *priv)
> +{
> +	struct btf *btf = (struct btf *)priv;
> +	const struct btf_type *ta = btf__type_by_id(btf, *(__u32 *)a);
> +	const struct btf_type *tb = btf__type_by_id(btf, *(__u32 *)b);
> +	const char *na, *nb;
> +
> +	if (!ta->name_off && tb->name_off)
> +		return 1;
> +	if (ta->name_off && !tb->name_off)
> +		return -1;
> +	if (!ta->name_off && !tb->name_off)
> +		return 0;
> +
> +	na = btf__str_by_offset(btf, ta->name_off);
> +	nb = btf__str_by_offset(btf, tb->name_off);
> +	return strcmp(na, nb);
> +}
> +
> +static int update_btf_section(const char *path, const struct btf *btf,

Hi Dongling.

Thanks for working on this, it's a great optimization. Just want to
give you a heads up that I am preparing a patchset changing
resolve_btfids behavior.

In particular, instead of updating the .BTF_ids section (and now with
your and upcoming changes the .BTF section) *in-place*, resolve_btfids
will only emit the data for the sections. And then it'll be integrated
into vmlinux with objcopy and linker. We already do a similar thing
with .BTF for vmlinux [1].

For your patchset it means that the parts handling ELF update will be
unnecessary.

Also I think the --btf_sort flag is unnecessary. We probably want
kernel BTF to always be sorted in this way. And if resolve_btfids will
be handling more btf2btf transformation, we should avoid adding a
flags for every one of them.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/tree/scripts/link-vmlinux.sh#n110


> +				  const char *btf_secname)
> +{
> +	GElf_Shdr shdr_mem, *shdr;
> +	Elf_Data *btf_data = NULL;
> +	Elf_Scn *scn = NULL;
> +	Elf *elf = NULL;
> +	const void *raw_btf_data;
> +	uint32_t raw_btf_size;
> +	int fd, err = -1;
> +	size_t strndx;
> +
> +	fd = open(path, O_RDWR);
> +	if (fd < 0) {
> +		pr_err("FAILED to open %s\n", path);
> +		return -1;
> +	}
> +
> +	if (elf_version(EV_CURRENT) == EV_NONE) {
> +		pr_err("FAILED to set libelf version");
> +		goto out;
> +	}
> +
> +	elf = elf_begin(fd, ELF_C_RDWR, NULL);
> +	if (elf == NULL) {
> +		pr_err("FAILED to update ELF file");
> +		goto out;
> +	}
> +
> +	elf_flagelf(elf, ELF_C_SET, ELF_F_LAYOUT);
> +
> +	elf_getshdrstrndx(elf, &strndx);
> +	while ((scn = elf_nextscn(elf, scn)) != NULL) {
> +		char *secname;
> +
> +		shdr = gelf_getshdr(scn, &shdr_mem);
> +		if (shdr == NULL)
> +			continue;
> +		secname = elf_strptr(elf, strndx, shdr->sh_name);
> +		if (strcmp(secname, btf_secname) == 0) {
> +			btf_data = elf_getdata(scn, btf_data);
> +			break;
> +		}
> +	}
> +
> +	raw_btf_data = btf__raw_data(btf, &raw_btf_size);
> +
> +	if (btf_data) {
> +		if (raw_btf_size != btf_data->d_size) {
> +			pr_err("FAILED: size mismatch");
> +			goto out;
> +		}
> +
> +		btf_data->d_buf = (void *)raw_btf_data;
> +		btf_data->d_type = ELF_T_WORD;
> +		elf_flagdata(btf_data, ELF_C_SET, ELF_F_DIRTY);
> +
> +		if (elf_update(elf, ELF_C_WRITE) >= 0)
> +			err = 0;
> +	}
> +
> +out:
> +	if (fd != -1)
> +		close(fd);
> +	if (elf)
> +		elf_end(elf);
> +	return err;
> +}
> +
> +static int sort_update_btf(struct object *obj, bool distilled_base)
> +{
> +	struct btf *base_btf = NULL;
> +	struct btf *btf = NULL;
> +	int start_id = 1, nr_types, id;
> +	int err = 0, i;
> +	__u32 *permute_ids = NULL, *id_map = NULL, btf_size;
> +	const void *btf_data;
> +	int fd;
> +
> +	if (obj->base_btf_path) {
> +		base_btf = btf__parse(obj->base_btf_path, NULL);
> +		err = libbpf_get_error(base_btf);
> +		if (err) {
> +			pr_err("FAILED: load base BTF from %s: %s\n",
> +			       obj->base_btf_path, strerror(-err));
> +			return -1;
> +		}
> +	}
> +
> +	btf = btf__parse_elf_split(obj->path, base_btf);
> +	err = libbpf_get_error(btf);
> +	if (err) {
> +		pr_err("FAILED: load BTF from %s: %s\n", obj->path, strerror(-err));
> +		goto out;
> +	}
> +
> +	if (base_btf)
> +		start_id = btf__type_cnt(base_btf);
> +	nr_types = btf__type_cnt(btf) - start_id;
> +	if (nr_types < 2)
> +		goto out;
> +
> +	permute_ids = calloc(nr_types, sizeof(*permute_ids));
> +	if (!permute_ids) {
> +		err = -ENOMEM;
> +		goto out;
> +	}
> +
> +	id_map = calloc(nr_types, sizeof(*id_map));
> +	if (!id_map) {
> +		err = -ENOMEM;
> +		goto out;
> +	}
> +
> +	for (i = 0, id = start_id; i < nr_types; i++, id++)
> +		permute_ids[i] = id;
> +
> +	qsort_r(permute_ids, nr_types, sizeof(*permute_ids), cmp_type_names, btf);
> +
> +	for (i = 0; i < nr_types; i++) {
> +		id = permute_ids[i] - start_id;
> +		id_map[id] = i + start_id;
> +	}
> +
> +	err = btf__permute(btf, id_map, nr_types, NULL);
> +	if (err) {
> +		pr_err("FAILED: btf permute: %s\n", strerror(-err));
> +		goto out;
> +	}
> +
> +	if (distilled_base) {
> +		struct btf *new_btf = NULL, *distilled_base = NULL;
> +
> +		if (btf__distill_base(btf, &distilled_base, &new_btf) < 0) {
> +			pr_err("FAILED to generate distilled base BTF: %s\n",
> +				strerror(errno));
> +			goto out;
> +		}
> +
> +		err = update_btf_section(obj->path, new_btf, BTF_ELF_SEC);
> +		if (!err) {
> +			err = update_btf_section(obj->path, distilled_base, BTF_BASE_ELF_SEC);
> +			if (err < 0)
> +				pr_err("FAILED to update '%s'\n", BTF_BASE_ELF_SEC);
> +		} else {
> +			pr_err("FAILED to update '%s'\n", BTF_ELF_SEC);
> +		}
> +
> +		btf__free(new_btf);
> +		btf__free(distilled_base);
> +	} else {
> +		err = update_btf_section(obj->path, btf, BTF_ELF_SEC);
> +		if (err < 0) {
> +			pr_err("FAILED to update '%s'\n", BTF_ELF_SEC);
> +			goto out;
> +		}
> +	}
> +
> +out:
> +	free(permute_ids);
> +	free(id_map);
> +	btf__free(base_btf);
> +	btf__free(btf);
> +	return err;
> +}
> +
>  static const char * const resolve_btfids_usage[] = {
>  	"resolve_btfids [<options>] <ELF object>",
>  	NULL
> @@ -787,6 +976,8 @@ int main(int argc, const char **argv)
>  		.sets     = RB_ROOT,
>  	};
>  	bool fatal_warnings = false;
> +	bool btf_sort = false;
> +	bool distilled_base = false;
>  	struct option btfid_options[] = {
>  		OPT_INCR('v', "verbose", &verbose,
>  			 "be more verbose (show errors, etc)"),
> @@ -796,6 +987,10 @@ int main(int argc, const char **argv)
>  			   "path of file providing base BTF"),
>  		OPT_BOOLEAN(0, "fatal_warnings", &fatal_warnings,
>  			    "turn warnings into errors"),
> +		OPT_BOOLEAN(0, "btf_sort", &btf_sort,
> +			    "sort BTF by name in ascending order"),
> +		OPT_BOOLEAN(0, "distilled_base", &distilled_base,
> +			    "distill base"),
>  		OPT_END()
>  	};
>  	int err = -1;
> @@ -807,6 +1002,11 @@ int main(int argc, const char **argv)
>  
>  	obj.path = argv[0];
>  
> +	if (btf_sort) {
> +		err = sort_update_btf(&obj, distilled_base);
> +		goto out;
> +	}
> +
>  	if (elf_collect(&obj))
>  		goto out;
>  


