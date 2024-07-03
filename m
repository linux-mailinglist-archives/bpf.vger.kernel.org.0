Return-Path: <bpf+bounces-33734-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91B3992552A
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2024 10:14:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4321E28602C
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2024 08:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E347139CE2;
	Wed,  3 Jul 2024 08:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZauMvKPd"
X-Original-To: bpf@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C35D13A240;
	Wed,  3 Jul 2024 08:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719994446; cv=none; b=arW/XUDVemXosmUmnO/oTzMip+Uy3EL+tSHRE09DebB5sAdlnBswVq/9Nkbp+BbypihbivquD1ZYIOId1h0/XYIWeIX1vwiQSNPO38vAaQN+PPwRe00dZ0SgTm43Ab2oRtGNha4P3N+xVwXMaAwb7PB4pimgyzsWDTc3GWZYs0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719994446; c=relaxed/simple;
	bh=UbrT7MLEbcbQzeNgLCfOBCxSek/yGusozCZS6BByWiw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QTYq4nAh6CAKr92mwctYJAuciA3uH91g+BSTot2ePsi9YktsKi1H9qOBfGYOzbimk7Q2ZI3a4lAO49Ud6oaAO9Y55dq3Ni+929vQFtwj4D/hUa8G7et45wM4MEwCiYntYPGNaqNnXLUKalwvqM24IyKpQlFJzFET5mL+sejFov8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ZauMvKPd; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=h1FAH4DAPdebB/Wse9W0SfJUP8z/jO44OvECbxhA2NA=; b=ZauMvKPdPFXeDgFFJ4m2TGJYS4
	SbSNyZq+L5sXQZIPWaUdQHpKeRxXnBGZ8yjp1JyNN9f0NmYl/XJJz6pi6EiAbVF1FpUCm1sWXn7+b
	tey31dq7pHoNdi8ptQMjQyhhj5pi6V7yTR/NztqcIzTFAMd3mQYUiHg7kkLG4oHNmmy4GTiB24Jck
	7KDI5OXnm0gFc4eF0T4GgXjpfr1qG9KHvOGtGZ7SECD7DbviUk04AIWF1mgWr8o6raIx4WEy1Pmmp
	GENIJsPhKJNEV0MYsAGbyJ/zi192VBGG25PcmZ8y/PRPKD3lRnoX6B/51kguGrzzC0GGBsFnAMMDw
	jF1ZGiKQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOv77-00000009whu-170q;
	Wed, 03 Jul 2024 08:13:50 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 32C2B3006B7; Wed,  3 Jul 2024 10:13:15 +0200 (CEST)
Date: Wed, 3 Jul 2024 10:13:15 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, rostedt@goodmis.org,
	mhiramat@kernel.org, oleg@redhat.com, mingo@redhat.com,
	bpf@vger.kernel.org, jolsa@kernel.org, paulmck@kernel.org,
	clm@meta.com
Subject: Re: [PATCH v2 05/12] uprobes: move offset and ref_ctr_offset into
 uprobe_consumer
Message-ID: <20240703081315.GN11386@noisy.programming.kicks-ass.net>
References: <20240701223935.3783951-1-andrii@kernel.org>
 <20240701223935.3783951-6-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240701223935.3783951-6-andrii@kernel.org>

On Mon, Jul 01, 2024 at 03:39:28PM -0700, Andrii Nakryiko wrote:
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
> Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  include/linux/uprobes.h                       | 18 +++----
>  kernel/events/uprobes.c                       | 19 ++-----
>  kernel/trace/bpf_trace.c                      | 21 +++-----
>  kernel/trace/trace_uprobe.c                   | 53 ++++++++-----------
>  .../selftests/bpf/bpf_testmod/bpf_testmod.c   | 22 ++++----
>  5 files changed, 55 insertions(+), 78 deletions(-)
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

It seems very weird and unnatural to split inode and offset like this.
The whole offset thing only makes sense within the context of an inode.

So yeah, lets not do this.

