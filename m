Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C883C277092
	for <lists+bpf@lfdr.de>; Thu, 24 Sep 2020 14:07:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727495AbgIXMG6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 24 Sep 2020 08:06:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726406AbgIXMGz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 24 Sep 2020 08:06:55 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90F7CC0613CE;
        Thu, 24 Sep 2020 05:06:55 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id r9so3039584ioa.2;
        Thu, 24 Sep 2020 05:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SYKa1nrEaZaYwZ8wYDMo+wGBRjI8YKJTKmH+OljJTGg=;
        b=r9uakENVZx3FshPV+JWxKdMA/UFifGO75CEByTaA1MQ7piwbKpqOgJyuN5h4qIsH6L
         AR1TMSH0M8ESEauKZ3CoROg4wA1sf1sd65zjzUrwfDJ7He2gW2hVB4rAejjqRkA6LYLp
         w6VY7ZlVsvh62gvHCCFXKqbaaStiEFRe833jE4vIoCWo4m5BfG5KaYv/tYf0w5Fx/DIy
         +aLTs8HcBLgpgOrsxQf06H85GyUWAmColJpWEtJWGGBmAAbn/O30q8qTicZuL1wOdzAu
         6wEPp35ZnzzZuUrTP0Jc3oyGY5+G6nVAndZI1pdHL9xdP33v5cLnEOw4CghoeO7zZhq2
         4AIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SYKa1nrEaZaYwZ8wYDMo+wGBRjI8YKJTKmH+OljJTGg=;
        b=A1vqiw8KZKFaSac3kikFaToUtf3FV7LDFoxarDAwW6u0reo2ZOPr8x1i1Mri4j1TKg
         TOCPDq/wi+CiY9iVb4ysR1kWZ4jEZNgMf5aIF1tYFBXHxQEKA1L6IR7p/6t0SWgtgvro
         NMWLrA6HofWU/6k+7Q0TIv1VqSx17pyf7rL/FL5lQVZqnMrZsD/eDyn29a/pSTlgecRq
         ODtTqoNFNwyOIux2Rkj//G7u7Zx3yXpwDbABwwAzMs1rdoLDXQmPJ9H2gKfgP0vNGgXg
         IiHbKdP94Pqcu5oqDxiDW0aukB8124o137UNuOWf5V78tQZLW4oLNG9UPSoBtRvJpOWj
         MwfA==
X-Gm-Message-State: AOAM533AGCckIWM1wNCixrpzMktF6JUugB9qkIMibs0O8NLfzTOTkNer
        LtrgtxTkU9Iviwab0kfrMU8=
X-Google-Smtp-Source: ABdhPJw93P0CEj705d5glXmkVMQsX8sYT2IX/Jed8l510hczs05iqHmTLAVyEZ8XcvX8Qih/ulIHbQ==
X-Received: by 2002:a6b:be44:: with SMTP id o65mr3036720iof.53.1600949214929;
        Thu, 24 Sep 2020 05:06:54 -0700 (PDT)
Received: from localhost.localdomain (host-173-230-99-154.tnkngak.clients.pavlovmedia.com. [173.230.99.154])
        by smtp.gmail.com with ESMTPSA id a23sm1259435ioc.54.2020.09.24.05.06.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 05:06:54 -0700 (PDT)
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
Subject: [PATCH seccomp 4/6] seccomp/cache: Lookup syscall allowlist for fast path
Date:   Thu, 24 Sep 2020 07:06:44 -0500
Message-Id: <6c754a336aef916e3a69af8b8b47834317f4dc60.1600946701.git.yifeifz2@illinois.edu>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1600946701.git.yifeifz2@illinois.edu>
References: <cover.1600946701.git.yifeifz2@illinois.edu>
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
index 7c286d66f983..5b1bd8329e9c 100644
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

