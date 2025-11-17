Return-Path: <bpf+bounces-74710-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D1952C62EA2
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 09:37:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A0794357A81
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 08:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41C0031DD98;
	Mon, 17 Nov 2025 08:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XMnhpwMa"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B859D31B831;
	Mon, 17 Nov 2025 08:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763368594; cv=none; b=OKx+r6S5baXdxscP1/wKKjIexXKf83mW1CrDEQQlQfJ1EG34hHqihJNu9azZ0DfI0KM1wzIS086z4afSN5uKmtV0FdNivajuA5J4awuF4vfsgIXRPg6DHwHMkE1yQ1Q8HyGDtFHSEIQJZnx7NOmxDC+002AGHP9mfMlcP86gUVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763368594; c=relaxed/simple;
	bh=PoX6orm7LuYUT02UK2LeHepbnxL5HmGjN7/dwjKL6p0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dExVgtrSQMGDj046Q+fpNBvOyII/796RuVt9TMJMaWcYAJrNrdt1Y2ybJhRCRVilviVC15QeYftq4hTkC16zYUWG/BKXKJCjG3pYAlpMZol3IDOfY5fypV80RdioSAdVWlaP0ZaHTPn40qdoQCmNeh5EjSib4nLSipeEHLlynVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XMnhpwMa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBCCEC19423;
	Mon, 17 Nov 2025 08:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763368594;
	bh=PoX6orm7LuYUT02UK2LeHepbnxL5HmGjN7/dwjKL6p0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XMnhpwMaEgwvoQv0m7Klx8B4Wp9uEFU5HU1LPFCfZJFAApMVzPDw+ApmkRkX5k1Pm
	 WF7kLpvWT0Uqwo7G0P810L1ll5CuVpAenY9qm8+7KI2huskh4pvCz6Sy1ltcH0mIkP
	 aw940RMv3CfuIVN6RRIapTr4qJdFqR5xlwFCpyZRBEcC5t9Uaybc6Pb2ciGs3OjWBT
	 +eJ6j+S+4p+jXUvpjtkjA6uBcfVX3Pwn/ccKMJsqOOJc6Sh9e/7zFT58GENGZ3EGhW
	 3Kq1gLhNo7kEFjZnJDPgpCE4GoqTtZ92XEY68gItsrkLkRikepJf/ogL5OkM2gLaHg
	 mkzMRHIe6AcPg==
From: Jiri Olsa <jolsa@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>
Subject: [PATCH bpf-next 3/4] libbpf: Add support to parse extra info in usdt note record
Date: Mon, 17 Nov 2025 09:35:50 +0100
Message-ID: <20251117083551.517393-4-jolsa@kernel.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251117083551.517393-1-jolsa@kernel.org>
References: <20251117083551.517393-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding support to parse extra info in usdt note record that
indicates there's nop,nop5 emitted for probe.

We detect this by checking extra zero byte placed in between
args zero termination byte and desc data end. Please see [1]
for more details.

Together with uprobe syscall feature detection we can decide
if we want to place the probe on top of nop or nop5.

[1] https://github.com/libbpf/usdt
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/lib/bpf/usdt.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/usdt.c b/tools/lib/bpf/usdt.c
index c174b4086673..5730295e69d3 100644
--- a/tools/lib/bpf/usdt.c
+++ b/tools/lib/bpf/usdt.c
@@ -241,6 +241,7 @@ struct usdt_note {
 	long loc_addr;
 	long base_addr;
 	long sema_addr;
+	bool nop_combo;
 };
 
 struct usdt_target {
@@ -262,6 +263,7 @@ struct usdt_manager {
 	bool has_bpf_cookie;
 	bool has_sema_refcnt;
 	bool has_uprobe_multi;
+	bool has_uprobe_syscall;
 };
 
 struct usdt_manager *usdt_manager_new(struct bpf_object *obj)
@@ -301,6 +303,11 @@ struct usdt_manager *usdt_manager_new(struct bpf_object *obj)
 	 * usdt probes.
 	 */
 	man->has_uprobe_multi = kernel_supports(obj, FEAT_UPROBE_MULTI_LINK);
+
+	/*
+	 * Detect kernel support for uprobe syscall to be used to pick usdt attach point.
+	 */
+	man->has_uprobe_syscall = kernel_supports(obj, FEAT_UPROBE_SYSCALL);
 	return man;
 }
 
@@ -784,6 +791,15 @@ static int collect_usdt_targets(struct usdt_manager *man, Elf *elf, const char *
 		target = &targets[target_cnt];
 		memset(target, 0, sizeof(*target));
 
+		/*
+		 * We have usdt with nop,nop5 instruction and we detected uprobe syscall,
+		 * so we can place the uprobe directly on nop5 (+1) to get it optimized.
+		 */
+		if (note.nop_combo && man->has_uprobe_syscall) {
+			usdt_abs_ip++;
+			usdt_rel_ip++;
+		}
+
 		target->abs_ip = usdt_abs_ip;
 		target->rel_ip = usdt_rel_ip;
 		target->sema_off = usdt_sema_off;
@@ -1144,7 +1160,7 @@ struct bpf_link *usdt_manager_attach_usdt(struct usdt_manager *man, const struct
 static int parse_usdt_note(GElf_Nhdr *nhdr, const char *data, size_t name_off, size_t desc_off,
 			   struct usdt_note *note)
 {
-	const char *provider, *name, *args;
+	const char *provider, *name, *args, *end, *extra;
 	long addrs[3];
 	size_t len;
 
@@ -1182,6 +1198,15 @@ static int parse_usdt_note(GElf_Nhdr *nhdr, const char *data, size_t name_off, s
 	if (args >= data + len) /* missing arguments spec */
 		return -EINVAL;
 
+	extra = memchr(args, '\0', data + len - args);
+	if (!extra) /* non-zero-terminated args */
+		return -EINVAL;
+	++extra;
+	end = data + len;
+
+	/* check if we have one extra byte and if it's zero */
+	note->nop_combo = (extra + 1) == end && *extra == 0;
+
 	note->provider = provider;
 	note->name = name;
 	if (*args == '\0' || *args == ':')
-- 
2.51.1


