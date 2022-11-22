Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66FD8633F89
	for <lists+bpf@lfdr.de>; Tue, 22 Nov 2022 15:54:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234128AbiKVOyu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 22 Nov 2022 09:54:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233884AbiKVOxr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 22 Nov 2022 09:53:47 -0500
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19BA031EF6;
        Tue, 22 Nov 2022 06:53:07 -0800 (PST)
Received: by mail-qt1-f182.google.com with SMTP id h24so9378615qta.9;
        Tue, 22 Nov 2022 06:53:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p4O1j+FTYhgropL6ZEAaxt9d0t6JxFTTNDaB9rWhEes=;
        b=4OFBzA4VkhDC40zAN5+S+D7ap08rkyRSIpXHlH6KXp/4wGgJpyz4jGKq18/OBf+5PL
         Q712pAtyKm9ErZfv+BOAtz21nQRA11CVxhQ7UjMpmDR1XL53KHy4HBzhPXf5D3V8+Q67
         53UVFb3RD46F7j6/jMZE+G4PtrJSbve+S6PPpGzmLgccuUb1N3oipSGAohGS5xAW51MG
         +h0ksfxSs/9Jf19rkDaDwh+ofLmqbOSNrKq3yV5UpcOSda9QgcaMGK2sEiCtXCVziczt
         +JdBGd1SlB2zqLIOiE8RVIrfLaslyB7HI0Kek80ZYUVq7WyIBlSB+0Vcu/4T2djQ10b/
         PdDQ==
X-Gm-Message-State: ANoB5plEs2aqSOOc0MGpdNWYVdzTtlfkI22QjArlY1qnLHJTxVvua6mQ
        0sxw+7TeFIaLiG2ZHmLa1oOPOiRtH2jsZWbN
X-Google-Smtp-Source: AA0mqf4Tve61XhyRWQo4b8UXgOUtJOzDdqSdMG7+km8HIPjj4kbzyNR0b5rkdw+AGIpUAuX2lZZWIw==
X-Received: by 2002:ac8:72c2:0:b0:3a5:2a33:d250 with SMTP id o2-20020ac872c2000000b003a52a33d250mr22307352qtp.568.1669128785740;
        Tue, 22 Nov 2022 06:53:05 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:3170])
        by smtp.gmail.com with ESMTPSA id k7-20020ac80747000000b003a4d5fed8c3sm8212633qth.85.2022.11.22.06.53.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 06:53:05 -0800 (PST)
From:   David Vernet <void@manifault.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        martin.lau@linux.dev, yhs@fb.com, song@kernel.org, sdf@google.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, jolsa@kernel.org,
        haoluo@google.com, tj@kernel.org, kernel-team@fb.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next 1/2] bpf: Add bpf_task_from_pid() kfunc
Date:   Tue, 22 Nov 2022 08:52:59 -0600
Message-Id: <20221122145300.251210-2-void@manifault.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221122145300.251210-1-void@manifault.com>
References: <20221122145300.251210-1-void@manifault.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Callers can currently store tasks as kptrs using bpf_task_acquire(),
bpf_task_kptr_get(), and bpf_task_release(). These are useful if a
caller already has a struct task_struct *, but there may be some callers
who only have a pid, and want to look up the associated struct
task_struct * from that to e.g. find task->comm.

This patch therefore adds a new bpf_task_from_pid() kfunc which allows
BPF programs to get a struct task_struct * kptr from a pid.

Signed-off-by: David Vernet <void@manifault.com>
---
 kernel/bpf/helpers.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 9e8a5557ea8d..d5a849d44a35 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1879,6 +1879,25 @@ void bpf_task_release(struct task_struct *p)
 	put_task_struct_rcu_user(p);
 }
 
+/**
+ * bpf_task_from_pid - Find a struct task_struct from its pid by looking it up
+ * in the root pid namespace idr. If a task is returned, it must either be
+ * stored in a map, or released with bpf_task_release().
+ * @pid: The pid of the task being looked up.
+ */
+struct task_struct *bpf_task_from_pid(s32 pid)
+{
+	struct task_struct *p;
+
+	rcu_read_lock();
+	p = find_task_by_pid_ns(pid, &init_pid_ns);
+	if (p)
+		bpf_task_acquire(p);
+	rcu_read_unlock();
+
+	return p;
+}
+
 void *bpf_cast_to_kern_ctx(void *obj)
 {
 	return obj;
@@ -1904,6 +1923,7 @@ BTF_ID_FLAGS(func, bpf_list_pop_back, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_task_acquire, KF_ACQUIRE | KF_TRUSTED_ARGS)
 BTF_ID_FLAGS(func, bpf_task_kptr_get, KF_ACQUIRE | KF_KPTR_GET | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_task_release, KF_RELEASE)
+BTF_ID_FLAGS(func, bpf_task_from_pid, KF_ACQUIRE | KF_RET_NULL)
 BTF_SET8_END(generic_btf_ids)
 
 static const struct btf_kfunc_id_set generic_kfunc_set = {
-- 
2.38.1

