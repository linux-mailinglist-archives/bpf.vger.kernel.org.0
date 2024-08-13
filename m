Return-Path: <bpf+bounces-37031-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2C12950679
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2024 15:29:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FD891F20407
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2024 13:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 774D619CCE8;
	Tue, 13 Aug 2024 13:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O/CZjGCT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B0419B5A7;
	Tue, 13 Aug 2024 13:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723555739; cv=none; b=vEpkLQYBHfSAUYMIO9fqX913/Z0ousVKf7bInLmD8wpsaggf7Vat2vqLCHdX2w4cHUCOcGjISBF5CpfuvL6KnaGTT3ab9E6LaaeBsUNpAAJiqWeNC/UdD6Vlwx6RrkK8+oNvpcHbtSP7nnv6c93KLFDl53ZtqXT02MQzqZQqm+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723555739; c=relaxed/simple;
	bh=nul9oNFo5MlT8L54l8FRJ+VtGDNyl0aThkFSBNHbOKU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R6Bs5qA0rO+LO/YRGjVeoeCJ3kAE0GJgNah1s+jOdHGSapqPYI3p6go+pefNIhBMSFqmQt7bPTeB6a3ZEy6cKa/RV+xEEFOk8PbWv2vfbLJUuJs2jAeYQvLmSliCsczOTfctidMhd/kbrehNg6nAr7S2atmprBvCykq5mvkpOoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O/CZjGCT; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5a1337cfbb5so7214734a12.3;
        Tue, 13 Aug 2024 06:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723555736; x=1724160536; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YKwcvjI1BwRV/PUGETAH1O0LycydQJQiwQrCJX2yD5s=;
        b=O/CZjGCTxHen70dB28pgnIkDSMhLkjIzz4wbF8m1NqmEvMZTCwWzmROt51nyo+qI50
         JiJd4PCQU87GODHPBY4u9QYSfiMUQceuHma+gxZAMqh+qK9BXR+JBF2W+GouqZSf4EqV
         cfJSm8zEoOAvI5NLcrcGk9RHHxZ4ZuD/8OxYfhd+PBOZbbtoeVfWvM7N1HJH1wSrKLJx
         H8CzrZpws7jo7zahjirDEZsn7a2OAFKcsXx9u/mhN+WPyr3rk8aKqkYRCmUxxSYVC3mC
         PH8F1GAUajWB4SgSRUI2Er/dW+oskjX1j+5wocvw4naXBbOY8VsnNY/CK0OQKdmqV/2R
         SAZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723555736; x=1724160536;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YKwcvjI1BwRV/PUGETAH1O0LycydQJQiwQrCJX2yD5s=;
        b=DXCW0CY4vbKZM9AtC9BAbJx5VExHBFFxiW3t4zva1Y4aF/R1YorGMXhaQGIEC/alTp
         LiH7maGAjgoUTPOVy+YRubz20Iml8HTzMgj7201Pk04Le0zNiyYSw+SIEBLjr5k3FmjG
         sr0XP4eoX3i5jtOpsVqiruKsDd08rVHI7hsESjH9v1cwygqYLvuBrmQ2NDupZb1EwvRx
         8/qJHnflbam012IXaZ7rTlsM4/T9BEI93yfGYaVe3VEimjw9bOmv9qebJh2b8U/yxTGi
         yJdR6lYKvSJCAAw4yxe3kKZUHj/U2S2Isbsjj6GQC/VPS9GUtWrRxmQ1Rvd9OCP1JRFP
         lFJw==
X-Forwarded-Encrypted: i=1; AJvYcCXYoWxJDkwsAeDrE1VH40qucA2GIE4UHViMYH+rPOSrPb/+xVlm7XkeAzPc4vNuYkV27sGy9i5eLczQAxxzsRcVcYZO7uW0UgDCIlN3i8Y/mlnJGa/CGLVsfEIdAV2SSIJtwheyTLC+
X-Gm-Message-State: AOJu0YxVDXII/fdaTSwFauqED3EtUSZA8JP1iUV1yyCITsALwE8UX4OT
	QWUWOz7jMfhgQa1j1irbOeIM9514fzwKYCIE9n3M5sfj6WNO/yBa
X-Google-Smtp-Source: AGHT+IEqoEDOsqu63OSRHDTK19w80a+3vW/zllREoHYe+sC7y4RPTXw2fRGg0bBLMzql2oo+nm3Zfg==
X-Received: by 2002:a17:907:3e14:b0:a77:c080:11fa with SMTP id a640c23a62f3a-a80ed2c5360mr278671866b.48.1723555735619;
        Tue, 13 Aug 2024 06:28:55 -0700 (PDT)
Received: from lenovo.homenet.telecomitalia.it (host-79-17-17-86.retail.telecomitalia.it. [79.17.17.86])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80f414afe2sm70426766b.144.2024.08.13.06.28.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 06:28:55 -0700 (PDT)
From: Matteo Croce <technoboy85@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Matteo Croce <teknoraver@meta.com>
Subject: [PATCH bpf-next v5 2/2] bpf: allow bpf_current_task_under_cgroup() with BPF_CGROUP_*
Date: Tue, 13 Aug 2024 15:28:31 +0200
Message-ID: <20240813132831.184362-3-technoboy85@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240813132831.184362-1-technoboy85@gmail.com>
References: <20240813132831.184362-1-technoboy85@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Matteo Croce <teknoraver@meta.com>

The helper bpf_current_task_under_cgroup() currently is only allowed for
tracing programs, allow its usage also in the BPF_CGROUP_* program types.

Move the code from kernel/trace/bpf_trace.c to kernel/bpf/helpers.c,
so it compiles also without CONFIG_BPF_EVENTS.

This will be used in systemd-networkd to monitor the sysctl writes,
and filter it's own writes from others:
https://github.com/systemd/systemd/pull/32212

Signed-off-by: Matteo Croce <teknoraver@meta.com>
---
 include/linux/bpf.h      |  1 +
 kernel/bpf/cgroup.c      |  2 ++
 kernel/bpf/helpers.c     | 23 +++++++++++++++++++++++
 kernel/trace/bpf_trace.c | 23 -----------------------
 4 files changed, 26 insertions(+), 23 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index b9425e410bcb..f0192c173ed8 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -3206,6 +3206,7 @@ extern const struct bpf_func_proto bpf_sock_hash_update_proto;
 extern const struct bpf_func_proto bpf_get_current_cgroup_id_proto;
 extern const struct bpf_func_proto bpf_get_current_ancestor_cgroup_id_proto;
 extern const struct bpf_func_proto bpf_get_cgroup_classid_curr_proto;
+extern const struct bpf_func_proto bpf_current_task_under_cgroup_proto;
 extern const struct bpf_func_proto bpf_msg_redirect_hash_proto;
 extern const struct bpf_func_proto bpf_msg_redirect_map_proto;
 extern const struct bpf_func_proto bpf_sk_redirect_hash_proto;
diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 8ba73042a239..e7113d700b87 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -2581,6 +2581,8 @@ cgroup_current_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 	case BPF_FUNC_get_cgroup_classid:
 		return &bpf_get_cgroup_classid_curr_proto;
 #endif
+	case BPF_FUNC_current_task_under_cgroup:
+		return &bpf_current_task_under_cgroup_proto;
 	default:
 		return NULL;
 	}
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 0d1d97d968b0..8502cfed2926 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2458,6 +2458,29 @@ __bpf_kfunc long bpf_task_under_cgroup(struct task_struct *task,
 	return ret;
 }
 
+BPF_CALL_2(bpf_current_task_under_cgroup, struct bpf_map *, map, u32, idx)
+{
+	struct bpf_array *array = container_of(map, struct bpf_array, map);
+	struct cgroup *cgrp;
+
+	if (unlikely(idx >= array->map.max_entries))
+		return -E2BIG;
+
+	cgrp = READ_ONCE(array->ptrs[idx]);
+	if (unlikely(!cgrp))
+		return -EAGAIN;
+
+	return task_under_cgroup_hierarchy(current, cgrp);
+}
+
+const struct bpf_func_proto bpf_current_task_under_cgroup_proto = {
+	.func           = bpf_current_task_under_cgroup,
+	.gpl_only       = false,
+	.ret_type       = RET_INTEGER,
+	.arg1_type      = ARG_CONST_MAP_PTR,
+	.arg2_type      = ARG_ANYTHING,
+};
+
 /**
  * bpf_task_get_cgroup1 - Acquires the associated cgroup of a task within a
  * specific cgroup1 hierarchy. The cgroup1 hierarchy is identified by its
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index d557bb11e0ff..e4e1f5d8b2a6 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -797,29 +797,6 @@ const struct bpf_func_proto bpf_task_pt_regs_proto = {
 	.ret_btf_id	= &bpf_task_pt_regs_ids[0],
 };
 
-BPF_CALL_2(bpf_current_task_under_cgroup, struct bpf_map *, map, u32, idx)
-{
-	struct bpf_array *array = container_of(map, struct bpf_array, map);
-	struct cgroup *cgrp;
-
-	if (unlikely(idx >= array->map.max_entries))
-		return -E2BIG;
-
-	cgrp = READ_ONCE(array->ptrs[idx]);
-	if (unlikely(!cgrp))
-		return -EAGAIN;
-
-	return task_under_cgroup_hierarchy(current, cgrp);
-}
-
-static const struct bpf_func_proto bpf_current_task_under_cgroup_proto = {
-	.func           = bpf_current_task_under_cgroup,
-	.gpl_only       = false,
-	.ret_type       = RET_INTEGER,
-	.arg1_type      = ARG_CONST_MAP_PTR,
-	.arg2_type      = ARG_ANYTHING,
-};
-
 struct send_signal_irq_work {
 	struct irq_work irq_work;
 	struct task_struct *task;
-- 
2.46.0


