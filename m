Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A45F8177861
	for <lists+bpf@lfdr.de>; Tue,  3 Mar 2020 15:12:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729598AbgCCOKH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 3 Mar 2020 09:10:07 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44854 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729566AbgCCOKG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 3 Mar 2020 09:10:06 -0500
Received: by mail-wr1-f68.google.com with SMTP id n7so4450285wrt.11
        for <bpf@vger.kernel.org>; Tue, 03 Mar 2020 06:10:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nJztjT2MwjynV5KBuohbmspfzqfUKbmH3h8bCyIWmhs=;
        b=g9jr9H6JO5s9LkX1fa0CFDbtx7qCEF3s2HMgd3GvrWwUqXT+aAZFXPbPqojaaxB7CG
         RHwoA79lx7O0RH9RRdX3TJDr+Z4bfuQNi2WlbP9lrarKYlvZH2W357HAXY+ejX6hS6o2
         eSMYjO6GFkBoHBxU6E3df/rkARRnhnl8NywtU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nJztjT2MwjynV5KBuohbmspfzqfUKbmH3h8bCyIWmhs=;
        b=h0ip2w6ltgtpb0eQawHADjda5UnpCoYaQ7I7W2Pd19ch8e/vADE4qBunO1+kBTkbMt
         5wkP0plCEQ9KgUWHbyfCOv9HVduGHUsIGABYxHm1+b4wONlTIcmlHgaNQWT1VIvhOYxI
         Ez2wT/aU7DnkHFGX3oGsisIo2TmOVUOQxPUJXOfdRhGV4sAVSWXWadYQpKSEOtAEarIG
         liaSBRKHrKBknB5UJrFcEUjwLXdO6x+TO6LU++rH9JY/N8ouRM87d7RSNPKOJFmJA68n
         89dREjDCqAcn9BMgXAIU0z335Q21VdpvZRapgXMCevZaibHQ4Oy7/lv2ztDm9aWhEo8T
         rpsQ==
X-Gm-Message-State: ANhLgQ33YvZeO+UR1qXLz8q0wy/HMkVBsWOLiGE1ndipSnjBVD118kud
        S/5EYFbNz/bsJYytGRWtHQxX5w==
X-Google-Smtp-Source: ADFU+vtYc28L9vB45Q1kXQXDXBL3PPh0nBXkSaKXlKK1rQd+rmdd+z2WK+JhQsu3EKP7VWqe2bxStw==
X-Received: by 2002:a5d:61ce:: with SMTP id q14mr5613252wrv.222.1583244604061;
        Tue, 03 Mar 2020 06:10:04 -0800 (PST)
Received: from kpsingh-kernel.localdomain ([2a00:79e1:abc:308:2811:c80d:9375:bf8a])
        by smtp.gmail.com with ESMTPSA id h20sm11746823wrc.47.2020.03.03.06.10.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 06:10:03 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Paul Turner <pjt@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>
Subject: [PATCH bpf-next 4/7] bpf: Attachment verification for BPF_MODIFY_RETURN
Date:   Tue,  3 Mar 2020 15:09:47 +0100
Message-Id: <20200303140950.6355-5-kpsingh@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200303140950.6355-1-kpsingh@chromium.org>
References: <20200303140950.6355-1-kpsingh@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: KP Singh <kpsingh@google.com>

- Functions that are whitlisted by for error injection i.e.
  within_error_injection_list.
- Security hooks, this is expected to be cleaned up after the KRSI
  patches introduce the LSM_HOOK macro:

    https://lore.kernel.org/bpf/20200220175250.10795-1-kpsingh@chromium.org/

- The attachment is currently limited to functions that return an int.
  This can be extended later other types (e.g. PTR).

Signed-off-by: KP Singh <kpsingh@google.com>
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

