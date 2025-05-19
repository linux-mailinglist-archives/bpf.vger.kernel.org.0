Return-Path: <bpf+bounces-58516-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E26A1ABCBBC
	for <lists+bpf@lfdr.de>; Tue, 20 May 2025 01:49:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79B551B62D80
	for <lists+bpf@lfdr.de>; Mon, 19 May 2025 23:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E71A22126F;
	Mon, 19 May 2025 23:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p79LCThA"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20575220F52;
	Mon, 19 May 2025 23:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747698531; cv=none; b=k9qiDdvwF/Lr7JdjDUB36le+5WV93NE1975ZFZSb98ZPZ8NsYIbgaEdCvjE1elykXF9kySUfnqfTcfNrl2AapIT061FObYXZICzx6hhvTsOE65yi06srArKyno6L9wEmqwSy9XALVxYty46bVVv05OfqAup19BvglW8PHVtQSXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747698531; c=relaxed/simple;
	bh=LMijej7gFtPDNBIOlBJu1tJ8zpVTvJVhOg0iGAqbUB4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=qfe+xLTB4hqy9/KQ5fy655WWQ4/ZlpfwoyJ67uRAvSeMKofVuaRs2k02YOEuQ1ARdAdJp+F6CszdH1s69Yhi0QDBj8ynCEhqMPrNcm3UchqhCKX3P1QdVtQ2pmyIBRf8uFLddzcsonR9gOc4QSMbyKOMXEGiNrkFjUHxoMS09JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p79LCThA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E71C4C4CEE4;
	Mon, 19 May 2025 23:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747698530;
	bh=LMijej7gFtPDNBIOlBJu1tJ8zpVTvJVhOg0iGAqbUB4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=p79LCThAtnHz+EDt53BzdMUN6qagFtutqFTVD3F35ZSzCJxO0VXbNLV03KoUCdtjq
	 /LMV73wPmUxo48wg9Y8XWztyKz9KR6oLY+bg+j00yRPj+LK2bDu6I2H9UPrjfVYP70
	 /jmOmTkQ3tju7Ur4CPiWXTkBkbZX4kpsQr/EA6y1aa36SHyC3yt+zZhMj2x200cZTR
	 bp/nqglcL5VuHI20xid+S+OA822wfZFdC9IBrj6qvRMM5XdFOcUsToGOpz7/9S9PoF
	 WVP0X3YH9kZGMPQ7VpQCp0DRqHue528ouTn6ZkNeUjn0Wxtg42NdDKNwknkyWrI5Yo
	 tXULjqg5FexNA==
Date: Tue, 20 May 2025 08:48:45 +0900
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
Subject: Re: [PATCHv2 perf/core 01/22] uprobes: Remove breakpoint in
 unapply_uprobe under mmap_write_lock
Message-Id: <20250520084845.6388479dd18658d2c2598953@kernel.org>
In-Reply-To: <20250515121121.2332905-2-jolsa@kernel.org>
References: <20250515121121.2332905-1-jolsa@kernel.org>
	<20250515121121.2332905-2-jolsa@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 15 May 2025 14:10:58 +0200
Jiri Olsa <jolsa@kernel.org> wrote:

> Currently unapply_uprobe takes mmap_read_lock, but it might call
> remove_breakpoint which eventually changes user pages.
> 
> Current code writes either breakpoint or original instruction, so
> it can probably go away with that, but with the upcoming change that
> writes multiple instructions on the probed address we need to ensure
> that any update to mm's pages is exclusive.
> 

So, this is a bugfix, right?

Thanks,

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

