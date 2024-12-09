Return-Path: <bpf+bounces-46383-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2ECC9E91E1
	for <lists+bpf@lfdr.de>; Mon,  9 Dec 2024 12:14:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24BC9188613A
	for <lists+bpf@lfdr.de>; Mon,  9 Dec 2024 11:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B675521884F;
	Mon,  9 Dec 2024 11:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FlWPDsg5"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA79339A0;
	Mon,  9 Dec 2024 11:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733742813; cv=none; b=DTxyH0VAX74PO72UHN2QGix0WNoTFjqgddj0HUfIU7w/Wyl6QCN1kzJVIJm7OL/X8jpuwrOmnQPtU1+oi+NM/Hil+KSv85J5+f+anAT7WnNXmaMftIAEEHDQveFezsMGPfyUgZykvanC4ed/19+yW74lPVfoonaBUCM58anajPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733742813; c=relaxed/simple;
	bh=KxWIoyveVJ4t4HYEke15CRbHdAOALVRp0qmm+qvDtUA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=scm0+2ZnJ8SiCaE4tKk6RBkiW8nnzOuNistSHnU3IeO7r6FY++j7PyGU4K5UZZ8hi97af31pLmSYbiif8ZVEFYk85lKLFIhZly+aJXkt7ycu8hbitmm8fPjcLSEHClnCGNAhFjzNjPdBQXajXuF0ktQw3MWPnNW0pDWxPgDRzSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FlWPDsg5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7C2AC4CEE0;
	Mon,  9 Dec 2024 11:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733742812;
	bh=KxWIoyveVJ4t4HYEke15CRbHdAOALVRp0qmm+qvDtUA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FlWPDsg56PG1IWrMPjovQhQ3mnxxws7oba/EP71fLyGYbwHt9lSvamrvOmqQi8SZY
	 24CauVTKQPtQMhYukNe2I1x3M5MUlppWqlRHZr8q8EgLVEepnC/lgCncd67twIm4CX
	 nDEulmS+MwmiHM9NNW8T0x9xQrziBOIyDe0eumPXKHof5dx5FpmiAqUIY1FCmiki6T
	 Eg9G6h1yOAG/KNcA2YgYx3IiPihKjv3AIladXxHB6/OwgO2k5IW1kHAaCZFnY75VZR
	 gLWh1cLIkA7eZuS0Do2uC24K146c8gE8zUZ4kpy1EJUbNpGBppmOMmjK0vYqLzWfdt
	 ngTGlaKy9+tqA==
Date: Mon, 9 Dec 2024 20:13:26 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, peterz@infradead.org,
 mingo@kernel.org, oleg@redhat.com, rostedt@goodmis.org,
 mhiramat@kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 jolsa@kernel.org, liaochang1@huawei.com, kernel-team@meta.com
Subject: Re: [PATCH perf/core] uprobes: guard against kmemdup() failing in
 dup_return_instance()
Message-Id: <20241209201326.31f5e339f70302f80c641c88@kernel.org>
In-Reply-To: <20241206183436.968068-1-andrii@kernel.org>
References: <20241206183436.968068-1-andrii@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  6 Dec 2024 10:34:36 -0800
Andrii Nakryiko <andrii@kernel.org> wrote:

> If kmemdup() failed to alloc memory, don't proceed with extra_consumers
> copy.
> 
> Fixes: e62f2d492728 ("uprobes: Simplify session consumer tracking")
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks!

> ---
>  kernel/events/uprobes.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> index 1af950208c2b..1f75a2f91206 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -2048,6 +2048,8 @@ static struct return_instance *dup_return_instance(struct return_instance *old)
>  	struct return_instance *ri;
>  
>  	ri = kmemdup(old, sizeof(*ri), GFP_KERNEL);
> +	if (!ri)
> +		return NULL;
>  
>  	if (unlikely(old->cons_cnt > 1)) {
>  		ri->extra_consumers = kmemdup(old->extra_consumers,
> -- 
> 2.43.5
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

