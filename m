Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D243244EBE
	for <lists+bpf@lfdr.de>; Fri, 14 Aug 2020 21:16:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728057AbgHNTQF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 14 Aug 2020 15:16:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726652AbgHNTQE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 14 Aug 2020 15:16:04 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77419C061385
        for <bpf@vger.kernel.org>; Fri, 14 Aug 2020 12:16:04 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id c6so9319789ilo.13
        for <bpf@vger.kernel.org>; Fri, 14 Aug 2020 12:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2N+DvyNqII1FuugRHkcsgtDFKc9Q/C1D5vc41I6jfrY=;
        b=QQchmShjXxwh8dfu7se5ZZ4VzYcaCOWL5cGSO8y3tUQpwkEW0osxHPu13aODZMCfs/
         X0nJRqTaGYC0+dJhIMbV+Mg6WFF0ZkEVaF5p4zygw+fehOEb3Tndt+9YweduX/ISiG60
         d7c+vsboQBqxvzPi13dFdvgtM8zMs36UaBu+f6B7Q2pgaeJwnHmVbFa3I81GBNZdpihO
         cG+UwhoGoSoKx7Ubfdr+ZsMjEgK/SHA5BYXfffv0L+szIwaWRW5I0u8WZ+W0dIkpYJa5
         Rs1VPff6ALcFbhXFDD6ABsSMhErvGZyuizkhqmYabfcY/quHzTHJvPOxOmQkh9EPjfBr
         krhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2N+DvyNqII1FuugRHkcsgtDFKc9Q/C1D5vc41I6jfrY=;
        b=HaKXaFllSnAHz74XcujCLVtisLbjeQlDeLD7YTtVJ+6c/gE+vxYJrzh2FWPDwKdtjL
         8e4jsnH49eazvXualQij6RW+NGTHQ/xR1lhbDek04MW/Uzo93Pec0r2ver3MBqnR6ArK
         XlSc/wPZEe29P4aiFGamgJRiOYyEuxp7NQJIGj2m9XFj0ZZnI29OKrYxwQYeB6IF1ecU
         s5DFV5HNGqLrMRSy3IbqHqXbK4/H6uyGCHKVU1+G/wA6ibMHXyyy1qq1Q8+JTQqZv+8e
         zdqlRSOSDAnrI2lvBUXkFt9EC1SqlgDunF1s0+TxI34EbQjAHkhkJ72FtSVEteedGqnK
         aENQ==
X-Gm-Message-State: AOAM531QLdp9ODyoMePrgjHqmdlWL4/cxXlkLb6I7/sPd1vhTriGoBHB
        bAPbgkRV9vcbd4S4KLuSvmvIR5HojGg7Fw==
X-Google-Smtp-Source: ABdhPJyVYEJwF71HX5cWN/LjnieELwCcS+w/l0E9mMZeZI3q8UA37rhr6CMVN3N4+uQe1tNpyIG5ZA==
X-Received: by 2002:a92:7a0e:: with SMTP id v14mr3735901ilc.296.1597432563638;
        Fri, 14 Aug 2020 12:16:03 -0700 (PDT)
Received: from localhost.localdomain (host-173-230-99-219.tnkngak.clients.pavlovmedia.com. [173.230.99.219])
        by smtp.gmail.com with ESMTPSA id f15sm4521028ilc.51.2020.08.14.12.16.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2020 12:16:02 -0700 (PDT)
From:   YiFei Zhu <zhuyifei1999@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Stanislav Fomichev <sdf@google.com>,
        Mahesh Bandewar <maheshb@google.com>,
        YiFei Zhu <zhuyifei@google.com>
Subject: [RFC PATCH bpf-next 2/5] bpf: Add BPF_PROG_ADD_MAP syscall
Date:   Fri, 14 Aug 2020 14:15:55 -0500
Message-Id: <55a2aeb0c93dd281f24c5e20c6ba3796477234eb.1597427271.git.zhuyifei@google.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1597427271.git.zhuyifei@google.com>
References: <cover.1597427271.git.zhuyifei@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: YiFei Zhu <zhuyifei@google.com>

This syscall attaches a map to a program. -EEXIST if the map is
already attached to the program. call_rcu is used to free the
old used_maps struct after an RCU grace period.

Signed-off-by: YiFei Zhu <zhuyifei@google.com>
---
 include/uapi/linux/bpf.h       |  7 +++
 kernel/bpf/syscall.c           | 83 ++++++++++++++++++++++++++++++++++
 tools/include/uapi/linux/bpf.h |  7 +++
 3 files changed, 97 insertions(+)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index b134e679e9db..01b32036a0f5 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -118,6 +118,7 @@ enum bpf_cmd {
 	BPF_ENABLE_STATS,
 	BPF_ITER_CREATE,
 	BPF_LINK_DETACH,
+	BPF_PROG_ADD_MAP,
 };
 
 enum bpf_map_type {
@@ -648,6 +649,12 @@ union bpf_attr {
 		__u32		flags;
 	} iter_create;
 
+	struct { /* struct used by BPF_PROG_ADD_MAP command */
+		__u32		prog_fd;
+		__u32		map_fd;
+		__u32		flags;		/* extra flags */
+	} prog_add_map;
+
 } __attribute__((aligned(8)));
 
 /* The description below is an attempt at providing documentation to eBPF
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 3fde9dc4b595..0564a4291184 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -4144,6 +4144,86 @@ static int bpf_iter_create(union bpf_attr *attr)
 	return err;
 }
 
+#define BPF_PROG_ADD_MAP_LAST_FIELD prog_add_map.flags
+
+static void __bpf_free_used_maps_rcu(struct rcu_head *rcu)
+{
+	struct bpf_used_maps *used_maps = container_of(rcu, struct bpf_used_maps, rcu);
+
+	kfree(used_maps->arr);
+	kfree(used_maps);
+}
+
+static int bpf_prog_add_map(union bpf_attr *attr)
+{
+	struct bpf_prog *prog;
+	struct bpf_map *map;
+	struct bpf_used_maps *used_maps_old, *used_maps_new;
+	int i, ret = 0;
+
+	if (CHECK_ATTR(BPF_PROG_ADD_MAP))
+		return -EINVAL;
+
+	if (attr->prog_add_map.flags)
+		return -EINVAL;
+
+	prog = bpf_prog_get(attr->prog_add_map.prog_fd);
+	if (IS_ERR(prog))
+		return PTR_ERR(prog);
+
+	map = bpf_map_get(attr->prog_add_map.map_fd);
+	if (IS_ERR(map)) {
+		ret = PTR_ERR(map);
+		goto out_prog_put;
+	}
+
+	used_maps_new = kzalloc(sizeof(*used_maps_new), GFP_KERNEL);
+	if (!used_maps_new) {
+		ret = -ENOMEM;
+		goto out_map_put;
+	}
+
+	mutex_lock(&prog->aux->used_maps_mutex);
+
+	used_maps_old = rcu_dereference_protected(prog->aux->used_maps,
+				lockdep_is_held(&prog->aux->used_maps_mutex));
+
+	for (i = 0; i < used_maps_old->cnt; i++)
+		if (used_maps_old->arr[i] == map) {
+			ret = -EEXIST;
+			goto out_unlock;
+		}
+
+	used_maps_new->cnt = used_maps_old->cnt + 1;
+	used_maps_new->arr = kmalloc_array(used_maps_new->cnt,
+					   sizeof(used_maps_new->arr[0]),
+					   GFP_KERNEL);
+	if (!used_maps_new->arr) {
+		ret = -ENOMEM;
+		goto out_unlock;
+	}
+
+	memcpy(used_maps_new->arr, used_maps_old->arr,
+	       sizeof(used_maps_old->arr[0]) * used_maps_old->cnt);
+	used_maps_new->arr[used_maps_old->cnt] = map;
+
+	rcu_assign_pointer(prog->aux->used_maps, used_maps_new);
+	call_rcu(&used_maps_old->rcu, __bpf_free_used_maps_rcu);
+
+out_unlock:
+	mutex_unlock(&prog->aux->used_maps_mutex);
+
+	if (ret)
+		kfree(used_maps_new);
+
+out_map_put:
+	if (ret)
+		bpf_map_put(map);
+out_prog_put:
+	bpf_prog_put(prog);
+	return ret;
+}
+
 SYSCALL_DEFINE3(bpf, int, cmd, union bpf_attr __user *, uattr, unsigned int, size)
 {
 	union bpf_attr attr;
@@ -4277,6 +4357,9 @@ SYSCALL_DEFINE3(bpf, int, cmd, union bpf_attr __user *, uattr, unsigned int, siz
 	case BPF_LINK_DETACH:
 		err = link_detach(&attr);
 		break;
+	case BPF_PROG_ADD_MAP:
+		err = bpf_prog_add_map(&attr);
+		break;
 	default:
 		err = -EINVAL;
 		break;
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index b134e679e9db..01b32036a0f5 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -118,6 +118,7 @@ enum bpf_cmd {
 	BPF_ENABLE_STATS,
 	BPF_ITER_CREATE,
 	BPF_LINK_DETACH,
+	BPF_PROG_ADD_MAP,
 };
 
 enum bpf_map_type {
@@ -648,6 +649,12 @@ union bpf_attr {
 		__u32		flags;
 	} iter_create;
 
+	struct { /* struct used by BPF_PROG_ADD_MAP command */
+		__u32		prog_fd;
+		__u32		map_fd;
+		__u32		flags;		/* extra flags */
+	} prog_add_map;
+
 } __attribute__((aligned(8)));
 
 /* The description below is an attempt at providing documentation to eBPF
-- 
2.28.0

