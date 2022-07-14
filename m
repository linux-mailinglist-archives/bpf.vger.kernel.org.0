Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C0965755B1
	for <lists+bpf@lfdr.de>; Thu, 14 Jul 2022 21:17:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239326AbiGNTRB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 14 Jul 2022 15:17:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiGNTRA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 14 Jul 2022 15:17:00 -0400
Received: from sinmsgout03.his.huawei.com (sinmsgout03.his.huawei.com [119.8.177.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 724EF2DA88
        for <bpf@vger.kernel.org>; Thu, 14 Jul 2022 12:16:59 -0700 (PDT)
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.156.149])
        by sinmsgout03.his.huawei.com (SkyGuard) with ESMTP id 4LkPN45YDmz9v7BW;
        Fri, 15 Jul 2022 03:15:48 +0800 (CST)
Received: from roberto-ThinkStation-P620.huawei.com (10.204.63.22) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 14 Jul 2022 21:16:50 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <ast@kernel.org>, <daniel@iogearbox.net>,
        <john.fastabend@gmail.com>, <andrii@kernel.org>,
        <martin.lau@linux.dev>, <song@kernel.org>, <yhs@fb.com>,
        <kpsingh@kernel.org>
CC:     <bpf@vger.kernel.org>, Roberto Sassu <roberto.sassu@huawei.com>
Subject: [RFC][PATCH v8 08/12] bpf: Add bpf_verify_pkcs7_signature() kfunc
Date:   Thu, 14 Jul 2022 21:14:51 +0200
Message-ID: <20220714191455.2101834-9-roberto.sassu@huawei.com>
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

Add the bpf_verify_pkcs7_signature() kfunc, to give eBPF security modules
the ability to check the validity of a signature against supplied data, by
using user-provided or system-provided keys as trust anchor.

The new kfunc makes it possible to enforce mandatory policies, as eBPF
programs might be allowed to make security decisions only based on data
sources the system administrator approves.

The caller should provide both the data to be verified and the signature as
eBPF dynamic pointers (to minimize the number of parameters) and,
alternatively, a keyring obtained from bpf_lookup_user_key(), or a
pre-determined keyring ID with values defined in
include/linux/verification.h.

The two keyring parameters have to be provided separately: the
pre-determined IDs exist only in the context of verify_pkcs7_signature().
They should not be passed to the bpf_lookup_user_key() kfunc, or to a new
kfunc doing type casting to a struct key (like: ((struct key *)2UL) in
include/linux/verification.h), as otherwise, each kfunc accepting a struct
key would have to check if it is a valid pointer or not.

Finally, bpf_verify_pkcs7_signature() completes the permission check
deferred by bpf_lookup_user_key(), by calling key_validate().
key_task_permission() is already called by the PKCS#7 code.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 kernel/trace/bpf_trace.c | 86 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 85 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index bffca9465574..c09ed20d7314 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -21,6 +21,7 @@
 #include <linux/bsearch.h>
 #include <linux/sort.h>
 #include <linux/key.h>
+#include <linux/verification.h>
 
 #include <net/bpf_sk_storage.h>
 
@@ -1234,6 +1235,75 @@ noinline __weak void bpf_key_put(struct key *key)
 	key_put(key);
 }
 
+#ifdef CONFIG_SYSTEM_DATA_VERIFICATION
+/**
+ * bpf_verify_pkcs7_signature - verify a PKCS#7 signature
+ * @data_ptr: data to verify
+ * @sig_ptr: signature of the data
+ * @user_keyring__maybe_null: user-defined keyring for sig ver (alternative)
+ * @system_keyring: system-defined keyring for sig ver (alternative)
+ *
+ * Verify the PKCS#7 signature *sig_ptr* against the supplied *data_ptr*
+ * alternatively with keys in *user_keyring__maybe_null* or *system_keyring*.
+ * Either one of the two must be provided. Respectively, NULL or UINT64_MAX
+ * must be passed to signal to the kfunc that the parameter is not used.
+ *
+ * *user_keyring__maybe_null* is a key pointer obtained from
+ * bpf_lookup_user_key(), while *system_keyring* is a pre-determined ID with
+ * values defined in include/linux/verification.h: 0 for the primary keyring
+ * (immutable keyring of system keys); 1 for both the primary and secondary
+ * keyring (where keys can be added only if they are vouched for by existing
+ * keys in those keyrings); 2 for the platform keyring (primarily used by the
+ * integrity subsystem to verify a kexec'ed kerned image and, possibly,
+ * the initramfs signature).
+ *
+ * Return: 0 on success, a negative value on error.
+ */
+noinline __weak int bpf_verify_pkcs7_signature(struct bpf_dynptr_kern *data_ptr,
+					struct bpf_dynptr_kern *sig_ptr,
+					struct key *user_keyring__maybe_null,
+					u64 system_keyring)
+{
+	struct key *trusted_keyring;
+	int ret;
+
+	/* Either user_keyring__maybe_null or system_keyring must be specified. */
+	if ((user_keyring__maybe_null && system_keyring != U64_MAX) ||
+	    (!user_keyring__maybe_null && system_keyring == U64_MAX))
+		return -EINVAL;
+
+	if (user_keyring__maybe_null) {
+		/*
+		 * Do the permission check deferred in bpf_lookup_user_key().
+		 *
+		 * A call to key_task_permission() here would be redundant, as
+		 * it is already done by keyring_search() called by
+		 * find_asymmetric_key().
+		 */
+		ret = key_validate(user_keyring__maybe_null);
+		if (ret < 0)
+			return ret;
+
+		trusted_keyring = user_keyring__maybe_null;
+		goto verify;
+	}
+
+	/* Keep in sync with defs in include/linux/verification.h. */
+	if (system_keyring > (unsigned long)VERIFY_USE_PLATFORM_KEYRING)
+		return -EINVAL;
+
+	trusted_keyring = (struct key *)(unsigned long)system_keyring;
+verify:
+	return verify_pkcs7_signature(data_ptr->data,
+				      bpf_dynptr_get_size(data_ptr),
+				      sig_ptr->data,
+				      bpf_dynptr_get_size(sig_ptr),
+				      trusted_keyring,
+				      VERIFYING_UNSPECIFIED_SIGNATURE, NULL,
+				      NULL);
+}
+#endif /* CONFIG_SYSTEM_DATA_VERIFICATION */
+
 __diag_pop();
 
 BTF_SET_START(key_kfunc_ids)
@@ -1257,12 +1327,26 @@ static const struct btf_kfunc_id_set bpf_key_kfunc_set = {
 	.release_set = &key_put_kfunc_ids,
 	.ret_null_set = &key_lookup_kfunc_ids,
 };
-#endif /* CONFIG_KEYS */
 
+#ifdef CONFIG_SYSTEM_DATA_VERIFICATION
+BTF_SET_START(verify_sig_kfunc_ids)
+BTF_ID(func, bpf_verify_pkcs7_signature)
+BTF_SET_END(verify_sig_kfunc_ids)
+
+static const struct btf_kfunc_id_set bpf_verify_sig_kfunc_set = {
+	.owner = THIS_MODULE,
+	.check_set = &verify_sig_kfunc_ids,
+	.sleepable_set = &verify_sig_kfunc_ids,
+};
+#endif /* CONFIG_SYSTEM_DATA_VERIFICATION */
+#endif /* CONFIG_KEYS */
 
 const struct btf_kfunc_id_set *kfunc_sets[] = {
 #ifdef CONFIG_KEYS
 	&bpf_key_kfunc_set,
+#ifdef CONFIG_SYSTEM_DATA_VERIFICATION
+	&bpf_verify_sig_kfunc_set,
+#endif /* CONFIG_SYSTEM_DATA_VERIFICATION */
 #endif /* CONFIG_KEYS */
 };
 
-- 
2.25.1

