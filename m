Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ED7426950D
	for <lists+bpf@lfdr.de>; Mon, 14 Sep 2020 20:39:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725984AbgINSjV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 14 Sep 2020 14:39:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbgINSgV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 14 Sep 2020 14:36:21 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA1F1C06174A
        for <bpf@vger.kernel.org>; Mon, 14 Sep 2020 11:36:21 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id b127so610296ybh.21
        for <bpf@vger.kernel.org>; Mon, 14 Sep 2020 11:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=2zAlitpz1bSHaXpmOBe1sEwQjxsIHDKKWn1soexKc5A=;
        b=NWFg5GIQ7/lCJ8rJPXclzGK9Ioj0v57JBpc6Mgf6Do87IAfWr7CkaiOjHcPcasb6Jt
         7/uDFPZ4J8C6Ot5NvFlwvuAOBycoNst4FL7JFGQTSCaH6YUfp0pvEfQ2+TWldYNGjFXv
         HyUzDHqtorf6M+XBG1+m+0zkGfZCOSImmfHEyUYEJCA78lKWwd3/sHDiTWN/Z+C4QYpn
         vwdfrgL/+fy3CcAxOF3xxWnDCgXW/cYLwL9lFJExwoOz1b40wpv+IWS8lB5JKfuRykqU
         kIBxrjLJK62Cw0uJ/TJ1o4fTpgL1kbF99LIz/cM+wBqnlSdwsRh4HMFYrYwY44SU5ZEI
         mGrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=2zAlitpz1bSHaXpmOBe1sEwQjxsIHDKKWn1soexKc5A=;
        b=t5prWbTqPA2uyHymE9s3JpzBF2+OtCBDTsp1zDZldOhgGIj/3AkdjMnPnNitXxXZc7
         Kyg9eO8R20dZ+DPAZ1wgi71tUiVONG0qfWGJIvaJzrgvo1QnxppuoaBUu8X3jXLglj9E
         q5HlYxqZJ84y/TcM47dvRLywVlSrSPVWKJo4k5Y1rfLs0OfZNzEFIJOP9HEEJW+jqOW9
         e1/xVWhfmmXdDrE9BET++TIcBUelHGkaNrAknkV23R29TN8mmMuhB4pcs3XEUkVd2Zpr
         zbRFMANzSFbxGwDuu/yKRkIXjDQSKflheiOJ8+QSTP5gd4MSMp25lkJ2H/OhpJkLIrEs
         f8yg==
X-Gm-Message-State: AOAM533ESpCmkkwGFSBRGCaWSI+A2hLiYNpS1k8Uyg8LT0Ej2+8ncVu6
        dsY97bGa3W5+fmHZsp0Vv+aybzE=
X-Google-Smtp-Source: ABdhPJzIIuHBD5Fem6UtPdobHRoqcsOF6vZLREqUydtxySAZLgt3Bs4bkL3LYQvbBfPwCZe3QNYw9lc=
X-Received: from sdf2.svl.corp.google.com ([2620:15c:2c4:1:7220:84ff:fe09:7732])
 (user=sdf job=sendgmr) by 2002:a25:ae59:: with SMTP id g25mr10874818ybe.317.1600108580862;
 Mon, 14 Sep 2020 11:36:20 -0700 (PDT)
Date:   Mon, 14 Sep 2020 11:36:12 -0700
In-Reply-To: <20200914183615.2038347-1-sdf@google.com>
Message-Id: <20200914183615.2038347-3-sdf@google.com>
Mime-Version: 1.0
References: <20200914183615.2038347-1-sdf@google.com>
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7-goog
Subject: [PATCH bpf-next v5 2/5] bpf: Add BPF_PROG_BIND_MAP syscall
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        Andrii Nakryiko <andriin@fb.com>,
        YiFei Zhu <zhuyifei1999@gmail.com>,
        Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: YiFei Zhu <zhuyifei@google.com>

This syscall binds a map to a program. Returns success if the map is
already bound to the program.

Acked-by: Andrii Nakryiko <andriin@fb.com>
Cc: YiFei Zhu <zhuyifei1999@gmail.com>
Signed-off-by: YiFei Zhu <zhuyifei@google.com>
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 include/uapi/linux/bpf.h       |  7 ++++
 kernel/bpf/syscall.c           | 63 ++++++++++++++++++++++++++++++++++
 tools/include/uapi/linux/bpf.h |  7 ++++
 3 files changed, 77 insertions(+)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 7dd314176df7..a22812561064 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -124,6 +124,7 @@ enum bpf_cmd {
 	BPF_ENABLE_STATS,
 	BPF_ITER_CREATE,
 	BPF_LINK_DETACH,
+	BPF_PROG_BIND_MAP,
 };
 
 enum bpf_map_type {
@@ -658,6 +659,12 @@ union bpf_attr {
 		__u32		flags;
 	} iter_create;
 
+	struct { /* struct used by BPF_PROG_BIND_MAP command */
+		__u32		prog_fd;
+		__u32		map_fd;
+		__u32		flags;		/* extra flags */
+	} prog_bind_map;
+
 } __attribute__((aligned(8)));
 
 /* The description below is an attempt at providing documentation to eBPF
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index a67b8c6746be..2ce32cad5c8e 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -4161,6 +4161,66 @@ static int bpf_iter_create(union bpf_attr *attr)
 	return err;
 }
 
+#define BPF_PROG_BIND_MAP_LAST_FIELD prog_bind_map.flags
+
+static int bpf_prog_bind_map(union bpf_attr *attr)
+{
+	struct bpf_prog *prog;
+	struct bpf_map *map;
+	struct bpf_map **used_maps_old, **used_maps_new;
+	int i, ret = 0;
+
+	if (CHECK_ATTR(BPF_PROG_BIND_MAP))
+		return -EINVAL;
+
+	if (attr->prog_bind_map.flags)
+		return -EINVAL;
+
+	prog = bpf_prog_get(attr->prog_bind_map.prog_fd);
+	if (IS_ERR(prog))
+		return PTR_ERR(prog);
+
+	map = bpf_map_get(attr->prog_bind_map.map_fd);
+	if (IS_ERR(map)) {
+		ret = PTR_ERR(map);
+		goto out_prog_put;
+	}
+
+	mutex_lock(&prog->aux->used_maps_mutex);
+
+	used_maps_old = prog->aux->used_maps;
+
+	for (i = 0; i < prog->aux->used_map_cnt; i++)
+		if (used_maps_old[i] == map)
+			goto out_unlock;
+
+	used_maps_new = kmalloc_array(prog->aux->used_map_cnt + 1,
+				      sizeof(used_maps_new[0]),
+				      GFP_KERNEL);
+	if (!used_maps_new) {
+		ret = -ENOMEM;
+		goto out_unlock;
+	}
+
+	memcpy(used_maps_new, used_maps_old,
+	       sizeof(used_maps_old[0]) * prog->aux->used_map_cnt);
+	used_maps_new[prog->aux->used_map_cnt] = map;
+
+	prog->aux->used_map_cnt++;
+	prog->aux->used_maps = used_maps_new;
+
+	kfree(used_maps_old);
+
+out_unlock:
+	mutex_unlock(&prog->aux->used_maps_mutex);
+
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
@@ -4294,6 +4354,9 @@ SYSCALL_DEFINE3(bpf, int, cmd, union bpf_attr __user *, uattr, unsigned int, siz
 	case BPF_LINK_DETACH:
 		err = link_detach(&attr);
 		break;
+	case BPF_PROG_BIND_MAP:
+		err = bpf_prog_bind_map(&attr);
+		break;
 	default:
 		err = -EINVAL;
 		break;
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 7dd314176df7..a22812561064 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -124,6 +124,7 @@ enum bpf_cmd {
 	BPF_ENABLE_STATS,
 	BPF_ITER_CREATE,
 	BPF_LINK_DETACH,
+	BPF_PROG_BIND_MAP,
 };
 
 enum bpf_map_type {
@@ -658,6 +659,12 @@ union bpf_attr {
 		__u32		flags;
 	} iter_create;
 
+	struct { /* struct used by BPF_PROG_BIND_MAP command */
+		__u32		prog_fd;
+		__u32		map_fd;
+		__u32		flags;		/* extra flags */
+	} prog_bind_map;
+
 } __attribute__((aligned(8)));
 
 /* The description below is an attempt at providing documentation to eBPF
-- 
2.28.0.618.gf4bc123cb7-goog

