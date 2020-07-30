Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A894233438
	for <lists+bpf@lfdr.de>; Thu, 30 Jul 2020 16:22:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728337AbgG3OWd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 30 Jul 2020 10:22:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726873AbgG3OWc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 30 Jul 2020 10:22:32 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3577FC061574
        for <bpf@vger.kernel.org>; Thu, 30 Jul 2020 07:22:32 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id a26so2351317ejc.2
        for <bpf@vger.kernel.org>; Thu, 30 Jul 2020 07:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YwZxozNZBXDiR/2kRqLL1MaXDjLPic26w5gQoYGrfkM=;
        b=R7tGuqjD/vvCJ2904Vuec4iUJ6rFzusWXWJpA5X/dmo3kgYXJDkMmYeNILpJLVELhQ
         IAVW2EQA1kYDJ0mQVbVZ/ri+6eTjMHp7C0fwDl/HDXtSIamI0BGeYc+Na69ibjZfTR+k
         A43hfZYIvSuhBuw6gTrAUuz2MGPi0kClRbeqMBypGnTi7UtIDyfJfWxE69l/X0YJM87N
         MTV3qlKOPuB7n3Y0yYpW9nt3ndY4Wc/s/iYW81vulZijqz8/pLpbUe9h8ZxE73hNQsXz
         v9H9yTa9MF94xzDWteLRVawS/ekYrp4ZjUF2eDn4jSz+CCPVPTPzkBYtQRE46iqj4tpE
         lifw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YwZxozNZBXDiR/2kRqLL1MaXDjLPic26w5gQoYGrfkM=;
        b=Er7YAegJIRDEXJgkt1G/lckdJjoeL99KSHhSJwMCx81kFNSNMjJcIGHeC+bR26EPr0
         QqJpHnNxu9/C4ot5b288tV2Gx3nVP20pg59NzyuNqKrqL1wyTSjxUVwsUp0uKWrKxlbY
         kR1nQ1+j4PJXFLK8indwOks2V+1f+kXOtfRJjTYSTrlHolcIh7uHHnS3GeiX1IaUPthv
         HAAouRtNJI4eNpjphs0pBZq6KDla6X/U1zeq4mkYMNc8BjyMjEdSdrH8OvZArQVnENwB
         Z6VBJ+QfxqrR1D4/GihAV9jiMZu0MM1GeZYlbrFohoBN+ao/pdfNNW9xVGLMXPG2Na2U
         G7PQ==
X-Gm-Message-State: AOAM5311xveTjPq1BDT9D8yDgFkGoKcmXw60HZ8uGIPy5RmcdN7KDTX4
        WUrZz/BIolnbhwAlxJO+JFUiJVTpzLfPyA==
X-Google-Smtp-Source: ABdhPJy7aqlSQaQrLHhofONaPZjwKauHbZHDGRXdQ92TUeggQySP4YNI9qe5tEKnlr5K8H51rOJFuQ==
X-Received: by 2002:a17:906:3e54:: with SMTP id t20mr2770755eji.471.1596118950795;
        Thu, 30 Jul 2020 07:22:30 -0700 (PDT)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id x16sm6372795edr.52.2020.07.30.07.22.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2020 07:22:29 -0700 (PDT)
Date:   Thu, 30 Jul 2020 16:22:13 +0200
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Qian Cai <cai@lca.pw>
Cc:     linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org,
        songliubraving@fb.com, andriin@fb.com, daniel@iogearbox.net,
        catalin.marinas@arm.com, john.fastabend@gmail.com, ast@kernel.org,
        zlim.lnx@gmail.com, kpsingh@chromium.org, yhs@fb.com,
        will@kernel.org, kafai@fb.com, sfr@canb.auug.org.au,
        linux-next@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next 1/1] arm64: bpf: Add BPF exception tables
Message-ID: <20200730142213.GB1529030@myrica>
References: <20200728152122.1292756-1-jean-philippe@linaro.org>
 <20200728152122.1292756-2-jean-philippe@linaro.org>
 <20200730122855.GA3773@lca.pw>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="r5Pyd7+fXNt84Ff3"
Content-Disposition: inline
In-Reply-To: <20200730122855.GA3773@lca.pw>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 30, 2020 at 08:28:56AM -0400, Qian Cai wrote:
> On Tue, Jul 28, 2020 at 05:21:26PM +0200, Jean-Philippe Brucker wrote:
> > When a tracing BPF program attempts to read memory without using the
> > bpf_probe_read() helper, the verifier marks the load instruction with
> > the BPF_PROBE_MEM flag. Since the arm64 JIT does not currently recognize
> > this flag it falls back to the interpreter.
> > 
> > Add support for BPF_PROBE_MEM, by appending an exception table to the
> > BPF program. If the load instruction causes a data abort, the fixup
> > infrastructure finds the exception table and fixes up the fault, by
> > clearing the destination register and jumping over the faulting
> > instruction.
> > 
> > To keep the compact exception table entry format, inspect the pc in
> > fixup_exception(). A more generic solution would add a "handler" field
> > to the table entry, like on x86 and s390.
> > 
> > Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> 
> This will fail to compile on arm64,
> 
> https://gitlab.com/cailca/linux-mm/-/blob/master/arm64.config
> 
> arch/arm64/mm/extable.o: In function `fixup_exception':
> arch/arm64/mm/extable.c:19: undefined reference to `arm64_bpf_fixup_exception'

Thanks for the report, I attached a fix. Daniel, can I squash it and
resend as v2 or is it too late?

I'd be more confident if my patches sat a little longer on the list so
arm64 folks have a chance to review them. This isn't my first silly
mistake...

Thanks,
Jean

--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-arm64-bpf-Fix-build-for-CONFIG_BPF_JIT.patch"

From 17d0f041b57903cb2657dde15559cd1923498337 Mon Sep 17 00:00:00 2001
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
Date: Thu, 30 Jul 2020 14:45:44 +0200
Subject: [PATCH] arm64: bpf: Fix build for !CONFIG_BPF_JIT

Add a stub for arm64_bpf_fixup_exception() when CONFIG_BPF_JIT isn't
enabled, and avoid the fixup in this case.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 arch/arm64/include/asm/extable.h | 9 +++++++++
 arch/arm64/mm/extable.c          | 3 ++-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/extable.h b/arch/arm64/include/asm/extable.h
index bcee40df1586..840a35ed92ec 100644
--- a/arch/arm64/include/asm/extable.h
+++ b/arch/arm64/include/asm/extable.h
@@ -22,8 +22,17 @@ struct exception_table_entry
 
 #define ARCH_HAS_RELATIVE_EXTABLE
 
+#ifdef CONFIG_BPF_JIT
 int arm64_bpf_fixup_exception(const struct exception_table_entry *ex,
 			      struct pt_regs *regs);
+#else /* !CONFIG_BPF_JIT */
+static inline
+int arm64_bpf_fixup_exception(const struct exception_table_entry *ex,
+			      struct pt_regs *regs)
+{
+	return 0;
+}
+#endif /* !CONFIG_BPF_JIT */
 
 extern int fixup_exception(struct pt_regs *regs);
 #endif
diff --git a/arch/arm64/mm/extable.c b/arch/arm64/mm/extable.c
index 1f42991cacdd..eee1732ab6cd 100644
--- a/arch/arm64/mm/extable.c
+++ b/arch/arm64/mm/extable.c
@@ -14,7 +14,8 @@ int fixup_exception(struct pt_regs *regs)
 	if (!fixup)
 		return 0;
 
-	if (regs->pc >= BPF_JIT_REGION_START &&
+	if (IS_ENABLED(CONFIG_BPF_JIT) &&
+	    regs->pc >= BPF_JIT_REGION_START &&
 	    regs->pc < BPF_JIT_REGION_END)
 		return arm64_bpf_fixup_exception(fixup, regs);
 
-- 
2.27.0


--r5Pyd7+fXNt84Ff3--
