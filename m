Return-Path: <bpf+bounces-59097-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 96A5AAC6057
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 05:52:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EBC0F7B0EB4
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 03:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01FC7215046;
	Wed, 28 May 2025 03:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d7VNdeoh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C824E21322B;
	Wed, 28 May 2025 03:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748404197; cv=none; b=IX94QfyipkS/E81uLQmjtfQV+sPFhPF3oaRkPw/Ob9ldtg0+yk/F69nVywtPkvcOEAZnFGr4qRpU3APSqY2Lo0vs10f4gbSIYtCuhSUq88f1xR6Bl+eIyx6+/PUh5Fhm11RVDi3y31hXTtixCDgcjrVmfeax/uQsoclyz72gEww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748404197; c=relaxed/simple;
	bh=Q2ZhADwFji9fpJ66IuQW1xzWb9NKosAUzd+v8YlATa8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=O7eDyEA7kJfi2QM/5zjXxH1ZpdOAJ3zWCB16k40q5/1cDp4b6Up5k7wISl/vbnlHNnA+j58iT6Ed0ZEY9tK4+Cp1vTTVdiuywMmZMhYAI9ZPAVZrGNpRmbyp9jiCaPphe6EsUWk3ckL0zX1jmj085juvgJoSB62F/7oo8B4oanM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d7VNdeoh; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-231c86bffc1so40748525ad.0;
        Tue, 27 May 2025 20:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748404194; x=1749008994; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BDS2dmniJXm2+zWW98g5diGeXn4aawjb/QQTXBKdBMQ=;
        b=d7VNdeohNBoGGKBzS03Urp93Vz2kHVMKyM2ESwRrRFRDHJouvDv3bo1i08PVQW2qJz
         OOGF8bPkK0j9lWqKeHwIiX6w1WJQDJ5QL4d8SUzQ05lN0M78nnBzLEoWCuqjFRg7++MC
         49ixp1a7W1q52ZtOi7ky1RHO2UEOCnnO7o/Rq+CJYMgOOPIzVGmtTD9ScQ+Vrb1/u+tG
         kocIeW7N7sb7AZz5M/cOdpKxrnhdUquP0yky9/bCIdyPPx80Ww2CPOfdkKP6X2Exvnbk
         qp6HRVE98MqNE0M86qbFgN0qfpeowZYECzSgprbAsqKcuHoK0eNiFZgYnfqQYIm3YCnG
         iASw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748404194; x=1749008994;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BDS2dmniJXm2+zWW98g5diGeXn4aawjb/QQTXBKdBMQ=;
        b=EZHYjEKErArK4lmdu7NxDSd5eCD2cfmXOveYICsMgU48LT0/RN6dEJeMuEcEl+q5I3
         iwzSrRwvx+Wb4/aMlCiKQBoXdRcI5miMMf6jPrRXTr9z+IRzcy2Nxxu7gu/JX1fzO3/h
         q4a3K1FgfZthzmrCX4Acb2XzJUobmz/Kr7sMt5bt2tvgnxeiG/Q2/jUFEIUxS2X3UPQV
         5BZf3d67wg+xMMAwLR8uFaoF+k0BBuaQsiWu2MJ45hy4NcsfRWjFovP7ZkysDeb20QJc
         WmNYj6D1ILFoh9uSccSwnAfm9h1YB+sMCDTzosbmiJvkYNtBxyVm/XFwRQ0tOubwdUTf
         0+jQ==
X-Forwarded-Encrypted: i=1; AJvYcCWOqwoWOUB2jCbGYkJGuYA/F0KcjP9Fc3FlcHyDnO+WQDks105T9iwxjUOQYj+ysoJirUzFIwCQmGyToQ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcxknlvA2yk8DBvVrmKyV2oH/V0zsXf5nCg4qxTWIgIp3rapXQ
	NTzOW5nWl0HSHa6whRSXfg6GImEsQvn+TWcaW2MwaigHp6NJVwUaeRjF
X-Gm-Gg: ASbGncvLtNme3Okw0XYM2M5NTnBlF48zGoTmWTLOO9MAVEAe+1hYwP/TrpmjMycReZ/
	KZWRunNs13d3F7ymyXhFPlfKDftkNxX0FtSTfFce3UkzNq78tRG6nRG/eT+s1k1/+7Wp8Yjyqb2
	oFekWDOIy0U1PsfbFTfp3YiNOa+4ePJ+quSov9M80sOBCZn0IROJREeXD/zlA0ULVYpxgVdTlWQ
	+aC56t1jWGb216Lt/R9fN9Mc6+O2GxhcmLA41UOVMHG1wrfJg14i+h7PAlQ4q7yA3UYJmVDIZK3
	qDxzWx0ghy80xTocMd/4UfHh01QShfIkZJ4wz8y1gpRE+0e0NgsoP1cIzLvftTT6sUpZSYqQIjd
	w/q0=
X-Google-Smtp-Source: AGHT+IHMnQL99sUjCpafDVBKNEwv0T97vx90aeArCF4R3+H/Zy3yyGJtPef038xTQz0YoeD5R0PH/Q==
X-Received: by 2002:a17:903:44c:b0:22e:3b65:9286 with SMTP id d9443c01a7336-23414fc7372mr173251535ad.49.1748404193924;
        Tue, 27 May 2025 20:49:53 -0700 (PDT)
Received: from localhost.localdomain ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-234d35ac417sm2074505ad.169.2025.05.27.20.49.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 May 2025 20:49:53 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: alexei.starovoitov@gmail.com,
	rostedt@goodmis.org,
	jolsa@kernel.org
Cc: bpf@vger.kernel.org,
	Menglong Dong <dongml2@chinatelecom.cn>,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next 08/25] bpf: introduce bpf_gtramp_link
Date: Wed, 28 May 2025 11:46:55 +0800
Message-Id: <20250528034712.138701-9-dongml2@chinatelecom.cn>
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

Introduce the struct bpf_gtramp_link, which is used to attach
a bpf prog to multi functions. Meanwhile, introduce corresponding
function bpf_gtrampoline_{link,unlink}_prog.

The lock global_tr_lock is held during global trampoline link and unlink.
Why we define the global_tr_lock as rw_semaphore? Well, it should be mutex
here, but we will use the rw_semaphore in the later patch for the
trampoline override case :/

When unlink the global trampoline link, we mark all the function in the
bpf_gtramp_link with KFUNC_MD_FL_BPF_REMOVING and update the global
trampoline with bpf_gtrampoline_update(). If this is the last bpf prog
in the kfunc_md, the function will be remove from the filter_hash of the
ftrace_ops of bpf_global_trampoline. Then, we remove the bpf prog from
the kfunc_md, and free the kfunc_md if necessary.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 include/linux/bpf.h     |  31 +++++++
 kernel/bpf/trampoline.c | 183 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 214 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 8979e397ea06..7527399bab5b 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -58,12 +58,15 @@ struct bpf_token;
 struct user_namespace;
 struct super_block;
 struct inode;
+struct bpf_tramp_link;
+struct bpf_gtramp_link;
 
 extern struct idr btf_idr;
 extern spinlock_t btf_idr_lock;
 extern struct kobject *btf_kobj;
 extern struct bpf_mem_alloc bpf_global_ma, bpf_global_percpu_ma;
 extern bool bpf_global_ma_set;
+extern struct bpf_global_trampoline global_tr;
 
 typedef u64 (*bpf_callback_t)(u64, u64, u64, u64, u64);
 typedef int (*bpf_iter_init_seq_priv_t)(void *private_data,
@@ -1279,6 +1282,12 @@ struct bpf_trampoline {
 	struct bpf_tramp_image *cur_image;
 };
 
+struct bpf_global_trampoline {
+	struct list_head list;
+	struct ftrace_ops *fops;
+	void *image;
+};
+
 struct bpf_attach_target_info {
 	struct btf_func_model fmodel;
 	long tgt_addr;
@@ -1382,6 +1391,12 @@ struct bpf_trampoline *bpf_trampoline_get(u64 key,
 void bpf_trampoline_put(struct bpf_trampoline *tr);
 int arch_prepare_bpf_dispatcher(void *image, void *buf, s64 *funcs, int num_funcs);
 
+#ifdef CONFIG_ARCH_HAS_BPF_GLOBAL_CALLER
+void bpf_global_caller(void);
+#endif
+int bpf_gtrampoline_link_prog(struct bpf_gtramp_link *link);
+int bpf_gtrampoline_unlink_prog(struct bpf_gtramp_link *link);
+
 /*
  * When the architecture supports STATIC_CALL replace the bpf_dispatcher_fn
  * indirection with a direct call to the bpf program. If the architecture does
@@ -1746,6 +1761,22 @@ struct bpf_shim_tramp_link {
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
index da4be23f03c3..be06dd76505a 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -13,6 +13,7 @@
 #include <linux/bpf_verifier.h>
 #include <linux/bpf_lsm.h>
 #include <linux/delay.h>
+#include <linux/kfunc_md.h>
 
 /* dummy _ops. The verifier will operate on target program's ops. */
 const struct bpf_verifier_ops bpf_extension_verifier_ops = {
@@ -29,6 +30,10 @@ static struct hlist_head trampoline_table[TRAMPOLINE_TABLE_SIZE];
 /* serializes access to trampoline_table */
 static DEFINE_MUTEX(trampoline_mutex);
 
+struct bpf_global_trampoline global_tr;
+static DECLARE_RWSEM(global_tr_lock);
+static const struct bpf_link_ops bpf_shim_tramp_link_lops;
+
 #ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
 static int bpf_trampoline_update(struct bpf_trampoline *tr, bool lock_direct_mutex);
 
@@ -645,6 +650,172 @@ int bpf_trampoline_unlink_prog(struct bpf_tramp_link *link,
 	return err;
 }
 
+#if defined(CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS) && defined(CONFIG_ARCH_HAS_BPF_GLOBAL_CALLER)
+static int bpf_gtrampoline_update(struct bpf_global_trampoline *tr)
+{
+	struct ftrace_ops *fops;
+	int ips_count, err = 0;
+	void **ips = NULL;
+
+	ips_count = kfunc_md_bpf_ips(&ips);
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
+#else
+static int bpf_gtrampoline_update(struct bpf_global_trampoline *tr)
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
+	kfunc_md_lock();
+	for (int i = 0; i < cnt; i++) {
+		md = kfunc_md_get_noref((long)link->entries[i].addr);
+		if (WARN_ON_ONCE(!md)) {
+			err = -EINVAL;
+			break;
+		}
+
+		if (md->tramp)
+			bpf_gtrampoline_remove(md->tramp, link->link.prog, false);
+
+		md->flags &= ~KFUNC_MD_FL_BPF_REMOVING;
+		err = kfunc_md_bpf_unlink(md, link->link.prog, kind);
+		kfunc_md_put_entry(md);
+		if (err)
+			break;
+	}
+	kfunc_md_unlock();
+
+	return err;
+}
+
+int bpf_gtrampoline_unlink_prog(struct bpf_gtramp_link *link)
+{
+	struct kfunc_md *md;
+	int err;
+
+
+	/* hold the global trampoline lock, to make the target functions
+	 * consist during we unlink the prog.
+	 */
+	down_read(&global_tr_lock);
+	/* update the kfunc_md status, meanwhile update corresponding fops */
+	kfunc_md_lock();
+	for (int i = 0; i < link->entry_cnt; i++) {
+		md = kfunc_md_get_noref((long)link->entries[i].addr);
+		if (WARN_ON_ONCE(!md))
+			continue;
+
+		md->flags |= KFUNC_MD_FL_BPF_REMOVING;
+	}
+	kfunc_md_unlock();
+
+	bpf_gtrampoline_update(&global_tr);
+
+	/* update the ftrace filter first, then the corresponding kfunc_md */
+	err = __bpf_gtrampoline_unlink_prog(link, link->entry_cnt);
+	up_read(&global_tr_lock);
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
+	prog = link->link.prog;
+	kind = bpf_attach_type_to_tramp(prog);
+
+	/* hold the global trampoline lock, to make the target functions
+	 * consist during we link the prog.
+	 */
+	down_read(&global_tr_lock);
+
+	/* update the bpf prog to all the corresponding function metadata */
+	for (i = 0; i < link->entry_cnt; i++) {
+		entry = &link->entries[i];
+		/* it seems that we hold this lock too long, we can use rcu
+		 * lock instead.
+		 */
+		kfunc_md_lock();
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
+			kfunc_md_put_entry(md);
+			kfunc_md_unlock();
+			goto on_fallback;
+		}
+		kfunc_md_unlock();
+	}
+
+	if (update) {
+		err = bpf_gtrampoline_update(&global_tr);
+		if (err)
+			goto on_fallback;
+	}
+	up_read(&global_tr_lock);
+
+	return 0;
+
+on_fallback:
+	__bpf_gtrampoline_unlink_prog(link, i);
+	up_read(&global_tr_lock);
+
+	return err;
+}
+
 #if defined(CONFIG_CGROUP_BPF) && defined(CONFIG_BPF_LSM)
 static void bpf_shim_tramp_link_release(struct bpf_link *link)
 {
@@ -1131,6 +1302,18 @@ static int __init init_trampolines(void)
 {
 	int i;
 
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
+	global_tr.fops = kzalloc(sizeof(struct ftrace_ops), GFP_KERNEL);
+	if (!global_tr.fops)
+		return -ENOMEM;
+
+	global_tr.fops->private = &global_tr;
+	global_tr.fops->ops_func = bpf_tramp_ftrace_ops_func;
+#endif
+#ifdef CONFIG_ARCH_HAS_BPF_GLOBAL_CALLER
+	global_tr.image = bpf_global_caller;
+#endif
+
 	for (i = 0; i < TRAMPOLINE_TABLE_SIZE; i++)
 		INIT_HLIST_HEAD(&trampoline_table[i]);
 	return 0;
-- 
2.39.5


