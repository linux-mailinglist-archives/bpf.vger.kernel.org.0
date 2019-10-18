Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7938DC666
	for <lists+bpf@lfdr.de>; Fri, 18 Oct 2019 15:43:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392518AbfJRNno (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 18 Oct 2019 09:43:44 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40474 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388989AbfJRNno (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 18 Oct 2019 09:43:44 -0400
Received: by mail-wr1-f66.google.com with SMTP id o28so6335358wro.7
        for <bpf@vger.kernel.org>; Fri, 18 Oct 2019 06:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SEzw38cDAC9xaprp9rRLe2ZVJoGCVxx2c6YAK/9vnss=;
        b=tCXCYl9NxZIduQLKAT3pdBJH2Tz+HjkAV6s4CrmlFofLB3DFnza9LGvhED5mIHrr4u
         26190+2TKrBN+a2IS9Qv5jj6mouKW/HsJoR5loI+noQ66dg6/PilZnwjw2Wj+E98xylG
         VsBn1kJ3rOcfbvRMuwmXpMpPNFpitTu4jcVGA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SEzw38cDAC9xaprp9rRLe2ZVJoGCVxx2c6YAK/9vnss=;
        b=IeHun1FcHO0hOWPhRRuug1gofTxbYqOppZGraU44hcIE9qudchTwXqX9LDw+SINTwI
         o1ShDC5c4APL+dI0jsINzc+RvzEdUc47c2uxBUYkmOnYXhXxj0XM0GjXUuNH8ZtlX2jF
         swA1FmJyemOUr0CI/U2IsPqEXJR+s3rusSHtvXr+whSeUU4ldrOUpQvzrcxPBnnw7t20
         pMN4/E/72FiJYuoa1fzGS7xv44gQiNw//lpxiHkBYBNbDqheTJY5YU9G8o4CPMQzLome
         /9AlqUQFv+msmBC4Po5M2A7FF2gjyr9Yc4gpKmWYxab5h04qXR25Qe1TpCn9Hn1iynuu
         4IZQ==
X-Gm-Message-State: APjAAAWXzGvM92qEV8fD6beUYQPlKJEusORD1uM7qE01ODHZHOImnCX/
        hgdK7j+lEHsZP/vHW1cT+VKs7F8MWYY=
X-Google-Smtp-Source: APXvYqwNrzgfSACK1p91ss5HVrJ0AwEGaifoDq8aiifNnaQE+CfhwK4Ga42+Q5eAqC7e06DhYQNGxw==
X-Received: by 2002:adf:f101:: with SMTP id r1mr8411079wro.320.1571406220465;
        Fri, 18 Oct 2019 06:43:40 -0700 (PDT)
Received: from localhost.localdomain ([2a06:98c0:1000:8250:24df:f8cf:746a:57f5])
        by smtp.gmail.com with ESMTPSA id z142sm6315491wmc.24.2019.10.18.06.43.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2019 06:43:39 -0700 (PDT)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net
Cc:     joe@wand.net.nz, Lorenz Bauer <lmb@cloudflare.com>
Subject: [PATCH bpf] bpf: improve htab_map_get_next_key behaviour during races
Date:   Fri, 18 Oct 2019 14:43:11 +0100
Message-Id: <20191018134311.7284-1-lmb@cloudflare.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

To iterate a BPF map, userspace must use MAP_GET_NEXT_KEY and provide
the last retrieved key. The code then scans the hash table bucket
for the key and returns the key of the next item.

This presents a problem if the last retrieved key isn't present in the
hash table anymore, e.g. due to concurrent deletion. It's not possible
to ascertain the location of a key in a given bucket, so there isn't
really a correct answer. The implementation currently returns the
first key in the first bucket. This guarantees that we never skip an
existing key. However, it means that a user space program iterating
a heavily modified map may never reach the end of the hash table,
forever restarting at the beginning.

Fixing this outright is rather involved. However, we can improve slightly
by never revisiting earlier buckets. Instead of the first key in the
first bucket we return the first key in the "current" bucket. This
doesn't eliminate the problem, but makes it less likely to occur.

Prior to commit 8fe45924387b ("bpf: map_get_next_key to return first key on NULL")
passing a non-existent key to MAP_GET_NEXT_KEY was the only way to
find the first key. Hence there is a small chance that there is code that
will be broken by this change.

Fixes: 8fe45924387b ("bpf: map_get_next_key to return first key on NULL")
Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
---
 kernel/bpf/hashtab.c                    | 4 +++-
 tools/testing/selftests/bpf/test_maps.c | 2 +-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 22066a62c8c9..30f0dab488f0 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -613,6 +613,9 @@ static int htab_map_get_next_key(struct bpf_map *map, void *key, void *next_key)
 
 	head = select_bucket(htab, hash);
 
+	/* don't iterate previous buckets */
+	i = hash & (htab->n_buckets - 1);
+
 	/* lookup the key */
 	l = lookup_nulls_elem_raw(head, hash, key, key_size, htab->n_buckets);
 
@@ -630,7 +633,6 @@ static int htab_map_get_next_key(struct bpf_map *map, void *key, void *next_key)
 	}
 
 	/* no more elements in this hash list, go to the next bucket */
-	i = hash & (htab->n_buckets - 1);
 	i++;
 
 find_first_elem:
diff --git a/tools/testing/selftests/bpf/test_maps.c b/tools/testing/selftests/bpf/test_maps.c
index 806b298397d3..6f351e532ddc 100644
--- a/tools/testing/selftests/bpf/test_maps.c
+++ b/tools/testing/selftests/bpf/test_maps.c
@@ -100,7 +100,7 @@ static void test_hashmap(unsigned int task, void *data)
 	assert(bpf_map_get_next_key(fd, NULL, &first_key) == 0 &&
 	       (first_key == 1 || first_key == 2));
 	assert(bpf_map_get_next_key(fd, &key, &next_key) == 0 &&
-	       (next_key == first_key));
+	       (next_key == 1 || next_key == 2));
 	assert(bpf_map_get_next_key(fd, &next_key, &next_key) == 0 &&
 	       (next_key == 1 || next_key == 2) &&
 	       (next_key != first_key));
-- 
2.20.1

