Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63A4067F317
	for <lists+bpf@lfdr.de>; Sat, 28 Jan 2023 01:20:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233032AbjA1AUh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 27 Jan 2023 19:20:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233044AbjA1AUI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 27 Jan 2023 19:20:08 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C06258D0BF;
        Fri, 27 Jan 2023 16:18:27 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id g9so4368496pfo.5;
        Fri, 27 Jan 2023 16:18:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/RFQgOqIi06BD6hRbYTcXyM+6XH+5DwTwQb1rdOUUH8=;
        b=X+NrKfDHMRzShdpNgAdJdKZMwXohdlp67oADr7COS7UF1nFdOtfymk9cwn2wvIKIXu
         SeCh/3/K+sx1q4Sbv401cEs4lsCuoGW8Dr6pZPz6CjHkX8B6Q3LgsHffdSpk40wqQNCv
         0GPJ98ySooHtgoeO3FTYxzRaHARa/Bur4Au9VrFK/cnnnoWRBX7jGiqLIxqdbi6bfx8m
         0+Lwk9bi83fje2RJ+4CGCwKZXWe8p3xMOIwTfPZS/+rCZT7c6Cv1Sx7UheaTOxI2IgDh
         Anp5kdHfT3Ta9RT5ZL+tGpO6VoukZjhHH9QFE3canXlh5fryAbhXs/IascqBKB7Evo5h
         r2pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/RFQgOqIi06BD6hRbYTcXyM+6XH+5DwTwQb1rdOUUH8=;
        b=SUiRBXE/4YymWjFS9bXQ/nRxLw7v4PFPP9tyAKuRhtwVBtPPwAzIm/Zjzd0u/tJQev
         JrYWwwmVZdQ++VjjlJGY0msU+HfxxqoSOazt+WP90royPHr3D/ESjAUDSRKaQ5w/nmqw
         8RHH7AfmxKL3+YFOX3ifJ08//GwfPd9M9VXCa8zIwvP2QuL1vkf756SXgMqiSw5XewUg
         7Abb0y138b1PjVRjXeaoqnNoZcvradirp5nh0QAzUie0Jk5z5Tojl5JNa40VJ3onxO/A
         7JZy7vWiUxIALqubvWeGLDW9AqV9zf2CTdrYYI0uM9WpglCMAzs6ceTb4OpQvUVMiuAa
         mtTw==
X-Gm-Message-State: AO0yUKV4417MMpm25Xl8Zq0zwPMGO737n702ZJxdByrM7dhDnRU6cnr2
        Rdnfi/XAxPfvQKjbK/w5G+HqY83kXT8=
X-Google-Smtp-Source: AK7set+u2mKT2yfeTuY/fzPJvKhWdsKHyMH137ClVvwq6ZjC6HMLcFEvlkqGujxrk8ARz5jXhIQWDA==
X-Received: by 2002:aa7:85c3:0:b0:592:629a:c9b5 with SMTP id z3-20020aa785c3000000b00592629ac9b5mr3592068pfn.14.1674865067876;
        Fri, 27 Jan 2023 16:17:47 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id a139-20020a621a91000000b0058e12371d96sm3137584pfa.164.2023.01.27.16.17.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 16:17:47 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
From:   Tejun Heo <tj@kernel.org>
To:     torvalds@linux-foundation.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org,
        joshdon@google.com, brho@google.com, pjt@google.com,
        derkling@google.com, haoluo@google.com, dvernet@meta.com,
        dschatzberg@meta.com, dskarlat@cs.cmu.edu, riel@surriel.com
Cc:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        kernel-team@meta.com, Tejun Heo <tj@kernel.org>
Subject: [PATCH 30/30] sched_ext: Add a rust userspace hybrid example scheduler
Date:   Fri, 27 Jan 2023 14:16:39 -1000
Message-Id: <20230128001639.3510083-31-tj@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230128001639.3510083-1-tj@kernel.org>
References: <20230128001639.3510083-1-tj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Dan Schatzberg <dschatzberg@meta.com>

Atropos is a multi-domain BPF / userspace hybrid scheduler where the BPF
part does simple round robin in each domain and the userspace part
calculates the load factor of each domain and tells the BPF part how to load
balance the domains.

This scheduler demonstrates dividing scheduling logic between BPF and
userspace and using rust to build the userspace part. An earlier variant of
this scheduler was used to balance across six domains, each representing a
chiplet in a six-chiplet AMD processor, and could match the performance of
production setup using CFS.

v2: Updated to use generic BPF cpumask helpers.

Signed-off-by: Dan Schatzberg <dschatzberg@meta.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 tools/sched_ext/Makefile                      |  13 +-
 tools/sched_ext/atropos/.gitignore            |   3 +
 tools/sched_ext/atropos/Cargo.toml            |  28 +
 tools/sched_ext/atropos/build.rs              |  70 ++
 tools/sched_ext/atropos/rustfmt.toml          |   8 +
 tools/sched_ext/atropos/src/bpf/atropos.bpf.c | 632 +++++++++++++++++
 tools/sched_ext/atropos/src/bpf/atropos.h     |  44 ++
 tools/sched_ext/atropos/src/main.rs           | 648 ++++++++++++++++++
 .../sched_ext/atropos/src/oss/atropos_sys.rs  |  10 +
 tools/sched_ext/atropos/src/oss/mod.rs        |  29 +
 tools/sched_ext/atropos/src/util.rs           |  24 +
 11 files changed, 1507 insertions(+), 2 deletions(-)
 create mode 100644 tools/sched_ext/atropos/.gitignore
 create mode 100644 tools/sched_ext/atropos/Cargo.toml
 create mode 100644 tools/sched_ext/atropos/build.rs
 create mode 100644 tools/sched_ext/atropos/rustfmt.toml
 create mode 100644 tools/sched_ext/atropos/src/bpf/atropos.bpf.c
 create mode 100644 tools/sched_ext/atropos/src/bpf/atropos.h
 create mode 100644 tools/sched_ext/atropos/src/main.rs
 create mode 100644 tools/sched_ext/atropos/src/oss/atropos_sys.rs
 create mode 100644 tools/sched_ext/atropos/src/oss/mod.rs
 create mode 100644 tools/sched_ext/atropos/src/util.rs

diff --git a/tools/sched_ext/Makefile b/tools/sched_ext/Makefile
index fcb4faa75e37..0ae20dc0f10d 100644
--- a/tools/sched_ext/Makefile
+++ b/tools/sched_ext/Makefile
@@ -85,6 +85,8 @@ CFLAGS += -g -O2 -rdynamic -pthread -Wall -Werror $(GENFLAGS)			\
 	  -I$(INCLUDE_DIR) -I$(GENDIR) -I$(LIBDIR)				\
 	  -I$(TOOLSINCDIR) -I$(APIDIR)
 
+CARGOFLAGS := --release
+
 # Silence some warnings when compiled with clang
 ifneq ($(LLVM),)
 CFLAGS += -Wno-unused-command-line-argument
@@ -116,7 +118,7 @@ BPF_CFLAGS = -g -D__TARGET_ARCH_$(SRCARCH)					\
 	     -O2 -mcpu=v3
 
 all: scx_example_dummy scx_example_qmap scx_example_central scx_example_pair	\
-     scx_example_userland
+     scx_example_userland atropos
 
 # sort removes libbpf duplicates when not cross-building
 MAKE_DIRS := $(sort $(BUILD_DIR)/libbpf $(HOST_BUILD_DIR)/libbpf		\
@@ -188,13 +190,20 @@ scx_example_userland: scx_example_userland.c scx_example_userland.skel.h	\
 	$(CC) $(CFLAGS) -c $< -o $@.o
 	$(CC) -o $@ $@.o $(HOST_BPFOBJ) $(LDFLAGS)
 
+atropos: export RUSTFLAGS = -C link-args=-lzstd -C link-args=-lz -C link-args=-lelf -L $(BPFOBJ_DIR)
+atropos: export ATROPOS_CLANG = $(CLANG)
+atropos: export ATROPOS_BPF_CFLAGS = $(BPF_CFLAGS)
+atropos: $(INCLUDE_DIR)/vmlinux.h
+	cargo build --manifest-path=atropos/Cargo.toml $(CARGOFLAGS)
+
 clean:
+	cargo clean --manifest-path=atropos/Cargo.toml
 	rm -rf $(SCRATCH_DIR) $(HOST_SCRATCH_DIR)
 	rm -f *.o *.bpf.o *.skel.h *.subskel.h
 	rm -f scx_example_dummy scx_example_qmap scx_example_central		\
 	      scx_example_pair scx_example_userland
 
-.PHONY: all clean
+.PHONY: all atropos clean
 
 # delete failed targets
 .DELETE_ON_ERROR:
diff --git a/tools/sched_ext/atropos/.gitignore b/tools/sched_ext/atropos/.gitignore
new file mode 100644
index 000000000000..186dba259ec2
--- /dev/null
+++ b/tools/sched_ext/atropos/.gitignore
@@ -0,0 +1,3 @@
+src/bpf/.output
+Cargo.lock
+target
diff --git a/tools/sched_ext/atropos/Cargo.toml b/tools/sched_ext/atropos/Cargo.toml
new file mode 100644
index 000000000000..fcfce056c741
--- /dev/null
+++ b/tools/sched_ext/atropos/Cargo.toml
@@ -0,0 +1,28 @@
+[package]
+name = "atropos-bin"
+version = "0.5.0"
+authors = ["Dan Schatzberg <dschatzberg@meta.com>", "Meta"]
+edition = "2021"
+description = "Userspace scheduling with BPF"
+license = "GPL-2.0-only"
+
+[dependencies]
+anyhow = "1.0.65"
+bitvec = { version = "1.0", features = ["serde"] }
+clap = { version = "3.2.17", features = ["derive", "env", "regex", "unicode", "wrap_help"] }
+ctrlc = { version = "3.1", features = ["termination"] }
+fb_procfs = { git = "https://github.com/facebookincubator/below.git", rev = "f305730"}
+hex = "0.4.3"
+libbpf-rs = "0.19.1"
+libbpf-sys = { version = "1.0.4", features = ["novendor", "static"] }
+libc = "0.2.137"
+slog = { version = "2.7", features = ["max_level_trace", "nested-values"] }
+slog-async = { version = "2.3", features = ["nested-values"] }
+slog-term = "2.8"
+
+[build-dependencies]
+bindgen = { version = "0.61.0", features = ["logging", "static"], default-features = false }
+libbpf-cargo = "0.13.0"
+
+[features]
+enable_backtrace = []
diff --git a/tools/sched_ext/atropos/build.rs b/tools/sched_ext/atropos/build.rs
new file mode 100644
index 000000000000..26e792c5e17e
--- /dev/null
+++ b/tools/sched_ext/atropos/build.rs
@@ -0,0 +1,70 @@
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
+const HEADER_PATH: &str = "src/bpf/atropos.h";
+
+fn bindgen_atropos() {
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
+        .write_to_file(out_path.join("atropos-sys.rs"))
+        .expect("Couldn't write bindings!");
+}
+
+fn gen_bpf_sched(name: &str) {
+    let bpf_cflags = env::var("ATROPOS_BPF_CFLAGS").unwrap();
+    let clang = env::var("ATROPOS_CLANG").unwrap();
+    eprintln!("{}", clang);
+    let outpath = format!("./src/bpf/.output/{}.skel.rs", name);
+    let skel = Path::new(&outpath);
+    let src = format!("./src/bpf/{}.bpf.c", name);
+    SkeletonBuilder::new()
+        .source(src.clone())
+        .clang(clang)
+        .clang_args(bpf_cflags)
+        .build_and_generate(&skel)
+        .unwrap();
+    println!("cargo:rerun-if-changed={}", src);
+}
+
+fn main() {
+    bindgen_atropos();
+    // It's unfortunate we cannot use `OUT_DIR` to store the generated skeleton.
+    // Reasons are because the generated skeleton contains compiler attributes
+    // that cannot be `include!()`ed via macro. And we cannot use the `#[path = "..."]`
+    // trick either because you cannot yet `concat!(env!("OUT_DIR"), "/skel.rs")` inside
+    // the path attribute either (see https://github.com/rust-lang/rust/pull/83366).
+    //
+    // However, there is hope! When the above feature stabilizes we can clean this
+    // all up.
+    create_dir_all("./src/bpf/.output").unwrap();
+    gen_bpf_sched("atropos");
+}
diff --git a/tools/sched_ext/atropos/rustfmt.toml b/tools/sched_ext/atropos/rustfmt.toml
new file mode 100644
index 000000000000..b7258ed0a8d8
--- /dev/null
+++ b/tools/sched_ext/atropos/rustfmt.toml
@@ -0,0 +1,8 @@
+# Get help on options with `rustfmt --help=config`
+# Please keep these in alphabetical order.
+edition = "2021"
+group_imports = "StdExternalCrate"
+imports_granularity = "Item"
+merge_derives = false
+use_field_init_shorthand = true
+version = "Two"
diff --git a/tools/sched_ext/atropos/src/bpf/atropos.bpf.c b/tools/sched_ext/atropos/src/bpf/atropos.bpf.c
new file mode 100644
index 000000000000..17b89d57e487
--- /dev/null
+++ b/tools/sched_ext/atropos/src/bpf/atropos.bpf.c
@@ -0,0 +1,632 @@
+// Copyright (c) Meta Platforms, Inc. and affiliates.
+
+// This software may be used and distributed according to the terms of the
+// GNU General Public License version 2.
+//
+// Atropos is a multi-domain BPF / userspace hybrid scheduler where the BPF
+// part does simple round robin in each domain and the userspace part
+// calculates the load factor of each domain and tells the BPF part how to load
+// balance the domains.
+//
+// Every task has an entry in the task_data map which lists which domain the
+// task belongs to. When a task first enters the system (atropos_prep_enable),
+// they are round-robined to a domain.
+//
+// atropos_select_cpu is the primary scheduling logic, invoked when a task
+// becomes runnable. The lb_data map is populated by userspace to inform the BPF
+// scheduler that a task should be migrated to a new domain. Otherwise, the task
+// is scheduled in priority order as follows:
+// * The current core if the task was woken up synchronously and there are idle
+//   cpus in the system
+// * The previous core, if idle
+// * The pinned-to core if the task is pinned to a specific core
+// * Any idle cpu in the domain
+//
+// If none of the above conditions are met, then the task is enqueued to a
+// dispatch queue corresponding to the domain (atropos_enqueue).
+//
+// atropos_dispatch will attempt to consume a task from its domain's
+// corresponding dispatch queue (this occurs after scheduling any tasks directly
+// assigned to it due to the logic in atropos_select_cpu). If no task is found,
+// then greedy load stealing will attempt to find a task on another dispatch
+// queue to run.
+//
+// Load balancing is almost entirely handled by userspace. BPF populates the
+// task weight, dom mask and current dom in the task_data map and executes the
+// load balance based on userspace populating the lb_data map.
+#include "../../../scx_common.bpf.h"
+#include "atropos.h"
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
+const volatile __u32 nr_doms;
+const volatile __u32 nr_cpus;
+const volatile __u32 cpu_dom_id_map[MAX_CPUS];
+const volatile __u64 dom_cpumasks[MAX_DOMS][MAX_CPUS / 64];
+
+const volatile bool switch_all;
+const volatile __u64 greedy_threshold = (u64)-1;
+
+/* base slice duration */
+const volatile __u64 slice_us = 20000;
+
+/*
+ * Exit info
+ */
+int exit_type = SCX_EXIT_NONE;
+char exit_msg[SCX_EXIT_MSG_LEN];
+
+struct pcpu_ctx {
+	__u32 dom_rr_cur; /* used when scanning other doms */
+
+	/* libbpf-rs does not respect the alignment, so pad out the struct explicitly */
+	__u8 _padding[CACHELINE_SIZE - sizeof(u64)];
+} __attribute__((aligned(CACHELINE_SIZE)));
+
+struct pcpu_ctx pcpu_ctx[MAX_CPUS];
+
+struct dom_cpumask {
+	struct bpf_cpumask __kptr_ref *cpumask;
+};
+
+/*
+ * Domain cpumasks
+ */
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__type(key, u32);
+	__type(value, struct dom_cpumask);
+	__uint(max_entries, MAX_DOMS);
+	__uint(map_flags, 0);
+} dom_cpumask_map SEC(".maps");
+
+/*
+ * Statistics
+ */
+struct {
+	__uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
+	__uint(key_size, sizeof(u32));
+	__uint(value_size, sizeof(u64));
+	__uint(max_entries, ATROPOS_NR_STATS);
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
+// Map pid -> task_ctx
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__type(key, pid_t);
+	__type(value, struct task_ctx);
+	__uint(max_entries, 1000000);
+	__uint(map_flags, 0);
+} task_data SEC(".maps");
+
+// This is populated from userspace to indicate which pids should be reassigned
+// to new doms
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__type(key, pid_t);
+	__type(value, u32);
+	__uint(max_entries, 1000);
+	__uint(map_flags, 0);
+} lb_data SEC(".maps");
+
+struct refresh_task_cpumask_loop_ctx {
+	struct task_struct *p;
+	struct task_ctx *ctx;
+};
+
+static void task_set_dq(struct task_ctx *task_ctx, struct task_struct *p,
+			u32 dom_id)
+{
+	struct dom_cpumask *dom_cpumask;
+	struct bpf_cpumask *d_cpumask, *t_cpumask;
+
+	dom_cpumask = bpf_map_lookup_elem(&dom_cpumask_map, &dom_id);
+	if (!dom_cpumask) {
+		scx_bpf_error("Failed to look up domain %u cpumask", dom_id);
+		return;
+	}
+
+	d_cpumask = bpf_cpumask_kptr_get(&dom_cpumask->cpumask);
+	if (!d_cpumask) {
+		scx_bpf_error("Failed to get domain %u cpumask kptr", dom_id);
+		return;
+	}
+
+	t_cpumask = bpf_cpumask_kptr_get(&task_ctx->cpumask);
+	if (!t_cpumask) {
+		scx_bpf_error("Failed to look up task cpumask");
+		bpf_cpumask_release(d_cpumask);
+		return;
+	}
+
+	bpf_cpumask_and(t_cpumask, (const struct cpumask *)d_cpumask, p->cpus_ptr);
+	bpf_cpumask_release(d_cpumask);
+	bpf_cpumask_release(t_cpumask);
+}
+
+s32 BPF_STRUCT_OPS(atropos_select_cpu, struct task_struct *p, int prev_cpu,
+		   u32 wake_flags)
+{
+	s32 cpu;
+	pid_t pid = p->pid;
+	struct task_ctx *task_ctx = bpf_map_lookup_elem(&task_data, &pid);
+	struct bpf_cpumask *p_cpumask;
+
+	if (!task_ctx) {
+		stat_add(ATROPOS_STAT_TASK_GET_ERR, 1);
+		return prev_cpu;
+	}
+
+	bool load_balanced = false;
+	u32 *new_dom = bpf_map_lookup_elem(&lb_data, &pid);
+	if (new_dom && *new_dom != task_ctx->dom_id) {
+		task_set_dq(task_ctx, p, *new_dom);
+		stat_add(ATROPOS_STAT_LOAD_BALANCE, 1);
+		load_balanced = true;
+	}
+
+	/*
+	 * If WAKE_SYNC and the machine isn't fully saturated, wake up @p to the
+	 * local dq of the waker.
+	 */
+	if (p->nr_cpus_allowed > 1 && (wake_flags & SCX_WAKE_SYNC)) {
+		struct task_struct *current = (void *)bpf_get_current_task();
+
+		if (!(BPF_CORE_READ(current, flags) & PF_EXITING) &&
+		    task_ctx->dom_id < MAX_DOMS) {
+			struct dom_cpumask *dmask_wrapper;
+			struct bpf_cpumask *d_cpumask;
+
+			dmask_wrapper = bpf_map_lookup_elem(&dom_cpumask_map, &task_ctx->dom_id);
+			if (!dmask_wrapper) {
+				scx_bpf_error("Failed to query for domain %u cpumask",
+					      task_ctx->dom_id);
+				return prev_cpu;
+			}
+			d_cpumask = bpf_cpumask_kptr_get(&dmask_wrapper->cpumask);
+			if (!d_cpumask) {
+				scx_bpf_error("Failed to acquire domain %u cpumask kptr",
+					      task_ctx->dom_id);
+				return prev_cpu;
+			}
+
+			cpu = scx_bpf_pick_idle_cpu(&d_cpumask->cpumask);
+			bpf_cpumask_release(d_cpumask);
+			if (bpf_cpumask_test_cpu(cpu, p->cpus_ptr)) {
+				stat_add(ATROPOS_STAT_WAKE_SYNC, 1);
+				goto local;
+			}
+		}
+	}
+
+	/* if the previous CPU is idle, dispatch directly to it */
+	if (!load_balanced) {
+		u8 prev_idle = scx_bpf_test_and_clear_cpu_idle(prev_cpu);
+		if (*(volatile u8 *)&prev_idle) {
+			stat_add(ATROPOS_STAT_PREV_IDLE, 1);
+			cpu = prev_cpu;
+			goto local;
+		}
+	}
+
+	/* If only one core is allowed, dispatch */
+	p_cpumask = bpf_cpumask_kptr_get(&task_ctx->cpumask);
+	if (!p_cpumask) {
+		scx_bpf_error("Failed to acquire task %s cpumask kptr",
+			      p->comm);
+		return prev_cpu;
+	}
+	if (p->nr_cpus_allowed == 1) {
+		cpu = bpf_cpumask_first(p_cpumask);
+		bpf_cpumask_release(p_cpumask);
+		stat_add(ATROPOS_STAT_PINNED, 1);
+		goto local;
+	}
+
+	/* Find an idle cpu and just dispatch */
+	cpu = scx_bpf_pick_idle_cpu(p_cpumask);
+	bpf_cpumask_release(p_cpumask);
+	if (cpu >= 0) {
+		stat_add(ATROPOS_STAT_DIRECT_DISPATCH, 1);
+		goto local;
+	}
+
+	return prev_cpu;
+
+local:
+	task_ctx->dispatch_local = true;
+	return cpu;
+}
+
+void BPF_STRUCT_OPS(atropos_enqueue, struct task_struct *p, u32 enq_flags)
+{
+	p->scx.slice = slice_us * 1000;
+
+	pid_t pid = p->pid;
+	struct task_ctx *task_ctx = bpf_map_lookup_elem(&task_data, &pid);
+	if (!task_ctx) {
+		stat_add(ATROPOS_STAT_TASK_GET_ERR, 1);
+		scx_bpf_dispatch(p, SCX_DSQ_GLOBAL, SCX_SLICE_DFL, enq_flags);
+		return;
+	}
+
+	if (task_ctx->dispatch_local) {
+		task_ctx->dispatch_local = false;
+		scx_bpf_dispatch(p, SCX_DSQ_LOCAL, SCX_SLICE_DFL, enq_flags);
+		return;
+	}
+
+	scx_bpf_dispatch(p, task_ctx->dom_id, SCX_SLICE_DFL, enq_flags);
+}
+
+static u32 cpu_to_dom_id(s32 cpu)
+{
+	if (nr_doms <= 1)
+		return 0;
+
+	if (cpu >= 0 && cpu < MAX_CPUS) {
+		u32 dom_id;
+
+		/*
+		 * XXX - idk why the verifier thinks cpu_dom_id_map[cpu] is not
+		 * safe here.
+		 */
+		bpf_probe_read_kernel(&dom_id, sizeof(dom_id),
+				      (const void *)&cpu_dom_id_map[cpu]);
+		return dom_id;
+	} else {
+		return MAX_DOMS;
+	}
+}
+
+static bool is_cpu_in_dom(u32 cpu, u32 dom_id)
+{
+	u64 mask = 0;
+
+	/*
+	 * XXX - derefing two dimensional array triggers the verifier, use
+	 * probe_read instead.
+	 */
+	bpf_probe_read_kernel(&mask, sizeof(mask),
+			      (const void *)&dom_cpumasks[dom_id][cpu / 64]);
+	return mask & (1LLU << (cpu % 64));
+}
+
+struct cpumask_intersects_domain_loop_ctx {
+	const struct cpumask *cpumask;
+	u32 dom_id;
+	bool ret;
+};
+
+static int cpumask_intersects_domain_loopfn(u32 idx, void *data)
+{
+	struct cpumask_intersects_domain_loop_ctx *lctx = data;
+	const struct cpumask *cpumask = lctx->cpumask;
+
+	if (bpf_cpumask_test_cpu(idx, cpumask) &&
+	    is_cpu_in_dom(idx, lctx->dom_id)) {
+		lctx->ret = true;
+		return 1;
+	}
+	return 0;
+}
+
+static bool cpumask_intersects_domain(const struct cpumask *cpumask, u32 dom_id)
+{
+	struct cpumask_intersects_domain_loop_ctx lctx = {
+		.cpumask = cpumask,
+		.dom_id = dom_id,
+		.ret = false,
+	};
+
+	bpf_loop(nr_cpus, cpumask_intersects_domain_loopfn, &lctx, 0);
+	return lctx.ret;
+}
+
+static u32 dom_rr_next(s32 cpu)
+{
+	if (cpu >= 0 && cpu < MAX_CPUS) {
+		struct pcpu_ctx *pcpuc = &pcpu_ctx[cpu];
+		u32 dom_id = (pcpuc->dom_rr_cur + 1) % nr_doms;
+
+		if (dom_id == cpu_to_dom_id(cpu))
+			dom_id = (dom_id + 1) % nr_doms;
+
+		pcpuc->dom_rr_cur = dom_id;
+		return dom_id;
+	}
+	return 0;
+}
+
+static int greedy_loopfn(s32 idx, void *data)
+{
+	u32 dom_id = dom_rr_next(*(s32 *)data);
+
+	if (scx_bpf_dsq_nr_queued(dom_id) > greedy_threshold &&
+	    scx_bpf_consume(dom_id)) {
+		stat_add(ATROPOS_STAT_GREEDY, 1);
+		return 1;
+	}
+	return 0;
+}
+
+void BPF_STRUCT_OPS(atropos_dispatch, s32 cpu, struct task_struct *prev)
+{
+	u32 dom = cpu_to_dom_id(cpu);
+	if (scx_bpf_consume(dom)) {
+		stat_add(ATROPOS_STAT_DSQ_DISPATCH, 1);
+		return;
+	}
+
+	if (greedy_threshold != (u64)-1)
+		bpf_loop(nr_doms - 1, greedy_loopfn, &cpu, 0);
+}
+
+struct pick_task_domain_loop_ctx {
+	struct task_struct *p;
+	const struct cpumask *cpumask;
+	u64 dom_mask;
+	u32 dom_rr_base;
+	u32 dom_id;
+};
+
+static int pick_task_domain_loopfn(u32 idx, void *data)
+{
+	struct pick_task_domain_loop_ctx *lctx = data;
+	u32 dom_id = (lctx->dom_rr_base + idx) % nr_doms;
+
+	if (dom_id >= MAX_DOMS)
+		return 1;
+
+	if (cpumask_intersects_domain(lctx->cpumask, dom_id)) {
+		lctx->dom_mask |= 1LLU << dom_id;
+		if (lctx->dom_id == MAX_DOMS)
+			lctx->dom_id = dom_id;
+	}
+	return 0;
+}
+
+static u32 pick_task_domain(struct task_ctx *task_ctx, struct task_struct *p,
+			    const struct cpumask *cpumask)
+{
+	struct pick_task_domain_loop_ctx lctx = {
+		.p = p,
+		.cpumask = cpumask,
+		.dom_id = MAX_DOMS,
+	};
+	s32 cpu = bpf_get_smp_processor_id();
+
+	if (cpu < 0 || cpu >= MAX_CPUS)
+		return MAX_DOMS;
+
+	lctx.dom_rr_base = ++(pcpu_ctx[cpu].dom_rr_cur);
+
+	bpf_loop(nr_doms, pick_task_domain_loopfn, &lctx, 0);
+	task_ctx->dom_mask = lctx.dom_mask;
+
+	return lctx.dom_id;
+}
+
+static void task_set_domain(struct task_ctx *task_ctx, struct task_struct *p,
+			    const struct cpumask *cpumask)
+{
+	u32 dom_id = 0;
+
+	if (nr_doms > 1)
+		dom_id = pick_task_domain(task_ctx, p, cpumask);
+
+	task_set_dq(task_ctx, p, dom_id);
+}
+
+void BPF_STRUCT_OPS(atropos_set_cpumask, struct task_struct *p,
+		    const struct cpumask *cpumask)
+{
+	pid_t pid = p->pid;
+	struct task_ctx *task_ctx = bpf_map_lookup_elem(&task_data, &pid);
+	if (!task_ctx) {
+		stat_add(ATROPOS_STAT_TASK_GET_ERR, 1);
+		return;
+	}
+
+	task_set_domain(task_ctx, p, cpumask);
+}
+
+s32 BPF_STRUCT_OPS(atropos_prep_enable, struct task_struct *p,
+		   struct scx_enable_args *args)
+{
+	struct bpf_cpumask *cpumask;
+	struct task_ctx task_ctx, *map_value;
+	long ret;
+	pid_t pid;
+
+	memset(&task_ctx, 0, sizeof(task_ctx));
+	task_ctx.weight = p->scx.weight;
+
+	pid = p->pid;
+	ret = bpf_map_update_elem(&task_data, &pid, &task_ctx, BPF_NOEXIST);
+	if (ret) {
+		stat_add(ATROPOS_STAT_TASK_GET_ERR, 1);
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
+	task_set_domain(map_value, p, p->cpus_ptr);
+
+	return 0;
+}
+
+void BPF_STRUCT_OPS(atropos_disable, struct task_struct *p)
+{
+	pid_t pid = p->pid;
+	long ret = bpf_map_delete_elem(&task_data, &pid);
+	if (ret) {
+		stat_add(ATROPOS_STAT_TASK_GET_ERR, 1);
+		return;
+	}
+}
+
+struct initialize_domain_loop_ctx {
+	struct bpf_cpumask *cpumask;
+	u32 dom_id;
+};
+
+static int set_cpumask_bit(u32 idx, void *data)
+{
+	struct initialize_domain_loop_ctx *lctx = data;
+	u32 dom_id = lctx->dom_id;
+	u64 mask = 1LLU << (idx % 64);
+	const volatile __u64 *dptr;
+
+	dptr = MEMBER_VPTR(dom_cpumasks, [dom_id][idx / 64]);
+	if (!dptr) {
+		scx_bpf_error("Failed to initialize cpu %u for dom %u", idx, dom_id);
+		return 1;
+	}
+
+	if ((*dptr & mask))
+		bpf_cpumask_set_cpu(idx, lctx->cpumask);
+	else
+		bpf_cpumask_clear_cpu(idx, lctx->cpumask);
+
+	return 0;
+}
+
+static int create_local_dsq(u32 idx, void *data)
+{
+	struct dom_cpumask entry, *v;
+	struct bpf_cpumask *cpumask;
+	struct initialize_domain_loop_ctx loop_ctx;
+	u32 dom_id = idx;
+	s64 ret;
+
+	ret = scx_bpf_create_dsq(dom_id, -1);
+	if (ret < 0) {
+		scx_bpf_error("Failed to create dsq %u (%d)", dom_id, ret);
+		return 1;
+	}
+
+	memset(&entry, 0, sizeof(entry));
+	ret = bpf_map_update_elem(&dom_cpumask_map, &dom_id, &entry, 0);
+	if (ret) {
+		scx_bpf_error("Failed to add dom_cpumask entry %u (%d)", dom_id, ret);
+		return 1;
+	}
+
+	v = bpf_map_lookup_elem(&dom_cpumask_map, &dom_id);
+	if (!v) {
+		/* Should never happen, we just inserted it above. */
+		scx_bpf_error("Failed to lookup dom element %u", dom_id);
+		return 1;
+	}
+
+	cpumask = bpf_cpumask_create();
+	if (!cpumask) {
+		scx_bpf_error("Failed to create BPF cpumask for domain %u", dom_id);
+		return 1;
+	}
+
+	loop_ctx.cpumask = cpumask;
+	loop_ctx.dom_id = dom_id;
+	if (bpf_loop(nr_cpus, set_cpumask_bit, &loop_ctx, 0) != nr_cpus) {
+		scx_bpf_error("Failed to initialize cpumask for domain %u", dom_id);
+		bpf_cpumask_release(cpumask);
+		return 1;
+	}
+
+	cpumask = bpf_kptr_xchg(&v->cpumask, cpumask);
+	if (cpumask) {
+		scx_bpf_error("Domain %u was already present", dom_id);
+		bpf_cpumask_release(cpumask);
+		return 1;
+	}
+
+	return 0;
+}
+
+int BPF_STRUCT_OPS_SLEEPABLE(atropos_init)
+{
+	u32 local_nr_doms = nr_doms;
+
+	bpf_printk("atropos init");
+
+	if (switch_all)
+		scx_bpf_switch_all();
+
+	// BPF verifier gets cranky if we don't bound this like so
+	if (local_nr_doms > MAX_DOMS)
+		local_nr_doms = MAX_DOMS;
+
+	bpf_loop(local_nr_doms, create_local_dsq, NULL, 0);
+
+	for (u32 i = 0; i < nr_cpus; ++i) {
+		pcpu_ctx[i].dom_rr_cur = i;
+	}
+
+	return 0;
+}
+
+void BPF_STRUCT_OPS(atropos_exit, struct scx_exit_info *ei)
+{
+	bpf_probe_read_kernel_str(exit_msg, sizeof(exit_msg), ei->msg);
+	exit_type = ei->type;
+}
+
+SEC(".struct_ops")
+struct sched_ext_ops atropos = {
+	.select_cpu = (void *)atropos_select_cpu,
+	.enqueue = (void *)atropos_enqueue,
+	.dispatch = (void *)atropos_dispatch,
+	.set_cpumask = (void *)atropos_set_cpumask,
+	.prep_enable = (void *)atropos_prep_enable,
+	.disable = (void *)atropos_disable,
+	.init = (void *)atropos_init,
+	.exit = (void *)atropos_exit,
+	.flags = 0,
+	.name = "atropos",
+};
diff --git a/tools/sched_ext/atropos/src/bpf/atropos.h b/tools/sched_ext/atropos/src/bpf/atropos.h
new file mode 100644
index 000000000000..921210ec2a3c
--- /dev/null
+++ b/tools/sched_ext/atropos/src/bpf/atropos.h
@@ -0,0 +1,44 @@
+// Copyright (c) Meta Platforms, Inc. and affiliates.
+
+// This software may be used and distributed according to the terms of the
+// GNU General Public License version 2.
+#ifndef __ATROPOS_H
+#define __ATROPOS_H
+
+#include <stdbool.h>
+#ifndef __kptr_ref
+#ifdef __KERNEL__
+#error "__kptr_ref not defined in the kernel"
+#endif
+#define __kptr_ref
+#endif
+
+#define	MAX_CPUS 512
+#define	MAX_DOMS 64 /* limited to avoid complex bitmask ops */
+#define	CACHELINE_SIZE 64
+
+/* Statistics */
+enum stat_idx {
+	ATROPOS_STAT_TASK_GET_ERR,
+	ATROPOS_STAT_TASK_GET_ERR_ENABLE,
+	ATROPOS_STAT_CPUMASK_ERR,
+	ATROPOS_STAT_WAKE_SYNC,
+	ATROPOS_STAT_PREV_IDLE,
+	ATROPOS_STAT_PINNED,
+	ATROPOS_STAT_DIRECT_DISPATCH,
+	ATROPOS_STAT_DSQ_DISPATCH,
+	ATROPOS_STAT_GREEDY,
+	ATROPOS_STAT_LOAD_BALANCE,
+	ATROPOS_STAT_LAST_TASK,
+	ATROPOS_NR_STATS,
+};
+
+struct task_ctx {
+	unsigned long long dom_mask; /* the domains this task can run on */
+	struct bpf_cpumask __kptr_ref *cpumask;
+	unsigned int dom_id;
+	unsigned int weight;
+	bool dispatch_local;
+};
+
+#endif /* __ATROPOS_H */
diff --git a/tools/sched_ext/atropos/src/main.rs b/tools/sched_ext/atropos/src/main.rs
new file mode 100644
index 000000000000..b9ae312a562f
--- /dev/null
+++ b/tools/sched_ext/atropos/src/main.rs
@@ -0,0 +1,648 @@
+// Copyright (c) Meta Platforms, Inc. and affiliates.
+
+// This software may be used and distributed according to the terms of the
+// GNU General Public License version 2.
+#![deny(clippy::all)]
+use std::collections::BTreeMap;
+use std::ffi::CStr;
+use std::sync::atomic::AtomicBool;
+use std::sync::atomic::Ordering;
+use std::sync::Arc;
+
+use ::fb_procfs as procfs;
+use anyhow::anyhow;
+use anyhow::bail;
+use anyhow::Context;
+use bitvec::prelude::*;
+use clap::Parser;
+
+mod util;
+
+oss_shim!();
+
+/// Atropos is a multi-domain BPF / userspace hybrid scheduler where the BPF
+/// part does simple round robin in each domain and the userspace part
+/// calculates the load factor of each domain and tells the BPF part how to load
+/// balance the domains.
+
+/// This scheduler demonstrates dividing scheduling logic between BPF and
+/// userspace and using rust to build the userspace part. An earlier variant of
+/// this scheduler was used to balance across six domains, each representing a
+/// chiplet in a six-chiplet AMD processor, and could match the performance of
+/// production setup using CFS.
+#[derive(Debug, Parser)]
+struct Opt {
+    /// Set the log level for more or less verbose output. --log_level=debug
+    /// will output libbpf verbose details
+    #[clap(short, long, default_value = "info")]
+    log_level: String,
+    /// Set the cpumask for a domain, provide multiple --cpumasks, one for each
+    /// domain. E.g. --cpumasks 0xff_00ff --cpumasks 0xff00 will create two
+    /// domains with the corresponding CPUs belonging to each domain. Each CPU
+    /// must belong to precisely one domain.
+    #[clap(short, long, required = true, min_values = 1)]
+    cpumasks: Vec<String>,
+    /// Switch all tasks to sched_ext. If not specified, only tasks which
+    /// have their scheduling policy set to SCHED_EXT using
+    /// sched_setscheduler(2) are switched.
+    #[clap(short, long, default_value = "false")]
+    all: bool,
+    /// Enable load balancing. Periodically userspace will calculate the load
+    /// factor of each domain and instruct BPF which processes to move.
+    #[clap(short, long, default_value = "true")]
+    load_balance: bool,
+    /// Enable greedy task stealing. When a domain is idle, a cpu will attempt
+    /// to steal tasks from a domain with at least greedy_threshold tasks
+    /// enqueued. These tasks aren't permanently stolen from the domain.
+    #[clap(short, long)]
+    greedy_threshold: Option<u64>,
+}
+
+type CpusetDqPair = (Vec<BitVec<u64, Lsb0>>, Vec<i32>);
+
+// Returns Vec of cpuset for each dq and a vec of dq for each cpu
+fn parse_cpusets(cpumasks: &[String]) -> anyhow::Result<CpusetDqPair> {
+    if cpumasks.len() > atropos_sys::MAX_DOMS as usize {
+        bail!(
+            "Number of requested DSQs ({}) is greater than MAX_DOMS ({})",
+            cpumasks.len(),
+            atropos_sys::MAX_DOMS
+        );
+    }
+    let num_cpus = libbpf_rs::num_possible_cpus()?;
+    if num_cpus > atropos_sys::MAX_CPUS as usize {
+        bail!(
+            "num_cpus ({}) is greater than MAX_CPUS ({})",
+            num_cpus,
+            atropos_sys::MAX_CPUS,
+        );
+    }
+    let mut cpus = vec![-1i32; num_cpus];
+    let mut cpusets = vec![bitvec![u64, Lsb0; 0; atropos_sys::MAX_CPUS as usize]; cpumasks.len()];
+    for (dq, cpumask) in cpumasks.iter().enumerate() {
+        let hex_str = {
+            let mut tmp_str = cpumask
+                .strip_prefix("0x")
+                .unwrap_or(cpumask)
+                .replace('_', "");
+            if tmp_str.len() % 2 != 0 {
+                tmp_str = "0".to_string() + &tmp_str;
+            }
+            tmp_str
+        };
+        let byte_vec = hex::decode(&hex_str)
+            .with_context(|| format!("Failed to parse cpumask: {}", cpumask))?;
+
+        for (index, &val) in byte_vec.iter().rev().enumerate() {
+            let mut v = val;
+            while v != 0 {
+                let lsb = v.trailing_zeros() as usize;
+                v &= !(1 << lsb);
+                let cpu = index * 8 + lsb;
+                if cpu > num_cpus {
+                    bail!(
+                        concat!(
+                            "Found cpu ({}) in cpumask ({}) which is larger",
+                            " than the number of cpus on the machine ({})"
+                        ),
+                        cpu,
+                        cpumask,
+                        num_cpus
+                    );
+                }
+                if cpus[cpu] != -1 {
+                    bail!(
+                        "Found cpu ({}) with dq ({}) but also in cpumask ({})",
+                        cpu,
+                        cpus[cpu],
+                        cpumask
+                    );
+                }
+                cpus[cpu] = dq as i32;
+                cpusets[dq].set(cpu, true);
+            }
+        }
+        cpusets[dq].set_uninitialized(false);
+    }
+
+    for (cpu, &dq) in cpus.iter().enumerate() {
+        if dq < 0 {
+            bail!(
+                "Cpu {} not assigned to any dq. Make sure it is covered by some --cpumasks argument.",
+                cpu
+            );
+        }
+    }
+
+    Ok((cpusets, cpus))
+}
+
+struct Sample {
+    total_cpu: procfs::CpuStat,
+}
+
+fn get_cpustats(reader: &mut procfs::ProcReader) -> anyhow::Result<Sample> {
+    let stat = reader.read_stat().context("Failed to read procfs")?;
+    Ok(Sample {
+        total_cpu: stat
+            .total_cpu
+            .ok_or_else(|| anyhow!("Could not read total cpu stat in proc"))?,
+    })
+}
+
+fn calculate_cpu_busy(prev: &procfs::CpuStat, next: &procfs::CpuStat) -> anyhow::Result<f64> {
+    match (prev, next) {
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
+                guest_usec: _,
+                guest_nice_usec: _,
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
+                guest_usec: _,
+                guest_nice_usec: _,
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
+            Ok(busy_usec as f64 / total_usec as f64)
+        }
+        _ => {
+            bail!("Some procfs stats are not populated!");
+        }
+    }
+}
+
+fn calculate_pid_busy(
+    prev: &procfs::PidStat,
+    next: &procfs::PidStat,
+    dur: std::time::Duration,
+) -> anyhow::Result<f64> {
+    match (
+        (prev.user_usecs, prev.system_usecs),
+        (next.user_usecs, prev.system_usecs),
+    ) {
+        ((Some(prev_user), Some(prev_system)), (Some(next_user), Some(next_system))) => {
+            if (next_user >= prev_user) && (next_system >= prev_system) {
+                let busy_usec = next_user + next_system - prev_user - prev_system;
+                Ok(busy_usec as f64 / dur.as_micros() as f64)
+            } else {
+                bail!("Pid usage values look wrong");
+            }
+        }
+        _ => {
+            bail!("Some procfs stats are not populated!");
+        }
+    }
+}
+
+struct PidInfo {
+    pub pid: i32,
+    pub dom: u32,
+    pub dom_mask: u64,
+}
+
+struct LoadInfo {
+    pids_by_milliload: BTreeMap<u64, PidInfo>,
+    pid_stats: BTreeMap<i32, procfs::PidStat>,
+    global_load_sum: f64,
+    dom_load: Vec<f64>,
+}
+
+// We calculate the load for each task and then each dom by enumerating all the
+// tasks in task_data and calculating their CPU util from procfs.
+
+// Given procfs reader, task data map, and pidstat from previous calculation,
+// return:
+//  * a sorted map from milliload -> pid_data,
+//  * a map from pid -> pidstat
+//  * a vec of per-dom looads
+fn calculate_load(
+    proc_reader: &procfs::ProcReader,
+    task_data: &libbpf_rs::Map,
+    interval: std::time::Duration,
+    prev_pid_stat: &BTreeMap<i32, procfs::PidStat>,
+    nr_doms: usize,
+) -> anyhow::Result<LoadInfo> {
+    let mut ret = LoadInfo {
+        pids_by_milliload: BTreeMap::new(),
+        pid_stats: BTreeMap::new(),
+        global_load_sum: 0f64,
+        dom_load: vec![0f64; nr_doms],
+    };
+    for key in task_data.keys() {
+        if let Some(task_ctx_vec) = task_data
+            .lookup(&key, libbpf_rs::MapFlags::ANY)
+            .context("Failed to lookup task_data")?
+        {
+            let task_ctx =
+                unsafe { &*(task_ctx_vec.as_slice().as_ptr() as *const atropos_sys::task_ctx) };
+            let pid = i32::from_ne_bytes(
+                key.as_slice()
+                    .try_into()
+                    .context("Invalid key length in task_data map")?,
+            );
+            match proc_reader.read_tid_stat(pid as u32) {
+                Ok(stat) => {
+                    ret.pid_stats.insert(pid, stat);
+                }
+                Err(procfs::Error::IoError(_, ref e))
+                    if e.raw_os_error()
+                        .map_or(false, |ec| ec == 2 || ec == 3 /* ENOENT or ESRCH */) =>
+                {
+                    continue;
+                }
+                Err(e) => {
+                    bail!(e);
+                }
+            }
+            let pid_load = match (prev_pid_stat.get(&pid), ret.pid_stats.get(&pid)) {
+                (Some(prev_pid_stat), Some(next_pid_stat)) => {
+                    calculate_pid_busy(prev_pid_stat, next_pid_stat, interval)?
+                }
+                // If we don't have any utilization #s for the process, just skip it
+                _ => {
+                    continue;
+                }
+            } * task_ctx.weight as f64;
+            if !pid_load.is_finite() || pid_load <= 0.0 {
+                continue;
+            }
+            ret.global_load_sum += pid_load;
+            ret.dom_load[task_ctx.dom_id as usize] += pid_load;
+            // Only record pids that are eligible for load balancing
+            if task_ctx.dom_mask == (1u64 << task_ctx.dom_id) {
+                continue;
+            }
+            ret.pids_by_milliload.insert(
+                (pid_load * 1000.0) as u64,
+                PidInfo {
+                    pid,
+                    dom: task_ctx.dom_id,
+                    dom_mask: task_ctx.dom_mask,
+                },
+            );
+        }
+    }
+    Ok(ret)
+}
+
+#[derive(Copy, Clone, Default)]
+struct DomLoadBalanceInfo {
+    load_to_pull: f64,
+    load_to_give: f64,
+}
+
+#[derive(Default)]
+struct LoadBalanceInfo {
+    doms: Vec<DomLoadBalanceInfo>,
+    doms_with_load_to_pull: BTreeMap<u32, f64>,
+    doms_with_load_to_give: BTreeMap<u32, f64>,
+}
+
+// To balance dom loads we identify doms with lower and higher load than average
+fn calculate_dom_load_balance(global_load_avg: f64, dom_load: &[f64]) -> LoadBalanceInfo {
+    let mut ret = LoadBalanceInfo::default();
+    ret.doms.resize(dom_load.len(), Default::default());
+
+    const LOAD_IMBAL_HIGH_PCT: f64 = 0.10;
+    const LOAD_IMBAL_MAX_ADJ_PCT: f64 = 0.10;
+    let high = global_load_avg * LOAD_IMBAL_HIGH_PCT;
+    let adj_max = global_load_avg * LOAD_IMBAL_MAX_ADJ_PCT;
+
+    for (dom, dom_load) in dom_load.iter().enumerate() {
+        let mut imbal = dom_load - global_load_avg;
+
+        let mut dom_load_to_pull = 0f64;
+        let mut dom_load_to_give = 0f64;
+        if imbal >= 0f64 {
+            dom_load_to_give = imbal;
+        } else {
+            imbal = -imbal;
+            if imbal > high {
+                dom_load_to_pull = f64::min(imbal, adj_max);
+            }
+        }
+        ret.doms[dom].load_to_pull = dom_load_to_pull;
+        ret.doms[dom].load_to_give = dom_load_to_give;
+        if dom_load_to_pull > 0f64 {
+            ret.doms_with_load_to_pull
+                .insert(dom as u32, dom_load_to_pull);
+        }
+        if dom_load_to_give > 0f64 {
+            ret.doms_with_load_to_give
+                .insert(dom as u32, dom_load_to_give);
+        }
+    }
+    ret
+}
+
+fn clear_map(map: &mut libbpf_rs::Map) {
+    // XXX: libbpf_rs has some design flaw that make it impossible to
+    // delete while iterating despite it being safe so we alias it here
+    let deleter: &mut libbpf_rs::Map = unsafe { &mut *(map as *mut _) };
+    for key in map.keys() {
+        let _ = deleter.delete(&key);
+    }
+}
+
+// Actually execute the load balancing. Concretely this writes pid -> dom
+// entries into the lb_data map for bpf side to consume.
+//
+// The logic here is simple, greedily balance the heaviest load processes until
+// either we have no doms with load to give or no doms with load to pull.
+fn load_balance(
+    global_load_avg: f64,
+    lb_data: &mut libbpf_rs::Map,
+    pids_by_milliload: &BTreeMap<u64, PidInfo>,
+    mut doms_with_load_to_pull: BTreeMap<u32, f64>,
+    mut doms_with_load_to_give: BTreeMap<u32, f64>,
+) -> anyhow::Result<()> {
+    clear_map(lb_data);
+    const LOAD_IMBAL_MIN_ADJ_PCT: f64 = 0.01;
+    let adj_min = global_load_avg * LOAD_IMBAL_MIN_ADJ_PCT;
+    for (pid_milliload, pidinfo) in pids_by_milliload.iter().rev() {
+        if doms_with_load_to_give.is_empty() || doms_with_load_to_pull.is_empty() {
+            break;
+        }
+
+        let pid_load = *pid_milliload as f64 / 1000f64;
+        let mut remove_to_give = None;
+        let mut remove_to_pull = None;
+        if let Some(dom_imbal) = doms_with_load_to_give.get_mut(&pidinfo.dom) {
+            if *dom_imbal < pid_load {
+                continue;
+            }
+
+            for (new_dom, new_dom_imbal) in doms_with_load_to_pull.iter_mut() {
+                if (pidinfo.dom_mask & (1 << new_dom)) == 0 || *new_dom_imbal < pid_load {
+                    continue;
+                }
+
+                *dom_imbal -= pid_load;
+                if *dom_imbal <= adj_min {
+                    remove_to_give = Some(pidinfo.dom);
+                }
+                *new_dom_imbal -= pid_load;
+                if *new_dom_imbal <= adj_min {
+                    remove_to_pull = Some(pidinfo.dom);
+                }
+
+                lb_data
+                    .update(
+                        &(pidinfo.pid as libc::pid_t).to_ne_bytes(),
+                        &new_dom.to_ne_bytes(),
+                        libbpf_rs::MapFlags::NO_EXIST,
+                    )
+                    .context("Failed to update lb_data")?;
+                break;
+            }
+        }
+
+        remove_to_give.map(|dom| doms_with_load_to_give.remove(&dom));
+        remove_to_pull.map(|dom| doms_with_load_to_pull.remove(&dom));
+    }
+    Ok(())
+}
+
+fn print_stats(
+    logger: slog::Logger,
+    stats_map: &mut libbpf_rs::Map,
+    nr_doms: usize,
+    nr_cpus: usize,
+    cpu_busy: f64,
+    global_load_avg: f64,
+    dom_load: &[f64],
+    dom_lb_info: &[DomLoadBalanceInfo],
+) -> anyhow::Result<()> {
+    let stats = {
+        let mut stats: Vec<u64> = Vec::new();
+        let zero_vec = vec![vec![0u8; stats_map.value_size() as usize]; nr_cpus];
+        for stat in 0..atropos_sys::stat_idx_ATROPOS_NR_STATS {
+            let cpu_stat_vec = stats_map
+                .lookup_percpu(&(stat as u32).to_ne_bytes(), libbpf_rs::MapFlags::ANY)
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
+                .update_percpu(
+                    &(stat as u32).to_ne_bytes(),
+                    &zero_vec,
+                    libbpf_rs::MapFlags::ANY,
+                )
+                .context("Failed to zero stat")?;
+            stats.push(sum);
+        }
+        stats
+    };
+    let mut total = 0;
+    total += stats[atropos_sys::stat_idx_ATROPOS_STAT_WAKE_SYNC as usize];
+    total += stats[atropos_sys::stat_idx_ATROPOS_STAT_PREV_IDLE as usize];
+    total += stats[atropos_sys::stat_idx_ATROPOS_STAT_PINNED as usize];
+    total += stats[atropos_sys::stat_idx_ATROPOS_STAT_DIRECT_DISPATCH as usize];
+    total += stats[atropos_sys::stat_idx_ATROPOS_STAT_DSQ_DISPATCH as usize];
+    total += stats[atropos_sys::stat_idx_ATROPOS_STAT_GREEDY as usize];
+    total += stats[atropos_sys::stat_idx_ATROPOS_STAT_LAST_TASK as usize];
+    slog::info!(logger, "cpu={:5.1}", cpu_busy * 100.0);
+    slog::info!(
+        logger,
+        "task_get_errs: {}, cpumask_errs: {}",
+        stats[atropos_sys::stat_idx_ATROPOS_STAT_TASK_GET_ERR as usize],
+        stats[atropos_sys::stat_idx_ATROPOS_STAT_CPUMASK_ERR as usize],
+    );
+    slog::info!(
+        logger,
+        "tot={:6} wake_sync={:4.1},prev_idle={:4.1},pinned={:4.1},direct={:4.1},dq={:4.1},greedy={:4.1}",
+        total,
+        stats[atropos_sys::stat_idx_ATROPOS_STAT_WAKE_SYNC as usize] as f64 / total as f64 * 100f64,
+        stats[atropos_sys::stat_idx_ATROPOS_STAT_PREV_IDLE as usize] as f64 / total as f64 * 100f64,
+        stats[atropos_sys::stat_idx_ATROPOS_STAT_PINNED as usize] as f64 / total as f64 * 100f64,
+        stats[atropos_sys::stat_idx_ATROPOS_STAT_DIRECT_DISPATCH as usize] as f64 / total as f64
+            * 100f64,
+        stats[atropos_sys::stat_idx_ATROPOS_STAT_DSQ_DISPATCH as usize] as f64 / total as f64
+            * 100f64,
+        stats[atropos_sys::stat_idx_ATROPOS_STAT_GREEDY as usize] as f64 / total as f64 * 100f64,
+    );
+
+    slog::info!(
+        logger,
+        "load_avg:{:.1}, load_balances={}",
+        global_load_avg,
+        stats[atropos_sys::stat_idx_ATROPOS_STAT_LOAD_BALANCE as usize]
+    );
+    for i in 0..nr_doms {
+        slog::info!(logger, "DOM[{:02}]", i);
+        slog::info!(
+            logger,
+            " load={:.1} to_pull={:.1},to_give={:.1}",
+            dom_load[i],
+            dom_lb_info[i].load_to_pull,
+            dom_lb_info[i].load_to_give,
+        );
+    }
+    Ok(())
+}
+
+pub fn run(
+    logger: slog::Logger,
+    debug: bool,
+    cpumasks: Vec<String>,
+    switch_all: bool,
+    balance_load: bool,
+    greedy_threshold: Option<u64>,
+) -> anyhow::Result<()> {
+    slog::info!(logger, "Atropos Scheduler Initialized");
+    let mut skel_builder = AtroposSkelBuilder::default();
+    skel_builder.obj_builder.debug(debug);
+    let mut skel = skel_builder.open().context("Failed to open BPF program")?;
+
+    let (cpusets, cpus) = parse_cpusets(&cpumasks)?;
+    let nr_doms = cpusets.len();
+    let nr_cpus = libbpf_rs::num_possible_cpus()?;
+    skel.rodata().nr_doms = nr_doms as u32;
+    skel.rodata().nr_cpus = nr_cpus as u32;
+
+    for (cpu, dom) in cpus.iter().enumerate() {
+        skel.rodata().cpu_dom_id_map[cpu] = *dom as u32;
+    }
+
+    for (dom, cpuset) in cpusets.iter().enumerate() {
+        let raw_cpuset_slice = cpuset.as_raw_slice();
+        let dom_cpumask_slice = &mut skel.rodata().dom_cpumasks[dom];
+        let (left, _) = dom_cpumask_slice.split_at_mut(raw_cpuset_slice.len());
+        left.clone_from_slice(cpuset.as_raw_slice());
+        slog::info!(logger, "dom {} cpumask {:X?}", dom, dom_cpumask_slice);
+    }
+
+    skel.rodata().switch_all = switch_all;
+
+    if let Some(greedy) = greedy_threshold {
+        skel.rodata().greedy_threshold = greedy;
+    }
+
+    let mut skel = skel.load().context("Failed to load BPF program")?;
+    skel.attach().context("Failed to attach BPF program")?;
+
+    let _structops = skel
+        .maps_mut()
+        .atropos()
+        .attach_struct_ops()
+        .context("Failed to attach atropos struct ops")?;
+    slog::info!(logger, "Atropos Scheduler Attached");
+    let shutdown = Arc::new(AtomicBool::new(false));
+    let shutdown_clone = shutdown.clone();
+    ctrlc::set_handler(move || {
+        shutdown_clone.store(true, Ordering::Relaxed);
+    })
+    .context("Error setting Ctrl-C handler")?;
+
+    let mut proc_reader = procfs::ProcReader::new();
+    let mut prev_sample = get_cpustats(&mut proc_reader)?;
+    let mut prev_pid_stat: BTreeMap<i32, procfs::PidStat> = BTreeMap::new();
+    while !shutdown.load(Ordering::Relaxed)
+        && unsafe { std::ptr::read_volatile(&skel.bss().exit_type as *const _) } == 0
+    {
+        let interval = std::time::Duration::from_secs(1);
+        std::thread::sleep(interval);
+        let now = std::time::SystemTime::now();
+        let next_sample = get_cpustats(&mut proc_reader)?;
+        let cpu_busy = calculate_cpu_busy(&prev_sample.total_cpu, &next_sample.total_cpu)?;
+        prev_sample = next_sample;
+        let load_info = calculate_load(
+            &proc_reader,
+            skel.maps().task_data(),
+            interval,
+            &prev_pid_stat,
+            nr_doms,
+        )?;
+        prev_pid_stat = load_info.pid_stats;
+
+        let global_load_avg = load_info.global_load_sum / nr_doms as f64;
+        let mut lb_info = calculate_dom_load_balance(global_load_avg, &load_info.dom_load);
+
+        let doms_with_load_to_pull = std::mem::take(&mut lb_info.doms_with_load_to_pull);
+        let doms_with_load_to_give = std::mem::take(&mut lb_info.doms_with_load_to_give);
+        if balance_load {
+            load_balance(
+                global_load_avg,
+                skel.maps_mut().lb_data(),
+                &load_info.pids_by_milliload,
+                doms_with_load_to_pull,
+                doms_with_load_to_give,
+            )?;
+            slog::info!(
+                logger,
+                "Load balancing took {:?}",
+                now.elapsed().context("Getting a duration failed")?
+            );
+        }
+        print_stats(
+            logger.clone(),
+            skel.maps_mut().stats(),
+            nr_doms,
+            nr_cpus,
+            cpu_busy,
+            global_load_avg,
+            &load_info.dom_load,
+            &lb_info.doms,
+        )?;
+    }
+    /* Report msg if EXT_OPS_EXIT_ERROR */
+    if skel.bss().exit_type == 2 {
+        let exit_msg_cstr = unsafe { CStr::from_ptr(skel.bss().exit_msg.as_ptr() as *const _) };
+        let exit_msg = exit_msg_cstr
+            .to_str()
+            .context("Failed to convert exit msg to string")?;
+        eprintln!("exit_type={} msg={}", skel.bss().exit_type, exit_msg);
+    }
+    Ok(())
+}
+
+fn main() -> anyhow::Result<()> {
+    let opts = Opt::parse();
+    let logger = setup_logger(&opts.log_level)?;
+    let debug = opts.log_level == "debug";
+
+    run(
+        logger,
+        debug,
+        opts.cpumasks,
+        opts.all,
+        opts.load_balance,
+        opts.greedy_threshold,
+    )
+}
diff --git a/tools/sched_ext/atropos/src/oss/atropos_sys.rs b/tools/sched_ext/atropos/src/oss/atropos_sys.rs
new file mode 100644
index 000000000000..bbeaf856d40e
--- /dev/null
+++ b/tools/sched_ext/atropos/src/oss/atropos_sys.rs
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
+include!(concat!(env!("OUT_DIR"), "/atropos-sys.rs"));
diff --git a/tools/sched_ext/atropos/src/oss/mod.rs b/tools/sched_ext/atropos/src/oss/mod.rs
new file mode 100644
index 000000000000..5afcf35f777d
--- /dev/null
+++ b/tools/sched_ext/atropos/src/oss/mod.rs
@@ -0,0 +1,29 @@
+// Copyright (c) Meta Platforms, Inc. and affiliates.
+
+// This software may be used and distributed according to the terms of the
+// GNU General Public License version 2.
+#[path = "../bpf/.output/atropos.skel.rs"]
+mod atropos;
+use std::str::FromStr;
+
+use anyhow::bail;
+pub use atropos::*;
+use slog::o;
+use slog::Drain;
+use slog::Level;
+
+pub mod atropos_sys;
+
+pub fn setup_logger(level: &str) -> anyhow::Result<slog::Logger> {
+    let log_level = match Level::from_str(level) {
+        Ok(l) => l,
+        Err(()) => bail!("Failed to parse \"{}\" as a log level", level),
+    };
+    let decorator = slog_term::TermDecorator::new().build();
+    let drain = slog_term::FullFormat::new(decorator).build().fuse();
+    let drain = slog_async::Async::new(drain)
+        .build()
+        .filter_level(log_level)
+        .fuse();
+    Ok(slog::Logger::root(drain, o!()))
+}
diff --git a/tools/sched_ext/atropos/src/util.rs b/tools/sched_ext/atropos/src/util.rs
new file mode 100644
index 000000000000..eae414c0919a
--- /dev/null
+++ b/tools/sched_ext/atropos/src/util.rs
@@ -0,0 +1,24 @@
+// Copyright (c) Meta Platforms, Inc. and affiliates.
+
+// This software may be used and distributed according to the terms of the
+// GNU General Public License version 2.
+
+// Shim between facebook types and open source types.
+//
+// The type interfaces and module hierarchy should be identical on
+// both "branches". And since we glob import, all the submodules in
+// this crate will inherit our name bindings and can use generic paths,
+// eg `crate::logging::setup(..)`.
+#[macro_export]
+macro_rules! oss_shim {
+    () => {
+        #[cfg(fbcode_build)]
+        mod facebook;
+        #[cfg(fbcode_build)]
+        use facebook::*;
+        #[cfg(not(fbcode_build))]
+        mod oss;
+        #[cfg(not(fbcode_build))]
+        use oss::*;
+    };
+}
-- 
2.39.1

