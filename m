Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D223417AFF4
	for <lists+bpf@lfdr.de>; Thu,  5 Mar 2020 21:50:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726178AbgCEUuC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 5 Mar 2020 15:50:02 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34395 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726080AbgCEUuC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 5 Mar 2020 15:50:02 -0500
Received: by mail-wr1-f67.google.com with SMTP id z15so8722971wrl.1
        for <bpf@vger.kernel.org>; Thu, 05 Mar 2020 12:50:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0KEfmruotSqhGTFUFxO/QW9JoUqhcmY2AakhHNMdqRo=;
        b=oB/PPOYSUG+ODvgRhZg5BbzVpqBfv+G+lqC3thkF+aDFBy1G1+1TSx08xO50tVNH28
         flJXZhESLQjxU4hoo8x9/4ckg453ezuG396NaKCx+HkzRITMFuwp0jR3UivxapLfEiOC
         vU/qF0FIjUNxLRugU665iHhYQtCySF5kKx9Ds=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0KEfmruotSqhGTFUFxO/QW9JoUqhcmY2AakhHNMdqRo=;
        b=WuSITLsJCXAI1SJi8sozQKeQZFr1uFWYpVgsBAiXKceQq8E4LdXa/jcKsxXd9o4iB9
         HCSSHrdAr4PqzB7WdHjat/1XCwh76ulUx2JLu6Xm0kiCSFkekI/QZEmDdkowghjAagYm
         xOxtzVzqyRviT6GGw2qh/qgFUAlI0Uk34802NhsyklHdh7NZkB7xZm/tH/Srh6tD11Q1
         LcP+YcfkJDXzsDnrRx8JxnvJ+AN5OGKZei77VDfGMyDFHIVwAE6fmzLWfKItfFgs8SWC
         MGQkvuv/T7478KYayHkW2BvcQPxJiCxK5a0eIF6nBG9STIedAy1U2zdwJMm7Fu53rqAS
         b6TQ==
X-Gm-Message-State: ANhLgQ1kHbtc8srE2X6YMaKgszuZPvmP44ItqCc5dK+JZud1qTJbxpKo
        zRAPYFZFkBKaUo8g/PtfZc7MnQ==
X-Google-Smtp-Source: ADFU+vsnUQrZpOi5VFZtfDihFlFQvHK8Y7uNQrEn+6t32yP+GM+QPKOlo7OKipnSjH7ihs/CuMFnxw==
X-Received: by 2002:a5d:5148:: with SMTP id u8mr787323wrt.132.1583441400388;
        Thu, 05 Mar 2020 12:50:00 -0800 (PST)
Received: from kpsingh-kernel.localdomain (77-56-209-237.dclient.hispeed.ch. [77.56.209.237])
        by smtp.gmail.com with ESMTPSA id r19sm10150874wmh.26.2020.03.05.12.49.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2020 12:49:59 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>
Subject: [PATCH bpf-next] bpf: Remove unnecessary CAP_MAC_ADMIN check
Date:   Thu,  5 Mar 2020 21:49:55 +0100
Message-Id: <20200305204955.31123-1-kpsingh@chromium.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: KP Singh <kpsingh@google.com>

While well intentioned, checking CAP_MAC_ADMIN for attaching
BPF_MODIFY_RETURN tracing programs to "security_" functions is not
necessary as tracing BPF programs already require CAP_SYS_ADMIN.

Fixes: 6ba43b761c41 ("bpf: Attachment verification for BPF_MODIFY_RETURN")
Signed-off-by: KP Singh <kpsingh@google.com>
---
 kernel/bpf/verifier.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index ae32517d4ccd..55d376c53f7d 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -9808,20 +9808,13 @@ static int check_attach_modify_return(struct bpf_verifier_env *env)
 	struct bpf_prog *prog = env->prog;
 	unsigned long addr = (unsigned long) prog->aux->trampoline->func.addr;
 
-	if (within_error_injection_list(addr))
-		return 0;
-
 	/* This is expected to be cleaned up in the future with the KRSI effort
 	 * introducing the LSM_HOOK macro for cleaning up lsm_hooks.h.
 	 */
-	if (!strncmp(SECURITY_PREFIX, prog->aux->attach_func_name,
-		     sizeof(SECURITY_PREFIX) - 1)) {
-
-		if (!capable(CAP_MAC_ADMIN))
-			return -EPERM;
-
+	if (within_error_injection_list(addr) ||
+	    !strncmp(SECURITY_PREFIX, prog->aux->attach_func_name,
+		     sizeof(SECURITY_PREFIX) - 1))
 		return 0;
-	}
 
 	verbose(env, "fmod_ret attach_btf_id %u (%s) is not modifiable\n",
 		prog->aux->attach_btf_id, prog->aux->attach_func_name);
-- 
2.20.1

