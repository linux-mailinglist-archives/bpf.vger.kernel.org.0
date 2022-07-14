Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E01F25755C5
	for <lists+bpf@lfdr.de>; Thu, 14 Jul 2022 21:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229458AbiGNTVi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 14 Jul 2022 15:21:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232159AbiGNTVi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 14 Jul 2022 15:21:38 -0400
X-Greylist: delayed 356 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 14 Jul 2022 12:21:37 PDT
Received: from sinsgout.his.huawei.com (sinsgout.his.huawei.com [119.8.179.247])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55FEB43332
        for <bpf@vger.kernel.org>; Thu, 14 Jul 2022 12:21:37 -0700 (PDT)
Received: from sinmsgout01.his.huawei.com (unknown [172.28.115.139])
        by sinsgout.his.huawei.com (SkyGuard) with ESMTP id 4LkPN16dzjz3h03s
        for <bpf@vger.kernel.org>; Fri, 15 Jul 2022 03:15:45 +0800 (CST)
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.156.147])
        by sinmsgout01.his.huawei.com (SkyGuard) with ESMTP id 4LkPGD2NQwz9xFB2;
        Fri, 15 Jul 2022 03:10:44 +0800 (CST)
Received: from roberto-ThinkStation-P620.huawei.com (10.204.63.22) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 14 Jul 2022 21:15:32 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <ast@kernel.org>, <daniel@iogearbox.net>,
        <john.fastabend@gmail.com>, <andrii@kernel.org>,
        <martin.lau@linux.dev>, <song@kernel.org>, <yhs@fb.com>,
        <kpsingh@kernel.org>
CC:     <bpf@vger.kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [RFC][PATCH v8 01/12] btf: Add a new kfunc set which allows to mark a function to be sleepable
Date:   Thu, 14 Jul 2022 21:14:44 +0200
Message-ID: <20220714191455.2101834-2-roberto.sassu@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220714191455.2101834-1-roberto.sassu@huawei.com>
References: <20220714191455.2101834-1-roberto.sassu@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.204.63.22]
X-ClientProxiedBy: lhreml754-chm.china.huawei.com (10.201.108.204) To
 fraeml714-chm.china.huawei.com (10.206.15.33)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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
index 4423045b8ff3..2a28ead92841 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6177,7 +6177,7 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
 	struct bpf_verifier_log *log = &env->log;
 	u32 i, nargs, ref_id, ref_obj_id = 0;
 	bool is_kfunc = btf_is_kernel(btf);
-	bool rel = false, kptr_get = false;
+	bool rel = false, kptr_get = false, sleepable = false;
 	const char *func_name, *ref_tname;
 	const struct btf_type *t, *ref_t;
 	const struct btf_param *args;
@@ -6208,9 +6208,10 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
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
@@ -6410,6 +6411,13 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
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
2.25.1

