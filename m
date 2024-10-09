Return-Path: <bpf+bounces-41487-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DEDC997653
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 22:20:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FC75282233
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 20:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 838F61E22E9;
	Wed,  9 Oct 2024 20:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kCDT75l+"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F3D1E04BF;
	Wed,  9 Oct 2024 20:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728505212; cv=none; b=E7mwKNpCux1If1kn5Hx3DbKq3jKjTgexbQw83SRDqvX+TBg4Q9cwOYOtrxquFxoZnNL6e6UONxmQgh/VTiDdimev0UZ0VtaivdynwyiNkmN30mcVK3SaWV0pBSathTubKPmUa9EUpZ7XLMgTvbamNAVmLIrqy2b28QPuLbi73Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728505212; c=relaxed/simple;
	bh=KzsQP48mbdeYco5aU4n9CSyrtRDfzohItrixaVc4Xqw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SMy6qUhMtKpc/KH5+c/xEGrMD3C9qrnt4rrENZZ+bRj05wEN3PErhZUMQ9Sl/7ITpLlxNrG3nR/nMcL6dcty8v+Hg6ORfbeJ0GcyujQJntUuhQGUhyKrkNZv1qEmjPc4eEY3co9Nyd+zHoyUeyI19GGyO5qeCVrwYibXAY6uDn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kCDT75l+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F29FAC4CEC3;
	Wed,  9 Oct 2024 20:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728505211;
	bh=KzsQP48mbdeYco5aU4n9CSyrtRDfzohItrixaVc4Xqw=;
	h=From:To:Cc:Subject:Date:From;
	b=kCDT75l+7s9xckCahhDNAv5e53A+ihUuBiosa0ax/KI6xiyE2ZbQSUj5L5lW/N1C9
	 KlxnEdtoylOonfK2ei29wYAa50ZvXT0LOuBXwmEAxVOtwjWsR+9eYcp3Nn5khkkf5l
	 YVSdhTNbrTf9u7lyxSmeaBj29U7tt1m7KklJLKUs+ybWbxg6Sbtq053LrhfK5frXuo
	 9A8MwSiWO4l0lrFeUahEgiQKKyU5YhMDiu25F5Mb17R29vKevo20kbr3mBjrg01/6m
	 vqLcM+xambCcwOlVPfrTaTnJ3R4U3fer97K/RLKpWjrATBQkiFQyYpWLfFOw0EVGs4
	 8Fbt3iFPQYdXg==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH 1/2] perf tools: Fix possible compiler warnings in hashmap
Date: Wed,  9 Oct 2024 13:20:08 -0700
Message-ID: <20241009202009.884884-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The hashmap__for_each_entry[_safe] is accessing 'map' as if it's a
pointer.  But it does without parentheses so passing a static hash map
with an ampersand (like &slab_hash below) caused compiler warnings due
to unmatched types.

  In file included from util/bpf_lock_contention.c:5:
  util/bpf_lock_contention.c: In function ‘exit_slab_cache_iter’:
  linux/tools/perf/util/hashmap.h:169:32: error: invalid type argument of ‘->’ (have ‘struct hashmap’)
    169 |         for (bkt = 0; bkt < map->cap; bkt++)                                \
        |                                ^~
  util/bpf_lock_contention.c:105:9: note: in expansion of macro ‘hashmap__for_each_entry’
    105 |         hashmap__for_each_entry(&slab_hash, cur, bkt)
        |         ^~~~~~~~~~~~~~~~~~~~~~~
  /home/namhyung/project/linux/tools/perf/util/hashmap.h:170:31: error: invalid type argument of ‘->’ (have ‘struct hashmap’)
    170 |                 for (cur = map->buckets[bkt]; cur; cur = cur->next)
        |                               ^~
  util/bpf_lock_contention.c:105:9: note: in expansion of macro ‘hashmap__for_each_entry’
    105 |         hashmap__for_each_entry(&slab_hash, cur, bkt)
        |         ^~~~~~~~~~~~~~~~~~~~~~~

Cc: bpf@vger.kernel.org
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
I've discovered this while prototyping the slab symbolization for perf
lock contention.  So this code is not available yet but I'd like to fix
the problem first.

Also noticed bpf has the same code and the same problem.  I'll send a
separate patch for them.

 tools/perf/util/hashmap.h | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/tools/perf/util/hashmap.h b/tools/perf/util/hashmap.h
index c12f8320e6682d50..0c4f155e8eb745d9 100644
--- a/tools/perf/util/hashmap.h
+++ b/tools/perf/util/hashmap.h
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
2.47.0.rc0.187.ge670bccf7e-goog


