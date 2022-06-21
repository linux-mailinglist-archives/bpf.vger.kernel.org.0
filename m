Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ED4F5528F8
	for <lists+bpf@lfdr.de>; Tue, 21 Jun 2022 03:28:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240120AbiFUB2a (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 20 Jun 2022 21:28:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241578AbiFUB2V (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 20 Jun 2022 21:28:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B68601928B
        for <bpf@vger.kernel.org>; Mon, 20 Jun 2022 18:28:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6A27BB811EC
        for <bpf@vger.kernel.org>; Tue, 21 Jun 2022 01:28:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3106C341C5;
        Tue, 21 Jun 2022 01:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655774898;
        bh=LYcal6BP+mEOEdUdVWBC5q5Ju3rVmyi66+AjKEcUkCA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fLDtaXXJBFK8hXyMyE9N+/Kl5zvDvgEgl8CXVpH5N04aQZIRiIWrRSA31OlLOz/Fo
         NITzD/TNKs+UyBWbOGXQ7Q8NA+/HocRQGyyNsTgdXDsaz5pZKzCYPN/qom/09R5xW+
         Thzoz/AAr34UHLP20c4ILq08FdM32GOTnd/fCnfj1wUyg6QxCLqmLxyDAqB/KsSdV2
         GEVxpJOlclDlStOpi14pX01FjePNguhZSiRWMoDPfcmy/ZZsGdoh9/Gvhp10a3MXp3
         fV4/mahPOpXDowxsjoelvMiCli2l+eBqYKQ1zbS8Dh3OAd7qGaiuXi0vMdosTmISWC
         JDD2kWTHWjjfg==
From:   KP Singh <kpsingh@kernel.org>
To:     bpf@vger.kernel.org
Cc:     KP Singh <kpsingh@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Yosry Ahmed <yosryahmed@google.com>
Subject: [PATCH v2 bpf-next 1/5] btf: Add a new kfunc set which allows to mark a function to be sleepable
Date:   Tue, 21 Jun 2022 01:28:07 +0000
Message-Id: <20220621012811.2683313-2-kpsingh@kernel.org>
X-Mailer: git-send-email 2.37.0.rc0.104.g0611611a94-goog
In-Reply-To: <20220621012811.2683313-1-kpsingh@kernel.org>
References: <20220621012811.2683313-1-kpsingh@kernel.org>
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

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Acked-by: KP Singh <kpsingh@kernel.org>
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

