Return-Path: <bpf+bounces-79652-lists+bpf=lfdr.de@vger.kernel.org>
Delivered-To: lists+bpf@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oAb3IOm/b2kOMQAAu9opvQ
	(envelope-from <bpf+bounces-79652-lists+bpf=lfdr.de@vger.kernel.org>)
	for <lists+bpf@lfdr.de>; Tue, 20 Jan 2026 18:48:25 +0100
X-Original-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2983C48D52
	for <lists+bpf@lfdr.de>; Tue, 20 Jan 2026 18:48:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 46009749364
	for <lists+bpf@lfdr.de>; Tue, 20 Jan 2026 16:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6037322B64;
	Tue, 20 Jan 2026 15:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Aj8SnRNq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B712031ED68
	for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 15:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768924777; cv=none; b=GafuZqQzUOyaR/gGqw0Bj2ojdyU9Fcc55e17TTuhK18ewF31jqu6WpTXByn6MFGOD4BpvGFxaH1cQdPYvbczd3k37zwvRQoV9aYO014DMUJV5JRwaGbvsDf/mW2IScOv6110hu8EUGvyawP5Ekz4/DMsPErc9/JLX5mldcFpU4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768924777; c=relaxed/simple;
	bh=SWyMRCjSOVCSx3FWxZDLXZnAjKeKkFv9M7p4lS61Opo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oYc0hgRYgtEkPNS8mpb59pmgmWgyHIzMHeXLOrufcYhIQELGdjGYEd9bESJQE74rD/cqjmD9alQkqlT/PZKUe5Zg2BWkst1d1Rc1VR6l5pZWKS0q9P3xufRTmaMphCPUOLcH2pWxe7Ow+Hy/J++3oZwnruJfdXh58e5UxSPuipk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Aj8SnRNq; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-47ee07570deso38575955e9.1
        for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 07:59:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768924774; x=1769529574; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z90nFROdPtst2IKVs/+csEyxpI1YETMH4mOHgmwYj7o=;
        b=Aj8SnRNqfTmCkSQ3e1+CCUs71m2TNvP2/TiIMm2G7eLtVJsc0vk0jMEOJYDFipw8s6
         p/dXdT1r/eTz98quHmlZX6wopLaz5SS0jZCaMkeggQoioAU5lpZ2MgkScoGVOZQQNpAn
         8Jw6nZW4K0Q6RBzkvVNu6pdq62hz1+QZgWiqn5ktIIo+lfma2z/yMFIkMrbj9BkQ1gxK
         ujuoYSZEaFgteR3lNrJByQ+ws9oa2Jf4TePHSHtfxVq0fGqkiBHGC0RIFsLQR6W17JsT
         cGd0In7ufrkhLyTX8nDPLiB4CVD7bXvnz9tUnvcsn5rObBcGPxs6T2iv5teQZOYnHHUI
         S0Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768924774; x=1769529574;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Z90nFROdPtst2IKVs/+csEyxpI1YETMH4mOHgmwYj7o=;
        b=h+mA+SoGCc1wpbKgNL4FQ1O1XpOsUEC/jqR76a/MItKHC6aY9M/u8SJZsoYwvWTQ+r
         zxm436x+8GG+mvsDZJVFdC6/dD1rUlY6fzyw8f8bRrzzUWXFopahW1BKKg5w4j5zgIUb
         K2LXHLkRsrH751eMGd6qhXd7pKFbj1ZCjG2dSX0tXVrMmNK5GN0eRuCHNrsX24RsCthp
         NsMqzuRyNh3IimgLGJOFwGs2l4SlMjIDjoTlvOSThTb4sUkMgYc/VPkzMvHM68RAoFRR
         MOI0gft+g/+s4T1ffgWp4pzKogfukZMHfEIyFSCe+6MvuD/n8eIZtRFM5pgkO+hgp1Mu
         Gxbg==
X-Gm-Message-State: AOJu0YwilDotovUQ8pNBZhHVAK3e0ZBzmpVZOmQ2gtV/F5AuzSmuQNpi
	1av3o+bLCFsWfjm8zQ6DWs0myCUaNc/GG+cL71pLYtxPImrJeZQkL6t0
X-Gm-Gg: AY/fxX7BjxD1AdBNNTf4iCm1pKTTG1AYwIE+5sLo9s83d8+E3ZYppF6eSdbeNzCr9dX
	TsNLgfRlwpSyjzVO0ynrE2wa5F6i8ZmTGZOO8lt/VxzvPyDTKiGnzi0LX0jfXnBLHaXrY9UkPPs
	ekG/doz3qYX2WDrZFGz5ZsIJq0u6egUGkIpvpJppUSvhKyImoth+g/6g/lpzQk8b3PrWpG02W6i
	chuz5GwmawZm3rZjiOKQOCAhnv0VjMgAJxJAEhNti7zz+EQvHDYNqpkn2nlhyuMJGY7GeXT4MNb
	nT5RH5Ot46RlnxuZTgw4NOEho78uojpju36j8BWBe7NGcZ0ZOMH2cQ7ZK95rpC+XqzAWkfx+SAV
	LI+M70VKuzer0tBErTrHMlPoWPd8JkYbTcQqwiFKiMZ+27H0SXJFgZKtZxTNDm12qKXEY0rPRAH
	MI2jmYcLc+jGwvUQ==
X-Received: by 2002:a05:600c:1c28:b0:45d:f81d:eae7 with SMTP id 5b1f17b1804b1-4801eb109e0mr192690175e9.28.1768924773861;
        Tue, 20 Jan 2026 07:59:33 -0800 (PST)
Received: from localhost ([2a01:4b00:bd1f:f500:e85d:a828:282d:d5c7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4801ea19f94sm112459085e9.3.2026.01.20.07.59.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 07:59:33 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Tue, 20 Jan 2026 15:59:17 +0000
Subject: [PATCH bpf-next v6 08/10] selftests/bpf: Refactor timer selftests
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260120-timer_nolock-v6-8-670ffdd787b4@meta.com>
References: <20260120-timer_nolock-v6-0-670ffdd787b4@meta.com>
In-Reply-To: <20260120-timer_nolock-v6-0-670ffdd787b4@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 memxor@gmail.com, eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768924764; l=2904;
 i=yatsenko@meta.com; s=20251031; h=from:subject:message-id;
 bh=I12f8/2m85P/qMhnRxqBUg240K5nCwpW7fUenuGUBFo=;
 b=JS5Vsw1YA1XJsmARSM/wCzj2Jv/v9VURPF+ttKw4aBc7ih8tDPD5RlzblK5lDUecaop01y+NL
 PyUlWiSLvohBkQ7R0AKg3x+Lst3QM5Pd/cYXfPxZY8lIZBl96fdRrWv
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=TFoLStOoH/++W4HJHRgNr8zj8vPFB1W+/QECPcQygzo=
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-79652-lists,bpf=lfdr.de];
	FREEMAIL_TO(0.00)[vger.kernel.org,kernel.org,iogearbox.net,meta.com,gmail.com];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	DKIM_TRACE(0.00)[gmail.com:+];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mykytayatsenko5@gmail.com,bpf@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[bpf];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,meta.com:email,meta.com:mid]
X-Rspamd-Queue-Id: 2983C48D52
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Mykyta Yatsenko <yatsenko@meta.com>

Refactor timer selftests, extracting stress test into a separate test.
This makes it easier to debug test failures and allows to extend.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 tools/testing/selftests/bpf/prog_tests/timer.c | 55 +++++++++++++++++---------
 1 file changed, 36 insertions(+), 19 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/timer.c b/tools/testing/selftests/bpf/prog_tests/timer.c
index 34f9ccce260293755980bcd6fcece491964f7929..4d853d1bd2a71b3d0f1ba0daa7a699945b4457fe 100644
--- a/tools/testing/selftests/bpf/prog_tests/timer.c
+++ b/tools/testing/selftests/bpf/prog_tests/timer.c
@@ -22,13 +22,35 @@ static void *spin_lock_thread(void *arg)
 	pthread_exit(arg);
 }
 
-static int timer(struct timer *timer_skel)
+
+static int timer_stress(struct timer *timer_skel)
 {
-	int i, err, prog_fd;
+	int i, err = 1, prog_fd;
 	LIBBPF_OPTS(bpf_test_run_opts, topts);
 	pthread_t thread_id[NUM_THR];
 	void *ret;
 
+	prog_fd = bpf_program__fd(timer_skel->progs.race);
+	for (i = 0; i < NUM_THR; i++) {
+		err = pthread_create(&thread_id[i], NULL,
+				     &spin_lock_thread, &prog_fd);
+		if (!ASSERT_OK(err, "pthread_create"))
+			break;
+	}
+
+	while (i) {
+		err = pthread_join(thread_id[--i], &ret);
+		if (ASSERT_OK(err, "pthread_join"))
+			ASSERT_EQ(ret, (void *)&prog_fd, "pthread_join");
+	}
+	return err;
+}
+
+static int timer(struct timer *timer_skel)
+{
+	int err, prog_fd;
+	LIBBPF_OPTS(bpf_test_run_opts, topts);
+
 	err = timer__attach(timer_skel);
 	if (!ASSERT_OK(err, "timer_attach"))
 		return err;
@@ -63,25 +85,10 @@ static int timer(struct timer *timer_skel)
 	/* check that code paths completed */
 	ASSERT_EQ(timer_skel->bss->ok, 1 | 2 | 4, "ok");
 
-	prog_fd = bpf_program__fd(timer_skel->progs.race);
-	for (i = 0; i < NUM_THR; i++) {
-		err = pthread_create(&thread_id[i], NULL,
-				     &spin_lock_thread, &prog_fd);
-		if (!ASSERT_OK(err, "pthread_create"))
-			break;
-	}
-
-	while (i) {
-		err = pthread_join(thread_id[--i], &ret);
-		if (ASSERT_OK(err, "pthread_join"))
-			ASSERT_EQ(ret, (void *)&prog_fd, "pthread_join");
-	}
-
 	return 0;
 }
 
-/* TODO: use pid filtering */
-void serial_test_timer(void)
+static void test_timer(int (*timer_test_fn)(struct timer *timer_skel))
 {
 	struct timer *timer_skel = NULL;
 	int err;
@@ -94,13 +101,23 @@ void serial_test_timer(void)
 	if (!ASSERT_OK_PTR(timer_skel, "timer_skel_load"))
 		return;
 
-	err = timer(timer_skel);
+	err = timer_test_fn(timer_skel);
 	ASSERT_OK(err, "timer");
 	timer__destroy(timer_skel);
+}
+
+void serial_test_timer(void)
+{
+	test_timer(timer);
 
 	RUN_TESTS(timer_failure);
 }
 
+void serial_test_timer_stress(void)
+{
+	test_timer(timer_stress);
+}
+
 void test_timer_interrupt(void)
 {
 	struct timer_interrupt *skel = NULL;

-- 
2.52.0


