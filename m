Return-Path: <bpf+bounces-28439-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 297D28B9AD3
	for <lists+bpf@lfdr.de>; Thu,  2 May 2024 14:25:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8D5D284DA6
	for <lists+bpf@lfdr.de>; Thu,  2 May 2024 12:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C764384A54;
	Thu,  2 May 2024 12:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NkiS0twE"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4289D7F481;
	Thu,  2 May 2024 12:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714652687; cv=none; b=Zk6ucTsmduAYMLNCwFfkdvN13YEmbWUQeGirSLhW6cDqfiAwEe0vXzVSMm1y9E4dDg+UZcdlyhQzm6dUd30QdpjJRjXcUYqc4c7yEdZKt1qpV6btmEdToWgzu1sLESwEju3siqD7FN+JB84eeXZqaPvIDDqfGW48vpkQgGaMIPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714652687; c=relaxed/simple;
	bh=IxSJTvmJyyluDOgbN3Qv5eq4m8dBC+x6ly4U5xSNfi8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BMRdLeshHT1NlQDhlNocuzxMiz6W63wJf7M5SBh3ilm0LGFbY4KoWpQ8KfomaGn19ECPu7BDXvUqccM4T33GREdN9oaCXzA4nlQtqSB8dT+XRTP1G8OOHwIwb9lgNreLCm5UT5tOZvu8rvI9BGKH/v9Ct9fvGewxZJWn7JuBpOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NkiS0twE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11B3CC113CC;
	Thu,  2 May 2024 12:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714652686;
	bh=IxSJTvmJyyluDOgbN3Qv5eq4m8dBC+x6ly4U5xSNfi8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NkiS0twE1DcVIJty0dIiyfLue//ziLF3Br/jp/DRl4zBOr4neTnq8rTX1yTUdGXcB
	 GEtXJnpJCRqAfn78vy1MPxMH2nr7ogcHv+OXLZTKquohizzO7Ma13iOiA/njI+AaCG
	 wCi5qvXE2KpVNQ/FzlDGAqytSftpjCBpmDZhU6VxS9eGH1hJW5eFgy6/vIAfPSwUQc
	 TwdkyCATEmtDutDB60ihVBEfqj64oiO3Qa4LcjPtR+VVU+1u6mQ7nz1ea7Zn7+E1BY
	 sUrwuJjfyUFuRujYAOIelYTj3V1RLXNaiH7bBVdWvBR37I4c4UexTy9gctjYija7UE
	 jKGmdjuy8XGtA==
From: Jiri Olsa <jolsa@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-api@vger.kernel.org,
	linux-man@vger.kernel.org,
	x86@kernel.org,
	bpf@vger.kernel.org,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Ingo Molnar <mingo@redhat.com>,
	Andy Lutomirski <luto@kernel.org>
Subject: [PATCHv4 7/7] man2: Add uretprobe syscall page
Date: Thu,  2 May 2024 14:23:13 +0200
Message-ID: <20240502122313.1579719-8-jolsa@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240502122313.1579719-1-jolsa@kernel.org>
References: <20240502122313.1579719-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding man page for new uretprobe syscall.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 man2/uretprobe.2 | 45 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)
 create mode 100644 man2/uretprobe.2

diff --git a/man2/uretprobe.2 b/man2/uretprobe.2
new file mode 100644
index 000000000000..08fe6a670430
--- /dev/null
+++ b/man2/uretprobe.2
@@ -0,0 +1,45 @@
+.\" Copyright (C) 2024, Jiri Olsa <jolsa@kernel.org>
+.\"
+.\" SPDX-License-Identifier: Linux-man-pages-copyleft
+.\"
+.TH uretprobe 2 (date) "Linux man-pages (unreleased)"
+.SH NAME
+uretprobe \- execute pending return uprobes
+.SH SYNOPSIS
+.nf
+.B int uretprobe(void)
+.fi
+.SH DESCRIPTION
+Kernel is using
+.BR uretprobe()
+syscall to trigger uprobe return probe consumers instead of using
+standard breakpoint instruction.
+
+The uretprobe syscall is not supposed to be called directly by user, it's allowed
+to be invoked only through user space trampoline provided by kernel.
+When called from outside of this trampoline, the calling process will receive
+.BR SIGILL .
+
+.SH RETURN VALUE
+.BR uretprobe()
+return value is specific for given architecture.
+
+.SH VERSIONS
+This syscall is not specified in POSIX,
+and details of its behavior vary across systems.
+.SH STANDARDS
+None.
+.SH NOTES
+.BR uretprobe()
+syscall is initially introduced on x86-64 architecture, because doing syscall
+is faster than doing breakpoint trap on it. It might be extended to other
+architectures.
+
+.BR uretprobe()
+syscall exists only to allow the invocation of return uprobe consumers.
+It should
+.B never
+be called directly.
+Details of the arguments (if any) passed to
+.BR uretprobe ()
+and the return value are specific for given architecture.
-- 
2.44.0


