Return-Path: <bpf+bounces-33217-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 32D80919DB6
	for <lists+bpf@lfdr.de>; Thu, 27 Jun 2024 05:06:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A10711F21B87
	for <lists+bpf@lfdr.de>; Thu, 27 Jun 2024 03:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10D20134B1;
	Thu, 27 Jun 2024 03:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UZ6UNnZd"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86FC2168DA;
	Thu, 27 Jun 2024 03:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719457588; cv=none; b=s7RAoL4JaQh6S2PSi/Fi+WJKbkqhWFiECykUq7kwIR7Xl+mcESiF1IacMFc6TcV5UpR0dpSSwhVs3OUh4julwy4WK7L9FtFBnLwfe1Wc+mNprd4xTMbzU68Jur00O+VzNLmdWuhbiooA68VuLH38VrBehsvNADBqov4vsiS+QRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719457588; c=relaxed/simple;
	bh=XxOrtLMFb8ZoeZFJ1vzTi6CWSKWFFP3m9J9eEwkblYM=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=YlhTTE8+sJyQoUXidpqLsDhJPdLjmQN1zr+WBso6OpUTLgfmt2kcI2kT6TWrOJMNyVrbZhBeIKmWEhUd2AGPzpurBdpUqLmd7f220AM06jSWQLbgK2RE+KWf8ClSkKtYbgjPk2RewYBZvcFh2cYDFoVHZH8UIDa39tX4ntQ5l8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UZ6UNnZd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE92BC116B1;
	Thu, 27 Jun 2024 03:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719457588;
	bh=XxOrtLMFb8ZoeZFJ1vzTi6CWSKWFFP3m9J9eEwkblYM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UZ6UNnZdGlmlxqBalOcPFX0aOCQ0mQyz8yAGysEufDlAnxRPCEsmLqQTpkjsUAzC+
	 kNCVVNTacue61tHSNEXPABOAtBOl3wLTCjBPGqYVasU18ZOr5u+K4kgLk92q19W5X1
	 UZffkJi2ALOQiTlnckOGXiZD/6Eric2hwKXE6RHNnDDNPFxRL2+tOEFVyV3CTuc6YR
	 RIpr/07kyMBjhPb4y0LEzj4eIU3HV9Q5+PiQ4gRme3r9XQlDGfqh96bphjD19/XDXt
	 thiXkl6gIC+hu2nxM/H36kV4pv3r39Cm/Uuo3qZKLcLELBk0RO6lV7huvl8pNW+B6O
	 KGLUwhAba8FHg==
Date: Thu, 27 Jun 2024 12:06:23 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, rostedt@goodmis.org,
 oleg@redhat.com, peterz@infradead.org, mingo@redhat.com,
 bpf@vger.kernel.org, jolsa@kernel.org, paulmck@kernel.org, clm@meta.com
Subject: Re: [PATCH 05/12] uprobes: move offset and ref_ctr_offset into
 uprobe_consumer
Message-Id: <20240627120623.8e946a9c3856fa28f068437a@kernel.org>
In-Reply-To: <20240625002144.3485799-6-andrii@kernel.org>
References: <20240625002144.3485799-1-andrii@kernel.org>
	<20240625002144.3485799-6-andrii@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 24 Jun 2024 17:21:37 -0700
Andrii Nakryiko <andrii@kernel.org> wrote:

> Simplify uprobe registration/unregistration interfaces by making offset
> and ref_ctr_offset part of uprobe_consumer "interface". In practice, all
> existing users already store these fields somewhere in uprobe_consumer's
> containing structure, so this doesn't pose any problem. We just move
> some fields around.
> 
> On the other hand, this simplifies uprobe_register() and
> uprobe_unregister() API by having only struct uprobe_consumer as one
> thing representing attachment/detachment entity. This makes batched
> versions of uprobe_register() and uprobe_unregister() simpler.
> 
> This also makes uprobe_register_refctr() unnecessary, so remove it and
> simplify consumers.
> 
> No functional changes intended.
> 

Looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks!

> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  include/linux/uprobes.h                       | 18 +++----
>  kernel/events/uprobes.c                       | 19 ++-----
>  kernel/trace/bpf_trace.c                      | 21 +++-----
>  kernel/trace/trace_uprobe.c                   | 53 ++++++++-----------
>  .../selftests/bpf/bpf_testmod/bpf_testmod.c   | 23 ++++----
>  5 files changed, 55 insertions(+), 79 deletions(-)
> 
> diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
> index b503fafb7fb3..a75ba37ce3c8 100644
> --- a/include/linux/uprobes.h
> +++ b/include/linux/uprobes.h
> @@ -42,6 +42,11 @@ struct uprobe_consumer {
>  				enum uprobe_filter_ctx ctx,
>  				struct mm_struct *mm);
>  
> +	/* associated file offset of this probe */
> +	loff_t offset;
> +	/* associated refctr file offset of this probe, or zero */
> +	loff_t ref_ctr_offset;
> +	/* for internal uprobe infra use, consumers shouldn't touch fields below */
>  	struct uprobe_consumer *next;
>  };
>  
> @@ -110,10 +115,9 @@ extern bool is_trap_insn(uprobe_opcode_t *insn);
>  extern unsigned long uprobe_get_swbp_addr(struct pt_regs *regs);
>  extern unsigned long uprobe_get_trap_addr(struct pt_regs *regs);
>  extern int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_struct *mm, unsigned long vaddr, uprobe_opcode_t);
> -extern int uprobe_register(struct inode *inode, loff_t offset, struct uprobe_consumer *uc);
> -extern int uprobe_register_refctr(struct inode *inode, loff_t offset, loff_t ref_ctr_offset, struct uprobe_consumer *uc);
> +extern int uprobe_register(struct inode *inode, struct uprobe_consumer *uc);
>  extern int uprobe_apply(struct inode *inode, loff_t offset, struct uprobe_consumer *uc, bool);
> -extern void uprobe_unregister(struct inode *inode, loff_t offset, struct uprobe_consumer *uc);
> +extern void uprobe_unregister(struct inode *inode, struct uprobe_consumer *uc);
>  extern int uprobe_mmap(struct vm_area_struct *vma);
>  extern void uprobe_munmap(struct vm_area_struct *vma, unsigned long start, unsigned long end);
>  extern void uprobe_start_dup_mmap(void);
> @@ -152,11 +156,7 @@ static inline void uprobes_init(void)
>  #define uprobe_get_trap_addr(regs)	instruction_pointer(regs)
>  
>  static inline int
> -uprobe_register(struct inode *inode, loff_t offset, struct uprobe_consumer *uc)
> -{
> -	return -ENOSYS;
> -}
> -static inline int uprobe_register_refctr(struct inode *inode, loff_t offset, loff_t ref_ctr_offset, struct uprobe_consumer *uc)
> +uprobe_register(struct inode *inode, struct uprobe_consumer *uc)
>  {
>  	return -ENOSYS;
>  }
> @@ -166,7 +166,7 @@ uprobe_apply(struct inode *inode, loff_t offset, struct uprobe_consumer *uc, boo
>  	return -ENOSYS;
>  }
>  static inline void
> -uprobe_unregister(struct inode *inode, loff_t offset, struct uprobe_consumer *uc)
> +uprobe_unregister(struct inode *inode, struct uprobe_consumer *uc)
>  {
>  }
>  static inline int uprobe_mmap(struct vm_area_struct *vma)
> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> index 8ce669bc6474..2544e8b79bad 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -1197,14 +1197,13 @@ __uprobe_unregister(struct uprobe *uprobe, struct uprobe_consumer *uc)
>  /*
>   * uprobe_unregister - unregister an already registered probe.
>   * @inode: the file in which the probe has to be removed.
> - * @offset: offset from the start of the file.
> - * @uc: identify which probe if multiple probes are colocated.
> + * @uc: identify which probe consumer to unregister.
>   */
> -void uprobe_unregister(struct inode *inode, loff_t offset, struct uprobe_consumer *uc)
> +void uprobe_unregister(struct inode *inode, struct uprobe_consumer *uc)
>  {
>  	struct uprobe *uprobe;
>  
> -	uprobe = find_uprobe(inode, offset);
> +	uprobe = find_uprobe(inode, uc->offset);
>  	if (WARN_ON(!uprobe))
>  		return;
>  
> @@ -1277,20 +1276,12 @@ static int __uprobe_register(struct inode *inode, loff_t offset,
>  	return ret;
>  }
>  
> -int uprobe_register(struct inode *inode, loff_t offset,
> -		    struct uprobe_consumer *uc)
> +int uprobe_register(struct inode *inode, struct uprobe_consumer *uc)
>  {
> -	return __uprobe_register(inode, offset, 0, uc);
> +	return __uprobe_register(inode, uc->offset, uc->ref_ctr_offset, uc);
>  }
>  EXPORT_SYMBOL_GPL(uprobe_register);
>  
> -int uprobe_register_refctr(struct inode *inode, loff_t offset,
> -			   loff_t ref_ctr_offset, struct uprobe_consumer *uc)
> -{
> -	return __uprobe_register(inode, offset, ref_ctr_offset, uc);
> -}
> -EXPORT_SYMBOL_GPL(uprobe_register_refctr);
> -
>  /*
>   * uprobe_apply - unregister an already registered probe.
>   * @inode: the file in which the probe has to be removed.
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index d1daeab1bbc1..ba62baec3152 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -3154,8 +3154,6 @@ struct bpf_uprobe_multi_link;
>  
>  struct bpf_uprobe {
>  	struct bpf_uprobe_multi_link *link;
> -	loff_t offset;
> -	unsigned long ref_ctr_offset;
>  	u64 cookie;
>  	struct uprobe_consumer consumer;
>  };
> @@ -3181,8 +3179,7 @@ static void bpf_uprobe_unregister(struct path *path, struct bpf_uprobe *uprobes,
>  	u32 i;
>  
>  	for (i = 0; i < cnt; i++) {
> -		uprobe_unregister(d_real_inode(path->dentry), uprobes[i].offset,
> -				  &uprobes[i].consumer);
> +		uprobe_unregister(d_real_inode(path->dentry), &uprobes[i].consumer);
>  	}
>  }
>  
> @@ -3262,10 +3259,10 @@ static int bpf_uprobe_multi_link_fill_link_info(const struct bpf_link *link,
>  
>  	for (i = 0; i < ucount; i++) {
>  		if (uoffsets &&
> -		    put_user(umulti_link->uprobes[i].offset, uoffsets + i))
> +		    put_user(umulti_link->uprobes[i].consumer.offset, uoffsets + i))
>  			return -EFAULT;
>  		if (uref_ctr_offsets &&
> -		    put_user(umulti_link->uprobes[i].ref_ctr_offset, uref_ctr_offsets + i))
> +		    put_user(umulti_link->uprobes[i].consumer.ref_ctr_offset, uref_ctr_offsets + i))
>  			return -EFAULT;
>  		if (ucookies &&
>  		    put_user(umulti_link->uprobes[i].cookie, ucookies + i))
> @@ -3439,15 +3436,16 @@ int bpf_uprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
>  		goto error_free;
>  
>  	for (i = 0; i < cnt; i++) {
> -		if (__get_user(uprobes[i].offset, uoffsets + i)) {
> +		if (__get_user(uprobes[i].consumer.offset, uoffsets + i)) {
>  			err = -EFAULT;
>  			goto error_free;
>  		}
> -		if (uprobes[i].offset < 0) {
> +		if (uprobes[i].consumer.offset < 0) {
>  			err = -EINVAL;
>  			goto error_free;
>  		}
> -		if (uref_ctr_offsets && __get_user(uprobes[i].ref_ctr_offset, uref_ctr_offsets + i)) {
> +		if (uref_ctr_offsets &&
> +		    __get_user(uprobes[i].consumer.ref_ctr_offset, uref_ctr_offsets + i)) {
>  			err = -EFAULT;
>  			goto error_free;
>  		}
> @@ -3477,10 +3475,7 @@ int bpf_uprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
>  		      &bpf_uprobe_multi_link_lops, prog);
>  
>  	for (i = 0; i < cnt; i++) {
> -		err = uprobe_register_refctr(d_real_inode(link->path.dentry),
> -					     uprobes[i].offset,
> -					     uprobes[i].ref_ctr_offset,
> -					     &uprobes[i].consumer);
> +		err = uprobe_register(d_real_inode(link->path.dentry), &uprobes[i].consumer);
>  		if (err) {
>  			bpf_uprobe_unregister(&path, uprobes, i);
>  			goto error_free;
> diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
> index c98e3b3386ba..d786f99114be 100644
> --- a/kernel/trace/trace_uprobe.c
> +++ b/kernel/trace/trace_uprobe.c
> @@ -60,8 +60,6 @@ struct trace_uprobe {
>  	struct path			path;
>  	struct inode			*inode;
>  	char				*filename;
> -	unsigned long			offset;
> -	unsigned long			ref_ctr_offset;
>  	unsigned long			nhit;
>  	struct trace_probe		tp;
>  };
> @@ -205,7 +203,7 @@ static unsigned long translate_user_vaddr(unsigned long file_offset)
>  
>  	udd = (void *) current->utask->vaddr;
>  
> -	base_addr = udd->bp_addr - udd->tu->offset;
> +	base_addr = udd->bp_addr - udd->tu->consumer.offset;
>  	return base_addr + file_offset;
>  }
>  
> @@ -286,13 +284,13 @@ static bool trace_uprobe_match_command_head(struct trace_uprobe *tu,
>  	if (strncmp(tu->filename, argv[0], len) || argv[0][len] != ':')
>  		return false;
>  
> -	if (tu->ref_ctr_offset == 0)
> -		snprintf(buf, sizeof(buf), "0x%0*lx",
> -				(int)(sizeof(void *) * 2), tu->offset);
> +	if (tu->consumer.ref_ctr_offset == 0)
> +		snprintf(buf, sizeof(buf), "0x%0*llx",
> +				(int)(sizeof(void *) * 2), tu->consumer.offset);
>  	else
> -		snprintf(buf, sizeof(buf), "0x%0*lx(0x%lx)",
> -				(int)(sizeof(void *) * 2), tu->offset,
> -				tu->ref_ctr_offset);
> +		snprintf(buf, sizeof(buf), "0x%0*llx(0x%llx)",
> +				(int)(sizeof(void *) * 2), tu->consumer.offset,
> +				tu->consumer.ref_ctr_offset);
>  	if (strcmp(buf, &argv[0][len + 1]))
>  		return false;
>  
> @@ -410,7 +408,7 @@ static bool trace_uprobe_has_same_uprobe(struct trace_uprobe *orig,
>  
>  	list_for_each_entry(orig, &tpe->probes, tp.list) {
>  		if (comp_inode != d_real_inode(orig->path.dentry) ||
> -		    comp->offset != orig->offset)
> +		    comp->consumer.offset != orig->consumer.offset)
>  			continue;
>  
>  		/*
> @@ -472,8 +470,8 @@ static int validate_ref_ctr_offset(struct trace_uprobe *new)
>  
>  	for_each_trace_uprobe(tmp, pos) {
>  		if (new_inode == d_real_inode(tmp->path.dentry) &&
> -		    new->offset == tmp->offset &&
> -		    new->ref_ctr_offset != tmp->ref_ctr_offset) {
> +		    new->consumer.offset == tmp->consumer.offset &&
> +		    new->consumer.ref_ctr_offset != tmp->consumer.ref_ctr_offset) {
>  			pr_warn("Reference counter offset mismatch.");
>  			return -EINVAL;
>  		}
> @@ -675,8 +673,8 @@ static int __trace_uprobe_create(int argc, const char **argv)
>  		WARN_ON_ONCE(ret != -ENOMEM);
>  		goto fail_address_parse;
>  	}
> -	tu->offset = offset;
> -	tu->ref_ctr_offset = ref_ctr_offset;
> +	tu->consumer.offset = offset;
> +	tu->consumer.ref_ctr_offset = ref_ctr_offset;
>  	tu->path = path;
>  	tu->filename = filename;
>  
> @@ -746,12 +744,12 @@ static int trace_uprobe_show(struct seq_file *m, struct dyn_event *ev)
>  	char c = is_ret_probe(tu) ? 'r' : 'p';
>  	int i;
>  
> -	seq_printf(m, "%c:%s/%s %s:0x%0*lx", c, trace_probe_group_name(&tu->tp),
> +	seq_printf(m, "%c:%s/%s %s:0x%0*llx", c, trace_probe_group_name(&tu->tp),
>  			trace_probe_name(&tu->tp), tu->filename,
> -			(int)(sizeof(void *) * 2), tu->offset);
> +			(int)(sizeof(void *) * 2), tu->consumer.offset);
>  
> -	if (tu->ref_ctr_offset)
> -		seq_printf(m, "(0x%lx)", tu->ref_ctr_offset);
> +	if (tu->consumer.ref_ctr_offset)
> +		seq_printf(m, "(0x%llx)", tu->consumer.ref_ctr_offset);
>  
>  	for (i = 0; i < tu->tp.nr_args; i++)
>  		seq_printf(m, " %s=%s", tu->tp.args[i].name, tu->tp.args[i].comm);
> @@ -1089,12 +1087,7 @@ static int trace_uprobe_enable(struct trace_uprobe *tu, filter_func_t filter)
>  	tu->consumer.filter = filter;
>  	tu->inode = d_real_inode(tu->path.dentry);
>  
> -	if (tu->ref_ctr_offset)
> -		ret = uprobe_register_refctr(tu->inode, tu->offset,
> -				tu->ref_ctr_offset, &tu->consumer);
> -	else
> -		ret = uprobe_register(tu->inode, tu->offset, &tu->consumer);
> -
> +	ret = uprobe_register(tu->inode, &tu->consumer);
>  	if (ret)
>  		tu->inode = NULL;
>  
> @@ -1112,7 +1105,7 @@ static void __probe_event_disable(struct trace_probe *tp)
>  		if (!tu->inode)
>  			continue;
>  
> -		uprobe_unregister(tu->inode, tu->offset, &tu->consumer);
> +		uprobe_unregister(tu->inode, &tu->consumer);
>  		tu->inode = NULL;
>  	}
>  }
> @@ -1310,7 +1303,7 @@ static int uprobe_perf_close(struct trace_event_call *call,
>  		return 0;
>  
>  	list_for_each_entry(tu, trace_probe_probe_list(tp), tp.list) {
> -		ret = uprobe_apply(tu->inode, tu->offset, &tu->consumer, false);
> +		ret = uprobe_apply(tu->inode, tu->consumer.offset, &tu->consumer, false);
>  		if (ret)
>  			break;
>  	}
> @@ -1334,7 +1327,7 @@ static int uprobe_perf_open(struct trace_event_call *call,
>  		return 0;
>  
>  	list_for_each_entry(tu, trace_probe_probe_list(tp), tp.list) {
> -		err = uprobe_apply(tu->inode, tu->offset, &tu->consumer, true);
> +		err = uprobe_apply(tu->inode, tu->consumer.offset, &tu->consumer, true);
>  		if (err) {
>  			uprobe_perf_close(call, event);
>  			break;
> @@ -1464,7 +1457,7 @@ int bpf_get_uprobe_info(const struct perf_event *event, u32 *fd_type,
>  	*fd_type = is_ret_probe(tu) ? BPF_FD_TYPE_URETPROBE
>  				    : BPF_FD_TYPE_UPROBE;
>  	*filename = tu->filename;
> -	*probe_offset = tu->offset;
> +	*probe_offset = tu->consumer.offset;
>  	*probe_addr = 0;
>  	return 0;
>  }
> @@ -1627,9 +1620,9 @@ create_local_trace_uprobe(char *name, unsigned long offs,
>  		return ERR_CAST(tu);
>  	}
>  
> -	tu->offset = offs;
> +	tu->consumer.offset = offs;
>  	tu->path = path;
> -	tu->ref_ctr_offset = ref_ctr_offset;
> +	tu->consumer.ref_ctr_offset = ref_ctr_offset;
>  	tu->filename = kstrdup(name, GFP_KERNEL);
>  	if (!tu->filename) {
>  		ret = -ENOMEM;
> diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> index b0132a342bb5..9ae2a3c64daa 100644
> --- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> +++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> @@ -377,7 +377,6 @@ uprobe_ret_handler(struct uprobe_consumer *self, unsigned long func,
>  
>  struct testmod_uprobe {
>  	struct path path;
> -	loff_t offset;
>  	struct uprobe_consumer consumer;
>  };
>  
> @@ -391,25 +390,24 @@ static int testmod_register_uprobe(loff_t offset)
>  {
>  	int err = -EBUSY;
>  
> -	if (uprobe.offset)
> +	if (uprobe.consumer.offset)
>  		return -EBUSY;
>  
>  	mutex_lock(&testmod_uprobe_mutex);
>  
> -	if (uprobe.offset)
> +	if (uprobe.consumer.offset)
>  		goto out;
>  
>  	err = kern_path("/proc/self/exe", LOOKUP_FOLLOW, &uprobe.path);
>  	if (err)
>  		goto out;
>  
> -	err = uprobe_register_refctr(d_real_inode(uprobe.path.dentry),
> -				     offset, 0, &uprobe.consumer);
> -	if (err)
> +	uprobe.consumer.offset = offset;
> +	err = uprobe_register(d_real_inode(uprobe.path.dentry), &uprobe.consumer);
> +	if (err) {
>  		path_put(&uprobe.path);
> -	else
> -		uprobe.offset = offset;
> -
> +		uprobe.consumer.offset = 0;
> +	}
>  out:
>  	mutex_unlock(&testmod_uprobe_mutex);
>  	return err;
> @@ -419,10 +417,9 @@ static void testmod_unregister_uprobe(void)
>  {
>  	mutex_lock(&testmod_uprobe_mutex);
>  
> -	if (uprobe.offset) {
> -		uprobe_unregister(d_real_inode(uprobe.path.dentry),
> -				  uprobe.offset, &uprobe.consumer);
> -		uprobe.offset = 0;
> +	if (uprobe.consumer.offset) {
> +		uprobe_unregister(d_real_inode(uprobe.path.dentry), &uprobe.consumer);
> +		uprobe.consumer.offset = 0;
>  	}
>  
>  	mutex_unlock(&testmod_uprobe_mutex);
> -- 
> 2.43.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

