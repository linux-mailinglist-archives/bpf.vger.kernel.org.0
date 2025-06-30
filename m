Return-Path: <bpf+bounces-61867-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DF30AEE587
	for <lists+bpf@lfdr.de>; Mon, 30 Jun 2025 19:18:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 144193BEBEF
	for <lists+bpf@lfdr.de>; Mon, 30 Jun 2025 17:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27DBC2980D4;
	Mon, 30 Jun 2025 17:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="M0MWgoeP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B072989A2
	for <bpf@vger.kernel.org>; Mon, 30 Jun 2025 17:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751303856; cv=none; b=Yv2K+/1y7R5wETcI8NDCaf2Ns2f4yY1B82AWaPgDlKwYHQuj5liy+YU+lfYCAZRz62vRHOsacy07Y4PYISTbITAJHS+yWaM3p84FtaFdGnY5slOq5bnXnCTqIvbg0zxynjp3YElJza9lZ/J/0HA2HogC/U5aOdwWQGYUNyOyoQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751303856; c=relaxed/simple;
	bh=foepoQWthtqzAO/amSXmA+Ijs1+fWhMG2CBZ9t6Tz18=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ie30FLwGUTR5IL/V7/hI9W9dCSqVBmTpgnuB08834DjY/CoHD/rqr48MeCQobBAWazBlv8Q8O18fnjJKd6JUddZ9H0gizlOLz+t9QEM6vtfXwK/6gq0wO73xdSdzByl4YrUB5i7PgQmtPBK5AmZFBtwvaEXZGPaekZs3etaZtok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=M0MWgoeP; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b3510c22173so218679a12.0
        for <bpf@vger.kernel.org>; Mon, 30 Jun 2025 10:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1751303854; x=1751908654; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vKLGPM6fsUvefIfdoj5d/pH5CeVPkyRVwIbtrb7Q6Tw=;
        b=M0MWgoePw8FkrFUksq1CQ1Ms3dU+Synq+rlOGEIHzQkad0MLoNg/HzI9j0lkOQoTvQ
         QnvFh9eTLIJhgkfXhNYgldFOAzgh1Rj76jreMGrMv6XyEkf4I1MEl10E7CVCvXlrkpaE
         vL1X1tmZyqB5fRJGPvBRlDztx+O+VdeTSFPQTbKL/3pt7QR9oYQLFU2GWKXfvlmZIbf1
         Vh7BjWiaLGT26LlTIDHVC8LCrbFRcRqutzKmH0W3fe77SUa/AAVuRV04AxRRe1Ddd5Z1
         oOJL3ZLmE1e8QIuUTdbsW2xhtxn4Zq8deaUamX2e44w8EL8aTNQBZxNsz2dty0R5bcAW
         1iOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751303854; x=1751908654;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vKLGPM6fsUvefIfdoj5d/pH5CeVPkyRVwIbtrb7Q6Tw=;
        b=TfZVq5vsaqc8It/dRquRTgnxry9EDJs8cX68hgJoqWBau4Sql6UwJguvlDUUcUwsip
         EdJ3hy8Lnjv8urTqbWNGp581ysxctgmWevFbaHrutAPdY5IRE3bxW3paWM0BkSch+cfM
         w9+HM64ixSjUANPZW60khKBNatrH9IdPqYWV9NmMAawEmtZ/ArY9rZN28SoesPAg2wog
         f6ddXU12gMGSisDcaUMSwNSeDPbhrS+LhHhAf0KQ/8FZW0SByyNIVGQQJAuAXI8DBMSi
         EBGjRF7si+ctTKjBMpaLYCs3lK0lquq5Je6KW2cC5k4Ey3lsTGOXM+zGgSGqcUWp+UJV
         q2WA==
X-Forwarded-Encrypted: i=1; AJvYcCWx4L79MXG+RL3WKYxF4qH6vVoecoC3jgYB0tlztIQloVxeuNb/seKzcV5AJEMnJGPm/84=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdoMTt6tdpApZdyBr+jlztACz5d37GUkNrFiHhvzIN4qdKeSWS
	+b/yZFVzadG857+TfrlVOL6EezHj0waim/xCjL97haacGhIcVePUkcyrcZkZGOVy13Q=
X-Gm-Gg: ASbGncs68WBjAe/fGImD6B5ELZm/e4g5vqrxWGSf3tz7TNN+xotQaaoZwZ3Z4oSJqSW
	U9IbzwPenEagkIDg6m1CV/93Zq5LdoWicadLfhuMCHOZs3v/P/uNiJ6SPsoyjEFLZUQSTWnbJ8k
	Se5F++INVeUXNuWjokOfhtzTIh8tH97u62PT9Kd/mPkqVCe9FUKv6XPAofiJ+5Km/WSVlW8vD0I
	oX3e0LsCSEru9YISvztIDM1bHBJBVqmOEj22PHq+RiznOR/DeUYPytfGBlNSO8Sc9/vGdIxNJjn
	95/XyYXNygf1e6V22n5OeFGsX/wrdj8cTNjRUQh8CWeVA8rnAQ==
X-Google-Smtp-Source: AGHT+IFPoOZ7DHExCotaE+9HxKf4rP0cmsuMLpa4XpFjsmFcK+SBuitbW6tTAXGGVyDrRGsbRGDVRg==
X-Received: by 2002:a05:6a20:3d95:b0:21f:419f:80a9 with SMTP id adf61e73a8af0-220b060ec69mr6913020637.10.1751303853806;
        Mon, 30 Jun 2025 10:17:33 -0700 (PDT)
Received: from t14.. ([2a00:79e1:abc:133:9ab8:319d:a54b:9f64])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74af540a846sm9229232b3a.31.2025.06.30.10.17.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 10:17:33 -0700 (PDT)
From: Jordan Rife <jordan@jrife.io>
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: Jordan Rife <jordan@jrife.io>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Stanislav Fomichev <stfomichev@gmail.com>
Subject: [PATCH v3 bpf-next 06/12] selftests/bpf: Add tests for bucket resume logic in listening sockets
Date: Mon, 30 Jun 2025 10:16:59 -0700
Message-ID: <20250630171709.113813-7-jordan@jrife.io>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250630171709.113813-1-jordan@jrife.io>
References: <20250630171709.113813-1-jordan@jrife.io>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replicate the set of test cases used for UDP socket iterators to test
similar scenarios for TCP listening sockets.

Signed-off-by: Jordan Rife <jordan@jrife.io>
---
 .../bpf/prog_tests/sock_iter_batch.c          | 47 +++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/sock_iter_batch.c b/tools/testing/selftests/bpf/prog_tests/sock_iter_batch.c
index a4517bee34d5..2adacd91fdf8 100644
--- a/tools/testing/selftests/bpf/prog_tests/sock_iter_batch.c
+++ b/tools/testing/selftests/bpf/prog_tests/sock_iter_batch.c
@@ -358,6 +358,53 @@ static struct test_case resume_tests[] = {
 		.family = AF_INET6,
 		.test = force_realloc,
 	},
+	{
+		.description = "tcp: resume after removing a seen socket (listening)",
+		.init_socks = nr_soreuse,
+		.max_socks = nr_soreuse,
+		.sock_type = SOCK_STREAM,
+		.family = AF_INET6,
+		.test = remove_seen,
+	},
+	{
+		.description = "tcp: resume after removing one unseen socket (listening)",
+		.init_socks = nr_soreuse,
+		.max_socks = nr_soreuse,
+		.sock_type = SOCK_STREAM,
+		.family = AF_INET6,
+		.test = remove_unseen,
+	},
+	{
+		.description = "tcp: resume after removing all unseen sockets (listening)",
+		.init_socks = nr_soreuse,
+		.max_socks = nr_soreuse,
+		.sock_type = SOCK_STREAM,
+		.family = AF_INET6,
+		.test = remove_all,
+	},
+	{
+		.description = "tcp: resume after adding a few sockets (listening)",
+		.init_socks = nr_soreuse,
+		.max_socks = nr_soreuse,
+		.sock_type = SOCK_STREAM,
+		/* Use AF_INET so that new sockets are added to the head of the
+		 * bucket's list.
+		 */
+		.family = AF_INET,
+		.test = add_some,
+	},
+	{
+		.description = "tcp: force a realloc to occur (listening)",
+		.init_socks = init_batch_size,
+		.max_socks = init_batch_size * 2,
+		.sock_type = SOCK_STREAM,
+		/* Use AF_INET6 so that new sockets are added to the tail of the
+		 * bucket's list, needing to be added to the next batch to force
+		 * a realloc.
+		 */
+		.family = AF_INET6,
+		.test = force_realloc,
+	},
 };
 
 static void do_resume_test(struct test_case *tc)
-- 
2.43.0


