Return-Path: <bpf+bounces-1857-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 318E77230A6
	for <lists+bpf@lfdr.de>; Mon,  5 Jun 2023 22:05:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE605281387
	for <lists+bpf@lfdr.de>; Mon,  5 Jun 2023 20:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C28F924EBA;
	Mon,  5 Jun 2023 20:05:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98091DDC0
	for <bpf@vger.kernel.org>; Mon,  5 Jun 2023 20:05:23 +0000 (UTC)
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B470F91;
	Mon,  5 Jun 2023 13:05:21 -0700 (PDT)
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-75ca95c4272so489093985a.0;
        Mon, 05 Jun 2023 13:05:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685995520; x=1688587520;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GuZmqFzHRVDW/tDZw+qFvJ052geN0PkW23I5wWlvfOM=;
        b=CshTFEI8yH0vymUVajf7VOt1zyZlFfa9yflcVjKlvSWqe+rPBKDSf2CVx3J57Fe4dJ
         yQQPmTvR9cWbmzVsDlO1hKEI/XJ2WNXfAvvh0ZaDiLME5lbP4w1pGTEex6oJW7oiCBLr
         GZQ1pECBTx6NJx9KUI5nNi0Jx9oeR5quQeSUFtF76KDtjvqHfknfmEpoUEQsR6vh4Xng
         jrJStfSnU6snuBgwj8mQ0FZZJSskyQqAM6yP452ufWESJ7PZ+WtFIfbVJ/h3co63RJbP
         kgPLZ/T/QB2s/07RPl4LHXg7DH8OyQEuuinTNMfLIjxf83m5IaxsvHtLuJL2kWIM+53q
         ptXA==
X-Gm-Message-State: AC+VfDyvSp2whyJcWobUJyByjdZaBZvbeQuB/kQp8qJvgSNwi41tUlzB
	ogfNxNYMAl/vfjmAaX3eb8dnrL5dHYynXEYF
X-Google-Smtp-Source: ACHHUZ7rJ43X1QcAxXKzmq+WE65nazT+mL27wARl79hkWLsnHGo5Wug0GegxpSrqeJ9mwQopdj6qOA==
X-Received: by 2002:a05:620a:89a:b0:75d:117:1c8 with SMTP id b26-20020a05620a089a00b0075d011701c8mr770489qka.43.1685995520396;
        Mon, 05 Jun 2023 13:05:20 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:7447])
        by smtp.gmail.com with ESMTPSA id z2-20020ae9c102000000b0074e0951c7e7sm4477960qki.28.2023.06.05.13.05.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 13:05:19 -0700 (PDT)
From: David Vernet <void@manifault.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yhs@fb.com,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	davemarchevsky@meta.com
Subject: [PATCH bpf-next 1/2] bpf: Support bpf_for_each_map_elem() for BPF_MAP_TYPE_HASH_OF_MAPS maps
Date: Mon,  5 Jun 2023 15:05:07 -0500
Message-Id: <20230605200508.1888874-1-void@manifault.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The bpf_for_each_map_elem() helper can be used to iterate over all of
the elements of a map. The helper is not supported for all maps, which
currently includes the BPF_MAP_TYPE_HASH_OF_MAPS map type. Other hash
map types, such as BPF_MAP_TYPE_HASH, BPF_MAP_TYPE_PERCPU_HASH, etc, do
support this helper, so adding support for a hash of maps map type
doesn't require much code change.

The current use case for this is sched_ext, where we want to populate a
hashmap of cgroup id -> array of integers before a scheduler is
attached, so the scheduler can iterate over the map and assign the array
of CPUs to each cgroup as a cpumask.

This patch therefore adds support for using bpf_for_each_map_elem() for
BPF_MAP_TYPE_HASH_OF_MAPS. A subsequent patch will add selftests which
validate its behavior.

Signed-off-by: David Vernet <void@manifault.com>
---
 include/uapi/linux/bpf.h | 3 ++-
 kernel/bpf/hashtab.c     | 2 ++
 kernel/bpf/verifier.c    | 6 +++++-
 3 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index a7b5e91dd768..fc5f027c4837 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -4909,7 +4909,8 @@ union bpf_attr {
  *
  *		BPF_MAP_TYPE_HASH, BPF_MAP_TYPE_PERCPU_HASH,
  *		BPF_MAP_TYPE_LRU_HASH, BPF_MAP_TYPE_LRU_PERCPU_HASH,
- *		BPF_MAP_TYPE_ARRAY, BPF_MAP_TYPE_PERCPU_ARRAY
+ *		BPF_MAP_TYPE_HASH_OF_MAPS, BPF_MAP_TYPE_ARRAY,
+ *		BPF_MAP_TYPE_PERCPU_ARRAY
  *
  *		long (\*callback_fn)(struct bpf_map \*map, const void \*key, void \*value, void \*ctx);
  *
diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 9901efee4339..fef7b94ed389 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -2580,6 +2580,8 @@ const struct bpf_map_ops htab_of_maps_map_ops = {
 	.map_fd_sys_lookup_elem = bpf_map_fd_sys_lookup_elem,
 	.map_gen_lookup = htab_of_map_gen_lookup,
 	.map_check_btf = map_check_no_btf,
+	.map_set_for_each_callback_args = map_set_for_each_callback_args,
+	.map_for_each_callback = bpf_for_each_hash_elem,
 	.map_mem_usage = htab_map_mem_usage,
 	BATCH_OPS(htab),
 	.map_btf_id = &htab_map_btf_ids[0],
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 086b2a14905b..ba74b3b8f181 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -8174,10 +8174,14 @@ static int check_map_func_compatibility(struct bpf_verifier_env *env,
 			goto error;
 		break;
 	case BPF_MAP_TYPE_ARRAY_OF_MAPS:
-	case BPF_MAP_TYPE_HASH_OF_MAPS:
 		if (func_id != BPF_FUNC_map_lookup_elem)
 			goto error;
 		break;
+	case BPF_MAP_TYPE_HASH_OF_MAPS:
+		if (func_id != BPF_FUNC_map_lookup_elem &&
+		    func_id != BPF_FUNC_for_each_map_elem)
+			goto error;
+		break;
 	case BPF_MAP_TYPE_SOCKMAP:
 		if (func_id != BPF_FUNC_sk_redirect_map &&
 		    func_id != BPF_FUNC_sock_map_update &&
-- 
2.40.1


