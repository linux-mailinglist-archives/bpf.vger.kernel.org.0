Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 670646291A8
	for <lists+bpf@lfdr.de>; Tue, 15 Nov 2022 06:50:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbiKOFuj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Nov 2022 00:50:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbiKOFui (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Nov 2022 00:50:38 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9AAA1EAC9
        for <bpf@vger.kernel.org>; Mon, 14 Nov 2022 21:50:37 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id c2so12184417plz.11
        for <bpf@vger.kernel.org>; Mon, 14 Nov 2022 21:50:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=INviuOJ65F5yfMhID0axeluA82Ll4d82NiqPDvrPIMY=;
        b=HgAkiX06461VJFlGhornBJ1Qzws4rjk74AOWqEVrf1ukHu9sVT99iQhOq5r2jUYqJI
         hbGwyO8XDrZ9RWIEEiZDaa4qrt/BAIxje3KnmL5AbW6XLGWLPy95T2zqBysN0huSaypH
         5pWx51hgqBwAGLvhmIX2pnmlV1FXCwAXTmnzq85ge7OYeQZhJqDgILV71krF3IzCFVc1
         ODPzuMrxBnBgwbVHd+MrroZ4HMJCgdhu6X+AUuQypgcW1zZpNRlhj/zIFmyvsli38k5z
         FiGimfSJ23L2WBAQo86d8RLPb5aYNZcRxl9AROCKJFgfMnbkNYsQESDlrg62zkRZLJT9
         6TtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=INviuOJ65F5yfMhID0axeluA82Ll4d82NiqPDvrPIMY=;
        b=ygS4LBtjPj9b/x1XawFCjSNbpkkhyP3/4Be26WOe4bbZdLSZn7JZLNaqN22t49YwVY
         N3OXtBBypis4j+SMONYJNAKAolnZp0nfaJ8YkU1nBC/l0djmRqt2mt/M7Q0H7C5vpgMt
         12ofejk1jGFpiAM434OyPcvuW7eil7ftJdTWLbcAXu/TGochWiN+hPvRrZLeplDx9eHc
         8gyoq7TM0821Yz/S/7/0PUuPfjBwqs2XZgDBEh8AQgJT7CsO6qSAm1aBMjXzCZ/ekz3S
         4muZDWPAQ+QRXIebN3iW5aHariNm1Og5vqTuKFHfa1Za83iT8zgVggqcVkoFjGH9aHUq
         2SfQ==
X-Gm-Message-State: ANoB5pmkjFFrB0HBF14WmAEwoD49aW8M0p4P7wdHoPATBE16Ryx1mH9D
        AHRoVMuoIlxXiQpiHZAe2pA=
X-Google-Smtp-Source: AA0mqf4nj/uTHkMnBQcd0xIdDi3k3im/+j28lNPncVnWQqaNnE+f9NkvrDZt7BfpZ+HqXgV+HcTpYw==
X-Received: by 2002:a17:902:b410:b0:178:7040:9917 with SMTP id x16-20020a170902b41000b0017870409917mr2504233plr.109.1668491437186;
        Mon, 14 Nov 2022 21:50:37 -0800 (PST)
Received: from macbook-pro-5.dhcp.thefacebook.com ([2620:10d:c090:400::5:cee6])
        by smtp.gmail.com with ESMTPSA id x11-20020a170902a38b00b00186881688f2sm8631838pla.220.2022.11.14.21.50.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 21:50:36 -0800 (PST)
Date:   Mon, 14 Nov 2022 21:50:34 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>
Subject: Re: [PATCH bpf-next v7 09/26] bpf: Recognize lock and list fields in
 allocated objects
Message-ID: <20221115055034.pf2onw7iddm2vtku@macbook-pro-5.dhcp.thefacebook.com>
References: <20221114191547.1694267-1-memxor@gmail.com>
 <20221114191547.1694267-10-memxor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221114191547.1694267-10-memxor@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Nov 15, 2022 at 12:45:30AM +0530, Kumar Kartikeya Dwivedi wrote:
> +	parse:
> +		if (!tab) {
> +			tab = kzalloc(offsetof(struct btf_struct_metas, types[1]),
> +				      GFP_KERNEL | __GFP_NOWARN);
> +			if (!tab)
> +				return ERR_PTR(-ENOMEM);
> +		} else {
> +			struct btf_struct_metas *new_tab;
> +
> +			new_tab = krealloc(tab, offsetof(struct btf_struct_metas, types[tab->cnt + 1]),
> +					   GFP_KERNEL | __GFP_NOWARN);
> +			if (!new_tab) {
> +				ret = -ENOMEM;
> +				goto free;
> +			}
> +			tab = new_tab;
> +		}

If @p is %NULL, krealloc() behaves exactly like kmalloc().

That can help to simplify above a bit?

> +		type = &tab->types[tab->cnt];
> +
> +		type->btf_id = i;
> +		record = btf_parse_fields(btf, t, BPF_SPIN_LOCK | BPF_LIST_HEAD | BPF_LIST_NODE, t->size);
> +		if (IS_ERR_OR_NULL(record)) {
> +			ret = PTR_ERR_OR_ZERO(record) ?: -EFAULT;
> +			goto free;
> +		}
> +		foffs = btf_parse_field_offs(record);
> +		if (WARN_ON_ONCE(IS_ERR_OR_NULL(foffs))) {

WARN_ON_ONCE ?
Pls add a comment.

> +			btf_record_free(record);
> +			ret = -EFAULT;
> +			goto free;
> +		}
> +		type->record = record;
> +		type->field_offs = foffs;
> +		tab->cnt++;
> +	}
> +	return tab;
> +free:
> +	btf_struct_metas_free(tab);
> +	return ERR_PTR(ret);
> +}
> +
> +struct btf_struct_meta *btf_find_struct_meta(const struct btf *btf, u32 btf_id)
> +{
> +	struct btf_struct_metas *tab;
> +
> +	BUILD_BUG_ON(offsetof(struct btf_struct_meta, btf_id) != 0);
> +	tab = btf->struct_meta_tab;
> +	if (!tab)
> +		return NULL;
> +	return bsearch(&btf_id, tab->types, tab->cnt, sizeof(tab->types[0]), btf_id_cmp_func);
> +}
> +
>  static int btf_check_type_tags(struct btf_verifier_env *env,
>  			       struct btf *btf, int start_id)
>  {
> @@ -5191,6 +5338,7 @@ static int btf_check_type_tags(struct btf_verifier_env *env,
>  static struct btf *btf_parse(bpfptr_t btf_data, u32 btf_data_size,
>  			     u32 log_level, char __user *log_ubuf, u32 log_size)
>  {
> +	struct btf_struct_metas *struct_meta_tab;
>  	struct btf_verifier_env *env = NULL;
>  	struct bpf_verifier_log *log;
>  	struct btf *btf = NULL;
> @@ -5259,15 +5407,24 @@ static struct btf *btf_parse(bpfptr_t btf_data, u32 btf_data_size,
>  	if (err)
>  		goto errout;
>  
> +	struct_meta_tab = btf_parse_struct_metas(log, btf);
> +	if (IS_ERR(struct_meta_tab)) {
> +		err = PTR_ERR(struct_meta_tab);
> +		goto errout;
> +	}
> +	btf->struct_meta_tab = struct_meta_tab;
> +
>  	if (log->level && bpf_verifier_log_full(log)) {
>  		err = -ENOSPC;
> -		goto errout;
> +		goto errout_meta;
>  	}
>  
>  	btf_verifier_env_free(env);
>  	refcount_set(&btf->refcnt, 1);
>  	return btf;
>  
> +errout_meta:
> +	btf_free_struct_meta_tab(btf);
>  errout:
>  	btf_verifier_env_free(env);
>  	if (btf)
> @@ -6028,6 +6185,28 @@ int btf_struct_access(struct bpf_verifier_log *log,
>  	u32 id = reg->btf_id;
>  	int err;
>  
> +	while (type_is_alloc(reg->type)) {
> +		struct btf_struct_meta *meta;
> +		struct btf_record *rec;
> +		int i;
> +
> +		meta = btf_find_struct_meta(btf, id);
> +		if (!meta)
> +			break;
> +		rec = meta->record;
> +		for (i = 0; i < rec->cnt; i++) {
> +			struct btf_field *field = &rec->fields[i];
> +			u32 offset = field->offset;
> +			if (off < offset + btf_field_type_size(field->type) && offset < off + size) {
> +				bpf_log(log,
> +					"direct access to %s is disallowed\n",
> +					btf_field_type_name(field->type));
> +				return -EACCES;
> +			}
> +		}
> +		break;
> +	}
> +
>  	t = btf_type_by_id(btf, id);
>  	do {
>  		err = btf_struct_walk(log, btf, t, off, size, &id, &tmp_flag);
> @@ -7269,23 +7448,6 @@ bool btf_is_module(const struct btf *btf)
>  	return btf->kernel_btf && strcmp(btf->name, "vmlinux") != 0;
>  }
>  
> -static int btf_id_cmp_func(const void *a, const void *b)
> -{
> -	const int *pa = a, *pb = b;
> -
> -	return *pa - *pb;
> -}
> -
> -bool btf_id_set_contains(const struct btf_id_set *set, u32 id)
> -{
> -	return bsearch(&id, set->ids, set->cnt, sizeof(u32), btf_id_cmp_func) != NULL;
> -}
> -
> -static void *btf_id_set8_contains(const struct btf_id_set8 *set, u32 id)
> -{
> -	return bsearch(&id, set->pairs, set->cnt, sizeof(set->pairs[0]), btf_id_cmp_func);
> -}
> -
>  enum {
>  	BTF_MODULE_F_LIVE = (1 << 0),
>  };
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index fdbae52f463f..c96039a4e57f 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -537,6 +537,7 @@ void btf_record_free(struct btf_record *rec)
>  			btf_put(rec->fields[i].kptr.btf);
>  			break;
>  		case BPF_LIST_HEAD:
> +		case BPF_LIST_NODE:
>  			/* Nothing to release for bpf_list_head */
>  			break;
>  		default:
> @@ -582,6 +583,7 @@ struct btf_record *btf_record_dup(const struct btf_record *rec)
>  			}
>  			break;
>  		case BPF_LIST_HEAD:
> +		case BPF_LIST_NODE:
>  			/* Nothing to acquire for bpf_list_head */
>  			break;
>  		default:
> @@ -648,6 +650,8 @@ void bpf_obj_free_fields(const struct btf_record *rec, void *obj)
>  				continue;
>  			bpf_list_head_free(field, field_ptr, obj + rec->spin_lock_off);
>  			break;
> +		case BPF_LIST_NODE:
> +			break;
>  		default:
>  			WARN_ON_ONCE(1);
>  			continue;
> -- 
> 2.38.1
> 
