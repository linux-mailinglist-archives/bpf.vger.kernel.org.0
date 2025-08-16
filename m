Return-Path: <bpf+bounces-65814-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3986FB28E9F
	for <lists+bpf@lfdr.de>; Sat, 16 Aug 2025 16:52:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07599189F535
	for <lists+bpf@lfdr.de>; Sat, 16 Aug 2025 14:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 682DD2EFD9B;
	Sat, 16 Aug 2025 14:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f5cR47R6"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74042D46CA;
	Sat, 16 Aug 2025 14:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755355830; cv=none; b=YlGqqhWIPi2YbWMPj43H4KBPW2+UbRz+P2LLXu1MYj4m1MmgZCanIW4rZDVg/oENyekpKweIHkaYYaOsv6e6/pBs1YLj25EFUBp/Qo2hxD0sDGHOYbw9C2X1noZuUrmJqolLfCWaHd4hzw2g4vpYvXZO00eYYgEBlRbr7LKx35g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755355830; c=relaxed/simple;
	bh=3/6j6G8m0fiGcHsJh9fJn6cHi5TaoU26V0jjDuRfG+A=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=VsMtu4UU4/DgQAtRIrBVD/Nlak/KGlIWlAhLR9C6tV4ud0mLsfdv2JLBzbIyFO/XMG5pp4tlMIWCBSvC7v8ozL7oK3GsIKq1YGzseYVceZIGRmjLm3mBYfmZackjLtR7ZZf6Eg9WVSsRu+wgEJMdmYZHB6QU/qo1vWU40+v2s64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f5cR47R6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AA1CC4CEEF;
	Sat, 16 Aug 2025 14:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755355829;
	bh=3/6j6G8m0fiGcHsJh9fJn6cHi5TaoU26V0jjDuRfG+A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=f5cR47R6qxae48z9hM2mG0DES2xjsZfWd4eXtRf/u1POszbsgvpHz4oYwRrRBX+sF
	 HG6wQSXjA+J2Q+ejd2Hjw0bdXH/x8EWJdO1fFoHk7HM+xI8vmqM62WFKbmytnFv2gr
	 HeVNXOvdO5WWPv5M0aSm6ulo7kGtnqi6KPVSSUZtlC/XrI0kijHEBDuR8aqk5NX/sG
	 VkDKCpTG3iO7R0NcddX+8jEUIjsKu/eC+JsuYcF0W4VMqramGQmI/6qiHiQAGxZfJh
	 z4ttB6PpFLctgPaTtIZLTJ3gwcR7uCGS71IV8U8gBMYH3xtEPGVFJlnj1bIwegDXO+
	 SSLSAs0zDe72A==
Date: Sat, 16 Aug 2025 23:50:23 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: olsajiri@gmail.com, rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
 hca@linux.ibm.com, revest@chromium.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next v4 1/4] fprobe: use rhltable for
 fprobe_ip_table
Message-Id: <20250816235023.4dabfbc13a46a859de61cf4d@kernel.org>
In-Reply-To: <20250815064712.771089-2-dongml2@chinatelecom.cn>
References: <20250815064712.771089-1-dongml2@chinatelecom.cn>
	<20250815064712.771089-2-dongml2@chinatelecom.cn>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Menglong,

Sorry, one more thing.

> @@ -260,14 +263,12 @@ static int fprobe_entry(struct ftrace_graph_ent *trace, struct fgraph_ops *gops,
>  	if (WARN_ON_ONCE(!fregs))
>  		return 0;
>  
> -	first = node = find_first_fprobe_node(func);
> -	if (unlikely(!first))
> -		return 0;
> -
> +	rcu_read_lock();

Actually, we don't need these rcu_read_lock() in this function, because
the caller function_graph_enter_regs() uses ftrace_test_recursion_trylock()
which disables preemption. Thus we don't need to do this again here.

> +	head = rhltable_lookup(&fprobe_ip_table, &func, fprobe_rht_params);
>  	reserved_words = 0;
> -	hlist_for_each_entry_from_rcu(node, hlist) {
> +	rhl_for_each_entry_rcu(node, pos, head, hlist) {
>  		if (node->addr != func)
> -			break;
> +			continue;
>  		fp = READ_ONCE(node->fp);
>  		if (!fp || !fp->exit_handler)
>  			continue;
> @@ -278,17 +279,19 @@ static int fprobe_entry(struct ftrace_graph_ent *trace, struct fgraph_ops *gops,
>  		reserved_words +=
>  			FPROBE_HEADER_SIZE_IN_LONG + SIZE_IN_LONG(fp->entry_data_size);
>  	}
> -	node = first;
> +	rcu_read_unlock();
>  	if (reserved_words) {
>  		fgraph_data = fgraph_reserve_data(gops->idx, reserved_words * sizeof(long));
>  		if (unlikely(!fgraph_data)) {
> -			hlist_for_each_entry_from_rcu(node, hlist) {
> +			rcu_read_lock();

Ditto.

> +			rhl_for_each_entry_rcu(node, pos, head, hlist) {
>  				if (node->addr != func)
> -					break;
> +					continue;
>  				fp = READ_ONCE(node->fp);
>  				if (fp && !fprobe_disabled(fp))
>  					fp->nmissed++;
>  			}
> +			rcu_read_unlock();
>  			return 0;
>  		}
>  	}

Thank you,


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

