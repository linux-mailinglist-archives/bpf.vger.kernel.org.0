Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF5B14F4D87
	for <lists+bpf@lfdr.de>; Wed,  6 Apr 2022 03:30:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343932AbiDEXpJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 5 Apr 2022 19:45:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1458055AbiDERGb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 5 Apr 2022 13:06:31 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CD77AC074
        for <bpf@vger.kernel.org>; Tue,  5 Apr 2022 10:04:32 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id 7so5627930pfu.13
        for <bpf@vger.kernel.org>; Tue, 05 Apr 2022 10:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pROGuwStiro9rcSYW3YeAtKJaGC9ZWqC+E1qhRzShxk=;
        b=tA6Lp2KTlzqbzCItB0ys8viPQghH3YJ6+SdbGwcrPNlITBfn8nt3mBaneYmi6Ifz19
         CJiVBsCpL+c6HqbbfYgHzDZsuF/gkKXK2lc4bTgNxgAK0/S4mz/rsh1hqwAlMUKEjKul
         w4GTz21a+EhIjdikEvLqtLFgIfLRaNS4O1VLUqQ4S1I5lgeSNNvm0TyL80b59lj1OXUa
         hXj0ircE3zWV8P0ASeIP76xonjuC1AoHwd7xnKPxA8+7Ewp9e+chhvgblMU270xglxj+
         rlavD5UNtimCx/YI+j+fTfO8nmEkwYIbCLnqEcie9L/jpvqMoWWcBJR7XFjpUQvB+ZAa
         7E8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pROGuwStiro9rcSYW3YeAtKJaGC9ZWqC+E1qhRzShxk=;
        b=bCefu1/9/X7Mven+h/RGqSZv0yr4rAL+YuBtVBF413WFHqp1stM0XiN5CufVM1EuL/
         ElQAHB53l2rAiUTTqKH6xnbzVUF4Wi4fhCfYvlp3b9ulqH9prx2BNwCMje3RQ+otFa1K
         0uQH+Xg5SJHqix6KO+lwQ3xVOnBa+S5KHI1Cl7rhkJYmiovQvYzZWa3Wonnzf3FTh5pc
         MedfjQ6gMoRmTntL7HsQ/wEVxEJYCSW1OZwKcgCdb6QuaDlXotcut4tqJDxYNI9l1VKd
         g6lEjk7imWzeAPClzBaLYUrwUVqqC6UAbrHP3epzD93XlNGX/YamxY3yFRM6RL8Pg8tQ
         niSw==
X-Gm-Message-State: AOAM5306qjmexiAgGD4QcNaBc0Z/tC6DzRrzjMezi0EQumfZbIsXDEWJ
        R6LMloDRDcyAPZCzFugRx7oW+UJOU5NqxCr5
X-Google-Smtp-Source: ABdhPJwD7B9L7RiPiFfKaGMQkGtYLA2hahKEheRhiKEh42v4f/MZK/KIfpScH9FOO2wpWsopqWEb2w==
X-Received: by 2002:a65:4647:0:b0:399:11b1:810b with SMTP id k7-20020a654647000000b0039911b1810bmr3638651pgr.449.1649178271389;
        Tue, 05 Apr 2022 10:04:31 -0700 (PDT)
Received: from localhost.localdomain ([50.39.160.154])
        by smtp.gmail.com with ESMTPSA id m7-20020a625807000000b004fe0a89f24fsm7796142pfb.112.2022.04.05.10.04.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Apr 2022 10:04:30 -0700 (PDT)
From:   Tadeusz Struk <tadeusz.struk@linaro.org>
To:     bpf@vger.kernel.org
Cc:     Tadeusz Struk <tadeusz.struk@linaro.org>,
        "Alexei Starovoitov" <ast@kernel.org>,
        "Daniel Borkmann" <daniel@iogearbox.net>,
        "Andrii Nakryiko" <andrii@kernel.org>,
        "Martin KaFai Lau" <kafai@fb.com>,
        "Song Liu" <songliubraving@fb.com>, "Yonghong Song" <yhs@fb.com>,
        "John Fastabend" <john.fastabend@gmail.com>,
        "KP Singh" <kpsingh@kernel.org>, netdev@vger.kernel.org,
        stable@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzbot+f264bffdfbd5614f3bb2@syzkaller.appspotmail.com
Subject: [PATCH] bpf: Fix KASAN use-after-free Read in compute_effective_progs
Date:   Tue,  5 Apr 2022 10:03:56 -0700
Message-Id: <20220405170356.43128-1-tadeusz.struk@linaro.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Syzbot found a Use After Free bug in compute_effective_progs().
The reproducer creates a number of BPF links, and causes a fault
injected alloc to fail, while calling bpf_link_detach on them.
Link detach triggers the link to be freed by bpf_link_free(),
which calls __cgroup_bpf_detach() and update_effective_progs().
If the memory allocation in this function fails, the function restores
the pointer to the bpf_cgroup_link on the cgroup list, but the memory
gets freed just after it returns. After this, every subsequent call to
update_effective_progs() causes this already deallocated pointer to be
dereferenced in prog_list_length(), and triggers KASAN UAF error.
To fix this don't preserve the pointer to the link on the cgroup list
in __cgroup_bpf_detach(), but proceed with the cleanup and retry calling
update_effective_progs() again afterwards.


Cc: "Alexei Starovoitov" <ast@kernel.org>
Cc: "Daniel Borkmann" <daniel@iogearbox.net>
Cc: "Andrii Nakryiko" <andrii@kernel.org>
Cc: "Martin KaFai Lau" <kafai@fb.com>
Cc: "Song Liu" <songliubraving@fb.com>
Cc: "Yonghong Song" <yhs@fb.com>
Cc: "John Fastabend" <john.fastabend@gmail.com>
Cc: "KP Singh" <kpsingh@kernel.org>
Cc: <netdev@vger.kernel.org>
Cc: <bpf@vger.kernel.org>
Cc: <stable@vger.kernel.org>
Cc: <linux-kernel@vger.kernel.org>

Link: https://syzkaller.appspot.com/bug?id=8ebf179a95c2a2670f7cf1ba62429ec044369db4
Fixes: af6eea57437a ("bpf: Implement bpf_link-based cgroup BPF program attachment")
Reported-by: <syzbot+f264bffdfbd5614f3bb2@syzkaller.appspotmail.com>
Signed-off-by: Tadeusz Struk <tadeusz.struk@linaro.org>
---
 kernel/bpf/cgroup.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 128028efda64..b6307337a3c7 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -723,10 +723,11 @@ static int __cgroup_bpf_detach(struct cgroup *cgrp, struct bpf_prog *prog,
 	pl->link = NULL;
 
 	err = update_effective_progs(cgrp, atype);
-	if (err)
-		goto cleanup;
-
-	/* now can actually delete it from this cgroup list */
+	/*
+	 * Proceed regardless of error. The link and/or prog will be freed
+	 * just after this function returns so just delete it from this
+	 * cgroup list and retry calling update_effective_progs again later.
+	 */
 	list_del(&pl->node);
 	kfree(pl);
 	if (list_empty(progs))
@@ -735,12 +736,11 @@ static int __cgroup_bpf_detach(struct cgroup *cgrp, struct bpf_prog *prog,
 	if (old_prog)
 		bpf_prog_put(old_prog);
 	static_branch_dec(&cgroup_bpf_enabled_key[atype]);
-	return 0;
 
-cleanup:
-	/* restore back prog or link */
-	pl->prog = old_prog;
-	pl->link = link;
+	/* In case of error call update_effective_progs again */
+	if (err)
+		err = update_effective_progs(cgrp, atype);
+
 	return err;
 }
 
@@ -881,6 +881,7 @@ static void bpf_cgroup_link_release(struct bpf_link *link)
 	struct bpf_cgroup_link *cg_link =
 		container_of(link, struct bpf_cgroup_link, link);
 	struct cgroup *cg;
+	int err;
 
 	/* link might have been auto-detached by dying cgroup already,
 	 * in that case our work is done here
@@ -896,8 +897,10 @@ static void bpf_cgroup_link_release(struct bpf_link *link)
 		return;
 	}
 
-	WARN_ON(__cgroup_bpf_detach(cg_link->cgroup, NULL, cg_link,
-				    cg_link->type));
+	err = __cgroup_bpf_detach(cg_link->cgroup, NULL, cg_link,
+				  cg_link->type);
+	if (err)
+		pr_warn("cgroup_bpf_detach() failed, err %d\n", err);
 
 	cg = cg_link->cgroup;
 	cg_link->cgroup = NULL;
-- 
2.35.1
