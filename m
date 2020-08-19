Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E814424997B
	for <lists+bpf@lfdr.de>; Wed, 19 Aug 2020 11:38:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727772AbgHSJiQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 19 Aug 2020 05:38:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727112AbgHSJhx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 19 Aug 2020 05:37:53 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8004DC061348
        for <bpf@vger.kernel.org>; Wed, 19 Aug 2020 02:37:50 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id k20so1452388wmi.5
        for <bpf@vger.kernel.org>; Wed, 19 Aug 2020 02:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gkrehb+NY6EpSKSWw1O3tHpluUDTjNcCIKKF3vkOvVk=;
        b=S2mA7NIzqZi2WbjNSenaPFYnG7D8TnMSSBbnZwpsfy0dPWN2nmJ4rf0GcxhmwlInyF
         i+j8y/QAZ8poyhKF6kgfQFa9tfujr7DPl1twJCmzHkuNlmw9i0Kj5JR0j5nYGrZv1HEk
         ZtWInXBNLA7TyA/6YZWg+Cz+iwuP/8L1GmpwI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gkrehb+NY6EpSKSWw1O3tHpluUDTjNcCIKKF3vkOvVk=;
        b=AjshJfouv8C2EoaVwG7NXCDbyELWzTH7LuyPnjwLyjiYjRl6T6glZ/ekThsC3FuVpw
         DEmpITVMp7rLOSIB07+bau6J1gZjIoMo/QltVAmmsW9+yg76eleTcuHkEi8tt1cAbTEK
         hmXpZLa/LAjE2h/cYPyXhsmGVJj34SCQwsPDA+MKos7GJdR0RpVpLPZeKra9eDBVbSI5
         Sy6mrtJ8mtVEJIY8gCfNmmhRS4ixQOEdBCIjxizFS6iOCG5vWzN+w615YmhX3pOhsb89
         /40nSHiQHE1iMXzTCkCQYR0kIMOUnDxNe33hIatKVJIJH/TXRs9xXVwRax+AVloILpVi
         agBg==
X-Gm-Message-State: AOAM530Ff92Gle418Vm38vIHnamJQP+ZvljTLPcM4nXo22d5atxyTrsL
        AZciw3+dV8coBDa8IK8IGDlHJw==
X-Google-Smtp-Source: ABdhPJz2KAAKA5XiONSTOgNjMoq0Ddnp/ynNK45lDn4chmtOLuEPVbwthqYKle4pW6HCBNFADw1hBg==
X-Received: by 2002:a1c:24d5:: with SMTP id k204mr3914788wmk.159.1597829869028;
        Wed, 19 Aug 2020 02:37:49 -0700 (PDT)
Received: from antares.lan (c.d.0.4.4.2.3.3.e.9.1.6.6.d.0.6.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff:60d6:619e:3324:40dc])
        by smtp.gmail.com with ESMTPSA id 3sm4204565wms.36.2020.08.19.02.37.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2020 02:37:48 -0700 (PDT)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     jakub@cloudflare.com, john.fastabend@gmail.com,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Lorenz Bauer <lmb@cloudflare.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     kernel-team@cloudflare.com, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next 3/6] bpf: sockmap: call sock_map_update_elem directly
Date:   Wed, 19 Aug 2020 10:24:33 +0100
Message-Id: <20200819092436.58232-4-lmb@cloudflare.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200819092436.58232-1-lmb@cloudflare.com>
References: <20200819092436.58232-1-lmb@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Don't go via map->ops to call sock_map_update_elem, since we know
what function to call in bpf_map_update_value. Since
check_map_func_compatibility doesn't allow calling
BPF_FUNC_map_update_elem from BPF context, we can remove
ops->map_update_elem and rename the function to
sock_map_update_elem_sys.

Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
---
 include/linux/bpf.h  | 7 +++++++
 kernel/bpf/syscall.c | 5 +++--
 net/core/sock_map.c  | 6 ++----
 3 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index cef4ef0d2b4e..cf3416d1b8c2 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1635,6 +1635,7 @@ int sock_map_prog_update(struct bpf_map *map, struct bpf_prog *prog,
 			 struct bpf_prog *old, u32 which);
 int sock_map_get_from_fd(const union bpf_attr *attr, struct bpf_prog *prog);
 int sock_map_prog_detach(const union bpf_attr *attr, enum bpf_prog_type ptype);
+int sock_map_update_elem_sys(struct bpf_map *map, void *key, void *value, u64 flags);
 void sock_map_unhash(struct sock *sk);
 void sock_map_close(struct sock *sk, long timeout);
 #else
@@ -1656,6 +1657,12 @@ static inline int sock_map_prog_detach(const union bpf_attr *attr,
 {
 	return -EOPNOTSUPP;
 }
+
+static inline int sock_map_update_elem_sys(struct bpf_map *map, void *key, void *value,
+					   u64 flags)
+{
+	return -EOPNOTSUPP;
+}
 #endif /* CONFIG_BPF_STREAM_PARSER */
 
 #if defined(CONFIG_INET) && defined(CONFIG_BPF_SYSCALL)
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 2f343ce15747..5867cf615a3c 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -157,10 +157,11 @@ static int bpf_map_update_value(struct bpf_map *map, struct fd f, void *key,
 	if (bpf_map_is_dev_bound(map)) {
 		return bpf_map_offload_update_elem(map, key, value, flags);
 	} else if (map->map_type == BPF_MAP_TYPE_CPUMAP ||
-		   map->map_type == BPF_MAP_TYPE_SOCKHASH ||
-		   map->map_type == BPF_MAP_TYPE_SOCKMAP ||
 		   map->map_type == BPF_MAP_TYPE_STRUCT_OPS) {
 		return map->ops->map_update_elem(map, key, value, flags);
+	} else if (map->map_type == BPF_MAP_TYPE_SOCKHASH ||
+		   map->map_type == BPF_MAP_TYPE_SOCKMAP) {
+		return sock_map_update_elem_sys(map, key, value, flags);
 	} else if (IS_FD_PROG_ARRAY(map)) {
 		return bpf_fd_array_map_update_elem(map, f.file, key, value,
 						    flags);
diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index f464a0ebc871..018367fb889f 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -562,8 +562,8 @@ static bool sock_map_sk_state_allowed(const struct sock *sk)
 static int sock_hash_update_common(struct bpf_map *map, void *key,
 				   struct sock *sk, u64 flags);
 
-int sock_map_update_elem(struct bpf_map *map, void *key,
-			 void *value, u64 flags)
+int sock_map_update_elem_sys(struct bpf_map *map, void *key,
+			     void *value, u64 flags)
 {
 	struct socket *sock;
 	struct sock *sk;
@@ -687,7 +687,6 @@ const struct bpf_map_ops sock_map_ops = {
 	.map_free		= sock_map_free,
 	.map_get_next_key	= sock_map_get_next_key,
 	.map_lookup_elem_sys_only = sock_map_lookup_sys,
-	.map_update_elem	= sock_map_update_elem,
 	.map_delete_elem	= sock_map_delete_elem,
 	.map_lookup_elem	= sock_map_lookup,
 	.map_release_uref	= sock_map_release_progs,
@@ -1181,7 +1180,6 @@ const struct bpf_map_ops sock_hash_ops = {
 	.map_alloc		= sock_hash_alloc,
 	.map_free		= sock_hash_free,
 	.map_get_next_key	= sock_hash_get_next_key,
-	.map_update_elem	= sock_map_update_elem,
 	.map_delete_elem	= sock_hash_delete_elem,
 	.map_lookup_elem	= sock_hash_lookup,
 	.map_lookup_elem_sys_only = sock_hash_lookup_sys,
-- 
2.25.1

