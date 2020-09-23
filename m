Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F0F2276484
	for <lists+bpf@lfdr.de>; Thu, 24 Sep 2020 01:31:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbgIWX3l (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 23 Sep 2020 19:29:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726749AbgIWX3b (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 23 Sep 2020 19:29:31 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 815EAC0613D2
        for <bpf@vger.kernel.org>; Wed, 23 Sep 2020 16:29:31 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id bw23so584576pjb.2
        for <bpf@vger.kernel.org>; Wed, 23 Sep 2020 16:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZE/79qG6H6lRxtOX3Wkl7bfi0pnZJM8pQYKGylI4ASw=;
        b=bfAu8zmgfDT6BYa5AFuGjf5HULT1RoGX5U1MHYBaJnsDPZIqHGceGVjIq0QrWYsXIN
         1nBIJcYwVXI/M/1TjzCxBqSwMVufR5fhXA7ESw3zg0MsBcR9YmbOnfl/dmqa5ZQdhGUH
         ueFBHPnxoz7qOSdPu1rvnb8vHu9CQAEMJn3Nk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZE/79qG6H6lRxtOX3Wkl7bfi0pnZJM8pQYKGylI4ASw=;
        b=VwDXCEAVh+3ay3ZU/rZslEcyD3LUn9cQQwtFJmLfEZwH04yXbtchEXrp7ZYWbraXWA
         jMKC83vPnt1iS6Ml1B++NpFvmJNYg4/pwjZlFyUx7DCwWl6bzIVKorrXAJYXEac7ttYL
         1qHLWlJg8KfmW9hFtnLNwStREFe1Da7ty30THYnpqvkc4TJNCy5UEECTfTIB8SufQXF6
         +36W6qfKux8WaSNEylFR6RUVi8PckiKDSMM3UPlth1yGWg4N2ujmN70D5Q+cHK2f8/rD
         +4uIaqkuc5qZRMN8XWjuY0iwQqySD/b6cI6HR3QIjw6Nplgx+XsXzYscSR52YCjcsv08
         RqnQ==
X-Gm-Message-State: AOAM533R4nMG4o2qpnC++qUodMXpQ5CDsWxJKVr2TChfemBbXBp3+Al+
        xwgitToT7fr+1EpVW4DX36YYWA==
X-Google-Smtp-Source: ABdhPJwhKgUZq608+q5NwYON4+CAPcXtEBNdHupkMvWVr63aqwYCkQW/0sNAogHldmRsrQqXgPaIjA==
X-Received: by 2002:a17:902:c692:b029:d0:90a3:24f4 with SMTP id r18-20020a170902c692b02900d090a324f4mr1951226plx.12.1600903771027;
        Wed, 23 Sep 2020 16:29:31 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z1sm669570pfj.113.2020.09.23.16.29.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2020 16:29:30 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     YiFei Zhu <yifeifz2@illinois.edu>
Cc:     Kees Cook <keescook@chromium.org>, Jann Horn <jannh@google.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Tycho Andersen <tycho@tycho.pizza>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Dimitrios Skarlatos <dskarlat@cs.cmu.edu>,
        Valentin Rothberg <vrothber@redhat.com>,
        Hubertus Franke <frankeh@us.ibm.com>,
        Jack Chen <jianyan2@illinois.edu>,
        Josep Torrellas <torrella@illinois.edu>,
        Tianyin Xu <tyxu@illinois.edu>, bpf@vger.kernel.org,
        containers@lists.linux-foundation.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] [DEBUG] seccomp: Report bitmap coverage ranges
Date:   Wed, 23 Sep 2020 16:29:23 -0700
Message-Id: <20200923232923.3142503-7-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200923232923.3142503-1-keescook@chromium.org>
References: <20200923232923.3142503-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This is what I've been using to explore actual bitmap results for
real-world filters...

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 kernel/seccomp.c | 115 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 115 insertions(+)

diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index 9921f6f39d12..1a0595d7f8ef 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -835,6 +835,85 @@ static void seccomp_update_bitmap(struct seccomp_filter *filter,
 	}
 }
 
+static void __report_bitmap(const char *arch, u32 ret, int start, int finish)
+{
+	int gap;
+	char *name;
+
+	if (finish == -1)
+		return;
+
+	switch (ret) {
+	case UINT_MAX:
+		name = "filter";
+		break;
+	case SECCOMP_RET_ALLOW:
+		name = "SECCOMP_RET_ALLOW";
+		break;
+	case SECCOMP_RET_KILL_PROCESS:
+		name = "SECCOMP_RET_KILL_PROCESS";
+		break;
+	case SECCOMP_RET_KILL_THREAD:
+		name = "SECCOMP_RET_KILL_THREAD";
+		break;
+	default:
+		WARN_ON_ONCE(1);
+		name = "unknown";
+		break;
+	}
+
+	gap = 0;
+	if (start < 100)
+		gap++;
+	if (start < 10)
+		gap++;
+	if (finish < 100)
+		gap++;
+	if (finish < 10)
+		gap++;
+
+	if (start == finish)
+		pr_info("%s     %3d: %s\n", arch, start, name);
+	else if (start + 1 == finish)
+		pr_info("%s %*s%d,%d: %s\n", arch, gap, "", start, finish, name);
+	else
+		pr_info("%s %*s%d-%d: %s\n", arch, gap, "", start, finish, name);
+}
+
+static void report_bitmap(struct seccomp_bitmaps *bitmaps, const char *arch)
+{
+	u32 nr;
+	int start = 0, finish = -1;
+	u32 ret = UINT_MAX;
+	struct report_states {
+		unsigned long *bitmap;
+		u32 ret;
+	} states[] = {
+		{ .bitmap = bitmaps->allow,	   .ret = SECCOMP_RET_ALLOW, },
+		{ .bitmap = bitmaps->kill_process, .ret = SECCOMP_RET_KILL_PROCESS, },
+		{ .bitmap = bitmaps->kill_thread,  .ret = SECCOMP_RET_KILL_THREAD, },
+		{ .bitmap = NULL,		   .ret = UINT_MAX, },
+	};
+
+	for (nr = 0; nr < NR_syscalls; nr++) {
+		int i;
+
+		for (i = 0; i < ARRAY_SIZE(states); i++) {
+			if (!states[i].bitmap || test_bit(nr, states[i].bitmap)) {
+				if (ret != states[i].ret) {
+					__report_bitmap(arch, ret, start, finish);
+					ret = states[i].ret;
+					start = nr;
+				}
+				finish = nr;
+				break;
+			}
+		}
+	}
+	if (start != nr)
+		__report_bitmap(arch, ret, start, finish);
+}
+
 static void seccomp_update_bitmaps(struct seccomp_filter *filter,
 				   void *pagepair)
 {
@@ -849,6 +928,23 @@ static void seccomp_update_bitmaps(struct seccomp_filter *filter,
 			      SECCOMP_MULTIPLEXED_SYSCALL_TABLE_MASK,
 			      &current->seccomp.multiplex);
 #endif
+	if (strncmp(current->comm, "test-", 5) == 0 ||
+	    strcmp(current->comm, "seccomp_bpf") == 0 ||
+	    /*
+	     * Why are systemd's process names head-truncated to 8 bytes
+	     * and wrapped in parens!?
+	     */
+	    (current->comm[0] == '(' && strrchr(current->comm, ')') != NULL)) {
+		pr_info("reporting syscall bitmap usage for %d (%s):\n",
+			task_pid_nr(current), current->comm);
+		report_bitmap(&current->seccomp.native, "native");
+#ifdef CONFIG_COMPAT
+		report_bitmap(&current->seccomp.compat, "compat");
+#endif
+#ifdef SECCOMP_MULTIPLEXED_SYSCALL_TABLE_ARCH
+		report_bitmap(&current->seccomp.multiplex, "multiplex");
+#endif
+	}
 }
 #else
 static void seccomp_update_bitmaps(struct seccomp_filter *filter,
@@ -908,6 +1004,10 @@ static long seccomp_attach_filter(unsigned int flags,
 	filter->prev = current->seccomp.filter;
 	current->seccomp.filter = filter;
 	atomic_inc(&current->seccomp.filter_count);
+	if (atomic_read(&current->seccomp.filter_count) > 10)
+		pr_info("%d filters: %d (%s)\n",
+			atomic_read(&current->seccomp.filter_count),
+			task_pid_nr(current), current->comm);
 
 	/* Evaluate filter for new known-outcome syscalls */
 	seccomp_update_bitmaps(filter, pagepair);
@@ -2419,6 +2519,21 @@ static int __init seccomp_sysctl_init(void)
 		pr_warn("sysctl registration failed\n");
 	else
 		kmemleak_not_leak(hdr);
+#ifndef SECCOMP_ARCH
+	pr_info("arch lacks support for constant action bitmaps\n");
+#else
+	pr_info("NR_syscalls: %d\n", NR_syscalls);
+	pr_info("arch: 0x%x\n", SECCOMP_ARCH);
+#ifdef CONFIG_COMPAT
+	pr_info("compat arch: 0x%x\n", SECCOMP_ARCH_COMPAT);
+#endif
+#ifdef SECCOMP_MULTIPLEXED_SYSCALL_TABLE_ARCH
+	pr_info("multiplex arch: 0x%x (mask: 0x%x)\n",
+		SECCOMP_MULTIPLEXED_SYSCALL_TABLE_ARCH,
+		SECCOMP_MULTIPLEXED_SYSCALL_TABLE_MASK);
+#endif
+#endif
+	pr_info("sizeof(struct seccomp_bitmaps): %zu\n", sizeof(struct seccomp_bitmaps));
 
 	return 0;
 }
-- 
2.25.1

