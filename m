Return-Path: <bpf+bounces-62260-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B845AAF73B1
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 14:20:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BDB437BA104
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 12:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E51B2E88B7;
	Thu,  3 Jul 2025 12:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J5r5TC/M"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373232E7F1A;
	Thu,  3 Jul 2025 12:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751545049; cv=none; b=XEtF2gQbNo2l6dC037kSCyd5xqNlE7Gm+YQtf4krcMLQ30r6fDPe37gfqvnCj+rV4S2LWlO2M+eGu0oDs5RRE6x0pDymfHp9bPSFzoxDgzeQc68M505DfLj2Kf3hXJgtlIcb8/qZiDIOs4HrEOFUU5E6ZQi2IVlpFfYiv5N2M/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751545049; c=relaxed/simple;
	bh=dCLO0Dzw5XDuaK59sFwYu6i8iKNycmJyj6mUxFMPq+4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=X4Fp9CpbNgUQ9CtiandVe6x5K48DZa8StaShOwgQwlbn2ICEuR8Zm1zQjnhQfwwzD0hMPlwWq19x4pxKLY+6cllOep17bxqPoIvuEORwodii/JXKmxzNLsVPd21fOiBHoCQVC1dlCchBEGcaWgTZZCCSRtNQex+wpFOj+HcAP4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J5r5TC/M; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-748f5a4a423so3402004b3a.1;
        Thu, 03 Jul 2025 05:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751545047; x=1752149847; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rMZQjMUadN6vTC20pd1eUPoOkbE0QlklsBkBnH/VU6M=;
        b=J5r5TC/MNoBKmpcjei1rF3U6MmfBLO//nlhUO0HHw/ZZtvYXdb9p8H7IWKlUiOr+M+
         50UxeTUVHB4pschMZbvRZpftki+Xs8r6UMIf8uJGvt7X6bxS1Ckcg5HfIRdmSTE0XKjL
         QP2IJOWus2q2b3osolWL0B2iS0AeOX4qh8AE8gRzYxVxvFKKQfwJz7Gwrzw8GuD32Q+3
         SGKsD8yJZq9x179b9SeO1Xq9cP+dEE3aW/dywkvK0huG4vKmN+B5fEbVwEmJoADNycSD
         actA1RRm4LfHl5T0v3jdPsaTelqsg06BdjrpmjZS+1HJoRTUh3X948kVgQUFuSW4i8Wm
         zMiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751545047; x=1752149847;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rMZQjMUadN6vTC20pd1eUPoOkbE0QlklsBkBnH/VU6M=;
        b=oFF7xaIl3XZeJ6oALEgMa76qnmmopuyE1824U72cPNu9yDRPmO8ngnOdzDtUPp4kdp
         xkRPjtbC1gaOSiPSEzJm5BOb7h4JK6MJn19w1rhCP635miqEgq1QhKEptLpyUvDNzYK/
         +aczt9KAdXkAHAWeS159SjKxf+PkBDbPFHYfQa/MwnBHWrdZFDFUw5FcFwmUBLknRmMk
         C33N6Pi7EEYIlpBpvpQlGEcSr64weaxUnebEv+GV28/6+lTbWHihfL4wXnfNR9BazS5k
         iuGJeH6a2goDo0j60qb2iFaRdkK7brHxMyH/fJaasypHUDB4oxcOzVhEgoU1t55q0Jy1
         KOPQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/xBUnMEU2ZiAu0ZFcW8k6Qw6CMlTLwKhr3LS+q7tGTzwkErMoN/PYR0RBk7oFUj6Q8VsvtouxvuMQy+Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx43wavIaygVp6Sf/8D7fSG4MxlE83/sDZscneoGsQZMRQBMD1m
	hGGzEYmNT+SuoRAv5FU5rrwfGQ3bqdrqCSbBsADbxLuUsiIy8uTLhcuA
X-Gm-Gg: ASbGncsDlM0AwoM0Aupa5vSm9c4JKsCQLQc2dLgSIGo0r91BvHB0liZ3gxVfjo0pdH9
	TCB3C+hYtNfokOFZqRdEXK3MiCQRvxN2d07AEp+j67YFkFCgrr1JM80ANwIYmZtWyjQ/VavjEbz
	1WiwKIVyXGK3/6SbIalfusia+P/LYqMfksR10UWkcYJn6zzD7kROAt4NkIjgQ7hNY7qt33qzrpX
	Rf4p0NAHBKDki0eLHuZcbgr2/NBqyzzZEAOw34/Z7Kc+E4MZQkVJgQOiSjUPgJQ2mWtpLwTu67I
	PV2uQs0dy0bZ9KjI4u0/z3ZO0BuvdQa2yFB0I9wtOugFnf4878uKX1so2zEhBHB/MxBHaUv+7W0
	RnA5CKQGTyESBpA==
X-Google-Smtp-Source: AGHT+IEnTMnW4PmKaAUkuUcYsiUVlHS+C5Zo2XxayHR8lPZ4scOgB0uXx/P+qU0dDq/9s+5iZ6hsqg==
X-Received: by 2002:a05:6a00:1a8e:b0:740:afda:a742 with SMTP id d2e1a72fcca58-74b50da219amr9454489b3a.0.1751545047307;
        Thu, 03 Jul 2025 05:17:27 -0700 (PDT)
Received: from localhost.localdomain ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74af5575895sm18591081b3a.94.2025.07.03.05.17.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 05:17:27 -0700 (PDT)
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
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v2 05/18] bpf: introduce bpf_gtramp_link
Date: Thu,  3 Jul 2025 20:15:08 +0800
Message-Id: <20250703121521.1874196-6-dongml2@chinatelecom.cn>
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

Introduce the struct bpf_gtramp_link, which is used to attach
a bpf prog to multi functions. Meanwhile, introduce corresponding
function bpf_gtrampoline_{link,unlink}_prog. The lock global_tr_lock is
held during global trampoline link and unlink.

We create different global trampoline for the kernel functions that have
different argument count. If corresponding global_tr->image is NULL, it
means such function argument count is not supported.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 include/linux/bpf.h     |  35 ++++++++
 kernel/bpf/trampoline.c | 189 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 224 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 5dd556e89cce..70bf613d51d0 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -58,6 +58,8 @@ struct bpf_token;
 struct user_namespace;
 struct super_block;
 struct inode;
+struct bpf_tramp_link;
+struct bpf_gtramp_link;
 
 extern struct idr btf_idr;
 extern spinlock_t btf_idr_lock;
@@ -1279,6 +1281,12 @@ struct bpf_trampoline {
 	struct bpf_tramp_image *cur_image;
 };
 
+struct bpf_global_trampoline {
+	struct ftrace_ops *fops;
+	void *image;
+	int nr_args;
+};
+
 struct bpf_attach_target_info {
 	struct btf_func_model fmodel;
 	long tgt_addr;
@@ -1382,6 +1390,9 @@ struct bpf_trampoline *bpf_trampoline_get(u64 key,
 void bpf_trampoline_put(struct bpf_trampoline *tr);
 int arch_prepare_bpf_dispatcher(void *image, void *buf, s64 *funcs, int num_funcs);
 
+int bpf_gtrampoline_link_prog(struct bpf_gtramp_link *link);
+int bpf_gtrampoline_unlink_prog(struct bpf_gtramp_link *link);
+
 /*
  * When the architecture supports STATIC_CALL replace the bpf_dispatcher_fn
  * indirection with a direct call to the bpf program. If the architecture does
@@ -1490,6 +1501,14 @@ static inline bool bpf_prog_has_trampoline(const struct bpf_prog *prog)
 {
 	return false;
 }
+int bpf_gtrampoline_link_prog(struct bpf_gtramp_link *link)
+{
+	return -ENODEV;
+}
+int bpf_gtrampoline_unlink_prog(struct bpf_gtramp_link *link)
+{
+	return -ENODEV;
+}
 #endif
 
 struct bpf_func_info_aux {
@@ -1746,6 +1765,22 @@ struct bpf_shim_tramp_link {
 	struct bpf_trampoline *trampoline;
 };
 
+struct bpf_gtramp_link_entry {
+	struct bpf_prog *tgt_prog;
+	struct bpf_trampoline *trampoline;
+	void *addr;
+	struct btf *attach_btf;
+	u64 cookie;
+	u32 btf_id;
+	u32 nr_args;
+};
+
+struct bpf_gtramp_link {
+	struct bpf_link link;
+	struct bpf_gtramp_link_entry *entries;
+	u32 entry_cnt;
+};
+
 struct bpf_tracing_link {
 	struct bpf_tramp_link link;
 	enum bpf_attach_type attach_type;
diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index fa90c225c93b..f70921ce4e97 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -14,6 +14,7 @@
 #include <linux/bpf_lsm.h>
 #include <linux/delay.h>
 #include <linux/bpf_tramp.h>
+#include <linux/kfunc_md.h>
 
 /* dummy _ops. The verifier will operate on target program's ops. */
 const struct bpf_verifier_ops bpf_extension_verifier_ops = {
@@ -30,6 +31,10 @@ static struct hlist_head trampoline_table[TRAMPOLINE_TABLE_SIZE];
 /* serializes access to trampoline_table */
 static DEFINE_MUTEX(trampoline_mutex);
 
+static struct bpf_global_trampoline global_tr_array[MAX_BPF_FUNC_ARGS + 1];
+static DEFINE_MUTEX(global_tr_lock);
+static const struct bpf_link_ops bpf_shim_tramp_link_lops;
+
 #ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
 static int bpf_trampoline_update(struct bpf_trampoline *tr, bool lock_direct_mutex);
 
@@ -646,6 +651,172 @@ int bpf_trampoline_unlink_prog(struct bpf_tramp_link *link,
 	return err;
 }
 
+#if defined(CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS) && defined(CONFIG_ARCH_HAS_BPF_GLOBAL_CALLER)
+static int bpf_gtrampoline_update(struct bpf_global_trampoline *tr)
+{
+	struct ftrace_ops *fops;
+	int ips_count, err = 0;
+	void **ips = NULL;
+
+	ips_count = kfunc_md_bpf_ips(&ips, tr->nr_args);
+	if (ips_count < 0) {
+		err = ips_count;
+		goto out;
+	}
+
+	fops = tr->fops;
+	if (ips_count == 0) {
+		if (!(fops->flags & FTRACE_OPS_FL_ENABLED))
+			goto out;
+		err = unregister_ftrace_direct(fops, (unsigned long)tr->image,
+					       true);
+		goto out;
+	}
+
+	if (fops->flags & FTRACE_OPS_FL_ENABLED) {
+		err = reset_ftrace_direct_ips(fops, (unsigned long *)ips,
+					      ips_count);
+		goto out;
+	}
+
+	err = ftrace_set_filter_ips(tr->fops, (unsigned long *)ips,
+				    ips_count, 0, 1);
+	if (err)
+		goto out;
+
+	err = register_ftrace_direct(fops, (unsigned long)tr->image);
+out:
+	kfree(ips);
+
+	return err;
+}
+
+static int bpf_gtrampoline_update_all(void)
+{
+	struct bpf_global_trampoline *gtr;
+	int err;
+
+	for (int i = 0; i <= MAX_BPF_FUNC_ARGS; i++) {
+		gtr = &global_tr_array[i];
+		if (!gtr->image)
+			break;
+		err = bpf_gtrampoline_update(gtr);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+#else
+static int bpf_gtrampoline_update_all(void)
+{
+	return -ENODEV;
+}
+#endif
+
+static int __bpf_gtrampoline_unlink_prog(struct bpf_gtramp_link *link,
+					 u32 cnt)
+{
+	enum bpf_tramp_prog_type kind;
+	struct kfunc_md *md;
+	int err = 0;
+
+	kind = bpf_attach_type_to_tramp(link->link.prog);
+
+	/* remove the prog from all the coressponding md */
+	for (int i = 0; i < link->entry_cnt; i++) {
+		md = kfunc_md_get((long)link->entries[i].addr);
+		if (WARN_ON_ONCE(!md))
+			continue;
+
+		err = kfunc_md_bpf_unlink(md, link->link.prog, kind);
+		if (err)
+			return err;
+	}
+
+	bpf_gtrampoline_update_all();
+	for (int i = 0; i < cnt; i++)
+		kfunc_md_put_ip((long)link->entries[i].addr);
+
+	return 0;
+}
+
+int bpf_gtrampoline_unlink_prog(struct bpf_gtramp_link *link)
+{
+	int err;
+
+	/* hold the global trampoline lock, to make the target functions
+	 * consist during we unlink the prog.
+	 */
+	mutex_lock(&global_tr_lock);
+	err = __bpf_gtrampoline_unlink_prog(link, link->entry_cnt);
+	mutex_unlock(&global_tr_lock);
+
+	return err;
+}
+
+int bpf_gtrampoline_link_prog(struct bpf_gtramp_link *link)
+{
+	struct bpf_gtramp_link_entry *entry;
+	enum bpf_tramp_prog_type kind;
+	struct bpf_prog *prog;
+	struct kfunc_md *md;
+	bool update = false;
+	int err = 0, i;
+
+	/* check if the function arguments count is supported by the arch */
+	for (int i = 0; i < link->entry_cnt; i++) {
+		entry = &link->entries[i];
+		if (entry->nr_args > MAX_BPF_FUNC_ARGS ||
+		    !global_tr_array[entry->nr_args].image)
+			return -EOPNOTSUPP;
+	}
+
+	prog = link->link.prog;
+	kind = bpf_attach_type_to_tramp(prog);
+
+	/* hold the global trampoline lock, to make the target functions
+	 * consist during we link the prog.
+	 */
+	mutex_lock(&global_tr_lock);
+
+	/* update the bpf prog to all the corresponding function metadata */
+	for (i = 0; i < link->entry_cnt; i++) {
+		entry = &link->entries[i];
+		md = kfunc_md_create((long)entry->addr, entry->nr_args);
+		if (md) {
+			/* the function is not in the filter hash of gtr,
+			 * we need update the global trampoline.
+			 */
+			if (!md->bpf_prog_cnt)
+				update = true;
+			err = kfunc_md_bpf_link(md, prog, kind, entry->cookie);
+		} else {
+			err = -ENOMEM;
+		}
+
+		if (err) {
+			kfunc_md_put(md);
+			goto on_fallback;
+		}
+	}
+
+	if (update) {
+		err = bpf_gtrampoline_update_all();
+		if (err)
+			goto on_fallback;
+	}
+	mutex_unlock(&global_tr_lock);
+
+	return 0;
+
+on_fallback:
+	__bpf_gtrampoline_unlink_prog(link, i);
+	mutex_unlock(&global_tr_lock);
+
+	return err;
+}
+
 #if defined(CONFIG_CGROUP_BPF) && defined(CONFIG_BPF_LSM)
 static void bpf_shim_tramp_link_release(struct bpf_link *link)
 {
@@ -1117,6 +1288,24 @@ static int __init init_trampolines(void)
 {
 	int i;
 
+	for (i = 0; i <= MAX_BPF_FUNC_ARGS; i++) {
+		struct bpf_global_trampoline *global_tr;
+
+		global_tr = &global_tr_array[i];
+		global_tr->nr_args = i;
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
+		global_tr->fops = kzalloc(sizeof(struct ftrace_ops), GFP_KERNEL);
+		if (!global_tr->fops)
+			return -ENOMEM;
+
+		global_tr->fops->private = global_tr;
+		global_tr->fops->ops_func = bpf_tramp_ftrace_ops_func;
+#endif
+#ifdef CONFIG_ARCH_HAS_BPF_GLOBAL_CALLER
+		global_tr->image = bpf_gloabl_caller_array[i];
+#endif
+	}
+
 	for (i = 0; i < TRAMPOLINE_TABLE_SIZE; i++)
 		INIT_HLIST_HEAD(&trampoline_table[i]);
 	return 0;
-- 
2.39.5


