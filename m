Return-Path: <bpf+bounces-47513-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE6389F9EB6
	for <lists+bpf@lfdr.de>; Sat, 21 Dec 2024 07:10:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD844188E612
	for <lists+bpf@lfdr.de>; Sat, 21 Dec 2024 06:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5CD41DF27A;
	Sat, 21 Dec 2024 06:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="RiUumem9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505AD86AE3
	for <bpf@vger.kernel.org>; Sat, 21 Dec 2024 06:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734761444; cv=none; b=hHeKyMZk9BDgZhTt1lwCO8YfpFP1fyXcJPgNLmFGVxM6lPTrX4Z7XXHGHdYfZZ1XL/sn14CoJr82/CvRBmPr07cI/SP694dZgYtq58KYkDeMMfB8+pgxIPBiApSp9tsO/QenVNF02IQSbn7ziN5ycEJPkF2OcaMJtaMhiqgLb1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734761444; c=relaxed/simple;
	bh=PN6V9tT+jUJNcrg2/IifXhf5UUd8c1DCmYD9pBGAcpo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OacHCrYQVaDkz0yMKiZ1DFRR1qe9LmzhZ3hgv/SE0oNhJ3NEYvPTQLZVWgz2jqnenivGEfVijitEJTwMaa4jdBa4Ue1aFZeKKZPEOZd9PWTw/tPQ0wbD5O3kjbTbxCNYV06weZ5xUUXAyoXVeCbjbyo2EcDZIrPI1AWE/cNxWzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=RiUumem9; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2161a4f86a3so3162535ad.1
        for <bpf@vger.kernel.org>; Fri, 20 Dec 2024 22:10:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1734761441; x=1735366241; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0MUN4Uw+ym76sEm1sJgHgtu0fyPy5FHyQ5TXTAPskQw=;
        b=RiUumem9U/bc/3gMigSyflmW1Gv58XZV+g2R8yjeJwnDCExFrK/XDgdHZUO43+/Hyl
         qCzcG2KMHoPDnRJken+u8taDjHH36kUC6b0T7DRk4vi3eaKXM/3ELXRLTjzHPCntDT/S
         ipBhwSw3pbcnPJkrn9ZBmhx3B6YUkU3AAaMx/T+HuWJ9m22uWehjZSKVh0RXJs0hdIK7
         vjMEDMsH+ZlKau6w5MeebIKkpgCk6mIB3JLe8TC3qyypcnE4FOXnqibphhtIRKBDaWqG
         tiQVjx9rh7f3W/WCza4angWbYDr6ykW9Z+ITnkV2lZyR8zoxZMvHzUp/bvvY2/IHGBTl
         5e0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734761441; x=1735366241;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0MUN4Uw+ym76sEm1sJgHgtu0fyPy5FHyQ5TXTAPskQw=;
        b=qOGXkb8Ltmnvtgt0iPRXGm0CcOKfMWYqRvV7KVBwpDLzLsiHQSPSD3pGPQDEuBJ3Zn
         SpkJgnmtdKhUV8mpJPhVx3xDwvl4P7ZE1a84JcJv4bssUV4UF+4Ugr7912nb+DqjBenn
         Kr8CXXsfVPTsCsMYA/R4fyeit74XqkAebAkfysiymfdchyYctCRzYsoq2MguR9EaW8p8
         Frpax9xnjjl7AAy2RFERcOdcKthl8BDxzxQ0w6fNobyzlD6CC1WOzagXMcpY154ZHcTe
         /o063etnB/LQ3wVqvBNjcamuCBgq6vfYCV1rvz0INmuYh/KAX1KMxJh2XJivstfz2Yyv
         iX/w==
X-Forwarded-Encrypted: i=1; AJvYcCWfrcCLzKcMJRupKxGGPuBwJid93JhAbW5AnmN9SH8XfAcH+nL1B90+aW56b4s9xLC3yQI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIw1wbiMSpFy7VSV+lhA3YgBzI73Cq18UEfeuS/jsX5smHUCP/
	RSu6C1ElTidFyoGevmC6sx/hFyBfPtfFV4fmKoqzzOGgqKSVmZiFOvcXGcsGm0w=
X-Gm-Gg: ASbGncu/+vIlfKv3Vt6OJULPUjpB2BWF2m2KlFHZ5C0c8f7V4oYw0HtC54xP6iuuhWU
	zkOsJgv2KMj7a2u5apmlP3o19OLgNttusHjjGEZ66pd39q07/6Ko6FQMa0eMh7MAHtseSlcoCor
	wvF/N/7CyH1YTYp/0QDe3AZsDr6YF+uVz0UDz5K/tKA5EUtwSa43rYuuSwit2ivmxVLr0DoiA8G
	Wa+lMp7wTYycN3TFcX6o6E/05bRTBF9Sds692TDVTnyz1uiz8oVwaYtzXOE0owsUxFT923eo3UT
	KpFOYlhVzisOH1mIIYE=
X-Google-Smtp-Source: AGHT+IH5nR5nisAREPuE59xSMd/Jd77yqnRaPq0stclmZn8R/ib/DK7nVCd3VKnc2yo9CrnKmZ3TyA==
X-Received: by 2002:a17:902:d510:b0:216:2e45:f6e1 with SMTP id d9443c01a7336-219e6f2739dmr27660845ad.15.1734761441601;
        Fri, 20 Dec 2024 22:10:41 -0800 (PST)
Received: from C02DV8HUMD6R.bytedance.net ([139.177.225.251])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc9629d0sm38292615ad.41.2024.12.20.22.10.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2024 22:10:41 -0800 (PST)
From: Abel Wu <wuyun.abel@bytedance.com>
To: Martin KaFai Lau <martin.lau@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	David Vernet <void@manifault.com>
Cc: Abel Wu <wuyun.abel@bytedance.com>,
	bpf@vger.kernel.org (open list:BPF [STORAGE & CGROUPS]),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH bpf v2] bpf: Fix deadlock when freeing cgroup storage
Date: Sat, 21 Dec 2024 14:10:16 +0800
Message-Id: <20241221061018.37717-1-wuyun.abel@bytedance.com>
X-Mailer: git-send-email 2.37.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following commit
bc235cdb423a ("bpf: Prevent deadlock from recursive bpf_task_storage_[get|delete]")
first introduced deadlock prevention for fentry/fexit programs attaching
on bpf_task_storage helpers. That commit also employed the logic in map
free path in its v6 version.

Later bpf_cgrp_storage was first introduced in
c4bcfb38a95e ("bpf: Implement cgroup storage available to non-cgroup-attached bpf progs")
which faces the same issue as bpf_task_storage, instead of its busy
counter, NULL was passed to bpf_local_storage_map_free() which opened
a window to cause deadlock:

	<TASK>
		(acquiring local_storage->lock)
	_raw_spin_lock_irqsave+0x3d/0x50
	bpf_local_storage_update+0xd1/0x460
	bpf_cgrp_storage_get+0x109/0x130
	bpf_prog_a4d4a370ba857314_cgrp_ptr+0x139/0x170
	? __bpf_prog_enter_recur+0x16/0x80
	bpf_trampoline_6442485186+0x43/0xa4
	cgroup_storage_ptr+0x9/0x20
		(holding local_storage->lock)
	bpf_selem_unlink_storage_nolock.constprop.0+0x135/0x160
	bpf_selem_unlink_storage+0x6f/0x110
	bpf_local_storage_map_free+0xa2/0x110
	bpf_map_free_deferred+0x5b/0x90
	process_one_work+0x17c/0x390
	worker_thread+0x251/0x360
	kthread+0xd2/0x100
	ret_from_fork+0x34/0x50
	ret_from_fork_asm+0x1a/0x30
	</TASK>

Progs:
 - A: SEC("fentry/cgroup_storage_ptr")
   - cgid (BPF_MAP_TYPE_HASH)
	Record the id of the cgroup the current task belonging
	to in this hash map, using the address of the cgroup
	as the map key.
   - cgrpa (BPF_MAP_TYPE_CGRP_STORAGE)
	If current task is a kworker, lookup the above hash
	map using function parameter @owner as the key to get
	its corresponding cgroup id which is then used to get
	a trusted pointer to the cgroup through
	bpf_cgroup_from_id(). This trusted pointer can then
	be passed to bpf_cgrp_storage_get() to finally trigger
	the deadlock issue.
 - B: SEC("tp_btf/sys_enter")
   - cgrpb (BPF_MAP_TYPE_CGRP_STORAGE)
	The only purpose of this prog is to fill Prog A's
	hash map by calling bpf_cgrp_storage_get() for as
	many userspace tasks as possible.

Steps to reproduce:
 - Run A;
 - while (true) { Run B; Destroy B; }

Fix this issue by passing its busy counter to the free procedure so
it can be properly incremented before storage/smap locking.

Fixes: c4bcfb38a95e ("bpf: Implement cgroup storage available to non-cgroup-attached bpf progs")
Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
---
 kernel/bpf/bpf_cgrp_storage.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/bpf_cgrp_storage.c b/kernel/bpf/bpf_cgrp_storage.c
index 20f05de92e9c..7996fcea3755 100644
--- a/kernel/bpf/bpf_cgrp_storage.c
+++ b/kernel/bpf/bpf_cgrp_storage.c
@@ -154,7 +154,7 @@ static struct bpf_map *cgroup_storage_map_alloc(union bpf_attr *attr)
 
 static void cgroup_storage_map_free(struct bpf_map *map)
 {
-	bpf_local_storage_map_free(map, &cgroup_cache, NULL);
+	bpf_local_storage_map_free(map, &cgroup_cache, &bpf_cgrp_storage_busy);
 }
 
 /* *gfp_flags* is a hidden argument provided by the verifier */
-- 
2.37.3


