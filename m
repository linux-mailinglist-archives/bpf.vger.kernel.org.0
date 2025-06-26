Return-Path: <bpf+bounces-61666-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 161F0AE9E16
	for <lists+bpf@lfdr.de>; Thu, 26 Jun 2025 15:02:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AC09189C719
	for <lists+bpf@lfdr.de>; Thu, 26 Jun 2025 13:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A3E22E4269;
	Thu, 26 Jun 2025 13:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b="JrgEnndU"
X-Original-To: bpf@vger.kernel.org
Received: from mx-rz-3.rrze.uni-erlangen.de (mx-rz-3.rrze.uni-erlangen.de [131.188.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A59323C4EB
	for <bpf@vger.kernel.org>; Thu, 26 Jun 2025 13:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=131.188.11.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750942936; cv=none; b=ZhnUPNMm3MueteBxtUDZJB7ESm0/8HXd/qIk0qmyIJlG8tIb4uxF3FQ6ZNDMDH2pYZpUdPRHdqMtQbuwiBOxGXjPC7ERuF38zB1ucOe2FsDZCiJSBuBUKdh9N9gY2jvDPq6K2qYpIp00i4K+JHJbCe8S20js/YSquGA27C0KyJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750942936; c=relaxed/simple;
	bh=S1X+cZlqYIS4hscYAXmeQ7UuHyxC6vYHIwNMw5LWid4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GLCrtlUa+ajXuZfpLk5QpbaW2hFqo/5nGF1ongYDhxylQ91TIO3d1LE+Vd+zkAmX5sY3nFzlskR7xV+U4rLI0sue9Banc3GWbakrc/VjNvv8wIlj4FQUYDL+bGm+EfyWhylmXs12Cs4ECpOPWi9h/aHt3UImoUv/7gXPfL+H9G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fau.de; spf=pass smtp.mailfrom=fau.de; dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b=JrgEnndU; arc=none smtp.client-ip=131.188.11.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fau.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fau.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fau.de; s=fau-2021;
	t=1750942932; bh=6UGcoEjnt7NirniVSg7tT5FGmb9dl8yrb4KFUoiaPkQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:To:CC:
	 Subject;
	b=JrgEnndUMfQ/TphSPmYxnCwwCSqlnaMFGMV6IYLSOYqu6EZ1ahWEyQtr6nmIhNMRV
	 iKFwkMp7v3FA1eSHUSvdZEozrSFVlU+zo0OfF6Ix9KErbpVifrLHOeZF0L93zdGByb
	 vTaIjpzwrobTX1RhbM8U0HOoqd1emH8/N/rdXB1NJ6zL10LN52370hGsPtQcfjbhN8
	 DpcfG706E7EIXYPHKe14xuEEcQsoIZdIWxEKr2UTDgtBWhtIzSYSm8M8DzZRmzjAJM
	 WbaXcY3fo8LHbI1qTEncrxrzti6mqau+RFNzbDkW879NkUSLfAEp+K2qwX/y37ESRt
	 H3XtrpoFS2FCA==
Received: from mx-rz-smart.rrze.uni-erlangen.de (mx-rz-smart.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::1e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-rz-3.rrze.uni-erlangen.de (Postfix) with ESMTPS id 4bSf3S2z4Hz21Cw;
	Thu, 26 Jun 2025 15:02:12 +0200 (CEST)
X-Virus-Scanned: amavisd-new at boeck5.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 10.188.34.184
Received: from luis-tp.pool.uni-erlangen.de (i4laptop33.informatik.uni-erlangen.de [10.188.34.184])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: U2FsdGVkX19nivAzl+5GQpbqOqzJxSKt5AvMdDZCBuk=)
	by smtp-auth.uni-erlangen.de (Postfix) with ESMTPSA id 4bSf3P5yGQz21D2;
	Thu, 26 Jun 2025 15:02:09 +0200 (CEST)
From: Luis Gerhorst <luis.gerhorst@fau.de>
To: Eduard Zingerman <eddyz87@gmail.com>,
	Paul Chaignon <paul.chaignon@gmail.com>,
	bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Luis Gerhorst <luis.gerhorst@fau.de>
Subject: [RFC PATCH 3/3] selftests/bpf: Add nospec_result test
Date: Thu, 26 Jun 2025 15:01:55 +0200
Message-ID: <20250626130155.15195-1-luis.gerhorst@fau.de>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <8734bmoemx.fsf@fau.de>
References: <8734bmoemx.fsf@fau.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make sure nospec_result does not prevent a nospec from being added
before the dangerous insn.

Signed-off-by: Luis Gerhorst <luis.gerhorst@fau.de>
---
 .../selftests/bpf/progs/verifier_unpriv.c     | 90 +++++++++++++++++++
 1 file changed, 90 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_unpriv.c b/tools/testing/selftests/bpf/progs/verifier_unpriv.c
index 35d2625e97b8..7684b7824f4a 100644
--- a/tools/testing/selftests/bpf/progs/verifier_unpriv.c
+++ b/tools/testing/selftests/bpf/progs/verifier_unpriv.c
@@ -820,4 +820,94 @@ __naked void ldimm64_nospec(void)
 "	::: __clobber_all);
 }
 
+SEC("socket")
+__description("spec_v4-induced path termination only after insn check")
+__success __success_unpriv
+__retval(0)
+#ifdef SPEC_V1
+#ifdef SPEC_V4
+/* starts with r0 == r8 == r9 == 0 */
+__xlated_unpriv("if r8 != 0x0 goto pc+1")
+__xlated_unpriv("goto pc+2")
+__xlated_unpriv("if r9 == 0x0 goto pc+4")
+__xlated_unpriv("r2 = r0")
+/* Following nospec required to prevent following `*(u64 *)(NULL -64) = r1` iff
+ * `if r9 == 0 goto pc+4` was mispredicted because of Spectre v1
+ */
+__xlated_unpriv("nospec") /* Spectre v1 */
+__xlated_unpriv("*(u64 *)(r2 -64) = r1")
+__xlated_unpriv("nospec") /* Spectre v4 (nospec_result) */
+#endif
+#endif
+__naked void v4_nospec_result_terminates_v1_path(void)
+{
+	asm volatile ("					\
+	r1 = 0;						\
+	*(u64*)(r10 - 8) = r1;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map_hash_8b] ll;				\
+	call %[bpf_map_lookup_elem];			\
+	r8 = r0;					\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map_hash_8b] ll;				\
+	call %[bpf_map_lookup_elem];			\
+	r9 = r0;					\
+	r0 = r10;					\
+	r1 = 0;						\
+	r2 = r10;					\
+	if r8 != 0 goto l0_%=;				\
+	if r9 != 0 goto l0_%=;				\
+	r0 = 0;						\
+l0_%=:	if r8 != 0 goto l1_%=;				\
+	goto l2_%=;					\
+l1_%=:	if r9 == 0 goto l3_%=;				\
+	r2 = r0;					\
+l2_%=:	*(u64 *)(r2 -64) = r1;				\
+l3_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash_8b)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("spec_v4-induced path termination only after insn check (simplified, with dead code)")
+__success __success_unpriv
+__retval(0)
+#ifdef SPEC_V1
+#ifdef SPEC_V4
+/* starts with r0 == r8 == r9 == 0 */
+__xlated_unpriv("if r8 != 0x0 goto pc+1") /* if r9 == 0 goto l3_%= */
+__xlated_unpriv("goto pc+2") /* goto l2_%= */
+__xlated_unpriv("goto pc-1") /* if r9 == 0 goto l3_%= */
+__xlated_unpriv("goto pc-1") /* r2 = r0 */
+__xlated_unpriv("nospec") /* Spectre v1 */
+__xlated_unpriv("*(u64 *)(r2 -64) = r1")
+__xlated_unpriv("nospec") /* Spectre v4 (nospec_result) */
+#endif
+#endif
+__naked void v4_nospec_result_terminates_v1_path_simple(void)
+{
+	asm volatile ("					\
+	r8 = 0;						\
+	r9 = 0;						\
+	r0 = r10;					\
+	r1 = 0;						\
+	r2 = r10;					\
+	if r8 != 0 goto l0_%=;				\
+	if r9 != 0 goto l0_%=;				\
+	r0 = 0;						\
+l0_%=:	if r8 != 0 goto l1_%=;				\
+	goto l2_%=;					\
+l1_%=:	if r9 == 0 goto l3_%=;				\
+	r2 = r0;					\
+l2_%=:	*(u64 *)(r2 -64) = r1;				\
+l3_%=:	r0 = 0;						\
+	exit;						\
+"	::: __clobber_all);
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.49.0


