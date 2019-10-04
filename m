Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D399ACC1A1
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2019 19:23:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388484AbfJDRWx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Oct 2019 13:22:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50390 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388321AbfJDRWq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Oct 2019 13:22:46 -0400
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com [209.85.167.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 427B979705
        for <bpf@vger.kernel.org>; Fri,  4 Oct 2019 17:22:45 +0000 (UTC)
Received: by mail-lf1-f71.google.com with SMTP id y27so772358lfg.21
        for <bpf@vger.kernel.org>; Fri, 04 Oct 2019 10:22:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=F4meXnZZR4fqpwAv9lrztd/EWhqarsHsKJt54pv+Qk0=;
        b=nCNJJuhocIscYqyBvfD3NWav5DpLUJ7i3fd5QnnCMd/YBsz2JcnpGW0B+b9ZcovPpo
         Nsg6BWL0rffdXG0yHR+8dIIGqj4YWJBJzulbQAaA1y+HxbczHKuw5Rv/8qnMtrxmI+O9
         XNVZDvfzQ3zJ9enikJVRFMWmzqLEN/HigdQgCyad7YoM+5rh9/9UdPLRVCxhj2NmExiJ
         pOZMkSxgrUteNZOZO7f23jud7Q3IhTfcfuqAAYQ19oKSt5XSOXRe0r7Wvy6F2pzyLBma
         JSM3iTFni7U+8E6Fwxw33HxAM4wsQYTpZHPW3KbC4lct37Hx/DlaTBGOXSRiVErXMn1m
         1bGg==
X-Gm-Message-State: APjAAAUfBz+4fsnIRfQc9d2ftVIqd4yexuXB69+wA61MD2Dk5s1PYkWN
        JkswZFBJknh7vqq2lmbCud5/TSF8kpEsOj4Dk5jacCB3GwRJW/D8dc05Xb/yvwPe8zZ2x96CvUs
        EnHHd6/oUvIZF
X-Received: by 2002:a2e:730a:: with SMTP id o10mr10636031ljc.214.1570209763731;
        Fri, 04 Oct 2019 10:22:43 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxHRJTCfcvsXHYOmbllo38oOd0jhYPGR+TCYKQTDz2UKe3wzrSmreET/PKxzJZxfQtBbo+TUA==
X-Received: by 2002:a2e:730a:: with SMTP id o10mr10636006ljc.214.1570209763395;
        Fri, 04 Oct 2019 10:22:43 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a00:7660:6da:443::2])
        by smtp.gmail.com with ESMTPSA id b25sm1651251ljj.36.2019.10.04.10.22.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2019 10:22:42 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 8B612180640; Fri,  4 Oct 2019 19:22:41 +0200 (CEST)
Subject: [PATCH bpf-next v2 1/5] bpf: Support injecting chain calls into BPF
 programs on load
From:   =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Marek Majkowski <marek@cloudflare.com>,
        Lorenz Bauer <lmb@cloudflare.com>,
        Alan Maguire <alan.maguire@oracle.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Date:   Fri, 04 Oct 2019 19:22:41 +0200
Message-ID: <157020976144.1824887.10249946730258092768.stgit@alrua-x1>
In-Reply-To: <157020976030.1824887.7191033447861395957.stgit@alrua-x1>
References: <157020976030.1824887.7191033447861395957.stgit@alrua-x1>
User-Agent: StGit/0.19-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Toke Høiland-Jørgensen <toke@redhat.com>

This adds support for injecting chain call logic into eBPF programs before
they return. The code injection is controlled by a flag at program load
time; if the flag is set, the verifier will add code to every BPF_EXIT
instruction that first does a lookup into a chain call structure to see if
it should call into another program before returning. The actual calls
reuse the tail call infrastructure.

Ideally, it shouldn't be necessary to set the flag on program load time,
but rather inject the calls when a chain call program is first loaded.
However, rewriting the program reallocates the bpf_prog struct, which is
obviously not possible after the program has been attached to something.

One way around this could be a sysctl to force the flag one (for enforcing
system-wide support). Another could be to have the chain call support
itself built into the interpreter and JIT, which could conceivably be
re-run each time we attach a new chain call program. This would also allow
the JIT to inject direct calls to the next program instead of using the
tail call infrastructure, which presumably would be a performance win. The
drawback is, of course, that it would require modifying all the JITs.

Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 include/linux/bpf.h      |    2 +
 include/uapi/linux/bpf.h |    6 ++++
 kernel/bpf/core.c        |   10 ++++++
 kernel/bpf/syscall.c     |    3 +-
 kernel/bpf/verifier.c    |   76 ++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 96 insertions(+), 1 deletion(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 5b9d22338606..753abfb78c13 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -383,6 +383,7 @@ struct bpf_prog_aux {
 	struct list_head ksym_lnode;
 	const struct bpf_prog_ops *ops;
 	struct bpf_map **used_maps;
+	struct bpf_array *chain_progs;
 	struct bpf_prog *prog;
 	struct user_struct *user;
 	u64 load_time; /* ns since boottime */
@@ -443,6 +444,7 @@ struct bpf_array {
 
 #define BPF_COMPLEXITY_LIMIT_INSNS      1000000 /* yes. 1M insns */
 #define MAX_TAIL_CALL_CNT 32
+#define BPF_NUM_CHAIN_SLOTS 8
 
 #define BPF_F_ACCESS_MASK	(BPF_F_RDONLY |		\
 				 BPF_F_RDONLY_PROG |	\
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 77c6be96d676..febe8934d19a 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -288,6 +288,12 @@ enum bpf_attach_type {
 /* The verifier internal test flag. Behavior is undefined */
 #define BPF_F_TEST_STATE_FREQ	(1U << 3)
 
+/* Whether to enable chain call injection at program return. If set, the
+ * verifier will rewrite program returns to check for and jump to chain call
+ * programs configured with the BPF_PROG_CHAIN_* commands to the bpf syscall.
+ */
+#define BPF_F_INJECT_CHAIN_CALLS	(1U << 4)
+
 /* When BPF ldimm64's insn[0].src_reg != 0 then this can have
  * two extensions:
  *
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 66088a9e9b9e..98f1ad920e48 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -255,6 +255,16 @@ void __bpf_prog_free(struct bpf_prog *fp)
 {
 	if (fp->aux) {
 		free_percpu(fp->aux->stats);
+		if (fp->aux->chain_progs) {
+			struct bpf_array *array = fp->aux->chain_progs;
+			int i;
+
+			for (i = 0; i < BPF_NUM_CHAIN_SLOTS; i++)
+				if (array->ptrs[i])
+					bpf_prog_put(array->ptrs[i]);
+
+			bpf_map_area_free(array);
+		}
 		kfree(fp->aux);
 	}
 	vfree(fp);
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 82eabd4e38ad..c2a49df5f921 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1630,7 +1630,8 @@ static int bpf_prog_load(union bpf_attr *attr, union bpf_attr __user *uattr)
 	if (attr->prog_flags & ~(BPF_F_STRICT_ALIGNMENT |
 				 BPF_F_ANY_ALIGNMENT |
 				 BPF_F_TEST_STATE_FREQ |
-				 BPF_F_TEST_RND_HI32))
+				 BPF_F_TEST_RND_HI32 |
+				 BPF_F_INJECT_CHAIN_CALLS))
 		return -EINVAL;
 
 	if (!IS_ENABLED(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS) &&
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index ffc3e53f5300..dbc9bbf13300 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -9154,6 +9154,79 @@ static int fixup_bpf_calls(struct bpf_verifier_env *env)
 	return 0;
 }
 
+static int bpf_inject_chain_calls(struct bpf_verifier_env *env)
+{
+	struct bpf_prog *prog = env->prog;
+	struct bpf_insn *insn = prog->insnsi;
+	int i, cnt, delta = 0, ret = -ENOMEM;
+	const int insn_cnt = prog->len;
+	struct bpf_array *prog_array;
+	struct bpf_prog *new_prog;
+	size_t array_size;
+
+	struct bpf_insn call_next[] = {
+		BPF_LD_IMM64(BPF_REG_2, 0),
+		/* Save real return value for later */
+		BPF_MOV64_REG(BPF_REG_6, BPF_REG_0),
+		/* First try tail call with index ret+1 */
+		BPF_MOV64_REG(BPF_REG_3, BPF_REG_0),
+		BPF_ALU64_IMM(BPF_ADD, BPF_REG_3, 1),
+		BPF_RAW_INSN(BPF_JMP | BPF_TAIL_CALL, 0, 0, 0, 0),
+		/* If that doesn't work, try with index 0 (wildcard) */
+		BPF_MOV64_IMM(BPF_REG_3, 0),
+		BPF_RAW_INSN(BPF_JMP | BPF_TAIL_CALL, 0, 0, 0, 0),
+		/* Restore saved return value and exit */
+		BPF_MOV64_REG(BPF_REG_0, BPF_REG_6),
+		BPF_EXIT_INSN()
+	};
+
+	if (prog->aux->chain_progs)
+		return 0;
+
+	array_size = sizeof(*prog_array) + BPF_NUM_CHAIN_SLOTS * sizeof(void*);
+	prog_array = bpf_map_area_alloc(array_size, NUMA_NO_NODE);
+
+	if (!prog_array)
+		goto out_err;
+
+	prog_array->elem_size = sizeof(void*);
+	prog_array->map.max_entries = BPF_NUM_CHAIN_SLOTS;
+
+	call_next[0].imm = (u32)((u64) prog_array);
+	call_next[1].imm = ((u64) prog_array) >> 32;
+
+	for (i = 0; i < insn_cnt; i++, insn++) {
+		if (insn->code != (BPF_JMP | BPF_EXIT))
+			continue;
+
+		cnt = ARRAY_SIZE(call_next);
+
+		new_prog = bpf_patch_insn_data(env, i+delta, call_next, cnt);
+		if (!new_prog) {
+			goto out_err;
+		}
+
+		delta    += cnt - 1;
+		env->prog = prog = new_prog;
+		insn      = new_prog->insnsi + i + delta;
+	}
+
+	/* If we chain call into other programs, we cannot make any assumptions
+	 * since they can be replaced dynamically during runtime.
+	 */
+	prog->cb_access = 1;
+	env->prog->aux->stack_depth = MAX_BPF_STACK;
+	env->prog->aux->max_pkt_offset = MAX_PACKET_OFF;
+
+	prog->aux->chain_progs = prog_array;
+	return 0;
+
+out_err:
+	bpf_map_area_free(prog_array);
+	return ret;
+}
+
+
 static void free_states(struct bpf_verifier_env *env)
 {
 	struct bpf_verifier_state_list *sl, *sln;
@@ -9336,6 +9409,9 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr,
 	if (ret == 0)
 		ret = fixup_bpf_calls(env);
 
+	if (ret == 0 && (attr->prog_flags & BPF_F_INJECT_CHAIN_CALLS))
+		ret = bpf_inject_chain_calls(env);
+
 	/* do 32-bit optimization after insn patching has done so those patched
 	 * insns could be handled correctly.
 	 */

