Return-Path: <bpf+bounces-67956-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6975B50A0D
	for <lists+bpf@lfdr.de>; Wed, 10 Sep 2025 03:05:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A5DF545824
	for <lists+bpf@lfdr.de>; Wed, 10 Sep 2025 01:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D6151E1A33;
	Wed, 10 Sep 2025 01:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mgGi8bke"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E961C2324;
	Wed, 10 Sep 2025 01:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757466345; cv=none; b=gCjnXaFSw6lGV7qriffW6yxKQaCnrIvPvgZVwRdFURMqVK45/9KqSzLyy1720rTzvaQyFGU+ef/Eridqlkpj3FhVhlALnR7xlEiXhXRrraIewLdSeCObREQGx6a+AKSKhKfdJb3SjN6Q0wxxBScN0x1yNw2vt+sfxhdgw+jK1G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757466345; c=relaxed/simple;
	bh=fOthtt3sHAR4XK1Blw8fcDEW53BygTROv/INF8rmzWc=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=SkAWt86bO5GIXOfN9pnrW7vKHdElpRdUovjztYPUnDaBw9nLP36DanUGXypxXQLXgyp4cgRQpG/XGHMVYUz3cIsW6r/Lf2QK856Xa0JdShddyrOePlHVy16D0AC01jq4SiakIyeX4p1TB8tWKCpLWHac60+EVJCBdm4d5Hz8kLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mgGi8bke; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 899E6C4CEF4;
	Wed, 10 Sep 2025 01:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757466345;
	bh=fOthtt3sHAR4XK1Blw8fcDEW53BygTROv/INF8rmzWc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mgGi8bkebjd3F7vpKdiW4vKmob23iQCHYOErV/87iaHw1Oaf7i19LUu0ZEMOFc+jt
	 yJDEDdauZ7P7n6gGM8SqzyfaUxUeL5Wf/lxU7FNT0ixWzt8imm0xGK9HNQ6FhzANAd
	 1z3R4Rd3kLBUX+rjrrTR7wOwzVzSEwtA+fewJY+rYjIBFsb/e1chXlIXddYzH13Q+h
	 iCMG6cUXZcvEvv8HcmXBg9VObYe+mP0Z14rIQy83JPHHgFuYZ1Zcy5Lp1RyapPrdAf
	 st0nPSnlvB49YimrKwsEQhBUudVlQMW8der0yiCxWBMkvp/Y/wJUvC/F9wguoEwQ3K
	 fKNV+n1evoBGg==
Date: Wed, 10 Sep 2025 10:05:38 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: jolsa@kernel.org, oleg@redhat.com, andrii@kernel.org,
 linux-kernel@vger.kernel.org, alx@kernel.org, eyal.birger@gmail.com,
 kees@kernel.org, bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 x86@kernel.org, songliubraving@fb.com, yhs@fb.com,
 john.fastabend@gmail.com, haoluo@google.com, rostedt@goodmis.org,
 alan.maguire@oracle.com, David.Laight@ACULAB.COM, thomas@t-8ch.de,
 mingo@kernel.org, rick.p.edgecombe@intel.com
Subject: Re: [PATCH 6/6] uprobes/x86: Add SLS mitigation to the trampolines
Message-Id: <20250910100538.9289cc4adfa34d616bc59f39@kernel.org>
In-Reply-To: <20250821123657.277506098@infradead.org>
References: <20250821122822.671515652@infradead.org>
	<20250821123657.277506098@infradead.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 21 Aug 2025 14:28:28 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> It is trivial; no reason not to.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Looks good to me :)

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

> ---
>  arch/x86/kernel/uprobes.c |    2 ++
>  1 file changed, 2 insertions(+)
> 
> --- a/arch/x86/kernel/uprobes.c
> +++ b/arch/x86/kernel/uprobes.c
> @@ -336,6 +336,7 @@ asm (
>  	 * call ret.
>  	 */
>  	"ret\n"
> +	"int3\n"
>  	".global uretprobe_trampoline_end\n"
>  	"uretprobe_trampoline_end:\n"
>  	".popsection\n"
> @@ -891,6 +892,7 @@ asm (
>  	"pop %r11\n"
>  	"pop %rcx\n"
>  	"ret\n"
> +	"int3\n"
>  	".balign " __stringify(PAGE_SIZE) "\n"
>  	".popsection\n"
>  );
> 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

