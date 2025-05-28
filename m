Return-Path: <bpf+bounces-59092-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CCB95AC604B
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 05:50:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 288541BA7A19
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 03:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E19D1FBC91;
	Wed, 28 May 2025 03:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O4UobeVk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270811F3BA9;
	Wed, 28 May 2025 03:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748404187; cv=none; b=Vnhtz+4k6Gc0oy9P3xFf6/c29l8cIXvUNKQlohoZJt7FdsS1AcSVA1ns9zoCslQ+gUnH6Hw3ubU1qpYr2zbC5z7OP3JDFtEw8kPybsJqedKnzCYByXmdNIUe3XznqeQJ3suVJuPU6KaynG8p4jsUyCFUt2xE4Q89T5CnWMDvBRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748404187; c=relaxed/simple;
	bh=id6lILaKdgBMWZnpVnlNqUcvsPute9DuoXqlXPJA44M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MRhuOg7R2DaJ9TmBierJoEF9Iu1baqHYZkyHXi+w9YEKmh91FsUBnGYC0ggoZxIOuI3pKG0rrr0eGmuDFYOP0ru9cFvHPzEnZv7s+ATdUw/kzCkDL6cd+Rd5woRvOs3rE6CFJFv+fnjteqful98M8SVtckm5pLfYXKflWsKJ1ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O4UobeVk; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-234c5b57557so4023365ad.3;
        Tue, 27 May 2025 20:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748404185; x=1749008985; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4y9BozBA9c7G/gYDE1RLJDCqW9V05vfoBze499QJjhM=;
        b=O4UobeVkNlZhQoGr1n4S9Yqb9XmBbR9BYo9cmADT7dHko4B93HkST0yrSTdTridsze
         gh8j3ZVC0XVc6CbRFZ4T9aN9XHP3McMJnwbCRSaSwqLznKUNMuFHNoRro90r0SfzGjCJ
         2TdYduJXW/CI6Hoy0gTieOevIF8Ux6APGra8EoHQZML6et3bNpTeRm1rCHkFVOlXnLmU
         M6mI5dYX99HzuK+rkzyM67gHUtgDw8Vq5OCKHIZzxzpD4fFH5nv5nddZJn9XJq/nR2Jf
         drlcj2yUkeFqh36aJeJw2vZ10//bUW+XeYYNb7sDLsWsfWpnHN0g6noBgq9S/ochS6rS
         kFmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748404185; x=1749008985;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4y9BozBA9c7G/gYDE1RLJDCqW9V05vfoBze499QJjhM=;
        b=boeFxjf/zM1/eZ8BIJ1MuLBXPLjsZpYf2KW4wIBG2E4QFtO31xr5RBcXRPN0Wcs6kU
         k3RDJvty93CJ7aIFOIuS3UTsizkiElcAFbfI6LS+r9fNHQHJXI5v8nQ9pt9gm030ilf1
         KCfvfeESOiTJDutfyMAWbOrgtQfi0VhZ3N4IdTlR71zeSu1fQ28viwQCPZl+a4s3q79c
         eKkRqXgon6MHOTN9HhGffI4qya8SqIx8UyeknnLT4AWOkCyu2nzeNwMA9aOlkZ40kJK/
         bMLWchOfQyaFP6LSXcZaRCnQvlmX5tqTMqBTBfANptpP7eTfMCYHPSKZSbdg6EviiDOz
         TCyA==
X-Forwarded-Encrypted: i=1; AJvYcCXtZN0O6FS/bOuKE4dxcuZwYr0sXuGRtG/21lYgyXL+GBZqrzyQDJow9FX2CZqjTFDHrm72ECU/yv9sDLs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzv8RSpRMh7QvouV8rbFkNjL72VBq86mtf5XD/hvpIQrX1zyNYC
	dO7tfy2bvkywvEtxycHbWayVzySHQnpGy3bPWBPLwLybzuTPUBBO4f4t
X-Gm-Gg: ASbGncv+KMSzWe/6uuuXCtmCRJOWPEFiNBCXILkWBmct6+Jc5EvfFO3+FoPVDWoCO6T
	VKbVxV2czqn5XGvKCGqe9YorXmy9NopEJJDHLzSxh7QKGw1hTalyJBSE3fqfbwYqpnUgjSHF5W4
	em9hmEJ0xc7J6tMJkaRGxaQHGkgxxvyxuV6dcTKz0MkgDNuHCIY4q36x47bErPtm06NrW3XwRb+
	CMUclYrkrZj1mr6ot4gVsR7wZTgpWAuaminsmQv6mSbb3ISguNEcAkVK/EysQuCgWc7dGGDASnM
	q4U4z9ZhO4Nv45m6iGg0YDhM75ZzuID+JH04XPuXjfXQCzenwNv1Rvfu5JzVYIqtCNYL7hJ9dH6
	ENtY=
X-Google-Smtp-Source: AGHT+IHgMrvnRk4C4QBdIIOR03RXWg25Wd0c+6j2FeK13WU7gMN5nz5BZ9oiNEdlJQNbPpve9T5v4g==
X-Received: by 2002:a17:903:40c5:b0:234:9fed:ccb2 with SMTP id d9443c01a7336-2349fedce43mr78841355ad.29.1748404185208;
        Tue, 27 May 2025 20:49:45 -0700 (PDT)
Received: from localhost.localdomain ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-234d35ac417sm2074505ad.169.2025.05.27.20.49.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 May 2025 20:49:44 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: alexei.starovoitov@gmail.com,
	rostedt@goodmis.org,
	jolsa@kernel.org
Cc: bpf@vger.kernel.org,
	Menglong Dong <dongml2@chinatelecom.cn>,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next 04/25] bpf: make kfunc_md support global trampoline link
Date: Wed, 28 May 2025 11:46:51 +0800
Message-Id: <20250528034712.138701-5-dongml2@chinatelecom.cn>
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

Introduce the struct kfunc_md_tramp_prog for BPF_PROG_TYPE_TRACING, and
add the field "bpf_progs" to struct kfunc_md. These filed will be used
in the next patch of bpf global trampoline.

And the KFUNC_MD_FL_TRACING_ORIGIN is introduced to indicate that origin
call is needed on this function.

Add the function kfunc_md_bpf_link and kfunc_md_bpf_unlink to add or
remove bpf prog to kfunc_md. Meanwhile, introduce kunfc_md_bpf_ips() to
get all the kernel functions in kfunc_mds that contains bpf progs.

The KFUNC_MD_FL_BPF_REMOVING indicate that a removing operation is in
progress, and we shouldn't return it if "bpf_prog_cnt<=1" in
kunfc_md_bpf_ips().

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 include/linux/kfunc_md.h |  17 ++++++
 kernel/trace/kfunc_md.c  | 118 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 135 insertions(+)

diff --git a/include/linux/kfunc_md.h b/include/linux/kfunc_md.h
index 21c0b879cc03..f1b1012eeab2 100644
--- a/include/linux/kfunc_md.h
+++ b/include/linux/kfunc_md.h
@@ -3,12 +3,21 @@
 #define _LINUX_KFUNC_MD_H
 
 #define KFUNC_MD_FL_DEAD		(1 << 0) /* the md shouldn't be reused */
+#define KFUNC_MD_FL_TRACING_ORIGIN	(1 << 1)
+#define KFUNC_MD_FL_BPF_REMOVING	(1 << 2)
 
 #ifndef __ASSEMBLER__
 
 #include <linux/kernel.h>
 #include <linux/bpf.h>
 
+struct kfunc_md_tramp_prog {
+	struct kfunc_md_tramp_prog *next;
+	struct bpf_prog *prog;
+	u64 cookie;
+	struct rcu_head rcu;
+};
+
 struct kfunc_md_array;
 
 struct kfunc_md {
@@ -19,6 +28,7 @@ struct kfunc_md {
 	struct rcu_head rcu;
 #endif
 	unsigned long func;
+	struct kfunc_md_tramp_prog *bpf_progs[BPF_TRAMP_MAX];
 #ifdef CONFIG_FUNCTION_METADATA
 	/* the array is used for the fast mode */
 	struct kfunc_md_array *array;
@@ -26,6 +36,7 @@ struct kfunc_md {
 	struct percpu_ref pcref;
 	u32 flags;
 	u16 users;
+	u8 bpf_prog_cnt;
 	u8 nr_args;
 };
 
@@ -40,5 +51,11 @@ void kfunc_md_exit(struct kfunc_md *md);
 void kfunc_md_enter(struct kfunc_md *md);
 bool kfunc_md_arch_support(int *insn, int *data);
 
+int kfunc_md_bpf_ips(void ***ips);
+
+int kfunc_md_bpf_unlink(struct kfunc_md *md, struct bpf_prog *prog, int type);
+int kfunc_md_bpf_link(struct kfunc_md *md, struct bpf_prog *prog, int type,
+		      u64 cookie);
+
 #endif
 #endif
diff --git a/kernel/trace/kfunc_md.c b/kernel/trace/kfunc_md.c
index 9571081f6560..ebb4e46d482d 100644
--- a/kernel/trace/kfunc_md.c
+++ b/kernel/trace/kfunc_md.c
@@ -131,6 +131,23 @@ static bool kfunc_md_fast(void)
 {
 	return static_branch_likely(&kfunc_md_use_padding);
 }
+
+static int kfunc_md_hash_bpf_ips(void **ips)
+{
+	struct hlist_head *head;
+	struct kfunc_md *md;
+	int c = 0, i;
+
+	for (i = 0; i < (1 << KFUNC_MD_HASH_BITS); i++) {
+		head = &kfunc_md_table[i];
+		hlist_for_each_entry(md, head, hash) {
+			if (md->bpf_prog_cnt > !!(md->flags & KFUNC_MD_FL_BPF_REMOVING))
+				ips[c++] = (void *)md->func;
+		}
+	}
+
+	return c;
+}
 #else
 
 static void kfunc_md_hash_put(struct kfunc_md *md)
@@ -148,6 +165,11 @@ static struct kfunc_md *kfunc_md_hash_create(unsigned long ip, int nr_args)
 }
 
 #define kfunc_md_fast() 1
+
+static int kfunc_md_hash_bpf_ips(void **ips)
+{
+	return 0;
+}
 #endif /* CONFIG_FUNCTION_METADATA_PADDING */
 
 #ifdef CONFIG_FUNCTION_METADATA
@@ -442,6 +464,19 @@ static struct kfunc_md *kfunc_md_fast_create(unsigned long ip, int nr_args)
 
 	return md;
 }
+
+static int kfunc_md_fast_bpf_ips(void **ips)
+{
+	struct kfunc_md *md;
+	int i, c = 0;
+
+	for (i = 0; i < kfunc_mds->kfunc_md_count; i++) {
+		md = &kfunc_mds->mds[i];
+		if (md->users && md->bpf_prog_cnt > !!(md->flags & KFUNC_MD_FL_BPF_REMOVING))
+			ips[c++] = (void *)md->func;
+	}
+	return c;
+}
 #else
 
 static void kfunc_md_fast_put(struct kfunc_md *md)
@@ -458,6 +493,10 @@ static struct kfunc_md *kfunc_md_fast_create(unsigned long ip, int nr_args)
 	return NULL;
 }
 
+static int kfunc_md_fast_bpf_ips(void **ips)
+{
+	return 0;
+}
 #endif /* !CONFIG_FUNCTION_METADATA */
 
 void kfunc_md_enter(struct kfunc_md *md)
@@ -547,6 +586,85 @@ struct kfunc_md *kfunc_md_create(unsigned long ip, int nr_args)
 }
 EXPORT_SYMBOL_GPL(kfunc_md_create);
 
+int kfunc_md_bpf_ips(void ***ips)
+{
+	void **tmp;
+	int c;
+
+	c = atomic_read(&kfunc_mds->kfunc_md_used);
+	if (!c)
+		return 0;
+
+	tmp = kmalloc_array(c, sizeof(*tmp), GFP_KERNEL);
+	if (!tmp)
+		return -ENOMEM;
+
+	rcu_read_lock();
+	c = CALL(kfunc_md_fast_bpf_ips, kfunc_md_hash_bpf_ips, int, tmp);
+	rcu_read_unlock();
+
+	*ips = tmp;
+
+	return c;
+}
+
+int kfunc_md_bpf_link(struct kfunc_md *md, struct bpf_prog *prog, int type,
+		      u64 cookie)
+{
+	struct kfunc_md_tramp_prog *tramp_prog, **last;
+
+	tramp_prog = md->bpf_progs[type];
+	/* check if the prog is already linked */
+	while (tramp_prog) {
+		if (tramp_prog->prog == prog)
+			return -EEXIST;
+		tramp_prog = tramp_prog->next;
+	}
+
+	tramp_prog = kmalloc(sizeof(*tramp_prog), GFP_KERNEL);
+	if (!tramp_prog)
+		return -ENOMEM;
+
+	tramp_prog->prog = prog;
+	tramp_prog->cookie = cookie;
+	tramp_prog->next = NULL;
+
+	/* add the new prog to the list tail */
+	last = &md->bpf_progs[type];
+	while (*last)
+		last = &(*last)->next;
+	*last = tramp_prog;
+
+	md->bpf_prog_cnt++;
+	if (type == BPF_TRAMP_FEXIT || type == BPF_TRAMP_MODIFY_RETURN)
+		md->flags |= KFUNC_MD_FL_TRACING_ORIGIN;
+
+	return 0;
+}
+
+int kfunc_md_bpf_unlink(struct kfunc_md *md, struct bpf_prog *prog, int type)
+{
+	struct kfunc_md_tramp_prog *cur, **prev;
+
+	prev = &md->bpf_progs[type];
+	while (*prev && (*prev)->prog != prog)
+		prev = &(*prev)->next;
+
+	cur = *prev;
+	if (!cur)
+		return -EINVAL;
+
+	*prev = cur->next;
+	kfree_rcu(cur, rcu);
+	md->bpf_prog_cnt--;
+
+	if (!md->bpf_progs[BPF_TRAMP_FEXIT] &&
+	    !md->bpf_progs[BPF_TRAMP_MODIFY_RETURN])
+		md->flags &= ~KFUNC_MD_FL_TRACING_ORIGIN;
+
+	return 0;
+}
+
 bool __weak kfunc_md_arch_support(int *insn, int *data)
 {
 	return false;
-- 
2.39.5


