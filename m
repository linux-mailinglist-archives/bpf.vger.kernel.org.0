Return-Path: <bpf+bounces-32542-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 55C4690F960
	for <lists+bpf@lfdr.de>; Thu, 20 Jun 2024 00:50:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFA841F23760
	for <lists+bpf@lfdr.de>; Wed, 19 Jun 2024 22:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90D4115B961;
	Wed, 19 Jun 2024 22:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="LNWxnnz1";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="roVh2sJJ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="LNWxnnz1";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="roVh2sJJ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE3082866;
	Wed, 19 Jun 2024 22:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718837387; cv=none; b=ooCWMl1uMPbhEg+xCNtqBoyCULLM5NBSg4ficUlCp9Hqc4c43dB8CY2zIT6N9ccf+C5DaJ378PcsTTZKHi0HwIeK6qTVTr3xsabzUXTUgrWDM2ohNb4I2B0acANC9fHKUpqTT1MH5r4IAF31LMfKPG2Fy+e3xg+eBgv0PGeUL9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718837387; c=relaxed/simple;
	bh=+HcqYdgaWT9BrUacvRJSWp4CDbAKfRkRibADsrgT2bU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Xr2du9jHi1mCaLJ7lThD6wAHe6VX+q0VapdsLXZ6f3R/40o4DAhvHZRMuDK/JIVjFtc/q+5ZA0wUj85tfabZP4VYzk9gRG2e4thzuvFbtPXMptyU6ALHs1ijZvQBCZ+A7YPQHvMaGasl4SN4jj9sMGCSWax1I3nkkYe9rab+X2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=LNWxnnz1; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=roVh2sJJ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=LNWxnnz1; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=roVh2sJJ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 994E01F7F7;
	Wed, 19 Jun 2024 22:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1718837383; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X7+XAotVIvWS2vTh75oVQOPFwsOci6tWQZhDoSRQGx4=;
	b=LNWxnnz1OKuGoWGrMXrwTd2enyzJN73ypy1Cuy1qZtBotKAAqp2aq65A1gK7qZ8U54E2Lz
	FILu5L+orwbhDShXDMWDHPD659eTlwmmC78MWsxkCr/n6HetuhQ8GeFlOmDbT43Vpg8zeO
	i6yA9AvNuoYhNrFm1SRXWVMJ9lI5Fo0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1718837383;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X7+XAotVIvWS2vTh75oVQOPFwsOci6tWQZhDoSRQGx4=;
	b=roVh2sJJLOmM0oiL35sPyLjBSwOuoRsf/nGyJvEjjBe2kt/FPev0yfzWJK/1XF1/iK2GOP
	56CsF5e9QNpjsaBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1718837383; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X7+XAotVIvWS2vTh75oVQOPFwsOci6tWQZhDoSRQGx4=;
	b=LNWxnnz1OKuGoWGrMXrwTd2enyzJN73ypy1Cuy1qZtBotKAAqp2aq65A1gK7qZ8U54E2Lz
	FILu5L+orwbhDShXDMWDHPD659eTlwmmC78MWsxkCr/n6HetuhQ8GeFlOmDbT43Vpg8zeO
	i6yA9AvNuoYhNrFm1SRXWVMJ9lI5Fo0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1718837383;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X7+XAotVIvWS2vTh75oVQOPFwsOci6tWQZhDoSRQGx4=;
	b=roVh2sJJLOmM0oiL35sPyLjBSwOuoRsf/nGyJvEjjBe2kt/FPev0yfzWJK/1XF1/iK2GOP
	56CsF5e9QNpjsaBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 76B2913AC3;
	Wed, 19 Jun 2024 22:49:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gBasHIdgc2aFIAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 19 Jun 2024 22:49:43 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Date: Thu, 20 Jun 2024 00:48:59 +0200
Subject: [PATCH v2 5/7] bpf: do not create bpf_non_sleepable_error_inject
 list when unnecessary
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240620-fault-injection-statickeys-v2-5-e23947d3d84b@suse.cz>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1591; i=vbabka@suse.cz;
 h=from:subject:message-id; bh=+HcqYdgaWT9BrUacvRJSWp4CDbAKfRkRibADsrgT2bU=;
 b=owEBbQGS/pANAwAIAbvgsHXSRYiaAcsmYgBmc2B9IzDEAVKG5FXS38RcYZUyeL9j5X2CdCydU
 Xm/auj9IMKJATMEAAEIAB0WIQR7u8hBFZkjSJZITfG74LB10kWImgUCZnNgfQAKCRC74LB10kWI
 mieMB/0Z2oYYCWNAmVEuHX7NW7yYno6Akg2QEWBe10L/+QsV4Wfjt61ibXRZyOYv5dL16q+TyVM
 Gofehb9TgIuIG9fzbiv/IkDt0D9UULaagQwhJUpdnLAOYxw7FRr1nYbjmJt/cNOUtR8cMo6x1PG
 33Gevml4l4phxiCJEnvCSO9Xum+ZBP/F3GOvVXDBDIF/vXVBhmF0iRyvefoi9o66f+guBziQc0j
 DDNd0wet/qYXslsYfyo9XtYY9+dP/5/d9pwYbcsvP8BN9uQkE3IeYQHe/Thldx8B/855/bItiKc
 AkAI9cbY8cY4/mKYag0vVzO6xNXmffLfuOg01lsVKyX58qWE
X-Developer-Key: i=vbabka@suse.cz; a=openpgp;
 fpr=A940D434992C2E8E99103D50224FA7E7CC82A664
X-Spamd-Result: default: False [-3.85 / 50.00];
	REPLY(-4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	BAYES_HAM(-0.05)[59.54%];
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
X-Spam-Score: -3.85
X-Spam-Level: 

When CONFIG_FUNCTION_ERROR_INJECTION is disabled,
within_error_injection_list() will return false for any address and the
result of check_non_sleepable_error_inject() denylist is thus redundant.
The bpf_non_sleepable_error_inject list thus does not need to be
constructed at all, so #ifdef it out.

This will allow to inline functions on the list when
CONFIG_FUNCTION_ERROR_INJECTION is disabled as there will be no BTF_ID()
reference for them.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 kernel/bpf/verifier.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 77da1f438bec..5cd93de37d68 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -21044,6 +21044,8 @@ static int check_attach_modify_return(unsigned long addr, const char *func_name)
 	return -EINVAL;
 }
 
+#ifdef CONFIG_FUNCTION_ERROR_INJECTION
+
 /* list of non-sleepable functions that are otherwise on
  * ALLOW_ERROR_INJECTION list
  */
@@ -21061,6 +21063,19 @@ static int check_non_sleepable_error_inject(u32 btf_id)
 	return btf_id_set_contains(&btf_non_sleepable_error_inject, btf_id);
 }
 
+#else /* CONFIG_FUNCTION_ERROR_INJECTION */
+
+/*
+ * Pretend the denylist is empty, within_error_injection_list() will return
+ * false anyway.
+ */
+static int check_non_sleepable_error_inject(u32 btf_id)
+{
+	return 0;
+}
+
+#endif
+
 int bpf_check_attach_target(struct bpf_verifier_log *log,
 			    const struct bpf_prog *prog,
 			    const struct bpf_prog *tgt_prog,

-- 
2.45.2


