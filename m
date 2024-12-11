Return-Path: <bpf+bounces-46634-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DA379ECD59
	for <lists+bpf@lfdr.de>; Wed, 11 Dec 2024 14:37:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D8601652F2
	for <lists+bpf@lfdr.de>; Wed, 11 Dec 2024 13:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5A482368E4;
	Wed, 11 Dec 2024 13:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dvWAeSTG"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6746822913C;
	Wed, 11 Dec 2024 13:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733924147; cv=none; b=Vi5bgtcJEQ+7Dyb+n/CBJi8zs1LG5OrMgH+DAHKYkHZCjxI433PgpAOSU4QK0djDGwmR9nQw6OfD34z08xibx+7FbrTidcvn/HIr95/JO0qjzYsorVgbbJoSUf5eqT8Hg8sX1KYmRk/Le3mVuhyuPRCC5+Ck/6nunpkLmPXHK60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733924147; c=relaxed/simple;
	bh=eVJp2tvqlAvwi3XNY+zHgNGDY+OQsQBQRyY5w45290U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oZc35ffCp1VLkAD44THJ85Oa+XeYuNElw8mvEkABEtAfoKzTH4oiFbQbktsAUMnz9AkRs/coArOkrq5JK1jW+LyCcI2EocYqojxKwYCl+iHHhAxrgJqHLpk8fXMVEmzmXolQDjvVyvo90jAdG/6U3AJlinCWw1ARNyQvV7+RKdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dvWAeSTG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94E29C4CED2;
	Wed, 11 Dec 2024 13:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733924146;
	bh=eVJp2tvqlAvwi3XNY+zHgNGDY+OQsQBQRyY5w45290U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dvWAeSTG946LLwT9po0SC0DUVCIt8caT7gTXeIdVfjKyuwPEXw3VAWVo3lAz3Da73
	 I9ri6F8h1I28t+YGBXcMMY3OzxvTD7mapawbthafwpURjX5BkSPfVMXgAMoOoJVpcS
	 AK9qQxUSYUZNQjuUZvBLb0veNWOvhSR0qU7jYC2baYhIhTTQOhaXFAu/v4CifrA/LM
	 0wr9SKPLuSSC5JlVRl3yuBiRy19pBEOQF6iY4M004A2SJTWfTT2VcLR4SepovLaCm9
	 YRJgNMzQCvxh3Nm2+lkiDOrwExuGFCnZks+P8prvYGsmIvFa6tGhHuiGrVoOERlmXj
	 MX2w1f/ltJZpg==
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
Subject: [PATCH bpf-next 09/13] selftests/bpf: Use 5-byte nop for x86 usdt probes
Date: Wed, 11 Dec 2024 14:33:58 +0100
Message-ID: <20241211133403.208920-10-jolsa@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241211133403.208920-1-jolsa@kernel.org>
References: <20241211133403.208920-1-jolsa@kernel.org>
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


