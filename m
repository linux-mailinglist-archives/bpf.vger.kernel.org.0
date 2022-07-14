Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C04DE5755B2
	for <lists+bpf@lfdr.de>; Thu, 14 Jul 2022 21:17:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239423AbiGNTRB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 14 Jul 2022 15:17:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230352AbiGNTRA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 14 Jul 2022 15:17:00 -0400
Received: from sinmsgout03.his.huawei.com (sinmsgout03.his.huawei.com [119.8.177.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D790A3D5BC
        for <bpf@vger.kernel.org>; Thu, 14 Jul 2022 12:16:59 -0700 (PDT)
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.156.149])
        by sinmsgout03.his.huawei.com (SkyGuard) with ESMTP id 4LkPN30Kfjz9xGP0;
        Fri, 15 Jul 2022 03:15:46 +0800 (CST)
Received: from roberto-ThinkStation-P620.huawei.com (10.204.63.22) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 14 Jul 2022 21:16:49 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <ast@kernel.org>, <daniel@iogearbox.net>,
        <john.fastabend@gmail.com>, <andrii@kernel.org>,
        <martin.lau@linux.dev>, <song@kernel.org>, <yhs@fb.com>,
        <kpsingh@kernel.org>
CC:     <bpf@vger.kernel.org>, Roberto Sassu <roberto.sassu@huawei.com>
Subject: [RFC][PATCH v8 07/12] bpf: Add bpf_lookup_user_key() and bpf_key_put() kfuncs
Date:   Thu, 14 Jul 2022 21:14:50 +0200
Message-ID: <20220714191455.2101834-8-roberto.sassu@huawei.com>
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

Add the bpf_lookup_user_key() and bpf_key_put() kfuncs, to respectively
search a key with a given serial and flags, and release the reference count
of the found key.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 kernel/trace/bpf_trace.c | 106 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 106 insertions(+)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 68e5cdd24cef..bffca9465574 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -20,6 +20,7 @@
 #include <linux/fprobe.h>
 #include <linux/bsearch.h>
 #include <linux/sort.h>
+#include <linux/key.h>
 
 #include <net/bpf_sk_storage.h>
 
@@ -1181,6 +1182,111 @@ static const struct bpf_func_proto bpf_get_func_arg_cnt_proto = {
 	.arg1_type	= ARG_PTR_TO_CTX,
 };
 
+#ifdef CONFIG_KEYS
+__diag_push();
+__diag_ignore_all("-Wmissing-prototypes",
+		  "kfuncs which will be used in BPF programs");
+
+/**
+ * bpf_lookup_user_key - lookup a key by its serial
+ * @serial: key serial
+ * @flags: lookup-specific flags
+ *
+ * Search a key with a given *serial* and the provided *flags*. The
+ * returned key, if found, has the reference count incremented by
+ * one, and must be passed to bpf_key_put() when done with it.
+ * Permission checks are deferred to the time the key is used by
+ * one of the available key-specific kfunc.
+ *
+ * Set *flags* with 1 to attempt creating a requested special
+ * keyring (e.g. session keyring), if it doesn't yet exist. Set
+ * *flags* to 2 to lookup a key without waiting for the key
+ * construction, and to retrieve uninstantiated keys (keys without
+ * data attached to them).
+ *
+ * Return: a key pointer if the key is found, a NULL pointer otherwise.
+ */
+noinline __weak struct key *bpf_lookup_user_key(u32 serial, u64 flags)
+{
+	key_ref_t key_ref;
+
+	/* Keep in sync with include/linux/key.h. */
+	if (flags > (KEY_LOOKUP_PARTIAL << 1) - 1)
+		return NULL;
+
+	/* Permission check is deferred until actual kfunc using the key. */
+	key_ref = lookup_user_key(serial, flags, KEY_DEFER_PERM_CHECK);
+	if (IS_ERR(key_ref))
+		return NULL;
+
+	return key_ref_to_ptr(key_ref);
+}
+
+/**
+ * bpf_key_put - release a key reference
+ * @key: key whose reference is released
+ *
+ * Decrement the reference count of *key* obtained with the
+ * bpf_lookup_user_key() kfunc.
+ */
+noinline __weak void bpf_key_put(struct key *key)
+{
+	key_put(key);
+}
+
+__diag_pop();
+
+BTF_SET_START(key_kfunc_ids)
+BTF_ID(func, bpf_lookup_user_key)
+BTF_ID(func, bpf_key_put)
+BTF_SET_END(key_kfunc_ids)
+
+BTF_SET_START(key_lookup_kfunc_ids)
+BTF_ID(func, bpf_lookup_user_key)
+BTF_SET_END(key_lookup_kfunc_ids)
+
+BTF_SET_START(key_put_kfunc_ids)
+BTF_ID(func, bpf_key_put)
+BTF_SET_END(key_put_kfunc_ids)
+
+static const struct btf_kfunc_id_set bpf_key_kfunc_set = {
+	.owner = THIS_MODULE,
+	.check_set = &key_kfunc_ids,
+	.sleepable_set = &key_lookup_kfunc_ids,
+	.acquire_set = &key_lookup_kfunc_ids,
+	.release_set = &key_put_kfunc_ids,
+	.ret_null_set = &key_lookup_kfunc_ids,
+};
+#endif /* CONFIG_KEYS */
+
+
+const struct btf_kfunc_id_set *kfunc_sets[] = {
+#ifdef CONFIG_KEYS
+	&bpf_key_kfunc_set,
+#endif /* CONFIG_KEYS */
+};
+
+static int __init bpf_kfuncs_init(void)
+{
+	int ret, i;
+
+	for (i = 0; i < ARRAY_SIZE(kfunc_sets); i++) {
+		ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING,
+						kfunc_sets[i]);
+		if (!ret)
+			continue;
+
+		ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_LSM,
+						kfunc_sets[i]);
+		if (ret < 0)
+			return ret;
+	}
+
+	return 0;
+}
+
+late_initcall(bpf_kfuncs_init);
+
 static const struct bpf_func_proto *
 bpf_tracing_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 {
-- 
2.25.1

