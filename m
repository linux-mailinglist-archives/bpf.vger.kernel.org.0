Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDC683399C6
	for <lists+bpf@lfdr.de>; Fri, 12 Mar 2021 23:43:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235624AbhCLWmr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 12 Mar 2021 17:42:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235602AbhCLWmk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 12 Mar 2021 17:42:40 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF1E5C061574
        for <bpf@vger.kernel.org>; Fri, 12 Mar 2021 14:42:40 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id y67so2848044pfb.2
        for <bpf@vger.kernel.org>; Fri, 12 Mar 2021 14:42:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=lWfyTO/59MNhBwzc3gIbG6SmbDAxdW3Xe9nUt0QBcRA=;
        b=cUUsS5vPm2OPlHkhrz9LWTuGDcIqQCJLqEmsPXBROXnwib/yr0xoVbFU5CAemi3AjN
         52Bsr8JbXweQBpgKyinb2KXVICdi0mGfW+D4gawFVp/vjoismWuGqfAobIoVxVPGne8+
         jZK5nnM4GM1PV2CCrTY4LxJMf1yLl2Ux4MDnkbtFeoG4bLdTN/wjg1GI1IKzxRwlSKas
         khZU7BuWMW2jvjM0jLOgGNkHzn04vouCwk2x4yilWqrWoSlbejdN1b2DElyZh4EeKmpy
         q5aoO+9T4LaneOQRLCTBYEb3s+cJURaNCMcJXtecVX1X+/KISeGulzOGN3Tw1/NgxP/j
         t/Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=lWfyTO/59MNhBwzc3gIbG6SmbDAxdW3Xe9nUt0QBcRA=;
        b=LMs8+7i3wqL2v3uZDgVUCgeOSLVYvl17VN216X7Oiz6WVTrcHU3GWr6nTga1GAbUj3
         wLKpIoS8Vqly1HFJoJxuWhm3kU4agpgECLeDu+5x3Tpz+QDhJUMflvVBedrObZyaZU4v
         J9yRqNFhusRo2DfIJHZF8CF2JIfoT16277cbJ80L51+5vghRFn5umUKiuqteL1ZYZJ8x
         FzSzmxNWRiK77Px/F0BSKxrY6kP0+GZCiedOPMYc9JHJRIY5ULOH2GUp34mNNEwuk4Da
         p7eE37JTm9YJG06MefxVEppi7BBTdmJi2ltSvoMh4Emt1ve5rR2c7QRIwoxDCi4oNpqU
         9A7Q==
X-Gm-Message-State: AOAM532yRCGCEl8ZdaCEy+RdClr3AlVDCOkjU33ZjZorT7SZsbSydXz3
        sm+6ivNoaSHDuKyX7rlb9Nk=
X-Google-Smtp-Source: ABdhPJwP40Nq5RMzRJ8Opz4NNRJnD+5KZyEckmGXlPGgTcVXjoXKlnX5S8+VEn4pCQJkMp/Cs0Ig/w==
X-Received: by 2002:a62:8103:0:b029:1ef:26e4:494f with SMTP id t3-20020a6281030000b02901ef26e4494fmr343200pfd.41.1615588960122;
        Fri, 12 Mar 2021 14:42:40 -0800 (PST)
Received: from ast-mbp.thefacebook.com ([163.114.132.7])
        by smtp.gmail.com with ESMTPSA id 132sm6449076pfu.158.2021.03.12.14.42.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Mar 2021 14:42:39 -0800 (PST)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, rostedt@goodmis.org, andrii@kernel.org,
        paulmck@kernel.org, bpf@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH bpf] ftrace: Fix modify_ftrace_direct.
Date:   Fri, 12 Mar 2021 14:42:37 -0800
Message-Id: <20210312224237.75061-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.13.5
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Alexei Starovoitov <ast@kernel.org>

The following sequence of commands:
  register_ftrace_direct(ip, addr1);
  modify_ftrace_direct(ip, addr1, addr2);
  unregister_ftrace_direct(ip, addr2);
will cause the kernel to warn:
[   30.179191] WARNING: CPU: 2 PID: 1961 at kernel/trace/ftrace.c:5223 unregister_ftrace_direct+0x130/0x150
[   30.180556] CPU: 2 PID: 1961 Comm: test_progs    W  O      5.12.0-rc2-00378-g86bc10a0a711-dirty #3246
[   30.182453] RIP: 0010:unregister_ftrace_direct+0x130/0x150

When modify_ftrace_direct() changes the addr from old to new it should update
the addr stored in ftrace_direct_funcs. Otherwise the final
unregister_ftrace_direct() won't find the address and will cause the splat.

Fixes: 0567d6809182 ("ftrace: Add modify_ftrace_direct()")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
Steven,

I was fixing bpf trampoline and realized that modify_ftrace_direct() was
broken from the beginning. bpf trampoline was lucky that it was
reusing the same page and the final unregister_ftrace_direct() always
happened with original addr.
Pls ack if the fix looks good to you.
I'd like to cary this patch through bpf tree with the other fixes
I'm working on.

Thanks!

 kernel/trace/ftrace.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 4d8e35575549..510e1c1050a1 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -5329,6 +5329,7 @@ int __weak ftrace_modify_direct_caller(struct ftrace_func_entry *entry,
 int modify_ftrace_direct(unsigned long ip,
 			 unsigned long old_addr, unsigned long new_addr)
 {
+	struct ftrace_direct_func *direct;
 	struct ftrace_func_entry *entry;
 	struct dyn_ftrace *rec;
 	int ret = -ENODEV;
@@ -5344,6 +5345,11 @@ int modify_ftrace_direct(unsigned long ip,
 	if (entry->direct != old_addr)
 		goto out_unlock;
 
+	direct = ftrace_find_direct_func(old_addr);
+	if (WARN_ON(!direct))
+		goto out_unlock;
+	direct->addr = new_addr;
+
 	/*
 	 * If there's no other ftrace callback on the rec->ip location,
 	 * then it can be changed directly by the architecture.
-- 
2.24.1

