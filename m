Return-Path: <bpf+bounces-10772-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 127D57AE08F
	for <lists+bpf@lfdr.de>; Mon, 25 Sep 2023 23:10:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 941D228199F
	for <lists+bpf@lfdr.de>; Mon, 25 Sep 2023 21:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16856241E4;
	Mon, 25 Sep 2023 21:10:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F411170A
	for <bpf@vger.kernel.org>; Mon, 25 Sep 2023 21:10:23 +0000 (UTC)
Received: from out-194.mta1.migadu.com (out-194.mta1.migadu.com [IPv6:2001:41d0:203:375::c2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7040103
	for <bpf@vger.kernel.org>; Mon, 25 Sep 2023 14:10:21 -0700 (PDT)
Message-ID: <c77c5a5d-7174-4770-4ffb-ee297a28f025@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1695676219;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ofh5uRT1ry1YGH3JhVqhxQr8YzXglb833Mg4JVdgPdI=;
	b=KnwLHpiHHVmOOSz4yWMvPTwYVQgeQob24nkeZHxAN8hYZsbbP64tYvEPw4t69qO76qRNg/
	ghcPt9iYk5cNe66TH+R9QudDmNzHVT+slXxrd3/xtPsj7hPPylKQ2VvOQO7KQcySFH9fyr
	YrPKudo6aIKghBY4SoeDlvFkUwIycGY=
Date: Mon, 25 Sep 2023 14:10:12 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC bpf-next v3 02/11] bpf: add struct_ops_tab to btf.
Content-Language: en-US
To: thinker.li@gmail.com
Cc: sinquersw@gmail.com, kuifeng@meta.com, bpf@vger.kernel.org,
 ast@kernel.org, song@kernel.org, kernel-team@meta.com, andrii@kernel.org
References: <20230920155923.151136-1-thinker.li@gmail.com>
 <20230920155923.151136-3-thinker.li@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20230920155923.151136-3-thinker.li@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 9/20/23 8:59 AM, thinker.li@gmail.com wrote:
> From: Kui-Feng Lee <thinker.li@gmail.com>
> 
> struct_ops_tab will be used to restore registered struct_ops.
> 
> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
> ---
>   include/linux/btf.h |  9 +++++
>   kernel/bpf/btf.c    | 84 +++++++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 93 insertions(+)
> 
> diff --git a/include/linux/btf.h b/include/linux/btf.h
> index 928113a80a95..5fabe23aedd2 100644
> --- a/include/linux/btf.h
> +++ b/include/linux/btf.h
> @@ -571,4 +571,13 @@ static inline bool btf_type_is_struct_ptr(struct btf *btf, const struct btf_type
>   	return btf_type_is_struct(t);
>   }
>   
> +struct bpf_struct_ops;
> +
> +int btf_add_struct_ops_btf(struct bpf_struct_ops *st_ops,
> +			   struct btf *btf);
> +int btf_add_struct_ops(struct bpf_struct_ops *st_ops,
> +		       struct module *owner);
> +const struct bpf_struct_ops **
> +btf_get_struct_ops(struct btf *btf, u32 *ret_cnt);
> +
>   #endif
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index f93e835d90af..3fb9964f8672 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -241,6 +241,12 @@ struct btf_id_dtor_kfunc_tab {
>   	struct btf_id_dtor_kfunc dtors[];
>   };
>   
> +struct btf_struct_ops_tab {
> +	u32 cnt;
> +	u32 capacity;
> +	struct bpf_struct_ops *ops[];
> +};
> +
>   struct btf {
>   	void *data;
>   	struct btf_type **types;
> @@ -258,6 +264,7 @@ struct btf {
>   	struct btf_kfunc_set_tab *kfunc_set_tab;
>   	struct btf_id_dtor_kfunc_tab *dtor_kfunc_tab;
>   	struct btf_struct_metas *struct_meta_tab;
> +	struct btf_struct_ops_tab *struct_ops_tab;
>   
>   	/* split BTF support */
>   	struct btf *base_btf;
> @@ -1688,11 +1695,20 @@ static void btf_free_struct_meta_tab(struct btf *btf)
>   	btf->struct_meta_tab = NULL;
>   }
>   
> +static void btf_free_struct_ops_tab(struct btf *btf)
> +{
> +	struct btf_struct_ops_tab *tab = btf->struct_ops_tab;
> +
> +	kfree(tab);
> +	btf->struct_ops_tab = NULL;
> +}
> +
>   static void btf_free(struct btf *btf)
>   {
>   	btf_free_struct_meta_tab(btf);
>   	btf_free_dtor_kfunc_tab(btf);
>   	btf_free_kfunc_set_tab(btf);
> +	btf_free_struct_ops_tab(btf);
>   	kvfree(btf->types);
>   	kvfree(btf->resolved_sizes);
>   	kvfree(btf->resolved_ids);
> @@ -8601,3 +8617,71 @@ bool btf_type_ids_nocast_alias(struct bpf_verifier_log *log,
>   
>   	return !strncmp(reg_name, arg_name, cmp_len);
>   }
> +
> +int btf_add_struct_ops_btf(struct bpf_struct_ops *st_ops, struct btf *btf)

A few nits.

'struct btf *btf' as the first argument, to be consistent with other similar btf 
functions.

This new function is not used outside of this file, so at least static. I would 
just fold this into btf_add_struct_ops() below which currently is mostly empty 
other than a btf_get/put.

> +{
> +	struct btf_struct_ops_tab *tab;
> +	int i;
> +
> +	/* Assume this function is called for a module when the module is
> +	 * loading.
> +	 */
> +
> +	tab = btf->struct_ops_tab;
> +	if (!tab) {
> +		tab = kzalloc(sizeof(*tab) +
> +			      sizeof(struct bpf_struct_ops *) * 4,
> +			      GFP_KERNEL);

nit. offsetof(struct bpf_struct_ops_tab, ops[4]).

> +		if (!tab)
> +			return -ENOMEM;
> +		tab->capacity = 4;
> +		btf->struct_ops_tab = tab;
> +	}
> +
> +	for (i = 0; i < tab->cnt; i++)
> +		if (tab->ops[i] == st_ops)
> +			return -EEXIST;
> +
> +	if (tab->cnt == tab->capacity) {
> +		struct btf_struct_ops_tab *new_tab;
> +
> +		new_tab = krealloc(tab, sizeof(*tab) +
> +				   sizeof(struct bpf_struct_ops *) *
> +				   tab->capacity * 2, GFP_KERNEL);
> +		if (!new_tab)
> +			return -ENOMEM;
> +		tab = new_tab;
> +		tab->capacity *= 2;
> +		btf->struct_ops_tab = tab;
> +	}
> +
> +	btf->struct_ops_tab->ops[btf->struct_ops_tab->cnt++] = st_ops;
> +
> +	return 0;
> +}
> +
> +int btf_add_struct_ops(struct bpf_struct_ops *st_ops, struct module *owner)
> +{
> +	struct btf *btf = btf_get_module_btf(owner);
> +	int ret;
> +
> +	if (!btf)
> +		return -ENOENT;
> +
> +	ret = btf_add_struct_ops_btf(st_ops, btf);
> +
> +	btf_put(btf);
> +
> +	return ret;
> +}
> +
> +const struct bpf_struct_ops **btf_get_struct_ops(struct btf *btf, u32 *ret_cnt)
> +{
> +	if (!btf)
> +		return NULL;
> +	if (!btf->struct_ops_tab)
> +		return NULL;
> +
> +	*ret_cnt = btf->struct_ops_tab->cnt;
> +	return (const struct bpf_struct_ops **)btf->struct_ops_tab->ops;
> +}


