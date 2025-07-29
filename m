Return-Path: <bpf+bounces-64578-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F042B145EE
	for <lists+bpf@lfdr.de>; Tue, 29 Jul 2025 03:43:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4B347A1F5D
	for <lists+bpf@lfdr.de>; Tue, 29 Jul 2025 01:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E2F91F4621;
	Tue, 29 Jul 2025 01:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DRD04GHS"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E061F237A;
	Tue, 29 Jul 2025 01:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753753377; cv=none; b=k1hQil1iJaJWFzmF0pGPW/s1eYPXxnscf8ZfKmPsx0XDVmKceS/+U+1qzAmLpjfqr2hSm1DCBzDJZsuxEZuRYLxU/WVV/sYuFRi7mWxjzi8vQwUBeCdGRs5/CJV17iJ3DYC03vIa/1nC+c5DdwUaxtNPVbsAdYnZAt3SoryjeVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753753377; c=relaxed/simple;
	bh=3g5GSCZ8bX42LsW/E2GOnhRkur95yaR7z21LAmkOLGs=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=cWekOgGkTCnZQvejfv0C9S+1YqMcH8SCi+k8jJn/guPmz5rMjMlMB9FxEWLIX2OeUcQMG0NBgquF79GmzFnI60umnWLlSW8OQNza8cK3C+mHuRnJfTTo8vUrFBkkJYzVj/GBSAkeGFft5d9I2yzz54zF0CD30aeFlzJPKQHFAgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DRD04GHS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E85D4C4CEE7;
	Tue, 29 Jul 2025 01:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753753377;
	bh=3g5GSCZ8bX42LsW/E2GOnhRkur95yaR7z21LAmkOLGs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DRD04GHSOGvW1QJ6BvYPIDL1ETlt92y/qD/ALuIR9jFHTdLIkz+VclMFMSejp6Bry
	 kc/+M8L+hb1A7qwExi5ejuQo+QJUzfIO2yyqYau2mEy3dmbMaZ0yk7S261XaZ0e9E/
	 8X3NMGNLZMQTVlT9aT2HCouedrElyNFRd+SDqPiUdFlva7GDGCFUZrcV+3bWdpEjXH
	 wkkoUWQRMC6jmPdQbeYU5BBxZyEnocjlUL3lf0bhP4cJpzN5Hc6lYrRxH4BM7OZfpm
	 vQgqKe/aMRrPPt6POcPxvkWJaykI+FuJFb4DX7iSnu6x8wddkiF4hceN1Xjb8uMJlo
	 mf79qyyxxikOQ==
Date: Tue, 29 Jul 2025 10:42:54 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: alexei.starovoitov@gmail.com, rostedt@goodmis.org,
 mathieu.desnoyers@efficios.com, hca@linux.ibm.com, revest@chromium.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org
Subject: Re: [PATCH RFC bpf-next v2 1/4] fprobe: use rhltable for
 fprobe_ip_table
Message-Id: <20250729104254.560beac056de20d6aebe1d55@kernel.org>
In-Reply-To: <20250728072637.1035818-2-dongml2@chinatelecom.cn>
References: <20250728072637.1035818-1-dongml2@chinatelecom.cn>
	<20250728072637.1035818-2-dongml2@chinatelecom.cn>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi,

I'll check it deeper, but 2 nits I found.

On Mon, 28 Jul 2025 15:22:50 +0800
Menglong Dong <menglong8.dong@gmail.com> wrote:

> diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
> index ba7ff14f5339..640a0c47fc76 100644
> --- a/kernel/trace/fprobe.c
> +++ b/kernel/trace/fprobe.c
> @@ -12,6 +12,7 @@
>  #include <linux/mutex.h>
>  #include <linux/slab.h>
>  #include <linux/sort.h>
> +#include <linux/rhashtable.h>

nit: Can you sort this alphabetically?

[...]
> @@ -249,9 +251,10 @@ static inline int __fprobe_kprobe_handler(unsigned long ip, unsigned long parent
>  static int fprobe_entry(struct ftrace_graph_ent *trace, struct fgraph_ops *gops,
>  			struct ftrace_regs *fregs)
>  {
> -	struct fprobe_hlist_node *node, *first;
> +	struct fprobe_hlist_node *node;
>  	unsigned long *fgraph_data = NULL;
>  	unsigned long func = trace->func;
> +	struct rhlist_head *head, *pos;

nit: Can you sort this as reverse Christmas tree? (like as below)

>  	unsigned long *fgraph_data = NULL;
>  	unsigned long func = trace->func;
> +	struct fprobe_hlist_node *node;
> +	struct rhlist_head *head, *pos;


>  	unsigned long ret_ip;
>  	int reserved_words;
>  	struct fprobe *fp;

Thank you,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

