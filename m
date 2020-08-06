Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34FEE23E092
	for <lists+bpf@lfdr.de>; Thu,  6 Aug 2020 20:38:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728723AbgHFSf5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Aug 2020 14:35:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729246AbgHFSfN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 6 Aug 2020 14:35:13 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCBEAC061575
        for <bpf@vger.kernel.org>; Thu,  6 Aug 2020 11:26:14 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id n12so17310280qtr.6
        for <bpf@vger.kernel.org>; Thu, 06 Aug 2020 11:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=h6CKdCAZ7nexLhptlfsLTSjR9JI36kIOk0ydm+WNJwQ=;
        b=evTkLWKyKJUcisp3sGIXFUzGQr/MOZpzg42XmX/3wYkt6nypVuYzShvTK0BAaORJcN
         skrZLkEOZmUKhikjELX5tIRaLtV5dVzTT4+dB7ozAsswSyUPpsBmWaSKaFXoF8jw0Opf
         Gka0cHPFf5G49l6q1E/kFeyrD/qGGn/fK9VyYAdI48jUIijXp2fqVgQXDet8ei6F88l/
         syitSbcg8CD5FDsOAukvj7xwgTY1Hmg5JRAHEJl6IzUJwZbcGb8igqHaIl0nWeksDwC+
         YJThB36usPn0UHVK6wI4g/eAeKklr+FvpM9LmgDcOKUX2yNA8KtL7qt20xRZ6YoHFYN2
         3ppQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=h6CKdCAZ7nexLhptlfsLTSjR9JI36kIOk0ydm+WNJwQ=;
        b=JAHa5a+5IOWpp6rZ/Srbh1EM+sn/qXXUhVS7Im53x6duAmtts45zCL+KowtmddhT2B
         SUcpfp4y4Svd3JEyGGL/3nx0hjb35A4JayAvJW9TebqWxwQgbpMp8te64I18vWOV3S8H
         Y9HO9pNGtwBPYNi7dJAKqvL40M9kGrb+sowV8yZPMyMiT0fFtRJMLTXWjC2ZnlxOxPdw
         XKjRDzdta21zZEWCzkMg7i7gioD4b6pL5MFVgy6ugPjAltmFWhpymBdU4bYlxQA3Ejb5
         TSXRydKEXHgagmRP/vr7Fjp/G35SmZ6b4V+0MNfH6An33cxiX6OjMBbnQY7YOVvpfOY5
         +D9A==
X-Gm-Message-State: AOAM5307LNvCZoJagMjO8OIyrIGGpDG/Kv6Y+rpM35PztuQv+TM0MRkJ
        H77HvVa1tgCWn6qsRDsdSyO9ugg=
X-Google-Smtp-Source: ABdhPJz1Fv5DIBVnHlfSBLv3sf2vQ9E+wLoBoKa8WwHCPB8AYq6Gsk70z9kID5J4BihogzMQjDcFH14=
X-Received: by 2002:a0c:f4d3:: with SMTP id o19mr10564858qvm.204.1596738373936;
 Thu, 06 Aug 2020 11:26:13 -0700 (PDT)
Date:   Thu,  6 Aug 2020 11:26:12 -0700
Message-Id: <20200806182612.1390883-1-sdf@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.236.gb10cc79966-goog
Subject: [PATCH bpf] bpf: remove inline from bpf_do_trace_printk
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

I get the following error during compilation on my side:
kernel/trace/bpf_trace.c: In function 'bpf_do_trace_printk':
kernel/trace/bpf_trace.c:386:34: error: function 'bpf_do_trace_printk' can never be inlined because it uses variable argument lists
 static inline __printf(1, 0) int bpf_do_trace_printk(const char *fmt, ...)
                                  ^

Fixes: ac5a72ea5c89 ("bpf: Use dedicated bpf_trace_printk event instead of trace_printk()")
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 kernel/trace/bpf_trace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index cb91ef902cc4..a8d4f253ed77 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -383,7 +383,7 @@ static DEFINE_RAW_SPINLOCK(trace_printk_lock);
 
 #define BPF_TRACE_PRINTK_SIZE   1024
 
-static inline __printf(1, 0) int bpf_do_trace_printk(const char *fmt, ...)
+static __printf(1, 0) int bpf_do_trace_printk(const char *fmt, ...)
 {
 	static char buf[BPF_TRACE_PRINTK_SIZE];
 	unsigned long flags;
-- 
2.28.0.236.gb10cc79966-goog

