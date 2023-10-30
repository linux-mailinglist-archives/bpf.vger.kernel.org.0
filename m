Return-Path: <bpf+bounces-13632-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B5037DC088
	for <lists+bpf@lfdr.de>; Mon, 30 Oct 2023 20:31:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75DD81C20B1F
	for <lists+bpf@lfdr.de>; Mon, 30 Oct 2023 19:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE3961A271;
	Mon, 30 Oct 2023 19:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TVnkrdsv"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB0931A283
	for <bpf@vger.kernel.org>; Mon, 30 Oct 2023 19:31:16 +0000 (UTC)
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [IPv6:2001:41d0:1004:224b::ba])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D2A3A9
	for <bpf@vger.kernel.org>; Mon, 30 Oct 2023 12:31:13 -0700 (PDT)
Message-ID: <ce4cbfe1-fd20-413a-a3ad-d34bac38fca1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1698694272;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X6rnLlbF5iL4vNqgMUDdG9N0w/+t80XZWtldm8mpHM0=;
	b=TVnkrdsv70tTUNqKxSgSMB1FGyhA4DC5GC1hCrVhQLhF4Rh19zZvU1hlyOuMBtObNlLbd7
	0lRGYBiE1newfTLdqZxvhuyIAHOR2YPbM2GrS34omTZ+9i/m8bPkjnjj9W8kK6ztW/bYQc
	48nxREZewtQsKb5CcDSYyQY26kdt/XI=
Date: Mon, 30 Oct 2023 12:31:05 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v1 bpf-next 2/4] bpf: Refactor btf_find_field with
 btf_field_info_search
Content-Language: en-GB
To: Dave Marchevsky <davemarchevsky@fb.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@fb.com>
References: <20231023220030.2556229-1-davemarchevsky@fb.com>
 <20231023220030.2556229-3-davemarchevsky@fb.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20231023220030.2556229-3-davemarchevsky@fb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 10/23/23 3:00 PM, Dave Marchevsky wrote:
> btf_find_field takes (btf_type, special_field_types) and returns info
> about the specific special fields in btf_type, in the form of an array
> of struct btf_field info. The meat of this 'search for special fields'

struct btf_field_info.

> process happens in btf_find_datasec_var and btf_find_struct_field
> helpers: each member is examined and, if it's special, a struct
> btf_field_info describing it is added to the return array. Indeed, any
> function that might add to the output probably also looks at struct
> members or datasec vars.
>
> Most of the parameters passed around between helpers doing the search
> can be grouped into two categories: "info about the output array" and
> "info about which fields to search for". This patch joins those together
> in struct btf_field_info_search, simplifying the signatures of most
> helpers involved in the search, including array flattening helper that
> later patches in the series will add.
>
> The aforementioned array flattening logic will greatly increase the
> number of btf_field_info's needed to describe some structs, so this
> patch also turns the statically-sized struct btf_field_info
> info_arr[BTF_FIELDS_MAX] into a growable array with a larger max size.

Since this patch is a 'refactoring' patch, let us delay this patch
until the next one. This patch should be strictly a refactoring
patch so it becomes easier to verify changes.

>
> Implementation notes:
>    * BTF_FIELDS_MAX is now max size of growable btf_field_info *infos
>      instead of initial (and max) size of static result array
>      * Static array before had 10 elems (+1 tmp btf_field_info)
>      * growable array starts with 16 and doubles every time it needs to
>        grow, up to BTF_FIELDS_MAX of 256
>
>    * __next_field_infos is used with next_cnt > 1 later in the series
>
>    * btf_find_{datasec_var, struct_field} have special logic for an edge
>      case where the result array is full but the field being examined
>      gets BTF_FIELD_IGNORE return from btf_find_{struct, kptr,graph_root}
>      * If result wasn't BTF_FIELD_IGNORE, a btf_field_info would have to
>        be added to the array. Since it is we can look at next field.
>      * Before this patch the logic handling this edge case was hard to
>        follow and used a tmp btf_struct_info. This patch moves the
>        add-if-not-ignore logic down into btf_find_{struct, kptr,
>        graph_root}, removing the need to opportunistically grab a
>        btf_field_info to populate before knowing if it's actually
>        necessary. Now a new one is grabbed only if the field shouldn't
>        be ignored.

This extra 'tmp' btf_field_info approach sounds okay to me
in the original code. The previous code has a static size
and there is no realloc. Now you introduced realloc, so
removing extra 'tmp' seems do make sense.


>
>    * Within btf_find_{datasec_var, struct_field}, each member is
>      currently examined in two phases: first btf_get_field_type checks
>      the member type name, then btf_find_{struct,graph_root,kptr} do
>      additional sanity checking and populate struct btf_field_info. Kptr
>      fields don't have a specific type name, though, so
>      btf_get_field_type assumes that - if we're looking for kptrs - any
>      member that fails type name check could be a kptr field.
>      * As a result btf_find_kptr effectively does all the pointer
>        hopping, sanity checking, and info population. Instead of trying
>        to fit kptr handling into this two-phase model, where it's
>        unwieldy, handle it in a separate codepath when name matching
>        fails.
>
> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
> ---
>   include/linux/bpf.h |   4 +-
>   kernel/bpf/btf.c    | 331 +++++++++++++++++++++++++++++---------------
>   2 files changed, 219 insertions(+), 116 deletions(-)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index b4825d3cdb29..e07cac5cc3cf 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -171,8 +171,8 @@ struct bpf_map_ops {
>   };
>   
>   enum {
> -	/* Support at most 10 fields in a BTF type */
> -	BTF_FIELDS_MAX	   = 10,
> +	/* Support at most 256 fields in a BTF type */
> +	BTF_FIELDS_MAX	   = 256,
>   };
>   
>   enum btf_field_type {
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 975ef8e73393..e999ba85c363 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -3257,25 +3257,94 @@ struct btf_field_info {
>   	};
>   };
>   
> +struct btf_field_info_search {
> +	/* growable array. allocated in __next_field_infos
> +	 * free'd in btf_parse_fields
> +	 */
> +	struct btf_field_info *infos;
> +	/* size of infos */
> +	int info_cnt;
> +	/* index of next btf_field_info to populate */
> +	int idx;
> +
> +	/* btf_field_types to search for */
> +	u32 field_mask;
> +	/* btf_field_types found earlier */
> +	u32 seen_mask;
> +};
> +
> +/* Reserve next_cnt contiguous btf_field_info's for caller to populate
> + * Returns ptr to first reserved btf_field_info
> + */
> +static struct btf_field_info *__next_field_infos(struct btf_field_info_search *srch,
> +						 u32 next_cnt)
> +{
> +	struct btf_field_info *new_infos, *ret;
> +
> +	if (!next_cnt)
> +		return ERR_PTR(-EINVAL);

Looks next_cnt is never 0.

> +
> +	if (srch->idx + next_cnt < srch->info_cnt)
> +		goto nogrow_out;
> +
> +	/* Need to grow */
> +	if (srch->idx + next_cnt > BTF_FIELDS_MAX)
> +		return ERR_PTR(-E2BIG);
> +
> +	while (srch->idx + next_cnt >= srch->info_cnt)
> +		srch->info_cnt = srch->infos ? srch->info_cnt * 2 : 16;
> +
> +	new_infos = krealloc(srch->infos,
> +			     srch->info_cnt * sizeof(struct btf_field_info),
> +			     GFP_KERNEL | __GFP_NOWARN);
> +	if (!new_infos)
> +		return ERR_PTR(-ENOMEM);
> +	srch->infos = new_infos;
> +
> +nogrow_out:
> +	ret = &srch->infos[srch->idx];
> +	srch->idx += next_cnt;
> +	return ret;
> +}
> +
> +/* Request srch's next free btf_field_info to populate, possibly growing
> + * srch->infos
> + */
> +static struct btf_field_info *__next_field_info(struct btf_field_info_search *srch)
> +{
> +	return __next_field_infos(srch, 1);
> +}
> +
>   static int btf_find_struct(const struct btf *btf, const struct btf_type *t,
>   			   u32 off, int sz, enum btf_field_type field_type,
> -			   struct btf_field_info *info)
> +			   struct btf_field_info_search *srch)
>   {
> +	struct btf_field_info *info;
> +
>   	if (!__btf_type_is_struct(t))
>   		return BTF_FIELD_IGNORE;
>   	if (t->size != sz)
>   		return BTF_FIELD_IGNORE;
> +
> +	info = __next_field_info(srch);
> +	if (IS_ERR_OR_NULL(info))
> +		return PTR_ERR(info);

info cannot be NULL.

> +
>   	info->type = field_type;
>   	info->off = off;
>   	return BTF_FIELD_FOUND;
>   }
>   
> -static int btf_find_kptr(const struct btf *btf, const struct btf_type *t,
> -			 u32 off, int sz, struct btf_field_info *info)
> +static int btf_maybe_find_kptr(const struct btf *btf, const struct btf_type *t,
> +			       u32 off, struct btf_field_info_search *srch)
>   {
> +	struct btf_field_info *info;
>   	enum btf_field_type type;
>   	u32 res_id;
>   
> +	if (!(srch->field_mask & BPF_KPTR))
> +		return BTF_FIELD_IGNORE;
> +
>   	/* Permit modifiers on the pointer itself */
>   	if (btf_type_is_volatile(t))
>   		t = btf_type_by_id(btf, t->type);
> @@ -3304,6 +3373,10 @@ static int btf_find_kptr(const struct btf *btf, const struct btf_type *t,
>   	if (!__btf_type_is_struct(t))
>   		return -EINVAL;
>   
> +	info = __next_field_info(srch);
> +	if (IS_ERR_OR_NULL(info))
> +		return PTR_ERR(info);

info cannot be NULL.

> +
>   	info->type = type;
>   	info->off = off;
>   	info->kptr.type_id = res_id;
> @@ -3340,9 +3413,10 @@ const char *btf_find_decl_tag_value(const struct btf *btf, const struct btf_type
>   static int
>   btf_find_graph_root(const struct btf *btf, const struct btf_type *pt,
>   		    const struct btf_type *t, int comp_idx, u32 off,
> -		    int sz, struct btf_field_info *info,
> +		    int sz, struct btf_field_info_search *srch,
>   		    enum btf_field_type head_type)
>   {
> +	struct btf_field_info *info;
>   	const char *node_field_name;
>   	const char *value_type;
>   	s32 id;
> @@ -3367,6 +3441,11 @@ btf_find_graph_root(const struct btf *btf, const struct btf_type *pt,
>   	node_field_name++;
>   	if (str_is_empty(node_field_name))
>   		return -EINVAL;
> +
> +	info = __next_field_info(srch);
> +	if (IS_ERR_OR_NULL(info))
> +		return PTR_ERR(info);
> +

ditto.

>   	info->type = head_type;
>   	info->off = off;
>   	info->graph_root.value_btf_id = id;
> @@ -3374,25 +3453,24 @@ btf_find_graph_root(const struct btf *btf, const struct btf_type *pt,
>   	return BTF_FIELD_FOUND;
>   }
>   
> -#define field_mask_test_name(field_type, field_type_str)		\
> -	if (field_mask & field_type && !strcmp(name, field_type_str)) {	\
> -		type = field_type;					\
> -		goto end;						\
> +#define field_mask_test_name(field_type, field_type_str)			\
> +	if (srch->field_mask & field_type && !strcmp(name, field_type_str)) {	\
> +		return field_type;						\
>   	}
>   
> -#define field_mask_test_name_check_seen(field_type, field_type_str)	\
> -	if (field_mask & field_type && !strcmp(name, field_type_str)) {	\
> -		if (*seen_mask & field_type)				\
> -			return -E2BIG;					\
> -		*seen_mask |= field_type;				\
> -		type = field_type;					\
> -		goto end;						\
> +#define field_mask_test_name_check_seen(field_type, field_type_str)		\
> +	if (srch->field_mask & field_type && !strcmp(name, field_type_str)) {	\
> +		if (srch->seen_mask & field_type)				\
> +			return -E2BIG;						\
> +		srch->seen_mask |= field_type;					\
> +		return field_type;						\
>   	}
>   
> -static int btf_get_field_type(const char *name, u32 field_mask, u32 *seen_mask,
> -			      int *align, int *sz)

[...]


