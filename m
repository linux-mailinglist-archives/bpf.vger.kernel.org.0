Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0170F6C27B1
	for <lists+bpf@lfdr.de>; Tue, 21 Mar 2023 03:01:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbjCUCBO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 20 Mar 2023 22:01:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbjCUCBM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 20 Mar 2023 22:01:12 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD413206A4;
        Mon, 20 Mar 2023 19:01:11 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id h12-20020a17090aea8c00b0023d1311fab3so14422466pjz.1;
        Mon, 20 Mar 2023 19:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679364071;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lhhrQN6VU2Z6m6A347eXTdRhJvwC6OZa/ddk6dk1oq0=;
        b=Myb/qLmsz62zshr+JOn5ZGXOoFhNLxsg98Vy5Tvgi6Rdv4PJmhEHRYnMpk67rzhGKt
         vKTcg7JOc/nYUrxOEpZuGtq1vQXToNp3O0gCvP5RdWO1bfF1+ReUe2JLA8sJnwink7+i
         dadIeV1EJR8qqhN66u+HGkUww45QL6776eQXv4iL5GbcFE+5VtjUDFvvq/ZNTOFKyZkE
         Mt9vb93Y3Mdr8e899EjS9n3rdSj4gdKrb4tWvbiR8zOUgMicl2piBqzJCkr0SVwvnjpD
         jlg8zAdqgYSZ36ACI9s46HixUhnjekRjNjvTUV3ndzCwLjT+VNmCQHLbBPstk9WNbKLf
         PX5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679364071;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lhhrQN6VU2Z6m6A347eXTdRhJvwC6OZa/ddk6dk1oq0=;
        b=rIoKNGGNJX8F8fAKLRvRLngxAuX8A48E/p6Ofa0WpdWgOy2Pr8ZenwlD73y2GTLnIN
         Mh7yxygQtzfoHe9THioD3z0KZ9MHiAVhdGBGC/HjdLiPvmdQj/u4iOR3jSio9uW/7Po9
         x5OVgxrIFpDZuTgBu/xvuur+tv9MKOGN5IybCvX/uv4ElOOPPwkhPTJJYfn1CwCVtPz/
         hS5pYlQ1dCHX6zj1yI4MRybsIhx1jtZ1P2tgWU/tjdD8OhPVrMvNwsDccLwrlFCBR5+b
         v6UizBET8KL5tL0kMhifeqRaX2rJjt8Z6zoIns3gR70OdUKd2Un04NOYQCCesA6LlRdy
         Tbkw==
X-Gm-Message-State: AO0yUKWWyWrM5EnaZzbBrMadcEFY+kSSrKANns3bA4ZPhKiyzbIgf46S
        xWNSR2Y+h9vfPTQbNGUnDuw=
X-Google-Smtp-Source: AK7set+z2UfwI6l7sgtBqNrYRQ1wr+Ou2J+fErZOAcYywp9G1cp6o8o3ogoHEWLZTKVrMqjq6cIovg==
X-Received: by 2002:a17:903:410c:b0:1a1:cd69:d301 with SMTP id r12-20020a170903410c00b001a1cd69d301mr413857pld.68.1679364071105;
        Mon, 20 Mar 2023 19:01:11 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:7002:81f:5400:4ff:fe5b:b66d])
        by smtp.gmail.com with ESMTPSA id s7-20020a170902988700b0019edd34dac9sm7367704plp.60.2023.03.20.19.01.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 19:01:10 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     rostedt@goodmis.org, mhiramat@kernel.org,
        alexei.starovoitov@gmail.com
Cc:     linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Jiri Olsa <olsajiri@gmail.com>
Subject: [PATCH] tracing: Refuse fprobe if RCU is not watching
Date:   Tue, 21 Mar 2023 02:01:03 +0000
Message-Id: <20230321020103.13494-1-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.1
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

It hits below warning on my test machine when running
selftests/bpf/test_progs,

[  702.223611] ------------[ cut here ]------------
[  702.224168] RCU not on for: preempt_count_sub+0x0/0xa0
[  702.224770] WARNING: CPU: 14 PID: 5267 at include/linux/trace_recursion.h:162 fprobe_handler.part.0+0x1b8/0x1c0
[  702.231740] CPU: 14 PID: 5267 Comm: main_amd64 Kdump: loaded Tainted: G           O       6.2.0+ #584
[  702.233169] RIP: 0010:fprobe_handler.part.0+0x1b8/0x1c0
[  702.241388] Call Trace:
[  702.241615]  <TASK>
[  702.241811]  fprobe_handler+0x22/0x30
[  702.242129]  0xffffffffc04710f7
[  702.242417] RIP: 0010:preempt_count_sub+0x5/0xa0
[  702.242809] Code: c8 50 68 94 42 0e b5 48 cf e9 f9 fd ff ff 0f 1f 80 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 e8 4b cd 38 0b <55> 8b 0d 9c d0 cf 02 48 89 e5 85 c9 75 1b 65 8b 05 be 78 f4 4a 89
[  702.244752] RSP: 0018:ffffaf6187d27f10 EFLAGS: 00000082 ORIG_RAX: 0000000000000000
[  702.245801] RAX: 000000000000000e RBX: 0000000001b6ab72 RCX: 0000000000000000
[  702.246804] RDX: 0000000000000000 RSI: ffffffffb627967d RDI: 0000000000000001
[  702.247801] RBP: ffffaf6187d27f30 R08: 0000000000000000 R09: 0000000000000000
[  702.248786] R10: 0000000000000000 R11: 0000000000000000 R12: 00000000000000ca
[  702.249782] R13: ffffaf6187d27f58 R14: 0000000000000000 R15: 0000000000000000
[  702.250785]  ? preempt_count_sub+0x5/0xa0
[  702.251540]  ? syscall_enter_from_user_mode+0x96/0xc0
[  702.252368]  ? preempt_count_sub+0x5/0xa0
[  702.253104]  ? syscall_enter_from_user_mode+0x96/0xc0
[  702.253918]  do_syscall_64+0x16/0x90
[  702.254613]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
[  702.255422] RIP: 0033:0x46b793

This issue happens under CONFIG_CONTEXT_TRACKING_USER=y. When a task
enters from user mode to kernel mode, or enters from user mode to irq,
it excutes preempt_count_sub before RCU begins watching, and thus this
warning is triggered.

We should not handle fprobe if RCU is not watching.

Suggested-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Jiri Olsa <olsajiri@gmail.com>
---
 kernel/trace/fprobe.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
index e8143e3..fe4b248 100644
--- a/kernel/trace/fprobe.c
+++ b/kernel/trace/fprobe.c
@@ -27,6 +27,9 @@ static void fprobe_handler(unsigned long ip, unsigned long parent_ip,
 	struct fprobe *fp;
 	int bit;
 
+	if (!rcu_is_watching())
+		return;
+
 	fp = container_of(ops, struct fprobe, ops);
 	if (fprobe_disabled(fp))
 		return;
-- 
1.8.3.1

