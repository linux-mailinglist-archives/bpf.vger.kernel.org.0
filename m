Return-Path: <bpf+bounces-75876-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2992AC9B62F
	for <lists+bpf@lfdr.de>; Tue, 02 Dec 2025 12:54:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1EB97345090
	for <lists+bpf@lfdr.de>; Tue,  2 Dec 2025 11:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 284E1314D36;
	Tue,  2 Dec 2025 11:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="jIyAKH2B"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8D2314D11
	for <bpf@vger.kernel.org>; Tue,  2 Dec 2025 11:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764676356; cv=none; b=DK+4xr4OU1rCqxPb0OsD1pNDH0O6gilcL6suPrj3/LP4o0xLVtxLV9dWqXuVmrdxhXGJIEIvGE6om8Q4bNmwI5Oi9rjAesG3GVFEk2Y7xpx78eTPTBN0M7tB/dLuA586mSFVPmpOl2H2oXs64fivX7doq68t4zpQecdq2g5EgZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764676356; c=relaxed/simple;
	bh=C77QVCaNFi1rF9WKTVN6GD+egWOqsJOFJ8DOWl6QG9I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bJbEcuNhryOv2N+qwx3PTQrKmEGtKiM8JuRBXDfS4AAJr9l6JwuO9uhAVRPsf98TfUX4iwD6cvUKI25fTlQOGwCYc0ZZ1bpA6dFm3HNtA80ZniWIWoj1po+3nK6CXpvFPKLZsgJY2qojI5EorA9/bBoUNLQoY0bh/4mQ6QRXlWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=jIyAKH2B; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id A60713FB63
	for <bpf@vger.kernel.org>; Tue,  2 Dec 2025 11:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1764676344;
	bh=Axv6vUiwWJhlCZhCOlctIB31d1FHH589LkNbghFTla0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type;
	b=jIyAKH2BUvfF5TXy5g1IuFRWOrFO6x2TEwj3zvJhCUcnzVJOCT0Zr3LF5j74VXrzN
	 2gu5ciXkP9IiXpdrrKQLEHTKJ2WPyjJIFVsfrR6DbFzbNvU6rHtNhcERpMPbhOne8B
	 9dWo0Uo98h3Ucc+7FcEtmywU1GcSE3+nWDaxd9ZgUcp6c3gzYnxoP5CbgQBJFSSXcl
	 8voYjDCJaJxaXnJNuM/xvYkpiSU7aNWofANfhCsQHAJFEbf8Ic1NAImAA5OW8zPImg
	 NXM0wZ6SppuFeLU8c7jPHtTBiBz+5rx96vpMcSKYgsGwxDjCJizUW801H8rlsph/kA
	 NV6raNoYiSZuysqHYb+QQaEUjr59YpkK07Fs/pT0l4PyLjXpBR2NqAZhx9gCheZg9/
	 s2Bwre82Zh7wrquVLdwN0S6tR44OYrB5PGE3aW1RNaLLG7j03eJ73D1EB3sOMQFeiJ
	 dg0DbM/+NVY+mp6VSBFwKjRxgvUTsK2JKf+f8O7h1SOXiAVRpMrtvGhDJp8ts5OX8c
	 FAKiG2uv7zY7Q2aU7IxEiniayeeqytRx8/1+XSUi2/PVbgL6UqL9I240TwnByH8Ipu
	 CR2ecbd0jZXjjrXFEGRYp94OAJWVstpKxXV79FRPZzVFCB4w+LegcIyWL4GZCb7Z/Y
	 tiZ1j3VQi4CeiQoEJdoFm5to=
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-b73599315adso391150866b.2
        for <bpf@vger.kernel.org>; Tue, 02 Dec 2025 03:52:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764676340; x=1765281140;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Axv6vUiwWJhlCZhCOlctIB31d1FHH589LkNbghFTla0=;
        b=s9F8u9XUroJ9xjmK5Cbe/ON5lqCKFofaBmSjHBFiUNQRZ994+8pqYyOLkdBDlI2r7s
         7r8GHHhEIVuLVfIVwrMM9WhyabbvlcWTJIKDtJP3jBk5E8m2JpGogxFg6/pUbSvvgUuZ
         1HqwsussxSSUnrXIs8CGJ9SRQcR8WlkQJhJXpOkIR4VCMpKzEu/2/ymynHbxMpDSgix7
         55op46MMMOuIoT7ybwAJecxXoxf5WYRx0kKN1rw/CphNSgz3skfLkdEFQiAapYvWcqQj
         NTOdwOw+CQUO/J2ls8S2Du3EDZXuwBR6O4rJnVUdedV3DfMycOI8Q98qL2ok1CtEQqAJ
         3o3w==
X-Forwarded-Encrypted: i=1; AJvYcCWgF4gfDR6x5jO6mTBkKsHGeDQ0odMGEbNvFuOInveEv3eAR50IaAxpmfFTckbIemBppVw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzmd4k9/xuJE6rA3Gv2F1PusSoS/dlx2NjviHVUQ5Sf5tc4AFq5
	IJ03JWqIFOJ9G+qYDM2jmJ331pkWde+1NnVbaCPP4YD+GSX4qNx3iodPTNrfMI/U0abZQQuH9jz
	pyF5KGgnUjiGYkDk/daon0YWnDQVDdEb9SdCtMgPHMpw7OiKv885h7pJYrhvZW77Z5j4OcA==
X-Gm-Gg: ASbGncsHgUhSRCITbJzQrvKR1CRcl8rE+NuU9nTsh0U3CHW20xYTEDu8IzXc/bCle5/
	3AQe49wim+fSijOi/lWVO8si2Ldu5eGJYh8+4E2p8zo/6PftQyrKxPxWwMIO1MsSaPUOhPUTvRw
	BvvKHtfn/3XmJtsyAr7lSHTkUvkPsuHsw03BAzoE1nxQEEjJIAcToneJE7b8Utk3gLYnIx9huAJ
	ZsdmIVTAweaMWmJWV+KkrlEEXjLl2k0qbijo43NxIQMx7Pt+SdxEetJx/MzLxPRcySM3ospRtQy
	q9Gl0TtOdfzptYg3OtRShc49T4ajRJojreJ8lkXohL+j9szY1cMWq7V/did1A/+JFLQOE/ozmi2
	Yb6XAI/J2u8ygUhfEThO9hi/gIBDwl7xkXa4n625ik4zgF5AmV0zE43hoWgT1opN6Rm7R1kWXvP
	rIeqw46PgN351lK/GrE8PJDIA=
X-Received: by 2002:a17:906:c14a:b0:b6d:3a00:983a with SMTP id a640c23a62f3a-b76c551504dmr3315911366b.38.1764676340072;
        Tue, 02 Dec 2025 03:52:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEPpx1/rOUbEn0W22PLKyuLu+FnwfRlf+qjfej6kw7xz7j4ARHbtg4setflSyZMmAZJqJtjow==
X-Received: by 2002:a17:906:c14a:b0:b6d:3a00:983a with SMTP id a640c23a62f3a-b76c551504dmr3315907366b.38.1764676339489;
        Tue, 02 Dec 2025 03:52:19 -0800 (PST)
Received: from amikhalitsyn.lan (p200300cf5702200011ee99ed0f378a51.dip0.t-ipconnect.de. [2003:cf:5702:2000:11ee:99ed:f37:8a51])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-647510519efsm15206765a12.29.2025.12.02.03.52.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Dec 2025 03:52:19 -0800 (PST)
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
Subject: [PATCH v2 5/6] seccomp: relax has_duplicate_listeners check
Date: Tue,  2 Dec 2025 12:51:57 +0100
Message-ID: <20251202115200.110646-6-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251202115200.110646-1-aleksandr.mikhalitsyn@canonical.com>
References: <20251202115200.110646-1-aleksandr.mikhalitsyn@canonical.com>
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
index 262390451ff1..a59276afc5b4 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -205,6 +205,7 @@ static inline void seccomp_cache_prepare(struct seccomp_filter *sfilter)
  * @log: true if all actions except for SECCOMP_RET_ALLOW should be logged
  * @wait_killable_recv: Put notifying process in killable state once the
  *			notification is received by the userspace listener.
+ * @allow_nested_listeners: Allow nested seccomp listeners.
  * @prev: points to a previously installed, or inherited, filter
  * @prog: the BPF program to evaluate
  * @notif: the struct that holds all notification related information
@@ -226,6 +227,7 @@ struct seccomp_filter {
 	refcount_t users;
 	bool log;
 	bool wait_killable_recv;
+	bool allow_nested_listeners;
 	struct action_cache cache;
 	struct seccomp_filter *prev;
 	struct bpf_prog *prog;
@@ -984,6 +986,10 @@ static long seccomp_attach_filter(unsigned int flags,
 	if (flags & SECCOMP_FILTER_FLAG_WAIT_KILLABLE_RECV)
 		filter->wait_killable_recv = true;
 
+	/* Set nested listeners allow flag, if present. */
+	if (flags & SECCOMP_FILTER_FLAG_ALLOW_NESTED_LISTENERS)
+		filter->allow_nested_listeners = true;
+
 	/*
 	 * If there is an existing filter, make it the prev and don't drop its
 	 * task reference.
@@ -1972,7 +1978,8 @@ static struct file *init_listener(struct seccomp_filter *filter)
 }
 
 /*
- * Does @new_child have a listener while an ancestor also has a listener?
+ * Does @new_child have a listener while an ancestor also has a listener
+ * and hasn't allowed nesting?
  * If so, we'll want to reject this filter.
  * This only has to be tested for the current process, even in the TSYNC case,
  * because TSYNC installs @child with the same parent on all threads.
@@ -1990,7 +1997,12 @@ static bool has_duplicate_listener(struct seccomp_filter *new_child)
 		return false;
 	for (cur = current->seccomp.filter; cur; cur = cur->prev) {
 		if (cur->notif)
-			return true;
+			/*
+			 * We don't need to go up further, because if there is a
+			 * listener with nesting allowed, then all the listeners
+			 * up the tree have allowed nesting as well.
+			 */
+			return !cur->allow_nested_listeners;
 	}
 
 	return false;
@@ -2035,10 +2047,12 @@ static long seccomp_set_mode_filter(unsigned int flags,
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


