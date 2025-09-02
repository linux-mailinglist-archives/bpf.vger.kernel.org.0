Return-Path: <bpf+bounces-67194-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FF68B408A0
	for <lists+bpf@lfdr.de>; Tue,  2 Sep 2025 17:12:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C583654249A
	for <lists+bpf@lfdr.de>; Tue,  2 Sep 2025 15:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F39C9315761;
	Tue,  2 Sep 2025 15:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IpRwT66F"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C883148CD;
	Tue,  2 Sep 2025 15:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756825897; cv=none; b=J8sw/TRROML6zoVL0uEjmmKkggp0TcrArhcxVqMLzV1OGqRaAB/ESpheFWT81q757SPbVHIJ6Wk8ChsqwBrmnHiUWtFobdoaNYPq42Ux8zelRgPJohz8+p2nmkYlLBKiAdMYiGfTu54+69ZB2FpckM4eZWefBBt7jsvDyA9JAW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756825897; c=relaxed/simple;
	bh=+9HP5l15oB0iuIxiMajn5CQ9jjlvaMDVkmHUr0VRnPE=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=RlplHV/dKq7PXiN0t/LVELX17FzWyRFB/+J+kQML+KkoD/hLfiorgh7Mu4gjYquNdKUm0FP55OqcJ/DLulZ3ntrxWpET13WG9u62DzvbKHznli8lW6wQb+e4mIOYWIvyVkM7I6lHgn5lbPEpC6lRbMQhoekPFHzg/sD/GE2Taks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IpRwT66F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29226C4CEED;
	Tue,  2 Sep 2025 15:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756825896;
	bh=+9HP5l15oB0iuIxiMajn5CQ9jjlvaMDVkmHUr0VRnPE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IpRwT66FVpw1fiRZdgU1RMfO19xdpyqn8bSTkI6PIMtvG7dycONNDE/Hj5UllIENt
	 t6vLb93qRvUYZX4SrQh3N3fXMoYrkRdo3prO2qDbEP32kebZV6o2saVtjSsFpoS5xh
	 Vnltxi2p7JV8Nrz8twUDqAqlvWK/2P5+NO9IJWEFaHnCOkQx6ia4f40yhbtLQDKvoG
	 5v9z136RTvBVms54J7DXV0hagCA2zHfJ7pfoFNIB6r9anPOVao7EMEHpNarLxtjQdj
	 Ck8KZR19EvV7hbyfzwZZlJABS2UIL988ptmnFnqKtit1BO9BOO9xr3t2GSRZpCxfCB
	 MvQYX0PruiYbg==
Date: Wed, 3 Sep 2025 00:11:33 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Jiri Olsa <jolsa@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 x86@kernel.org, Song Liu <songliubraving@fb.com>, Yonghong Song
 <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>, Hao Luo
 <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar
 <mingo@kernel.org>
Subject: Re: [PATCH perf/core 01/11] uprobes: Add unique flag to uprobe
 consumer
Message-Id: <20250903001133.8a02cf5db5ab4fd23c9a334f@kernel.org>
In-Reply-To: <20250902143504.1224726-2-jolsa@kernel.org>
References: <20250902143504.1224726-1-jolsa@kernel.org>
	<20250902143504.1224726-2-jolsa@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  2 Sep 2025 16:34:54 +0200
Jiri Olsa <jolsa@kernel.org> wrote:

> Adding unique flag to uprobe consumer to ensure it's the only consumer
> attached on the uprobe.
> 
> This is helpful for use cases when consumer wants to change user space
> registers, which might confuse other consumers. With this change we can
> ensure there's only one consumer on specific uprobe.

nit: Does this mean one callback (consumer) is exclusively attached?
If so, "exclusive" will be better wording?

The logic looks good to me.

Thanks,

> 
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  include/linux/uprobes.h |  1 +
>  kernel/events/uprobes.c | 30 ++++++++++++++++++++++++++++--
>  2 files changed, 29 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
> index 08ef78439d0d..0df849dee720 100644
> --- a/include/linux/uprobes.h
> +++ b/include/linux/uprobes.h
> @@ -60,6 +60,7 @@ struct uprobe_consumer {
>  	struct list_head cons_node;
>  
>  	__u64 id;	/* set when uprobe_consumer is registered */
> +	bool is_unique; /* the only consumer on uprobe */
>  };
>  
>  #ifdef CONFIG_UPROBES
> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> index 996a81080d56..b9b088f7333a 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -1024,14 +1024,35 @@ static struct uprobe *alloc_uprobe(struct inode *inode, loff_t offset,
>  	return uprobe;
>  }
>  
> -static void consumer_add(struct uprobe *uprobe, struct uprobe_consumer *uc)
> +static bool consumer_can_add(struct list_head *head, struct uprobe_consumer *uc)
> +{
> +	/* Uprobe has no consumer, we can add any. */
> +	if (list_empty(head))
> +		return true;
> +	/* Uprobe has consumer/s, we can't add unique one. */
> +	if (uc->is_unique)
> +		return false;
> +	/*
> +	 * Uprobe has consumer/s, we can add nother consumer only if the
> +	 * current consumer is not unique.
> +	 **/
> +	return !list_first_entry(head, struct uprobe_consumer, cons_node)->is_unique;
> +}
> +
> +static int consumer_add(struct uprobe *uprobe, struct uprobe_consumer *uc)
>  {
>  	static atomic64_t id;
> +	int ret = -EBUSY;
>  
>  	down_write(&uprobe->consumer_rwsem);
> +	if (!consumer_can_add(&uprobe->consumers, uc))
> +		goto unlock;
>  	list_add_rcu(&uc->cons_node, &uprobe->consumers);
>  	uc->id = (__u64) atomic64_inc_return(&id);
> +	ret = 0;
> +unlock:
>  	up_write(&uprobe->consumer_rwsem);
> +	return ret;
>  }
>  
>  /*
> @@ -1420,7 +1441,12 @@ struct uprobe *uprobe_register(struct inode *inode,
>  		return uprobe;
>  
>  	down_write(&uprobe->register_rwsem);
> -	consumer_add(uprobe, uc);
> +	ret = consumer_add(uprobe, uc);
> +	if (ret) {
> +		put_uprobe(uprobe);
> +		up_write(&uprobe->register_rwsem);
> +		return ERR_PTR(ret);
> +	}
>  	ret = register_for_each_vma(uprobe, uc);
>  	up_write(&uprobe->register_rwsem);
>  
> -- 
> 2.51.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

