Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 061F3D4543
	for <lists+bpf@lfdr.de>; Fri, 11 Oct 2019 18:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726910AbfJKQV1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Oct 2019 12:21:27 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:51675 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726728AbfJKQV1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Oct 2019 12:21:27 -0400
Received: by mail-pf1-f202.google.com with SMTP id s137so7830170pfs.18
        for <bpf@vger.kernel.org>; Fri, 11 Oct 2019 09:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=xBvLpnklmO3BeW4F+cJ5FIZ6jEwlCbi0YlkXsejMb1w=;
        b=DJDypAfZlllevArKYRXQ88RS2H5DrNm8EpfeLw0LXLL9H2QzEvYMOHgzPgfZLU1X/L
         JJJT4X310I3RLuccgMEULteGhzajAR5lZlZDMZixeiB8cDBJ91DWJen2FfZQRl3nQqZV
         qmbplDBAo2KOix/9DuGplFa612nYshXxViRktpY5GDcK/Ngy6OJur4k2oU2Gvu6REX+Q
         bfQATZ4WAYcPUcavGantHH14ujG+WJzEbqRJbkNVZk0TEPpBboiCkEyiLXpsAJ0yxws0
         d+qsfem0kGQQvHYPb0pTXc4HHjAr1oqKZyyarWsWqyEzw/eypGX5F/IUjgFoao0x50jn
         TpIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=xBvLpnklmO3BeW4F+cJ5FIZ6jEwlCbi0YlkXsejMb1w=;
        b=dp0kQjh+z1tx15Eo1nzD8r6hiwy8XtWRT1MsVXHU+gj4hQrb8rps9vf5BYkCDhHljY
         cO0q/fbCxbmwR3aRxmTzEVK2QTOgmHrnwaQnaI1+zXuU9JuwOHnN0S+On9n134rhSszJ
         SoEjT+jEOBBfUD8k1kbDkLzUGNYmU+tDsv4riQis+dE2y8/newbh6sMb1qnBBuQgApQ5
         mlZHgJZuLmqTB99A31pr/gaCYe142TY5StgWbVqusiQH/nJPrXpxmFYY5uIigR1XSiEm
         QcDnnSiEOUsmbxolYka78DRZAnA+7cdyHnWeVhnZE7UxZz0DwJQEiAIqeWtES2jIm0BS
         w09g==
X-Gm-Message-State: APjAAAWmLbS2KKE8MI2M66/X066lSptmLa7OrzrR3BLKrrl1NCwArRTT
        4lvb/2OGzIMoynIVY7YOObLf088=
X-Google-Smtp-Source: APXvYqygwahaAN17B+q4IqG8G6ZDeaeOcvOgLgoWO2UFUdciDoSvOipn4xcw0+z6LVegK7y3x/kSxg4=
X-Received: by 2002:a63:5c49:: with SMTP id n9mr17568195pgm.289.1570810886256;
 Fri, 11 Oct 2019 09:21:26 -0700 (PDT)
Date:   Fri, 11 Oct 2019 09:21:22 -0700
Message-Id: <20191011162124.52982-1-sdf@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.23.0.700.g56cf767bdb-goog
Subject: [PATCH bpf-next 1/3] bpf: preserve command of the process that loaded
 the program
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Even though we have the pointer to user_struct and can recover
uid of the user who has created the program, it usually contains
0 (root) which is not very informative. Let's store the comm of the
calling process and export it via bpf_prog_info. This should help
answer the question "which process loaded this particular program".

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 include/linux/bpf.h      | 1 +
 include/uapi/linux/bpf.h | 2 ++
 kernel/bpf/syscall.c     | 4 ++++
 3 files changed, 7 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 5b9d22338606..b03ea396afe5 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -421,6 +421,7 @@ struct bpf_prog_aux {
 		struct work_struct work;
 		struct rcu_head	rcu;
 	};
+	char created_by_comm[BPF_CREATED_COMM_LEN];
 };
 
 struct bpf_array {
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index a65c3b0c6935..4e883ecbba1e 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -326,6 +326,7 @@ enum bpf_attach_type {
 #define BPF_F_NUMA_NODE		(1U << 2)
 
 #define BPF_OBJ_NAME_LEN 16U
+#define BPF_CREATED_COMM_LEN	16U
 
 /* Flags for accessing BPF object from syscall side. */
 #define BPF_F_RDONLY		(1U << 3)
@@ -3252,6 +3253,7 @@ struct bpf_prog_info {
 	__aligned_u64 prog_tags;
 	__u64 run_time_ns;
 	__u64 run_cnt;
+	char created_by_comm[BPF_CREATED_COMM_LEN];
 } __attribute__((aligned(8)));
 
 struct bpf_map_info {
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 82eabd4e38ad..51c125292eaf 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1735,6 +1735,8 @@ static int bpf_prog_load(union bpf_attr *attr, union bpf_attr __user *uattr)
 	bpf_prog_kallsyms_add(prog);
 	perf_event_bpf_event(prog, PERF_BPF_EVENT_PROG_LOAD, 0);
 
+	get_task_comm(prog->aux->created_by_comm, current);
+
 	err = bpf_prog_new_fd(prog);
 	if (err < 0)
 		bpf_prog_put(prog);
@@ -2337,6 +2339,8 @@ static int bpf_prog_get_info_by_fd(struct bpf_prog *prog,
 
 	memcpy(info.tag, prog->tag, sizeof(prog->tag));
 	memcpy(info.name, prog->aux->name, sizeof(prog->aux->name));
+	memcpy(info.created_by_comm, prog->aux->created_by_comm,
+	       sizeof(prog->aux->created_by_comm));
 
 	ulen = info.nr_map_ids;
 	info.nr_map_ids = prog->aux->used_map_cnt;
-- 
2.23.0.700.g56cf767bdb-goog

