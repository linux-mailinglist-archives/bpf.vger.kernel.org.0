Return-Path: <bpf+bounces-37018-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3911F9504D2
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2024 14:21:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94B032833DF
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2024 12:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ADD6199389;
	Tue, 13 Aug 2024 12:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KWvRj6rZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1611991C2;
	Tue, 13 Aug 2024 12:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723551698; cv=none; b=sLjVZ0H9FSINgTdh/40Mn1k1xm5Qdi0H+HSA2Z+i16XZqu3T/p8yNiEWlSPmXOVLJvED6ldQyTmXpo4QfcgeNekV0GGa1jzn6RUqrWAjgiMQgndRzKKkqiUthom0MscsDUIfklHtgO0q7rxHV65n+ZXEong5+SKLc27Xy/SL88Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723551698; c=relaxed/simple;
	bh=nul9oNFo5MlT8L54l8FRJ+VtGDNyl0aThkFSBNHbOKU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cpgAzrvW/KhUw1CJGs9+gqpUWjZDh+4U+xxPh+OWMoa70BQD/R+c+DHI60/uBYOueSXK4PDgBWJrB6l8z5iLh2lBXGGtWbhfRGiriz0k41War0Vb4QI17Wk/QKOrMq201dSsxLkXOzhvlO2nYbiZby8d45GAcTNc9meQC4f/wBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KWvRj6rZ; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a7a9185e1c0so409703266b.1;
        Tue, 13 Aug 2024 05:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723551695; x=1724156495; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YKwcvjI1BwRV/PUGETAH1O0LycydQJQiwQrCJX2yD5s=;
        b=KWvRj6rZtWmFXTTBuD6pnETCNYE3rjbax2Qsf+vFxkjp+EgeWReVzWitEwUqrGE2Ui
         V1UhpZ7FpMVgcpUc7CkUvANXDWhag5m+7B9YiRaA2CAcae7pZ94KMfat9KHEk3oyY6o1
         aPBlUMBoA+65u7q3I/+RAV37r46ljx35bxifrB7y4RqWTZBD6am4srwKnXgaqJMyIR84
         48NlJi/HyeguPtMUxZWlSEXBMmSGYVPvALyNFNS9IMNT2Ljq1xH7bM2dbxBIhvbOPpi9
         feW206L6vHpajrjNAiqBUpb1lgBQ7iMZBnSvzdJWVQjdHKm27h82EAtQiAeDc/pwRhVu
         ecQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723551695; x=1724156495;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YKwcvjI1BwRV/PUGETAH1O0LycydQJQiwQrCJX2yD5s=;
        b=tToZ3b/jdn7Pc/3AWgd3jQqMYHU7CXPlLG3MBRFQDL1Mz9GkaUk25uU/hVk/v+HN3w
         jdWhTu0YSt4DKv6U73OaSlIDyvzB82/MQbwvZNuweII8pvZictJ4bAAoawo4E4FLktTO
         d4KmKH+D9qQdTdx4r863HSphI/WxOP9Q236TkFuGx1f2Brtu7lNAkBg+8IsZd5LK6hMq
         o6GwOE+2Nme/PUTkvMtIy6+KddyT/kEZsLnEVpjPCEcapvurBi9L0xfakTXBo0jwa8my
         s/xFupezHwpYyQMTtXV7zN1CxIHDrdTmcTfrhhIA2GIp15/O+rJ+8ZykSRJYmfwGoDkJ
         rVYQ==
X-Forwarded-Encrypted: i=1; AJvYcCWt703tcS+v7K5YbZPy5FsewBNm/79PQ3bw8PN4wW63ToZt4p9EiWmUz3aWoAXDEJfsEXhU20hSZpWT8lLapV9Lq3metX6cPN3vL1ZKLIBQpEf+XwZ+sIKqnWSi8upJZhA42di403DO
X-Gm-Message-State: AOJu0YyspVef4hSkM6wEzpi/vq8aXXKe+Q3bEtNunjCgaCO91eD5Lq9T
	0kaLedX5eD9IpVTpiDkPxNX0dmpKowFzPpQZpet82iFAe4ViTSeY
X-Google-Smtp-Source: AGHT+IHSPYKEoBsb0fISxSo3sHBmT1rvSbClTaG3HWR9l0IPSzLQ0Fhf12Udo8xgjVy2f2Goy6qZoA==
X-Received: by 2002:a17:907:9412:b0:a80:d64f:6734 with SMTP id a640c23a62f3a-a80ed2d256dmr230346766b.60.1723551695037;
        Tue, 13 Aug 2024 05:21:35 -0700 (PDT)
Received: from lenovo.homenet.telecomitalia.it (host-79-17-17-86.retail.telecomitalia.it. [79.17.17.86])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80f41849cesm65358766b.199.2024.08.13.05.21.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 05:21:34 -0700 (PDT)
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
Subject: [PATCH bpf-next v4 2/2] bpf: allow bpf_current_task_under_cgroup() with BPF_CGROUP_*
Date: Tue, 13 Aug 2024 14:21:00 +0200
Message-ID: <20240813122100.181246-3-technoboy85@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240813122100.181246-1-technoboy85@gmail.com>
References: <20240813122100.181246-1-technoboy85@gmail.com>
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


