Return-Path: <bpf+bounces-47967-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C55CAA02D84
	for <lists+bpf@lfdr.de>; Mon,  6 Jan 2025 17:17:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4827B3A4ADB
	for <lists+bpf@lfdr.de>; Mon,  6 Jan 2025 16:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD6C41DE4F3;
	Mon,  6 Jan 2025 16:17:20 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 457EB17799F;
	Mon,  6 Jan 2025 16:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736180240; cv=none; b=afq/HJyMjof2cPoqWuPTW5t7/gA5cM/MlbnuzYGP32tY3ZI4CTC5i+j8YcqZqwGbDC85yAcqKfOe9LsU5vZRkq+AUDxVNgaDp12F0MuXBnh+g5xEAMmtBNKeGkDLiA6CcqW4CgeEgLxnR5yTR2bMQ7yrstz1zHX9lqoUvjHo5PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736180240; c=relaxed/simple;
	bh=DQ7EH9i23/yGs3Y8LsmMVcN0j+K2pY6jjjeIMnUKv60=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=uFFhTyCvPbFnSkVDjzEv7D8KGOI25FyIZCAfMmgthRh0u0b4Lrwu3dnlwwop237/hV+V85QaV8U05OYt0vfJinkwYnbBgu4juPRx57Wca/aFuKwjLIYALwk8yyiu+dpqDZqQr1g420znASmYc/j17nztQN1qVXQm6PLl5KVbMCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16978C4CEEC;
	Mon,  6 Jan 2025 16:17:20 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tUpoU-00000009J0m-2hSS;
	Mon, 06 Jan 2025 11:18:46 -0500
Message-ID: <20250106161846.492818648@goodmis.org>
User-Agent: quilt/0.68
Date: Mon, 06 Jan 2025 11:17:30 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 bpf <bpf@vger.kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Masahiro Yamada <masahiroy@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>,
 Nicolas Schier <nicolas@fjasle.eu>,
 Zheng Yejian <zhengyejian1@huawei.com>,
 Martin  Kelly <martin.kelly@crowdstrike.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [for-next][PATCH 04/14] scripts/sorttable: Have the ORC code use the _r() functions to read
References: <20250106161726.131794583@goodmis.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

The ORC code reads the section information directly from the file. This
currently works because the default read function is for 64bit little
endian machines. But if for some reason that ever changes, this will
break. Instead of having a surprise breakage, use the _r() functions that
will read the values from the file properly.

Cc: bpf <bpf@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Nicolas Schier <nicolas@fjasle.eu>
Cc: Zheng Yejian <zhengyejian1@huawei.com>
Cc: Martin  Kelly <martin.kelly@crowdstrike.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lore.kernel.org/20250105162344.721480386@goodmis.org
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 scripts/sorttable.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/scripts/sorttable.h b/scripts/sorttable.h
index aa7a8499a516..7c06a754e31a 100644
--- a/scripts/sorttable.h
+++ b/scripts/sorttable.h
@@ -296,14 +296,14 @@ static int do_sort(Elf_Ehdr *ehdr,
 #if defined(SORTTABLE_64) && defined(UNWINDER_ORC_ENABLED)
 		/* locate the ORC unwind tables */
 		if (!strcmp(secstrings + idx, ".orc_unwind_ip")) {
-			orc_ip_size = s->sh_size;
+			orc_ip_size = _r(&s->sh_size);
 			g_orc_ip_table = (int *)((void *)ehdr +
-						   s->sh_offset);
+						   _r(&s->sh_offset));
 		}
 		if (!strcmp(secstrings + idx, ".orc_unwind")) {
-			orc_size = s->sh_size;
+			orc_size = _r(&s->sh_size);
 			g_orc_table = (struct orc_entry *)((void *)ehdr +
-							     s->sh_offset);
+							     _r(&s->sh_offset));
 		}
 #endif
 	} /* for loop */
-- 
2.45.2



