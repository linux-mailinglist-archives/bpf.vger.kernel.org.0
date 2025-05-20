Return-Path: <bpf+bounces-58574-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9ED7ABDDDC
	for <lists+bpf@lfdr.de>; Tue, 20 May 2025 16:53:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0FD7D7A5203
	for <lists+bpf@lfdr.de>; Tue, 20 May 2025 14:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D296525178D;
	Tue, 20 May 2025 14:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="PIpnOHkQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B25250C1F
	for <bpf@vger.kernel.org>; Tue, 20 May 2025 14:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747752686; cv=none; b=qQt9moIUB/x14xsHeGN2l8Mv1xAFZZ0gO9CTcNlxR4f7tdz0spi0yfWXCHx031vCej5QVyl4XKNMB6dzp4uQwT820mHbI67dh9N+POld/ou3vOl+knfDiWg2HFvTxr5z5nM3FETWPh+BJXn13ZgeJGSWfonS474B/lZoABl0Lpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747752686; c=relaxed/simple;
	bh=foepoQWthtqzAO/amSXmA+Ijs1+fWhMG2CBZ9t6Tz18=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QvefAdw+5LunopsPIlirHpQ5kvFVmK1ygaB729sfmbhrNEOJLdNCPRhngQMxitCwfs5rvPDiHxCI+tO2FzBLFrZt0Z/N0ogum1c39oJspRjoSOVMfC/KQlzSck3vu1Wq34oCRglPgsy1x7sxlmm4dSUDELFMDpnEC9MrOjnu60M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=PIpnOHkQ; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7390294782bso584335b3a.0
        for <bpf@vger.kernel.org>; Tue, 20 May 2025 07:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1747752684; x=1748357484; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vKLGPM6fsUvefIfdoj5d/pH5CeVPkyRVwIbtrb7Q6Tw=;
        b=PIpnOHkQpQe/hb2d/2787LlMQWafZMQfakY7Oj9Fv70Oo5OAefo4GuLb4+4zc1ewPL
         KPW7A9VQCqkAr0tUMtu96c3OcEpYC5E6RzZJJBBWb21fodRWjCyopmn6wq+N1mOgwQ9Z
         mWg5F0Ran3otbQVWChxuBK+mq1c9nANSnfvov75w0Mmd7/N+/GUTJLNBXb7dc5OeH7cM
         UPoNsT45XS74gLoWMA/NHNG7+NlL5SENejqva1KCnc8ygqUQ9eFbn4zrfCf+9wBA9ob9
         BixtOEMFA2pct/2beFd07wY/eImXq1B+XOftl+mvwRsfUIBDn0CUn++V8wUVji1YeIIO
         +QBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747752684; x=1748357484;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vKLGPM6fsUvefIfdoj5d/pH5CeVPkyRVwIbtrb7Q6Tw=;
        b=hQqAHPbHs5iEQFMRzQmY/5Qw7TzKgxC98lBQKtq+YKMBs/cpFP83E03dGfCf2IjeaU
         x1eDAHcAND6ZfpT12jnF04WMCuQNmYyNjMAOBn15Ah2v3GZ0QLMT7xVghrGeg1rKzYxL
         eDT1EcsS1OEx0dXhO568RHxsjMwyqBNW5m+hVxxKgHTrGq0bKK4TSnJ2GSMhJYD2jUvx
         jDhn66bv7Fbl6xIFTMXUw2XDD62qrW2pcq9evgcRU4fNusP4ro204fs+cPe0ERMiQ5Kp
         LYTQqccW7QwycFVSvOIttwojIlby4HfnckBQ1Z0y+vbNCuIahofl6n3nUjzHtf4E34eV
         35CQ==
X-Forwarded-Encrypted: i=1; AJvYcCWEBP8lY34wmKfBRM4++CWI2wcHwXro3Hi8aSFfDQ1EL2MGigKg3SGWQ7SRJjgklxopJrM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBB98IvkJ9rJ6IPYCRdPVO/Xts5VX0dyW6DsvB0VncRyRsQAYK
	NVKYNhBs4d6ZB/HFeNaMgPWwNWxBgCsaSqCI7alMPikVZqw0/8H6FwZ7x8NkvZVPMG3cvw+bX+9
	MFcQ8f0A=
X-Gm-Gg: ASbGncubsn+L+N+fwhAlfBm4FLMJN45bwg+lUVi7/eJpJb4P9pPT/tBBrwkeDIW+hxl
	Umb4D/Md+J617mnyjIL4orgdjwIw6r6ZAnEP+5wwW/sOLWwbdIvPuGNinUmpJtJCvNFw8IbO6m7
	k8tDDomF9mJF+S+x7SoHf0paeY/kl7vgt9FIDieg3O3VqGsCb5ng5+3u9Fxk50lsUhDZFTeSpvj
	Kx12fYPVV7YG1iXc08aFTGKVcACyxsGm7jzzJE7PpoA5/KIAl8oW0GWNOU+BL/gn1uFqQa3cq5u
	2J0KbPqEOkoIDi3SSeBDCNWchHoAQNYYz1DBGvp7
X-Google-Smtp-Source: AGHT+IF0F6xtLP2HHB5uOTkdRK6j/UQO37x83W9I0aWOiPNT9KpY2EBgs1u6lQupNnv0Z3avSxv17A==
X-Received: by 2002:a05:6a20:3d0f:b0:1f3:2cf5:c964 with SMTP id adf61e73a8af0-216219bd5d4mr8771721637.6.1747752684194;
        Tue, 20 May 2025 07:51:24 -0700 (PDT)
Received: from t14.. ([2001:5a8:4528:b100:276d:b09e:9f33:af8d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a9829bb3sm8242993b3a.100.2025.05.20.07.51.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 07:51:23 -0700 (PDT)
From: Jordan Rife <jordan@jrife.io>
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: Jordan Rife <jordan@jrife.io>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: [PATCH v1 bpf-next 06/10] selftests/bpf: Add tests for bucket resume logic in listening sockets
Date: Tue, 20 May 2025 07:50:53 -0700
Message-ID: <20250520145059.1773738-7-jordan@jrife.io>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250520145059.1773738-1-jordan@jrife.io>
References: <20250520145059.1773738-1-jordan@jrife.io>
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


