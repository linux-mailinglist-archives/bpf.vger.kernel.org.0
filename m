Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF4AD215C5D
	for <lists+bpf@lfdr.de>; Mon,  6 Jul 2020 18:57:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729600AbgGFQ5P (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 6 Jul 2020 12:57:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729386AbgGFQ5O (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 6 Jul 2020 12:57:14 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77CA7C061755;
        Mon,  6 Jul 2020 09:57:14 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id l2so41382083wmf.0;
        Mon, 06 Jul 2020 09:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:mime-version
         :content-disposition;
        bh=R/YjKM4rOkF0piUgbg1Z0k3ov8aHdcptlyDHTu9pr18=;
        b=JNOnGohp5rk/Iys3k3bb2ZsZnXn6s/eIdIduV7h3TwG+vH+MomPUI2HAc2MrRfGM+2
         hQRLCDZj2xZIoh+BggLnKky0pu43rZO3qVp7BbQovs61n/EMPRGEr6KbnrmjJ+Nni7Ha
         EEUKEN1UBQzDSoVM23S5b2TV9Ed3ZZorMbhB2B3YS41luFIhtkyPj8TvW4Lq/bxhwNic
         tO1NsjbskbfU3LePP2U3iGxtor9XdI8WYnL00dUti3Ed0VSoqvq1RPgloVzKnHqNOowp
         3EtgyGgV1gS3qxPfg1C7mi5QH2o6M5L+AJP+lRV9DdfHUu1WALLQiEswc3M6SaCUtp+M
         CV6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:mime-version:content-disposition;
        bh=R/YjKM4rOkF0piUgbg1Z0k3ov8aHdcptlyDHTu9pr18=;
        b=oYF/kGCTJEpampG+0IWnkO54Ey4eLkWXtEUhtM5DNX5z5wrGN0ONJtAUsAsLfJEM3I
         vM86/c1UuuyP8Tx0TMeH77rA6E3NdmWlGJHE8EML8b03IkuPue6OzYWYZSewocp0R2Ty
         wgcGn69heRytlX9aBopvfW6D6qVO2kkEYu+TFmptjDcMG+DyNnMHzo6UHJJ2zpQ76ZVM
         aBB9Cwh+WxxD/KY5MvcAgfM0TMaC3vbcGKXUuUCkr5vystusPxGTrNd5Ug5j9eCnCABz
         mOtC9r2edvl2BK1LmmSQ/epp9Vb/hpPCAMih/XadfRiHphWY7u6XSWCfMkzMEETUW5Nl
         /9xA==
X-Gm-Message-State: AOAM533qNz1FBV/eMPXG3EXaUaB7/h20dKo31uAp6WP17ZK2C6zbm9QM
        oyNo05FoCI8/wtup+qm8WBicUsZVTvRdVA==
X-Google-Smtp-Source: ABdhPJwCAOnRf+CcFCx6YEfpYFYNa2AuSlPzTN/p/Y4w/uqIVp5wIHDENeMU9hop8O2zcT/S7VHPww==
X-Received: by 2002:a7b:c0c9:: with SMTP id s9mr112960wmh.166.1594054632753;
        Mon, 06 Jul 2020 09:57:12 -0700 (PDT)
Received: from localhost ([95.236.72.230])
        by smtp.gmail.com with ESMTPSA id v6sm12360079wrr.85.2020.07.06.09.57.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 09:57:11 -0700 (PDT)
Date:   Mon, 6 Jul 2020 18:57:10 +0200
From:   Lorenzo Fontana <fontanalorenz@gmail.com>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc:     Jonathan Corbet <corbet@lwn.net>, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>
Subject: [PATCH] bpf: lsm: Disable or enable BPF LSM at boot time
Message-ID: <20200706165710.GA208695@gallifrey>
Mail-Followup-To: Lorenzo Fontana <fontanalorenz@gmail.com>,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
        Yonghong Song <yhs@fb.com>, Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This option adds a kernel parameter 'bpf_lsm',
which allows the BPF LSM to be disabled at boot.
The purpose of this option is to allow a single kernel
image to be distributed with the BPF LSM built in,
but not necessarily enabled.

Signed-off-by: Lorenzo Fontana <fontanalorenz@gmail.com>
---
 Documentation/admin-guide/kernel-parameters.txt |  8 ++++++++
 init/Kconfig                                    | 12 ++++++++++++
 security/bpf/hooks.c                            | 16 ++++++++++++++++
 3 files changed, 36 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index fb95fad81c79..c0d5955279d7 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4575,6 +4575,14 @@
 			1 -- enable.
 			Default value is set via kernel config option.
 
+	bpf_lsm=	[BPF_LSM] Disable or enable LSM Instrumentation
+			with BPF at boot time.
+			Format: { "0" | "1" }
+			See init/Kconfig help text.
+			0 -- disable.
+			1 -- enable.
+			Default value is 1.
+
 	serialnumber	[BUGS=X86-32]
 
 	shapers=	[NET]
diff --git a/init/Kconfig b/init/Kconfig
index a46aa8f3174d..410547e4342e 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1659,6 +1659,18 @@ config BPF_LSM
 
 	  If you are unsure how to answer this question, answer N.
 
+config BPF_LSM_BOOTPARAM
+	bool "LSM Instrumentation with BPF boot parameter"
+	depends on BPF_LSM
+	help
+	  This option adds a kernel parameter 'bpf_lsm', which allows LSM
+	  instrumentation with BPF to be disabled at boot.
+	  If this option is selected, the BPF LSM
+	  functionality can be disabled with bpf_lsm=0 on the kernel
+	  command line.  The purpose of this option is to allow a single
+	  kernel image to be distributed with the BPF LSM built in, but not
+	  necessarily enabled.
+
 config BPF_SYSCALL
 	bool "Enable bpf() system call"
 	select BPF
diff --git a/security/bpf/hooks.c b/security/bpf/hooks.c
index 32d32d485451..6a4b4f63976c 100644
--- a/security/bpf/hooks.c
+++ b/security/bpf/hooks.c
@@ -3,9 +3,24 @@
 /*
  * Copyright (C) 2020 Google LLC.
  */
+
+#include <linux/init.h>
 #include <linux/lsm_hooks.h>
 #include <linux/bpf_lsm.h>
 
+int bpf_lsm_enabled_boot __initdata = 1;
+#ifdef CONFIG_BPF_LSM_BOOTPARAM
+static int __init bpf_lsm_enabled_setup(char *str)
+{
+	unsigned long enabled;
+
+	if (!kstrtoul(str, 0, &enabled))
+		bpf_lsm_enabled_boot = enabled ? 1 : 0;
+	return 1;
+}
+__setup("bpf_lsm=", bpf_lsm_enabled_setup);
+#endif
+
 static struct security_hook_list bpf_lsm_hooks[] __lsm_ro_after_init = {
 	#define LSM_HOOK(RET, DEFAULT, NAME, ...) \
 	LSM_HOOK_INIT(NAME, bpf_lsm_##NAME),
@@ -23,4 +38,5 @@ static int __init bpf_lsm_init(void)
 DEFINE_LSM(bpf) = {
 	.name = "bpf",
 	.init = bpf_lsm_init,
+	.enabled = &bpf_lsm_enabled_boot,
 };
-- 
2.27.0

