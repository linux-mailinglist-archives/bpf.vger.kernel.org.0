Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99C725B3714
	for <lists+bpf@lfdr.de>; Fri,  9 Sep 2022 14:11:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231252AbiIIMK4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 9 Sep 2022 08:10:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230509AbiIIMKT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 9 Sep 2022 08:10:19 -0400
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 889053A160;
        Fri,  9 Sep 2022 05:09:47 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.227])
        by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4MPF5h4Vcrz9xGZB;
        Fri,  9 Sep 2022 20:04:08 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
        by APP1 (Coremail) with SMTP id LxC2BwC3rpKVLBtj1uszAA--.31607S9;
        Fri, 09 Sep 2022 13:09:18 +0100 (CET)
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, mykolal@fb.com,
        dhowells@redhat.com, jarkko@kernel.org, rostedt@goodmis.org,
        mingo@redhat.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, shuah@kernel.org
Cc:     bpf@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        deso@posteo.net, memxor@gmail.com,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v17 07/12] bpf: Add bpf_verify_pkcs7_signature() kfunc
Date:   Fri,  9 Sep 2022 14:07:31 +0200
Message-Id: <20220909120736.1027040-8-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220909120736.1027040-1-roberto.sassu@huaweicloud.com>
References: <20220909120736.1027040-1-roberto.sassu@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LxC2BwC3rpKVLBtj1uszAA--.31607S9
X-Coremail-Antispam: 1UD129KBjvJXoWxAr1xZw47AFykZFWfGFyrCrg_yoW5uF18pF
        W8Kr4S9rykJr1ftFyfAa1fuF1Fkw4vqw17G3ZrA3s3uFnYgF17Z3WxtF4UW3sYkry8trZF
        vryIqr1akr13WaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBvb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6r1S6rWUM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
        Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
        rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
        AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E
        14v26r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrV
        C2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE
        7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCF04k20x
        vY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I
        3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIx
        AIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI
        42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z2
        80aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07UZo7tUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAKBF1jj37rbAAAsE
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Roberto Sassu <roberto.sassu@huawei.com>

Add the bpf_verify_pkcs7_signature() kfunc, to give eBPF security modules
the ability to check the validity of a signature against supplied data, by
using user-provided or system-provided keys as trust anchor.

The new kfunc makes it possible to enforce mandatory policies, as eBPF
programs might be allowed to make security decisions only based on data
sources the system administrator approves.

The caller should provide the data to be verified and the signature as eBPF
dynamic pointers (to minimize the number of parameters) and a bpf_key
structure containing a reference to the keyring with keys trusted for
signature verification, obtained from bpf_lookup_user_key() or
bpf_lookup_system_key().

For bpf_key structures obtained from the former lookup function,
bpf_verify_pkcs7_signature() completes the permission check deferred by
that function by calling key_validate(). key_task_permission() is already
called by the PKCS#7 code.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
Acked-by: KP Singh <kpsingh@kernel.org>
---
 kernel/trace/bpf_trace.c | 45 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index ab183dbaa8d1..9df53c40cffd 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1294,12 +1294,57 @@ void bpf_key_put(struct bpf_key *bkey)
 	kfree(bkey);
 }
 
+#ifdef CONFIG_SYSTEM_DATA_VERIFICATION
+/**
+ * bpf_verify_pkcs7_signature - verify a PKCS#7 signature
+ * @data_ptr: data to verify
+ * @sig_ptr: signature of the data
+ * @trusted_keyring: keyring with keys trusted for signature verification
+ *
+ * Verify the PKCS#7 signature *sig_ptr* against the supplied *data_ptr*
+ * with keys in a keyring referenced by *trusted_keyring*.
+ *
+ * Return: 0 on success, a negative value on error.
+ */
+int bpf_verify_pkcs7_signature(struct bpf_dynptr_kern *data_ptr,
+			       struct bpf_dynptr_kern *sig_ptr,
+			       struct bpf_key *trusted_keyring)
+{
+	int ret;
+
+	if (trusted_keyring->has_ref) {
+		/*
+		 * Do the permission check deferred in bpf_lookup_user_key().
+		 * See bpf_lookup_user_key() for more details.
+		 *
+		 * A call to key_task_permission() here would be redundant, as
+		 * it is already done by keyring_search() called by
+		 * find_asymmetric_key().
+		 */
+		ret = key_validate(trusted_keyring->key);
+		if (ret < 0)
+			return ret;
+	}
+
+	return verify_pkcs7_signature(data_ptr->data,
+				      bpf_dynptr_get_size(data_ptr),
+				      sig_ptr->data,
+				      bpf_dynptr_get_size(sig_ptr),
+				      trusted_keyring->key,
+				      VERIFYING_UNSPECIFIED_SIGNATURE, NULL,
+				      NULL);
+}
+#endif /* CONFIG_SYSTEM_DATA_VERIFICATION */
+
 __diag_pop();
 
 BTF_SET8_START(key_sig_kfunc_set)
 BTF_ID_FLAGS(func, bpf_lookup_user_key, KF_ACQUIRE | KF_RET_NULL | KF_SLEEPABLE)
 BTF_ID_FLAGS(func, bpf_lookup_system_key, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_key_put, KF_RELEASE)
+#ifdef CONFIG_SYSTEM_DATA_VERIFICATION
+BTF_ID_FLAGS(func, bpf_verify_pkcs7_signature, KF_SLEEPABLE)
+#endif
 BTF_SET8_END(key_sig_kfunc_set)
 
 static const struct btf_kfunc_id_set bpf_key_sig_kfunc_set = {
-- 
2.25.1

