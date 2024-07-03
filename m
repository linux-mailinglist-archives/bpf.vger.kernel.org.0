Return-Path: <bpf+bounces-33771-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EA829261A2
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2024 15:18:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F152FB2B504
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2024 13:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AC43172777;
	Wed,  3 Jul 2024 13:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a9tIHEnk"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 219E71E4BE;
	Wed,  3 Jul 2024 13:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720012530; cv=none; b=Y+MnERVqXC0LI5IRNXbw9B9K6NNtIR3gqYhP1Ckz+Q6xb1mJRsal4/ZQirQUOcQxo0qSQ4Uv06IbkjomhcFvEBCaE2ywBxr+0g6SRW2JZ7MKH8Zl2/jtYpnJWqPFlI9U5uOneNTSP3Q18L6Km5GqUOD2Yo/ZJ006CCF71kMavq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720012530; c=relaxed/simple;
	bh=pp9IYcc32SZRbVofOh0Qkhr0fzVFapnBx6KENqMEW60=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=QsoEXQg5ncoj8aEUHBmSa9vAqEI8u3Fa0HpmdcKKK/wvOulKC1hr3tM+GKleKozGY3isga74/5UAHROIFXf9sIORWOfMxMJ/zx9E80Qbs2LeGQ7qS2rdwtnMCWVn8GeGOUbNrJaWAJUnBy5nPuqaecj+2NiWSlC1BZZlDnHGB+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a9tIHEnk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74258C2BD10;
	Wed,  3 Jul 2024 13:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720012529;
	bh=pp9IYcc32SZRbVofOh0Qkhr0fzVFapnBx6KENqMEW60=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=a9tIHEnkLMgStKfgO2iJaVkYL3WlY6Lt9JVIKL0YOdbq/WtARvixdcj2ugHbMcyi4
	 ef9/Dc1DxJBLp3j0GKKouMJ1Hlrg8wvOlxoM2GIyGl/bblde92pWuzUe3kqGafjVBG
	 zbSYyC2jd4woe5tIAJ3ziKNt5Pup/zODIFTPdyn9ek09vz9TxiNKmukhfhVkyJ1J7X
	 YUk40SEjG02Vo1dY9fU7aU0LnnSHId60lavxussjknn/SJf+RIjPdLUlbjO+iR82tK
	 4AQfyjzyDzVUapudeia3Sasli15hGWPvsz9PaYwup7vFMmoPs4rXEyU0H7YwuGwMrU
	 0o8LZ2DiDu+cA==
Date: Wed, 3 Jul 2024 22:15:25 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, rostedt@goodmis.org,
 oleg@redhat.com, peterz@infradead.org, mingo@redhat.com,
 bpf@vger.kernel.org, jolsa@kernel.org, paulmck@kernel.org, clm@meta.com
Subject: Re: [PATCH v2 02/12] uprobes: correct mmap_sem locking assumptions
 in uprobe_write_opcode()
Message-Id: <20240703221525.dff79d6c71af3921ca7a7232@kernel.org>
In-Reply-To: <20240701223935.3783951-3-andrii@kernel.org>
References: <20240701223935.3783951-1-andrii@kernel.org>
	<20240701223935.3783951-3-andrii@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  1 Jul 2024 15:39:25 -0700
Andrii Nakryiko <andrii@kernel.org> wrote:

> It seems like uprobe_write_opcode() doesn't require writer locked
> mmap_sem, any lock (reader or writer) should be sufficient. This was
> established in a discussion in [0] and looking through existing code
> seems to confirm that there is no need for write-locked mmap_sem.
> 
> Fix the comment to state this clearly.
> 
>   [0] https://lore.kernel.org/linux-trace-kernel/20240625190748.GC14254@redhat.com/
> 
> Fixes: 29dedee0e693 ("uprobes: Add mem_cgroup_charge_anon() into uprobe_write_opcode()")

nit: why this has Fixes but [01/12] doesn't?

Should I pick both to fixes branch?

Thank you,

> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  kernel/events/uprobes.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> index 081821fd529a..f87049c08ee9 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -453,7 +453,7 @@ static int update_ref_ctr(struct uprobe *uprobe, struct mm_struct *mm,
>   * @vaddr: the virtual address to store the opcode.
>   * @opcode: opcode to be written at @vaddr.
>   *
> - * Called with mm->mmap_lock held for write.
> + * Called with mm->mmap_lock held for read or write.
>   * Return 0 (success) or a negative errno.
>   */
>  int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_struct *mm,
> -- 
> 2.43.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

