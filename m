Return-Path: <bpf+bounces-7598-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2C6377960A
	for <lists+bpf@lfdr.de>; Fri, 11 Aug 2023 19:25:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A275828243F
	for <lists+bpf@lfdr.de>; Fri, 11 Aug 2023 17:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FBC1219D7;
	Fri, 11 Aug 2023 17:25:47 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A5871172E
	for <bpf@vger.kernel.org>; Fri, 11 Aug 2023 17:25:46 +0000 (UTC)
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4514A30CB;
	Fri, 11 Aug 2023 10:25:45 -0700 (PDT)
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-bc379e4c1cbso2081687276.2;
        Fri, 11 Aug 2023 10:25:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691774744; x=1692379544;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jGoJuAaL7UedDzvJJkHogM35NrJIaiMLcIhsmtcuEcI=;
        b=Pb5SCI1zVXIof06x0ZLuTr5oDuSLIHSHZ51Y0B70UVhDi/7rd+zck9wcI2kg7q7JwR
         QhVkhLT2neT/J7n//1yyS4U+1llyJ/oNPWiZDVWOZ5DaOVFcYOjcBH4+Zo56RZLUaVa1
         iL2wvZh/gVXbrRLhKGHzZM7zt54wpkAiCyEEpdYN/mjTPOE3r/nlFm5zcuNRnmdQP+uR
         knm4U45WybbpJyJUsGIppV1Zk5xODgNbyPhrcDO61mmYCc/E8AN/wALe58awPot8Wh/x
         EXQsw9/TorBLyLTyK1iC9Z2n9E83f0RBAKIEVx1tZbJPusTw9DeEG3ryJqFvCHkd4uie
         zo2A==
X-Gm-Message-State: AOJu0YxPc6u6TIWBtqJdWY3jAcV31d2ldyfQeBycJLtldmxvwYZdGsb0
	FYZOYYTN4itv+AukM1lUWbY9qnnj6MiNrhJD
X-Google-Smtp-Source: AGHT+IESHCldMhz2zO7cLkf4tUyRGKg/MK0ARvlUjbho5c24JvyLyEsyeDF20WThnlQD9RRG60Cs7g==
X-Received: by 2002:a25:b19c:0:b0:d53:f88a:dc09 with SMTP id h28-20020a25b19c000000b00d53f88adc09mr3003890ybj.2.1691774744160;
        Fri, 11 Aug 2023 10:25:44 -0700 (PDT)
Received: from localhost ([24.1.27.177])
        by smtp.gmail.com with ESMTPSA id g9-20020a256b09000000b00cf79d3a503fsm981762ybc.42.2023.08.11.10.25.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 10:25:43 -0700 (PDT)
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
	thinker.li@gmail.com
Subject: [PATCH bpf-next v2] bpf: Support default .validate() and .update() behavior for struct_ops links
Date: Fri, 11 Aug 2023 12:25:41 -0500
Message-ID: <20230811172541.618284-1-void@manifault.com>
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
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
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


