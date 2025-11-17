Return-Path: <bpf+bounces-74708-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A4A13C62E99
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 09:36:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D381E358AA2
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 08:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43E4831DD96;
	Mon, 17 Nov 2025 08:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a1J4iIpv"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F6630C350;
	Mon, 17 Nov 2025 08:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763368574; cv=none; b=P48biygmRiDa43L3S/8+8pp3Vw8U38XNtvYB8wppdWV05Q0CwQa/cR+Keq6FerrbWRC7FxihQy6+Ty0RtTSg+eJBssl4bKTdaDyeDqyalOAeUwTWblNsj8MmOsDfUZqoYebIVbQcy4pXRXQDTxQakewJ+xxJ9Htorrin3d5HAxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763368574; c=relaxed/simple;
	bh=h9cfMXTylO4ilK7PpWBGTfAb5BXyOdB/JSrgD/0CO9s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j1ysmubQOWYFEGJJ9NbPzolVtmA51X34LHjThG6RBZJmz6db8NmqCCin1wiVsrUMglP0pb+zFf/gJFeexcl1bLnEcRoQEdOY5ZkX/6UGIibo7BB2os6zv+dVMZLMxBVXob6NL6m6tnM4ddf+LeOgEJDkkoTSoiZ7PMvaZhnLBXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a1J4iIpv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93A74C19422;
	Mon, 17 Nov 2025 08:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763368574;
	bh=h9cfMXTylO4ilK7PpWBGTfAb5BXyOdB/JSrgD/0CO9s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a1J4iIpvprU/w0n7F6LlJp83hNQIJ6fY6v0BbCB2a1y1IwWtvshguY2g8s7DUOKfp
	 sOWyz6OgbIIUQq7ioC802qzOYY9UcBzlFmRywec73PLKwG9VZXP7sASSpBa6xNGj+S
	 LRhk+5eX2UlWfAowYz1vGPwAkUhBbYrZJBlgXlLoDAHeRDZpz5I5DzxhM0LuqveviX
	 Ya3eI9W+tAfQMrOyPMVf2Hy0Q82igDvDZYpUPUFULRHY0NrDFclPnQ2/9iIuLLVFBy
	 8u9974kb5Ba2xMYOcdhhK+9ZyOiMBZVTagEhSLmw14QX8e08DPMzEwNGM0Qes6fh7p
	 Z0NB0GiBSI8Kw==
From: Jiri Olsa <jolsa@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>
Subject: [PATCH bpf-next 1/4] selftests/bpf: Emit nop,nop5 instructions for x86_64 usdt probe
Date: Mon, 17 Nov 2025 09:35:48 +0100
Message-ID: <20251117083551.517393-2-jolsa@kernel.org>
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

We can currently optimize uprobes on top of nop5 instructions,
so application can define USDT_NOP to nop5 and use USDT macro
to define optimized usdt probes.

This works fine on new kernels, but could have performance penalty
on older kernels, that do not have the support to optimize and to
emulate nop5 instruction.

  execution of the usdt probe on top of nop:
  - nop -> trigger usdt -> emulate nop -> continue

  execution of the usdt probe on top of nop5:
  - nop5 -> trigger usdt -> single step nop5 -> continue

Note the 'single step nop5' as the source of performance regression.

To workaround that we change the USDT macro to emit nop,nop5 for
the probe (instead of default nop) and make record of that in
USDT record (more on that below).

This can be detected by application (libbpf) and it can place the
uprobe either on nop or nop5 based on the optimization support in
the kernel.

We make record of using the nop,nop5 instructions in the USDT ELF
note data.

Current elf note format is as follows:

  namesz (4B) | descsz (4B) | type (4B) | name | desc

And current usdt record (with "stapsdt" name) placed in the note's
desc data look like:

  loc_addr  | 8 bytes
  base_addr | 8 bytes
  sema_addr | 8 bytes
  provider  | zero terminated string
  name      | zero terminated string
  args      | zero terminated string

None of the tested parsers (bpftrace-bcc, libbpf) checked that the args
zero terminated byte is the actual end of the 'desc' data. As Andrii
suggested we could use this and place extra zero byte right there as an
indication for the parser we use the nop,nop5 instructions.

It's bit tricky, but the other way would be to introduce new elf note type
or note name and change all existing parsers to recognize it. With the change
above the existing parsers would still recognize such usdt probes.

Note we do not emit this extra byte if app defined its own nop through
USDT_NOP macro.

Suggested-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/testing/selftests/bpf/usdt.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/tools/testing/selftests/bpf/usdt.h b/tools/testing/selftests/bpf/usdt.h
index 549d1f774810..57fa2902136c 100644
--- a/tools/testing/selftests/bpf/usdt.h
+++ b/tools/testing/selftests/bpf/usdt.h
@@ -312,9 +312,16 @@ struct usdt_sema { volatile unsigned short active; };
 #ifndef USDT_NOP
 #if defined(__ia64__) || defined(__s390__) || defined(__s390x__)
 #define USDT_NOP			nop 0
+#elif defined(__x86_64__)
+#define USDT_NOP			.byte 0x90, 0x0f, 0x1f, 0x44, 0x00, 0x0 /* nop, nop5 */
 #else
 #define USDT_NOP			nop
 #endif
+#else
+/*
+ * User define its own nop instruction, do not emit extra note data.
+ */
+#define __usdt_asm_extra
 #endif /* USDT_NOP */
 
 /*
@@ -403,6 +410,15 @@ struct usdt_sema { volatile unsigned short active; };
 	__asm__ __volatile__ ("" :: "m" (sema));
 #endif
 
+#ifndef __usdt_asm_extra
+#ifdef __x86_64__
+#define __usdt_asm_extra									\
+	__usdt_asm1(            .ascii "\0")
+#else
+#define __usdt_asm_extra
+#endif
+#endif
+
 /* main USDT definition (nop and .note.stapsdt metadata) */
 #define __usdt_probe(group, name, sema_def, sema, ...) do {					\
 	sema_def(sema)										\
@@ -420,6 +436,7 @@ struct usdt_sema { volatile unsigned short active; };
 	__usdt_asm_strz(name)									\
 	__usdt_asm_args(__VA_ARGS__)								\
 	__usdt_asm1(		.ascii "\0")							\
+	__usdt_asm_extra									\
 	__usdt_asm1(994:	.balign 4)							\
 	__usdt_asm1(		.popsection)							\
 	__usdt_asm1(.ifndef _.stapsdt.base)							\
-- 
2.51.1


