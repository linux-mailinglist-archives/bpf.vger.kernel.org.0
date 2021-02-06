Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BFDF311F02
	for <lists+bpf@lfdr.de>; Sat,  6 Feb 2021 18:05:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbhBFRFL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 6 Feb 2021 12:05:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbhBFRFI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 6 Feb 2021 12:05:08 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84BDEC06178C
        for <bpf@vger.kernel.org>; Sat,  6 Feb 2021 09:03:55 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id u15so5193090plf.1
        for <bpf@vger.kernel.org>; Sat, 06 Feb 2021 09:03:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=p5OjMVcmFAQK4VRhF/dmgTvepnxhG787NrU5e2J2yVs=;
        b=efsLnt8lD1w6qCy+5DZ/h4c/oD6H7OLU27HzCp98Q54M0xKSu6US3jhYjxZgR7Rt4d
         zTAsCPB/Juaxdhgw1MYwhtHbr5VgBrEpOv31D8WW3KNobKtsVL4BcxiYiS8QkJuuZ+YA
         1Uux2nCKrtSCN3BZBTCg2KA0ZfQn2cbk9rNUSyso+okm/lIRHhFpaKvH7pWgJDTbfjwX
         d/g1sTtWFRcwQK47hZ/W+pNL2TI/8L6nQ6kX9nXNZ3wuunZof9W0atspUyFLkU4Qoipw
         n+nAnGS36M+b8PpqRPVUuoe62yWy5k45wW/hfyku1LVm+/V3Y7xeVOA2PYLalo1mSxCT
         O4ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=p5OjMVcmFAQK4VRhF/dmgTvepnxhG787NrU5e2J2yVs=;
        b=QvXzfM+ku0Sq7ORLGPHKv8fBOSvgzHsdqpMePa7ghyqdjhBS05aPz0qQf/ui0trY/Z
         1BNAjXvOMt14tfYxtLEolrVyGLwjtfX0dk9IQV3fLTETLdpnMG+91XvKfLqRGsGn4wr+
         EPIgqL39FgiRTQ4BNm0ywHWz2OygfGjo7dnb4h7vDUkJUg+BL0Wnai5t7dR3/CykXIR4
         CVstdXAZ33PPteDdC3j1EqMomqgFSXmRnlK8v/SWA4bL4h9B52wcAIy7VKI+a4ao+syX
         zt4W9jbFlf7pXQx54ZueIaIMaWUrRPcM6zlR+IjKwXq8EPCQsnigau17ESIH91JfiTce
         fCHg==
X-Gm-Message-State: AOAM531wV4CPBRUkFNH6IePSgjx7WCFkuI3nH3fBoU5EfBPjkYuNCDDg
        dkfHH59Kd08XhQU21vpMZI0E4jB1Iuc=
X-Google-Smtp-Source: ABdhPJyAzSC7qBLauVhpda92A+jY4ps8yssFJNR/2iOeyAwc6pRwAOUz8XdPXm9nGTcWFgIe0QMLFA==
X-Received: by 2002:a17:902:d4c7:b029:e2:b2cb:136a with SMTP id o7-20020a170902d4c7b02900e2b2cb136amr7505775plg.53.1612631035084;
        Sat, 06 Feb 2021 09:03:55 -0800 (PST)
Received: from ast-mbp.thefacebook.com ([163.114.132.7])
        by smtp.gmail.com with ESMTPSA id j14sm11149964pjl.35.2021.02.06.09.03.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 Feb 2021 09:03:54 -0800 (PST)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, bpf@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 bpf-next 6/7] bpf: Allows per-cpu maps and map-in-map in sleepable programs
Date:   Sat,  6 Feb 2021 09:03:43 -0800
Message-Id: <20210206170344.78399-7-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <20210206170344.78399-1-alexei.starovoitov@gmail.com>
References: <20210206170344.78399-1-alexei.starovoitov@gmail.com>
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

