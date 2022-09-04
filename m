Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD1B45AC67D
	for <lists+bpf@lfdr.de>; Sun,  4 Sep 2022 22:42:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234318AbiIDUm0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 4 Sep 2022 16:42:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234419AbiIDUmT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 4 Sep 2022 16:42:19 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5805C2CDD8
        for <bpf@vger.kernel.org>; Sun,  4 Sep 2022 13:42:18 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id fc24so4454093ejc.3
        for <bpf@vger.kernel.org>; Sun, 04 Sep 2022 13:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=cLpnahZFvnPbBr98Bh8qsZI+aoWPpjLmf5po8/pXe7g=;
        b=nlGQvb5ZUV3KYd5/sDC1bRrDclJbRb9DWvDUc58TwvljJDzxaWpi5GK/a5hxd8sd1d
         xfbh/80PfSDiDVaBaEuvphutSKAPFbdvAurp+8wUwZSRv2mF+koopT29QyGmDxK6NdEI
         PaFzslbL1Vtb6e8GEMyhXL3PxDfSWDc75LIjZrwXu7ffxWMbTSuhhNO3YsP8YchjR5u7
         fR8bfDHdNxtMMJeE5e6tyQMOU8tkoBMVrExT/mQX4rOHi5LW0LVI5fUR/R/ukQX9CHsd
         iVifToDb1Jw+iRMPwKbnEhPTgWjG/oDFAT1V8h9ujDJzzDkrEtzuU7NoAEit+/q+s1dk
         0CfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=cLpnahZFvnPbBr98Bh8qsZI+aoWPpjLmf5po8/pXe7g=;
        b=Qc8wfJDlSXg+aJAVAPG5N/gBw6XomouE1GmhYbm3ZEVNhK0orodvL3kpMbqpsb6B1c
         wzq804M+xVwzlRnjvb0NU1BQelX4TkYNra60A33vb5DxmQS9GwQVF8FsPlNQ9e/SPodT
         UToC+ezdFFKpjf5lsQUMmoj7lqms5ozNBa9WOGaO8m81qTeM5NnVgMJQ6klq1LsLknAC
         zmKs7kRHxE4HLQBXdDLnsRHLTFfsJEF4vEXn+9UUyPhOCqOxELTkeMmqAeNERUzGcO5N
         GdsjSlYoYyvf5mWMFJPotJn2Fe+dP45wTpGC5HIjIMfzxExTuGjDsOgPxRSvWrFIdfmI
         D52g==
X-Gm-Message-State: ACgBeo0C0fXj7FBws30kgRbTj1qNczLO2x/TP6QzPZWJ1tZqJ3Nmp8lh
        j+clXvjMR3Nxwj9aBgDLPTfIfawr5I3mbA==
X-Google-Smtp-Source: AA6agR4tZ10cb3xDE7dUBAgUmOUqDq04D4UKMcFkf0+dRoQmKxIAnY1Ba6sPkLw21KeNEHmVc/18PQ==
X-Received: by 2002:a17:907:dab:b0:742:5e2e:6e4 with SMTP id go43-20020a1709070dab00b007425e2e06e4mr18727140ejc.338.1662324137437;
        Sun, 04 Sep 2022 13:42:17 -0700 (PDT)
Received: from localhost (212.191.202.62.dynamic.cgnat.res.cust.swisscom.ch. [62.202.191.212])
        by smtp.gmail.com with ESMTPSA id i15-20020a50fd0f000000b00445bda73fbesm5314871eds.33.2022.09.04.13.42.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Sep 2022 13:42:17 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Delyan Kratunov <delyank@fb.com>
Subject: [PATCH RFC bpf-next v1 27/32] bpf: Add destructor for bpf_list_head in local kptr
Date:   Sun,  4 Sep 2022 22:41:40 +0200
Message-Id: <20220904204145.3089-28-memxor@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220904204145.3089-1-memxor@gmail.com>
References: <20220904204145.3089-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8187; i=memxor@gmail.com; h=from:subject; bh=X580yBMnPktmkZC1RII80xSi8fwZyXIv1tjivOW3HRc=; b=owEBbQKS/ZANAwAKAUzgyIZIvxHKAcsmYgBjFQ1xgvVvzc6qPYWXL3xemM0eQ5mphCMwpz+Vr4tF K9dEMDSJAjMEAAEKAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYxUNcQAKCRBM4MiGSL8RypLtEA CcDX5uyS1slCCF+0kKnkla06CNoiQjN3rNiuZfYNbf8XxPhLbspNq4ZAwPdPG29eHZtmBQnWr4pNcy RAmxokWhypREm1HPVS8w0DyUi8+oTMB1gWw7SGnMHQEfMreMO1mab/tT9qsG1mr3X93bE7i4S68PFg XYbPMeQgoKWyK3vqtru6qEfhCx64CYVMx58smcrCIrJnT3iVt/vS4KT36Dfl/KyMMZPp/n3HCLCZfL RnhcpeRF5ljtyJISisVNR2Ao3km4kHi3XOXd2wm2zB+pC7RGrFxiOrHRml/t0ZU75/E9V/G1gkMzMA bYBPlLwaSECh1p4BKkpEVHMrBfqdMJl7HwZOaY635nIGeLzKNa+paO8isw2qNeXSBQ+HE3LVtu1BoX FIV4TfOq4/FCsyW2xPy1GlpQMz3ziHIwPRa9in2QGQNG9H2KORO4KgDoPrBJsUC799r3/tPkEREkiD XNPW8LUInius9iAjv85RZXeRhHm9GCQcWAzgaY1YxMtBVdMU5HpF/h4495zEQOh/W29jdOWIEj6Ime S2VlUmcNaWPgwi/4UbI7U+RprC76Fr7h/fbfHkMHTQOt5Kmf7E7z6x9UPdg5BesfwDlsd7ergfLoSG zX7CPpB3x+Uv06AyWCyIQAFMVRT5TENKsuaT9PPIj7R+YSeCKQlWLf0d9S0g==
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

Refactor bpf_free_local_kptr's bpf_list_head handling logic to introduce
the destructor for bpf_list_head inside local kptrs. The first argument
is pointer to the bpf_list_head inside local kptr, while the second
argument is the node offset of the value type of the list head.

It is possible to only take one argument and pass 'hidden' argument from
verifier side, but unlike helpers which always take 5 arguments at C ABI
level, kfuncs are more strongly checked from their prototype in kernel
BTF. So hidden arguments are more work to support.

Secondly, it would again require rewriting arguments and
bpf_patch_insn_data, which is expensive and slow. Hence, just force user
to pass the offset, but check that it is the right one from verifier
side, which turns out to be much more easier.

Ofcourse, this is a little bit inconvenient, we can explore improving it
later though.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf.h                           |  1 +
 kernel/bpf/helpers.c                          |  6 +++
 kernel/bpf/syscall.c                          | 39 ++++++++++++-------
 kernel/bpf/verifier.c                         | 26 ++++++++++++-
 .../testing/selftests/bpf/bpf_experimental.h  | 11 ++++++
 5 files changed, 69 insertions(+), 14 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index ad18408ba442..9279e453528c 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1733,6 +1733,7 @@ void bpf_map_free_kptr_off_tab(struct bpf_map *map);
 struct bpf_map_value_off *bpf_map_copy_kptr_off_tab(const struct bpf_map *map);
 bool bpf_map_equal_kptr_off_tab(const struct bpf_map *map_a, const struct bpf_map *map_b);
 void bpf_map_free_kptrs(struct bpf_map *map, void *map_value);
+void bpf_free_local_kptr_list_head(struct list_head *list, u32 list_node_off);
 
 struct bpf_map_value_off_desc *bpf_map_list_head_off_contains(struct bpf_map *map, u32 offset);
 void bpf_map_free_list_head_off_tab(struct bpf_map *map);
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 832dd57ae608..030c35bf030d 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1800,6 +1800,11 @@ struct bpf_list_node *bpf_list_pop_back(struct bpf_list_head *head)
 	return (struct bpf_list_node *)node;
 }
 
+void bpf_list_head_fini(struct bpf_list_head *head__dlkptr, u64 node_off__k)
+{
+	bpf_free_local_kptr_list_head((struct list_head *)head__dlkptr, node_off__k);
+}
+
 __diag_pop();
 
 BTF_SET8_START(tracing_btf_ids)
@@ -1816,6 +1821,7 @@ BTF_ID_FLAGS(func, bpf_list_add_tail)
 BTF_ID_FLAGS(func, bpf_list_del)
 BTF_ID_FLAGS(func, bpf_list_pop_front, KF_ACQUIRE | KF_RET_NULL | __KF_RET_DYN_BTF)
 BTF_ID_FLAGS(func, bpf_list_pop_back, KF_ACQUIRE | KF_RET_NULL | __KF_RET_DYN_BTF)
+BTF_ID_FLAGS(func, bpf_list_head_fini)
 BTF_SET8_END(tracing_btf_ids)
 
 static const struct btf_kfunc_id_set tracing_kfunc_set = {
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index f1e244b03382..feaf4351345b 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -590,12 +590,31 @@ bool bpf_map_equal_kptr_off_tab(const struct bpf_map *map_a, const struct bpf_ma
 				       map_value_has_kptrs(map_b));
 }
 
+void bpf_free_local_kptr_list_head(struct list_head *list, u32 list_node_off)
+{
+	struct list_head *olist;
+	void *entry;
+
+	/* List elements for bpf_list_head in local kptr cannot have
+	 * bpf_list_head again. Hence, just iterate and kfree them.
+	 */
+	olist = list;
+	list = list->next;
+	if (!list)
+		goto init;
+	while (list != olist) {
+		entry = list - list_node_off;
+		list = list->next;
+		kfree(entry);
+	}
+init:
+	INIT_LIST_HEAD(olist);
+}
+
 static void bpf_free_local_kptr(const struct btf *btf, u32 btf_id, void *kptr)
 {
-	struct list_head *list, *olist;
-	u32 offset, list_node_off;
+	u32 list_head_off, list_node_off;
 	const struct btf_type *t;
-	void *entry;
 	int ret;
 
 	if (!kptr)
@@ -613,19 +632,13 @@ static void bpf_free_local_kptr(const struct btf *btf, u32 btf_id, void *kptr)
 	 * do quick lookups into it. Instead of offset, table would be keyed by
 	 * btf_id.
 	 */
-	ret = __btf_local_type_has_bpf_list_head(btf, t, &offset, NULL, &list_node_off);
+	ret = __btf_local_type_has_bpf_list_head(btf, t, &list_head_off, NULL, &list_node_off);
 	if (ret <= 0)
 		goto free_kptr;
 	/* List elements for bpf_list_head in local kptr cannot have
-	 * bpf_list_head again. Hence, just iterate and kfree them.
-	 */
-	olist = list = kptr + offset;
-	list = list->next;
-	while (list != olist) {
-		entry = list - list_node_off;
-		list = list->next;
-		kfree(entry);
-	}
+         * bpf_list_head again. Hence, just iterate and kfree them.
+         */
+	bpf_free_local_kptr_list_head(kptr + list_head_off, list_node_off);
 free_kptr:
 	kfree(kptr);
 }
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index d2c4ffc80f4d..b795fe9a88da 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7911,6 +7911,7 @@ BTF_ID(func, bpf_list_add_tail)
 BTF_ID(func, bpf_list_del)
 BTF_ID(func, bpf_list_pop_front)
 BTF_ID(func, bpf_list_pop_back)
+BTF_ID(func, bpf_list_head_fini)
 BTF_ID(struct, btf) /* empty entry */
 
 enum bpf_special_kfuncs {
@@ -7924,6 +7925,7 @@ enum bpf_special_kfuncs {
 	KF_SPECIAL_bpf_list_del,
 	KF_SPECIAL_bpf_list_pop_front,
 	KF_SPECIAL_bpf_list_pop_back,
+	KF_SPECIAL_bpf_list_head_fini,
 	KF_SPECIAL_bpf_empty,
 	KF_SPECIAL_MAX = KF_SPECIAL_bpf_empty,
 };
@@ -8156,7 +8158,7 @@ static int find_local_type_fields(const struct btf *btf, u32 btf_id, struct loca
 
 	FILL_LOCAL_TYPE_FIELD(bpf_list_node, bpf_list_node_init, bpf_empty, false);
 	FILL_LOCAL_TYPE_FIELD(bpf_spin_lock, bpf_spin_lock_init, bpf_empty, false);
-	FILL_LOCAL_TYPE_FIELD(bpf_list_head, bpf_list_head_init, bpf_empty, true);
+	FILL_LOCAL_TYPE_FIELD(bpf_list_head, bpf_list_head_init, bpf_list_head_fini, true);
 
 #undef FILL_LOCAL_TYPE_FIELD
 
@@ -8391,6 +8393,19 @@ process_kf_arg_destructing_local_kptr(struct bpf_verifier_env *env,
 			if (mark_dtor)
 				ireg->type |= OBJ_DESTRUCTING;
 		}));
+
+		/* Stash the list_node offset in value type of the
+		 * bpf_list_head, so that offset of node in next argument can be
+		 * checked for bpf_list_head_fini.
+		 */
+		if (fields[i].type == FIELD_bpf_list_head) {
+			ret = __btf_local_type_has_bpf_list_head(reg->btf, btf_type_by_id(reg->btf, reg->btf_id),
+								 NULL, NULL, &meta->list_node.off);
+			if (ret <= 0) {
+				verbose(env, "verifier internal error: bpf_list_head not found\n");
+				return -EFAULT;
+			}
+		}
 		return 0;
 	}
 	verbose(env, "no destructible field at offset: %d\n", reg->off);
@@ -8875,6 +8890,15 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_arg_m
 		return -EINVAL;
 	}
 
+	/* Special semantic checks for some functions */
+	if (is_kfunc_special(meta->btf, meta->func_id, bpf_list_head_fini)) {
+		if (!meta->arg_constant.found || meta->list_node.off != meta->arg_constant.value) {
+			verbose(env, "arg#1 to bpf_list_head_fini must be constant %d\n",
+				meta->list_node.off);
+			return -EINVAL;
+		}
+	}
+
 	return 0;
 }
 
diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
index a8f7a5af8ee3..60fe48df4f68 100644
--- a/tools/testing/selftests/bpf/bpf_experimental.h
+++ b/tools/testing/selftests/bpf/bpf_experimental.h
@@ -102,4 +102,15 @@ struct bpf_list_node *bpf_list_pop_front(struct bpf_list_head *head) __ksym;
  */
 struct bpf_list_node *bpf_list_pop_back(struct bpf_list_head *head) __ksym;
 
+/* Description
+ *	Destruct bpf_list_head field in a local kptr. This kfunc has destructor
+ *	semantics, and marks local kptr as destructing if it isn't already.
+ *
+ *	Note that value_node_offset is the offset of bpf_list_node inside the
+ *	value type of local kptr's bpf_list_head. It must be a known constant.
+ * Returns
+ *	Void.
+ */
+void bpf_list_head_fini(struct bpf_list_head *node, u64 value_node_offset) __ksym;
+
 #endif
-- 
2.34.1

