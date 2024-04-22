Return-Path: <bpf+bounces-27433-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79D178AD046
	for <lists+bpf@lfdr.de>; Mon, 22 Apr 2024 17:08:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 997E31C20FC3
	for <lists+bpf@lfdr.de>; Mon, 22 Apr 2024 15:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DAE0152DF0;
	Mon, 22 Apr 2024 15:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rzzItP2/"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B518152521;
	Mon, 22 Apr 2024 15:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713798457; cv=none; b=jNrg5daMbtr018uc5thzZp3PUaWueheWBVUu+8SXpPJMAsq9uYM7wfc3R06vhLNdlb2zYJNGHiGBzg22cbRwYDDJCIY4Icif4j6XsSCyts4R02/m205ugmGlN1GogdWqgsfRHxkeib/+jpSG0TuyiQ6WLdoZUGzmnKWAd1H3bL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713798457; c=relaxed/simple;
	bh=9gL/4UlZA/kW/pnMl559dwLrf9AiXozcEdYa08TOlpQ=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ezmJv5YO8C8So5BHPQmxzDFjimqd6lXs6r+lZRFkATuTyVolfjPM/UqvaF0wp4qIBraqW1nfpzNn5lmofvb1npp7SYsCSrBsdPjPiWeOyt+rWAaxfKZhxJWHG0xUvExVjKPkxJMOp+EztLK3J9jkkSMwBr4SzoJ3pODQdaN75Xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rzzItP2/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDCF3C32781;
	Mon, 22 Apr 2024 15:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713798456;
	bh=9gL/4UlZA/kW/pnMl559dwLrf9AiXozcEdYa08TOlpQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rzzItP2/R0evw0aSPWMiigg9UGmnBkw8ZN6K7fvAQlb2QKa3Ce12lBg44agS4ncDu
	 sraKypj4jLlWkgwF1Emb9sVIW/0dfDIAJuKwOjqZG4xRzLt2cjqrBwT3ohLq2Gbcy1
	 AFRTgCS/yEhQoGVaSyGzEXaNbMVF2l0KN94ZRqhH1b0Fxthlr/Fg5CZpKSu4yApjGA
	 momJjKpTW+5egCrYP8fR9ejr4e+ZzVKkavsyULLZprL8JgJDvebd7TztooGnRiB0EW
	 MLjAYgjtDVfuoMMUKBI9bzdmjVr/FkzK3LDArEpGLsK/Pp5+PZeGC018nMgRKKIHOk
	 ndDr6bUXYGtpA==
Date: Tue, 23 Apr 2024 00:07:29 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Jiri Olsa <jolsa@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Oleg Nesterov <oleg@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-api@vger.kernel.org, x86@kernel.org, bpf@vger.kernel.org, Song Liu
 <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, John Fastabend
 <john.fastabend@gmail.com>, Peter Zijlstra <peterz@infradead.org>, Thomas
 Gleixner <tglx@linutronix.de>, "Borislav Petkov (AMD)" <bp@alien8.de>, Ingo
 Molnar <mingo@redhat.com>, Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH 7/7] man2: Add uretprobe syscall page
Message-Id: <20240423000729.f1d58443100c3994afca0a7f@kernel.org>
In-Reply-To: <20240421194206.1010934-8-jolsa@kernel.org>
References: <20240421194206.1010934-1-jolsa@kernel.org>
	<20240421194206.1010934-8-jolsa@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 21 Apr 2024 21:42:06 +0200
Jiri Olsa <jolsa@kernel.org> wrote:

> Adding man page for new uretprobe syscall.
> 
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  man2/uretprobe.2 | 40 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
>  create mode 100644 man2/uretprobe.2
> 
> diff --git a/man2/uretprobe.2 b/man2/uretprobe.2
> new file mode 100644
> index 000000000000..c0343a88bb57
> --- /dev/null
> +++ b/man2/uretprobe.2
> @@ -0,0 +1,40 @@
> +.\" Copyright (C) 2024, Jiri Olsa <jolsa@kernel.org>
> +.\"
> +.\" SPDX-License-Identifier: Linux-man-pages-copyleft
> +.\"
> +.TH uretprobe 2 (date) "Linux man-pages (unreleased)"
> +.SH NAME
> +uretprobe \- execute pending return uprobes
> +.SH SYNOPSIS
> +.nf
> +.B int uretprobe(void)
> +.fi
> +.SH DESCRIPTION
> +On x86_64 architecture the kernel is using uretprobe syscall to trigger
> +uprobe return probe consumers instead of using standard breakpoint instruction.
> +The reason is that it's much faster to do syscall than breakpoint trap
> +on x86_64 architecture.

Do we specify the supported architecture as this? Currently it is supported
only on x86-64, but it could be extended later, right?

This should be just noted as NOTES. Something like "This syscall is initially
introduced on x86-64 because a syscall is faster than a breakpoint trap on it.
But this will be extended to the architectures whose syscall is faster than
breakpoint trap."

Thank you,

> +
> +The uretprobe syscall is not supposed to be called directly by user, it's allowed
> +to be invoked only through user space trampoline provided by kernel.
> +When called from outside of this trampoline, the calling process will receive
> +.BR SIGILL .
> +
> +.SH RETURN VALUE
> +.BR uretprobe()
> +return value is specific for given architecture.
> +
> +.SH VERSIONS
> +This syscall is not specified in POSIX,
> +and details of its behavior vary across systems.
> +.SH STANDARDS
> +None.
> +.SH NOTES
> +.BR uretprobe()
> +exists only to allow the invocation of return uprobe consumers.
> +It should
> +.B never
> +be called directly.
> +Details of the arguments (if any) passed to
> +.BR uretprobe ()
> +and the return value are specific for given architecture.
> -- 
> 2.44.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

