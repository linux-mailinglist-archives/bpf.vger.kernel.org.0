Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20E10272374
	for <lists+bpf@lfdr.de>; Mon, 21 Sep 2020 14:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbgIUMN3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 21 Sep 2020 08:13:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726767AbgIUMNY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 21 Sep 2020 08:13:24 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EE63C0613D3
        for <bpf@vger.kernel.org>; Mon, 21 Sep 2020 05:13:24 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id y15so12401442wmi.0
        for <bpf@vger.kernel.org>; Mon, 21 Sep 2020 05:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FX7gRVNUI/UcPgeW8DERQX7S3d1U46YyTQ3a8yJH4B8=;
        b=Ya4zp/oFM0uXOoDh7IxcMEGQwgDsf5CXIhwLPI3D1Trcuao0rZ/PVabG6zw5d2Wrgq
         MNuf3+6mMmdsim0aVEU4zdDWbKQK0FR8LCyJ1VH9ALpVc4OBF3PzbKrsIxMF1pnN7q44
         eJU2WfUrZY0bLNm+NaxA2OQEk1gEa65vU8sD0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FX7gRVNUI/UcPgeW8DERQX7S3d1U46YyTQ3a8yJH4B8=;
        b=GlHS+jBmc7Ju5Nzo6c9uXgI86sctmM/rSlJHQrl8dUvT85PpUTZ/DuzpU41ebNlO+z
         0emanzIS3N/7+1lYiauAgpQBCbbn8+qXS4lfvJLW4hQWevgG0RoThxkCs+tzTkegOCNu
         VNBYZJWC2MT8gEBDp69tsq9K5ED5OxWfSjeqZL+VZ1t3TcUejeqtUWuJjz4CuZqIezix
         XLTEboOpAO6/EgfL1plgmIa7hbdTX4X1D0zdVkvXUO5iSg8bb7Aw98LgHv7UcKj9DY0b
         3ArEJWH6EoOTMKm5dIbupsKxS4XmXgprH2NPXwZoNTnLwYG/5yDsDBp8NCk6PY6p78Uh
         BD9g==
X-Gm-Message-State: AOAM531LIt7rSZBhwgG+dTCTKi7czw2vVYr1U8vITsZqI9D+GGgLKfjx
        8m9M8MypWlJ11VfFmprjadtEXA==
X-Google-Smtp-Source: ABdhPJyRIV5vAyRehQsAoulIA1IlhQsYgCkDqMhQKInljIITFQZMuX9QFhYubFiOoTZoqMEupKJJcg==
X-Received: by 2002:a1c:6a11:: with SMTP id f17mr28226044wmc.143.1600690402922;
        Mon, 21 Sep 2020 05:13:22 -0700 (PDT)
Received: from antares.lan (5.4.6.2.d.5.3.3.f.8.1.6.b.2.d.8.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff:8d2b:618f:335d:2645])
        by smtp.gmail.com with ESMTPSA id t15sm18466557wmj.15.2020.09.21.05.13.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2020 05:13:22 -0700 (PDT)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     ast@kernel.org, daniel@iogearbox.net
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        Lorenz Bauer <lmb@cloudflare.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Martin KaFai Lau <kafai@fb.com>
Subject: [PATCH bpf-next v4 06/11] bpf: make reference tracking generic
Date:   Mon, 21 Sep 2020 13:12:22 +0100
Message-Id: <20200921121227.255763-7-lmb@cloudflare.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200921121227.255763-1-lmb@cloudflare.com>
References: <20200921121227.255763-1-lmb@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Instead of dealing with reg->ref_obj_id individually for every arg type that
needs it, rely on the fact that ref_obj_id is zero if the register is not
reference tracked.

Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
Acked-by: Andrii Nakryiko <andriin@fb.com>
Acked-by: Martin KaFai Lau <kafai@fb.com>
---
 kernel/bpf/verifier.c | 26 ++++++++++----------------
 1 file changed, 10 insertions(+), 16 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 99c0d7adcb1e..0f7a9c65db5c 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3983,15 +3983,6 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 		/* Any sk pointer can be ARG_PTR_TO_SOCK_COMMON */
 		if (!type_is_sk_pointer(type))
 			goto err_type;
-		if (reg->ref_obj_id) {
-			if (meta->ref_obj_id) {
-				verbose(env, "verifier internal error: more than one arg with ref_obj_id R%d %u %u\n",
-					regno, reg->ref_obj_id,
-					meta->ref_obj_id);
-				return -EFAULT;
-			}
-			meta->ref_obj_id = reg->ref_obj_id;
-		}
 	} else if (arg_type == ARG_PTR_TO_SOCKET ||
 		   arg_type == ARG_PTR_TO_SOCKET_OR_NULL) {
 		expected_type = PTR_TO_SOCKET;
@@ -4040,13 +4031,6 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 			/* final test in check_stack_boundary() */;
 		else if (type != expected_type)
 			goto err_type;
-		if (meta->ref_obj_id) {
-			verbose(env, "verifier internal error: more than one arg with ref_obj_id R%d %u %u\n",
-				regno, reg->ref_obj_id,
-				meta->ref_obj_id);
-			return -EFAULT;
-		}
-		meta->ref_obj_id = reg->ref_obj_id;
 	} else if (arg_type_is_int_ptr(arg_type)) {
 		expected_type = PTR_TO_STACK;
 		if (!type_is_pkt_pointer(type) &&
@@ -4078,6 +4062,16 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 		}
 	}
 
+	if (reg->ref_obj_id) {
+		if (meta->ref_obj_id) {
+			verbose(env, "verifier internal error: more than one arg with ref_obj_id R%d %u %u\n",
+				regno, reg->ref_obj_id,
+				meta->ref_obj_id);
+			return -EFAULT;
+		}
+		meta->ref_obj_id = reg->ref_obj_id;
+	}
+
 	if (arg_type == ARG_CONST_MAP_PTR) {
 		/* bpf_map_xxx(map_ptr) call: remember that map_ptr */
 		meta->map_ptr = reg->map_ptr;
-- 
2.25.1

