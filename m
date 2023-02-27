Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33CD46A45F5
	for <lists+bpf@lfdr.de>; Mon, 27 Feb 2023 16:21:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbjB0PVs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Feb 2023 10:21:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbjB0PVq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Feb 2023 10:21:46 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEACF21A11
        for <bpf@vger.kernel.org>; Mon, 27 Feb 2023 07:21:44 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id h8so3763601plf.10
        for <bpf@vger.kernel.org>; Mon, 27 Feb 2023 07:21:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q9Z5DKhfz6PQXivX8D2qLY+IJ9SYZdE33NA/HYP26PU=;
        b=YeHoBBXZUnjCKBS3Pdl9+IPNtAUJLLCiGExuFVntMiCIGvFXr1et5QKFYcnTquLHsY
         DtL41lbDIV2LUo6P7Pwhz0n5FoHVY6HNrNJrUDAZUmMe2ENhIbdSrZVO2tPkmcrQ5c9Q
         fPH7slIDkU8ehlddDh+0g5mfB47QEfxlhJIHIRWyOH+5Kmz/+tda0vgVemsn/T7al/Rf
         NC5y3Lag4B/dkMVWWHIcwaPnYWZ9qXpDE5wE2DVEPpKfT8mRuFeeUZrni/7z/gSbb4vW
         p5SjLYjwCrO5JHwDNdn8t7ZBNyqHX2eKjdX3p8Hv4VccHGZauJbp4DVQ9hdg/Tm+MKdu
         90Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q9Z5DKhfz6PQXivX8D2qLY+IJ9SYZdE33NA/HYP26PU=;
        b=JhQUE3EhFvGdlLvZHaN0vt9fuv5rlRtPsf/hAtI7ygjBBMTncXXzjdPa3XyzmfUddn
         Gg2PYaghAIS6V4JWtXbyqhxX4760L0XZbQNk+Nl8I7zLJB9AwURo6k2f5Ulu6vpUwOqw
         5dkF17enR+VdMoe9r88/5dI68gxZYkPpyQzvbeiUk1hXY/pbVdWUmOJ7ExW3lJnBXw7L
         Z926/Nq+qQa+iYBQgUeo+qTE+vV3i6W1QudBRfS3RK1z5UFU1+1dZZbxGZaP8+mv6G2t
         UMxolvYFuCfRVPU6NzaGgv5ssV/IKKhg68uvzPL1HFf7M5mwDu7am5Xuexp7zOlED1vn
         030Q==
X-Gm-Message-State: AO0yUKVITpLqZm9pdKZYAdXq2871O8W+7+2UrK7AD6ADdNYLadKAZuT5
        6TRtLPoKUye19ZX1jH73zD8=
X-Google-Smtp-Source: AK7set9vru8Y31spVr9dxRvBxxFytTCIMF5tXv6u63jwB8o+V3wrstKE7iSyX268UzXjdaEgNFRarg==
X-Received: by 2002:a05:6a20:6982:b0:bb:9d1c:ede5 with SMTP id t2-20020a056a20698200b000bb9d1cede5mr12674961pzk.19.1677511304274;
        Mon, 27 Feb 2023 07:21:44 -0800 (PST)
Received: from vultr.guest ([2401:c080:1000:4a6a:5400:4ff:fe53:1982])
        by smtp.gmail.com with ESMTPSA id n2-20020a62e502000000b00589a7824703sm4326825pff.194.2023.02.27.07.21.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 07:21:43 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, horenc@vt.edu,
        xiyou.wangcong@gmail.com
Cc:     bpf@vger.kernel.org, Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH bpf-next v3 17/18] bpf: offload map memory usage
Date:   Mon, 27 Feb 2023 15:20:31 +0000
Message-Id: <20230227152032.12359-18-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230227152032.12359-1-laoar.shao@gmail.com>
References: <20230227152032.12359-1-laoar.shao@gmail.com>
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
index bca0963..341e8df 100644
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
 
+static inline u64 bpf_map_offload_map_mem_usage(const struct bpf_map *map)
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

