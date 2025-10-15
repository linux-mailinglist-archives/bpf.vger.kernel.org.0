Return-Path: <bpf+bounces-71040-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21BC1BE04F3
	for <lists+bpf@lfdr.de>; Wed, 15 Oct 2025 21:08:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48CE5426FF6
	for <lists+bpf@lfdr.de>; Wed, 15 Oct 2025 19:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F979305E19;
	Wed, 15 Oct 2025 19:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g2ys5lgE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CBDE3019CA
	for <bpf@vger.kernel.org>; Wed, 15 Oct 2025 19:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760555318; cv=none; b=D+sWwKVYvXXIof1kY0tZawo0A5dYtGNhPGBCUnZQMeL+KwGHO3D6BWi2DGrnnXJLGLSS0BBWU3Lad9bqdxHoMQngQNzpQeGxDIafuZE52dXkJAuAKltIJe6SqWM6FwN4XyzdgBOwY7Oxuq9kwFXBY+KlpTfYvRKIBxiMxkMwJTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760555318; c=relaxed/simple;
	bh=Zjie/6h9688PXeDDGg8W8+IR7jPAwonzHziJnGJ5lUI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CS8bOFv6VZjnpB2sg8I85OCOjGtRLRUoho8r6iNK4KU//925mUdabnAV6HV3gyO7X3Y6Oyhdxh5tPkf2JCgcus6G6R4hO3SjNS76+u/8Ywq4Bo8SNxWb9EEm750EQAZl5L7jMqepTYs0ous6TqFrx+WHfWu1XVKSl8Jox6AMa8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g2ys5lgE; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-781251eec51so5720552b3a.3
        for <bpf@vger.kernel.org>; Wed, 15 Oct 2025 12:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760555316; x=1761160116; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x4+5aOgvWODOPGtO0hDqGiqO++kewzL0OPl+hME7NKc=;
        b=g2ys5lgEgG7xXvV75IxrLSTh2/nW0796DPJwLOmyOWhJu++bzSJiAHgJtOJnBcincw
         o2eHt6mFnG2Bw7V1Kc+SPq1T1eArnau0oxyynCW17b9w6e1pKLxTbFCWV1KZd6fFALf1
         1rXVNnH0Xrox9xwjHGv2T2shm+YUMidbgeuRvPTnRIVtz8ZkJTin7irmc+T8g8tT8Jrt
         VFd8Xx4bLWKAiuAyflUzBAam0JpwmodfPeHyf/NenovJ0uXM2jM9h72QijcoNA4yLrfj
         2I0hvOIRoemXt+9ypqSCjv6/UHbdgrWsRJbRrO4MwRSufaMEUFgR9MvzIKYd1B1r3yG/
         NwDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760555316; x=1761160116;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x4+5aOgvWODOPGtO0hDqGiqO++kewzL0OPl+hME7NKc=;
        b=jr/jzvK88+WLeL8nRI/Tv+6+WHx1Puh+t88/5N9cDmhQZSP/IDED5AbqNWwmQZ2CdC
         1Ia6R4cXmzVInp8xAVfSVNgkk18aT2s1GRpRqRpNTHm+jkzBGiJ172Vswo1t6XYrhOvf
         GoxnHKgB8W+v8Ud+0pSYTdrIwUUWDPV2XFi1ZglBUcU5KRcwobk2kITLEB6n91QnpeIU
         wUoVtsxVv+tERAm7gdhMrs0jNCScZrs3+SMpf6nISr5bYbixas1mcYNUC72JBPR+38T7
         5ZP4eaYS0ZrczqKuRJI+Ts3bz4A+WNULUGKi0k6DpSA1epIGJW+QSPnW1bIeaC4t7Vq2
         9oqA==
X-Forwarded-Encrypted: i=1; AJvYcCXcOqIg0IAg7fBUxYyV62T31e89eHMZH8gg/17xyWemf3w0/0vWUrL0zmrzoRGpC314XN8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWn6k0ts/kn1yDG8fINHdVI2WxNUTSQI5JLU1JIqvF30UGv1TR
	QK3XLGEfGe8Sn7YbBcPZdJjc5Eg+tbTyabAZoOtB6UkohkYHE9z5BBq2
X-Gm-Gg: ASbGncshmdBvq0et52GyFQy1NCgsK8Uqc6oHXYgIqQdLglIbC3v21k7Zeu0MdIQenmO
	bj3ExZuNXwUsxM7AEyhyrIEQmqLWrQo46Gi7WMri86WEqejFDy4KLBzq2XqDppVU8Qlt8pFTnj+
	cT9dO8MaI/GnwOaRrUZSdtmn0P4UwAnNsDvhXdNif3ulxN+vj/906oSR8mK//3AZ+rfWPGAS9s0
	viHg6D3/gy662lPmBmNx1VSAJebfi/7jkTVeDHHeVDkJElpFqWIOFc3ikfe3Pi8/GV9cE2I9goH
	EycMQ15PdtUJgMXMbhq+o5t5X0lVVpSnHKOhRp/wJS8NgdwHrdDTGk5bVn+1b5epXo6Bu/powWo
	qAQFpxVqCMcMD4vXA8rzyCAXQv4qL3ca+NxmtOqE0Vjn4OgvIq15ShpA2w9is0ODhfXwEOg==
X-Google-Smtp-Source: AGHT+IFmVjoy0/RXg9J2/ujgSWA6hbqUoUjXe12ni5dKrJHqDFKqV95/Gh1KnAb6dMRdJCKgoA9fqw==
X-Received: by 2002:a05:6a00:182a:b0:781:275a:29d9 with SMTP id d2e1a72fcca58-7938742c7aemr38835163b3a.18.1760555316194;
        Wed, 15 Oct 2025 12:08:36 -0700 (PDT)
Received: from jpkobryn-fedora-PF5CFKNC.thefacebook.com ([2620:10d:c090:500::7:1069])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992d5b8672sm19483106b3a.69.2025.10.15.12.08.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 12:08:35 -0700 (PDT)
From: JP Kobryn <inwardvessel@gmail.com>
To: shakeel.butt@linux.dev,
	andrii@kernel.org,
	ast@kernel.org,
	mkoutny@suse.com,
	yosryahmed@google.com,
	hannes@cmpxchg.org,
	tj@kernel.org,
	akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	bpf@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH v2 1/2] memcg: introduce kfuncs for fetching memcg stats
Date: Wed, 15 Oct 2025 12:08:12 -0700
Message-ID: <20251015190813.80163-2-inwardvessel@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251015190813.80163-1-inwardvessel@gmail.com>
References: <20251015190813.80163-1-inwardvessel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reading from the memory.stat file can be expensive because of the string
encoding/decoding and text filtering involved. Introduce three kfuncs for
fetching each type of memcg stat from a bpf program. This allows data to be
transferred directly to userspace, eliminating the need for string
encoding/decoding. It also removes the need for text filtering since it
allows for fetching specific stats.

The patch also includes a kfunc for flushing stats in order to read the
latest values. Note that this is not required for fetching stats, since the
kernel periodically flushes memcg stats. It is left up to the programmer
whether they want more recent stats or not.

Signed-off-by: JP Kobryn <inwardvessel@gmail.com>
---
 mm/memcontrol.c | 67 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 4deda33625f4..6547c27d4430 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -871,6 +871,73 @@ unsigned long memcg_events_local(struct mem_cgroup *memcg, int event)
 }
 #endif
 
+static inline struct mem_cgroup *memcg_from_cgroup(struct cgroup *cgrp)
+{
+	return cgrp ? mem_cgroup_from_css(cgrp->subsys[memory_cgrp_id]) : NULL;
+}
+
+__bpf_kfunc static void memcg_flush_stats(struct cgroup *cgrp)
+{
+	struct mem_cgroup *memcg = memcg_from_cgroup(cgrp);
+
+	if (!memcg)
+		return;
+
+	mem_cgroup_flush_stats(memcg);
+}
+
+__bpf_kfunc static unsigned long memcg_stat_fetch(struct cgroup *cgrp,
+		enum memcg_stat_item item)
+{
+	struct mem_cgroup *memcg = memcg_from_cgroup(cgrp);
+
+	if (!memcg)
+		return 0;
+
+	return memcg_page_state_output(memcg, item);
+}
+
+__bpf_kfunc static unsigned long memcg_node_stat_fetch(struct cgroup *cgrp,
+		enum node_stat_item item)
+{
+	struct mem_cgroup *memcg = memcg_from_cgroup(cgrp);
+
+	if (!memcg)
+		return 0;
+
+	return memcg_page_state_output(memcg, item);
+}
+
+__bpf_kfunc static unsigned long memcg_vm_event_fetch(struct cgroup *cgrp,
+		enum vm_event_item item)
+{
+	struct mem_cgroup *memcg = memcg_from_cgroup(cgrp);
+
+	if (!memcg)
+		return 0;
+
+	return memcg_events(memcg, item);
+}
+
+BTF_KFUNCS_START(bpf_memcontrol_kfunc_ids)
+BTF_ID_FLAGS(func, memcg_flush_stats, KF_TRUSTED_ARGS | KF_SLEEPABLE)
+BTF_ID_FLAGS(func, memcg_stat_fetch, KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, memcg_node_stat_fetch, KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, memcg_vm_event_fetch, KF_TRUSTED_ARGS)
+BTF_KFUNCS_END(bpf_memcontrol_kfunc_ids)
+
+static const struct btf_kfunc_id_set bpf_memcontrol_kfunc_set = {
+	.owner          = THIS_MODULE,
+	.set            = &bpf_memcontrol_kfunc_ids,
+};
+
+static int __init bpf_memcontrol_kfunc_init(void)
+{
+	return register_btf_kfunc_id_set(BPF_PROG_TYPE_UNSPEC,
+					 &bpf_memcontrol_kfunc_set);
+}
+late_initcall(bpf_memcontrol_kfunc_init);
+
 struct mem_cgroup *mem_cgroup_from_task(struct task_struct *p)
 {
 	/*
-- 
2.47.3


