Return-Path: <bpf+bounces-32983-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7324E915BB4
	for <lists+bpf@lfdr.de>; Tue, 25 Jun 2024 03:29:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A3061F219A4
	for <lists+bpf@lfdr.de>; Tue, 25 Jun 2024 01:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DF3917991;
	Tue, 25 Jun 2024 01:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d6CTwfej"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9535417BA0;
	Tue, 25 Jun 2024 01:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719278970; cv=none; b=BKU96CfFGKazbE4d+5iHM/7U/EyMIy3l+XAdZRUZ7jxQ1b0FIbDUFp8prFPw/9iOcNCIlncRud+63UxH6WBCBy8++HbE29c6UOM8cQkqWVx5peitn1A18GDH5BOS2KN6N/RDL2ZZG8IJrydpoQm7Y/VXQqcluXEkBjfwK61ijFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719278970; c=relaxed/simple;
	bh=XjjssAJBNddISSmt0hM1wukuGTlEDquHwFEQeOSzgs4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=u1TNo8SVP7nE30I+QcFTFyJ7Z7qbl96mwedPFlRa/VN92xdnfxH4Qp4w/l+6RHr8yHWm4IxhkgwWNmuJSacGVeBmRxiJ3RLRsSh0897XavXmlyEurPUeAYPQA8Jco9JPhkVa2cIpKcmOe6s8HBQR0NrpAH3AfCrGt9Rpzd6JGZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d6CTwfej; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99899C2BBFC;
	Tue, 25 Jun 2024 01:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719278970;
	bh=XjjssAJBNddISSmt0hM1wukuGTlEDquHwFEQeOSzgs4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=d6CTwfejUWlq+zJgBuG5rWdq1qOTX82B+zEGVzUCSgjqgs7fpj6s3Yz5WZe1QPN2x
	 W1uBY//I9XC695m4sUPKzQl3zGPHof96/IMWCrjXlOjUWjq7ccZ8H/kG0fgyZwBeLs
	 Bk7+JrWz1u3clZyoDeE27KNup7JoOhVgKULJysk1W44Btloay2NFMEnGhDJHmJLFIX
	 opFouUJYR6o6qTpSXov4jauVsRE3nMGWt1I45G4/Qxpzh//V3SYjLlArMcbaPjN6xZ
	 KdeobwIfucOxIvCoqZF6Vi48ob69tqzot8vJ926G00GvyddL9vQTR/wAx8reUaZs+L
	 X+LXMBsbtmmiA==
Date: Tue, 25 Jun 2024 10:29:25 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, rostedt@goodmis.org,
 oleg@redhat.com, peterz@infradead.org, mingo@redhat.com,
 bpf@vger.kernel.org, jolsa@kernel.org, paulmck@kernel.org, clm@meta.com
Subject: Re: [PATCH 02/12] uprobes: grab write mmap lock in unapply_uprobe()
Message-Id: <20240625102925.665f2fa3b39dc7602b1321d8@kernel.org>
In-Reply-To: <20240625002144.3485799-3-andrii@kernel.org>
References: <20240625002144.3485799-1-andrii@kernel.org>
	<20240625002144.3485799-3-andrii@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 24 Jun 2024 17:21:34 -0700
Andrii Nakryiko <andrii@kernel.org> wrote:

> Given unapply_uprobe() can call remove_breakpoint() which eventually
> calls uprobe_write_opcode(), which can modify a set of memory pages and
> expects mm->mmap_lock held for write, it needs to have writer lock.
> 
> Fix this by switching to mmap_write_lock()/mmap_write_unlock().
> 

Oops, it is an actual bug, right?

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks,

> Fixes: da1816b1caec ("uprobes: Teach handler_chain() to filter out the probed task")
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  kernel/events/uprobes.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> index 197fbe4663b5..e896eeecb091 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -1235,7 +1235,7 @@ static int unapply_uprobe(struct uprobe *uprobe, struct mm_struct *mm)
>  	struct vm_area_struct *vma;
>  	int err = 0;
>  
> -	mmap_read_lock(mm);
> +	mmap_write_lock(mm);
>  	for_each_vma(vmi, vma) {
>  		unsigned long vaddr;
>  		loff_t offset;
> @@ -1252,7 +1252,7 @@ static int unapply_uprobe(struct uprobe *uprobe, struct mm_struct *mm)
>  		vaddr = offset_to_vaddr(vma, uprobe->offset);
>  		err |= remove_breakpoint(uprobe, mm, vaddr);
>  	}
> -	mmap_read_unlock(mm);
> +	mmap_write_unlock(mm);
>  
>  	return err;
>  }
> -- 
> 2.43.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

