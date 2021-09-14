Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCF1840B1A2
	for <lists+bpf@lfdr.de>; Tue, 14 Sep 2021 16:42:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234997AbhINOng (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Sep 2021 10:43:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:36700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233874AbhINOmo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Sep 2021 10:42:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id ABA73610CE;
        Tue, 14 Sep 2021 14:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631630487;
        bh=PKI/11VUgofsqKtIxhbATROKObOP+Kwnqz32HDODdGE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HGB87MJ7+KwchYoMM7AajMZQOrGm+n2sGKRCRgQaV0TA71beLJbLmYmhmukbaRzWu
         dYizsIBQaaqf9Bvhf4hFGnG/FGyS8yEAR/0q1dwxO4JtyyYpO3OWtjpl7Od+XH7acW
         i4rtdvKrKpnuKwCXcss6R/XeWIgxGCjrlEZCzzR1lBg4xTwa3Y2ERU9thHexdZMtb9
         g9ISYfQtB5U2FtkmHlDutf3f3gehA+1RWccApUbfQ+5b/+mqOT71fmcahDU/AacFB0
         TyIoKyl5QBOHWl29SnfUpjOI9uPtvOgiFUwlGYKjcQt6uw1VhCWQWDaO/dmvwon7HD
         AxnmZS4mHkm3g==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@kernel.org>
Cc:     X86 ML <x86@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>,
        Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, kuba@kernel.org, mingo@redhat.com,
        ast@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>, kernel-team@fb.com,
        yhs@fb.com, linux-ia64@vger.kernel.org,
        Abhishek Sagar <sagar.abhishek@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Paul McKenney <paulmck@kernel.org>
Subject: [PATCH -tip v11 18/27] objtool: Ignore unwind hints for ignored functions
Date:   Tue, 14 Sep 2021 23:41:23 +0900
Message-Id: <163163048317.489837.10988954983369863209.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <163163030719.489837.2236069935502195491.stgit@devnote2>
References: <163163030719.489837.2236069935502195491.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Josh Poimboeuf <jpoimboe@redhat.com>

If a function is ignored, also ignore its hints.  This is useful for the
case where the function ignore is conditional on frame pointers, e.g.
STACK_FRAME_NON_STANDARD_FP().

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
Tested-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 tools/objtool/check.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index e5947fbb9e7a..67cbdcfcabae 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2909,7 +2909,7 @@ static int validate_unwind_hints(struct objtool_file *file, struct section *sec)
 	}
 
 	while (&insn->list != &file->insn_list && (!sec || insn->sec == sec)) {
-		if (insn->hint && !insn->visited) {
+		if (insn->hint && !insn->visited && !insn->ignore) {
 			ret = validate_branch(file, insn->func, insn, state);
 			if (ret && backtrace)
 				BT_FUNC("<=== (hint)", insn);

