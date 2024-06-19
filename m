Return-Path: <bpf+bounces-32541-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DBE290F95D
	for <lists+bpf@lfdr.de>; Thu, 20 Jun 2024 00:50:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEA851F236A2
	for <lists+bpf@lfdr.de>; Wed, 19 Jun 2024 22:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C81715B157;
	Wed, 19 Jun 2024 22:49:47 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F26077F10;
	Wed, 19 Jun 2024 22:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718837386; cv=none; b=bnQO/3hGfs1t7NJr4gGMVPm7vsm9uqaucs2DQxlYhI5YQjkAizsDiY5FazTSHJWomJwXSFZHSX6UtLf9bKdB9u/WE+sZbrr/6ftrNtqQBfP1pu1vN7dHstjTAUV2h3+iWymB9IfIhO3hlFqYseJw1at2t2/dkYrC03qO2XxwkdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718837386; c=relaxed/simple;
	bh=nCcr0F2SycRd4ZmkZlDmyM/fEKeGlbV/Lf6N6wPJuRc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fBB6QS6icyvN5LHJcPMurMQZqCwGFLZt7yrQi58ossh3gDo9SVPDQEkvus/3SYOAcqyxClrppVTMIlMtfd9iDOdMTgObpnmfiP2t676Ir1cbsiAiQizuD77jR5ucwC/DnOHvjPNPcqQEVbpOMFTF5Ne+cL5/Ds8XKwfynoVuZ4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 41DA621A2E;
	Wed, 19 Jun 2024 22:49:43 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1F2C313AC3;
	Wed, 19 Jun 2024 22:49:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id EHVGB4dgc2aFIAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 19 Jun 2024 22:49:43 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Date: Thu, 20 Jun 2024 00:48:56 +0200
Subject: [PATCH v2 2/7] error-injection: support static keys around
 injectable functions
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240620-fault-injection-statickeys-v2-2-e23947d3d84b@suse.cz>
References: <20240620-fault-injection-statickeys-v2-0-e23947d3d84b@suse.cz>
In-Reply-To: <20240620-fault-injection-statickeys-v2-0-e23947d3d84b@suse.cz>
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
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6789; i=vbabka@suse.cz;
 h=from:subject:message-id; bh=nCcr0F2SycRd4ZmkZlDmyM/fEKeGlbV/Lf6N6wPJuRc=;
 b=owEBbQGS/pANAwAIAbvgsHXSRYiaAcsmYgBmc2B1Frl4h+MJPB9HCCgG1OKOEt9S1LyDBVAEU
 7M0ia0/FuiJATMEAAEIAB0WIQR7u8hBFZkjSJZITfG74LB10kWImgUCZnNgdQAKCRC74LB10kWI
 mp78B/0Vz6PDUOi8A2kc1lduJ93rou5JOVEFkLMCT4JoJKKbCqgoG658Fnnx3HlaQKP7S28r1fP
 3vgXATaULFd5SCEjA0oxzDNE6YzK5EL7BA3K1xGx2ofu2hYba8jUh2vCZNZdX5+CZfVZ0ia4k1F
 HeqTxFmhEPAcJdAKjraSQVpcrsT7x5vV2wQojWCTDZ6JdWc8oL0+KJgVJG2ZQa3s8WdwYCP3nLu
 7jplQLjhYrn1Z/XT2KfZoM2MkKZtaAbOHvn26QSrMM7DkuEfK4dHHHDCMXkU9NPJ7I3zN5sUNll
 X6uoyBbRQtQVe7e4xWwoXZNVn1VN3YvXt5fClIg6WZkAwvHt
X-Developer-Key: i=vbabka@suse.cz; a=openpgp;
 fpr=A940D434992C2E8E99103D50224FA7E7CC82A664
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Queue-Id: 41DA621A2E
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[];
	TAGGED_RCPT(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

Error injectable functions cannot be inlined and since some are called
from hot paths, this incurs overhead even if no error injection is
enabled for them.

To avoid this overhead when disabled, allow the callsites of error
injectable functions to put the calls behind a static key, which the
framework can control when error injection is enabled or disabled for
the function.

Introduce a new ALLOW_ERROR_INJECTION_KEY() macro that adds a parameter
with the static key's address, and store it in struct
error_injection_entry. This new field has caused a mismatch when
populating the injection list from the _error_injection_whitelist
section using the current STRUCT_ALIGN(), so change the alignment to 8.

During the population, copy the key's address also to struct ei_entry,
and make it possible to retrieve it by get_injection_key().

Finally, make the processing of writes to the debugfs inject file enable
the static key when the function is added to the injection list, and
disable when removed.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 include/asm-generic/error-injection.h | 13 ++++++++++++-
 include/asm-generic/vmlinux.lds.h     |  2 +-
 include/linux/error-injection.h       | 12 ++++++++++--
 kernel/fail_function.c                | 10 ++++++++++
 lib/error-inject.c                    | 19 +++++++++++++++++++
 5 files changed, 52 insertions(+), 4 deletions(-)

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
index 20e738f4eae8..48da027c0302 100644
--- a/include/linux/error-injection.h
+++ b/include/linux/error-injection.h
@@ -6,10 +6,13 @@
 #include <linux/errno.h>
 #include <asm-generic/error-injection.h>
 
+struct static_key;
+
 #ifdef CONFIG_FUNCTION_ERROR_INJECTION
 
-extern bool within_error_injection_list(unsigned long addr);
-extern int get_injectable_error_type(unsigned long addr);
+bool within_error_injection_list(unsigned long addr);
+int get_injectable_error_type(unsigned long addr);
+struct static_key *get_injection_key(unsigned long addr);
 
 #else /* !CONFIG_FUNCTION_ERROR_INJECTION */
 
@@ -23,6 +26,11 @@ static inline int get_injectable_error_type(unsigned long addr)
 	return -EOPNOTSUPP;
 }
 
+static inline struct static_key *get_injection_key(unsigned long addr)
+{
+	return NULL;
+}
+
 #endif
 
 #endif /* _LINUX_ERROR_INJECTION_H */
diff --git a/kernel/fail_function.c b/kernel/fail_function.c
index d971a0189319..d39a9606a448 100644
--- a/kernel/fail_function.c
+++ b/kernel/fail_function.c
@@ -27,6 +27,7 @@ struct fei_attr {
 	struct list_head list;
 	struct kprobe kp;
 	unsigned long retval;
+	struct static_key *key;
 };
 static DEFINE_MUTEX(fei_lock);
 static LIST_HEAD(fei_attr_list);
@@ -67,6 +68,11 @@ static struct fei_attr *fei_attr_new(const char *sym, unsigned long addr)
 		attr->kp.pre_handler = fei_kprobe_handler;
 		attr->kp.post_handler = fei_post_handler;
 		attr->retval = adjust_error_retval(addr, 0);
+
+		attr->key = get_injection_key(addr);
+		if (IS_ERR(attr->key))
+			attr->key = NULL;
+
 		INIT_LIST_HEAD(&attr->list);
 	}
 	return attr;
@@ -218,6 +224,8 @@ static int fei_open(struct inode *inode, struct file *file)
 
 static void fei_attr_remove(struct fei_attr *attr)
 {
+	if (attr->key)
+		static_key_slow_dec(attr->key);
 	fei_debugfs_remove_attr(attr);
 	unregister_kprobe(&attr->kp);
 	list_del(&attr->list);
@@ -295,6 +303,8 @@ static ssize_t fei_write(struct file *file, const char __user *buffer,
 		fei_attr_free(attr);
 		goto out;
 	}
+	if (attr->key)
+		static_key_slow_inc(attr->key);
 	fei_debugfs_add_attr(attr);
 	list_add_tail(&attr->list, &fei_attr_list);
 	ret = count;
diff --git a/lib/error-inject.c b/lib/error-inject.c
index 887acd9a6ea6..982fbedd9ad5 100644
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
@@ -54,6 +55,23 @@ int get_injectable_error_type(unsigned long addr)
 	return ei_type;
 }
 
+struct static_key *get_injection_key(unsigned long addr)
+{
+	struct ei_entry *ent;
+	struct static_key *ei_key = ERR_PTR(-EINVAL);
+
+	mutex_lock(&ei_mutex);
+	list_for_each_entry(ent, &error_injection_list, list) {
+		if (addr >= ent->start_addr && addr < ent->end_addr) {
+			ei_key = ent->key;
+			break;
+		}
+	}
+	mutex_unlock(&ei_mutex);
+
+	return ei_key;
+}
+
 /*
  * Lookup and populate the error_injection_list.
  *
@@ -86,6 +104,7 @@ static void populate_error_injection_list(struct error_injection_entry *start,
 		ent->start_addr = entry;
 		ent->end_addr = entry + size;
 		ent->etype = iter->etype;
+		ent->key = (struct static_key *) iter->static_key_addr;
 		ent->priv = priv;
 		INIT_LIST_HEAD(&ent->list);
 		list_add_tail(&ent->list, &error_injection_list);

-- 
2.45.2


