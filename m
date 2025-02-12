Return-Path: <bpf+bounces-51254-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F28BA3279F
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2025 14:54:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBD1F166E64
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2025 13:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87A4F27181F;
	Wed, 12 Feb 2025 13:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="AGngtVVA"
X-Original-To: bpf@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEA1820E6E1
	for <bpf@vger.kernel.org>; Wed, 12 Feb 2025 13:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739368442; cv=none; b=qjaqICddFRdKTA/oOk0KvxfrvVLw6jmh91xQtcJL+wUsCkiC47fMsYSk2oGKymACC9EanabkK7oCVVVBEGBo1TPNXb3QFpvatKkhFDvwnppzWNX2Uj2kY0NcfsQej7H9ARqwPsgBNxdIDMlidTYaU2pgh8N+4YMOyyvByUKYFpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739368442; c=relaxed/simple;
	bh=KqVczGPQmDbso8goJQ17H2gqr9JzyoS9YGhdOUbQq5A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CyrOH+c3Q5dEIImzmkkR3pVdEf6Mw79hbl2PlwpwDNwNmTbt4Anx+DnDsHUAsuIz1ueFn4S0P/JE/BI6QCQ2a4fseiYZ9NkndPcnOgV3M9VkSjBNg3E5pip5kpxPWS4KRSTmSl84jJ7weMwnuQgfQkTb6CCQ08lKXaQrbnrAFY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=AGngtVVA; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=QceoO
	8k2h7uGLagBkuKouEvOovOe7yhNXI84DPM4hak=; b=AGngtVVAqj4+PHr8uPyn9
	/PLeFdj5p36eLuGdcjcNJN+T0xUnedKaWPmwpI2E30+H3Hflq4XQ8xEOSy917AVI
	rdassvGPbKvfwlAHQTKwM+aqtYydSuDBeN1o1MoSDZ7OOGCGJErvHaX3oLbU9Ryo
	J+5cCKjYZ/xCL55vB3ic18=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wD37x+9p6xn5UW6Lg--.513S3;
	Wed, 12 Feb 2025 21:53:07 +0800 (CST)
From: Jiayuan Chen <mrpre@163.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: daniel@iogearbox.net,
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
	mykolal@fb.com,
	shuah@kernel.org,
	Jiayuan Chen <mrpre@163.com>,
	syzbot+d2a2c639d03ac200a4f1@syzkaller.appspotmail.com
Subject: [PATCH bpf-next v1 1/2] bpf: Fix array bounds error with may_goto
Date: Wed, 12 Feb 2025 21:52:50 +0800
Message-ID: <20250212135251.85487-2-mrpre@163.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250212135251.85487-1-mrpre@163.com>
References: <20250212135251.85487-1-mrpre@163.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD37x+9p6xn5UW6Lg--.513S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7KF18Jr1fGrWDKr45ArWfuFg_yoW8uFyDpF
	n8CFyjkF4kKF4UK390k3ZrZrZ8GF48G3W7W3ZxAw18Gry7Xr4DCF12gFZ09r43Xr92kF1r
	Can8uryYkFZrt3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zEcTmxUUUUU=
X-CM-SenderInfo: xpus2vi6rwjhhfrp/xtbBDx7xp2espEEvTQAAsL

may_goto uses an additional 8 bytes on the stack, which causes the
interpreters[] array to go out of bounds when calculating index by
stack_size.

Reported-by: syzbot+d2a2c639d03ac200a4f1@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/bpf/0000000000000f823606139faa5d@google.com/
Fixes: 011832b97b311 ("bpf: Introduce may_goto instruction")
Signed-off-by: Jiayuan Chen <mrpre@163.com>
---
 kernel/bpf/core.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index da729cbbaeb9..498b35284f81 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -2255,7 +2255,7 @@ static u64 PROG_NAME_ARGS(stack_size)(u64 r1, u64 r2, u64 r3, u64 r4, u64 r5, \
 
 EVAL6(DEFINE_BPF_PROG_RUN, 32, 64, 96, 128, 160, 192);
 EVAL6(DEFINE_BPF_PROG_RUN, 224, 256, 288, 320, 352, 384);
-EVAL4(DEFINE_BPF_PROG_RUN, 416, 448, 480, 512);
+EVAL5(DEFINE_BPF_PROG_RUN, 416, 448, 480, 512, 544);
 
 EVAL6(DEFINE_BPF_PROG_RUN_ARGS, 32, 64, 96, 128, 160, 192);
 EVAL6(DEFINE_BPF_PROG_RUN_ARGS, 224, 256, 288, 320, 352, 384);
@@ -2267,8 +2267,11 @@ static unsigned int (*interpreters[])(const void *ctx,
 				      const struct bpf_insn *insn) = {
 EVAL6(PROG_NAME_LIST, 32, 64, 96, 128, 160, 192)
 EVAL6(PROG_NAME_LIST, 224, 256, 288, 320, 352, 384)
-EVAL4(PROG_NAME_LIST, 416, 448, 480, 512)
+EVAL5(PROG_NAME_LIST, 416, 448, 480, 512, 544)
 };
+
+#define MAX_INTERPRETERS_CALLBACK (sizeof(interpreters) / sizeof(*interpreters))
+
 #undef PROG_NAME_LIST
 #define PROG_NAME_LIST(stack_size) PROG_NAME_ARGS(stack_size),
 static __maybe_unused
@@ -2380,8 +2383,10 @@ static void bpf_prog_select_func(struct bpf_prog *fp)
 {
 #ifndef CONFIG_BPF_JIT_ALWAYS_ON
 	u32 stack_depth = max_t(u32, fp->aux->stack_depth, 1);
+	u32 idx = (round_up(stack_depth, 32) / 32) - 1;
 
-	fp->bpf_func = interpreters[(round_up(stack_depth, 32) / 32) - 1];
+	WARN_ON_ONCE(idx >= MAX_INTERPRETERS_CALLBACK);
+	fp->bpf_func = interpreters[idx];
 #else
 	fp->bpf_func = __bpf_prog_ret0_warn;
 #endif
-- 
2.47.1


