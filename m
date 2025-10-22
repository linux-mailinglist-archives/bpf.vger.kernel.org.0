Return-Path: <bpf+bounces-71828-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 61655BFD701
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 19:02:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 78C58506EAE
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 16:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 740D729AB05;
	Wed, 22 Oct 2025 16:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VoFBlYf/"
X-Original-To: bpf@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B914B28EA56
	for <bpf@vger.kernel.org>; Wed, 22 Oct 2025 16:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761151592; cv=none; b=diPiwZjomowG1x6yilIFW7NGC6vIZ8LsJSjKoV4yWZ59u63roWrbOi3gsDjLUDT16RE1ikD0dVSVjHHX+yQMyDE8WmY05bLCBAXMCEIa0hDro04PbqibBsrLTiPza1kJ+rSsGfKz6nvC6NpfBrrnhlNdttXUFTEpGxdb1c41Qwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761151592; c=relaxed/simple;
	bh=wrsQAp0TGs8gJXBhL+Pm/Ez5V7kMDw/AHC3OiikOpMQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P8+SYOvKh13K1eG8+gfSf8E8sttyoQYMwd3NecYa/tIYDwFzhyDlYJua4bJ7DyLgqdUCCIfk5XL05Ts/PDh9HKhTEai2x/YqHn/ByrHS7jmjHlGBZgq3O8BSuPCo27cVruCOJphPEMXfAutnm8nw79ySFcJiJpTK1y/g8SLi5rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VoFBlYf/; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761151587;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tE0qJy2M/AZrZXVbIbayGvBfV5fR9ey5S78aB6UPd6Y=;
	b=VoFBlYf/alWqPDOqivJXzjjBUpQ3M2YCxCaxiBivgUp3LrNSG5JbaoDyskPlf+7cMhPSFE
	gxV6E+zta7cYYyC3KgBWKE6iEd1bjb0KXNWwHe1TIvo+ZJnNEiYkiAq6MhSkF3V43/nQsu
	VUDRCNdsnRJ4EXpSLCcbujeIGzweTxs=
From: KaFai Wan <kafai.wan@linux.dev>
To: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	shuah@kernel.org,
	paul.chaignon@gmail.com,
	m.shachnai@gmail.com,
	luis.gerhorst@fau.de,
	colin.i.king@gmail.com,
	harishankar.vishwanathan@gmail.com,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: KaFai Wan <kafai.wan@linux.dev>
Subject: [PATCH bpf-next 2/2] selftests/bpf: Add test for conditional jumps on same register
Date: Thu, 23 Oct 2025 00:44:57 +0800
Message-ID: <20251022164457.1203756-3-kafai.wan@linux.dev>
In-Reply-To: <20251022164457.1203756-1-kafai.wan@linux.dev>
References: <20251022164457.1203756-1-kafai.wan@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Add a test case to verify that conditional jumps on the same register
(e.g., JGT r0 > r0) do not trigger verifier BUG warnings when the register
holds a scalar with range.

Signed-off-by: KaFai Wan <kafai.wan@linux.dev>
---
 .../selftests/bpf/progs/verifier_bounds.c       | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_bounds.c b/tools/testing/selftests/bpf/progs/verifier_bounds.c
index 0a72e0228ea9..620095635af5 100644
--- a/tools/testing/selftests/bpf/progs/verifier_bounds.c
+++ b/tools/testing/selftests/bpf/progs/verifier_bounds.c
@@ -1709,4 +1709,21 @@ __naked void jeq_disagreeing_tnums(void *ctx)
 	: __clobber_all);
 }
 
+SEC("socket")
+__description("JGT on same register")
+__success __log_level(2)
+__naked void jgt_same_register(void *ctx)
+{
+	asm volatile("			\
+	call %[bpf_get_prandom_u32];	\
+	w8 = 0x80000000;		\
+	r0 &= r8;			\
+	if r0 > r0 goto +1;		\
+	call %[bpf_get_prandom_u32];	\
+	exit;				\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.43.0


