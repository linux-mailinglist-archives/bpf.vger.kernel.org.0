Return-Path: <bpf+bounces-61493-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06E61AE76AC
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 08:04:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A165E5A135E
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 06:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 401441E3787;
	Wed, 25 Jun 2025 06:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CXG/9r0d"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2116367;
	Wed, 25 Jun 2025 06:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750831473; cv=none; b=m3DNptbJV7ZDSbUg4OAT/ttKC5avHU73fYjrknMBJPKtEV11b55bedpjPD1m1oGxWAb0oB72LSEUgmL57V5ZceGlPEjXK8I1YV5jknf408nDxsL4KLRNmy4WpDLkGcYKnAgnuNg5sfeW3dXFpkoNoNHsV2NE8IwPTECaycOWnEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750831473; c=relaxed/simple;
	bh=76VGGKAqigMaJenupp9hk8dQHtelG15+lysezKsW0wA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=FjgzbnrLYOMqIVL3LOqOWzQOKfib11CCqP7iWVHMWzdNp7R4NuktB2hjkeWja4k99PAdtKziHLe3/JybpShGAKHdueihEg6khxj+ho6HgL9niUlaFJnLBI5H5enCYZ+d3XQ8aWl5x2/xWGJPOGHoHtJEWsb5CRH9DduziVmSwNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CXG/9r0d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2DBBC4CEEA;
	Wed, 25 Jun 2025 06:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750831473;
	bh=76VGGKAqigMaJenupp9hk8dQHtelG15+lysezKsW0wA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CXG/9r0dbh4S+Nh+g6uxzVpttvRdirM4k9Z1cPoX0AM6QKVangDyE7CZffoA5TUsZ
	 iK3eFxH/x7XidVEMeZQbMpYH51wqQldsnAr8Yp2R61j+7R5sNeo7S0e/Sch1c5+td7
	 yuL4fBsej9MabYdKiyc1AZrJvmeJaaQrRTjqXbT7b+fvkShJX1podJ+M+tWlcAeM2b
	 qaApWhp69xAd9n2bfOoZpAMSyQ3jzOL0w5OuYlBnc6ACGkKIp4gJcb4UwHrC37HQyJ
	 PsHfAkzeRWnDBE1ZXrm9vAbZdGGbqeKwowQSku4Etf56GF01HeRQsHbZiwL8G2asyl
	 Ex4RQVU5GLQzw==
Date: Wed, 25 Jun 2025 15:04:29 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Jiri Olsa <jolsa@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 x86@kernel.org, Song Liu <songliubraving@fb.com>, Yonghong Song
 <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>, Hao Luo
 <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Alan Maguire <alan.maguire@oracle.com>, David Laight
 <David.Laight@ACULAB.COM>, Thomas =?UTF-8?B?V2Vpw59zY2h1aA==?=
 <thomas@t-8ch.de>, Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCHv3 perf/core 01/22] uprobes: Remove breakpoint in
 unapply_uprobe under mmap_write_lock
Message-Id: <20250625150429.0623e05b3b1bba2d95b57dc5@kernel.org>
In-Reply-To: <20250605132350.1488129-2-jolsa@kernel.org>
References: <20250605132350.1488129-1-jolsa@kernel.org>
	<20250605132350.1488129-2-jolsa@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  5 Jun 2025 15:23:28 +0200
Jiri Olsa <jolsa@kernel.org> wrote:

> Currently unapply_uprobe takes mmap_read_lock, but it might call
> remove_breakpoint which eventually changes user pages.
> 
> Current code writes either breakpoint or original instruction, so it can
> go away with read lock as explained in here [1]. But with the upcoming
> change that writes multiple instructions on the probed address we need
> to ensure that any update to mm's pages is exclusive.
> 
> [1] https://lore.kernel.org/all/20240710140045.GA1084@redhat.com/
> 

Looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks,



> Acked-by: Oleg Nesterov <oleg@redhat.com>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  kernel/events/uprobes.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> index 84ee7b590861..257581432cd8 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -483,7 +483,7 @@ static int __uprobe_write_opcode(struct vm_area_struct *vma,
>   * @opcode_vaddr: the virtual address to store the opcode.
>   * @opcode: opcode to be written at @opcode_vaddr.
>   *
> - * Called with mm->mmap_lock held for read or write.
> + * Called with mm->mmap_lock held for write.
>   * Return 0 (success) or a negative errno.
>   */
>  int uprobe_write_opcode(struct arch_uprobe *auprobe, struct vm_area_struct *vma,
> @@ -1464,7 +1464,7 @@ static int unapply_uprobe(struct uprobe *uprobe, struct mm_struct *mm)
>  	struct vm_area_struct *vma;
>  	int err = 0;
>  
> -	mmap_read_lock(mm);
> +	mmap_write_lock(mm);
>  	for_each_vma(vmi, vma) {
>  		unsigned long vaddr;
>  		loff_t offset;
> @@ -1481,7 +1481,7 @@ static int unapply_uprobe(struct uprobe *uprobe, struct mm_struct *mm)
>  		vaddr = offset_to_vaddr(vma, uprobe->offset);
>  		err |= remove_breakpoint(uprobe, vma, vaddr);
>  	}
> -	mmap_read_unlock(mm);
> +	mmap_write_unlock(mm);
>  
>  	return err;
>  }
> -- 
> 2.49.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

