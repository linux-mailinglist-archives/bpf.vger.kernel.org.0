Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A4B82A125
	for <lists+bpf@lfdr.de>; Sat, 25 May 2019 00:27:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404422AbfEXW13 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 May 2019 18:27:29 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34013 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404418AbfEXW12 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 May 2019 18:27:28 -0400
Received: by mail-wr1-f66.google.com with SMTP id f8so11407454wrt.1
        for <bpf@vger.kernel.org>; Fri, 24 May 2019 15:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QzC26/F3XpPlZi4rI1WSSH9zL3fubSuDnCZRGSMGQV8=;
        b=L4YbX/Sor9/S/Q9zboKQb6GBzrSGXJfuEg4y8CgiTbGuY8WujSwEZd3BXVm+by41Lq
         wdpv3e8fL/GWuRbHXerVLA06lCtWW/Gf0U+wCjNmcqJKwtraUtrTiqzLLAbCYkPWxpzT
         X8XOYmRPdT+G18hPuRYwW+QaPXA96zuuyGJGuMvieoeTUXToRgFWC0xSGVr8mr40ZTkr
         tMSjZjPILTiOGgF+d8YGNaAdg9eezVH+JmMxhDD2AdDVbY7qxMoRU9189vpQB6Q7S24c
         qbpXjKiCJxe1kHXblq66erp95DNjAoX65Yx/6TMucAXbgK/Z5Kq+Bqj4FZBqUYmrpa4n
         sHlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QzC26/F3XpPlZi4rI1WSSH9zL3fubSuDnCZRGSMGQV8=;
        b=nRFcN/x8UfvIe8lEeApUE4DA9Xx/9dDAm0zrAKP3AIsqzgKCuvTfPlhvdewUvMAFsL
         dbaF/1ZD0efFt7riJpJHFQQJnG+QPHmLR3DtCXvECgTxdCFUz8BNoT/CjUxE4L62ANaS
         Dc4fTiTCpNkOlCC5P3RYe2veYy4V0pbYIL09I5XMfK0XGpN/sT/wATF7qLLQql0L4MxF
         hOa5WwzdO6sFL2zV0XKqstZiVGu7vIQhLgWZvf7iP2bLUciiRZTRP/qNLkw7LAhGQJjQ
         p6xar8DZQCHsVsBPXhNqWRwOufUMn/1h6xe1/UzHawT8aBJ7N683vCC7fKiQKQCdFqnD
         3hmw==
X-Gm-Message-State: APjAAAVcJdDIgME4YHqAhhiEfCeY+DsCueELaFp+g9G0RJEgkKAMJIyR
        HWcT12ThVZjh0PJQ0ElWvPZM6g==
X-Google-Smtp-Source: APXvYqwxlayMQXWlzeWw5obW9//4TWQsGqGjnHmi5ms/jmFqlt3K87Kduiox8HjGHkKr0MOrxReIwA==
X-Received: by 2002:adf:fd0f:: with SMTP id e15mr2613082wrr.104.1558736847215;
        Fri, 24 May 2019 15:27:27 -0700 (PDT)
Received: from cbtest28.netronome.com ([217.38.71.146])
        by smtp.gmail.com with ESMTPSA id y10sm7194961wmg.8.2019.05.24.15.27.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 24 May 2019 15:27:26 -0700 (PDT)
From:   Jiong Wang <jiong.wang@netronome.com>
To:     alexei.starovoitov@gmail.com, daniel@iogearbox.net
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        oss-drivers@netronome.com, davem@davemloft.net,
        paul.burton@mips.com, udknight@gmail.com, zlim.lnx@gmail.com,
        illusionist.neo@gmail.com, naveen.n.rao@linux.ibm.com,
        sandipan@linux.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, jakub.kicinski@netronome.com,
        Jiong Wang <jiong.wang@netronome.com>
Subject: [PATCH v9 bpf-next 05/17] bpf: introduce new bpf prog load flags "BPF_F_TEST_RND_HI32"
Date:   Fri, 24 May 2019 23:25:16 +0100
Message-Id: <1558736728-7229-6-git-send-email-jiong.wang@netronome.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1558736728-7229-1-git-send-email-jiong.wang@netronome.com>
References: <1558736728-7229-1-git-send-email-jiong.wang@netronome.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

x86_64 and AArch64 perhaps are two arches that running bpf testsuite
frequently, however the zero extension insertion pass is not enabled for
them because of their hardware support.

It is critical to guarantee the pass correction as it is supposed to be
enabled at default for a couple of other arches, for example PowerPC,
SPARC, arm, NFP etc. Therefore, it would be very useful if there is a way
to test this pass on for example x86_64.

The test methodology employed by this set is "poisoning" useless bits. High
32-bit of a definition is randomized if it is identified as not used by any
later insn. Such randomization is only enabled under testing mode which is
gated by the new bpf prog load flags "BPF_F_TEST_RND_HI32".

Suggested-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Jiong Wang <jiong.wang@netronome.com>
---
 include/uapi/linux/bpf.h | 18 ++++++++++++++++++
 kernel/bpf/syscall.c     |  4 +++-
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 68d4470..7c6aef2 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -260,6 +260,24 @@ enum bpf_attach_type {
  */
 #define BPF_F_ANY_ALIGNMENT	(1U << 1)
 
+/* BPF_F_TEST_RND_HI32 is used in BPF_PROG_LOAD command for testing purpose.
+ * Verifier does sub-register def/use analysis and identifies instructions whose
+ * def only matters for low 32-bit, high 32-bit is never referenced later
+ * through implicit zero extension. Therefore verifier notifies JIT back-ends
+ * that it is safe to ignore clearing high 32-bit for these instructions. This
+ * saves some back-ends a lot of code-gen. However such optimization is not
+ * necessary on some arches, for example x86_64, arm64 etc, whose JIT back-ends
+ * hence hasn't used verifier's analysis result. But, we really want to have a
+ * way to be able to verify the correctness of the described optimization on
+ * x86_64 on which testsuites are frequently exercised.
+ *
+ * So, this flag is introduced. Once it is set, verifier will randomize high
+ * 32-bit for those instructions who has been identified as safe to ignore them.
+ * Then, if verifier is not doing correct analysis, such randomization will
+ * regress tests to expose bugs.
+ */
+#define BPF_F_TEST_RND_HI32	(1U << 2)
+
 /* When BPF ldimm64's insn[0].src_reg != 0 then this can have
  * two extensions:
  *
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index cb5440b..3d546b6 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1604,7 +1604,9 @@ static int bpf_prog_load(union bpf_attr *attr, union bpf_attr __user *uattr)
 	if (CHECK_ATTR(BPF_PROG_LOAD))
 		return -EINVAL;
 
-	if (attr->prog_flags & ~(BPF_F_STRICT_ALIGNMENT | BPF_F_ANY_ALIGNMENT))
+	if (attr->prog_flags & ~(BPF_F_STRICT_ALIGNMENT |
+				 BPF_F_ANY_ALIGNMENT |
+				 BPF_F_TEST_RND_HI32))
 		return -EINVAL;
 
 	if (!IS_ENABLED(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS) &&
-- 
2.7.4

