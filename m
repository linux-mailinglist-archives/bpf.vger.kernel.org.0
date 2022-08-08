Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB1A358CA23
	for <lists+bpf@lfdr.de>; Mon,  8 Aug 2022 16:08:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235514AbiHHOIE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Aug 2022 10:08:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237227AbiHHOIE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Aug 2022 10:08:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4706E2E
        for <bpf@vger.kernel.org>; Mon,  8 Aug 2022 07:08:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A3FD2B8049B
        for <bpf@vger.kernel.org>; Mon,  8 Aug 2022 14:08:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 637B6C433D6;
        Mon,  8 Aug 2022 14:07:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659967680;
        bh=Eabw5c+cDjQGY9iSJWIk/1u/+WzAFRBu7rJ7bIbnxPk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fgqnkhisFFKwF2yjQE3EibEuQ4PmTRfy+XncD4pHs7lqoEFUL6zvrdiNt4MxAmGoi
         IkHAqnSVezoP61FQ26WrUA9MOboUmgkNlepkI4LQacpLpFfBOxG3ACbNtBz+BVnw6+
         ccBcijfEgy0cg0nUZ23m+AnobyxWgowA6LrgnZ785dlHQBfO8KN4cEv8qSeTdD2403
         eu00xA2gkbrreOIRMsbhnAkZazE1PqEYAczmS7KVWIqTLL0SptQrO1Yk5sajkGjLK5
         +3+SCeAdCmFG7w/2rgxo2Y3zFDdLr1tHsG19+C2skb3hI+VBlvtzgmvv4cxCF+uOGA
         c4BjcXpCmKoUw==
From:   Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>
Subject: [RFC PATCH bpf-next 08/17] bpf: Factor bpf_trampoline_lookup function
Date:   Mon,  8 Aug 2022 16:06:17 +0200
Message-Id: <20220808140626.422731-9-jolsa@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220808140626.422731-1-jolsa@kernel.org>
References: <20220808140626.422731-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Factoring bpf_trampoline_lookup function and adding to new
functions which will be needed in following changes:

  struct bpf_trampoline *__bpf_trampoline_lookup(u64 key)
  - returns trampoline without locking trampoline_mutex

  static struct bpf_trampoline *bpf_trampoline_alloc(void)
  - alocates trampoline object

The bpf_trampoline_lookup logic stays the same.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/bpf/trampoline.c | 45 ++++++++++++++++++++++++++++++-----------
 1 file changed, 33 insertions(+), 12 deletions(-)

diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index e926692ded85..15801f6c5071 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -188,38 +188,59 @@ void bpf_tramp_id_put(struct bpf_tramp_id *id)
 	kfree(id);
 }
 
-static struct bpf_trampoline *bpf_trampoline_lookup(u64 key)
+static struct bpf_trampoline *__bpf_trampoline_lookup(u64 key)
 {
 	struct bpf_trampoline *tr;
 	struct hlist_head *head;
 
-	mutex_lock(&trampoline_mutex);
 	head = &trampoline_table[hash_64(key, TRAMPOLINE_HASH_BITS)];
 	hlist_for_each_entry(tr, head, hlist) {
-		if (tr->key == key) {
-			refcount_inc(&tr->refcnt);
-			goto out;
-		}
+		if (tr->key == key)
+			return tr;
 	}
+	return NULL;
+}
+
+static struct bpf_trampoline *bpf_trampoline_alloc(void)
+{
+	struct bpf_trampoline *tr;
+
 	tr = kzalloc(sizeof(*tr), GFP_KERNEL);
 	if (!tr)
-		goto out;
+		return NULL;
+
+	INIT_HLIST_NODE(&tr->hlist);
+	refcount_set(&tr->refcnt, 1);
+	mutex_init(&tr->mutex);
 #ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
 	tr->fops = kzalloc(sizeof(struct ftrace_ops), GFP_KERNEL);
 	if (!tr->fops) {
 		kfree(tr);
-		tr = NULL;
-		goto out;
+		return NULL;
 	}
 	tr->fops->private = tr;
 	tr->fops->ops_func = bpf_tramp_ftrace_ops_func;
 #endif
+	return tr;
+}
+
+static struct bpf_trampoline *bpf_trampoline_lookup(u64 key)
+{
+	struct bpf_trampoline *tr;
+	struct hlist_head *head;
 
+	mutex_lock(&trampoline_mutex);
+	tr = __bpf_trampoline_lookup(key);
+	if (tr) {
+		refcount_inc(&tr->refcnt);
+		goto out;
+	}
+	tr = bpf_trampoline_alloc();
+	if (!tr)
+		goto out;
 	tr->key = key;
-	INIT_HLIST_NODE(&tr->hlist);
+	head = &trampoline_table[hash_64(key, TRAMPOLINE_HASH_BITS)];
 	hlist_add_head(&tr->hlist, head);
-	refcount_set(&tr->refcnt, 1);
-	mutex_init(&tr->mutex);
 out:
 	mutex_unlock(&trampoline_mutex);
 	return tr;
-- 
2.37.1

