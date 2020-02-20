Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C82F166557
	for <lists+bpf@lfdr.de>; Thu, 20 Feb 2020 18:53:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728809AbgBTRxC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 20 Feb 2020 12:53:02 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41539 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728483AbgBTRxB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 20 Feb 2020 12:53:01 -0500
Received: by mail-wr1-f66.google.com with SMTP id c9so5608774wrw.8
        for <bpf@vger.kernel.org>; Thu, 20 Feb 2020 09:52:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lKW2MzukcNPCi/25rtTKAKQ42C5bRG1+jarcaz5NtHI=;
        b=PJruUuRl5SuOo/l2gIEHwBUPO96BpTAQVkJfL0l+k6D0iDONJsn+yPFci1Gdr4yQef
         jZmY71z4UXmArPerDVdjQANLI6j2n7KbUZgqZ6ywhXtbhbCcB9PR+CPmpzs6C1SiSxMT
         v8hmjlWBWRsOx5GFHjCdTzEf3JI8r4J/XQquk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lKW2MzukcNPCi/25rtTKAKQ42C5bRG1+jarcaz5NtHI=;
        b=tSTDzwA9oNzchhYcMPaOb+2t8+TDflo6qfZF2k0nUyA5o8RM9miyVQ/bYty/AOCJ2M
         GvxG/Nbo7VqROeHVoKkhEuzQx7D+rZQkQnag4U0YZV10P4svaGDIuN8C4m7ccVjsKS2t
         zix0cXkEydLd3u3VXiab/FZrsYLHdrsV5AD3NEdudu1UaWF5NC92/ttb4O5NgjgGjBx+
         f2IlVqTZUtKEOlhk4MrfdRpj8BBbWuXC7+b44thLPK9h4ROfDEaaiVfOfe/1VCkFjS3x
         fsWhweDjg1rEemWe0TiNYtG5YrSjLpdppmmnx8gjwdaAkC/ADsADfUzgMtvrXzwgWLv9
         TG3w==
X-Gm-Message-State: APjAAAWm7ihbnI7Gbb9HdjgJvlWYigaTt535aRd/BK7HRcE6/UBAd9v4
        0BICBsnOZFdNTWKEPN/6RYCl5g==
X-Google-Smtp-Source: APXvYqxXDn9Z/x/ZI7GWukZw5C1wH7P8LAjuJiwD5kBuqCEirAfZJYEkwTIYpv03n5kIetKLjLNXgg==
X-Received: by 2002:adf:dc86:: with SMTP id r6mr43903264wrj.68.1582221178664;
        Thu, 20 Feb 2020 09:52:58 -0800 (PST)
Received: from kpsingh-kernel.localdomain ([2620:0:105f:fd00:d960:542a:a1d:648a])
        by smtp.gmail.com with ESMTPSA id r5sm363059wrt.43.2020.02.20.09.52.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 09:52:58 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Thomas Garnier <thgarnie@chromium.org>,
        Michael Halcrow <mhalcrow@google.com>,
        Paul Turner <pjt@google.com>,
        Brendan Gregg <brendan.d.gregg@gmail.com>,
        Jann Horn <jannh@google.com>,
        Matthew Garrett <mjg59@google.com>,
        Christian Brauner <christian@brauner.io>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Stanislav Fomichev <sdf@google.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Andrey Ignatov <rdna@fb.com>, Joe Stringer <joe@wand.net.nz>
Subject: [PATCH bpf-next v4 4/8] bpf: lsm: Add support for enabling/disabling BPF hooks
Date:   Thu, 20 Feb 2020 18:52:46 +0100
Message-Id: <20200220175250.10795-5-kpsingh@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200220175250.10795-1-kpsingh@chromium.org>
References: <20200220175250.10795-1-kpsingh@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: KP Singh <kpsingh@google.com>

Each LSM hook defines a static key i.e. bpf_lsm_<name>
and a bpf_lsm_<name>_set_enabled function to toggle the key
which enables/disables the branch which executes the BPF programs
attached to the LSM hook.

Use of static keys was suggested in upstream discussion:

  https://lore.kernel.org/bpf/1cd10710-a81b-8f9b-696d-aa40b0a67225@iogearbox.net/

and results in the following assembly:

  0x0000000000001e31 <+65>:    jmpq   0x1e36 <security_bprm_check+70>
  0x0000000000001e36 <+70>:    nopl   0x0(%rax,%rax,1)
  0x0000000000001e3b <+75>:    xor    %eax,%eax
  0x0000000000001e3d <+77>:    jmp    0x1e25 <security_bprm_check+53>

which avoids an indirect branch and results in lower overhead which is
especially helpful for LSM hooks in performance hotpaths.

Given the ability to toggle the BPF trampolines, some hooks which do
not call call_<int, void>_hooks as they have different default return
values, also gain support for BPF program attachment.

There are some hooks like security_setprocattr and security_getprocattr
which are not instrumentable as they do not provide any monitoring or
access control decisions. If required, generation of BTF type
information for these hooks can be also be blacklisted.

Signed-off-by: KP Singh <kpsingh@google.com>
---
 include/linux/bpf_lsm.h | 30 +++++++++++++++++++++++++++---
 kernel/bpf/bpf_lsm.c    | 28 ++++++++++++++++++++++++++++
 security/security.c     | 32 ++++++++++++++++++++++++++++++++
 3 files changed, 87 insertions(+), 3 deletions(-)

diff --git a/include/linux/bpf_lsm.h b/include/linux/bpf_lsm.h
index f867f72f6aa9..53dcda8ace01 100644
--- a/include/linux/bpf_lsm.h
+++ b/include/linux/bpf_lsm.h
@@ -8,27 +8,51 @@
 #define _LINUX_BPF_LSM_H
 
 #include <linux/bpf.h>
+#include <linux/jump_label.h>
 
 #ifdef CONFIG_BPF_LSM
 
+#define LSM_HOOK(RET, NAME, ...)		\
+DECLARE_STATIC_KEY_FALSE(bpf_lsm_key_##NAME);   \
+void bpf_lsm_##NAME##_set_enabled(bool value);
+#include <linux/lsm_hook_names.h>
+#undef LSM_HOOK
+
 #define LSM_HOOK(RET, NAME, ...) RET bpf_lsm_##NAME(__VA_ARGS__);
 #include <linux/lsm_hook_names.h>
 #undef LSM_HOOK
 
-#define RUN_BPF_LSM_VOID_PROGS(FUNC, ...) bpf_lsm_##FUNC(__VA_ARGS__)
+#define HAS_BPF_LSM_PROG(FUNC) (static_branch_unlikely(&bpf_lsm_key_##FUNC))
+
+#define RUN_BPF_LSM_VOID_PROGS(FUNC, ...)				\
+	do {								\
+		if (HAS_BPF_LSM_PROG(FUNC))				\
+			bpf_lsm_##FUNC(__VA_ARGS__);			\
+	} while (0)
+
 #define RUN_BPF_LSM_INT_PROGS(RC, FUNC, ...) ({				\
 	do {								\
-		if (RC == 0)						\
-			RC = bpf_lsm_##FUNC(__VA_ARGS__);		\
+		if (HAS_BPF_LSM_PROG(FUNC)) {				\
+			if (RC == 0)					\
+				RC = bpf_lsm_##FUNC(__VA_ARGS__);	\
+		}							\
 	} while (0);							\
 	RC;								\
 })
 
+int bpf_lsm_set_enabled(const char *name, bool value);
+
 #else /* !CONFIG_BPF_LSM */
 
+#define HAS_BPF_LSM_PROG false
 #define RUN_BPF_LSM_INT_PROGS(RC, FUNC, ...) (RC)
 #define RUN_BPF_LSM_VOID_PROGS(FUNC, ...)
 
+static inline int bpf_lsm_set_enabled(const char *name, bool value)
+{
+	return -EOPNOTSUPP;
+}
+
 #endif /* CONFIG_BPF_LSM */
 
 #endif /* _LINUX_BPF_LSM_H */
diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
index abc847c9b9a1..d7c44433c003 100644
--- a/kernel/bpf/bpf_lsm.c
+++ b/kernel/bpf/bpf_lsm.c
@@ -8,6 +8,20 @@
 #include <linux/bpf.h>
 #include <linux/btf.h>
 #include <linux/bpf_lsm.h>
+#include <linux/jump_label.h>
+#include <linux/kallsyms.h>
+
+#define LSM_HOOK(RET, NAME, ...)					\
+	DEFINE_STATIC_KEY_FALSE(bpf_lsm_key_##NAME);			\
+	void bpf_lsm_##NAME##_set_enabled(bool value)			\
+	{								\
+		if (value)						\
+			static_branch_enable(&bpf_lsm_key_##NAME);	\
+		else							\
+			static_branch_disable(&bpf_lsm_key_##NAME);	\
+	}
+#include <linux/lsm_hook_names.h>
+#undef LSM_HOOK
 
 /* For every LSM hook  that allows attachment of BPF programs, declare a NOP
  * function where a BPF program can be attached as an fexit trampoline.
@@ -24,6 +38,20 @@
 #include <linux/lsm_hook_names.h>
 #undef LSM_HOOK
 
+int bpf_lsm_set_enabled(const char *name, bool value)
+{
+	char toggle_fn_name[KSYM_NAME_LEN];
+	void (*toggle_fn)(bool value);
+
+	snprintf(toggle_fn_name, KSYM_NAME_LEN, "%s_set_enabled", name);
+	toggle_fn = (void *)kallsyms_lookup_name(toggle_fn_name);
+	if (!toggle_fn)
+		return -ESRCH;
+
+	toggle_fn(value);
+	return 0;
+}
+
 const struct bpf_prog_ops lsm_prog_ops = {
 };
 
diff --git a/security/security.c b/security/security.c
index aa111392a700..569cc07d5e34 100644
--- a/security/security.c
+++ b/security/security.c
@@ -804,6 +804,13 @@ int security_vm_enough_memory_mm(struct mm_struct *mm, long pages)
 			break;
 		}
 	}
+#ifdef CONFIG_BPF_LSM
+	if (HAS_BPF_LSM_PROG(vm_enough_memory)) {
+		rc = bpf_lsm_vm_enough_memory(mm, pages);
+		if (rc <= 0)
+			cap_sys_admin = 0;
+	}
+#endif
 	return __vm_enough_memory(mm, pages, cap_sys_admin);
 }
 
@@ -1350,6 +1357,13 @@ int security_inode_getsecurity(struct inode *inode, const char *name, void **buf
 		if (rc != -EOPNOTSUPP)
 			return rc;
 	}
+#ifdef CONFIG_BPF_LSM
+	if (HAS_BPF_LSM_PROG(inode_getsecurity)) {
+		rc = bpf_lsm_inode_getsecurity(inode, name, buffer, alloc);
+		if (rc != -EOPNOTSUPP)
+			return rc;
+	}
+#endif
 	return -EOPNOTSUPP;
 }
 
@@ -1369,6 +1383,14 @@ int security_inode_setsecurity(struct inode *inode, const char *name, const void
 		if (rc != -EOPNOTSUPP)
 			return rc;
 	}
+#ifdef CONFIG_BPF_LSM
+	if (HAS_BPF_LSM_PROG(inode_setsecurity)) {
+		rc = bpf_lsm_inode_setsecurity(inode, name, value, size,
+					       flags);
+		if (rc != -EOPNOTSUPP)
+			return rc;
+	}
+#endif
 	return -EOPNOTSUPP;
 }
 
@@ -1754,6 +1776,12 @@ int security_task_prctl(int option, unsigned long arg2, unsigned long arg3,
 				break;
 		}
 	}
+#ifdef CONFIG_BPF_LSM
+	if (HAS_BPF_LSM_PROG(task_prctl)) {
+		if (rc == -ENOSYS)
+			rc = bpf_lsm_task_prctl(option, arg2, arg3, arg4, arg5);
+	}
+#endif
 	return rc;
 }
 
@@ -2334,6 +2362,10 @@ int security_xfrm_state_pol_flow_match(struct xfrm_state *x,
 		rc = hp->hook.xfrm_state_pol_flow_match(x, xp, fl);
 		break;
 	}
+#ifdef CONFIG_BPF_LSM
+	if (HAS_BPF_LSM_PROG(xfrm_state_pol_flow_match))
+		rc = bpf_lsm_xfrm_state_pol_flow_match(x, xp, fl);
+#endif
 	return rc;
 }
 
-- 
2.20.1

