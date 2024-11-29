Return-Path: <bpf+bounces-45850-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E9A69DBE33
	for <lists+bpf@lfdr.de>; Fri, 29 Nov 2024 01:16:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CDF9282543
	for <lists+bpf@lfdr.de>; Fri, 29 Nov 2024 00:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A21915AF6;
	Fri, 29 Nov 2024 00:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VAI6z091"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553D412B71
	for <bpf@vger.kernel.org>; Fri, 29 Nov 2024 00:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732839405; cv=none; b=arnOBjywJEiR693gLsDwdNvLnWJMO8WdwlztUVVO5oXvvX9pJ29QlMlwOCvjgWmSCY51obM86HwNKpWeD+hfkFRA6q+XYn2lkjPlhM+3nkeYy/wSg48xAhGQ5kmJkWx3WbjqKEBjtuUZENXFNRyyj+ufWhawQsNQvVf01hwUErM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732839405; c=relaxed/simple;
	bh=Qp24u3dI0LLdgiPG9kdtgCTmGoG7HoAAH3rw8TwUDTo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iPC55HT0bhvkOFUJkMo7Ef6wUdcg9VZ+S09tz2ys43K/qSejAaXc5SwOnbrV4rf+wPoD7lvVpLOHC7IfY9+DXIdSXTxMod3mFOOHd3n744EmI3GuuQTGEXtLqs2j7zBEdqcx0YjafDGpRT+NRJRZVn3B1a4m0P8djWSbaFyspRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VAI6z091; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-434a044dce2so14526265e9.2
        for <bpf@vger.kernel.org>; Thu, 28 Nov 2024 16:16:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732839401; x=1733444201; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v5O9Jut8NRsZ+6S0wg2el/dfEmBw09a1A9p4uUQuLT0=;
        b=VAI6z091jAynYekIahtkIiQCQ2HxTZtC3ACI7APWfsvy7kW2dIHAzbOq4hOLQVqZJb
         9c7wpOH7wCQbSNsu+F1d3aYrOFxsxFUjK7sWEKVqzyyhPv9IckMkPZN2qezvMGKOJWDR
         5U4hZZOtMiEIKceyVBhungoMMitMdPXs0/t/Jkfv0DmNe+Z0GMNhsXTkX+FFy/KYDM6W
         G+iHesKjJUAPSYo3vovp6hCZ9lJNEhCtmccSJT9wTZpLHgwfY1QT25cSzkoFr3KTesX3
         TKFDDWsjfKqJcymp9WlfbSxf67nnUVo7Bh3v1dOqUd2JzPj/4RPPbUXBdngQjhI8Gf+F
         WsMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732839401; x=1733444201;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v5O9Jut8NRsZ+6S0wg2el/dfEmBw09a1A9p4uUQuLT0=;
        b=LfJhS+maT0sjOBAcO0qC0QCjKbHvmXj5XFugDQL1bCOFq14XNKTk7LcX/MZlG4tQ6O
         2zwQPFbL+yROfAaFoxgMJqaQ/rsjk45wr8cquAvpEkGmetDwaJ0kNiahBPcjc8e602JI
         o11SCrqfAc+v0aEdl3gBwD53u6UYT1mr8hfAzR3PjjYpOKRL9FjPZtkMAY6ERN0FoUTT
         meLlNSeWy/BMQdaa/xMBXjdi1NBb7b129l90fLE3rI9HKINrR+pS0gGzCT9RrMiAJlY0
         QSuI7U4InLnHRYerQffMhUe8FGU3V+neJjFrZVYIinw8fkene8Xv/+LqdZ9O1lg8p+e6
         N9HQ==
X-Gm-Message-State: AOJu0YwZjahjuVvItVnDiAI9s5wn1My3rhozLr8aIaITRRuVRU8XLp/p
	APLuR5nywHPR/gS6RFkeaWkpVEAUnydyHCh6vHnl14NFJs+Fr2C5h0mlgo0OqHs=
X-Gm-Gg: ASbGncvt71V12I8mCt6aXheDUZVWTeJqqjiNMfN29Vb2bTX79mEpzT+ydJPr6IGk4EX
	lz+BAjsxOQLQaiWTTwzSQfvU+B2QonWixw3EMo4E/m1IjClW6Lk7KMhp96H6ty02tOOeJvzkVho
	7PicAbHPyXmu4OIxSccF7jhaOke3lUvFs3ZOZ+KzckFJ4N4g/Irnw5Q8MZEY3hc8sNu6PNxOLZA
	T59SszUUmmrctwkcnenF7Vi8fwhiNEfWKRDvHNnAujKIdnLN+biw3N+PCnMYzljbxxeZa92wcQQ
X-Google-Smtp-Source: AGHT+IEzl6SlrmyKyaewvcUNciryF0lTkuXudSUCWwpH/KHv9jRXUR8yQBSEvBDnMEM2RyLOprDsvQ==
X-Received: by 2002:a05:600c:45cd:b0:431:6083:cd30 with SMTP id 5b1f17b1804b1-434a9dbb631mr90327465e9.6.1732839401040;
        Thu, 28 Nov 2024 16:16:41 -0800 (PST)
Received: from localhost (fwdproxy-cln-006.fbsv.net. [2a03:2880:31ff:6::face:b00c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385ccd80a61sm2849686f8f.107.2024.11.28.16.16.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2024 16:16:40 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: kkd@meta.com,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v5 5/7] bpf: Improve verifier log for resource leak on exit
Date: Thu, 28 Nov 2024 16:16:30 -0800
Message-ID: <20241129001632.3828611-6-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241129001632.3828611-1-memxor@gmail.com>
References: <20241129001632.3828611-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5835; h=from:subject; bh=Qp24u3dI0LLdgiPG9kdtgCTmGoG7HoAAH3rw8TwUDTo=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnSQfcEHuRbGcOVnEG6A1dAz73oW9ngsF1cXIh2DxY 9pE/1aGJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ0kH3AAKCRBM4MiGSL8RyuIzEA CBOITrgvJgVr7kJJZfbFL43UD07qpti8RKEVgAb1at2Fs406HH72mSCg9YzeRS7o639/JGSm+qO6dI 1LKe8HvLV1KBFu+Ju5LPovGZBLJ9/1nL8h8innodWncHQHs1U4lLO70WmaviMg1VejRi2/UuNuWIyO hkRhfPB9/eBkJwE70K1hunKUxoWOnJwVU5gdJayJczdIgmTmkObT3JtIHgdHxHWOP+eJwYEn2p+vuA I3qLCOrxZwC98BAwblZ1sndahvY/UFLIsg33knDP6kI55IeozrNg4sKawVA7gpMG8EPkiuKjA7G0HZ rVbAOaKrZ4OwG5PCMMwyp/tTmNsAzTQ/HxosD3HQNmKDqXMJRy2XfTzizncnv0HXzg9NO2rIyf8Z+N WKxn+cJqvFLmSI3bpqj6uJGSFqO8bQEnBw7vusK9mwiQkNZbmOx9MrmaKrESJbJCwgMw30WNEE+HXv 2il2jw0UesE4qM3KLGRTeizvYqyk0fPVXm92EItfENeOC8dQNjeOBlUtWiqolK8q6mxaysxn7dCpoP QynPCuvC9CMzZwnErqZCkOsYqEAYsI6BCnoATKSAzQwnRIq6L0u5tbqHGzRjXjJICbVd5slKiKyJ1k 9rZOhVy8SJn87sjoz/oSkTRIe6pQjvDISBZTRQZloMUF1Ga9MEFIuldlZklg==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

The verifier log when leaking resources on BPF_EXIT may be a bit
confusing, as it's a problem only when finally existing from the main
prog, not from any of the subprogs. Hence, update the verifier error
string and the corresponding selftests matching on it.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Suggested-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/verifier.c                              |  2 +-
 .../testing/selftests/bpf/progs/exceptions_fail.c  |  4 ++--
 tools/testing/selftests/bpf/progs/preempt_lock.c   | 14 +++++++-------
 .../selftests/bpf/progs/verifier_spin_lock.c       |  2 +-
 4 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 9c0315fffa07..a901af186400 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -19102,7 +19102,7 @@ static int do_check(struct bpf_verifier_env *env)
 				 * match caller reference state when it exits.
 				 */
 				err = check_resource_leak(env, exception_exit, !env->cur_state->curframe,
-							  "BPF_EXIT instruction");
+							  "BPF_EXIT instruction in main prog");
 				if (err)
 					return err;
 
diff --git a/tools/testing/selftests/bpf/progs/exceptions_fail.c b/tools/testing/selftests/bpf/progs/exceptions_fail.c
index fe0f3fa5aab6..8a0fdff89927 100644
--- a/tools/testing/selftests/bpf/progs/exceptions_fail.c
+++ b/tools/testing/selftests/bpf/progs/exceptions_fail.c
@@ -131,7 +131,7 @@ int reject_subprog_with_lock(void *ctx)
 }
 
 SEC("?tc")
-__failure __msg("BPF_EXIT instruction cannot be used inside bpf_rcu_read_lock-ed region")
+__failure __msg("BPF_EXIT instruction in main prog cannot be used inside bpf_rcu_read_lock-ed region")
 int reject_with_rcu_read_lock(void *ctx)
 {
 	bpf_rcu_read_lock();
@@ -147,7 +147,7 @@ __noinline static int throwing_subprog(struct __sk_buff *ctx)
 }
 
 SEC("?tc")
-__failure __msg("BPF_EXIT instruction cannot be used inside bpf_rcu_read_lock-ed region")
+__failure __msg("BPF_EXIT instruction in main prog cannot be used inside bpf_rcu_read_lock-ed region")
 int reject_subprog_with_rcu_read_lock(void *ctx)
 {
 	bpf_rcu_read_lock();
diff --git a/tools/testing/selftests/bpf/progs/preempt_lock.c b/tools/testing/selftests/bpf/progs/preempt_lock.c
index 885377e83607..5269571cf7b5 100644
--- a/tools/testing/selftests/bpf/progs/preempt_lock.c
+++ b/tools/testing/selftests/bpf/progs/preempt_lock.c
@@ -6,7 +6,7 @@
 #include "bpf_experimental.h"
 
 SEC("?tc")
-__failure __msg("BPF_EXIT instruction cannot be used inside bpf_preempt_disable-ed region")
+__failure __msg("BPF_EXIT instruction in main prog cannot be used inside bpf_preempt_disable-ed region")
 int preempt_lock_missing_1(struct __sk_buff *ctx)
 {
 	bpf_preempt_disable();
@@ -14,7 +14,7 @@ int preempt_lock_missing_1(struct __sk_buff *ctx)
 }
 
 SEC("?tc")
-__failure __msg("BPF_EXIT instruction cannot be used inside bpf_preempt_disable-ed region")
+__failure __msg("BPF_EXIT instruction in main prog cannot be used inside bpf_preempt_disable-ed region")
 int preempt_lock_missing_2(struct __sk_buff *ctx)
 {
 	bpf_preempt_disable();
@@ -23,7 +23,7 @@ int preempt_lock_missing_2(struct __sk_buff *ctx)
 }
 
 SEC("?tc")
-__failure __msg("BPF_EXIT instruction cannot be used inside bpf_preempt_disable-ed region")
+__failure __msg("BPF_EXIT instruction in main prog cannot be used inside bpf_preempt_disable-ed region")
 int preempt_lock_missing_3(struct __sk_buff *ctx)
 {
 	bpf_preempt_disable();
@@ -33,7 +33,7 @@ int preempt_lock_missing_3(struct __sk_buff *ctx)
 }
 
 SEC("?tc")
-__failure __msg("BPF_EXIT instruction cannot be used inside bpf_preempt_disable-ed region")
+__failure __msg("BPF_EXIT instruction in main prog cannot be used inside bpf_preempt_disable-ed region")
 int preempt_lock_missing_3_minus_2(struct __sk_buff *ctx)
 {
 	bpf_preempt_disable();
@@ -55,7 +55,7 @@ static __noinline void preempt_enable(void)
 }
 
 SEC("?tc")
-__failure __msg("BPF_EXIT instruction cannot be used inside bpf_preempt_disable-ed region")
+__failure __msg("BPF_EXIT instruction in main prog cannot be used inside bpf_preempt_disable-ed region")
 int preempt_lock_missing_1_subprog(struct __sk_buff *ctx)
 {
 	preempt_disable();
@@ -63,7 +63,7 @@ int preempt_lock_missing_1_subprog(struct __sk_buff *ctx)
 }
 
 SEC("?tc")
-__failure __msg("BPF_EXIT instruction cannot be used inside bpf_preempt_disable-ed region")
+__failure __msg("BPF_EXIT instruction in main prog cannot be used inside bpf_preempt_disable-ed region")
 int preempt_lock_missing_2_subprog(struct __sk_buff *ctx)
 {
 	preempt_disable();
@@ -72,7 +72,7 @@ int preempt_lock_missing_2_subprog(struct __sk_buff *ctx)
 }
 
 SEC("?tc")
-__failure __msg("BPF_EXIT instruction cannot be used inside bpf_preempt_disable-ed region")
+__failure __msg("BPF_EXIT instruction in main prog cannot be used inside bpf_preempt_disable-ed region")
 int preempt_lock_missing_2_minus_1_subprog(struct __sk_buff *ctx)
 {
 	preempt_disable();
diff --git a/tools/testing/selftests/bpf/progs/verifier_spin_lock.c b/tools/testing/selftests/bpf/progs/verifier_spin_lock.c
index 3f679de73229..25599eac9a70 100644
--- a/tools/testing/selftests/bpf/progs/verifier_spin_lock.c
+++ b/tools/testing/selftests/bpf/progs/verifier_spin_lock.c
@@ -187,7 +187,7 @@ l0_%=:	r6 = r0;					\
 
 SEC("cgroup/skb")
 __description("spin_lock: test6 missing unlock")
-__failure __msg("BPF_EXIT instruction cannot be used inside bpf_spin_lock-ed region")
+__failure __msg("BPF_EXIT instruction in main prog cannot be used inside bpf_spin_lock-ed region")
 __failure_unpriv __msg_unpriv("")
 __naked void spin_lock_test6_missing_unlock(void)
 {
-- 
2.43.5


