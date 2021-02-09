Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA9B315832
	for <lists+bpf@lfdr.de>; Tue,  9 Feb 2021 22:01:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234228AbhBIU6E (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Feb 2021 15:58:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234053AbhBIUtj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Feb 2021 15:49:39 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 571BBC061A86
        for <bpf@vger.kernel.org>; Tue,  9 Feb 2021 11:49:10 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id o7so13179058pgl.1
        for <bpf@vger.kernel.org>; Tue, 09 Feb 2021 11:49:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4VaKfGywaG+qquwOXdd9aHLw00AX3G7ubALIgBFTaBM=;
        b=TXQJZGwln1+OM6wVN1PkN/c5i+AA/DHY4e5mqGKbEfW/RD0Qa6RwjPIX5WqdS4WNKg
         BheZJIayKhwWeAqgWjQ9HyILpOm7IFr9J6EnhUYiar8CBRmh5i0K8GB8REvS7BuQ55r5
         1cb6hKwdYmB9hfek33KqjKi4QiLX94IEl6v69l409GvDjnycBPX4iZXYTTSRSrMfYPPq
         /dAHFCHjzueW47lLi5VKzJ3wXfJFF+F4BpuZhw6twuCwQcuSCCoaNNbrlL3ZOE8WRESq
         v+s/RBVJ9YX5aSMk90DtMzlcJ+i0G3fVi11GagOfx+h2WL+XPAnFYVNgQfgVVE9yv+Ev
         5Vag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4VaKfGywaG+qquwOXdd9aHLw00AX3G7ubALIgBFTaBM=;
        b=l4j5AZi9LCTjKDoDMrugPlqEgnzWTQ4j7DLyht6h8F75Id+qNiqxofFQ3pBQtDCjky
         3akge0vEz9/hVy+VgSP85rEXJIOfuw4vNtp0TkESUGdA//vabbz+T0u3P4IJ7TdVscw1
         9B1Mg4HGzpbCZOWdCtQREA5CMPBHaR3+GwM0HQ6PkiY/wmDgbPzb2gNX37JzyOF4NFlG
         0a9iLoz/AR/D1PmKLBqZa10D0DLc/PvI4TXsri0jiDJhGBd9M2hNPa4zY4CvRF00Ag0s
         ZWUuDDOi/WsAwIngN1rW23A7+OYwbL0EQQ35SeDCCiRH0CWIYNhZU8kR6jHDi1LYOMpS
         RXzA==
X-Gm-Message-State: AOAM530MtBh2X+F2wRuD8jR094eR0dcz7JPMU5WOgBPrjMp9XPal5gPv
        L+W9PxKQ514cTQEbQrhAOXrVYZMzvS4=
X-Google-Smtp-Source: ABdhPJxV1zkpKFFYWRJSacoywC3T3xw/bniSWsKeNUQ5wf2N6zTp65MfEEGY3zCls19xFF4vUgo+PA==
X-Received: by 2002:a63:8f59:: with SMTP id r25mr18233891pgn.161.1612900150006;
        Tue, 09 Feb 2021 11:49:10 -0800 (PST)
Received: from ast-mbp.thefacebook.com ([163.114.132.7])
        by smtp.gmail.com with ESMTPSA id j22sm139123pff.57.2021.02.09.11.49.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Feb 2021 11:49:09 -0800 (PST)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, bpf@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 bpf-next 8/8] selftests/bpf: Add a test for map-in-map and per-cpu maps in sleepable progs
Date:   Tue,  9 Feb 2021 11:48:56 -0800
Message-Id: <20210209194856.24269-9-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <20210209194856.24269-1-alexei.starovoitov@gmail.com>
References: <20210209194856.24269-1-alexei.starovoitov@gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Alexei Starovoitov <ast@kernel.org>

Add a basic test for map-in-map and per-cpu maps in sleepable programs.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
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

