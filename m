Return-Path: <bpf+bounces-63525-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D19DB0824A
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 03:30:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A38777A60AA
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 01:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04C2C1F8755;
	Thu, 17 Jul 2025 01:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m/QFJQWw"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD2D1E47B7;
	Thu, 17 Jul 2025 01:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752715756; cv=none; b=BWK2nBJuZ+/fwfqqRY3RmTgLSvvMtN88g9QNE0MvwfBVcCeYf5kcBXK3T459XzowoRTn2RAck58uAYwC6yhfXUPO4iV7g3GfBKy0QS6VI4EeBdM0Uc2/QGmdkVrEFYuVeN38/zlb2tCXkZvRWwEYKCzAxm31dGFMKLqGaILtPOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752715756; c=relaxed/simple;
	bh=ckTATXCHrvGOC+WZsqQof/3QKuBCz763BBzol3sDKjI=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=QcB0w/aoftzXbprWNudqa2b5+mm7mwZE84wU8abQGRen6WR+53AwrjlKARGU3/0Uia2/6dzJ4LQBu9pJnCnrxR1jTFWKbs+F0D7sZ7vRYzl7K3gEps8y1XyPwx7byVK12r5+cnnCwg/ajPPrQtCIldSmQHKcJwzp1ffJMaZ6Y0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m/QFJQWw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8E31C113D0;
	Thu, 17 Jul 2025 01:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752715756;
	bh=ckTATXCHrvGOC+WZsqQof/3QKuBCz763BBzol3sDKjI=;
	h=Date:From:To:Cc:Subject:References:From;
	b=m/QFJQWwppgTiNK2hwh/4uOiQoAmu1LW1Y7Mcxm75h50ZpfmkeKyKJy+1Vbv4EZjI
	 bR3c1iQQDRh5JWFsExVEsZZOxDD+QhfBMUXOP4U6jRlresanvXYSfCtfySeKM+y7Ux
	 dZby2XAwmjD7AS37wD7RuCFJu/k1JYX5pSoRc/NkklAKhb3dTS6W4pZ+KLWurZDNTX
	 LBpaWA11PaYttZJeM3Ck7PQE3W5pkpLbYJ3fmbnvUiKXuIWbqSPpCYSYtHeWAN0UEF
	 Oy1hRNLnYEXlx0Bx8y9UedmFqTZ9FVsNEoYua3qMVuzvdGXKZdz07czIyrE6oaMM9B
	 2IFVPJyc5TcQw==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1ucDRI-000000068vj-16Y0;
	Wed, 16 Jul 2025 21:29:36 -0400
Message-ID: <20250717012936.120967362@kernel.org>
User-Agent: quilt/0.68
Date: Wed, 16 Jul 2025 21:28:51 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org,
 x86@kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>,
 Jiri Olsa <jolsa@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Andrii Nakryiko <andrii@kernel.org>,
 Indu Bhagat <indu.bhagat@oracle.com>,
 "Jose E. Marchesi" <jemarch@gnu.org>,
 Beau Belgrave <beaub@linux.microsoft.com>,
 Jens Remus <jremus@linux.ibm.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Jens Axboe <axboe@kernel.dk>,
 Florian Weimer <fweimer@redhat.com>,
 Sam James <sam@gentoo.org>
Subject: [PATCH v9 03/11] x86/uaccess: Add unsafe_copy_from_user() implementation
References: <20250717012848.927473176@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Josh Poimboeuf <jpoimboe@kernel.org>

Add an x86 implementation of unsafe_copy_from_user() similar to the
existing unsafe_copy_to_user().

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 arch/x86/include/asm/uaccess.h | 39 +++++++++++++++++++++++++---------
 1 file changed, 29 insertions(+), 10 deletions(-)

diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
index 3a7755c1a441..3caf02d0503e 100644
--- a/arch/x86/include/asm/uaccess.h
+++ b/arch/x86/include/asm/uaccess.h
@@ -599,7 +599,7 @@ _label:									\
  * We want the unsafe accessors to always be inlined and use
  * the error labels - thus the macro games.
  */
-#define unsafe_copy_loop(dst, src, len, type, label)				\
+#define unsafe_copy_to_user_loop(dst, src, len, type, label)			\
 	while (len >= sizeof(type)) {						\
 		unsafe_put_user(*(type *)(src),(type __user *)(dst),label);	\
 		dst += sizeof(type);						\
@@ -607,15 +607,34 @@ _label:									\
 		len -= sizeof(type);						\
 	}
 
-#define unsafe_copy_to_user(_dst,_src,_len,label)			\
-do {									\
-	char __user *__ucu_dst = (_dst);				\
-	const char *__ucu_src = (_src);					\
-	size_t __ucu_len = (_len);					\
-	unsafe_copy_loop(__ucu_dst, __ucu_src, __ucu_len, u64, label);	\
-	unsafe_copy_loop(__ucu_dst, __ucu_src, __ucu_len, u32, label);	\
-	unsafe_copy_loop(__ucu_dst, __ucu_src, __ucu_len, u16, label);	\
-	unsafe_copy_loop(__ucu_dst, __ucu_src, __ucu_len, u8, label);	\
+#define unsafe_copy_to_user(_dst, _src, _len, label)				\
+do {										\
+	void __user *__dst = (_dst);						\
+	const void *__src = (_src);						\
+	size_t __len = (_len);							\
+	unsafe_copy_to_user_loop(__dst, __src, __len, u64, label);		\
+	unsafe_copy_to_user_loop(__dst, __src, __len, u32, label);		\
+	unsafe_copy_to_user_loop(__dst, __src, __len, u16, label);		\
+	unsafe_copy_to_user_loop(__dst, __src, __len, u8,  label);		\
+} while (0)
+
+#define unsafe_copy_from_user_loop(dst, src, len, type, label)			\
+	while (len >= sizeof(type)) {						\
+		unsafe_get_user(*(type *)(dst), (type __user *)(src), label);	\
+		dst += sizeof(type);						\
+		src += sizeof(type);						\
+		len -= sizeof(type);						\
+	}
+
+#define unsafe_copy_from_user(_dst, _src, _len, label)				\
+do {										\
+	void *__dst = (_dst);							\
+	void __user *__src = (_src);						\
+	size_t __len = (_len);							\
+	unsafe_copy_from_user_loop(__dst, __src, __len, u64, label);		\
+	unsafe_copy_from_user_loop(__dst, __src, __len, u32, label);		\
+	unsafe_copy_from_user_loop(__dst, __src, __len, u16, label);		\
+	unsafe_copy_from_user_loop(__dst, __src, __len, u8,  label);		\
 } while (0)
 
 #ifdef CONFIG_CC_HAS_ASM_GOTO_OUTPUT
-- 
2.47.2



