Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE1356C33C5
	for <lists+bpf@lfdr.de>; Tue, 21 Mar 2023 15:12:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbjCUOMg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Mar 2023 10:12:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbjCUOMf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Mar 2023 10:12:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12ECC4AFDF;
        Tue, 21 Mar 2023 07:12:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C2875B816EC;
        Tue, 21 Mar 2023 14:12:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D64CDC433D2;
        Tue, 21 Mar 2023 14:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679407951;
        bh=VUblCBlGq6BxeQ8EVDvDqcA5ve3wzpR0PTtnv6H9WD0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZNSrrs5C/EF+kBay2XHVa7rBId5O1mlvoL7JIVqrO2iWDktEGL79bkFspl7HLu5T0
         OzaEhDbYMf7+Rv0oMuXarSv/6ZX4Tg6w9bgrGUKzKHTcWwCTqVvAmw9sLXZDZLU0+h
         7JZ20WlBziqa8enewY4MrVfgtHaIXvsFTTXAAqNZ631rYw2JAUrA1+nED0hGdpkBSr
         D05+eVw0TxQ+w7VazP0SxcA/CIOVCyPkohiKyCuF11sM0sMtEbdGWoOBVrmTjLm+Mo
         5eZf9vS377EMgkW9Tc0IaqjReaS6hCy9qfKwnwx8Znbtt46Wd+V+Q+EgnEhPomSnmd
         wlGz0ncrWiO6A==
Date:   Tue, 21 Mar 2023 23:12:27 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     rostedt@goodmis.org, alexei.starovoitov@gmail.com,
        linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Jiri Olsa <olsajiri@gmail.com>
Subject: Re: [PATCH] tracing: Refuse fprobe if RCU is not watching
Message-Id: <20230321231227.44cc5eb356c3df5fd50d6b64@kernel.org>
In-Reply-To: <20230321020103.13494-1-laoar.shao@gmail.com>
References: <20230321020103.13494-1-laoar.shao@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 21 Mar 2023 02:01:03 +0000
Yafang Shao <laoar.shao@gmail.com> wrote:

> It hits below warning on my test machine when running
> selftests/bpf/test_progs,
> 
> [  702.223611] ------------[ cut here ]------------
> [  702.224168] RCU not on for: preempt_count_sub+0x0/0xa0
> [  702.224770] WARNING: CPU: 14 PID: 5267 at include/linux/trace_recursion.h:162 fprobe_handler.part.0+0x1b8/0x1c0
> [  702.231740] CPU: 14 PID: 5267 Comm: main_amd64 Kdump: loaded Tainted: G           O       6.2.0+ #584
> [  702.233169] RIP: 0010:fprobe_handler.part.0+0x1b8/0x1c0
> [  702.241388] Call Trace:
> [  702.241615]  <TASK>
> [  702.241811]  fprobe_handler+0x22/0x30
> [  702.242129]  0xffffffffc04710f7
> [  702.242417] RIP: 0010:preempt_count_sub+0x5/0xa0
> [  702.242809] Code: c8 50 68 94 42 0e b5 48 cf e9 f9 fd ff ff 0f 1f 80 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 e8 4b cd 38 0b <55> 8b 0d 9c d0 cf 02 48 89 e5 85 c9 75 1b 65 8b 05 be 78 f4 4a 89
> [  702.244752] RSP: 0018:ffffaf6187d27f10 EFLAGS: 00000082 ORIG_RAX: 0000000000000000
> [  702.245801] RAX: 000000000000000e RBX: 0000000001b6ab72 RCX: 0000000000000000
> [  702.246804] RDX: 0000000000000000 RSI: ffffffffb627967d RDI: 0000000000000001
> [  702.247801] RBP: ffffaf6187d27f30 R08: 0000000000000000 R09: 0000000000000000
> [  702.248786] R10: 0000000000000000 R11: 0000000000000000 R12: 00000000000000ca
> [  702.249782] R13: ffffaf6187d27f58 R14: 0000000000000000 R15: 0000000000000000
> [  702.250785]  ? preempt_count_sub+0x5/0xa0
> [  702.251540]  ? syscall_enter_from_user_mode+0x96/0xc0
> [  702.252368]  ? preempt_count_sub+0x5/0xa0
> [  702.253104]  ? syscall_enter_from_user_mode+0x96/0xc0
> [  702.253918]  do_syscall_64+0x16/0x90
> [  702.254613]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
> [  702.255422] RIP: 0033:0x46b793
> 
> This issue happens under CONFIG_CONTEXT_TRACKING_USER=y. When a task
> enters from user mode to kernel mode, or enters from user mode to irq,
> it excutes preempt_count_sub before RCU begins watching, and thus this
> warning is triggered.
> 
> We should not handle fprobe if RCU is not watching.

Good catch!

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thank you!

> 
> Suggested-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> Cc: Jiri Olsa <olsajiri@gmail.com>
> ---
>  kernel/trace/fprobe.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
> index e8143e3..fe4b248 100644
> --- a/kernel/trace/fprobe.c
> +++ b/kernel/trace/fprobe.c
> @@ -27,6 +27,9 @@ static void fprobe_handler(unsigned long ip, unsigned long parent_ip,
>  	struct fprobe *fp;
>  	int bit;
>  
> +	if (!rcu_is_watching())
> +		return;
> +
>  	fp = container_of(ops, struct fprobe, ops);
>  	if (fprobe_disabled(fp))
>  		return;
> -- 
> 1.8.3.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
