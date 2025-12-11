Return-Path: <bpf+bounces-76469-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 027CECB5ECF
	for <lists+bpf@lfdr.de>; Thu, 11 Dec 2025 13:47:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5EECA3001806
	for <lists+bpf@lfdr.de>; Thu, 11 Dec 2025 12:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6547A3126A2;
	Thu, 11 Dec 2025 12:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="lkLVo8aB"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4818310630
	for <bpf@vger.kernel.org>; Thu, 11 Dec 2025 12:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765457240; cv=none; b=TP7VSXG6fQ0S3yND8fmVVbj/rgVvFOVhJbjBG1AnX6dHaPX/KiTKHw84Sef3VFj++Odc4DB6QCMvXzQcuSamAhaSiaVqE6kIcUZfogUlPpkzIcFjey8ZxwsxPJ9eyHf2rOKm91+x9Od0OxWiQeW7XQ3QvacNu7yYZjhnpDHh0Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765457240; c=relaxed/simple;
	bh=3qmycWVGwa0fleVcc4GLQW2Fzgtj2dBXk0K8XPFPQCQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=drEWO72VJJkSCCPkJ1t/HAUlXcA0XV4WpPQS6yywZveQuJ2hopzYCINIjyspv/V9bsL5OStJr1Z6LD60XgGm26t/HAXQqjcXZMYdFnt0uXK/OKFQ+FDE+tg3NO6d4viQFvwCjjUmZfJZw/3B2VMfP8Ef9Nifn5IxNj4qp4Sj6kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=lkLVo8aB; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 0B39A3F86D
	for <bpf@vger.kernel.org>; Thu, 11 Dec 2025 12:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1765457221;
	bh=suV39gaCYkEDANhyygJAMBI3GGjztJlbBT8FfCj6jaQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type;
	b=lkLVo8aB/t8fCNGuhkC73TT6SnnVMZn2HIqU5VxR6RN97mukJwSUROiCp67kemnOY
	 dtQ+j+WGo+4wh8YHtcVDxwmI6Nce/GspcQfGJbEDWADJ+mghIjTvsNo2b7RV+GGKrU
	 BlhWTn3kyUPcLujwTJHsertOzeHMYNB8oHp7i4S9NM7GP4Loepd2xOceMZbEUdv8v0
	 Tv5CZuCJ9PNnZf+V5zPk7Ys2ksnC+VxmQDpSlO0prBEOoQG9sstMaRNi2ugFs68Mh4
	 vzGBQOhnFrvBrOV+/qwvGQe9yU+YwQBzsLhkv52wl+vj5uoLRAa1GDlb4KtA5qXbrW
	 ES64yoCZ13KCVdiad1l9XMNgU5undGcqiMkNdROtsC0tFEugqVxVyFyv8HPPUZNKHO
	 Bpb7mCrH2uEBGz7kdSK+KAYpqKOCdvC2yFFWxnFJ9odeYcNrG3+xW/nSFYod0vaFw3
	 ZfMJDYs2TvJMWtbR2u8iTBqhQTDHPg8tEYp+ybTIT1KkNQ3aO+ue+nQgmSbpKcg19Z
	 2MAXybug7uVziq2afUVJhF/+H/Pmy2akTRvJMLh7DWr1CI9gOW6Ov6lcEjLRTKjgt5
	 rEhzutxvz4igOv+055kjS/18BR/Y8jxwP3UCWzaSwrSH7i4ANZRTNnCjk6HAfkS9uG
	 lQSdj1XQ9m0FuVt5f/Cf1KQA=
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-477a11d9e67so233755e9.2
        for <bpf@vger.kernel.org>; Thu, 11 Dec 2025 04:47:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765457201; x=1766062001;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=suV39gaCYkEDANhyygJAMBI3GGjztJlbBT8FfCj6jaQ=;
        b=e9/UznXbJvjH4gYUq1GYhyFcD6fQQiLpcVBf7dbUO9xp/abCUhER4QlC9d6sE8rnIX
         hGWj1/oBHGQhMB+r1435cGY5MgeN86lfz7nHwkOyxFBSFCfaD9VItiCjb5+lzoC1dFa2
         Tgzd5/QAqpsDv43y4lTLpwOsSF77BFhfAF6br+JbF0q8ICOUPNfccY8S6ql9l7R0YVpl
         PPXnWxBEnuYeM7xL9I727RKPM5LTyHP64iKefSdmmROvHFXBSFSGTMtzZvgH5Rha816s
         tHFZCuPVBvnMDpzy0bmwhpyU+ZjwTJTm6+93DTSbru2tZoldZpNpR70nssFw2kw4zGjQ
         eTVA==
X-Forwarded-Encrypted: i=1; AJvYcCUUqS4moNBR1cP70kiHU34TeqdY12chGuR0gJ0CcdVT412JR/Z0S7vieO5o4BTrdGGJSBg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1hOsuJx2xrgvSI0DNt7esi4LSG6GW1lxEpXsnc4T3FnH6XZSu
	1FhGQzWYPdY87uVttb5hpa7fjGmUtdiY2THYmwsxFjILzFRiW9EI+/1IzSHglvraxrTUzenjLwy
	RBmdMCjqj1cJpDFXQ91NEWKVo2A42dkRMLTgiHon4F5VzRTRxuZtfs7fkcDGSAhtCIkgXog==
X-Gm-Gg: AY/fxX4YPnDLSBJtHsmGrLEAP0ug/+Sl8Kg1UyI8GExN4Sc3ho0KdBiXYw3WDa8SXrg
	JCY9jPQtiFXpRR0zLjfbrWlKAIbIACsx3+eqqH+a3B+Sz8JfkCtEHtJIebs4R/zjFWjhmA8Ops6
	Hs6MY2TNmc1GuUVdUcxDWJeN5URVEKls1RrZUwi83cef4x2JuBVcM1wssuijRyv75dsbXUQRPVr
	7Aj9MILNR3r18me2v7hlKpGI0l9N7TeiMYcfOKWi3dcD7Zg8H5KVNV9tswjDHGyDQmeyk0xVC8Z
	t81Bbjh2Qm8KQ/rOwT9+ShbatI/kW/+K9so9SuFis4nueUdnijeTV1ikfntpOVOX2FhAVSsynS+
	oKDrKotlm9At5b2hCT17myakaBnKmmG0KQnbCaab0LZjdvH6I4VXyLT8jCm1cvPjQt5sfgDrUcT
	PwGNiPLk4IyogKjDm3LISGT4E=
X-Received: by 2002:a05:600c:46cf:b0:47a:829a:ebb with SMTP id 5b1f17b1804b1-47a8383c856mr56890535e9.19.1765457200901;
        Thu, 11 Dec 2025 04:46:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEdBy+0ixhzmCiyvohlwRh+X5WzSwkP+d/0rQhp386/uoSX/xcLaiXgvZ/61M7qhAv/XiR5Hg==
X-Received: by 2002:a05:600c:46cf:b0:47a:829a:ebb with SMTP id 5b1f17b1804b1-47a8383c856mr56890055e9.19.1765457200466;
        Thu, 11 Dec 2025 04:46:40 -0800 (PST)
Received: from amikhalitsyn.lan (p200300cf57022000e6219d5798620e30.dip0.t-ipconnect.de. [2003:cf:5702:2000:e621:9d57:9862:e30])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47a89f0d6f2sm32075905e9.13.2025.12.11.04.46.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Dec 2025 04:46:39 -0800 (PST)
From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To: kees@kernel.org
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Andy Lutomirski <luto@amacapital.net>,
	Will Drewry <wad@chromium.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <shuah@kernel.org>,
	Aleksa Sarai <cyphar@cyphar.com>,
	Tycho Andersen <tycho@tycho.pizza>,
	Andrei Vagin <avagin@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	=?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@stgraber.org>,
	Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
	Alexander Mikhalitsyn <alexander@mihalicyn.com>
Subject: [PATCH v3 6/7] seccomp: allow nested listeners
Date: Thu, 11 Dec 2025 13:46:10 +0100
Message-ID: <20251211124614.161900-7-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251211124614.161900-1-aleksandr.mikhalitsyn@canonical.com>
References: <20251211124614.161900-1-aleksandr.mikhalitsyn@canonical.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Now everything is ready to get rid of "only one listener per tree"
limitation.

Let's introduce a new uAPI flag
SECCOMP_FILTER_FLAG_ALLOW_NESTED_LISTENERS, so userspace may explicitly
allow nested listeners when installing a listener.

Note, that to install n-th listener, this flag must be set on all
the listeners up the tree.

Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: bpf@vger.kernel.org
Cc: Kees Cook <kees@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Will Drewry <wad@chromium.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Aleksa Sarai <cyphar@cyphar.com>
Cc: Tycho Andersen <tycho@tycho.pizza>
Cc: Andrei Vagin <avagin@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Stéphane Graber <stgraber@stgraber.org>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
 .../userspace-api/seccomp_filter.rst          |  6 +++++
 include/linux/seccomp.h                       |  3 ++-
 include/uapi/linux/seccomp.h                  | 13 ++++++-----
 kernel/seccomp.c                              | 22 +++++++++++++++----
 tools/include/uapi/linux/seccomp.h            | 13 ++++++-----
 5 files changed, 40 insertions(+), 17 deletions(-)

diff --git a/Documentation/userspace-api/seccomp_filter.rst b/Documentation/userspace-api/seccomp_filter.rst
index cff0fa7f3175..b9633ab1ed47 100644
--- a/Documentation/userspace-api/seccomp_filter.rst
+++ b/Documentation/userspace-api/seccomp_filter.rst
@@ -210,6 +210,12 @@ notifications from both tasks will appear on the same filter fd. Reads and
 writes to/from a filter fd are also synchronized, so a filter fd can safely
 have many readers.
 
+By default, only one listener within seccomp filters tree is allowed. On attempt
+to add a new listener when one already exists in the filter tree, the
+``seccomp()`` call will fail with ``-EBUSY``. To allow multiple listeners, the
+``SECCOMP_FILTER_FLAG_ALLOW_NESTED_LISTENERS`` flag can be passed in addition to
+the ``SECCOMP_FILTER_FLAG_NEW_LISTENER`` flag.
+
 The interface for a seccomp notification fd consists of two structures:
 
 .. code-block:: c
diff --git a/include/linux/seccomp.h b/include/linux/seccomp.h
index 9b959972bf4a..9b060946019d 100644
--- a/include/linux/seccomp.h
+++ b/include/linux/seccomp.h
@@ -10,7 +10,8 @@
 					 SECCOMP_FILTER_FLAG_SPEC_ALLOW | \
 					 SECCOMP_FILTER_FLAG_NEW_LISTENER | \
 					 SECCOMP_FILTER_FLAG_TSYNC_ESRCH | \
-					 SECCOMP_FILTER_FLAG_WAIT_KILLABLE_RECV)
+					 SECCOMP_FILTER_FLAG_WAIT_KILLABLE_RECV | \
+					 SECCOMP_FILTER_FLAG_ALLOW_NESTED_LISTENERS)
 
 /* sizeof() the first published struct seccomp_notif_addfd */
 #define SECCOMP_NOTIFY_ADDFD_SIZE_VER0 24
diff --git a/include/uapi/linux/seccomp.h b/include/uapi/linux/seccomp.h
index dbfc9b37fcae..de78d8e7a70b 100644
--- a/include/uapi/linux/seccomp.h
+++ b/include/uapi/linux/seccomp.h
@@ -18,13 +18,14 @@
 #define SECCOMP_GET_NOTIF_SIZES		3
 
 /* Valid flags for SECCOMP_SET_MODE_FILTER */
-#define SECCOMP_FILTER_FLAG_TSYNC		(1UL << 0)
-#define SECCOMP_FILTER_FLAG_LOG			(1UL << 1)
-#define SECCOMP_FILTER_FLAG_SPEC_ALLOW		(1UL << 2)
-#define SECCOMP_FILTER_FLAG_NEW_LISTENER	(1UL << 3)
-#define SECCOMP_FILTER_FLAG_TSYNC_ESRCH		(1UL << 4)
+#define SECCOMP_FILTER_FLAG_TSYNC			(1UL << 0)
+#define SECCOMP_FILTER_FLAG_LOG				(1UL << 1)
+#define SECCOMP_FILTER_FLAG_SPEC_ALLOW			(1UL << 2)
+#define SECCOMP_FILTER_FLAG_NEW_LISTENER		(1UL << 3)
+#define SECCOMP_FILTER_FLAG_TSYNC_ESRCH			(1UL << 4)
 /* Received notifications wait in killable state (only respond to fatal signals) */
-#define SECCOMP_FILTER_FLAG_WAIT_KILLABLE_RECV	(1UL << 5)
+#define SECCOMP_FILTER_FLAG_WAIT_KILLABLE_RECV		(1UL << 5)
+#define SECCOMP_FILTER_FLAG_ALLOW_NESTED_LISTENERS	(1UL << 6)
 
 /*
  * All BPF programs must return a 32-bit value.
diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index 51d0d8adaffb..7667f443ff6c 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -206,6 +206,7 @@ static inline void seccomp_cache_prepare(struct seccomp_filter *sfilter)
  * @wait_killable_recv: Put notifying process in killable state once the
  *			notification is received by the userspace listener.
  * @first_listener: true if this is the first seccomp listener installed in the tree.
+ * @allow_nested_listeners: Allow nested seccomp listeners.
  * @prev: points to a previously installed, or inherited, filter
  * @prog: the BPF program to evaluate
  * @notif: the struct that holds all notification related information
@@ -228,6 +229,7 @@ struct seccomp_filter {
 	bool log : 1;
 	bool wait_killable_recv : 1;
 	bool first_listener : 1;
+	bool allow_nested_listeners : 1;
 	struct action_cache cache;
 	struct seccomp_filter *prev;
 	struct bpf_prog *prog;
@@ -956,6 +958,10 @@ static long seccomp_attach_filter(unsigned int flags,
 	if (flags & SECCOMP_FILTER_FLAG_WAIT_KILLABLE_RECV)
 		filter->wait_killable_recv = true;
 
+	/* Set nested listeners allow flag, if present. */
+	if (flags & SECCOMP_FILTER_FLAG_ALLOW_NESTED_LISTENERS)
+		filter->allow_nested_listeners = true;
+
 	/*
 	 * If there is an existing filter, make it the prev and don't drop its
 	 * task reference.
@@ -1997,7 +2003,8 @@ static struct file *init_listener(struct seccomp_filter *filter)
 }
 
 /*
- * Does @new_child have a listener while an ancestor also has a listener?
+ * Does @new_child have a listener while an ancestor also has a listener
+ * and hasn't allowed nesting?
  * If so, we'll want to reject this filter.
  * This only has to be tested for the current process, even in the TSYNC case,
  * because TSYNC installs @child with the same parent on all threads.
@@ -2015,7 +2022,12 @@ static bool check_duplicate_listener(struct seccomp_filter *new_child)
 		return false;
 	for (cur = current->seccomp.filter; cur; cur = cur->prev) {
 		if (!IS_ERR_OR_NULL(cur->notif))
-			return true;
+			/*
+			 * We don't need to go up further, because if there is a
+			 * listener with nesting allowed, then all the listeners
+			 * up the tree have allowed nesting as well.
+			 */
+			return !cur->allow_nested_listeners;
 	}
 
 	/* Mark first listener in the tree. */
@@ -2062,10 +2074,12 @@ static long seccomp_set_mode_filter(unsigned int flags,
 		return -EINVAL;
 
 	/*
-	 * The SECCOMP_FILTER_FLAG_WAIT_KILLABLE_SENT flag doesn't make sense
+	 * The SECCOMP_FILTER_FLAG_WAIT_KILLABLE_SENT and
+	 * SECCOMP_FILTER_FLAG_ALLOW_NESTED_LISTENERS flags don't make sense
 	 * without the SECCOMP_FILTER_FLAG_NEW_LISTENER flag.
 	 */
-	if ((flags & SECCOMP_FILTER_FLAG_WAIT_KILLABLE_RECV) &&
+	if (((flags & SECCOMP_FILTER_FLAG_WAIT_KILLABLE_RECV) ||
+	     (flags & SECCOMP_FILTER_FLAG_ALLOW_NESTED_LISTENERS)) &&
 	    ((flags & SECCOMP_FILTER_FLAG_NEW_LISTENER) == 0))
 		return -EINVAL;
 
diff --git a/tools/include/uapi/linux/seccomp.h b/tools/include/uapi/linux/seccomp.h
index dbfc9b37fcae..de78d8e7a70b 100644
--- a/tools/include/uapi/linux/seccomp.h
+++ b/tools/include/uapi/linux/seccomp.h
@@ -18,13 +18,14 @@
 #define SECCOMP_GET_NOTIF_SIZES		3
 
 /* Valid flags for SECCOMP_SET_MODE_FILTER */
-#define SECCOMP_FILTER_FLAG_TSYNC		(1UL << 0)
-#define SECCOMP_FILTER_FLAG_LOG			(1UL << 1)
-#define SECCOMP_FILTER_FLAG_SPEC_ALLOW		(1UL << 2)
-#define SECCOMP_FILTER_FLAG_NEW_LISTENER	(1UL << 3)
-#define SECCOMP_FILTER_FLAG_TSYNC_ESRCH		(1UL << 4)
+#define SECCOMP_FILTER_FLAG_TSYNC			(1UL << 0)
+#define SECCOMP_FILTER_FLAG_LOG				(1UL << 1)
+#define SECCOMP_FILTER_FLAG_SPEC_ALLOW			(1UL << 2)
+#define SECCOMP_FILTER_FLAG_NEW_LISTENER		(1UL << 3)
+#define SECCOMP_FILTER_FLAG_TSYNC_ESRCH			(1UL << 4)
 /* Received notifications wait in killable state (only respond to fatal signals) */
-#define SECCOMP_FILTER_FLAG_WAIT_KILLABLE_RECV	(1UL << 5)
+#define SECCOMP_FILTER_FLAG_WAIT_KILLABLE_RECV		(1UL << 5)
+#define SECCOMP_FILTER_FLAG_ALLOW_NESTED_LISTENERS	(1UL << 6)
 
 /*
  * All BPF programs must return a 32-bit value.
-- 
2.43.0


