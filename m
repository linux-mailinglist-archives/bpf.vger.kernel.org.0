Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D4FE66074D
	for <lists+bpf@lfdr.de>; Fri,  6 Jan 2023 20:45:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbjAFTpC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 6 Jan 2023 14:45:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbjAFTpB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 6 Jan 2023 14:45:01 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1F7C6E0C0
        for <bpf@vger.kernel.org>; Fri,  6 Jan 2023 11:45:00 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id o8-20020a17090a9f8800b00223de0364beso6186984pjp.4
        for <bpf@vger.kernel.org>; Fri, 06 Jan 2023 11:45:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Snh7uk5DxOJPdJR59DpaCuP9ts2AuGCJFA9IRo6NaCE=;
        b=rk94C250kx/kjnSVWVpYN/WGNwWwJEGGuHnOmQWX7CROKD1qlLyqYGaKtDg7zh1Eir
         YOoGL8SM11scDNCz9RggAIygVwqocqZxt86SV2JvLmMMn0XFMkfrDu1YaLukhwLfYFCT
         2s6QtYEbR24YBdWh5wAkHfqYTdWucJR8nA1560T2/Q2p+YjKsBaF0F3OTggs7cgahFLw
         lSuF7q92S8rO74jTIpGKM4RZo5gNciSKJUs75ElTtNytassPPzMYbBGx8yK1xWCTTkMY
         SfRO8HJo9LVCo10Xj1G0GkPjidk1jkbr0KzVPIGgQGoE5+xH2ZebzMUdk1x7zskCfEzU
         rxXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Snh7uk5DxOJPdJR59DpaCuP9ts2AuGCJFA9IRo6NaCE=;
        b=FPEKxv9qtnwfD2RR1lSyweVm5b4gDi0F8oOVstKCu4AWP5P6YsZUd7VgLE3JxjyKSH
         7BzhGgooeW5uA+JuJWxe/4Rs/+mh364U2v/iiV1WBNHx9BEIfCAiZpEfbuXwpRMmkMgj
         CxR57k3ehpCTZqVNQMPDy6uMy8cbQWH6GcFZDMgC0bGdYB2N5maRnLfH2VJIcm+YCl3E
         pUaZBylRDTRshZvSB4l2jxL5Un7ygUldRZiZ9eNjZB2Ls+orpXbnzDPGsCOvTDwAoiEY
         J9jcXuH26C9rvBclpljudvA5CLwUQ3+whMeWPcZSqLW5oJ9bsIzG1u9/U3lvjnIFKvi+
         Fwvg==
X-Gm-Message-State: AFqh2kqxLAtQWG3HTA27hKwrfVpYNGRvH7HMw4Sz1/DPkDHUche196jB
        +fVyHhTDng2eQGSAR6wdDtVrNGKXLFuu4Xr7HRsO/A==
X-Google-Smtp-Source: AMrXdXv57/MYEwsHX3MLBNu9Exll6PNK96xDrRSJLYYDR1kuEa02Eo2U4BHHGEhCNK/GAqp1RKpp44VYBXsl5BnNXKs=
X-Received: by 2002:a17:90a:5296:b0:219:fbc:a088 with SMTP id
 w22-20020a17090a529600b002190fbca088mr5293875pjh.162.1673034300135; Fri, 06
 Jan 2023 11:45:00 -0800 (PST)
MIME-Version: 1.0
References: <20230106084838.12690-1-sunhao.th@gmail.com>
In-Reply-To: <20230106084838.12690-1-sunhao.th@gmail.com>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Fri, 6 Jan 2023 11:44:48 -0800
Message-ID: <CAKH8qBtAubqGg42+QgNv5nTHeHke=OWskfR1bxX0TG4yGb-FAg@mail.gmail.com>
Subject: Re: [PATCH] bpf: skip task with pid=1 in send_signal_common()
To:     Hao Sun <sunhao.th@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev,
        song@kernel.org, yhs@fb.com, kpsingh@kernel.org, haoluo@google.com,
        jolsa@kernel.org, davem@davemloft.net, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jan 6, 2023 at 12:48 AM Hao Sun <sunhao.th@gmail.com> wrote:
>
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

Acked-by: Stanislav Fomichev <sdf@google.com>


> ---
>  kernel/trace/bpf_trace.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 23ce498bca97..ed21ab9fe846 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -844,6 +844,9 @@ static int bpf_send_signal_common(u32 sig, enum pid_type type)
>          */
>         if (unlikely(current->flags & (PF_KTHREAD | PF_EXITING)))
>                 return -EPERM;
> +       /* Task should not be pid=1 to avoid kernel panic. */
> +       if (unlikely(is_global_init(current)))
> +               return -EPERM;
>         if (unlikely(!nmi_uaccess_okay()))
>                 return -EPERM;
>
>
> base-commit: 4aea86b4033f92f01547e6d4388d4451ae9b0980
> --
> 2.39.0
>
