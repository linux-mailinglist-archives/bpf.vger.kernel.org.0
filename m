Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C23462E19D
	for <lists+bpf@lfdr.de>; Thu, 17 Nov 2022 17:26:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240392AbiKQQ0d (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Nov 2022 11:26:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240409AbiKQQ0R (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Nov 2022 11:26:17 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CE487FF2B
        for <bpf@vger.kernel.org>; Thu, 17 Nov 2022 08:24:48 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id 62so2369227pgb.13
        for <bpf@vger.kernel.org>; Thu, 17 Nov 2022 08:24:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0LB9qhJTd7oVL3uqsvJLuNvLsH7Z0bs7/d2iO6QOalE=;
        b=B3QX++703HwRKTH2dcqhIBJFfdLs3Mvq5gPOvRQnhpE9G2vCTRFRX8OvlIzbEOOsBA
         NHGMPMi4OYSOBUro1mmg2HypuDHyhLBHkJwjmT2JPGlM23eNXHPfgMJ83cfRrmwLiZnZ
         eAxtAX56/innZKp4mPwtG7CCCHunwtVaT4yICzKn1q6KZBTQWTaK5o88fGt0I0Z7OWTO
         KpQwrdldE0b3gWy760FtmPDOpcqKKqGcq3p/6DcQy6iR+2P7ANdNMryDAXISv7h4zRPb
         4W4/XVU+ZA/BoVLlArvBhPcslWYytOc24AxKThjES4ZWX4kFPnQv7wwUoHsLgMGlmIal
         9jiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0LB9qhJTd7oVL3uqsvJLuNvLsH7Z0bs7/d2iO6QOalE=;
        b=tH71Jk0EJkBtbYczoWpW4a3OJhEG000dDwQ+kuN8pV5AfyJEFwx/ua77KMWp4g75gu
         2G7x2Ymw2Q3rxYi6txwLllRzynx7EyQ65fxf7qx9EuWZOfnCVRrPr0xow50a5xn8Srkz
         +a8rK2Ek4bzaxKVpnAqMDZ8SA2MoKqnA6+qeUgmyAFiWxWwaVUGY6xQkd+z8u07vdHVS
         yfuxmU71Od5G8rYwT09jAs3AsJKuCeAA+QR5GtjWWg4PYomRPbDjvLCetYqNRNR4M2+z
         O8o+d1or9AETMbIXsYnydxglxkdl9n2UsxsYAMoK4xmeEH29fpo6t6N6lHDwebTglLIL
         uW6w==
X-Gm-Message-State: ANoB5pkXocIOXwLzHMLSJSRsk/c1DTm3xLXTBn6hWG3XtW4C4y5l8NsF
        HDjeXE+US5PwiNB6L8fYd5U1UanI6GQ=
X-Google-Smtp-Source: AA0mqf6fZBQ/OOsT3WPM9X+bVGTVsjrAy0ZLx4O7m2NtrJM/+Psl50Zr+av0yrqMUTt760By9Y4A9g==
X-Received: by 2002:a63:a516:0:b0:45f:bf96:771c with SMTP id n22-20020a63a516000000b0045fbf96771cmr2775320pgf.131.1668702287806;
        Thu, 17 Nov 2022 08:24:47 -0800 (PST)
Received: from localhost ([103.4.221.252])
        by smtp.gmail.com with ESMTPSA id y65-20020a626444000000b005627868e27esm1333853pfb.127.2022.11.17.08.24.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 08:24:47 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>
Subject: [PATCH bpf-next v8 02/22] bpf: Do btf_record_free outside map_free callback
Date:   Thu, 17 Nov 2022 21:54:10 +0530
Message-Id: <20221117162430.1213770-3-memxor@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221117162430.1213770-1-memxor@gmail.com>
References: <20221117162430.1213770-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3893; i=memxor@gmail.com; h=from:subject; bh=GGK3XlnC6SdTUhmrTjYYXPKQ7WaZ5TiHqcf8QM1M4bQ=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjdl7+2Rw03T0emeTlv8e6UDcMsT7XnSv1FvkyfUVr pYHaNMiJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY3Ze/gAKCRBM4MiGSL8RyvCiEA Cnq9h9t6iyRLm1f1pyGehsF1ZqQKB9BH+Qy/JDdoYDeC4S1DbSJEuN/wNbGc9GjLwxsbZCTORazXPx WsmpUhs+Jp0OO+erMflViEB/DrHR+WOzY+vQO18U8BsBLHzC9a2STtOdlx5oey/D9vigKAE503HYx1 1qd1HFrhA8sln5kER42ORjd7dArnetT9fPyv2HUh5e/BpUaSTB/z+WQv7tIM6IcMIN9pqZ43jN0j8H x1jrEXyHoiO+O+E9Zh1awF5VJ+x5FYwSuTvyLi/X0FJ7vzVIIT/FEIy8cEEOWihYRwfToJu85oeTKH 568YGelwbuycWnACmSaC4IP0/EXgE9z+j24A4/Qxh47pPWgF8w/ApHfT3oBMIJNwIgEhNT1d8Cu/xV 067kbTH/ugf9xOzdqYXMBFCE4gAOKNSy+SnHuQ3pSkJDW7ia/gaPMwfd99EqaGtbY8wMFLcHnrsYS+ MHZU4Umc+fvmYQJvYQ1RYhfUzsl24bW0n0yYsfpKwi66xJXz4QL6csJQD8NWIJTsYdPTFU9bFQKADa Y/qm/rLpUSQPMn8GhroAwTdMQA0kqpghOR3WJsVoTtUmiRPMO40irRxDhzW21csgsmgljOASpyQx5R /AO/BRXCwrgOY2OODYxVHtwmmpRTWYCHlrEK3NdYYJXAgqoLzW+2Z7EIPpJQ==
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

Fixes: db559117828d ("bpf: Consolidate spin_lock, timer management into btf_record")
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/arraymap.c   | 1 -
 kernel/bpf/hashtab.c    | 1 -
 kernel/bpf/map_in_map.c | 1 -
 kernel/bpf/syscall.c    | 9 +++++----
 4 files changed, 5 insertions(+), 7 deletions(-)

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
diff --git a/kernel/bpf/map_in_map.c b/kernel/bpf/map_in_map.c
index 8ca0cca39d49..4caf03eb51ab 100644
--- a/kernel/bpf/map_in_map.c
+++ b/kernel/bpf/map_in_map.c
@@ -78,7 +78,6 @@ struct bpf_map *bpf_map_meta_alloc(int inner_map_ufd)
 
 void bpf_map_meta_free(struct bpf_map *map_meta)
 {
-	bpf_map_free_record(map_meta);
 	btf_put(map_meta->btf);
 	kfree(map_meta);
 }
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 0b48e2b13021..0621d2f4e38a 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -659,14 +659,15 @@ void bpf_obj_free_fields(const struct btf_record *rec, void *obj)
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
+	kfree(foffs);
+	btf_record_free(rec);
 }
 
 static void bpf_map_put_uref(struct bpf_map *map)
-- 
2.38.1

