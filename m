Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89BC7373F83
	for <lists+bpf@lfdr.de>; Wed,  5 May 2021 18:23:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233909AbhEEQYP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 5 May 2021 12:24:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233808AbhEEQYP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 5 May 2021 12:24:15 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37F63C061763
        for <bpf@vger.kernel.org>; Wed,  5 May 2021 09:23:18 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id t18so2503547wry.1
        for <bpf@vger.kernel.org>; Wed, 05 May 2021 09:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6XN47Z1msFXr3oDKB1aZHCS/bnZ/+lvKQpoKFFoW/yU=;
        b=ix/7UViMhrqY4NFEXW6WuTj61OtFrhsyijxpOhJFnH2MpopB33MturLkApDTYc4ET8
         10PpDLlIHgpSX6Q1Xmlu1ICN7V9HNsUnj9MMWPqxwlhDPTq6Hf7VVMnSf6Cb5Vlx0WGI
         zlTQMZyo8FUTla1KtAry3OcjORiOyuctj3DRk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6XN47Z1msFXr3oDKB1aZHCS/bnZ/+lvKQpoKFFoW/yU=;
        b=JJ3ofuUZHH2WZvQYqalobyudQiB4+tbZThk7FtfVkiRLSuIdQFbyeLAxrVdg2h7QhW
         8AhRWJkwnjTe9K8qrP8dz9pEwjNlzlMT6WbkHk68Hqqdin1F6QLEHli3kZu7xib4BAfQ
         yOfoZcc3Ndsu3hBuhob9q/dtlA11xGH7y6Zyk5oXbGIb41hdRKi5IR1S1nG7rK29T0lg
         5ZCkF1hHRmO2MGreIkxZlkxJMsJNX2tv7tPPl5Ou1uqppic1HCBaHuthX+VIOuzruUsI
         407DlHpwJ5LoOR476zRFqZnzFPA6Xiw4r0g6km5jqJK5zJ2+W2SR10W9/B0kqb8LC43N
         rPGQ==
X-Gm-Message-State: AOAM531BV/+BSpYYS1hpz5lDN4LpJg61pavUkvZV3ZtuXPeA8OubidS0
        F4LOMNpVBhu53jQjVIX3Huo5x8E1c2GSEQ==
X-Google-Smtp-Source: ABdhPJxEiHkV7KG5Rx3iD3zJ454hg4/eNOKMNBsVKrXdk6NEynpDH7WKCEjtkX41/46Nfo2ew7UwRg==
X-Received: by 2002:a5d:6e0d:: with SMTP id h13mr5103442wrz.118.1620231796710;
        Wed, 05 May 2021 09:23:16 -0700 (PDT)
Received: from revest.zrh.corp.google.com ([2a00:79e0:61:302:e29a:615e:d9e6:423e])
        by smtp.gmail.com with ESMTPSA id u6sm6260955wml.6.2021.05.05.09.23.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 May 2021 09:23:15 -0700 (PDT)
From:   Florent Revest <revest@chromium.org>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kpsingh@kernel.org, jackmanb@google.com, sdf@google.com,
        linux-kernel@vger.kernel.org, Florent Revest <revest@chromium.org>,
        syzbot <syzbot@syzkaller.appspotmail.com>
Subject: [PATCH bpf] bpf: Don't WARN_ON_ONCE in bpf_bprintf_prepare
Date:   Wed,  5 May 2021 18:23:07 +0200
Message-Id: <20210505162307.2545061-1-revest@chromium.org>
X-Mailer: git-send-email 2.31.1.527.g47e6f16901-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The bpf_seq_printf, bpf_trace_printk and bpf_snprintf helpers share one
per-cpu buffer that they use to store temporary data (arguments to
bprintf). They "get" that buffer with try_get_fmt_tmp_buf and "put" it
by the end of their scope with bpf_bprintf_cleanup.

If one of these helpers gets called within the scope of one of these
helpers, for example: a first bpf program gets called, uses
bpf_trace_printk which calls raw_spin_lock_irqsave which is traced by
another bpf program that calls bpf_trace_printk again, then the second
"get" fails. Essentially, these helpers are not re-entrant, and it's not
that bad because they would simply return -EBUSY and recover gracefully.

However, when this happens, the code hits a WARN_ON_ONCE. The guidelines
in include/asm-generic/bug.h say "Do not use these macros [...] on
transient conditions like ENOMEM or EAGAIN."

This condition qualifies as transient, for example, the next
raw_spin_lock_irqsave probe is likely to succeed, so it does not deserve
a WARN_ON_ONCE.

The guidelines also say "Do not use these macros when checking for
invalid external inputs (e.g. invalid system call arguments" and, in a
way, this can be seen as an invalid input because syzkaller triggered
it.

Signed-off-by: Florent Revest <revest@chromium.org>
Reported-by: syzbot <syzbot@syzkaller.appspotmail.com>
Fixes: d9c9e4db186a ("bpf: Factorize bpf_trace_printk and bpf_seq_printf")
---
 kernel/bpf/helpers.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 544773970dbc..007fa26eb3f5 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -709,7 +709,7 @@ static int try_get_fmt_tmp_buf(char **tmp_buf)
 
 	preempt_disable();
 	used = this_cpu_inc_return(bpf_printf_buf_used);
-	if (WARN_ON_ONCE(used > 1)) {
+	if (used > 1) {
 		this_cpu_dec(bpf_printf_buf_used);
 		preempt_enable();
 		return -EBUSY;
-- 
2.31.1.527.g47e6f16901-goog

