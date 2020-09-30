Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1590A27EC7E
	for <lists+bpf@lfdr.de>; Wed, 30 Sep 2020 17:27:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729432AbgI3PUp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 30 Sep 2020 11:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729351AbgI3PUc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 30 Sep 2020 11:20:32 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94E23C061755;
        Wed, 30 Sep 2020 08:20:32 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id k6so2210379ior.2;
        Wed, 30 Sep 2020 08:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AThlbV8qSIf//EFg3le7/Kv8iNlRjvJHI5D0t9AJZm8=;
        b=WAIVZfAyst0tKhF9rP+a6GZ+1JKCLVToxPDvriVX3CfSR+N3Xd6eMx+ty3tny7GcQX
         Ox0ZwqAzeN9LprFtrND1a43fsROAkb06iKQnUVhQ+6308rCs33JcrgNiXG2E4BXkGOW+
         Da5kBXuylCu+EJnHnu4DodHho0uQsQ7U2CXPjgtT8tRH6nLserbvWx/b7mH6EITU6xCw
         Lj/Unacm/R864IYgL21+F2Zxt4Hm2yc8eW7zsqUI8mj2aXsP0X5XaFl7CZSBcQv/UXDA
         CQmHuaXTcI2lVPGJ6g6+9M/ltyubt8DetU3jMrh1xULbP0DyAtxUbZVjajpdC/5bd7zp
         1EIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AThlbV8qSIf//EFg3le7/Kv8iNlRjvJHI5D0t9AJZm8=;
        b=cTc3AaxMx4t2wGj67+G40zoRnN4w5ojGtx516++2MwHOZ0qD+C6TOmc//kydK9Pi5p
         TpkAdtNKmiYiPgEHxqIY7LqE+TKX0o+gKyo95xwC5XvOwyUCF9phJDRCpTyFAZqAH0tV
         gCKuDJZyYe43SZivC7F8FRDaXrrcCid+cV5BBUv+hlw8dE3tnl4yOdpBoZ902o3TfMYs
         yOg7PHSq97HDlOknhRkInZyAckoSxLicTn0TlWFTnASyuCmD42oLxLcQgBrOBafoGDL2
         wobb0TX+tnv591KLJV867yumYqZCMjY9JOmvAdzkFnyjTu8z2SQ3QVvXQginzNn5Elge
         jDqw==
X-Gm-Message-State: AOAM532Ga5Z0wLt8pB9nJORWauo03f1mCT7zF1n+LEd6xQGoKolz/RRV
        IwM75WlWQs6QaAPPjDlptwI=
X-Google-Smtp-Source: ABdhPJzWaCyTch/tKZaigzg6FeIVXvEYSGeGYLTEGOfVr8Nx/Z0PJIexqASFa5s5Jud5vcYxyB44VA==
X-Received: by 2002:a05:6638:da:: with SMTP id w26mr2363943jao.137.1601479231865;
        Wed, 30 Sep 2020 08:20:31 -0700 (PDT)
Received: from localhost.localdomain (ip-99-203-15-156.pools.cgn.spcsdns.net. [99.203.15.156])
        by smtp.gmail.com with ESMTPSA id t10sm770788iog.49.2020.09.30.08.20.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 08:20:31 -0700 (PDT)
From:   YiFei Zhu <zhuyifei1999@gmail.com>
To:     containers@lists.linux-foundation.org
Cc:     YiFei Zhu <yifeifz2@illinois.edu>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        David Laight <David.Laight@aculab.com>,
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
Subject: [PATCH v3 seccomp 3/5] seccomp/cache: Lookup syscall allowlist for fast path
Date:   Wed, 30 Sep 2020 10:19:14 -0500
Message-Id: <83c72471f9f79fa982508bd4db472686a67b8320.1601478774.git.yifeifz2@illinois.edu>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1601478774.git.yifeifz2@illinois.edu>
References: <cover.1601478774.git.yifeifz2@illinois.edu>
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
 kernel/seccomp.c | 52 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index f09c9e74ae05..bed3b2a7f6c8 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -172,6 +172,12 @@ struct seccomp_cache_filter_data { };
 static inline void seccomp_cache_prepare(struct seccomp_filter *sfilter)
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
@@ -331,6 +337,49 @@ static int seccomp_check_filter(struct sock_filter *filter, unsigned int flen)
 	return 0;
 }
 
+#ifdef CONFIG_SECCOMP_CACHE_NR_ONLY
+static bool seccomp_cache_check_bitmap(const void *bitmap, size_t bitmap_size,
+				       int syscall_nr)
+{
+	if (unlikely(syscall_nr < 0 || syscall_nr >= bitmap_size))
+		return false;
+	syscall_nr = array_index_nospec(syscall_nr, bitmap_size);
+
+	return test_bit(syscall_nr, bitmap);
+}
+
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
+	const struct seccomp_cache_filter_data *cache = &sfilter->cache;
+
+#ifdef SECCOMP_ARCH_DEFAULT
+	if (likely(sd->arch == SECCOMP_ARCH_DEFAULT))
+		return seccomp_cache_check_bitmap(cache->syscall_allow_default,
+						  SECCOMP_ARCH_DEFAULT_NR,
+						  syscall_nr);
+#endif /* SECCOMP_ARCH_DEFAULT */
+
+#ifdef SECCOMP_ARCH_COMPAT
+	if (likely(sd->arch == SECCOMP_ARCH_COMPAT))
+		return seccomp_cache_check_bitmap(cache->syscall_allow_compat,
+						  SECCOMP_ARCH_COMPAT_NR,
+						  syscall_nr);
+#endif /* SECCOMP_ARCH_COMPAT */
+
+	WARN_ON_ONCE(true);
+	return false;
+}
+#endif /* CONFIG_SECCOMP_CACHE_NR_ONLY */
+
 /**
  * seccomp_run_filters - evaluates all seccomp filters against @sd
  * @sd: optional seccomp data to be passed to filters
@@ -353,6 +402,9 @@ static u32 seccomp_run_filters(const struct seccomp_data *sd,
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

