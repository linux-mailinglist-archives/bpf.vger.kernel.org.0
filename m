Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8266426660
	for <lists+bpf@lfdr.de>; Fri,  8 Oct 2021 11:13:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235706AbhJHJPl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 8 Oct 2021 05:15:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60413 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235819AbhJHJPk (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 8 Oct 2021 05:15:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633684425;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t8XYUgR9kHcOYFdSNrWNV6bYolumP9ymhRdSASBvoKM=;
        b=NvEV3wvzZGZ4sG2PhwJMZJozhTmoMRzYiJxYq7m78HbBGfeBIYfi3fBbq6IuaFujgKEjGe
        3jdcv2iJSFs/wIH6+2Zuh2SIU1nmDYdG77ngb+ThxfhMwJQGRz+1Au2k5TxkeqPnLhs/gn
        +E+9Osxuznz9QM+IbGjtTD93CDb+KJI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-459-GBpginFRMAWEJPG0WcOUIg-1; Fri, 08 Oct 2021 05:13:44 -0400
X-MC-Unique: GBpginFRMAWEJPG0WcOUIg-1
Received: by mail-wr1-f69.google.com with SMTP id d13-20020adf9b8d000000b00160a94c235aso6810529wrc.2
        for <bpf@vger.kernel.org>; Fri, 08 Oct 2021 02:13:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=t8XYUgR9kHcOYFdSNrWNV6bYolumP9ymhRdSASBvoKM=;
        b=d1WC9KothNPwQFOBQ5Iw6cCf/LG/zOTz3Lp/ufE4dWGj4sBmfl1tbIw5505eOecAG8
         ZyP09FQQHzW2XFl//BPAy7y8gHZ1v3703iiNcnVi4Ih7XnZsVGaJDFKPX5eTK/Alk1Wy
         trb8H9XerFpCnyZFWBShaxlm4WfU9LHu1h8gHyCf8k5nnFJzUL/sWupBPVHyfbwTjote
         BaK8rpZxHFeg1Nah4tGC196Enzk4dII7i+6XWO2m3veWfJLDmNJf7Zque6t9zO1Z7glL
         l56r4REsGigshV/ZqfO+i8mWRY6jLEleKYm5o7d20ZgI6isg8BRcYjga6GxpDnUafc+5
         e82g==
X-Gm-Message-State: AOAM532DhlCY3Qfbzfh0EGpgA5pQ3w7+i87tJaH05xw6KNB6i1d9TNhV
        qWsoFCdNH/3+mGSMcC+KfxjA40Xvnez5UCyQ1JQdqEJO2VuP2gqC6HmZZdCLQ4VU7oQHRKTzBQp
        7cWufOay26im7
X-Received: by 2002:adf:8b1a:: with SMTP id n26mr2553757wra.182.1633684423778;
        Fri, 08 Oct 2021 02:13:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx7pqH/9VGiNhSSQLuJGc71f9A4S88upuxhvoibmjXrXfdo84xNDH3ZpV69N8QYUBNTaQgOdQ==
X-Received: by 2002:adf:8b1a:: with SMTP id n26mr2553740wra.182.1633684423641;
        Fri, 08 Oct 2021 02:13:43 -0700 (PDT)
Received: from krava.redhat.com (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id g25sm1822738wrc.88.2021.10.08.02.13.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 02:13:43 -0700 (PDT)
From:   Jiri Olsa <jolsa@redhat.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
To:     "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>
Subject: [PATCH 1/8] x86/ftrace: Remove extra orig rax move
Date:   Fri,  8 Oct 2021 11:13:29 +0200
Message-Id: <20211008091336.33616-2-jolsa@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211008091336.33616-1-jolsa@kernel.org>
References: <20211008091336.33616-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

There's identical move 2 lines earlier.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 arch/x86/kernel/ftrace_64.S | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/kernel/ftrace_64.S b/arch/x86/kernel/ftrace_64.S
index 7c273846c687..a8eb084a7a9a 100644
--- a/arch/x86/kernel/ftrace_64.S
+++ b/arch/x86/kernel/ftrace_64.S
@@ -251,7 +251,6 @@ SYM_INNER_LABEL(ftrace_regs_call, SYM_L_GLOBAL)
 	 * If ORIG_RAX is anything but zero, make this a call to that.
 	 * See arch_ftrace_set_direct_caller().
 	 */
-	movq ORIG_RAX(%rsp), %rax
 	testq	%rax, %rax
 SYM_INNER_LABEL(ftrace_regs_caller_jmp, SYM_L_GLOBAL)
 	jnz	1f
-- 
2.31.1

