Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09C9127719B
	for <lists+bpf@lfdr.de>; Thu, 24 Sep 2020 14:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727829AbgIXMoz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 24 Sep 2020 08:44:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727820AbgIXMop (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 24 Sep 2020 08:44:45 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06491C0613CE;
        Thu, 24 Sep 2020 05:44:45 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id y9so3000622ilq.2;
        Thu, 24 Sep 2020 05:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l5sZSI+cLE2joNnPykw3MJU/gzivLj0GX9Q9hGA5pVs=;
        b=do2eV7guKNVRVckBf3Qfgxpk/b3ON9tjlGe5E57+r1XmL7t/D5Kw5KdZ5uZbhjS1Ff
         QN0OB9vDaxjoBHoNISHtwjZkYjJhcOvuwq7phhDPiFl0X78WFGCOASDBa5khLnQZYNPm
         UiLhV9gs9CCVHZg9bYlt+/5X8Y6AEGDJNTCrkyszULDF1aC+PIjShWf3ODB/iyVwQMtu
         24alqEDxI6BWef3lFhd6g7eQdorBv7AUCIEMY8KsgHMB6dhVngX/5p2+hVZ4MQE2Bmp2
         QylQd+CTvWFDivAicsUJD9I76oXNjqgJzciXs+NXTr1SVYHKYHsW3d4YEtEbl8YvwW7k
         fFlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l5sZSI+cLE2joNnPykw3MJU/gzivLj0GX9Q9hGA5pVs=;
        b=X9EAr+7RE38yDBxijH6tiB17c1UQOw6dIsytl6hodCNgmIFYhM4NOsR/ijP/w6ckFX
         Z4fd/euClphNVfFgcjd2NFaWzg0KTwuQJXhjSCqbKWIDLnE6vZS4JY3I6WmRkf8JvgIx
         BtPtLRuFEuUyrYG5bjdIsr+hiH+U3J7fOFq4gQJ2wTN3seQ8q0UUfJi4gSziud5aqsY1
         w9ifcRoGCSVs5DQHAi2XuHxQpky8NfEWm2T541pG4u9qbWWQGO5PFhYgEQWLVr+1AjGD
         k/K43k0Il1CR+6cqX/SaDk9mLUlHDtg8Ykm9T/s8xXpSga/3PK3P7aJubRE60qPOctsW
         WRSA==
X-Gm-Message-State: AOAM531w5nTO+52jWsdSNir927P7for/wz7Zz8TC1sepWhFMo71GyU3/
        RTcM8em9HVKbasv2F+md97CjrReLIIUTqw==
X-Google-Smtp-Source: ABdhPJxpBnD87qzZx6pccGeAQzN1T2pWR8/PeSQiL6zBbati5Zbhu9BAc67rqhD1Wk2L+0muJEHyqg==
X-Received: by 2002:a05:6e02:f48:: with SMTP id y8mr3911683ilj.103.1600951484344;
        Thu, 24 Sep 2020 05:44:44 -0700 (PDT)
Received: from localhost.localdomain (host-173-230-99-154.tnkngak.clients.pavlovmedia.com. [173.230.99.154])
        by smtp.gmail.com with ESMTPSA id p5sm1575175ilg.32.2020.09.24.05.44.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 05:44:43 -0700 (PDT)
From:   YiFei Zhu <zhuyifei1999@gmail.com>
To:     containers@lists.linux-foundation.org
Cc:     YiFei Zhu <yifeifz2@illinois.edu>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Dimitrios Skarlatos <dskarlat@cs.cmu.edu>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Hubertus Franke <frankeh@us.ibm.com>,
        Jack Chen <jianyan2@illinois.edu>,
        Jann Horn <jannh@google.com>,
        Josep Torrellas <torrella@illinois.edu>,
        Kees Cook <keescook@chromium.org>,
        Tianyin Xu <tyxu@illinois.edu>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Tycho Andersen <tycho@tycho.pizza>,
        Valentin Rothberg <vrothber@redhat.com>,
        Will Drewry <wad@chromium.org>
Subject: [PATCH v2 seccomp 4/6] seccomp/cache: Lookup syscall allowlist for fast path
Date:   Thu, 24 Sep 2020 07:44:19 -0500
Message-Id: <64052a5b81d5dacd63efb577c1d99e6f98e69702.1600951211.git.yifeifz2@illinois.edu>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1600951211.git.yifeifz2@illinois.edu>
References: <cover.1600951211.git.yifeifz2@illinois.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: YiFei Zhu <yifeifz2@illinois.edu>

The fast (common) path for seccomp should be that the filter permits
the syscall to pass through, and failing seccomp is expected to be
an exceptional case; it is not expected for userspace to call a
denylisted syscall over and over.

This first finds the current allow bitmask by iterating through
syscall_arches[] array and comparing it to the one in struct
seccomp_data; this loop is expected to be unrolled. It then
does a test_bit against the bitmask. If the bit is set, then
there is no need to run the full filter; it returns
SECCOMP_RET_ALLOW immediately.

Co-developed-by: Dimitrios Skarlatos <dskarlat@cs.cmu.edu>
Signed-off-by: Dimitrios Skarlatos <dskarlat@cs.cmu.edu>
Signed-off-by: YiFei Zhu <yifeifz2@illinois.edu>
---
 kernel/seccomp.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index 20d33378a092..ac0266b6d18a 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -167,6 +167,12 @@ static inline void seccomp_cache_inherit(struct seccomp_filter *sfilter,
 					 const struct seccomp_filter *prev)
 {
 }
+
+static inline bool seccomp_cache_check(const struct seccomp_filter *sfilter,
+				       const struct seccomp_data *sd)
+{
+	return false;
+}
 #endif /* CONFIG_SECCOMP_CACHE_NR_ONLY */
 
 /**
@@ -321,6 +327,34 @@ static int seccomp_check_filter(struct sock_filter *filter, unsigned int flen)
 	return 0;
 }
 
+#ifdef CONFIG_SECCOMP_CACHE_NR_ONLY
+/**
+ * seccomp_cache_check - lookup seccomp cache
+ * @sfilter: The seccomp filter
+ * @sd: The seccomp data to lookup the cache with
+ *
+ * Returns true if the seccomp_data is cached and allowed.
+ */
+static bool seccomp_cache_check(const struct seccomp_filter *sfilter,
+				const struct seccomp_data *sd)
+{
+	int syscall_nr = sd->nr;
+	int arch;
+
+	if (unlikely(syscall_nr < 0 || syscall_nr >= NR_syscalls))
+		return false;
+
+	for (arch = 0; arch < ARRAY_SIZE(syscall_arches); arch++) {
+		if (likely(syscall_arches[arch] == sd->arch))
+			return test_bit(syscall_nr,
+					sfilter->cache.syscall_ok[arch]);
+	}
+
+	WARN_ON_ONCE(true);
+	return false;
+}
+#endif /* CONFIG_SECCOMP_CACHE_NR_ONLY */
+
 /**
  * seccomp_run_filters - evaluates all seccomp filters against @sd
  * @sd: optional seccomp data to be passed to filters
@@ -343,6 +377,9 @@ static u32 seccomp_run_filters(const struct seccomp_data *sd,
 	if (WARN_ON(f == NULL))
 		return SECCOMP_RET_KILL_PROCESS;
 
+	if (seccomp_cache_check(f, sd))
+		return SECCOMP_RET_ALLOW;
+
 	/*
 	 * All filters in the list are evaluated and the lowest BPF return
 	 * value always takes priority (ignoring the DATA).
-- 
2.28.0

