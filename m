Return-Path: <bpf+bounces-64619-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2EB4B14C39
	for <lists+bpf@lfdr.de>; Tue, 29 Jul 2025 12:31:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E56B188CF41
	for <lists+bpf@lfdr.de>; Tue, 29 Jul 2025 10:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A70DA28C2C5;
	Tue, 29 Jul 2025 10:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BagLhifs"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 186D528C03A;
	Tue, 29 Jul 2025 10:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753785005; cv=none; b=WZJpHdu/eFxfas0s9vwAWBV1I+smFEm5E+zPO3H3yBDkra6RgH28ydiM4qUCrzDaVZK5vgnQpwGD1gr87AZkU7rkj/b3MXemEaXJ+a9L7NR46RseZtbo/ZHm0R+CscO8NH3aHFLz2NJxayQdL4O2nfvSgwVwHQUvTXCyB+npEXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753785005; c=relaxed/simple;
	bh=FPo8YQqOadYn1SLIdyIUhOdC1QxNA1+UX5dVUQRyf18=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=egUAz9uJLKXN1ut0Y5rfVsNcU0Hf7Ib+ZsdBnuCbZRXoK+k48d8m+1sYoEgS9Q0lPELWgzJOi8pN84LmyapprSd4rXMxDLXHq3E87bjk5sbV4eVTxDR7Tl51zwg0C0rqBfsA3vUa38jf5jr/S/YAhbggA+3kLU/Cc3O4LvEa3/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BagLhifs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8683C4CEEF;
	Tue, 29 Jul 2025 10:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753785004;
	bh=FPo8YQqOadYn1SLIdyIUhOdC1QxNA1+UX5dVUQRyf18=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BagLhifsVfRtRYe693MOPXaH0MDHVEcCsj/9+B5e1df1R4YGBcU7puY5o8QVWMWlO
	 bbEimocZrrSVVvnZtezyTDHAwm7PQq+T9WTbdDS5NUCirB8//xDfGdjfhxQIZ8iz9g
	 Ugl1Oe4veyFL9z7jKbZUMBh7YkkzUaQ8pQGTlgeX59XzZUvnzDlv8QtGOgulO+zlaD
	 oqRokKw6yTaXTq3qJSQcwr1VXf5uBCTPxlmpXRoJvdGshwIkYqZXjELI4pZXV+TEDp
	 oPfbVMS86b+4iNDkX6wQO57LzBqr5cql2YZmytGFmGLzIwmHvaVIShvrZgD3X/kB0L
	 +JubbS7ROZTRg==
From: Jiri Olsa <jolsa@kernel.org>
To: Steven Rostedt <rostedt@kernel.org>,
	Florent Revest <revest@google.com>,
	Mark Rutland <mark.rutland@arm.com>
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Menglong Dong <menglong8.dong@gmail.com>
Subject: [RFC 10/10] Revert "ftrace: Store direct called addresses in their ops"
Date: Tue, 29 Jul 2025 12:28:13 +0200
Message-ID: <20250729102813.1531457-11-jolsa@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250729102813.1531457-1-jolsa@kernel.org>
References: <20250729102813.1531457-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit dbaccb618fabde8b8596e341f8d76da63a9b0c2f.

Current code uses ip address to lookup the trampoline and we need the
ops to point multiple trampolines, hence this is no longer needed.

TODO this probably breaks arm.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 include/linux/ftrace.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 1a61f969550d..27b26a87231c 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -457,9 +457,6 @@ struct ftrace_ops {
 	struct list_head		subop_list;
 	ftrace_ops_func_t		ops_func;
 	struct ftrace_ops		*managed;
-#ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
-	unsigned long			direct_call;
-#endif
 #endif
 };
 
-- 
2.50.1


