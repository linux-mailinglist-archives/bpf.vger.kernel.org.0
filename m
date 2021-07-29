Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A27813DA5BC
	for <lists+bpf@lfdr.de>; Thu, 29 Jul 2021 16:10:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238117AbhG2OJg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 29 Jul 2021 10:09:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:57020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238651AbhG2OHd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 29 Jul 2021 10:07:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4EA5860F6F;
        Thu, 29 Jul 2021 14:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627567626;
        bh=PKI/11VUgofsqKtIxhbATROKObOP+Kwnqz32HDODdGE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Yp2Ss41CFX3w+aBnhv6DNWDEEn6ZVWQ00j3G4+8dZUskytxHPvb3E2MRAwoEJ44HP
         Y4/WzR/dQr7BeKPmhkmzacXk1A/GZn4bMIBfNQ1YCXfafj8k3xw5+gVRUm/tdSkIFi
         uhQHZz5xIADdPOGr0zKURE3JQwJtLeCJkB9E24qQhIRmsizq1xySTmEmWDuLhjfUlp
         1rBZSGj5AKQDBvWss3m7OHAMPYQRD7I+ZoWsMTEt/YSNLncpJ3x7RHn0/VZPwni4S1
         LQdfEhrrxlJsUDOgY0QRfRo52+34vyLqGYurM/4bXHpyl4XfyTjMklkgi4SD+Xe0cP
         6iNhYD3cKesaw==
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
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Subject: [PATCH -tip v10 07/16] objtool: Ignore unwind hints for ignored functions
Date:   Thu, 29 Jul 2021 23:07:01 +0900
Message-Id: <162756762128.301564.14921395970626566365.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <162756755600.301564.4957591913842010341.stgit@devnote2>
References: <162756755600.301564.4957591913842010341.stgit@devnote2>
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

