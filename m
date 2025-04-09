Return-Path: <bpf+bounces-55505-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86635A81B99
	for <lists+bpf@lfdr.de>; Wed,  9 Apr 2025 05:38:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A4C67B639E
	for <lists+bpf@lfdr.de>; Wed,  9 Apr 2025 03:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF29B1C5D7D;
	Wed,  9 Apr 2025 03:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="UXfmFIuG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NG95msL7"
X-Original-To: bpf@vger.kernel.org
Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F091C57B2;
	Wed,  9 Apr 2025 03:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744169707; cv=none; b=DeelSv+Wkp/K9BR4CK6TyHjUIUNHGGbpPT2uneOvd2f/D5VoBnFMM/Ug5wUR8EoAEwsplbJp4wA8dIJcsV0ex+P0HZlaZD4eICuYjLbH++CdLgOsccX/VVdo82hyFZBeQGWAPymJSNEpA+04JbY5RbXudK0+E52SKLZNfmi7+GM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744169707; c=relaxed/simple;
	bh=B04kxiv2MQQ7PBpdqgDE+iXkeCnRc7TBYsgOtOOsFnU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n1DwP+Y1pWgiKf9zxcRELtR8N0JHigDN2drNqk+tKHyutx/UyyUGBsEKBI4nf/h7wy2ezX7DbG4qzqJk73f11lzDzGBJWhz9PLsYDbVQEUP5poyLK6zVp1PH3QXskOe1pjcOXN/pbXZye2SUzOZszasid0UUhnsSCoO9ertjkuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=UXfmFIuG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NG95msL7; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id B5AD613801DD;
	Tue,  8 Apr 2025 23:35:04 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 08 Apr 2025 23:35:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1744169704; x=
	1744256104; bh=71eCra28VqFvwu+DqJB69IOBTAVWWSIfZcw9cSyC1Yo=; b=U
	XfmFIuG//PqtTp2caDVnfoh6yIqhFrwRYNXpC+xBN+adWC5vsbwY0hFkxlR/wWTO
	Gs9y+MyY0PRCU7LqRDc1Y278FKgqhkisyDyEQXC2Wb80lTkSbK1C0cFHX7ZZ7jls
	xzcJ+2oMx4KIoJorJiM9EuQopRHJNra/A7m1rH/xKj8n3LxYMKm+7BpoEBji8Km6
	eCr+f6X/bQAi1ZowG67W841rX5f91xIKS0Ju7Wm6UWNS90gMsgAt5D6UbEYFuLSg
	Ts0ffNUv0z+yjB5AiVMLxFFgWrd+gOO6Y2IoWjrf7LmhSm5yocQK7mxYsOaFHP/c
	mrCr5OyCQLjz2OHxKgB2Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1744169704; x=1744256104; bh=7
	1eCra28VqFvwu+DqJB69IOBTAVWWSIfZcw9cSyC1Yo=; b=NG95msL7C8ywuv44u
	tVqWfPVhpLtK2xaMMDk2+kg7Qfok/zel/WCEC0IJDcgispfkhHZmvAG8v72OqPgi
	gMiC2bqrbgieZOMbj2r1Q3G7uC/F9ydZEv2DCdIyqXk/+85Av81A4iBgB/ysSrXZ
	4Cl4ZmtB1Ms6eb9OlSyho2sfzHQeomGkaTJhybtBWPyedIT56FPYyhoc9YYukcEa
	OuLEe9dg4RhRA+vV3+B8UvY005l2PwZIJokouVYPmuJxg2IpJ3DVeYnh+8t4s2ik
	U6FjVVyJeYLxdoAbRYwka6KN08ufNwsV9pf4qdiGs4OaTudL5P2QgGwjwkhIRMOP
	mYukA==
X-ME-Sender: <xms:6Or1Z483vV3H1jWuaaom8Ccou2Ej438XzL_gQm1tRUrcvHTtn33r3g>
    <xme:6Or1Zws-RWu_JNhuOW0sTknLwYqZAqC6y796EFoEJRdCal59yuPhF445FSFLyMDR4
    pVGrLnqB8etwm_7mg>
X-ME-Received: <xmr:6Or1Z-CkvZWWpnUaIkL1NLpA5uUnz0c_EDEduuWw2M9EUXdiIoYksLr0sQFHxr4uAR4go91xeU0QVzTAGJ-CzsWK-m1XOELxJiyp2ZU6p-GXeB_74WDQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtdegledvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffuc
    dljedtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhm
    peffrghnihgvlhcuighuuceougiguhesugiguhhuuhdrgiihiieqnecuggftrfgrthhtvg
    hrnhepgfefgfegjefhudeikedvueetffelieefuedvhfehjeeljeejkefgffeghfdttdet
    necuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepugiguh
    esugiguhhuuhdrgiihiidpnhgspghrtghpthhtohepudegpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopegrnhgurhhiiheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprg
    hstheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrnhhivghlsehiohhgvggrrhgs
    ohigrdhnvghtpdhrtghpthhtohepmhgrrhhtihhnrdhlrghusehlihhnuhigrdguvghvpd
    hrtghpthhtohepvgguugihiiekjeesghhmrghilhdrtghomhdprhgtphhtthhopehsohhn
    gheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohephihonhhghhhonhhgrdhsohhngheslh
    hinhhugidruggvvhdprhgtphhtthhopehjohhhnhdrfhgrshhtrggsvghnugesghhmrghi
    lhdrtghomhdprhgtphhtthhopehkphhsihhnghhhsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:6Or1Z4ffQ6fZYluUiWidoSQaLtWgHJEj68yJ1TTz5FNF4iT2eZnLhw>
    <xmx:6Or1Z9M6cZG0DDoDlxAhUvOENNrLyKK4sIpXeFlyF79x_JV2f5TnIA>
    <xmx:6Or1Zyk6el0PzGXZRSkA-3P_4CdxcQMyJsHJTZoCYDvi-MQdRzd_7Q>
    <xmx:6Or1Z_sqtTuvi9hNPM6JyWuBWubIosdDgxfKX583Qt41Styr7bOPQQ>
    <xmx:6Or1Z64Tx_yPvpZNFi-eTGcFa6nH56NVJnRWmM9ASjwM9MLS-gbRuwQ5>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Apr 2025 23:35:03 -0400 (EDT)
From: Daniel Xu <dxu@dxuuu.xyz>
To: andrii@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net
Cc: martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC bpf-next 12/13] bpf: verifier: Make verifier loadable
Date: Tue,  8 Apr 2025 21:34:07 -0600
Message-ID: <32da0f412d267be39872c4c2de1f48f12ad7571e.1744169424.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1744169424.git.dxu@dxuuu.xyz>
References: <cover.1744169424.git.dxu@dxuuu.xyz>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit makes the BPF verifier loadable, with the default being the
same as before (built in). Note that no matter the build configuration,
it is always possible to load a new module (evicting the previous).

Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 include/linux/bpf.h   | 15 ++++++++++++---
 kernel/bpf/Kconfig    | 12 ++++++++++++
 kernel/bpf/Makefile   |  3 ++-
 kernel/bpf/core.c     |  4 ++++
 kernel/bpf/syscall.c  | 45 ++++++++++++++++++++++++++++++++++++++++++-
 kernel/bpf/verifier.c | 28 +++++++++++++++++++++++++--
 6 files changed, 100 insertions(+), 7 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index a5806a7b31d3..127b75ecc532 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -72,6 +72,18 @@ typedef int (*bpf_iter_init_seq_priv_t)(void *private_data,
 typedef void (*bpf_iter_fini_seq_priv_t)(void *private_data);
 typedef unsigned int (*bpf_func_t)(const void *,
 				   const struct bpf_insn *);
+
+struct bpf_check_hook {
+	struct module *owner;
+	/* verify correctness of eBPF program */
+	int (*bpf_check)(struct bpf_prog **prog,
+			 union bpf_attr *attr,
+			 bpfptr_t uattr,
+			 __u32 uattr_size);
+};
+
+extern const struct bpf_check_hook __rcu *bpf_check;
+
 struct bpf_iter_seq_info {
 	const struct seq_operations *seq_ops;
 	bpf_iter_init_seq_priv_t init_seq_private;
@@ -2663,9 +2675,6 @@ int bpf_get_file_flag(int flags);
 int bpf_check_uarg_tail_zero(bpfptr_t uaddr, size_t expected_size,
 			     size_t actual_size);
 
-/* verify correctness of eBPF program */
-int bpf_check(struct bpf_prog **fp, union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size);
-
 #ifndef CONFIG_BPF_JIT_ALWAYS_ON
 void bpf_patch_call_args(struct bpf_insn *insn, u32 stack_depth);
 #endif
diff --git a/kernel/bpf/Kconfig b/kernel/bpf/Kconfig
index 17067dcb4386..90745b6e2af1 100644
--- a/kernel/bpf/Kconfig
+++ b/kernel/bpf/Kconfig
@@ -39,6 +39,18 @@ config BPF_SYSCALL
 	  Enable the bpf() system call that allows to manipulate BPF programs
 	  and maps via file descriptors.
 
+config BPF_VERIFIER
+	tristate "BPF verifier"
+	default y
+	depends on BPF_SYSCALL
+	help
+	  Controls if BPF verifier is built as a kernel module or not.
+
+	  Regardless of choice, it is possible to dynamically load a new verifier
+	  module.
+
+	  If you are unsure how to answer this question, answer Y.
+
 config BPF_JIT
 	bool "Enable BPF Just In Time compiler"
 	depends on BPF
diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
index 70502f038b92..82cf9ea39225 100644
--- a/kernel/bpf/Makefile
+++ b/kernel/bpf/Makefile
@@ -6,11 +6,12 @@ cflags-nogcse-$(CONFIG_X86)$(CONFIG_CC_IS_GCC) := -fno-gcse
 endif
 CFLAGS_core.o += -Wno-override-init $(cflags-nogcse-yy)
 
-obj-$(CONFIG_BPF_SYSCALL) += syscall.o verifier.o inode.o helpers.o tnum.o log.o token.o
+obj-$(CONFIG_BPF_SYSCALL) += syscall.o inode.o helpers.o tnum.o log.o token.o
 obj-$(CONFIG_BPF_SYSCALL) += bpf_iter.o map_iter.o task_iter.o prog_iter.o link_iter.o
 obj-$(CONFIG_BPF_SYSCALL) += hashtab.o arraymap.o percpu_freelist.o bpf_lru_list.o lpm_trie.o map_in_map.o bloom_filter.o
 obj-$(CONFIG_BPF_SYSCALL) += local_storage.o queue_stack_maps.o ringbuf.o
 obj-$(CONFIG_BPF_SYSCALL) += bpf_local_storage.o bpf_task_storage.o
+obj-$(CONFIG_BPF_VERIFIER) += verifier.o
 obj-${CONFIG_BPF_LSM}	  += bpf_inode_storage.o
 obj-$(CONFIG_BPF_SYSCALL) += disasm.o mprog.o
 obj-$(CONFIG_BPF_JIT) += trampoline.o
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 6c8bb4cdac0f..25eac0e2f929 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -30,6 +30,7 @@
 #include <linux/kallsyms.h>
 #include <linux/rcupdate.h>
 #include <linux/perf_event.h>
+#include <linux/export.h>
 #include <linux/extable.h>
 #include <linux/log2.h>
 #include <linux/bpf_verifier.h>
@@ -44,6 +45,9 @@
 #include <asm/barrier.h>
 #include <linux/unaligned.h>
 
+const struct bpf_check_hook *bpf_check __rcu __read_mostly;
+EXPORT_SYMBOL_GPL(bpf_check);
+
 /* Registers */
 #define BPF_R0	regs[BPF_REG_0]
 #define BPF_R1	regs[BPF_REG_1]
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 2ef55503ba32..7cf65d2c37ee 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2759,6 +2759,41 @@ static bool is_perfmon_prog_type(enum bpf_prog_type prog_type)
 	}
 }
 
+static const struct bpf_check_hook *bpf_check_get(void)
+{
+	const struct bpf_check_hook *hook;
+	int err;
+
+	/* RCU protects us from races against module unloading */
+	rcu_read_lock();
+	hook = rcu_dereference(bpf_check);
+	if (!hook) {
+		rcu_read_unlock();
+		err = request_module("verifier");
+		if (err)
+			return ERR_PTR(err < 0 ? err : -ENOENT);
+
+		rcu_read_lock();
+		hook = rcu_dereference(bpf_check);
+	}
+
+	if (hook && try_module_get(hook->owner)) {
+		/* Once we have a refcnt on the module, we no longer need RCU */
+		hook = rcu_pointer_handoff(hook);
+	} else {
+		WARN_ONCE(!hook, "verifier has bad registration");
+		hook = ERR_PTR(-ENOENT);
+	}
+	rcu_read_unlock();
+
+	return hook;
+}
+
+static void bpf_check_put(const struct bpf_check_hook *c)
+{
+	module_put(c->owner);
+}
+
 /* last field in 'union bpf_attr' used by this command */
 #define BPF_PROG_LOAD_LAST_FIELD fd_array_cnt
 
@@ -2766,6 +2801,7 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size)
 {
 	enum bpf_prog_type type = attr->prog_type;
 	struct bpf_prog *prog, *dst_prog = NULL;
+	const struct bpf_check_hook *hook;
 	struct btf *attach_btf = NULL;
 	struct bpf_token *token = NULL;
 	bool bpf_cap;
@@ -2973,8 +3009,15 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size)
 	if (err)
 		goto free_prog_sec;
 
+	hook = bpf_check_get();
+	if (IS_ERR(hook)) {
+		err = PTR_ERR(hook);
+		goto free_used_maps;
+	}
+
 	/* run eBPF verifier */
-	err = bpf_check(&prog, attr, uattr, uattr_size);
+	err = hook->bpf_check(&prog, attr, uattr, uattr_size);
+	bpf_check_put(hook);
 	if (err < 0)
 		goto free_used_maps;
 
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 080cc380e806..1574400a0c76 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -18351,7 +18351,6 @@ static __init int unbound_reg_init(void)
 	unbound_reg.live |= REG_LIVE_READ;
 	return 0;
 }
-late_initcall(unbound_reg_init);
 
 static bool is_stack_all_misc(struct bpf_verifier_env *env,
 			      struct bpf_stack_state *stack)
@@ -23428,7 +23427,7 @@ static int compute_live_registers(struct bpf_verifier_env *env)
 	return err;
 }
 
-int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u32 uattr_size)
+static int __bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u32 uattr_size)
 {
 	u64 start_time = ktime_get_ns();
 	struct bpf_verifier_env *env;
@@ -23695,3 +23694,28 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
 	kvfree(env);
 	return ret;
 }
+
+static const struct bpf_check_hook verifier = {
+	.owner = THIS_MODULE,
+	.bpf_check = __bpf_check,
+};
+
+static int __init bpf_verifier_init(void)
+{
+	unbound_reg_init();
+	rcu_assign_pointer(bpf_check, &verifier);
+
+	return 0;
+}
+
+static void __exit bpf_verifier_fini(void)
+{
+	rcu_assign_pointer(bpf_check, NULL);
+}
+
+
+module_init(bpf_verifier_init);
+module_exit(bpf_verifier_fini);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("eBPF verifier");
-- 
2.47.1


