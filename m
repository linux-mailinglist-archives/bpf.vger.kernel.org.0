Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 368C650BD67
	for <lists+bpf@lfdr.de>; Fri, 22 Apr 2022 18:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1392468AbiDVQtF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 22 Apr 2022 12:49:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1449804AbiDVQtE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 22 Apr 2022 12:49:04 -0400
X-Greylist: delayed 338 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 22 Apr 2022 09:46:09 PDT
Received: from pi3.com.pl (pi3.com.pl [185.238.74.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD21C5F265
        for <bpf@vger.kernel.org>; Fri, 22 Apr 2022 09:46:09 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by pi3.com.pl (Postfix) with ESMTP id 7E52C4C11A3;
        Fri, 22 Apr 2022 18:40:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=pi3.com.pl; s=default;
        t=1650645630; bh=EvOpauGsHzyNJvQrSIZ+SO3KZOe4YEWNzQVtyyEd+1Y=;
        h=Date:From:To:Cc:Subject:From;
        b=bqDkp15jyjx5kd9T7uBC+Vue98c+rOOEL4wyyEJBndwPQHGfy+cIHYbZLpkSzsY+D
         RoFvHV83jJyA4og/eYZFTqbBUW63XkzYf9u449gxaO523b2jrJMWqv1U0u0sZoRfft
         TAilKwlbtymkH0laC0k34n/1E06F494mnfAmPs1MCNuRIgBgADo2pgDKPCoHGIl5W5
         +GnaxS267tZnNyDfucMpQ41hVVrTPUYm9RxYjYxzZy642RThdi9NDUyi7BVb8gAAyh
         LtL670zKoc6/fVyUbb2IwX0p8OSjGTKc+r+iSw0HPT1DQHF2EJeGUWLFV5NOKiAEnQ
         BuQUQ7VYE2GKA==
X-Virus-Scanned: Debian amavisd-new at pi3.com.pl
Received: from pi3.com.pl ([127.0.0.1])
        by localhost (pi3.com.pl [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id WF6dyeIOMHpi; Fri, 22 Apr 2022 18:40:27 +0200 (CEST)
Received: by pi3.com.pl (Postfix, from userid 1000)
        id 3E45A4C14ED; Fri, 22 Apr 2022 18:40:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=pi3.com.pl; s=default;
        t=1650645627; bh=EvOpauGsHzyNJvQrSIZ+SO3KZOe4YEWNzQVtyyEd+1Y=;
        h=Date:From:To:Cc:Subject:From;
        b=lRtVuAiSQugsAzWGGpP0Erosx60RxcGZTfIpHSEzai5SrJyViwiTdW//6haXG+58Z
         5Qsi+giYU+1SpSE7lobnGJPtFRerSTJ6IB+C7vcXdRZLkcou5d6PGdagHfvFCiyhLX
         tlctqYXbKWXWgVy+UL5brRCF9ngZfe6GAUuYbU8Hextf5i/TfkxxlPfkQFYCeAYKTA
         ekQrdCfjc+cosv1hF4aurI3RIG+7dZXtpTHZl1PucqK/ifsh/gj/Pj0x4pn6sGeZjK
         iPFgtNT/lW3KRzh+6bf+rYqAFVel7P6mijKRd7SDuTPl1+A7xFazUSVNqIiWYvtYJ8
         ypmTq/TSYwxTg==
Date:   Fri, 22 Apr 2022 18:40:27 +0200
From:   Adam Zabrocki <pi3@pi3.com.pl>
To:     Masami Hiramatsu <mhiramat@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Solar Designer <solar@openwall.com>
Cc:     bpf@vger.kernel.org
Subject: [PATCH bpf] x86/kprobes: Fix KRETPROBES when
 CONFIG_KRETPROBE_ON_RETHOOK is set
Message-ID: <20220422164027.GA7862@pi3.com.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

[PATCH bpf] x86/kprobes: Fix KRETPROBES when CONFIG_KRETPROBE_ON_RETHOOK is set

The recent kernel change "kprobes: Use rethook for kretprobe if possible",
introduced a potential NULL pointer dereference bug in the KRETPROBE
mechanism. The official Kprobes documentation defines that "Any or all
handlers can be NULL". Unfortunately, there is a missing return handler
verification to fulfill these requirements and can result in a NULL pointer
dereference bug.

This patch adds such verification in kretprobe_rethook_handler() function.

Fixes: 73f9b911faa7 ("kprobes: Use rethook for kretprobe if possible")
Signed-off-by: Adam Zabrocki <pi3@pi3.com.pl>
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 kernel/kprobes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index dbe57df2e199..dd58c0be9ce2 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -2126,7 +2126,7 @@ static void kretprobe_rethook_handler(struct rethook_node *rh, void *data,
 	struct kprobe_ctlblk *kcb;
 
 	/* The data must NOT be null. This means rethook data structure is broken. */
-	if (WARN_ON_ONCE(!data))
+	if (WARN_ON_ONCE(!data) || !rp->handler)
 		return;
 
 	__this_cpu_write(current_kprobe, &rp->kp);

-- 
pi3 (pi3ki31ny) - pi3 (at) itsec pl
http://pi3.com.pl

