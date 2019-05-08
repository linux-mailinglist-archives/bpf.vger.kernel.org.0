Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43BA817EF6
	for <lists+bpf@lfdr.de>; Wed,  8 May 2019 19:18:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728921AbfEHRSw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 May 2019 13:18:52 -0400
Received: from mail-vs1-f74.google.com ([209.85.217.74]:39122 "EHLO
        mail-vs1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728676AbfEHRSw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 May 2019 13:18:52 -0400
Received: by mail-vs1-f74.google.com with SMTP id i9so4048201vsm.6
        for <bpf@vger.kernel.org>; Wed, 08 May 2019 10:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=YsTefcGNkf2Q/mZpauJsyMPBMEq1hDK7EmnhSqbxuI0=;
        b=sClWGi7ujpn87u3owuoyPatrLqrKe+FTZdsQzsYSMxV5GuSZTuH8BYL/C2yvEffDyY
         oalmfgqVtv+4X20AMQvFrA9oyRuRwBfL6N0upurbJVP9gK1w+O6ZPcRPMU/BbkJiT6DL
         Sp5YRlbx97ohczv6bKsEHo7ycwOPjANOgh2sZaarU2YGiYBVFB9o/hJjSrkH1pA+jMLV
         yKN+BJPUzSdCttpln7RAD5hPLWYJH2JalICt0odlRuWy1nVM0duxML6TI+qE2I8uCIuV
         7QBYN8Ij1U5/VZue/1nr+NrnF8PobvqpcuBf7h9jggOJs/Z3tn2WvFSy+UR8S4UNf1BP
         oCDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=YsTefcGNkf2Q/mZpauJsyMPBMEq1hDK7EmnhSqbxuI0=;
        b=T4HVF/LJozyA6UAoNkDHXKTdCjqZGUWf4ZYErb+8Mn9rRyMNAL1KjbfXzDHa+ItOiv
         tW75uNNURMbXpQxJG9LKlVd+ECRao5xB0pkEHDbZxsh8zJ5/f0En3q2heoOg6gR5d9s3
         fMX2Z2H9Mh1cydElVhhWP/4IXkjWDj0myF+mPSUoCdvCoOduds2cflbwmEHE0lstOIVd
         X5QxjjSKE7OCueVtxga/0YsIu8yZZipcCPWrh4ygm/9sk7GwT+2r215HS+GrVPUUPPWC
         uA1soQnkYS3fXvvZu/5hxbxxGbLJtyVfRwzk4O5rSdCkBBxCBzSChSorWmA0SRripnCz
         Mkcg==
X-Gm-Message-State: APjAAAUHDrMI/KY68K6R1Bb+mWI0CRPJOAhcOLDKCV81YmaiRVxrtPd9
        KxCcPWZhm/p4JBM62YVJsG8RBdo=
X-Google-Smtp-Source: APXvYqyf7nPoRvIo5uDirN7fq+seYuLhBE/Tg4GvR/S9VmBqkEK+iF95ILtrtDPiU+1A+MbJlEmH7U0=
X-Received: by 2002:ab0:c12:: with SMTP id a18mr7746194uak.69.1557335930641;
 Wed, 08 May 2019 10:18:50 -0700 (PDT)
Date:   Wed,  8 May 2019 10:18:42 -0700
In-Reply-To: <20190508171845.201303-1-sdf@google.com>
Message-Id: <20190508171845.201303-2-sdf@google.com>
Mime-Version: 1.0
References: <20190508171845.201303-1-sdf@google.com>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
Subject: [PATCH bpf 1/4] bpf: remove __rcu annotations from bpf_prog_array
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Drop __rcu annotations and rcu read sections. That's not needed since
all existing callers call those helpers from the rcu update side
and under a mutex. This guarantees that use-after-free could not
happen. In the next patches I'll fix the callers with missing
rcu_dereference_protected to make sparse/lockdep happy.

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 include/linux/bpf.h | 12 ++++++------
 kernel/bpf/core.c   | 31 ++++++++++++-------------------
 2 files changed, 18 insertions(+), 25 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 944ccc310201..b90d2859bc60 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -476,17 +476,17 @@ struct bpf_prog_array {
 };
 
 struct bpf_prog_array *bpf_prog_array_alloc(u32 prog_cnt, gfp_t flags);
-void bpf_prog_array_free(struct bpf_prog_array __rcu *progs);
-int bpf_prog_array_length(struct bpf_prog_array __rcu *progs);
-int bpf_prog_array_copy_to_user(struct bpf_prog_array __rcu *progs,
+void bpf_prog_array_free(struct bpf_prog_array *progs);
+int bpf_prog_array_length(struct bpf_prog_array *progs);
+int bpf_prog_array_copy_to_user(struct bpf_prog_array *progs,
 				__u32 __user *prog_ids, u32 cnt);
 
-void bpf_prog_array_delete_safe(struct bpf_prog_array __rcu *progs,
+void bpf_prog_array_delete_safe(struct bpf_prog_array *progs,
 				struct bpf_prog *old_prog);
-int bpf_prog_array_copy_info(struct bpf_prog_array __rcu *array,
+int bpf_prog_array_copy_info(struct bpf_prog_array *array,
 			     u32 *prog_ids, u32 request_cnt,
 			     u32 *prog_cnt);
-int bpf_prog_array_copy(struct bpf_prog_array __rcu *old_array,
+int bpf_prog_array_copy(struct bpf_prog_array *old_array,
 			struct bpf_prog *exclude_prog,
 			struct bpf_prog *include_prog,
 			struct bpf_prog_array **new_array);
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index ff09d32a8a1b..da03fbc811fd 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -1794,38 +1794,33 @@ struct bpf_prog_array *bpf_prog_array_alloc(u32 prog_cnt, gfp_t flags)
 	return &empty_prog_array.hdr;
 }
 
-void bpf_prog_array_free(struct bpf_prog_array __rcu *progs)
+void bpf_prog_array_free(struct bpf_prog_array *progs)
 {
-	if (!progs ||
-	    progs == (struct bpf_prog_array __rcu *)&empty_prog_array.hdr)
+	if (!progs || progs == &empty_prog_array.hdr)
 		return;
 	kfree_rcu(progs, rcu);
 }
 
-int bpf_prog_array_length(struct bpf_prog_array __rcu *array)
+int bpf_prog_array_length(struct bpf_prog_array *array)
 {
 	struct bpf_prog_array_item *item;
 	u32 cnt = 0;
 
-	rcu_read_lock();
-	item = rcu_dereference(array)->items;
-	for (; item->prog; item++)
+	for (item = array->items; item->prog; item++)
 		if (item->prog != &dummy_bpf_prog.prog)
 			cnt++;
-	rcu_read_unlock();
 	return cnt;
 }
 
 
-static bool bpf_prog_array_copy_core(struct bpf_prog_array __rcu *array,
+static bool bpf_prog_array_copy_core(struct bpf_prog_array *array,
 				     u32 *prog_ids,
 				     u32 request_cnt)
 {
 	struct bpf_prog_array_item *item;
 	int i = 0;
 
-	item = rcu_dereference_check(array, 1)->items;
-	for (; item->prog; item++) {
+	for (item = array->items; item->prog; item++) {
 		if (item->prog == &dummy_bpf_prog.prog)
 			continue;
 		prog_ids[i] = item->prog->aux->id;
@@ -1838,7 +1833,7 @@ static bool bpf_prog_array_copy_core(struct bpf_prog_array __rcu *array,
 	return !!(item->prog);
 }
 
-int bpf_prog_array_copy_to_user(struct bpf_prog_array __rcu *array,
+int bpf_prog_array_copy_to_user(struct bpf_prog_array *array,
 				__u32 __user *prog_ids, u32 cnt)
 {
 	unsigned long err = 0;
@@ -1858,9 +1853,7 @@ int bpf_prog_array_copy_to_user(struct bpf_prog_array __rcu *array,
 	ids = kcalloc(cnt, sizeof(u32), GFP_USER | __GFP_NOWARN);
 	if (!ids)
 		return -ENOMEM;
-	rcu_read_lock();
 	nospc = bpf_prog_array_copy_core(array, ids, cnt);
-	rcu_read_unlock();
 	err = copy_to_user(prog_ids, ids, cnt * sizeof(u32));
 	kfree(ids);
 	if (err)
@@ -1870,19 +1863,19 @@ int bpf_prog_array_copy_to_user(struct bpf_prog_array __rcu *array,
 	return 0;
 }
 
-void bpf_prog_array_delete_safe(struct bpf_prog_array __rcu *array,
+void bpf_prog_array_delete_safe(struct bpf_prog_array *array,
 				struct bpf_prog *old_prog)
 {
-	struct bpf_prog_array_item *item = array->items;
+	struct bpf_prog_array_item *item;
 
-	for (; item->prog; item++)
+	for (item = array->items; item->prog; item++)
 		if (item->prog == old_prog) {
 			WRITE_ONCE(item->prog, &dummy_bpf_prog.prog);
 			break;
 		}
 }
 
-int bpf_prog_array_copy(struct bpf_prog_array __rcu *old_array,
+int bpf_prog_array_copy(struct bpf_prog_array *old_array,
 			struct bpf_prog *exclude_prog,
 			struct bpf_prog *include_prog,
 			struct bpf_prog_array **new_array)
@@ -1946,7 +1939,7 @@ int bpf_prog_array_copy(struct bpf_prog_array __rcu *old_array,
 	return 0;
 }
 
-int bpf_prog_array_copy_info(struct bpf_prog_array __rcu *array,
+int bpf_prog_array_copy_info(struct bpf_prog_array *array,
 			     u32 *prog_ids, u32 request_cnt,
 			     u32 *prog_cnt)
 {
-- 
2.21.0.1020.gf2820cf01a-goog

