Return-Path: <bpf+bounces-31002-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E6988D5E5A
	for <lists+bpf@lfdr.de>; Fri, 31 May 2024 11:34:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CC161C21040
	for <lists+bpf@lfdr.de>; Fri, 31 May 2024 09:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ADB784FC3;
	Fri, 31 May 2024 09:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="JssftoR6";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="/5hT1B4N";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="JssftoR6";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="/5hT1B4N"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E99F48286D;
	Fri, 31 May 2024 09:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717148023; cv=none; b=onyoEooCWWOXCKLoUbuEQil0byKvNaxGqbyoFN2I1Odpd1QFikZHaw9xdXg6kiMrUG6vZ4myntOl7KTVoNMX2TglKZRwknxkS2MbhbbG1lnrh4QUXPbrECtN6E5S5jZS9MA0qB3RM5ltF71W2h63P0mQisXFLY7rtqI2F8Zlh9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717148023; c=relaxed/simple;
	bh=bGXaWYl5eTRvWhzfLzb4sljod8QozsipxEcqDOyf9eY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BQOeXRrD2NlNHT/FOH04ZiMhGTAN3KNFN7nBR8zJM94iFsYQ+jeH4Bh6fB1uGIxc65DtbmEtxl1Vt3oOhQRpS2cMKHVZkoowLhuzd1v0kdgIAzOvgtPW3bwh9s1DJJj3vTSEkWzP+x35L+GrKb85DN9IHhII558jH0hd9BsAXtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=JssftoR6; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=/5hT1B4N; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=JssftoR6; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=/5hT1B4N; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 10AFD21B25;
	Fri, 31 May 2024 09:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1717148020; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u2635+TpURoaMWiOVxYkY4gXrnKDk2yUsxy6mghZqBU=;
	b=JssftoR6B7pLW9rYT+Tuv/kXK/+g2BXda/wOv7dsChTZxN/xGrJlQ1Jc6cmei7hmQSqNqP
	6rqvF2BKD8laRmpvrMaXDERqb2Lu+k87pA+l3hoXVTU+jtV4440OtAWW1jJpaGRb1oLD33
	LjQbmi/lydv2YxzuDTeIk5RFh3UnqbE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1717148020;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u2635+TpURoaMWiOVxYkY4gXrnKDk2yUsxy6mghZqBU=;
	b=/5hT1B4N5thhpu2CPFQv8Dbg+mgJCzLOUi8MarugqWlJa+NX1EDAVtQEkknmpwp0aRhQxi
	itSLEgs1gbsRQ2DQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1717148020; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u2635+TpURoaMWiOVxYkY4gXrnKDk2yUsxy6mghZqBU=;
	b=JssftoR6B7pLW9rYT+Tuv/kXK/+g2BXda/wOv7dsChTZxN/xGrJlQ1Jc6cmei7hmQSqNqP
	6rqvF2BKD8laRmpvrMaXDERqb2Lu+k87pA+l3hoXVTU+jtV4440OtAWW1jJpaGRb1oLD33
	LjQbmi/lydv2YxzuDTeIk5RFh3UnqbE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1717148020;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u2635+TpURoaMWiOVxYkY4gXrnKDk2yUsxy6mghZqBU=;
	b=/5hT1B4N5thhpu2CPFQv8Dbg+mgJCzLOUi8MarugqWlJa+NX1EDAVtQEkknmpwp0aRhQxi
	itSLEgs1gbsRQ2DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E3E9B13A64;
	Fri, 31 May 2024 09:33:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id eMBdN3OZWWZKHQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 31 May 2024 09:33:39 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Date: Fri, 31 May 2024 11:33:32 +0200
Subject: [PATCH RFC 1/4] fault-inject: add support for static keys around
 fault injection sites
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240531-fault-injection-statickeys-v1-1-a513fd0a9614@suse.cz>
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
X-Spam-Flag: NO
X-Spam-Score: -6.80
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

Some fault injection sites are placed in hotpaths and incur overhead
even if not enabled, due to one or more function calls leading up to
should_fail_ex() that returns false due to attr->probability == 0.

This overhead can be eliminated if the outermost call into the checks is
guarded with a static key, so add support for that. The framework should
be told that such static key exist for a fault_attr, by initializing
fault_attr->active with the static key address. When it's not NULL,
enable the static key from setup_fault_attr() when the fault probability
is non-zero.

Also wire up writing into debugfs "probability" file to enable or
disable the static key when transitioning between zero and non-zero
probability.

For now, do not add configfs interface support as the immediate plan is
to leverage this for should_failslab() and should_fail_alloc_page()
after other necessary preparatory changes, and none of the configfs
based fault injection users.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 include/linux/fault-inject.h |  7 ++++++-
 lib/fault-inject.c           | 43 ++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 48 insertions(+), 2 deletions(-)

diff --git a/include/linux/fault-inject.h b/include/linux/fault-inject.h
index 6d5edef09d45..cfe75cc1bac4 100644
--- a/include/linux/fault-inject.h
+++ b/include/linux/fault-inject.h
@@ -9,6 +9,7 @@
 #include <linux/configfs.h>
 #include <linux/ratelimit.h>
 #include <linux/atomic.h>
+#include <linux/jump_label.h>
 
 /*
  * For explanation of the elements of this struct, see
@@ -30,13 +31,14 @@ struct fault_attr {
 	unsigned long count;
 	struct ratelimit_state ratelimit_state;
 	struct dentry *dname;
+	struct static_key *active;
 };
 
 enum fault_flags {
 	FAULT_NOWARN =	1 << 0,
 };
 
-#define FAULT_ATTR_INITIALIZER {					\
+#define FAULT_ATTR_INITIALIZER_KEY(_key) {				\
 		.interval = 1,						\
 		.times = ATOMIC_INIT(1),				\
 		.require_end = ULONG_MAX,				\
@@ -44,8 +46,11 @@ enum fault_flags {
 		.ratelimit_state = RATELIMIT_STATE_INIT_DISABLED,	\
 		.verbose = 2,						\
 		.dname = NULL,						\
+		.active = (_key),					\
 	}
 
+#define FAULT_ATTR_INITIALIZER		FAULT_ATTR_INITIALIZER_KEY(NULL)
+
 #define DECLARE_FAULT_ATTR(name) struct fault_attr name = FAULT_ATTR_INITIALIZER
 int setup_fault_attr(struct fault_attr *attr, char *str);
 bool should_fail_ex(struct fault_attr *attr, ssize_t size, int flags);
diff --git a/lib/fault-inject.c b/lib/fault-inject.c
index d608f9b48c10..93c46d2ec106 100644
--- a/lib/fault-inject.c
+++ b/lib/fault-inject.c
@@ -35,6 +35,9 @@ int setup_fault_attr(struct fault_attr *attr, char *str)
 	atomic_set(&attr->times, times);
 	atomic_set(&attr->space, space);
 
+	if (probability != 0 && attr->active)
+		static_key_slow_inc(attr->active);
+
 	return 1;
 }
 EXPORT_SYMBOL_GPL(setup_fault_attr);
@@ -166,6 +169,12 @@ EXPORT_SYMBOL_GPL(should_fail);
 
 #ifdef CONFIG_FAULT_INJECTION_DEBUG_FS
 
+/*
+ * Protect updating probability from debugfs as that may trigger static key
+ * changes when changing between zero and non-zero.
+ */
+static DEFINE_MUTEX(probability_mutex);
+
 static int debugfs_ul_set(void *data, u64 val)
 {
 	*(unsigned long *)data = val;
@@ -186,6 +195,38 @@ static void debugfs_create_ul(const char *name, umode_t mode,
 	debugfs_create_file(name, mode, parent, value, &fops_ul);
 }
 
+static int debugfs_prob_set(void *data, u64 val)
+{
+	struct fault_attr *attr = data;
+
+	mutex_lock(&probability_mutex);
+
+	if (attr->active) {
+		if (attr->probability != 0 && val == 0) {
+			static_key_slow_dec(attr->active);
+		} else if (attr->probability == 0 && val != 0) {
+			static_key_slow_inc(attr->active);
+		}
+	}
+
+	attr->probability = val;
+
+	mutex_unlock(&probability_mutex);
+
+	return 0;
+}
+
+static int debugfs_prob_get(void *data, u64 *val)
+{
+	struct fault_attr *attr = data;
+
+	*val = attr->probability;
+
+	return 0;
+}
+
+DEFINE_SIMPLE_ATTRIBUTE(fops_prob, debugfs_prob_get, debugfs_prob_set, "%llu\n");
+
 #ifdef CONFIG_FAULT_INJECTION_STACKTRACE_FILTER
 
 static int debugfs_stacktrace_depth_set(void *data, u64 val)
@@ -218,7 +259,7 @@ struct dentry *fault_create_debugfs_attr(const char *name,
 	if (IS_ERR(dir))
 		return dir;
 
-	debugfs_create_ul("probability", mode, dir, &attr->probability);
+	debugfs_create_file("probability", mode, dir, &attr, &fops_prob);
 	debugfs_create_ul("interval", mode, dir, &attr->interval);
 	debugfs_create_atomic_t("times", mode, dir, &attr->times);
 	debugfs_create_atomic_t("space", mode, dir, &attr->space);

-- 
2.45.1


