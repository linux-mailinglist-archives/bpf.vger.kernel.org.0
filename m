Return-Path: <bpf+bounces-79637-lists+bpf=lfdr.de@vger.kernel.org>
Delivered-To: lists+bpf@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gMRfJMDPb2mgMQAAu9opvQ
	(envelope-from <bpf+bounces-79637-lists+bpf=lfdr.de@vger.kernel.org>)
	for <lists+bpf@lfdr.de>; Tue, 20 Jan 2026 19:56:00 +0100
X-Original-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EE5E349DF2
	for <lists+bpf@lfdr.de>; Tue, 20 Jan 2026 19:55:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7AE2F94B761
	for <lists+bpf@lfdr.de>; Tue, 20 Jan 2026 15:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 521CD478874;
	Tue, 20 Jan 2026 15:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fLAFBzzZ"
X-Original-To: bpf@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E82CE478843
	for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 15:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768922784; cv=none; b=W+kFLTGi0k9/OWcin7jRvWDgPjo+Lfn2zjOE5XvdJIJUWa6oS9xEM9s8V0/oT76ytwKzoaQyKUPnBgIop1Z/hDy98s3ZlI6G68xvY9UJFfJJS1usf+cax/ZQjy49fhvy+g4ZbYvnBK+sRzBGPeOG+RaegdVZ/fMgUg2Y8rlYZPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768922784; c=relaxed/simple;
	bh=ilx2NWgx8rmvFwpmeIR1HyrlwMnAeTCcEo8vKyWsCF8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GGHczeijyFT/ADxJoZiTOIXFbJJFwv82eqFVPpFrwqMgV4WKobI164kMMSg+p5/8tlCsWLrM1xLt92/RS5aa49i10wnzESPfDjCjDdsrMRqcISTIwKp/y2gOP+6VgbxMCjFM4tFzzZmMqEgowVl8CW8SL/mpqQDJgCzuQ4lEpYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fLAFBzzZ; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768922778;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pKJje7gzUYA+IYud4++/tzIR0p8owud7kzFt87TWJSw=;
	b=fLAFBzzZzeSzXEDdVV9qPcRj/uG4SYh1SCL7Sj/zWaUvshocH5GipL+bD66zHeK8zcsZo1
	VwWnqi+2V9R4zL+83K1ksQHvVlFmsFjPHWdouZxheMZYQNr3QcDIhJHrAxF2eUGrKlzFLS
	7zjfy7q8+MvbPgX2IdPs7XcdPtctIgA=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Seth Forshee <sforshee@kernel.org>,
	Yuichiro Tsuji <yuichtsu@amazon.com>,
	Andrey Albershteyn <aalbersh@redhat.com>,
	Leon Hwang <leon.hwang@linux.dev>,
	Willem de Bruijn <willemb@google.com>,
	Jason Xing <kerneljasonxing@gmail.com>,
	Tao Chen <chen.dylane@linux.dev>,
	Mykyta Yatsenko <yatsenko@meta.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Anton Protopopov <a.s.protopopov@gmail.com>,
	Amery Hung <ameryhung@gmail.com>,
	Rong Tao <rongtao@cestc.cn>,
	linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kernel-patches-bot@fb.com
Subject: [RESEND PATCH bpf-next v6 4/9] bpf: Add syscall common attributes support for prog_load
Date: Tue, 20 Jan 2026 23:24:18 +0800
Message-ID: <20260120152424.40766-5-leon.hwang@linux.dev>
In-Reply-To: <20260120152424.40766-1-leon.hwang@linux.dev>
References: <20260120152424.40766-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [1.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[31];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,gmail.com,linux.dev,fomichev.me,google.com,amazon.com,redhat.com,meta.com,cestc.cn,vger.kernel.org,fb.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	TAGGED_FROM(0.00)[bounces-79637-lists,bpf=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon.hwang@linux.dev,bpf@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[linux.dev,none];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	TAGGED_RCPT(0.00)[bpf];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,linux.dev:email,linux.dev:dkim,linux.dev:mid]
X-Rspamd-Queue-Id: EE5E349DF2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The log buffer of common attributes would be confusing with the one in
'union bpf_attr' for BPF_PROG_LOAD.

In order to clarify the usage of these two log buffers, they both can be
used for logging if:

* They are same, including 'log_buf', 'log_level' and 'log_size'.
* One of them is missing, then another one will be used for logging.

If they both have 'log_buf' but they are not same totally, return -EINVAL.

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 include/linux/bpf_verifier.h |  4 +++-
 kernel/bpf/log.c             | 29 ++++++++++++++++++++++++++---
 kernel/bpf/syscall.c         |  9 ++++++---
 3 files changed, 35 insertions(+), 7 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 4c9632c40059..da2d37ca60e7 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -637,9 +637,11 @@ struct bpf_log_attr {
 	u32 log_level;
 	struct bpf_attrs *attrs;
 	u32 offsetof_log_true_size;
+	struct bpf_attrs *attrs_common;
 };
 
-int bpf_prog_load_log_attr_init(struct bpf_log_attr *log_attr, struct bpf_attrs *attrs);
+int bpf_prog_load_log_attr_init(struct bpf_log_attr *log_attr, struct bpf_attrs *attrs,
+				struct bpf_attrs *attrs_common);
 int bpf_log_attr_finalize(struct bpf_log_attr *log_attr, struct bpf_verifier_log *log);
 
 #define BPF_MAX_SUBPROGS 256
diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
index 457b724c4176..c0b816e84384 100644
--- a/kernel/bpf/log.c
+++ b/kernel/bpf/log.c
@@ -865,23 +865,41 @@ void print_insn_state(struct bpf_verifier_env *env, const struct bpf_verifier_st
 }
 
 static int bpf_log_attr_init(struct bpf_log_attr *log_attr, struct bpf_attrs *attrs, u64 log_buf,
-			     u32 log_size, u32 log_level, int offsetof_log_true_size)
+			     u32 log_size, u32 log_level, int offsetof_log_true_size,
+			     struct bpf_attrs *attrs_common)
 {
+	const struct bpf_common_attr *common = attrs_common ? attrs_common->attr : NULL;
+
 	memset(log_attr, 0, sizeof(*log_attr));
 	log_attr->log_buf = log_buf;
 	log_attr->log_size = log_size;
 	log_attr->log_level = log_level;
 	log_attr->attrs = attrs;
 	log_attr->offsetof_log_true_size = offsetof_log_true_size;
+	log_attr->attrs_common = attrs_common;
+
+	if (log_buf && common && common->log_buf &&
+		(log_buf != common->log_buf ||
+		 log_size != common->log_size ||
+		 log_level != common->log_level))
+		return -EINVAL;
+
+	if (!log_buf && common && common->log_buf) {
+		log_attr->log_buf = common->log_buf;
+		log_attr->log_size = common->log_size;
+		log_attr->log_level = common->log_level;
+	}
+
 	return 0;
 }
 
-int bpf_prog_load_log_attr_init(struct bpf_log_attr *log_attr, struct bpf_attrs *attrs)
+int bpf_prog_load_log_attr_init(struct bpf_log_attr *log_attr, struct bpf_attrs *attrs,
+				struct bpf_attrs *attrs_common)
 {
 	const union bpf_attr *attr = attrs->attr;
 
 	return bpf_log_attr_init(log_attr, attrs, attr->log_buf, attr->log_size, attr->log_level,
-				 offsetof(union bpf_attr, log_true_size));
+				 offsetof(union bpf_attr, log_true_size), attrs_common);
 }
 
 int bpf_log_attr_finalize(struct bpf_log_attr *log_attr, struct bpf_verifier_log *log)
@@ -901,5 +919,10 @@ int bpf_log_attr_finalize(struct bpf_log_attr *log_attr, struct bpf_verifier_log
 	    copy_to_bpfptr_offset(log_attr->attrs->uattr, off, &log_true_size, size))
 		err = -EFAULT;
 
+	off = offsetof(struct bpf_common_attr, log_true_size);
+	if (log_attr->attrs_common && log_attr->attrs_common->size >= off + size &&
+	    copy_to_bpfptr_offset(log_attr->attrs_common->uattr, off, &log_true_size, size))
+		err = -EFAULT;
+
 	return err;
 }
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 645cc0c0cd3f..ea59cd178dcf 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2865,7 +2865,8 @@ static int bpf_prog_mark_insn_arrays_ready(struct bpf_prog *prog)
 /* last field in 'union bpf_attr' used by this command */
 #define BPF_PROG_LOAD_LAST_FIELD keyring_id
 
-static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size)
+static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size,
+			 struct bpf_attrs *attrs_common)
 {
 	enum bpf_prog_type type = attr->prog_type;
 	struct bpf_prog *prog, *dst_prog = NULL;
@@ -3085,7 +3086,7 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size)
 		goto free_prog_sec;
 
 	bpf_attrs_init(&attrs, attr, uattr, uattr_size);
-	err = bpf_prog_load_log_attr_init(&log_attr, &attrs);
+	err = bpf_prog_load_log_attr_init(&log_attr, &attrs, attrs_common);
 	if (err < 0)
 		goto free_used_maps;
 
@@ -6174,6 +6175,7 @@ static int __sys_bpf(enum bpf_cmd cmd, bpfptr_t uattr, unsigned int size,
 		     bpfptr_t uattr_common, unsigned int size_common)
 {
 	struct bpf_common_attr attr_common;
+	struct bpf_attrs attrs_common;
 	union bpf_attr attr;
 	int err;
 
@@ -6225,7 +6227,8 @@ static int __sys_bpf(enum bpf_cmd cmd, bpfptr_t uattr, unsigned int size,
 		err = map_freeze(&attr);
 		break;
 	case BPF_PROG_LOAD:
-		err = bpf_prog_load(&attr, uattr, size);
+		bpf_attrs_init(&attrs_common, &attr_common, uattr_common, size_common);
+		err = bpf_prog_load(&attr, uattr, size, &attrs_common);
 		break;
 	case BPF_OBJ_PIN:
 		err = bpf_obj_pin(&attr);
-- 
2.52.0


