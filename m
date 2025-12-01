Return-Path: <bpf+bounces-75803-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F1D02C973D4
	for <lists+bpf@lfdr.de>; Mon, 01 Dec 2025 13:25:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C1078343C1E
	for <lists+bpf@lfdr.de>; Mon,  1 Dec 2025 12:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA61130E0D9;
	Mon,  1 Dec 2025 12:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="SoNpN1NZ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5395330BBBB
	for <bpf@vger.kernel.org>; Mon,  1 Dec 2025 12:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764591875; cv=none; b=iRQXR5hME6kDXA5Km48xbtZoL6wtFZBbR6tkjBPKkud6E2OChC8VNr/WQ3Tln7FR/pwEQrLwQVucKce9H8bU0iFTlex4dRWSBjB5yOgjKG/BoMQw3P4nBVMQDnDAf63bli7qILm6QVPkLoxSJ6MD7DGfipnjS/rzuKIxozXSiXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764591875; c=relaxed/simple;
	bh=8MfDex+kidsWNd3urXjWl39OzEr3uA9ecYv97MZfhkQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ystt/MfLMYTwjlBYURZUdOv2U6GzBOQoo6RY8ggIFmdD0Y+m7Dvw3VMhHEjWHtfttx7JCIluntmcqTRRiWYDJ7Ojka6Vfvpetyth6WsnBCu2OZdsVOmIIwEaKTRLmc5qsikUBGYm7WI9T+ydUr9LaQ5cEqWiwwv6EmHDVXRCbiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=SoNpN1NZ; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 0F66E3F278
	for <bpf@vger.kernel.org>; Mon,  1 Dec 2025 12:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1764591867;
	bh=zW8+/HrAO0awxNuy3yAxkVCoMyJbpjCi4GDs+eaZJcc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type;
	b=SoNpN1NZoL8bFG8QHpGj24nK/g4tIcV05IYXnkFysHugTd8fU0XSIO12jWUVlzcqn
	 CRQmcJM7K0O2g1TZbSMRWCrDlQJWw10ZtWn9NfAqcn4kkgGRVevZfExCe8A119K/yX
	 6SQ6rveJ9b9u82jtkcMuwxZcayPglB5FOsbWUi+Q3LryuGbUIKHhZCuB5Y9A59Ejry
	 gOwfktUgPE0jUVFDf9ZXbmGH6RBB/k1V+YoMCa7ASC47SMJR8j07jYRUeLjrmEVcuA
	 AAKKnfyWYs5oxC2s6gwVN42tHMz3pSKgFVLkadji4+21uSNuV8jOq+KaPZATH4gpx3
	 iQQ+mNtAQN+eBk4fxrP9Er0y0ldeaHlhp/mi0DbgbsNgAY96bMD/0KhkR9zn3/s+yB
	 53Xmw10QtNIr5nMeefpUUtwnnvnB3KF/cx9HzLPPug3p96Gr71I0ZFaTUuHT3/jdiu
	 Uc8wNYyfJJ/X7eWJ5/Hazfqp5Ohu509nTkrQUPDmWH/0YMaZbrQX0n5X365Ll/hzYx
	 Pxvo0mS9gPA4TCmiLQC5lQbk81z8QN47ObmkpI3w8u1LVnbhaH7fPWP8kbXCD1ARWa
	 83eqsHwJv0+qQlF9g2DMMiUdswP0abdb4A6mUYRergfB0XpRW0UW+9D1grkKbpqEBz
	 ig2C4tPXb4nwwPcb7n6Fhlh8=
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-6417b2fae83so4864354a12.1
        for <bpf@vger.kernel.org>; Mon, 01 Dec 2025 04:24:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764591866; x=1765196666;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zW8+/HrAO0awxNuy3yAxkVCoMyJbpjCi4GDs+eaZJcc=;
        b=vKyTl0+48RCuRTj8rtHpQwSvoDXqyrZTbmVjn2JvZVu5bCoXqeyq1+8CndFq1BINmc
         SKk6moLFUk2Xaa6tRE1mf2uVoBiWUZDDqGb+4+KWwO2s8XGSbtBntHnMKbqDf/y+cclb
         p4N1IxbYjAdy4KPx/blxCL+zSovqJNcMhK3mPM6Js4MSEsfiJCVBafAvPgz0nFoR6zOj
         63pdqHHQZSr6cYq4UXxuMyh3v8J1z6bnPKKWFJ6GAV1X8rH+DSq9W1a3mxGxB7xL6327
         zZi79G3JogpeGu6+FVDHowMHPBh4sEEfgz0BoPzNaykAMlFBu0KRJN5DcV7wrUM6aaHg
         HxGg==
X-Forwarded-Encrypted: i=1; AJvYcCX4+cTv9ceEQYqwHbzfCwgPpQyh4tPxW936+Jm/mvFpbs7lMmvyGdP0B28/0xSjk/8qj2A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCna3QTHTBwfSKLNBSz/Y19XjwVSOccUpni8Wm9EovHBhxT+v1
	NKFfxJpck99LsDMMxQnv/ihdKUj+0yD5OWDG+oWD1PVcQNl/3StYn5pQ/VJZwcyHd6fOccVKFmE
	WIKHwJdFUmEESqRrNeAzyIyROz1RXiOvJngTiD1GQuqzt+KNolIrmlkUzn7flW2bzHq/sDQ==
X-Gm-Gg: ASbGnctFSUzf1zrqikhqOx4Q8c0EqgDgdhOrA/feQzxGXQSEGXPScdQUz0VDKRmBubL
	kTxRnDna7dCn+/pBnjz88yPZAibN4B+T1Xlp3epd+L6X0BIlNkddNshi61Dr2W8l8kI8I/ZSuIV
	Dby8X5PU9IYowag1eTWz6ELcjRbz9wfLXHtDl2WX3PZFjFqvG1KYKR0p/wEJk60EwNsf4NfTfte
	go7yi21bCztS+e/uccGy5dJuwaKukM3iwZfruz7XeW8TvWnpoKwP6NpvSF1EXSg9q2Mr1gC8Zgw
	swxqrnNqqpJex5V1YY0degITyZJTWtdLHVgNdy8uoPx29L69M41C5hpvmeOMxTQzDsuaskkP1b7
	OtKl7FWt3UxymHFriWYHwIUmNMweUSSlhwSLAbBrUZdCBw10xvYfFN8/EMDFJVOIQAb2E2REMV4
	TWbX4mUhFpjqLeP7s7/4zlw70e
X-Received: by 2002:a05:6402:24cc:b0:640:b814:bb81 with SMTP id 4fb4d7f45d1cf-645546a3c11mr36462570a12.32.1764591866622;
        Mon, 01 Dec 2025 04:24:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGN1tIOcPrGnJFOxXrUnXoTJlFWJRG9I1z+01CVFHJKk93OfxDzmlpm1HbJF02rEwstWrU0Vw==
X-Received: by 2002:a05:6402:24cc:b0:640:b814:bb81 with SMTP id 4fb4d7f45d1cf-645546a3c11mr36462550a12.32.1764591866178;
        Mon, 01 Dec 2025 04:24:26 -0800 (PST)
Received: from amikhalitsyn.lan (p200300cf5749de007c66abd95f8bdeba.dip0.t-ipconnect.de. [2003:cf:5749:de00:7c66:abd9:5f8b:deba])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64750a6ea36sm12307884a12.2.2025.12.01.04.24.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Dec 2025 04:24:25 -0800 (PST)
From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To: kees@kernel.org
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Andy Lutomirski <luto@amacapital.net>,
	Will Drewry <wad@chromium.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <shuah@kernel.org>,
	Tycho Andersen <tycho@tycho.pizza>,
	Andrei Vagin <avagin@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	=?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@stgraber.org>,
	Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
	Alexander Mikhalitsyn <alexander@mihalicyn.com>
Subject: [PATCH v1 5/6] seccomp: relax has_duplicate_listeners check
Date: Mon,  1 Dec 2025 13:24:02 +0100
Message-ID: <20251201122406.105045-6-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251201122406.105045-1-aleksandr.mikhalitsyn@canonical.com>
References: <20251201122406.105045-1-aleksandr.mikhalitsyn@canonical.com>
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
index ad733f849e0f..348e10d403b1 100644
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
@@ -974,6 +976,10 @@ static long seccomp_attach_filter(unsigned int flags,
 	if (flags & SECCOMP_FILTER_FLAG_WAIT_KILLABLE_RECV)
 		filter->wait_killable_recv = true;
 
+	/* Set nested listeners allow flag, if present. */
+	if (flags & SECCOMP_FILTER_FLAG_ALLOW_NESTED_LISTENERS)
+		filter->allow_nested_listeners = true;
+
 	/*
 	 * If there is an existing filter, make it the prev and don't drop its
 	 * task reference.
@@ -1955,7 +1961,8 @@ static struct file *init_listener(struct seccomp_filter *filter)
 }
 
 /*
- * Does @new_child have a listener while an ancestor also has a listener?
+ * Does @new_child have a listener while an ancestor also has a listener
+ * and hasn't allowed nesting?
  * If so, we'll want to reject this filter.
  * This only has to be tested for the current process, even in the TSYNC case,
  * because TSYNC installs @child with the same parent on all threads.
@@ -1973,7 +1980,12 @@ static bool has_duplicate_listener(struct seccomp_filter *new_child)
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
@@ -2018,10 +2030,12 @@ static long seccomp_set_mode_filter(unsigned int flags,
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


