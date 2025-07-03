Return-Path: <bpf+bounces-62266-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 721CDAF73BA
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 14:21:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAEE64E6529
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 12:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C0682EBBB9;
	Thu,  3 Jul 2025 12:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uh6/wIP3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE502EBBAE;
	Thu,  3 Jul 2025 12:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751545072; cv=none; b=XX4yOdpj0tdQRpcC0Sd3XW3IhD2jEEDzQR2P2CVwlUvA2ns6UsZ6kgF1LLm4up/zWkQ5ee/FJaAcVUWp0b4OLgLD8rTJTtJTcpPSdjBnoQPk0thYT5KVT1PonXKuKIoWtKLPx5IAfO6JcrS7Af6l0ONV5SiGYa9Lxgu0nIowTtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751545072; c=relaxed/simple;
	bh=YnoFyWI1IUMizE7r32ai9JJKvJNUe7ZYEuJvRY02GF4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sDiJJqp20Ggn5GiQ0A60V7Jr2Tm2+Cd50HHx7fNZsgfawPNGYwNNLo5G84z6ku8PjoGaHBCQAJiDNIzVpYhA1b1zPwp6YQ+Qgtthw4Y8PJXQh14BDM7YE9fXtTYYehp4iOLkx7VVcPJpCrU4wALWfY6XCQzsyvBLJi5QhB5Et0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uh6/wIP3; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-74af4af04fdso717371b3a.1;
        Thu, 03 Jul 2025 05:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751545070; x=1752149870; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KLMkiZfQv3qoSy4AHmmz4OCnnoCuZgsAHFlasMXQNvY=;
        b=Uh6/wIP3/JRd6EMTRlotmFAwrLvw1UWSOQxhZPn5AyQwPCQbnbTV1xBEJkLJis1V/E
         INN4fBsir/72A07gDa45ozPLBiIoNV6nCdGGD3WZQ+xPUwIA4NsZ3W4xYwtVuiUA4Vt4
         wT37d0uUX7MVL5Vcv+kAR/fFhErh8bxvqmJwCxodtn+ucZpenLwJ95ZcfqjIWhcfkXf2
         P1z/CY8dT7y9IoUQIAd5LzxvgW8KFqDw7uIMjJMsvSZRVEu3UXa4pnY0/iH8IzaDyRGy
         2T86rfWNw9+j/UI/N+xOvHxCnDne0ZkgDn4RwYtE0yNsNGpDG2o3G+XhiTZ5Vu/+Taz4
         Nw8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751545070; x=1752149870;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KLMkiZfQv3qoSy4AHmmz4OCnnoCuZgsAHFlasMXQNvY=;
        b=sQtRrmJDFlTg2QBUmH8ON3IObQHkoazF4jx87H1vpjqyZVfYWG2A2if0TDteIuxcw+
         9rwRaQQlBgjWyFsGYG5o6UwR95SmMrHa5UlX8B5f1kpG0n27pxrujUbDE67qZLzLzseb
         AZx8a5Vc4+pkMjW16jziu1XAInawboxjWpJZQHVPon0Ce9xgMGpCmHingcCj+wUjt5Cr
         tK7r28ShOrML6ot1AGbJgRuZVW66LEszfv0GEAHwiNjZ+rNAc+fIlVACd5lP+iV5zFyI
         A2aEP36/66rfq4PXGmwk+oUohoRXhO+te8CptoeGszjmTkyR+9tU7K0miPYzZxYEOQFp
         WQbg==
X-Forwarded-Encrypted: i=1; AJvYcCViLgBVjYvBqsDeZuA1KGPt7el5gEo25oTEcQKdicNXc7BdXKC+ec+iGzJu2udX62zZDmQE5S2E@vger.kernel.org, AJvYcCX9+yUoRzbD7x7YzrdXygIE81OpBlO6e8shd6kUVtZsAsQZpyVJw2msToPrIOvvLsoj65m0WOHPd+I4Lxg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzy3af6C7JT6R4Mt2wrL1mA70r3S4nozC8SChv4XFqZm6o4VJKn
	gsV08k+F7G5IyuNUP/SIPYYkLkctjXAzp9EZKCOO7OEdECEDvRuI+7MQmKFnUQPEvF/qkw==
X-Gm-Gg: ASbGncuGbixtyjjWdbihevJUqB+QKJGSl2gBsKYgINPnTY6YzIA/aPhj6AMoY8D+mEe
	YK40e33ilnREod4Y3LtW3ASqZUMlOzEU6wjBzfFK7WtKwSvtDeZPd/XY89nnOOL0wpSdl2nDIGI
	stJ3UV/R3OJQFkpz6vnIszTTZmm8m55YyCyvm01kvKu/ZPEldCYH2b/B3yHs0JbKOSQbc5deZpF
	Nyszts4YCCeCAlYl4e+c1G6ATFB/XvHaKjm0NoNZbveZmH/mratTWbKCTa/kOCDxmgkx5Vbghae
	biJa05DYOkk4SMFjlI3xUKBzWQxkjaaSWttJz+5argFdJckjnRIaRryLfBlT81q2qPr1M2R/q5V
	SYs4=
X-Google-Smtp-Source: AGHT+IGLSKuxphEiZKo77VKb+H8yYhe9HWajksgxk6/dfacla+3giw0Nf0+7fcNSbqASvycn6LboBw==
X-Received: by 2002:a05:6a20:e605:b0:224:46a0:25ef with SMTP id adf61e73a8af0-22488674568mr2621182637.16.1751545069568;
        Thu, 03 Jul 2025 05:17:49 -0700 (PDT)
Received: from localhost.localdomain ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74af5575895sm18591081b3a.94.2025.07.03.05.17.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 05:17:49 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: alexei.starovoitov@gmail.com,
	rostedt@goodmis.org,
	jolsa@kernel.org
Cc: bpf@vger.kernel.org,
	Menglong Dong <dongml2@chinatelecom.cn>,
	John Fastabend <john.fastabend@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH bpf-next v2 11/18] bpf: tracing: add multi-link support
Date: Thu,  3 Jul 2025 20:15:14 +0800
Message-Id: <20250703121521.1874196-12-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250703121521.1874196-1-dongml2@chinatelecom.cn>
References: <20250703121521.1874196-1-dongml2@chinatelecom.cn>
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
 include/linux/bpf.h            |   9 +
 include/linux/bpf_types.h      |   1 +
 include/uapi/linux/bpf.h       |  10 +
 kernel/bpf/btf.c               |   5 +
 kernel/bpf/syscall.c           | 353 +++++++++++++++++++++++++++++++++
 kernel/bpf/trampoline.c        |   7 +-
 kernel/bpf/verifier.c          |  25 ++-
 net/bpf/test_run.c             |   3 +
 net/core/bpf_sk_storage.c      |   2 +
 tools/include/uapi/linux/bpf.h |  10 +
 10 files changed, 421 insertions(+), 4 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index da5951b0335b..b4f8e2a068e5 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1806,6 +1806,15 @@ struct bpf_raw_tp_link {
 	u64 cookie;
 };
 
+struct bpf_tracing_multi_link {
+	struct bpf_gtramp_link link;
+	enum bpf_attach_type attach_type;
+	struct btf **tgt_btfs;
+	struct module **mods;
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
index 719ba230032f..a143a64f69ae 100644
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
index 853ca19bbe81..a25c2a0303f2 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6112,6 +6112,9 @@ static int btf_validate_prog_ctx_type(struct bpf_verifier_log *log, const struct
 		case BPF_TRACE_FENTRY:
 		case BPF_TRACE_FEXIT:
 		case BPF_MODIFY_RETURN:
+		case BPF_TRACE_FENTRY_MULTI:
+		case BPF_TRACE_FEXIT_MULTI:
+		case BPF_MODIFY_RETURN_MULTI:
 			/* allow u64* as ctx */
 			if (btf_is_int(t) && t->size == 8)
 				return 0;
@@ -6718,6 +6721,7 @@ bool btf_ctx_access(int off, int size, enum bpf_access_type type,
 			fallthrough;
 		case BPF_LSM_CGROUP:
 		case BPF_TRACE_FEXIT:
+		case BPF_TRACE_FEXIT_MULTI:
 			/* When LSM programs are attached to void LSM hooks
 			 * they use FEXIT trampolines and when attached to
 			 * int LSM hooks, they use MODIFY_RETURN trampolines.
@@ -6736,6 +6740,7 @@ bool btf_ctx_access(int off, int size, enum bpf_access_type type,
 			t = btf_type_by_id(btf, t->type);
 			break;
 		case BPF_MODIFY_RETURN:
+		case BPF_MODIFY_RETURN_MULTI:
 			/* For now the BPF_MODIFY_RETURN can only be attached to
 			 * functions that return an int.
 			 */
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index b21bbbc4263d..01430308558f 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -37,6 +37,7 @@
 #include <linux/trace_events.h>
 #include <linux/tracepoint.h>
 #include <linux/overflow.h>
+#include <linux/kfunc_md.h>
 
 #include <net/netfilter/nf_bpf_link.h>
 #include <net/netkit.h>
@@ -3469,6 +3470,34 @@ static const struct bpf_link_ops bpf_tracing_link_lops = {
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
@@ -3668,6 +3697,323 @@ static int bpf_tracing_prog_attach(struct bpf_prog *prog,
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
+					    struct ptr_array *mods,
+					    struct ptr_array *btfs)
+{
+	link->mods = (struct module **) mods->ptrs;
+	link->mods_cnt = mods->cnt;
+	link->tgt_btfs = (struct btf **) btfs->ptrs;
+	link->btf_cnt = btfs->cnt;
+}
+
+static int bpf_tracing_prog_attach_multi(const union bpf_attr *attr,
+					 struct bpf_prog *prog)
+{
+	struct bpf_tracing_multi_link *link = NULL;
+	u32 cnt, *btf_ids = NULL, *tgt_fds = NULL;
+	struct bpf_link_primer link_primer;
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
+			/* the global trampoline link is ftrace based, bpf2bpf
+			 * is not supported for now.
+			 */
+			bpf_prog_put(tgt_prog);
+			err = -EOPNOTSUPP;
+			goto err_out_unlock;
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
+	bpf_tracing_multi_link_ptr_fill(link, &mod_array, &btf_array);
+	mutex_unlock(&prog->aux->dst_mutex);
+
+	kfree(btf_ids);
+	kfree(tgt_fds);
+	kfree(cookies);
+	return bpf_link_settle(&link_primer);
+err_out_unlock:
+	bpf_tracing_multi_link_ptr_fill(link, &mod_array, &btf_array);
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
@@ -4259,6 +4605,9 @@ attach_type_to_prog_type(enum bpf_attach_type attach_type)
 	case BPF_TRACE_FENTRY:
 	case BPF_TRACE_FEXIT:
 	case BPF_MODIFY_RETURN:
+	case BPF_TRACE_FENTRY_MULTI:
+	case BPF_TRACE_FEXIT_MULTI:
+	case BPF_MODIFY_RETURN_MULTI:
 		return BPF_PROG_TYPE_TRACING;
 	case BPF_LSM_MAC:
 		return BPF_PROG_TYPE_LSM;
@@ -5581,6 +5930,10 @@ static int link_create(union bpf_attr *attr, bpfptr_t uattr)
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
index 8fcb0352f36e..07986669ada0 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -117,7 +117,9 @@ bool bpf_prog_has_trampoline(const struct bpf_prog *prog)
 
 	return (ptype == BPF_PROG_TYPE_TRACING &&
 		(eatype == BPF_TRACE_FENTRY || eatype == BPF_TRACE_FEXIT ||
-		 eatype == BPF_MODIFY_RETURN)) ||
+		 eatype == BPF_MODIFY_RETURN ||
+		 eatype == BPF_TRACE_FENTRY_MULTI || eatype == BPF_TRACE_FEXIT_MULTI ||
+		 eatype == BPF_MODIFY_RETURN_MULTI)) ||
 		(ptype == BPF_PROG_TYPE_LSM && eatype == BPF_LSM_MAC);
 }
 
@@ -516,10 +518,13 @@ static enum bpf_tramp_prog_type bpf_attach_type_to_tramp(struct bpf_prog *prog)
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
index 86a64d843465..a44e1fed3fa1 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -17103,10 +17103,13 @@ static int check_return_code(struct bpf_verifier_env *env, int regno, const char
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
@@ -22632,7 +22635,9 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
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
@@ -23619,7 +23624,9 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
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
@@ -23718,6 +23725,9 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
 	case BPF_LSM_CGROUP:
 	case BPF_TRACE_FENTRY:
 	case BPF_TRACE_FEXIT:
+	case BPF_MODIFY_RETURN_MULTI:
+	case BPF_TRACE_FENTRY_MULTI:
+	case BPF_TRACE_FEXIT_MULTI:
 		if (!btf_type_is_func(t)) {
 			bpf_log(log, "attach_btf_id %u is not a function\n",
 				btf_id);
@@ -23803,7 +23813,8 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
 				bpf_log(log, "%s is not sleepable\n", tname);
 				return ret;
 			}
-		} else if (prog->expected_attach_type == BPF_MODIFY_RETURN) {
+		} else if (prog->expected_attach_type == BPF_MODIFY_RETURN ||
+			   prog->expected_attach_type == BPF_MODIFY_RETURN_MULTI) {
 			if (tgt_prog) {
 				module_put(mod);
 				bpf_log(log, "can't modify return codes of BPF programs\n");
@@ -23856,6 +23867,9 @@ static bool can_be_sleepable(struct bpf_prog *prog)
 		case BPF_TRACE_FEXIT:
 		case BPF_MODIFY_RETURN:
 		case BPF_TRACE_ITER:
+		case BPF_TRACE_FENTRY_MULTI:
+		case BPF_TRACE_FEXIT_MULTI:
+		case BPF_MODIFY_RETURN_MULTI:
 			return true;
 		default:
 			return false;
@@ -23930,6 +23944,11 @@ static int check_attach_btf_id(struct bpf_verifier_env *env)
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
index 9728dbd4c66c..a5e5094a5189 100644
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
index 719ba230032f..a143a64f69ae 100644
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


