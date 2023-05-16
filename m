Return-Path: <bpf+bounces-657-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64093705311
	for <lists+bpf@lfdr.de>; Tue, 16 May 2023 18:05:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D7081C20E8D
	for <lists+bpf@lfdr.de>; Tue, 16 May 2023 16:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7872631108;
	Tue, 16 May 2023 16:05:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2444434CF9
	for <bpf@vger.kernel.org>; Tue, 16 May 2023 16:05:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24D8AC433EF;
	Tue, 16 May 2023 16:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1684253123;
	bh=WyRb0cO3Dcn2zW5KolHtzKC/m3CXEA35/xNovR2+mVs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NCS2Zz8pxqjius3cIeMK7tjhFhsxId3BBRETFZma2dEBbqmn9f6SuTd2lZIRnTt9T
	 hHkK4e+Cx6MPeUDdPZ0fwTAizNgNityDFGD5sy19v/a4jq2GCTg1FF0Jn8rVwnLng9
	 a0vJmEwoIbzmK2DkBlzmLDbPkpl9DpwSFrMwC1h+6eA1tvY8GFLDSAQdH58KYn1FSC
	 ArtXT/RdjGCyQNQ2KAG7y1F3Nvc1Tpc71ewwBpAplzWKPFoKUciNxZBkonWaWUynqa
	 kWUI6Rd0tpwC9UPT9E0yyrPpVvJhSgpIlVKKtgGScC7W1FOAq+1YqbSSZALcG/dzk4
	 W49qIyvsxZq9w==
Date: Wed, 17 May 2023 01:05:17 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Ze Gao <zegao2021@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexander Gordeev <agordeev@linux.ibm.com>, Alexei Starovoitov
 <ast@kernel.org>, Borislav Petkov <bp@alien8.de>, Christian Borntraeger
 <borntraeger@linux.ibm.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 Heiko Carstens <hca@linux.ibm.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo
 Molnar <mingo@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>, Paul
 Walmsley <paul.walmsley@sifive.com>, Sven Schnelle <svens@linux.ibm.com>,
 Thomas Gleixner <tglx@linutronix.de>, Vasily Gorbik <gor@linux.ibm.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, Conor Dooley
 <conor@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Yonghong Song
 <yhs@fb.com>, Ze Gao <zegao@tencent.com>
Subject: Re: [PATCH v2 4/4] rehook, fprobe: do not trace rethook related
 functions
Message-Id: <20230517010517.9b7bf28a42067540f7a25638@kernel.org>
In-Reply-To: <20230516071830.8190-5-zegao@tencent.com>
References: <20230516071830.8190-1-zegao@tencent.com>
	<20230516071830.8190-5-zegao@tencent.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 16 May 2023 15:18:30 +0800
Ze Gao <zegao2021@gmail.com> wrote:

> These functions are already marked as NOKPROBE to prevent recursion and
> we have the same reason to blacklist them if rethook is used with fprobe,
> since they are beyond the recursion-free region ftrace can guard.
> 
> Signed-off-by: Ze Gao <zegao@tencent.com>

Looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thank you!

> ---
>  arch/riscv/kernel/probes/Makefile | 2 ++
>  arch/s390/kernel/Makefile         | 1 +
>  arch/x86/kernel/Makefile          | 1 +
>  3 files changed, 4 insertions(+)
> 
> diff --git a/arch/riscv/kernel/probes/Makefile b/arch/riscv/kernel/probes/Makefile
> index c40139e9ca47..8265ff497977 100644
> --- a/arch/riscv/kernel/probes/Makefile
> +++ b/arch/riscv/kernel/probes/Makefile
> @@ -4,3 +4,5 @@ obj-$(CONFIG_RETHOOK)		+= rethook.o rethook_trampoline.o
>  obj-$(CONFIG_KPROBES_ON_FTRACE)	+= ftrace.o
>  obj-$(CONFIG_UPROBES)		+= uprobes.o decode-insn.o simulate-insn.o
>  CFLAGS_REMOVE_simulate-insn.o = $(CC_FLAGS_FTRACE)
> +CFLAGS_REMOVE_rethook.o = $(CC_FLAGS_FTRACE)
> +CFLAGS_REMOVE_rethook_trampoline.o = $(CC_FLAGS_FTRACE)
> diff --git a/arch/s390/kernel/Makefile b/arch/s390/kernel/Makefile
> index 8983837b3565..6b2a051e1f8a 100644
> --- a/arch/s390/kernel/Makefile
> +++ b/arch/s390/kernel/Makefile
> @@ -10,6 +10,7 @@ CFLAGS_REMOVE_ftrace.o		= $(CC_FLAGS_FTRACE)
>  
>  # Do not trace early setup code
>  CFLAGS_REMOVE_early.o		= $(CC_FLAGS_FTRACE)
> +CFLAGS_REMOVE_rethook.o		= $(CC_FLAGS_FTRACE)
>  
>  endif
>  
> diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
> index dd61752f4c96..4070a01c11b7 100644
> --- a/arch/x86/kernel/Makefile
> +++ b/arch/x86/kernel/Makefile
> @@ -17,6 +17,7 @@ CFLAGS_REMOVE_ftrace.o = -pg
>  CFLAGS_REMOVE_early_printk.o = -pg
>  CFLAGS_REMOVE_head64.o = -pg
>  CFLAGS_REMOVE_sev.o = -pg
> +CFLAGS_REMOVE_rethook.o = -pg
>  endif
>  
>  KASAN_SANITIZE_head$(BITS).o				:= n
> -- 
> 2.40.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

