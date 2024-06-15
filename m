Return-Path: <bpf+bounces-32224-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C9FF9098D2
	for <lists+bpf@lfdr.de>; Sat, 15 Jun 2024 17:19:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D9ED1F22287
	for <lists+bpf@lfdr.de>; Sat, 15 Jun 2024 15:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF13E4F201;
	Sat, 15 Jun 2024 15:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iX1sMCK5"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE1F4DA0F;
	Sat, 15 Jun 2024 15:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718464764; cv=none; b=iyRVHLimAVqM1Y5QFxHexkEXDVTtRz3zMSB7fdZdT71aLZZz0mgIp130RQMnEr78xGHiuMVYqRqjZ9BuDpz17uvDt0Rm86B8Rl56vCFUsOxvGAEwhwiy6c71FQoDmflefzpZCjUekd6/bavIQGYad4KLSIBSxjrxhVluORAZNI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718464764; c=relaxed/simple;
	bh=adZ/bRj+MoOBaiiYAdhvJpu9cSDcRAK6pFkfbsYL9p8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=PUuyJcEr0cD1F3Cg9/5aPlq6sFFP6Qx0Obvv5lJIV7VBFtOaBKxhqajVbrobKTZ9lJMKwH7oBP17oXP2OX3RPHEhkMt622XNWxCz7lcUV2IRzimaDrUZTFWeM9kRZyNQLAxMlnPG6Nr4CapSXNs344lk+n0dxRiSahR7r5PYmCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iX1sMCK5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38FF0C116B1;
	Sat, 15 Jun 2024 15:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718464763;
	bh=adZ/bRj+MoOBaiiYAdhvJpu9cSDcRAK6pFkfbsYL9p8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iX1sMCK5GkTbCqQlZaeiCQXuH2SfTDx+MgqmQMnJ3CEjboesGRau+F0rCGkPpb4Im
	 YuBsXOSXRqzHJu7EvHWKl7XpBsBqIl54LIlicRIQv235z19QGGzuUvihLgOAyYyQ7g
	 IfCxF3MQ7TL86uPAVPXRVq1u4FBHiSr27CrAM4xvfmFtbRVNmhIUpeSNozJ+pYvMot
	 KU0Ct2s2+hIDf4rSfOfqwCjgMCP3a+3T+8zp+5qIMgq78l57Q4P7JxjGguH4sPFtMb
	 8BRsM74V1MlobFcSYhdTjYh0mHG4BEm774gtALJQWJ9/cVRvNK8S7yJ/qm8BZ+s0HR
	 2XTgy1hfJpslw==
Date: Sun, 16 Jun 2024 00:19:20 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Jiri Olsa <jolsa@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Andrii Nakryiko
 <andrii@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH] bpf/selftests: Fix __NR_uretprobe in uprobe_syscall
 test
Message-Id: <20240616001920.0662473b0c3211e1dbd4b6f5@kernel.org>
In-Reply-To: <20240614101509.764664-1-jolsa@kernel.org>
References: <20240614101509.764664-1-jolsa@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 14 Jun 2024 12:15:09 +0200
Jiri Olsa <jolsa@kernel.org> wrote:

> Fixing the __NR_uretprobe number in uprobe_syscall test,
> because it changed due to merge conflict.
> 

Ah, it is not enough, since Stephen's change is just a temporary fix on
next tree. OK, Let me update it.

Thanks,

> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
> index c8517c8f5313..bd8c75b620c2 100644
> --- a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
> +++ b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
> @@ -216,7 +216,7 @@ static void test_uretprobe_regs_change(void)
>  }
>  
>  #ifndef __NR_uretprobe
> -#define __NR_uretprobe 463
> +#define __NR_uretprobe 467
>  #endif
>  
>  __naked unsigned long uretprobe_syscall_call_1(void)
> -- 
> 2.45.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

