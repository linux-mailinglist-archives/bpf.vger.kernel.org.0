Return-Path: <bpf+bounces-40753-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0648A98D1C2
	for <lists+bpf@lfdr.de>; Wed,  2 Oct 2024 12:54:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35CFAB2178F
	for <lists+bpf@lfdr.de>; Wed,  2 Oct 2024 10:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 786A71E7674;
	Wed,  2 Oct 2024 10:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="edMvpQAP";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Jdet9iXc";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="edMvpQAP";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Jdet9iXc"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0046419D07D;
	Wed,  2 Oct 2024 10:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727866462; cv=none; b=Ql9B48tr5103vlU5JxJbLnVBwjfi+UBbs+5F3qaqWCyOreI6NgN38KrNQRZIG7hh0peY3niCNtE2O8k/kfgVBcHCt61JjA2e+/lQw+bmxCB5vTgwwrOkoOUPiF05NCqRv1g+NCNLNm54fsdKL0FgTTNHFaJl0V/oCshjGs0Sxm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727866462; c=relaxed/simple;
	bh=HkFM8UcK8uF98b/tKDCbbHCWintf/vR0zKqGgo1hPUc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Tjsa9KSn8fr+rPslUtpBAmslGQNAiZByGDZWWHhdq4ryWq2hqj+9AxQjHOK2r1jKuO+zCFzyyOOgqELirsDv15+GN9v/OdP6hBocjj+KReVTHkfy2TsguiuFa039GqwFIktQafQqvOkJIetS90FuYNfWxD091eXN4OZvUq+r9xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=edMvpQAP; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Jdet9iXc; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=edMvpQAP; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Jdet9iXc; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3B0D11FD49;
	Wed,  2 Oct 2024 10:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1727866458; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=zDgFGEa7c7drZSi9zW1qpp3cR/TOGgBbEzux7jAZNCc=;
	b=edMvpQAPPzN/AtNaXZehQAH+1VFBSYKTxCIT2YTaR1JGdw+brmgb+GFc49Sk/lsCcafG/w
	QPPpcrFqF9KMukvQJuL91vA6t2ZSR1YpkyT35/zbBrUW3Gu8C74irXJ3F5n8pPJFoOAhHz
	o2ynAsXHAxy1QA2F2HPUuOsh6lQd67c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1727866458;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=zDgFGEa7c7drZSi9zW1qpp3cR/TOGgBbEzux7jAZNCc=;
	b=Jdet9iXc53oHGrh9qukEMVGRLwwWzYzyygK9tKSnEENOssLu63eB4kQXwIvdmSJCTuCF4S
	eqHOwyZkWdYwZ2Cw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1727866458; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=zDgFGEa7c7drZSi9zW1qpp3cR/TOGgBbEzux7jAZNCc=;
	b=edMvpQAPPzN/AtNaXZehQAH+1VFBSYKTxCIT2YTaR1JGdw+brmgb+GFc49Sk/lsCcafG/w
	QPPpcrFqF9KMukvQJuL91vA6t2ZSR1YpkyT35/zbBrUW3Gu8C74irXJ3F5n8pPJFoOAhHz
	o2ynAsXHAxy1QA2F2HPUuOsh6lQd67c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1727866458;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=zDgFGEa7c7drZSi9zW1qpp3cR/TOGgBbEzux7jAZNCc=;
	b=Jdet9iXc53oHGrh9qukEMVGRLwwWzYzyygK9tKSnEENOssLu63eB4kQXwIvdmSJCTuCF4S
	eqHOwyZkWdYwZ2Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 09EFB13A6E;
	Wed,  2 Oct 2024 10:54:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id nwUWAlom/WZnagAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 02 Oct 2024 10:54:18 +0000
Message-ID: <0906dee9-636b-4aef-b513-fe188232e458@suse.cz>
Date: Wed, 2 Oct 2024 12:54:17 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 bpf-next 1/3] bpf: Add kmem_cache iterator
Content-Language: en-US
To: Namhyung Kim <namhyung@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 bpf@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
 David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
 Arnaldo Carvalho de Melo <acme@kernel.org>
References: <20241002065456.1580143-1-namhyung@kernel.org>
 <20241002065456.1580143-2-namhyung@kernel.org>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <20241002065456.1580143-2-namhyung@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	TAGGED_RCPT(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[24];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux.dev,gmail.com,kernel.org,fomichev.me,google.com,vger.kernel.org,linux-foundation.org,linux.com,lge.com,kvack.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:mid]
X-Spam-Score: -2.80
X-Spam-Flag: NO

On 10/2/24 08:54, Namhyung Kim wrote:
> The new "kmem_cache" iterator will traverse the list of slab caches
> and call attached BPF programs for each entry.  It should check the
> argument (ctx.s) if it's NULL before using it.
> 
> Now the iteration grabs the slab_mutex only if it traverse the list and
> releases the mutex when it runs the BPF program.  The kmem_cache entry
> is protected by a refcount during the execution.
> 
> It includes the internal "mm/slab.h" header to access kmem_cache,
> slab_caches and slab_mutex.  Hope it's ok to mm folks.
> 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
> I've removed the Acked-by's from Roman and Vlastimil since it's changed
> not to hold the slab_mutex and to manage the refcount.  Please review
> this change again!
> 
>  include/linux/btf_ids.h      |   1 +
>  kernel/bpf/Makefile          |   1 +
>  kernel/bpf/kmem_cache_iter.c | 165 +++++++++++++++++++++++++++++++++++
>  3 files changed, 167 insertions(+)
>  create mode 100644 kernel/bpf/kmem_cache_iter.c
> 
> diff --git a/include/linux/btf_ids.h b/include/linux/btf_ids.h
> index c0e3e1426a82f5c4..139bdececdcfaefb 100644
> --- a/include/linux/btf_ids.h
> +++ b/include/linux/btf_ids.h
> @@ -283,5 +283,6 @@ extern u32 btf_tracing_ids[];
>  extern u32 bpf_cgroup_btf_id[];
>  extern u32 bpf_local_storage_map_btf_id[];
>  extern u32 btf_bpf_map_id[];
> +extern u32 bpf_kmem_cache_btf_id[];
>  
>  #endif
> diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
> index 9b9c151b5c826b31..105328f0b9c04e37 100644
> --- a/kernel/bpf/Makefile
> +++ b/kernel/bpf/Makefile
> @@ -52,3 +52,4 @@ obj-$(CONFIG_BPF_PRELOAD) += preload/
>  obj-$(CONFIG_BPF_SYSCALL) += relo_core.o
>  obj-$(CONFIG_BPF_SYSCALL) += btf_iter.o
>  obj-$(CONFIG_BPF_SYSCALL) += btf_relocate.o
> +obj-$(CONFIG_BPF_SYSCALL) += kmem_cache_iter.o
> diff --git a/kernel/bpf/kmem_cache_iter.c b/kernel/bpf/kmem_cache_iter.c
> new file mode 100644
> index 0000000000000000..a77c08b82c6bc965
> --- /dev/null
> +++ b/kernel/bpf/kmem_cache_iter.c
> @@ -0,0 +1,165 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright (c) 2024 Google */
> +#include <linux/bpf.h>
> +#include <linux/btf_ids.h>
> +#include <linux/slab.h>
> +#include <linux/kernel.h>
> +#include <linux/seq_file.h>
> +
> +#include "../../mm/slab.h" /* kmem_cache, slab_caches and slab_mutex */
> +
> +struct bpf_iter__kmem_cache {
> +	__bpf_md_ptr(struct bpf_iter_meta *, meta);
> +	__bpf_md_ptr(struct kmem_cache *, s);
> +};
> +
> +static void *kmem_cache_iter_seq_start(struct seq_file *seq, loff_t *pos)
> +{
> +	loff_t cnt = 0;
> +	struct kmem_cache *s = NULL;
> +
> +	mutex_lock(&slab_mutex);
> +
> +	/*
> +	 * Find an entry at the given position in the slab_caches list instead
> +	 * of keeping a reference (of the last visited entry, if any) out of
> +	 * slab_mutex. It might miss something if one is deleted in the middle
> +	 * while it releases the lock.  But it should be rare and there's not
> +	 * much we can do about it.
> +	 */
> +	list_for_each_entry(s, &slab_caches, list) {
> +		if (cnt == *pos) {
> +			/*
> +			 * Make sure this entry remains in the list by getting
> +			 * a new reference count.  Note that boot_cache entries
> +			 * have a negative refcount, so don't touch them.
> +			 */
> +			if (s->refcount > 0)
> +				s->refcount++;
> +			break;
> +		}
> +
> +		cnt++;
> +	}
> +	mutex_unlock(&slab_mutex);
> +
> +	if (cnt != *pos)
> +		return NULL;
> +
> +	++*pos;
> +	return s;
> +}
> +
> +static void kmem_cache_iter_seq_stop(struct seq_file *seq, void *v)
> +{
> +	struct bpf_iter_meta meta;
> +	struct bpf_iter__kmem_cache ctx = {
> +		.meta = &meta,
> +		.s = v,
> +	};
> +	struct bpf_prog *prog;
> +	bool destroy = false;
> +
> +	meta.seq = seq;
> +	prog = bpf_iter_get_info(&meta, true);
> +	if (prog)
> +		bpf_iter_run_prog(prog, &ctx);
> +
> +	mutex_lock(&slab_mutex);
> +	if (ctx.s && ctx.s->refcount > 0)
> +		destroy = true;

I'd do the same optimization as in kmem_cache_iter_seq_next() otherwise this
will always results in taking the mutex twice and performing
kvfree_rcu_barrier() needlessly?

> +	mutex_unlock(&slab_mutex);
> +
> +	if (destroy)
> +		kmem_cache_destroy(ctx.s);
> +}
> +
> +static void *kmem_cache_iter_seq_next(struct seq_file *seq, void *v, loff_t *pos)
> +{
> +	struct kmem_cache *s = v;
> +	struct kmem_cache *next = NULL;
> +	bool destroy = false;
> +
> +	++*pos;
> +
> +	mutex_lock(&slab_mutex);
> +
> +	if (list_last_entry(&slab_caches, struct kmem_cache, list) != s) {
> +		next = list_next_entry(s, list);
> +		if (next->refcount > 0)
> +			next->refcount++;
> +	}
> +
> +	/* Skip kmem_cache_destroy() for active entries */
> +	if (s->refcount > 1)
> +		s->refcount--;
> +	else if (s->refcount == 1)
> +		destroy = true;
> +
> +	mutex_unlock(&slab_mutex);
> +
> +	if (destroy)
> +		kmem_cache_destroy(s);
> +
> +	return next;
> +}
> +
> +static int kmem_cache_iter_seq_show(struct seq_file *seq, void *v)
> +{
> +	struct bpf_iter_meta meta;
> +	struct bpf_iter__kmem_cache ctx = {
> +		.meta = &meta,
> +		.s = v,
> +	};
> +	struct bpf_prog *prog;
> +	int ret = 0;
> +
> +	meta.seq = seq;
> +	prog = bpf_iter_get_info(&meta, false);
> +	if (prog)
> +		ret = bpf_iter_run_prog(prog, &ctx);
> +
> +	return ret;
> +}
> +
> +static const struct seq_operations kmem_cache_iter_seq_ops = {
> +	.start  = kmem_cache_iter_seq_start,
> +	.next   = kmem_cache_iter_seq_next,
> +	.stop   = kmem_cache_iter_seq_stop,
> +	.show   = kmem_cache_iter_seq_show,
> +};
> +
> +BTF_ID_LIST_GLOBAL_SINGLE(bpf_kmem_cache_btf_id, struct, kmem_cache)
> +
> +static const struct bpf_iter_seq_info kmem_cache_iter_seq_info = {
> +	.seq_ops		= &kmem_cache_iter_seq_ops,
> +};
> +
> +static void bpf_iter_kmem_cache_show_fdinfo(const struct bpf_iter_aux_info *aux,
> +					    struct seq_file *seq)
> +{
> +	seq_puts(seq, "kmem_cache iter\n");
> +}
> +
> +DEFINE_BPF_ITER_FUNC(kmem_cache, struct bpf_iter_meta *meta,
> +		     struct kmem_cache *s)
> +
> +static struct bpf_iter_reg bpf_kmem_cache_reg_info = {
> +	.target			= "kmem_cache",
> +	.feature		= BPF_ITER_RESCHED,
> +	.show_fdinfo		= bpf_iter_kmem_cache_show_fdinfo,
> +	.ctx_arg_info_size	= 1,
> +	.ctx_arg_info		= {
> +		{ offsetof(struct bpf_iter__kmem_cache, s),
> +		  PTR_TO_BTF_ID_OR_NULL | PTR_TRUSTED },
> +	},
> +	.seq_info		= &kmem_cache_iter_seq_info,
> +};
> +
> +static int __init bpf_kmem_cache_iter_init(void)
> +{
> +	bpf_kmem_cache_reg_info.ctx_arg_info[0].btf_id = bpf_kmem_cache_btf_id[0];
> +	return bpf_iter_reg_target(&bpf_kmem_cache_reg_info);
> +}
> +
> +late_initcall(bpf_kmem_cache_iter_init);
> 
> base-commit: 9502a7de5a61bec3bda841a830560c5d6d40ecac


