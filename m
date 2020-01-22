Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED8CE1448E9
	for <lists+bpf@lfdr.de>; Wed, 22 Jan 2020 01:29:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727847AbgAVA3I (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Jan 2020 19:29:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:40240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726970AbgAVA3I (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Jan 2020 19:29:08 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BF0D6217F4;
        Wed, 22 Jan 2020 00:29:06 +0000 (UTC)
Date:   Tue, 21 Jan 2020 19:29:05 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Brendan Gregg <brendan.d.gregg@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        "David S . Miller" <davem@davemloft.net>, paulmck@kernel.org,
        joel@joelfernandes.org,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
Subject: Re: [RFT PATCH 04/13] kprobes: Make optimizer delay to 1 second
Message-ID: <20200121192905.0f001c61@gandalf.local.home>
In-Reply-To: <157918589199.29301.4419459150054220408.stgit@devnote2>
References: <157918584866.29301.6941815715391411338.stgit@devnote2>
        <157918589199.29301.4419459150054220408.stgit@devnote2>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 16 Jan 2020 23:44:52 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Since the 5 jiffies delay for the optimizer is too
> short to wait for other probes, make it longer,
> like 1 second.

Hi Masami,

Can you explain more *why* 5 jiffies is too short.

Thanks!

-- Steve

> 
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> ---
>  kernel/kprobes.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index 0dacdcecc90f..9c6e230852ad 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -469,7 +469,8 @@ static int kprobe_optimizer_queue_update;
>  
>  static void kprobe_optimizer(struct work_struct *work);
>  static DECLARE_DELAYED_WORK(optimizing_work, kprobe_optimizer);
> -#define OPTIMIZE_DELAY 5
> +/* Wait 1 second for starting optimization */
> +#define OPTIMIZE_DELAY HZ
>  
>  /*
>   * Optimize (replace a breakpoint with a jump) kprobes listed on

