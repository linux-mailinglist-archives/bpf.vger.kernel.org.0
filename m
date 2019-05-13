Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 495391BB1C
	for <lists+bpf@lfdr.de>; Mon, 13 May 2019 18:39:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730453AbfEMQjA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 May 2019 12:39:00 -0400
Received: from mail-qk1-f201.google.com ([209.85.222.201]:35962 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728159AbfEMQjA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 13 May 2019 12:39:00 -0400
Received: by mail-qk1-f201.google.com with SMTP id a12so13356124qkb.3
        for <bpf@vger.kernel.org>; Mon, 13 May 2019 09:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=0j3OK6hF4mf82yxPJIwgHpqW3ZFmvyPeHIUEaQWbhx0=;
        b=EWPfO5gkQSHCK1fZ6D9STjcKrGg8ME4f7p45bRBK292gX1nMCLrHbysOSnwAEGilcU
         zCI2ayNa1BA2BsCy0+CiwKqrZtqMC8uaq9mFHlXfCJc7Nm89m70sfox5gifW70utcpyR
         TjbsLiUInYTs3DVIdmXUOd/WZcJjoNYOJX3/pJYYuGCjuI6cU3VWTvdwE6Hg4rGwoRJn
         YVJfSoRqivxXfsaUK2kgzAa5kZ7XwGvg23lEs4d+WWOlqBsLGMPoqlLg8rbUbyWRHJEo
         gB+DWHFIJbiDjJwgBaiLnB66dApj3olZRUSaupjxzs29OX/nwoE1Mw/ttwFmAQWDPhQR
         /W5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=0j3OK6hF4mf82yxPJIwgHpqW3ZFmvyPeHIUEaQWbhx0=;
        b=SfkSqVzidaFAcY2714Chm1EhJkfmuMy9fgyV9+RYHln+p7zipNIlFCvz+7zRRg6XOL
         LG92Tn7GBWArHPWdJJZMjrfRa1LPIjwfGVZbnNxxA73i/ftJIyHWmEErNbXocNr8MLd5
         QNgYlFo3bYGiiL001yiSc/uJ8iaBKnqPSzpi3qC39xCpwhbwfnerEOg/cZHUxGHhH3Oc
         +duWPnbOjxFFO9FqF4DKTejXqa/b4ki6STJW/eOBVagWG6HELVhYv0+XGd4nNzKPtR5P
         xryTkF9tScrg/fccWy1HqIw6dVlxrggpOAHtYfsSLkJFN60QZ8vNVNNin3Guxc6B+4Jf
         mVvQ==
X-Gm-Message-State: APjAAAVWWihArE77i1NgjV0AKCU+uMoExroW3PUswJKBjv5itmSKeykd
        Ci8uFtAOQFQMJ5iE7NZhTM1fmhd5Aq1+IA==
X-Google-Smtp-Source: APXvYqzH2sRpHn8wHkU95Zy4b/nQttKfsEu55iUoaGmbAGVh9TDjACHMoKeX9UniSpUjK/3jaDS3YTTj15R16A==
X-Received: by 2002:ac8:3231:: with SMTP id x46mr24584388qta.328.1557765539082;
 Mon, 13 May 2019 09:38:59 -0700 (PDT)
Date:   Mon, 13 May 2019 09:38:55 -0700
Message-Id: <20190513163855.225489-1-edumazet@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
Subject: [PATCH net] flow_dissector: disable preemption around BPF calls
From:   Eric Dumazet <edumazet@google.com>
To:     "David S . Miller" <davem@davemloft.net>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        netdev <netdev@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        bpf <bpf@vger.kernel.org>, syzbot <syzkaller@googlegroups.com>,
        Petar Penkov <ppenkov@google.com>,
        Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Various things in eBPF really require us to disable preemption
before running an eBPF program.

syzbot reported :

BUG: assuming atomic context at net/core/flow_dissector.c:737
in_atomic(): 0, irqs_disabled(): 0, pid: 24710, name: syz-executor.3
2 locks held by syz-executor.3/24710:
 #0: 00000000e81a4bf1 (&tfile->napi_mutex){+.+.}, at: tun_get_user+0x168e/0x3ff0 drivers/net/tun.c:1850
 #1: 00000000254afebd (rcu_read_lock){....}, at: __skb_flow_dissect+0x1e1/0x4bb0 net/core/flow_dissector.c:822
CPU: 1 PID: 24710 Comm: syz-executor.3 Not tainted 5.1.0+ #6
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x172/0x1f0 lib/dump_stack.c:113
 __cant_sleep kernel/sched/core.c:6165 [inline]
 __cant_sleep.cold+0xa3/0xbb kernel/sched/core.c:6142
 bpf_flow_dissect+0xfe/0x390 net/core/flow_dissector.c:737
 __skb_flow_dissect+0x362/0x4bb0 net/core/flow_dissector.c:853
 skb_flow_dissect_flow_keys_basic include/linux/skbuff.h:1322 [inline]
 skb_probe_transport_header include/linux/skbuff.h:2500 [inline]
 skb_probe_transport_header include/linux/skbuff.h:2493 [inline]
 tun_get_user+0x2cfe/0x3ff0 drivers/net/tun.c:1940
 tun_chr_write_iter+0xbd/0x156 drivers/net/tun.c:2037
 call_write_iter include/linux/fs.h:1872 [inline]
 do_iter_readv_writev+0x5fd/0x900 fs/read_write.c:693
 do_iter_write fs/read_write.c:970 [inline]
 do_iter_write+0x184/0x610 fs/read_write.c:951
 vfs_writev+0x1b3/0x2f0 fs/read_write.c:1015
 do_writev+0x15b/0x330 fs/read_write.c:1058
 __do_sys_writev fs/read_write.c:1131 [inline]
 __se_sys_writev fs/read_write.c:1128 [inline]
 __x64_sys_writev+0x75/0xb0 fs/read_write.c:1128
 do_syscall_64+0x103/0x670 arch/x86/entry/common.c:298
 entry_SYSCALL_64_after_hwframe+0x49/0xbe

Fixes: d58e468b1112 ("flow_dissector: implements flow dissector BPF hook")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: syzbot <syzkaller@googlegroups.com>
Cc: Petar Penkov <ppenkov@google.com>
Cc: Stanislav Fomichev <sdf@google.com>
---
 net/core/flow_dissector.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c
index 9ca784c592ac8c9c58282289a81889fbe4658a9e..548f39dde30711ac5be9e921993a6d8e53f74161 100644
--- a/net/core/flow_dissector.c
+++ b/net/core/flow_dissector.c
@@ -734,7 +734,9 @@ bool bpf_flow_dissect(struct bpf_prog *prog, struct bpf_flow_dissector *ctx,
 	flow_keys->nhoff = nhoff;
 	flow_keys->thoff = flow_keys->nhoff;
 
+	preempt_disable();
 	result = BPF_PROG_RUN(prog, ctx);
+	preempt_enable();
 
 	flow_keys->nhoff = clamp_t(u16, flow_keys->nhoff, nhoff, hlen);
 	flow_keys->thoff = clamp_t(u16, flow_keys->thoff,
-- 
2.21.0.1020.gf2820cf01a-goog

