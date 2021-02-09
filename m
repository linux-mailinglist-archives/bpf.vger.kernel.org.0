Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80C9C31582E
	for <lists+bpf@lfdr.de>; Tue,  9 Feb 2021 22:01:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233984AbhBIU4z (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Feb 2021 15:56:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233983AbhBIUq7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Feb 2021 15:46:59 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00E8EC061A32
        for <bpf@vger.kernel.org>; Tue,  9 Feb 2021 11:49:09 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id q20so12557515pfu.8
        for <bpf@vger.kernel.org>; Tue, 09 Feb 2021 11:49:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zkWaqcUrYtyYpGOIw2vG0Hnf7hqG1IVD40aD0CVo6cc=;
        b=fhqMkx3ta0c3o3lAA/C63FnOXhSTrT1hdhmkEXikeGDiwLDML2SFbvTamXmIUbN2ds
         jUmjYXmBtIyHCqgZp/TM5vokvg3qbKoVYn+L3aSJi5WblAo5Q7BFx7oPRuQw7vfABGiv
         tJUe8vEXxsilSTM+qndilMv7t4NkIur2E1wLNiJMsQk8J/LcUHz2BmuLxbkCYNOtgAEw
         JLJ0R1I8I/9ycUfAzmdWSTRgo5U+qWbqrp6nXzcg6AT94e1mdEhrv87Oyh7SecZWs4on
         ZCjb4e/L+RZRBneBLxgq0s0Tl/6CvCrK8IaijrlCO9FYwHOx7mrZxeCrZPrNke0BbyPm
         7Cqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zkWaqcUrYtyYpGOIw2vG0Hnf7hqG1IVD40aD0CVo6cc=;
        b=QqO5tz3mmTeFBjMlAw6+ApFbuf3bbfjyEtjaQtb7RrytaTJOeG/i42E4ihHU4fOYs2
         uHNDsN/8AqoqF6qfUW4P8r5hXjQ28MMJwfMSi0vSeq7CiUu4Bt+ff0YiD+mjBoHE+sig
         G3fZzta2MBsFC9YfalPNa/siqR0O1DCOncyTt/tGnB+a/jv5ygFrqbN4aZhTJFVMACmH
         Wm+dTpDjXdD2dnH6YuvzvQ3QueAwtgFoPxZKnJkJb81IBAgMYBGxedacg0bzkRO8Codu
         GsruCRoS3p96OxM4r44D63g30wf1g3maHTT0fD3f7WosfShiDpULwqWfyKKh/AyV0pQX
         TRog==
X-Gm-Message-State: AOAM531wgEcC6SmJigeI8INSNEiteIx2DlsjzXfAI4hCXf85pJ02jJwz
        wETuqRnNVU0Fl1GjShvEazZZmPAhwzo=
X-Google-Smtp-Source: ABdhPJyrmvr2zzBLygHLpvF5/IInTRzEIf/3gHNIzjYnCwOT26x43frWq/6tMOIBMtDpItKsGK4awA==
X-Received: by 2002:aa7:8815:0:b029:1bc:93cc:d6fa with SMTP id c21-20020aa788150000b02901bc93ccd6famr23974653pfo.26.1612900148601;
        Tue, 09 Feb 2021 11:49:08 -0800 (PST)
Received: from ast-mbp.thefacebook.com ([163.114.132.7])
        by smtp.gmail.com with ESMTPSA id j22sm139123pff.57.2021.02.09.11.49.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Feb 2021 11:49:08 -0800 (PST)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, bpf@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 bpf-next 7/8] bpf: Allows per-cpu maps and map-in-map in sleepable programs
Date:   Tue,  9 Feb 2021 11:48:55 -0800
Message-Id: <20210209194856.24269-8-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <20210209194856.24269-1-alexei.starovoitov@gmail.com>
References: <20210209194856.24269-1-alexei.starovoitov@gmail.com>
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

