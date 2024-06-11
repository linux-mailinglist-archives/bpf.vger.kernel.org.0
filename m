Return-Path: <bpf+bounces-31841-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D0C57903ED0
	for <lists+bpf@lfdr.de>; Tue, 11 Jun 2024 16:30:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B89A1F21D56
	for <lists+bpf@lfdr.de>; Tue, 11 Jun 2024 14:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA83917DE1C;
	Tue, 11 Jun 2024 14:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E+8SBmXg"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE9617D890;
	Tue, 11 Jun 2024 14:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718116230; cv=none; b=BT6G/dKxlfziz2zS0QXn6bAcr5AlzKGw1hJS4GiZaEUsuT9m0ZE0LEqgML/nWNN4P3ePNKWDrDsJbabIUmnCL8iqvysWU9R/7nkuw+h6EMWSSYrMlmVwE2n1VLrjLWygsl+Ej7lVg2hg4viyeItVEZWTWpec8KK9O7QopWzPREQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718116230; c=relaxed/simple;
	bh=+hg6mwKUT4FXKccgfxs6KTWJDqOAp3AVHYpeZy7+Brs=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Dmk/mMbE2EkzxBWeUKs7b7FPvKoMqztyE6/uJ6r+2UsuEDeGfJpKdstqOsS6BfHtNjFAFxVDL774dJrMHoZ4pEPS2fUmXGIJzVAC5Al8cn5B3AbWi1e+s2hw2pSydDLS1OV1nXn0jX2CIblQLL2/ej/qNvA0p94rNkcNQuArtr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E+8SBmXg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73981C2BD10;
	Tue, 11 Jun 2024 14:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718116229;
	bh=+hg6mwKUT4FXKccgfxs6KTWJDqOAp3AVHYpeZy7+Brs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=E+8SBmXg4kHbc2+kE5VdtOtyIigM64Ao0eLalvYBcyTz7+feUFW4RpyhNl09KCg+u
	 G8qnxEPn98CKmOUDRIg+qWyUHuPAueaR63ZY7qBzjjSCAEsZ8Z4ncDiVQhOx8jQjP8
	 WYU5EQIOBHZz85f5YNImLAba2Yh1ieUPH0M4aePuokdD2QdE9Z95LGGpFmHkYdUvty
	 pV1FJYWQlqxmz3mf96bTtEBIFGnOQ4DlkwWF2Z4L9hXld3wLCKGY9LZVbV+EWUxrh2
	 JoXDvFEGfN5Ckx9lAVTx7FaZi4DkiQe+PgQl0tEbqXLK/QNJeXmDNl55/x7cPamngA
	 dzkYxoJ6jjFgA==
Date: Tue, 11 Jun 2024 23:30:22 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Jiri Olsa <jolsa@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Oleg Nesterov <oleg@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Alejandro
 Colomar <alx@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-api@vger.kernel.org,
 linux-man@vger.kernel.org, x86@kernel.org, bpf@vger.kernel.org, Song Liu
 <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, John Fastabend
 <john.fastabend@gmail.com>, Peter Zijlstra <peterz@infradead.org>, Thomas
 Gleixner <tglx@linutronix.de>, "Borislav Petkov (AMD)" <bp@alien8.de>, Ingo
 Molnar <mingo@redhat.com>, Andy Lutomirski <luto@kernel.org>,
 "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, Deepak Gupta
 <debug@rivosinc.com>
Subject: Re: [PATCHv8 9/9] man2: Add uretprobe syscall page
Message-Id: <20240611233022.82e8abfa2ff0e43fd36798b2@kernel.org>
In-Reply-To: <20240611112158.40795-10-jolsa@kernel.org>
References: <20240611112158.40795-1-jolsa@kernel.org>
	<20240611112158.40795-10-jolsa@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Jun 2024 13:21:58 +0200
Jiri Olsa <jolsa@kernel.org> wrote:

> Adding man page for new uretprobe syscall.
> 
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> Reviewed-by: Alejandro Colomar <alx@kernel.org>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

This looks good to me.

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

And this needs to be picked by linux-man@ project.

Thank you,

> ---
>  man/man2/uretprobe.2 | 56 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 56 insertions(+)
>  create mode 100644 man/man2/uretprobe.2
> 
> diff --git a/man/man2/uretprobe.2 b/man/man2/uretprobe.2
> new file mode 100644
> index 000000000000..cf1c2b0d852e
> --- /dev/null
> +++ b/man/man2/uretprobe.2
> @@ -0,0 +1,56 @@
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
> +The
> +.BR uretprobe ()
> +system call is an alternative to breakpoint instructions for triggering return
> +uprobe consumers.
> +.P
> +Calls to
> +.BR uretprobe ()
> +system call are only made from the user-space trampoline provided by the kernel.
> +Calls from any other place result in a
> +.BR SIGILL .
> +.SH RETURN VALUE
> +The
> +.BR uretprobe ()
> +system call return value is architecture-specific.
> +.SH ERRORS
> +.TP
> +.B SIGILL
> +The
> +.BR uretprobe ()
> +system call was called by a user-space program.
> +.SH VERSIONS
> +Details of the
> +.BR uretprobe ()
> +system call behavior vary across systems.
> +.SH STANDARDS
> +None.
> +.SH HISTORY
> +TBD
> +.SH NOTES
> +The
> +.BR uretprobe ()
> +system call was initially introduced for the x86_64 architecture
> +where it was shown to be faster than breakpoint traps.
> +It might be extended to other architectures.
> +.P
> +The
> +.BR uretprobe ()
> +system call exists only to allow the invocation of return uprobe consumers.
> +It should
> +.B never
> +be called directly.
> +Details of the arguments (if any) passed to
> +.BR uretprobe ()
> +and the return value are architecture-specific.
> -- 
> 2.45.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

