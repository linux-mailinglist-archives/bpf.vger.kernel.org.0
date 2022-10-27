Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9001610605
	for <lists+bpf@lfdr.de>; Fri, 28 Oct 2022 00:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235176AbiJ0Wzl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Oct 2022 18:55:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233884AbiJ0Wzl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 Oct 2022 18:55:41 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09F18792DB
        for <bpf@vger.kernel.org>; Thu, 27 Oct 2022 15:55:40 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id f186-20020a636ac3000000b0044adaa7d347so1492515pgc.14
        for <bpf@vger.kernel.org>; Thu, 27 Oct 2022 15:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UyHHKto1OD9zfhqI+IeRFxKyzOJ9hzJRkZE5cd1gUiY=;
        b=IdlGsYzA7suWb1V+cdR6rTS/O6ecsngCSXAmC8Ce0keNTGEDB3UKyuSuJvDaSFFGKt
         fB/apJOgpPo73MwU430+vb71nEejIpR3kbzEmbRWnP3qXcVAitEv3rBgLg7kghCHeMFQ
         7xmT4wQVF8oPY0PbAKs+PtVbKk98jqlRZy9NDS9AnmG8Jj9gWSlaoOD3+Ucdxx3cpYdq
         j04vy+y5kAcYEEhXnrOZWRMH6aKVQNdpAwMQfqXUMfkjHgJM8aU+jgxvHpywxz3ywKb9
         9U1+Ac1fMt/GCkF6GD987yCmUyBXZOOPZg/jxY0p/Aqlza50uAa2D46kb1MtrjA/RbhO
         DiKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UyHHKto1OD9zfhqI+IeRFxKyzOJ9hzJRkZE5cd1gUiY=;
        b=8Qm9z1CljFtXnvwrsw6eJ8KIH0rouKVPG+VzbjrXeOVxJ7AGTZfsSlXAFE26W0QnV+
         aTg9LdYQQLnKGj55FMWwT20L7FRAC1t9A8TM7jZNaVKpbDze5V/xZnmntnWMFnsG2ilU
         tjwdevGEKxj6bxHrERJwlBZ9JySk1/gOQtF5X7AYRrL411bDOmmyybU/Vsa4H9mMvXq9
         O589aIxPSTxoKCeO7EPEikBrdvJh/JPldTm+5Ntncf/S6n/hf4LfRx/CMC+e3MEil6H1
         BFUS9b39cJjO4ThM/QVO8XyB7oTEo3ib+gF2kbtOPoKtbIz/q8kAbfNGbx5L3X7alsUA
         4o5g==
X-Gm-Message-State: ACrzQf30dYQbbeTSL/n+DFiHD2nvpByhSinb5t3JfvS9aPtPh91uoh7K
        744rSXy+VyyIiXFg60S9vkI4Fw5Fqky/bQlC3ANF/EG6KDr9KARS8pvOR58+HrdubxJ/ir01PJd
        y1GVY6ztzDnkEA/ZShsVjPOUCJQ0p1rVQZk5agLvpaQIHE5txgQ==
X-Google-Smtp-Source: AMsMyM68N1r54qPC+XY+Wz1JHDtY5xjkqeJrcoqvW6kq7l8qC87XfHcXB8IZcoE+qHlV/5DIVULWSKw=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a63:8341:0:b0:46f:d9e:b13f with SMTP id
 h62-20020a638341000000b0046f0d9eb13fmr19295422pge.389.1666911339422; Thu, 27
 Oct 2022 15:55:39 -0700 (PDT)
Date:   Thu, 27 Oct 2022 15:55:37 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.1.273.g43a17bfeac-goog
Message-ID: <20221027225537.353077-1-sdf@google.com>
Subject: [PATCH bpf-next] bpf: make sure skb->len != 0 when redirecting to a
 tunneling device
From:   Stanislav Fomichev <sdf@google.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org,
        Eric Dumazet <edumazet@google.com>,
        syzbot+f635e86ec3fa0a37e019@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

syzkaller managed to trigger another case where skb->len == 0
when we enter __dev_queue_xmit:

WARNING: CPU: 0 PID: 2470 at include/linux/skbuff.h:2576 skb_assert_len include/linux/skbuff.h:2576 [inline]
WARNING: CPU: 0 PID: 2470 at include/linux/skbuff.h:2576 __dev_queue_xmit+0x2069/0x35e0 net/core/dev.c:4295

Call Trace:
 dev_queue_xmit+0x17/0x20 net/core/dev.c:4406
 __bpf_tx_skb net/core/filter.c:2115 [inline]
 __bpf_redirect_no_mac net/core/filter.c:2140 [inline]
 __bpf_redirect+0x5fb/0xda0 net/core/filter.c:2163
 ____bpf_clone_redirect net/core/filter.c:2447 [inline]
 bpf_clone_redirect+0x247/0x390 net/core/filter.c:2419
 bpf_prog_48159a89cb4a9a16+0x59/0x5e
 bpf_dispatcher_nop_func include/linux/bpf.h:897 [inline]
 __bpf_prog_run include/linux/filter.h:596 [inline]
 bpf_prog_run include/linux/filter.h:603 [inline]
 bpf_test_run+0x46c/0x890 net/bpf/test_run.c:402
 bpf_prog_test_run_skb+0xbdc/0x14c0 net/bpf/test_run.c:1170
 bpf_prog_test_run+0x345/0x3c0 kernel/bpf/syscall.c:3648
 __sys_bpf+0x43a/0x6c0 kernel/bpf/syscall.c:5005
 __do_sys_bpf kernel/bpf/syscall.c:5091 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5089 [inline]
 __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5089
 do_syscall_64+0x54/0x70 arch/x86/entry/common.c:48
 entry_SYSCALL_64_after_hwframe+0x61/0xc6

The reproducer doesn't really reproduce outside of syzkaller
environment, so I'm taking a guess here. It looks like we
do generate correct ETH_HLEN-sized packet, but we redirect
the packet to the tunneling device. Before we do so, we
__skb_pull l2 header and arrive again at skb->len == 0.
Doesn't seem like we can do anything better than having
an explicit check after __skb_pull?

Cc: Eric Dumazet <edumazet@google.com>
Reported-by: syzbot+f635e86ec3fa0a37e019@syzkaller.appspotmail.com
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 net/core/filter.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index bb0136e7a8e4..cb3b635e35be 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -2126,6 +2126,10 @@ static int __bpf_redirect_no_mac(struct sk_buff *skb, struct net_device *dev,
 
 	if (mlen) {
 		__skb_pull(skb, mlen);
+		if (unlikely(!skb->len)) {
+			kfree_skb(skb);
+			return -ERANGE;
+		}
 
 		/* At ingress, the mac header has already been pulled once.
 		 * At egress, skb_pospull_rcsum has to be done in case that
-- 
2.38.1.273.g43a17bfeac-goog

