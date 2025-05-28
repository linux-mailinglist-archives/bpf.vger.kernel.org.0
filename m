Return-Path: <bpf+bounces-59103-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A2AC9AC6067
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 05:54:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C41E1BC2E20
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 03:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56FBE1F1507;
	Wed, 28 May 2025 03:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O1k0LxWX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f68.google.com (mail-pj1-f68.google.com [209.85.216.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4C321B185;
	Wed, 28 May 2025 03:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748404209; cv=none; b=WF1f/BlmZI9W87QT2Hmj/OBLQWyI7aVbTqw+bj5VY8GVZp40VBGw2weV+ozNftSo96YNbbtWPy+GGrJ1t3oMeHXWEL4hfJG+jLuJUduD27YDkiMwlTJeQkB8Hyp1MRqRB42PrWKGvkITPgBFQGT6pnDPuzCXHV57XBBeTBVW/7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748404209; c=relaxed/simple;
	bh=+GQpoZXDPO7rGQs0NfF2G75ig1nN7rowJn5wSET/d3o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WRLd1e4GMSxjLNcGMUpFdt9EzNt3kcTcupdWYUv93bduuC1iWKqXDQVSrzkByUkrw//8rC9ftgLlyIyRPKRTx7y7jpmmowv9j7PCd8XxbBeniJGdtWSqMrCqZqTHapo9BWxmQYGO6kdnmaKcTtJNl49rwxKTf613uplTflpA5pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O1k0LxWX; arc=none smtp.client-ip=209.85.216.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f68.google.com with SMTP id 98e67ed59e1d1-30e5430ed0bso3878637a91.3;
        Tue, 27 May 2025 20:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748404207; x=1749009007; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pd1iJVXmvy8UHPpKSuMU0wcMCTE7OFRL0Fq7hy/IwPI=;
        b=O1k0LxWXMxcl0CI+buidq8BRWXJCkaQlehoLGkXe52eUnfoEwKzCHbcZw4eJl1P+bM
         M3rz1hJpdU2mkdw/q1P5t03XgkyKhlyQU00G9iYW9A4ZQBE1381l3I0uGgV58C9ykGJS
         3uo5kKvjKSZLCEO+fhQsQWR0vGS6/gDa751q0W1PZcxsz6xt0naj5Jhd09u5Lt/MUhlI
         Fzox184HK++1Ftk8fDgfYxXo3Swu7BsQ11y864sVeNJ7sH/6NKozXMwYkbGudZ0cOjso
         h1dclMy5vTDxme/K8vmMD1IhHBkjpArm/1GlLtNvJTqJ7C+aDr0S+15HeJ7OuAMqv9Vd
         MbKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748404207; x=1749009007;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pd1iJVXmvy8UHPpKSuMU0wcMCTE7OFRL0Fq7hy/IwPI=;
        b=woYFxOBJJnBMd8oKTxunOxXBjVQhHhJgR/6Gakma/dtpz5RULOLfFSJUj1mP1ej7o2
         QxTwv5fYBSXxqk/YdzfPTg1G9tHca7ebESRPf3zhfuu3Yejr7tuKT/2jTP0tN+82k6xO
         oPHQIEsERNhDwM8YUNfL75loDR35kER2boCnLgkQ3ZD9ucHWArTwsqEq8WzMLKb3iBiK
         H95pPhRzI823FKys1i13Kc6FhC38ncMFYgsdf83w8P5hSlfgg7P+BBoPn/cq5YchZcMk
         MVI97LrAVnSLumzFYPa7kiTLSZtlmOdSyKi8xF4pxWK+uCQs9cIBzgiDWKd94FhtgT3n
         oKGg==
X-Forwarded-Encrypted: i=1; AJvYcCXTBHneBZSDjVX0mVxGuPg5uRXbIRdAQTJ7SYtzxGttUH4DgiYcwcy46XWjk2j+xV3O6Y3J1NoKDf/EEDQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUFNNvKOTjPuXZt2/yI/9qAWdXYEmpZYBNs6EB2qze+PqPu5VG
	2d37LVtfgOF8/w/vKB5bmKaTgTEL0FJTei6f+N3MoYPdRTta0UJyNq5W1aGFRmOt
X-Gm-Gg: ASbGncvbmvg+yeinegF/6D28pOrfJn/3NlhzH7BHLz61aZDSFi9PamNPQv7ZHrZPPFV
	BLXB1JAztAGT/jS7KDz51wrXFLCGRD9XZ9YZriKo+qQlG5ViSLMP2Mg1NMEjaJMElLhe81h468/
	/vqTcxA3A8uRpV8uEn6y54lQZeCvBKIJQ5nipiapxgQymYIpQvY/I3myngjM3EVaHSpti5HykoX
	PzO9SSGGo+XQK0MeIkKtI6WCe7iTuxerp/O+72QkqIV45VGdDPtpWc4QNCQ/4eYLc+iTMyAgoaL
	zUqUivSu+/CyzcV0icB76tVEjVx9VVawN3GKGC7t/lw9n4DTm3oyp42v5Kz8lZyG46zC
X-Google-Smtp-Source: AGHT+IE9KH+zIs6JCpp9NMS9hc8oxqAOFu3qZ83LuK5e1fLc5u6ULkMEO9E+4nONeHSydvcsq8VxYA==
X-Received: by 2002:a17:90b:55cb:b0:2ee:ad18:b309 with SMTP id 98e67ed59e1d1-3110f113859mr23293747a91.3.1748404206746;
        Tue, 27 May 2025 20:50:06 -0700 (PDT)
Received: from localhost.localdomain ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-234d35ac417sm2074505ad.169.2025.05.27.20.50.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 May 2025 20:50:06 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: alexei.starovoitov@gmail.com,
	rostedt@goodmis.org,
	jolsa@kernel.org
Cc: bpf@vger.kernel.org,
	Menglong Dong <dongml2@chinatelecom.cn>,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next 14/25] bpf: tracing: add multi-link support
Date: Wed, 28 May 2025 11:47:01 +0800
Message-Id: <20250528034712.138701-15-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250528034712.138701-1-dongml2@chinatelecom.cn>
References: <20250528034712.138701-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In this commit, we add the support to allow attaching a tracing BPF
program to multi hooks, which is similar to BPF_TRACE_KPROBE_MULTI.

The use case is obvious. For now, we have to create a BPF program for each
kernel function, for which we want to trace, even through all the program
have the same (or similar logic). This can consume extra memory, and make
the program loading slow if we have plenty of kernel function to trace.
The KPROBE_MULTI maybe a alternative, but it can't do what TRACING do. For
example, the kretprobe can't obtain the function args, but the FEXIT can.

For now, we support to create multi-link for fentry/fexit/modify_return
with the following new attach types that we introduce:

  BPF_TRACE_FENTRY_MULTI
  BPF_TRACE_FEXIT_MULTI
  BPF_MODIFY_RETURN_MULTI

We introduce the struct bpf_tracing_multi_link for this purpose, which
can hold all the kernel modules, target bpf program (for attaching to bpf
program) or target btf (for attaching to kernel function) that we
referenced.

During loading, the first target is used for verification by the verifer.
And during attaching, we check the consistency of all the targets with
the first target.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 include/linux/bpf.h            |  11 +
 include/linux/bpf_types.h      |   1 +
 include/uapi/linux/bpf.h       |  10 +
 kernel/bpf/btf.c               |   5 +
 kernel/bpf/syscall.c           | 365 +++++++++++++++++++++++++++++++++
 kernel/bpf/trampoline.c        |   7 +-
 kernel/bpf/verifier.c          |  25 ++-
 net/bpf/test_run.c             |   3 +
 net/core/bpf_sk_storage.c      |   2 +
 tools/include/uapi/linux/bpf.h |  10 +
 10 files changed, 435 insertions(+), 4 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 080bb966d026..7191ad25d519 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1802,6 +1802,17 @@ struct bpf_raw_tp_link {
 	u64 cookie;
 };
 
+struct bpf_tracing_multi_link {
+	struct bpf_gtramp_link link;
+	enum bpf_attach_type attach_type;
+	struct bpf_prog **tgt_progs;
+	struct btf **tgt_btfs;
+	struct module **mods;
+	u32 prog_cnt;
+	u32 btf_cnt;
+	u32 mods_cnt;
+};
+
 struct bpf_link_primer {
 	struct bpf_link *link;
 	struct file *file;
diff --git a/include/linux/bpf_types.h b/include/linux/bpf_types.h
index fa78f49d4a9a..139d5436ce4c 100644
--- a/include/linux/bpf_types.h
+++ b/include/linux/bpf_types.h
@@ -154,3 +154,4 @@ BPF_LINK_TYPE(BPF_LINK_TYPE_PERF_EVENT, perf)
 BPF_LINK_TYPE(BPF_LINK_TYPE_KPROBE_MULTI, kprobe_multi)
 BPF_LINK_TYPE(BPF_LINK_TYPE_STRUCT_OPS, struct_ops)
 BPF_LINK_TYPE(BPF_LINK_TYPE_UPROBE_MULTI, uprobe_multi)
+BPF_LINK_TYPE(BPF_LINK_TYPE_TRACING_MULTI, tracing_multi)
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 16e95398c91c..45dfaf40230e 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1120,6 +1120,9 @@ enum bpf_attach_type {
 	BPF_NETKIT_PEER,
 	BPF_TRACE_KPROBE_SESSION,
 	BPF_TRACE_UPROBE_SESSION,
+	BPF_TRACE_FENTRY_MULTI,
+	BPF_TRACE_FEXIT_MULTI,
+	BPF_MODIFY_RETURN_MULTI,
 	__MAX_BPF_ATTACH_TYPE
 };
 
@@ -1144,6 +1147,7 @@ enum bpf_link_type {
 	BPF_LINK_TYPE_UPROBE_MULTI = 12,
 	BPF_LINK_TYPE_NETKIT = 13,
 	BPF_LINK_TYPE_SOCKMAP = 14,
+	BPF_LINK_TYPE_TRACING_MULTI = 15,
 	__MAX_BPF_LINK_TYPE,
 };
 
@@ -1765,6 +1769,12 @@ union bpf_attr {
 				 */
 				__u64		cookie;
 			} tracing;
+			struct {
+				__u32		cnt;
+				__aligned_u64	tgt_fds;
+				__aligned_u64	btf_ids;
+				__aligned_u64	cookies;
+			} tracing_multi;
 			struct {
 				__u32		pf;
 				__u32		hooknum;
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 64538625ee91..03045f7d428f 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6100,6 +6100,9 @@ static int btf_validate_prog_ctx_type(struct bpf_verifier_log *log, const struct
 		case BPF_TRACE_FENTRY:
 		case BPF_TRACE_FEXIT:
 		case BPF_MODIFY_RETURN:
+		case BPF_TRACE_FENTRY_MULTI:
+		case BPF_TRACE_FEXIT_MULTI:
+		case BPF_MODIFY_RETURN_MULTI:
 			/* allow u64* as ctx */
 			if (btf_is_int(t) && t->size == 8)
 				return 0;
@@ -6705,6 +6708,7 @@ bool btf_ctx_access(int off, int size, enum bpf_access_type type,
 			fallthrough;
 		case BPF_LSM_CGROUP:
 		case BPF_TRACE_FEXIT:
+		case BPF_TRACE_FEXIT_MULTI:
 			/* When LSM programs are attached to void LSM hooks
 			 * they use FEXIT trampolines and when attached to
 			 * int LSM hooks, they use MODIFY_RETURN trampolines.
@@ -6723,6 +6727,7 @@ bool btf_ctx_access(int off, int size, enum bpf_access_type type,
 			t = btf_type_by_id(btf, t->type);
 			break;
 		case BPF_MODIFY_RETURN:
+		case BPF_MODIFY_RETURN_MULTI:
 			/* For now the BPF_MODIFY_RETURN can only be attached to
 			 * functions that return an int.
 			 */
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 60865a27d7d3..0cd989381128 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -37,6 +37,7 @@
 #include <linux/trace_events.h>
 #include <linux/tracepoint.h>
 #include <linux/overflow.h>
+#include <linux/kfunc_md.h>
 
 #include <net/netfilter/nf_bpf_link.h>
 #include <net/netkit.h>
@@ -3466,6 +3467,34 @@ static const struct bpf_link_ops bpf_tracing_link_lops = {
 	.fill_link_info = bpf_tracing_link_fill_link_info,
 };
 
+static int bpf_tracing_check_multi(struct bpf_prog *prog,
+				   struct bpf_prog *tgt_prog,
+				   struct btf *btf2,
+				   const struct btf_type *t2)
+{
+	const struct btf_type *t1;
+	struct btf *btf1;
+
+	/* this case is already valided in bpf_check_attach_target() */
+	if (prog->type == BPF_PROG_TYPE_EXT)
+		return 0;
+
+	btf1 = prog->aux->dst_prog ? prog->aux->dst_prog->aux->btf :
+				     prog->aux->attach_btf;
+	if (!btf1)
+		return -EOPNOTSUPP;
+
+	btf2 = btf2 ?: tgt_prog->aux->btf;
+	t1 = prog->aux->attach_func_proto;
+
+	/* the target is the same as the origin one, this is a re-attach */
+	if (t1 == t2)
+		return 0;
+
+	return btf_check_func_part_match(btf1, t1, btf2, t2,
+					 prog->aux->accessed_args);
+}
+
 static int bpf_tracing_prog_attach(struct bpf_prog *prog,
 				   int tgt_prog_fd,
 				   u32 btf_id,
@@ -3665,6 +3694,335 @@ static int bpf_tracing_prog_attach(struct bpf_prog *prog,
 	return err;
 }
 
+static void __bpf_tracing_multi_link_release(struct bpf_tracing_multi_link *link)
+{
+	int i;
+
+	if (link->mods_cnt) {
+		for (i = 0; i < link->mods_cnt; i++)
+			module_put(link->mods[i]);
+		kfree(link->mods);
+	}
+
+	if (link->prog_cnt) {
+		for (i = 0; i < link->prog_cnt; i++)
+			bpf_prog_put(link->tgt_progs[i]);
+		kfree(link->tgt_progs);
+	}
+
+	if (link->btf_cnt) {
+		for (i = 0; i < link->btf_cnt; i++)
+			btf_put(link->tgt_btfs[i]);
+		kfree(link->tgt_btfs);
+	}
+
+	kfree(link->link.entries);
+}
+
+static void bpf_tracing_multi_link_release(struct bpf_link *link)
+{
+	struct bpf_tracing_multi_link *multi_link =
+		container_of(link, struct bpf_tracing_multi_link, link.link);
+
+	bpf_gtrampoline_unlink_prog(&multi_link->link);
+	__bpf_tracing_multi_link_release(multi_link);
+}
+
+static void bpf_tracing_multi_link_dealloc(struct bpf_link *link)
+{
+	struct bpf_tracing_multi_link *tr_link =
+		container_of(link, struct bpf_tracing_multi_link, link.link);
+
+	kfree(tr_link);
+}
+
+static void bpf_tracing_multi_link_show_fdinfo(const struct bpf_link *link,
+					 struct seq_file *seq)
+{
+	struct bpf_tracing_multi_link *tr_link =
+		container_of(link, struct bpf_tracing_multi_link, link.link);
+	int i;
+
+	for (i = 0; i < tr_link->link.entry_cnt; i++) {
+		seq_printf(seq,
+			   "attach_type:\t%d\n"
+			   "target_addr:\t%p\n",
+			   tr_link->attach_type,
+			   tr_link->link.entries[i].addr);
+	}
+}
+
+static const struct bpf_link_ops bpf_tracing_multi_link_lops = {
+	.release = bpf_tracing_multi_link_release,
+	.dealloc = bpf_tracing_multi_link_dealloc,
+	.show_fdinfo = bpf_tracing_multi_link_show_fdinfo,
+};
+
+#define MAX_TRACING_MULTI_CNT	102400
+
+static int bpf_tracing_get_target(u32 fd, struct bpf_prog **tgt_prog,
+				  struct btf **tgt_btf)
+{
+	struct bpf_prog *prog = NULL;
+	struct btf *btf = NULL;
+	int err = 0;
+
+	if (fd) {
+		prog = bpf_prog_get(fd);
+		if (!IS_ERR(prog))
+			goto found;
+
+		prog = NULL;
+		/* "fd" is the fd of the kernel module BTF */
+		btf = btf_get_by_fd(fd);
+		if (IS_ERR(btf)) {
+			err = PTR_ERR(btf);
+			goto err;
+		}
+		if (!btf_is_kernel(btf)) {
+			btf_put(btf);
+			err = -EOPNOTSUPP;
+			goto err;
+		}
+	} else {
+		btf = bpf_get_btf_vmlinux();
+		if (IS_ERR(btf)) {
+			err = PTR_ERR(btf);
+			goto err;
+		}
+		if (!btf) {
+			err = -EINVAL;
+			goto err;
+		}
+		btf_get(btf);
+	}
+found:
+	*tgt_prog = prog;
+	*tgt_btf = btf;
+	return 0;
+err:
+	*tgt_prog = NULL;
+	*tgt_btf = NULL;
+	return err;
+}
+
+static int bpf_tracing_multi_link_check(const union bpf_attr *attr, u32 **btf_ids,
+					u32 **tgt_fds, u64 **cookies,
+					u32 cnt)
+{
+	void __user *ubtf_ids;
+	void __user *utgt_fds;
+	void __user *ucookies;
+	void *tmp;
+	int i;
+
+	if (!cnt)
+		return -EINVAL;
+
+	if (cnt > MAX_TRACING_MULTI_CNT)
+		return -E2BIG;
+
+	ucookies = u64_to_user_ptr(attr->link_create.tracing_multi.cookies);
+	if (ucookies) {
+		tmp = kvmalloc_array(cnt, sizeof(**cookies), GFP_KERNEL);
+		if (!tmp)
+			return -ENOMEM;
+
+		*cookies = tmp;
+		if (copy_from_user(tmp, ucookies, cnt * sizeof(**cookies)))
+			return -EFAULT;
+	}
+
+	utgt_fds = u64_to_user_ptr(attr->link_create.tracing_multi.tgt_fds);
+	if (utgt_fds) {
+		tmp = kvmalloc_array(cnt, sizeof(**tgt_fds), GFP_KERNEL);
+		if (!tmp)
+			return -ENOMEM;
+
+		*tgt_fds = tmp;
+		if (copy_from_user(tmp, utgt_fds, cnt * sizeof(**tgt_fds)))
+			return -EFAULT;
+	}
+
+	ubtf_ids = u64_to_user_ptr(attr->link_create.tracing_multi.btf_ids);
+	if (!ubtf_ids)
+		return -EINVAL;
+
+	tmp = kvmalloc_array(cnt, sizeof(**btf_ids), GFP_KERNEL);
+	if (!tmp)
+		return -ENOMEM;
+
+	*btf_ids = tmp;
+	if (copy_from_user(tmp, ubtf_ids, cnt * sizeof(**btf_ids)))
+		return -EFAULT;
+
+	for (i = 0; i < cnt; i++) {
+		if (!(*btf_ids)[i])
+			return -EINVAL;
+	}
+
+	return 0;
+}
+
+static void bpf_tracing_multi_link_ptr_fill(struct bpf_tracing_multi_link *link,
+					    struct ptr_array *progs,
+					    struct ptr_array *mods,
+					    struct ptr_array *btfs)
+{
+	link->mods = (struct module **) mods->ptrs;
+	link->mods_cnt = mods->cnt;
+	link->tgt_btfs = (struct btf **) btfs->ptrs;
+	link->btf_cnt = btfs->cnt;
+	link->tgt_progs = (struct bpf_prog **) progs->ptrs;
+	link->prog_cnt = progs->cnt;
+}
+
+static int bpf_tracing_prog_attach_multi(const union bpf_attr *attr,
+					 struct bpf_prog *prog)
+{
+	struct bpf_tracing_multi_link *link = NULL;
+	u32 cnt, *btf_ids = NULL, *tgt_fds = NULL;
+	struct bpf_link_primer link_primer;
+	struct ptr_array prog_array = { };
+	struct ptr_array btf_array = { };
+	struct ptr_array mod_array = { };
+	u64 *cookies = NULL;
+	int err = 0, i;
+
+	if ((prog->expected_attach_type != BPF_TRACE_FENTRY_MULTI &&
+	     prog->expected_attach_type != BPF_TRACE_FEXIT_MULTI &&
+	     prog->expected_attach_type != BPF_MODIFY_RETURN_MULTI) ||
+	     prog->type != BPF_PROG_TYPE_TRACING)
+		return -EINVAL;
+
+	cnt = attr->link_create.tracing_multi.cnt;
+	err = bpf_tracing_multi_link_check(attr, &btf_ids, &tgt_fds, &cookies,
+					   cnt);
+	if (err)
+		goto err_out;
+
+	link = kzalloc(sizeof(*link), GFP_USER);
+	if (!link) {
+		err = -ENOMEM;
+		goto err_out;
+	}
+	link->link.entries = kzalloc(sizeof(*link->link.entries) * cnt,
+				     GFP_USER);
+	if (!link->link.entries) {
+		err = -ENOMEM;
+		goto err_out;
+	}
+
+	bpf_link_init(&link->link.link, BPF_LINK_TYPE_TRACING_MULTI,
+		      &bpf_tracing_multi_link_lops, prog);
+	link->attach_type = prog->expected_attach_type;
+
+	mutex_lock(&prog->aux->dst_mutex);
+
+	for (i = 0; i < cnt; i++) {
+		struct bpf_attach_target_info tgt_info = {};
+		struct bpf_gtramp_link_entry *entry;
+		struct bpf_prog *tgt_prog = NULL;
+		u32 tgt_fd, btf_id = btf_ids[i];
+		struct btf *tgt_btf = NULL;
+		struct module *mod = NULL;
+		int nr_regs;
+
+		entry = &link->link.entries[i];
+		tgt_fd = tgt_fds ? tgt_fds[i] : 0;
+		err = bpf_tracing_get_target(tgt_fd, &tgt_prog, &tgt_btf);
+		if (err)
+			goto err_out_unlock;
+
+		if (tgt_prog) {
+			err = bpf_try_add_ptr(&prog_array, tgt_prog);
+			if (err) {
+				bpf_prog_put(tgt_prog);
+				if (err != -EEXIST)
+					goto err_out_unlock;
+			}
+		}
+
+		if (tgt_btf) {
+			err = bpf_try_add_ptr(&btf_array, tgt_btf);
+			if (err) {
+				btf_put(tgt_btf);
+				if (err != -EEXIST)
+					goto err_out_unlock;
+			}
+		}
+
+		prog->aux->attach_tracing_prog = tgt_prog &&
+			tgt_prog->type == BPF_PROG_TYPE_TRACING &&
+			prog->type == BPF_PROG_TYPE_TRACING;
+
+		err = bpf_check_attach_target(NULL, prog, tgt_prog, tgt_btf,
+					      btf_id, &tgt_info);
+		if (err)
+			goto err_out_unlock;
+
+		nr_regs = arch_bpf_get_regs_nr(&tgt_info.fmodel);
+		if (nr_regs < 0) {
+			err = nr_regs;
+			goto err_out_unlock;
+		}
+
+		mod = tgt_info.tgt_mod;
+		if (mod) {
+			err = bpf_try_add_ptr(&mod_array, mod);
+			if (err) {
+				module_put(mod);
+				if (err != -EEXIST)
+					goto err_out_unlock;
+			}
+		}
+
+		err = bpf_tracing_check_multi(prog, tgt_prog, tgt_btf,
+					      tgt_info.tgt_type);
+		if (err)
+			goto err_out_unlock;
+
+		entry->cookie = cookies ? cookies[i] : 0;
+		entry->addr = (void *)tgt_info.tgt_addr;
+		entry->tgt_prog = tgt_prog;
+		entry->attach_btf = tgt_btf;
+		entry->btf_id = btf_id;
+		entry->nr_args = nr_regs;
+
+		link->link.entry_cnt++;
+	}
+
+	err = bpf_gtrampoline_link_prog(&link->link);
+	if (err)
+		goto err_out_unlock;
+
+	err = bpf_link_prime(&link->link.link, &link_primer);
+	if (err) {
+		bpf_gtrampoline_unlink_prog(&link->link);
+		goto err_out_unlock;
+	}
+
+	bpf_tracing_multi_link_ptr_fill(link, &prog_array, &mod_array,
+					&btf_array);
+	mutex_unlock(&prog->aux->dst_mutex);
+
+	kfree(btf_ids);
+	kfree(tgt_fds);
+	kfree(cookies);
+	return bpf_link_settle(&link_primer);
+err_out_unlock:
+	bpf_tracing_multi_link_ptr_fill(link, &prog_array, &mod_array,
+					&btf_array);
+	__bpf_tracing_multi_link_release(link);
+	mutex_unlock(&prog->aux->dst_mutex);
+err_out:
+	kfree(btf_ids);
+	kfree(tgt_fds);
+	kfree(cookies);
+	kfree(link);
+	return err;
+}
+
 static void bpf_raw_tp_link_release(struct bpf_link *link)
 {
 	struct bpf_raw_tp_link *raw_tp =
@@ -4133,6 +4491,9 @@ attach_type_to_prog_type(enum bpf_attach_type attach_type)
 	case BPF_TRACE_FENTRY:
 	case BPF_TRACE_FEXIT:
 	case BPF_MODIFY_RETURN:
+	case BPF_TRACE_FENTRY_MULTI:
+	case BPF_TRACE_FEXIT_MULTI:
+	case BPF_MODIFY_RETURN_MULTI:
 		return BPF_PROG_TYPE_TRACING;
 	case BPF_LSM_MAC:
 		return BPF_PROG_TYPE_LSM;
@@ -5439,6 +5800,10 @@ static int link_create(union bpf_attr *attr, bpfptr_t uattr)
 			ret = bpf_iter_link_attach(attr, uattr, prog);
 		else if (prog->expected_attach_type == BPF_LSM_CGROUP)
 			ret = cgroup_bpf_link_attach(attr, prog);
+		else if (prog->expected_attach_type == BPF_TRACE_FENTRY_MULTI ||
+			 prog->expected_attach_type == BPF_TRACE_FEXIT_MULTI ||
+			 prog->expected_attach_type == BPF_MODIFY_RETURN_MULTI)
+			ret = bpf_tracing_prog_attach_multi(attr, prog);
 		else
 			ret = bpf_tracing_prog_attach(prog,
 						      attr->link_create.target_fd,
diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index 3d7fd59107ed..b92d1d4f1033 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -116,7 +116,9 @@ bool bpf_prog_has_trampoline(const struct bpf_prog *prog)
 
 	return (ptype == BPF_PROG_TYPE_TRACING &&
 		(eatype == BPF_TRACE_FENTRY || eatype == BPF_TRACE_FEXIT ||
-		 eatype == BPF_MODIFY_RETURN)) ||
+		 eatype == BPF_MODIFY_RETURN ||
+		 eatype == BPF_TRACE_FENTRY_MULTI || eatype == BPF_TRACE_FEXIT_MULTI ||
+		 eatype == BPF_MODIFY_RETURN_MULTI)) ||
 		(ptype == BPF_PROG_TYPE_LSM && eatype == BPF_LSM_MAC);
 }
 
@@ -515,10 +517,13 @@ static enum bpf_tramp_prog_type bpf_attach_type_to_tramp(struct bpf_prog *prog)
 {
 	switch (prog->expected_attach_type) {
 	case BPF_TRACE_FENTRY:
+	case BPF_TRACE_FENTRY_MULTI:
 		return BPF_TRAMP_FENTRY;
 	case BPF_MODIFY_RETURN:
+	case BPF_MODIFY_RETURN_MULTI:
 		return BPF_TRAMP_MODIFY_RETURN;
 	case BPF_TRACE_FEXIT:
+	case BPF_TRACE_FEXIT_MULTI:
 		return BPF_TRAMP_FEXIT;
 	case BPF_LSM_MAC:
 		if (!prog->aux->attach_func_proto->type)
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 9c4e29bc98c0..bbfe8ae39f3c 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -16945,10 +16945,13 @@ static int check_return_code(struct bpf_verifier_env *env, int regno, const char
 		switch (env->prog->expected_attach_type) {
 		case BPF_TRACE_FENTRY:
 		case BPF_TRACE_FEXIT:
+		case BPF_TRACE_FENTRY_MULTI:
+		case BPF_TRACE_FEXIT_MULTI:
 			range = retval_range(0, 0);
 			break;
 		case BPF_TRACE_RAW_TP:
 		case BPF_MODIFY_RETURN:
+		case BPF_MODIFY_RETURN_MULTI:
 			return 0;
 		case BPF_TRACE_ITER:
 			break;
@@ -22264,7 +22267,9 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 		if (prog_type == BPF_PROG_TYPE_TRACING &&
 		    insn->imm == BPF_FUNC_get_func_ret) {
 			if (eatype == BPF_TRACE_FEXIT ||
-			    eatype == BPF_MODIFY_RETURN) {
+			    eatype == BPF_MODIFY_RETURN ||
+			    eatype == BPF_TRACE_FEXIT_MULTI ||
+			    eatype == BPF_MODIFY_RETURN_MULTI) {
 				/* Load nr_args from ctx - 8 */
 				insn_buf[0] = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -8);
 				insn_buf[1] = BPF_ALU64_IMM(BPF_LSH, BPF_REG_0, 3);
@@ -23246,7 +23251,9 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
 		if (tgt_prog->type == BPF_PROG_TYPE_TRACING &&
 		    prog_extension &&
 		    (tgt_prog->expected_attach_type == BPF_TRACE_FENTRY ||
-		     tgt_prog->expected_attach_type == BPF_TRACE_FEXIT)) {
+		     tgt_prog->expected_attach_type == BPF_TRACE_FEXIT ||
+		     tgt_prog->expected_attach_type == BPF_TRACE_FENTRY_MULTI ||
+		     tgt_prog->expected_attach_type == BPF_TRACE_FEXIT_MULTI)) {
 			/* Program extensions can extend all program types
 			 * except fentry/fexit. The reason is the following.
 			 * The fentry/fexit programs are used for performance
@@ -23345,6 +23352,9 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
 	case BPF_LSM_CGROUP:
 	case BPF_TRACE_FENTRY:
 	case BPF_TRACE_FEXIT:
+	case BPF_MODIFY_RETURN_MULTI:
+	case BPF_TRACE_FENTRY_MULTI:
+	case BPF_TRACE_FEXIT_MULTI:
 		if (!btf_type_is_func(t)) {
 			bpf_log(log, "attach_btf_id %u is not a function\n",
 				btf_id);
@@ -23430,7 +23440,8 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
 				bpf_log(log, "%s is not sleepable\n", tname);
 				return ret;
 			}
-		} else if (prog->expected_attach_type == BPF_MODIFY_RETURN) {
+		} else if (prog->expected_attach_type == BPF_MODIFY_RETURN ||
+			   prog->expected_attach_type == BPF_MODIFY_RETURN_MULTI) {
 			if (tgt_prog) {
 				module_put(mod);
 				bpf_log(log, "can't modify return codes of BPF programs\n");
@@ -23483,6 +23494,9 @@ static bool can_be_sleepable(struct bpf_prog *prog)
 		case BPF_TRACE_FEXIT:
 		case BPF_MODIFY_RETURN:
 		case BPF_TRACE_ITER:
+		case BPF_TRACE_FENTRY_MULTI:
+		case BPF_TRACE_FEXIT_MULTI:
+		case BPF_MODIFY_RETURN_MULTI:
 			return true;
 		default:
 			return false;
@@ -23557,6 +23571,11 @@ static int check_attach_btf_id(struct bpf_verifier_env *env)
 		return bpf_iter_prog_supported(prog);
 	}
 
+	if (prog->expected_attach_type == BPF_TRACE_FENTRY_MULTI ||
+	    prog->expected_attach_type == BPF_TRACE_FEXIT_MULTI ||
+	    prog->expected_attach_type == BPF_MODIFY_RETURN_MULTI)
+		return 0;
+
 	key = bpf_trampoline_compute_key(tgt_prog, prog->aux->attach_btf, btf_id);
 	tr = bpf_trampoline_get(key, &tgt_info);
 	if (!tr)
diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index aaf13a7d58ed..bcb609425fda 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -696,6 +696,8 @@ int bpf_prog_test_run_tracing(struct bpf_prog *prog,
 	switch (prog->expected_attach_type) {
 	case BPF_TRACE_FENTRY:
 	case BPF_TRACE_FEXIT:
+	case BPF_TRACE_FENTRY_MULTI:
+	case BPF_TRACE_FEXIT_MULTI:
 		if (bpf_fentry_test1(1) != 2 ||
 		    bpf_fentry_test2(2, 3) != 5 ||
 		    bpf_fentry_test3(4, 5, 6) != 15 ||
@@ -709,6 +711,7 @@ int bpf_prog_test_run_tracing(struct bpf_prog *prog,
 			goto out;
 		break;
 	case BPF_MODIFY_RETURN:
+	case BPF_MODIFY_RETURN_MULTI:
 		ret = bpf_modify_return_test(1, &b);
 		if (b != 2)
 			side_effect++;
diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
index 2e538399757f..c5b1fd714b58 100644
--- a/net/core/bpf_sk_storage.c
+++ b/net/core/bpf_sk_storage.c
@@ -369,6 +369,8 @@ static bool bpf_sk_storage_tracing_allowed(const struct bpf_prog *prog)
 		return true;
 	case BPF_TRACE_FENTRY:
 	case BPF_TRACE_FEXIT:
+	case BPF_TRACE_FENTRY_MULTI:
+	case BPF_TRACE_FEXIT_MULTI:
 		return !!strncmp(prog->aux->attach_func_name, "bpf_sk_storage",
 				 strlen("bpf_sk_storage"));
 	default:
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 16e95398c91c..45dfaf40230e 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1120,6 +1120,9 @@ enum bpf_attach_type {
 	BPF_NETKIT_PEER,
 	BPF_TRACE_KPROBE_SESSION,
 	BPF_TRACE_UPROBE_SESSION,
+	BPF_TRACE_FENTRY_MULTI,
+	BPF_TRACE_FEXIT_MULTI,
+	BPF_MODIFY_RETURN_MULTI,
 	__MAX_BPF_ATTACH_TYPE
 };
 
@@ -1144,6 +1147,7 @@ enum bpf_link_type {
 	BPF_LINK_TYPE_UPROBE_MULTI = 12,
 	BPF_LINK_TYPE_NETKIT = 13,
 	BPF_LINK_TYPE_SOCKMAP = 14,
+	BPF_LINK_TYPE_TRACING_MULTI = 15,
 	__MAX_BPF_LINK_TYPE,
 };
 
@@ -1765,6 +1769,12 @@ union bpf_attr {
 				 */
 				__u64		cookie;
 			} tracing;
+			struct {
+				__u32		cnt;
+				__aligned_u64	tgt_fds;
+				__aligned_u64	btf_ids;
+				__aligned_u64	cookies;
+			} tracing_multi;
 			struct {
 				__u32		pf;
 				__u32		hooknum;
-- 
2.39.5


