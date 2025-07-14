Return-Path: <bpf+bounces-63200-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06004B040E6
	for <lists+bpf@lfdr.de>; Mon, 14 Jul 2025 16:04:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E2DB7A39E8
	for <lists+bpf@lfdr.de>; Mon, 14 Jul 2025 14:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E7B8254AE7;
	Mon, 14 Jul 2025 14:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tmaXUJhO"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C286E24DCEF;
	Mon, 14 Jul 2025 14:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752501882; cv=none; b=P1qDba/ZVmz3PkL8ydrC46ayFN1NxvywHfyvD2euAqX/lfLVDwCwo+2Huw2yB26DrLbJ+0w6m8wVQAleM1hXlrY8aSxPhBSzB1JZWFCQsgPYlttfMzlc7hwHazV04ACUZYlrwi+zORyjTjpl2u0wjarhVr+on5jRfsajbdUDgbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752501882; c=relaxed/simple;
	bh=YH668rpFJXukxr+2YwtKp1L0+P3LzA2wA6CXb2BnnQg=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Y/3bAfnIjH8GU2uYmZyGDYS0NnD+S2E9VaPrp6gBoWbeI3WucPgF2zHCvvZkoTywhO91KPkshZh4lVagGJM9b9J5YcXfAOoJ4OnqFoxKpE3jezmp0tpEnCu38Vb2mWrT3iFiS+RbykPQ1uaaS4g3Vm2NA/902F2s5gNJjic9Ftw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tmaXUJhO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7722C4CEED;
	Mon, 14 Jul 2025 14:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752501882;
	bh=YH668rpFJXukxr+2YwtKp1L0+P3LzA2wA6CXb2BnnQg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tmaXUJhOO8qybGoimCIa4isgnq+xkf3T3BhrXkU9fzm+cA2Ch6J72q09lN5cfBjbE
	 WzYmXaE2GRADoAZYwrFIopbZZ8tplLswF9KfPSXHlcjiPtMtGG2zRgeynf604KU20M
	 2r2teSMcYiyoGttJ57Ao7otA0AJFGpL/3Zp1xhQL71SpCMthxrdauPxO217kK4hB9V
	 QjPp9LmUnY/GmmzhUMOxfA9e4PqLO+wvMpZW81AS6zNgCMXHb4QKj8gCNiJG45aQiw
	 Xsstnu66NOxAgnx5klLX7njL3Qkn9EAFrQQbGcn/WIeDGnWTl2dP4gcJjRUT7Wesmq
	 FWQLsc+kIJKfw==
Date: Mon, 14 Jul 2025 23:04:38 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Jiri Olsa <jolsa@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Andrii Nakryiko <andrii@kernel.org>, Alejandro Colomar <alx@kernel.org>,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, x86@kernel.org, Song Liu
 <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, John Fastabend
 <john.fastabend@gmail.com>, Hao Luo <haoluo@google.com>, Steven Rostedt
 <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, Alan Maguire
 <alan.maguire@oracle.com>, David Laight <David.Laight@ACULAB.COM>, Thomas
 =?UTF-8?B?V2Vpw59zY2h1aA==?= <thomas@t-8ch.de>, Ingo Molnar
 <mingo@kernel.org>
Subject: Re: [PATCHv5 22/22] man2: Add uprobe syscall page
Message-Id: <20250714230438.c5494ba28608e9466d676763@kernel.org>
In-Reply-To: <20250711082931.3398027-23-jolsa@kernel.org>
References: <20250711082931.3398027-1-jolsa@kernel.org>
	<20250711082931.3398027-23-jolsa@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 11 Jul 2025 10:29:30 +0200
Jiri Olsa <jolsa@kernel.org> wrote:

> Changing uretprobe syscall man page to be shared with new
> uprobe syscall man page.
> 

Looks good to me.

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks,

> Cc: Alejandro Colomar <alx@kernel.org>
> Reviewed-by: Alejandro Colomar <alx@kernel.org>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  man/man2/uprobe.2    |  1 +
>  man/man2/uretprobe.2 | 36 ++++++++++++++++++++++++------------
>  2 files changed, 25 insertions(+), 12 deletions(-)
>  create mode 100644 man/man2/uprobe.2
> 
> diff --git a/man/man2/uprobe.2 b/man/man2/uprobe.2
> new file mode 100644
> index 000000000000..ea5ccf901591
> --- /dev/null
> +++ b/man/man2/uprobe.2
> @@ -0,0 +1 @@
> +.so man2/uretprobe.2
> diff --git a/man/man2/uretprobe.2 b/man/man2/uretprobe.2
> index bbbfb0c59335..df0e5d92e5ed 100644
> --- a/man/man2/uretprobe.2
> +++ b/man/man2/uretprobe.2
> @@ -2,22 +2,28 @@
>  .\"
>  .\" SPDX-License-Identifier: Linux-man-pages-copyleft
>  .\"
> -.TH uretprobe 2 (date) "Linux man-pages (unreleased)"
> +.TH uprobe 2 (date) "Linux man-pages (unreleased)"
>  .SH NAME
> +uprobe,
>  uretprobe
>  \-
> -execute pending return uprobes
> +execute pending entry or return uprobes
>  .SH SYNOPSIS
>  .nf
> +.B int uprobe(void);
>  .B int uretprobe(void);
>  .fi
>  .SH DESCRIPTION
> +.BR uprobe ()
> +is an alternative to breakpoint instructions
> +for triggering entry uprobe consumers.
> +.P
>  .BR uretprobe ()
>  is an alternative to breakpoint instructions
>  for triggering return uprobe consumers.
>  .P
>  Calls to
> -.BR uretprobe ()
> +these system calls
>  are only made from the user-space trampoline provided by the kernel.
>  Calls from any other place result in a
>  .BR SIGILL .
> @@ -26,22 +32,28 @@ The return value is architecture-specific.
>  .SH ERRORS
>  .TP
>  .B SIGILL
> -.BR uretprobe ()
> -was called by a user-space program.
> +These system calls
> +were called by a user-space program.
>  .SH VERSIONS
>  The behavior varies across systems.
>  .SH STANDARDS
>  None.
>  .SH HISTORY
> +.TP
> +.BR uprobe ()
> +TBD
> +.TP
> +.BR uretprobe ()
>  Linux 6.11.
>  .P
> -.BR uretprobe ()
> -was initially introduced for the x86_64 architecture
> -where it was shown to be faster than breakpoint traps.
> -It might be extended to other architectures.
> +These system calls
> +were initially introduced for the x86_64 architecture
> +where they were shown to be faster than breakpoint traps.
> +They might be extended to other architectures.
>  .SH CAVEATS
> -.BR uretprobe ()
> -exists only to allow the invocation of return uprobe consumers.
> -It should
> +These system calls
> +exist only to allow the invocation of
> +entry or return uprobe consumers.
> +They should
>  .B never
>  be called directly.
> -- 
> 2.49.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

