Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26CBC379564
	for <lists+bpf@lfdr.de>; Mon, 10 May 2021 19:23:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231908AbhEJRYf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 10 May 2021 13:24:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232783AbhEJRYK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 10 May 2021 13:24:10 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73574C061763;
        Mon, 10 May 2021 10:23:05 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id a22so15524839qkl.10;
        Mon, 10 May 2021 10:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cX52Zs/xDsiq7rE6ph9VA8cUYUpw0YB0S2ZUk1qpvmc=;
        b=vIeg2VmImJPDTqp/NxQuqgMD47fn10g6oqPN4/D23lmD83s5AbYtXiqT4xi3cxQWwQ
         kA7/Zm0j91GNbdpXxtRMZIgfh4wi8jLESXWJ6SS8JkSRdyMchgMK2+YFPNJJh0Igb4DD
         vr27WPQHkjmJJe+YV19pKplElTiGT9l3KJMAhikqFw6bHHCBBDq5x5yBCYq/2m4JwbLW
         HWWi4Vn3Mc2tQzkkxjxRTeo8rdsHxWX0E8VSFCsUsmpc1Xhctr0aHKjhI5ul3C5sGDrC
         yiUOQOXvBgp8WgfUfOk9VicYLRZaJOF9A5cw9mE37Ix6BrwUTGzDeifefvZ9C60DT4ZK
         N9CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cX52Zs/xDsiq7rE6ph9VA8cUYUpw0YB0S2ZUk1qpvmc=;
        b=k2qQdi8uUxbxc5nJUyB1t93kDJwwxy/15wWhjCAcyvuhplcSz1MqXRMRD1HKtyvsAn
         DkffxvhH3ar5yYdY7owKnXpm5jxQ+KLORwy4UXrzzZSQyBAumwd3QXpDZSY4FCxSk4JX
         l5jizbcF3VdyStSJdZP93JNHxrQv+JQygN1bAtmmdY7sX36c43KmApXaNUyq5oFsjci7
         nHPZtBwCNP0V12F9O4cF7bKjoL7tfoTIvKcO0AQ0EmVRh3Wv1SICXV3Ze7hzwQioq/hc
         PfK4Maicfdspis+T1/zR8eVjwdf0Vxnfq5VzLnYckeiqJ0kFEbIga7uFOXTcPvb1LUxc
         kXrg==
X-Gm-Message-State: AOAM531j7GefVKRfcdeSu241uZfwfqFZ0rWXQvAjAxRvgzGk2PgkBFLl
        wRGYhDnZqE8eSl8ET6tP/QR/ozNSNgLC3abk
X-Google-Smtp-Source: ABdhPJzMd3Ycz3/4IwsWCcmCOykOGaViFf5Pq5ljtHvY21Ye4p7MT6H0wZPExMpUeToIk8ZkAuuyBw==
X-Received: by 2002:a37:43d4:: with SMTP id q203mr24178322qka.124.1620667384566;
        Mon, 10 May 2021 10:23:04 -0700 (PDT)
Received: from localhost.localdomain (host-173-230-99-154.tnkngak.clients.pavlovmedia.com. [173.230.99.154])
        by smtp.gmail.com with ESMTPSA id q7sm11924367qki.17.2021.05.10.10.23.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 10:23:04 -0700 (PDT)
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
Subject: [RFC PATCH bpf-next seccomp 09/12] yama: (concept) restrict seccomp-eBPF with ptrace_scope
Date:   Mon, 10 May 2021 12:22:46 -0500
Message-Id: <d753bba7dc730c5244962f5c98dd00bc0d4c99d6.1620499942.git.yifeifz2@illinois.edu>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1620499942.git.yifeifz2@illinois.edu>
References: <cover.1620499942.git.yifeifz2@illinois.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: YiFei Zhu <yifeifz2@illinois.edu>

LSM hook seccomp_extended is made to return -EPERM if the current
process may not ptrace its children, depending on the value of
ptrace_scope and CAP_SYS_PTRACE capability.

I'm not sure if this is the right way to do it, since ptrace_scope
is about ptrace and not seccomp. Is there a better policy that would
make more sense?

Signed-off-by: YiFei Zhu <yifeifz2@illinois.edu>
---
 security/yama/yama_lsm.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/security/yama/yama_lsm.c b/security/yama/yama_lsm.c
index 06e226166aab..3b7b408b47a3 100644
--- a/security/yama/yama_lsm.c
+++ b/security/yama/yama_lsm.c
@@ -421,9 +421,39 @@ static int yama_ptrace_traceme(struct task_struct *parent)
 	return rc;
 }
 
+#ifdef CONFIG_SECCOMP_FILTER_EXTENDED
+static int yama_seccomp_extended(void)
+{
+	int rc = 0;
+
+	/* seccomp filter attach can only affect itself and children */
+	switch (ptrace_scope) {
+	case YAMA_SCOPE_DISABLED:
+	case YAMA_SCOPE_RELATIONAL:
+		/* No additional restrictions. */
+		break;
+	case YAMA_SCOPE_CAPABILITY:
+		rcu_read_lock();
+		if (!ns_capable(current_user_ns(), CAP_SYS_PTRACE))
+			rc = -EPERM;
+		rcu_read_unlock();
+		break;
+	case YAMA_SCOPE_NO_ATTACH:
+	default:
+		rc = -EPERM;
+		break;
+	}
+
+	return rc;
+}
+#endif /* CONFIG_SECCOMP_FILTER_EXTENDED */
+
 static struct security_hook_list yama_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(ptrace_access_check, yama_ptrace_access_check),
 	LSM_HOOK_INIT(ptrace_traceme, yama_ptrace_traceme),
+#ifdef CONFIG_SECCOMP_FILTER_EXTENDED
+	LSM_HOOK_INIT(seccomp_extended, yama_seccomp_extended),
+#endif
 	LSM_HOOK_INIT(task_prctl, yama_task_prctl),
 	LSM_HOOK_INIT(task_free, yama_task_free),
 };
-- 
2.31.1

