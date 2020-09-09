Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 898AB2633E8
	for <lists+bpf@lfdr.de>; Wed,  9 Sep 2020 19:12:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731222AbgIIRMM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Sep 2020 13:12:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731208AbgIIRML (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Sep 2020 13:12:11 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0733C061756
        for <bpf@vger.kernel.org>; Wed,  9 Sep 2020 10:12:10 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id l9so3150438wme.3
        for <bpf@vger.kernel.org>; Wed, 09 Sep 2020 10:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VGnSte/PWuuWLLiQPY0aYt8mPU312KivF/nZQTZv/vI=;
        b=WpFGeKWcWeTMlZMgEq7iQ/ScGrbXWZXq3F9nmybPXUfnNCfe+f5jC4Ha8XfRH2ZFzN
         vw8IQg2iOUj6Nj+draUVJ3356HsY/5Tc0VvFO1T9KVqfdE7IRusJBFpCzTKbtTvICwYE
         ltBnB3o+aeVE8BvSSgIyTr2YjFMQxun2YeeOE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VGnSte/PWuuWLLiQPY0aYt8mPU312KivF/nZQTZv/vI=;
        b=WzhHxwki8VQygd3EH3GPeA1tWLv5Mywp2u1d3ovgC/SLKm1+G/ia+YArtCGeDcApkA
         jq1jo7s5+8Y2/jxXiMnvVqha8v+CkyBMovNtvrpMs+4C1njdr1e11QBAhF3YGknNtJHF
         23ITYVjDWLf16BvNlzl9oZd9xdEC8rV5GZq7fU6m996Vn/46HiZ2H2r0+H3IYut0XMQJ
         O9eAewpfeaBlMPJLQ8XM6NJPEVFJtVlmDfTSa99T3RqjHzQ/Ie07z8kr6GhD1DCD72/L
         SNSXjIoebnyndoouRLAugZePE9Toe6tYMVC6DTqIgMQfwZ7jbtlt3JRDI3YTK9WSpk0f
         ujUQ==
X-Gm-Message-State: AOAM5315bz84CpQjnFJLcWs0bj6Ywxcd2Snsg54vQTQt+EnQHeG3l8Do
        SwhEFHhf0mZ2llPTBcEaRhHBUA==
X-Google-Smtp-Source: ABdhPJzrlV4yhxJEWfmwLG4dw7f+Gad535rSlmWd8AiWJFu6b39NFY4i/EsjQetGu9XJp9Ea540u/A==
X-Received: by 2002:a7b:c255:: with SMTP id b21mr4414735wmj.17.1599671529357;
        Wed, 09 Sep 2020 10:12:09 -0700 (PDT)
Received: from antares.lan (1.3.0.0.8.d.4.4.b.b.8.a.1.4.5.e.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff:e541:a8bb:44d8:31])
        by smtp.gmail.com with ESMTPSA id g131sm3746743wmf.25.2020.09.09.10.12.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 10:12:08 -0700 (PDT)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     ast@kernel.org, yhs@fb.com, daniel@iogearbox.net, kafai@fb.com,
        andriin@fb.com
Cc:     bpf@vger.kernel.org, kernel-team@cloudflare.com,
        Lorenz Bauer <lmb@cloudflare.com>
Subject: [PATCH bpf-next v2 06/11] bpf: make reference tracking generic
Date:   Wed,  9 Sep 2020 18:11:50 +0100
Message-Id: <20200909171155.256601-7-lmb@cloudflare.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200909171155.256601-1-lmb@cloudflare.com>
References: <20200909171155.256601-1-lmb@cloudflare.com>
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
---
 kernel/bpf/verifier.c | 26 ++++++++++----------------
 1 file changed, 10 insertions(+), 16 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index b949e0afef8a..43df3bae93aa 100644
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

