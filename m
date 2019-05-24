Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00C5C2975C
	for <lists+bpf@lfdr.de>; Fri, 24 May 2019 13:36:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391118AbfEXLfy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 May 2019 07:35:54 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54451 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391112AbfEXLfy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 May 2019 07:35:54 -0400
Received: by mail-wm1-f68.google.com with SMTP id i3so9009740wml.4
        for <bpf@vger.kernel.org>; Fri, 24 May 2019 04:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DX8u14woMWB0/T1N/svKd1Gm9eJRtJGFELY8NQbCyRY=;
        b=UZ1Ng0cB6tRBgt0MkN1f2QmfqIWsvAtoU5hE52bip+XYpMUPLgjEJp2mgh2a3uIUbY
         rrl6PXLC2MoYi66XS/sk1bRnkte8c5/o6lMLVeyEy3PXuf7VB0IVdle98c5vezLLVuYm
         gFOlbJzC98vEVR6q0+1p7MkrW3dktIoQ9MXNDVTwxc6RX4w2klw8pHjRzV852O2Ex4L6
         Q5pVFYQG3+TapaFrQNBhZ2TFazrjdB+lAVobiUAqQs5spppG+ZPrO8tLjQR7Dr+jhHzS
         wSH3EaK+AdWwG47001ES4NaKFTAm2aZ6yWHVqSxP6Kz/KB5JpbnHTC05C1G6pYndQwdE
         Qwag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DX8u14woMWB0/T1N/svKd1Gm9eJRtJGFELY8NQbCyRY=;
        b=haErk6NMYq2RMcqWGl9H8D8TthuwpZleBcolEexSegdFyXq8fqfNF0NB0FX1q1Avkd
         rHmlmX+fPFqevwKqRGQGSpMsvt/kl7MqDh3DvFmJvgxoSwHxSp4Ne+A38v6Mgi6dwfk4
         2uMbZZtXqPaMf87ZmFtBKpMhCTDMuuRb/phr0aBGUadaRhxbqIdL2G1D9uHOkp4NiGQL
         uhEZN2V1+GmYcUeJIUzJ3Hbt6wMxLAwQMhOj1ZHSjtfj+rGuf1B7va71bvkriZu7i3hI
         WVxBA/tBKFP8BJc1b2zMn8pMzswQRjPnXVXupKaQ45WR9aDrSU1fQbODt2BA18f0+0CK
         xGpg==
X-Gm-Message-State: APjAAAU7zW0ng4cemSnK85AehC+DwCnSJIVPzJFFCKuBFliD2vCHhYYc
        aovyOhd5dybDWjI68DWUVHv70Q==
X-Google-Smtp-Source: APXvYqx9WP5jwojRzuN71GCyy37AdeKNMFFLQmvHP0V1FQj1rrtvgopL0rffK6o4XmLQi+JfIgAZMQ==
X-Received: by 2002:a1c:e714:: with SMTP id e20mr15426964wmh.143.1558697752051;
        Fri, 24 May 2019 04:35:52 -0700 (PDT)
Received: from cbtest28.netronome.com ([217.38.71.146])
        by smtp.gmail.com with ESMTPSA id x22sm2462902wmi.4.2019.05.24.04.35.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 24 May 2019 04:35:51 -0700 (PDT)
From:   Jiong Wang <jiong.wang@netronome.com>
To:     alexei.starovoitov@gmail.com, daniel@iogearbox.net
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        oss-drivers@netronome.com, davem@davemloft.net,
        paul.burton@mips.com, udknight@gmail.com, zlim.lnx@gmail.com,
        illusionist.neo@gmail.com, naveen.n.rao@linux.ibm.com,
        sandipan@linux.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, jakub.kicinski@netronome.com,
        Jiong Wang <jiong.wang@netronome.com>
Subject: [PATCH v8 bpf-next 05/16] bpf: introduce new bpf prog load flags "BPF_F_TEST_RND_HI32"
Date:   Fri, 24 May 2019 12:35:15 +0100
Message-Id: <1558697726-4058-6-git-send-email-jiong.wang@netronome.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1558697726-4058-1-git-send-email-jiong.wang@netronome.com>
References: <1558697726-4058-1-git-send-email-jiong.wang@netronome.com>
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
 include/uapi/linux/bpf.h       | 18 ++++++++++++++++++
 kernel/bpf/syscall.c           |  4 +++-
 tools/include/uapi/linux/bpf.h | 18 ++++++++++++++++++
 3 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 63e0cf6..daac8df 100644
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
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 63e0cf6..daac8df 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
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
-- 
2.7.4

