Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D543379569
	for <lists+bpf@lfdr.de>; Mon, 10 May 2021 19:23:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232768AbhEJRYq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 10 May 2021 13:24:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232822AbhEJRYP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 10 May 2021 13:24:15 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 335FEC06175F;
        Mon, 10 May 2021 10:23:09 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id c10so2684237qtx.10;
        Mon, 10 May 2021 10:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5/rwXY3Tz97DG7RI33m/7eYmkIHu/XikiymKc76hRuI=;
        b=Qoor7W8OoHJh8YFJwaDNYg1EhzPV+XmZZTxmIbK8xsOopphUxHRO+5slKwOBJQsxbB
         Ig1Em/YJCGj0gQIgKNbEvqsRN99g0dxRQP7xB1Nlb1l+talVrXYw83g7AoiJZndYjJWb
         RoauFxCt9kJiLqVvhi4ZPmj3J2HEYIWm3TAvEIR2YaFvOTGt+Da3DvynvW1VdZfLwRVL
         reXVfLFNd7Hs8jGhbbq8hZ5I53DE0OyVE9APlZR6pjJKWV0GLjIlBCWh6yj/YWyM7AYb
         BwqFa47yZICJI86OMu4z7Nt0B0UT91cZqaab6CLdOVLg/oHqXwW72BI543Lw/8JOgrbt
         ZZ9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5/rwXY3Tz97DG7RI33m/7eYmkIHu/XikiymKc76hRuI=;
        b=B1W7MwkdcMsaomcEcN5Mky+OcPLccLAHoa1FpgN0Qsz3ml3S7D+/ISk30RquqQgALj
         MqPUvctoOvIraFPxZnEIsi5M2DBsRvJC8kt7Cj5onYG0oM79Wa/t01Brx3Tri1JGdWpD
         2/chLGi22pSOtxKvRC1kOnYik+mGr1O0ma/Li2q82wEIX5s2ecJoukYFxYt6k2wcTsqU
         +tzywtGYU/F16Rx+EybnPH/ksShEfZM44eSyX4iA/9kQfuqUy/zsHrs8B5rZsiNU/lVs
         vuK4B38OtLUvvzhhdHsN6CRda1gPM8Vj3mTE0HTzVCoGMLqnwrEYP8UyzHtt/GYh3GEp
         CEOQ==
X-Gm-Message-State: AOAM530vTnMFZ4jhbMhk/MB7BF2zyE1wOn8ooQ+bQUl8pnH85fl5wmuV
        UGIM8/Reg0FDTzXZIrqj1PM=
X-Google-Smtp-Source: ABdhPJzZxsGB9ozvYjpJmRg62FFX02uOjGCBLcBwlLpOtloL9dHrxHJL0pVdAzZwU8U1raciHQh7vg==
X-Received: by 2002:a05:622a:15c9:: with SMTP id d9mr6841464qty.103.1620667388424;
        Mon, 10 May 2021 10:23:08 -0700 (PDT)
Received: from localhost.localdomain (host-173-230-99-154.tnkngak.clients.pavlovmedia.com. [173.230.99.154])
        by smtp.gmail.com with ESMTPSA id q7sm11924367qki.17.2021.05.10.10.23.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 10:23:08 -0700 (PDT)
From:   YiFei Zhu <zhuyifei1999@gmail.com>
To:     containers@lists.linux.dev, bpf@vger.kernel.org
Cc:     YiFei Zhu <yifeifz2@illinois.edu>,
        linux-security-module@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Austin Kuo <hckuo2@illinois.edu>,
        Claudio Canella <claudio.canella@iaik.tugraz.at>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Daniel Gruss <daniel.gruss@iaik.tugraz.at>,
        Dimitrios Skarlatos <dskarlat@cs.cmu.edu>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Hubertus Franke <frankeh@us.ibm.com>,
        Jann Horn <jannh@google.com>,
        Jinghao Jia <jinghao7@illinois.edu>,
        Josep Torrellas <torrella@illinois.edu>,
        Kees Cook <keescook@chromium.org>,
        Sargun Dhillon <sargun@sargun.me>,
        Tianyin Xu <tyxu@illinois.edu>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Tom Hromatka <tom.hromatka@oracle.com>,
        Will Drewry <wad@chromium.org>
Subject: [RFC PATCH bpf-next seccomp 12/12] seccomp-ebpf: support task storage from BPF-LSM, defaulting to group leader
Date:   Mon, 10 May 2021 12:22:49 -0500
Message-Id: <db41ad3924d01374d08984d20ad6678f91b82cde.1620499942.git.yifeifz2@illinois.edu>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1620499942.git.yifeifz2@illinois.edu>
References: <cover.1620499942.git.yifeifz2@illinois.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: YiFei Zhu <yifeifz2@illinois.edu>

This enables seccomp-eBPF filters to have per-process state even when
the filter is loaded by an unprivileged process. Without CAP_BPF &&
CAP_PERFMON no access to ptr to BTF ID is possible, so the only valid
task the verifier will accept is NULL, and the helper implementation
fallbacks to the group leader to have a per-process storage.

Filters loaded by privileged processes may still access the storage
of arbitrary tasks via a valid task_struct ptr to BTF ID.

Since task storage require rcu being locked. We lock and unlock
rcu before every seccomp-eBPF filter execution.

I'm not sure if this is the best way to do this. One, this introduces
a dependency on BPF-LSM. Two, per-thread storage is not accessible
to unprivileged filter loaders; it has to be per-process.

Signed-off-by: YiFei Zhu <yifeifz2@illinois.edu>
---
 include/linux/bpf.h           |  2 ++
 kernel/bpf/bpf_task_storage.c | 64 ++++++++++++++++++++++++++++++-----
 kernel/seccomp.c              |  4 +++
 3 files changed, 61 insertions(+), 9 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index efa6444b88d3..7c9755802275 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1964,7 +1964,9 @@ extern const struct bpf_func_proto bpf_ktime_get_coarse_ns_proto;
 extern const struct bpf_func_proto bpf_sock_from_file_proto;
 extern const struct bpf_func_proto bpf_get_socket_ptr_cookie_proto;
 extern const struct bpf_func_proto bpf_task_storage_get_proto;
+extern const struct bpf_func_proto bpf_task_storage_get_default_leader_proto;
 extern const struct bpf_func_proto bpf_task_storage_delete_proto;
+extern const struct bpf_func_proto bpf_task_storage_delete_default_leader_proto;
 extern const struct bpf_func_proto bpf_for_each_map_elem_proto;
 extern const struct bpf_func_proto bpf_probe_read_user_proto;
 extern const struct bpf_func_proto bpf_probe_read_user_dumpable_proto;
diff --git a/kernel/bpf/bpf_task_storage.c b/kernel/bpf/bpf_task_storage.c
index 3ce75758d394..5ddf3a92d359 100644
--- a/kernel/bpf/bpf_task_storage.c
+++ b/kernel/bpf/bpf_task_storage.c
@@ -224,19 +224,19 @@ static int bpf_pid_task_storage_delete_elem(struct bpf_map *map, void *key)
 	return err;
 }
 
-BPF_CALL_4(bpf_task_storage_get, struct bpf_map *, map, struct task_struct *,
-	   task, void *, value, u64, flags)
+static void *_bpf_task_storage_get(struct bpf_map *map, struct task_struct *task,
+				   void *value, u64 flags)
 {
 	struct bpf_local_storage_data *sdata;
 
 	if (flags & ~(BPF_LOCAL_STORAGE_GET_F_CREATE))
-		return (unsigned long)NULL;
+		return NULL;
 
 	if (!task)
-		return (unsigned long)NULL;
+		return NULL;
 
 	if (!bpf_task_storage_trylock())
-		return (unsigned long)NULL;
+		return NULL;
 
 	sdata = task_storage_lookup(task, map, true);
 	if (sdata)
@@ -251,12 +251,24 @@ BPF_CALL_4(bpf_task_storage_get, struct bpf_map *, map, struct task_struct *,
 
 unlock:
 	bpf_task_storage_unlock();
-	return IS_ERR_OR_NULL(sdata) ? (unsigned long)NULL :
-		(unsigned long)sdata->data;
+	return IS_ERR_OR_NULL(sdata) ? NULL : sdata->data;
 }
 
-BPF_CALL_2(bpf_task_storage_delete, struct bpf_map *, map, struct task_struct *,
-	   task)
+BPF_CALL_4(bpf_task_storage_get, struct bpf_map *, map, struct task_struct *,
+	   task, void *, value, u64, flags)
+{
+	return (unsigned long)_bpf_task_storage_get(map, task, value, flags);
+}
+
+BPF_CALL_4(bpf_task_storage_get_default_leader, struct bpf_map *, map,
+	   struct task_struct *, task, void *, value, u64, flags)
+{
+	if (!task)
+		task = current->group_leader;
+	return (unsigned long)_bpf_task_storage_get(map, task, value, flags);
+}
+
+static int _bpf_task_storage_delete(struct bpf_map *map, struct task_struct *task)
 {
 	int ret;
 
@@ -275,6 +287,20 @@ BPF_CALL_2(bpf_task_storage_delete, struct bpf_map *, map, struct task_struct *,
 	return ret;
 }
 
+BPF_CALL_2(bpf_task_storage_delete, struct bpf_map *, map, struct task_struct *,
+	   task)
+{
+	return _bpf_task_storage_delete(map, task);
+}
+
+BPF_CALL_2(bpf_task_storage_delete_default_leader, struct bpf_map *, map,
+	   struct task_struct *, task)
+{
+	if (!task)
+		task = current->group_leader;
+	return _bpf_task_storage_delete(map, task);
+}
+
 static int notsupp_get_next_key(struct bpf_map *map, void *key, void *next_key)
 {
 	return -ENOTSUPP;
@@ -330,6 +356,17 @@ const struct bpf_func_proto bpf_task_storage_get_proto = {
 	.arg4_type = ARG_ANYTHING,
 };
 
+const struct bpf_func_proto bpf_task_storage_get_default_leader_proto = {
+	.func = bpf_task_storage_get_default_leader,
+	.gpl_only = false,
+	.ret_type = RET_PTR_TO_MAP_VALUE_OR_NULL,
+	.arg1_type = ARG_CONST_MAP_PTR,
+	.arg2_type = ARG_PTR_TO_BTF_ID_OR_NULL,
+	.arg2_btf_id = &bpf_task_storage_btf_ids[0],
+	.arg3_type = ARG_PTR_TO_MAP_VALUE_OR_NULL,
+	.arg4_type = ARG_ANYTHING,
+};
+
 const struct bpf_func_proto bpf_task_storage_delete_proto = {
 	.func = bpf_task_storage_delete,
 	.gpl_only = false,
@@ -338,3 +375,12 @@ const struct bpf_func_proto bpf_task_storage_delete_proto = {
 	.arg2_type = ARG_PTR_TO_BTF_ID,
 	.arg2_btf_id = &bpf_task_storage_btf_ids[0],
 };
+
+const struct bpf_func_proto bpf_task_storage_delete_default_leader_proto = {
+	.func = bpf_task_storage_delete_default_leader,
+	.gpl_only = false,
+	.ret_type = RET_INTEGER,
+	.arg1_type = ARG_CONST_MAP_PTR,
+	.arg2_type = ARG_PTR_TO_BTF_ID_OR_NULL,
+	.arg2_btf_id = &bpf_task_storage_btf_ids[0],
+};
diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index 330e9c365cdc..5b41b2aee39c 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -2457,6 +2457,10 @@ seccomp_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return ns_capable(current_user_ns(), CAP_SYS_PTRACE) ?
 			&bpf_probe_read_user_str_proto :
 			&bpf_probe_read_user_dumpable_str_proto;
+	case BPF_FUNC_task_storage_get:
+		return &bpf_task_storage_get_default_leader_proto;
+	case BPF_FUNC_task_storage_delete:
+		return &bpf_task_storage_delete_default_leader_proto;
 	default:
 		break;
 	}
-- 
2.31.1

