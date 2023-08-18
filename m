Return-Path: <bpf+bounces-8099-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2EE97812F4
	for <lists+bpf@lfdr.de>; Fri, 18 Aug 2023 20:38:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 639272824F4
	for <lists+bpf@lfdr.de>; Fri, 18 Aug 2023 18:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CF581ADCD;
	Fri, 18 Aug 2023 18:37:52 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A2B1AA91
	for <bpf@vger.kernel.org>; Fri, 18 Aug 2023 18:37:51 +0000 (UTC)
Received: from out-33.mta0.migadu.com (out-33.mta0.migadu.com [91.218.175.33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB3C73C3F
	for <bpf@vger.kernel.org>; Fri, 18 Aug 2023 11:37:47 -0700 (PDT)
Message-ID: <ee360b23-9768-9187-4eb0-d43b67bcd07c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1692383865;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CRtbzEOcAUIb/laczi85iO8kRgqkVo6tfQyNqujpJRo=;
	b=i1R0Fb2e4f1V+wvHOxE2wH0YfBO25lRcEq2QKCd9LIpIuNpGVwcBb+YDWZNn85WuitNxpa
	bjj3YCcZrWc/OCcGipLo4g25CwGkJn00oqBcly2xaCdR1N5pTHMqoZtTE+aH5JQT3/ugWs
	DhGUdx4cePeJ+KBfqpcv3/shxRK0Oj8=
Date: Fri, 18 Aug 2023 14:37:41 -0400
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 02/15] bpf: Add BPF_KPTR_PERCPU_REF as a field
 type
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
 Martin KaFai Lau <martin.lau@kernel.org>
References: <20230814172809.1361446-1-yonghong.song@linux.dev>
 <20230814172820.1362751-1-yonghong.song@linux.dev>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: David Marchevsky <david.marchevsky@linux.dev>
In-Reply-To: <20230814172820.1362751-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 8/14/23 1:28 PM, Yonghong Song wrote:
> BPF_KPTR_PERCPU_REF represents a percpu field type like below
> 
>   struct val_t {
>     ... fields ...
>   };
>   struct t {
>     ...
>     struct val_t __percpu *percpu_data_ptr;
>     ...
>   };
> 
> where
>   #define __percpu __attribute__((btf_type_tag("percpu")))

nit: Maybe this should be __percpu_kptr (and similar for the actual tag)?

I don't feel strongly about this. It's certainly less concise, but given that
existing docs mention kptrs a few times, and anyone using percpu kptrs can
probably be expected to have some familiarity with "normal" kptrs, making
it more clear to BPF program writers that their existing mental model of
what a kptr is and how it should be used seems beneficial.

> 
> While BPF_KPTR_REF points to a trusted kernel object or a trusted
> local object, BPF_KPTR_PERCPU_REF points to a trusted local
> percpu object.
> 
> This patch added basic support for BPF_KPTR_PERCPU_REF
> related to percpu field parsing, recording and free operations.
> BPF_KPTR_PERCPU_REF also supports the same map types
> as BPF_KPTR_REF does.
> 
> Note that unlike a local kptr, it is possible that
> a BPF_KTPR_PERCUP_REF struct may not contain any

nit: typo here ("BPF_KTPR_PERCUP_REF" -> "BPF_KPTR_PERCPU_REF")

> special fields like other kptr, bpf_spin_lock, bpf_list_head, etc.
> 
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---
>  include/linux/bpf.h  | 18 ++++++++++++------
>  kernel/bpf/btf.c     |  5 +++++
>  kernel/bpf/syscall.c |  7 ++++++-
>  3 files changed, 23 insertions(+), 7 deletions(-)
> 
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 60e80e90c37d..e6348fd0a785 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -180,14 +180,15 @@ enum btf_field_type {
>  	BPF_TIMER      = (1 << 1),
>  	BPF_KPTR_UNREF = (1 << 2),
>  	BPF_KPTR_REF   = (1 << 3),
> -	BPF_KPTR       = BPF_KPTR_UNREF | BPF_KPTR_REF,
> -	BPF_LIST_HEAD  = (1 << 4),
> -	BPF_LIST_NODE  = (1 << 5),
> -	BPF_RB_ROOT    = (1 << 6),
> -	BPF_RB_NODE    = (1 << 7),
> +	BPF_KPTR_PERCPU_REF   = (1 << 4),
> +	BPF_KPTR       = BPF_KPTR_UNREF | BPF_KPTR_REF | BPF_KPTR_PERCPU_REF,
> +	BPF_LIST_HEAD  = (1 << 5),
> +	BPF_LIST_NODE  = (1 << 6),
> +	BPF_RB_ROOT    = (1 << 7),
> +	BPF_RB_NODE    = (1 << 8),
>  	BPF_GRAPH_NODE_OR_ROOT = BPF_LIST_NODE | BPF_LIST_HEAD |
>  				 BPF_RB_NODE | BPF_RB_ROOT,
> -	BPF_REFCOUNT   = (1 << 8),
> +	BPF_REFCOUNT   = (1 << 9),
>  };
>  
>  typedef void (*btf_dtor_kfunc_t)(void *);
> @@ -300,6 +301,8 @@ static inline const char *btf_field_type_name(enum btf_field_type type)
>  	case BPF_KPTR_UNREF:
>  	case BPF_KPTR_REF:
>  		return "kptr";
> +	case BPF_KPTR_PERCPU_REF:
> +		return "kptr_percpu";
>  	case BPF_LIST_HEAD:
>  		return "bpf_list_head";
>  	case BPF_LIST_NODE:
> @@ -325,6 +328,7 @@ static inline u32 btf_field_type_size(enum btf_field_type type)
>  		return sizeof(struct bpf_timer);
>  	case BPF_KPTR_UNREF:
>  	case BPF_KPTR_REF:
> +	case BPF_KPTR_PERCPU_REF:
>  		return sizeof(u64);
>  	case BPF_LIST_HEAD:
>  		return sizeof(struct bpf_list_head);
> @@ -351,6 +355,7 @@ static inline u32 btf_field_type_align(enum btf_field_type type)
>  		return __alignof__(struct bpf_timer);
>  	case BPF_KPTR_UNREF:
>  	case BPF_KPTR_REF:
> +	case BPF_KPTR_PERCPU_REF:
>  		return __alignof__(u64);
>  	case BPF_LIST_HEAD:
>  		return __alignof__(struct bpf_list_head);
> @@ -389,6 +394,7 @@ static inline void bpf_obj_init_field(const struct btf_field *field, void *addr)
>  	case BPF_TIMER:
>  	case BPF_KPTR_UNREF:
>  	case BPF_KPTR_REF:
> +	case BPF_KPTR_PERCPU_REF:
>  		break;
>  	default:
>  		WARN_ON_ONCE(1);
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 249657c466dd..bc1792edc64e 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -3293,6 +3293,8 @@ static int btf_find_kptr(const struct btf *btf, const struct btf_type *t,
>  		type = BPF_KPTR_UNREF;
>  	else if (!strcmp("kptr", __btf_name_by_offset(btf, t->name_off)))
>  		type = BPF_KPTR_REF;
> +	else if (!strcmp("percpu", __btf_name_by_offset(btf, t->name_off)))
> +		type = BPF_KPTR_PERCPU_REF;
>  	else
>  		return -EINVAL;
>  
> @@ -3457,6 +3459,7 @@ static int btf_find_struct_field(const struct btf *btf,
>  			break;
>  		case BPF_KPTR_UNREF:
>  		case BPF_KPTR_REF:
> +		case BPF_KPTR_PERCPU_REF:
>  			ret = btf_find_kptr(btf, member_type, off, sz,
>  					    idx < info_cnt ? &info[idx] : &tmp);
>  			if (ret < 0)
> @@ -3523,6 +3526,7 @@ static int btf_find_datasec_var(const struct btf *btf, const struct btf_type *t,
>  			break;
>  		case BPF_KPTR_UNREF:
>  		case BPF_KPTR_REF:
> +		case BPF_KPTR_PERCPU_REF:
>  			ret = btf_find_kptr(btf, var_type, off, sz,
>  					    idx < info_cnt ? &info[idx] : &tmp);
>  			if (ret < 0)
> @@ -3783,6 +3787,7 @@ struct btf_record *btf_parse_fields(const struct btf *btf, const struct btf_type
>  			break;
>  		case BPF_KPTR_UNREF:
>  		case BPF_KPTR_REF:
> +		case BPF_KPTR_PERCPU_REF:
>  			ret = btf_parse_kptr(btf, &rec->fields[i], &info_arr[i]);
>  			if (ret < 0)
>  				goto end;
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 7f4e8c357a6a..1c30b6ee84d4 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -514,6 +514,7 @@ void btf_record_free(struct btf_record *rec)
>  		switch (rec->fields[i].type) {
>  		case BPF_KPTR_UNREF:
>  		case BPF_KPTR_REF:
> +		case BPF_KPTR_PERCPU_REF:
>  			if (rec->fields[i].kptr.module)
>  				module_put(rec->fields[i].kptr.module);
>  			btf_put(rec->fields[i].kptr.btf);
> @@ -560,6 +561,7 @@ struct btf_record *btf_record_dup(const struct btf_record *rec)
>  		switch (fields[i].type) {
>  		case BPF_KPTR_UNREF:
>  		case BPF_KPTR_REF:
> +		case BPF_KPTR_PERCPU_REF:
>  			btf_get(fields[i].kptr.btf);
>  			if (fields[i].kptr.module && !try_module_get(fields[i].kptr.module)) {
>  				ret = -ENXIO;
> @@ -650,6 +652,7 @@ void bpf_obj_free_fields(const struct btf_record *rec, void *obj)
>  			WRITE_ONCE(*(u64 *)field_ptr, 0);
>  			break;
>  		case BPF_KPTR_REF:
> +		case BPF_KPTR_PERCPU_REF:
>  			xchgd_field = (void *)xchg((unsigned long *)field_ptr, 0);
>  			if (!xchgd_field)
>  				break;
> @@ -657,7 +660,8 @@ void bpf_obj_free_fields(const struct btf_record *rec, void *obj)
>  			if (!btf_is_kernel(field->kptr.btf)) {
>  				pointee_struct_meta = btf_find_struct_meta(field->kptr.btf,
>  									   field->kptr.btf_id);
> -				WARN_ON_ONCE(!pointee_struct_meta);
> +				if (field->type != BPF_KPTR_PERCPU_REF)
> +					WARN_ON_ONCE(!pointee_struct_meta);
>  				migrate_disable();
>  				__bpf_obj_drop_impl(xchgd_field, pointee_struct_meta ?
>  								 pointee_struct_meta->record :
> @@ -1046,6 +1050,7 @@ static int map_check_btf(struct bpf_map *map, const struct btf *btf,
>  				break;
>  			case BPF_KPTR_UNREF:
>  			case BPF_KPTR_REF:
> +			case BPF_KPTR_PERCPU_REF:
>  			case BPF_REFCOUNT:
>  				if (map->map_type != BPF_MAP_TYPE_HASH &&
>  				    map->map_type != BPF_MAP_TYPE_PERCPU_HASH &&

