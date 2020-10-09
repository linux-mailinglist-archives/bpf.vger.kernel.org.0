Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6118128900D
	for <lists+bpf@lfdr.de>; Fri,  9 Oct 2020 19:33:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733120AbgJIRQ2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 9 Oct 2020 13:16:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbgJIRPe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 9 Oct 2020 13:15:34 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA26AC0613D2;
        Fri,  9 Oct 2020 10:15:34 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id y20so6657528iod.5;
        Fri, 09 Oct 2020 10:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z2j0Bc9FHm93nqZodukx18Qz+KCEFZbMeEPob7kjzBE=;
        b=BKwZr5LyhXxdrzvbw8c10S2Uyba4pfEe7BUUoZdA3Vys3fE53N1uab3/opbcB4sZTP
         9lJvMQ4Zhqute99rAsBlwO569kisTow+ZwXfH14wu5+GPOzgCBp19nLsFF4BiBUL0+e0
         OeRX86ycKIaeRHB1CuuJojwX3hLnkNmAGmuZ8tUKf/yJgPrAgXEoEebfhPfa7L5cktBJ
         M3k1cG9mJIYM96sezp5c2AUyc1qp87oB8BDBK5jJO6Q3dGxTIC3SvS7YN0y0iJUbKAs2
         uZUWyijMHQNIR1V+0Kfu8Ui8VSNEKYh/LZ/hHNayCyHs5nQy+hcLsF0wnhe0oeYwnpkW
         W2lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z2j0Bc9FHm93nqZodukx18Qz+KCEFZbMeEPob7kjzBE=;
        b=J3e6ToPTuvwfaqwbuKAjFp0nTLUfd/CqtMz5Am/JnckzIyN+/0OK78hFsDwcsF2PL4
         uLGjKOYPppPEiAw2ef5rubje+iw+uMZ93RZnTRJq5VWko0bUs6SMZDSfJIxj3IQy75ci
         ZBiSNoQfD4xVbiBG7r/yk3PIqMC9h37AsBYnfPXl0FCX5c85Fr2/PBb6iHqv7E0ZX3eV
         O4w/HAGcpUTbU42Ut9TVpFyIAqeISgegPIYoGJ6USdvV+WB/wIzoAiJe6oNHn/BlkEKx
         HaRgP/gF68ERlSklpvfMzzCUVp34kQk2FRuXGApyT2pI3XbHk12gJOJ4Kckfy9Plvf4K
         wPJg==
X-Gm-Message-State: AOAM532gqjS5Yrra2Hq9VVW+9HiJMocq3GqmBgjE9HkfZRP+nxQAdnzu
        ApAZkbongfsxRLSMZ0BVLsg=
X-Google-Smtp-Source: ABdhPJwYOxoA6gvDxUA4JAzPl2IwaAOgIxNmLHxz6lLrSQFuB73GGdA3I8y4EVbDsVW6rlNzl9vXPQ==
X-Received: by 2002:a5d:8798:: with SMTP id f24mr9863459ion.35.1602263733960;
        Fri, 09 Oct 2020 10:15:33 -0700 (PDT)
Received: from localhost.localdomain (host-173-230-99-154.tnkngak.clients.pavlovmedia.com. [173.230.99.154])
        by smtp.gmail.com with ESMTPSA id c2sm3762830iot.52.2020.10.09.10.15.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2020 10:15:33 -0700 (PDT)
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
Subject: [PATCH v4 seccomp 1/5] seccomp/cache: Lookup syscall allowlist bitmap for fast path
Date:   Fri,  9 Oct 2020 12:14:29 -0500
Message-Id: <896cd9de97318d20c25edb1297db8c65e1cfdf84.1602263422.git.yifeifz2@illinois.edu>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1602263422.git.yifeifz2@illinois.edu>
References: <cover.1602263422.git.yifeifz2@illinois.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: YiFei Zhu <yifeifz2@illinois.edu>

The overhead of running Seccomp filters has been part of some past
discussions [1][2][3]. Oftentimes, the filters have a large number
of instructions that check syscall numbers one by one and jump based
on that. Some users chain BPF filters which further enlarge the
overhead. A recent work [6] comprehensively measures the Seccomp
overhead and shows that the overhead is non-negligible and has a
non-trivial impact on application performance.

We observed some common filters, such as docker's [4] or
systemd's [5], will make most decisions based only on the syscall
numbers, and as past discussions considered, a bitmap where each bit
represents a syscall makes most sense for these filters.

The fast (common) path for seccomp should be that the filter permits
the syscall to pass through, and failing seccomp is expected to be
an exceptional case; it is not expected for userspace to call a
denylisted syscall over and over.

When it can be concluded that an allow must occur for the given
architecture and syscall pair (this determination is introduced in
the next commit), seccomp will immediately allow the syscall,
bypassing further BPF execution.

Each architecture number has its own bitmap. The architecture
number in seccomp_data is checked against the defined architecture
number constant before proceeding to test the bit against the
bitmap with the syscall number as the index of the bit in the
bitmap, and if the bit is set, seccomp returns allow. The bitmaps
are all clear in this patch and will be initialized in the next
commit.

[1] https://lore.kernel.org/linux-security-module/c22a6c3cefc2412cad00ae14c1371711@huawei.com/T/
[2] https://lore.kernel.org/lkml/202005181120.971232B7B@keescook/T/
[3] https://github.com/seccomp/libseccomp/issues/116
[4] https://github.com/moby/moby/blob/ae0ef82b90356ac613f329a8ef5ee42ca923417d/profiles/seccomp/default.json
[5] https://github.com/systemd/systemd/blob/6743a1caf4037f03dc51a1277855018e4ab61957/src/shared/seccomp-util.c#L270
[6] Draco: Architectural and Operating System Support for System Call Security
    https://tianyin.github.io/pub/draco.pdf, MICRO-53, Oct. 2020

Co-developed-by: Dimitrios Skarlatos <dskarlat@cs.cmu.edu>
Signed-off-by: Dimitrios Skarlatos <dskarlat@cs.cmu.edu>
Signed-off-by: YiFei Zhu <yifeifz2@illinois.edu>
---
 kernel/seccomp.c | 72 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index ae6b40cc39f4..73f6b6e9a3b0 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -143,6 +143,34 @@ struct notification {
 	struct list_head notifications;
 };
 
+#ifdef SECCOMP_ARCH_NATIVE
+/**
+ * struct action_cache - per-filter cache of seccomp actions per
+ * arch/syscall pair
+ *
+ * @allow_native: A bitmap where each bit represents whether the
+ *		  filter will always allow the syscall, for the
+ *		  native architecture.
+ * @allow_compat: A bitmap where each bit represents whether the
+ *		  filter will always allow the syscall, for the
+ *		  compat architecture.
+ */
+struct action_cache {
+	DECLARE_BITMAP(allow_native, SECCOMP_ARCH_NATIVE_NR);
+#ifdef SECCOMP_ARCH_COMPAT
+	DECLARE_BITMAP(allow_compat, SECCOMP_ARCH_COMPAT_NR);
+#endif
+};
+#else
+struct action_cache { };
+
+static inline bool seccomp_cache_check_allow(const struct seccomp_filter *sfilter,
+					     const struct seccomp_data *sd)
+{
+	return false;
+}
+#endif /* SECCOMP_ARCH_NATIVE */
+
 /**
  * struct seccomp_filter - container for seccomp BPF programs
  *
@@ -298,6 +326,47 @@ static int seccomp_check_filter(struct sock_filter *filter, unsigned int flen)
 	return 0;
 }
 
+#ifdef SECCOMP_ARCH_NATIVE
+static inline bool seccomp_cache_check_allow_bitmap(const void *bitmap,
+						    size_t bitmap_size,
+						    int syscall_nr)
+{
+	if (unlikely(syscall_nr < 0 || syscall_nr >= bitmap_size))
+		return false;
+	syscall_nr = array_index_nospec(syscall_nr, bitmap_size);
+
+	return test_bit(syscall_nr, bitmap);
+}
+
+/**
+ * seccomp_cache_check_allow - lookup seccomp cache
+ * @sfilter: The seccomp filter
+ * @sd: The seccomp data to lookup the cache with
+ *
+ * Returns true if the seccomp_data is cached and allowed.
+ */
+static inline bool seccomp_cache_check_allow(const struct seccomp_filter *sfilter,
+					     const struct seccomp_data *sd)
+{
+	int syscall_nr = sd->nr;
+	const struct action_cache *cache = &sfilter->cache;
+
+	if (likely(sd->arch == SECCOMP_ARCH_NATIVE))
+		return seccomp_cache_check_allow_bitmap(cache->allow_native,
+							SECCOMP_ARCH_NATIVE_NR,
+							syscall_nr);
+#ifdef SECCOMP_ARCH_COMPAT
+	if (likely(sd->arch == SECCOMP_ARCH_COMPAT))
+		return seccomp_cache_check_allow_bitmap(cache->allow_compat,
+							SECCOMP_ARCH_COMPAT_NR,
+							syscall_nr);
+#endif /* SECCOMP_ARCH_COMPAT */
+
+	WARN_ON_ONCE(true);
+	return false;
+}
+#endif /* SECCOMP_ARCH_NATIVE */
+
 /**
  * seccomp_run_filters - evaluates all seccomp filters against @sd
  * @sd: optional seccomp data to be passed to filters
@@ -320,6 +389,9 @@ static u32 seccomp_run_filters(const struct seccomp_data *sd,
 	if (WARN_ON(f == NULL))
 		return SECCOMP_RET_KILL_PROCESS;
 
+	if (seccomp_cache_check_allow(f, sd))
+		return SECCOMP_RET_ALLOW;
+
 	/*
 	 * All filters in the list are evaluated and the lowest BPF return
 	 * value always takes priority (ignoring the DATA).
-- 
2.28.0

