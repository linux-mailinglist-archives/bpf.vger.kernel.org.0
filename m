Return-Path: <bpf+bounces-43268-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE6C89B2214
	for <lists+bpf@lfdr.de>; Mon, 28 Oct 2024 02:51:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45190B2141C
	for <lists+bpf@lfdr.de>; Mon, 28 Oct 2024 01:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B3FE14D43D;
	Mon, 28 Oct 2024 01:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h4cqvTfB"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C986A3D66;
	Mon, 28 Oct 2024 01:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730080290; cv=none; b=N+y4vViWlb8UNOEKLAqRL9bWGdRf5hIqUx/Ll3TgrRVwww722D0HyCZCgzxGmOuHWFQXkwrADx/OHlBXUzeRuZ8XC4chuYhP6OKhtQS7wAjsXRpuIZXc5lbIU0KwnuPZ+1yJlj3kZF6NM9QCAGa+t77fWjACBMk+MSqiCxXVOfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730080290; c=relaxed/simple;
	bh=zODM8QIek4pjyL7QBTrHXutihD100zn+5yBx+vpDtpo=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=c2AIei34bZ1PrfhNMwtMBeSfYJNNdzbFMpzAgB+EiuG0rhKh7hDP6gb0g/49kR7aCV5t1cN92/X3eG24aAzjye5TeOklmjfarZHfx+9+3r3D6BDYCFs/DM0cOZsf47QXTSKacwKJ1jFuJKk5UFm17dfQoDnhzeIRSlVRFbq/7CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h4cqvTfB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0D5AC4CEE5;
	Mon, 28 Oct 2024 01:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730080290;
	bh=zODM8QIek4pjyL7QBTrHXutihD100zn+5yBx+vpDtpo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=h4cqvTfBjY6zSmRUrHbRxk4oO6JM3O0fcrnPO6DlHd+8Lh00lp+I2giwVDt2Q5Y87
	 WfxGlEP27BVGuh4C//0ip1aiVrA7vAqwqgQW7E1Xx/UA+yW8bmqv9IYmyvhZT4IeXV
	 W/Oc2/Ipug0BqLXrb0D5dqGGTCdpiiO4/jkQ/wMJhExbgWnE6t6QdIziooCLkcJzbT
	 k/2GNvkqDMzL7T6a7B4rcHpYv4FzE571p12O7sfdq5K2BR4AFdSHUp9kSD4ge9YoqS
	 3eJhwBsmXnAk0oAHDa5O3HLc2oeNU9scF/PhNNo5z8whoGq6QCAEBhCe4+0hzEdGjb
	 OP7pTv9Gaoy8w==
Date: Mon, 28 Oct 2024 10:51:23 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org,
 akpm@linux-foundation.org, peterz@infradead.org, oleg@redhat.com,
 rostedt@goodmis.org, mhiramat@kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, jolsa@kernel.org, paulmck@kernel.org,
 willy@infradead.org, surenb@google.com, mjguzik@gmail.com,
 brauner@kernel.org, jannh@google.com, mhocko@kernel.org, vbabka@suse.cz,
 shakeel.butt@linux.dev, hannes@cmpxchg.org, Liam.Howlett@oracle.com,
 lorenzo.stoakes@oracle.com, david@redhat.com, arnd@arndb.de,
 richard.weiyang@gmail.com, zhangpeng.00@bytedance.com,
 linmiaohe@huawei.com, viro@zeniv.linux.org.uk, hca@linux.ibm.com
Subject: Re: [PATCH v4 tip/perf/core 3/4] uprobes: simplify
 find_active_uprobe_rcu() VMA checks
Message-Id: <20241028105123.c97544285c7e3304138c5a40@kernel.org>
In-Reply-To: <20241028010818.2487581-4-andrii@kernel.org>
References: <20241028010818.2487581-1-andrii@kernel.org>
	<20241028010818.2487581-4-andrii@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 27 Oct 2024 18:08:17 -0700
Andrii Nakryiko <andrii@kernel.org> wrote:

> At the point where find_active_uprobe_rcu() is used we know that VMA in
> question has triggered software breakpoint, so we don't need to validate
> vma->vm_flags. Keep only vma->vm_file NULL check.
> 

Looks good to me.

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks,

> Acked-by: Oleg Nesterov <oleg@redhat.com>
> Suggested-by: Oleg Nesterov <oleg@redhat.com>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  kernel/events/uprobes.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> index 4ef4b51776eb..290c445768fa 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -2084,7 +2084,7 @@ static struct uprobe *find_active_uprobe_rcu(unsigned long bp_vaddr, int *is_swb
>  	mmap_read_lock(mm);
>  	vma = vma_lookup(mm, bp_vaddr);
>  	if (vma) {
> -		if (valid_vma(vma, false)) {
> +		if (vma->vm_file) {
>  			struct inode *inode = file_inode(vma->vm_file);
>  			loff_t offset = vaddr_to_offset(vma, bp_vaddr);
>  
> -- 
> 2.43.5
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

