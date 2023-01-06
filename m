Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 923B165FD0E
	for <lists+bpf@lfdr.de>; Fri,  6 Jan 2023 09:48:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231876AbjAFIsw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 6 Jan 2023 03:48:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232243AbjAFIsp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 6 Jan 2023 03:48:45 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E48954724;
        Fri,  6 Jan 2023 00:48:45 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id j8-20020a17090a3e0800b00225fdd5007fso1054800pjc.2;
        Fri, 06 Jan 2023 00:48:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CLvpBtlWPC1Y4yYI2pgDTW/iPqU69O+/L6LCbdiNubM=;
        b=lHv5XTXiqHurmIC9daS85WL8F1hlIf+iMEPyKW/hqT5o6m23V36EImDG5+lebQRKh7
         2rP/ozBPce66wr0G1nAHk8/dW/TCH5f1TsDPgdXZmFDqO5RiiValeEKncRc2RHt4kILf
         eonuRBauT79z5oxxhHdll1stttLZGbIvf+OyUqPvaVX5K7Bg4/2e85/Wgh3kvRtnjoql
         hS8c9IpERfH9+FDXga1NmZqwbw/Qrr0D8PaqUpr+7sRtH5lorO8aHxZu06g51dOUf58b
         m+KeVRccO0fjzADOYFQplOOFDksFH4Eeo2d/d3NFs6OyU6noDiqMFRtJEoc79SyrI4Tm
         iNfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CLvpBtlWPC1Y4yYI2pgDTW/iPqU69O+/L6LCbdiNubM=;
        b=B/1+p1JdVnUiUe32VPR8lhWnBhvDJUVYXqzpxz7HTdkFt1QCmBJEM2apcev/0Rcff4
         KU902RQ6gulDaVRXm11RUGLE3MRxNvyV1oatRLAypIBC9INfKGeYBzQNGGiq3UUnbMnS
         5DdJv1rJqJlw0FQAj4+u17ASED2bscNbzcJnpPfnerrSTT5Lii1CUOk/XNUKkOMcWehX
         2iV2CF6Q9Pz3JsWCUu6gyk5H4jXKAgY4PzdFaSW2OOVuukscWhdStOb/kuzeDa4qqB+t
         jf9d80bmNDm4ClKYu9iTZhNwvxh8OaRiIr3OLKNNSD7EsiPG+Th9jETWi92edhbbYEsW
         C2Ig==
X-Gm-Message-State: AFqh2kr2RC8/QBK6Jq5QQQPD31rJ2ePGt39g7Roo0y9jfFplAmWhZxj/
        K7UDD4+ueGWvV4r4Mgmx45wcram2Mw/y
X-Google-Smtp-Source: AMrXdXtgJ2BhPl0zgwGWxM9NuOuMxVGVUoOI1lEAZJenlI7nk4b+Rj04PBbjF8EF5bk+mhPxDQqjhw==
X-Received: by 2002:a17:902:d346:b0:192:9160:6cd with SMTP id l6-20020a170902d34600b00192916006cdmr35802234plk.13.1672994924239;
        Fri, 06 Jan 2023 00:48:44 -0800 (PST)
Received: from localhost.localdomain ([144.214.0.13])
        by smtp.gmail.com with ESMTPSA id o9-20020a170903210900b0017fe9b038fdsm469840ple.14.2023.01.06.00.48.41
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 06 Jan 2023 00:48:43 -0800 (PST)
From:   Hao Sun <sunhao.th@gmail.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, davem@davemloft.net,
        linux-kernel@vger.kernel.org, Hao Sun <sunhao.th@gmail.com>
Subject: [PATCH] bpf: skip task with pid=1 in send_signal_common()
Date:   Fri,  6 Jan 2023 16:48:38 +0800
Message-Id: <20230106084838.12690-1-sunhao.th@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The following kernel panic can be triggered when a task with pid=1
attach a prog that attempts to send killing signal to itself, also
see [1] for more details:

Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
CPU: 3 PID: 1 Comm: systemd Not tainted 6.1.0-09652-g59fe41b5255f #148
Call Trace:
<TASK>
__dump_stack lib/dump_stack.c:88 [inline]
dump_stack_lvl+0x100/0x178 lib/dump_stack.c:106
panic+0x2c4/0x60f kernel/panic.c:275
do_exit.cold+0x63/0xe4 kernel/exit.c:789
do_group_exit+0xd4/0x2a0 kernel/exit.c:950
get_signal+0x2460/0x2600 kernel/signal.c:2858
arch_do_signal_or_restart+0x78/0x5d0 arch/x86/kernel/signal.c:306
exit_to_user_mode_loop kernel/entry/common.c:168 [inline]
exit_to_user_mode_prepare+0x15f/0x250 kernel/entry/common.c:203
__syscall_exit_to_user_mode_work kernel/entry/common.c:285 [inline]
syscall_exit_to_user_mode+0x1d/0x50 kernel/entry/common.c:296
do_syscall_64+0x44/0xb0 arch/x86/entry/common.c:86
entry_SYSCALL_64_after_hwframe+0x63/0xcd

So skip task with pid=1 in bpf_send_signal_common() to avoid the panic.

[1] https://lore.kernel.org/bpf/20221222043507.33037-1-sunhao.th@gmail.com

Signed-off-by: Hao Sun <sunhao.th@gmail.com>
---
 kernel/trace/bpf_trace.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 23ce498bca97..ed21ab9fe846 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -844,6 +844,9 @@ static int bpf_send_signal_common(u32 sig, enum pid_type type)
 	 */
 	if (unlikely(current->flags & (PF_KTHREAD | PF_EXITING)))
 		return -EPERM;
+	/* Task should not be pid=1 to avoid kernel panic. */
+	if (unlikely(is_global_init(current)))
+		return -EPERM;
 	if (unlikely(!nmi_uaccess_okay()))
 		return -EPERM;
 

base-commit: 4aea86b4033f92f01547e6d4388d4451ae9b0980
-- 
2.39.0

