Return-Path: <bpf+bounces-35479-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02C9293AD8C
	for <lists+bpf@lfdr.de>; Wed, 24 Jul 2024 09:55:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B13FF2859DB
	for <lists+bpf@lfdr.de>; Wed, 24 Jul 2024 07:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B21912F59C;
	Wed, 24 Jul 2024 07:55:39 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from vmicros1.altlinux.org (vmicros1.altlinux.org [194.107.17.57])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A68937A141;
	Wed, 24 Jul 2024 07:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.107.17.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721807739; cv=none; b=K7eUBlH7DDeHiO9Ctj9OYprnEfLgG6K1FVptZ+kbNdPspZLAQFsVW33YQgpR0QILJeO+zYmjsePUeyaEYA9nnfcEiS2S/iSRWdvP57qP+8LShtByUq0r12hJToOH5NMluY/u6gXs+Tvq0GELQ77wNo/h0Odg2VT8NpbPUsN3gvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721807739; c=relaxed/simple;
	bh=EPj+8jND55oLT0Yv4yVYXVWeyqe6ixwiN3eJg1f/bx8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cA1LkC8uqYUFrhq34cRdiI1sPI745jhJqJGYvvWnOX3tjhpRdcNkdFeSIV9D5HfuMvn1j60NtH/xspNhHF+nXsgCjFp9uxBzI6GWllbM2zhQzrefNuxtpLUIgbap8UMzU2I3nePrCI0JQYshXaK/N/Uy0NiRoMDj4d+PjH1pn88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strace.io; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=194.107.17.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strace.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
	by vmicros1.altlinux.org (Postfix) with ESMTP id 2092B72C8FB;
	Wed, 24 Jul 2024 10:46:30 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
	id 141F37CCB3C; Wed, 24 Jul 2024 10:46:30 +0300 (IDT)
Date: Wed, 24 Jul 2024 10:46:30 +0300
From: "Dmitry V. Levin" <ldv@strace.io>
To: Jiri Olsa <jolsa@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-api@vger.kernel.org, x86@kernel.org, bpf@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Ingo Molnar <mingo@redhat.com>, Andy Lutomirski <luto@kernel.org>,
	Deepak Gupta <debug@rivosinc.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH 1/2] uprobe: Change uretprobe syscall scope and number
Message-ID: <20240724074629.GA11265@altlinux.org>
References: <20240712135228.1619332-1-jolsa@kernel.org>
 <20240712135228.1619332-2-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240712135228.1619332-2-jolsa@kernel.org>

On Fri, Jul 12, 2024 at 03:52:27PM +0200, Jiri Olsa wrote:
> After discussing with Arnd [1] it's preferable to change uretprobe
> syscall number to 467 to omit the merge conflict with xattrat syscalls.
> 
> Also changing the ABI to 'common' which will ease up the global
> scripts/syscall.tbl management. One consequence is we generate uretprobe
> syscall numbers for ABIs that do not support uretprobe syscall, but the
> syscall still returns -ENOSYS when called in that ABI.
> 
> [1] https://lore.kernel.org/lkml/784a34e5-4654-44c9-9c07-f9f4ffd952a0@app.fastmail.com/
> 
> Fixes: 190fec72df4a ("uprobe: Wire up uretprobe system call")
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  arch/x86/entry/syscalls/syscall_64.tbl | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
> index 6452c2ec469a..dabf1982de6d 100644
> --- a/arch/x86/entry/syscalls/syscall_64.tbl
> +++ b/arch/x86/entry/syscalls/syscall_64.tbl
> @@ -384,7 +384,7 @@
>  460	common	lsm_set_self_attr	sys_lsm_set_self_attr
>  461	common	lsm_list_modules	sys_lsm_list_modules
>  462 	common  mseal			sys_mseal
> -463	64	uretprobe		sys_uretprobe
> +467	common	uretprobe		sys_uretprobe
>  
>  #
>  # Due to a historical design error, certain syscalls are numbered differently

Isn't include/uapi/asm-generic/unistd.h expected to be updated as well?
As of mainline commit v6.10-12246-g786c8248dbd3, it still contains

#define __NR_uretprobe 463


-- 
ldv

