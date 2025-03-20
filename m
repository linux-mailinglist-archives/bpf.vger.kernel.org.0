Return-Path: <bpf+bounces-54453-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43C17A6A540
	for <lists+bpf@lfdr.de>; Thu, 20 Mar 2025 12:48:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80CAB1892A97
	for <lists+bpf@lfdr.de>; Thu, 20 Mar 2025 11:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DE21225761;
	Thu, 20 Mar 2025 11:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LxB2xpgB"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7450225413;
	Thu, 20 Mar 2025 11:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742471061; cv=none; b=GqtdslB8YtzZZhWlZ5o12jnq5NRqJ/aRtQ0Vt88iRHVnzKdg/DZ6h7XuYZE7DknlXWUv2kFI1m04ZC+xo0PD0OHkR3rrrwgeD8vRgteW1+Q9uR6QgMdRL6QUqS7sQSeQw4na+4DcbkQIJTwoJMnA6N4ouUQRxw2V0txV6g3EnZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742471061; c=relaxed/simple;
	bh=ArFi6LYnws/zK5pbLN4Y6WDU1aVkoTA4UhqE31uFzpc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZoUy14zmQcDe7smpq0xX0b7AuWCZt8XSXm4KLRp++oFkQw4KelC3E/A1oXwOzPs5YFGEngJqwbeMbCSJ80ktMjcMeBhXbXuHTqDYB0knHT1qWh57zt7jSxUPYcPrTj3ct/Cs3Z6gl47qjFz0ocxJCnLdy2dxJO+vyC2yfQDXFj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LxB2xpgB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71CEDC4CEDD;
	Thu, 20 Mar 2025 11:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742471061;
	bh=ArFi6LYnws/zK5pbLN4Y6WDU1aVkoTA4UhqE31uFzpc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LxB2xpgBNiMBZ40aMizcDYZVftrCgO+oTiZatXW3BMIfuLoKksIo3rkEtIXBlMuiw
	 VZQxFCZfGrFiJMzwSUeir4K3q152o90B7fFyUTZhpdJCj7KCLtR1Qsgw2e0pa54aOh
	 S2oIj0YBb/jFPNcrOx34W/+cvHB63kKaFrc9IjtCWUebWaVPVZyeIUb1Q1JpWVCXQA
	 Y/Rqp9mdiV/COtHq/hDCZfT2GeD6x/p0QTfPsPSEVHLmxB8N6Jm9Z+a363BlYjjoQu
	 bbIrnSt7Kq0Xl4C0WSfkGAGrV7mpJijeKwkq4IvG94eBpk5dPuVKVnDFnP65SwPPcW
	 Ce3T+Vl7Myi1A==
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
Subject: [PATCH RFCv3 12/23] selftests/bpf: Use 5-byte nop for x86 usdt probes
Date: Thu, 20 Mar 2025 12:41:47 +0100
Message-ID: <20250320114200.14377-13-jolsa@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250320114200.14377-1-jolsa@kernel.org>
References: <20250320114200.14377-1-jolsa@kernel.org>
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
2.49.0


