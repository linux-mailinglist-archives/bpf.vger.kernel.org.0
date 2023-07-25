Return-Path: <bpf+bounces-5867-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C5B576234A
	for <lists+bpf@lfdr.de>; Tue, 25 Jul 2023 22:27:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA6C5281A28
	for <lists+bpf@lfdr.de>; Tue, 25 Jul 2023 20:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F8F026B35;
	Tue, 25 Jul 2023 20:27:03 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A161F186
	for <bpf@vger.kernel.org>; Tue, 25 Jul 2023 20:27:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EEFEC433C8;
	Tue, 25 Jul 2023 20:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690316821;
	bh=gEzQPMn8Qpqa1JNOX+vH1aewrhLcYcM6fFBfClUEv/8=;
	h=From:To:Cc:Subject:Date:From;
	b=sJOSbA51Ti/uusknlq3hcUajShgMVP5z/PCyoNDaQKCdcs/uUIgZfXCX1UG1v0Oot
	 my+3xnrTIt+cx7D1BZtbLrFTLldGkUUGrwVNRzH3n2oKhj4yR2G3AZhbpKqXDEYj+a
	 twITw/WPtdabfmBPL6L4tWn6j7GYpJFgOWIxUxh+KCeNryHCSaxm6YHiINcP7MXc8l
	 JQjvVQaLkbcYjJhKC+Q/PngVugBOQFKn7zfKu8nj4iswQ7Vzsk04tbSLVT0n6WQM20
	 wnrOvnfOKUCFX6HIjA5b6NUW5fzMIN5jA464TDQKcFU/9rytA81/bvOZ5+VKjdFWf2
	 8Fi3j79i7PbBg==
From: Arnd Bergmann <arnd@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Hou Tao <houtao1@huawei.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] [v2] bpf: work around -Wuninitialized warning
Date: Tue, 25 Jul 2023 22:26:40 +0200
Message-Id: <20230725202653.2905259-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

Splitting these out into separate helper functions means that we
actually pass an uninitialized variable into another function call
if dec_active() happens to not be inlined, and CONFIG_PREEMPT_RT
is disabled:

kernel/bpf/memalloc.c: In function 'add_obj_to_free_list':
kernel/bpf/memalloc.c:200:9: error: 'flags' is used uninitialized [-Werror=uninitialized]
  200 |         dec_active(c, flags);

Avoid this by passing the flags by reference, so they either get
initialized and dereferenced through a pointer, or the pointer never
gets accessed at all.

Fixes: 18e027b1c7c6d ("bpf: Factor out inc/dec of active flag into helpers.")
Suggested-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 kernel/bpf/memalloc.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
index 51d6389e5152e..14d9b1a9a4cac 100644
--- a/kernel/bpf/memalloc.c
+++ b/kernel/bpf/memalloc.c
@@ -183,11 +183,11 @@ static void inc_active(struct bpf_mem_cache *c, unsigned long *flags)
 	WARN_ON_ONCE(local_inc_return(&c->active) != 1);
 }
 
-static void dec_active(struct bpf_mem_cache *c, unsigned long flags)
+static void dec_active(struct bpf_mem_cache *c, unsigned long *flags)
 {
 	local_dec(&c->active);
 	if (IS_ENABLED(CONFIG_PREEMPT_RT))
-		local_irq_restore(flags);
+		local_irq_restore(*flags);
 }
 
 static void add_obj_to_free_list(struct bpf_mem_cache *c, void *obj)
@@ -197,7 +197,7 @@ static void add_obj_to_free_list(struct bpf_mem_cache *c, void *obj)
 	inc_active(c, &flags);
 	__llist_add(obj, &c->free_llist);
 	c->free_cnt++;
-	dec_active(c, flags);
+	dec_active(c, &flags);
 }
 
 /* Mostly runs from irq_work except __init phase. */
@@ -344,7 +344,7 @@ static void free_bulk(struct bpf_mem_cache *c)
 			cnt = --c->free_cnt;
 		else
 			cnt = 0;
-		dec_active(c, flags);
+		dec_active(c, &flags);
 		if (llnode)
 			enque_to_free(tgt, llnode);
 	} while (cnt > (c->high_watermark + c->low_watermark) / 2);
@@ -384,7 +384,7 @@ static void check_free_by_rcu(struct bpf_mem_cache *c)
 		llist_for_each_safe(llnode, t, llist_del_all(&c->free_llist_extra_rcu))
 			if (__llist_add(llnode, &c->free_by_rcu))
 				c->free_by_rcu_tail = llnode;
-		dec_active(c, flags);
+		dec_active(c, &flags);
 	}
 
 	if (llist_empty(&c->free_by_rcu))
@@ -408,7 +408,7 @@ static void check_free_by_rcu(struct bpf_mem_cache *c)
 	inc_active(c, &flags);
 	WRITE_ONCE(c->waiting_for_gp.first, __llist_del_all(&c->free_by_rcu));
 	c->waiting_for_gp_tail = c->free_by_rcu_tail;
-	dec_active(c, flags);
+	dec_active(c, &flags);
 
 	if (unlikely(READ_ONCE(c->draining))) {
 		free_all(llist_del_all(&c->waiting_for_gp), !!c->percpu_size);
-- 
2.39.2


