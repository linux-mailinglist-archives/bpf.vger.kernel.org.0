Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5B9B31CBC2
	for <lists+bpf@lfdr.de>; Tue, 16 Feb 2021 15:21:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbhBPOUW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 16 Feb 2021 09:20:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230196AbhBPOUM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 16 Feb 2021 09:20:12 -0500
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48F72C061574
        for <bpf@vger.kernel.org>; Tue, 16 Feb 2021 06:19:32 -0800 (PST)
Received: by mail-qt1-x849.google.com with SMTP id n4so7826371qte.11
        for <bpf@vger.kernel.org>; Tue, 16 Feb 2021 06:19:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=C+z2l1Z8SEwFSvAfHkg3uXhxtmTk3DKZDz4dc2bKtl4=;
        b=CT8p/H0hPNVOkrHpP24jyvc3W3A8cPyxSFTTSFNf3AhNybMMTc6RNlLYhURB8W9CT8
         O1GmBHiF07E5BDeOCIkuWUj+vSF6juA9inSU0vrh5A2EE/wLbIF7x5DyByibtMjqj66b
         s8viy4kuodaGzFb5fab82zAOy62qo95KANgpwWdVsKx6u8EZKUO1jGDjmI1Neo9KCPKL
         ACy1ViHOHMHlcYQW/QUs7LZYT6whnb0r8yXkSWrfQGfiHeqz+av7QDdxfUiwpKB3MBC9
         /mWipfyNIMYCyCEszmUX+mdPWlDGdOo/CBQqq5GZzSHKZQ1XnO/LmxuTI7DxlVzm6bEj
         3lfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=C+z2l1Z8SEwFSvAfHkg3uXhxtmTk3DKZDz4dc2bKtl4=;
        b=GW49gkS6u+UVr63JuM8e7ZbXF4lx0iWdiTZKUL1F9t/+z69wiZ2Dp1jz2mLrIYUX7T
         nP2aAtZ3xk6JF08G+DBU9j7u2trYbA6dd67T9eTOmmscbtWKs/ReIGAYWw92w2dYWwXY
         WAaBd+UlOPY9gzYTArjQPURzkIekSC9LIxA4kJPeSMUXv51uKu65MSoKtP9Gh9gWAeas
         5Dje7Px9mCidjP6ruMDfwFRRwviWLlkVgoPzbWVJNaVvSCNS7hRpPKxkeie5qAwwM8o1
         5MJJ/X3LbtvzrCI8FOXMOcuMLAFxpQ0sVb0KLJ0ykrZO+XgnIxlBnoemmHhmESIsevZr
         EUcg==
X-Gm-Message-State: AOAM532spSi9/MYJzDHwYQsEXZSWyZgv+Jr20NEqg1V1HeszVoBFA6hS
        hADN6OjInKpWB1ZuA6N6evVc+pqAiX3Kvv2QQOXtDMG9fFZ5y8bjzBayw3DLcx8MeO3GG/NmkzG
        k6RvOxov+F7NVaI6Kv8hSTyOGkU/SKq/g77oAf2/IWHAUqrFMKXdFul018O2+6fk=
X-Google-Smtp-Source: ABdhPJyJVA1QK2v5nil6qrTYbcNyWjsTUGhB0HFeGwV7NJTuuTuzDvvnx85v4QOZ3xcE9GN/1zw3wsItqkHRhw==
Sender: "jackmanb via sendgmr" <jackmanb@beeg.c.googlers.com>
X-Received: from beeg.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:11db])
 (user=jackmanb job=sendgmr) by 2002:a05:6214:2022:: with SMTP id
 2mr10214189qvf.39.1613485171364; Tue, 16 Feb 2021 06:19:31 -0800 (PST)
Date:   Tue, 16 Feb 2021 14:19:25 +0000
Message-Id: <20210216141925.1549405-1-jackmanb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
Subject: [PATCH v2 bpf-next] bpf: Explicitly zero-extend R0 after 32-bit cmpxchg
From:   Brendan Jackman <jackmanb@google.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

As pointed out by Ilya and explained in the new comment, there's a
discrepancy between x86 and BPF CMPXCHG semantics: BPF always loads
the value from memory into r0, while x86 only does so when r0 and the
value in memory are different. The same issue affects s390.

At first this might sound like pure semantics, but it makes a real
difference when the comparison is 32-bit, since the load will
zero-extend r0/rax.

The fix is to explicitly zero-extend rax after doing such a
CMPXCHG. Since this problem affects multiple archs, this is done in
the verifier by patching in a BPF_ZEXT_REG instruction after every
32-bit cmpxchg. Any archs that don't need such manual zero-extension
can do a look-ahead with insn_is_zext to skip the unnecessary mov.

Reported-by: Ilya Leoshkevich <iii@linux.ibm.com>
Fixes: 5ffa25502b5a ("bpf: Add instructions for atomic_[cmp]xchg")
Signed-off-by: Brendan Jackman <jackmanb@google.com>
---

Difference from v1[1]: Now solved centrally in the verifier instead of
  specifically for the x86 JIT. Thanks to Ilya and Daniel for the suggestions!

[1] https://lore.kernel.org/bpf/d7ebaefb-bfd6-a441-3ff2-2fdfe699b1d2@iogearbox.net/T/#t

 kernel/bpf/verifier.c                         | 36 +++++++++++++++++++
 .../selftests/bpf/verifier/atomic_cmpxchg.c   | 25 +++++++++++++
 .../selftests/bpf/verifier/atomic_or.c        | 26 ++++++++++++++
 3 files changed, 87 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 16ba43352a5f..7f4a83d62acc 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -11889,6 +11889,39 @@ static int fixup_bpf_calls(struct bpf_verifier_env *env)
 	return 0;
 }

+/* BPF_CMPXCHG always loads a value into R0, therefore always zero-extends.
+ * However some archs' equivalent instruction only does this load when the
+ * comparison is successful. So here we add a BPF_ZEXT_REG after every 32-bit
+ * CMPXCHG, so that such archs' JITs don't need to deal with the issue. Archs
+ * that don't face this issue may use insn_is_zext to detect and skip the added
+ * instruction.
+ */
+static int add_zext_after_cmpxchg(struct bpf_verifier_env *env)
+{
+	struct bpf_insn zext_patch[2] = { [1] = BPF_ZEXT_REG(BPF_REG_0) };
+	struct bpf_insn *insn = env->prog->insnsi;
+	int insn_cnt = env->prog->len;
+	struct bpf_prog *new_prog;
+	int delta = 0; /* Number of instructions added */
+	int i;
+
+	for (i = 0; i < insn_cnt; i++, insn++) {
+		if (insn->code != (BPF_STX | BPF_W | BPF_ATOMIC) || insn->imm != BPF_CMPXCHG)
+			continue;
+
+		zext_patch[0] = *insn;
+		new_prog = bpf_patch_insn_data(env, i + delta, zext_patch, 2);
+		if (!new_prog)
+			return -ENOMEM;
+
+		delta++;
+		env->prog = new_prog;
+		insn = new_prog->insnsi + i + delta;
+	}
+
+	return 0;
+}
+
 static void free_states(struct bpf_verifier_env *env)
 {
 	struct bpf_verifier_state_list *sl, *sln;
@@ -12655,6 +12688,9 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr,
 	if (ret == 0)
 		ret = fixup_call_args(env);

+	if (ret == 0)
+		ret = add_zext_after_cmpxchg(env);
+
 	env->verification_time = ktime_get_ns() - start_time;
 	print_verification_stats(env);

diff --git a/tools/testing/selftests/bpf/verifier/atomic_cmpxchg.c b/tools/testing/selftests/bpf/verifier/atomic_cmpxchg.c
index 2efd8bcf57a1..6e52dfc64415 100644
--- a/tools/testing/selftests/bpf/verifier/atomic_cmpxchg.c
+++ b/tools/testing/selftests/bpf/verifier/atomic_cmpxchg.c
@@ -94,3 +94,28 @@
 	.result = REJECT,
 	.errstr = "invalid read from stack",
 },
+{
+	"BPF_W cmpxchg should zero top 32 bits",
+	.insns = {
+		/* r0 = U64_MAX; */
+		BPF_MOV64_IMM(BPF_REG_0, 0),
+		BPF_ALU64_IMM(BPF_SUB, BPF_REG_0, 1),
+		/* u64 val = r0; */
+		BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_0, -8),
+		/* r0 = (u32)atomic_cmpxchg((u32 *)&val, r0, 1); */
+		BPF_MOV32_IMM(BPF_REG_1, 1),
+		BPF_ATOMIC_OP(BPF_W, BPF_CMPXCHG, BPF_REG_10, BPF_REG_1, -8),
+		/* r1 = 0x00000000FFFFFFFFull; */
+		BPF_MOV64_IMM(BPF_REG_1, 1),
+		BPF_ALU64_IMM(BPF_LSH, BPF_REG_1, 32),
+		BPF_ALU64_IMM(BPF_SUB, BPF_REG_1, 1),
+		/* if (r0 != r1) exit(1); */
+		BPF_JMP_REG(BPF_JEQ, BPF_REG_0, BPF_REG_1, 2),
+		BPF_MOV32_IMM(BPF_REG_0, 1),
+		BPF_EXIT_INSN(),
+		/* exit(0); */
+		BPF_MOV32_IMM(BPF_REG_0, 0),
+		BPF_EXIT_INSN(),
+	},
+	.result = ACCEPT,
+},
diff --git a/tools/testing/selftests/bpf/verifier/atomic_or.c b/tools/testing/selftests/bpf/verifier/atomic_or.c
index 70f982e1f9f0..0a08b99e6ddd 100644
--- a/tools/testing/selftests/bpf/verifier/atomic_or.c
+++ b/tools/testing/selftests/bpf/verifier/atomic_or.c
@@ -75,3 +75,29 @@
 	},
 	.result = ACCEPT,
 },
+{
+	"BPF_W atomic_fetch_or should zero top 32 bits",
+	.insns = {
+		/* r1 = U64_MAX; */
+		BPF_MOV64_IMM(BPF_REG_1, 0),
+		BPF_ALU64_IMM(BPF_SUB, BPF_REG_1, 1),
+		/* u64 val = r0; */
+		BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_1, -8),
+		/* r1 = (u32)atomic_sub((u32 *)&val, 1); */
+		BPF_MOV32_IMM(BPF_REG_1, 2),
+		BPF_ATOMIC_OP(BPF_W, BPF_OR | BPF_FETCH, BPF_REG_10, BPF_REG_1, -8),
+		/* r2 = 0x00000000FFFFFFFF; */
+		BPF_MOV64_IMM(BPF_REG_2, 1),
+		BPF_ALU64_IMM(BPF_LSH, BPF_REG_2, 32),
+		BPF_ALU64_IMM(BPF_SUB, BPF_REG_2, 1),
+		/* if (r2 != r1) exit(1); */
+		BPF_JMP_REG(BPF_JEQ, BPF_REG_2, BPF_REG_1, 2),
+		/* BPF_MOV32_IMM(BPF_REG_0, 1), */
+		BPF_MOV64_REG(BPF_REG_0, BPF_REG_1),
+		BPF_EXIT_INSN(),
+		/* exit(0); */
+		BPF_MOV32_IMM(BPF_REG_0, 0),
+		BPF_EXIT_INSN(),
+	},
+	.result = ACCEPT,
+},

base-commit: 45159b27637b0fef6d5ddb86fc7c46b13c77960f
--
2.30.0.478.g8a0d178c01-goog

