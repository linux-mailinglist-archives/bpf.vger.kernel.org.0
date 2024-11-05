Return-Path: <bpf+bounces-44041-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A7419BCE07
	for <lists+bpf@lfdr.de>; Tue,  5 Nov 2024 14:37:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C8C41C214BB
	for <lists+bpf@lfdr.de>; Tue,  5 Nov 2024 13:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B07171D8E07;
	Tue,  5 Nov 2024 13:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y/ZL9e2J"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307B71D63EA;
	Tue,  5 Nov 2024 13:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730813737; cv=none; b=kKQ893d0ioGKXfPWnRyDkfXu7orZvGGR1pG1vfVDrxCTTPPK4l+raR8S4syum8s//UkWVztixvutehcwgqYnp1HcWZXpndeSmkQi3RBsefpIYAYx6NqvSihf/uU70JI+GdPdt447OV3922jilS/9Xz/OjON+aQgm7/GzuqcIiHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730813737; c=relaxed/simple;
	bh=eVJp2tvqlAvwi3XNY+zHgNGDY+OQsQBQRyY5w45290U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gqOyOY+Sbms6OkuDSbM1UiGBzNa8kwXQehzAUB0MoBbWgwRrgHnrmPgOxwftyqEsYlDSrQQkxb2B4wm1aOPwcla/xzYg4QdyoTlEYxBSLOoD/Gx4WMOZAnE8qNOn/+3r7LRFe2dLr80bDFcYRHUQFtBk+k5nVH9ikMJuE6mnT/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y/ZL9e2J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A28CC4CECF;
	Tue,  5 Nov 2024 13:35:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730813736;
	bh=eVJp2tvqlAvwi3XNY+zHgNGDY+OQsQBQRyY5w45290U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y/ZL9e2JRiz8Y0IArgMnxL0btwzw+wIrKrW43vSOe1w58W8+GmiJNuTKa+JTNLToV
	 5rThuGTZ56YQY++8IHa9J5WmP+oTneVUTnC2ITPDZw1j2xDb5dvmY81I6/a4IBPO5b
	 ttEk4aHzW8t/yBEjaW3TSG4UCYlO1UyMEFCgJPomdby1XHbL2IuZuld6M79lU0bnGr
	 sEuvLj8qGgcViJqbSifw0vggxohxFWZejhvOTfllBgsC1FIwH7NDj98WHwdVV7iurC
	 fa1K5a6ABim40OF/9cpRqV7Pp9J96GvUfL6tx66wwBKLfX58n5vmJ38qTjN0dBSUCK
	 DFneyTS63vu1Q==
From: Jiri Olsa <jolsa@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [RFC bpf-next 08/11] selftests/bpf: Use 5-byte nop for x86 usdt probes
Date: Tue,  5 Nov 2024 14:34:02 +0100
Message-ID: <20241105133405.2703607-9-jolsa@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241105133405.2703607-1-jolsa@kernel.org>
References: <20241105133405.2703607-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Using 5-byte nop for x86 usdt probes so we can switch
to optimized uprobe them.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/testing/selftests/bpf/sdt.h | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/sdt.h b/tools/testing/selftests/bpf/sdt.h
index ca0162b4dc57..7ac9291f45f1 100644
--- a/tools/testing/selftests/bpf/sdt.h
+++ b/tools/testing/selftests/bpf/sdt.h
@@ -234,6 +234,13 @@ __extension__ extern unsigned long long __sdt_unsp;
 #define _SDT_NOP	nop
 #endif
 
+/* Use 5 byte nop for x86_64 to allow optimizing uprobes. */
+#if defined(__x86_64__)
+# define _SDT_DEF_NOP _SDT_ASM_5(990:	.byte 0x0f, 0x1f, 0x44, 0x00, 0x00)
+#else
+# define _SDT_DEF_NOP _SDT_ASM_1(990:	_SDT_NOP)
+#endif
+
 #define _SDT_NOTE_NAME	"stapsdt"
 #define _SDT_NOTE_TYPE	3
 
@@ -286,7 +293,7 @@ __extension__ extern unsigned long long __sdt_unsp;
 
 #define _SDT_ASM_BODY(provider, name, pack_args, args, ...)		      \
   _SDT_DEF_MACROS							      \
-  _SDT_ASM_1(990:	_SDT_NOP)					      \
+  _SDT_DEF_NOP								      \
   _SDT_ASM_3(		.pushsection .note.stapsdt,_SDT_ASM_AUTOGROUP,"note") \
   _SDT_ASM_1(		.balign 4)					      \
   _SDT_ASM_3(		.4byte 992f-991f, 994f-993f, _SDT_NOTE_TYPE)	      \
-- 
2.47.0


