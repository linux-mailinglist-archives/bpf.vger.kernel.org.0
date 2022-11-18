Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C689562EB64
	for <lists+bpf@lfdr.de>; Fri, 18 Nov 2022 02:56:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240308AbiKRB43 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Nov 2022 20:56:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235076AbiKRB41 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Nov 2022 20:56:27 -0500
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3413F748D8
        for <bpf@vger.kernel.org>; Thu, 17 Nov 2022 17:56:25 -0800 (PST)
Received: by mail-pj1-x1043.google.com with SMTP id o7so3258868pjj.1
        for <bpf@vger.kernel.org>; Thu, 17 Nov 2022 17:56:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xQWfEZnU96xkexiHPMecwLZhhJHKeuuTJzPTTJL5+18=;
        b=I8W9StaFTVstIe120gGSDsAQ6Y7cWe/VS+VL4Z5tADFZCKelWmVyOhhuVbYMv7tGR8
         2y7dKQim/z+9sg2kDDpEOx1raClkAY7u/g3yhTdKiausGo6uJTc+MG9Wz3uRSjdu9flG
         QNAlCsJre9iN9D0O7LVRiiLKD7B7nm8TgJk8z5cgy0oyXOvPatIh8P/KNTMGWwkhw511
         VyE4Feb7Wyixfqa8We/wOcmiKTyd0vBcyKPWekSMxL0lZ4cu+DAPLZL9BS9Blg/83Y/T
         hMqOnd/qPtO6jgdMEEbOxE0eYiwPu4vniWLG1nL4MADrMMge+2XBrHwBtFq8kSuZ3vk6
         HrSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xQWfEZnU96xkexiHPMecwLZhhJHKeuuTJzPTTJL5+18=;
        b=uEAukkxzuUsMyWFojNx2aTJ9Ss5ru67mcvplwVrKuT/lQBWR99J7XYH1WNQvVYkQ3R
         QuTARpZr8y/3b4fO9J/vEZIYw4GqARC+F00RVk/25SAg/TgEyCJ08tBjiugbAIfxICfZ
         sYVKIVHxPqp1ZZRGfxY/uWwu6gpE5F/gbgPim7t1RytgpdQXnRjy7qhk7AABCgdROdRG
         GDvhUAvSwjxU6k40Opplyd0N2A13GSldUFPQvlOaSeIbHjqDMuCm8Apz284tQDaxG+HG
         3uOD6ebAio2OFKM6JxHhDPi+bJtIJa5ZW8jW3Oswz+D1VuX6duVGUJUZWOW9uwCBAX3z
         pjAg==
X-Gm-Message-State: ANoB5pmouNC0Z3Bl4nY3cFcRKDYsxE/sxHkbrgpW4fbSC8rPRnouwn6H
        CLHy2YkxdSViMfDOgxJGnU+x7QJf/Kg=
X-Google-Smtp-Source: AA0mqf63YzCiiAD22TXJK8fTirEkKdxoutoF8mpysNak78U9G1Fzp5PaZu0C0ilLDOvw6fnXZeSorg==
X-Received: by 2002:a17:902:760f:b0:188:fcda:1141 with SMTP id k15-20020a170902760f00b00188fcda1141mr1378861pll.62.1668736584159;
        Thu, 17 Nov 2022 17:56:24 -0800 (PST)
Received: from localhost ([2409:40f4:8:955c:5484:8048:c08:7b3])
        by smtp.gmail.com with ESMTPSA id x9-20020aa79409000000b005623f96c24bsm1840349pfo.89.2022.11.17.17.56.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 17:56:23 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>
Subject: [PATCH bpf-next v10 02/24] bpf: Do btf_record_free outside map_free callback
Date:   Fri, 18 Nov 2022 07:25:52 +0530
Message-Id: <20221118015614.2013203-3-memxor@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221118015614.2013203-1-memxor@gmail.com>
References: <20221118015614.2013203-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4312; i=memxor@gmail.com; h=from:subject; bh=5PZ4QRQvYOcWzKDR5LxcVFsRltruQteYwu7du7JUqDk=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjduXOSvKXZ89jWdGw5U7Y5qB+JVaf8OZrycuT+vY5 wHUBAheJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY3blzgAKCRBM4MiGSL8RytowD/ 9vqia5GSOqaM95p4aPoXNYF0z0sArspw9afEuznvNxZwipwTfQ92B5C4r6PaVcy5E2Ev61I7Hj+zIs Wz0X5IK2ClNsWvRmxxCyySefg89e1TyYUjpu+29nXea7ReT8UqWWDK5k4bhsB4CzfF8/EvuZxqUSFm IpcaA0tKWCYrrqoY6CvHjtqnW94Gl4UWfZbWZNH79EHXTf44+GXq4RCoK/FFeyWoESZkcWjLwnBFTI QAjWxjXve0s4DiIchYFnSoOeDJDWPAvFB+jtgFzCJ2yRJCd55YIZRUhvA24W7RRPDQb4qUrMvmSHD/ CII6dujOXGvDGmpqb6v3HpgqYzFbT3nV/hihHO40QfBVr0xKtprPd5hdsam3dz0k42NhbJtXKnMAa7 U83FhcfWGm14AVN5YE+SnJgIyZCwM1KCdKekobxGWi6ahV8XjShVv+whdtxMO7KpBXUOU3qnfeEq45 XbC3+e2HHE7jzahE0Qzt1XGiPW2cQjoCtI6SWUvkDnpqQgfFAIKh2Fd4NQlLikTcyRll7F7TrhapYJ qKkV2Q0sYo96foMphcHxrSypp8NJCiNYftzSZg6wa6bziX/k7Wz1Gg3NxMr2o/QmR2sWF+c3Aa1/Pd IXDL/jzxobvY5Ml2zYqCVDTkpzUJPqXYxzYTIy52nPwF5od171wMGzh/g5SQ==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Since the commit being fixed, we now miss freeing btf_record for local
storage maps which will have a btf_record populated in case they have
bpf_spin_lock element.

This was missed because I made the choice of offloading the job to free
kptr_off_tab (now btf_record) to the map_free callback when adding
support for kptrs.

Revisiting the reason for this decision, there is the possibility that
the btf_record gets used inside map_free callback (e.g. in case of maps
embedding kptrs) to iterate over them and free them, hence doing it
before the map_free callback would be leaking special field memory, and
do invalid memory access. The btf_record keeps module references which
is critical to ensure the dtor call made for referenced kptr is safe to
do.

If doing it after map_free callback, the map area is already freed, so
we cannot access bpf_map structure anymore.

To fix this and prevent such lapses in future, move bpf_map_free_record
out of the map_free callback, and do it after map_free by remembering
the btf_record pointer. There is no need to access bpf_map structure in
that case, and we can avoid missing this case when support for new map
types is added for other special fields.

Since a btf_record and its btf_field_offs are used together, for
consistency delay freeing of field_offs as well. While not a problem
right now, a lot of code assumes that either both record and field_offs
are set or none at once.

Note that in case of map of maps (outer maps), inner_map_meta->record is
only used during verification, not to free fields in map value, hence we
simply keep the bpf_map_free_record call as is in bpf_map_meta_free and
never touch map->inner_map_meta in bpf_map_free_deferred.

Add a comment making note of these details.

Fixes: db559117828d ("bpf: Consolidate spin_lock, timer management into btf_record")
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/arraymap.c |  1 -
 kernel/bpf/hashtab.c  |  1 -
 kernel/bpf/syscall.c  | 18 ++++++++++++++----
 3 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
index 672eb17ac421..484706959556 100644
--- a/kernel/bpf/arraymap.c
+++ b/kernel/bpf/arraymap.c
@@ -430,7 +430,6 @@ static void array_map_free(struct bpf_map *map)
 			for (i = 0; i < array->map.max_entries; i++)
 				bpf_obj_free_fields(map->record, array_map_elem_ptr(array, i));
 		}
-		bpf_map_free_record(map);
 	}
 
 	if (array->map.map_type == BPF_MAP_TYPE_PERCPU_ARRAY)
diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 50d254cd0709..5aa2b5525f79 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -1511,7 +1511,6 @@ static void htab_map_free(struct bpf_map *map)
 		prealloc_destroy(htab);
 	}
 
-	bpf_map_free_record(map);
 	free_percpu(htab->extra_elems);
 	bpf_map_area_free(htab->buckets);
 	bpf_mem_alloc_destroy(&htab->pcpu_ma);
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 8eff51a63af6..4c20dcbc6526 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -659,14 +659,24 @@ void bpf_obj_free_fields(const struct btf_record *rec, void *obj)
 static void bpf_map_free_deferred(struct work_struct *work)
 {
 	struct bpf_map *map = container_of(work, struct bpf_map, work);
+	struct btf_field_offs *foffs = map->field_offs;
+	struct btf_record *rec = map->record;
 
 	security_bpf_map_free(map);
-	kfree(map->field_offs);
 	bpf_map_release_memcg(map);
-	/* implementation dependent freeing, map_free callback also does
-	 * bpf_map_free_record, if needed.
-	 */
+	/* implementation dependent freeing */
 	map->ops->map_free(map);
+	/* Delay freeing of field_offs and btf_record for maps, as map_free
+	 * callback usually needs access to them. It is better to do it here
+	 * than require each callback to do the free itself manually.
+	 *
+	 * Note that the btf_record stashed in map->inner_map_meta->record was
+	 * already freed using the map_free callback for map in map case which
+	 * eventually calls bpf_map_free_meta, since inner_map_meta is only a
+	 * template bpf_map struct used during verification.
+	 */
+	kfree(foffs);
+	btf_record_free(rec);
 }
 
 static void bpf_map_put_uref(struct bpf_map *map)
-- 
2.38.1

