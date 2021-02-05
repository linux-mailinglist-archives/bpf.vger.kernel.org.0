Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 710F93104E9
	for <lists+bpf@lfdr.de>; Fri,  5 Feb 2021 07:24:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbhBEGYk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 5 Feb 2021 01:24:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbhBEGYj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 5 Feb 2021 01:24:39 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDA10C0613D6
        for <bpf@vger.kernel.org>; Thu,  4 Feb 2021 22:23:59 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id u15so3066099plf.1
        for <bpf@vger.kernel.org>; Thu, 04 Feb 2021 22:23:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RXeFko+22uKlLMlBeraP/fxifYu+9nAPCDw15hFBtiQ=;
        b=HDrUhj2gau8uzA9lrqA2r/qaPcrZVdU+miurwHGLaaZqY6dIHCyB8BnnU2f/wDHf1m
         +xFe6i5sbPk9Ej8cEQf6PEBgbHpMMQ9EE0IzLHQ+OVTmBNYM6VBrnSJwl/1dDLnGQ+CL
         1QUXubWpF+2bqYPL0Xrf+GQaOZsjczh8gCxqM9Y9uSOe/dTwEpcHutETohCNBt8cl0oz
         Uj+kb4IWjUE3wYeLseYrIDeGuFUy1l0ah9BZCcdHR2AMPdw0GxifjHrVfTTijXQnjQxK
         yiKbGiDu7RD7VXXItYf0QIQWo/6Ouk20OzHwHWwsUqXg1JsvhjKZ8ejXx3ZEEX3vAGFq
         kglA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RXeFko+22uKlLMlBeraP/fxifYu+9nAPCDw15hFBtiQ=;
        b=peg98mLI45du2NErf+EPkd4czGbGg+3IuCtP9IupXic2ADhLDtjILFMQ9huSuJmkL1
         dL/sMx3d4E8CGL3TMPlDvHVSi5ECA0oGGg++mFVFedkbXBTsl6TBQNGkxgzAe+4H2KyI
         DKcc8nAus5BacIMq7uYGtZj2vCOwT/QdzY4eJhKe48xzMOMxIySLVDBw7XhmKVKr0auB
         5cNcODE2CwvNmuq4trQt2OcHRCswpux7XbCMIiehl5vfjTLB4nlAIDsFsD6E2yqoP+Dr
         ehd9pDM1j9TzLBo7eDAzoXSNTChFjsV4c0SMNI8Qv+tgHJCpsJBoTFAYUyHYhSSInd+O
         6HTg==
X-Gm-Message-State: AOAM532flCPW7vXGO+LJNxCLBIMPt0YffqzjUwaSbgNM0bESxN13pZPI
        cUyyPR5cC66di++SZvSlt0U=
X-Google-Smtp-Source: ABdhPJyNQ7SYNJkNuBQgoR3TSAj/al247DBbuY9v/t4RijEpgN35ytOdaGSoHO7NIKw8UpUSFWEfKA==
X-Received: by 2002:a17:90b:4d09:: with SMTP id mw9mr2755562pjb.199.1612506238988;
        Thu, 04 Feb 2021 22:23:58 -0800 (PST)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:400::5:52b9])
        by smtp.gmail.com with ESMTPSA id h6sm8136313pfr.47.2021.02.04.22.23.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 22:23:58 -0800 (PST)
Date:   Thu, 4 Feb 2021 22:23:56 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com
Subject: Re: [PATCH bpf-next 3/8] bpf: add hashtab support for
 bpf_for_each_map_elem() helper
Message-ID: <20210205062356.blcdj7abj7gwymcc@ast-mbp.dhcp.thefacebook.com>
References: <20210204234827.1628857-1-yhs@fb.com>
 <20210204234830.1629223-1-yhs@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210204234830.1629223-1-yhs@fb.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Feb 04, 2021 at 03:48:30PM -0800, Yonghong Song wrote:
> This patch added support for hashmap, percpu hashmap,
> lru hashmap and percpu lru hashmap.
> 
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---
>  include/linux/bpf.h   |  4 +++
>  kernel/bpf/hashtab.c  | 57 +++++++++++++++++++++++++++++++++++++++++++
>  kernel/bpf/verifier.c | 23 +++++++++++++++++
>  3 files changed, 84 insertions(+)
> 
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index c8b72ae16cc5..31e0447cadd8 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1396,6 +1396,10 @@ void bpf_iter_map_show_fdinfo(const struct bpf_iter_aux_info *aux,
>  int bpf_iter_map_fill_link_info(const struct bpf_iter_aux_info *aux,
>  				struct bpf_link_info *info);
>  
> +int map_set_for_each_callback_args(struct bpf_verifier_env *env,
> +				   struct bpf_func_state *caller,
> +				   struct bpf_func_state *callee);
> +
>  int bpf_percpu_hash_copy(struct bpf_map *map, void *key, void *value);
>  int bpf_percpu_array_copy(struct bpf_map *map, void *key, void *value);
>  int bpf_percpu_hash_update(struct bpf_map *map, void *key, void *value,
> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> index c1ac7f964bc9..40f5404cfb01 100644
> --- a/kernel/bpf/hashtab.c
> +++ b/kernel/bpf/hashtab.c
> @@ -1869,6 +1869,55 @@ static const struct bpf_iter_seq_info iter_seq_info = {
>  	.seq_priv_size		= sizeof(struct bpf_iter_seq_hash_map_info),
>  };
>  
> +static int bpf_for_each_hash_elem(struct bpf_map *map, void *callback_fn,
> +				  void *callback_ctx, u64 flags)
> +{
> +	struct bpf_htab *htab = container_of(map, struct bpf_htab, map);
> +	struct hlist_nulls_head *head;
> +	struct hlist_nulls_node *n;
> +	struct htab_elem *elem;
> +	u32 roundup_key_size;
> +	void __percpu *pptr;
> +	struct bucket *b;
> +	void *key, *val;
> +	bool is_percpu;
> +	long ret = 0;
> +	int i;
> +
> +	if (flags != 0)
> +		return -EINVAL;
> +
> +	is_percpu = htab_is_percpu(htab);
> +
> +	roundup_key_size = round_up(map->key_size, 8);
> +	for (i = 0; i < htab->n_buckets; i++) {
> +		b = &htab->buckets[i];
> +		rcu_read_lock();
> +		head = &b->head;
> +		hlist_nulls_for_each_entry_rcu(elem, n, head, hash_node) {
> +			key = elem->key;
> +			if (!is_percpu) {
> +				val = elem->key + roundup_key_size;
> +			} else {
> +				/* current cpu value for percpu map */
> +				pptr = htab_elem_get_ptr(elem, map->key_size);
> +				val = this_cpu_ptr(pptr);
> +			}
> +			ret = BPF_CAST_CALL(callback_fn)((u64)(long)map,
> +					(u64)(long)key, (u64)(long)val,
> +					(u64)(long)callback_ctx, 0);
> +			if (ret) {
> +				rcu_read_unlock();
> +				ret = (ret == 1) ? 0 : -EINVAL;

one more thing that I should have mentioned in patch 2.
In prepare_func_exit would be good to add:
if (callee->in_callback_fn)
  check that r0 is readable and in tnum_range(0, 1).
and then don't assign r0 reg_state anywhere.

> +				goto out;
> +			}
> +		}
> +		rcu_read_unlock();

Sleepable progs can do cond_resched here.
How about adding migrate_disable before for() loop
to make sure that for_each(per_cpu_map,...) is still meaningful and
if (!in_atomic())
   cond_resched();
here.
Since this helper is called from bpf progs only the in_atomic check
(whether prog was sleepable or not) is accurate.

> +	}
  
  migrate_enable() here after the loop.

> +out:
> +	return ret;
> +}
> +
>  static int htab_map_btf_id;
>  const struct bpf_map_ops htab_map_ops = {
>  	.map_meta_equal = bpf_map_meta_equal,
> @@ -1881,6 +1930,8 @@ const struct bpf_map_ops htab_map_ops = {
>  	.map_delete_elem = htab_map_delete_elem,
>  	.map_gen_lookup = htab_map_gen_lookup,
>  	.map_seq_show_elem = htab_map_seq_show_elem,
> +	.map_set_for_each_callback_args = map_set_for_each_callback_args,
> +	.map_for_each_callback = bpf_for_each_hash_elem,
>  	BATCH_OPS(htab),
>  	.map_btf_name = "bpf_htab",
>  	.map_btf_id = &htab_map_btf_id,
> @@ -1900,6 +1951,8 @@ const struct bpf_map_ops htab_lru_map_ops = {
>  	.map_delete_elem = htab_lru_map_delete_elem,
>  	.map_gen_lookup = htab_lru_map_gen_lookup,
>  	.map_seq_show_elem = htab_map_seq_show_elem,
> +	.map_set_for_each_callback_args = map_set_for_each_callback_args,
> +	.map_for_each_callback = bpf_for_each_hash_elem,
>  	BATCH_OPS(htab_lru),
>  	.map_btf_name = "bpf_htab",
>  	.map_btf_id = &htab_lru_map_btf_id,
> @@ -2019,6 +2072,8 @@ const struct bpf_map_ops htab_percpu_map_ops = {
>  	.map_update_elem = htab_percpu_map_update_elem,
>  	.map_delete_elem = htab_map_delete_elem,
>  	.map_seq_show_elem = htab_percpu_map_seq_show_elem,
> +	.map_set_for_each_callback_args = map_set_for_each_callback_args,
> +	.map_for_each_callback = bpf_for_each_hash_elem,
>  	BATCH_OPS(htab_percpu),
>  	.map_btf_name = "bpf_htab",
>  	.map_btf_id = &htab_percpu_map_btf_id,
> @@ -2036,6 +2091,8 @@ const struct bpf_map_ops htab_lru_percpu_map_ops = {
>  	.map_update_elem = htab_lru_percpu_map_update_elem,
>  	.map_delete_elem = htab_lru_map_delete_elem,
>  	.map_seq_show_elem = htab_percpu_map_seq_show_elem,
> +	.map_set_for_each_callback_args = map_set_for_each_callback_args,
> +	.map_for_each_callback = bpf_for_each_hash_elem,
>  	BATCH_OPS(htab_lru_percpu),
>  	.map_btf_name = "bpf_htab",
>  	.map_btf_id = &htab_lru_percpu_map_btf_id,
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 050b067a0be6..32c8dcc27da8 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -4987,6 +4987,29 @@ static int check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>  	return 0;
>  }
>  
> +int map_set_for_each_callback_args(struct bpf_verifier_env *env,
> +				   struct bpf_func_state *caller,
> +				   struct bpf_func_state *callee)
> +{
> +	/* pointer to map */
> +	callee->regs[BPF_REG_1] = caller->regs[BPF_REG_1];
> +
> +	callee->regs[BPF_REG_2].type = PTR_TO_MAP_KEY;
> +	__mark_reg_known_zero(&callee->regs[BPF_REG_2]);
> +	callee->regs[BPF_REG_2].map_ptr = caller->regs[BPF_REG_1].map_ptr;
> +
> +	callee->regs[BPF_REG_3].type = PTR_TO_MAP_VALUE;
> +	__mark_reg_known_zero(&callee->regs[BPF_REG_3]);
> +	callee->regs[BPF_REG_3].map_ptr = caller->regs[BPF_REG_1].map_ptr;
> +
> +	/* pointer to stack or null */
> +	callee->regs[BPF_REG_4] = caller->regs[BPF_REG_3];

This hard coding of regs 1 through 4 makes sense.
May be add a comment with bpf_for_each_map_elem and callback_fn prototypes,
so it's more obvious what's going on.

> +
> +	/* unused */
> +	__mark_reg_unknown(env, &callee->regs[BPF_REG_5]);

I think it should be __mark_reg_not_init to make sure that callback_fn
doesn't use r5.
That will help with future extensions via new flags arg that is passed
into bpf_for_each_map_elem.
