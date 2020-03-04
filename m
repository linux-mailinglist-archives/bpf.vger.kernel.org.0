Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A3781798DB
	for <lists+bpf@lfdr.de>; Wed,  4 Mar 2020 20:20:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729302AbgCDTTX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 4 Mar 2020 14:19:23 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37652 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728998AbgCDTTE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 4 Mar 2020 14:19:04 -0500
Received: by mail-wr1-f67.google.com with SMTP id q8so3873905wrm.4
        for <bpf@vger.kernel.org>; Wed, 04 Mar 2020 11:19:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OnY0sLzc6EG75w+2zGbx52f2fr6wBzB9p2HqJRSWjIE=;
        b=KrYHo+/bLsRjUZcEbIkwebji3qt7L79xT3U0cAYrKWEPwSuoqQx9lrwQVmBjPaeNbw
         eQ+/lzkfmqPSd3QW1qa1wfD0mrKx6SlTRjSXWlsGPkaBFMLEr047YBzANy7ElGgtUKjU
         rqjcRgXGtvkONacDRZFLmCfDWFm5CU2B1zaLg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OnY0sLzc6EG75w+2zGbx52f2fr6wBzB9p2HqJRSWjIE=;
        b=nDyQdG5KLAaSNNbmjdRH6x9xZvVbiyRLAiUoWVdynAsI6dY5zCDVEFlVgOk4ECh4pY
         STxkmUABs6PaIOzUZKcMH5b31OKa/35fRBmeUCIqpgFz8f9fIeCv0xGzSOyZhROO28VG
         4CdXIZ6B3xWpxNUjYRHXUx4c6uicKN3PyhMMayuL8WkBJHAgpwj8BLh4bsw7Yo1ttV62
         EluurGlX7sB8CJBBSlm71q4vrrVm6Z3fzYp93cNgIyXtTxpOBODdMe4utZTFLCuuuPhd
         SQLuMkO3gcJcAbuU3aC9hA6yUrOnj1Ip+zH45b4ho9CPo1e36Acu7j0n8+vuGMNkZTUC
         Lh7g==
X-Gm-Message-State: ANhLgQ1scq+DkISG/jsM/YPn6b8YHV4vwHL0QumldK4aPL8rOTM3Gte0
        7flYlVWYbKpcbfIcmd0LHxIzcw==
X-Google-Smtp-Source: ADFU+vvHwAciakiJxwlmepwHyW2J21FSSjWdRYPxPdRLAVA7EUQMGTrOrOYDWbPSeIo+YU+6uqiwjA==
X-Received: by 2002:adf:e9c2:: with SMTP id l2mr5325388wrn.86.1583349542937;
        Wed, 04 Mar 2020 11:19:02 -0800 (PST)
Received: from kpsingh-kernel.localdomain (77-56-209-237.dclient.hispeed.ch. [77.56.209.237])
        by smtp.gmail.com with ESMTPSA id w9sm2018556wrn.35.2020.03.04.11.19.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 11:19:02 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Cc:     Andrii Nakryiko <andriin@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>
Subject: [PATCH bpf-next v4 4/7] bpf: Attachment verification for BPF_MODIFY_RETURN
Date:   Wed,  4 Mar 2020 20:18:50 +0100
Message-Id: <20200304191853.1529-5-kpsingh@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200304191853.1529-1-kpsingh@chromium.org>
References: <20200304191853.1529-1-kpsingh@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: KP Singh <kpsingh@google.com>

- Allow BPF_MODIFY_RETURN attachment only to functions that are:

    * Whitelisted for error injection by checking
      within_error_injection_list. Similar discussions happened for the
      bpf_override_return helper.

    * security hooks, this is expected to be cleaned up with the LSM
      changes after the KRSI patches introduce the LSM_HOOK macro:

        https://lore.kernel.org/bpf/20200220175250.10795-1-kpsingh@chromium.org/

- The attachment is currently limited to functions that return an int.
  This can be extended later other types (e.g. PTR).

Signed-off-by: KP Singh <kpsingh@google.com>
Acked-by: Andrii Nakryiko <andriin@fb.com>
---
 kernel/bpf/btf.c      | 28 ++++++++++++++++++++--------
 kernel/bpf/verifier.c | 31 +++++++++++++++++++++++++++++++
 2 files changed, 51 insertions(+), 8 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 30841fb8b3c0..50080add2ab9 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -3710,14 +3710,26 @@ bool btf_ctx_access(int off, int size, enum bpf_access_type type,
 		nr_args--;
 	}
 
-	if ((prog->expected_attach_type == BPF_TRACE_FEXIT ||
-	     prog->expected_attach_type == BPF_MODIFY_RETURN) &&
-	    arg == nr_args) {
-		if (!t)
-			/* Default prog with 5 args. 6th arg is retval. */
-			return true;
-		/* function return type */
-		t = btf_type_by_id(btf, t->type);
+	if (arg == nr_args) {
+		if (prog->expected_attach_type == BPF_TRACE_FEXIT) {
+			if (!t)
+				return true;
+			t = btf_type_by_id(btf, t->type);
+		} else if (prog->expected_attach_type == BPF_MODIFY_RETURN) {
+			/* For now the BPF_MODIFY_RETURN can only be attached to
+			 * functions that return an int.
+			 */
+			if (!t)
+				return false;
+
+			t = btf_type_skip_modifiers(btf, t->type, NULL);
+			if (!btf_type_is_int(t)) {
+				bpf_log(log,
+					"ret type %s not allowed for fmod_ret\n",
+					btf_kind_str[BTF_INFO_KIND(t->info)]);
+				return false;
+			}
+		}
 	} else if (arg >= nr_args) {
 		bpf_log(log, "func '%s' doesn't have %d-th argument\n",
 			tname, arg + 1);
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 2460c8e6b5be..ae32517d4ccd 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -19,6 +19,7 @@
 #include <linux/sort.h>
 #include <linux/perf_event.h>
 #include <linux/ctype.h>
+#include <linux/error-injection.h>
 
 #include "disasm.h"
 
@@ -9800,6 +9801,33 @@ static int check_struct_ops_btf_id(struct bpf_verifier_env *env)
 
 	return 0;
 }
+#define SECURITY_PREFIX "security_"
+
+static int check_attach_modify_return(struct bpf_verifier_env *env)
+{
+	struct bpf_prog *prog = env->prog;
+	unsigned long addr = (unsigned long) prog->aux->trampoline->func.addr;
+
+	if (within_error_injection_list(addr))
+		return 0;
+
+	/* This is expected to be cleaned up in the future with the KRSI effort
+	 * introducing the LSM_HOOK macro for cleaning up lsm_hooks.h.
+	 */
+	if (!strncmp(SECURITY_PREFIX, prog->aux->attach_func_name,
+		     sizeof(SECURITY_PREFIX) - 1)) {
+
+		if (!capable(CAP_MAC_ADMIN))
+			return -EPERM;
+
+		return 0;
+	}
+
+	verbose(env, "fmod_ret attach_btf_id %u (%s) is not modifiable\n",
+		prog->aux->attach_btf_id, prog->aux->attach_func_name);
+
+	return -EINVAL;
+}
 
 static int check_attach_btf_id(struct bpf_verifier_env *env)
 {
@@ -10000,6 +10028,9 @@ static int check_attach_btf_id(struct bpf_verifier_env *env)
 		}
 		tr->func.addr = (void *)addr;
 		prog->aux->trampoline = tr;
+
+		if (prog->expected_attach_type == BPF_MODIFY_RETURN)
+			ret = check_attach_modify_return(env);
 out:
 		mutex_unlock(&tr->mutex);
 		if (ret)
-- 
2.20.1

