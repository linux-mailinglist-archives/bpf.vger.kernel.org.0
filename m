Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0099FDB084
	for <lists+bpf@lfdr.de>; Thu, 17 Oct 2019 16:54:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404753AbfJQOyH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Oct 2019 10:54:07 -0400
Received: from www62.your-server.de ([213.133.104.62]:60898 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731768AbfJQOyH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Oct 2019 10:54:07 -0400
Received: from 55.249.197.178.dynamic.dsl-lte-bonding.lssmb00p-msn.res.cust.swisscom.ch ([178.197.249.55] helo=localhost)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1iL7A6-0003cm-P7; Thu, 17 Oct 2019 16:53:58 +0200
Date:   Thu, 17 Oct 2019 16:53:58 +0200
From:   Daniel Borkmann <daniel@iogearbox.net>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     bpf@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] BPF: Disable on PREEMPT_RT
Message-ID: <20191017145358.GA26267@pc-63.home>
References: <20191017090500.ienqyium2phkxpdo@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191017090500.ienqyium2phkxpdo@linutronix.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.101.4/25605/Thu Oct 17 10:52:31 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Oct 17, 2019 at 11:05:01AM +0200, Sebastian Andrzej Siewior wrote:
> Disable BPF on PREEMPT_RT because
> - it allocates and frees memory in atomic context
> - it uses up_read_non_owner()
> - BPF_PROG_RUN() expects to be invoked in non-preemptible context

For the latter you'd also need to disable seccomp-BPF and everything
cBPF related as they are /all/ invoked via BPF_PROG_RUN() ...

> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
> 
> I tried to fix the memory allocations in 
>   http://lkml.kernel.org/r/20190410143025.11997-1-bigeasy@linutronix.de
> 
> but I have no idea how to address the other two issues.
> 
>  init/Kconfig    |    1 +
>  net/kcm/Kconfig |    1 +
>  2 files changed, 2 insertions(+)
> 
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -1629,6 +1629,7 @@ config KALLSYMS_BASE_RELATIVE
>  # syscall, maps, verifier
>  config BPF_SYSCALL
>  	bool "Enable bpf() system call"
> +	depends on !PREEMPT_RT
>  	select BPF
>  	select IRQ_WORK
>  	default n
> --- a/net/kcm/Kconfig
> +++ b/net/kcm/Kconfig
> @@ -3,6 +3,7 @@
>  config AF_KCM
>  	tristate "KCM sockets"
>  	depends on INET
> +	depends on !PREEMPT_RT
>  	select BPF_SYSCALL
>  	select STREAM_PARSER
>  	---help---
