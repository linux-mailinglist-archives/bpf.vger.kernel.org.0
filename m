Return-Path: <bpf+bounces-33894-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07A82927901
	for <lists+bpf@lfdr.de>; Thu,  4 Jul 2024 16:41:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 230F51C235AB
	for <lists+bpf@lfdr.de>; Thu,  4 Jul 2024 14:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFA6C1B1202;
	Thu,  4 Jul 2024 14:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vLzJTmit"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757DA1AC247;
	Thu,  4 Jul 2024 14:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720104007; cv=none; b=IVKP/SW0XaFb8V2UzCfe3XUvJZTV4l4JtwsIxFQ/CvbcxO8qEOxxeuFO1I8YxcXRB/F2KQFgJyQiYYGe4YI+fy1eKMwnTw/DwIrYku+0PJwpbLWugHfeLQumA83fuISDFBze56uf14T2TgTv6zfiSi7SuaxKo6Z2wLZVITlBI9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720104007; c=relaxed/simple;
	bh=/YC5GMeMjS2gNuhqO35KQ87bb7zI/jgUaeZ0M7iy+Fs=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=p621proS2ewHZRvoUEpgqlMMx7rUu+ZsPITtm2IeAjuo+1FGTu5oEFvSCVVNpsYzzWL0IFY/rNEHW9AwGKOK4BXRiGqMqQxZ4zpPPhH2JxwTj7xgUK3fa9pkoZ+stuKa7CsI1Ec4ZCo+e9srXp3I2JHCNy8BR8MF3yk92eoubFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vLzJTmit; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 534CFC3277B;
	Thu,  4 Jul 2024 14:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720104007;
	bh=/YC5GMeMjS2gNuhqO35KQ87bb7zI/jgUaeZ0M7iy+Fs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=vLzJTmitOafc2YPJPYZJDskgTTpzCbHUtPU7LwOKb8ZpFnTHlKKuzSAYt3l4YlHLx
	 RDHULY0R9W6B4N11LhXGxtWthCPi4DsQ1GaPJB/tSPkbJGZi9bSIPRhqWfySutbdQq
	 hnd3Kzb44drnltm6tTRxSB1+Y9aLHmMoZrWGZqrkBwbN6xqjVA5ffkSZNtPuLnxnR0
	 Pew/DoStnextUGUQgtFnHiOtdHpcPQqVHZ+J+hfVlFF4XkrzpRH2sA439xO2N43Vni
	 wFvx42qQ0TaNMFOpKVl3BFlPUP2qoLvViT2G5MBT+Lsi99Aaf9Deuoq1KffZu850wk
	 YHp3hgF5KqcWA==
Date: Thu, 4 Jul 2024 23:40:02 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Andrii Nakryiko
 <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org,
 rostedt@goodmis.org, mhiramat@kernel.org, oleg@redhat.com,
 mingo@redhat.com, bpf@vger.kernel.org, jolsa@kernel.org,
 paulmck@kernel.org, clm@meta.com
Subject: Re: [PATCH v2 04/12] uprobes: revamp uprobe refcounting and
 lifetime management
Message-Id: <20240704234002.115ca8f3509d7896a851f77f@kernel.org>
In-Reply-To: <20240704084524.GC28838@noisy.programming.kicks-ass.net>
References: <20240701223935.3783951-1-andrii@kernel.org>
	<20240701223935.3783951-5-andrii@kernel.org>
	<20240703133608.GO11386@noisy.programming.kicks-ass.net>
	<CAEf4BzZQQJGrC+tCbrU90JNpXxH8-vBg_c5GzjS=FLZp0PfExA@mail.gmail.com>
	<20240704080348.GP11386@noisy.programming.kicks-ass.net>
	<20240704084524.GC28838@noisy.programming.kicks-ass.net>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 4 Jul 2024 10:45:24 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Thu, Jul 04, 2024 at 10:03:48AM +0200, Peter Zijlstra wrote:
> 
> > diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
> > index c98e3b3386ba..4aafb4485be7 100644
> > --- a/kernel/trace/trace_uprobe.c
> > +++ b/kernel/trace/trace_uprobe.c
> > @@ -1112,7 +1112,8 @@ static void __probe_event_disable(struct trace_probe *tp)
> >  		if (!tu->inode)
> >  			continue;
> >  
> > -		uprobe_unregister(tu->inode, tu->offset, &tu->consumer);
> > +		uprobe_unregister(tu->inode, tu->offset, &tu->consumer,
> > +				  list_is_last(trace_probe_probe_list(tp), &tu->tp.list) ? 0 : URF_NO_SYNC);
> >  		tu->inode = NULL;
> >  	}
> >  }
> 
> 
> Hmm, that continue clause might ruin things. Still easy enough to add
> uprobe_unregister_sync() and simpy always pass URF_NO_SYNC.
> 
> I really don't see why we should make this more complicated than it
> needs to be.
> 
> diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
> index 354cab634341..681741a51df3 100644
> --- a/include/linux/uprobes.h
> +++ b/include/linux/uprobes.h
> @@ -115,7 +115,9 @@ extern int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_struct *mm
>  extern int uprobe_register(struct inode *inode, loff_t offset, struct uprobe_consumer *uc);
>  extern int uprobe_register_refctr(struct inode *inode, loff_t offset, loff_t ref_ctr_offset, struct uprobe_consumer *uc);
>  extern int uprobe_apply(struct inode *inode, loff_t offset, struct uprobe_consumer *uc, bool);
> -extern void uprobe_unregister(struct inode *inode, loff_t offset, struct uprobe_consumer *uc);
> +#define URF_NO_SYNC	0x01
> +extern void uprobe_unregister(struct inode *inode, loff_t offset, struct uprobe_consumer *uc, unsigned int flags);
> +extern void uprobe_unregister_sync(void);
>  extern int uprobe_mmap(struct vm_area_struct *vma);
>  extern void uprobe_munmap(struct vm_area_struct *vma, unsigned long start, unsigned long end);
>  extern void uprobe_start_dup_mmap(void);
> @@ -165,7 +167,7 @@ uprobe_apply(struct inode *inode, loff_t offset, struct uprobe_consumer *uc, boo
>  	return -ENOSYS;
>  }
>  static inline void
> -uprobe_unregister(struct inode *inode, loff_t offset, struct uprobe_consumer *uc)
> +uprobe_unregister(struct inode *inode, loff_t offset, struct uprobe_consumer *uc, unsigned int flags)

nit: IMHO, I would like to see uprobe_unregister_nosync() variant instead of
adding flags.

Thank you,

>  {
>  }
>  static inline int uprobe_mmap(struct vm_area_struct *vma)
> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> index 0b7574a54093..d09f7b942076 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -1145,7 +1145,7 @@ __uprobe_unregister(struct uprobe *uprobe, struct uprobe_consumer *uc)
>   * @offset: offset from the start of the file.
>   * @uc: identify which probe if multiple probes are colocated.
>   */
> -void uprobe_unregister(struct inode *inode, loff_t offset, struct uprobe_consumer *uc)
> +void uprobe_unregister(struct inode *inode, loff_t offset, struct uprobe_consumer *uc, unsigned int flags)
>  {
>  	scoped_guard (srcu, &uprobe_srcu) {
>  		struct uprobe *uprobe = find_uprobe(inode, offset);
> @@ -1157,10 +1157,17 @@ void uprobe_unregister(struct inode *inode, loff_t offset, struct uprobe_consume
>  		mutex_unlock(&uprobe->register_mutex);
>  	}
>  
> -	synchronize_srcu(&uprobe_srcu); // XXX amortize / batch
> +	if (!(flags & URF_NO_SYNC))
> +		synchronize_srcu(&uprobe_srcu);
>  }
>  EXPORT_SYMBOL_GPL(uprobe_unregister);
>  
> +void uprobe_unregister_sync(void)
> +{
> +	synchronize_srcu(&uprobe_srcu);
> +}
> +EXPORT_SYMBOL_GPL(uprobe_unregister_sync);
> +
>  /*
>   * __uprobe_register - register a probe
>   * @inode: the file in which the probe has to be placed.
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index d1daeab1bbc1..1f6adabbb1e7 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -3181,9 +3181,10 @@ static void bpf_uprobe_unregister(struct path *path, struct bpf_uprobe *uprobes,
>  	u32 i;
>  
>  	for (i = 0; i < cnt; i++) {
> -		uprobe_unregister(d_real_inode(path->dentry), uprobes[i].offset,
> -				  &uprobes[i].consumer);
> +		uprobe_unregister(d_real_inode(path->dentry), uprobes[i].offset, URF_NO_SYNC);
>  	}
> +	if (cnt > 0)
> +		uprobe_unregister_sync();
>  }
>  
>  static void bpf_uprobe_multi_link_release(struct bpf_link *link)
> diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
> index c98e3b3386ba..6b64470a1c5c 100644
> --- a/kernel/trace/trace_uprobe.c
> +++ b/kernel/trace/trace_uprobe.c
> @@ -1104,6 +1104,7 @@ static int trace_uprobe_enable(struct trace_uprobe *tu, filter_func_t filter)
>  static void __probe_event_disable(struct trace_probe *tp)
>  {
>  	struct trace_uprobe *tu;
> +	bool sync = false;
>  
>  	tu = container_of(tp, struct trace_uprobe, tp);
>  	WARN_ON(!uprobe_filter_is_empty(tu->tp.event->filter));
> @@ -1112,9 +1113,12 @@ static void __probe_event_disable(struct trace_probe *tp)
>  		if (!tu->inode)
>  			continue;
>  
> -		uprobe_unregister(tu->inode, tu->offset, &tu->consumer);
> +		uprobe_unregister(tu->inode, tu->offset, &tu->consumer, URF_NO_SYNC);
> +		sync = true;
>  		tu->inode = NULL;
>  	}
> +	if (sync)
> +		uprobe_unregister_sync();
>  }
>  
>  static int probe_event_enable(struct trace_event_call *call,


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

