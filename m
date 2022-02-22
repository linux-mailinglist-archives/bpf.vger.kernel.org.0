Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A61A4BFFAC
	for <lists+bpf@lfdr.de>; Tue, 22 Feb 2022 18:06:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234519AbiBVRHO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 22 Feb 2022 12:07:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234529AbiBVRHK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 22 Feb 2022 12:07:10 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95EE15FF7;
        Tue, 22 Feb 2022 09:06:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id BE246CE13BB;
        Tue, 22 Feb 2022 17:06:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7356C340E8;
        Tue, 22 Feb 2022 17:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645549598;
        bh=IoPx8xQlUVqfSVxrA4rRVfDSjrO1Pqa9sU88ZlyIxuA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PcED5mzMu1PBUrd7S7dJ8s3e4DaKvLRi/PSRjxUPX904UklnLQz76tVEpDQSjCaCz
         UHZuIBvNg2FMR1GxJBGf9SO59azLLerufBbF39WEGzEFVmDu+2OQ/m5tyJ5eRve8cX
         XYCfUDF0yyoQOGpVRxox7jd3JB0YaCHIW3YY0RO26xcKr2903HaTP+uHdqIKwJiAH9
         7vgHjTXgsSrtLoN2BY4KIsoUeTIWDh1rFDXJR/FcHEZ4ThK6nMvwXgb/WTS9nTjlGS
         mVDKGZFG3zBV9Ijtsjwo2FouHXARm+9Sl8KVAJL4xDkhPhoRM1QNDM7gOWTLNA/1wx
         tsw5HE1Rr1Q1Q==
From:   Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH 02/10] bpf: Add multi kprobe link
Date:   Tue, 22 Feb 2022 18:05:52 +0100
Message-Id: <20220222170600.611515-3-jolsa@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220222170600.611515-1-jolsa@kernel.org>
References: <20220222170600.611515-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Adding new link type BPF_LINK_TYPE_KPROBE_MULTI that attaches kprobe
program through fprobe API.

The fprobe API allows to attach probe on multiple functions at once
very fast, because it works on top of ftrace. On the other hand this
limits the probe point to the function entry or return.

The kprobe program gets the same pt_regs input ctx as when it's attached
through the perf API.

Adding new attach type BPF_TRACE_KPROBE_MULTI that allows attachment
kprobe to multiple function with new link.

User provides array of addresses or symbols with count to attach the
kprobe program to. The new link_create uapi interface looks like:

  struct {
          __aligned_u64   syms;
          __aligned_u64   addrs;
          __u32           cnt;
          __u32           flags;
  } kprobe_multi;

The flags field allows single BPF_TRACE_KPROBE_MULTI bit to create
return multi kprobe.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 include/linux/bpf_types.h      |   1 +
 include/linux/trace_events.h   |   6 +
 include/uapi/linux/bpf.h       |  13 ++
 kernel/bpf/syscall.c           |  26 +++-
 kernel/trace/bpf_trace.c       | 211 +++++++++++++++++++++++++++++++++
 tools/include/uapi/linux/bpf.h |  13 ++
 6 files changed, 265 insertions(+), 5 deletions(-)

diff --git a/include/linux/bpf_types.h b/include/linux/bpf_types.h
index 48a91c51c015..3e24ad0c4b3c 100644
--- a/include/linux/bpf_types.h
+++ b/include/linux/bpf_types.h
@@ -140,3 +140,4 @@ BPF_LINK_TYPE(BPF_LINK_TYPE_XDP, xdp)
 #ifdef CONFIG_PERF_EVENTS
 BPF_LINK_TYPE(BPF_LINK_TYPE_PERF_EVENT, perf)
 #endif
+BPF_LINK_TYPE(BPF_LINK_TYPE_KPROBE_MULTI, kprobe_multi)
diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index 70c069aef02c..29f8e66929c7 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -736,6 +736,7 @@ void bpf_put_raw_tracepoint(struct bpf_raw_event_map *btp);
 int bpf_get_perf_event_info(const struct perf_event *event, u32 *prog_id,
 			    u32 *fd_type, const char **buf,
 			    u64 *probe_offset, u64 *probe_addr);
+int bpf_kprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *prog);
 #else
 static inline unsigned int trace_call_bpf(struct trace_event_call *call, void *ctx)
 {
@@ -777,6 +778,11 @@ static inline int bpf_get_perf_event_info(const struct perf_event *event,
 {
 	return -EOPNOTSUPP;
 }
+static inline int
+bpf_kprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *prog)
+{
+	return -EOPNOTSUPP;
+}
 #endif
 
 enum {
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index afe3d0d7f5f2..6c66138c1b9b 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -997,6 +997,7 @@ enum bpf_attach_type {
 	BPF_SK_REUSEPORT_SELECT,
 	BPF_SK_REUSEPORT_SELECT_OR_MIGRATE,
 	BPF_PERF_EVENT,
+	BPF_TRACE_KPROBE_MULTI,
 	__MAX_BPF_ATTACH_TYPE
 };
 
@@ -1011,6 +1012,7 @@ enum bpf_link_type {
 	BPF_LINK_TYPE_NETNS = 5,
 	BPF_LINK_TYPE_XDP = 6,
 	BPF_LINK_TYPE_PERF_EVENT = 7,
+	BPF_LINK_TYPE_KPROBE_MULTI = 8,
 
 	MAX_BPF_LINK_TYPE,
 };
@@ -1118,6 +1120,11 @@ enum bpf_link_type {
  */
 #define BPF_F_XDP_HAS_FRAGS	(1U << 5)
 
+/* link_create.kprobe_multi.flags used in LINK_CREATE command for
+ * BPF_TRACE_KPROBE_MULTI attach type to create return probe.
+ */
+#define BPF_F_KPROBE_MULTI_RETURN	(1U << 0)
+
 /* When BPF ldimm64's insn[0].src_reg != 0 then this can have
  * the following extensions:
  *
@@ -1472,6 +1479,12 @@ union bpf_attr {
 				 */
 				__u64		bpf_cookie;
 			} perf_event;
+			struct {
+				__aligned_u64	syms;
+				__aligned_u64	addrs;
+				__u32		cnt;
+				__u32		flags;
+			} kprobe_multi;
 		};
 	} link_create;
 
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 9c7a72b65eee..bf76c04597b5 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -32,6 +32,7 @@
 #include <linux/bpf-netns.h>
 #include <linux/rcupdate_trace.h>
 #include <linux/memcontrol.h>
+#include <linux/trace_events.h>
 
 #define IS_FD_ARRAY(map) ((map)->map_type == BPF_MAP_TYPE_PERF_EVENT_ARRAY || \
 			  (map)->map_type == BPF_MAP_TYPE_CGROUP_ARRAY || \
@@ -3022,6 +3023,11 @@ static int bpf_perf_link_attach(const union bpf_attr *attr, struct bpf_prog *pro
 	fput(perf_file);
 	return err;
 }
+#else
+static int bpf_perf_link_attach(const union bpf_attr *attr, struct bpf_prog *prog)
+{
+	return -EOPNOTSUPP;
+}
 #endif /* CONFIG_PERF_EVENTS */
 
 #define BPF_RAW_TRACEPOINT_OPEN_LAST_FIELD raw_tracepoint.prog_fd
@@ -4255,7 +4261,7 @@ static int tracing_bpf_link_attach(const union bpf_attr *attr, bpfptr_t uattr,
 	return -EINVAL;
 }
 
-#define BPF_LINK_CREATE_LAST_FIELD link_create.iter_info_len
+#define BPF_LINK_CREATE_LAST_FIELD link_create.kprobe_multi.flags
 static int link_create(union bpf_attr *attr, bpfptr_t uattr)
 {
 	enum bpf_prog_type ptype;
@@ -4279,7 +4285,6 @@ static int link_create(union bpf_attr *attr, bpfptr_t uattr)
 		ret = tracing_bpf_link_attach(attr, uattr, prog);
 		goto out;
 	case BPF_PROG_TYPE_PERF_EVENT:
-	case BPF_PROG_TYPE_KPROBE:
 	case BPF_PROG_TYPE_TRACEPOINT:
 		if (attr->link_create.attach_type != BPF_PERF_EVENT) {
 			ret = -EINVAL;
@@ -4287,6 +4292,14 @@ static int link_create(union bpf_attr *attr, bpfptr_t uattr)
 		}
 		ptype = prog->type;
 		break;
+	case BPF_PROG_TYPE_KPROBE:
+		if (attr->link_create.attach_type != BPF_PERF_EVENT &&
+		    attr->link_create.attach_type != BPF_TRACE_KPROBE_MULTI) {
+			ret = -EINVAL;
+			goto out;
+		}
+		ptype = prog->type;
+		break;
 	default:
 		ptype = attach_type_to_prog_type(attr->link_create.attach_type);
 		if (ptype == BPF_PROG_TYPE_UNSPEC || ptype != prog->type) {
@@ -4318,13 +4331,16 @@ static int link_create(union bpf_attr *attr, bpfptr_t uattr)
 		ret = bpf_xdp_link_attach(attr, prog);
 		break;
 #endif
-#ifdef CONFIG_PERF_EVENTS
 	case BPF_PROG_TYPE_PERF_EVENT:
 	case BPF_PROG_TYPE_TRACEPOINT:
-	case BPF_PROG_TYPE_KPROBE:
 		ret = bpf_perf_link_attach(attr, prog);
 		break;
-#endif
+	case BPF_PROG_TYPE_KPROBE:
+		if (attr->link_create.attach_type == BPF_PERF_EVENT)
+			ret = bpf_perf_link_attach(attr, prog);
+		else
+			ret = bpf_kprobe_multi_link_attach(attr, prog);
+		break;
 	default:
 		ret = -EINVAL;
 	}
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index a2024ba32a20..df3771bfd6e5 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -17,6 +17,7 @@
 #include <linux/error-injection.h>
 #include <linux/btf_ids.h>
 #include <linux/bpf_lsm.h>
+#include <linux/fprobe.h>
 
 #include <net/bpf_sk_storage.h>
 
@@ -2181,3 +2182,213 @@ static int __init bpf_event_init(void)
 
 fs_initcall(bpf_event_init);
 #endif /* CONFIG_MODULES */
+
+#ifdef CONFIG_FPROBE
+struct bpf_kprobe_multi_link {
+	struct bpf_link link;
+	struct fprobe fp;
+	unsigned long *addrs;
+};
+
+static void bpf_kprobe_multi_link_release(struct bpf_link *link)
+{
+	struct bpf_kprobe_multi_link *kmulti_link;
+
+	kmulti_link = container_of(link, struct bpf_kprobe_multi_link, link);
+	unregister_fprobe(&kmulti_link->fp);
+}
+
+static void bpf_kprobe_multi_link_dealloc(struct bpf_link *link)
+{
+	struct bpf_kprobe_multi_link *kmulti_link;
+
+	kmulti_link = container_of(link, struct bpf_kprobe_multi_link, link);
+	kvfree(kmulti_link->addrs);
+	kfree(kmulti_link);
+}
+
+static const struct bpf_link_ops bpf_kprobe_multi_link_lops = {
+	.release = bpf_kprobe_multi_link_release,
+	.dealloc = bpf_kprobe_multi_link_dealloc,
+};
+
+static int
+kprobe_multi_link_prog_run(struct bpf_kprobe_multi_link *link,
+			   struct pt_regs *regs)
+{
+	int err;
+
+	if (unlikely(__this_cpu_inc_return(bpf_prog_active) != 1)) {
+		err = 0;
+		goto out;
+	}
+
+	rcu_read_lock();
+	migrate_disable();
+	err = bpf_prog_run(link->link.prog, regs);
+	migrate_enable();
+	rcu_read_unlock();
+
+ out:
+	__this_cpu_dec(bpf_prog_active);
+	return err;
+}
+
+static void
+kprobe_multi_link_handler(struct fprobe *fp, unsigned long entry_ip,
+			  struct pt_regs *regs)
+{
+	unsigned long saved_ip = instruction_pointer(regs);
+	struct bpf_kprobe_multi_link *link;
+
+	/*
+	 * Because fprobe's regs->ip is set to the next instruction of
+	 * dynamic-ftrace instruction, correct entry ip must be set, so
+	 * that the bpf program can access entry address via regs as same
+	 * as kprobes.
+	 */
+	instruction_pointer_set(regs, entry_ip);
+
+	link = container_of(fp, struct bpf_kprobe_multi_link, fp);
+	kprobe_multi_link_prog_run(link, regs);
+
+	instruction_pointer_set(regs, saved_ip);
+}
+
+static int
+kprobe_multi_resolve_syms(const void *usyms, u32 cnt,
+			  unsigned long *addrs)
+{
+	unsigned long addr, size;
+	const char **syms;
+	int err = -ENOMEM;
+	unsigned int i;
+	char *func;
+
+	size = cnt * sizeof(*syms);
+	syms = kvzalloc(size, GFP_KERNEL);
+	if (!syms)
+		return -ENOMEM;
+
+	func = kmalloc(KSYM_NAME_LEN, GFP_KERNEL);
+	if (!func)
+		goto error;
+
+	if (copy_from_user(syms, usyms, size)) {
+		err = -EFAULT;
+		goto error;
+	}
+
+	for (i = 0; i < cnt; i++) {
+		err = strncpy_from_user(func, syms[i], KSYM_NAME_LEN);
+		if (err == KSYM_NAME_LEN)
+			err = -E2BIG;
+		if (err < 0)
+			goto error;
+
+		err = -EINVAL;
+		if (func[0] == '\0')
+			goto error;
+		addr = kallsyms_lookup_name(func);
+		if (!addr)
+			goto error;
+		if (!kallsyms_lookup_size_offset(addr, &size, NULL))
+			size = MCOUNT_INSN_SIZE;
+		addr = ftrace_location_range(addr, addr + size - 1);
+		if (!addr)
+			goto error;
+		addrs[i] = addr;
+	}
+
+	err = 0;
+error:
+	kvfree(syms);
+	kfree(func);
+	return err;
+}
+
+int bpf_kprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *prog)
+{
+	struct bpf_kprobe_multi_link *link = NULL;
+	struct bpf_link_primer link_primer;
+	unsigned long *addrs;
+	u32 flags, cnt, size;
+	void __user *uaddrs;
+	void __user *usyms;
+	int err;
+
+	/* no support for 32bit archs yet */
+	if (sizeof(u64) != sizeof(void *))
+		return -EOPNOTSUPP;
+
+	if (prog->expected_attach_type != BPF_TRACE_KPROBE_MULTI)
+		return -EINVAL;
+
+	flags = attr->link_create.kprobe_multi.flags;
+	if (flags & ~BPF_F_KPROBE_MULTI_RETURN)
+		return -EINVAL;
+
+	uaddrs = u64_to_user_ptr(attr->link_create.kprobe_multi.addrs);
+	usyms = u64_to_user_ptr(attr->link_create.kprobe_multi.syms);
+	if (!!uaddrs == !!usyms)
+		return -EINVAL;
+
+	cnt = attr->link_create.kprobe_multi.cnt;
+	if (!cnt)
+		return -EINVAL;
+
+	size = cnt * sizeof(*addrs);
+	addrs = kvmalloc(size, GFP_KERNEL);
+	if (!addrs)
+		return -ENOMEM;
+
+	if (uaddrs) {
+		if (copy_from_user(addrs, uaddrs, size)) {
+			err = -EFAULT;
+			goto error;
+		}
+	} else {
+		err = kprobe_multi_resolve_syms(usyms, cnt, addrs);
+		if (err)
+			goto error;
+	}
+
+	link = kzalloc(sizeof(*link), GFP_KERNEL);
+	if (!link) {
+		err = -ENOMEM;
+		goto error;
+	}
+
+	bpf_link_init(&link->link, BPF_LINK_TYPE_KPROBE_MULTI,
+		      &bpf_kprobe_multi_link_lops, prog);
+
+	err = bpf_link_prime(&link->link, &link_primer);
+	if (err)
+		goto error;
+
+	if (flags & BPF_F_KPROBE_MULTI_RETURN)
+		link->fp.exit_handler = kprobe_multi_link_handler;
+	else
+		link->fp.entry_handler = kprobe_multi_link_handler;
+
+	link->addrs = addrs;
+
+	err = register_fprobe_ips(&link->fp, addrs, cnt);
+	if (err) {
+		bpf_link_cleanup(&link_primer);
+		return err;
+	}
+
+	return bpf_link_settle(&link_primer);
+
+error:
+	kfree(link);
+	kvfree(addrs);
+	return err;
+}
+#else /* !CONFIG_FPROBE */
+int bpf_kprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *prog)
+{
+	return -EOPNOTSUPP;
+}
+#endif
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index afe3d0d7f5f2..6c66138c1b9b 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -997,6 +997,7 @@ enum bpf_attach_type {
 	BPF_SK_REUSEPORT_SELECT,
 	BPF_SK_REUSEPORT_SELECT_OR_MIGRATE,
 	BPF_PERF_EVENT,
+	BPF_TRACE_KPROBE_MULTI,
 	__MAX_BPF_ATTACH_TYPE
 };
 
@@ -1011,6 +1012,7 @@ enum bpf_link_type {
 	BPF_LINK_TYPE_NETNS = 5,
 	BPF_LINK_TYPE_XDP = 6,
 	BPF_LINK_TYPE_PERF_EVENT = 7,
+	BPF_LINK_TYPE_KPROBE_MULTI = 8,
 
 	MAX_BPF_LINK_TYPE,
 };
@@ -1118,6 +1120,11 @@ enum bpf_link_type {
  */
 #define BPF_F_XDP_HAS_FRAGS	(1U << 5)
 
+/* link_create.kprobe_multi.flags used in LINK_CREATE command for
+ * BPF_TRACE_KPROBE_MULTI attach type to create return probe.
+ */
+#define BPF_F_KPROBE_MULTI_RETURN	(1U << 0)
+
 /* When BPF ldimm64's insn[0].src_reg != 0 then this can have
  * the following extensions:
  *
@@ -1472,6 +1479,12 @@ union bpf_attr {
 				 */
 				__u64		bpf_cookie;
 			} perf_event;
+			struct {
+				__aligned_u64	syms;
+				__aligned_u64	addrs;
+				__u32		cnt;
+				__u32		flags;
+			} kprobe_multi;
 		};
 	} link_create;
 
-- 
2.35.1

