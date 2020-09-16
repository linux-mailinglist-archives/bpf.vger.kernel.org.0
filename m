Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4169226C68F
	for <lists+bpf@lfdr.de>; Wed, 16 Sep 2020 19:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727346AbgIPRzL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Sep 2020 13:55:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727294AbgIPRyY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 16 Sep 2020 13:54:24 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 767D0C061351
        for <bpf@vger.kernel.org>; Wed, 16 Sep 2020 10:53:40 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id s13so3605901wmh.4
        for <bpf@vger.kernel.org>; Wed, 16 Sep 2020 10:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FX7gRVNUI/UcPgeW8DERQX7S3d1U46YyTQ3a8yJH4B8=;
        b=clZbLWp2gViCbRNgIfmljtoEaxC4MhuKfg78ZwFjs2bRWeh1HaXh4NOy0Mv+enLRD0
         0JDquIINO0hDQrrWga+0iwT9FUhLE6AhArZXVe7je1tGgCG3lPBHjx45d1LV2CJkp8Ip
         KVFl1OUpZWxKYv9WltLhrRkANI3lXQpE7/Ou0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FX7gRVNUI/UcPgeW8DERQX7S3d1U46YyTQ3a8yJH4B8=;
        b=L/GoAqaa/BZi+riI9Wg9p4fZQgfp6YGpkt4CgtF6kTDUMoKVlna0QjGifQSUvsn1g8
         o/9C8p18uvbtkpOtdQyor6n4uM0bB1ZYsVCc1mKCE8kaoUe+d9oPJYcPW73vWluMfWVE
         tLWbkGlUr8I19VGv9+J/3tiFPbkbGcqt/lNTYQtOsEnjcUFzIMFeyWZE6CQKk06AcULX
         Y90q+1too7PU85prH7pP5zUB3xqxuR0xxg9yzp7UYLRyMg2vl0bgCCMuv5dSpjf+1Pl4
         5I3Zn70tuVl41YYbFGYnkTlj7vklZbR++Mt520ioKRG4m2MuG/RxN75EW2dZlmofwoCY
         T+Yw==
X-Gm-Message-State: AOAM532mvT85fYVC4dAFwwmX+73m8Hs6RFLJMWEmfumhLvMOQM/u8FlB
        8Oq9oNtIuC5XdCozbgGbQuaioA==
X-Google-Smtp-Source: ABdhPJzm9o+Fws3Zk8ExhfNd1H6iNHtpL5AWCoTTgGOmJu8BQNeuCmlZtaJqRt1dEuCi31bAQ4kNWw==
X-Received: by 2002:a05:600c:22d1:: with SMTP id 17mr5928300wmg.58.1600278819093;
        Wed, 16 Sep 2020 10:53:39 -0700 (PDT)
Received: from antares.lan (5.c.5.5.a.2.f.6.a.a.d.6.3.1.9.1.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff:1913:6daa:6f2a:55c5])
        by smtp.gmail.com with ESMTPSA id v17sm34177508wrr.60.2020.09.16.10.53.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 10:53:38 -0700 (PDT)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     ast@kernel.org, yhs@fb.com, daniel@iogearbox.net, kafai@fb.com,
        andriin@fb.com
Cc:     bpf@vger.kernel.org, kernel-team@cloudflare.com,
        Lorenz Bauer <lmb@cloudflare.com>
Subject: [PATCH bpf-next v4 06/11] bpf: make reference tracking generic
Date:   Wed, 16 Sep 2020 18:52:50 +0100
Message-Id: <20200916175255.192040-7-lmb@cloudflare.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200916175255.192040-1-lmb@cloudflare.com>
References: <20200916175255.192040-1-lmb@cloudflare.com>
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

