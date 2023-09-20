Return-Path: <bpf+bounces-10464-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04D1D7A8925
	for <lists+bpf@lfdr.de>; Wed, 20 Sep 2023 18:01:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 154701C20A0F
	for <lists+bpf@lfdr.de>; Wed, 20 Sep 2023 16:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B45873D39C;
	Wed, 20 Sep 2023 16:00:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 088603C6B2
	for <bpf@vger.kernel.org>; Wed, 20 Sep 2023 16:00:27 +0000 (UTC)
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8FB0B9
	for <bpf@vger.kernel.org>; Wed, 20 Sep 2023 09:00:25 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-59c0b9ad491so56053567b3.1
        for <bpf@vger.kernel.org>; Wed, 20 Sep 2023 09:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695225624; x=1695830424; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y7/7aeCW2UddI0iHJjaBMHkrBaD02WgMDA4Zu10F0Ng=;
        b=bQZjlie4SbsKwslBISdFz9a79L0XS0UW14EXO/Hnr9sD9Vd/AlNhTskOKtFUbCnQn0
         s0gO0kVZd/LeJ0O2ABFkfS0z68son6bWYXURfEjnAlmfBgVnjBWuNFW3IVHNigDPAkFT
         IwGUUJKXh5uOEMEdEaOz8edFLjaLEWs2Izutt6R72JG9crFOYgtCGWWT3jIer3MJHwuV
         w++JKeIs1G/pvU9exagte1cj9xXLzy1/b+IS4Wg4h43J0nRc7cEMhIx7oxHERBKKpaV/
         V54F0c35hPR/zJyuVusLDfVCKAml+GzBJCNJE4jrXyThnaHwGTcy0sYXIAFlgG9w/LkT
         D4Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695225624; x=1695830424;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y7/7aeCW2UddI0iHJjaBMHkrBaD02WgMDA4Zu10F0Ng=;
        b=RGAt8zUy2y2JnH4TNJL9JgWkqr7HWpXyhcNN1xOhHbTcyDIgvB+jSGoXmRwbpukO6y
         2e+ruihoeNVocuff3vHLPmOYhp3VpJKDJRWMA6/mAq/hhSvmHOawdoPEHNkLlfiMaVNV
         EzGIisy4jeGKcpTKZx6DgWPw+0u3yklkQYrap57HLX64U8CT+v6zeUJQ4uAUhrQrWy8a
         Y5ukvoMCWaI8Z0UCYSriwDIXyuisYeARouTRzAhUXOB/lRebzAtDZy4kkskIWbKLr4ri
         rJfnaHqDTcAVRXns9FZ5lPGbbgaIMbkZhZ6fQfe50Qvm0rzkkdqav3oxjVKAO9rUQUzN
         eRNw==
X-Gm-Message-State: AOJu0YzTkJ2ncpb8l+730o4/+QWGkIIQB2AS8o1g8HeC9Z5Wp6NNYB2d
	HhBCoFhf7o7EizuU2JYBh4kmQyG8GZ0=
X-Google-Smtp-Source: AGHT+IGbwZcdcQ/kJ1ATcFza8q9PEVLlYEk0BrBj6CYCuyppWEqQ0KWjsSHtEPr/9PvVnrfQcRz7+A==
X-Received: by 2002:a81:4883:0:b0:59b:51b2:223d with SMTP id v125-20020a814883000000b0059b51b2223dmr2714159ywa.20.1695225624297;
        Wed, 20 Sep 2023 09:00:24 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:dcd2:9730:2c7c:239f])
        by smtp.gmail.com with ESMTPSA id m131-20020a817189000000b00589dbcf16cbsm3860490ywc.35.2023.09.20.09.00.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 09:00:22 -0700 (PDT)
From: thinker.li@gmail.com
To: bpf@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	kernel-team@meta.com,
	andrii@kernel.org
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>
Subject: [RFC bpf-next v3 05/11] bpf: hold module for bpf_struct_ops_map.
Date: Wed, 20 Sep 2023 08:59:17 -0700
Message-Id: <20230920155923.151136-6-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230920155923.151136-1-thinker.li@gmail.com>
References: <20230920155923.151136-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Kui-Feng Lee <thinker.li@gmail.com>

Ensure a module doesn't go away when a struct_ops object is still alive,
being a struct_ops type that is registered by the module.

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 include/linux/bpf.h         | 1 +
 kernel/bpf/bpf_struct_ops.c | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 0776cb584b3f..faaec20156f1 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1627,6 +1627,7 @@ struct bpf_struct_ops {
 	int (*update)(void *kdata, void *old_kdata);
 	int (*validate)(void *kdata);
 	const struct btf *btf;
+	struct module *owner;
 	const struct btf_type *type;
 	const struct btf_type *value_type;
 	const char *name;
diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index 7c2ef53687ef..ef8a1edec891 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -632,6 +632,8 @@ static void __bpf_struct_ops_map_free(struct bpf_map *map)
 
 static void bpf_struct_ops_map_free(struct bpf_map *map)
 {
+	struct bpf_struct_ops_map *st_map = (struct bpf_struct_ops_map *)map;
+
 	/* The struct_ops's function may switch to another struct_ops.
 	 *
 	 * For example, bpf_tcp_cc_x->init() may switch to
@@ -649,6 +651,7 @@ static void bpf_struct_ops_map_free(struct bpf_map *map)
 	 */
 	synchronize_rcu_mult(call_rcu, call_rcu_tasks);
 
+	module_put(st_map->st_ops->owner);
 	__bpf_struct_ops_map_free(map);
 }
 
@@ -673,6 +676,9 @@ static struct bpf_map *bpf_struct_ops_map_alloc(union bpf_attr *attr)
 	if (!st_ops)
 		return ERR_PTR(-ENOTSUPP);
 
+	if (!try_module_get(st_ops->owner))
+		return ERR_PTR(-EINVAL);
+
 	vt = st_ops->value_type;
 	if (attr->value_size != vt->size)
 		return ERR_PTR(-EINVAL);
-- 
2.34.1


