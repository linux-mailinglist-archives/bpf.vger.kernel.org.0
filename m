Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79A27426662
	for <lists+bpf@lfdr.de>; Fri,  8 Oct 2021 11:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236070AbhJHJPr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 8 Oct 2021 05:15:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:46857 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235847AbhJHJPr (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 8 Oct 2021 05:15:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633684431;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eqAj4ZrmrtKDThZEc8WrAKFFOfUsJKx4HE/+LaO0ups=;
        b=AWPM/0dJV6o4t4FM7esqEkgvfUfAx3yN2UoiW1bGjGEAHTKUnaKcJ/xa/RFlUSyTwuXj5w
        xkzvOw8Vd78XvFAbI7wnvnwZN4ZAlGTl+ButRGqJPYhzMGttiqzFBSfrLGqDMxCcoIXSMm
        3yZp6q1cL4sFHpziQlEcaKLBXA1V4/k=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-218-GIGKOTafOwS_8GgpMbbU9g-1; Fri, 08 Oct 2021 05:13:51 -0400
X-MC-Unique: GIGKOTafOwS_8GgpMbbU9g-1
Received: by mail-wr1-f70.google.com with SMTP id p12-20020adfc38c000000b00160d6a7e293so4314875wrf.18
        for <bpf@vger.kernel.org>; Fri, 08 Oct 2021 02:13:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eqAj4ZrmrtKDThZEc8WrAKFFOfUsJKx4HE/+LaO0ups=;
        b=zO9CU6R/PvZ/nDWgoc65IxH+842vDUY3ekMjAvTQst/yLNF2stjHqAI65AhKQ5iSz4
         uTXTyXxN0PXOLiitjewEyXMVVywsVu6L6vsnGDHJeJA8mvX65rq7oRsp9sQwgmotNIQW
         t5ySB0/OVK7zjSRQPwXPx0F+DK6GF+oYdXpN1t4xPczI+UrSqov8WA6w74gT7KpQjEBs
         5dwZn6CFnEur/iEVZ7PZm7AYzLktBxpcH7JKs+eDkAm1yB0wMU+L6NjAXjuvm7y9/gbX
         cuLwMgLGJgoN+/7cz8zwkAA8vmu//C1p5jIMlizpFlbtM39WfI8R+vuDlA1dcf42joGq
         eD8w==
X-Gm-Message-State: AOAM530POei4trPC+auLu8c9myeVPV/A6bE8nUlm1ZEr+hUu0o/VQVAA
        YWsT63o70T+5OvjZ89eY42n58bx6ewcliBp/qHL0jNKQ20680XWE5ka3nb+RG3m255MinF4d98s
        s/7mPDA6Gan82
X-Received: by 2002:adf:bc48:: with SMTP id a8mr2596059wrh.397.1633684429747;
        Fri, 08 Oct 2021 02:13:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw+TIty7irIaIflePLhh/gHbVH4LIWV87ZMOeBrKD6N733Xj1c4RMbUdKNhdpfkePK8v0WAOQ==
X-Received: by 2002:adf:bc48:: with SMTP id a8mr2596045wrh.397.1633684429598;
        Fri, 08 Oct 2021 02:13:49 -0700 (PDT)
Received: from krava.redhat.com (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id q7sm1884016wrs.73.2021.10.08.02.13.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 02:13:49 -0700 (PDT)
From:   Jiri Olsa <jolsa@redhat.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
To:     "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>
Subject: [PATCH 2/8] x86/ftrace: Remove fault protection code in prepare_ftrace_return
Date:   Fri,  8 Oct 2021 11:13:30 +0200
Message-Id: <20211008091336.33616-3-jolsa@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211008091336.33616-1-jolsa@kernel.org>
References: <20211008091336.33616-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

Removing the fault protection code when writing return_hooker
to stack. As Steven noted:

> That protection was there from the beginning due to being "paranoid",
> considering ftrace was bricking network cards. But that protection
> would not have even protected against that.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 arch/x86/kernel/ftrace.c | 38 +++-----------------------------------
 1 file changed, 3 insertions(+), 35 deletions(-)

diff --git a/arch/x86/kernel/ftrace.c b/arch/x86/kernel/ftrace.c
index 1b3ce3b4a2a2..c555624da989 100644
--- a/arch/x86/kernel/ftrace.c
+++ b/arch/x86/kernel/ftrace.c
@@ -625,12 +625,10 @@ int ftrace_disable_ftrace_graph_caller(void)
  * Hook the return address and push it in the stack of return addrs
  * in current thread info.
  */
-void prepare_ftrace_return(unsigned long self_addr, unsigned long *parent,
+void prepare_ftrace_return(unsigned long ip, unsigned long *parent,
 			   unsigned long frame_pointer)
 {
 	unsigned long return_hooker = (unsigned long)&return_to_handler;
-	unsigned long old;
-	int faulted;
 
 	/*
 	 * When resuming from suspend-to-ram, this function can be indirectly
@@ -650,37 +648,7 @@ void prepare_ftrace_return(unsigned long self_addr, unsigned long *parent,
 	if (unlikely(atomic_read(&current->tracing_graph_pause)))
 		return;
 
-	/*
-	 * Protect against fault, even if it shouldn't
-	 * happen. This tool is too much intrusive to
-	 * ignore such a protection.
-	 */
-	asm volatile(
-		"1: " _ASM_MOV " (%[parent]), %[old]\n"
-		"2: " _ASM_MOV " %[return_hooker], (%[parent])\n"
-		"   movl $0, %[faulted]\n"
-		"3:\n"
-
-		".section .fixup, \"ax\"\n"
-		"4: movl $1, %[faulted]\n"
-		"   jmp 3b\n"
-		".previous\n"
-
-		_ASM_EXTABLE(1b, 4b)
-		_ASM_EXTABLE(2b, 4b)
-
-		: [old] "=&r" (old), [faulted] "=r" (faulted)
-		: [parent] "r" (parent), [return_hooker] "r" (return_hooker)
-		: "memory"
-	);
-
-	if (unlikely(faulted)) {
-		ftrace_graph_stop();
-		WARN_ON(1);
-		return;
-	}
-
-	if (function_graph_enter(old, self_addr, frame_pointer, parent))
-		*parent = old;
+	if (!function_graph_enter(*parent, ip, frame_pointer, parent))
+		*parent = return_hooker;
 }
 #endif /* CONFIG_FUNCTION_GRAPH_TRACER */
-- 
2.31.1

