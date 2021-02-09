Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C3F9314E39
	for <lists+bpf@lfdr.de>; Tue,  9 Feb 2021 12:30:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbhBIL2q (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Feb 2021 06:28:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbhBIL1w (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Feb 2021 06:27:52 -0500
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1567DC061788
        for <bpf@vger.kernel.org>; Tue,  9 Feb 2021 03:27:12 -0800 (PST)
Received: by mail-wr1-x44a.google.com with SMTP id u15so16653769wrn.3
        for <bpf@vger.kernel.org>; Tue, 09 Feb 2021 03:27:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=A5PjxBocm6GkKPxXcYzX2e1AeHxW0gP+W7kFc8REg2E=;
        b=ofP339Bc5incCy4OVOMtxQ6ESTNMLP3Fc6EZ7VuXFsN0nYTCQuk3+Saa2UBlwztZ04
         8ZfX/NKW7MwxFkaStBW0GBGHv5nyLJClX5a4HNKpwvY8aZKkDqS18qOB5fmuiBzgx1lx
         k9IKdZGVfB6c+hJ98cgN3nh35iDKtooVTgyWjrRxFLw76X9Yg3G93wWrLoIHORVj/wj0
         9isSi7YjzfOrQGavjf96/f69AWde9QdwEmcAULfGVvVM90BSaujuIMkxeAzRh81H4aGE
         +n/UGB58fR+evj/4F7nqI10mVBlmJZ9H5/m2oUXnCrvGaHiaY6QFyMXllL0MV+R+pFrf
         4vzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=A5PjxBocm6GkKPxXcYzX2e1AeHxW0gP+W7kFc8REg2E=;
        b=rPAIAZb+YYnza3BSHFIk71bIKmBr8jOJuzPOI02ZSQhFRMpBNDRdQWn+jvUcGq1n2i
         Vpz47tsyM3Q97tpm2DVCSh7FdFAHU3g/K2b+m8FVyYu5kBhoZqMUyU76HKXSYwoMFF5f
         omcXAeVQyQcpXr/XPHVl+4UII9ulOE6BfazI3S3GVi3B7YDTDdzYqdmeAHg+NjHRDip5
         oHGR5WykpIDrxrTKG9+rhWIb7lCOzvr/YrC+ZBBfFuH+4gCBsqhN7Qvjs/CaCFg5ytTJ
         wVllMeE3FMcONWzkvC7MuwWp8POZuTRxXNMes60/VSmz6HQg4bY7bX6L8xp5Ra9BYmMd
         JfLA==
X-Gm-Message-State: AOAM531SQoi+qmBmeXUtV1xrxS0Xo2yyhhIaaWV8aOU8izWISFAO0F27
        6XOiSa5y5UAsldElheTsqSeVcZypSw==
X-Google-Smtp-Source: ABdhPJy71wYx5F5tGmoACI6FT7+5mPXDTjIjyxo+ykfIRjL5SWm/BBNye+fcUz68j74/ZTvvlLPyboqWrg==
Sender: "elver via sendgmr" <elver@elver.muc.corp.google.com>
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:51c9:b9a4:3e29:2cd0])
 (user=elver job=sendgmr) by 2002:a05:600c:35c9:: with SMTP id
 r9mr396002wmq.0.1612870029964; Tue, 09 Feb 2021 03:27:09 -0800 (PST)
Date:   Tue,  9 Feb 2021 12:27:01 +0100
Message-Id: <20210209112701.3341724-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
Subject: [PATCH] bpf_lru_list: Read double-checked variable once without lock
From:   Marco Elver <elver@google.com>
To:     elver@google.com, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     kasan-dev@googlegroups.com, paulmck@kernel.org, dvyukov@google.com,
        syzbot+3536db46dfa58c573458@syzkaller.appspotmail.com,
        syzbot+516acdb03d3e27d91bcd@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

For double-checked locking in bpf_common_lru_push_free(), node->type is
read outside the critical section and then re-checked under the lock.
However, concurrent writes to node->type result in data races.

For example, the following concurrent access was observed by KCSAN:

  write to 0xffff88801521bc22 of 1 bytes by task 10038 on cpu 1:
   __bpf_lru_node_move_in        kernel/bpf/bpf_lru_list.c:91
   __local_list_flush            kernel/bpf/bpf_lru_list.c:298
   ...
  read to 0xffff88801521bc22 of 1 bytes by task 10043 on cpu 0:
   bpf_common_lru_push_free      kernel/bpf/bpf_lru_list.c:507
   bpf_lru_push_free             kernel/bpf/bpf_lru_list.c:555
   ...

Fix the data races where node->type is read outside the critical section
(for double-checked locking) by marking the access with READ_ONCE() as
well as ensuring the variable is only accessed once.

Reported-by: syzbot+3536db46dfa58c573458@syzkaller.appspotmail.com
Reported-by: syzbot+516acdb03d3e27d91bcd@syzkaller.appspotmail.com
Signed-off-by: Marco Elver <elver@google.com>
---
Detailed reports:
	https://groups.google.com/g/syzkaller-upstream-moderation/c/PwsoQ7bfi8k/m/NH9Ni2WxAQAJ
	https://groups.google.com/g/syzkaller-upstream-moderation/c/-fXQO9ehxSM/m/RmQEcI2oAQAJ
---
 kernel/bpf/bpf_lru_list.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/bpf_lru_list.c b/kernel/bpf/bpf_lru_list.c
index 1b6b9349cb85..d99e89f113c4 100644
--- a/kernel/bpf/bpf_lru_list.c
+++ b/kernel/bpf/bpf_lru_list.c
@@ -502,13 +502,14 @@ struct bpf_lru_node *bpf_lru_pop_free(struct bpf_lru *lru, u32 hash)
 static void bpf_common_lru_push_free(struct bpf_lru *lru,
 				     struct bpf_lru_node *node)
 {
+	u8 node_type = READ_ONCE(node->type);
 	unsigned long flags;
 
-	if (WARN_ON_ONCE(node->type == BPF_LRU_LIST_T_FREE) ||
-	    WARN_ON_ONCE(node->type == BPF_LRU_LOCAL_LIST_T_FREE))
+	if (WARN_ON_ONCE(node_type == BPF_LRU_LIST_T_FREE) ||
+	    WARN_ON_ONCE(node_type == BPF_LRU_LOCAL_LIST_T_FREE))
 		return;
 
-	if (node->type == BPF_LRU_LOCAL_LIST_T_PENDING) {
+	if (node_type == BPF_LRU_LOCAL_LIST_T_PENDING) {
 		struct bpf_lru_locallist *loc_l;
 
 		loc_l = per_cpu_ptr(lru->common_lru.local_list, node->cpu);
-- 
2.30.0.478.g8a0d178c01-goog

