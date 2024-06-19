Return-Path: <bpf+bounces-32544-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16F4590F967
	for <lists+bpf@lfdr.de>; Thu, 20 Jun 2024 00:50:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4ED6BB21A5B
	for <lists+bpf@lfdr.de>; Wed, 19 Jun 2024 22:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 921F715D5C9;
	Wed, 19 Jun 2024 22:49:48 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9958175E;
	Wed, 19 Jun 2024 22:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718837388; cv=none; b=Ko7Mc7FqThmJoiuA6gjmS1WvWL4sWVshCIiV9JCngTIcH7zE3pp1AyQYEZL3OmvpD36vk9bH1oxyW2mMD1Nlk3OZvJAxSQOhP3sgQS0TSeZmZxnLrUNlsxMCZUIrTWpW74vbBWR900h+r7mxAR5eza9JBkIJM8LdxZDwbhdynfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718837388; c=relaxed/simple;
	bh=3qciDcxlabL8RPKApoikpRFG6GtFoTLNySS+QbqQz9Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nrB8K+jY71UZV5aY6s6MAPBJe7E35lJ8+iddmjwplUJRJtqN/1bub97u4tYgQ9+B4Sar/moOcWBY27kYlGBZ5IGE+vvJ+FwC+gdARAYTaWVsXGjp2Or7YdLVXX+KsoMhaQfUNxO0b+BgdmQ2EQYHKDaRTabrW93HellzTt30doc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 78F4B21A5F;
	Wed, 19 Jun 2024 22:49:43 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 593BA13ABD;
	Wed, 19 Jun 2024 22:49:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QO+DFYdgc2aFIAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 19 Jun 2024 22:49:43 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Date: Thu, 20 Jun 2024 00:48:58 +0200
Subject: [PATCH v2 4/7] bpf: support error injection static keys for
 multi_link attached progs
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240620-fault-injection-statickeys-v2-4-e23947d3d84b@suse.cz>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4495; i=vbabka@suse.cz;
 h=from:subject:message-id; bh=3qciDcxlabL8RPKApoikpRFG6GtFoTLNySS+QbqQz9Q=;
 b=owEBbQGS/pANAwAIAbvgsHXSRYiaAcsmYgBmc2B7A+FYtqvio9GTWv3xme47MHxydtFu6JcXT
 U9aKA8HdJyJATMEAAEIAB0WIQR7u8hBFZkjSJZITfG74LB10kWImgUCZnNgewAKCRC74LB10kWI
 mtXfB/9Wf8ufmNZ+KgSqZhasEn0ZqY1pTjQK/1k4ql5arsN4WjQN5LONf7zFbsRueo1MccTXI8j
 /fH+X3PTcoSG6fRMjz3+vuHCOkrsWH3yUtKIWVCjSGbCnoTDSPalLr/doZP8HAWLrmhpFni/wZC
 6VZHYbuRigc7AohRXcOu7R4Px5zhFhdbb+6z1EZkeKJzmzriFXhSIczEoPYa6g6RmKDL/HsZiEY
 Iwcv1O2H9gYU+430HbPN6am111EVHOeM6rY2MCwZaJjWJjd3at7bfhl/tIQWnAM0gal51sJCbR6
 2uksKs0VJHgNrhMdsLGxDLtpwTXG5HrhbVle/JopZQNha/Sy
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
X-Rspamd-Queue-Id: 78F4B21A5F
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[];
	TAGGED_RCPT(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

Functions marked for error injection can have an associated static key
that guards the callsite(s) to avoid overhead of calling an empty
function when no error injection is in progress.

Outside of the error injection framework itself, bpf programs can be
atteched to kprobes and override results of error-injectable functions.
To make sure these functions are actually called, attaching such bpf
programs should control the static key accordingly.

Therefore, add an array of static keys to struct bpf_kprobe_multi_link
and fill it in addrs_check_error_injection_list() for programs with
kprobe_override enabled, using get_injection_key() instead of
within_error_injection_list(). Introduce bpf_kprobe_ei_keys_control() to
control the static keys and call the control function when doing
multi_link_attach and release.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 kernel/trace/bpf_trace.c | 59 +++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 53 insertions(+), 6 deletions(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 944de1c41209..ef0fadb76bfa 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -2613,6 +2613,7 @@ struct bpf_kprobe_multi_link {
 	struct bpf_link link;
 	struct fprobe fp;
 	unsigned long *addrs;
+	struct static_key **ei_keys;
 	u64 *cookies;
 	u32 cnt;
 	u32 mods_cnt;
@@ -2687,11 +2688,30 @@ static void free_user_syms(struct user_syms *us)
 	kvfree(us->buf);
 }
 
+static void bpf_kprobe_ei_keys_control(struct bpf_kprobe_multi_link *link, bool enable)
+{
+	u32 i;
+
+	for (i = 0; i < link->cnt; i++) {
+		if (!link->ei_keys[i])
+			break;
+
+		if (enable)
+			static_key_slow_inc(link->ei_keys[i]);
+		else
+			static_key_slow_dec(link->ei_keys[i]);
+	}
+}
+
 static void bpf_kprobe_multi_link_release(struct bpf_link *link)
 {
 	struct bpf_kprobe_multi_link *kmulti_link;
 
 	kmulti_link = container_of(link, struct bpf_kprobe_multi_link, link);
+
+	if (kmulti_link->ei_keys)
+		bpf_kprobe_ei_keys_control(kmulti_link, false);
+
 	unregister_fprobe(&kmulti_link->fp);
 	kprobe_multi_put_modules(kmulti_link->mods, kmulti_link->mods_cnt);
 }
@@ -2703,6 +2723,7 @@ static void bpf_kprobe_multi_link_dealloc(struct bpf_link *link)
 	kmulti_link = container_of(link, struct bpf_kprobe_multi_link, link);
 	kvfree(kmulti_link->addrs);
 	kvfree(kmulti_link->cookies);
+	kvfree(kmulti_link->ei_keys);
 	kfree(kmulti_link->mods);
 	kfree(kmulti_link);
 }
@@ -2985,13 +3006,19 @@ static int get_modules_for_addrs(struct module ***mods, unsigned long *addrs, u3
 	return arr.mods_cnt;
 }
 
-static int addrs_check_error_injection_list(unsigned long *addrs, u32 cnt)
+static int addrs_check_error_injection_list(unsigned long *addrs, struct static_key **ei_keys,
+					    u32 cnt)
 {
-	u32 i;
+	struct static_key *ei_key;
+	u32 i, j = 0;
 
 	for (i = 0; i < cnt; i++) {
-		if (!within_error_injection_list(addrs[i]))
+		ei_key = get_injection_key(addrs[i]);
+		if (IS_ERR(ei_key))
 			return -EINVAL;
+
+		if (ei_key)
+			ei_keys[j++] = ei_key;
 	}
 	return 0;
 }
@@ -3000,6 +3027,7 @@ int bpf_kprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
 {
 	struct bpf_kprobe_multi_link *link = NULL;
 	struct bpf_link_primer link_primer;
+	struct static_key **ei_keys = NULL;
 	void __user *ucookies;
 	unsigned long *addrs;
 	u32 flags, cnt, size;
@@ -3075,9 +3103,24 @@ int bpf_kprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
 			goto error;
 	}
 
-	if (prog->kprobe_override && addrs_check_error_injection_list(addrs, cnt)) {
-		err = -EINVAL;
-		goto error;
+	if (prog->kprobe_override) {
+		ei_keys = kvcalloc(cnt, sizeof(*ei_keys), GFP_KERNEL);
+		if (!ei_keys) {
+			err = -ENOMEM;
+			goto error;
+		}
+
+		if (addrs_check_error_injection_list(addrs, ei_keys, cnt)) {
+			err = -EINVAL;
+			goto error;
+		}
+
+		if (ei_keys[0]) {
+			link->ei_keys = ei_keys;
+		} else {
+			kvfree(ei_keys);
+			ei_keys = NULL;
+		}
 	}
 
 	link = kzalloc(sizeof(*link), GFP_KERNEL);
@@ -3132,10 +3175,14 @@ int bpf_kprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
 		return err;
 	}
 
+	if (link->ei_keys)
+		bpf_kprobe_ei_keys_control(link, true);
+
 	return bpf_link_settle(&link_primer);
 
 error:
 	kfree(link);
+	kvfree(ei_keys);
 	kvfree(addrs);
 	kvfree(cookies);
 	return err;

-- 
2.45.2


