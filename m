Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E1376C3499
	for <lists+bpf@lfdr.de>; Tue, 21 Mar 2023 15:44:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231440AbjCUOoJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Mar 2023 10:44:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230231AbjCUOoH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Mar 2023 10:44:07 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19320303EE;
        Tue, 21 Mar 2023 07:44:04 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id t15so13950638wrz.7;
        Tue, 21 Mar 2023 07:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679409842;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rHAgTCkUW/lrxIRKIdW9hq+yn5IAPeXNGhTcjGhOfFo=;
        b=LGSs9hSyVpDRwvB0TOwPjE/1eLc1VHF1TNQZmTDpSLKzMdYHrV2OUr3VH12n7tnoxb
         Wreq1U9DzJI7OCfds7m2Dz+2JtSQGmydhEdCod+5w9gOXVUlxPBQPI3Q+ppq0lXP9Shn
         fP27z32x+l8+r4NRTHcvaqnOZ6+NVr4YUrTat6jVuZpuENeAPOgqF6mX6xEicCbvr2Lk
         tLWnEV8+LaHYvO0xX8wsKstmcYFXdMOuJylc9axParRxL/wluOaX9RqX/8Hyzf6eFcl5
         HLqqXQ8gDm/Q61F2ePTQKKm9D3u16dKktCGKxK1PpBbcAmm0lEWf7B6hg7fkzojlNWse
         Foxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679409842;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rHAgTCkUW/lrxIRKIdW9hq+yn5IAPeXNGhTcjGhOfFo=;
        b=aAhxmglkX6ivF0CWzSk8VWFctGjnRHZ0NunFQ2mX8efldEcFifwa31eAVPJhgJGa+J
         Dpl4votYz/j1Dfg8aJxlBz1uUGUF4GYQPCVfhmQXFZxZFm30Z8tpR+BG1wHkxMXomVch
         8fa1THjSCg+Je7RXjcHXiNH04mPdfOcMeIVyJb1rAIyAAsQAxjSf6e3gBSaclwMk0C9x
         U/DZl0dyNSAwwCCbqo6ZFHsYUYtjArEek0NyMD1005RvsVefPxzPix0eA+obPqrah2zj
         6K8uM8+zl4J5km42J08fUQn6qJlpz/F7l3Ys97iJ/7+kvskFTdIqPmnyFJYYFCeNhpcZ
         i/QQ==
X-Gm-Message-State: AO0yUKWyaYcY6W7itxVzXS+J+XsI5A6lIKTyeYpRswVXIVyOGrnBxoVF
        NeYgvIy7C6/a73sCJlQNObE=
X-Google-Smtp-Source: AK7set+THO0MAZ7nqkCgdMSS/If1fcEvpOX/pQjSu515Q+TLwuh3rBt36/NutZVAcshaHYlYC73P5w==
X-Received: by 2002:a5d:5685:0:b0:2ce:a835:83d4 with SMTP id f5-20020a5d5685000000b002cea83583d4mr2587977wrv.27.1679409842363;
        Tue, 21 Mar 2023 07:44:02 -0700 (PDT)
Received: from krava (net-93-147-243-166.cust.vodafonedsl.it. [93.147.243.166])
        by smtp.gmail.com with ESMTPSA id x8-20020a5d6508000000b002cea299a575sm11513572wru.101.2023.03.21.07.44.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 07:44:01 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Tue, 21 Mar 2023 15:43:59 +0100
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     rostedt@goodmis.org, mhiramat@kernel.org,
        alexei.starovoitov@gmail.com, linux-trace-kernel@vger.kernel.org,
        bpf@vger.kernel.org, Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Jiri Olsa <olsajiri@gmail.com>
Subject: Re: [PATCH] tracing: Refuse fprobe if RCU is not watching
Message-ID: <ZBnCr6YuUKCXpDXr@krava>
References: <20230321020103.13494-1-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230321020103.13494-1-laoar.shao@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Mar 21, 2023 at 02:01:03AM +0000, Yafang Shao wrote:
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
> 
> Suggested-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> Cc: Jiri Olsa <olsajiri@gmail.com>

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka

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
