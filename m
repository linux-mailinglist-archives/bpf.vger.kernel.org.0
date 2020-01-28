Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7BCD314BC8D
	for <lists+bpf@lfdr.de>; Tue, 28 Jan 2020 16:02:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726073AbgA1PC2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Jan 2020 10:02:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:53490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726295AbgA1PC1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Jan 2020 10:02:27 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A3FEA2467E;
        Tue, 28 Jan 2020 15:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580223747;
        bh=GLcMbDI+gfzPGzKyUngTVfxGFi9C1OuQc12EKClEHjQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=yxsRYU9XsJ2ZYWezsuYg5pdJ6dmX3iGh/7GhjEnJG144INZW1JHui8EPxOM+f4ovQ
         P5CDWepZ7rVcdRsx6Xk7sHFAN4pTfqhQAyoj1CejVdADOjUJhV670ERTdji1WMGGqH
         JbEgX1QkEpWGlRbaEF9V9dlI7gHIZPqou95L/x5c=
Date:   Wed, 29 Jan 2020 00:02:20 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, Brendan Gregg <brendan.d.gregg@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        "David S . Miller" <davem@davemloft.net>, paulmck@kernel.org,
        joel@joelfernandes.org,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
Subject: Re: [RFC PATCH] tracing/kprobe: trace_kprobe_disabled_finished can
 be static
Message-Id: <20200129000220.81b363f3c5306eb054f91cdc@kernel.org>
In-Reply-To: <20200127150243.bllddfobxryxagwd@f53c9c00458a>
References: <157918590192.29301.6909688694265698678.stgit@devnote2>
        <20200127150243.bllddfobxryxagwd@f53c9c00458a>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 27 Jan 2020 23:02:43 +0800
kbuild test robot <lkp@intel.com> wrote:

> 
> Fixes: 3c794bf25a2b ("tracing/kprobe: Use call_rcu to defer freeing event_file_link")
> Signed-off-by: kbuild test robot <lkp@intel.com>
> ---
>  trace_kprobe.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
> index 1a5882bb77471..fba738aa458af 100644
> --- a/kernel/trace/trace_kprobe.c
> +++ b/kernel/trace/trace_kprobe.c
> @@ -328,7 +328,7 @@ static inline int __enable_trace_kprobe(struct trace_kprobe *tk)
>  	return ret;
>  }
>  
> -atomic_t trace_kprobe_disabled_finished;
> +static atomic_t trace_kprobe_disabled_finished;
>  
>  static void trace_kprobe_disabled_handlers_finish(void)
>  {

Oops, right. I forgot the static. I'll update it.

Thanks,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
