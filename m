Return-Path: <bpf+bounces-14848-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19C067E889A
	for <lists+bpf@lfdr.de>; Sat, 11 Nov 2023 03:50:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D3841C20AC7
	for <lists+bpf@lfdr.de>; Sat, 11 Nov 2023 02:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E8614414;
	Sat, 11 Nov 2023 02:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PiYJ32Ab"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459CF53B1
	for <bpf@vger.kernel.org>; Sat, 11 Nov 2023 02:50:45 +0000 (UTC)
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 747AB46AF;
	Fri, 10 Nov 2023 18:50:07 -0800 (PST)
Received: by mail-il1-x132.google.com with SMTP id e9e14a558f8ab-3592fadbd7eso10204715ab.0;
        Fri, 10 Nov 2023 18:50:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699671007; x=1700275807; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=et9VEo0AAxPogrUw4++2h31/Qd/i4Y1LXtoGl8MHdpY=;
        b=PiYJ32AbIjSNRVXD47vy8fkr5dKU3qvohYWboujV80P9GXrivr0RMcHOXWEqR3X3vs
         5w6/6R0M26HB27XCuz9/umvO0e/Y1Xj49edQ2fMt7UaFl2W8koGicqt95Ei33gbZ8KKj
         7mOfmXYkwVe+rZ0tbGA1Wn2e0ZiyVxoOu/IPQ5bkYUUzcMeOmMqMOTzVM9qNha7cJUl/
         bLaXbfNuENf30e8pI9wlBqARTQAHWWy79HL6cTjjHukPS63Q4C1Rb4z0DgDUXsXEdQ4n
         dKwSChLRJu3c+031hhaXkrK0N4cV5/LiiIpjjXtpK4gOiAzBQJd8OYxdtMQiToG/qYFO
         UxCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699671007; x=1700275807;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=et9VEo0AAxPogrUw4++2h31/Qd/i4Y1LXtoGl8MHdpY=;
        b=Xb4bKLrtp7M6u9kC7Csr1JOpQhvBfrsT9KSU6cHd5A6UIKMUd8Ccd+EDiXF1J+K9mf
         7kESACjiaep+KZedxfUx3fpBww546ceYFicYKVX5jv5yYQNZtEWt25FKPEsT62ZITaZr
         xOBg4/Fqm0ynDR2/vwqgquwEVHneVmD8nu81D8ogErVSUHRGf/u3DIq2OQbDCn3DjP78
         TdCc4itLe0BihCNchO7+2N45I2PlQWmhG1ShMdbrlDS6DU7chgZ47RkcQSy83VLgolXI
         QB/hBx0Qn+GH7+hP2KC2L+h8tmsHY3KO3tDUqLLNHLg/ZeG6ZHzp0PUqStehxWQeStWw
         xG7g==
X-Gm-Message-State: AOJu0Yx73mFeJdBWsNE+o8iUZbibfWFub7ZuGvhL90eaGbDO9pgwFgeA
	hXoGxQoT+c+DPdUg1dv/Dek=
X-Google-Smtp-Source: AGHT+IEfVUzARDVR1EllVB+5y5DuU7TSyMEUW5lNsS4p890X1rLOw3OUVsTUWVjXZEnrOBWzHlPaeg==
X-Received: by 2002:a05:6e02:1c4d:b0:359:445:8469 with SMTP id d13-20020a056e021c4d00b0035904458469mr1652634ilg.22.1699671006050;
        Fri, 10 Nov 2023 18:50:06 -0800 (PST)
Received: from localhost ([2620:10d:c090:400::4:7384])
        by smtp.gmail.com with ESMTPSA id u6-20020a170902e5c600b001ca21e05c69sm353899plf.109.2023.11.10.18.50.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Nov 2023 18:50:05 -0800 (PST)
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
Subject: [PATCH 36/36] sched_ext: Add scx_layered, a highly configurable multi-layer scheduler
Date: Fri, 10 Nov 2023 16:48:02 -1000
Message-ID: <20231111024835.2164816-37-tj@kernel.org>
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

scx_layered allows classifying tasks into multiple layers and applying
different scheduling policies to them. The configuration is specified in
json and composed of two parts - matches and policies.

The matches classify tasks into a layer and different scheduling policies
can be applied to the layer. For example, if a layer is "Confined", its
tasks are confined to the CPUs that are allocated to the layer. The CPU
allocation is dynamically adjusted to target CPU utilization in a specific
range. This can be used to e.g. confine managerial workloads to a small
number of CPUs while leaving the rest for latency sensitive workloads. A
layer can also be configured to preempt other non-preempting layers.

This scheduler is limited in that it assumes homogenous CPUs in a single
node and the load based CPU allocation limit doesn't work well yet. However,
even in the current form, in an experimental deployment over ~1000 machines,
it showed a significant (>5%) bandwidth gain with a large-scale latency
sensitive workload.

As sched_ext scheduler development style and cadence are different from
kernel proper, the plan is to keep simpler example schedulers and one more
generic scheduler (scx_rusty) in tree and publish others in a separate
repository. This scheduler will be a part of that repo once ready.

NOT_FOR_UPSTREAM_INCLUSION
---
 tools/sched_ext/Makefile                      |    2 +-
 tools/sched_ext/scx_layered/.gitignore        |    3 +
 tools/sched_ext/scx_layered/Cargo.toml        |   30 +
 tools/sched_ext/scx_layered/build.rs          |   77 +
 tools/sched_ext/scx_layered/rustfmt.toml      |    8 +
 .../scx_layered/src/bpf/layered.bpf.c         |  974 ++++++++++
 tools/sched_ext/scx_layered/src/bpf/layered.h |  100 +
 .../sched_ext/scx_layered/src/bpf/util.bpf.c  |   68 +
 .../sched_ext/scx_layered/src/layered_sys.rs  |   10 +
 tools/sched_ext/scx_layered/src/main.rs       | 1641 +++++++++++++++++
 10 files changed, 2912 insertions(+), 1 deletion(-)
 create mode 100644 tools/sched_ext/scx_layered/.gitignore
 create mode 100644 tools/sched_ext/scx_layered/Cargo.toml
 create mode 100644 tools/sched_ext/scx_layered/build.rs
 create mode 100644 tools/sched_ext/scx_layered/rustfmt.toml
 create mode 100644 tools/sched_ext/scx_layered/src/bpf/layered.bpf.c
 create mode 100644 tools/sched_ext/scx_layered/src/bpf/layered.h
 create mode 100644 tools/sched_ext/scx_layered/src/bpf/util.bpf.c
 create mode 100644 tools/sched_ext/scx_layered/src/layered_sys.rs
 create mode 100644 tools/sched_ext/scx_layered/src/main.rs

diff --git a/tools/sched_ext/Makefile b/tools/sched_ext/Makefile
index f72e3be99f5c..94985639b299 100644
--- a/tools/sched_ext/Makefile
+++ b/tools/sched_ext/Makefile
@@ -201,7 +201,7 @@ $(c-sched-targets): %: $(BINDIR)/%
 ###################
 # Rust schedulers #
 ###################
-rust-sched-targets := scx_rusty
+rust-sched-targets := scx_rusty scx_layered
 
 # Separate build target that is available for build systems to use to fetch
 # dependencies in a separate step from building. This allows the scheduler
diff --git a/tools/sched_ext/scx_layered/.gitignore b/tools/sched_ext/scx_layered/.gitignore
new file mode 100644
index 000000000000..186dba259ec2
--- /dev/null
+++ b/tools/sched_ext/scx_layered/.gitignore
@@ -0,0 +1,3 @@
+src/bpf/.output
+Cargo.lock
+target
diff --git a/tools/sched_ext/scx_layered/Cargo.toml b/tools/sched_ext/scx_layered/Cargo.toml
new file mode 100644
index 000000000000..6ba1b98d25cd
--- /dev/null
+++ b/tools/sched_ext/scx_layered/Cargo.toml
@@ -0,0 +1,30 @@
+[package]
+name = "scx_layered"
+version = "0.0.1"
+authors = ["Tejun Heo <htejun@meta.com>", "Meta"]
+edition = "2021"
+description = "Userspace scheduling with BPF for Ads"
+license = "GPL-2.0-only"
+
+[dependencies]
+anyhow = "1.0"
+bitvec = "1.0"
+clap = { version = "4.1", features = ["derive", "env", "unicode", "wrap_help"] }
+ctrlc = { version = "3.1", features = ["termination"] }
+fb_procfs = "0.7"
+lazy_static = "1.4"
+libbpf-rs = "0.21"
+libbpf-sys = { version = "1.2.0", features = ["novendor", "static"] }
+libc = "0.2"
+log = "0.4"
+serde = { version = "1.0", features = ["derive"] }
+serde_json = "1.0"
+simplelog = "0.12"
+
+[build-dependencies]
+bindgen = { version = "0.61" }
+libbpf-cargo = "0.21"
+glob = "0.3"
+
+[features]
+enable_backtrace = []
diff --git a/tools/sched_ext/scx_layered/build.rs b/tools/sched_ext/scx_layered/build.rs
new file mode 100644
index 000000000000..ea0bbd48af82
--- /dev/null
+++ b/tools/sched_ext/scx_layered/build.rs
@@ -0,0 +1,77 @@
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
+use glob::glob;
+use libbpf_cargo::SkeletonBuilder;
+
+const HEADER_PATH: &str = "src/bpf/layered.h";
+
+fn bindgen_layered() {
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
+        .write_to_file(out_path.join("layered_sys.rs"))
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
+
+    // Trigger rebuild if any .[hc] files are changed in the directory.
+    for path in glob("./src/bpf/*.[hc]").unwrap().filter_map(Result::ok) {
+        println!("cargo:rerun-if-changed={}", path.to_str().unwrap());
+    }
+}
+
+fn main() {
+    bindgen_layered();
+    // It's unfortunate we cannot use `OUT_DIR` to store the generated skeleton.
+    // Reasons are because the generated skeleton contains compiler attributes
+    // that cannot be `include!()`ed via macro. And we cannot use the `#[path = "..."]`
+    // trick either because you cannot yet `concat!(env!("OUT_DIR"), "/skel.rs")` inside
+    // the path attribute either (see https://github.com/rust-lang/rust/pull/83366).
+    //
+    // However, there is hope! When the above feature stabilizes we can clean this
+    // all up.
+    create_dir_all("./src/bpf/.output").unwrap();
+    gen_bpf_sched("layered");
+}
diff --git a/tools/sched_ext/scx_layered/rustfmt.toml b/tools/sched_ext/scx_layered/rustfmt.toml
new file mode 100644
index 000000000000..b7258ed0a8d8
--- /dev/null
+++ b/tools/sched_ext/scx_layered/rustfmt.toml
@@ -0,0 +1,8 @@
+# Get help on options with `rustfmt --help=config`
+# Please keep these in alphabetical order.
+edition = "2021"
+group_imports = "StdExternalCrate"
+imports_granularity = "Item"
+merge_derives = false
+use_field_init_shorthand = true
+version = "Two"
diff --git a/tools/sched_ext/scx_layered/src/bpf/layered.bpf.c b/tools/sched_ext/scx_layered/src/bpf/layered.bpf.c
new file mode 100644
index 000000000000..b0a27f3c7137
--- /dev/null
+++ b/tools/sched_ext/scx_layered/src/bpf/layered.bpf.c
@@ -0,0 +1,974 @@
+/* Copyright (c) Meta Platforms, Inc. and affiliates. */
+#include "../../../scx_common.bpf.h"
+#include "layered.h"
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
+const volatile u32 debug = 0;
+const volatile u64 slice_ns = SCX_SLICE_DFL;
+const volatile u32 nr_possible_cpus = 1;
+const volatile u32 nr_layers = 1;
+const volatile bool smt_enabled = true;
+const volatile unsigned char all_cpus[MAX_CPUS_U8];
+
+private(all_cpumask) struct bpf_cpumask __kptr *all_cpumask;
+struct layer layers[MAX_LAYERS];
+u32 fallback_cpu;
+static u32 preempt_cursor;
+
+#define dbg(fmt, args...)	do { if (debug) bpf_printk(fmt, ##args); } while (0)
+#define trace(fmt, args...)	do { if (debug > 1) bpf_printk(fmt, ##args); } while (0)
+
+#include "util.bpf.c"
+#include "../../../ravg_impl.bpf.h"
+
+struct user_exit_info uei;
+
+static inline bool vtime_before(u64 a, u64 b)
+{
+	return (s64)(a - b) < 0;
+}
+
+struct {
+	__uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
+	__type(key, u32);
+	__type(value, struct cpu_ctx);
+	__uint(max_entries, 1);
+} cpu_ctxs SEC(".maps");
+
+static struct cpu_ctx *lookup_cpu_ctx(int cpu)
+{
+	struct cpu_ctx *cctx;
+	u32 zero = 0;
+
+	if (cpu < 0)
+		cctx = bpf_map_lookup_elem(&cpu_ctxs, &zero);
+	else
+		cctx = bpf_map_lookup_percpu_elem(&cpu_ctxs, &zero, cpu);
+
+	if (!cctx) {
+		scx_bpf_error("no cpu_ctx for cpu %d", cpu);
+		return NULL;
+	}
+
+	return cctx;
+}
+
+static void gstat_inc(enum global_stat_idx idx, struct cpu_ctx *cctx)
+{
+	if (idx < 0 || idx >= NR_GSTATS) {
+		scx_bpf_error("invalid global stat idx %d", idx);
+		return;
+	}
+
+	cctx->gstats[idx]++;
+}
+
+static void lstat_inc(enum layer_stat_idx idx, struct layer *layer, struct cpu_ctx *cctx)
+{
+	u64 *vptr;
+
+	if ((vptr = MEMBER_VPTR(*cctx, .lstats[layer->idx][idx])))
+		(*vptr)++;
+	else
+		scx_bpf_error("invalid layer or stat idxs: %d, %d", idx, layer->idx);
+}
+
+struct lock_wrapper {
+	struct bpf_spin_lock	lock;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__type(key, u32);
+	__type(value, struct lock_wrapper);
+	__uint(max_entries, MAX_LAYERS);
+	__uint(map_flags, 0);
+} layer_load_locks SEC(".maps");
+
+static void adj_load(u32 layer_idx, s64 adj, u64 now)
+{
+	struct layer *layer;
+	struct lock_wrapper *lockw;
+
+	layer = MEMBER_VPTR(layers, [layer_idx]);
+	lockw = bpf_map_lookup_elem(&layer_load_locks, &layer_idx);
+
+	if (!layer || !lockw) {
+		scx_bpf_error("Can't access layer%d or its load_lock", layer_idx);
+		return;
+	}
+
+	bpf_spin_lock(&lockw->lock);
+	layer->load += adj;
+	ravg_accumulate(&layer->load_rd, layer->load, now, USAGE_HALF_LIFE);
+	bpf_spin_unlock(&lockw->lock);
+
+	if (debug && adj < 0 && (s64)layer->load < 0)
+		scx_bpf_error("cpu%d layer%d load underflow (load=%lld adj=%lld)",
+			      bpf_get_smp_processor_id(), layer_idx, layer->load, adj);
+}
+
+struct layer_cpumask_wrapper {
+	struct bpf_cpumask __kptr *cpumask;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__type(key, u32);
+	__type(value, struct layer_cpumask_wrapper);
+	__uint(max_entries, MAX_LAYERS);
+	__uint(map_flags, 0);
+} layer_cpumasks SEC(".maps");
+
+static struct cpumask *lookup_layer_cpumask(int idx)
+{
+	struct layer_cpumask_wrapper *cpumaskw;
+
+	if ((cpumaskw = bpf_map_lookup_elem(&layer_cpumasks, &idx))) {
+		return (struct cpumask *)cpumaskw->cpumask;
+	} else {
+		scx_bpf_error("no layer_cpumask");
+		return NULL;
+	}
+}
+
+static void refresh_cpumasks(int idx)
+{
+	struct layer_cpumask_wrapper *cpumaskw;
+	struct layer *layer;
+	int cpu, total = 0;
+
+	if (!__sync_val_compare_and_swap(&layers[idx].refresh_cpus, 1, 0))
+		return;
+
+	cpumaskw = bpf_map_lookup_elem(&layer_cpumasks, &idx);
+
+	bpf_for(cpu, 0, nr_possible_cpus) {
+		u8 *u8_ptr;
+
+		if ((u8_ptr = MEMBER_VPTR(layers, [idx].cpus[cpu / 8]))) {
+			/*
+			 * XXX - The following test should be outside the loop
+			 * but that makes the verifier think that
+			 * cpumaskw->cpumask might be NULL in the loop.
+			 */
+			barrier_var(cpumaskw);
+			if (!cpumaskw || !cpumaskw->cpumask) {
+				scx_bpf_error("can't happen");
+				return;
+			}
+
+			if (*u8_ptr & (1 << (cpu % 8))) {
+				bpf_cpumask_set_cpu(cpu, cpumaskw->cpumask);
+				total++;
+			} else {
+				bpf_cpumask_clear_cpu(cpu, cpumaskw->cpumask);
+			}
+		} else {
+			scx_bpf_error("can't happen");
+		}
+	}
+
+	// XXX - shouldn't be necessary
+	layer = MEMBER_VPTR(layers, [idx]);
+	if (!layer) {
+		scx_bpf_error("can't happen");
+		return;
+	}
+
+	layer->nr_cpus = total;
+	__sync_fetch_and_add(&layer->cpus_seq, 1);
+	trace("LAYER[%d] now has %d cpus, seq=%llu", idx, layer->nr_cpus, layer->cpus_seq);
+}
+
+SEC("fentry/scheduler_tick")
+int scheduler_tick_fentry(const void *ctx)
+{
+	int idx;
+
+	if (bpf_get_smp_processor_id() == 0)
+		bpf_for(idx, 0, nr_layers)
+			refresh_cpumasks(idx);
+	return 0;
+}
+
+struct task_ctx {
+	int			pid;
+
+	int			layer;
+	bool			refresh_layer;
+	u64			layer_cpus_seq;
+	struct bpf_cpumask __kptr *layered_cpumask;
+
+	bool			all_cpus_allowed;
+	bool			dispatch_local;
+	u64			started_running_at;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__type(key, pid_t);
+	__type(value, struct task_ctx);
+	__uint(max_entries, MAX_TASKS);
+	__uint(map_flags, 0);
+} task_ctxs SEC(".maps");
+
+struct task_ctx *lookup_task_ctx_may_fail(struct task_struct *p)
+{
+	s32 pid = p->pid;
+
+	return bpf_map_lookup_elem(&task_ctxs, &pid);
+}
+
+struct task_ctx *lookup_task_ctx(struct task_struct *p)
+{
+	struct task_ctx *tctx;
+	s32 pid = p->pid;
+
+	if ((tctx = bpf_map_lookup_elem(&task_ctxs, &pid))) {
+		return tctx;
+	} else {
+		scx_bpf_error("task_ctx lookup failed");
+		return NULL;
+	}
+}
+
+struct layer *lookup_layer(int idx)
+{
+	if (idx < 0 || idx >= nr_layers) {
+		scx_bpf_error("invalid layer %d", idx);
+		return NULL;
+	}
+	return &layers[idx];
+}
+
+SEC("tp_btf/cgroup_attach_task")
+int BPF_PROG(tp_cgroup_attach_task, struct cgroup *cgrp, const char *cgrp_path,
+	     struct task_struct *leader, bool threadgroup)
+{
+	struct task_struct *next;
+	struct task_ctx *tctx;
+	int leader_pid = leader->pid;
+
+	if (!(tctx = lookup_task_ctx_may_fail(leader)))
+		return 0;
+	tctx->refresh_layer = true;
+
+	if (!threadgroup)
+		return 0;
+
+	if (!(next = bpf_task_acquire(leader))) {
+		scx_bpf_error("failed to acquire leader");
+		return 0;
+	}
+
+	bpf_repeat(MAX_TASKS) {
+		struct task_struct *p;
+		int pid;
+
+		p = container_of(next->thread_group.next, struct task_struct, thread_group);
+		bpf_task_release(next);
+
+		pid = BPF_CORE_READ(p, pid);
+		if (pid == leader_pid) {
+			next = NULL;
+			break;
+		}
+
+		next = bpf_task_from_pid(pid);
+		if (!next) {
+			scx_bpf_error("thread iteration failed");
+			break;
+		}
+
+		if ((tctx = lookup_task_ctx(next)))
+			tctx->refresh_layer = true;
+	}
+
+	if (next)
+		bpf_task_release(next);
+	return 0;
+}
+
+SEC("tp_btf/task_rename")
+int BPF_PROG(tp_task_rename, struct task_struct *p, const char *buf)
+{
+	struct task_ctx *tctx;
+
+	if ((tctx = lookup_task_ctx_may_fail(p)))
+		tctx->refresh_layer = true;
+	return 0;
+}
+
+static void maybe_refresh_layered_cpumask(struct cpumask *layered_cpumask,
+					  struct task_struct *p, struct task_ctx *tctx,
+					  const struct cpumask *layer_cpumask)
+{
+	u64 layer_seq = layers->cpus_seq;
+
+	if (tctx->layer_cpus_seq == layer_seq)
+		return;
+
+	/*
+	 * XXX - We're assuming that the updated @layer_cpumask matching the new
+	 * @layer_seq is visible which may not be true. For now, leave it as-is.
+	 * Let's update once BPF grows enough memory ordering constructs.
+	 */
+	bpf_cpumask_and((struct bpf_cpumask *)layered_cpumask, layer_cpumask, p->cpus_ptr);
+	tctx->layer_cpus_seq = layer_seq;
+	trace("%s[%d] cpumask refreshed to seq %llu", p->comm, p->pid, layer_seq);
+}
+
+static s32 pick_idle_cpu_from(const struct cpumask *cand_cpumask, s32 prev_cpu,
+			      const struct cpumask *idle_cpumask,
+			      const struct cpumask *idle_smtmask)
+{
+	bool prev_in_cand = bpf_cpumask_test_cpu(prev_cpu, cand_cpumask);
+	s32 cpu;
+
+	/*
+	 * If CPU has SMT, any wholly idle CPU is likely a better pick than
+	 * partially idle @prev_cpu.
+	 */
+	if (smt_enabled) {
+		if (prev_in_cand &&
+		    bpf_cpumask_test_cpu(prev_cpu, idle_smtmask) &&
+		    scx_bpf_test_and_clear_cpu_idle(prev_cpu))
+			return prev_cpu;
+
+		cpu = scx_bpf_pick_idle_cpu(cand_cpumask, SCX_PICK_IDLE_CORE);
+		if (cpu >= 0)
+			return cpu;
+	}
+
+	if (prev_in_cand && scx_bpf_test_and_clear_cpu_idle(prev_cpu))
+		return prev_cpu;
+
+	return scx_bpf_pick_idle_cpu(cand_cpumask, 0);
+}
+
+s32 BPF_STRUCT_OPS(layered_select_cpu, struct task_struct *p, s32 prev_cpu, u64 wake_flags)
+{
+	const struct cpumask *idle_cpumask, *idle_smtmask;
+	struct cpumask *layer_cpumask, *layered_cpumask;
+	struct cpu_ctx *cctx;
+	struct task_ctx *tctx;
+	struct layer *layer;
+	s32 cpu;
+
+	/* look up everything we need */
+	if (!(cctx = lookup_cpu_ctx(-1)) || !(tctx = lookup_task_ctx(p)) ||
+	    !(layered_cpumask = (struct cpumask *)tctx->layered_cpumask))
+		return prev_cpu;
+
+	/*
+	 * We usually update the layer in layered_runnable() to avoid confusing.
+	 * As layered_select_cpu() takes place before runnable, new tasks would
+	 * still have -1 layer. Just return @prev_cpu.
+	 */
+	if (tctx->layer < 0)
+		return prev_cpu;
+
+	if (!(layer = lookup_layer(tctx->layer)) ||
+	    !(layer_cpumask = lookup_layer_cpumask(tctx->layer)))
+		return prev_cpu;
+
+	if (!(idle_cpumask = scx_bpf_get_idle_cpumask()))
+		return prev_cpu;
+
+	if (!(idle_smtmask = scx_bpf_get_idle_smtmask())) {
+		cpu = prev_cpu;
+		goto out_put_idle_cpumask;
+	}
+
+	/* not much to do if bound to a single CPU */
+	if (p->nr_cpus_allowed == 1) {
+		cpu = prev_cpu;
+		if (scx_bpf_test_and_clear_cpu_idle(prev_cpu)) {
+			if (!bpf_cpumask_test_cpu(cpu, layer_cpumask))
+				lstat_inc(LSTAT_AFFN_VIOL, layer, cctx);
+			goto dispatch_local;
+		} else {
+			goto out_put_cpumasks;
+		}
+	}
+
+	maybe_refresh_layered_cpumask(layered_cpumask, p, tctx, layer_cpumask);
+
+	/*
+	 * If CPU has SMT, any wholly idle CPU is likely a better pick than
+	 * partially idle @prev_cpu.
+	 */
+	if ((cpu = pick_idle_cpu_from(layered_cpumask, prev_cpu,
+				      idle_cpumask, idle_smtmask)) >= 0)
+		goto dispatch_local;
+
+	/*
+	 * If the layer is an open one, we can try the whole machine.
+	 */
+	if (layer->open &&
+	    ((cpu = pick_idle_cpu_from(p->cpus_ptr, prev_cpu,
+				       idle_cpumask, idle_smtmask)) >= 0)) {
+		lstat_inc(LSTAT_OPEN_IDLE, layer, cctx);
+		goto dispatch_local;
+	}
+
+	cpu = prev_cpu;
+	goto out_put_cpumasks;
+
+dispatch_local:
+	tctx->dispatch_local = true;
+out_put_cpumasks:
+	scx_bpf_put_idle_cpumask(idle_smtmask);
+out_put_idle_cpumask:
+	scx_bpf_put_idle_cpumask(idle_cpumask);
+	return cpu;
+}
+
+void BPF_STRUCT_OPS(layered_enqueue, struct task_struct *p, u64 enq_flags)
+{
+	struct cpu_ctx *cctx;
+	struct task_ctx *tctx;
+	struct layer *layer;
+	u64 vtime = p->scx.dsq_vtime;
+	u32 idx;
+
+	if (!(cctx = lookup_cpu_ctx(-1)) || !(tctx = lookup_task_ctx(p)) ||
+	    !(layer = lookup_layer(tctx->layer)))
+		return;
+
+	if (tctx->dispatch_local) {
+		tctx->dispatch_local = false;
+		lstat_inc(LSTAT_LOCAL, layer, cctx);
+		scx_bpf_dispatch(p, SCX_DSQ_LOCAL, slice_ns, enq_flags);
+		return;
+	}
+
+	lstat_inc(LSTAT_GLOBAL, layer, cctx);
+
+	/*
+	 * Limit the amount of budget that an idling task can accumulate
+	 * to one slice.
+	 */
+	if (vtime_before(vtime, layer->vtime_now - slice_ns))
+		vtime = layer->vtime_now - slice_ns;
+
+	if (!tctx->all_cpus_allowed) {
+		lstat_inc(LSTAT_AFFN_VIOL, layer, cctx);
+		scx_bpf_dispatch(p, SCX_DSQ_GLOBAL, slice_ns, enq_flags);
+		return;
+	}
+
+	scx_bpf_dispatch_vtime(p, tctx->layer, slice_ns, vtime, enq_flags);
+
+	if (!layer->preempt)
+		return;
+
+	bpf_for(idx, 0, nr_possible_cpus) {
+		struct cpu_ctx *cand_cctx;
+		u32 cpu = (preempt_cursor + idx) % nr_possible_cpus;
+
+		if (!all_cpumask ||
+		    !bpf_cpumask_test_cpu(cpu, (const struct cpumask *)all_cpumask))
+			continue;
+		if (!(cand_cctx = lookup_cpu_ctx(cpu)) || cand_cctx->current_preempt)
+			continue;
+
+		scx_bpf_kick_cpu(cpu, SCX_KICK_PREEMPT);
+
+		/*
+		 * Round-robining doesn't have to be strict. Let's not bother
+		 * with atomic ops on $preempt_cursor.
+		 */
+		preempt_cursor = (cpu + 1) % nr_possible_cpus;
+
+		lstat_inc(LSTAT_PREEMPT, layer, cctx);
+		break;
+	}
+}
+
+void BPF_STRUCT_OPS(layered_dispatch, s32 cpu, struct task_struct *prev)
+{
+	int idx;
+
+	/* consume preempting layers first */
+	bpf_for(idx, 0, nr_layers)
+		if (layers[idx].preempt && scx_bpf_consume(idx))
+			return;
+
+	/* consume !open layers second */
+	bpf_for(idx, 0, nr_layers) {
+		struct layer *layer = &layers[idx];
+		struct cpumask *layer_cpumask;
+
+		if (layer->open)
+			continue;
+
+		/* consume matching layers */
+		if (!(layer_cpumask = lookup_layer_cpumask(idx)))
+			return;
+
+		if (bpf_cpumask_test_cpu(cpu, layer_cpumask) ||
+		    (cpu == fallback_cpu && layer->nr_cpus == 0)) {
+			if (scx_bpf_consume(idx))
+				return;
+		}
+	}
+
+	/* consume !preempting open layers */
+	bpf_for(idx, 0, nr_layers) {
+		if (!layers[idx].preempt && layers[idx].open &&
+		    scx_bpf_consume(idx))
+			return;
+	}
+}
+
+static bool match_one(struct layer_match *match, struct task_struct *p, const char *cgrp_path)
+{
+	switch (match->kind) {
+	case MATCH_CGROUP_PREFIX: {
+		return match_prefix(match->cgroup_prefix, cgrp_path, MAX_PATH);
+	}
+	case MATCH_COMM_PREFIX: {
+		char comm[MAX_COMM];
+		memcpy(comm, p->comm, MAX_COMM);
+		return match_prefix(match->comm_prefix, comm, MAX_COMM);
+	}
+	case MATCH_NICE_ABOVE:
+		return (s32)p->static_prio - 120 > match->nice_above_or_below;
+	case MATCH_NICE_BELOW:
+		return (s32)p->static_prio - 120 < match->nice_above_or_below;
+	default:
+		scx_bpf_error("invalid match kind %d", match->kind);
+		return false;
+	}
+}
+
+static bool match_layer(struct layer *layer, struct task_struct *p, const char *cgrp_path)
+{
+	u32 nr_match_ors = layer->nr_match_ors;
+	u64 or_idx, and_idx;
+
+	if (nr_match_ors > MAX_LAYER_MATCH_ORS) {
+		scx_bpf_error("too many ORs");
+		return false;
+	}
+
+	bpf_for(or_idx, 0, nr_match_ors) {
+		struct layer_match_ands *ands;
+		bool matched = true;
+
+		barrier_var(or_idx);
+		if (or_idx >= MAX_LAYER_MATCH_ORS)
+			return false; /* can't happen */
+		ands = &layer->matches[or_idx];
+
+		if (ands->nr_match_ands > NR_LAYER_MATCH_KINDS) {
+			scx_bpf_error("too many ANDs");
+			return false;
+		}
+
+		bpf_for(and_idx, 0, ands->nr_match_ands) {
+			struct layer_match *match;
+
+			barrier_var(and_idx);
+			if (and_idx >= NR_LAYER_MATCH_KINDS)
+				return false; /* can't happen */
+			match = &ands->matches[and_idx];
+
+			if (!match_one(match, p, cgrp_path)) {
+				matched = false;
+				break;
+			}
+		}
+
+		if (matched)
+			return true;
+	}
+
+	return false;
+}
+
+static void maybe_refresh_layer(struct task_struct *p, struct task_ctx *tctx)
+{
+	const char *cgrp_path;
+	bool matched = false;
+	u64 idx;	// XXX - int makes verifier unhappy
+
+	if (!tctx->refresh_layer)
+		return;
+	tctx->refresh_layer = false;
+
+	if (!(cgrp_path = format_cgrp_path(p->cgroups->dfl_cgrp)))
+		return;
+
+	if (tctx->layer >= 0 && tctx->layer < nr_layers)
+		__sync_fetch_and_add(&layers[tctx->layer].nr_tasks, -1);
+
+	bpf_for(idx, 0, nr_layers) {
+		if (match_layer(&layers[idx], p, cgrp_path)) {
+			matched = true;
+			break;
+		}
+	}
+
+	if (matched) {
+		struct layer *layer = &layers[idx];
+
+		tctx->layer = idx;
+		tctx->layer_cpus_seq = layer->cpus_seq - 1;
+		__sync_fetch_and_add(&layer->nr_tasks, 1);
+		/*
+		 * XXX - To be correct, we'd need to calculate the vtime
+		 * delta in the previous layer, scale it by the load
+		 * fraction difference and then offset from the new
+		 * layer's vtime_now. For now, just do the simple thing
+		 * and assume the offset to be zero.
+		 *
+		 * Revisit if high frequency dynamic layer switching
+		 * needs to be supported.
+		 */
+		p->scx.dsq_vtime = layer->vtime_now;
+	} else {
+		scx_bpf_error("[%s]%d didn't match any layer", p->comm, p->pid);
+	}
+
+	if (tctx->layer < nr_layers - 1)
+		trace("LAYER=%d %s[%d] cgrp=\"%s\"",
+		      tctx->layer, p->comm, p->pid, cgrp_path);
+}
+
+void BPF_STRUCT_OPS(layered_runnable, struct task_struct *p, u64 enq_flags)
+{
+	u64 now = bpf_ktime_get_ns();
+	struct task_ctx *tctx;
+
+	if (!(tctx = lookup_task_ctx(p)))
+		return;
+
+	maybe_refresh_layer(p, tctx);
+
+	adj_load(tctx->layer, p->scx.weight, now);
+}
+
+void BPF_STRUCT_OPS(layered_running, struct task_struct *p)
+{
+	struct cpu_ctx *cctx;
+	struct task_ctx *tctx;
+	struct layer *layer;
+
+	if (!(cctx = lookup_cpu_ctx(-1)) || !(tctx = lookup_task_ctx(p)) ||
+	    !(layer = lookup_layer(tctx->layer)))
+		return;
+
+	if (vtime_before(layer->vtime_now, p->scx.dsq_vtime))
+		layer->vtime_now = p->scx.dsq_vtime;
+
+	cctx->current_preempt = layer->preempt;
+	tctx->started_running_at = bpf_ktime_get_ns();
+}
+
+void BPF_STRUCT_OPS(layered_stopping, struct task_struct *p, bool runnable)
+{
+	struct cpu_ctx *cctx;
+	struct task_ctx *tctx;
+	u64 used;
+	u32 layer;
+
+	if (!(cctx = lookup_cpu_ctx(-1)) || !(tctx = lookup_task_ctx(p)))
+		return;
+
+	layer = tctx->layer;
+	if (layer >= nr_layers) {
+		scx_bpf_error("invalid layer %u", layer);
+		return;
+	}
+
+	used = bpf_ktime_get_ns() - tctx->started_running_at;
+	cctx->layer_cycles[layer] += used;
+	cctx->current_preempt = false;
+
+	/* scale the execution time by the inverse of the weight and charge */
+	p->scx.dsq_vtime += used * 100 / p->scx.weight;
+}
+
+void BPF_STRUCT_OPS(layered_quiescent, struct task_struct *p, u64 deq_flags)
+{
+	struct task_ctx *tctx;
+
+	if ((tctx = lookup_task_ctx(p)))
+		adj_load(tctx->layer, -(s64)p->scx.weight, bpf_ktime_get_ns());
+}
+
+void BPF_STRUCT_OPS(layered_set_weight, struct task_struct *p, u32 weight)
+{
+	struct task_ctx *tctx;
+
+	if ((tctx = lookup_task_ctx(p)))
+		tctx->refresh_layer = true;
+}
+
+void BPF_STRUCT_OPS(layered_set_cpumask, struct task_struct *p,
+		    const struct cpumask *cpumask)
+{
+	struct task_ctx *tctx;
+
+	if (!(tctx = lookup_task_ctx(p)))
+		return;
+
+	if (!all_cpumask) {
+		scx_bpf_error("NULL all_cpumask");
+		return;
+	}
+
+	tctx->all_cpus_allowed =
+		bpf_cpumask_subset((const struct cpumask *)all_cpumask, cpumask);
+}
+
+s32 BPF_STRUCT_OPS(layered_prep_enable, struct task_struct *p,
+		   struct scx_enable_args *args)
+{
+	struct task_ctx tctx_init = {
+		.pid = p->pid,
+		.layer = -1,
+		.refresh_layer = true,
+	};
+	struct task_ctx *tctx;
+	struct bpf_cpumask *cpumask;
+	s32 pid = p->pid;
+	s32 ret;
+
+	if (all_cpumask)
+		tctx_init.all_cpus_allowed =
+			bpf_cpumask_subset((const struct cpumask *)all_cpumask, p->cpus_ptr);
+	else
+		scx_bpf_error("missing all_cpumask");
+
+	/*
+	 * XXX - We want BPF_NOEXIST but bpf_map_delete_elem() in .disable() may
+	 * fail spuriously due to BPF recursion protection triggering
+	 * unnecessarily.
+	 */
+	if ((ret = bpf_map_update_elem(&task_ctxs, &pid, &tctx_init, 0 /*BPF_NOEXIST*/))) {
+		scx_bpf_error("task_ctx allocation failure, ret=%d", ret);
+		return ret;
+	}
+
+	/*
+	 * Read the entry from the map immediately so we can add the cpumask
+	 * with bpf_kptr_xchg().
+	 */
+	if (!(tctx = lookup_task_ctx(p)))
+		return -ENOENT;
+
+	cpumask = bpf_cpumask_create();
+	if (!cpumask) {
+		bpf_map_delete_elem(&task_ctxs, &pid);
+		return -ENOMEM;
+	}
+
+	cpumask = bpf_kptr_xchg(&tctx->layered_cpumask, cpumask);
+	if (cpumask) {
+		/* Should never happen as we just inserted it above. */
+		bpf_cpumask_release(cpumask);
+		bpf_map_delete_elem(&task_ctxs, &pid);
+		return -EINVAL;
+	}
+
+	/*
+	 * We are matching cgroup hierarchy path directly rather than the CPU
+	 * controller path. As the former isn't available during the scheduler
+	 * fork path, let's delay the layer selection until the first
+	 * runnable().
+	 */
+
+	return 0;
+}
+
+void BPF_STRUCT_OPS(layered_cancel_enable, struct task_struct *p)
+{
+	s32 pid = p->pid;
+
+	bpf_map_delete_elem(&task_ctxs, &pid);
+}
+
+void BPF_STRUCT_OPS(layered_disable, struct task_struct *p)
+{
+	struct cpu_ctx *cctx;
+	struct task_ctx *tctx;
+	s32 pid = p->pid;
+	int ret;
+
+	if (!(cctx = lookup_cpu_ctx(-1)) || !(tctx = lookup_task_ctx(p)))
+		return;
+
+	if (tctx->layer >= 0 && tctx->layer < nr_layers)
+		__sync_fetch_and_add(&layers[tctx->layer].nr_tasks, -1);
+
+	/*
+	 * XXX - There's no reason delete should fail here but BPF's recursion
+	 * protection can unnecessarily fail the operation. The fact that
+	 * deletions aren't reliable means that we sometimes leak task_ctx and
+	 * can't use BPF_NOEXIST on allocation in .prep_enable().
+	 */
+	ret = bpf_map_delete_elem(&task_ctxs, &pid);
+	if (ret)
+		gstat_inc(GSTAT_TASK_CTX_FREE_FAILED, cctx);
+}
+
+s32 BPF_STRUCT_OPS_SLEEPABLE(layered_init)
+{
+	struct bpf_cpumask *cpumask;
+	int i, j, k, nr_online_cpus, ret;
+
+	scx_bpf_switch_all();
+
+	cpumask = bpf_cpumask_create();
+	if (!cpumask)
+		return -ENOMEM;
+
+	nr_online_cpus = 0;
+	bpf_for(i, 0, nr_possible_cpus) {
+		const volatile u8 *u8_ptr;
+
+		if ((u8_ptr = MEMBER_VPTR(all_cpus, [i / 8]))) {
+			if (*u8_ptr & (1 << (i % 8))) {
+				bpf_cpumask_set_cpu(i, cpumask);
+				nr_online_cpus++;
+			}
+		} else {
+			return -EINVAL;
+		}
+	}
+
+	cpumask = bpf_kptr_xchg(&all_cpumask, cpumask);
+	if (cpumask)
+		bpf_cpumask_release(cpumask);
+
+	dbg("CFG: Dumping configuration, nr_online_cpus=%d smt_enabled=%d",
+	    nr_online_cpus, smt_enabled);
+
+	bpf_for(i, 0, nr_layers) {
+		struct layer *layer = &layers[i];
+
+		dbg("CFG LAYER[%d] open=%d preempt=%d",
+		    i, layer->open, layer->preempt);
+
+		if (layer->nr_match_ors > MAX_LAYER_MATCH_ORS) {
+			scx_bpf_error("too many ORs");
+			return -EINVAL;
+		}
+
+		bpf_for(j, 0, layer->nr_match_ors) {
+			struct layer_match_ands *ands = MEMBER_VPTR(layers, [i].matches[j]);
+			if (!ands) {
+				scx_bpf_error("shouldn't happen");
+				return -EINVAL;
+			}
+
+			if (ands->nr_match_ands > NR_LAYER_MATCH_KINDS) {
+				scx_bpf_error("too many ANDs");
+				return -EINVAL;
+			}
+
+			dbg("CFG   OR[%02d]", j);
+
+			bpf_for(k, 0, ands->nr_match_ands) {
+				char header[32];
+				u64 header_data[1] = { k };
+				struct layer_match *match;
+
+				bpf_snprintf(header, sizeof(header), "CFG     AND[%02d]:",
+					     header_data, sizeof(header_data));
+
+				match = MEMBER_VPTR(layers, [i].matches[j].matches[k]);
+				if (!match) {
+					scx_bpf_error("shouldn't happen");
+					return -EINVAL;
+				}
+
+				switch (match->kind) {
+				case MATCH_CGROUP_PREFIX:
+					dbg("%s CGROUP_PREFIX \"%s\"", header, match->cgroup_prefix);
+					break;
+				case MATCH_COMM_PREFIX:
+					dbg("%s COMM_PREFIX \"%s\"", header, match->comm_prefix);
+					break;
+				case MATCH_NICE_ABOVE:
+					dbg("%s NICE_ABOVE %d", header, match->nice_above_or_below);
+					break;
+				case MATCH_NICE_BELOW:
+					dbg("%s NICE_BELOW %d", header, match->nice_above_or_below);
+					break;
+				default:
+					scx_bpf_error("%s Invalid kind", header);
+					return -EINVAL;
+				}
+			}
+			if (ands->nr_match_ands == 0)
+				dbg("CFG     DEFAULT");
+		}
+	}
+
+	bpf_for(i, 0, nr_layers) {
+		struct layer_cpumask_wrapper *cpumaskw;
+
+		layers[i].idx = i;
+
+		ret = scx_bpf_create_dsq(i, -1);
+		if (ret < 0)
+			return ret;
+
+		if (!(cpumaskw = bpf_map_lookup_elem(&layer_cpumasks, &i)))
+			return -ENONET;
+
+		cpumask = bpf_cpumask_create();
+		if (!cpumask)
+			return -ENOMEM;
+
+		/*
+		 * Start all layers with full cpumask so that everything runs
+		 * everywhere. This will soon be updated by refresh_cpumasks()
+		 * once the scheduler starts running.
+		 */
+		bpf_cpumask_setall(cpumask);
+
+		cpumask = bpf_kptr_xchg(&cpumaskw->cpumask, cpumask);
+		if (cpumask)
+			bpf_cpumask_release(cpumask);
+	}
+
+	return 0;
+}
+
+void BPF_STRUCT_OPS(layered_exit, struct scx_exit_info *ei)
+{
+	uei_record(&uei, ei);
+}
+
+SEC(".struct_ops.link")
+struct sched_ext_ops layered = {
+	.select_cpu		= (void *)layered_select_cpu,
+	.enqueue		= (void *)layered_enqueue,
+	.dispatch		= (void *)layered_dispatch,
+	.runnable		= (void *)layered_runnable,
+	.running		= (void *)layered_running,
+	.stopping		= (void *)layered_stopping,
+	.quiescent		= (void *)layered_quiescent,
+	.set_weight		= (void *)layered_set_weight,
+	.set_cpumask		= (void *)layered_set_cpumask,
+	.prep_enable		= (void *)layered_prep_enable,
+	.cancel_enable		= (void *)layered_cancel_enable,
+	.disable		= (void *)layered_disable,
+	.init			= (void *)layered_init,
+	.exit			= (void *)layered_exit,
+	.name			= "layered",
+};
diff --git a/tools/sched_ext/scx_layered/src/bpf/layered.h b/tools/sched_ext/scx_layered/src/bpf/layered.h
new file mode 100644
index 000000000000..bedfa0650c00
--- /dev/null
+++ b/tools/sched_ext/scx_layered/src/bpf/layered.h
@@ -0,0 +1,100 @@
+// Copyright (c) Meta Platforms, Inc. and affiliates.
+
+// This software may be used and distributed according to the terms of the
+// GNU General Public License version 2.
+#ifndef __LAYERED_H
+#define __LAYERED_H
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
+typedef unsigned long long u64;
+typedef long long s64;
+#endif
+
+#include "../../../ravg.bpf.h"
+
+enum consts {
+	MAX_CPUS_SHIFT		= 9,
+	MAX_CPUS		= 1 << MAX_CPUS_SHIFT,
+	MAX_CPUS_U8		= MAX_CPUS / 8,
+	MAX_TASKS		= 131072,
+	MAX_PATH		= 4096,
+	MAX_COMM		= 16,
+	MAX_LAYER_MATCH_ORS	= 32,
+	MAX_LAYERS		= 16,
+	USAGE_HALF_LIFE		= 100000000,	/* 100ms */
+
+	/* XXX remove */
+	MAX_CGRP_PREFIXES = 32
+};
+
+/* Statistics */
+enum global_stat_idx {
+	GSTAT_TASK_CTX_FREE_FAILED,
+	NR_GSTATS,
+};
+
+enum layer_stat_idx {
+	LSTAT_LOCAL,
+	LSTAT_GLOBAL,
+	LSTAT_OPEN_IDLE,
+	LSTAT_AFFN_VIOL,
+	LSTAT_PREEMPT,
+	NR_LSTATS,
+};
+
+struct cpu_ctx {
+	bool			current_preempt;
+	u64			layer_cycles[MAX_LAYERS];
+	u64			gstats[NR_GSTATS];
+	u64			lstats[MAX_LAYERS][NR_LSTATS];
+};
+
+enum layer_match_kind {
+	MATCH_CGROUP_PREFIX,
+	MATCH_COMM_PREFIX,
+	MATCH_NICE_ABOVE,
+	MATCH_NICE_BELOW,
+
+	NR_LAYER_MATCH_KINDS,
+};
+
+struct layer_match {
+	int		kind;
+	char		cgroup_prefix[MAX_PATH];
+	char		comm_prefix[MAX_COMM];
+	int		nice_above_or_below;
+};
+
+struct layer_match_ands {
+	struct layer_match	matches[NR_LAYER_MATCH_KINDS];
+	int			nr_match_ands;
+};
+
+struct layer {
+	struct layer_match_ands	matches[MAX_LAYER_MATCH_ORS];
+	unsigned int		nr_match_ors;
+	unsigned int		idx;
+	bool			open;
+	bool			preempt;
+
+	u64			vtime_now;
+	u64			nr_tasks;
+
+	u64			load;
+	struct ravg_data	load_rd;
+
+	u64			cpus_seq;
+	unsigned int		refresh_cpus;
+	unsigned char		cpus[MAX_CPUS_U8];
+	unsigned int		nr_cpus;	// managed from BPF side
+};
+
+#endif /* __LAYERED_H */
diff --git a/tools/sched_ext/scx_layered/src/bpf/util.bpf.c b/tools/sched_ext/scx_layered/src/bpf/util.bpf.c
new file mode 100644
index 000000000000..703e0eece60b
--- /dev/null
+++ b/tools/sched_ext/scx_layered/src/bpf/util.bpf.c
@@ -0,0 +1,68 @@
+/* to be included in the main bpf.c file */
+
+struct {
+	__uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
+	__uint(key_size, sizeof(u32));
+	/* double size because verifier can't follow length calculation */
+	__uint(value_size, 2 * MAX_PATH);
+	__uint(max_entries, 1);
+} cgrp_path_bufs SEC(".maps");
+
+static char *format_cgrp_path(struct cgroup *cgrp)
+{
+	u32 zero = 0;
+	char *path = bpf_map_lookup_elem(&cgrp_path_bufs, &zero);
+	u32 len = 0, level, max_level;
+
+	if (!path) {
+		scx_bpf_error("cgrp_path_buf lookup failed");
+		return NULL;
+	}
+
+	max_level = cgrp->level;
+	if (max_level > 127)
+		max_level = 127;
+
+	bpf_for(level, 1, max_level + 1) {
+		int ret;
+
+		if (level > 1 && len < MAX_PATH - 1)
+			path[len++] = '/';
+
+		if (len >= MAX_PATH - 1) {
+			scx_bpf_error("cgrp_path_buf overflow");
+			return NULL;
+		}
+
+		ret = bpf_probe_read_kernel_str(path + len, MAX_PATH - len - 1,
+						BPF_CORE_READ(cgrp, ancestors[level], kn, name));
+		if (ret < 0) {
+			scx_bpf_error("bpf_probe_read_kernel_str failed");
+			return NULL;
+		}
+
+		len += ret - 1;
+	}
+
+	if (len >= MAX_PATH - 2) {
+		scx_bpf_error("cgrp_path_buf overflow");
+		return NULL;
+	}
+	path[len] = '/';
+	path[len + 1] = '\0';
+
+	return path;
+}
+
+static inline bool match_prefix(const char *prefix, const char *str, u32 max_len)
+{
+	int c;
+
+	bpf_for(c, 0, max_len) {
+		if (prefix[c] == '\0')
+			return true;
+		if (str[c] != prefix[c])
+			return false;
+	}
+	return false;
+}
diff --git a/tools/sched_ext/scx_layered/src/layered_sys.rs b/tools/sched_ext/scx_layered/src/layered_sys.rs
new file mode 100644
index 000000000000..afc821d388d2
--- /dev/null
+++ b/tools/sched_ext/scx_layered/src/layered_sys.rs
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
+include!(concat!(env!("OUT_DIR"), "/layered_sys.rs"));
diff --git a/tools/sched_ext/scx_layered/src/main.rs b/tools/sched_ext/scx_layered/src/main.rs
new file mode 100644
index 000000000000..7eb2edf53661
--- /dev/null
+++ b/tools/sched_ext/scx_layered/src/main.rs
@@ -0,0 +1,1641 @@
+// Copyright (c) Meta Platforms, Inc. and affiliates.
+
+// This software may be used and distributed according to the terms of the
+// GNU General Public License version 2.
+#[path = "bpf/.output/layered.skel.rs"]
+mod layered;
+pub use layered::*;
+pub mod layered_sys;
+
+use std::collections::BTreeMap;
+use std::collections::BTreeSet;
+use std::ffi::CStr;
+use std::ffi::CString;
+use std::fs;
+use std::io::Read;
+use std::io::Write;
+use std::ops::Sub;
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
+use serde::Deserialize;
+use serde::Serialize;
+
+const RAVG_FRAC_BITS: u32 = layered_sys::ravg_consts_RAVG_FRAC_BITS;
+const MAX_CPUS: usize = layered_sys::consts_MAX_CPUS as usize;
+const MAX_PATH: usize = layered_sys::consts_MAX_PATH as usize;
+const MAX_COMM: usize = layered_sys::consts_MAX_COMM as usize;
+const MAX_LAYER_MATCH_ORS: usize = layered_sys::consts_MAX_LAYER_MATCH_ORS as usize;
+const MAX_LAYERS: usize = layered_sys::consts_MAX_LAYERS as usize;
+const USAGE_HALF_LIFE: u32 = layered_sys::consts_USAGE_HALF_LIFE;
+const USAGE_HALF_LIFE_F64: f64 = USAGE_HALF_LIFE as f64 / 1_000_000_000.0;
+const NR_GSTATS: usize = layered_sys::global_stat_idx_NR_GSTATS as usize;
+const NR_LSTATS: usize = layered_sys::layer_stat_idx_NR_LSTATS as usize;
+const NR_LAYER_MATCH_KINDS: usize = layered_sys::layer_match_kind_NR_LAYER_MATCH_KINDS as usize;
+const CORE_CACHE_LEVEL: u32 = 2;
+
+include!("../../ravg_read.rs.h");
+
+lazy_static::lazy_static! {
+    static ref NR_POSSIBLE_CPUS: usize = libbpf_rs::num_possible_cpus().unwrap();
+    static ref USAGE_DECAY: f64 = 0.5f64.powf(1.0 / USAGE_HALF_LIFE_F64);
+}
+
+/// scx_layered: A highly configurable multi-layer sched_ext scheduler
+///
+/// scx_layered allows classifying tasks into multiple layers and applying
+/// different scheduling policies to them. The configuration is specified in
+/// json and composed of two parts - matches and policies.
+///
+/// Matches
+/// =======
+///
+/// Whenever a task is forked or its attributes are changed, the task goes
+/// through a series of matches to determine the layer it belongs to. A
+/// match set is composed of OR groups of AND blocks. An example:
+///
+///   "matches": [
+///     [
+///       {
+///         "CgroupPrefix": "system.slice/"
+///       }
+///     ],
+///     [
+///       {
+///         "CommPrefix": "fbagent"
+///       },
+///       {
+///         "NiceAbove": 0
+///       }
+///     ]
+///   ],
+///
+/// The outer array contains the OR groups and the inner AND blocks, so the
+/// above matches:
+///
+/// * Tasks which are in the cgroup sub-hierarchy under "system.slice".
+/// * Or tasks whose comm starts with "fbagent" and have a nice value > 0.
+///
+/// Currently, the following matches are supported:
+///
+/// * CgroupPrefix: Matches the prefix of the cgroup that the task belongs
+///   to. As this is a string match, whether the pattern has the trailing
+///   '/' makes a difference. For example, "TOP/CHILD/" only matches tasks
+///   which are under that particular cgroup while "TOP/CHILD" also matches
+///   tasks under "TOP/CHILD0/" or "TOP/CHILD1/".
+///
+/// * CommPrefix: Matches the task's comm prefix.
+///
+/// * NiceAbove: Matches if the task's nice value is greater than the
+///   pattern.
+///
+/// * NiceBelow: Matches if the task's nice value is smaller than the
+///   pattern.
+///
+/// While there are complexity limitations as the matches are performed in
+/// BPF, it is straightforward to add more types of matches.
+///
+/// Policies
+/// ========
+///
+/// The following is an example policy configuration for a layer.
+///
+///   "kind": {
+///     "Confined": {
+///       "cpus_range": [1, 8],
+///       "util_range": [0.8, 0.9]
+///     }
+///   }
+///
+/// It's of "Confined" kind, which tries to concentrate the layer's tasks
+/// into a limited number of CPUs. In the above case, the number of CPUs
+/// assigned to the layer is scaled between 1 and 8 so that the per-cpu
+/// utilization is kept between 80% and 90%. If the CPUs are loaded higher
+/// than 90%, more CPUs are allocated to the layer. If the utilization drops
+/// below 80%, the layer loses CPUs.
+///
+/// Currently, the following policy kinds are supported:
+///
+/// * Confined: Tasks are restricted to the allocated CPUs. The number of
+///   CPUs allocated is modulated to keep the per-CPU utilization in
+///   "util_range". The range can optionally be restricted with the
+///   "cpus_range" property.
+///
+/// * Grouped: Similar to Confined but tasks may spill outside if there are
+///   idle CPUs outside the allocated ones. If "preempt" is true, tasks in
+///   this layer will preempt tasks which belong to other non-preempting
+///   layers when no idle CPUs are available.
+///
+/// * Open: Prefer the CPUs which are not occupied by Confined or Grouped
+///   layers. Tasks in this group will spill into occupied CPUs if there are
+///   no unoccupied idle CPUs. If "preempt" is true, tasks in this layer
+///   will preempt tasks which belong to other non-preempting layers when no
+///   idle CPUs are available.
+///
+/// Similar to matches, adding new policies and extending existing ones
+/// should be relatively straightforward.
+///
+/// Configuration example and running scx_layered
+/// =============================================
+///
+/// A scx_layered config is composed of layer configs and a layer config is
+/// composed of a name, a set of matches and a policy block. Running the
+/// following will write an example configuration into example.json.
+///
+///   $ scx_layered -e example.json
+///
+/// Note that the last layer in the configuration must have an empty match
+/// set as it must match all tasks which haven't been matched into previous
+/// layers.
+///
+/// The configuration can be specified in multiple json files and command
+/// line arguments. Each must contain valid layer configurations and they're
+/// concatenated in the specified order. In most cases, something like the
+/// following should do.
+///
+///   $ scx_layered file:example.json
+///
+/// Statistics
+/// ==========
+///
+/// scx_layered will print out a set of statistics every monitoring
+/// interval.
+///
+///   tot= 117909 local=86.20 open_idle= 0.21 affn_viol= 1.37 tctx_err=9 proc=6ms
+///   busy= 34.2 util= 1733.6 load=  21744.1 fallback_cpu=  1
+///     batch    : util/frac=   11.8/  0.7 load/frac=     29.7:  0.1 tasks=  2597
+///                tot=   3478 local=67.80 open_idle= 0.00 preempt= 0.00 affn_viol= 0.00
+///                cpus=  2 [  2,  2] 04000001 00000000
+///     immediate: util/frac= 1218.8/ 70.3 load/frac=  21399.9: 98.4 tasks=  1107
+///                tot=  68997 local=90.57 open_idle= 0.26 preempt= 9.36 affn_viol= 0.00
+///                cpus= 50 [ 50, 50] fbfffffe 000fffff
+///     normal   : util/frac=  502.9/ 29.0 load/frac=    314.5:  1.4 tasks=  3512
+///                tot=  45434 local=80.97 open_idle= 0.16 preempt= 0.00 affn_viol= 3.56
+///                cpus= 50 [ 50, 50] fbfffffe 000fffff
+///
+/// Global statistics:
+///
+/// - tot: Total scheduling events in the period.
+///
+/// - local: % that got scheduled directly into an idle CPU.
+///
+/// - open_idle: % of open layer tasks scheduled into occupied idle CPUs.
+///
+/// - affn_viol: % which violated configured policies due to CPU affinity
+///   restrictions.
+///
+/// - proc: CPU time this binary consumed during the period.
+///
+/// - busy: CPU busy % (100% means all CPUs were fully occupied)
+///
+/// - util: CPU utilization % (100% means one CPU was fully occupied)
+///
+/// - load: Sum of weight * duty_cycle for all tasks
+///
+/// Per-layer statistics:
+///
+/// - util/frac: CPU utilization and fraction % (sum of fractions across
+///   layers is always 100%).
+///
+/// - load/frac: Load sum and fraction %.
+///
+/// - tasks: Number of tasks.
+///
+/// - tot: Total scheduling events.
+///
+/// - open_idle: % of tasks scheduled into idle CPUs occupied by other layers.
+///
+/// - preempt: % of tasks that preempted other tasks.
+///
+/// - affn_viol: % which violated configured policies due to CPU affinity
+///   restrictions.
+///
+/// - cpus: CUR_NR_CPUS [MIN_NR_CPUS, MAX_NR_CPUS] CUR_CPU_MASK
+///
+#[derive(Debug, Parser)]
+#[command(verbatim_doc_comment)]
+struct Opts {
+    /// Scheduling slice duration in microseconds.
+    #[clap(short = 's', long, default_value = "20000")]
+    slice_us: u64,
+
+    /// Scheduling interval in seconds.
+    #[clap(short = 'i', long, default_value = "0.1")]
+    interval: f64,
+
+    /// Monitoring interval in seconds.
+    #[clap(short = 'm', long, default_value = "2.0")]
+    monitor: f64,
+
+    /// Disable load-fraction based max layer CPU limit. ***NOTE***
+    /// load-fraction calculation is currently broken due to lack of
+    /// infeasible weight adjustments. Setting this option is recommended.
+    #[clap(short = 'n', long)]
+    no_load_frac_limit: bool,
+
+    /// Enable verbose output including libbpf details. Specify multiple
+    /// times to increase verbosity.
+    #[clap(short = 'v', long, action = clap::ArgAction::Count)]
+    verbose: u8,
+
+    /// Write example layer specifications into the file and exit.
+    #[clap(short = 'e', long)]
+    example: Option<String>,
+
+    /// Layer specification. See --help.
+    specs: Vec<String>,
+}
+
+#[derive(Clone, Debug, Serialize, Deserialize)]
+enum LayerMatch {
+    CgroupPrefix(String),
+    CommPrefix(String),
+    NiceAbove(i32),
+    NiceBelow(i32),
+}
+
+#[derive(Clone, Debug, Serialize, Deserialize)]
+enum LayerKind {
+    Confined {
+        cpus_range: Option<(usize, usize)>,
+        util_range: (f64, f64),
+    },
+    Grouped {
+        cpus_range: Option<(usize, usize)>,
+        util_range: (f64, f64),
+        preempt: bool,
+    },
+    Open {
+        preempt: bool,
+    },
+}
+
+#[derive(Clone, Debug, Serialize, Deserialize)]
+struct LayerSpec {
+    name: String,
+    comment: Option<String>,
+    matches: Vec<Vec<LayerMatch>>,
+    kind: LayerKind,
+}
+
+impl LayerSpec {
+    fn parse(input: &str) -> Result<Vec<Self>> {
+        let config: LayerConfig = if input.starts_with("f:") || input.starts_with("file:") {
+            let mut f = fs::OpenOptions::new()
+                .read(true)
+                .open(input.split_once(':').unwrap().1)?;
+            let mut content = String::new();
+            f.read_to_string(&mut content)?;
+            serde_json::from_str(&content)?
+        } else {
+            serde_json::from_str(input)?
+        };
+        Ok(config.specs)
+    }
+}
+
+#[derive(Clone, Debug, Serialize, Deserialize)]
+#[serde(transparent)]
+struct LayerConfig {
+    specs: Vec<LayerSpec>,
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
+fn copy_into_cstr(dst: &mut [i8], src: &str) {
+    let cstr = CString::new(src).unwrap();
+    let bytes = unsafe { std::mem::transmute::<&[u8], &[i8]>(cstr.as_bytes_with_nul()) };
+    dst[0..bytes.len()].copy_from_slice(bytes);
+}
+
+fn format_bitvec(bitvec: &BitVec) -> String {
+    let mut vals = Vec::<u32>::new();
+    let mut val: u32 = 0;
+    for (idx, bit) in bitvec.iter().enumerate() {
+        if idx > 0 && idx % 32 == 0 {
+            vals.push(val);
+            val = 0;
+        }
+        if *bit {
+            val |= 1 << (idx % 32);
+        }
+    }
+    vals.push(val);
+    let mut output = vals
+        .iter()
+        .fold(String::new(), |string, v| format!("{}{:08x} ", string, v));
+    output.pop();
+    output
+}
+
+fn read_cpu_ctxs(skel: &LayeredSkel) -> Result<Vec<layered_sys::cpu_ctx>> {
+    let mut cpu_ctxs = vec![];
+    let cpu_ctxs_vec = skel
+        .maps()
+        .cpu_ctxs()
+        .lookup_percpu(&0u32.to_ne_bytes(), libbpf_rs::MapFlags::ANY)
+        .context("Failed to lookup cpu_ctx")?
+        .unwrap();
+    for cpu in 0..*NR_POSSIBLE_CPUS {
+        cpu_ctxs.push(*unsafe {
+            &*(cpu_ctxs_vec[cpu].as_slice().as_ptr() as *const layered_sys::cpu_ctx)
+        });
+    }
+    Ok(cpu_ctxs)
+}
+
+#[derive(Clone, Debug)]
+struct BpfStats {
+    gstats: Vec<u64>,
+    lstats: Vec<Vec<u64>>,
+    lstats_sums: Vec<u64>,
+}
+
+impl BpfStats {
+    fn read(cpu_ctxs: &[layered_sys::cpu_ctx], nr_layers: usize) -> Self {
+        let mut gstats = vec![0u64; NR_GSTATS];
+        let mut lstats = vec![vec![0u64; NR_LSTATS]; nr_layers];
+
+        for cpu in 0..*NR_POSSIBLE_CPUS {
+            for stat in 0..NR_GSTATS {
+                gstats[stat] += cpu_ctxs[cpu].gstats[stat];
+            }
+            for layer in 0..nr_layers {
+                for stat in 0..NR_LSTATS {
+                    lstats[layer][stat] += cpu_ctxs[cpu].lstats[layer][stat];
+                }
+            }
+        }
+
+        let mut lstats_sums = vec![0u64; NR_LSTATS];
+        for layer in 0..nr_layers {
+            for stat in 0..NR_LSTATS {
+                lstats_sums[stat] += lstats[layer][stat];
+            }
+        }
+
+        Self {
+            gstats,
+            lstats,
+            lstats_sums,
+        }
+    }
+}
+
+impl<'a, 'b> Sub<&'b BpfStats> for &'a BpfStats {
+    type Output = BpfStats;
+
+    fn sub(self, rhs: &'b BpfStats) -> BpfStats {
+        let vec_sub = |l: &[u64], r: &[u64]| l.iter().zip(r.iter()).map(|(l, r)| *l - *r).collect();
+        BpfStats {
+            gstats: vec_sub(&self.gstats, &rhs.gstats),
+            lstats: self
+                .lstats
+                .iter()
+                .zip(rhs.lstats.iter())
+                .map(|(l, r)| vec_sub(l, r))
+                .collect(),
+            lstats_sums: vec_sub(&self.lstats_sums, &rhs.lstats_sums),
+        }
+    }
+}
+
+struct Stats {
+    nr_layers: usize,
+    at: Instant,
+
+    nr_layer_tasks: Vec<usize>,
+
+    total_load: f64,
+    layer_loads: Vec<f64>,
+
+    total_util: f64, // Running AVG of sum of layer_utils
+    layer_utils: Vec<f64>,
+    prev_layer_cycles: Vec<u64>,
+
+    cpu_busy: f64, // Read from /proc, maybe higher than total_util
+    prev_total_cpu: procfs::CpuStat,
+
+    bpf_stats: BpfStats,
+    prev_bpf_stats: BpfStats,
+}
+
+impl Stats {
+    fn read_layer_loads(skel: &mut LayeredSkel, nr_layers: usize) -> (f64, Vec<f64>) {
+        let now_mono = now_monotonic();
+        let layer_loads: Vec<f64> = skel
+            .bss()
+            .layers
+            .iter()
+            .take(nr_layers)
+            .map(|layer| {
+                let rd = &layer.load_rd;
+                ravg_read(
+                    rd.val,
+                    rd.val_at,
+                    rd.old,
+                    rd.cur,
+                    now_mono,
+                    USAGE_HALF_LIFE,
+                    RAVG_FRAC_BITS,
+                )
+            })
+            .collect();
+        (layer_loads.iter().sum(), layer_loads)
+    }
+
+    fn read_layer_cycles(cpu_ctxs: &[layered_sys::cpu_ctx], nr_layers: usize) -> Vec<u64> {
+        let mut layer_cycles = vec![0u64; nr_layers];
+
+        for cpu in 0..*NR_POSSIBLE_CPUS {
+            for layer in 0..nr_layers {
+                layer_cycles[layer] += cpu_ctxs[cpu].layer_cycles[layer];
+            }
+        }
+
+        layer_cycles
+    }
+
+    fn new(skel: &mut LayeredSkel, proc_reader: &procfs::ProcReader) -> Result<Self> {
+        let nr_layers = skel.rodata().nr_layers as usize;
+        let bpf_stats = BpfStats::read(&read_cpu_ctxs(skel)?, nr_layers);
+
+        Ok(Self {
+            at: Instant::now(),
+            nr_layers,
+
+            nr_layer_tasks: vec![0; nr_layers],
+
+            total_load: 0.0,
+            layer_loads: vec![0.0; nr_layers],
+
+            total_util: 0.0,
+            layer_utils: vec![0.0; nr_layers],
+            prev_layer_cycles: vec![0; nr_layers],
+
+            cpu_busy: 0.0,
+            prev_total_cpu: read_total_cpu(&proc_reader)?,
+
+            bpf_stats: bpf_stats.clone(),
+            prev_bpf_stats: bpf_stats,
+        })
+    }
+
+    fn refresh(
+        &mut self,
+        skel: &mut LayeredSkel,
+        proc_reader: &procfs::ProcReader,
+        now: Instant,
+    ) -> Result<()> {
+        let elapsed = now.duration_since(self.at).as_secs_f64() as f64;
+        let cpu_ctxs = read_cpu_ctxs(skel)?;
+
+        let nr_layer_tasks: Vec<usize> = skel
+            .bss()
+            .layers
+            .iter()
+            .take(self.nr_layers)
+            .map(|layer| layer.nr_tasks as usize)
+            .collect();
+
+        let (total_load, layer_loads) = Self::read_layer_loads(skel, self.nr_layers);
+
+        let cur_layer_cycles = Self::read_layer_cycles(&cpu_ctxs, self.nr_layers);
+        let cur_layer_utils: Vec<f64> = cur_layer_cycles
+            .iter()
+            .zip(self.prev_layer_cycles.iter())
+            .map(|(cur, prev)| (cur - prev) as f64 / 1_000_000_000.0 / elapsed)
+            .collect();
+        let layer_utils: Vec<f64> = cur_layer_utils
+            .iter()
+            .zip(self.layer_utils.iter())
+            .map(|(cur, prev)| {
+                let decay = USAGE_DECAY.powf(elapsed);
+                prev * decay + cur * (1.0 - decay)
+            })
+            .collect();
+
+        let cur_total_cpu = read_total_cpu(proc_reader)?;
+        let cpu_busy = calc_util(&cur_total_cpu, &self.prev_total_cpu)?;
+
+        let cur_bpf_stats = BpfStats::read(&cpu_ctxs, self.nr_layers);
+        let bpf_stats = &cur_bpf_stats - &self.prev_bpf_stats;
+
+        *self = Self {
+            at: now,
+            nr_layers: self.nr_layers,
+
+            nr_layer_tasks,
+
+            total_load,
+            layer_loads,
+
+            total_util: layer_utils.iter().sum(),
+            layer_utils: layer_utils.try_into().unwrap(),
+            prev_layer_cycles: cur_layer_cycles,
+
+            cpu_busy,
+            prev_total_cpu: cur_total_cpu,
+
+            bpf_stats,
+            prev_bpf_stats: cur_bpf_stats,
+        };
+        Ok(())
+    }
+}
+
+#[derive(Debug, Default)]
+struct UserExitInfo {
+    kind: i32,
+    reason: Option<String>,
+    msg: Option<String>,
+}
+
+impl UserExitInfo {
+    fn read(bpf_uei: &layered_bss_types::user_exit_info) -> Result<Self> {
+        let kind = unsafe { std::ptr::read_volatile(&bpf_uei.kind as *const _) };
+
+        let (reason, msg) = if kind != 0 {
+            (
+                Some(
+                    unsafe { CStr::from_ptr(bpf_uei.reason.as_ptr() as *const _) }
+                        .to_str()
+                        .context("Failed to convert reason to string")?
+                        .to_string(),
+                )
+                .filter(|s| !s.is_empty()),
+                Some(
+                    unsafe { CStr::from_ptr(bpf_uei.msg.as_ptr() as *const _) }
+                        .to_str()
+                        .context("Failed to convert msg to string")?
+                        .to_string(),
+                )
+                .filter(|s| !s.is_empty()),
+            )
+        } else {
+            (None, None)
+        };
+
+        Ok(Self { kind, reason, msg })
+    }
+
+    fn exited(bpf_uei: &layered_bss_types::user_exit_info) -> Result<bool> {
+        Ok(Self::read(bpf_uei)?.kind != 0)
+    }
+
+    fn report(&self) -> Result<()> {
+        let why = match (&self.reason, &self.msg) {
+            (Some(reason), None) => format!("{}", reason),
+            (Some(reason), Some(msg)) => format!("{} ({})", reason, msg),
+            _ => "".into(),
+        };
+
+        match self.kind {
+            0 => Ok(()),
+            etype => {
+                if etype != 64 {
+                    bail!("EXIT: kind={} {}", etype, why);
+                } else {
+                    info!("EXIT: {}", why);
+                    Ok(())
+                }
+            }
+        }
+    }
+}
+
+#[derive(Debug)]
+struct CpuPool {
+    nr_cores: usize,
+    nr_cpus: usize,
+    all_cpus: BitVec,
+    core_cpus: Vec<BitVec>,
+    cpu_core: Vec<usize>,
+    available_cores: BitVec,
+    first_cpu: usize,
+    fallback_cpu: usize, // next free or the first CPU if none is free
+}
+
+impl CpuPool {
+    fn new() -> Result<Self> {
+        if *NR_POSSIBLE_CPUS > MAX_CPUS {
+            bail!(
+                "NR_POSSIBLE_CPUS {} > MAX_CPUS {}",
+                *NR_POSSIBLE_CPUS,
+                MAX_CPUS
+            );
+        }
+
+        let mut cpu_to_cache = vec![]; // (cpu_id, Option<cache_id>)
+        let mut cache_ids = BTreeSet::<usize>::new();
+        let mut nr_offline = 0;
+
+        // Build cpu -> cache ID mapping.
+        for cpu in 0..*NR_POSSIBLE_CPUS {
+            let path = format!(
+                "/sys/devices/system/cpu/cpu{}/cache/index{}/id",
+                cpu, CORE_CACHE_LEVEL
+            );
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
+        let nr_cpus = *NR_POSSIBLE_CPUS - nr_offline;
+
+        // Cache IDs may have holes. Assign consecutive core IDs to existing
+        // cache IDs.
+        let mut cache_to_core = BTreeMap::<usize, usize>::new();
+        let mut nr_cores = 0;
+        for cache_id in cache_ids.iter() {
+            cache_to_core.insert(*cache_id, nr_cores);
+            nr_cores += 1;
+        }
+
+        // Build core -> cpumask and cpu -> core mappings.
+        let mut all_cpus = bitvec![0; *NR_POSSIBLE_CPUS];
+        let mut core_cpus = vec![bitvec![0; *NR_POSSIBLE_CPUS]; nr_cores];
+        let mut cpu_core = vec![];
+
+        for (cpu, cache) in cpu_to_cache.iter().enumerate().take(*NR_POSSIBLE_CPUS) {
+            if let Some(cache_id) = cache {
+                let core_id = cache_to_core[cache_id];
+                all_cpus.set(cpu, true);
+                core_cpus[core_id].set(cpu, true);
+                cpu_core.push(core_id);
+            }
+        }
+
+        info!(
+            "CPUs: online/possible={}/{} nr_cores={}",
+            nr_cpus, *NR_POSSIBLE_CPUS, nr_cores,
+        );
+
+        let first_cpu = core_cpus[0].first_one().unwrap();
+
+        let mut cpu_pool = Self {
+            nr_cores,
+            nr_cpus,
+            all_cpus,
+            core_cpus,
+            cpu_core,
+            available_cores: bitvec![1; nr_cores],
+            first_cpu,
+            fallback_cpu: first_cpu,
+        };
+        cpu_pool.update_fallback_cpu();
+        Ok(cpu_pool)
+    }
+
+    fn update_fallback_cpu(&mut self) {
+        match self.available_cores.first_one() {
+            Some(next) => self.fallback_cpu = self.core_cpus[next].first_one().unwrap(),
+            None => self.fallback_cpu = self.first_cpu,
+        }
+    }
+
+    fn alloc<'a>(&'a mut self) -> Option<&'a BitVec> {
+        let core = self.available_cores.first_one()?;
+        self.available_cores.set(core, false);
+        self.update_fallback_cpu();
+        Some(&self.core_cpus[core])
+    }
+
+    fn cpus_to_cores(&self, cpus_to_match: &BitVec) -> Result<BitVec> {
+        let mut cpus = cpus_to_match.clone();
+        let mut cores = bitvec![0; self.nr_cores];
+
+        while let Some(cpu) = cpus.first_one() {
+            let core = self.cpu_core[cpu];
+
+            if (self.core_cpus[core].clone() & !cpus.clone()).count_ones() != 0 {
+                bail!(
+                    "CPUs {} partially intersect with core {} ({})",
+                    cpus_to_match,
+                    core,
+                    self.core_cpus[core],
+                );
+            }
+
+            cpus &= !self.core_cpus[core].clone();
+            cores.set(core, true);
+        }
+
+        Ok(cores)
+    }
+
+    fn free<'a>(&'a mut self, cpus_to_free: &BitVec) -> Result<()> {
+        let cores = self.cpus_to_cores(cpus_to_free)?;
+        if (self.available_cores.clone() & &cores).any() {
+            bail!("Some of CPUs {} are already free", cpus_to_free);
+        }
+        self.available_cores |= cores;
+        self.update_fallback_cpu();
+        Ok(())
+    }
+
+    fn next_to_free<'a>(&'a self, cands: &BitVec) -> Result<Option<&'a BitVec>> {
+        let last = match cands.last_one() {
+            Some(ret) => ret,
+            None => return Ok(None),
+        };
+        let core = self.cpu_core[last];
+        if (self.core_cpus[core].clone() & !cands.clone()).count_ones() != 0 {
+            bail!(
+                "CPUs{} partially intersect with core {} ({})",
+                cands,
+                core,
+                self.core_cpus[core]
+            );
+        }
+
+        Ok(Some(&self.core_cpus[core]))
+    }
+
+    fn available_cpus(&self) -> BitVec {
+        let mut cpus = bitvec![0; self.nr_cpus];
+        for core in self.available_cores.iter_ones() {
+            cpus |= &self.core_cpus[core];
+        }
+        cpus
+    }
+}
+
+#[derive(Debug)]
+struct Layer {
+    name: String,
+    kind: LayerKind,
+
+    nr_cpus: usize,
+    cpus: BitVec,
+}
+
+impl Layer {
+    fn new(cpu_pool: &mut CpuPool, name: &str, kind: LayerKind) -> Result<Self> {
+        match &kind {
+            LayerKind::Confined {
+                cpus_range,
+                util_range,
+            } => {
+                let cpus_range = cpus_range.unwrap_or((0, std::usize::MAX));
+                if cpus_range.0 > cpus_range.1 || cpus_range.1 == 0 {
+                    bail!("invalid cpus_range {:?}", cpus_range);
+                }
+                if util_range.0 < 0.0
+                    || util_range.0 > 1.0
+                    || util_range.1 < 0.0
+                    || util_range.1 > 1.0
+                    || util_range.0 >= util_range.1
+                {
+                    bail!("invalid util_range {:?}", util_range);
+                }
+            }
+            _ => {}
+        }
+
+        let nr_cpus = cpu_pool.nr_cpus;
+
+        let mut layer = Self {
+            name: name.into(),
+            kind,
+
+            nr_cpus: 0,
+            cpus: bitvec![0; nr_cpus],
+        };
+
+        match &layer.kind {
+            LayerKind::Confined {
+                cpus_range,
+                util_range,
+            }
+            | LayerKind::Grouped {
+                cpus_range,
+                util_range,
+                ..
+            } => {
+                layer.resize_confined_or_grouped(
+                    cpu_pool,
+                    *cpus_range,
+                    *util_range,
+                    (0.0, 0.0),
+                    (0.0, 0.0),
+                    false,
+                )?;
+            }
+            _ => {}
+        }
+
+        Ok(layer)
+    }
+
+    fn grow_confined_or_grouped(
+        &mut self,
+        cpu_pool: &mut CpuPool,
+        (cpus_min, cpus_max): (usize, usize),
+        (_util_low, util_high): (f64, f64),
+        (layer_load, total_load): (f64, f64),
+        (layer_util, _total_util): (f64, f64),
+        no_load_frac_limit: bool,
+    ) -> Result<bool> {
+        if self.nr_cpus >= cpus_max {
+            return Ok(false);
+        }
+
+        // Do we already have enough?
+        if self.nr_cpus >= cpus_min
+            && (layer_util == 0.0
+                || (self.nr_cpus > 0 && layer_util / self.nr_cpus as f64 <= util_high))
+        {
+            return Ok(false);
+        }
+
+        // Can't have more CPUs than our load fraction.
+        if !no_load_frac_limit
+            && self.nr_cpus >= cpus_min
+            && (total_load >= 0.0
+                && self.nr_cpus as f64 / cpu_pool.nr_cpus as f64 >= layer_load / total_load)
+        {
+            trace!(
+                "layer-{} needs more CPUs (util={:.3}) but is over the load fraction",
+                &self.name,
+                layer_util
+            );
+            return Ok(false);
+        }
+
+        let new_cpus = match cpu_pool.alloc().clone() {
+            Some(ret) => ret.clone(),
+            None => {
+                trace!("layer-{} can't grow, no CPUs", &self.name);
+                return Ok(false);
+            }
+        };
+
+        trace!(
+            "layer-{} adding {} CPUs to {} CPUs",
+            &self.name,
+            new_cpus.count_ones(),
+            self.nr_cpus
+        );
+
+        self.nr_cpus += new_cpus.count_ones();
+        self.cpus |= &new_cpus;
+        Ok(true)
+    }
+
+    fn cpus_to_free(
+        &self,
+        cpu_pool: &mut CpuPool,
+        (cpus_min, _cpus_max): (usize, usize),
+        (util_low, util_high): (f64, f64),
+        (layer_load, total_load): (f64, f64),
+        (layer_util, _total_util): (f64, f64),
+        no_load_frac_limit: bool,
+    ) -> Result<Option<BitVec>> {
+        if self.nr_cpus <= cpus_min {
+            return Ok(None);
+        }
+
+        let cpus_to_free = match cpu_pool.next_to_free(&self.cpus)? {
+            Some(ret) => ret.clone(),
+            None => return Ok(None),
+        };
+
+        let nr_to_free = cpus_to_free.count_ones();
+
+        // If we'd be over the load fraction even after freeing
+        // $cpus_to_free, we have to free.
+        if !no_load_frac_limit
+            && total_load >= 0.0
+            && (self.nr_cpus - nr_to_free) as f64 / cpu_pool.nr_cpus as f64
+                >= layer_load / total_load
+        {
+            return Ok(Some(cpus_to_free));
+        }
+
+        if layer_util / self.nr_cpus as f64 >= util_low {
+            return Ok(None);
+        }
+
+        // Can't shrink if losing the CPUs pushes us over @util_high.
+        match self.nr_cpus - nr_to_free {
+            0 => {
+                if layer_util > 0.0 {
+                    return Ok(None);
+                }
+            }
+            nr_left => {
+                if layer_util / nr_left as f64 >= util_high {
+                    return Ok(None);
+                }
+            }
+        }
+
+        return Ok(Some(cpus_to_free));
+    }
+
+    fn shrink_confined_or_grouped(
+        &mut self,
+        cpu_pool: &mut CpuPool,
+        cpus_range: (usize, usize),
+        util_range: (f64, f64),
+        load: (f64, f64),
+        util: (f64, f64),
+        no_load_frac_limit: bool,
+    ) -> Result<bool> {
+        match self.cpus_to_free(
+            cpu_pool,
+            cpus_range,
+            util_range,
+            load,
+            util,
+            no_load_frac_limit,
+        )? {
+            Some(cpus_to_free) => {
+                trace!("freeing CPUs {}", &cpus_to_free);
+                self.nr_cpus -= cpus_to_free.count_ones();
+                self.cpus &= !cpus_to_free.clone();
+                cpu_pool.free(&cpus_to_free)?;
+                Ok(true)
+            }
+            None => Ok(false),
+        }
+    }
+
+    fn resize_confined_or_grouped(
+        &mut self,
+        cpu_pool: &mut CpuPool,
+        cpus_range: Option<(usize, usize)>,
+        util_range: (f64, f64),
+        load: (f64, f64),
+        util: (f64, f64),
+        no_load_frac_limit: bool,
+    ) -> Result<i64> {
+        let cpus_range = cpus_range.unwrap_or((0, std::usize::MAX));
+        let mut adjusted = 0;
+
+        while self.grow_confined_or_grouped(
+            cpu_pool,
+            cpus_range,
+            util_range,
+            load,
+            util,
+            no_load_frac_limit,
+        )? {
+            adjusted += 1;
+            trace!("{} grew, adjusted={}", &self.name, adjusted);
+        }
+
+        if adjusted == 0 {
+            while self.shrink_confined_or_grouped(
+                cpu_pool,
+                cpus_range,
+                util_range,
+                load,
+                util,
+                no_load_frac_limit,
+            )? {
+                adjusted -= 1;
+                trace!("{} shrunk, adjusted={}", &self.name, adjusted);
+            }
+        }
+
+        if adjusted != 0 {
+            trace!("{} done resizing, adjusted={}", &self.name, adjusted);
+        }
+        Ok(adjusted)
+    }
+}
+
+struct Scheduler<'a> {
+    skel: LayeredSkel<'a>,
+    struct_ops: Option<libbpf_rs::Link>,
+    layer_specs: Vec<LayerSpec>,
+
+    sched_intv: Duration,
+    monitor_intv: Duration,
+    no_load_frac_limit: bool,
+
+    cpu_pool: CpuPool,
+    layers: Vec<Layer>,
+
+    proc_reader: procfs::ProcReader,
+    sched_stats: Stats,
+    report_stats: Stats,
+
+    nr_layer_cpus_min_max: Vec<(usize, usize)>,
+    processing_dur: Duration,
+    prev_processing_dur: Duration,
+}
+
+impl<'a> Scheduler<'a> {
+    fn init_layers(skel: &mut OpenLayeredSkel, specs: &Vec<LayerSpec>) -> Result<()> {
+        skel.rodata().nr_layers = specs.len() as u32;
+
+        for (spec_i, spec) in specs.iter().enumerate() {
+            let layer = &mut skel.bss().layers[spec_i];
+
+            for (or_i, or) in spec.matches.iter().enumerate() {
+                for (and_i, and) in or.iter().enumerate() {
+                    let mt = &mut layer.matches[or_i].matches[and_i];
+                    match and {
+                        LayerMatch::CgroupPrefix(prefix) => {
+                            mt.kind = layered_sys::layer_match_kind_MATCH_CGROUP_PREFIX as i32;
+                            copy_into_cstr(&mut mt.cgroup_prefix, prefix.as_str());
+                        }
+                        LayerMatch::CommPrefix(prefix) => {
+                            mt.kind = layered_sys::layer_match_kind_MATCH_COMM_PREFIX as i32;
+                            copy_into_cstr(&mut mt.comm_prefix, prefix.as_str());
+                        }
+                        LayerMatch::NiceAbove(nice) => {
+                            mt.kind = layered_sys::layer_match_kind_MATCH_NICE_ABOVE as i32;
+                            mt.nice_above_or_below = *nice;
+                        }
+                        LayerMatch::NiceBelow(nice) => {
+                            mt.kind = layered_sys::layer_match_kind_MATCH_NICE_BELOW as i32;
+                            mt.nice_above_or_below = *nice;
+                        }
+                    }
+                }
+                layer.matches[or_i].nr_match_ands = or.len() as i32;
+            }
+
+            layer.nr_match_ors = spec.matches.len() as u32;
+
+            match &spec.kind {
+                LayerKind::Open { preempt } | LayerKind::Grouped { preempt, .. } => {
+                    layer.open = true;
+                    layer.preempt = *preempt;
+                }
+                _ => {}
+            }
+        }
+
+        Ok(())
+    }
+
+    fn init(opts: &Opts, layer_specs: Vec<LayerSpec>) -> Result<Self> {
+        let nr_layers = layer_specs.len();
+        let mut cpu_pool = CpuPool::new()?;
+
+        // Open the BPF prog first for verification.
+        let mut skel_builder = LayeredSkelBuilder::default();
+        skel_builder.obj_builder.debug(opts.verbose > 1);
+        let mut skel = skel_builder.open().context("Failed to open BPF program")?;
+
+        // Initialize skel according to @opts.
+        skel.rodata().debug = opts.verbose as u32;
+        skel.rodata().slice_ns = opts.slice_us * 1000;
+        skel.rodata().nr_possible_cpus = *NR_POSSIBLE_CPUS as u32;
+        skel.rodata().smt_enabled = cpu_pool.nr_cpus > cpu_pool.nr_cores;
+        for cpu in cpu_pool.all_cpus.iter_ones() {
+            skel.rodata().all_cpus[cpu / 8] |= 1 << (cpu % 8);
+        }
+        Self::init_layers(&mut skel, &layer_specs)?;
+
+        // Attach.
+        let mut skel = skel.load().context("Failed to load BPF program")?;
+        skel.attach().context("Failed to attach BPF program")?;
+        let struct_ops = Some(
+            skel.maps_mut()
+                .layered()
+                .attach_struct_ops()
+                .context("Failed to attach layered struct ops")?,
+        );
+        info!("Layered Scheduler Attached");
+
+        let mut layers = vec![];
+        for spec in layer_specs.iter() {
+            layers.push(Layer::new(&mut cpu_pool, &spec.name, spec.kind.clone())?);
+        }
+
+        // Other stuff.
+        let proc_reader = procfs::ProcReader::new();
+
+        Ok(Self {
+            struct_ops, // should be held to keep it attached
+            layer_specs,
+
+            sched_intv: Duration::from_secs_f64(opts.interval),
+            monitor_intv: Duration::from_secs_f64(opts.monitor),
+            no_load_frac_limit: opts.no_load_frac_limit,
+
+            cpu_pool,
+            layers,
+
+            sched_stats: Stats::new(&mut skel, &proc_reader)?,
+            report_stats: Stats::new(&mut skel, &proc_reader)?,
+
+            nr_layer_cpus_min_max: vec![(0, 0); nr_layers],
+            processing_dur: Duration::from_millis(0),
+            prev_processing_dur: Duration::from_millis(0),
+
+            proc_reader,
+            skel,
+        })
+    }
+
+    fn update_bpf_layer_cpumask(layer: &Layer, bpf_layer: &mut layered_bss_types::layer) {
+        for bit in 0..layer.cpus.len() {
+            if layer.cpus[bit] {
+                bpf_layer.cpus[bit / 8] |= 1 << (bit % 8);
+            } else {
+                bpf_layer.cpus[bit / 8] &= !(1 << (bit % 8));
+            }
+        }
+        bpf_layer.refresh_cpus = 1;
+    }
+
+    fn step(&mut self) -> Result<()> {
+        let started_at = Instant::now();
+        self.sched_stats
+            .refresh(&mut self.skel, &self.proc_reader, started_at)?;
+        let mut updated = false;
+
+        for idx in 0..self.layers.len() {
+            match self.layers[idx].kind {
+                LayerKind::Confined {
+                    cpus_range,
+                    util_range,
+                }
+                | LayerKind::Grouped {
+                    cpus_range,
+                    util_range,
+                    ..
+                } => {
+                    let load = (
+                        self.sched_stats.layer_loads[idx],
+                        self.sched_stats.total_load,
+                    );
+                    let util = (
+                        self.sched_stats.layer_utils[idx],
+                        self.sched_stats.total_util,
+                    );
+                    if self.layers[idx].resize_confined_or_grouped(
+                        &mut self.cpu_pool,
+                        cpus_range,
+                        util_range,
+                        load,
+                        util,
+                        self.no_load_frac_limit,
+                    )? != 0
+                    {
+                        Self::update_bpf_layer_cpumask(
+                            &self.layers[idx],
+                            &mut self.skel.bss().layers[idx],
+                        );
+                        updated = true;
+                    }
+                }
+                _ => {}
+            }
+        }
+
+        if updated {
+            let available_cpus = self.cpu_pool.available_cpus();
+            let nr_available_cpus = available_cpus.count_ones();
+            for idx in 0..self.layers.len() {
+                let layer = &mut self.layers[idx];
+                let bpf_layer = &mut self.skel.bss().layers[idx];
+                match &layer.kind {
+                    LayerKind::Open { .. } => {
+                        layer.cpus.copy_from_bitslice(&available_cpus);
+                        layer.nr_cpus = nr_available_cpus;
+                        Self::update_bpf_layer_cpumask(layer, bpf_layer);
+                    }
+                    _ => {}
+                }
+            }
+
+            self.skel.bss().fallback_cpu = self.cpu_pool.fallback_cpu as u32;
+
+            for (lidx, layer) in self.layers.iter().enumerate() {
+                self.nr_layer_cpus_min_max[lidx] = (
+                    self.nr_layer_cpus_min_max[lidx].0.min(layer.nr_cpus),
+                    self.nr_layer_cpus_min_max[lidx].1.max(layer.nr_cpus),
+                );
+            }
+        }
+
+        self.processing_dur += Instant::now().duration_since(started_at);
+        Ok(())
+    }
+
+    fn report(&mut self) -> Result<()> {
+        let started_at = Instant::now();
+        self.report_stats
+            .refresh(&mut self.skel, &self.proc_reader, started_at)?;
+        let stats = &self.report_stats;
+
+        let processing_dur = self.processing_dur - self.prev_processing_dur;
+        self.prev_processing_dur = self.processing_dur;
+
+        let lsum = |idx| stats.bpf_stats.lstats_sums[idx as usize];
+        let total = lsum(layered_sys::layer_stat_idx_LSTAT_LOCAL)
+            + lsum(layered_sys::layer_stat_idx_LSTAT_GLOBAL);
+        let lsum_pct = |idx| {
+            if total != 0 {
+                lsum(idx) as f64 / total as f64 * 100.0
+            } else {
+                0.0
+            }
+        };
+
+        info!(
+            "tot={:7} local={:5.2} open_idle={:5.2} affn_viol={:5.2} tctx_err={} proc={:?}ms",
+            total,
+            lsum_pct(layered_sys::layer_stat_idx_LSTAT_LOCAL),
+            lsum_pct(layered_sys::layer_stat_idx_LSTAT_OPEN_IDLE),
+            lsum_pct(layered_sys::layer_stat_idx_LSTAT_AFFN_VIOL),
+            stats.prev_bpf_stats.gstats
+                [layered_sys::global_stat_idx_GSTAT_TASK_CTX_FREE_FAILED as usize],
+            processing_dur.as_millis(),
+        );
+
+        info!(
+            "busy={:5.1} util={:7.1} load={:9.1} fallback_cpu={:3}",
+            stats.cpu_busy * 100.0,
+            stats.total_util * 100.0,
+            stats.total_load,
+            self.cpu_pool.fallback_cpu,
+        );
+
+        let header_width = self
+            .layer_specs
+            .iter()
+            .map(|spec| spec.name.len())
+            .max()
+            .unwrap()
+            .max(4);
+
+        let calc_frac = |a, b| {
+            if b != 0.0 { a / b * 100.0 } else { 0.0 }
+        };
+
+        for (lidx, (spec, layer)) in self.layer_specs.iter().zip(self.layers.iter()).enumerate() {
+            let lstat = |sidx| stats.bpf_stats.lstats[lidx][sidx as usize];
+            let ltotal = lstat(layered_sys::layer_stat_idx_LSTAT_LOCAL)
+                + lstat(layered_sys::layer_stat_idx_LSTAT_GLOBAL);
+            let lstat_pct = |sidx| {
+                if ltotal != 0 {
+                    lstat(sidx) as f64 / ltotal as f64 * 100.0
+                } else {
+                    0.0
+                }
+            };
+
+            info!(
+                "  {:<width$}: util/frac={:7.1}/{:5.1} load/frac={:9.1}:{:5.1} tasks={:6}",
+                spec.name,
+                stats.layer_utils[lidx] * 100.0,
+                calc_frac(stats.layer_utils[lidx], stats.total_util),
+                stats.layer_loads[lidx],
+                calc_frac(stats.layer_loads[lidx], stats.total_load),
+                stats.nr_layer_tasks[lidx],
+                width = header_width,
+            );
+            info!(
+                "  {:<width$}  tot={:7} local={:5.2} open_idle={:5.2} preempt={:5.2} affn_viol={:5.2}",
+                "",
+                ltotal,
+                lstat_pct(layered_sys::layer_stat_idx_LSTAT_LOCAL),
+                lstat_pct(layered_sys::layer_stat_idx_LSTAT_OPEN_IDLE),
+                lstat_pct(layered_sys::layer_stat_idx_LSTAT_PREEMPT),
+                lstat_pct(layered_sys::layer_stat_idx_LSTAT_AFFN_VIOL),
+                width = header_width,
+            );
+            info!(
+                "  {:<width$}  cpus={:3} [{:3},{:3}] {}",
+                "",
+                layer.nr_cpus,
+                self.nr_layer_cpus_min_max[lidx].0,
+                self.nr_layer_cpus_min_max[lidx].1,
+                format_bitvec(&layer.cpus),
+                width = header_width
+            );
+            self.nr_layer_cpus_min_max[lidx] = (layer.nr_cpus, layer.nr_cpus);
+        }
+
+        self.processing_dur += Instant::now().duration_since(started_at);
+        Ok(())
+    }
+
+    fn run(&mut self, shutdown: Arc<AtomicBool>) -> Result<()> {
+        let now = Instant::now();
+        let mut next_sched_at = now + self.sched_intv;
+        let mut next_monitor_at = now + self.monitor_intv;
+
+        while !shutdown.load(Ordering::Relaxed) && !UserExitInfo::exited(&self.skel.bss().uei)? {
+            let now = Instant::now();
+
+            if now >= next_sched_at {
+                self.step()?;
+                while next_sched_at < now {
+                    next_sched_at += self.sched_intv;
+                }
+            }
+
+            if now >= next_monitor_at {
+                self.report()?;
+                while next_monitor_at < now {
+                    next_monitor_at += self.monitor_intv;
+                }
+            }
+
+            std::thread::sleep(
+                next_sched_at
+                    .min(next_monitor_at)
+                    .duration_since(Instant::now()),
+            );
+        }
+
+        self.struct_ops.take();
+        UserExitInfo::read(&self.skel.bss().uei)?.report()
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
+fn write_example_file(path: &str) -> Result<()> {
+    let example = LayerConfig {
+        specs: vec![
+            LayerSpec {
+                name: "batch".into(),
+                comment: Some("tasks under system.slice or tasks with nice value > 0".into()),
+                matches: vec![
+                    vec![LayerMatch::CgroupPrefix("system.slice/".into())],
+                    vec![LayerMatch::NiceAbove(0)],
+                ],
+                kind: LayerKind::Confined {
+                    cpus_range: Some((0, 16)),
+                    util_range: (0.8, 0.9),
+                },
+            },
+            LayerSpec {
+                name: "immediate".into(),
+                comment: Some("tasks under workload.slice with nice value < 0".into()),
+                matches: vec![vec![
+                    LayerMatch::CgroupPrefix("workload.slice/".into()),
+                    LayerMatch::NiceBelow(0),
+                ]],
+                kind: LayerKind::Open { preempt: true },
+            },
+            LayerSpec {
+                name: "normal".into(),
+                comment: Some("the rest".into()),
+                matches: vec![vec![]],
+                kind: LayerKind::Grouped {
+                    cpus_range: None,
+                    util_range: (0.5, 0.6),
+                    preempt: false,
+                },
+            },
+        ],
+    };
+
+    let mut f = fs::OpenOptions::new()
+        .create_new(true)
+        .write(true)
+        .open(path)?;
+    Ok(f.write_all(serde_json::to_string_pretty(&example)?.as_bytes())?)
+}
+
+fn verify_layer_specs(specs: &[LayerSpec]) -> Result<()> {
+    let nr_specs = specs.len();
+    if nr_specs == 0 {
+        bail!("No layer spec");
+    }
+    if nr_specs > MAX_LAYERS {
+        bail!("Too many layer specs");
+    }
+
+    for (idx, spec) in specs.iter().enumerate() {
+        if idx < nr_specs - 1 {
+            if spec.matches.len() == 0 {
+                bail!("Non-terminal spec {:?} has NULL matches", spec.name);
+            }
+        } else {
+            if spec.matches.len() != 1 || spec.matches[0].len() != 0 {
+                bail!("Terminal spec {:?} must have an empty match", spec.name);
+            }
+        }
+
+        if spec.matches.len() > MAX_LAYER_MATCH_ORS {
+            bail!(
+                "Spec {:?} has too many ({}) OR match blocks",
+                spec.name,
+                spec.matches.len()
+            );
+        }
+
+        for (ands_idx, ands) in spec.matches.iter().enumerate() {
+            if ands.len() > NR_LAYER_MATCH_KINDS {
+                bail!(
+                    "Spec {:?}'s {}th OR block has too many ({}) match conditions",
+                    spec.name,
+                    ands_idx,
+                    ands.len()
+                );
+            }
+            for one in ands.iter() {
+                match one {
+                    LayerMatch::CgroupPrefix(prefix) => {
+                        if prefix.len() > MAX_PATH {
+                            bail!("Spec {:?} has too long a cgroup prefix", spec.name);
+                        }
+                    }
+                    LayerMatch::CommPrefix(prefix) => {
+                        if prefix.len() > MAX_COMM {
+                            bail!("Spec {:?} has too long a comm prefix", spec.name);
+                        }
+                    }
+                    _ => {}
+                }
+            }
+        }
+
+        match spec.kind {
+            LayerKind::Confined {
+                cpus_range,
+                util_range,
+            }
+            | LayerKind::Grouped {
+                cpus_range,
+                util_range,
+                ..
+            } => {
+                if let Some((cpus_min, cpus_max)) = cpus_range {
+                    if cpus_min > cpus_max {
+                        bail!(
+                            "Spec {:?} has invalid cpus_range({}, {})",
+                            spec.name,
+                            cpus_min,
+                            cpus_max
+                        );
+                    }
+                }
+                if util_range.0 >= util_range.1 {
+                    bail!(
+                        "Spec {:?} has invalid util_range ({}, {})",
+                        spec.name,
+                        util_range.0,
+                        util_range.1
+                    );
+                }
+            }
+            _ => {}
+        }
+    }
+
+    Ok(())
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
+    debug!("opts={:?}", &opts);
+
+    if let Some(path) = &opts.example {
+        write_example_file(path)?;
+        return Ok(());
+    }
+
+    let mut layer_config = LayerConfig { specs: vec![] };
+    for (idx, input) in opts.specs.iter().enumerate() {
+        layer_config.specs.append(
+            &mut LayerSpec::parse(input)
+                .context(format!("Failed to parse specs[{}] ({:?})", idx, input))?,
+        );
+    }
+
+    debug!("specs={}", serde_json::to_string_pretty(&layer_config)?);
+    verify_layer_specs(&layer_config.specs)?;
+
+    let mut sched = Scheduler::init(&opts, layer_config.specs)?;
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
-- 
2.42.0


