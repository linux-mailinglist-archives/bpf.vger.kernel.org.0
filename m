Return-Path: <bpf+bounces-70141-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ABF4BB199E
	for <lists+bpf@lfdr.de>; Wed, 01 Oct 2025 21:30:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 975834C3F95
	for <lists+bpf@lfdr.de>; Wed,  1 Oct 2025 19:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EB4E2D8781;
	Wed,  1 Oct 2025 19:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=listout.xyz header.i=@listout.xyz header.b="WBpNrBTJ"
X-Original-To: bpf@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340B12D7810;
	Wed,  1 Oct 2025 19:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759346989; cv=none; b=EWdzyonTiOJk7FjKuPXWGUV72oe0G68eOZYy7/EWGLcf1QXHJBAq7kFgw4v8BorcpkULj4EkBuieseX80KmZXkmtiHPmI4A0olsyiPWUgeW8UiLaQzky7XI9RBy75wnmCIOSKJ83wIdtznC7eAuj+UfvkOZz0mrYTlQOG9SU3is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759346989; c=relaxed/simple;
	bh=HLYhW50XHaRj/9ZRdiTUSGg8dvCftmf3opE4NOaKOFI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rTWPrHShDxS70dEv/Dz/L23Sl2m9IqAKfhmLjXmox2L6rdycSYFPqimQ7mSFKa1w9t3R+1F1R7zAJCtRP6879tlEZWPflJPdlIr8bKaDhD6RScxxL5IWV9FmN4kN7tIecMAT/WqoB30aI/OaSUcVee/BY6BvXycOtKunkFLhaoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=listout.xyz; spf=pass smtp.mailfrom=listout.xyz; dkim=pass (2048-bit key) header.d=listout.xyz header.i=@listout.xyz header.b=WBpNrBTJ; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=listout.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=listout.xyz
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4ccQ3q3XFdz9sbC;
	Wed,  1 Oct 2025 21:29:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=listout.xyz; s=MBO0001;
	t=1759346983;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mFOt7Q6Yh4zU6HGqC4KBvS7uM2NDq7KoM7BsVGIWIDU=;
	b=WBpNrBTJDebZFbtWff4fU8NsdEx9UFdfAXhpZVJe49UvJYzwkte308sbBgcbmIxJ0EiHNE
	qlG+fwBpHwbKhqX8PbnbJ5Ta/BZUtWAk2WHiQiC0Ct4rVk/K/L3YwQzBv5acbj1Phs0SEG
	E6OOrAlyEPQVdHkbU9FEft5RZU8DtXJPEGfBahyngZv7i/UorgrWNgd/Vbtx97OyP8YzJc
	u9XkDFim6zISZvo1iv8oKhLgJz0ikJmZPz1BFzDHNekYtokpJgFn5TSc5bs5TM/OY5z2JF
	OIqXhUey+PZbvlSyDJ+8XYv74KoqazSxt+nf9RSmkp/IrTt73cfqajuArJkR2g==
From: Brahmajit Das <listout@listout.xyz>
To: syzbot+d36d5ae81e1b0a53ef58@syzkaller.appspotmail.com
Cc: andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	haoluo@google.com,
	john.fastabend@gmail.com,
	jolsa@kernel.org,
	kpsingh@kernel.org,
	linux-kernel@vger.kernel.org,
	martin.lau@linux.dev,
	sdf@fomichev.me,
	song@kernel.org,
	syzkaller-bugs@googlegroups.com,
	yonghong.song@linux.dev,
	KaFai Wan <kafai.wan@linux.dev>
Subject: [PATCH v4 2/2] selftests/bpf: Add test for BPF_NEG alu on CONST_PTR_TO_MAP
Date: Thu,  2 Oct 2025 00:58:59 +0530
Message-ID: <20251001192859.2343567-3-listout@listout.xyz>
In-Reply-To: <20251001192859.2343567-1-listout@listout.xyz>
References: <68d26227.a70a0220.1b52b.02a4.GAE@google.com>
 <20251001192859.2343567-1-listout@listout.xyz>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: KaFai Wan <kafai.wan@linux.dev>

Add a test case for BPF_NEG operation on CONST_PTR_TO_MAP. Tests if
BPF_NEG operation on map_ptr is rejected in unprivileged mode and is a
scalar value and do not trigger Oops in privileged mode.

Signed-off-by: KaFai Wan <kafai.wan@linux.dev>
---
 .../bpf/progs/verifier_value_illegal_alu.c     | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_value_illegal_alu.c b/tools/testing/selftests/bpf/progs/verifier_value_illegal_alu.c
index a9ab37d3b9e2..dcaab61a11a0 100644
--- a/tools/testing/selftests/bpf/progs/verifier_value_illegal_alu.c
+++ b/tools/testing/selftests/bpf/progs/verifier_value_illegal_alu.c
@@ -146,6 +146,24 @@ l0_%=:	exit;						\
 	: __clobber_all);
 }
 
+SEC("socket")
+__description("map_ptr illegal alu op, map_ptr = -map_ptr")
+__failure __msg("R0 invalid mem access 'scalar'")
+__failure_unpriv __msg_unpriv("R0 pointer arithmetic prohibited")
+__flag(BPF_F_ANY_ALIGNMENT)
+__naked void map_ptr_illegal_alu_op(void)
+{
+	asm volatile ("					\
+	r0 = %[map_hash_48b] ll;			\
+	r0 = -r0;					\
+	r1 = 22;					\
+	*(u64*)(r0 + 0) = r1;				\
+	exit;						\
+"	:
+	: __imm_addr(map_hash_48b)
+	: __clobber_all);
+}
+
 SEC("flow_dissector")
 __description("flow_keys illegal alu op with variable offset")
 __failure __msg("R7 pointer arithmetic on flow_keys prohibited")
-- 
2.51.0


