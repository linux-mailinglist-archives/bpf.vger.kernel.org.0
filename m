Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 662B32633E9
	for <lists+bpf@lfdr.de>; Wed,  9 Sep 2020 19:12:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730271AbgIIRMV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Sep 2020 13:12:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730337AbgIIRMQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Sep 2020 13:12:16 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FD5FC061755
        for <bpf@vger.kernel.org>; Wed,  9 Sep 2020 10:12:15 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id s12so3766450wrw.11
        for <bpf@vger.kernel.org>; Wed, 09 Sep 2020 10:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dJFl+2zg7LbqBMwza/2tMQ9lfaScC9r4gXZCukHKDe0=;
        b=fKsQWMJoPL235m7NefmqtGpPT++wzZujdhD6vULkEV12e04isD6p4f+FgQuw8XVH/s
         Yc0JeNDWrayp2d7l+p/LRKKzKTbAg0RLZcUU/pPdK+9K018h12WHWXYFvxuD4IOqw2Rz
         hDh1RWRMcbwB7uu1k1M3QtDoQl0GrEfRK4u10=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dJFl+2zg7LbqBMwza/2tMQ9lfaScC9r4gXZCukHKDe0=;
        b=GYhN4Cf9p1igspmq0a+RGUnfzlnKgrSoOv4K/df/oJ/ZDSQbYUBLTph4roCDfWDOSY
         /OkCHMr6unQDr1jvcL3FmWtpZaI3YCnMMmLCKLFPuU7q0mJo0w+xAWIa/Fatj5woswn/
         qK5WdQub3ZC7bJXF5j+2A69/UhhPUOP7KLgqljV4aaGGsSjpSTLeavFOiJbhNaTmWAvK
         8eaVf4wWBwJigwMYJrS603eUJ0965SfS9b03KevcknTg9OsOCyzKFK+euNnkXD6HPEDk
         BiiFGg+5tZCYBlAs0XjSNK7oTpNlev6kp/lt9OqdC55P5FcEV0SxkfzwSuZ2qsOg1+Ao
         N/2Q==
X-Gm-Message-State: AOAM532ZbIxeQ973j03SLdqtSjYffcMCqVsmTeep6xlDpLtonO7WVfsP
        7cYWOpkQiGChY224qbHB1bR2OQ==
X-Google-Smtp-Source: ABdhPJwJLWgvWl+G3RGH7RHYsuvWaJDFL0yP6FNCWuhZtJ5APySW3zwOP23EMH4eb7p5MrYKVFpoTA==
X-Received: by 2002:a5d:4151:: with SMTP id c17mr5255496wrq.302.1599671534256;
        Wed, 09 Sep 2020 10:12:14 -0700 (PDT)
Received: from antares.lan (1.3.0.0.8.d.4.4.b.b.8.a.1.4.5.e.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff:e541:a8bb:44d8:31])
        by smtp.gmail.com with ESMTPSA id g131sm3746743wmf.25.2020.09.09.10.12.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 10:12:13 -0700 (PDT)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     ast@kernel.org, yhs@fb.com, daniel@iogearbox.net, kafai@fb.com,
        andriin@fb.com
Cc:     bpf@vger.kernel.org, kernel-team@cloudflare.com,
        Lorenz Bauer <lmb@cloudflare.com>
Subject: [PATCH bpf-next v2 09/11] bpf: check ARG_PTR_TO_SPINLOCK register type in check_func_arg
Date:   Wed,  9 Sep 2020 18:11:53 +0100
Message-Id: <20200909171155.256601-10-lmb@cloudflare.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200909171155.256601-1-lmb@cloudflare.com>
References: <20200909171155.256601-1-lmb@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Move the check for PTR_TO_MAP_VALUE to check_func_arg, where all other
checking is done as well. Move the invocation of process_spin_lock away
from the register type checking, to allow a future refactoring.

Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
---
 kernel/bpf/verifier.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e0ab3b8c489d..42f68ffa2b52 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3781,10 +3781,6 @@ static int process_spin_lock(struct bpf_verifier_env *env, int regno,
 	struct bpf_map *map = reg->map_ptr;
 	u64 val = reg->var_off.value;
 
-	if (reg->type != PTR_TO_MAP_VALUE) {
-		verbose(env, "R%d is not a pointer to map_value\n", regno);
-		return -EINVAL;
-	}
 	if (!is_const) {
 		verbose(env,
 			"R%d doesn't have constant offset. bpf_spin_lock has to be at the constant offset\n",
@@ -3993,16 +3989,9 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 		if (type != expected_type)
 			goto err_type;
 	} else if (arg_type == ARG_PTR_TO_SPIN_LOCK) {
-		if (meta->func_id == BPF_FUNC_spin_lock) {
-			if (process_spin_lock(env, regno, true))
-				return -EACCES;
-		} else if (meta->func_id == BPF_FUNC_spin_unlock) {
-			if (process_spin_lock(env, regno, false))
-				return -EACCES;
-		} else {
-			verbose(env, "verifier internal error\n");
-			return -EFAULT;
-		}
+		expected_type = PTR_TO_MAP_VALUE;
+		if (type != expected_type)
+			goto err_type;
 	} else if (arg_type_is_mem_ptr(arg_type)) {
 		expected_type = PTR_TO_STACK;
 		/* One exception here. In case function allows for NULL to be
@@ -4108,6 +4097,17 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 		err = check_helper_mem_access(env, regno,
 					      meta->map_ptr->value_size, false,
 					      meta);
+	} else if (arg_type == ARG_PTR_TO_SPIN_LOCK) {
+		if (meta->func_id == BPF_FUNC_spin_lock) {
+			if (process_spin_lock(env, regno, true))
+				return -EACCES;
+		} else if (meta->func_id == BPF_FUNC_spin_unlock) {
+			if (process_spin_lock(env, regno, false))
+				return -EACCES;
+		} else {
+			verbose(env, "verifier internal error\n");
+			return -EFAULT;
+		}
 	} else if (arg_type_is_mem_ptr(arg_type)) {
 		/* The access to this pointer is only checked when we hit the
 		 * next is_mem_size argument below.
-- 
2.25.1

