Return-Path: <bpf+bounces-14847-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B1307E8899
	for <lists+bpf@lfdr.de>; Sat, 11 Nov 2023 03:50:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 613EDB20B89
	for <lists+bpf@lfdr.de>; Sat, 11 Nov 2023 02:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEBAB566A;
	Sat, 11 Nov 2023 02:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EK8GwDae"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE184414
	for <bpf@vger.kernel.org>; Sat, 11 Nov 2023 02:50:37 +0000 (UTC)
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14C1046B2;
	Fri, 10 Nov 2023 18:50:05 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-6bf03b98b9bso2859433b3a.1;
        Fri, 10 Nov 2023 18:50:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699671004; x=1700275804; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qHu+6MoXAM5xN5qmdOqeh9o8GmUeJcmELsiUMx9NK1c=;
        b=EK8GwDaejPh7xNeO8+Oq7dOfHvmyylMsvXUMYQzZwAJZy2wgQTXwZyQIM2RBPgSIWk
         HlPRZsnxBc2wTDuuoO67jeGlnR8m6dVR099p+IqccwTBG0pUutKBqBRx9GhGOc8vV2RY
         QLJICexBxQqF7ENIim8I7h3uqQlIsK8RE5nNCVKCTI5BlmoGZLtOegG1t8HOMIk5jxcV
         UXZAjs/loTzhzTEherOym4LteTbisgBKTmKLJ7ps6F4VmBB2MpBuC4XOYO8viEJHc9HN
         fpqJN8J7YqVPv8BcNCbH0ARGOuN4IdZYZWRNhtOGd29IlZs625X5R7PyrSZHbDVQZuNA
         J6IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699671004; x=1700275804;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qHu+6MoXAM5xN5qmdOqeh9o8GmUeJcmELsiUMx9NK1c=;
        b=jh99oiUCmDKNe/K73jQgAcFdT/SC1Il/5nA43M4wJ2CoDXzD6xS2Oq1DVdsF/RQr6l
         w5RtEXSdUy2ACO6O+zEsbqphJUf1+GxXBArYY5NMPKRIrPT0by791bOGoqInaa7tHYZM
         NOewKrV4683ICTe8uZYBNU30ISwKG/xQD4iV8VJjX/hRgtBTXKD2CCs95hQtRBtP+sG4
         1IqX02+JphgemW5kHI4zB9TsS/zVSEDeKp+C+MWIICQU0X+cXqIDEZS72xh+88p2/lrP
         bK+PiGcSRQCiQa8ByjBBMKX6po86YbzV/4qulHgrCFCNFB04ELmqs7NgQ68RDW94cibU
         d/5g==
X-Gm-Message-State: AOJu0YyiI+gKo1XhJ4cO5C0LGTYuOsp6QQBFNdtMJFhpZPyDgqyylXsa
	0BHFygOgmJC7dsSSH5htchOrW6IjIu0=
X-Google-Smtp-Source: AGHT+IF+OEJB2RDecWu59WaHn9FS9cUR/gcTOta8HWvFsN4iUbMjLWWpQdKLFUugIC/TLGUPy7HWJw==
X-Received: by 2002:a17:90b:33cc:b0:280:23e1:e4dd with SMTP id lk12-20020a17090b33cc00b0028023e1e4ddmr1443938pjb.17.1699671003424;
        Fri, 10 Nov 2023 18:50:03 -0800 (PST)
Received: from localhost ([2620:10d:c090:400::4:7384])
        by smtp.gmail.com with ESMTPSA id f8-20020a170902684800b001cc46240491sm364114pln.136.2023.11.10.18.50.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Nov 2023 18:50:02 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
From: Tejun Heo <tj@kernel.org>
To: torvalds@linux-foundation.org,
	mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	bristot@redhat.com,
	vschneid@redhat.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	joshdon@google.com,
	brho@google.com,
	pjt@google.com,
	derkling@google.com,
	haoluo@google.com,
	dvernet@meta.com,
	dschatzberg@meta.com,
	dskarlat@cs.cmu.edu,
	riel@surriel.com,
	changwoo@igalia.com,
	himadrics@inria.fr,
	memxor@gmail.com
Cc: linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	kernel-team@meta.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 35/36] sched_ext: Add scx_rusty, a rust userspace hybrid scheduler
Date: Fri, 10 Nov 2023 16:48:01 -1000
Message-ID: <20231111024835.2164816-36-tj@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231111024835.2164816-1-tj@kernel.org>
References: <20231111024835.2164816-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dan Schatzberg <dschatzberg@meta.com>

Rusty is a multi-domain BPF / userspace hybrid scheduler where the BPF part
does simple round robin in each domain and the userspace part calculates the
load factor of each domain and tells the BPF part how to load balance the
domains.

This scheduler demonstrates dividing scheduling logic between BPF and
userspace and using rust to build the userspace part. An earlier variant of
this scheduler was used to balance across six domains, each representing a
chiplet in a six-chiplet AMD processor, and could match the performance of
production setup using CFS.

See the --help message for more details.

v5: * Renamed to scx_rusty and improve build scripts.

    * Load metrics are now tracked in BPF using the running average
      implementation in tools/sched_ext/ravg[_impl].bpf.h and
      ravg.read.rs.h. Before, the userspace part was iterating all tasks to
      calculate load metrics and make LB decisions. Now, high level LB
      decisions are made by simply reading per-domain load averages and
      Picking migrating target tasks only accesses the load metrics for a
      fixed number of recently active tasks in the pushing domains. This
      greatly reduces CPU overhead and makes rusty a lot more scalable.

v4: * tools/sched_ext/atropos renamed to tools/sched_ext/scx_atropos for
      consistency.

    * LoadBalancer sometimes couldn't converge on balanced state due to
      restrictions it put on each balancing operation. Fixed.

    * Topology information refactored into struct Topology and Tuner is
      added. Tuner runs in shorter cycles (100ms) than LoadBalancer and
      dynamically adjusts scheduling behaviors, currently, based on the
      per-domain utilization states.

    * ->select_cpu() has been revamped. Combined with other improvements,
      this allows atropos to outperform CFS in various sub-saturation
      scenarios when tested with fio over dm-crypt.

    * Many minor code cleanups and improvements.

v3: * The userspace code is substantially restructured and rewritten. The
      binary is renamed to scx_atropos and can now figure out the domain
      topology automatically based on L3 cache configuration. The LB logic
      which was rather broken in the previous postings are revamped and
      should behave better.

    * Updated to support weighted vtime scheduling (can be turned off with
      --fifo-sched). Added a couple options (--slice_us, --kthreads-local)
      to modify scheduling behaviors.

    * Converted to use BPF inline iterators.

v2: * Updated to use generic BPF cpumask helpers.

Signed-off-by: Dan Schatzberg <dschatzberg@meta.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 tools/sched_ext/Makefile                      |   53 +-
 tools/sched_ext/README.md                     |   29 +
 tools/sched_ext/ravg.bpf.h                    |   42 +
 tools/sched_ext/ravg_impl.bpf.h               |  358 +++++
 tools/sched_ext/ravg_read.rs.h                |   82 ++
 tools/sched_ext/scx_rusty/.gitignore          |    3 +
 tools/sched_ext/scx_rusty/Cargo.toml          |   28 +
 tools/sched_ext/scx_rusty/build.rs            |   72 +
 tools/sched_ext/scx_rusty/rustfmt.toml        |    8 +
 tools/sched_ext/scx_rusty/src/bpf/rusty.bpf.c | 1153 +++++++++++++++
 tools/sched_ext/scx_rusty/src/bpf/rusty.h     |   97 ++
 tools/sched_ext/scx_rusty/src/main.rs         | 1265 +++++++++++++++++
 tools/sched_ext/scx_rusty/src/rusty_sys.rs    |   10 +
 13 files changed, 3199 insertions(+), 1 deletion(-)
 create mode 100644 tools/sched_ext/ravg.bpf.h
 create mode 100644 tools/sched_ext/ravg_impl.bpf.h
 create mode 100644 tools/sched_ext/ravg_read.rs.h
 create mode 100644 tools/sched_ext/scx_rusty/.gitignore
 create mode 100644 tools/sched_ext/scx_rusty/Cargo.toml
 create mode 100644 tools/sched_ext/scx_rusty/build.rs
 create mode 100644 tools/sched_ext/scx_rusty/rustfmt.toml
 create mode 100644 tools/sched_ext/scx_rusty/src/bpf/rusty.bpf.c
 create mode 100644 tools/sched_ext/scx_rusty/src/bpf/rusty.h
 create mode 100644 tools/sched_ext/scx_rusty/src/main.rs
 create mode 100644 tools/sched_ext/scx_rusty/src/rusty_sys.rs

diff --git a/tools/sched_ext/Makefile b/tools/sched_ext/Makefile
index 59f230bd1437..f72e3be99f5c 100644
--- a/tools/sched_ext/Makefile
+++ b/tools/sched_ext/Makefile
@@ -93,6 +93,11 @@ CFLAGS += -g -O2 -rdynamic -pthread -Wall -Werror $(GENFLAGS)			\
 	  -I$(INCLUDE_DIR) -I$(GENDIR) -I$(LIBDIR)				\
 	  -I$(TOOLSINCDIR) -I$(APIDIR)
 
+CARGOFLAGS := --release --target-dir $(OUTPUT_DIR)
+ifneq ($(CARGO_OFFLINE),)
+CARGOFLAGS += --offline
+endif
+
 # Silence some warnings when compiled with clang
 ifneq ($(LLVM),)
 CFLAGS += -Wno-unused-command-line-argument
@@ -159,7 +164,7 @@ else
 endif
 
 $(SCXOBJ_DIR)/%.bpf.o: %.bpf.c $(INCLUDE_DIR)/vmlinux.h scx_common.bpf.h	\
-		       user_exit_info.h						\
+		       user_exit_info.h ravg.bpf.h ravg_impl.bpf.h		\
 		       | $(BPFOBJ) $(SCXOBJ_DIR)
 	$(call msg,CLNG-BPF,,$(notdir $@))
 	$(Q)$(CLANG) $(BPF_CFLAGS) -target bpf -c $< -o $@
@@ -192,11 +197,37 @@ $(addprefix $(BINDIR)/,$(c-sched-targets)): \
 	$(CC) -o $@ $(SCXOBJ_DIR)/$(sched).o $(HOST_BPFOBJ) $(LDFLAGS)
 $(c-sched-targets): %: $(BINDIR)/%
 
+
+###################
+# Rust schedulers #
+###################
+rust-sched-targets := scx_rusty
+
+# Separate build target that is available for build systems to use to fetch
+# dependencies in a separate step from building. This allows the scheduler
+# to be compiled without network access.
+#
+# If the regular rust scheduler Make target (e.g. scx_rusty) is invoked without
+# CARGO_OFFLINE=1 (e.g. if building locally), then cargo build will download
+# all of the necessary dependencies, and the deps target can be skipped.
+$(addsuffix _deps,$(rust-sched-targets)):
+	$(eval sched=$(@:_deps=))
+	$(Q)cargo fetch --manifest-path=$(sched)/Cargo.toml
+
+$(rust-sched-targets): %: $(INCLUDE_DIR)/vmlinux.h $(SCX_COMMON_DEPS)
+	$(eval export RUSTFLAGS = -C link-args=-lzstd -C link-args=-lz -C link-args=-lelf -L $(BPFOBJ_DIR))
+	$(eval export SCX_RUST_CLANG = $(CLANG))
+	$(eval export SCX_RUST_BPF_CFLAGS= $(BPF_CFLAGS))
+	$(eval sched=$(notdir $@))
+	$(Q)cargo build --manifest-path=$(sched)/Cargo.toml $(CARGOFLAGS)
+	$(Q)cp $(OUTPUT_DIR)/release/$(sched) $(BINDIR)/$@
+
 install: all
 	$(Q)mkdir -p $(DESTDIR)/usr/local/bin/
 	$(Q)cp $(BINDIR)/* $(DESTDIR)/usr/local/bin/
 
 clean:
+	$(foreach sched,$(rust-sched-targets),cargo clean --manifest-path=$(sched)/Cargo.toml;)
 	rm -rf $(OUTPUT_DIR) $(HOST_OUTPUT_DIR)
 	rm -f *.o *.bpf.o *.skel.h *.subskel.h
 	rm -f $(c-sched-targets)
@@ -220,6 +251,26 @@ install: all
 	@echo   '/tmp/sched_ext/build.'
 	@echo   ''
 	@echo   ''
+	@echo   'Rust scheduler targets'
+	@echo   '======================'
+	@echo   ''
+	@printf '  %s\n' $(rust-sched-targets)
+	@printf '  %s_deps\n' $(rust-sched-targets)
+	@echo   ''
+	@echo   'For any rust schedulers built with cargo, you can specify'
+	@echo   'CARGO_OFFLINE=1 to ensure the build portion does not access the'
+	@echo   'network (e.g. if the scheduler is being packaged).'
+	@echo   ''
+	@echo   'For such use cases, the build workflow will look something like this:'
+	@echo   ''
+	@echo   '   make scx_rusty_deps'
+	@echo   '   CARGO_OFFLINE=1 make scx_rusty'
+	@echo   ''
+	@echo   'If network access during build is allowed, you can just make scx_rusty'
+	@echo   'directly without CARGO_OFFLINE, and dependencies will be downloaded'
+	@echo   'during the build step.'
+	@echo   ''
+	@echo   ''
 	@echo   'Installing targets'
 	@echo   '=================='
 	@echo   ''
diff --git a/tools/sched_ext/README.md b/tools/sched_ext/README.md
index 9e4ec761af62..8e7194ada331 100644
--- a/tools/sched_ext/README.md
+++ b/tools/sched_ext/README.md
@@ -309,6 +309,35 @@ top of sched_ext.
 
 --------------------------------------------------------------------------------
 
+## scx_rusty
+
+### Overview
+
+A multi-domain, BPF / user space hybrid scheduler. The BPF portion of the
+scheduler does a simple round robin in each domain, and the user space portion
+(written in Rust) calculates the load factor of each domain, and informs BPF of
+how tasks should be load balanced accordingly.
+
+### Typical Use Case
+
+Rusty is designed to be flexible, and accommodate different architectures and
+workloads. Various load balancing thresholds (e.g. greediness, frequenty, etc),
+as well as how Rusty should partition the system into scheduling domains, can
+be tuned to achieve the optimal configuration for any given system or workload.
+
+### Production Ready?
+
+Yes. If tuned correctly, rusty should be performant across various CPU
+architectures and workloads. Rusty by default creates a separate scheduling
+domain per-LLC, so its default configuration may be performant as well.
+
+That said, you may run into an issue with infeasible weights, where a task with
+a very high weight may cause the scheduler to incorrectly leave cores idle
+because it thinks they're necessary to accommodate the compute for a single
+task. This can also happen in CFS, and should soon be addressed for rusty.
+
+--------------------------------------------------------------------------------
+
 # Troubleshooting
 
 There are a number of common issues that you may run into when building the
diff --git a/tools/sched_ext/ravg.bpf.h b/tools/sched_ext/ravg.bpf.h
new file mode 100644
index 000000000000..a233d85d05aa
--- /dev/null
+++ b/tools/sched_ext/ravg.bpf.h
@@ -0,0 +1,42 @@
+#ifndef __SCX_RAVG_BPF_H__
+#define __SCX_RAVG_BPF_H__
+
+/*
+ * Running average helpers to be used in BPF progs. Assumes vmlinux.h has
+ * already been included.
+ */
+enum ravg_consts {
+	RAVG_VAL_BITS		= 44,		/* input values are 44bit */
+	RAVG_FRAC_BITS		= 20,		/* 1048576 is 1.0 */
+};
+
+/*
+ * Running avg mechanism. Accumulates values between 0 and RAVG_MAX_VAL in
+ * arbitrary time intervals. The accumulated values are halved every half_life
+ * with each period starting when the current time % half_life is 0. Zeroing is
+ * enough for initialization.
+ *
+ * See ravg_accumulate() and ravg_read() for more details.
+ */
+struct ravg_data {
+	/* current value */
+	u64			val;
+
+	/*
+	 * The timestamp of @val. The latest completed seq #:
+	 *
+	 *   (val_at / half_life) - 1
+	 */
+	u64			val_at;
+
+	/* running avg as of the latest completed seq  */
+	u64			old;
+
+	/*
+	 * Accumulated value of the current period. Input value is 48bits and we
+	 * normalize half-life to 16bit, so it should fit in an u64.
+	 */
+	u64			cur;
+};
+
+#endif /* __SCX_RAVG_BPF_H__ */
diff --git a/tools/sched_ext/ravg_impl.bpf.h b/tools/sched_ext/ravg_impl.bpf.h
new file mode 100644
index 000000000000..4922a3e689bc
--- /dev/null
+++ b/tools/sched_ext/ravg_impl.bpf.h
@@ -0,0 +1,358 @@
+/* to be included in the main bpf.c file */
+#include "ravg.bpf.h"
+
+#define RAVG_FN_ATTRS		inline __attribute__((unused, always_inline))
+
+static RAVG_FN_ATTRS void ravg_add(u64 *sum, u64 addend)
+{
+	u64 new = *sum + addend;
+
+	if (new >= *sum)
+		*sum = new;
+	else
+		*sum = -1;
+}
+
+static RAVG_FN_ATTRS u64 ravg_decay(u64 v, u32 shift)
+{
+	if (shift >= 64)
+		return 0;
+	else
+		return v >> shift;
+}
+
+static RAVG_FN_ATTRS u32 ravg_normalize_dur(u32 dur, u32 half_life)
+{
+	if (dur < half_life)
+		return (((u64)dur << RAVG_FRAC_BITS) + half_life - 1) /
+			half_life;
+	else
+		return 1 << RAVG_FRAC_BITS;
+}
+
+/*
+ * Pre-computed decayed full-period values. This is quicker and keeps the bpf
+ * verifier happy by removing the need for looping.
+ *
+ * [0] = ravg_decay(1 << RAVG_FRAC_BITS, 1)
+ * [1] = [0] + ravg_decay(1 << RAVG_FRAC_BITS, 2)
+ * [2] = [1] + ravg_decay(1 << RAVG_FRAC_BITS, 3)
+ * ...
+ */
+static u64 ravg_full_sum[] = {
+	 524288,  786432,  917504,  983040,
+	1015808, 1032192, 1040384, 1044480,
+	1046528, 1047552, 1048064, 1048320,
+	1048448, 1048512, 1048544, 1048560,
+	1048568, 1048572, 1048574, 1048575,
+	/* the same from here on */
+};
+
+static const int ravg_full_sum_len = sizeof(ravg_full_sum) / sizeof(ravg_full_sum[0]);
+
+/**
+ * ravg_accumulate - Accumulate a new value
+ * @rd: ravg_data to accumulate into
+ * @new_val: new value
+ * @now: current timestamp
+ * @half_life: decay period, must be the same across calls
+ *
+ * The current value is changing to @val at @now. Accumulate accordingly.
+ */
+static RAVG_FN_ATTRS void ravg_accumulate(struct ravg_data *rd, u64 new_val, u64 now,
+					  u32 half_life)
+{
+	u32 cur_seq, val_seq, seq_delta;
+
+	/*
+	 * It may be difficult for the caller to guarantee monotonic progress if
+	 * multiple CPUs accumulate to the same ravg_data. Handle @now being in
+	 * the past of @rd->val_at.
+	 */
+	if (now < rd->val_at)
+		now = rd->val_at;
+
+	cur_seq = now / half_life;
+	val_seq = rd->val_at / half_life;
+	seq_delta = cur_seq - val_seq;
+
+	/*
+	 * Decay ->old and fold ->cur into it.
+	 *
+	 *                                                          @end
+	 *                                                            v
+	 * timeline     |---------|---------|---------|---------|---------|
+	 * seq delta         4         3         2         1          0
+	 * seq            ->seq                                    cur_seq
+	 * val            ->old     ->cur                  ^
+	 *                   |         |                   |
+	 *                   \---------+------------------/
+	 */
+	if (seq_delta > 0) {
+		/* decay ->old to bring it upto the cur_seq - 1 */
+		rd->old = ravg_decay(rd->old, seq_delta);
+		/* non-zero ->cur must be from val_seq, calc and fold */
+		ravg_add(&rd->old, ravg_decay(rd->cur, seq_delta));
+		/* clear */
+		rd->cur = 0;
+	}
+
+	if (!rd->val)
+		goto out;
+
+	/*
+	 * Accumulate @rd->val between @rd->val_at and @now.
+	 *
+	 *                       @rd->val_at                        @now
+	 *                            v                               v
+	 * timeline     |---------|---------|---------|---------|---------|
+	 * seq delta                  [  3  |    2    |    1    |  0  ]
+	 */
+	if (seq_delta > 0) {
+		u32 dur;
+
+		/* fold the oldest period which may be partial */
+		dur = ravg_normalize_dur(half_life - rd->val_at % half_life, half_life);
+		ravg_add(&rd->old, rd->val * ravg_decay(dur, seq_delta));
+
+		/* fold the full periods in the middle with precomputed vals */
+		if (seq_delta > 1) {
+			u32 idx = seq_delta - 2;
+
+			if (idx >= ravg_full_sum_len)
+				idx = ravg_full_sum_len - 1;
+
+			ravg_add(&rd->old, rd->val * ravg_full_sum[idx]);
+		}
+
+		/* accumulate the current period duration into ->cur */
+		rd->cur += rd->val * ravg_normalize_dur(now % half_life,
+							half_life);
+	} else {
+		rd->cur += rd->val * ravg_normalize_dur(now - rd->val_at,
+							half_life);
+	}
+out:
+	if (new_val >= 1LLU << RAVG_VAL_BITS)
+		rd->val = (1LLU << RAVG_VAL_BITS) - 1;
+	else
+		rd->val = new_val;
+	rd->val_at = now;
+}
+
+/**
+ * ravg_transfer - Transfer in or out a component running avg
+ * @base: ravg_data to transfer @xfer into or out of
+ * @base_new_val: new value for @base
+ * @xfer: ravg_data to transfer
+ * @xfer_new_val: new value for @xfer
+ * @is_xfer_in: transfer direction
+ *
+ * An ravg may be a sum of component ravgs. For example, a scheduling domain's
+ * load is the sum of the load values of all member tasks. If a task is migrated
+ * to a different domain, its contribution should be subtracted from the source
+ * ravg and added to the destination one.
+ *
+ * This function can be used for such component transfers. Both @base and @xfer
+ * must have been accumulated at the same timestamp. @xfer's contribution is
+ * subtracted if @is_fer_in is %false and added if %true.
+ */
+static RAVG_FN_ATTRS void ravg_transfer(struct ravg_data *base, u64 base_new_val,
+					struct ravg_data *xfer, u64 xfer_new_val,
+					u32 half_life, bool is_xfer_in)
+{
+	/* synchronize @base and @xfer */
+	if ((s64)(base->val_at - xfer->val_at) < 0)
+		ravg_accumulate(base, base_new_val, xfer->val_at, half_life);
+	else if ((s64)(base->val_at - xfer->val_at) > 0)
+		ravg_accumulate(xfer, xfer_new_val, base->val_at, half_life);
+
+	/* transfer */
+	if (is_xfer_in) {
+		base->old += xfer->old;
+		base->cur += xfer->cur;
+	} else {
+		if (base->old > xfer->old)
+			base->old -= xfer->old;
+		else
+			base->old = 0;
+
+		if (base->cur > xfer->cur)
+			base->cur -= xfer->cur;
+		else
+			base->cur = 0;
+	}
+}
+
+/**
+ * u64_x_u32_rshift - Calculate ((u64 * u32) >> rshift)
+ * @a: multiplicand
+ * @b: multiplier
+ * @rshift: number of bits to shift right
+ *
+ * Poor man's 128bit arithmetic. Calculate ((@a * @b) >> @rshift) where @a is
+ * u64 and @b is u32 and (@a * @b) may be bigger than #U64_MAX. The caller must
+ * ensure that the final shifted result fits in u64.
+ */
+static inline __attribute__((always_inline))
+u64 u64_x_u32_rshift(u64 a, u32 b, u32 rshift)
+{
+	const u64 mask32 = (u32)-1;
+	u64 al = a & mask32;
+	u64 ah = (a & (mask32 << 32)) >> 32;
+
+	/*
+	 *                                        ah: high 32     al: low 32
+	 * a                                   |--------------||--------------|
+	 *
+	 * ah * b              |--------------||--------------|
+	 * al * b                              |--------------||--------------|
+	 */
+	al *= b;
+	ah *= b;
+
+	/*
+	 * (ah * b) >> rshift        |--------------||--------------|
+	 * (al * b) >> rshift                        |--------------||--------|
+	 *                                                           <-------->
+	 *                                                           32 - rshift
+	 */
+	al >>= rshift;
+	if (rshift <= 32)
+		ah <<= 32 - rshift;
+	else
+		ah >>= rshift - 32;
+
+	return al + ah;
+}
+
+/**
+ * ravg_scale - Scale a running avg
+ * @rd: ravg_data to scale
+ * @mult: multipler
+ * @rshift: right shift amount
+ *
+ * Scale @rd by multiplying the tracked values by @mult and shifting right by
+ * @rshift.
+ */
+static RAVG_FN_ATTRS void ravg_scale(struct ravg_data *rd, u32 mult, u32 rshift)
+{
+	rd->val = u64_x_u32_rshift(rd->val, mult, rshift);
+	rd->old = u64_x_u32_rshift(rd->old, mult, rshift);
+	rd->cur = u64_x_u32_rshift(rd->cur, mult, rshift);
+}
+
+/**
+ * ravg_read - Read the current running avg
+ * @rd: ravg_data to read from
+ * @now: timestamp as of which to read the running avg
+ * @half_life: decay period, must match ravg_accumulate()'s
+ *
+ * Read running avg from @rd as of @now.
+ */
+static RAVG_FN_ATTRS u64 ravg_read(struct ravg_data *rd, u64 now, u64 half_life)
+{
+	struct ravg_data trd;
+	u32 elapsed;
+
+	/*
+	 * It may be difficult for the caller to guarantee monotonic progress if
+	 * multiple CPUs accumulate to the same ravg_data. Handle @now being in
+	 * the past of @rd->val_at.
+	 */
+	if (now < rd->val_at)
+		now = rd->val_at;
+
+	elapsed = now % half_life;
+
+	/*
+	 * Accumulate the ongoing period into a temporary copy. This allows
+	 * external readers to access up-to-date avg without strongly
+	 * synchronizing with the updater (we need to add a seq lock tho).
+	 */
+	trd = *rd;
+	rd = &trd;
+	ravg_accumulate(rd, 0, now, half_life);
+
+	/*
+	 * At the beginning of a new half_life period, the running avg is the
+	 * same as @rd->old. At the beginning of the next, it'd be old load / 2
+	 * + current load / 2. Inbetween, we blend the two linearly.
+	 */
+	if (elapsed) {
+		u32 progress = ravg_normalize_dur(elapsed, half_life);
+		/*
+		 * `H` is the duration of the half-life window, and `E` is how
+		 * much time has elapsed in this window. `P` is [0.0, 1.0]
+		 * representing how much the current window has progressed:
+		 *
+		 *   P = E / H
+		 *
+		 * If `old` is @rd->old, we would want to calculate the
+		 * following for blending:
+		 *
+		 *   old * (1.0 - P / 2)
+		 *
+		 * Because @progress is [0, 1 << RAVG_FRAC_BITS], let's multiply
+		 * and then divide by 1 << RAVG_FRAC_BITS:
+		 *
+		 *         (1 << RAVG_FRAC_BITS) - (1 << RAVG_FRAC_BITS) * P / 2
+		 *   old * -----------------------------------------------------
+		 *                       1 << RAVG_FRAC_BITS
+		 *
+		 * As @progress is (1 << RAVG_FRAC_BITS) * P:
+		 *
+		 *         (1 << RAVG_FRAC_BITS) - progress / 2
+		 *   old * ------------------------------------
+		 *                1 << RAVG_FRAC_BITS
+		 *
+		 * As @rd->old uses full 64bit, the multiplication can overflow,
+		 * but we also know that the final result is gonna be smaller
+		 * than @rd->old and thus fit. Use u64_x_u32_rshift() to handle
+		 * the interim multiplication correctly.
+		 */
+		u64 old = u64_x_u32_rshift(rd->old,
+					   (1 << RAVG_FRAC_BITS) - progress / 2,
+					   RAVG_FRAC_BITS);
+		/*
+		 * If `S` is the Sum(val * duration) for this half-life window,
+		 * the avg for this window is:
+		 *
+		 *   S / E
+		 *
+		 * We would want to calculate the following for blending:
+		 *
+		 *   S / E * (P / 2)
+		 *
+		 * As P = E / H,
+		 *
+		 *   S / E * (E / H / 2)
+		 *   S / H / 2
+		 *
+		 * Expanding S, the above becomes:
+		 *
+		 *   Sum(val * duration) / H / 2
+		 *   Sum(val * (duration / H)) / 2
+		 *
+		 * As we use RAVG_FRAC_BITS bits for fixed point arithmetic,
+		 * let's multiply the whole result accordingly:
+		 *
+		 *   (Sum(val * (duration / H)) / 2) * (1 << RAVG_FRAC_BITS)
+		 *
+		 *             duration * (1 << RAVG_FRAC_BITS)
+		 *   Sum(val * --------------------------------) / 2
+		 *                            H
+		 *
+		 * The righthand multiplier inside Sum() is the normalized
+		 * duration returned from ravg_normalize_dur(), so, the whole
+		 * Sum term equals @rd->cur.
+		 *
+		 *  rd->cur / 2
+		 */
+		u64 cur = rd->cur / 2;
+
+		return old + cur;
+	} else {
+		return rd->old;
+	}
+}
diff --git a/tools/sched_ext/ravg_read.rs.h b/tools/sched_ext/ravg_read.rs.h
new file mode 100644
index 000000000000..4efaa2390aa6
--- /dev/null
+++ b/tools/sched_ext/ravg_read.rs.h
@@ -0,0 +1,82 @@
+/// ravg_read() implementation for rust userland. See ravg_read() in
+/// ravg_impl.bpf.h. We don't yet have a good mechanism to share BPF and
+/// matching rust code across multiple schedulers. For now, include both BPF
+/// and rust code from scheduler implementations.
+fn ravg_read(
+    val: u64,
+    val_at: u64,
+    old: u64,
+    cur: u64,
+    now: u64,
+    half_life: u32,
+    frac_bits: u32,
+) -> f64 {
+    let ravg_1: f64 = (1 << frac_bits) as f64;
+    let half_life = half_life as u64;
+    let val = val as f64;
+    let mut old = old as f64 / ravg_1;
+    let mut cur = cur as f64 / ravg_1;
+
+    let now = now.max(val_at);
+    let normalized_dur = |dur| dur as f64 / half_life as f64;
+
+    //
+    // The following is f64 implementation of BPF ravg_accumulate().
+    //
+    let cur_seq = (now / half_life) as i64;
+    let val_seq = (val_at / half_life) as i64;
+    let seq_delta = (cur_seq - val_seq) as i32;
+
+    if seq_delta > 0 {
+        let full_decay = 2f64.powi(seq_delta);
+
+        // Decay $old and fold $cur into it.
+        old /= full_decay;
+        old += cur / full_decay;
+        cur = 0.0;
+
+        // Fold the oldest period whicy may be partial.
+        old += val * normalized_dur(half_life - val_at % half_life) / full_decay;
+
+        // Pre-computed decayed full-period values.
+        const FULL_SUMS: [f64; 20] = [
+            0.5,
+            0.75,
+            0.875,
+            0.9375,
+            0.96875,
+            0.984375,
+            0.9921875,
+            0.99609375,
+            0.998046875,
+            0.9990234375,
+            0.99951171875,
+            0.999755859375,
+            0.9998779296875,
+            0.99993896484375,
+            0.999969482421875,
+            0.9999847412109375,
+            0.9999923706054688,
+            0.9999961853027344,
+            0.9999980926513672,
+            0.9999990463256836,
+            // Use the same value beyond this point.
+        ];
+
+        // Fold the full periods in the middle.
+        if seq_delta >= 2 {
+            let idx = ((seq_delta - 2) as usize).min(FULL_SUMS.len() - 1);
+            old += val * FULL_SUMS[idx];
+        }
+
+        // Accumulate the current period duration into @cur.
+        cur += val * normalized_dur(now % half_life);
+    } else {
+        cur += val * normalized_dur(now - val_at);
+    }
+
+    //
+    // The following is the blending part of BPF ravg_read().
+    //
+    old * (1.0 - normalized_dur(now % half_life) / 2.0) + cur / 2.0
+}
diff --git a/tools/sched_ext/scx_rusty/.gitignore b/tools/sched_ext/scx_rusty/.gitignore
new file mode 100644
index 000000000000..186dba259ec2
--- /dev/null
+++ b/tools/sched_ext/scx_rusty/.gitignore
@@ -0,0 +1,3 @@
+src/bpf/.output
+Cargo.lock
+target
diff --git a/tools/sched_ext/scx_rusty/Cargo.toml b/tools/sched_ext/scx_rusty/Cargo.toml
new file mode 100644
index 000000000000..b0edd3b937d4
--- /dev/null
+++ b/tools/sched_ext/scx_rusty/Cargo.toml
@@ -0,0 +1,28 @@
+[package]
+name = "scx_rusty"
+version = "0.5.0"
+authors = ["Dan Schatzberg <dschatzberg@meta.com>", "Meta"]
+edition = "2021"
+description = "Userspace scheduling with BPF"
+license = "GPL-2.0-only"
+
+[dependencies]
+anyhow = "1.0.65"
+bitvec = { version = "1.0", features = ["serde"] }
+clap = { version = "4.1", features = ["derive", "env", "unicode", "wrap_help"] }
+ctrlc = { version = "3.1", features = ["termination"] }
+fb_procfs = "0.7.0"
+hex = "0.4.3"
+libbpf-rs = "0.21.0"
+libbpf-sys = { version = "1.2.0", features = ["novendor", "static"] }
+libc = "0.2.137"
+log = "0.4.17"
+ordered-float = "3.4.0"
+simplelog = "0.12.0"
+
+[build-dependencies]
+bindgen = { version = "0.61.0" }
+libbpf-cargo = "0.21.0"
+
+[features]
+enable_backtrace = []
diff --git a/tools/sched_ext/scx_rusty/build.rs b/tools/sched_ext/scx_rusty/build.rs
new file mode 100644
index 000000000000..c54b8f33c577
--- /dev/null
+++ b/tools/sched_ext/scx_rusty/build.rs
@@ -0,0 +1,72 @@
+// Copyright (c) Meta Platforms, Inc. and affiliates.
+
+// This software may be used and distributed according to the terms of the
+// GNU General Public License version 2.
+extern crate bindgen;
+
+use std::env;
+use std::fs::create_dir_all;
+use std::path::Path;
+use std::path::PathBuf;
+
+use libbpf_cargo::SkeletonBuilder;
+
+const HEADER_PATH: &str = "src/bpf/rusty.h";
+
+fn bindgen_rusty() {
+    // Tell cargo to invalidate the built crate whenever the wrapper changes
+    println!("cargo:rerun-if-changed={}", HEADER_PATH);
+
+    // The bindgen::Builder is the main entry point
+    // to bindgen, and lets you build up options for
+    // the resulting bindings.
+    let bindings = bindgen::Builder::default()
+        // The input header we would like to generate
+        // bindings for.
+        .header(HEADER_PATH)
+        // Tell cargo to invalidate the built crate whenever any of the
+        // included header files changed.
+        .parse_callbacks(Box::new(bindgen::CargoCallbacks))
+        // Finish the builder and generate the bindings.
+        .generate()
+        // Unwrap the Result and panic on failure.
+        .expect("Unable to generate bindings");
+
+    // Write the bindings to the $OUT_DIR/bindings.rs file.
+    let out_path = PathBuf::from(env::var("OUT_DIR").unwrap());
+    bindings
+        .write_to_file(out_path.join("rusty_sys.rs"))
+        .expect("Couldn't write bindings!");
+}
+
+fn gen_bpf_sched(name: &str) {
+    let bpf_cflags = env::var("SCX_RUST_BPF_CFLAGS").unwrap();
+    let clang = env::var("SCX_RUST_CLANG").unwrap();
+    eprintln!("{}", clang);
+    let outpath = format!("./src/bpf/.output/{}.skel.rs", name);
+    let skel = Path::new(&outpath);
+    let src = format!("./src/bpf/{}.bpf.c", name);
+    let obj = format!("./src/bpf/.output/{}.bpf.o", name);
+    SkeletonBuilder::new()
+        .source(src.clone())
+	.obj(obj)
+        .clang(clang)
+        .clang_args(bpf_cflags)
+        .build_and_generate(skel)
+        .unwrap();
+    println!("cargo:rerun-if-changed={}", src);
+}
+
+fn main() {
+    bindgen_rusty();
+    // It's unfortunate we cannot use `OUT_DIR` to store the generated skeleton.
+    // Reasons are because the generated skeleton contains compiler attributes
+    // that cannot be `include!()`ed via macro. And we cannot use the `#[path = "..."]`
+    // trick either because you cannot yet `concat!(env!("OUT_DIR"), "/skel.rs")` inside
+    // the path attribute either (see https://github.com/rust-lang/rust/pull/83366).
+    //
+    // However, there is hope! When the above feature stabilizes we can clean this
+    // all up.
+    create_dir_all("./src/bpf/.output").unwrap();
+    gen_bpf_sched("rusty");
+}
diff --git a/tools/sched_ext/scx_rusty/rustfmt.toml b/tools/sched_ext/scx_rusty/rustfmt.toml
new file mode 100644
index 000000000000..b7258ed0a8d8
--- /dev/null
+++ b/tools/sched_ext/scx_rusty/rustfmt.toml
@@ -0,0 +1,8 @@
+# Get help on options with `rustfmt --help=config`
+# Please keep these in alphabetical order.
+edition = "2021"
+group_imports = "StdExternalCrate"
+imports_granularity = "Item"
+merge_derives = false
+use_field_init_shorthand = true
+version = "Two"
diff --git a/tools/sched_ext/scx_rusty/src/bpf/rusty.bpf.c b/tools/sched_ext/scx_rusty/src/bpf/rusty.bpf.c
new file mode 100644
index 000000000000..7a8b27ceae05
--- /dev/null
+++ b/tools/sched_ext/scx_rusty/src/bpf/rusty.bpf.c
@@ -0,0 +1,1153 @@
+/* Copyright (c) Meta Platforms, Inc. and affiliates. */
+/*
+ * This software may be used and distributed according to the terms of the
+ * GNU General Public License version 2.
+ *
+ * scx_rusty is a multi-domain BPF / userspace hybrid scheduler where the BPF
+ * part does simple round robin in each domain and the userspace part
+ * calculates the load factor of each domain and tells the BPF part how to load
+ * balance the domains.
+ *
+ * Every task has an entry in the task_data map which lists which domain the
+ * task belongs to. When a task first enters the system (rusty_prep_enable),
+ * they are round-robined to a domain.
+ *
+ * rusty_select_cpu is the primary scheduling logic, invoked when a task
+ * becomes runnable. The lb_data map is populated by userspace to inform the BPF
+ * scheduler that a task should be migrated to a new domain. Otherwise, the task
+ * is scheduled in priority order as follows:
+ * * The current core if the task was woken up synchronously and there are idle
+ *   cpus in the system
+ * * The previous core, if idle
+ * * The pinned-to core if the task is pinned to a specific core
+ * * Any idle cpu in the domain
+ *
+ * If none of the above conditions are met, then the task is enqueued to a
+ * dispatch queue corresponding to the domain (rusty_enqueue).
+ *
+ * rusty_dispatch will attempt to consume a task from its domain's
+ * corresponding dispatch queue (this occurs after scheduling any tasks directly
+ * assigned to it due to the logic in rusty_select_cpu). If no task is found,
+ * then greedy load stealing will attempt to find a task on another dispatch
+ * queue to run.
+ *
+ * Load balancing is almost entirely handled by userspace. BPF populates the
+ * task weight, dom mask and current dom in the task_data map and executes the
+ * load balance based on userspace populating the lb_data map.
+ */
+#include "../../../scx_common.bpf.h"
+#include "../../../ravg_impl.bpf.h"
+#include "rusty.h"
+
+#include <errno.h>
+#include <stdbool.h>
+#include <string.h>
+#include <bpf/bpf_core_read.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+char _license[] SEC("license") = "GPL";
+
+/*
+ * const volatiles are set during initialization and treated as consts by the
+ * jit compiler.
+ */
+
+/*
+ * Domains and cpus
+ */
+const volatile u32 nr_doms = 32;	/* !0 for veristat, set during init */
+const volatile u32 nr_cpus = 64;	/* !0 for veristat, set during init */
+const volatile u32 cpu_dom_id_map[MAX_CPUS];
+const volatile u64 dom_cpumasks[MAX_DOMS][MAX_CPUS / 64];
+const volatile u32 load_half_life = 1000000000	/* 1s */;
+
+const volatile bool kthreads_local;
+const volatile bool fifo_sched;
+const volatile bool switch_partial;
+const volatile u32 greedy_threshold;
+const volatile u32 debug;
+
+/* base slice duration */
+const volatile u64 slice_ns = SCX_SLICE_DFL;
+
+/*
+ * Exit info
+ */
+int exit_kind = SCX_EXIT_NONE;
+char exit_msg[SCX_EXIT_MSG_LEN];
+
+/*
+ * Per-CPU context
+ */
+struct pcpu_ctx {
+	u32 dom_rr_cur; /* used when scanning other doms */
+
+	/* libbpf-rs does not respect the alignment, so pad out the struct explicitly */
+	u8 _padding[CACHELINE_SIZE - sizeof(u32)];
+} __attribute__((aligned(CACHELINE_SIZE)));
+
+struct pcpu_ctx pcpu_ctx[MAX_CPUS];
+
+/*
+ * Domain context
+ */
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__type(key, u32);
+	__type(value, struct dom_ctx);
+	__uint(max_entries, MAX_DOMS);
+	__uint(map_flags, 0);
+} dom_data SEC(".maps");
+
+struct lock_wrapper {
+	struct bpf_spin_lock lock;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__type(key, u32);
+	__type(value, struct lock_wrapper);
+	__uint(max_entries, MAX_DOMS);
+	__uint(map_flags, 0);
+} dom_load_locks SEC(".maps");
+
+struct dom_active_pids {
+	u64 gen;
+	u64 read_idx;
+	u64 write_idx;
+	s32 pids[MAX_DOM_ACTIVE_PIDS];
+};
+
+struct dom_active_pids dom_active_pids[MAX_DOMS];
+
+const u64 ravg_1 = 1 << RAVG_FRAC_BITS;
+
+static void dom_load_adj(u32 dom_id, s64 adj, u64 now)
+{
+	struct dom_ctx *domc;
+	struct lock_wrapper *lockw;
+
+	domc = bpf_map_lookup_elem(&dom_data, &dom_id);
+	lockw = bpf_map_lookup_elem(&dom_load_locks, &dom_id);
+
+	if (!domc || !lockw) {
+		scx_bpf_error("dom_ctx / lock lookup failed");
+		return;
+	}
+
+	bpf_spin_lock(&lockw->lock);
+	domc->load += adj;
+	ravg_accumulate(&domc->load_rd, domc->load, now, load_half_life);
+	bpf_spin_unlock(&lockw->lock);
+
+	if (adj < 0 && (s64)domc->load < 0)
+		scx_bpf_error("cpu%d dom%u load underflow (load=%lld adj=%lld)",
+			      bpf_get_smp_processor_id(), dom_id, domc->load, adj);
+
+	if (debug >=2 &&
+	    (!domc->dbg_load_printed_at || now - domc->dbg_load_printed_at >= 1000000000)) {
+		bpf_printk("LOAD ADJ dom=%u adj=%lld load=%llu",
+			   dom_id,
+			   adj,
+			   ravg_read(&domc->load_rd, now, load_half_life) >> RAVG_FRAC_BITS);
+		domc->dbg_load_printed_at = now;
+	}
+}
+
+static void dom_load_xfer_task(struct task_struct *p, struct task_ctx *taskc,
+			       u32 from_dom_id, u32 to_dom_id, u64 now)
+{
+	struct dom_ctx *from_domc, *to_domc;
+	struct lock_wrapper *from_lockw, *to_lockw;
+	struct ravg_data task_load_rd;
+	u64 from_load[2], to_load[2], task_load;
+
+	from_domc = bpf_map_lookup_elem(&dom_data, &from_dom_id);
+	from_lockw = bpf_map_lookup_elem(&dom_load_locks, &from_dom_id);
+	to_domc = bpf_map_lookup_elem(&dom_data, &to_dom_id);
+	to_lockw = bpf_map_lookup_elem(&dom_load_locks, &to_dom_id);
+	if (!from_domc || !from_lockw || !to_domc || !to_lockw) {
+		scx_bpf_error("dom_ctx / lock lookup failed");
+		return;
+	}
+
+	/*
+	 * @p is moving from @from_dom_id to @to_dom_id. Its load contribution
+	 * should be moved together. We only track duty cycle for tasks. Scale
+	 * it by weight to get load_rd.
+	 */
+	ravg_accumulate(&taskc->dcyc_rd, taskc->runnable, now, load_half_life);
+	task_load_rd = taskc->dcyc_rd;
+	ravg_scale(&task_load_rd, p->scx.weight, 0);
+
+	if (debug >= 2)
+		task_load = ravg_read(&task_load_rd, now, load_half_life);
+
+	/* transfer out of @from_dom_id */
+	bpf_spin_lock(&from_lockw->lock);
+	if (taskc->runnable)
+		from_domc->load -= p->scx.weight;
+
+	if (debug >= 2)
+		from_load[0] = ravg_read(&from_domc->load_rd, now, load_half_life);
+
+	ravg_transfer(&from_domc->load_rd, from_domc->load,
+		      &task_load_rd, taskc->runnable, load_half_life, false);
+
+	if (debug >= 2)
+		from_load[1] = ravg_read(&from_domc->load_rd, now, load_half_life);
+
+	bpf_spin_unlock(&from_lockw->lock);
+
+	/* transfer into @to_dom_id */
+	bpf_spin_lock(&to_lockw->lock);
+	if (taskc->runnable)
+		to_domc->load += p->scx.weight;
+
+	if (debug >= 2)
+		to_load[0] = ravg_read(&to_domc->load_rd, now, load_half_life);
+
+	ravg_transfer(&to_domc->load_rd, to_domc->load,
+		      &task_load_rd, taskc->runnable, load_half_life, true);
+
+	if (debug >= 2)
+		to_load[1] = ravg_read(&to_domc->load_rd, now, load_half_life);
+
+	bpf_spin_unlock(&to_lockw->lock);
+
+	if (debug >= 2)
+		bpf_printk("XFER dom%u->%u task=%lu from=%lu->%lu to=%lu->%lu",
+			   from_dom_id, to_dom_id,
+			   task_load >> RAVG_FRAC_BITS,
+			   from_load[0] >> RAVG_FRAC_BITS,
+			   from_load[1] >> RAVG_FRAC_BITS,
+			   to_load[0] >> RAVG_FRAC_BITS,
+			   to_load[1] >> RAVG_FRAC_BITS);
+}
+
+/*
+ * Statistics
+ */
+struct {
+	__uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
+	__uint(key_size, sizeof(u32));
+	__uint(value_size, sizeof(u64));
+	__uint(max_entries, RUSTY_NR_STATS);
+} stats SEC(".maps");
+
+static inline void stat_add(enum stat_idx idx, u64 addend)
+{
+	u32 idx_v = idx;
+
+	u64 *cnt_p = bpf_map_lookup_elem(&stats, &idx_v);
+	if (cnt_p)
+		(*cnt_p) += addend;
+}
+
+/* Map pid -> task_ctx */
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__type(key, pid_t);
+	__type(value, struct task_ctx);
+	__uint(max_entries, 1000000);
+	__uint(map_flags, 0);
+} task_data SEC(".maps");
+
+struct task_ctx *lookup_task_ctx(struct task_struct *p)
+{
+	struct task_ctx *taskc;
+	s32 pid = p->pid;
+
+	if ((taskc = bpf_map_lookup_elem(&task_data, &pid))) {
+		return taskc;
+	} else {
+		scx_bpf_error("task_ctx lookup failed for pid %d", p->pid);
+		return NULL;
+	}
+}
+
+/*
+ * This is populated from userspace to indicate which pids should be reassigned
+ * to new doms.
+ */
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__type(key, pid_t);
+	__type(value, u32);
+	__uint(max_entries, 1000);
+	__uint(map_flags, 0);
+} lb_data SEC(".maps");
+
+/*
+ * Userspace tuner will frequently update the following struct with tuning
+ * parameters and bump its gen. refresh_tune_params() converts them into forms
+ * that can be used directly in the scheduling paths.
+ */
+struct tune_input{
+	u64 gen;
+	u64 direct_greedy_cpumask[MAX_CPUS / 64];
+	u64 kick_greedy_cpumask[MAX_CPUS / 64];
+} tune_input;
+
+u64 tune_params_gen;
+private(A) struct bpf_cpumask __kptr *all_cpumask;
+private(A) struct bpf_cpumask __kptr *direct_greedy_cpumask;
+private(A) struct bpf_cpumask __kptr *kick_greedy_cpumask;
+
+static inline bool vtime_before(u64 a, u64 b)
+{
+	return (s64)(a - b) < 0;
+}
+
+static u32 cpu_to_dom_id(s32 cpu)
+{
+	const volatile u32 *dom_idp;
+
+	if (nr_doms <= 1)
+		return 0;
+
+	dom_idp = MEMBER_VPTR(cpu_dom_id_map, [cpu]);
+	if (!dom_idp)
+		return MAX_DOMS;
+
+	return *dom_idp;
+}
+
+static void refresh_tune_params(void)
+{
+	s32 cpu;
+
+	if (tune_params_gen == tune_input.gen)
+		return;
+
+	tune_params_gen = tune_input.gen;
+
+	bpf_for(cpu, 0, nr_cpus) {
+		u32 dom_id = cpu_to_dom_id(cpu);
+		struct dom_ctx *domc;
+
+		if (!(domc = bpf_map_lookup_elem(&dom_data, &dom_id))) {
+			scx_bpf_error("Failed to lookup dom[%u]", dom_id);
+			return;
+		}
+
+		if (tune_input.direct_greedy_cpumask[cpu / 64] & (1LLU << (cpu % 64))) {
+			if (direct_greedy_cpumask)
+				bpf_cpumask_set_cpu(cpu, direct_greedy_cpumask);
+			if (domc->direct_greedy_cpumask)
+				bpf_cpumask_set_cpu(cpu, domc->direct_greedy_cpumask);
+		} else {
+			if (direct_greedy_cpumask)
+				bpf_cpumask_clear_cpu(cpu, direct_greedy_cpumask);
+			if (domc->direct_greedy_cpumask)
+				bpf_cpumask_clear_cpu(cpu, domc->direct_greedy_cpumask);
+		}
+
+		if (tune_input.kick_greedy_cpumask[cpu / 64] & (1LLU << (cpu % 64))) {
+			if (kick_greedy_cpumask)
+				bpf_cpumask_set_cpu(cpu, kick_greedy_cpumask);
+		} else {
+			if (kick_greedy_cpumask)
+				bpf_cpumask_clear_cpu(cpu, kick_greedy_cpumask);
+		}
+	}
+}
+
+static bool task_set_domain(struct task_ctx *taskc, struct task_struct *p,
+			    u32 new_dom_id, bool init_dsq_vtime)
+{
+	struct dom_ctx *old_domc, *new_domc;
+	struct bpf_cpumask *d_cpumask, *t_cpumask;
+	u32 old_dom_id = taskc->dom_id;
+	s64 vtime_delta;
+
+	old_domc = bpf_map_lookup_elem(&dom_data, &old_dom_id);
+	if (!old_domc) {
+		scx_bpf_error("Failed to lookup old dom%u", old_dom_id);
+		return false;
+	}
+
+	if (init_dsq_vtime)
+		vtime_delta = 0;
+	else
+		vtime_delta = p->scx.dsq_vtime - old_domc->vtime_now;
+
+	new_domc = bpf_map_lookup_elem(&dom_data, &new_dom_id);
+	if (!new_domc) {
+		scx_bpf_error("Failed to lookup new dom%u", new_dom_id);
+		return false;
+	}
+
+	d_cpumask = new_domc->cpumask;
+	if (!d_cpumask) {
+		scx_bpf_error("Failed to get dom%u cpumask kptr",
+			      new_dom_id);
+		return false;
+	}
+
+	t_cpumask = taskc->cpumask;
+	if (!t_cpumask) {
+		scx_bpf_error("Failed to look up task cpumask");
+		return false;
+	}
+
+	/*
+	 * set_cpumask might have happened between userspace requesting LB and
+	 * here and @p might not be able to run in @dom_id anymore. Verify.
+	 */
+	if (bpf_cpumask_intersects((const struct cpumask *)d_cpumask,
+				   p->cpus_ptr)) {
+		u64 now = bpf_ktime_get_ns();
+
+		dom_load_xfer_task(p, taskc, taskc->dom_id, new_dom_id, now);
+
+		p->scx.dsq_vtime = new_domc->vtime_now + vtime_delta;
+		taskc->dom_id = new_dom_id;
+		bpf_cpumask_and(t_cpumask, (const struct cpumask *)d_cpumask,
+				p->cpus_ptr);
+	}
+
+	return taskc->dom_id == new_dom_id;
+}
+
+s32 BPF_STRUCT_OPS(rusty_select_cpu, struct task_struct *p, s32 prev_cpu,
+		   u64 wake_flags)
+{
+	const struct cpumask *idle_smtmask = scx_bpf_get_idle_smtmask();
+	struct task_ctx *taskc;
+	struct bpf_cpumask *p_cpumask;
+	bool prev_domestic, has_idle_cores;
+	s32 cpu;
+
+	refresh_tune_params();
+
+	if (!(taskc = lookup_task_ctx(p)) || !(p_cpumask = taskc->cpumask))
+		goto enoent;
+
+	if (kthreads_local &&
+	    (p->flags & PF_KTHREAD) && p->nr_cpus_allowed == 1) {
+		cpu = prev_cpu;
+		stat_add(RUSTY_STAT_DIRECT_DISPATCH, 1);
+		goto direct;
+	}
+
+	/*
+	 * If WAKE_SYNC and the machine isn't fully saturated, wake up @p to the
+	 * local dsq of the waker.
+	 */
+	if (p->nr_cpus_allowed > 1 && (wake_flags & SCX_WAKE_SYNC)) {
+		struct task_struct *current = (void *)bpf_get_current_task();
+
+		if (!(BPF_CORE_READ(current, flags) & PF_EXITING) &&
+		    taskc->dom_id < MAX_DOMS) {
+			struct dom_ctx *domc;
+			struct bpf_cpumask *d_cpumask;
+			const struct cpumask *idle_cpumask;
+			bool has_idle;
+
+			domc = bpf_map_lookup_elem(&dom_data, &taskc->dom_id);
+			if (!domc) {
+				scx_bpf_error("Failed to find dom%u", taskc->dom_id);
+				goto enoent;
+			}
+			d_cpumask = domc->cpumask;
+			if (!d_cpumask) {
+				scx_bpf_error("Failed to acquire dom%u cpumask kptr",
+					      taskc->dom_id);
+				goto enoent;
+			}
+
+			idle_cpumask = scx_bpf_get_idle_cpumask();
+
+			has_idle = bpf_cpumask_intersects((const struct cpumask *)d_cpumask,
+							  idle_cpumask);
+
+			scx_bpf_put_idle_cpumask(idle_cpumask);
+
+			if (has_idle) {
+				cpu = bpf_get_smp_processor_id();
+				if (bpf_cpumask_test_cpu(cpu, p->cpus_ptr)) {
+					stat_add(RUSTY_STAT_WAKE_SYNC, 1);
+					goto direct;
+				}
+			}
+		}
+	}
+
+	/* If only one CPU is allowed, dispatch */
+	if (p->nr_cpus_allowed == 1) {
+		stat_add(RUSTY_STAT_PINNED, 1);
+		cpu = prev_cpu;
+		goto direct;
+	}
+
+	has_idle_cores = !bpf_cpumask_empty(idle_smtmask);
+
+	/* did @p get pulled out to a foreign domain by e.g. greedy execution? */
+	prev_domestic = bpf_cpumask_test_cpu(prev_cpu,
+					     (const struct cpumask *)p_cpumask);
+
+	/*
+	 * See if we want to keep @prev_cpu. We want to keep @prev_cpu if the
+	 * whole physical core is idle. If the sibling[s] are busy, it's likely
+	 * more advantageous to look for wholly idle cores first.
+	 */
+	if (prev_domestic) {
+		if (bpf_cpumask_test_cpu(prev_cpu, idle_smtmask) &&
+		    scx_bpf_test_and_clear_cpu_idle(prev_cpu)) {
+			stat_add(RUSTY_STAT_PREV_IDLE, 1);
+			cpu = prev_cpu;
+			goto direct;
+		}
+	} else {
+		/*
+		 * @prev_cpu is foreign. Linger iff the domain isn't too busy as
+		 * indicated by direct_greedy_cpumask. There may also be an idle
+		 * CPU in the domestic domain
+		 */
+		if (direct_greedy_cpumask &&
+		    bpf_cpumask_test_cpu(prev_cpu, (const struct cpumask *)
+					 direct_greedy_cpumask) &&
+		    bpf_cpumask_test_cpu(prev_cpu, idle_smtmask) &&
+		    scx_bpf_test_and_clear_cpu_idle(prev_cpu)) {
+			stat_add(RUSTY_STAT_GREEDY_IDLE, 1);
+			cpu = prev_cpu;
+			goto direct;
+		}
+	}
+
+	/*
+	 * @prev_cpu didn't work out. Let's see whether there's an idle CPU @p
+	 * can be directly dispatched to. We'll first try to find the best idle
+	 * domestic CPU and then move onto foreign.
+	 */
+
+	/* If there is a domestic idle core, dispatch directly */
+	if (has_idle_cores) {
+		cpu = scx_bpf_pick_idle_cpu((const struct cpumask *)p_cpumask,
+					    SCX_PICK_IDLE_CORE);
+		if (cpu >= 0) {
+			stat_add(RUSTY_STAT_DIRECT_DISPATCH, 1);
+			goto direct;
+		}
+	}
+
+	/*
+	 * If @prev_cpu was domestic and is idle itself even though the core
+	 * isn't, picking @prev_cpu may improve L1/2 locality.
+	 */
+	if (prev_domestic && scx_bpf_test_and_clear_cpu_idle(prev_cpu)) {
+		stat_add(RUSTY_STAT_DIRECT_DISPATCH, 1);
+		cpu = prev_cpu;
+		goto direct;
+	}
+
+	/* If there is any domestic idle CPU, dispatch directly */
+	cpu = scx_bpf_pick_idle_cpu((const struct cpumask *)p_cpumask, 0);
+	if (cpu >= 0) {
+		stat_add(RUSTY_STAT_DIRECT_DISPATCH, 1);
+		goto direct;
+	}
+
+	/*
+	 * Domestic domain is fully booked. If there are CPUs which are idle and
+	 * under-utilized, ignore domain boundaries and push the task there. Try
+	 * to find an idle core first.
+	 */
+	if (taskc->all_cpus && direct_greedy_cpumask &&
+	    !bpf_cpumask_empty((const struct cpumask *)direct_greedy_cpumask)) {
+		u32 dom_id = cpu_to_dom_id(prev_cpu);
+		struct dom_ctx *domc;
+
+		if (!(domc = bpf_map_lookup_elem(&dom_data, &dom_id))) {
+			scx_bpf_error("Failed to lookup dom[%u]", dom_id);
+			goto enoent;
+		}
+
+		/* Try to find an idle core in the previous and then any domain */
+		if (has_idle_cores) {
+			if (domc->direct_greedy_cpumask) {
+				cpu = scx_bpf_pick_idle_cpu((const struct cpumask *)
+							    domc->direct_greedy_cpumask,
+							    SCX_PICK_IDLE_CORE);
+				if (cpu >= 0) {
+					stat_add(RUSTY_STAT_DIRECT_GREEDY, 1);
+					goto direct;
+				}
+			}
+
+			if (direct_greedy_cpumask) {
+				cpu = scx_bpf_pick_idle_cpu((const struct cpumask *)
+							    direct_greedy_cpumask,
+							    SCX_PICK_IDLE_CORE);
+				if (cpu >= 0) {
+					stat_add(RUSTY_STAT_DIRECT_GREEDY_FAR, 1);
+					goto direct;
+				}
+			}
+		}
+
+		/*
+		 * No idle core. Is there any idle CPU?
+		 */
+		if (domc->direct_greedy_cpumask) {
+			cpu = scx_bpf_pick_idle_cpu((const struct cpumask *)
+						    domc->direct_greedy_cpumask, 0);
+			if (cpu >= 0) {
+				stat_add(RUSTY_STAT_DIRECT_GREEDY, 1);
+				goto direct;
+			}
+		}
+
+		if (direct_greedy_cpumask) {
+			cpu = scx_bpf_pick_idle_cpu((const struct cpumask *)
+						    direct_greedy_cpumask, 0);
+			if (cpu >= 0) {
+				stat_add(RUSTY_STAT_DIRECT_GREEDY_FAR, 1);
+				goto direct;
+			}
+		}
+	}
+
+	/*
+	 * We're going to queue on the domestic domain's DSQ. @prev_cpu may be
+	 * in a different domain. Returning an out-of-domain CPU can lead to
+	 * stalls as all in-domain CPUs may be idle by the time @p gets
+	 * enqueued.
+	 */
+	if (prev_domestic)
+		cpu = prev_cpu;
+	else
+		cpu = scx_bpf_pick_any_cpu((const struct cpumask *)p_cpumask, 0);
+
+	scx_bpf_put_idle_cpumask(idle_smtmask);
+	return cpu;
+
+direct:
+	taskc->dispatch_local = true;
+	scx_bpf_put_idle_cpumask(idle_smtmask);
+	return cpu;
+
+enoent:
+	scx_bpf_put_idle_cpumask(idle_smtmask);
+	return -ENOENT;
+}
+
+void BPF_STRUCT_OPS(rusty_enqueue, struct task_struct *p, u64 enq_flags)
+{
+	struct task_ctx *taskc;
+	struct bpf_cpumask *p_cpumask;
+	pid_t pid = p->pid;
+	u32 *new_dom;
+	s32 cpu;
+
+	if (!(taskc = lookup_task_ctx(p)))
+		return;
+	if (!(p_cpumask = taskc->cpumask)) {
+		scx_bpf_error("NULL cpmask");
+		return;
+	}
+
+	/*
+	 * Migrate @p to a new domain if requested by userland through lb_data.
+	 */
+	new_dom = bpf_map_lookup_elem(&lb_data, &pid);
+	if (new_dom && *new_dom != taskc->dom_id &&
+	    task_set_domain(taskc, p, *new_dom, false)) {
+		stat_add(RUSTY_STAT_LOAD_BALANCE, 1);
+		taskc->dispatch_local = false;
+		cpu = scx_bpf_pick_any_cpu((const struct cpumask *)p_cpumask, 0);
+		if (cpu >= 0)
+			scx_bpf_kick_cpu(cpu, 0);
+		goto dom_queue;
+	}
+
+	if (taskc->dispatch_local) {
+		taskc->dispatch_local = false;
+		scx_bpf_dispatch(p, SCX_DSQ_LOCAL, slice_ns, enq_flags);
+		return;
+	}
+
+	/*
+	 * @p is about to be queued on its domain's dsq. However, @p may be on a
+	 * foreign CPU due to a greedy execution and not have gone through
+	 * ->select_cpu() if it's being enqueued e.g. after slice exhaustion. If
+	 * so, @p would be queued on its domain's dsq but none of the CPUs in
+	 * the domain would be woken up which can induce temporary execution
+	 * stalls. Kick a domestic CPU if @p is on a foreign domain.
+	 */
+	if (!bpf_cpumask_test_cpu(scx_bpf_task_cpu(p), (const struct cpumask *)p_cpumask)) {
+		cpu = scx_bpf_pick_any_cpu((const struct cpumask *)p_cpumask, 0);
+		scx_bpf_kick_cpu(cpu, 0);
+		stat_add(RUSTY_STAT_REPATRIATE, 1);
+	}
+
+dom_queue:
+	if (fifo_sched) {
+		scx_bpf_dispatch(p, taskc->dom_id, slice_ns, enq_flags);
+	} else {
+		u64 vtime = p->scx.dsq_vtime;
+		u32 dom_id = taskc->dom_id;
+		struct dom_ctx *domc;
+
+		domc = bpf_map_lookup_elem(&dom_data, &dom_id);
+		if (!domc) {
+			scx_bpf_error("Failed to lookup dom[%u]", dom_id);
+			return;
+		}
+
+		/*
+		 * Limit the amount of budget that an idling task can accumulate
+		 * to one slice.
+		 */
+		if (vtime_before(vtime, domc->vtime_now - slice_ns))
+			vtime = domc->vtime_now - slice_ns;
+
+		scx_bpf_dispatch_vtime(p, taskc->dom_id, slice_ns, vtime, enq_flags);
+	}
+
+	/*
+	 * If there are CPUs which are idle and not saturated, wake them up to
+	 * see whether they'd be able to steal the just queued task. This path
+	 * is taken only if DIRECT_GREEDY didn't trigger in select_cpu().
+	 *
+	 * While both mechanisms serve very similar purposes, DIRECT_GREEDY
+	 * emplaces the task in a foreign CPU directly while KICK_GREEDY just
+	 * wakes up a foreign CPU which will then first try to execute from its
+	 * domestic domain first before snooping foreign ones.
+	 *
+	 * While KICK_GREEDY is a more expensive way of accelerating greedy
+	 * execution, DIRECT_GREEDY shows negative performance impacts when the
+	 * CPUs are highly loaded while KICK_GREEDY doesn't. Even under fairly
+	 * high utilization, KICK_GREEDY can slightly improve work-conservation.
+	 */
+	if (taskc->all_cpus && kick_greedy_cpumask) {
+		cpu = scx_bpf_pick_idle_cpu((const struct cpumask *)
+					    kick_greedy_cpumask, 0);
+		if (cpu >= 0) {
+			stat_add(RUSTY_STAT_KICK_GREEDY, 1);
+			scx_bpf_kick_cpu(cpu, 0);
+		}
+	}
+}
+
+static bool cpumask_intersects_domain(const struct cpumask *cpumask, u32 dom_id)
+{
+	s32 cpu;
+
+	if (dom_id >= MAX_DOMS)
+		return false;
+
+	bpf_for(cpu, 0, nr_cpus) {
+		if (bpf_cpumask_test_cpu(cpu, cpumask) &&
+		    (dom_cpumasks[dom_id][cpu / 64] & (1LLU << (cpu % 64))))
+			return true;
+	}
+	return false;
+}
+
+static u32 dom_rr_next(s32 cpu)
+{
+	struct pcpu_ctx *pcpuc;
+	u32 dom_id;
+
+	pcpuc = MEMBER_VPTR(pcpu_ctx, [cpu]);
+	if (!pcpuc)
+		return 0;
+
+	dom_id = (pcpuc->dom_rr_cur + 1) % nr_doms;
+
+	if (dom_id == cpu_to_dom_id(cpu))
+		dom_id = (dom_id + 1) % nr_doms;
+
+	pcpuc->dom_rr_cur = dom_id;
+	return dom_id;
+}
+
+void BPF_STRUCT_OPS(rusty_dispatch, s32 cpu, struct task_struct *prev)
+{
+	u32 dom = cpu_to_dom_id(cpu);
+
+	if (scx_bpf_consume(dom)) {
+		stat_add(RUSTY_STAT_DSQ_DISPATCH, 1);
+		return;
+	}
+
+	if (!greedy_threshold)
+		return;
+
+	bpf_repeat(nr_doms - 1) {
+		u32 dom_id = dom_rr_next(cpu);
+
+		if (scx_bpf_dsq_nr_queued(dom_id) >= greedy_threshold &&
+		    scx_bpf_consume(dom_id)) {
+			stat_add(RUSTY_STAT_GREEDY, 1);
+			break;
+		}
+	}
+}
+
+void BPF_STRUCT_OPS(rusty_runnable, struct task_struct *p, u64 enq_flags)
+{
+	u64 now = bpf_ktime_get_ns();
+	struct task_ctx *taskc;
+
+	if (!(taskc = lookup_task_ctx(p)))
+		return;
+
+	taskc->runnable = true;
+	taskc->is_kworker = p->flags & PF_WQ_WORKER;
+
+	ravg_accumulate(&taskc->dcyc_rd, taskc->runnable, now, load_half_life);
+	dom_load_adj(taskc->dom_id, p->scx.weight, now);
+}
+
+void BPF_STRUCT_OPS(rusty_running, struct task_struct *p)
+{
+	struct task_ctx *taskc;
+	struct dom_ctx *domc;
+	u32 dom_id, dap_gen;
+
+	if (!(taskc = lookup_task_ctx(p)))
+		return;
+
+	taskc->running_at = bpf_ktime_get_ns();
+	dom_id = taskc->dom_id;
+	if (dom_id >= MAX_DOMS) {
+		scx_bpf_error("Invalid dom ID");
+		return;
+	}
+
+	/*
+	 * Record that @p has been active in @domc. Load balancer will only
+	 * consider recently active tasks. Access synchronization rules aren't
+	 * strict. We just need to be right most of the time.
+	 */
+	dap_gen = dom_active_pids[dom_id].gen;
+	if (taskc->dom_active_pids_gen != dap_gen) {
+		u64 idx = __sync_fetch_and_add(&dom_active_pids[dom_id].write_idx, 1) %
+			MAX_DOM_ACTIVE_PIDS;
+		s32 *pidp;
+
+		pidp = MEMBER_VPTR(dom_active_pids, [dom_id].pids[idx]);
+		if (!pidp) {
+			scx_bpf_error("dom_active_pids[%u][%llu] indexing failed",
+				      dom_id, idx);
+			return;
+		}
+
+		*pidp = p->pid;
+		taskc->dom_active_pids_gen = dap_gen;
+	}
+
+	if (fifo_sched)
+		return;
+
+	domc = bpf_map_lookup_elem(&dom_data, &dom_id);
+	if (!domc) {
+		scx_bpf_error("Failed to lookup dom[%u]", dom_id);
+		return;
+	}
+
+	/*
+	 * Global vtime always progresses forward as tasks start executing. The
+	 * test and update can be performed concurrently from multiple CPUs and
+	 * thus racy. Any error should be contained and temporary. Let's just
+	 * live with it.
+	 */
+	if (vtime_before(domc->vtime_now, p->scx.dsq_vtime))
+		domc->vtime_now = p->scx.dsq_vtime;
+}
+
+void BPF_STRUCT_OPS(rusty_stopping, struct task_struct *p, bool runnable)
+{
+	struct task_ctx *taskc;
+
+	if (fifo_sched)
+		return;
+
+	if (!(taskc = lookup_task_ctx(p)))
+		return;
+
+	/* scale the execution time by the inverse of the weight and charge */
+	p->scx.dsq_vtime +=
+		(bpf_ktime_get_ns() - taskc->running_at) * 100 / p->scx.weight;
+}
+
+void BPF_STRUCT_OPS(rusty_quiescent, struct task_struct *p, u64 deq_flags)
+{
+	u64 now = bpf_ktime_get_ns();
+	struct task_ctx *taskc;
+
+	if (!(taskc = lookup_task_ctx(p)))
+		return;
+
+	taskc->runnable = false;
+
+	ravg_accumulate(&taskc->dcyc_rd, taskc->runnable, now, load_half_life);
+	dom_load_adj(taskc->dom_id, -(s64)p->scx.weight, now);
+}
+
+void BPF_STRUCT_OPS(rusty_set_weight, struct task_struct *p, u32 weight)
+{
+	struct task_ctx *taskc;
+
+	if (!(taskc = lookup_task_ctx(p)))
+		return;
+
+	taskc->weight = weight;
+}
+
+static u32 task_pick_domain(struct task_ctx *taskc, struct task_struct *p,
+			    const struct cpumask *cpumask)
+{
+	s32 cpu = bpf_get_smp_processor_id();
+	u32 first_dom = MAX_DOMS, dom;
+
+	if (cpu < 0 || cpu >= MAX_CPUS)
+		return MAX_DOMS;
+
+	taskc->dom_mask = 0;
+
+	dom = pcpu_ctx[cpu].dom_rr_cur++;
+	bpf_repeat(nr_doms) {
+		dom = (dom + 1) % nr_doms;
+		if (cpumask_intersects_domain(cpumask, dom)) {
+			taskc->dom_mask |= 1LLU << dom;
+			/*
+			 * AsThe starting point is round-robin'd and the first
+			 * match should be spread across all the domains.
+			 */
+			if (first_dom == MAX_DOMS)
+				first_dom = dom;
+		}
+	}
+
+	return first_dom;
+}
+
+static void task_pick_and_set_domain(struct task_ctx *taskc,
+				     struct task_struct *p,
+				     const struct cpumask *cpumask,
+				     bool init_dsq_vtime)
+{
+	u32 dom_id = 0;
+
+	if (nr_doms > 1)
+		dom_id = task_pick_domain(taskc, p, cpumask);
+
+	if (!task_set_domain(taskc, p, dom_id, init_dsq_vtime))
+		scx_bpf_error("Failed to set dom%d for %s[%d]",
+			      dom_id, p->comm, p->pid);
+}
+
+void BPF_STRUCT_OPS(rusty_set_cpumask, struct task_struct *p,
+		    const struct cpumask *cpumask)
+{
+	struct task_ctx *taskc;
+
+	if (!(taskc = lookup_task_ctx(p)))
+		return;
+
+	task_pick_and_set_domain(taskc, p, cpumask, false);
+	if (all_cpumask)
+		taskc->all_cpus =
+			bpf_cpumask_subset((const struct cpumask *)all_cpumask, cpumask);
+}
+
+s32 BPF_STRUCT_OPS(rusty_prep_enable, struct task_struct *p,
+		   struct scx_enable_args *args)
+{
+	struct bpf_cpumask *cpumask;
+	struct task_ctx taskc = { .dom_active_pids_gen = -1 };
+	struct task_ctx *map_value;
+	long ret;
+	pid_t pid;
+
+	pid = p->pid;
+	ret = bpf_map_update_elem(&task_data, &pid, &taskc, BPF_NOEXIST);
+	if (ret) {
+		stat_add(RUSTY_STAT_TASK_GET_ERR, 1);
+		return ret;
+	}
+
+	/*
+	 * Read the entry from the map immediately so we can add the cpumask
+	 * with bpf_kptr_xchg().
+	 */
+	map_value = bpf_map_lookup_elem(&task_data, &pid);
+	if (!map_value)
+		/* Should never happen -- it was just inserted above. */
+		return -EINVAL;
+
+	cpumask = bpf_cpumask_create();
+	if (!cpumask) {
+		bpf_map_delete_elem(&task_data, &pid);
+		return -ENOMEM;
+	}
+
+	cpumask = bpf_kptr_xchg(&map_value->cpumask, cpumask);
+	if (cpumask) {
+		/* Should never happen as we just inserted it above. */
+		bpf_cpumask_release(cpumask);
+		bpf_map_delete_elem(&task_data, &pid);
+		return -EINVAL;
+	}
+
+	task_pick_and_set_domain(map_value, p, p->cpus_ptr, true);
+
+	return 0;
+}
+
+void BPF_STRUCT_OPS(rusty_disable, struct task_struct *p)
+{
+	pid_t pid = p->pid;
+	long ret = bpf_map_delete_elem(&task_data, &pid);
+	if (ret) {
+		stat_add(RUSTY_STAT_TASK_GET_ERR, 1);
+		return;
+	}
+}
+
+static s32 create_dom(u32 dom_id)
+{
+	struct dom_ctx domc_init = {}, *domc;
+	struct bpf_cpumask *cpumask;
+	u32 cpu;
+	s32 ret;
+
+	ret = scx_bpf_create_dsq(dom_id, -1);
+	if (ret < 0) {
+		scx_bpf_error("Failed to create dsq %u (%d)", dom_id, ret);
+		return ret;
+	}
+
+	ret = bpf_map_update_elem(&dom_data, &dom_id, &domc_init, 0);
+	if (ret) {
+		scx_bpf_error("Failed to add dom_ctx entry %u (%d)", dom_id, ret);
+		return ret;
+	}
+
+	domc = bpf_map_lookup_elem(&dom_data, &dom_id);
+	if (!domc) {
+		/* Should never happen, we just inserted it above. */
+		scx_bpf_error("No dom%u", dom_id);
+		return -ENOENT;
+	}
+
+	cpumask = bpf_cpumask_create();
+	if (!cpumask) {
+		scx_bpf_error("Failed to create BPF cpumask for domain %u", dom_id);
+		return -ENOMEM;
+	}
+
+	for (cpu = 0; cpu < MAX_CPUS; cpu++) {
+		const volatile u64 *dmask;
+
+		dmask = MEMBER_VPTR(dom_cpumasks, [dom_id][cpu / 64]);
+		if (!dmask) {
+			scx_bpf_error("array index error");
+			bpf_cpumask_release(cpumask);
+			return -ENOENT;
+		}
+
+		if (*dmask & (1LLU << (cpu % 64))) {
+			bpf_cpumask_set_cpu(cpu, cpumask);
+
+			bpf_rcu_read_lock();
+			if (all_cpumask)
+				bpf_cpumask_set_cpu(cpu, all_cpumask);
+			bpf_rcu_read_unlock();
+		}
+	}
+
+	cpumask = bpf_kptr_xchg(&domc->cpumask, cpumask);
+	if (cpumask) {
+		scx_bpf_error("Domain %u cpumask already present", dom_id);
+		bpf_cpumask_release(cpumask);
+		return -EEXIST;
+	}
+
+	cpumask = bpf_cpumask_create();
+	if (!cpumask) {
+		scx_bpf_error("Failed to create BPF cpumask for domain %u",
+			      dom_id);
+		return -ENOMEM;
+	}
+
+	cpumask = bpf_kptr_xchg(&domc->direct_greedy_cpumask, cpumask);
+	if (cpumask) {
+		scx_bpf_error("Domain %u direct_greedy_cpumask already present",
+			      dom_id);
+		bpf_cpumask_release(cpumask);
+		return -EEXIST;
+	}
+
+	return 0;
+}
+
+s32 BPF_STRUCT_OPS_SLEEPABLE(rusty_init)
+{
+	struct bpf_cpumask *cpumask;
+	s32 i, ret;
+
+	cpumask = bpf_cpumask_create();
+	if (!cpumask)
+		return -ENOMEM;
+	cpumask = bpf_kptr_xchg(&all_cpumask, cpumask);
+	if (cpumask)
+		bpf_cpumask_release(cpumask);
+
+	cpumask = bpf_cpumask_create();
+	if (!cpumask)
+		return -ENOMEM;
+	cpumask = bpf_kptr_xchg(&direct_greedy_cpumask, cpumask);
+	if (cpumask)
+		bpf_cpumask_release(cpumask);
+
+	cpumask = bpf_cpumask_create();
+	if (!cpumask)
+		return -ENOMEM;
+	cpumask = bpf_kptr_xchg(&kick_greedy_cpumask, cpumask);
+	if (cpumask)
+		bpf_cpumask_release(cpumask);
+
+	if (!switch_partial)
+		scx_bpf_switch_all();
+
+	bpf_for(i, 0, nr_doms) {
+		ret = create_dom(i);
+		if (ret)
+			return ret;
+	}
+
+	bpf_for(i, 0, nr_cpus)
+		pcpu_ctx[i].dom_rr_cur = i;
+
+	return 0;
+}
+
+void BPF_STRUCT_OPS(rusty_exit, struct scx_exit_info *ei)
+{
+	bpf_probe_read_kernel_str(exit_msg, sizeof(exit_msg), ei->msg);
+	exit_kind = ei->kind;
+}
+
+SEC(".struct_ops.link")
+struct sched_ext_ops rusty = {
+	.select_cpu		= (void *)rusty_select_cpu,
+	.enqueue		= (void *)rusty_enqueue,
+	.dispatch		= (void *)rusty_dispatch,
+	.runnable		= (void *)rusty_runnable,
+	.running		= (void *)rusty_running,
+	.stopping		= (void *)rusty_stopping,
+	.quiescent		= (void *)rusty_quiescent,
+	.set_weight		= (void *)rusty_set_weight,
+	.set_cpumask		= (void *)rusty_set_cpumask,
+	.prep_enable		= (void *)rusty_prep_enable,
+	.disable		= (void *)rusty_disable,
+	.init			= (void *)rusty_init,
+	.exit			= (void *)rusty_exit,
+	.name			= "rusty",
+};
diff --git a/tools/sched_ext/scx_rusty/src/bpf/rusty.h b/tools/sched_ext/scx_rusty/src/bpf/rusty.h
new file mode 100644
index 000000000000..8a7487cf426c
--- /dev/null
+++ b/tools/sched_ext/scx_rusty/src/bpf/rusty.h
@@ -0,0 +1,97 @@
+// Copyright (c) Meta Platforms, Inc. and affiliates.
+
+// This software may be used and distributed according to the terms of the
+// GNU General Public License version 2.
+#ifndef __RUSTY_H
+#define __RUSTY_H
+
+#include <stdbool.h>
+#ifndef __kptr
+#ifdef __KERNEL__
+#error "__kptr_ref not defined in the kernel"
+#endif
+#define __kptr
+#endif
+
+#ifndef __KERNEL__
+typedef unsigned char u8;
+typedef unsigned int u32;
+typedef unsigned long long u64;
+#endif
+
+#include "../../../ravg.bpf.h"
+
+enum consts {
+	MAX_CPUS		= 512,
+	MAX_DOMS		= 64,	/* limited to avoid complex bitmask ops */
+	CACHELINE_SIZE		= 64,
+
+	/*
+	 * When userspace load balancer is trying to determine the tasks to push
+	 * out from an overloaded domain, it looks at the the following number
+	 * of recently active tasks of the domain. While this may lead to
+	 * spurious migration victim selection failures in pathological cases,
+	 * this isn't a practical problem as the LB rounds are best-effort
+	 * anyway and will be retried until loads are balanced.
+	 */
+	MAX_DOM_ACTIVE_PIDS	= 1024,
+};
+
+/* Statistics */
+enum stat_idx {
+	/* The following fields add up to all dispatched tasks */
+	RUSTY_STAT_WAKE_SYNC,
+	RUSTY_STAT_PREV_IDLE,
+	RUSTY_STAT_GREEDY_IDLE,
+	RUSTY_STAT_PINNED,
+	RUSTY_STAT_DIRECT_DISPATCH,
+	RUSTY_STAT_DIRECT_GREEDY,
+	RUSTY_STAT_DIRECT_GREEDY_FAR,
+	RUSTY_STAT_DSQ_DISPATCH,
+	RUSTY_STAT_GREEDY,
+
+	/* Extra stats that don't contribute to total */
+	RUSTY_STAT_REPATRIATE,
+	RUSTY_STAT_KICK_GREEDY,
+	RUSTY_STAT_LOAD_BALANCE,
+
+	/* Errors */
+	RUSTY_STAT_TASK_GET_ERR,
+
+	RUSTY_NR_STATS,
+};
+
+struct task_ctx {
+	/* The domains this task can run on */
+	u64 dom_mask;
+
+	struct bpf_cpumask __kptr *cpumask;
+	u32 dom_id;
+	u32 weight;
+	bool runnable;
+	u64 dom_active_pids_gen;
+	u64 running_at;
+
+	/* The task is a workqueue worker thread */
+	bool is_kworker;
+
+	/* Allowed on all CPUs and eligible for DIRECT_GREEDY optimization */
+	bool all_cpus;
+
+	/* select_cpu() telling enqueue() to queue directly on the DSQ */
+	bool dispatch_local;
+
+	struct ravg_data dcyc_rd;
+};
+
+struct dom_ctx {
+	u64 vtime_now;
+	struct bpf_cpumask __kptr *cpumask;
+	struct bpf_cpumask __kptr *direct_greedy_cpumask;
+
+	u64 load;
+	struct ravg_data load_rd;
+	u64 dbg_load_printed_at;
+};
+
+#endif /* __RUSTY_H */
diff --git a/tools/sched_ext/scx_rusty/src/main.rs b/tools/sched_ext/scx_rusty/src/main.rs
new file mode 100644
index 000000000000..3b0bcd742e05
--- /dev/null
+++ b/tools/sched_ext/scx_rusty/src/main.rs
@@ -0,0 +1,1265 @@
+// Copyright (c) Meta Platforms, Inc. and affiliates.
+
+// This software may be used and distributed according to the terms of the
+// GNU General Public License version 2.
+#[path = "bpf/.output/rusty.skel.rs"]
+mod rusty;
+pub use rusty::*;
+pub mod rusty_sys;
+
+use std::cell::Cell;
+use std::collections::BTreeMap;
+use std::collections::BTreeSet;
+use std::ffi::CStr;
+use std::ops::Bound::Included;
+use std::ops::Bound::Unbounded;
+use std::sync::atomic::AtomicBool;
+use std::sync::atomic::Ordering;
+use std::sync::Arc;
+use std::time::Duration;
+use std::time::Instant;
+
+use ::fb_procfs as procfs;
+use anyhow::anyhow;
+use anyhow::bail;
+use anyhow::Context;
+use anyhow::Result;
+use bitvec::prelude::*;
+use clap::Parser;
+use libbpf_rs::skel::OpenSkel as _;
+use libbpf_rs::skel::Skel as _;
+use libbpf_rs::skel::SkelBuilder as _;
+use log::debug;
+use log::info;
+use log::trace;
+use log::warn;
+use ordered_float::OrderedFloat;
+
+const RAVG_FRAC_BITS: u32 = rusty_sys::ravg_consts_RAVG_FRAC_BITS;
+const MAX_DOMS: usize = rusty_sys::consts_MAX_DOMS as usize;
+const MAX_CPUS: usize = rusty_sys::consts_MAX_CPUS as usize;
+
+include!("../../ravg_read.rs.h");
+
+/// scx_rusty: A multi-domain BPF / userspace hybrid scheduler
+///
+/// The BPF part does simple vtime or round robin scheduling in each domain
+/// while tracking average load of each domain and duty cycle of each task.
+///
+/// The userspace part performs two roles. First, it makes higher frequency
+/// (100ms) tuning decisions. It identifies CPUs which are not too heavily
+/// loaded and mark them so that they can pull tasks from other overloaded
+/// domains on the fly.
+///
+/// Second, it drives lower frequency (2s) load balancing. It determines
+/// whether load balancing is necessary by comparing domain load averages.
+/// If there are large enough load differences, it examines upto 1024
+/// recently active tasks on the domain to determine which should be
+/// migrated.
+///
+/// The overhead of userspace operations is low. Load balancing is not
+/// performed frequently but work-conservation is still maintained through
+/// tuning and greedy execution. Load balancing itself is not that expensive
+/// either. It only accesses per-domain load metrics to determine the
+/// domains that need load balancing and limited number of per-task metrics
+/// for each pushing domain.
+///
+/// An earlier variant of this scheduler was used to balance across six
+/// domains, each representing a chiplet in a six-chiplet AMD processor, and
+/// could match the performance of production setup using CFS.
+///
+/// WARNING: Very high weight (low nice value) tasks can throw off load
+/// balancing due to infeasible weight problem. This problem will be solved
+/// in the near future.
+///
+/// WARNING: scx_rusty currently assumes that all domains have equal
+/// processing power and at similar distances from each other. This
+/// limitation will be removed in the future.
+#[derive(Debug, Parser)]
+struct Opts {
+    /// Scheduling slice duration in microseconds.
+    #[clap(short = 's', long, default_value = "20000")]
+    slice_us: u64,
+
+    /// Monitoring and load balance interval in seconds.
+    #[clap(short = 'i', long, default_value = "2.0")]
+    interval: f64,
+
+    /// Tuner runs at higher frequency than the load balancer to dynamically
+    /// tune scheduling behavior. Tuning interval in seconds.
+    #[clap(short = 'I', long, default_value = "0.1")]
+    tune_interval: f64,
+
+    /// The half-life of task and domain load running averages in seconds.
+    #[clap(short = 'l', long, default_value = "1.0")]
+    load_half_life: f64,
+
+    /// Build domains according to how CPUs are grouped at this cache level
+    /// as determined by /sys/devices/system/cpu/cpuX/cache/indexI/id.
+    #[clap(short = 'c', long, default_value = "3")]
+    cache_level: u32,
+
+    /// Instead of using cache locality, set the cpumask for each domain
+    /// manually, provide multiple --cpumasks, one for each domain. E.g.
+    /// --cpumasks 0xff_00ff --cpumasks 0xff00 will create two domains with
+    /// the corresponding CPUs belonging to each domain. Each CPU must
+    /// belong to precisely one domain.
+    #[clap(short = 'C', long, num_args = 1.., conflicts_with = "cache_level")]
+    cpumasks: Vec<String>,
+
+    /// When non-zero, enable greedy task stealing. When a domain is idle, a
+    /// cpu will attempt to steal tasks from a domain with at least
+    /// greedy_threshold tasks enqueued. These tasks aren't permanently
+    /// stolen from the domain.
+    #[clap(short = 'g', long, default_value = "1")]
+    greedy_threshold: u32,
+
+    /// Disable load balancing. Unless disabled, periodically userspace will
+    /// calculate the load factor of each domain and instruct BPF which
+    /// processes to move.
+    #[clap(long, action = clap::ArgAction::SetTrue)]
+    no_load_balance: bool,
+
+    /// Put per-cpu kthreads directly into local dsq's.
+    #[clap(short = 'k', long, action = clap::ArgAction::SetTrue)]
+    kthreads_local: bool,
+
+    /// In recent kernels (>=v6.6), the kernel is responsible for balancing
+    /// kworkers across L3 cache domains. Exclude them from load-balancing
+    /// to avoid conflicting operations. Greedy executions still apply.
+    #[clap(short = 'b', long, action = clap::ArgAction::SetTrue)]
+    balanced_kworkers: bool,
+
+    /// Use FIFO scheduling instead of weighted vtime scheduling.
+    #[clap(short = 'f', long, action = clap::ArgAction::SetTrue)]
+    fifo_sched: bool,
+
+    /// Idle CPUs with utilization lower than this will get remote tasks
+    /// directly pushed on them. 0 disables, 100 enables always.
+    #[clap(short = 'D', long, default_value = "90.0")]
+    direct_greedy_under: f64,
+
+    /// Idle CPUs with utilization lower than this may get kicked to
+    /// accelerate stealing when a task is queued on a saturated remote
+    /// domain. 0 disables, 100 enables always.
+    #[clap(short = 'K', long, default_value = "100.0")]
+    kick_greedy_under: f64,
+
+    /// If specified, only tasks which have their scheduling policy set to
+    /// SCHED_EXT using sched_setscheduler(2) are switched. Otherwise, all
+    /// tasks are switched.
+    #[clap(short = 'p', long, action = clap::ArgAction::SetTrue)]
+    partial: bool,
+
+    /// Enable verbose output including libbpf details. Specify multiple
+    /// times to increase verbosity.
+    #[clap(short = 'v', long, action = clap::ArgAction::Count)]
+    verbose: u8,
+}
+
+fn now_monotonic() -> u64 {
+    let mut time = libc::timespec {
+        tv_sec: 0,
+        tv_nsec: 0,
+    };
+    let ret = unsafe { libc::clock_gettime(libc::CLOCK_MONOTONIC, &mut time) };
+    assert!(ret == 0);
+    time.tv_sec as u64 * 1_000_000_000 + time.tv_nsec as u64
+}
+
+fn clear_map(map: &libbpf_rs::Map) {
+    for key in map.keys() {
+        let _ = map.delete(&key);
+    }
+}
+
+fn format_cpumask(cpumask: &[u64], nr_cpus: usize) -> String {
+    cpumask
+        .iter()
+        .take((nr_cpus + 64) / 64)
+        .rev()
+        .fold(String::new(), |acc, x| format!("{} {:016X}", acc, x))
+}
+
+fn read_total_cpu(reader: &procfs::ProcReader) -> Result<procfs::CpuStat> {
+    reader
+        .read_stat()
+        .context("Failed to read procfs")?
+        .total_cpu
+        .ok_or_else(|| anyhow!("Could not read total cpu stat in proc"))
+}
+
+fn calc_util(curr: &procfs::CpuStat, prev: &procfs::CpuStat) -> Result<f64> {
+    match (curr, prev) {
+        (
+            procfs::CpuStat {
+                user_usec: Some(prev_user),
+                nice_usec: Some(prev_nice),
+                system_usec: Some(prev_system),
+                idle_usec: Some(prev_idle),
+                iowait_usec: Some(prev_iowait),
+                irq_usec: Some(prev_irq),
+                softirq_usec: Some(prev_softirq),
+                stolen_usec: Some(prev_stolen),
+                ..
+            },
+            procfs::CpuStat {
+                user_usec: Some(curr_user),
+                nice_usec: Some(curr_nice),
+                system_usec: Some(curr_system),
+                idle_usec: Some(curr_idle),
+                iowait_usec: Some(curr_iowait),
+                irq_usec: Some(curr_irq),
+                softirq_usec: Some(curr_softirq),
+                stolen_usec: Some(curr_stolen),
+                ..
+            },
+        ) => {
+            let idle_usec = curr_idle - prev_idle;
+            let iowait_usec = curr_iowait - prev_iowait;
+            let user_usec = curr_user - prev_user;
+            let system_usec = curr_system - prev_system;
+            let nice_usec = curr_nice - prev_nice;
+            let irq_usec = curr_irq - prev_irq;
+            let softirq_usec = curr_softirq - prev_softirq;
+            let stolen_usec = curr_stolen - prev_stolen;
+
+            let busy_usec =
+                user_usec + system_usec + nice_usec + irq_usec + softirq_usec + stolen_usec;
+            let total_usec = idle_usec + busy_usec + iowait_usec;
+            if total_usec > 0 {
+                Ok(((busy_usec as f64) / (total_usec as f64)).clamp(0.0, 1.0))
+            } else {
+                Ok(1.0)
+            }
+        }
+        _ => {
+            bail!("Missing stats in cpustat");
+        }
+    }
+}
+
+#[derive(Debug)]
+struct Topology {
+    nr_cpus: usize,
+    nr_doms: usize,
+    dom_cpus: Vec<BitVec<u64, Lsb0>>,
+    cpu_dom: Vec<Option<usize>>,
+}
+
+impl Topology {
+    fn from_cpumasks(cpumasks: &[String], nr_cpus: usize) -> Result<Self> {
+        if cpumasks.len() > MAX_DOMS {
+            bail!(
+                "Number of requested domains ({}) is greater than MAX_DOMS ({})",
+                cpumasks.len(),
+                MAX_DOMS
+            );
+        }
+        let mut cpu_dom = vec![None; nr_cpus];
+        let mut dom_cpus = vec![bitvec![u64, Lsb0; 0; MAX_CPUS]; cpumasks.len()];
+        for (dom, cpumask) in cpumasks.iter().enumerate() {
+            let hex_str = {
+                let mut tmp_str = cpumask
+                    .strip_prefix("0x")
+                    .unwrap_or(cpumask)
+                    .replace('_', "");
+                if tmp_str.len() % 2 != 0 {
+                    tmp_str = "0".to_string() + &tmp_str;
+                }
+                tmp_str
+            };
+            let byte_vec = hex::decode(&hex_str)
+                .with_context(|| format!("Failed to parse cpumask: {}", cpumask))?;
+
+            for (index, &val) in byte_vec.iter().rev().enumerate() {
+                let mut v = val;
+                while v != 0 {
+                    let lsb = v.trailing_zeros() as usize;
+                    v &= !(1 << lsb);
+                    let cpu = index * 8 + lsb;
+                    if cpu > nr_cpus {
+                        bail!(
+                            concat!(
+                                "Found cpu ({}) in cpumask ({}) which is larger",
+                                " than the number of cpus on the machine ({})"
+                            ),
+                            cpu,
+                            cpumask,
+                            nr_cpus
+                        );
+                    }
+                    if let Some(other_dom) = cpu_dom[cpu] {
+                        bail!(
+                            "Found cpu ({}) with domain ({}) but also in cpumask ({})",
+                            cpu,
+                            other_dom,
+                            cpumask
+                        );
+                    }
+                    cpu_dom[cpu] = Some(dom);
+                    dom_cpus[dom].set(cpu, true);
+                }
+            }
+            dom_cpus[dom].set_uninitialized(false);
+        }
+
+        for (cpu, dom) in cpu_dom.iter().enumerate() {
+            if dom.is_none() {
+                bail!(
+                    "CPU {} not assigned to any domain. Make sure it is covered by some --cpumasks argument.",
+                    cpu
+                );
+            }
+        }
+
+        Ok(Self {
+            nr_cpus,
+            nr_doms: dom_cpus.len(),
+            dom_cpus,
+            cpu_dom,
+        })
+    }
+
+    fn from_cache_level(level: u32, nr_cpus: usize) -> Result<Self> {
+        let mut cpu_to_cache = vec![]; // (cpu_id, Option<cache_id>)
+        let mut cache_ids = BTreeSet::<usize>::new();
+        let mut nr_offline = 0;
+
+        // Build cpu -> cache ID mapping.
+        for cpu in 0..nr_cpus {
+            let path = format!("/sys/devices/system/cpu/cpu{}/cache/index{}/id", cpu, level);
+            let id = match std::fs::read_to_string(&path) {
+                Ok(val) => Some(val.trim().parse::<usize>().with_context(|| {
+                    format!("Failed to parse {:?}'s content {:?}", &path, &val)
+                })?),
+                Err(e) if e.kind() == std::io::ErrorKind::NotFound => {
+                    nr_offline += 1;
+                    None
+                }
+                Err(e) => return Err(e).with_context(|| format!("Failed to open {:?}", &path)),
+            };
+
+            cpu_to_cache.push(id);
+            if let Some(id) = id {
+                cache_ids.insert(id);
+            }
+        }
+
+        info!(
+            "CPUs: online/possible = {}/{}",
+            nr_cpus - nr_offline,
+            nr_cpus
+        );
+
+        // Cache IDs may have holes. Assign consecutive domain IDs to
+        // existing cache IDs.
+        let mut cache_to_dom = BTreeMap::<usize, usize>::new();
+        let mut nr_doms = 0;
+        for cache_id in cache_ids.iter() {
+            cache_to_dom.insert(*cache_id, nr_doms);
+            nr_doms += 1;
+        }
+
+        if nr_doms > MAX_DOMS {
+            bail!(
+                "Total number of doms {} is greater than MAX_DOMS ({})",
+                nr_doms,
+                MAX_DOMS
+            );
+        }
+
+        // Build and return dom -> cpumask and cpu -> dom mappings.
+        let mut dom_cpus = vec![bitvec![u64, Lsb0; 0; MAX_CPUS]; nr_doms];
+        let mut cpu_dom = vec![];
+
+        for (cpu, cache) in cpu_to_cache.iter().enumerate().take(nr_cpus) {
+            match cache {
+                Some(cache_id) => {
+                    let dom_id = cache_to_dom[cache_id];
+                    dom_cpus[dom_id].set(cpu, true);
+                    cpu_dom.push(Some(dom_id));
+                }
+                None => {
+                    dom_cpus[0].set(cpu, true);
+                    cpu_dom.push(None);
+                }
+            }
+        }
+
+        Ok(Self {
+            nr_cpus,
+            nr_doms: dom_cpus.len(),
+            dom_cpus,
+            cpu_dom,
+        })
+    }
+}
+
+struct Tuner {
+    top: Arc<Topology>,
+    direct_greedy_under: f64,
+    kick_greedy_under: f64,
+    proc_reader: procfs::ProcReader,
+    prev_cpu_stats: BTreeMap<u32, procfs::CpuStat>,
+    dom_utils: Vec<f64>,
+}
+
+impl Tuner {
+    fn new(top: Arc<Topology>, opts: &Opts) -> Result<Self> {
+        let proc_reader = procfs::ProcReader::new();
+        let prev_cpu_stats = proc_reader
+            .read_stat()?
+            .cpus_map
+            .ok_or_else(|| anyhow!("Expected cpus_map to exist"))?;
+        Ok(Self {
+            direct_greedy_under: opts.direct_greedy_under / 100.0,
+            kick_greedy_under: opts.kick_greedy_under / 100.0,
+            proc_reader,
+            prev_cpu_stats,
+            dom_utils: vec![0.0; top.nr_doms],
+            top,
+        })
+    }
+
+    fn step(&mut self, skel: &mut RustySkel) -> Result<()> {
+        let curr_cpu_stats = self
+            .proc_reader
+            .read_stat()?
+            .cpus_map
+            .ok_or_else(|| anyhow!("Expected cpus_map to exist"))?;
+        let ti = &mut skel.bss().tune_input;
+        let mut dom_nr_cpus = vec![0; self.top.nr_doms];
+        let mut dom_util_sum = vec![0.0; self.top.nr_doms];
+
+        for cpu in 0..self.top.nr_cpus {
+            let cpu32 = cpu as u32;
+            // None domain indicates the CPU was offline during
+            // initialization and None CpuStat indicates the CPU has gone
+            // down since then. Ignore both.
+            if let (Some(dom), Some(curr), Some(prev)) = (
+                self.top.cpu_dom[cpu],
+                curr_cpu_stats.get(&cpu32),
+                self.prev_cpu_stats.get(&cpu32),
+            ) {
+                dom_nr_cpus[dom] += 1;
+                dom_util_sum[dom] += calc_util(curr, prev)?;
+            }
+        }
+
+        for dom in 0..self.top.nr_doms {
+            // Calculate the domain avg util. If there are no active CPUs,
+            // it doesn't really matter. Go with 0.0 as that's less likely
+            // to confuse users.
+            let util = match dom_nr_cpus[dom] {
+                0 => 0.0,
+                nr => dom_util_sum[dom] / nr as f64,
+            };
+
+            self.dom_utils[dom] = util;
+
+            // This could be implemented better.
+            let update_dom_bits = |target: &mut [u64; 8], val: bool| {
+                for cpu in 0..self.top.nr_cpus {
+                    if let Some(cdom) = self.top.cpu_dom[cpu] {
+                        if cdom == dom {
+                            if val {
+                                target[cpu / 64] |= 1u64 << (cpu % 64);
+                            } else {
+                                target[cpu / 64] &= !(1u64 << (cpu % 64));
+                            }
+                        }
+                    }
+                }
+            };
+
+            update_dom_bits(
+                &mut ti.direct_greedy_cpumask,
+                self.direct_greedy_under > 0.99999 || util < self.direct_greedy_under,
+            );
+            update_dom_bits(
+                &mut ti.kick_greedy_cpumask,
+                self.kick_greedy_under > 0.99999 || util < self.kick_greedy_under,
+            );
+        }
+
+        ti.gen += 1;
+        self.prev_cpu_stats = curr_cpu_stats;
+        Ok(())
+    }
+}
+
+#[derive(Debug)]
+struct TaskInfo {
+    pid: i32,
+    dom_mask: u64,
+    migrated: Cell<bool>,
+    is_kworker: bool,
+}
+
+struct LoadBalancer<'a, 'b, 'c> {
+    skel: &'a mut RustySkel<'b>,
+    top: Arc<Topology>,
+    skip_kworkers: bool,
+
+    tasks_by_load: Vec<Option<BTreeMap<OrderedFloat<f64>, TaskInfo>>>,
+    load_avg: f64,
+    dom_loads: Vec<f64>,
+
+    imbal: Vec<f64>,
+    doms_to_push: BTreeMap<OrderedFloat<f64>, u32>,
+    doms_to_pull: BTreeMap<OrderedFloat<f64>, u32>,
+
+    nr_lb_data_errors: &'c mut u64,
+}
+
+impl<'a, 'b, 'c> LoadBalancer<'a, 'b, 'c> {
+    // If imbalance gets higher than this ratio, try to balance the loads.
+    const LOAD_IMBAL_HIGH_RATIO: f64 = 0.10;
+
+    // Aim to transfer this fraction of the imbalance on each round. We want
+    // to be gradual to avoid unnecessary oscillations. While this can delay
+    // convergence, greedy execution should be able to bridge the temporary
+    // gap.
+    const LOAD_IMBAL_XFER_TARGET_RATIO: f64 = 0.50;
+
+    // Don't push out more than this ratio of load on each round. While this
+    // overlaps with XFER_TARGET_RATIO, XFER_TARGET_RATIO only defines the
+    // target and doesn't limit the total load. As long as the transfer
+    // reduces load imbalance between the two involved domains, it'd happily
+    // transfer whatever amount that can be transferred. This limit is used
+    // as the safety cap to avoid draining a given domain too much in a
+    // single round.
+    const LOAD_IMBAL_PUSH_MAX_RATIO: f64 = 0.50;
+
+    fn new(
+        skel: &'a mut RustySkel<'b>,
+        top: Arc<Topology>,
+        skip_kworkers: bool,
+        nr_lb_data_errors: &'c mut u64,
+    ) -> Self {
+        Self {
+            skel,
+            skip_kworkers,
+
+            tasks_by_load: (0..top.nr_doms).map(|_| None).collect(),
+            load_avg: 0f64,
+            dom_loads: vec![0.0; top.nr_doms],
+
+            imbal: vec![0.0; top.nr_doms],
+            doms_to_pull: BTreeMap::new(),
+            doms_to_push: BTreeMap::new(),
+
+            nr_lb_data_errors,
+
+            top,
+        }
+    }
+
+    fn read_dom_loads(&mut self) -> Result<()> {
+        let now_mono = now_monotonic();
+        let load_half_life = self.skel.rodata().load_half_life;
+        let maps = self.skel.maps();
+        let dom_data = maps.dom_data();
+        let mut load_sum = 0.0f64;
+
+        for i in 0..self.top.nr_doms {
+            let key = unsafe { std::mem::transmute::<u32, [u8; 4]>(i as u32) };
+
+            if let Some(dom_ctx_map_elem) = dom_data
+                .lookup(&key, libbpf_rs::MapFlags::ANY)
+                .context("Failed to lookup dom_ctx")?
+            {
+                let dom_ctx = unsafe {
+                    &*(dom_ctx_map_elem.as_slice().as_ptr() as *const rusty_sys::dom_ctx)
+                };
+
+                let rd = &dom_ctx.load_rd;
+                self.dom_loads[i] = ravg_read(
+                    rd.val,
+                    rd.val_at,
+                    rd.old,
+                    rd.cur,
+                    now_mono,
+                    load_half_life,
+                    RAVG_FRAC_BITS,
+                );
+
+                load_sum += self.dom_loads[i];
+            }
+        }
+
+        self.load_avg = load_sum / self.top.nr_doms as f64;
+
+        Ok(())
+    }
+
+    /// To balance dom loads, identify doms with lower and higher load than
+    /// average.
+    fn calculate_dom_load_balance(&mut self) -> Result<()> {
+        for (dom, dom_load) in self.dom_loads.iter().enumerate() {
+            let imbal = dom_load - self.load_avg;
+            if imbal.abs() >= self.load_avg * Self::LOAD_IMBAL_HIGH_RATIO {
+                if imbal > 0f64 {
+                    self.doms_to_push.insert(OrderedFloat(imbal), dom as u32);
+                } else {
+                    self.doms_to_pull.insert(OrderedFloat(-imbal), dom as u32);
+                }
+                self.imbal[dom] = imbal;
+            }
+        }
+        Ok(())
+    }
+
+    /// @dom needs to push out tasks to balance loads. Make sure its
+    /// tasks_by_load is populated so that the victim tasks can be picked.
+    fn populate_tasks_by_load(&mut self, dom: u32) -> Result<()> {
+        if self.tasks_by_load[dom as usize].is_some() {
+            return Ok(());
+        }
+
+        // Read active_pids and update write_idx and gen.
+        //
+        // XXX - We can't read task_ctx inline because self.skel.bss()
+        // borrows mutably and thus conflicts with self.skel.maps().
+        const MAX_PIDS: u64 = rusty_sys::consts_MAX_DOM_ACTIVE_PIDS as u64;
+        let active_pids = &mut self.skel.bss().dom_active_pids[dom as usize];
+        let mut pids = vec![];
+
+        let (mut ridx, widx) = (active_pids.read_idx, active_pids.write_idx);
+        if widx - ridx > MAX_PIDS {
+            ridx = widx - MAX_PIDS;
+        }
+
+        for idx in ridx..widx {
+            let pid = active_pids.pids[(idx % MAX_PIDS) as usize];
+            pids.push(pid);
+        }
+
+        active_pids.read_idx = active_pids.write_idx;
+        active_pids.gen += 1;
+
+        // Read task_ctx and load.
+        let load_half_life = self.skel.rodata().load_half_life;
+        let maps = self.skel.maps();
+        let task_data = maps.task_data();
+        let now_mono = now_monotonic();
+        let mut tasks_by_load = BTreeMap::new();
+
+        for pid in pids.iter() {
+            let key = unsafe { std::mem::transmute::<i32, [u8; 4]>(*pid) };
+
+            if let Some(task_data_elem) = task_data.lookup(&key, libbpf_rs::MapFlags::ANY)? {
+                let task_ctx =
+                    unsafe { &*(task_data_elem.as_slice().as_ptr() as *const rusty_sys::task_ctx) };
+
+                if task_ctx.dom_id != dom {
+                    continue;
+                }
+
+                let rd = &task_ctx.dcyc_rd;
+                let load = task_ctx.weight as f64
+                    * ravg_read(
+                        rd.val,
+                        rd.val_at,
+                        rd.old,
+                        rd.cur,
+                        now_mono,
+                        load_half_life,
+                        RAVG_FRAC_BITS,
+                    );
+
+                tasks_by_load.insert(
+                    OrderedFloat(load),
+                    TaskInfo {
+                        pid: *pid,
+                        dom_mask: task_ctx.dom_mask,
+                        migrated: Cell::new(false),
+                        is_kworker: task_ctx.is_kworker,
+                    },
+                );
+            }
+        }
+
+        debug!(
+            "DOM[{:02}] read load for {} tasks",
+            dom,
+            &tasks_by_load.len(),
+        );
+        trace!("DOM[{:02}] tasks_by_load={:?}", dom, &tasks_by_load);
+
+        self.tasks_by_load[dom as usize] = Some(tasks_by_load);
+        Ok(())
+    }
+
+    // Find the first candidate pid which hasn't already been migrated and
+    // can run in @pull_dom.
+    fn find_first_candidate<'d, I>(
+        tasks_by_load: I,
+        pull_dom: u32,
+        skip_kworkers: bool,
+    ) -> Option<(f64, &'d TaskInfo)>
+    where
+        I: IntoIterator<Item = (&'d OrderedFloat<f64>, &'d TaskInfo)>,
+    {
+        match tasks_by_load
+            .into_iter()
+            .skip_while(|(_, task)| {
+                task.migrated.get()
+                    || (task.dom_mask & (1 << pull_dom) == 0)
+                    || (skip_kworkers && task.is_kworker)
+            })
+            .next()
+        {
+            Some((OrderedFloat(load), task)) => Some((*load, task)),
+            None => None,
+        }
+    }
+
+    fn pick_victim(
+        &mut self,
+        (push_dom, to_push): (u32, f64),
+        (pull_dom, to_pull): (u32, f64),
+    ) -> Result<Option<(&TaskInfo, f64)>> {
+        let to_xfer = to_pull.min(to_push) * Self::LOAD_IMBAL_XFER_TARGET_RATIO;
+
+        debug!(
+            "considering dom {}@{:.2} -> {}@{:.2}",
+            push_dom, to_push, pull_dom, to_pull
+        );
+
+        let calc_new_imbal = |xfer: f64| (to_push - xfer).abs() + (to_pull - xfer).abs();
+
+        self.populate_tasks_by_load(push_dom)?;
+
+        // We want to pick a task to transfer from push_dom to pull_dom to
+        // reduce the load imbalance between the two closest to $to_xfer.
+        // IOW, pick a task which has the closest load value to $to_xfer
+        // that can be migrated. Find such task by locating the first
+        // migratable task while scanning left from $to_xfer and the
+        // counterpart while scanning right and picking the better of the
+        // two.
+        let (load, task, new_imbal) = match (
+            Self::find_first_candidate(
+                self.tasks_by_load[push_dom as usize]
+                    .as_ref()
+                    .unwrap()
+                    .range((Unbounded, Included(&OrderedFloat(to_xfer))))
+                    .rev(),
+                pull_dom,
+                self.skip_kworkers,
+            ),
+            Self::find_first_candidate(
+                self.tasks_by_load[push_dom as usize]
+                    .as_ref()
+                    .unwrap()
+                    .range((Included(&OrderedFloat(to_xfer)), Unbounded)),
+                pull_dom,
+                self.skip_kworkers,
+            ),
+        ) {
+            (None, None) => return Ok(None),
+            (Some((load, task)), None) | (None, Some((load, task))) => {
+                (load, task, calc_new_imbal(load))
+            }
+            (Some((load0, task0)), Some((load1, task1))) => {
+                let (new_imbal0, new_imbal1) = (calc_new_imbal(load0), calc_new_imbal(load1));
+                if new_imbal0 <= new_imbal1 {
+                    (load0, task0, new_imbal0)
+                } else {
+                    (load1, task1, new_imbal1)
+                }
+            }
+        };
+
+        // If the best candidate can't reduce the imbalance, there's nothing
+        // to do for this pair.
+        let old_imbal = to_push + to_pull;
+        if old_imbal < new_imbal {
+            debug!(
+                "skipping pid {}, dom {} -> {} won't improve imbal {:.2} -> {:.2}",
+                task.pid, push_dom, pull_dom, old_imbal, new_imbal
+            );
+            return Ok(None);
+        }
+
+        debug!(
+            "migrating pid {}, dom {} -> {}, imbal={:.2} -> {:.2}",
+            task.pid, push_dom, pull_dom, old_imbal, new_imbal,
+        );
+
+        Ok(Some((task, load)))
+    }
+
+    // Actually execute the load balancing. Concretely this writes pid -> dom
+    // entries into the lb_data map for bpf side to consume.
+    fn load_balance(&mut self) -> Result<()> {
+        clear_map(self.skel.maps().lb_data());
+
+        debug!("imbal={:?}", &self.imbal);
+        debug!("doms_to_push={:?}", &self.doms_to_push);
+        debug!("doms_to_pull={:?}", &self.doms_to_pull);
+
+        // Push from the most imbalanced to least.
+        while let Some((OrderedFloat(mut to_push), push_dom)) = self.doms_to_push.pop_last() {
+            let push_max = self.dom_loads[push_dom as usize] * Self::LOAD_IMBAL_PUSH_MAX_RATIO;
+            let mut pushed = 0f64;
+
+            // Transfer tasks from push_dom to reduce imbalance.
+            loop {
+                let last_pushed = pushed;
+
+                // Pull from the most imbalaned to least.
+                let mut doms_to_pull = BTreeMap::<_, _>::new();
+                std::mem::swap(&mut self.doms_to_pull, &mut doms_to_pull);
+                let mut pull_doms = doms_to_pull.into_iter().rev().collect::<Vec<(_, _)>>();
+
+                for (to_pull, pull_dom) in pull_doms.iter_mut() {
+                    if let Some((task, load)) =
+                        self.pick_victim((push_dom, to_push), (*pull_dom, f64::from(*to_pull)))?
+                    {
+                        // Execute migration.
+                        task.migrated.set(true);
+                        to_push -= load;
+                        *to_pull -= load;
+                        pushed += load;
+
+                        // Ask BPF code to execute the migration.
+                        let pid = task.pid;
+                        let cpid = (pid as libc::pid_t).to_ne_bytes();
+                        if let Err(e) = self.skel.maps_mut().lb_data().update(
+                            &cpid,
+                            &pull_dom.to_ne_bytes(),
+                            libbpf_rs::MapFlags::NO_EXIST,
+                        ) {
+                            warn!(
+                                "Failed to update lb_data map for pid={} error={:?}",
+                                pid, &e
+                            );
+                            *self.nr_lb_data_errors += 1;
+                        }
+
+                        // Always break after a successful migration so that
+                        // the pulling domains are always considered in the
+                        // descending imbalance order.
+                        break;
+                    }
+                }
+
+                pull_doms
+                    .into_iter()
+                    .map(|(k, v)| self.doms_to_pull.insert(k, v))
+                    .count();
+
+                // Stop repeating if nothing got transferred or pushed enough.
+                if pushed == last_pushed || pushed >= push_max {
+                    break;
+                }
+            }
+        }
+        Ok(())
+    }
+}
+
+struct Scheduler<'a> {
+    skel: RustySkel<'a>,
+    struct_ops: Option<libbpf_rs::Link>,
+
+    sched_interval: Duration,
+    tune_interval: Duration,
+    balance_load: bool,
+    balanced_kworkers: bool,
+
+    top: Arc<Topology>,
+    proc_reader: procfs::ProcReader,
+
+    prev_at: Instant,
+    prev_total_cpu: procfs::CpuStat,
+
+    nr_lb_data_errors: u64,
+
+    tuner: Tuner,
+}
+
+impl<'a> Scheduler<'a> {
+    fn init(opts: &Opts) -> Result<Self> {
+        // Open the BPF prog first for verification.
+        let mut skel_builder = RustySkelBuilder::default();
+        skel_builder.obj_builder.debug(opts.verbose > 0);
+        let mut skel = skel_builder.open().context("Failed to open BPF program")?;
+
+        let nr_cpus = libbpf_rs::num_possible_cpus().unwrap();
+        if nr_cpus > MAX_CPUS {
+            bail!(
+                "nr_cpus ({}) is greater than MAX_CPUS ({})",
+                nr_cpus,
+                MAX_CPUS
+            );
+        }
+
+        // Initialize skel according to @opts.
+        let top = Arc::new(if !opts.cpumasks.is_empty() {
+            Topology::from_cpumasks(&opts.cpumasks, nr_cpus)?
+        } else {
+            Topology::from_cache_level(opts.cache_level, nr_cpus)?
+        });
+
+        skel.rodata().nr_doms = top.nr_doms as u32;
+        skel.rodata().nr_cpus = top.nr_cpus as u32;
+
+        for (cpu, dom) in top.cpu_dom.iter().enumerate() {
+            skel.rodata().cpu_dom_id_map[cpu] = dom.unwrap_or(0) as u32;
+        }
+
+        for (dom, cpus) in top.dom_cpus.iter().enumerate() {
+            let raw_cpus_slice = cpus.as_raw_slice();
+            let dom_cpumask_slice = &mut skel.rodata().dom_cpumasks[dom];
+            let (left, _) = dom_cpumask_slice.split_at_mut(raw_cpus_slice.len());
+            left.clone_from_slice(cpus.as_raw_slice());
+            info!(
+                "DOM[{:02}] cpumask{} ({} cpus)",
+                dom,
+                &format_cpumask(dom_cpumask_slice, nr_cpus),
+                cpus.count_ones()
+            );
+        }
+
+        skel.rodata().slice_ns = opts.slice_us * 1000;
+        skel.rodata().load_half_life = (opts.load_half_life * 1000000000.0) as u32;
+        skel.rodata().kthreads_local = opts.kthreads_local;
+        skel.rodata().fifo_sched = opts.fifo_sched;
+        skel.rodata().switch_partial = opts.partial;
+        skel.rodata().greedy_threshold = opts.greedy_threshold;
+        skel.rodata().debug = opts.verbose as u32;
+
+        // Attach.
+        let mut skel = skel.load().context("Failed to load BPF program")?;
+        skel.attach().context("Failed to attach BPF program")?;
+        let struct_ops = Some(
+            skel.maps_mut()
+                .rusty()
+                .attach_struct_ops()
+                .context("Failed to attach rusty struct ops")?,
+        );
+        info!("Rusty Scheduler Attached");
+
+        // Other stuff.
+        let proc_reader = procfs::ProcReader::new();
+        let prev_total_cpu = read_total_cpu(&proc_reader)?;
+
+        Ok(Self {
+            skel,
+            struct_ops, // should be held to keep it attached
+
+            sched_interval: Duration::from_secs_f64(opts.interval),
+            tune_interval: Duration::from_secs_f64(opts.tune_interval),
+            balance_load: !opts.no_load_balance,
+            balanced_kworkers: opts.balanced_kworkers,
+
+            top: top.clone(),
+            proc_reader,
+
+            prev_at: Instant::now(),
+            prev_total_cpu,
+
+            nr_lb_data_errors: 0,
+
+            tuner: Tuner::new(top, opts)?,
+        })
+    }
+
+    fn get_cpu_busy(&mut self) -> Result<f64> {
+        let total_cpu = read_total_cpu(&self.proc_reader)?;
+        let busy = match (&self.prev_total_cpu, &total_cpu) {
+            (
+                procfs::CpuStat {
+                    user_usec: Some(prev_user),
+                    nice_usec: Some(prev_nice),
+                    system_usec: Some(prev_system),
+                    idle_usec: Some(prev_idle),
+                    iowait_usec: Some(prev_iowait),
+                    irq_usec: Some(prev_irq),
+                    softirq_usec: Some(prev_softirq),
+                    stolen_usec: Some(prev_stolen),
+                    guest_usec: _,
+                    guest_nice_usec: _,
+                },
+                procfs::CpuStat {
+                    user_usec: Some(curr_user),
+                    nice_usec: Some(curr_nice),
+                    system_usec: Some(curr_system),
+                    idle_usec: Some(curr_idle),
+                    iowait_usec: Some(curr_iowait),
+                    irq_usec: Some(curr_irq),
+                    softirq_usec: Some(curr_softirq),
+                    stolen_usec: Some(curr_stolen),
+                    guest_usec: _,
+                    guest_nice_usec: _,
+                },
+            ) => {
+                let idle_usec = curr_idle - prev_idle;
+                let iowait_usec = curr_iowait - prev_iowait;
+                let user_usec = curr_user - prev_user;
+                let system_usec = curr_system - prev_system;
+                let nice_usec = curr_nice - prev_nice;
+                let irq_usec = curr_irq - prev_irq;
+                let softirq_usec = curr_softirq - prev_softirq;
+                let stolen_usec = curr_stolen - prev_stolen;
+
+                let busy_usec =
+                    user_usec + system_usec + nice_usec + irq_usec + softirq_usec + stolen_usec;
+                let total_usec = idle_usec + busy_usec + iowait_usec;
+                busy_usec as f64 / total_usec as f64
+            }
+            _ => {
+                bail!("Some procfs stats are not populated!");
+            }
+        };
+
+        self.prev_total_cpu = total_cpu;
+        Ok(busy)
+    }
+
+    fn read_bpf_stats(&mut self) -> Result<Vec<u64>> {
+        let mut maps = self.skel.maps_mut();
+        let stats_map = maps.stats();
+        let mut stats: Vec<u64> = Vec::new();
+        let zero_vec = vec![vec![0u8; stats_map.value_size() as usize]; self.top.nr_cpus];
+
+        for stat in 0..rusty_sys::stat_idx_RUSTY_NR_STATS {
+            let cpu_stat_vec = stats_map
+                .lookup_percpu(&stat.to_ne_bytes(), libbpf_rs::MapFlags::ANY)
+                .with_context(|| format!("Failed to lookup stat {}", stat))?
+                .expect("per-cpu stat should exist");
+            let sum = cpu_stat_vec
+                .iter()
+                .map(|val| {
+                    u64::from_ne_bytes(
+                        val.as_slice()
+                            .try_into()
+                            .expect("Invalid value length in stat map"),
+                    )
+                })
+                .sum();
+            stats_map
+                .update_percpu(&stat.to_ne_bytes(), &zero_vec, libbpf_rs::MapFlags::ANY)
+                .context("Failed to zero stat")?;
+            stats.push(sum);
+        }
+        Ok(stats)
+    }
+
+    fn report(
+        &mut self,
+        stats: &[u64],
+        cpu_busy: f64,
+        processing_dur: Duration,
+        load_avg: f64,
+        dom_loads: &[f64],
+        imbal: &[f64],
+    ) {
+        let stat = |idx| stats[idx as usize];
+        let total = stat(rusty_sys::stat_idx_RUSTY_STAT_WAKE_SYNC)
+            + stat(rusty_sys::stat_idx_RUSTY_STAT_PREV_IDLE)
+            + stat(rusty_sys::stat_idx_RUSTY_STAT_GREEDY_IDLE)
+            + stat(rusty_sys::stat_idx_RUSTY_STAT_PINNED)
+            + stat(rusty_sys::stat_idx_RUSTY_STAT_DIRECT_DISPATCH)
+            + stat(rusty_sys::stat_idx_RUSTY_STAT_DIRECT_GREEDY)
+            + stat(rusty_sys::stat_idx_RUSTY_STAT_DIRECT_GREEDY_FAR)
+            + stat(rusty_sys::stat_idx_RUSTY_STAT_DSQ_DISPATCH)
+            + stat(rusty_sys::stat_idx_RUSTY_STAT_GREEDY);
+
+        info!(
+            "cpu={:7.2} bal={} load_avg={:8.2} task_err={} lb_data_err={} proc={:?}ms",
+            cpu_busy * 100.0,
+            stats[rusty_sys::stat_idx_RUSTY_STAT_LOAD_BALANCE as usize],
+            load_avg,
+            stats[rusty_sys::stat_idx_RUSTY_STAT_TASK_GET_ERR as usize],
+            self.nr_lb_data_errors,
+            processing_dur.as_millis(),
+        );
+
+        let stat_pct = |idx| stat(idx) as f64 / total as f64 * 100.0;
+
+        info!(
+            "tot={:7} wsync={:5.2} prev_idle={:5.2} greedy_idle={:5.2} pin={:5.2}",
+            total,
+            stat_pct(rusty_sys::stat_idx_RUSTY_STAT_WAKE_SYNC),
+            stat_pct(rusty_sys::stat_idx_RUSTY_STAT_PREV_IDLE),
+            stat_pct(rusty_sys::stat_idx_RUSTY_STAT_GREEDY_IDLE),
+            stat_pct(rusty_sys::stat_idx_RUSTY_STAT_PINNED),
+        );
+
+        info!(
+            "dir={:5.2} dir_greedy={:5.2} dir_greedy_far={:5.2}",
+            stat_pct(rusty_sys::stat_idx_RUSTY_STAT_DIRECT_DISPATCH),
+            stat_pct(rusty_sys::stat_idx_RUSTY_STAT_DIRECT_GREEDY),
+            stat_pct(rusty_sys::stat_idx_RUSTY_STAT_DIRECT_GREEDY_FAR),
+        );
+
+        info!(
+            "dsq={:5.2} greedy={:5.2} kick_greedy={:5.2} rep={:5.2}",
+            stat_pct(rusty_sys::stat_idx_RUSTY_STAT_DSQ_DISPATCH),
+            stat_pct(rusty_sys::stat_idx_RUSTY_STAT_GREEDY),
+            stat_pct(rusty_sys::stat_idx_RUSTY_STAT_KICK_GREEDY),
+            stat_pct(rusty_sys::stat_idx_RUSTY_STAT_REPATRIATE),
+        );
+
+        let ti = &self.skel.bss().tune_input;
+        info!(
+            "direct_greedy_cpumask={}",
+            format_cpumask(&ti.direct_greedy_cpumask, self.top.nr_cpus)
+        );
+        info!(
+            "  kick_greedy_cpumask={}",
+            format_cpumask(&ti.kick_greedy_cpumask, self.top.nr_cpus)
+        );
+
+        for i in 0..self.top.nr_doms {
+            info!(
+                "DOM[{:02}] util={:6.2} load={:8.2} imbal={}",
+                i,
+                self.tuner.dom_utils[i] * 100.0,
+                dom_loads[i],
+                if imbal[i] == 0.0 {
+                    format!("{:9.2}", 0.0)
+                } else {
+                    format!("{:+9.2}", imbal[i])
+                },
+            );
+        }
+    }
+
+    fn lb_step(&mut self) -> Result<()> {
+        let started_at = Instant::now();
+        let bpf_stats = self.read_bpf_stats()?;
+        let cpu_busy = self.get_cpu_busy()?;
+
+        let mut lb = LoadBalancer::new(
+            &mut self.skel,
+            self.top.clone(),
+            self.balanced_kworkers,
+            &mut self.nr_lb_data_errors,
+        );
+
+        lb.read_dom_loads()?;
+        lb.calculate_dom_load_balance()?;
+
+        if self.balance_load {
+            lb.load_balance()?;
+        }
+
+        // Extract fields needed for reporting and drop lb to release
+        // mutable borrows.
+        let (load_avg, dom_loads, imbal) = (lb.load_avg, lb.dom_loads, lb.imbal);
+
+        self.report(
+            &bpf_stats,
+            cpu_busy,
+            Instant::now().duration_since(started_at),
+            load_avg,
+            &dom_loads,
+            &imbal,
+        );
+
+        self.prev_at = started_at;
+        Ok(())
+    }
+
+    fn read_bpf_exit_kind(&mut self) -> i32 {
+        unsafe { std::ptr::read_volatile(&self.skel.bss().exit_kind as *const _) }
+    }
+
+    fn report_bpf_exit_kind(&mut self) -> Result<()> {
+        // Report msg if EXT_OPS_EXIT_ERROR.
+        match self.read_bpf_exit_kind() {
+            0 => Ok(()),
+            etype if etype == 2 => {
+                let cstr = unsafe { CStr::from_ptr(self.skel.bss().exit_msg.as_ptr() as *const _) };
+                let msg = cstr
+                    .to_str()
+                    .context("Failed to convert exit msg to string")
+                    .unwrap();
+                bail!("BPF exit_kind={} msg={}", etype, msg);
+            }
+            etype => {
+                info!("BPF exit_kind={}", etype);
+                Ok(())
+            }
+        }
+    }
+
+    fn run(&mut self, shutdown: Arc<AtomicBool>) -> Result<()> {
+        let now = Instant::now();
+        let mut next_tune_at = now + self.tune_interval;
+        let mut next_sched_at = now + self.sched_interval;
+
+        while !shutdown.load(Ordering::Relaxed) && self.read_bpf_exit_kind() == 0 {
+            let now = Instant::now();
+
+            if now >= next_tune_at {
+                self.tuner.step(&mut self.skel)?;
+                next_tune_at += self.tune_interval;
+                if next_tune_at < now {
+                    next_tune_at = now + self.tune_interval;
+                }
+            }
+
+            if now >= next_sched_at {
+                self.lb_step()?;
+                next_sched_at += self.sched_interval;
+                if next_sched_at < now {
+                    next_sched_at = now + self.sched_interval;
+                }
+            }
+
+            std::thread::sleep(
+                next_sched_at
+                    .min(next_tune_at)
+                    .duration_since(Instant::now()),
+            );
+        }
+
+        self.report_bpf_exit_kind()
+    }
+}
+
+impl<'a> Drop for Scheduler<'a> {
+    fn drop(&mut self) {
+        if let Some(struct_ops) = self.struct_ops.take() {
+            drop(struct_ops);
+        }
+    }
+}
+
+fn main() -> Result<()> {
+    let opts = Opts::parse();
+
+    let llv = match opts.verbose {
+        0 => simplelog::LevelFilter::Info,
+        1 => simplelog::LevelFilter::Debug,
+        _ => simplelog::LevelFilter::Trace,
+    };
+    let mut lcfg = simplelog::ConfigBuilder::new();
+    lcfg.set_time_level(simplelog::LevelFilter::Error)
+        .set_location_level(simplelog::LevelFilter::Off)
+        .set_target_level(simplelog::LevelFilter::Off)
+        .set_thread_level(simplelog::LevelFilter::Off);
+    simplelog::TermLogger::init(
+        llv,
+        lcfg.build(),
+        simplelog::TerminalMode::Stderr,
+        simplelog::ColorChoice::Auto,
+    )?;
+
+    let mut sched = Scheduler::init(&opts)?;
+
+    let shutdown = Arc::new(AtomicBool::new(false));
+    let shutdown_clone = shutdown.clone();
+    ctrlc::set_handler(move || {
+        shutdown_clone.store(true, Ordering::Relaxed);
+    })
+    .context("Error setting Ctrl-C handler")?;
+
+    sched.run(shutdown)
+}
diff --git a/tools/sched_ext/scx_rusty/src/rusty_sys.rs b/tools/sched_ext/scx_rusty/src/rusty_sys.rs
new file mode 100644
index 000000000000..e948d81e7356
--- /dev/null
+++ b/tools/sched_ext/scx_rusty/src/rusty_sys.rs
@@ -0,0 +1,10 @@
+// Copyright (c) Meta Platforms, Inc. and affiliates.
+
+// This software may be used and distributed according to the terms of the
+// GNU General Public License version 2.
+#![allow(non_upper_case_globals)]
+#![allow(non_camel_case_types)]
+#![allow(non_snake_case)]
+#![allow(dead_code)]
+
+include!(concat!(env!("OUT_DIR"), "/rusty_sys.rs"));
-- 
2.42.0


