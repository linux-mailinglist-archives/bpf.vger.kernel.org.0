Return-Path: <bpf+bounces-47893-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AE36A01A6F
	for <lists+bpf@lfdr.de>; Sun,  5 Jan 2025 17:22:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C37E03A2E9F
	for <lists+bpf@lfdr.de>; Sun,  5 Jan 2025 16:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A99E61B21AB;
	Sun,  5 Jan 2025 16:22:21 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F3A181CFD;
	Sun,  5 Jan 2025 16:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736094141; cv=none; b=ciVN+2eOnlYYJNQIdzyXBL7xaSHLzRobxcPaW7SswvPQaAOmdX6ZV46ExmifZgllyyRgSwxF+PS1KZp0i4Ff/M/knWzCB+chuNpY9ULMh57G44jNTWbg1SETw1IPPr1QZGfrISS0BsCu+3/DTCNnv+ikvgHXfY+BbkMrQysUjuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736094141; c=relaxed/simple;
	bh=vpefdYnotZYqFb3OuaEaxQCVmosOhU+jvix41HPEufg=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=iU3N6gmhZqgc3QLY5xiSjY2TLFeAPXPwoSs/8ZO+VHFvSEz/5js0+rH07K9V6zclaDfutSG3sfiDuuYaNG+WFfJ/BjsewhZlquc5OWj3LaiLFBt+9uqP7p+Lpr5qhugEht7NM2eLR6niSl9CNUDAyht1wT4uLafVw8s2Nvrvp2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF460C4CEE9;
	Sun,  5 Jan 2025 16:22:20 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tUTPk-00000008Esa-3ro5;
	Sun, 05 Jan 2025 11:23:44 -0500
Message-ID: <20250105162344.721480386@goodmis.org>
User-Agent: quilt/0.68
Date: Sun, 05 Jan 2025 11:22:15 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org,
 linux-kbuild@vger.kernel.org,
 bpf <bpf@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Masahiro Yamada <masahiroy@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>,
 Nicolas Schier <nicolas@fjasle.eu>,
 Zheng Yejian <zhengyejian1@huawei.com>,
 Martin  Kelly <martin.kelly@crowdstrike.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [PATCH 04/14] scripts/sorttable: Have the ORC code use the _r() functions to read
References: <20250105162211.971039541@goodmis.org>
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



