Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 506E23061A6
	for <lists+bpf@lfdr.de>; Wed, 27 Jan 2021 18:14:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231234AbhA0RO3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 27 Jan 2021 12:14:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233624AbhA0RMh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 27 Jan 2021 12:12:37 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B179C0613D6
        for <bpf@vger.kernel.org>; Wed, 27 Jan 2021 09:11:57 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id j13so3358446edp.2
        for <bpf@vger.kernel.org>; Wed, 27 Jan 2021 09:11:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=tEZ9d5CGPHKYoot4+8YCqvx94kyHRm7qbCXqK5obPXk=;
        b=HN4YGq5HSaQa25DG94t8FLNd44eGMEXFXURHEEumpwlKp5I9ltvOj1ly+iBE6I4Ux3
         eM7nL6b+s2JBaE9gH+2pAZAPjEghoDASEiqy99hT+H7ytMnoXFPeLtR38rPZyIrjjrBY
         O/8p/RC+oEs1B/Qnpy+pioC+q0Zr/9Pm0Pp20GHj0eXpjIRlSeVZk/ZkRCz59kuVpgHR
         jYiH8ksfMZS2lT0TX3sTUk92kwiJyfrEOl4plYbrXdNT3jv2hGnnnmgCyNMbHtxlukF+
         CUkMtb3ECYR2yJ7ElPhHOALaujqxzHbTeckKwp+xn/NQjTQL9ne236OSyQ1Arobk829L
         Hq7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=tEZ9d5CGPHKYoot4+8YCqvx94kyHRm7qbCXqK5obPXk=;
        b=f6f459LAoWW0G5c9s3IXMFoLLeZ/iMl5GKyMx6D6aKGYPsw14jtnmT/goHpbwj90dK
         fKB5SPz035jQQvnV0R0+z9qBcntedEkS5gpQf8uroSumtTjzCyviMbSuB7zSBMK+yfqF
         ivujRw3xSW5h+CCijLMqKJNSGqTxpvYzsRwrKCNTlXIgNIZ70LIWETlzxLCXAWxk3h/0
         vl/pWZtXkicGiBrieOUo7ODVELuqCjvYq5cXuZBKRQs+mzCqd321QBNdUGRBanNESLIR
         QAhAcdvCdoX4hYnCOlqzZVoG/ISD0UJ1kN/qLVyZlWGw0QzZxndClT+1Hwcpsu/Ebmq8
         vaFQ==
X-Gm-Message-State: AOAM5339EtcnLZFXQ2lfkB67HSz3phjBq47oMCank2urw7leRisAqHuH
        oap+4x03JX7cMM09k3HCo1MpnsXvJKVdx6pgWybfBZsoMh6cVV6+t5b9sk727/2FPo4bfyHwwAk
        roPXqfrkgxKKqT1jSoNnME20kL6r9vzPwUi8Uf4DYCwh/JdRKlV4HYOO3HLgQaMHHi/W2sR0o
X-Google-Smtp-Source: ABdhPJygRzklgOMW2KTk8cQR3TNc0BzBal3DKpGHyVrJThtWJGc+8jLWCdPgMyMpM3vud6ivIaVnPQ==
X-Received: by 2002:a05:6402:35ca:: with SMTP id z10mr10135937edc.174.1611767516118;
        Wed, 27 Jan 2021 09:11:56 -0800 (PST)
Received: from gmail.com (93-136-180-151.adsl.net.t-com.hr. [93.136.180.151])
        by smtp.gmail.com with ESMTPSA id l17sm1116662ejc.60.2021.01.27.09.11.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jan 2021 09:11:55 -0800 (PST)
Date:   Wed, 27 Jan 2021 18:12:05 +0100
From:   Denis Salopek <denis.salopek@sartura.hr>
To:     bpf@vger.kernel.org
Cc:     luka.perkov@sartura.hr, luka.oreskovic@sartura.hr,
        juraj.vijtiuk@sartura.hr
Subject: [PATCH bpf-next] bpf: add lookup_and_delete_elem support to hashtab
Message-ID: <YBGe5WFzSc3Z8Oh5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Extend the existing bpf_map_lookup_and_delete_elem() functionality to
hashtab maps, in addition to stacks and queues.
Create a new hashtab bpf_map_ops function that does lookup and deletion
of the element under the same bucket lock and add the created map_ops to
bpf.h.
Add the appropriate test case to 'maps' selftests.

Signed-off-by: Denis Salopek <denis.salopek@sartura.hr>
Cc: Juraj Vijtiuk <juraj.vijtiuk@sartura.hr>
Cc: Luka Oreskovic <luka.oreskovic@sartura.hr>
Cc: Luka Perkov <luka.perkov@sartura.hr>
---
 include/linux/bpf.h                     |  1 +
 kernel/bpf/hashtab.c                    | 38 +++++++++++++++++++++++++
 kernel/bpf/syscall.c                    |  9 ++++++
 tools/testing/selftests/bpf/test_maps.c |  7 +++++
 4 files changed, 55 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 1aac2af12fed..003c1505f0e3 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -77,6 +77,7 @@ struct bpf_map_ops {
 
 	/* funcs callable from userspace and from eBPF programs */
 	void *(*map_lookup_elem)(struct bpf_map *map, void *key);
+	int (*map_lookup_and_delete_elem)(struct bpf_map *map, void *key, void *value);
 	int (*map_update_elem)(struct bpf_map *map, void *key, void *value, u64 flags);
 	int (*map_delete_elem)(struct bpf_map *map, void *key);
 	int (*map_push_elem)(struct bpf_map *map, void *value, u64 flags);
diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index c1ac7f964bc9..8d8463e0ea34 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -973,6 +973,43 @@ static int check_flags(struct bpf_htab *htab, struct htab_elem *l_old,
 	return 0;
 }
 
+/* Called from syscall or from eBPF program */
+static int htab_map_lookup_and_delete_elem(struct bpf_map *map, void *key, void *value)
+{
+	struct bpf_htab *htab = container_of(map, struct bpf_htab, map);
+	struct hlist_nulls_head *head;
+	struct bucket *b;
+	struct htab_elem *l;
+	unsigned long flags;
+	u32 hash, key_size;
+	int ret;
+
+	WARN_ON_ONCE(!rcu_read_lock_held() && !rcu_read_lock_trace_held());
+
+	key_size = map->key_size;
+
+	hash = htab_map_hash(key, key_size, htab->hashrnd);
+	b = __select_bucket(htab, hash);
+	head = &b->head;
+
+	ret = htab_lock_bucket(htab, b, hash, &flags);
+	if (ret)
+		return ret;
+
+	l = lookup_elem_raw(head, hash, key, key_size);
+
+	if (l) {
+		copy_map_value(map, value, l->key + round_up(key_size, 8));
+		hlist_nulls_del_rcu(&l->hash_node);
+		free_htab_elem(htab, l);
+	} else {
+		ret = -ENOENT;
+	}
+
+	htab_unlock_bucket(htab, b, hash, flags);
+	return ret;
+}
+
 /* Called from syscall or from eBPF program */
 static int htab_map_update_elem(struct bpf_map *map, void *key, void *value,
 				u64 map_flags)
@@ -1877,6 +1914,7 @@ const struct bpf_map_ops htab_map_ops = {
 	.map_free = htab_map_free,
 	.map_get_next_key = htab_map_get_next_key,
 	.map_lookup_elem = htab_map_lookup_elem,
+	.map_lookup_and_delete_elem = htab_map_lookup_and_delete_elem,
 	.map_update_elem = htab_map_update_elem,
 	.map_delete_elem = htab_map_delete_elem,
 	.map_gen_lookup = htab_map_gen_lookup,
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index e5999d86c76e..4ff45c8d1077 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1505,6 +1505,15 @@ static int map_lookup_and_delete_elem(union bpf_attr *attr)
 	if (map->map_type == BPF_MAP_TYPE_QUEUE ||
 	    map->map_type == BPF_MAP_TYPE_STACK) {
 		err = map->ops->map_pop_elem(map, value);
+	} else if (map->map_type == BPF_MAP_TYPE_HASH) {
+		if (!bpf_map_is_dev_bound(map)) {
+			bpf_disable_instrumentation();
+			rcu_read_lock();
+			err = map->ops->map_lookup_and_delete_elem(map, key, value);
+			rcu_read_unlock();
+			bpf_enable_instrumentation();
+			maybe_wait_bpf_programs(map);
+		}
 	} else {
 		err = -ENOTSUPP;
 	}
diff --git a/tools/testing/selftests/bpf/test_maps.c b/tools/testing/selftests/bpf/test_maps.c
index 51adc42b2b40..3e1900e46e1d 100644
--- a/tools/testing/selftests/bpf/test_maps.c
+++ b/tools/testing/selftests/bpf/test_maps.c
@@ -65,6 +65,13 @@ static void test_hashmap(unsigned int task, void *data)
 	assert(bpf_map_lookup_elem(fd, &key, &value) == 0 && value == 1234);
 
 	key = 2;
+	value = 1234;
+	/* Insert key=2 element. */
+	assert(bpf_map_update_elem(fd, &key, &value, BPF_ANY) == 0);
+
+	/* Check that key=2 matches the value and delete it */
+	assert(bpf_map_lookup_and_delete_elem(fd, &key, &value) == 0 && value == 1234);
+
 	/* Check that key=2 is not found. */
 	assert(bpf_map_lookup_elem(fd, &key, &value) == -1 && errno == ENOENT);
 
-- 
2.26.2

