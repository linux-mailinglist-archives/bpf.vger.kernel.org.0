Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A76F673FA5
	for <lists+bpf@lfdr.de>; Thu, 19 Jan 2023 18:11:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbjASRLz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 19 Jan 2023 12:11:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbjASRLu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 19 Jan 2023 12:11:50 -0500
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4824F8CE66;
        Thu, 19 Jan 2023 09:11:40 -0800 (PST)
Received: by mail-pj1-x1042.google.com with SMTP id u1-20020a17090a450100b0022936a63a21so6461394pjg.4;
        Thu, 19 Jan 2023 09:11:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eWyZ6OMpRDqwN7CwCYZdQQF6LML9EGI8pdw8AXpmI8Y=;
        b=TZ94KDggWV7EOTXzLJurNLt0lH5k1N5QS2bco2lc2jIFe2TbJZ8XlytdlGbcCPvJQV
         SBPqP5vBLQKXzsSkkxKxEjw6uPisnBEfdRLcWsamW4hF6xllrAl6RO5xMChS+Dt/rMu1
         evvZvTQc//FlRv6kyp6kxq5RPZL20TFKwV4xHmOOOj2qTrihVpaErE5s/1bs12Nla2Gb
         0txEcTr8N7NepuL2KNM4v2OXNLDziMiG7hWwCrQ6rzIXqUIS/9NTccyC7yklNAwNQa3I
         0Qkg/+2peQ6HwFtjdJBiU1145RZbOCazkqYD4XSOjOwB6lkbMp2587zKJmsEcWdJ70N6
         TJfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eWyZ6OMpRDqwN7CwCYZdQQF6LML9EGI8pdw8AXpmI8Y=;
        b=w8uM8ngXgwzJk7dlLBQZoyT+CqkoH8CAm4JuQGyGAv3N4IZQDkU/LygsUe8y4llZKq
         PlIw3jMIyQMQvrTnWBW7sSUr7G6H+lNMXuO9qKB78crbqnHnGFeU1DmlY9GRbF1dv+YX
         2hlFcp/U1E14MdnEPrER+aWEyJXTHO4O15AqQPsL3M5tKIj7T9vhVfjrs5WGtgF1nibR
         bxMRB3vlJG4VV9NWFa59AB1h7nIsqaYt+3I2adx3PtbDIblWyqvx6T2bNW4Df0s25Sg5
         qT0W66IsDCnv0i+/XeL27h/DFZ5m2zoCLhAoe7EbIP615l/D4U4kGH+U5ffDxH1hv6nl
         /hoQ==
X-Gm-Message-State: AFqh2krRZIFICQddiNNCPsp5tDQyVLM5OGTg++Uj7xHn0xIzubb9KfV4
        VsVxM3fVg6m5uGth4PbQ8nU=
X-Google-Smtp-Source: AMrXdXuQQ8bYqUq9pAsTvVWN9LBUtJea733+ceOorBCHNFd0CIQqE5Tqv4TOFkRe7AG3OHpAaa1ypQ==
X-Received: by 2002:a17:902:e548:b0:194:751f:3e89 with SMTP id n8-20020a170902e54800b00194751f3e89mr17352460plf.63.1674148299530;
        Thu, 19 Jan 2023 09:11:39 -0800 (PST)
Received: from localhost ([2405:201:6014:dae3:7dbb:8857:7c39:bb2a])
        by smtp.gmail.com with ESMTPSA id z6-20020a1709027e8600b0019445b8ef29sm17747855pla.61.2023.01.19.09.11.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 09:11:39 -0800 (PST)
Date:   Thu, 19 Jan 2023 22:41:36 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     Hao Sun <sunhao.th@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev,
        song@kernel.org, yhs@fb.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, davem@davemloft.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bpf: skip task with pid=1 in send_signal_common()
Message-ID: <20230119171136.3i25lucvhij2tr76@apollo>
References: <20230106084838.12690-1-sunhao.th@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230106084838.12690-1-sunhao.th@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jan 06, 2023 at 02:18:38PM IST, Hao Sun wrote:
> The following kernel panic can be triggered when a task with pid=1
> attach a prog that attempts to send killing signal to itself, also
> see [1] for more details:
>
> Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
> CPU: 3 PID: 1 Comm: systemd Not tainted 6.1.0-09652-g59fe41b5255f #148
> Call Trace:
> <TASK>
> __dump_stack lib/dump_stack.c:88 [inline]
> dump_stack_lvl+0x100/0x178 lib/dump_stack.c:106
> panic+0x2c4/0x60f kernel/panic.c:275
> do_exit.cold+0x63/0xe4 kernel/exit.c:789
> do_group_exit+0xd4/0x2a0 kernel/exit.c:950
> get_signal+0x2460/0x2600 kernel/signal.c:2858
> arch_do_signal_or_restart+0x78/0x5d0 arch/x86/kernel/signal.c:306
> exit_to_user_mode_loop kernel/entry/common.c:168 [inline]
> exit_to_user_mode_prepare+0x15f/0x250 kernel/entry/common.c:203
> __syscall_exit_to_user_mode_work kernel/entry/common.c:285 [inline]
> syscall_exit_to_user_mode+0x1d/0x50 kernel/entry/common.c:296
> do_syscall_64+0x44/0xb0 arch/x86/entry/common.c:86
> entry_SYSCALL_64_after_hwframe+0x63/0xcd
>
> So skip task with pid=1 in bpf_send_signal_common() to avoid the panic.
>
> [1] https://lore.kernel.org/bpf/20221222043507.33037-1-sunhao.th@gmail.com
>
> Signed-off-by: Hao Sun <sunhao.th@gmail.com>
> ---
>  kernel/trace/bpf_trace.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 23ce498bca97..ed21ab9fe846 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -844,6 +844,9 @@ static int bpf_send_signal_common(u32 sig, enum pid_type type)
>  	 */
>  	if (unlikely(current->flags & (PF_KTHREAD | PF_EXITING)))
>  		return -EPERM;
> +	/* Task should not be pid=1 to avoid kernel panic. */
> +	if (unlikely(is_global_init(current)))
> +		return -EPERM;

Sorry for chiming in late.
This seems a bit too restrictive, there are a lot of legitimate signals that can
be sent to the init process (like the ones listed in man 1 systemd). Maybe you
should only prevent sig == SIGKILL and not others?
