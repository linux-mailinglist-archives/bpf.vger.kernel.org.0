Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F6F6636EEE
	for <lists+bpf@lfdr.de>; Thu, 24 Nov 2022 01:28:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbiKXA2o (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 23 Nov 2022 19:28:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiKXA2n (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 23 Nov 2022 19:28:43 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07CD49A25D
        for <bpf@vger.kernel.org>; Wed, 23 Nov 2022 16:28:42 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id t5-20020a5b07c5000000b006dfa2102debso97581ybq.4
        for <bpf@vger.kernel.org>; Wed, 23 Nov 2022 16:28:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YJmQddKCKqUUhEm/1VFgPEyUGRWF3vfNgSFK1d0tc7Q=;
        b=kSF2mr5ubZkc88uQWgKl+GT0weAYSQ3pevPSPheUgS9K+p9Gam2Ga5/NAQumrOOOOY
         UzU507YBWQonIfKPMVHL+g3cdqIC+CI8W7Q2a6Huyk3qU2wY2tdGE5hrENLpzQyYCUaU
         a9+DWbZZQCtL/5XfYK8Qq21QycqtNi2nPY9moWCvPksJy5JKkopB6axt7bRbYy33t2Ig
         4VxEVanhOqb7+5UG2XblpczOKSOksU0LGohhMSSYBz8B8mQdMsP9v4Sr6zKI+NjYaIU3
         QMm8XhdszWwY7Rwd05ZSy3UUMXLe2lv//q7KR6ah6wOH0OPYHGypj5O0FuOj3djRgyrQ
         rHZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YJmQddKCKqUUhEm/1VFgPEyUGRWF3vfNgSFK1d0tc7Q=;
        b=HfV7tHOlGx5T7MNBNgUV81/iQg3KZBxQ8LPAfdXFZYwXxuHURqQE//QiWJGH4vb5YP
         eA/08UV6B1DJN2HcNeelrsG5J3sgQXSmHZBrLi9c/I773g3D5shP1U2Z7nLGps6rQl0O
         wEqGNpjjTAme7OFW5K28ZXy9sSVR0GexIIMAHs8WehkpSliwzE4YjAXROb2LARhZ80yj
         17w8PyHGSu7l564lc/WjYvKuq3ZWxkj8kgtIZXcaoka/1pPAIKnW3dW670kQSHJjnN6c
         IcyDZA+aUwcsM0JjvFUfOBNdnmEt2MSr5a9vBSP9N+Q0foiYeyTvk6RmnjrQ5oefE/oB
         EDkA==
X-Gm-Message-State: ANoB5plRESq2nuDSrFknaCId70nW1mTDlrc3LNLKD2vm9sKsljtQt5Dw
        k2sqECmaM+92EUpa62mEECmza8MBs0BvyYJQbto5/9M92Al9HSbNRbRTzDAsgRmiT/tFiWoGcg/
        9v3tX9vVU7INZLAzMEUA6jz29Dmj8vqoCOW660lLd17q547Ad3A==
X-Google-Smtp-Source: AA0mqf4AIhvMFi8n+a7cCxc7deLW57L0utq/E0IC2GW/m9A2unJrWqCLBbN4crkFLOJLzqh7g1qnbVA=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a81:5043:0:b0:3b1:a398:7ada with SMTP id
 e64-20020a815043000000b003b1a3987adamr0ywb.373.1669249720196; Wed, 23 Nov
 2022 16:28:40 -0800 (PST)
Date:   Wed, 23 Nov 2022 16:28:38 -0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
Message-ID: <20221124002838.2700179-1-sdf@google.com>
Subject: [PATCH bpf-next] bpf: Unify and simplify btf_func_proto_check error handling
From:   Stanislav Fomichev <sdf@google.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Replace 'err = x; break;' with 'return x;'.

Suggested-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 kernel/bpf/btf.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index cb43cb842e16..9dbfda2b5c6c 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -4779,7 +4779,6 @@ static int btf_func_proto_check(struct btf_verifier_env *env,
 		nr_args--;
 	}
 
-	err = 0;
 	for (i = 0; i < nr_args; i++) {
 		const struct btf_type *arg_type;
 		u32 arg_type_id;
@@ -4788,8 +4787,7 @@ static int btf_func_proto_check(struct btf_verifier_env *env,
 		arg_type = btf_type_by_id(btf, arg_type_id);
 		if (!arg_type) {
 			btf_verifier_log_type(env, t, "Invalid arg#%u", i + 1);
-			err = -EINVAL;
-			break;
+			return -EINVAL;
 		}
 
 		if (btf_type_is_resolve_source_only(arg_type)) {
@@ -4802,25 +4800,23 @@ static int btf_func_proto_check(struct btf_verifier_env *env,
 		     !btf_name_valid_identifier(btf, args[i].name_off))) {
 			btf_verifier_log_type(env, t,
 					      "Invalid arg#%u", i + 1);
-			err = -EINVAL;
-			break;
+			return -EINVAL;
 		}
 
 		if (btf_type_needs_resolve(arg_type) &&
 		    !env_type_is_resolved(env, arg_type_id)) {
 			err = btf_resolve(env, arg_type, arg_type_id);
 			if (err)
-				break;
+				return err;
 		}
 
 		if (!btf_type_id_size(btf, &arg_type_id, NULL)) {
 			btf_verifier_log_type(env, t, "Invalid arg#%u", i + 1);
-			err = -EINVAL;
-			break;
+			return -EINVAL;
 		}
 	}
 
-	return err;
+	return 0;
 }
 
 static int btf_func_check(struct btf_verifier_env *env,
-- 
2.38.1.584.g0f3c55d4c2-goog

