Return-Path: <bpf+bounces-77778-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BA2BBCF0F11
	for <lists+bpf@lfdr.de>; Sun, 04 Jan 2026 13:42:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AA63030139AB
	for <lists+bpf@lfdr.de>; Sun,  4 Jan 2026 12:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB19E271457;
	Sun,  4 Jan 2026 12:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TqPkms3U"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f196.google.com (mail-yw1-f196.google.com [209.85.128.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC92327FB25
	for <bpf@vger.kernel.org>; Sun,  4 Jan 2026 12:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767529843; cv=none; b=ftthqvmVtTmHpew4VU1jIK2HKa9SSk8gMQts/HSNVz2A4/eYcsix4Xj0rmWcbHcHavo61CQzZ4XoW8PguazIU37mHRtPNz0S19wvY3QNp2u6oJc7fnXeObLwmTQAOGZ++kPxotNkozZ1Oyp6W4fTWKyssiwhYHuWLIbfQUonS9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767529843; c=relaxed/simple;
	bh=ARq0/QucFj/sxPqr+22ybRos7rUcjBBi5nq/Y4PoAvU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dRSsTYYziBjea/h3PYBVb+C8Zv50XyfbSog3dqlZjDm8y+doVvR/jhLl4xThk0JRRNp92e+U/Of45tZL9i9MIoS/Ck8W3gKHmMV5Q4IAWpLy05thodMeBcCOc7FBtpvIu4oy2M/WsbODT0gkVZSE67TaJuOeheeciJhoyU9+fQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TqPkms3U; arc=none smtp.client-ip=209.85.128.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f196.google.com with SMTP id 00721157ae682-7908ddad578so1309927b3.1
        for <bpf@vger.kernel.org>; Sun, 04 Jan 2026 04:30:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767529841; x=1768134641; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ki8yj47Ksf2sOkp6JBKCA9cB1ptX2Wx6sb0cvY7RlMA=;
        b=TqPkms3U+iW3ZtHfZVQjlxgEmv0kdW+TEc691Q1F9AVik7R1CxM07xU7sYmYBVdTut
         YvJEwRyigQ5XFg1f7RzDNSD3bh2JcV7WL/9BJ3LTQ0zYR6Vdk0j9pO8dneLnayedCXqc
         LEUM1gufSqq0uuveuXnxoag76AtvwEJ7x19FKID0Ls60Op0pCUIAQzJlHRBrGt/AkY8p
         e4Ct6NtYXCI14AdCF8c0n5JEOY6cIEWXviAQ9nfuSF+p7cY0AKDL+2Vh8fUPuJ9uZs7W
         vK4ovstoqjMQOr/l+xVySfCshB9DkSnht4D9YXD0x1xwbiNUOgBfzP+kpl+N1TlUZe5D
         ltpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767529841; x=1768134641;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ki8yj47Ksf2sOkp6JBKCA9cB1ptX2Wx6sb0cvY7RlMA=;
        b=DeAKTzvalncqzOUXBiCKLAX0MykbdmD3wfJLG7Pn+AnChEcEAy5WbP1fs/k0I6uvt1
         6Qbif1Glp1XmOtECs98SNiIz39F//RaWP/qW36Bda806HRW97Z+baEsTERlJLAZ4u/Ie
         CA3DdCtUSqc0h0yNRvewCGXixn9WjIfRELD9my3lSebWtUhSrfKiy+YxsSxJCZIcDmgP
         FFT4DSCFTeO12eK363Ox9R0iKaXFOllh4Aoei7vAY6eYyIfa6eh2aUbovco8md54pQuf
         X58fOGlvtpzoLuflMLLwMM9XqsUK9wbYXxtr4ntRDt8xH5ZoqkQ4wIluuhr4ZhFTvTYQ
         K53w==
X-Forwarded-Encrypted: i=1; AJvYcCUdTsUHQYm7iGfoVHu+XZq3oxQwFFvpc1LJSr6LCq70hxm8q0VWA3EtlF7N2ldt9aHeD6g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAGZ2YRoLdtzkKsrnoASe2AS50l2X6KZUmVkiUAODGETp4fN4b
	pxWSH8GoPKY0Q9aiMgQbQAR4r9px+VKJ/z/cloAKg7kDsnRzCQBo/WsQ
X-Gm-Gg: AY/fxX4e4fCgD4Q6gABPWZjhqH11Mhdx3lPL6iFS8HofE1i/mY5D5bIYJqJ7Bz1vnnh
	4N6taZEt+3LL9EOp7POqovEGe+PtP2D7PZj+svGt3Z+bRF9eVEuIdfhfkTCX/gS+fEZKCzFeJYu
	ZUFqLwozScuRkrcRK/4lE1JwqkQKyfGlXceu90ypsm4UagnKjO39t8pkNgAnoDh4RFc5lRCp/Ax
	FpcPq7LEng5KrplN8Qb19MceuDykwooZaOtmtwWRg7u8QEXagXAQtw8/iWi0m8LZuIvBcL+wW6g
	ZAwhqaInicji7IPY+LrE84ZcawzxbBVpXEHenq+7zHJgspoRsLqY1JMqiKu8/hrSbbD52v3lYis
	XM7hgi5PPhmOGPVpmpMc+3bGkW8LKwIk5REmJ+EwJAhv6h8RKaBnNlKDDtYnaBoKm0wDwOCmaop
	acqK9Liic=
X-Google-Smtp-Source: AGHT+IHvmhNvokdhiDeZCaYjQcCM0epcPEZFOjtq+9XoutL8WlCTfktxFdlZD6VAvB+jQfPzwTGVbQ==
X-Received: by 2002:a53:acdc:0:10b0:644:79fb:7db7 with SMTP id 956f58d0204a3-6466a87f95emr31497735d50.13.1767529840792;
        Sun, 04 Jan 2026 04:30:40 -0800 (PST)
Received: from 7940hx ([23.94.188.235])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78fb4378372sm175449427b3.12.2026.01.04.04.30.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jan 2026 04:30:40 -0800 (PST)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	davem@davemloft.net,
	dsahern@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	jiang.biao@linux.dev,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v6 10/10] selftests/bpf: test fsession mixed with fentry and fexit
Date: Sun,  4 Jan 2026 20:28:14 +0800
Message-ID: <20260104122814.183732-11-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260104122814.183732-1-dongml2@chinatelecom.cn>
References: <20260104122814.183732-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Test the fsession when it is used together with fentry, fexit.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 .../testing/selftests/bpf/progs/fsession_test.c  | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/fsession_test.c b/tools/testing/selftests/bpf/progs/fsession_test.c
index 5630cf3bbd8b..acf76e20284b 100644
--- a/tools/testing/selftests/bpf/progs/fsession_test.c
+++ b/tools/testing/selftests/bpf/progs/fsession_test.c
@@ -180,3 +180,19 @@ int BPF_PROG(test11, int a, int ret)
 	*cookie = 0;
 	return 0;
 }
+
+__u64 test12_result = 0;
+SEC("fexit/bpf_fentry_test1")
+int BPF_PROG(test12, int a, int ret)
+{
+	test12_result = a == 1 && ret == 2;
+	return 0;
+}
+
+__u64 test13_result = 0;
+SEC("fentry/bpf_fentry_test1")
+int BPF_PROG(test13, int a)
+{
+	test13_result = a == 1;
+	return 0;
+}
-- 
2.52.0


