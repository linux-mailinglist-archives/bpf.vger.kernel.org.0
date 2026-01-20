Return-Path: <bpf+bounces-79654-lists+bpf=lfdr.de@vger.kernel.org>
Delivered-To: lists+bpf@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OA+hDfCyb2nHMAAAu9opvQ
	(envelope-from <bpf+bounces-79654-lists+bpf=lfdr.de@vger.kernel.org>)
	for <lists+bpf@lfdr.de>; Tue, 20 Jan 2026 17:53:04 +0100
X-Original-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A6CF48007
	for <lists+bpf@lfdr.de>; Tue, 20 Jan 2026 17:53:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BCDEE8CC829
	for <lists+bpf@lfdr.de>; Tue, 20 Jan 2026 16:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ADDD322C60;
	Tue, 20 Jan 2026 15:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NvHxSO1a"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2023F322B6D
	for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 15:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768924779; cv=none; b=mGMnkjOX8QCOUc8FnvH9FzmwRa+PSvDT7zH8WinCbpSx4vC40gT+CRNXJjoSj6O2+braEpGppeT6M1oWRit11C1TeRfWrA/wPYoOUQdQ0px/lFSwGsNHyeQsYQ44zu3jcK5+jcdgm+I9aDS8oIvjoaXw3UwYeZDcKwAlEWu5bHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768924779; c=relaxed/simple;
	bh=lRes9l+x3wDpNSO2Sa5JkIhFzgz9xGBZD8cX6/ZNbvQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BnugB6/oGb/Ty5aFfbgWrKdCYGwDDl0v0G54He/1AUPACnW1zmysNhppG6pXLIgN5vx91zyMZw4LKHAGtPCe6CadgtiGs0msrfV7nwbnU4PXVym6MhiDCqP84j1SFS1CFcgjoRauqXF0DwXLZeOnvYfgSmXBSYaesq057koMSkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NvHxSO1a; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-47ee301a06aso52322165e9.0
        for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 07:59:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768924776; x=1769529576; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4FzDrJXSiFpMM2oO5xJw4oZibyZTAtzJi/b5pFlTTC8=;
        b=NvHxSO1apwOXAtABu42GT2jJqte+uasXMN96tqNxESpynXcD0+Ij2jOw31wU34oUP5
         lH0mwkxGSvOTAPS7tDKtbfs5gPF9j2lu0wKTESXKNXAXNDb+wGFQ/Y4S0lv5g/4piWSi
         1aA4KC/j13tIxkW9TSwsg1ZXBgZPllIMe6gPZ/ODZw2RmWOkTEETZSD0LgIPPziiOt+A
         S+b7DLEFvdlpSiOFrMxt0MStjmVsgGJzIAM/zMn3GtP4S1gVbdrOvvYZ+/Vcu9CuMJ8z
         zdTZVd6CEHkosDT4pSUG5htKMH3Fc0P+DIVNez+DqCTK40TnJhWRLkVVRO8dfMxpFKkx
         oMBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768924776; x=1769529576;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4FzDrJXSiFpMM2oO5xJw4oZibyZTAtzJi/b5pFlTTC8=;
        b=uwunibH/0ouqRz1Zl0NIUUmxP73E8KVuvHyfAv66Sg2TN4TyycKRM9BGEq+3S7Zzt0
         SswUdKuxGnyPMQucYyh9Ix6R7T3s80oK0Ug4DxQL9vfgmxgoE+d9jp0Q+SVcuSqE4zpJ
         hnHrqdojmeJDtKHsL9Y2BxKbMrvlfbhjhMo8us9Axo2IzAwxa/DUzl8pvgII0B/B8O4Z
         6P8VuR12oviNUgIB34i98NhS5HFeUQBGZma4ERwdZhsF27w2Kha0DkiEaAKk+PJgN+6B
         /FEGbpU9fxiFTtu6IcyNrav+eSvVJIBhdbaaHhF+T1B3AZd6mG7rn6Rj1grsu4U0+4QS
         ZCQg==
X-Gm-Message-State: AOJu0YyoiX2qSuU8DObUEqT/CZNWobxyOC0RmkM8G5rlhy9nzCXaCNFw
	KuZXUqYif0IvO/XJkiFMB2ipz9EqpNBH0nE7B6Yj9mQuOKHub/zwm3Mx
X-Gm-Gg: AY/fxX4URUfvdjt3tAkbkkanxB4D4swM8VMd+lOBKXZd4PjcipbZHIl69kuiyQG021K
	OMpnvm5euloagwhwdumD2DmQ63A8tcSgda/hVD0mC1Aw/fqCqXxbf9fxCPJ7Bi4t/QeOMA8ftBk
	SC3SeFx01uqivT5q0ay0X0Y/BUUMdvlHg3IcHrT3PgNvJ0+Y91UaCMyvQNbuplDDr3YJiUvC9nS
	4twfJZZmBt3ub8U/SOuYbjvFdNJGTYMZ0xb76zvbx7Ca0sGp3wi5tIVYLphe6ixFvqxWiU9E+fK
	K3P8Vs26SHvriLnu/kX/W6WSbXjq7NE3ncnqf4kCLyUhYQNVEN4bvWDJd1M6Y8sbepzzIlRiQOn
	Q99EQhE8eXGicSqZHdK+ci+kQN7Rky0M/YkOpYRfGkcU8o6C8Z5lQezLvMjnjRapXIU7eGHuhOr
	SrkIjpNYvDDtHMXg==
X-Received: by 2002:a05:600c:c171:b0:47a:9560:5944 with SMTP id 5b1f17b1804b1-4803d8481bbmr36155435e9.34.1768924776142;
        Tue, 20 Jan 2026 07:59:36 -0800 (PST)
Received: from localhost ([2a01:4b00:bd1f:f500:e85d:a828:282d:d5c7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43569921facsm28818718f8f.5.2026.01.20.07.59.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 07:59:35 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Tue, 20 Jan 2026 15:59:19 +0000
Subject: [PATCH bpf-next v6 10/10] selftests/bpf: Verify
 bpf_timer_cancel_async works
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260120-timer_nolock-v6-10-670ffdd787b4@meta.com>
References: <20260120-timer_nolock-v6-0-670ffdd787b4@meta.com>
In-Reply-To: <20260120-timer_nolock-v6-0-670ffdd787b4@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 memxor@gmail.com, eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768924765; l=2785;
 i=yatsenko@meta.com; s=20251031; h=from:subject:message-id;
 bh=rxvPvabdjJ7jjXmOwc3ttq22Faa0bJrvplOFprPR9ZE=;
 b=u9Ycm2Fz/+PT26PFCoLxrVo9ygg0PKXDjCBWesttCyJSP2tgaOH1r2em6cmUi5znkVuZnN/qR
 BFQIiTVKQf0CFMmnbcje533xi0ja6/uu2wImZ/J+W/iQT75PTCi/FJh
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=TFoLStOoH/++W4HJHRgNr8zj8vPFB1W+/QECPcQygzo=
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-79654-lists,bpf=lfdr.de];
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
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,meta.com:email,meta.com:mid]
X-Rspamd-Queue-Id: 9A6CF48007
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Mykyta Yatsenko <yatsenko@meta.com>

Add test that verifies that bpf_timer_cancel_async works: can cancel
callback successfully.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 tools/testing/selftests/bpf/prog_tests/timer.c | 25 +++++++++++++++++++++++++
 tools/testing/selftests/bpf/progs/timer.c      | 23 +++++++++++++++++++++++
 2 files changed, 48 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/timer.c b/tools/testing/selftests/bpf/prog_tests/timer.c
index a157a2a699e638c9f21712b1e7194fc4b6382e71..2b932d4dfd436fd322bd07169f492e20e4ec7624 100644
--- a/tools/testing/selftests/bpf/prog_tests/timer.c
+++ b/tools/testing/selftests/bpf/prog_tests/timer.c
@@ -99,6 +99,26 @@ static int timer(struct timer *timer_skel)
 	return 0;
 }
 
+static int timer_cancel_async(struct timer *timer_skel)
+{
+	int err, prog_fd;
+	LIBBPF_OPTS(bpf_test_run_opts, topts);
+
+	prog_fd = bpf_program__fd(timer_skel->progs.test_async_cancel_succeed);
+	err = bpf_prog_test_run_opts(prog_fd, &topts);
+	ASSERT_OK(err, "test_run");
+	ASSERT_EQ(topts.retval, 0, "test_run");
+
+	usleep(500);
+	/* check that there were no errors in timer execution */
+	ASSERT_EQ(timer_skel->bss->err, 0, "err");
+
+	/* check that code paths completed */
+	ASSERT_EQ(timer_skel->bss->ok, 1 | 2 | 4, "ok");
+
+	return 0;
+}
+
 static void test_timer(int (*timer_test_fn)(struct timer *timer_skel))
 {
 	struct timer *timer_skel = NULL;
@@ -134,6 +154,11 @@ void serial_test_timer_stress_async_cancel(void)
 	test_timer(timer_stress_async_cancel);
 }
 
+void serial_test_timer_async_cancel(void)
+{
+	test_timer(timer_cancel_async);
+}
+
 void test_timer_interrupt(void)
 {
 	struct timer_interrupt *skel = NULL;
diff --git a/tools/testing/selftests/bpf/progs/timer.c b/tools/testing/selftests/bpf/progs/timer.c
index a81413514e4b07ef745f27eade71454234e731e8..4b4ca781e7cdcf78015359cbd8f8d8ff591d6036 100644
--- a/tools/testing/selftests/bpf/progs/timer.c
+++ b/tools/testing/selftests/bpf/progs/timer.c
@@ -169,6 +169,29 @@ int BPF_PROG2(test1, int, a)
 	return 0;
 }
 
+static int timer_error(void *map, int *key, struct bpf_timer *timer)
+{
+	err = 42;
+	return 0;
+}
+
+SEC("syscall")
+int test_async_cancel_succeed(void *ctx)
+{
+	struct bpf_timer *arr_timer;
+	int array_key = ARRAY;
+
+	arr_timer = bpf_map_lookup_elem(&array, &array_key);
+	if (!arr_timer)
+		return 0;
+	bpf_timer_init(arr_timer, &array, CLOCK_MONOTONIC);
+	bpf_timer_set_callback(arr_timer, timer_error);
+	bpf_timer_start(arr_timer, 100000 /* 100us */, 0);
+	bpf_timer_cancel_async(arr_timer);
+	ok = 7;
+	return 0;
+}
+
 /* callback for prealloc and non-prealloca hashtab timers */
 static int timer_cb2(void *map, int *key, struct hmap_elem *val)
 {

-- 
2.52.0


