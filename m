Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D7D142ED10
	for <lists+bpf@lfdr.de>; Fri, 15 Oct 2021 11:04:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235771AbhJOJGe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 15 Oct 2021 05:06:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234459AbhJOJGe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 15 Oct 2021 05:06:34 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA088C061570
        for <bpf@vger.kernel.org>; Fri, 15 Oct 2021 02:04:27 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id g13-20020a17090a3c8d00b00196286963b9so8879647pjc.3
        for <bpf@vger.kernel.org>; Fri, 15 Oct 2021 02:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Va56VXzThcapfyuRQ5Jm4rTPogdKDliZvBqOga5mRCw=;
        b=hnSlvkSy8cjPjchSs3Hpxei9lPzOzdRKnGEDp0hhdCM+8yKQM4Kt1BRIwSd26KLl2l
         EFt5IAwN/0QrDf9Ta4giZbi+cJSj/gjcY7WvJljtnfU+YA/iP4/es2U9Po4uq36kYsqt
         ZJkQW2CtqgeF7zNus5pDXLAia3sR2pzy+X97VVYBrEUz4GSuz34o7soP/h9oeIV5YShH
         J5rb+9ip9FiehgJgt/fE4mfeSqpbFLNggzPBdWu+jW0bLOZEiexIKguWCTWM3PUQXc3d
         qBvugIE6AYBQ6nGxzs2FajNbJidlKnQD4W9TkFUG+Ccbcta63FTpS54osYsbSKjCJdnD
         waxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Va56VXzThcapfyuRQ5Jm4rTPogdKDliZvBqOga5mRCw=;
        b=n+YXkBxGTVW7xtxpik6kxvhRULVLl/DbDb3paWZVdKHYR8kyVNpaeHcSAtUeJzc4MZ
         +3mgVBalJ91cBE1jY3OC9ivI8WvUa43otTpMmiHBsSIBXbk1kIuNRLtTQpsJlV000/Na
         Oa+qi1UNFFSc/oth4qC4ES8wos7dHzf1S8FJJQUgt1UWuTUX7tsqrrtsgJuVJwFSNKco
         pY6FLKsl5WTleK23XOJIrJl+zbHC9zzL3BaQxR8+b+u1J351nTRtDZJZbn0Vfw2zM2wG
         DcsyNlTolxw+LY5SO/neGh436IU70iPFeMk+7x86I+Mak+dy3acgMEWcG3JXhXKyPbdt
         63Og==
X-Gm-Message-State: AOAM532PBvYjLjiOt//DyBn5nbciGOM1u4J7+c8j9nTT1eBKLFqTnvK0
        W1iWWo1M3l26QgQnbhM3AiD8Fw==
X-Google-Smtp-Source: ABdhPJwUUlt2PziUSmkUXhAgxMM7TpA7Blg+ObSbfCjY4jh7FhM1njWaFNuIMt+ySOT3pqCxqR6rXA==
X-Received: by 2002:a17:903:41c2:b0:13f:f26:d6b9 with SMTP id u2-20020a17090341c200b0013f0f26d6b9mr10019185ple.14.1634288667413;
        Fri, 15 Oct 2021 02:04:27 -0700 (PDT)
Received: from C02CV1DAMD6P.bytedance.net ([139.177.225.226])
        by smtp.gmail.com with ESMTPSA id k190sm4366009pfd.211.2021.10.15.02.04.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Oct 2021 02:04:27 -0700 (PDT)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhouchengming@bytedance.com
Subject: [PATCH] bpf: use count for prealloc hashtab too
Date:   Fri, 15 Oct 2021 17:03:53 +0800
Message-Id: <20211015090353.31248-1-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

We only use count for kmalloc hashtab not for prealloc hashtab, because
__pcpu_freelist_pop() return NULL when no more elem in pcpu freelist.

But the problem is that __pcpu_freelist_pop() will traverse all CPUs and
spin_lock for all CPUs to find there is no more elem at last.

We encountered bad case on big system with 96 CPUs that alloc_htab_elem()
would last for 1ms. This patch use count for prealloc hashtab too,
avoid traverse and spin_lock for all CPUs in this case.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 kernel/bpf/hashtab.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 32471ba02708..0c432a23aa00 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -855,12 +855,12 @@ static void htab_put_fd_value(struct bpf_htab *htab, struct htab_elem *l)
 static void free_htab_elem(struct bpf_htab *htab, struct htab_elem *l)
 {
 	htab_put_fd_value(htab, l);
+	atomic_dec(&htab->count);
 
 	if (htab_is_prealloc(htab)) {
 		check_and_free_timer(htab, l);
 		__pcpu_freelist_push(&htab->freelist, &l->fnode);
 	} else {
-		atomic_dec(&htab->count);
 		l->htab = htab;
 		call_rcu(&l->rcu, htab_elem_free_rcu);
 	}
@@ -938,6 +938,11 @@ static struct htab_elem *alloc_htab_elem(struct bpf_htab *htab, void *key,
 		} else {
 			struct pcpu_freelist_node *l;
 
+			if (atomic_inc_return(&htab->count) > htab->map.max_entries) {
+				l_new = ERR_PTR(-E2BIG);
+				goto dec_count;
+			}
+
 			l = __pcpu_freelist_pop(&htab->freelist);
 			if (!l)
 				return ERR_PTR(-E2BIG);
-- 
2.11.0

