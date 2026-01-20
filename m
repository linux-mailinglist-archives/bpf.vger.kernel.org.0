Return-Path: <bpf+bounces-79635-lists+bpf=lfdr.de@vger.kernel.org>
Delivered-To: lists+bpf@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mCumBKbKb2mgMQAAu9opvQ
	(envelope-from <bpf+bounces-79635-lists+bpf=lfdr.de@vger.kernel.org>)
	for <lists+bpf@lfdr.de>; Tue, 20 Jan 2026 19:34:14 +0100
X-Original-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A13B749884
	for <lists+bpf@lfdr.de>; Tue, 20 Jan 2026 19:34:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3CA1F88A66F
	for <lists+bpf@lfdr.de>; Tue, 20 Jan 2026 15:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 486FF4611E8;
	Tue, 20 Jan 2026 15:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VDuMbnAI"
X-Original-To: bpf@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03FCD466B53
	for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 15:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768922766; cv=none; b=UnVR6THAZ3bYSAg6wV6QcXOzgXsTHzfbiQry1dQEFLJdkYgAgGrEPcu5xVS6GE9TUNcF+ZxxF+icsdNsyOnn4hV49jGyCk5Avt8ZZrKkSQfkK8bA8BW+/tzarVD5cPalvzlCkW+tVT6z86h9IwwjB8gdFr3mYvo5I8jXon5Q2ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768922766; c=relaxed/simple;
	bh=VdT+qfzrEMk9+yt37S7v4EN0NFQasyDvpE4a1Fswi2Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YPoG3pt8IRYUVcUUim1lDHlM9UOg7azUzp47OQYobyoMGGyhavse2Xwh2zpf0V7h4ozUrgcT6RejJjet+TQ8HPz2FVujVa2mNmGE+kXQTYISEJyoTL7F/u+9wEecRH6dkdN177voEhKOcZtM5GtJd2EajjN+WjHY9MB6jdd9F0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VDuMbnAI; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768922761;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kRTfHCwrpnuV0VymQxiwG5FoFnK+9yQFhsoaAGJJJH8=;
	b=VDuMbnAISim49rGxk7/apW0PDYg5f/M6k+W6PMvuINM406rCG0/7xuFWJngcmkc1ksWghG
	2pgzlLaXC9uWswy8YUAvf7uXNYET6fugMqm3lPkuJEbS1gqeY2cpJ6b6s014D8gO6y1P8x
	8aa7at/i6jv1uPRaqJGWggmaXUHy808=
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
Subject: [RESEND PATCH bpf-next v6 2/9] libbpf: Add support for extended bpf syscall
Date: Tue, 20 Jan 2026 23:24:16 +0800
Message-ID: <20260120152424.40766-3-leon.hwang@linux.dev>
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
	TAGGED_FROM(0.00)[bounces-79635-lists,bpf=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,linux.dev:dkim,linux.dev:mid,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: A13B749884
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

To support the extended BPF syscall introduced in the previous commit,
introduce the following internal APIs:

* 'sys_bpf_ext()'
* 'sys_bpf_ext_fd()'
  They wrap the raw 'syscall()' interface to support passing extended
  attributes.
* 'probe_sys_bpf_ext()'
  Check whether current kernel supports the BPF syscall common attributes.

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 tools/lib/bpf/bpf.c             | 32 ++++++++++++++++++++++++++++++++
 tools/lib/bpf/features.c        |  8 ++++++++
 tools/lib/bpf/libbpf_internal.h |  3 +++
 3 files changed, 43 insertions(+)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index 21b57a629916..ed9c6eaeb656 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -69,6 +69,38 @@ static inline __u64 ptr_to_u64(const void *ptr)
 	return (__u64) (unsigned long) ptr;
 }
 
+static inline int sys_bpf_ext(enum bpf_cmd cmd, union bpf_attr *attr,
+			      unsigned int size,
+			      struct bpf_common_attr *attr_common,
+			      unsigned int size_common)
+{
+	cmd = attr_common ? (cmd | BPF_COMMON_ATTRS) : (cmd & ~BPF_COMMON_ATTRS);
+	return syscall(__NR_bpf, cmd, attr, size, attr_common, size_common);
+}
+
+static inline int sys_bpf_ext_fd(enum bpf_cmd cmd, union bpf_attr *attr,
+				 unsigned int size,
+				 struct bpf_common_attr *attr_common,
+				 unsigned int size_common)
+{
+	int fd;
+
+	fd = sys_bpf_ext(cmd, attr, size, attr_common, size_common);
+	return ensure_good_fd(fd);
+}
+
+int probe_sys_bpf_ext(void)
+{
+	const size_t attr_sz = offsetofend(union bpf_attr, prog_token_fd);
+	union bpf_attr attr;
+
+	memset(&attr, 0, attr_sz);
+	/* This syscall() will return error always. */
+	(void) syscall(__NR_bpf, BPF_PROG_LOAD | BPF_COMMON_ATTRS, &attr, attr_sz, NULL,
+		       sizeof(struct bpf_common_attr));
+	return errno == EFAULT;
+}
+
 static inline int sys_bpf(enum bpf_cmd cmd, union bpf_attr *attr,
 			  unsigned int size)
 {
diff --git a/tools/lib/bpf/features.c b/tools/lib/bpf/features.c
index b842b83e2480..e0d646a9e233 100644
--- a/tools/lib/bpf/features.c
+++ b/tools/lib/bpf/features.c
@@ -506,6 +506,11 @@ static int probe_kern_arg_ctx_tag(int token_fd)
 	return probe_fd(prog_fd);
 }
 
+static int probe_bpf_syscall_common_attrs(int token_fd)
+{
+	return probe_sys_bpf_ext();
+}
+
 typedef int (*feature_probe_fn)(int /* token_fd */);
 
 static struct kern_feature_cache feature_cache;
@@ -581,6 +586,9 @@ static struct kern_feature_desc {
 	[FEAT_BTF_QMARK_DATASEC] = {
 		"BTF DATASEC names starting from '?'", probe_kern_btf_qmark_datasec,
 	},
+	[FEAT_BPF_SYSCALL_COMMON_ATTRS] = {
+		"BPF syscall common attributes support", probe_bpf_syscall_common_attrs,
+	},
 };
 
 bool feat_supported(struct kern_feature_cache *cache, enum kern_feature_id feat_id)
diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
index fc59b21b51b5..aa16be869c4f 100644
--- a/tools/lib/bpf/libbpf_internal.h
+++ b/tools/lib/bpf/libbpf_internal.h
@@ -392,6 +392,8 @@ enum kern_feature_id {
 	FEAT_ARG_CTX_TAG,
 	/* Kernel supports '?' at the front of datasec names */
 	FEAT_BTF_QMARK_DATASEC,
+	/* Kernel supports BPF syscall common attributes */
+	FEAT_BPF_SYSCALL_COMMON_ATTRS,
 	__FEAT_CNT,
 };
 
@@ -757,4 +759,5 @@ int probe_fd(int fd);
 #define SHA256_DWORD_SIZE SHA256_DIGEST_LENGTH / sizeof(__u64)
 
 void libbpf_sha256(const void *data, size_t len, __u8 out[SHA256_DIGEST_LENGTH]);
+int probe_sys_bpf_ext(void);
 #endif /* __LIBBPF_LIBBPF_INTERNAL_H */
-- 
2.52.0


