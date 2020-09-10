Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FFBC26544B
	for <lists+bpf@lfdr.de>; Thu, 10 Sep 2020 23:54:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728608AbgIJVmu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Sep 2020 17:42:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730785AbgIJM7o (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 10 Sep 2020 08:59:44 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89445C061799
        for <bpf@vger.kernel.org>; Thu, 10 Sep 2020 05:57:30 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id a17so6593322wrn.6
        for <bpf@vger.kernel.org>; Thu, 10 Sep 2020 05:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jvDqkk+rK7tYvuhp9ONyqe/Hab7Pr75RWbP3/jnb6tU=;
        b=gMD1PyCVWyMgEArrcOkoqdUMw25ZiibPzGO8fE6s5ztOoWZedkNC/Z1ohykU5LSZdJ
         Cqo3ETO+Jzeqgw6u0Ui+mc/lrM4PkEuuzevaPI165IHE8SSf2GImYz7HQxlzEuXPkN9A
         JP4emccRbCO4DwyvcOtDG5j3QTH+pic9brC10=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jvDqkk+rK7tYvuhp9ONyqe/Hab7Pr75RWbP3/jnb6tU=;
        b=GXu1v4uY5ia+oBR/pSRh0BY35Vr3NsdA2pG9CWgTk/fjoJJzGSZguotsYMddl/qy4J
         TSQDLAqQDkNP4kWn5kVjZRVC621bC/tE+OUskauNls+hW4ha5vS1hSUS6Vh5XFlpTazp
         uOWfLYpj3DqEgkW9tNK61TiSmmWDzszDSN9JnlLO5qFjc5GRDmvG3tPjOklgw9gPo0ZI
         aVreap+ODcd8bIz3u05RbrIIzC6aT0nRettENiuJysE73jQIZ/MeyRo2+C5UMIJ4IIhe
         XLtfy2F/XRUvtdnv5FUg/bhRlWQ6f4XmpaXBiMhHgrDlFNVz1vmL+BUlA2U6+3qmVXHH
         Q0Rw==
X-Gm-Message-State: AOAM533MwKE0DX4uAXBye8q0Lvk6A5gfZOAeUjZ+OSpExm5Qzy5ewKQM
        E+htUk/Z1bT7KaGDpnUaL0HYTQ==
X-Google-Smtp-Source: ABdhPJxIs6DM+CHIakuqmfez4aXGGMdfzn8K1chlOe19rAUfqYR1aYfQrVTP1A6wxtlRiAHETRJROA==
X-Received: by 2002:adf:c44d:: with SMTP id a13mr8673696wrg.11.1599742649276;
        Thu, 10 Sep 2020 05:57:29 -0700 (PDT)
Received: from antares.lan (6.9.9.0.0.d.a.3.9.b.d.2.8.1.d.7.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff:7d18:2db9:3ad0:996])
        by smtp.gmail.com with ESMTPSA id v6sm8737400wrt.90.2020.09.10.05.57.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 05:57:28 -0700 (PDT)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     ast@kernel.org, yhs@fb.com, daniel@iogearbox.net, kafai@fb.com,
        andriin@fb.com
Cc:     bpf@vger.kernel.org, kernel-team@cloudflare.com,
        Lorenz Bauer <lmb@cloudflare.com>
Subject: [PATCH bpf-next v3 06/11] bpf: make reference tracking generic
Date:   Thu, 10 Sep 2020 13:56:26 +0100
Message-Id: <20200910125631.225188-7-lmb@cloudflare.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200910125631.225188-1-lmb@cloudflare.com>
References: <20200910125631.225188-1-lmb@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
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
index 850d40667182..dc68690fb5f4 100644
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

