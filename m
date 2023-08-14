Return-Path: <bpf+bounces-7767-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B002677C030
	for <lists+bpf@lfdr.de>; Mon, 14 Aug 2023 21:00:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EB3C280D7E
	for <lists+bpf@lfdr.de>; Mon, 14 Aug 2023 19:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A374CA74;
	Mon, 14 Aug 2023 18:59:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728AACA6A;
	Mon, 14 Aug 2023 18:59:23 +0000 (UTC)
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8519310F2;
	Mon, 14 Aug 2023 11:59:22 -0700 (PDT)
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-40ff796e8ddso36052591cf.2;
        Mon, 14 Aug 2023 11:59:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692039561; x=1692644361;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tFsZYglbIoheMRdnUX+qlZ0MFAe72xqHNVYG2PQUmMI=;
        b=kmlHjjL+NrrCbl48hiCNs3SFWVjWqyUuvQkwkx1W/MxM3BEZAKa9YbJ0iYtQPvLROd
         EGfrWtvrzW0pm/jHPdzz8gG+wvP1yIYkS4peLkZ59KzTivbrq64Fwy3FJU9v08aSshGv
         2wLfQX9PLHB3k0nzqpc4Z0gfJIiDH4BaZ6bsCvwapwbjm7DIm/j2gpDJPg7pfXGc+mcK
         NQ60ygvhc30WCWPyACc1rXqf9V71GEbJHsPmvIZyWkcTQmaj+2MTzaI7BFXHAeVAitCO
         SJGua1QlD117IvMzBMK7P6lkSORoSdYxMCLNE1BMS8oWjPh95Zexwiw130Ek6RvsGB3T
         dWMA==
X-Gm-Message-State: AOJu0YxCkalGLFLit1P3zgmdHHDazMPxPyXeDgzgFSemZ62FcK3YdIBJ
	MJXCxdf4D2fWi/QkBm++7s2aDRXUxvUBuBa9
X-Google-Smtp-Source: AGHT+IFrP3BKp7vJH8r6t9jh/zesUXJcFDd7e6j/KQDpSz31cru/oAx9m+dOyy1rkEiPQvfFCgdsHQ==
X-Received: by 2002:ac8:5b91:0:b0:40f:bc9a:3262 with SMTP id a17-20020ac85b91000000b0040fbc9a3262mr13578948qta.21.1692039561291;
        Mon, 14 Aug 2023 11:59:21 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:93a1])
        by smtp.gmail.com with ESMTPSA id m19-20020ac86893000000b00403cce833eesm3288487qtq.27.2023.08.14.11.59.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 11:59:20 -0700 (PDT)
From: David Vernet <void@manifault.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	tj@kernel.org,
	clm@meta.com,
	thinker.li@gmail.com,
	netdev@vger.kernel.org
Subject: [PATCH bpf-next v3 1/2] bpf: Support default .validate() and .update() behavior for struct_ops links
Date: Mon, 14 Aug 2023 13:59:07 -0500
Message-ID: <20230814185908.700553-2-void@manifault.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230814185908.700553-1-void@manifault.com>
References: <20230814185908.700553-1-void@manifault.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
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

Acked-by: Kui-Feng Lee <thinker.li@gmail.com>
Signed-off-by: David Vernet <void@manifault.com>
---
 kernel/bpf/bpf_struct_ops.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index eaff04eefb31..fdc3e8705a3c 100644
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
@@ -823,6 +823,9 @@ static int bpf_struct_ops_map_link_update(struct bpf_link *link, struct bpf_map
 	if (!bpf_struct_ops_valid_to_reg(new_map))
 		return -EINVAL;
 
+	if (!st_map->st_ops->update)
+		return -EOPNOTSUPP;
+
 	mutex_lock(&update_mutex);
 
 	old_map = rcu_dereference_protected(st_link->map, lockdep_is_held(&update_mutex));
-- 
2.41.0


