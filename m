Return-Path: <bpf+bounces-649-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C0F6705071
	for <lists+bpf@lfdr.de>; Tue, 16 May 2023 16:20:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCA18281665
	for <lists+bpf@lfdr.de>; Tue, 16 May 2023 14:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDAD828C15;
	Tue, 16 May 2023 14:20:12 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD9928C08
	for <bpf@vger.kernel.org>; Tue, 16 May 2023 14:20:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FB3AC433EF;
	Tue, 16 May 2023 14:20:07 +0000 (UTC)
Date: Tue, 16 May 2023 10:20:06 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Ze Gao <zegao2021@gmail.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Albert Ou
 <aou@eecs.berkeley.edu>, Alexander Gordeev <agordeev@linux.ibm.com>, Alexei
 Starovoitov <ast@kernel.org>, Borislav Petkov <bp@alien8.de>, Christian
 Borntraeger <borntraeger@linux.ibm.com>, Dave Hansen
 <dave.hansen@linux.intel.com>, Heiko Carstens <hca@linux.ibm.com>, "H.
 Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, Palmer
 Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>,
 Sven Schnelle <svens@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>,
 Vasily Gorbik <gor@linux.ibm.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org, Conor Dooley <conor@kernel.org>, Jiri Olsa
 <jolsa@kernel.org>, Yonghong Song <yhs@fb.com>, Ze Gao <zegao@tencent.com>
Subject: Re: [PATCH v2 4/4] rehook, fprobe: do not trace rethook related
 functions
Message-ID: <20230516102006.76dfd68a@gandalf.local.home>
In-Reply-To: <20230516071830.8190-5-zegao@tencent.com>
References: <20230516071830.8190-1-zegao@tencent.com>
	<20230516071830.8190-5-zegao@tencent.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 16 May 2023 15:18:30 +0800
Ze Gao <zegao2021@gmail.com> wrote:

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

Unrelated to this patch, but someday we need to change the -pg above to
$(CC_FLAGS_FTRACE).

-- Steve


>  endif
>  
>  KASAN_SANITIZE_head$(BITS).o				:= n
> -- 

