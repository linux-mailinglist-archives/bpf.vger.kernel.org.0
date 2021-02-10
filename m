Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2940A315DDA
	for <lists+bpf@lfdr.de>; Wed, 10 Feb 2021 04:38:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231269AbhBJDiB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Feb 2021 22:38:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbhBJDiA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Feb 2021 22:38:00 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23313C061793
        for <bpf@vger.kernel.org>; Tue,  9 Feb 2021 19:36:50 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id q20so382182pfu.8
        for <bpf@vger.kernel.org>; Tue, 09 Feb 2021 19:36:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DZJd/YF3DiVLSxSb90+M096cbfDvCusfguUpNecrdPE=;
        b=p9SfGtAHXS7VxzQhknu4XEaGLDxLc/+giLrysnny6QyH8o0s9Wp80AvSAZLbsiNV5T
         DamSKWsezXKgdFjl+3BXEV3Nv2B9zk6gJsg+2VtV0dpc7nK24wLHbdMemB/fdjAh9Kuj
         My4bYG0emXylSkEK0wabdztdq/9WARlQVFeulFLR9RgnaBumUVhUjcSFI8oxg0UOOyZ8
         w25XjuXQeapYPau/p1dIMkX7KPzJcJxXEirsGT0Ncs/kUEvs43oRHU0a4KVWDGmEinJq
         xVcnyzUQ/0D9WXQMhsdUGX2LmNCw/PDF21iHqOtw+3l4t70j3R7AKvHNJInUdiUpNFrF
         07Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DZJd/YF3DiVLSxSb90+M096cbfDvCusfguUpNecrdPE=;
        b=nOcU5xucHpPamyGMBAtY+7hlVvK/jnJz8moq4h2GLPOtCkRsGe6X+L+1oFcXj3c/rR
         QP3QKfzlz1XvK1+8yW0QFPzUi75SLaXmPzHCT+4sbW+IJw9EMxXxZGeJ3eTBVkIm2YUi
         GcwChji4tI42PefFgWr3+ZAkr08xUqQvIZ9Jci83SjmsrQrpHU+1ebFwqy21sc7oD8vQ
         1op1TgK1FhwfUWsEgz/F1/G8xIJDBV4Q92nUGyt2QBU/yI/fu0/QCnbFmWg0EcP+guh7
         83iDQNrDZNb+GiIljWR5RdNFvBz5vTlZ+OinTSeLGRb1XB+GrBnZqlWG3XiUM812OGie
         Bl5w==
X-Gm-Message-State: AOAM530vbE9rz1t25lN41QE37nLsravlb9RiVGFdZ8B6i6PyGCcKZAfw
        yjQpcUPv1tPArfEYykOjipo=
X-Google-Smtp-Source: ABdhPJxv2RxzgmDx/bWNyJ8lZdRLANCxYneD/3qOJwHKzgTLJUtAox5loCeKzcZq7iYsUDeexjMtEw==
X-Received: by 2002:aa7:9736:0:b029:1b9:c4f5:54d5 with SMTP id k22-20020aa797360000b02901b9c4f554d5mr983482pfg.47.1612928209720;
        Tue, 09 Feb 2021 19:36:49 -0800 (PST)
Received: from ast-mbp.thefacebook.com ([163.114.132.7])
        by smtp.gmail.com with ESMTPSA id f7sm391099pjh.45.2021.02.09.19.36.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Feb 2021 19:36:49 -0800 (PST)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, bpf@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v4 bpf-next 9/9] selftests/bpf: Add a test for map-in-map and per-cpu maps in sleepable progs
Date:   Tue,  9 Feb 2021 19:36:34 -0800
Message-Id: <20210210033634.62081-10-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <20210210033634.62081-1-alexei.starovoitov@gmail.com>
References: <20210210033634.62081-1-alexei.starovoitov@gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Alexei Starovoitov <ast@kernel.org>

Add a basic test for map-in-map and per-cpu maps in sleepable programs.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Acked-by: KP Singh <kpsingh@kernel.org>
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

