Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F1634AA4C8
	for <lists+bpf@lfdr.de>; Sat,  5 Feb 2022 00:58:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343639AbiBDX6x (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Feb 2022 18:58:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234384AbiBDX6x (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Feb 2022 18:58:53 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D51CDF3770A
        for <bpf@vger.kernel.org>; Fri,  4 Feb 2022 15:58:52 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 2-20020a251302000000b006118f867dadso16163844ybt.12
        for <bpf@vger.kernel.org>; Fri, 04 Feb 2022 15:58:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=71LLBJLAIinOPQPItWAAGAQTxnq0uFrVdPYrb+8ip2M=;
        b=Ek9lr1dPo9Itt5aqgLqNP9YfbrMMChBJfzNe07gzHG0Hvl5eMR+q+8KslO8JLkTVpw
         kpXTtfMbploP3ra/QpOsI9ja7hu2lE81NYxkWdmxPJMKRrj04cgryRp2YCb+Oj9HUXZg
         ATx6dL7OXuCEEd+RFk9JgzasD6GqBWI4gX+Gb7XO3VI7s55tgFz/jHRSqHeTr2PgFTc4
         HV5Hof5k0g/UtDjUWIfSUwCGN0WPb8FMKuW9wZwOghuVTGKJUm91TWk6vvQzx/vexJHc
         hvJtc1v3Dyt2bPuSHsTjf2fRB8keuVDanBMp5OPQ1z2tPW0P5wen3MVhx0mvI+SRMrH7
         8GWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=71LLBJLAIinOPQPItWAAGAQTxnq0uFrVdPYrb+8ip2M=;
        b=q/SRjkixJIrI0AAWzE1S3ux3evVyqb4ENK0UisaD/UhZYDBKhZnB/mV0vZ35cNnbOi
         qQsgb8vetQHUmhVJuIwasiC8POI9usUaoD+ESTxJE8mkHc+PWe56m4q+g4yAJZyyfBsv
         IaI7SYTRZhqLbC7qfrPku4so1u4UcP534tF8DG+XuTQkP02xkViNgsmjhBZLbF8jOmaF
         5CxvT8iTP3/H8IrYcMfI/qzpm0RpWMu03pzAfPdYzewXvhXD/hVh4O7Q9KU5/Y4egRCM
         08tAW/g7M4S9enk6eEIddxLVTlET3ItE90HhBLpjP/wEOcMwoU++jrsYkkt3G3fvknn5
         KkIw==
X-Gm-Message-State: AOAM532TlZO6xfQfCOprwG4E5MMOeMolA8t0bPToxjsKnbpqS8D6Sapv
        1OzgaPOzAl0Jo3telWGE0LKykWY=
X-Google-Smtp-Source: ABdhPJyOkuqfh9zN9ZpzjCRHJ2pf17k8tEyWDex1pdMCZkTep2cW5ubLBODROl7H9aeM0zrBmapM+NE=
X-Received: from sdf2.svl.corp.google.com ([2620:15c:2c4:201:f002:9b32:36ff:cceb])
 (user=sdf job=sendgmr) by 2002:a5b:148:: with SMTP id c8mr1667937ybp.726.1644019131688;
 Fri, 04 Feb 2022 15:58:51 -0800 (PST)
Date:   Fri,  4 Feb 2022 15:58:48 -0800
Message-Id: <20220204235849.14658-1-sdf@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.0.263.gb82422642f-goog
Subject: [PATCH bpf-next 1/2] bpf: test_run: fix overflow in xdp frags parsing
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        Stanislav Fomichev <sdf@google.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        syzbot <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

When kattr->test.data_size_in > INT_MAX, signed min_t will assign
negative value to data_len. This negative value then gets passed
over to copy_from_user where it is converted to (big) unsigned.

Use unsigned min_t to avoid this overflow.

usercopy: Kernel memory overwrite attempt detected to wrapped address
(offset 0, size 18446612140539162846)!
------------[ cut here ]------------
kernel BUG at mm/usercopy.c:102!
invalid opcode: 0000 [#1] SMP KASAN
Modules linked in:
CPU: 0 PID: 3781 Comm: syz-executor226 Not tainted 4.15.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
Google 01/01/2011
RIP: 0010:usercopy_abort+0xbd/0xbf mm/usercopy.c:102
RSP: 0018:ffff8801e9703a38 EFLAGS: 00010286
RAX: 000000000000006c RBX: ffffffff84fc7040 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff816560a2 RDI: ffffed003d2e0739
RBP: ffff8801e9703a90 R08: 000000000000006c R09: 0000000000000001
R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff84fc73a0
R13: ffffffff84fc7180 R14: ffffffff84fc7040 R15: ffffffff84fc7040
FS:  00007f54e0bec300(0000) GS:ffff8801f6600000(0000)
knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000280 CR3: 00000001e90ea000 CR4: 00000000003426f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 check_bogus_address mm/usercopy.c:155 [inline]
 __check_object_size mm/usercopy.c:263 [inline]
 __check_object_size.cold+0x8c/0xad mm/usercopy.c:253
 check_object_size include/linux/thread_info.h:112 [inline]
 check_copy_size include/linux/thread_info.h:143 [inline]
 copy_from_user include/linux/uaccess.h:142 [inline]
 bpf_prog_test_run_xdp+0xe57/0x1240 net/bpf/test_run.c:989
 bpf_prog_test_run kernel/bpf/syscall.c:3377 [inline]
 __sys_bpf+0xdf2/0x4a50 kernel/bpf/syscall.c:4679
 SYSC_bpf kernel/bpf/syscall.c:4765 [inline]
 SyS_bpf+0x26/0x50 kernel/bpf/syscall.c:4763
 do_syscall_64+0x21a/0x3e0 arch/x86/entry/common.c:305
 entry_SYSCALL_64_after_hwframe+0x46/0xbb

Cc: Lorenzo Bianconi <lorenzo@kernel.org>
Fixes: 1c1949982524 ("bpf: introduce frags support to bpf_prog_test_run_xdp()")
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 net/bpf/test_run.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index 0220b0822d77..5819a7a5e3c6 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -960,7 +960,7 @@ int bpf_prog_test_run_xdp(struct bpf_prog *prog, const union bpf_attr *kattr,
 		while (size < kattr->test.data_size_in) {
 			struct page *page;
 			skb_frag_t *frag;
-			int data_len;
+			u32 data_len;
 
 			if (sinfo->nr_frags == MAX_SKB_FRAGS) {
 				ret = -ENOMEM;
@@ -976,7 +976,7 @@ int bpf_prog_test_run_xdp(struct bpf_prog *prog, const union bpf_attr *kattr,
 			frag = &sinfo->frags[sinfo->nr_frags++];
 			__skb_frag_set_page(frag, page);
 
-			data_len = min_t(int, kattr->test.data_size_in - size,
+			data_len = min_t(u32, kattr->test.data_size_in - size,
 					 PAGE_SIZE);
 			skb_frag_size_set(frag, data_len);
 
-- 
2.35.0.263.gb82422642f-goog

