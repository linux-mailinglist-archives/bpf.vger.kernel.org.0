Return-Path: <bpf+bounces-78059-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0544ECFC42C
	for <lists+bpf@lfdr.de>; Wed, 07 Jan 2026 07:57:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E0C2D30194CC
	for <lists+bpf@lfdr.de>; Wed,  7 Jan 2026 06:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B9F02D63E5;
	Wed,  7 Jan 2026 06:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DwTMbxd9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f196.google.com (mail-yw1-f196.google.com [209.85.128.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C8C26ED59
	for <bpf@vger.kernel.org>; Wed,  7 Jan 2026 06:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767768366; cv=none; b=NqcgLnOFyK2DYQ6dhGWDhY5h932GcKUK5HCiMXNpoHzgLerJaVt3RNMur8XTBp8bLpX5+EgCH2Tiw2G8yxZawebJGDd5gaeuQwY6SSl3bnq+58PYFT2qklI1lbgEtaPxs4haaCO19JbB4fY7grca4D0Zm9TDm8sjhnv4t2ZIUUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767768366; c=relaxed/simple;
	bh=agW6uKNys5gOeoTrVORTjBOaAxozAsYVc4VUeEIRBqk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iq6jM24vhRysyNJe5EiW1w2KbH1whmuU6djtSZ/S/4Pf5pqe+Jm70N3greOY0HGnyE2XCeEDtTK+4LSEjHF7GfccVkZx75PCu4CfxyJKmFsaddUbeSWQnIOkN7TIWZFO+dxNzfEFSrOJBzWcyKwBi6Xf/a+5mOscigDm0FQsY3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DwTMbxd9; arc=none smtp.client-ip=209.85.128.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f196.google.com with SMTP id 00721157ae682-78fcb465733so19898647b3.3
        for <bpf@vger.kernel.org>; Tue, 06 Jan 2026 22:46:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767768362; x=1768373162; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ft9yy1vLUwNJD7u+x5LfWhJWNGjlertbzF816wc1jaU=;
        b=DwTMbxd9IeAkkEfBrWzCeXpKfpwnwxgy4qvoLrA7f5okRsKRS6kCKXQWNhIWiYmYtb
         xi9AcqxJzqdTUJJZpsKrCA/IfJciYGjGdmJ/DJ0oRMlQVLmC97Ie7Qebw8Miq2iw6ZF5
         Ol5BpIRNaY4kOdOVMF5xLz4u8k+ymUYRV6nDRkJ8es9+hlZo4QgFntzN1K+oAYC8M6He
         9Jlres+ElBWns1U7IEJhSUs38m1gpd5Ym0c6VAN+Swdr0Xo4YVYtXnrekRgfSqmeEIuR
         KqaVy6ivG7+8oBbYUUa1c1LDt5iro/aiSs07/0Z5I41IB/xeol1ETzyWNBIVLAPd9ZbT
         HeZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767768362; x=1768373162;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ft9yy1vLUwNJD7u+x5LfWhJWNGjlertbzF816wc1jaU=;
        b=PMFWyBpaRsjl9f0uiS4YAhHeKgusyifCwhus9TVk5gtgDQHSwMY5mCjowgy5NOTUca
         USQ8isfD3Y11jjBOeZU4ekuXLD6kANn2QyE06Ks5GW2Nqg7oM8FaLR3uOaZFWypb2Dz1
         U91lfkTeu/B3g8Gvt0+pxIY634VaO+srB7DvzCbGQ4PH8XDzeTixEryPSQ75dpw5voXg
         Y38TVfgd9Uym3tc9MDQUqyXb/jiI6AVnTfpinh9UWIpYpb4mtDwAFKnB8peF1m1KFq6k
         Zu0PKyQn6ekUAKzxucv9cXoDoYnMIaeNNcHZioG4TJwefpNjCMkfpjnpuGNt5yNqHj08
         TX+w==
X-Forwarded-Encrypted: i=1; AJvYcCWLHYZ2uL3uJ0zdNODq4UyyUIU9QFdfnbPZz0j/P1CiyXDk+5vkAzYaB+RBf1ugV/jms6Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqLT5U1WC087qqQbQM7cozI5VmPeP4AFg81FUFGxKk7YTfDOsw
	vv3rD79GwjO5jLkIX3tCg328kozOwo5ohK00MmkTEvQfHRK3ZpYLPbCJ
X-Gm-Gg: AY/fxX7xuiBGRtcvLx1veYHLn08P9I8j1jBhy3l1pjYbX2BnW8iKg5EFFNJtdFRWsgg
	P/J/vOhP4UaNlRKIz6kRPzbZcHppYaR/IBzGeGZsJxWzzFT8ZBiudyPpgt2DlG3QpiaObUQrgIq
	DAjSsQvyoSNPOM/IowQSE3rZHrb006fEKsuNNkseG+qe512638o7KeZLxpZsdj+b4+nOKgEe5N4
	eKIcCBVSstyMyRaZjSezqR66pvwUJA+PIUB/pn2sxGp6UpmbhPKqlosRao3XqhU/e1W9/R5quNu
	T8kJwVUzP+/C+RTHu0sG6nHOc6MZFst9Ftc9wlaESx4PM388EY9fxdCKQoBP3SN49IqzcKDbiOc
	CXZkjayZry3VSsttL+DAjEqJVEgz/lTi8PIUbb06B/l+MQIqzqsCtFILIa3UyKjN3zkqRMRd0Hc
	I2tJJsP7M=
X-Google-Smtp-Source: AGHT+IFRwIpFYE8JW/BqV+Uh4FKDeGkj90yb3724hL0VZNUbVTJ7ud+xBiwCBD2KX8IWvAZdS1l7iw==
X-Received: by 2002:a05:690c:e21:b0:788:763:17bd with SMTP id 00721157ae682-790b57edc61mr16814257b3.60.1767768362444;
        Tue, 06 Jan 2026 22:46:02 -0800 (PST)
Received: from 7940hx ([23.94.188.235])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-790b1be88dcsm9635047b3.47.2026.01.06.22.45.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 22:46:02 -0800 (PST)
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
Subject: [PATCH bpf-next v7 11/11] selftests/bpf: test fsession mixed with fentry and fexit
Date: Wed,  7 Jan 2026 14:43:52 +0800
Message-ID: <20260107064352.291069-12-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260107064352.291069-1-dongml2@chinatelecom.cn>
References: <20260107064352.291069-1-dongml2@chinatelecom.cn>
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
index 85e89f7219a7..c14dc0ed28e9 100644
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


