Return-Path: <bpf+bounces-60973-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 664EFADF2A5
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 18:28:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EA2B1BC3F3F
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 16:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4A6E2F2C6D;
	Wed, 18 Jun 2025 16:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="2vmF2nTv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA1DD2F0C5A
	for <bpf@vger.kernel.org>; Wed, 18 Jun 2025 16:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750263963; cv=none; b=eq+RKQSV2rbHmnyFU9qtligKmFyK1CeN8VltHvrtJAduqARYOEe5TB1DFRDOdk1lqxhAu20VsAADU1YFEIgcuDSwcCsZ82fsoZWmIwpAQs7wL4WLeE8yrzpwC1bHS58kMzn/z3pPkYEMXPESuz9fkCvZgIpanFTuO/DeiQRnWgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750263963; c=relaxed/simple;
	bh=8znAfQ1IP5+4ZLJ0094gbfhffGuzbrK/6tpSUK5ZSgI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WSFqRwQzhHr3JrW55qcAWtNvWGSLmrSxnyvLekpvkjW77DTPVYkfvWjU4KvRhEyzPpvxtiFF7H11zqrmG77JB2f3zOB/pdEtRoEp4fbZ1dUKwPTTHIoGTq/rZdG0K0Ry/MGyLmpvJLKfrW35gdQYDFL7LUnzzAz5DbN2eF9IBjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=2vmF2nTv; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-31384c8ba66so1290259a91.1
        for <bpf@vger.kernel.org>; Wed, 18 Jun 2025 09:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1750263961; x=1750868761; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hEMTgxL0uwtqGX7Eiy7dFlITzxO3HjkYHcIu9b6MYOw=;
        b=2vmF2nTvTcYmStbQRWU2QsBvesvT5puX04P6lP3k5vTgFxFTT7epEUHemLTVw+j/gn
         XwTrUe0qKj3WlXvDX6+uPNeQVfaVtKOQk46o7ep+finQmr1relfhFyeuE+DtmiPE16QK
         9ODUqGTtFAIk6mai/qtBdzcbJkeect0cFjgv9jUaKoL3aUg0eZHUGsJYUte3K7/3J30B
         YuOo8te4fDw8jVQBCqqXDNxJ+0t1ozatgZCmR8ycO70lvIC9wtxKahqgxt8aEuHGFKHN
         cqarHxr8xo0a4C4n6URMJt27nNr3AFendKp3cfVBH9v/0LJS9tkqXYTZLAUU5/EhDyUR
         X1qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750263961; x=1750868761;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hEMTgxL0uwtqGX7Eiy7dFlITzxO3HjkYHcIu9b6MYOw=;
        b=FXBEcdaW6+w4IcfaDZVXq0RPQa9YAnabNtV4Ufo3KCEPvtA64zFM0v8N8+uhTN1yeA
         sQaz7MwvglKgxdrt/seiZ9yDEij5ZWZbJnnxou5Lb+Zuk+/+f65xrMpsOaS/+TpnMA7x
         2sp4GH3eZhXjEg0IJShoomfPkMvkwH/SXHShY0kxe3Qem83JX3kUYbtsGUeTtwHIAYak
         TLLFiEZaljlUmkN/xmzM3/ISya58ipSgIPjZDVQvvKxkZjq5To0VMXmbBxLDrX2HcaY6
         FHTP/MjVQP4QpVSiTUBtLkco+RYKU0N/jAbuch0cSMPg5QNADmuzzFZpFCzTm6Nlbr1V
         ohtw==
X-Forwarded-Encrypted: i=1; AJvYcCXVsJ0SPxHZAHaDn5AHjh/3yf3NW2xLBq3jisDywSa2fuzgaoHX2E8xYbOTfNyOj30v9qk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyT/c1/aiNTGqdA+0BitfRa9JYlJkUbVN3rVX+ZPhlj1YUo2lyH
	fixtQgwXPRQg9Zx1AC3RrU7z8ALFr9loUZa28QfVenHXAhGAb8BtsK/ZwAtZOJJluYs=
X-Gm-Gg: ASbGncvMOTs42nQcolYWVd8YnnAuto7TRGcblO7l4IV8WrdZapFNOFtCyJtmG+N8/d0
	77CZTdA8rqP244TXmQuNgFHiO9KDEmALS0t9/vqxdtL3nX73GdnvU1rgCGD97QGUV69NzY/nGvC
	Um1NhbKba5NZghoZFYNoFyhGUdViUhsu1R3pu+eB+wRJujjzcbwCV2CZdCVhRCcovdhg3kYEHLx
	Ak3T0wOKqvn1hqN0ZeAZ7zHGEfBElyp/XOPfYH7T4tOyLr/XwfKT1q2W0cf9IkvAx4787feN/jd
	948UUxFODfJKp5JLka78EWXSY5jeVI0kbe0OS3fcrnn84IhzOQY=
X-Google-Smtp-Source: AGHT+IH/G5OFC/5QjcIcqVdSZjYPjbO5cB8wewYUnrAuiMBGclHnQwgLdX4VEHcpEv/vewBBbJddsg==
X-Received: by 2002:a17:90b:4d12:b0:310:8d79:dfe4 with SMTP id 98e67ed59e1d1-31425ae54f4mr4381052a91.4.1750263961332;
        Wed, 18 Jun 2025 09:26:01 -0700 (PDT)
Received: from t14.. ([2001:5a8:4528:b100:d683:8e90:dec5:4c47])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3158a2768c6sm137475a91.44.2025.06.18.09.26.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 09:26:00 -0700 (PDT)
From: Jordan Rife <jordan@jrife.io>
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: Jordan Rife <jordan@jrife.io>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: [RESEND PATCH v2 bpf-next 11/12] selftests/bpf: Create iter_tcp_destroy test program
Date: Wed, 18 Jun 2025 09:25:42 -0700
Message-ID: <20250618162545.15633-12-jordan@jrife.io>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250618162545.15633-1-jordan@jrife.io>
References: <20250618162545.15633-1-jordan@jrife.io>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Prepare for bucket resume tests for established TCP sockets by creating
a program to immediately destroy and remove sockets from the TCP ehash
table, since close() is not deterministic.

Signed-off-by: Jordan Rife <jordan@jrife.io>
---
 .../selftests/bpf/progs/sock_iter_batch.c     | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/sock_iter_batch.c b/tools/testing/selftests/bpf/progs/sock_iter_batch.c
index a36361e4a5de..14513aa77800 100644
--- a/tools/testing/selftests/bpf/progs/sock_iter_batch.c
+++ b/tools/testing/selftests/bpf/progs/sock_iter_batch.c
@@ -70,6 +70,28 @@ int iter_tcp_soreuse(struct bpf_iter__tcp *ctx)
 	return 0;
 }
 
+int bpf_sock_destroy(struct sock_common *sk) __ksym;
+volatile const __u64 destroy_cookie;
+
+SEC("iter/tcp")
+int iter_tcp_destroy(struct bpf_iter__tcp *ctx)
+{
+	struct sock_common *sk_common = (struct sock_common *)ctx->sk_common;
+	__u64 sock_cookie;
+
+	if (!sk_common)
+		return 0;
+
+	sock_cookie = bpf_get_socket_cookie(sk_common);
+	if (sock_cookie != destroy_cookie)
+		return 0;
+
+	bpf_sock_destroy(sk_common);
+	bpf_seq_write(ctx->meta->seq, &sock_cookie, sizeof(sock_cookie));
+
+	return 0;
+}
+
 #define udp_sk(ptr) container_of(ptr, struct udp_sock, inet.sk)
 
 SEC("iter/udp")
-- 
2.43.0


