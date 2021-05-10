Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F17A0379557
	for <lists+bpf@lfdr.de>; Mon, 10 May 2021 19:23:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232801AbhEJRYJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 10 May 2021 13:24:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232762AbhEJRYD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 10 May 2021 13:24:03 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C29A5C0613ED;
        Mon, 10 May 2021 10:22:57 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id c10so2683687qtx.10;
        Mon, 10 May 2021 10:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Nm+KuM9ff9d7ka8+7ZtDl8pCOVV7hGgjqFXWjHyaY58=;
        b=fsjib6JFKB1SyB4TqRkLe0oWxCn6a1aMnr343ATb8KbJa7WNWCrgCvWk1DqdmUShU8
         Pv+g+pQxTacxI3WgWyPQv1i2tcRvXE3tWDfxy5HSjnYmZ0y5123dlnOJajG4VXOX8LCm
         PkN3Fqn/x8pg1XHiARTjzmQiHC/tpRSU/6FD5fei9iutaoGdsZDfv4u/vwnIfSYqU4RB
         8NnTOo52srAdZIPVCxkAddbaikyphzE4t5/DqDz2ofo1KgbPtGdDb6E2mHDFmaEwmiLF
         1KFSRo8kBRB3sJOpmaqVnk917oZDw0zYIdOHhLZrQEbLe4NvSCJE4OVdXMJEhL/ZFQj7
         HRlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Nm+KuM9ff9d7ka8+7ZtDl8pCOVV7hGgjqFXWjHyaY58=;
        b=NmWwjwc8yXlXCborf3JMO/02ZHo7FSoSt39Kqk2RwdUiflwoj/9W0woI31Mzdry9My
         yWYiUbiAOMIpH3gZdFyyNBkc25QuU/Ptz/p1aujLzlOEeL92gSXtBAxFrPE+4OcBbaJj
         35PCn2VfewA5JV3gfEeXdRBO0dyu5I7H0pjG/YaJwvNeDg/fBULYHjyU9g0a6YNVvNaF
         GaIgjVhHqO0C7/uMjSd3E35N3znH2AlwsuqkWBHaklpfGqTujpLeFd+sxy8rNZmA78UF
         XjL4CSahJKzdMOAZFPQDzEiADOFZGT8I1T58G7CjfD6b69KFmTxWAdwhRtxll79CmfjO
         Chwg==
X-Gm-Message-State: AOAM530r56kuxpUerHMlE0PdDp0JDrxhfKPXl4DnUeMCKtbSG4hhRdzx
        g0oe857jeK32WIk0TXRE3nc=
X-Google-Smtp-Source: ABdhPJyrRbwmlmB0HmoAXEyUfIQvt7D/1NgpybbDMUmlcNeiDapwTWCT1jz6kOsYOgAoqNEcZWiGSQ==
X-Received: by 2002:ac8:5806:: with SMTP id g6mr24084856qtg.152.1620667377051;
        Mon, 10 May 2021 10:22:57 -0700 (PDT)
Received: from localhost.localdomain (host-173-230-99-154.tnkngak.clients.pavlovmedia.com. [173.230.99.154])
        by smtp.gmail.com with ESMTPSA id q7sm11924367qki.17.2021.05.10.10.22.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 10:22:56 -0700 (PDT)
From:   YiFei Zhu <zhuyifei1999@gmail.com>
To:     containers@lists.linux.dev, bpf@vger.kernel.org
Cc:     YiFei Zhu <yifeifz2@illinois.edu>,
        linux-security-module@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Austin Kuo <hckuo2@illinois.edu>,
        Claudio Canella <claudio.canella@iaik.tugraz.at>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Daniel Gruss <daniel.gruss@iaik.tugraz.at>,
        Dimitrios Skarlatos <dskarlat@cs.cmu.edu>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Hubertus Franke <frankeh@us.ibm.com>,
        Jann Horn <jannh@google.com>,
        Jinghao Jia <jinghao7@illinois.edu>,
        Josep Torrellas <torrella@illinois.edu>,
        Kees Cook <keescook@chromium.org>,
        Sargun Dhillon <sargun@sargun.me>,
        Tianyin Xu <tyxu@illinois.edu>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Tom Hromatka <tom.hromatka@oracle.com>,
        Will Drewry <wad@chromium.org>
Subject: [RFC PATCH bpf-next seccomp 03/12] seccomp, ptrace: Add a mechanism to retrieve attached eBPF seccomp filters
Date:   Mon, 10 May 2021 12:22:40 -0500
Message-Id: <b09d7033ae669b3611edd13899d59d1cc437fbf6.1620499942.git.yifeifz2@illinois.edu>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1620499942.git.yifeifz2@illinois.edu>
References: <cover.1620499942.git.yifeifz2@illinois.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Sargun Dhillon <sargun@sargun.me>

This extends the ptrace API to allow fetching eBPF seccomp filters
attached to programs. This is to enable checkpoint / restore cases.
The user will have to use the traditional PTRACE_SECCOMP_GET_FILTER
API call, and if they get an invalid medium type error they can switch
over to the eBPF variant of the API -- PTRACE_SECCOMP_GET_FILTER_EXTENDED.

Signed-off-by: Sargun Dhillon <sargun@sargun.me>
Link: https://lists.linux-foundation.org/pipermail/containers/2018-February/038478.html
[YiFei: increase ptrace number to 0x4210]
Signed-off-by: YiFei Zhu <yifeifz2@illinois.edu>
---
 include/linux/seccomp.h     | 12 ++++++++++++
 include/uapi/linux/ptrace.h |  2 ++
 kernel/ptrace.c             |  4 ++++
 kernel/seccomp.c            | 37 +++++++++++++++++++++++++++++++++++++
 4 files changed, 55 insertions(+)

diff --git a/include/linux/seccomp.h b/include/linux/seccomp.h
index c0750dc05de5..7ce9e3b3fa80 100644
--- a/include/linux/seccomp.h
+++ b/include/linux/seccomp.h
@@ -122,6 +122,18 @@ static inline long seccomp_get_metadata(struct task_struct *task,
 	return -EINVAL;
 }
 #endif /* CONFIG_SECCOMP_FILTER && CONFIG_CHECKPOINT_RESTORE */
+#if defined(CONFIG_SECCOMP_FILTER_EXTENDED) && defined(CONFIG_CHECKPOINT_RESTORE)
+extern long seccomp_get_filter_extended(struct task_struct *task,
+					unsigned long n,
+					void __user *data);
+#else
+static inline long seccomp_get_filter_extended(struct task_struct *task,
+					       unsigned long n,
+					       void __user *data)
+{
+	return -EINVAL;
+}
+#endif /* CONFIG_SECCOMP_FILTER_EXTENDED && CONFIG_CHECKPOINT_RESTORE */
 
 #ifdef CONFIG_SECCOMP_CACHE_DEBUG
 struct seq_file;
diff --git a/include/uapi/linux/ptrace.h b/include/uapi/linux/ptrace.h
index 3747bf816f9a..725a03614c28 100644
--- a/include/uapi/linux/ptrace.h
+++ b/include/uapi/linux/ptrace.h
@@ -112,6 +112,8 @@ struct ptrace_rseq_configuration {
 	__u32 pad;
 };
 
+#define PTRACE_SECCOMP_GET_FILTER_EXTENDED	0x4210
+
 /*
  * These values are stored in task->ptrace_message
  * by tracehook_report_syscall_* to describe the current syscall-stop.
diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index 76f09456ec4b..1e8d2155231f 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -1247,6 +1247,10 @@ int ptrace_request(struct task_struct *child, long request,
 		break;
 #endif
 
+	case PTRACE_SECCOMP_GET_FILTER_EXTENDED:
+		ret = seccomp_get_filter_extended(child, addr, datavp);
+		break;
+
 	default:
 		break;
 	}
diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index 1ef26a5bf93f..8550ae885245 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -2168,6 +2168,43 @@ long seccomp_get_metadata(struct task_struct *task,
 }
 #endif
 
+#if defined(CONFIG_SECCOMP_FILTER_EXTENDED) && defined(CONFIG_CHECKPOINT_RESTORE)
+long seccomp_get_filter_extended(struct task_struct *task,
+				 unsigned long filter_off,
+				 void __user *data)
+{
+	struct seccomp_filter *filter;
+	struct bpf_prog *prog;
+	long ret;
+
+	if (!capable(CAP_SYS_ADMIN) ||
+	    current->seccomp.mode != SECCOMP_MODE_DISABLED) {
+		return -EACCES;
+	}
+
+	filter = get_nth_filter(task, filter_off);
+	if (IS_ERR(filter))
+		return PTR_ERR(filter);
+
+	if (bpf_prog_was_classic(filter->prog)) {
+		ret = -EMEDIUMTYPE;
+		goto out;
+	}
+	prog = bpf_prog_inc_not_zero(filter->prog);
+	if (IS_ERR(prog)) {
+		ret = PTR_ERR(prog);
+		goto out;
+	}
+
+	ret = bpf_prog_new_fd(filter->prog);
+	if (ret < 0)
+		bpf_prog_put(prog);
+out:
+	__put_seccomp_filter(filter);
+	return ret;
+}
+#endif
+
 #ifdef CONFIG_SYSCTL
 
 /* Human readable action names for friendly sysctl interaction */
-- 
2.31.1

