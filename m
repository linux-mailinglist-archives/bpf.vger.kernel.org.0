Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 392C125D740
	for <lists+bpf@lfdr.de>; Fri,  4 Sep 2020 13:29:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730232AbgIDL3T (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Sep 2020 07:29:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728263AbgIDL0C (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Sep 2020 07:26:02 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05F64C0619C4
        for <bpf@vger.kernel.org>; Fri,  4 Sep 2020 04:24:21 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id k15so6342663wrn.10
        for <bpf@vger.kernel.org>; Fri, 04 Sep 2020 04:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QTxDMqIedGHd6nEHPaqkTSyOMImcvTE/s8Ne5HgNwhY=;
        b=mzr0PB3aDKq5/Lxp4ONFu0pyaVkB36cYtaOb5BsF08YNWZmxJHN74LjX9ZwrqlpYrW
         ecugmyEAooZbNNjTjiXHnZof4QcEc0Cf4aerzP4OeA02EB08cRcOrCE+5XdDP9Xwjvyl
         8UkvynE89RuKwLnaoO3mqkCl6aPgmBWMOsT0A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QTxDMqIedGHd6nEHPaqkTSyOMImcvTE/s8Ne5HgNwhY=;
        b=IxVSi6NnysfugmCHFyGeMTv582jbzdaMqVr8UUL8CKZcIsgc7Ia2Q41oDwGti5URog
         sZI1+2mFHlp0GCQrWezY1LeezkKN5iw3OnUHOejGx+6Q5qyeeWtXR0CxUCgvInbPCviR
         Y+8QUf6P/9IJ+QYlq8s+IuVZx+yckjCwW36zTUUPDqcNaWVCBGcrAZvSLTet8ISQVDGN
         ddRDWCsgLQ63gUSCKKL8s0Xsbbh/H5uVrpZfM0iRtb7K3BhoXhBhF2h8Mg6x8m4bmtzy
         opzoXXCjQyEUoDlEHypBNOLVGwKVeG9P9cF9c1k8iXpYN8/bxDXD3a5QGYDyxlNklRpj
         H4rw==
X-Gm-Message-State: AOAM531gFXkK1fTzRCoZ6o9KPmHqT11DD5qiHxmkvBYGIxyr+Z/nSfRq
        f0HvJLY5YMTm/55A8gkyvAodqQ==
X-Google-Smtp-Source: ABdhPJwr9RvTnKQ8LB1QlqOFU/xwIYprm8BN2DMQ1bbX4TWGOaeAlGKuleWkvMPFuuC+KzSAizE+7Q==
X-Received: by 2002:adf:df0f:: with SMTP id y15mr7087825wrl.127.1599218659714;
        Fri, 04 Sep 2020 04:24:19 -0700 (PDT)
Received: from antares.lan (111.253.187.81.in-addr.arpa. [81.187.253.111])
        by smtp.gmail.com with ESMTPSA id v2sm9104408wrm.16.2020.09.04.04.24.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2020 04:24:19 -0700 (PDT)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     ast@kernel.org, yhs@fb.com, daniel@iogearbox.net, kafai@fb.com
Cc:     bpf@vger.kernel.org, kernel-team@cloudflare.com,
        Lorenz Bauer <lmb@cloudflare.com>
Subject: [PATCH bpf-next 06/11] bpf: make reference tracking in check_func_arg generic
Date:   Fri,  4 Sep 2020 12:23:56 +0100
Message-Id: <20200904112401.667645-7-lmb@cloudflare.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200904112401.667645-1-lmb@cloudflare.com>
References: <20200904112401.667645-1-lmb@cloudflare.com>
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
---
 kernel/bpf/verifier.c | 26 ++++++++++----------------
 1 file changed, 10 insertions(+), 16 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 45759638e1b8..c7df4ccad8e2 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3988,15 +3988,6 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
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
@@ -4047,13 +4038,6 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
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
@@ -4087,6 +4071,16 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
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

