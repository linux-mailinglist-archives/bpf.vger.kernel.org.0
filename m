Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BA5B5AC674
	for <lists+bpf@lfdr.de>; Sun,  4 Sep 2022 22:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234742AbiIDUmU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 4 Sep 2022 16:42:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234662AbiIDUmQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 4 Sep 2022 16:42:16 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E0FE2CDE2
        for <bpf@vger.kernel.org>; Sun,  4 Sep 2022 13:42:12 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id s11so8995709edd.13
        for <bpf@vger.kernel.org>; Sun, 04 Sep 2022 13:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=DTOqT+Ny3gIY/UHsYgqg5cNBjxOnKHxmtoXYgTOwxZ8=;
        b=FyB5jM1Nt6VESCzW8Sex3k772D/OJBDBU1VpI1+PUe6VPKLYckPCA6cbj/S5a/LGL+
         W1WWFUbkrg+RjSGE7nba3hNyHc+S/PcQjMk5aoAiBNlJ72LzhCCjGen7CqYw9f+b8MMK
         z7gEFPYHgnz80nPhF6nZQ7IU5jzi6DKUPuj6UzDQBa0JWbb2RbFK/6v2lfnmx1dAx7HO
         kz9jkHq3T4PovnDSNp95v9VzCNfZs6goWFpo3NP7TF1DZ93NcCCZkPnajWw3CGFMfepm
         HvfpoqIRvjzC426g2jd+sWrkCMswnpfiazpoKxbMtUgNDSI4OhvRtUuEJMj1u4H82EXD
         Z8+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=DTOqT+Ny3gIY/UHsYgqg5cNBjxOnKHxmtoXYgTOwxZ8=;
        b=OYIrKs7V6Y282yb8lHTpU59YEkII/9i9vBXKoudXPVqhVNxVc4vMkKEocb9xVDIzKg
         xG9G203zzZzrT4Ubyjrsen38iHQUTleGCjICkDB70C2n0CGqXQGEX1mdOIgwJJAR7ej1
         fXE5oUdr/I8gerMwz3DLW1UYEr50wJSobv0y8BMxCw31du1ktiD9UvQQCf5TPFCtT/xU
         ULM5kBP2lUFOSZ6VKqnrEXjBxWqYrn+NKF7wgZa2QALZDHfj4fVz+ZDD8gh+rLJDe/CD
         ZXKqGpBnEcdZg9INTREZAvRogHxyVGdf3p6pPvzwS2lDo2tMCoKzLPi6Ua0hVjXLUv1T
         MhJA==
X-Gm-Message-State: ACgBeo18846IF35hSU9ZFrD0ipqWO9pENnHfT7qmtTUhnA5IU/e2b2DN
        GRqQjiHjJ7ij66A5AeW5MRHsimJFGHk9Aw==
X-Google-Smtp-Source: AA6agR4s6RvrIpjiGasYdzKW2VOOtKjfFRdHxqKpLkjmETRp1EHQPesp+HG1KmNkuamjQh7gxyQtHQ==
X-Received: by 2002:a05:6402:120d:b0:448:e049:c665 with SMTP id c13-20020a056402120d00b00448e049c665mr21340877edw.70.1662324130363;
        Sun, 04 Sep 2022 13:42:10 -0700 (PDT)
Received: from localhost (212.191.202.62.dynamic.cgnat.res.cust.swisscom.ch. [62.202.191.212])
        by smtp.gmail.com with ESMTPSA id mc4-20020a170906eb4400b0073100dfa7b5sm4170362ejb.33.2022.09.04.13.42.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Sep 2022 13:42:10 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Delyan Kratunov <delyank@fb.com>
Subject: [PATCH RFC bpf-next v1 20/32] bpf: Introduce bpf_kptr_free helper
Date:   Sun,  4 Sep 2022 22:41:33 +0200
Message-Id: <20220904204145.3089-21-memxor@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220904204145.3089-1-memxor@gmail.com>
References: <20220904204145.3089-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3989; i=memxor@gmail.com; h=from:subject; bh=TwJ3REhRb2mISJ2W9YSN6LJcwxNl39rv4Y+aF38t58s=; b=owEBbQKS/ZANAwAKAUzgyIZIvxHKAcsmYgBjFQ1xlSY7LqeNsmoR6/PdTB1yFS+wA8r7HXWjpn6t a/XCsz+JAjMEAAEKAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYxUNcQAKCRBM4MiGSL8RykYXEA CYez8oUFMe48aK8VTTCFIAVG1JGDpewp2Tb8qjB8uvcTYYan/peC34bH/zKdcrHnOUF3PCawLC9K8r elqh51/YZjSxOh4MAcVoYhmGjjI0ByD+/pnrxaM6rlUWu3SN4WRYrRh0IZ1ZkxxMd5Hcuqpwafsys7 RF+EBxKE1RIYOsijYLIR+u5JmpOPJPrpYyXIkSaJKsFgE2dJhSrfofcLUx7Q6zGm+xWS111j/4pvcC fKAR/fJHFKHJGCRygaGkeI0zks6XlYAI4Q6ekZEJxEWD4lOv7uCznnBGaDEAMHP+F8BglgUC5GTa7J P97LAE3laSy1Rhfw2H0NEkNUAfKMuKnbHTjSRZiD72xffAYSSebAeRA9RU50VbpPADKsCBOxRhUdEL TSD9tM8vM1KRXIwtY5ke7aRMx4Nh25GX0DTrJm9Rwmb6CcsEv3iGW703ntMgNAEaUlgXyM+HNOdYbF TAziTryKxvEOD1Mnq+AVKWGPrnaHCA/R/5MmuxtncGi0jL+0hanoUgBjmowvcKSDdZfqw+pxT9PTbA 6kJ4rDeMFgbxgx2RUtbdZSzVEZuXNunwV5/KOrO6h+4ReONkmaDOlnbIXRI3wDis04IhNROrPeP8Xv 3YpdDyVu64lauSphlF4sW7kWfjI5KajDaT0yfVok0AaTYa0iuiDk/CVUYPxQ==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

After ensuring that the verifier can recognize normal vs destructing
objects, add bpf_kptr_free support, and then verify whether normal
object can directly be freed, or whether it needs destruction. If
already in destructing phase, ensure all fields have been destructed.

Having this state in the verifier simplifies how we release resources
for kptrs to local types with arbitrary fields considerably. The
verifier just needs to ensure that destruction happens while program
has ownership of object, and then it can just release the storage using
bpf_kptr_free.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/helpers.c                          |  6 ++++
 kernel/bpf/verifier.c                         | 29 +++++++++++++++++++
 .../testing/selftests/bpf/bpf_experimental.h  |  8 +++++
 3 files changed, 43 insertions(+)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 8eee0793c7f1..4a6fffe401ae 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1731,6 +1731,11 @@ void bpf_list_head_init(struct bpf_list_head *head__clkptr)
 	INIT_LIST_HEAD((struct list_head *)head__clkptr);
 }
 
+void bpf_kptr_free(void *p__dlkptr)
+{
+	kfree(p__dlkptr);
+}
+
 __diag_pop();
 
 BTF_SET8_START(tracing_btf_ids)
@@ -1741,6 +1746,7 @@ BTF_ID_FLAGS(func, bpf_kptr_alloc, KF_ACQUIRE | KF_RET_NULL | __KF_RET_DYN_BTF)
 BTF_ID_FLAGS(func, bpf_list_node_init)
 BTF_ID_FLAGS(func, bpf_spin_lock_init)
 BTF_ID_FLAGS(func, bpf_list_head_init)
+BTF_ID_FLAGS(func, bpf_kptr_free, KF_RELEASE)
 BTF_SET8_END(tracing_btf_ids)
 
 static const struct btf_kfunc_id_set tracing_kfunc_set = {
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index a5aa5de4b246..b1754fd69f7d 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7812,6 +7812,7 @@ BTF_ID(func, bpf_kptr_alloc)
 BTF_ID(func, bpf_list_node_init)
 BTF_ID(func, bpf_spin_lock_init)
 BTF_ID(func, bpf_list_head_init)
+BTF_ID(func, bpf_kptr_free)
 BTF_ID(struct, btf) /* empty entry */
 
 enum bpf_special_kfuncs {
@@ -7819,6 +7820,7 @@ enum bpf_special_kfuncs {
 	KF_SPECIAL_bpf_list_node_init,
 	KF_SPECIAL_bpf_spin_lock_init,
 	KF_SPECIAL_bpf_list_head_init,
+	KF_SPECIAL_bpf_kptr_free,
 	KF_SPECIAL_bpf_empty,
 	KF_SPECIAL_MAX = KF_SPECIAL_bpf_empty,
 };
@@ -8156,6 +8158,33 @@ process_kf_arg_destructing_local_kptr(struct bpf_verifier_env *env,
 		}));
 	}
 
+	/* Handle bpf_kptr_free */
+	if (is_kfunc_special(meta->btf, meta->func_id, bpf_kptr_free)) {
+		for (i = cnt - 1; i >= 0; i--) {
+			if (!fields[i].needs_destruction)
+				continue;
+			/* If a field needs destruction, it must be in
+			 * destructed state when calling bpf_kptr_free.
+			 */
+			switch (local_kptr_get_state(reg, i)) {
+			case FIELD_STATE_CONSTRUCTED:
+				verbose(env, "'%s' field needs to be destructed before bpf_kptr_free\n",
+					fields[i].name);
+				return -EINVAL;
+			case FIELD_STATE_DESTRUCTED:
+				break;
+			case FIELD_STATE_UNKNOWN:
+				if (reg->type & OBJ_CONSTRUCTING)
+					break;
+				fallthrough;
+			default:
+				verbose(env, "verifier internal error: unknown field state\n");
+				return -EFAULT;
+			}
+		}
+		return 0;
+	}
+
 	for (i = 0; i < cnt; i++) {
 		bool mark_dtor = false, unmark_ctor = false;
 		int j;
diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
index f0b6e92c6908..595e99d5cbc2 100644
--- a/tools/testing/selftests/bpf/bpf_experimental.h
+++ b/tools/testing/selftests/bpf/bpf_experimental.h
@@ -59,4 +59,12 @@ void bpf_spin_lock_init(struct bpf_spin_lock *node) __ksym;
  */
 void bpf_list_head_init(struct bpf_list_head *node) __ksym;
 
+/* Description
+ *	Free a local kptr. All fields of local kptr that require destruction
+ *	need to be in destructed state before this call is made.
+ * Returns
+ *	Void.
+ */
+void bpf_kptr_free(void *kptr) __ksym;
+
 #endif
-- 
2.34.1

