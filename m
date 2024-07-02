Return-Path: <bpf+bounces-33617-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 653F3923D17
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 14:02:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 667C91C21127
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 12:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 967E115CD7F;
	Tue,  2 Jul 2024 12:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WnUXE+J4"
X-Original-To: bpf@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7515B15B10F;
	Tue,  2 Jul 2024 12:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719921727; cv=none; b=R4o0Muva/BZMSSW3P2lOKfOj7/1I2KArcnaP5Na3bCO0G9W1VZIiYvgwyraFGPYDkJpKfOookLgrkVgc+wtZjx2lqcGXeM4lADOoFC6Mhzjzvz/APPOueEZgK5uVO8w7dI2OZCWxDGz/VBBY5JADWK5O116/8FprP+46+ma5zv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719921727; c=relaxed/simple;
	bh=6+CKEhkMe2CwGR+Amp7jTJil14pHK7hidnCRm1NzLUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CLufIpVZ0BpANB2i4s0v6/1lrDmqJS6TiZmsZ5BW5Tu9v3OMfpvIOJlp6yB9JjW8AbYq8RAymIxWktevv3Ft1lBgh+tv7foGovqC49NAhkQPKJqjH5p5Qw9CNov+VaShuJVfxrQXZqfssiFiMoNMKb3XNwHFmX7avdiXWUx+0Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=WnUXE+J4; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=0fmx3brueG8ivWi5L34jTrdGNl5ELxv76aQMcr2RTXo=; b=WnUXE+J4kbnZsAZ76RZ0vqfdQk
	3JuiTVdML6uB4KHOnfAkfWCuwAdIutswauOpSND1ZnjXSAtIe5clKphzN5RkN0oyPLiB1JTfWnP8S
	YwqIOaciyPC0Q089w7KFjsyaUSDpEq9ESI5f7ph6GhMezWdRGJXVEQF+xEi+9yi69al+NWAghSX+4
	xhSR45VYN2BSJjBRUGYJSAa1+EThrPsO/Z+h1H10yBzAzTA0W1uQunhj4pkOq8rbp7xFSCWIMQvNY
	s4Fc3t6afro8faGCHOrM1+owya1b8QV+rE6AhpYrSm6zGC+LiD24TNbSg76jLP+vXGtnCWuQhbc7g
	bvIw23LA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOcCj-00000009obd-3Lry;
	Tue, 02 Jul 2024 12:01:51 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id C24B0300694; Tue,  2 Jul 2024 14:01:46 +0200 (CEST)
Date: Tue, 2 Jul 2024 14:01:46 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, rostedt@goodmis.org,
	mhiramat@kernel.org, oleg@redhat.com, mingo@redhat.com,
	bpf@vger.kernel.org, jolsa@kernel.org, paulmck@kernel.org,
	clm@meta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/12] uprobes: add batched register/unregister APIs
 and per-CPU RW semaphore
Message-ID: <20240702120146.GB28838@noisy.programming.kicks-ass.net>
References: <20240701223935.3783951-1-andrii@kernel.org>
 <20240702102353.GG11386@noisy.programming.kicks-ass.net>
 <20240702115447.GA28838@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240702115447.GA28838@noisy.programming.kicks-ass.net>

On Tue, Jul 02, 2024 at 01:54:47PM +0200, Peter Zijlstra wrote:

> @@ -668,12 +677,25 @@ static struct uprobe *__find_uprobe(struct inode *inode, loff_t offset)
>  static struct uprobe *find_uprobe(struct inode *inode, loff_t offset)
>  {
>  	struct uprobe *uprobe;
> +	unsigned seq;
>  
> +	guard(rcu)();
>  
> +	do {
> +		seq = read_seqcount_begin(&uprobes_seqcount);
> +		uprobes = __find_uprobe(inode, offset);
> +		if (uprobes) {
> +			/*
> +			 * Lockless RB-tree lookups are prone to false-negatives.
> +			 * If they find something, it's good. If they do not find,
> +			 * it needs to be validated.
> +			 */
> +			return uprobes;
> +		}
> +	} while (read_seqcount_retry(&uprobes_seqcount, seq));
> +
> +	/* Really didn't find anything. */
> +	return NULL;
>  }
>  
>  static struct uprobe *__insert_uprobe(struct uprobe *uprobe)
> @@ -702,7 +724,9 @@ static struct uprobe *insert_uprobe(struct uprobe *uprobe)
>  	struct uprobe *u;
>  
>  	write_lock(&uprobes_treelock);
> +	write_seqcount_begin(&uprobes_seqcount);
>  	u = __insert_uprobe(uprobe);
> +	write_seqcount_end(&uprobes_seqcount);
>  	write_unlock(&uprobes_treelock);
>  
>  	return u;

Strictly speaking I suppose we should add rb_find_rcu() and
rc_find_add_rcu() that sprinkle some rcu_dereference_raw() and
rb_link_node_rcu() around. See the examples in __lt_find() and
__lt_insert().


