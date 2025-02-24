Return-Path: <bpf+bounces-52357-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CBEAA422BD
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2025 15:17:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9E914429BA
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2025 14:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7936254863;
	Mon, 24 Feb 2025 14:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m0XTtbOX"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D101624D9;
	Mon, 24 Feb 2025 14:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740405873; cv=none; b=efvoVjbA/VDH1YNycOQRMipu3qERhw1QTpHDoXqtbddBEwragIaJ97x8H2ggr7G67zhDxKca4TydNye3fFxW5VGd6ZlCy6DXoYMEg4dFulObLHTZCCZJQhrNDGIWdNMV9/gFoSTa3ISyUu2VBaG8zuR/jDn2QcosZvaV7CcZtz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740405873; c=relaxed/simple;
	bh=T6d3PGBM2fqmXyl9UEq+fkjN0GkW2lFQKaocpSHdRMY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oz4lzSRj9fE2hMLI1EXg3a26DyfCrJHzBuQK29RmMmQhfS5EAr/F6RCX8MCGmGbqI8UvHzFssi+IitNw1ivlFBYz3waWFx4IjRc5PMYHkdGetyGL6KssnoUhHgbsgkuOi5tNYCBSVdI3Cw1ehNCTo2f0842xBPhrB1ZWsEfgjk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m0XTtbOX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DE9AC4CED6;
	Mon, 24 Feb 2025 14:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740405873;
	bh=T6d3PGBM2fqmXyl9UEq+fkjN0GkW2lFQKaocpSHdRMY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m0XTtbOXfRsblnkuyOwHNIKiYG/NxXxWfQQDl66dn/art2zZhpqTmThX86h79zyFL
	 2sYJD5VzbLIG0wFXRuU/gPczVps2/lqkyILJth1FucDRuvUqQ6udNIJUgGSmGtrNM6
	 GgfI3sgqcxhX8krc1UMhShZof7GdcsQhD/Wszhp9kaDeEhnXIESK109Xaxld3ZEycv
	 ye9tRXv2C15/FlFox2Oyi49eiIGF0m1GwYQ6D8VhZo4YgcCQlonEimSDxYmjHBV8dn
	 5CKgcOnk4A2TXT3pfG/4YQ4lllyHg74JOlMfv0IjVRsNJPpOL1hWRd6SMZD39hhjSV
	 3uUMqCEBrLqBg==
From: Jiri Olsa <jolsa@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	x86@kernel.org,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	David Laight <David.Laight@ACULAB.COM>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas@t-8ch.de>
Subject: [PATCH RFCv2 14/18] selftests/bpf: Use 5-byte nop for x86 usdt probes
Date: Mon, 24 Feb 2025 15:01:46 +0100
Message-ID: <20250224140151.667679-15-jolsa@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250224140151.667679-1-jolsa@kernel.org>
References: <20250224140151.667679-1-jolsa@kernel.org>
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
index 1fcfa5160231..1d62c06f5ddc 100644
--- a/tools/testing/selftests/bpf/sdt.h
+++ b/tools/testing/selftests/bpf/sdt.h
@@ -236,6 +236,13 @@ __extension__ extern unsigned long long __sdt_unsp;
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
 
@@ -288,7 +295,7 @@ __extension__ extern unsigned long long __sdt_unsp;
 
 #define _SDT_ASM_BODY(provider, name, pack_args, args, ...)		      \
   _SDT_DEF_MACROS							      \
-  _SDT_ASM_1(990:	_SDT_NOP)					      \
+  _SDT_DEF_NOP								      \
   _SDT_ASM_3(		.pushsection .note.stapsdt,_SDT_ASM_AUTOGROUP,"note") \
   _SDT_ASM_1(		.balign 4)					      \
   _SDT_ASM_3(		.4byte 992f-991f, 994f-993f, _SDT_NOTE_TYPE)	      \
-- 
2.48.1


