Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 462CD69EC86
	for <lists+bpf@lfdr.de>; Wed, 22 Feb 2023 02:47:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbjBVBrY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Feb 2023 20:47:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjBVBrX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Feb 2023 20:47:23 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40AFB32E6B
        for <bpf@vger.kernel.org>; Tue, 21 Feb 2023 17:47:22 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id fb30so3537965pfb.13
        for <bpf@vger.kernel.org>; Tue, 21 Feb 2023 17:47:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oi+d4l8Cq9vDb+7VuIkyl4rONbcY2brBirVQtnXOQc8=;
        b=Boge3vGhGikAFj9rcZjNnf/0TnD1sixP3DV/Fh8W1uU+butCf2/eJGzg5CqPNpotI1
         pD9RVyyHGSSbxOyCGiTPzTVcOpjjmwqRvmbgZwBS0CjZbRt24PoRY8HtzRKhmSnW7YnK
         9K8HPXWjS6hqVMJf+ceZBsAgxOq3nEtA/EO1OH0Pj+GdqOSznYjaeM3277sv9bK/wHQA
         qC3lKE6PMTXM8cig2GUsmp0QXheEWjTr+rLrsF5loopGCGFeDMHW0DWKS5uJRTs0NQsa
         faBWKrnzjAJCGhLpv2YWVRQdYm4kXsen4YqDdn+WzQBZL4ivyckBOYhzvGzvIVBUlOp+
         mWlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Oi+d4l8Cq9vDb+7VuIkyl4rONbcY2brBirVQtnXOQc8=;
        b=JYnskxPrMAYS26W8UIXuyItE39t1mAJ5FUvUnXg/rJHeiHNFcwjX04J+HHP+t+7hJL
         QDii7KkiufGzV1sryQPNidxCtqHwY4dg4Z+Q0UqcCYhN0AYzJe2T0UT9xOayVyb+X9jU
         5y14ZxVa7ZjQ9/MwG0yhUSeT3DCSOpaAYous9rkwC5U/7pgAKoZyGANlbUOqLBOyy9nw
         xbQIebrUXPpp88+2vU3Y38gp5aUiVpQkVsAFDRXoX4taZqLcFBP3b2H1QoZ5vW2Raxok
         HEIF9d1UEHceTCtYU/+bS6NHTjaONkB6hWq4ARgyDDe80C/ThRKZfJQ0EK9FyUfrtGxc
         Uulg==
X-Gm-Message-State: AO0yUKWidy3aSc6k70D3HdFZ9PitFI9C4Ptyp/0WCTAQKz4ADne8/MyQ
        zx2ANTULlVyRvYqAJLU8dAI=
X-Google-Smtp-Source: AK7set94uSiUAI2xmCjuOo9ylXoh7FgmWsxX3b0uVgGa3lyL5Fga0+zEq4TPNUYPFE2HaNxXCtY3pA==
X-Received: by 2002:a05:6a00:cd:b0:5d6:138f:5599 with SMTP id e13-20020a056a0000cd00b005d6138f5599mr256969pfj.26.1677030441676;
        Tue, 21 Feb 2023 17:47:21 -0800 (PST)
Received: from vultr.guest ([2001:19f0:7001:5cd8:5400:4ff:fe4e:5fe5])
        by smtp.gmail.com with ESMTPSA id f15-20020aa78b0f000000b005ac419804d3sm3811509pfd.186.2023.02.21.17.47.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 17:47:21 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, horenc@vt.edu,
        xiyou.wangcong@gmail.com
Cc:     bpf@vger.kernel.org, Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH bpf-next v2 17/18] bpf: offload map memory usage
Date:   Wed, 22 Feb 2023 01:45:52 +0000
Message-Id: <20230222014553.47744-18-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230222014553.47744-1-laoar.shao@gmail.com>
References: <20230222014553.47744-1-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

A new helper is introduced to calculate offload map memory usage. But
currently the memory dynamically allocated in netdev dev_ops, like
nsim_map_update_elem, is not counted. Let's just put it aside now.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 include/linux/bpf.h  | 6 ++++++
 kernel/bpf/offload.c | 6 ++++++
 kernel/bpf/syscall.c | 1 +
 3 files changed, 13 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index bca0963..e50e5e1 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2568,6 +2568,7 @@ static inline bool bpf_map_is_offloaded(struct bpf_map *map)
 
 struct bpf_map *bpf_map_offload_map_alloc(union bpf_attr *attr);
 void bpf_map_offload_map_free(struct bpf_map *map);
+u64 bpf_map_offload_map_mem_usage(const struct bpf_map *map);
 int bpf_prog_test_run_syscall(struct bpf_prog *prog,
 			      const union bpf_attr *kattr,
 			      union bpf_attr __user *uattr);
@@ -2639,6 +2640,11 @@ static inline void bpf_map_offload_map_free(struct bpf_map *map)
 {
 }
 
+static inline u64 bpf_map_offload_map_mem_usage(const struct bpf_map *map);
+{
+	return 0;
+}
+
 static inline int bpf_prog_test_run_syscall(struct bpf_prog *prog,
 					    const union bpf_attr *kattr,
 					    union bpf_attr __user *uattr)
diff --git a/kernel/bpf/offload.c b/kernel/bpf/offload.c
index 0c85e06..d9c9f45 100644
--- a/kernel/bpf/offload.c
+++ b/kernel/bpf/offload.c
@@ -563,6 +563,12 @@ void bpf_map_offload_map_free(struct bpf_map *map)
 	bpf_map_area_free(offmap);
 }
 
+u64 bpf_map_offload_map_mem_usage(const struct bpf_map *map)
+{
+	/* The memory dynamically allocated in netdev dev_ops is not counted */
+	return sizeof(struct bpf_offloaded_map);
+}
+
 int bpf_map_offload_lookup_elem(struct bpf_map *map, void *key, void *value)
 {
 	struct bpf_offloaded_map *offmap = map_to_offmap(map);
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 8333aa0..e12b03e 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -105,6 +105,7 @@ int bpf_check_uarg_tail_zero(bpfptr_t uaddr,
 	.map_alloc = bpf_map_offload_map_alloc,
 	.map_free = bpf_map_offload_map_free,
 	.map_check_btf = map_check_no_btf,
+	.map_mem_usage = bpf_map_offload_map_mem_usage,
 };
 
 static struct bpf_map *find_and_alloc_map(union bpf_attr *attr)
-- 
1.8.3.1

