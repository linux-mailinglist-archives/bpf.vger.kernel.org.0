Return-Path: <bpf+bounces-32539-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7587A90F95E
	for <lists+bpf@lfdr.de>; Thu, 20 Jun 2024 00:50:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7990A1C210F8
	for <lists+bpf@lfdr.de>; Wed, 19 Jun 2024 22:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FDEC15B557;
	Wed, 19 Jun 2024 22:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="mtxCY5NO";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="2+cvj+i4";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="mtxCY5NO";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="2+cvj+i4"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4437F7C7;
	Wed, 19 Jun 2024 22:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718837386; cv=none; b=igiavJmjvBAlIDCJ4bV1xv9JzLIRC0NjjVnwwpn6mBQf3tSVUTwgVLifI8WSGLULXpgPxxkn5UbmUDPMTdbClv+dofLb6hkh3/CVHn331TlNI4OrJ9AxhRWu9JQnNehWX/spqqjfBS4nx+jeE0V9Xt+BqeSFOsazLWLDB/PgtQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718837386; c=relaxed/simple;
	bh=RHlcQH9C6ly4CbQFrHL5k0pueBGzmfFJHg6uosgSnqE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N0pvB+lUsDQbQfv7zdCVF6OW2dgywUije4PuDqEHQPoSokWxOxfM5/TCxUdPg3ShXvyKBTDAf0UPtpSp3VUH8oUyWqoogz9kQDCZh/j/yhCsV1v5iHPLqDyv2sHmRJUM6578oqBjGgmcQohumF7M9Yu0Ly+OAgSw+ZPEq2m0WYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=mtxCY5NO; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=2+cvj+i4; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=mtxCY5NO; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=2+cvj+i4; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5C51F21A5C;
	Wed, 19 Jun 2024 22:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1718837383; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GJmQfB+SFKwkGljPkMoSf+PzrKg2yTJDdkhioKlFbR0=;
	b=mtxCY5NOZUMLeNOQo2490WnZzrZz5lK6g9Qm7Ex4Shmq2UVpwBxwZP+nWMnZFY2Qk8nBs1
	siLzlqttayrh4IykYENtS8rfrWC8ksDwhasAHMwn4I+ihPTkA8zNMcN6XlS3RF8s2wohXI
	U+CXOQeOPkjiu8wHU+JqsGy5rejV9nA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1718837383;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GJmQfB+SFKwkGljPkMoSf+PzrKg2yTJDdkhioKlFbR0=;
	b=2+cvj+i4DhZ6XKrKA7se2fWikyWEQBDFIpBjv+eA7nIqPwGQ03LS2LkiZhUbMyFqEGyfvQ
	qHnQkg3JJUtkfiDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1718837383; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GJmQfB+SFKwkGljPkMoSf+PzrKg2yTJDdkhioKlFbR0=;
	b=mtxCY5NOZUMLeNOQo2490WnZzrZz5lK6g9Qm7Ex4Shmq2UVpwBxwZP+nWMnZFY2Qk8nBs1
	siLzlqttayrh4IykYENtS8rfrWC8ksDwhasAHMwn4I+ihPTkA8zNMcN6XlS3RF8s2wohXI
	U+CXOQeOPkjiu8wHU+JqsGy5rejV9nA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1718837383;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GJmQfB+SFKwkGljPkMoSf+PzrKg2yTJDdkhioKlFbR0=;
	b=2+cvj+i4DhZ6XKrKA7se2fWikyWEQBDFIpBjv+eA7nIqPwGQ03LS2LkiZhUbMyFqEGyfvQ
	qHnQkg3JJUtkfiDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3D08413AAA;
	Wed, 19 Jun 2024 22:49:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SCSeDodgc2aFIAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 19 Jun 2024 22:49:43 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Date: Thu, 20 Jun 2024 00:48:57 +0200
Subject: [PATCH v2 3/7] bpf: support error injection static keys for
 perf_event attached progs
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240620-fault-injection-statickeys-v2-3-e23947d3d84b@suse.cz>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4256; i=vbabka@suse.cz;
 h=from:subject:message-id; bh=RHlcQH9C6ly4CbQFrHL5k0pueBGzmfFJHg6uosgSnqE=;
 b=owEBbQGS/pANAwAIAbvgsHXSRYiaAcsmYgBmc2B4jX+g3Xf4kDO7RN55ImULUpPLAS31+cJIL
 VWj6k4LZzmJATMEAAEIAB0WIQR7u8hBFZkjSJZITfG74LB10kWImgUCZnNgeAAKCRC74LB10kWI
 mk8pCACesvfkTPT71qvqKXfyLJtHc/HZ29/KezJP030k0GlFWTkG41XeSOf+Jc9jxoC1871A4SK
 EWFDuN7tbL8sEOdT7cBJU0MBEXQSDEYNDcoGyZxl98cLsAJ9XHVdkhNOzgJJgPRwcnPT10ejR6X
 Eb39gdyBoKUdHWD8IoRYiCpG6/Wx8PRQUjK59shva6E514qQRimzOvre6ZR5OQrcynjumq8WrVE
 n12/Bf0XbXqhrgaM1emVNUHExQn1U7iCYwHGEzlGPNvC8Mi+wQG9Xsq7xvjA5OSOUmmmDusj3eC
 3soz/74FQINFipML/55CmhoPIFrOsjPyQbm5FZDYbWm25i7L
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

Functions marked for error injection can have an associated static key
that guards the callsite(s) to avoid overhead of calling an empty
function when no error injection is in progress.

Outside of the error injection framework itself, bpf programs can be
atteched to perf events and override results of error-injectable
functions. To make sure these functions are actually called, attaching
such bpf programs should control the static key accordingly.

Therefore, add the static key's address to struct trace_kprobe and fill
it in trace_kprobe_error_injectable(), using get_injection_key() instead
of within_error_injection_list(). Introduce
trace_kprobe_error_injection_control() to control the static key and
call the control function when attaching or detaching programs with
kprobe_override to perf events.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 kernel/trace/bpf_trace.c    |  6 ++++++
 kernel/trace/trace_kprobe.c | 30 ++++++++++++++++++++++++++++--
 kernel/trace/trace_probe.h  |  5 +++++
 3 files changed, 39 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index f5154c051d2c..944de1c41209 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -2283,6 +2283,9 @@ int perf_event_attach_bpf_prog(struct perf_event *event,
 	rcu_assign_pointer(event->tp_event->prog_array, new_array);
 	bpf_prog_array_free_sleepable(old_array);
 
+	if (prog->kprobe_override)
+		trace_kprobe_error_injection_control(event->tp_event, true);
+
 unlock:
 	mutex_unlock(&bpf_event_mutex);
 	return ret;
@@ -2299,6 +2302,9 @@ void perf_event_detach_bpf_prog(struct perf_event *event)
 	if (!event->prog)
 		goto unlock;
 
+	if (event->prog->kprobe_override)
+		trace_kprobe_error_injection_control(event->tp_event, false);
+
 	old_array = bpf_event_rcu_dereference(event->tp_event->prog_array);
 	ret = bpf_prog_array_copy(old_array, event->prog, NULL, 0, &new_array);
 	if (ret == -ENOENT)
diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 16383247bdbf..1c1ee95bd5de 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -61,6 +61,7 @@ struct trace_kprobe {
 	unsigned long __percpu *nhit;
 	const char		*symbol;	/* symbol name */
 	struct trace_probe	tp;
+	struct static_key	*ei_key;
 };
 
 static bool is_trace_kprobe(struct dyn_event *ev)
@@ -235,9 +236,34 @@ bool trace_kprobe_on_func_entry(struct trace_event_call *call)
 bool trace_kprobe_error_injectable(struct trace_event_call *call)
 {
 	struct trace_kprobe *tk = trace_kprobe_primary_from_call(call);
+	struct static_key *ei_key;
 
-	return tk ? within_error_injection_list(trace_kprobe_address(tk)) :
-	       false;
+	if (!tk)
+		return false;
+
+	ei_key = get_injection_key(trace_kprobe_address(tk));
+	if (IS_ERR(ei_key))
+		return false;
+
+	tk->ei_key = ei_key;
+	return true;
+}
+
+void trace_kprobe_error_injection_control(struct trace_event_call *call,
+					  bool enable)
+{
+	struct trace_kprobe *tk = trace_kprobe_primary_from_call(call);
+
+	if (!tk)
+		return;
+
+	if (!tk->ei_key)
+		return;
+
+	if (enable)
+		static_key_slow_inc(tk->ei_key);
+	else
+		static_key_slow_dec(tk->ei_key);
 }
 
 static int register_kprobe_event(struct trace_kprobe *tk);
diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
index 5803e6a41570..d9ddcabb9f97 100644
--- a/kernel/trace/trace_probe.h
+++ b/kernel/trace/trace_probe.h
@@ -212,6 +212,8 @@ DECLARE_BASIC_PRINT_TYPE_FUNC(symbol);
 #ifdef CONFIG_KPROBE_EVENTS
 bool trace_kprobe_on_func_entry(struct trace_event_call *call);
 bool trace_kprobe_error_injectable(struct trace_event_call *call);
+void trace_kprobe_error_injection_control(struct trace_event_call *call,
+					  bool enabled);
 #else
 static inline bool trace_kprobe_on_func_entry(struct trace_event_call *call)
 {
@@ -222,6 +224,9 @@ static inline bool trace_kprobe_error_injectable(struct trace_event_call *call)
 {
 	return false;
 }
+
+static inline void trace_kprobe_error_injection_control(struct trace_event_call *call,
+							bool enabled) { }
 #endif /* CONFIG_KPROBE_EVENTS */
 
 struct probe_arg {

-- 
2.45.2


