Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A705553BC5
	for <lists+bpf@lfdr.de>; Tue, 21 Jun 2022 22:46:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353136AbiFUUqx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Jun 2022 16:46:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352430AbiFUUqw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Jun 2022 16:46:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F78723BC4
        for <bpf@vger.kernel.org>; Tue, 21 Jun 2022 13:46:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D0BFAB81B01
        for <bpf@vger.kernel.org>; Tue, 21 Jun 2022 20:46:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D869C341C7;
        Tue, 21 Jun 2022 20:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655844409;
        bh=0sz9cN1XmOO/ZvIT4AWqxdHy7X13KQiUBPBhOXErjEk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CkRcP0xcDNVdTPpXLd6PqcXbJHXR6a7ak+ZDGRh5kM7H0HkcI3YWHULX5ddvXnE55
         ICwWcB4sHTQuUyxRRPk33Tex6PM2oD+oISdUoMjm5L/orqjNvY67QUAL+4LqYhxS54
         l7+UeB+gGBrlg4EcHQaxc2fIbZ8Adp25F4KN/W5HQVCpJaa1IlCN8+y4F93s/Vyp1W
         BsV4MLS0XGiYykY/YOFwXMiLtXlN9kU/znYQlJRROyIMHVvXIZlfxOGcx96dO51abH
         bkqY/zL0DUzKNbJZEvhPLu2eEPqp24bVjvABx8LBPLPhU7kVw+ARZdyUTKz7YMz+56
         njYxRL3ebiUkA==
From:   KP Singh <kpsingh@kernel.org>
To:     bpf@vger.kernel.org
Cc:     KP Singh <kpsingh@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Yosry Ahmed <yosryahmed@google.com>
Subject: [PATCH v3 bpf-next 1/5] btf: Add a new kfunc set which allows to mark a function to be sleepable
Date:   Tue, 21 Jun 2022 20:46:38 +0000
Message-Id: <20220621204642.2891979-2-kpsingh@kernel.org>
X-Mailer: git-send-email 2.37.0.rc0.104.g0611611a94-goog
In-Reply-To: <20220621204642.2891979-1-kpsingh@kernel.org>
References: <20220621204642.2891979-1-kpsingh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Benjamin Tissoires <benjamin.tissoires@redhat.com>

This allows to declare a kfunc as sleepable and prevents its use in
a non sleepable program.

Acked-by: KP Singh <kpsingh@kernel.org>
Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Signed-off-by: KP Singh <kpsingh@kernel.org>
---
 include/linux/btf.h |  2 ++
 kernel/bpf/btf.c    | 12 ++++++++++--
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/include/linux/btf.h b/include/linux/btf.h
index 1bfed7fa0428..6e7517573d9e 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -18,6 +18,7 @@ enum btf_kfunc_type {
 	BTF_KFUNC_TYPE_RELEASE,
 	BTF_KFUNC_TYPE_RET_NULL,
 	BTF_KFUNC_TYPE_KPTR_ACQUIRE,
+	BTF_KFUNC_TYPE_SLEEPABLE,
 	BTF_KFUNC_TYPE_MAX,
 };
 
@@ -37,6 +38,7 @@ struct btf_kfunc_id_set {
 			struct btf_id_set *release_set;
 			struct btf_id_set *ret_null_set;
 			struct btf_id_set *kptr_acquire_set;
+			struct btf_id_set *sleepable_set;
 		};
 		struct btf_id_set *sets[BTF_KFUNC_TYPE_MAX];
 	};
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index f08037c31dd7..668ecf61649b 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6171,7 +6171,7 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
 	struct bpf_verifier_log *log = &env->log;
 	u32 i, nargs, ref_id, ref_obj_id = 0;
 	bool is_kfunc = btf_is_kernel(btf);
-	bool rel = false, kptr_get = false;
+	bool rel = false, kptr_get = false, sleepable = false;
 	const char *func_name, *ref_tname;
 	const struct btf_type *t, *ref_t;
 	const struct btf_param *args;
@@ -6202,9 +6202,10 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
 	}
 
 	if (is_kfunc) {
-		/* Only kfunc can be release func */
 		rel = btf_kfunc_id_set_contains(btf, resolve_prog_type(env->prog),
 						BTF_KFUNC_TYPE_RELEASE, func_id);
+		sleepable = btf_kfunc_id_set_contains(btf, resolve_prog_type(env->prog),
+						      BTF_KFUNC_TYPE_SLEEPABLE, func_id);
 		kptr_get = btf_kfunc_id_set_contains(btf, resolve_prog_type(env->prog),
 						     BTF_KFUNC_TYPE_KPTR_ACQUIRE, func_id);
 	}
@@ -6404,6 +6405,13 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
 			func_name);
 		return -EINVAL;
 	}
+
+	if (sleepable && !env->prog->aux->sleepable) {
+		bpf_log(log, "kernel function %s is sleepable but the program is not\n",
+			func_name);
+		return -EINVAL;
+	}
+
 	/* returns argument register number > 0 in case of reference release kfunc */
 	return rel ? ref_regno : 0;
 }
-- 
2.37.0.rc0.104.g0611611a94-goog

