Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F8C34E9ED2
	for <lists+bpf@lfdr.de>; Mon, 28 Mar 2022 20:17:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245140AbiC1SSz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 28 Mar 2022 14:18:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245155AbiC1SSx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 28 Mar 2022 14:18:53 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D29664BE4
        for <bpf@vger.kernel.org>; Mon, 28 Mar 2022 11:17:04 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-2e6402f436cso125181177b3.3
        for <bpf@vger.kernel.org>; Mon, 28 Mar 2022 11:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Co/xGv2r3vy215Bwt4aigwl1bl7HKveKP+Fei159KlE=;
        b=LbBYuHIY/48PfIRKpw8E8PnJduzQlIo56f9znECRVUiit6mXogAIo8SY0yiEWIrwDf
         H+im3pZUl/nDJ4fvgnKasUU1K1xVjXbubAm/eMWWwwk0ockfzFTJRMwwRNxecSmToFhm
         UO+5YKMyW5/HhgOhpHkIruvtE8szlXIOIVJAJojReiUEQSIu/DQHL462ZIlcmsD5z+ap
         OQjV0rp7GEuxmOopaK5XJsvItMoXo34eKsKuXpJU+cwQML1VNyQGXJwekTXU57DnJJVP
         S1jOt9//M7UQE1oKqFD6QRPJjqC36zsE55+f89yP2bmhdWV/nKb+LAq4m7NToXCqYNVi
         2rqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Co/xGv2r3vy215Bwt4aigwl1bl7HKveKP+Fei159KlE=;
        b=OwJ7JG5N3+f0EOY9b5AApDWEKqzXulSRhu4SBI934AhurxYosOZrDCHyYsEPmTFQ5h
         jkAG+YeewB4ZODJ3cm6izb3dT14GvdEKaDwtBLLGvhogyXHFy679BcAFIK5XFbAT7YFD
         75DdEhkGGxqzv1rQKajK8tNTEu+TESQjab2yR/IYWVqgXWMiypqbIwlg4/spkIvydEl+
         HA47yq7py3sRPRdz/9IlQTXDq5L1igOaq70rclU0p35/Z9mx8JUB9+VLXunoAe5pJx8D
         OxWrE7yf+Fr81Qn57viUn6V7c1lAGIbdzj9pOxEN1Kv8Oe43OCV4iJEjANLfYY1MB4fB
         Fu3g==
X-Gm-Message-State: AOAM5303iP4mIQ+ThLGB74eEDjJdtBAAbnJytmiWzo2bqMfqbODcn9ij
        ZrD14NOSb1A5pvIl/wb6b/lGnbM=
X-Google-Smtp-Source: ABdhPJzzpMZaBHZsAkx/GCJpvD1aeHhtXj6W+TnG4b19zrp1qyNZHwjUnklZPOHVtmXCOLhlH8GWZGE=
X-Received: from sdf2.svl.corp.google.com ([2620:15c:2c4:201:a900:e0f6:cf98:d8c8])
 (user=sdf job=sendgmr) by 2002:a25:2388:0:b0:633:ca61:bd48 with SMTP id
 j130-20020a252388000000b00633ca61bd48mr24219224ybj.120.1648491423711; Mon, 28
 Mar 2022 11:17:03 -0700 (PDT)
Date:   Mon, 28 Mar 2022 11:16:44 -0700
In-Reply-To: <20220328181644.1748789-1-sdf@google.com>
Message-Id: <20220328181644.1748789-8-sdf@google.com>
Mime-Version: 1.0
References: <20220328181644.1748789-1-sdf@google.com>
X-Mailer: git-send-email 2.35.1.1021.g381101b075-goog
Subject: [PATCH bpf-next 7/7] selftests/bpf: verify lsm_cgroup struct sock access
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,TVD_PH_SUBJ_META,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

sk_priority & sk_mark are writable, the rest is readonly.

Add new ldx_offset fixups to lookup the offset of struct field.
Allow using test.kfunc regardless of prog_type.

One interesting thing here is that the verifier doesn't
really force me to add NULL checks anywhere :-/

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 tools/testing/selftests/bpf/test_verifier.c   | 54 ++++++++++++++++++-
 .../selftests/bpf/verifier/lsm_cgroup.c       | 34 ++++++++++++
 2 files changed, 87 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/verifier/lsm_cgroup.c

diff --git a/tools/testing/selftests/bpf/test_verifier.c b/tools/testing/selftests/bpf/test_verifier.c
index a2cd236c32eb..d6bc55c54aaa 100644
--- a/tools/testing/selftests/bpf/test_verifier.c
+++ b/tools/testing/selftests/bpf/test_verifier.c
@@ -75,6 +75,12 @@ struct kfunc_btf_id_pair {
 	int insn_idx;
 };
 
+struct ldx_offset {
+	const char *strct;
+	const char *field;
+	int insn_idx;
+};
+
 struct bpf_test {
 	const char *descr;
 	struct bpf_insn	insns[MAX_INSNS];
@@ -102,6 +108,7 @@ struct bpf_test {
 	int fixup_map_ringbuf[MAX_FIXUPS];
 	int fixup_map_timer[MAX_FIXUPS];
 	struct kfunc_btf_id_pair fixup_kfunc_btf_id[MAX_FIXUPS];
+	struct ldx_offset fixup_ldx[MAX_FIXUPS];
 	/* Expected verifier log output for result REJECT or VERBOSE_ACCEPT.
 	 * Can be a tab-separated sequence of expected strings. An empty string
 	 * means no log verification.
@@ -755,6 +762,7 @@ static void do_test_fixup(struct bpf_test *test, enum bpf_prog_type prog_type,
 	int *fixup_map_ringbuf = test->fixup_map_ringbuf;
 	int *fixup_map_timer = test->fixup_map_timer;
 	struct kfunc_btf_id_pair *fixup_kfunc_btf_id = test->fixup_kfunc_btf_id;
+	struct ldx_offset *fixup_ldx = test->fixup_ldx;
 
 	if (test->fill_helper) {
 		test->fill_insns = calloc(MAX_TEST_INSNS, sizeof(struct bpf_insn));
@@ -967,6 +975,50 @@ static void do_test_fixup(struct bpf_test *test, enum bpf_prog_type prog_type,
 			fixup_kfunc_btf_id++;
 		} while (fixup_kfunc_btf_id->kfunc);
 	}
+
+	if (fixup_ldx->strct) {
+		const struct btf_member *memb;
+		const struct btf_type *tp;
+		const char *name;
+		struct btf *btf;
+		int btf_id;
+		int off;
+		int i;
+
+		btf = btf__load_vmlinux_btf();
+
+		do {
+			off = -1;
+			if (!btf)
+				goto next_ldx;
+
+			btf_id = btf__find_by_name_kind(btf,
+							fixup_ldx->strct,
+							BTF_KIND_STRUCT);
+			if (btf_id < 0)
+				goto next_ldx;
+
+			tp = btf__type_by_id(btf, btf_id);
+			memb = btf_members(tp);
+
+			for (i = 0; i < btf_vlen(tp); i++) {
+				name = btf__name_by_offset(btf,
+							   memb->name_off);
+				if (strcmp(fixup_ldx->field, name) == 0) {
+					off = memb->offset / 8;
+					break;
+				}
+				memb++;
+			}
+
+next_ldx:
+			prog[fixup_ldx->insn_idx].off = off;
+			fixup_ldx++;
+
+		} while (fixup_ldx->strct);
+
+		btf__free(btf);
+	}
 }
 
 struct libcap {
@@ -1131,7 +1183,7 @@ static void do_test_single(struct bpf_test *test, bool unpriv,
 		opts.log_level = 4;
 	opts.prog_flags = pflags;
 
-	if (prog_type == BPF_PROG_TYPE_TRACING && test->kfunc) {
+	if (test->kfunc) {
 		int attach_btf_id;
 
 		attach_btf_id = libbpf_find_vmlinux_btf_id(test->kfunc,
diff --git a/tools/testing/selftests/bpf/verifier/lsm_cgroup.c b/tools/testing/selftests/bpf/verifier/lsm_cgroup.c
new file mode 100644
index 000000000000..af0efe783511
--- /dev/null
+++ b/tools/testing/selftests/bpf/verifier/lsm_cgroup.c
@@ -0,0 +1,34 @@
+#define SK_WRITABLE_FIELD(tp, field, size, res) \
+{ \
+	.descr = field, \
+	.insns = { \
+		/* r1 = *(u64 *)(r1 + 0) */ \
+		BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_1, 0), \
+		/* r1 = *(u64 *)(r1 + offsetof(struct socket, sk)) */ \
+		BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_1, 0), \
+		/* r2 = *(u64 *)(r1 + offsetof(struct sock, <field>)) */ \
+		BPF_LDX_MEM(size, BPF_REG_2, BPF_REG_1, 0), \
+		/* *(u64 *)(r1 + offsetof(struct sock, <field>)) = r2 */ \
+		BPF_STX_MEM(size, BPF_REG_1, BPF_REG_2, 0), \
+		BPF_MOV64_IMM(BPF_REG_0, 1), \
+		BPF_EXIT_INSN(), \
+	}, \
+	.result = res, \
+	.errstr = res ? "no write support to 'struct sock' at off" : "", \
+	.prog_type = BPF_PROG_TYPE_LSM, \
+	.expected_attach_type = BPF_LSM_CGROUP, \
+	.kfunc = "socket_post_create", \
+	.fixup_ldx = { \
+		{ "socket", "sk", 1 }, \
+		{ tp, field, 2 }, \
+		{ tp, field, 3 }, \
+	}, \
+}
+
+SK_WRITABLE_FIELD("sock_common", "skc_family", BPF_H, REJECT),
+SK_WRITABLE_FIELD("sock", "sk_sndtimeo", BPF_DW, REJECT),
+SK_WRITABLE_FIELD("sock", "sk_priority", BPF_W, ACCEPT),
+SK_WRITABLE_FIELD("sock", "sk_mark", BPF_W, ACCEPT),
+SK_WRITABLE_FIELD("sock", "sk_pacing_rate", BPF_DW, REJECT),
+
+#undef SK_WRITABLE_FIELD
-- 
2.35.1.1021.g381101b075-goog

