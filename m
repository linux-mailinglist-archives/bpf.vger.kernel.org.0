Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60412311F03
	for <lists+bpf@lfdr.de>; Sat,  6 Feb 2021 18:05:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbhBFRFL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 6 Feb 2021 12:05:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbhBFRFK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 6 Feb 2021 12:05:10 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C07D0C061793
        for <bpf@vger.kernel.org>; Sat,  6 Feb 2021 09:03:56 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id m12so5296964pjs.4
        for <bpf@vger.kernel.org>; Sat, 06 Feb 2021 09:03:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UUFZ3hy4+kGr5BVmj29me3nmmAUMnwFvrmhzO7lqSPo=;
        b=l1Qxjru+8d2e2rxn/pyLnnJRGl62A18M3wOgwHHC4Hef8d+EEc9q7n6Z5E6IRd8+Bn
         6BQJICeHms8iwhc8Zy8mps6J9/MIxktTB+NcY0DUlfXy8gUrYlA4dtbqxuUggLvCow+u
         +baZXAA/nO1cEuWn1PUdWjM4/wRbduHEA63IoprmyooiVIpagkLg1n2zSZ32BfEZnQej
         W87YqYAkjKij9ebKi8GcL92X/komGHQZJHhIqmBjePJumP0lWgne8mwieB4fVq4ExQ92
         6MBRQc/9qbr2iVkPtYwPMj7pSRKn8+vzcaTU6SUaHiWJRgl08PHUt0apLQJtBt5zqVXz
         Oukw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UUFZ3hy4+kGr5BVmj29me3nmmAUMnwFvrmhzO7lqSPo=;
        b=FeZjKnTaM+wnD0qDGD7ccxIi00pi3Ca9SV7yV1RMYe/nHu8KXA56zfz/ZfyQ1CWFtM
         misMgEX1Zj1ZrhS3TjWq+EEXOIxsBeGCs+1QD5gwHBp/tbifoAvae0C4HQ8KI8ZXZlpL
         nQrCVVeKcEDRG+LLzYzC0mAEFzuBmkDpwkNGd1P1Cu7ADS5rRuf9KXdCZ0z2zVmzWUHn
         j+iPWRj2ohx1OJ+Kr7sYCoKqTNiyMzYAP8Xcctg28oQfKyxPyhY4eoq8KozVA0cen64D
         UrMDfH0eCBXqK8/5XlfLDH4vWX1xZQlJBAClmdSEcnrlQztkK3JJUI7b4pGCjKptoim3
         bhcA==
X-Gm-Message-State: AOAM530dFPnM8IBEsHCVG74AFw3uqNqro3seluqzoPFsJEiUGcENEvab
        ZxOEXnkN4waAH6e0+VsCJ2OiVhl2z0M=
X-Google-Smtp-Source: ABdhPJxsMmDznUJYfVRb/l2tS6kDkl9E4uHGWKOhCCO/6WuO+L/4eoFqMJCYI6kFuzkoZjd6fYYN3w==
X-Received: by 2002:a17:90b:3892:: with SMTP id mu18mr9303563pjb.143.1612631036406;
        Sat, 06 Feb 2021 09:03:56 -0800 (PST)
Received: from ast-mbp.thefacebook.com ([163.114.132.7])
        by smtp.gmail.com with ESMTPSA id j14sm11149964pjl.35.2021.02.06.09.03.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 Feb 2021 09:03:55 -0800 (PST)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, bpf@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 bpf-next 7/7] selftests/bpf: Add a test for map-in-map and per-cpu maps in sleepable progs
Date:   Sat,  6 Feb 2021 09:03:44 -0800
Message-Id: <20210206170344.78399-8-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <20210206170344.78399-1-alexei.starovoitov@gmail.com>
References: <20210206170344.78399-1-alexei.starovoitov@gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Alexei Starovoitov <ast@kernel.org>

Add a basic test for map-in-map and per-cpu maps in sleepable programs.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 tools/testing/selftests/bpf/progs/lsm.c | 69 +++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/lsm.c b/tools/testing/selftests/bpf/progs/lsm.c
index ff4d343b94b5..33694ef8acfa 100644
--- a/tools/testing/selftests/bpf/progs/lsm.c
+++ b/tools/testing/selftests/bpf/progs/lsm.c
@@ -30,6 +30,53 @@ struct {
 	__type(value, __u64);
 } lru_hash SEC(".maps");
 
+struct {
+	__uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, __u32);
+	__type(value, __u64);
+} percpu_array SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_PERCPU_HASH);
+	__uint(max_entries, 1);
+	__type(key, __u32);
+	__type(value, __u64);
+} percpu_hash SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_LRU_PERCPU_HASH);
+	__uint(max_entries, 1);
+	__type(key, __u32);
+	__type(value, __u64);
+} lru_percpu_hash SEC(".maps");
+
+struct inner_map {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, int);
+	__type(value, __u64);
+} inner_map SEC(".maps");
+
+struct outer_arr {
+	__uint(type, BPF_MAP_TYPE_ARRAY_OF_MAPS);
+	__uint(max_entries, 1);
+	__uint(key_size, sizeof(int));
+	__uint(value_size, sizeof(int));
+	__array(values, struct inner_map);
+} outer_arr SEC(".maps") = {
+	.values = { [0] = &inner_map },
+};
+
+struct outer_hash {
+	__uint(type, BPF_MAP_TYPE_HASH_OF_MAPS);
+	__uint(max_entries, 1);
+	__uint(key_size, sizeof(int));
+	__array(values, struct inner_map);
+} outer_hash SEC(".maps") = {
+	.values = { [0] = &inner_map },
+};
+
 char _license[] SEC("license") = "GPL";
 
 int monitored_pid = 0;
@@ -61,6 +108,7 @@ SEC("lsm.s/bprm_committed_creds")
 int BPF_PROG(test_void_hook, struct linux_binprm *bprm)
 {
 	__u32 pid = bpf_get_current_pid_tgid() >> 32;
+	struct inner_map *inner_map;
 	char args[64];
 	__u32 key = 0;
 	__u64 *value;
@@ -80,6 +128,27 @@ int BPF_PROG(test_void_hook, struct linux_binprm *bprm)
 	value = bpf_map_lookup_elem(&lru_hash, &key);
 	if (value)
 		*value = 0;
+	value = bpf_map_lookup_elem(&percpu_array, &key);
+	if (value)
+		*value = 0;
+	value = bpf_map_lookup_elem(&percpu_hash, &key);
+	if (value)
+		*value = 0;
+	value = bpf_map_lookup_elem(&lru_percpu_hash, &key);
+	if (value)
+		*value = 0;
+	inner_map = bpf_map_lookup_elem(&outer_arr, &key);
+	if (inner_map) {
+		value = bpf_map_lookup_elem(inner_map, &key);
+		if (value)
+			*value = 0;
+	}
+	inner_map = bpf_map_lookup_elem(&outer_hash, &key);
+	if (inner_map) {
+		value = bpf_map_lookup_elem(inner_map, &key);
+		if (value)
+			*value = 0;
+	}
 
 	return 0;
 }
-- 
2.24.1

