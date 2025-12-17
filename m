Return-Path: <bpf+bounces-76854-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B0A02CC6EB6
	for <lists+bpf@lfdr.de>; Wed, 17 Dec 2025 10:58:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7B299301ADF9
	for <lists+bpf@lfdr.de>; Wed, 17 Dec 2025 09:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CEF0344044;
	Wed, 17 Dec 2025 09:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vrsuoc0G"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6145A344032
	for <bpf@vger.kernel.org>; Wed, 17 Dec 2025 09:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765965354; cv=none; b=DZ2bsYQe6DQdLY0YpDcsWZ2uhSQWv/mRLG9IBm5h2NKfb/DQ2L1uyG8A7L1BcIdzWq5jHUdlOz6pACZOBxD1UXYrW1fXT5TaYKt0oq/YSU0le9xLwmCUTtRF/FzV2eeTLUp/u3wBy+R9qFyznvx47YDASCpBKnuembeG7i4XHQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765965354; c=relaxed/simple;
	bh=Yb5/UWx4ETqVzjpmnt4mp4ucReGhuU4KaNvRMGqzA/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pnr6IIQVuO+cETYzDEK2lYwYtlCv9rFjTYXePasLT6bzfC7BnOsvKpdhFJCXfjk9VHjEV1tpq9CMrUv0P7kqfSChjPYbpYIPHKDehTTBek7kowOifFBuIcV5W4OKvPqJ9CYhO+1fOBvhRguzkb0adDAsUP/GXc6May00gd1SvTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vrsuoc0G; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-2a0bae9aca3so46729985ad.3
        for <bpf@vger.kernel.org>; Wed, 17 Dec 2025 01:55:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765965352; x=1766570152; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N1TUFEJUx0NUwFPar33N5JyqgDjZHtLZ8/dAi+dAv+U=;
        b=Vrsuoc0GGDCWFdn/fgOI4170rQDbkpEruQK0lgp3GxtjQKpW5K2lvepj6Ly8CSgSO6
         02kPVnPwHVLGYXGM/DlykQ6jWYov3gX13dBeMOJG1VdOXbHGxjpuIyxEjB7l1s0EwMmR
         6IskURwA59Kwp6VtI2YxoDZQLvIFBFo98lR7lad6mPgdfFhNcROj/gJq8r/nwnMSJHMk
         DQdKKsai+4dXCaEyRiBwGrjT3e9CecVVjNJcfUGWaLvzqmpwSdwW/kIZREnSy0KC9ylj
         zu/vvXAPoQhB+A2JfCDv+4xr0q5+0N5jOL3XQFaJN7O+uceVaFgcUMv8QqZNpsZLf0J6
         qnRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765965352; x=1766570152;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=N1TUFEJUx0NUwFPar33N5JyqgDjZHtLZ8/dAi+dAv+U=;
        b=SZIZgyXvpYKIKT/dTAtkSyOAJQV8DO3iszivLGZi4qC8ZiZZlxfN+Kf6Hp86BdUhdo
         h+AYtmmNs3QjSETfsbXzcwi52Dg8H+SeYcvEr+MM/i9xiFQx02Oz23K8MeJo0Wg7KhWj
         H8SmmL+eja2U700HZTEO+XmK0Sgdoz0i/6BnA0zBVmv0JfYC8q+3wqQRhie2oYbR8Vk/
         oW52eD/WK5aFLNDOMCDQSZwRsLo0qf207BP5IzMrYKmfPx0iYvzZ8kU1KJSmQ627ERan
         Y0uIUV5dISU0lzijZeiXygonp/QW2TikeXu/6Zi1+uFjT9fnqpPIc+U5BvfCROMgJBNv
         leHg==
X-Forwarded-Encrypted: i=1; AJvYcCWYLd3Sr8vcNPVf/cWoiClil9eswBoZYigUV2YDcKxk33ze8uImG9NfdhacTxTYkdDzYg0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywe3l4woG+3ATu4j8ntJFPZGIiRwwRqtL+zPAqOfm0+757pr4eK
	FV1pgfAnQUKn27Qwov7KAJ51vdka2NJG3heg4QUxoa0DKXvQYUHgkpAb
X-Gm-Gg: AY/fxX4LC5b8xSsp4sO0IskoWgbiQEaVQgma3KFfCehlofO+6Tj9IPRZW4Zg72cA8UM
	SUEgMUsNY1oOAk+y0HMsL2FYeLz9j0r4f3Gp9jRp+MURWBtPRBn0nmqKdP/6Xx01+iFoWHm7EEb
	z+jmpxsd72MLgleF2BRzaN9f/81TKxu03sk7PZukjAplxsR6zjl/CDZbOH9o93kigId0eXqgDjE
	AYspIMR6TYdv9uq2W9FCM53nAQGCQCG9Y55TYGLfX9otyf3iIVWrcb4TP5S99pfUaeElovNwnWz
	peob7Iidovu/1qpgAm6469GONo3fsGKnqgF4cPeMNm00YRRXAwdKZ9WIPx1/L+cHldrLA5fxU1d
	5U0jTqbV4KI2SVAcW2QVMZ66nsfd2nDqxeswbfuMFfUnA1i+vB6Zescah5DkiaBopPDIgpQeyS3
	E0qIl5fIs=
X-Google-Smtp-Source: AGHT+IH/IrGCAvWhN5SwCzXnuM6ATb26TVbLzAtyqwtKp2xc+K59EJog5pKbvQBAIw3NE1gXxnNZ3Q==
X-Received: by 2002:a17:903:144f:b0:2a0:e80e:b118 with SMTP id d9443c01a7336-2a0e80eb3bemr106850305ad.7.1765965352560;
        Wed, 17 Dec 2025 01:55:52 -0800 (PST)
Received: from 7940hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a07fa0b1aasm140715945ad.3.2025.12.17.01.55.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 01:55:52 -0800 (PST)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: ast@kernel.org,
	andrii@kernel.org
Cc: davem@davemloft.net,
	dsahern@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v4 9/9] selftests/bpf: test fsession mixed with fentry and fexit
Date: Wed, 17 Dec 2025 17:54:45 +0800
Message-ID: <20251217095445.218428-10-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251217095445.218428-1-dongml2@chinatelecom.cn>
References: <20251217095445.218428-1-dongml2@chinatelecom.cn>
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
 .../selftests/bpf/progs/fsession_test.c       | 34 +++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/fsession_test.c b/tools/testing/selftests/bpf/progs/fsession_test.c
index f7c96ef1c7a9..223a6ea47888 100644
--- a/tools/testing/selftests/bpf/progs/fsession_test.c
+++ b/tools/testing/selftests/bpf/progs/fsession_test.c
@@ -190,3 +190,37 @@ int BPF_PROG(test10, int a)
 		test10_exit_ok = *cookie == 0x1111222233334444ull;
 	return 0;
 }
+
+__u64 test11_entry_result = 0;
+__u64 test11_exit_result = 0;
+
+SEC("fsession/bpf_fentry_test1")
+int BPF_PROG(test11, int a, int ret)
+{
+	__u64 *cookie = bpf_fsession_cookie(ctx);
+
+	if (!bpf_fsession_is_return(ctx)) {
+		test11_entry_result = a == 1 && ret == 0;
+		*cookie = 0x123456ULL;
+		return 0;
+	}
+
+	test11_exit_result = a == 1 && ret == 2 && *cookie == 0x123456ULL;
+	return 0;
+}
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


