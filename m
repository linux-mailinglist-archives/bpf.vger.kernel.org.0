Return-Path: <bpf+bounces-21346-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A18784B946
	for <lists+bpf@lfdr.de>; Tue,  6 Feb 2024 16:22:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26EC52914C4
	for <lists+bpf@lfdr.de>; Tue,  6 Feb 2024 15:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F298713C1DB;
	Tue,  6 Feb 2024 15:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D9RTYE2r"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75098133432;
	Tue,  6 Feb 2024 15:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707232433; cv=none; b=V3TOQug9Ug5HdB7vdJO1qWcBG348rrWvVKVdRFPWHF6kghrSkir1kGn4N74sg7gdgicZPkiyJkjkqWT7UDWGLlsHTau7Xezr4wNu5fgqbr5B1pIETH5+ov7N9oRCxtKc3WbzGMFovEQ1DAVlPgMHQz1TkIDwtci0k33jQHHa8Mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707232433; c=relaxed/simple;
	bh=AhqKrJz5NqAxQZJTxzvS35/o9mTQRDXLSjKOCvX5P6o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NwIsWq2obpNmKei22Aww1/3qB2gPtZ7TYLqG3qqQKa4ImKWxQV78DNfebXHvSrE9Zjb5389Ionm7WPFtqCbIdk+qUfUeyEsGz2Ctyui3jyGLvf4HHTPeXyYhUYJDo0GOM80XIzez2erHeSoybSg5hL9RwTXVT92kr89pCaNwt/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D9RTYE2r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 432A2C433C7;
	Tue,  6 Feb 2024 15:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707232433;
	bh=AhqKrJz5NqAxQZJTxzvS35/o9mTQRDXLSjKOCvX5P6o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D9RTYE2rucHhwjfXu5vYc7a/lKZrG1OEFTu3RxUQe9O1kV1sEL7ZTgjAUtjlkJXlI
	 SAQi6Q0dpZAFRuGIna2o4T9/63f9sz6b1kLXqNUv3CUgCKD+rz8ntl38VXFBTwuQvq
	 Uot4bN+NSUdc3127XooI+id/bYzOUZM/6TJHDMZ/2qD5wkc9hWEvv1MDDHM57uhrK1
	 ZR5XTXBkUpitJ9lprIqDB9dnE90FXUQLveEthaVMm1Es/yEl95zYLez21/wmFfDb/m
	 mh4wOdFMAH26Y+dTZgaCul1kDuZZHuZPEmHg56R08bNZ5qy04udC6xWGTlLN9FWaNX
	 cLq/yltWbMwUA==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Florent Revest <revest@chromium.org>
Cc: linux-trace-kernel@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	bpf <bpf@vger.kernel.org>,
	Sven Schnelle <svens@linux.ibm.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alan Maguire <alan.maguire@oracle.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Guo Ren <guoren@kernel.org>
Subject: [PATCH v7 34/36] selftests: ftrace: Remove obsolate maxactive syntax check
Date: Wed,  7 Feb 2024 00:13:48 +0900
Message-Id: <170723242825.502590.11677076282887486945.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <170723204881.502590.11906735097521170661.stgit@devnote2>
References: <170723204881.502590.11906735097521170661.stgit@devnote2>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Since the fprobe event does not support maxactive anymore, stop
testing the maxactive syntax error checking.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 .../ftrace/test.d/dynevent/fprobe_syntax_errors.tc |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/fprobe_syntax_errors.tc b/tools/testing/selftests/ftrace/test.d/dynevent/fprobe_syntax_errors.tc
index 20e42c030095..66516073ff27 100644
--- a/tools/testing/selftests/ftrace/test.d/dynevent/fprobe_syntax_errors.tc
+++ b/tools/testing/selftests/ftrace/test.d/dynevent/fprobe_syntax_errors.tc
@@ -16,9 +16,7 @@ aarch64)
   REG=%r0 ;;
 esac
 
-check_error 'f^100 vfs_read'		# MAXACT_NO_KPROBE
-check_error 'f^1a111 vfs_read'		# BAD_MAXACT
-check_error 'f^100000 vfs_read'		# MAXACT_TOO_BIG
+check_error 'f^100 vfs_read'		# BAD_MAXACT
 
 check_error 'f ^non_exist_func'		# BAD_PROBE_ADDR (enoent)
 check_error 'f ^vfs_read+10'		# BAD_PROBE_ADDR


