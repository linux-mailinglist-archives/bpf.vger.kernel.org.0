Return-Path: <bpf+bounces-41758-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A73399A955
	for <lists+bpf@lfdr.de>; Fri, 11 Oct 2024 19:00:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D72C1C21604
	for <lists+bpf@lfdr.de>; Fri, 11 Oct 2024 17:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B2EC19F49C;
	Fri, 11 Oct 2024 17:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gj8R9lAs"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E72D81AD7;
	Fri, 11 Oct 2024 17:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728666023; cv=none; b=MXyfWNaXasufgWSr1/X9Zdv3W/eOsjFcdDP1PfeoWERr9hKiaqVV6TUcGC9NQMgPYlzx3A2kzX5VKbRpBF1oKPriZa4QC51Silo2zXLKQ3TMoHYPIhcdP1JM6hDDpXSRL3tuuJICpqamdG72i1kVWQ7dA0R2BR1SPMBeKrfUW4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728666023; c=relaxed/simple;
	bh=tCb1Adt6yx6LpCYAGBV57u5hT1us7wTQ1g6x8UVUOS8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JeEWGJ0/Xc0a3s+fj9HvOFe8rLfvE9+qU54JJEmtUgLr6VnhOh4ofmP2jk6WI0By+Wqs4pbpmKH4D95upVi0K250liKXdM3GteO6KTU9eiGOY1JmoXRgwW7ctACItNJqEEFTV23rGnCE5De0YwZNuPBW8g1GlwVl0Hkh02UYVHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gj8R9lAs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71108C4CEC7;
	Fri, 11 Oct 2024 17:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728666022;
	bh=tCb1Adt6yx6LpCYAGBV57u5hT1us7wTQ1g6x8UVUOS8=;
	h=From:To:Cc:Subject:Date:From;
	b=gj8R9lAsMEqm144H+P5577uKJKD2sJvbLLLAIV/YwaZL9D0+LjfagcA5qOi0+q2Em
	 BvCp+o1uxk9LNQ4UxyJseQf8MCWdF7VjaTIyYVpG6k62Oxn8G2B7q05lE5TGcXf2CB
	 5MvgcwD/nx5OCWM4Yd+rhigAOOsTXOvQzUSpy9upd6q9eOceIcOlGI3Up0IcuD1gGS
	 oibNk0m2AsJ0uZ7tiiTuISNA3pF9gouA6vQolIE9MmEcbLTAEUG3zVH0dViGe3AxIZ
	 6fV+qRDvLGQHTAABQQb9tkQ6YhBGMatW98QOp4I2qw50DgXWqWVGZ5Bc2CQSjvG6N5
	 O/VGcjrmARXPA==
From: Namhyung Kim <namhyung@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
	bpf@vger.kernel.org
Subject: [PATCH] libbpf: Fix possible compiler warnings in hashmap
Date: Fri, 11 Oct 2024 10:00:21 -0700
Message-ID: <20241011170021.1490836-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The hashmap__for_each_entry[_safe] is accessing 'map' as a pointer.
But it does without parentheses so passing a static hash map with an
ampersand (like '&slab_hash') will cause compiler warnings due
to unmatched types as '->' operator has a higher precedence.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/lib/bpf/hashmap.h | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/tools/lib/bpf/hashmap.h b/tools/lib/bpf/hashmap.h
index c12f8320e6682d50..0c4f155e8eb745d9 100644
--- a/tools/lib/bpf/hashmap.h
+++ b/tools/lib/bpf/hashmap.h
@@ -166,8 +166,8 @@ bool hashmap_find(const struct hashmap *map, long key, long *value);
  * @bkt: integer used as a bucket loop cursor
  */
 #define hashmap__for_each_entry(map, cur, bkt)				    \
-	for (bkt = 0; bkt < map->cap; bkt++)				    \
-		for (cur = map->buckets[bkt]; cur; cur = cur->next)
+	for (bkt = 0; bkt < (map)->cap; bkt++)				    \
+		for (cur = (map)->buckets[bkt]; cur; cur = cur->next)
 
 /*
  * hashmap__for_each_entry_safe - iterate over all entries in hashmap, safe
@@ -178,8 +178,8 @@ bool hashmap_find(const struct hashmap *map, long key, long *value);
  * @bkt: integer used as a bucket loop cursor
  */
 #define hashmap__for_each_entry_safe(map, cur, tmp, bkt)		    \
-	for (bkt = 0; bkt < map->cap; bkt++)				    \
-		for (cur = map->buckets[bkt];				    \
+	for (bkt = 0; bkt < (map)->cap; bkt++)				    \
+		for (cur = (map)->buckets[bkt];				    \
 		     cur && ({tmp = cur->next; true; });		    \
 		     cur = tmp)
 
@@ -190,19 +190,19 @@ bool hashmap_find(const struct hashmap *map, long key, long *value);
  * @key: key to iterate entries for
  */
 #define hashmap__for_each_key_entry(map, cur, _key)			    \
-	for (cur = map->buckets						    \
-		     ? map->buckets[hash_bits(map->hash_fn((_key), map->ctx), map->cap_bits)] \
+	for (cur = (map)->buckets					    \
+		     ? (map)->buckets[hash_bits((map)->hash_fn((_key), (map)->ctx), (map)->cap_bits)] \
 		     : NULL;						    \
 	     cur;							    \
 	     cur = cur->next)						    \
-		if (map->equal_fn(cur->key, (_key), map->ctx))
+		if ((map)->equal_fn(cur->key, (_key), (map)->ctx))
 
 #define hashmap__for_each_key_entry_safe(map, cur, tmp, _key)		    \
-	for (cur = map->buckets						    \
-		     ? map->buckets[hash_bits(map->hash_fn((_key), map->ctx), map->cap_bits)] \
+	for (cur = (map)->buckets					    \
+		     ? (map)->buckets[hash_bits((map)->hash_fn((_key), (map)->ctx), (map)->cap_bits)] \
 		     : NULL;						    \
 	     cur && ({ tmp = cur->next; true; });			    \
 	     cur = tmp)							    \
-		if (map->equal_fn(cur->key, (_key), map->ctx))
+		if ((map)->equal_fn(cur->key, (_key), (map)->ctx))
 
 #endif /* __LIBBPF_HASHMAP_H */
-- 
2.47.0.rc1.288.g06298d1525-goog


