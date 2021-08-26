Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53CB23F8ED2
	for <lists+bpf@lfdr.de>; Thu, 26 Aug 2021 21:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243464AbhHZTk0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 26 Aug 2021 15:40:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45680 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243407AbhHZTk0 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 26 Aug 2021 15:40:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630006778;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eqAj4ZrmrtKDThZEc8WrAKFFOfUsJKx4HE/+LaO0ups=;
        b=Aqv01lJYjYD8nAuWAlTu4/fQk5EYYnyoRW2U3cBdRoPozjUCJ6H9tvdwQ2DnaI6f/M7aq2
        /NbrS0Hy8uBgYpuj8lPnG1vzD/xiSpk3R/Pmd+92Gcr/MiNXf4l7CzH/fq26ZuN54bPacb
        uWXiBzIkRpqPXZRJVKMat6wLY+ygHC4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-581-tyq5BFi2ONOjT_0mX_RgOw-1; Thu, 26 Aug 2021 15:39:37 -0400
X-MC-Unique: tyq5BFi2ONOjT_0mX_RgOw-1
Received: by mail-wm1-f71.google.com with SMTP id k5-20020a7bc3050000b02901e081f69d80so1265214wmj.8
        for <bpf@vger.kernel.org>; Thu, 26 Aug 2021 12:39:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eqAj4ZrmrtKDThZEc8WrAKFFOfUsJKx4HE/+LaO0ups=;
        b=TWOimxMPNJCawK0+tbcQHSt2/aRx/YIuyh1tZRbS38i3RtXhhbDLtTyNSAbHpBw6hz
         nWvRl/SarE00QGcCmtzzUvxd3oMe8lAG+jo0vPffWNQSZc4OmruOAjUS5rjCXyzJxjM0
         LCfAXVcTB3p2WRQhoXYVKyYqoLlOWDVkx9LDXmMgzVu2mpWWx4bJERcpV4O3kwJ1XC1G
         DJ78mI3IB02CDsdnEhmWsUmYcXDCCtbJbMHDZTHxaAbL7q1EKRw6DY+z7/nBgMdXqVpG
         DQn0zLPrrC9sVtg7L0etr/LGCqAL/4oqdy0leVaoz4xGkvvmrpqZ0KOrQbyu0KYIQ364
         vuCQ==
X-Gm-Message-State: AOAM530LYVmalrfzmpzbNczVaWqnPL+wNC//vVk4shmBwgrx+ebgLyAc
        mPCXOQp887RUE02txkOjbWfyqStvaql9IU2+9kmRHOjjix7eFhu/uvgFwWCLJFaes0aon/xkI+O
        YGxClR9d9LfBw
X-Received: by 2002:a5d:664b:: with SMTP id f11mr5900058wrw.39.1630006776008;
        Thu, 26 Aug 2021 12:39:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJynG5QoqDJvteuV2aFyjTpD5oRelW0Ocw2434p+kHB3WTHEdIOLbOwZ+xN6eQOLJnZF/BgGeQ==
X-Received: by 2002:a5d:664b:: with SMTP id f11mr5900047wrw.39.1630006775853;
        Thu, 26 Aug 2021 12:39:35 -0700 (PDT)
Received: from krava.redhat.com ([83.240.63.86])
        by smtp.gmail.com with ESMTPSA id o5sm3981177wrw.17.2021.08.26.12.39.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Aug 2021 12:39:35 -0700 (PDT)
From:   Jiri Olsa <jolsa@redhat.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>, Daniel Xu <dxu@dxuuu.xyz>,
        Viktor Malik <vmalik@redhat.com>
Subject: [PATCH bpf-next v4 02/27] x86/ftrace: Remove fault protection code in prepare_ftrace_return
Date:   Thu, 26 Aug 2021 21:38:57 +0200
Message-Id: <20210826193922.66204-3-jolsa@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210826193922.66204-1-jolsa@kernel.org>
References: <20210826193922.66204-1-jolsa@kernel.org>
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

