Return-Path: <bpf+bounces-31003-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1336E8D5E5C
	for <lists+bpf@lfdr.de>; Fri, 31 May 2024 11:34:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBBBF287681
	for <lists+bpf@lfdr.de>; Fri, 31 May 2024 09:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F58E1422A2;
	Fri, 31 May 2024 09:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="NLOye7sb";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="egjcXQtp";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="NLOye7sb";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="egjcXQtp"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E99B8824BF;
	Fri, 31 May 2024 09:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717148024; cv=none; b=D+03J0ZueNaP4sv4xKZOt40Z3TMc518ftsgquJmvt+IKgro1bYLeLDCg/0fDi4lzVzYBo8Cwfd930DzFe5d1LMQx3cYgPTsgo1Cnil1nDsQ/Z0CmyTu0WOs68fkqpMvF6i8nHDMdGPAXC4nc4ZH+QYZ7aVTZTmJayAIfJQXB2ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717148024; c=relaxed/simple;
	bh=vTRWDEiZmQG/0nVeGn4k6YE6j0cmGkb0kjfMM8odYQo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Na1StpdZ7JZkV8uWlfCn0ufxx3jYtZ1WGOnmkCHAUdKS3V0238xcT/o1DwSIrAT8WfNBPG/R1WAZDdY9bV+W/EMa5t2KyrhymN+HHLpZOWnyY/0SScC5m6eh5ZJBMtObSOdvC8TX/WL1E+/rWKPqu0D8CqGdxHr5Hlwj3YQnNxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=NLOye7sb; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=egjcXQtp; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=NLOye7sb; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=egjcXQtp; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 306CE21B29;
	Fri, 31 May 2024 09:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1717148020; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t8Mu1INP306CXVJLbtkEYc46ROCJCSbEjjUhioLXt6I=;
	b=NLOye7sbpB3u1184zrlaGLIfhjypv/L8wYQ7PttPtS19iOcn1heYNY/JhSZeqtmHmbGxHu
	OUeoUpvWM/WYj4FpaEZxsX90CaKbPaXZNHqaRpvzqIkQkwAcdTgH89ltA29ELTOr3hXNSA
	lCa6qtULc7LPWZeIOKoGPqhNDLgZNC8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1717148020;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t8Mu1INP306CXVJLbtkEYc46ROCJCSbEjjUhioLXt6I=;
	b=egjcXQtpYNPE0TganvgfvmKJWiJQ/5fLjMR5R9KMtaSX1BeJ1Ih1v57ryPctvr1Dv1VIM8
	kBCA6IwOGoLvXhAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1717148020; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t8Mu1INP306CXVJLbtkEYc46ROCJCSbEjjUhioLXt6I=;
	b=NLOye7sbpB3u1184zrlaGLIfhjypv/L8wYQ7PttPtS19iOcn1heYNY/JhSZeqtmHmbGxHu
	OUeoUpvWM/WYj4FpaEZxsX90CaKbPaXZNHqaRpvzqIkQkwAcdTgH89ltA29ELTOr3hXNSA
	lCa6qtULc7LPWZeIOKoGPqhNDLgZNC8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1717148020;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t8Mu1INP306CXVJLbtkEYc46ROCJCSbEjjUhioLXt6I=;
	b=egjcXQtpYNPE0TganvgfvmKJWiJQ/5fLjMR5R9KMtaSX1BeJ1Ih1v57ryPctvr1Dv1VIM8
	kBCA6IwOGoLvXhAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0B90913A90;
	Fri, 31 May 2024 09:33:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YGCIAnSZWWZKHQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 31 May 2024 09:33:40 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Date: Fri, 31 May 2024 11:33:33 +0200
Subject: [PATCH RFC 2/4] error-injection: support static keys around
 injectable functions
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240531-fault-injection-statickeys-v1-2-a513fd0a9614@suse.cz>
References: <20240531-fault-injection-statickeys-v1-0-a513fd0a9614@suse.cz>
In-Reply-To: <20240531-fault-injection-statickeys-v1-0-a513fd0a9614@suse.cz>
To: Akinobu Mita <akinobu.mita@gmail.com>, Christoph Lameter <cl@linux.com>, 
 David Rientjes <rientjes@google.com>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, 
 Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Steven Rostedt <rostedt@goodmis.org>, Mark Rutland <mark.rutland@arm.com>
Cc: Jiri Olsa <jolsa@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
 Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-kernel@vger.kernel.org, 
 linux-mm@kvack.org, bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 Vlastimil Babka <vbabka@suse.cz>
X-Mailer: b4 0.13.0
X-Spam-Level: 
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_TO(0.00)[gmail.com,linux.com,google.com,kernel.org,iogearbox.net,linux.ibm.com,intel.com,davemloft.net,goodmis.org,arm.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,linux.dev,gmail.com,vger.kernel.org,kvack.org,suse.cz];
	R_RATELIMIT(0.00)[to_ip_from(RL5nkphuxq5kxo98ppmuqoc8wo)];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -6.80
X-Spam-Flag: NO

Error injectable functions cannot be inlined and since some are called
from hot paths, this incurrs overhead even if no error injection is
enabled for them.

To remove this overhead when disabled, allow the callsites of error
injectable functions to put the calls behind a static key, which the
framework can control when error injection is enabled or disabled for
the function.

Introduce a new ALLOW_ERROR_INJECTION_KEY() macro that adds a parameter
with the static key's address, and store it in struct
error_injection_entry. This new field has caused a mismatch when
populating the injection list from the _error_injection_whitelist
section with the current STRUCT_ALIGN(), so change the alignment to 8.

During the population, copy the key's address also to struct ei_entry,
and make it possible to retrieve it along with the error type by
get_injectable_error_type().

Finally, make the processing of writes to the debugfs inject file enable
the static key when the function is added to the injection list, and
disable when removed.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 include/asm-generic/error-injection.h | 13 ++++++++++++-
 include/asm-generic/vmlinux.lds.h     |  2 +-
 include/linux/error-injection.h       |  9 ++++++---
 kernel/fail_function.c                | 22 +++++++++++++++++++---
 lib/error-inject.c                    |  6 +++++-
 5 files changed, 43 insertions(+), 9 deletions(-)

diff --git a/include/asm-generic/error-injection.h b/include/asm-generic/error-injection.h
index b05253f68eaa..eed2731f3820 100644
--- a/include/asm-generic/error-injection.h
+++ b/include/asm-generic/error-injection.h
@@ -12,6 +12,7 @@ enum {
 
 struct error_injection_entry {
 	unsigned long	addr;
+	unsigned long	static_key_addr;
 	int		etype;
 };
 
@@ -25,16 +26,26 @@ struct pt_regs;
  * 'Error Injectable Functions' section.
  */
 #define ALLOW_ERROR_INJECTION(fname, _etype)				\
-static struct error_injection_entry __used				\
+static struct error_injection_entry __used __aligned(8)			\
 	__section("_error_injection_whitelist")				\
 	_eil_addr_##fname = {						\
 		.addr = (unsigned long)fname,				\
 		.etype = EI_ETYPE_##_etype,				\
 	}
 
+#define ALLOW_ERROR_INJECTION_KEY(fname, _etype, key)			\
+static struct error_injection_entry __used __aligned(8)			\
+	__section("_error_injection_whitelist")				\
+	_eil_addr_##fname = {						\
+		.addr = (unsigned long)fname,				\
+		.static_key_addr = (unsigned long)key,			\
+		.etype = EI_ETYPE_##_etype,				\
+	}
+
 void override_function_with_return(struct pt_regs *regs);
 #else
 #define ALLOW_ERROR_INJECTION(fname, _etype)
+#define ALLOW_ERROR_INJECTION_KEY(fname, _etype, key)
 
 static inline void override_function_with_return(struct pt_regs *regs) { }
 #endif
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 5703526d6ebf..1b15a0af2a00 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -248,7 +248,7 @@
 
 #ifdef CONFIG_FUNCTION_ERROR_INJECTION
 #define ERROR_INJECT_WHITELIST()			\
-	STRUCT_ALIGN();					\
+	. = ALIGN(8);					\
 	BOUNDED_SECTION(_error_injection_whitelist)
 #else
 #define ERROR_INJECT_WHITELIST()
diff --git a/include/linux/error-injection.h b/include/linux/error-injection.h
index 20e738f4eae8..bec81b57a9d5 100644
--- a/include/linux/error-injection.h
+++ b/include/linux/error-injection.h
@@ -6,10 +6,12 @@
 #include <linux/errno.h>
 #include <asm-generic/error-injection.h>
 
+struct static_key;
+
 #ifdef CONFIG_FUNCTION_ERROR_INJECTION
 
-extern bool within_error_injection_list(unsigned long addr);
-extern int get_injectable_error_type(unsigned long addr);
+bool within_error_injection_list(unsigned long addr);
+int get_injectable_error_type(unsigned long addr, struct static_key **key_addr);
 
 #else /* !CONFIG_FUNCTION_ERROR_INJECTION */
 
@@ -18,7 +20,8 @@ static inline bool within_error_injection_list(unsigned long addr)
 	return false;
 }
 
-static inline int get_injectable_error_type(unsigned long addr)
+static inline int get_injectable_error_type(unsigned long addr,
+					    struct static_key **key_addr)
 {
 	return -EOPNOTSUPP;
 }
diff --git a/kernel/fail_function.c b/kernel/fail_function.c
index d971a0189319..9240eb137e00 100644
--- a/kernel/fail_function.c
+++ b/kernel/fail_function.c
@@ -27,15 +27,16 @@ struct fei_attr {
 	struct list_head list;
 	struct kprobe kp;
 	unsigned long retval;
+	struct static_key *key;
 };
 static DEFINE_MUTEX(fei_lock);
 static LIST_HEAD(fei_attr_list);
 static DECLARE_FAULT_ATTR(fei_fault_attr);
 static struct dentry *fei_debugfs_dir;
 
-static unsigned long adjust_error_retval(unsigned long addr, unsigned long retv)
+static unsigned long __adjust_error_retval(int type, unsigned long retv)
 {
-	switch (get_injectable_error_type(addr)) {
+	switch (type) {
 	case EI_ETYPE_NULL:
 		return 0;
 	case EI_ETYPE_ERRNO:
@@ -53,9 +54,17 @@ static unsigned long adjust_error_retval(unsigned long addr, unsigned long retv)
 	return retv;
 }
 
+static unsigned long adjust_error_retval(unsigned long addr, unsigned long retv)
+{
+	int type = get_injectable_error_type(addr, NULL);
+
+	return __adjust_error_retval(type, retv);
+}
+
 static struct fei_attr *fei_attr_new(const char *sym, unsigned long addr)
 {
 	struct fei_attr *attr;
+	int type;
 
 	attr = kzalloc(sizeof(*attr), GFP_KERNEL);
 	if (attr) {
@@ -66,7 +75,10 @@ static struct fei_attr *fei_attr_new(const char *sym, unsigned long addr)
 		}
 		attr->kp.pre_handler = fei_kprobe_handler;
 		attr->kp.post_handler = fei_post_handler;
-		attr->retval = adjust_error_retval(addr, 0);
+
+		type = get_injectable_error_type(addr, &attr->key);
+		attr->retval = __adjust_error_retval(type, 0);
+
 		INIT_LIST_HEAD(&attr->list);
 	}
 	return attr;
@@ -218,6 +230,8 @@ static int fei_open(struct inode *inode, struct file *file)
 
 static void fei_attr_remove(struct fei_attr *attr)
 {
+	if (attr->key)
+		static_key_slow_dec(attr->key);
 	fei_debugfs_remove_attr(attr);
 	unregister_kprobe(&attr->kp);
 	list_del(&attr->list);
@@ -295,6 +309,8 @@ static ssize_t fei_write(struct file *file, const char __user *buffer,
 		fei_attr_free(attr);
 		goto out;
 	}
+	if (attr->key)
+		static_key_slow_inc(attr->key);
 	fei_debugfs_add_attr(attr);
 	list_add_tail(&attr->list, &fei_attr_list);
 	ret = count;
diff --git a/lib/error-inject.c b/lib/error-inject.c
index 887acd9a6ea6..e5f3b63f0dbb 100644
--- a/lib/error-inject.c
+++ b/lib/error-inject.c
@@ -17,6 +17,7 @@ struct ei_entry {
 	struct list_head list;
 	unsigned long start_addr;
 	unsigned long end_addr;
+	struct static_key *key;
 	int etype;
 	void *priv;
 };
@@ -37,7 +38,7 @@ bool within_error_injection_list(unsigned long addr)
 	return ret;
 }
 
-int get_injectable_error_type(unsigned long addr)
+int get_injectable_error_type(unsigned long addr, struct static_key **key_addr)
 {
 	struct ei_entry *ent;
 	int ei_type = -EINVAL;
@@ -46,6 +47,8 @@ int get_injectable_error_type(unsigned long addr)
 	list_for_each_entry(ent, &error_injection_list, list) {
 		if (addr >= ent->start_addr && addr < ent->end_addr) {
 			ei_type = ent->etype;
+			if (key_addr)
+				*key_addr = ent->key;
 			break;
 		}
 	}
@@ -86,6 +89,7 @@ static void populate_error_injection_list(struct error_injection_entry *start,
 		ent->start_addr = entry;
 		ent->end_addr = entry + size;
 		ent->etype = iter->etype;
+		ent->key = (struct static_key *) iter->static_key_addr;
 		ent->priv = priv;
 		INIT_LIST_HEAD(&ent->list);
 		list_add_tail(&ent->list, &error_injection_list);

-- 
2.45.1


