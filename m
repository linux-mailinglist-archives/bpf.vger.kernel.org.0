Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0089F3FC523
	for <lists+bpf@lfdr.de>; Tue, 31 Aug 2021 11:53:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240662AbhHaJvo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 31 Aug 2021 05:51:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:49627 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234216AbhHaJvW (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 31 Aug 2021 05:51:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630403427;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t8XYUgR9kHcOYFdSNrWNV6bYolumP9ymhRdSASBvoKM=;
        b=ZE15u+td5r1mW2/OqEBqoALMSlkl9lFGXp+G6nqsqryGxJy9RS1ryjPcNenslW+WLPi1LG
        SmMkKa/uLaELj8ETAdWBl6vGIlDAvWXZiUIiDLouyBstahbcaa2PkBSTzRzvMLnN3YIGd5
        4ufHCfgLN45XtT3h53F0AZl8RpFyXO0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-334-oZH62Jt-NXWGuTl8f_KSZw-1; Tue, 31 Aug 2021 05:50:26 -0400
X-MC-Unique: oZH62Jt-NXWGuTl8f_KSZw-1
Received: by mail-wm1-f72.google.com with SMTP id k5-20020a7bc3050000b02901e081f69d80so5761740wmj.8
        for <bpf@vger.kernel.org>; Tue, 31 Aug 2021 02:50:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=t8XYUgR9kHcOYFdSNrWNV6bYolumP9ymhRdSASBvoKM=;
        b=lSEXU5OTmoJy1VpsacSAjJJpviWPp6iqtnIwOOmK0Ma9SkC2QthXi6cN4c7R/URyTP
         p5ymL2hhuBjycOeOiVtGDr570NfK3KMdeM94HgHvuoreuGhACECJGvxgptWQSjx50Ham
         IBZmLI8PacUwsEN8FKllfjaAu9eEF6EtmA8tQNp0fwZ/KwQbZGMELVSdYc49V1NSkqlp
         6QjSpJgsn7Ws0kMzJkNbuY/1KMPgdm6DfRCJRB6f2kGm7mby7aMGfgQekwFYIZahAlry
         umJAYP54iZT6pbK7xbInkTrF7R5915iZdrx1xfK55UFZDLUAl9EjH1iFYlDpmMFX7NsW
         JBvw==
X-Gm-Message-State: AOAM531XxywxLs9YUxGhsh+taS3nLAu8O+oAHD19+MeJc3OQqE3KuvIX
        5uHk9+zaN3Mt8w7WeaqQY3kcDoE8vaRQxMJFKIy703lduzALjcJsFXMfT05r4jkqjpzbbDy4KiE
        68D1NZIWP2iBt
X-Received: by 2002:a05:600c:a08:: with SMTP id z8mr3237222wmp.52.1630403424876;
        Tue, 31 Aug 2021 02:50:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwmw4QOsPrdbgK9ka9SXfqxCs3jTWhJePp5bIWBfxduD2YjHbSYNsMxcmqk6mS4WTpJhWp5+w==
X-Received: by 2002:a05:600c:a08:: with SMTP id z8mr3237201wmp.52.1630403424699;
        Tue, 31 Aug 2021 02:50:24 -0700 (PDT)
Received: from krava.redhat.com ([94.113.247.3])
        by smtp.gmail.com with ESMTPSA id y11sm21530442wru.0.2021.08.31.02.50.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 02:50:24 -0700 (PDT)
From:   Jiri Olsa <jolsa@redhat.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
To:     "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>
Subject: [PATCH 1/8] x86/ftrace: Remove extra orig rax move
Date:   Tue, 31 Aug 2021 11:50:10 +0200
Message-Id: <20210831095017.412311-2-jolsa@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210831095017.412311-1-jolsa@kernel.org>
References: <20210831095017.412311-1-jolsa@kernel.org>
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

