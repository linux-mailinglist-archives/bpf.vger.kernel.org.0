Return-Path: <bpf+bounces-13639-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F5DF7DC16E
	for <lists+bpf@lfdr.de>; Mon, 30 Oct 2023 21:56:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F5421C20B87
	for <lists+bpf@lfdr.de>; Mon, 30 Oct 2023 20:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0712F1A70F;
	Mon, 30 Oct 2023 20:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AqFBqjek"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4700913AC4
	for <bpf@vger.kernel.org>; Mon, 30 Oct 2023 20:56:39 +0000 (UTC)
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [IPv6:2001:41d0:1004:224b::ab])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12CEFDD
	for <bpf@vger.kernel.org>; Mon, 30 Oct 2023 13:56:37 -0700 (PDT)
Message-ID: <2d795a03-aaef-403c-ad96-75fea0699137@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1698699395;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o+zcWnE27upTh2kUrSiXvwrej08zD3n1y1QbMtMGTXU=;
	b=AqFBqjekxWIo3AlXfhsl5VrlCqLtMXY7Zrj657dDxWB8+sqs4QOTvZsmnKL12zTeont5/B
	cJ4FCHZEHp0fh0l8Vipaqz1cd/fAGeRaJXtqM2mhQTudJqKCKaHp2vjzHWWdJ5tm372ISE
	P6+1QFE9nd96Zu6/OF3GWrWBx5/z+eY=
Date: Mon, 30 Oct 2023 13:56:27 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v1 bpf-next 3/4] btf: Descend into structs and arrays
 during special field search
Content-Language: en-GB
To: Dave Marchevsky <davemarchevsky@fb.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@fb.com>
References: <20231023220030.2556229-1-davemarchevsky@fb.com>
 <20231023220030.2556229-4-davemarchevsky@fb.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20231023220030.2556229-4-davemarchevsky@fb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 10/23/23 3:00 PM, Dave Marchevsky wrote:
> Structs and arrays are aggregate types which contain some inner
> type(s) - members and elements - at various offsets. Currently, when
> examining a struct or datasec for special fields, the verifier does
> not look into the inner type of the structs or arrays it contains.
> This patch adds logic to descend into struct and array types when
> searching for special fields.
This indeed a great improvement. Thanks!
>
> If we have struct x containing an array:
>
> struct x {
>    int a;
>    u64 b[10];
> };
>
> we can construct some struct y with no array or struct members that
> has the same types at the same offsets:
>
> struct y {
>    int a;
>    u64 b1;
>    u64 b2;
>    /* ... */
>    u64 b10;
> };
>
> Similarly for a struct containing a struct:
>
> struct x {
>    char a;
>    struct {
>      int b;
>      u64 c;
>    } inner;
> };
>
> there's a struct y with no aggregate members and same types/offsets:
>
> struct y {
>    char a;
>    int inner_b __attribute__ ((aligned (8))); /* See [0] */
>    u64 inner_c __attribute__ ((aligned (8)));
> };
>
> This patch takes advantage of this equivalence to 'flatten' the
> field info found while descending into struct or array members into
> the btf_field_info result array of the original type being examined.
> The resultant btf_record of the original type being searched will
> have the correct fields at the correct offsets, but without any
> differentiation between "this field is one of my members" and "this
> field is actually in my some struct / array member".
>
> For now this descendant search logic looks for kptr fields only.
>
> Implementation notes:
>    * Search starts at btf_find_field - we're either looking at a struct
>      that's the type of some mapval (btf_find_struct_field), or a
>      datasec representing a .bss or .data map (btf_find_datasec_var).
>      Newly-added btf_find_aggregate_field is a "disambiguation helper"
>      like btf_find_field, but is meant to be called from one of the
>      starting points of the search - btf_find_{struct_field,
>      datasec_var}.
>      * btf_find_aggregate_field may itself call btf_find_struct_field,
>        so there's some recursive digging possible here
>
>    * Newly-added btf_flatten_array_field handles array fields by
>      finding the type of their element and continuing the dig based on
>      elem type.
>
>    [0]:  Structs have the alignment of their largest field, so the
>          explicit alignment is necessary here. Luckily this patch's
>          changes don't need to care about alignment / padding, since
> 	the BTF created during compilation is being searched, and
> 	it already has the correct information.
>
> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
> ---
>   kernel/bpf/btf.c | 151 ++++++++++++++++++++++++++++++++++++++++++++---
>   1 file changed, 142 insertions(+), 9 deletions(-)
>
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index e999ba85c363..b982bf6fef9d 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -3496,9 +3496,41 @@ static int __struct_member_check_align(u32 off, enum btf_field_type field_type)
>   	return 0;
>   }
>   
> +/* Return number of elems and elem_type of a btf_array
> + *
> + * If the array is multi-dimensional, return elem count of
> + * equivalent single-dimensional array
> + *   e.g. int x[10][10][10] has same layout as int x[1000]
> + */
> +static u32 __multi_dim_elem_type_nelems(const struct btf *btf,
> +					const struct btf_type *t,
> +					const struct btf_type **elem_type)
> +{
> +	u32 nelems = btf_array(t)->nelems;
> +
> +	if (!nelems)
> +		return 0;
> +
> +	*elem_type = btf_type_by_id(btf, btf_array(t)->type);
> +
> +	while (btf_type_is_array(*elem_type)) {
> +		if (!btf_array(*elem_type)->nelems)
> +			return 0;

btf_array(*elem_type)->nelems == 0 is a very rare case.
I guess we do not need it here. If it is indeed 0,
the final nelems will be 0 any way.

> +		nelems *= btf_array(*elem_type)->nelems;
> +		*elem_type = btf_type_by_id(btf, btf_array(*elem_type)->type);
> +	}
> +	return nelems;
> +}
> +
> +static int btf_find_aggregate_field(const struct btf *btf,
> +				    const struct btf_type *t,
> +				    struct btf_field_info_search *srch,
> +				    int field_off, int rec);
> +
>   static int btf_find_struct_field(const struct btf *btf,
>   				 const struct btf_type *t,
> -				 struct btf_field_info_search *srch)
> +				 struct btf_field_info_search *srch,
> +				 int struct_field_off, int rec)
>   {
>   	const struct btf_member *member;
>   	int ret, field_type;
> @@ -3522,10 +3554,24 @@ static int btf_find_struct_field(const struct btf *btf,
>   			 * checks, all ptrs have same align.
>   			 * btf_maybe_find_kptr will find actual kptr type
>   			 */
> -			if (__struct_member_check_align(off, BPF_KPTR_REF))
> +			if (srch->field_mask & BPF_KPTR &&
> +			    !__struct_member_check_align(off, BPF_KPTR_REF)) {
> +				ret = btf_maybe_find_kptr(btf, member_type,
> +							  struct_field_off + off,
> +							  srch);
> +				if (ret < 0)
> +					return ret;
> +				if (ret == BTF_FIELD_FOUND)
> +					continue;
> +			}
> +
> +			if (!(btf_type_is_array(member_type) ||
> +			      __btf_type_is_struct(member_type)))
>   				continue;
>   
> -			ret = btf_maybe_find_kptr(btf, member_type, off, srch);
> +			ret = btf_find_aggregate_field(btf, member_type, srch,
> +						       struct_field_off + off,
> +						       rec);
>   			if (ret < 0)
>   				return ret;
>   			continue;
> @@ -3541,15 +3587,17 @@ static int btf_find_struct_field(const struct btf *btf,
>   		case BPF_LIST_NODE:
>   		case BPF_RB_NODE:
>   		case BPF_REFCOUNT:
> -			ret = btf_find_struct(btf, member_type, off, sz, field_type,
> -					      srch);
> +			ret = btf_find_struct(btf, member_type,
> +					      struct_field_off + off,
> +					      sz, field_type, srch);
>   			if (ret < 0)
>   				return ret;
>   			break;
>   		case BPF_LIST_HEAD:
>   		case BPF_RB_ROOT:
>   			ret = btf_find_graph_root(btf, t, member_type,
> -						  i, off, sz, srch, field_type);
> +						  i, struct_field_off + off, sz,
> +						  srch, field_type);
>   			if (ret < 0)
>   				return ret;
>   			break;
> @@ -3566,6 +3614,82 @@ static int btf_find_struct_field(const struct btf *btf,
>   	return srch->idx;
>   }
>   
> +static int btf_flatten_array_field(const struct btf *btf,
> +				   const struct btf_type *t,
> +				   struct btf_field_info_search *srch,
> +				   int array_field_off, int rec)
> +{
> +	int ret, start_idx, elem_field_cnt;
> +	const struct btf_type *elem_type;
> +	struct btf_field_info *info;
> +	u32 i, j, off, nelems;
> +
> +	if (!btf_type_is_array(t))
> +		return -EINVAL;
> +	nelems = __multi_dim_elem_type_nelems(btf, t, &elem_type);
> +	if (!nelems || !__btf_type_is_struct(elem_type))
> +		return srch->idx;
> +
> +	start_idx = srch->idx;
> +	ret = btf_find_struct_field(btf, elem_type, srch, array_field_off + off, rec);

As kerneltest bot mentioned, 'off' is undefined. The array_field_off
should equal the first array element struct_elem_off, right?
So I think here 'off' can be replaced with 0?

> +	if (ret < 0)
> +		return ret;
> +
> +	/* No btf_field_info's added */
> +	if (srch->idx == start_idx)
> +		return srch->idx;
> +
> +	elem_field_cnt = srch->idx - start_idx;
> +	info = __next_field_infos(srch, elem_field_cnt * (nelems - 1));
> +	if (IS_ERR_OR_NULL(info))
> +		return PTR_ERR(info);

What happens if nelems = 1?


> +
> +	/* Array elems after the first can copy first elem's btf_field_infos
> +	 * and adjust offset
> +	 */
> +	for (i = 1; i < nelems; i++) {
> +		memcpy(info, &srch->infos[start_idx],
> +		       elem_field_cnt * sizeof(struct btf_field_info));
> +		for (j = 0; j < elem_field_cnt; j++) {
> +			info->off += (i * elem_type->size);
> +			info++;
> +		}
> +	}
> +	return srch->idx;
> +}
> +
> [...]

