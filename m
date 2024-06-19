Return-Path: <bpf+bounces-32543-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C142490F961
	for <lists+bpf@lfdr.de>; Thu, 20 Jun 2024 00:50:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54721283B4A
	for <lists+bpf@lfdr.de>; Wed, 19 Jun 2024 22:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5D2E15B978;
	Wed, 19 Jun 2024 22:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="smRbBT/c";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="g3E3XRzi";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="smRbBT/c";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="g3E3XRzi"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE9C80C15;
	Wed, 19 Jun 2024 22:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718837387; cv=none; b=arnBbHzdkOa6E3iTraKNCzH3zl5LctpUbHVSpv2gqfQAUg2loF8RXAUaz7QB4cO0LUPvTRt+1NiJUiZZPL+t7niNrXi8BwnGyRwWskQUF+pEeB1BUXIUSs54rkJAj8i3yja7WajnlzcqwzsEH05Ap0bCXce3mnEd/sSI1keTHoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718837387; c=relaxed/simple;
	bh=/cKM1m+IMVDzuJzFS+1fl48bPoWvR2tEgzVaVUXVT8A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MUzScgJFsBHOY4IOyTTKkV3zuNI1ZIIOY/8FyxDM9/ZuOZ+mcrHFKMsQ8y6Evp3bRmmAIqnYLX76euApKKrCLqtT9rMnfiVSTdNGRjTDLPkIaBlWlac+DCY3TkF5bseUJlXTCnAi33TSwHCN4KWlyADOqZO756rAvH3S5trC/u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=smRbBT/c; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=g3E3XRzi; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=smRbBT/c; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=g3E3XRzi; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 25D261F7F5;
	Wed, 19 Jun 2024 22:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1718837383; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r7eLs3qWVHkCYzNUctfASvMgvFekhPcbd8a5b9Uty8M=;
	b=smRbBT/csZSGJtlsJ4JN3oklSIC7vbquyuWyYFQK4X7uOph5tB+4a752AntXvJy1S6SyqH
	IS3Q3mHFdaV3Nuk7YxxoaL7OyDll3aJ5H4tMiqF2zEByxywgSPn6DUWnsDAtqd2l0oVEwI
	Ih3Y7GYugjJN390WQpBeTcoBGFUj6Z4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1718837383;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r7eLs3qWVHkCYzNUctfASvMgvFekhPcbd8a5b9Uty8M=;
	b=g3E3XRziF6HgkAAPS88wKQ5lNo4texbHFNeFeEwV0v4mYHhP+i771BZm1quZ/kUsnkbfs9
	f1WTtAqzsMR7PdDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1718837383; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r7eLs3qWVHkCYzNUctfASvMgvFekhPcbd8a5b9Uty8M=;
	b=smRbBT/csZSGJtlsJ4JN3oklSIC7vbquyuWyYFQK4X7uOph5tB+4a752AntXvJy1S6SyqH
	IS3Q3mHFdaV3Nuk7YxxoaL7OyDll3aJ5H4tMiqF2zEByxywgSPn6DUWnsDAtqd2l0oVEwI
	Ih3Y7GYugjJN390WQpBeTcoBGFUj6Z4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1718837383;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r7eLs3qWVHkCYzNUctfASvMgvFekhPcbd8a5b9Uty8M=;
	b=g3E3XRziF6HgkAAPS88wKQ5lNo4texbHFNeFeEwV0v4mYHhP+i771BZm1quZ/kUsnkbfs9
	f1WTtAqzsMR7PdDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0152E13ABD;
	Wed, 19 Jun 2024 22:49:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0PuTO4Zgc2aFIAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 19 Jun 2024 22:49:42 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Date: Thu, 20 Jun 2024 00:48:55 +0200
Subject: [PATCH v2 1/7] fault-inject: add support for static keys around
 fault injection sites
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240620-fault-injection-statickeys-v2-1-e23947d3d84b@suse.cz>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4698; i=vbabka@suse.cz;
 h=from:subject:message-id; bh=/cKM1m+IMVDzuJzFS+1fl48bPoWvR2tEgzVaVUXVT8A=;
 b=owEBbQGS/pANAwAIAbvgsHXSRYiaAcsmYgBmc2Byf1V3Bpp5LNGsY/c7Mzv3/GsPZ55FjBkLd
 LX7xvgBpSWJATMEAAEIAB0WIQR7u8hBFZkjSJZITfG74LB10kWImgUCZnNgcgAKCRC74LB10kWI
 mrooB/987gBj0pha0dvAhFXZiGUJdrVCDtQ6t2BV/SIlkveQM37wjVIcJKlT46POmu0EAVLbGts
 rfVWVX5e4aCI80nZ5KpkSs0COyqzR+4Eym09R0s0Mm29ctQ8BJYXISybtjvacF6lT2sDF1PvZG8
 i3JzV58YERvX5BU+hxW2HjtgpEHgCzBBjFK/t/heKLFCeork00ZpNgQXER2fUDtpVCd4m62wTb9
 aJr4p+K+XdUOvo164UnmBjTbqVN9BjUYA1laDaYyZ5+8942w7HBeyumYAqx3oJBarTi3ujoosjc
 1Yyw2OhX6svXSoURISrllNMod+BTK/2jVgFrBLmcWyLPRwOW
X-Developer-Key: i=vbabka@suse.cz; a=openpgp;
 fpr=A940D434992C2E8E99103D50224FA7E7CC82A664
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email]
X-Spam-Flag: NO
X-Spam-Score: -6.80
X-Spam-Level: 

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
after other necessary preparatory changes, and not for any of the
configfs based fault injection users.

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
index d608f9b48c10..de9552cb22d0 100644
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
+	debugfs_create_file("probability", mode, dir, attr, &fops_prob);
 	debugfs_create_ul("interval", mode, dir, &attr->interval);
 	debugfs_create_atomic_t("times", mode, dir, &attr->times);
 	debugfs_create_atomic_t("space", mode, dir, &attr->space);

-- 
2.45.2


