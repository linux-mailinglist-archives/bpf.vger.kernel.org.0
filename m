Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA178315DD3
	for <lists+bpf@lfdr.de>; Wed, 10 Feb 2021 04:38:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbhBJDhV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Feb 2021 22:37:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbhBJDhU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Feb 2021 22:37:20 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B4C1C061756
        for <bpf@vger.kernel.org>; Tue,  9 Feb 2021 19:36:40 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id g3so464067plp.2
        for <bpf@vger.kernel.org>; Tue, 09 Feb 2021 19:36:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aPVbXdT0/D0quWw/01RSc/SwOGlQJ9NewoSBOvhSa90=;
        b=KbyMyuLioAKuxEYgfXoZt1vslHnpdKhpJ7b2pfH+Y7n/acTrnMk8QTgX3/0gCVFVTg
         lhCtotgby7DlsEmDaRHI45sQ1OrU5emF13294cUK5ZTs4REuUEUVIr1KvhDPIiBH4rNZ
         4gUsVdRiLMlpOlXcv6moYEfYNNj63t6ttSJt+2r9uxCN6xIjti22QdLiTZ7EFkIYqodo
         2bT4qwO4TXNozhirPLNrPE8MdD9lNggQnMLPQtyZ4wCeL7CyPsIuDU8ll/qPJBi2ljA/
         UGFhCW0L5DNme5qiI6wD9Ow332Y8esC915bv5RAzWfyJorUmt51Sb2MZlAqmEizHs+W8
         cQyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=aPVbXdT0/D0quWw/01RSc/SwOGlQJ9NewoSBOvhSa90=;
        b=Vwmgxqqa/v5npJKpFQcvFnKDUBljmfYP5nboTNFYlpfka++BwzWdrZWjLfodUTY99T
         LxKsX5blzUtutFAf4X/KxgkNymBbLNsEi+sTHC85xHIc6jGq3I3gbEZOaX72f6rMz0C1
         m8mbeqrT1W7YizPLjYtYsRtQzaN+3JJZBS8HqRKAzFH6t1Y0E73ImUljfTQqkRNYUuyb
         ch7TDG/p6+mCjeX76iZm7F/0qlQLH/jSKwFjYkPEhm0tWW0v6U+dKO5bJUY2uS1Q6oO5
         reUO8ySOpQkXM72dYnrYgL9zn57X51oI/msSOchh5T+6C87UZItIZ/+wHhEdv2NS9X4F
         FnoA==
X-Gm-Message-State: AOAM53154ZASP2Z3KMqYzYmZxgJowApKJBlaEcOEKMXxhEjk1CEcZ+Ko
        jQp7Cwdqk46aQLuJWm1f0RA=
X-Google-Smtp-Source: ABdhPJwVv6iaMoWysiUwJU9aNl+KovzoJisEDa+Mu0Q0DY/DPpNMD6/P1PL8VFVL8lEZEBUKKJa4+w==
X-Received: by 2002:a17:90a:e392:: with SMTP id b18mr1141768pjz.33.1612928200082;
        Tue, 09 Feb 2021 19:36:40 -0800 (PST)
Received: from ast-mbp.thefacebook.com ([163.114.132.7])
        by smtp.gmail.com with ESMTPSA id f7sm391099pjh.45.2021.02.09.19.36.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Feb 2021 19:36:39 -0800 (PST)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, bpf@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v4 bpf-next 2/9] bpf: Run sleepable programs with migration disabled
Date:   Tue,  9 Feb 2021 19:36:27 -0800
Message-Id: <20210210033634.62081-3-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <20210210033634.62081-1-alexei.starovoitov@gmail.com>
References: <20210210033634.62081-1-alexei.starovoitov@gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Alexei Starovoitov <ast@kernel.org>

In older non-RT kernels migrate_disable() was the same as preempt_disable().
Since commit 74d862b682f5 ("sched: Make migrate_disable/enable() independent of RT")
migrate_disable() is real and doesn't prevent sleeping.
Running sleepable programs with migration disabled allows to add support for
program stats and per-cpu maps later.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Acked-by: KP Singh <kpsingh@kernel.org>
---
 kernel/bpf/trampoline.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index 5be3beeedd74..89fc849ba271 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -425,11 +425,13 @@ void notrace __bpf_prog_exit(struct bpf_prog *prog, u64 start)
 void notrace __bpf_prog_enter_sleepable(void)
 {
 	rcu_read_lock_trace();
+	migrate_disable();
 	might_fault();
 }
 
 void notrace __bpf_prog_exit_sleepable(void)
 {
+	migrate_enable();
 	rcu_read_unlock_trace();
 }
 
-- 
2.24.1

