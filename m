Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC964315DD9
	for <lists+bpf@lfdr.de>; Wed, 10 Feb 2021 04:38:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbhBJDiA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Feb 2021 22:38:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbhBJDh7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Feb 2021 22:37:59 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D46B6C06178C
        for <bpf@vger.kernel.org>; Tue,  9 Feb 2021 19:36:48 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id m2so341410pgq.5
        for <bpf@vger.kernel.org>; Tue, 09 Feb 2021 19:36:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=flxXAiAxW4pgrrJIUJj/B3flDOSlOcbNsPL/TPSLgzA=;
        b=Q7qEhRffRoz1A5weJUi19Cp+BId61Y6b93uY96XbtVtHJ2oSiJU80Sdzn8AF6tm4R5
         kAVdDoqJnlyZyxQalf+AYdbdevOFtjSFbvfhSwIGNmU6qpmuJ8vYLcEQxjREIlKOz4SD
         SdRpQoc1mkTLLI2ggJuL0IesWVmMLCyiLTofwI3AL0NUd/LjjZxOWzlhG5gEx8ttdcH9
         fz/09jHg1XTigwEzMiMTVqn+Ku5m77ytGnQwjnV82XP71Dg03AdmFUpefhMFvY2syLWr
         rUSaTnFTWNSclE+bGwF8vs6MnbPmH9ye6Fle/0VAm6tXrm0/3Bq9Gr/jtcKJNTrMBNBq
         nx9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=flxXAiAxW4pgrrJIUJj/B3flDOSlOcbNsPL/TPSLgzA=;
        b=fVOGpVszbbO+wW/d7xbs+dYOUCjWUrWgEePxWLdb3pYbToiOpIv4omlyK2S2lLgnae
         0H/rmhZkxdxhSMM4XaC0dcQZfu02xhlupvByvl9et8CqW1zVRDpQzoZlqDMMjcxFmVyJ
         EsHWYmMSUU+P7AJree2lYRzmkajoPeEDxHf8ZwNIEBOlIgezqW9Ws1zXh3p5qPimZjBs
         EsG+6dsCirku6bwrAyAEyzdnEUuKH1FBh4RC1dZ1YlnUZQnFHTa6lcRhyGmeP7etQJqQ
         xChXcw6FPglg4op2EI/P6i141XRoY/RHylLwNAJ7kyVImI5oW3gWIQJcaSmoHhcdECBL
         Pr/A==
X-Gm-Message-State: AOAM531o50Wr3laDOlyHN1C1DILZwzHB5qjbmKxNo8RGG8hPrmA8Hr8R
        a0nX1e9hvI473CD0WMZ2LB8=
X-Google-Smtp-Source: ABdhPJzbrt4ASzg5BqiRU/ACRAIqFQ02QTvChqVHjJm37XDK/t2uqRokgBkoOZbR3QlZOTANeTAgqQ==
X-Received: by 2002:a05:6a00:847:b029:1b3:b9c3:11fb with SMTP id q7-20020a056a000847b02901b3b9c311fbmr1321941pfk.44.1612928208331;
        Tue, 09 Feb 2021 19:36:48 -0800 (PST)
Received: from ast-mbp.thefacebook.com ([163.114.132.7])
        by smtp.gmail.com with ESMTPSA id f7sm391099pjh.45.2021.02.09.19.36.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Feb 2021 19:36:47 -0800 (PST)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, bpf@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v4 bpf-next 8/9] bpf: Allows per-cpu maps and map-in-map in sleepable programs
Date:   Tue,  9 Feb 2021 19:36:33 -0800
Message-Id: <20210210033634.62081-9-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <20210210033634.62081-1-alexei.starovoitov@gmail.com>
References: <20210210033634.62081-1-alexei.starovoitov@gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Alexei Starovoitov <ast@kernel.org>

Since sleepable programs are now executing under migrate_disable
the per-cpu maps are safe to use.
The map-in-map were ok to use in sleepable from the time sleepable
progs were introduced.

Note that non-preallocated maps are still not safe, since there is
no rcu_read_lock yet in sleepable programs and dynamically allocated
map elements are relying on rcu protection. The sleepable programs
have rcu_read_lock_trace instead. That limitation will be addresses
in the future.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Acked-by: KP Singh <kpsingh@kernel.org>
---
 kernel/bpf/hashtab.c  | 4 ++--
 kernel/bpf/verifier.c | 7 ++++++-
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index c1ac7f964bc9..d63912e73ad9 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -1148,7 +1148,7 @@ static int __htab_percpu_map_update_elem(struct bpf_map *map, void *key,
 		/* unknown flags */
 		return -EINVAL;
 
-	WARN_ON_ONCE(!rcu_read_lock_held());
+	WARN_ON_ONCE(!rcu_read_lock_held() && !rcu_read_lock_trace_held());
 
 	key_size = map->key_size;
 
@@ -1202,7 +1202,7 @@ static int __htab_lru_percpu_map_update_elem(struct bpf_map *map, void *key,
 		/* unknown flags */
 		return -EINVAL;
 
-	WARN_ON_ONCE(!rcu_read_lock_held());
+	WARN_ON_ONCE(!rcu_read_lock_held() && !rcu_read_lock_trace_held());
 
 	key_size = map->key_size;
 
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 4189edb41b73..9561f2af7710 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -10020,9 +10020,14 @@ static int check_map_prog_compatibility(struct bpf_verifier_env *env,
 		case BPF_MAP_TYPE_HASH:
 		case BPF_MAP_TYPE_LRU_HASH:
 		case BPF_MAP_TYPE_ARRAY:
+		case BPF_MAP_TYPE_PERCPU_HASH:
+		case BPF_MAP_TYPE_PERCPU_ARRAY:
+		case BPF_MAP_TYPE_LRU_PERCPU_HASH:
+		case BPF_MAP_TYPE_ARRAY_OF_MAPS:
+		case BPF_MAP_TYPE_HASH_OF_MAPS:
 			if (!is_preallocated_map(map)) {
 				verbose(env,
-					"Sleepable programs can only use preallocated hash maps\n");
+					"Sleepable programs can only use preallocated maps\n");
 				return -EINVAL;
 			}
 			break;
-- 
2.24.1

