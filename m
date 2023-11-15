Return-Path: <bpf+bounces-14485-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B951A7E58AA
	for <lists+bpf@lfdr.de>; Wed,  8 Nov 2023 15:25:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 716972813A8
	for <lists+bpf@lfdr.de>; Wed,  8 Nov 2023 14:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB15319BCC;
	Wed,  8 Nov 2023 14:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pq/L0QIu"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5111D199AD;
	Wed,  8 Nov 2023 14:25:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F3B0C433C8;
	Wed,  8 Nov 2023 14:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699453500;
	bh=EOdwMS7vJXCXxyNePs9bFMY5mRinN5nN+9oKZfWkeWA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pq/L0QIuPS6c36rUuYEpModmDqSsMnMj6rd7FfSDmMmvsR83JA+1gr4f459TTHxaE
	 8jAfy8Ou3yT1rhtf+JaAXVd1xhKJdvDu0xARIIX9V7cprjH1FQF66QEbz6gWZf0HeL
	 BunIb/yDaukNxi0d4pw1/V4Mw7XGlDqsTPIZlM6aAxj8UNEqUjhipg2gQT942ZmTR/
	 6qiuajPQFF6fGWWjH6q6F5uTOXpkQ/V4ESTNCi40qFiYNCVHy4rrYq1WtCGvb9o0es
	 6PlH5SyM6OFH8kMGz7OmJaIRQ5ceAiG4VzLCdC8GAczMG/geWRTKNfkgb2dkdmP/oW
	 pvPodc8wJtmBg==
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
Subject: [RFC PATCH v2 03/31] seq_buf: Export seq_buf_puts()
Date: Wed,  8 Nov 2023 23:24:55 +0900
Message-Id: <169945349504.55307.11956579566800344063.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <169945345785.55307.5003201137843449313.stgit@devnote2>
References: <169945345785.55307.5003201137843449313.stgit@devnote2>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Mark seq_buf_puts() which is part of the seq_buf API to be exported to
kernel loadable GPL modules.

Link: https://lkml.kernel.org/r/b9e3737f66ec2450221b492048ce0d9c65c84953.1698861216.git.christophe.jaillet@wanadoo.fr

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 lib/seq_buf.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/seq_buf.c b/lib/seq_buf.c
index 45c450f423fa..46a1b00c3815 100644
--- a/lib/seq_buf.c
+++ b/lib/seq_buf.c
@@ -189,6 +189,7 @@ int seq_buf_puts(struct seq_buf *s, const char *str)
 	seq_buf_set_overflow(s);
 	return -1;
 }
+EXPORT_SYMBOL_GPL(seq_buf_puts);
 
 /**
  * seq_buf_putc - sequence printing of simple character


