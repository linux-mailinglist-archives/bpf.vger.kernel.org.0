Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB42F645156
	for <lists+bpf@lfdr.de>; Wed,  7 Dec 2022 02:41:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbiLGBlo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 6 Dec 2022 20:41:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbiLGBlc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 6 Dec 2022 20:41:32 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30B99528A5
        for <bpf@vger.kernel.org>; Tue,  6 Dec 2022 17:41:29 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id t17so16169481pjo.3
        for <bpf@vger.kernel.org>; Tue, 06 Dec 2022 17:41:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HHVdp3GrwrYWH1Z2JPTxom1kFQzxvjnPxuOO4FlbnY4=;
        b=evSest2tyEGZKDuQNOCLfDpKI8uGN/uKD4SQ2V8ewewMS+Qt9wIVbgI+Qvj6CJwpGf
         7Sit1Z5V6kQQHahBYFildH31m4yk0fjK22BsWAYAMF/QSGzyZx4u/hUtdyfr/jIO/Jom
         kXztq6qoXMbqE61/9438Y2+PtzQK9Z+y1F3klSvo6Bdw2A2ivqZtkB8KILo+a3hwMmp2
         gYZHEe5yk+lF7bRXURZdfYjC8T6X/k3QIbFM0Kg39lOimgQJhCCq1owrynytU/jubpqz
         KmjTRhKEpuBF0x98uJV3AF2dWljSSf37pNqnvSPWnSZYFqrXSNJQjihiQioIb/YOrIRq
         bflg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HHVdp3GrwrYWH1Z2JPTxom1kFQzxvjnPxuOO4FlbnY4=;
        b=XLIm8+uoljdG7FuecfE/1PFTTx247qnmBZ/CALEUdrHEzgehQlY75Go4bQgfiDinXP
         i98o7gL/lKuDK39c4sZhhpXX2h30Xq0bT3i4wrpCTW3WRkyUEJbU4qOoEXRj2/nfCXCQ
         1Ro4djLCAq7u6w6MC8GLNZjGx2dwBd7EHtmqlzsZYUl0s4ph31Vuok8Y+8j4xZ7tlpOD
         pMW7weEP6rxYmrAykDbqOC9kDxJ1XBGW3IG0ZVWmE15iyf5YjvtxOptoGPrZjCI79LKh
         vZflwRbNPp+f8itAANQPH34IIeuB0FsCjSX9pD6wTmXE8q2fyC3kJrSIP6XM6sNm8t19
         yKig==
X-Gm-Message-State: ANoB5pmT/ec563fY9QJ2zsSe0DGRiCn+/hfHRiQG5OqgyPoeKeyBEtKV
        81T2A9XBDgfvDd3JimjE3+g=
X-Google-Smtp-Source: AA0mqf4lnyJ6caF06oznHNoNO8F0FUtvJhfhr+KH5u/dF+CesRCelHVpT4IWLFusxqHzIQimOwwGPg==
X-Received: by 2002:a17:903:2305:b0:189:d342:c41b with SMTP id d5-20020a170903230500b00189d342c41bmr747631plh.30.1670377288496;
        Tue, 06 Dec 2022 17:41:28 -0800 (PST)
Received: from macbook-pro-6.dhcp.thefacebook.com ([2620:10d:c090:400::5:11da])
        by smtp.gmail.com with ESMTPSA id jw17-20020a170903279100b001868d4600b8sm13234949plb.158.2022.12.06.17.41.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 17:41:27 -0800 (PST)
Date:   Tue, 6 Dec 2022 17:41:23 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Dave Marchevsky <davemarchevsky@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH bpf-next 04/13] bpf: rename list_head ->
 datastructure_head in field info types
Message-ID: <Y4/vQ11buRVt4CBL@macbook-pro-6.dhcp.thefacebook.com>
References: <20221206231000.3180914-1-davemarchevsky@fb.com>
 <20221206231000.3180914-5-davemarchevsky@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221206231000.3180914-5-davemarchevsky@fb.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Dec 06, 2022 at 03:09:51PM -0800, Dave Marchevsky wrote:
> Many of the structs recently added to track field info for linked-list
> head are useful as-is for rbtree root. So let's do a mechanical renaming
> of list_head-related types and fields:
> 
> include/linux/bpf.h:
>   struct btf_field_list_head -> struct btf_field_datastructure_head
>   list_head -> datastructure_head in struct btf_field union
> kernel/bpf/btf.c:
>   list_head -> datastructure_head in struct btf_field_info

Looking through this patch and others it eventually becomes
confusing with 'datastructure head' name.
I'm not sure what is 'head' of the data structure.
There is head in the link list, but 'head of tree' is odd.

The attemp here is to find a common name that represents programming
concept where there is a 'root' and there are 'nodes' that added to that 'root'.
The 'data structure' name is too broad in that sense.
Especially later it becomes 'datastructure_api' which is even broader.

I was thinking to propose:
 struct btf_field_list_head -> struct btf_field_tree_root
 list_head -> tree_root in struct btf_field union

and is_kfunc_tree_api later...
since link list is a tree too.

But reading 'tree' next to other names like 'field', 'kfunc'
it might be mistaken that 'tree' applies to the former.
So I think using 'graph' as more general concept to describe both
link list and rb-tree would be the best.

So the proposal:
 struct btf_field_list_head -> struct btf_field_graph_root
 list_head -> graph_root in struct btf_field union

and is_kfunc_graph_api later...

'graph' is short enough and rarely used in names,
so it stands on its own next to 'field' and in combination
with other names.
wdyt?

> 
> This is a nonfunctional change, functionality to actually use these
> fields for rbtree will be added in further patches.
> 
> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
> ---
>  include/linux/bpf.h   |  4 ++--
>  kernel/bpf/btf.c      | 21 +++++++++++----------
>  kernel/bpf/helpers.c  |  4 ++--
>  kernel/bpf/verifier.c | 21 +++++++++++----------
>  4 files changed, 26 insertions(+), 24 deletions(-)
> 
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 4920ac252754..9e8b12c7061e 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -189,7 +189,7 @@ struct btf_field_kptr {
>  	u32 btf_id;
>  };
>  
> -struct btf_field_list_head {
> +struct btf_field_datastructure_head {
>  	struct btf *btf;
>  	u32 value_btf_id;
>  	u32 node_offset;
> @@ -201,7 +201,7 @@ struct btf_field {
>  	enum btf_field_type type;
>  	union {
>  		struct btf_field_kptr kptr;
> -		struct btf_field_list_head list_head;
> +		struct btf_field_datastructure_head datastructure_head;
>  	};
>  };
>  
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index c80bd8709e69..284e3e4b76b7 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -3227,7 +3227,7 @@ struct btf_field_info {
>  		struct {
>  			const char *node_name;
>  			u32 value_btf_id;
> -		} list_head;
> +		} datastructure_head;
>  	};
>  };
>  
> @@ -3334,8 +3334,8 @@ static int btf_find_list_head(const struct btf *btf, const struct btf_type *pt,
>  		return -EINVAL;
>  	info->type = BPF_LIST_HEAD;
>  	info->off = off;
> -	info->list_head.value_btf_id = id;
> -	info->list_head.node_name = list_node;
> +	info->datastructure_head.value_btf_id = id;
> +	info->datastructure_head.node_name = list_node;
>  	return BTF_FIELD_FOUND;
>  }
>  
> @@ -3603,13 +3603,14 @@ static int btf_parse_list_head(const struct btf *btf, struct btf_field *field,
>  	u32 offset;
>  	int i;
>  
> -	t = btf_type_by_id(btf, info->list_head.value_btf_id);
> +	t = btf_type_by_id(btf, info->datastructure_head.value_btf_id);
>  	/* We've already checked that value_btf_id is a struct type. We
>  	 * just need to figure out the offset of the list_node, and
>  	 * verify its type.
>  	 */
>  	for_each_member(i, t, member) {
> -		if (strcmp(info->list_head.node_name, __btf_name_by_offset(btf, member->name_off)))
> +		if (strcmp(info->datastructure_head.node_name,
> +			   __btf_name_by_offset(btf, member->name_off)))
>  			continue;
>  		/* Invalid BTF, two members with same name */
>  		if (n)
> @@ -3626,9 +3627,9 @@ static int btf_parse_list_head(const struct btf *btf, struct btf_field *field,
>  		if (offset % __alignof__(struct bpf_list_node))
>  			return -EINVAL;
>  
> -		field->list_head.btf = (struct btf *)btf;
> -		field->list_head.value_btf_id = info->list_head.value_btf_id;
> -		field->list_head.node_offset = offset;
> +		field->datastructure_head.btf = (struct btf *)btf;
> +		field->datastructure_head.value_btf_id = info->datastructure_head.value_btf_id;
> +		field->datastructure_head.node_offset = offset;
>  	}
>  	if (!n)
>  		return -ENOENT;
> @@ -3735,11 +3736,11 @@ int btf_check_and_fixup_fields(const struct btf *btf, struct btf_record *rec)
>  
>  		if (!(rec->fields[i].type & BPF_LIST_HEAD))
>  			continue;
> -		btf_id = rec->fields[i].list_head.value_btf_id;
> +		btf_id = rec->fields[i].datastructure_head.value_btf_id;
>  		meta = btf_find_struct_meta(btf, btf_id);
>  		if (!meta)
>  			return -EFAULT;
> -		rec->fields[i].list_head.value_rec = meta->record;
> +		rec->fields[i].datastructure_head.value_rec = meta->record;
>  
>  		if (!(rec->field_mask & BPF_LIST_NODE))
>  			continue;
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index cca642358e80..6c67740222c2 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -1737,12 +1737,12 @@ void bpf_list_head_free(const struct btf_field *field, void *list_head,
>  	while (head != orig_head) {
>  		void *obj = head;
>  
> -		obj -= field->list_head.node_offset;
> +		obj -= field->datastructure_head.node_offset;
>  		head = head->next;
>  		/* The contained type can also have resources, including a
>  		 * bpf_list_head which needs to be freed.
>  		 */
> -		bpf_obj_free_fields(field->list_head.value_rec, obj);
> +		bpf_obj_free_fields(field->datastructure_head.value_rec, obj);
>  		/* bpf_mem_free requires migrate_disable(), since we can be
>  		 * called from map free path as well apart from BPF program (as
>  		 * part of map ops doing bpf_obj_free_fields).
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 6f0aac837d77..bc80b4c4377b 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -8615,21 +8615,22 @@ static int process_kf_arg_ptr_to_list_node(struct bpf_verifier_env *env,
>  
>  	field = meta->arg_list_head.field;
>  
> -	et = btf_type_by_id(field->list_head.btf, field->list_head.value_btf_id);
> +	et = btf_type_by_id(field->datastructure_head.btf, field->datastructure_head.value_btf_id);
>  	t = btf_type_by_id(reg->btf, reg->btf_id);
> -	if (!btf_struct_ids_match(&env->log, reg->btf, reg->btf_id, 0, field->list_head.btf,
> -				  field->list_head.value_btf_id, true)) {
> +	if (!btf_struct_ids_match(&env->log, reg->btf, reg->btf_id, 0, field->datastructure_head.btf,
> +				  field->datastructure_head.value_btf_id, true)) {
>  		verbose(env, "operation on bpf_list_head expects arg#1 bpf_list_node at offset=%d "
>  			"in struct %s, but arg is at offset=%d in struct %s\n",
> -			field->list_head.node_offset, btf_name_by_offset(field->list_head.btf, et->name_off),
> +			field->datastructure_head.node_offset,
> +			btf_name_by_offset(field->datastructure_head.btf, et->name_off),
>  			list_node_off, btf_name_by_offset(reg->btf, t->name_off));
>  		return -EINVAL;
>  	}
>  
> -	if (list_node_off != field->list_head.node_offset) {
> +	if (list_node_off != field->datastructure_head.node_offset) {
>  		verbose(env, "arg#1 offset=%d, but expected bpf_list_node at offset=%d in struct %s\n",
> -			list_node_off, field->list_head.node_offset,
> -			btf_name_by_offset(field->list_head.btf, et->name_off));
> +			list_node_off, field->datastructure_head.node_offset,
> +			btf_name_by_offset(field->datastructure_head.btf, et->name_off));
>  		return -EINVAL;
>  	}
>  	/* Set arg#1 for expiration after unlock */
> @@ -9078,9 +9079,9 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>  
>  				mark_reg_known_zero(env, regs, BPF_REG_0);
>  				regs[BPF_REG_0].type = PTR_TO_BTF_ID | MEM_ALLOC;
> -				regs[BPF_REG_0].btf = field->list_head.btf;
> -				regs[BPF_REG_0].btf_id = field->list_head.value_btf_id;
> -				regs[BPF_REG_0].off = field->list_head.node_offset;
> +				regs[BPF_REG_0].btf = field->datastructure_head.btf;
> +				regs[BPF_REG_0].btf_id = field->datastructure_head.value_btf_id;
> +				regs[BPF_REG_0].off = field->datastructure_head.node_offset;
>  			} else if (meta.func_id == special_kfunc_list[KF_bpf_cast_to_kern_ctx]) {
>  				mark_reg_known_zero(env, regs, BPF_REG_0);
>  				regs[BPF_REG_0].type = PTR_TO_BTF_ID | PTR_TRUSTED;
> -- 
> 2.30.2
> 
