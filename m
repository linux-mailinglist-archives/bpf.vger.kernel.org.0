Return-Path: <bpf+bounces-7500-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FF4377836D
	for <lists+bpf@lfdr.de>; Fri, 11 Aug 2023 00:05:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6C94281EAD
	for <lists+bpf@lfdr.de>; Thu, 10 Aug 2023 22:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B5C225145;
	Thu, 10 Aug 2023 22:05:11 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B9922F02
	for <bpf@vger.kernel.org>; Thu, 10 Aug 2023 22:05:10 +0000 (UTC)
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E31042123;
	Thu, 10 Aug 2023 15:05:09 -0700 (PDT)
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-76c8dd2ce79so114764085a.1;
        Thu, 10 Aug 2023 15:05:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691705109; x=1692309909;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aFjkqjJ2FVdTFKrxffUkW0MiERwjfIJkGtRrXjfMlRg=;
        b=PpDBuX4+CX94MTfOiRJWRTmaXzOk+GhkXHfml+DYm8XeqXzAmmfiu+h94J7biYGlDv
         7hPgEfbzrt2GulnkvAvcielkOYhkcJbqO8xKQxZcgly9kObQ91rT8Ez7ujdtrSOpStfm
         ssIVldsjhwvS+VaRHoLaGF/a5ZuERE6jkagOzaTXNp9eqTywyxI+L5wdPMxm8ki7spct
         HaYoTYxFYy5O5N21EQK1HxTYMJxYyNFpI31vJ1rOVmSxAB4hzUfj+GIbNilem+BkCt7r
         e1K7nRLsPfz3ApiXDwp5wxRvMyax6kR5UOuOY3XGZQKEDoRVkw8bdlMYW57c7cvhagcr
         CE0A==
X-Gm-Message-State: AOJu0YwO0JZU2iX4B6ACNI+tvvYWrt8fcGWuV+hpvs24NZSRgY3sCFDZ
	j7Au+shc5CdBq6s6r3uNw2uu03AfABPoxUEr
X-Google-Smtp-Source: AGHT+IENK/+KAi6n28GpOvj2pkywcPRdPdwKuCuLe6XXOVQRvanxlY5xzTWyNV4xam9K+joUt0N98g==
X-Received: by 2002:a05:620a:25cf:b0:76c:9427:5c54 with SMTP id y15-20020a05620a25cf00b0076c94275c54mr109875qko.27.1691705108724;
        Thu, 10 Aug 2023 15:05:08 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:d81f])
        by smtp.gmail.com with ESMTPSA id x8-20020ae9f808000000b0076cdc3b5beasm782788qkh.86.2023.08.10.15.05.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 15:05:08 -0700 (PDT)
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
	tj@kernel.org,
	clm@meta.com,
	thinker.li@gmail.com
Subject: [PATCH bpf-next] bpf: Support default .validate() and .update() behavior for struct_ops links
Date: Thu, 10 Aug 2023 17:04:56 -0500
Message-ID: <20230810220456.521517-1-void@manifault.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Currently, if a struct_ops map is loaded with BPF_F_LINK, it must also
define the .validate() and .update() callbacks in its corresponding
struct bpf_struct_ops in the kernel. Enabling struct_ops link is useful
in its own right to ensure that the map is unloaded if an application
crashes. For example, with sched_ext, we want to automatically unload
the host-wide scheduler if the application crashes. We would likely
never support updating elements of a sched_ext struct_ops map, so we'd
have to implement these callbacks showing that they _can't_ support
element updates just to benefit from the basic lifetime management of
struct_ops links.

Let's enable struct_ops maps to work with BPF_F_LINK even if they
haven't defined these callbacks, by assuming that a struct_ops map
element cannot be updated by default.

Signed-off-by: David Vernet <void@manifault.com>
---
 kernel/bpf/bpf_struct_ops.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index eaff04eefb31..3d2fb85186a9 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -509,9 +509,12 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
 	}
 
 	if (st_map->map.map_flags & BPF_F_LINK) {
-		err = st_ops->validate(kdata);
-		if (err)
-			goto reset_unlock;
+		err = 0;
+		if (st_ops->validate) {
+			err = st_ops->validate(kdata);
+			if (err)
+				goto reset_unlock;
+		}
 		set_memory_rox((long)st_map->image, 1);
 		/* Let bpf_link handle registration & unregistration.
 		 *
@@ -663,9 +666,6 @@ static struct bpf_map *bpf_struct_ops_map_alloc(union bpf_attr *attr)
 	if (attr->value_size != vt->size)
 		return ERR_PTR(-EINVAL);
 
-	if (attr->map_flags & BPF_F_LINK && (!st_ops->validate || !st_ops->update))
-		return ERR_PTR(-EOPNOTSUPP);
-
 	t = st_ops->type;
 
 	st_map_size = sizeof(*st_map) +
@@ -838,6 +838,11 @@ static int bpf_struct_ops_map_link_update(struct bpf_link *link, struct bpf_map
 		goto err_out;
 	}
 
+	if (!st_map->st_ops->update) {
+		err = -EOPNOTSUPP;
+		goto err_out;
+	}
+
 	err = st_map->st_ops->update(st_map->kvalue.data, old_st_map->kvalue.data);
 	if (err)
 		goto err_out;
-- 
2.41.0


