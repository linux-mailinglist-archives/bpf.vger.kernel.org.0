Return-Path: <bpf+bounces-63234-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A3E19B0473B
	for <lists+bpf@lfdr.de>; Mon, 14 Jul 2025 20:11:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D0A57AA447
	for <lists+bpf@lfdr.de>; Mon, 14 Jul 2025 18:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B82042727F7;
	Mon, 14 Jul 2025 18:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="zkXm4PrJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E46E3270571
	for <bpf@vger.kernel.org>; Mon, 14 Jul 2025 18:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752516582; cv=none; b=s8vCgp5YhufOaOY24SZo08wcVzlh8pCUkqiuF79hr/hZGxXvNgPR3fwC43tqaiTYVz1bl1J71+PIDqgt9hEJ6W09Hopp88uDcKuRwULRxOJcyzIHgtkZVioPh4gmSMwBkE2PIlcE4m2HCdi6e65uHdKRhLKm3wOBsJCzpfZASfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752516582; c=relaxed/simple;
	bh=JYYfuH+lTwaumMcaKIm1Mjx5EJTwz+NEYIR8eCVU6l4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O3IgQmOjafVeMjbvHujtBF6mgUflzupKekrWWUY+5+tBkyhtWrQCr4rX7gWB+cJt8pPcSf5RjwFAgQ2a7iOUGFYKsSgVEu3a0fIPG+IIhbhGQ9I3KZIyoSbzXth6/FY5WWIHujgBRoD/n+WZSOUnosk1vHXIgP4NboKNS5XuwVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=zkXm4PrJ; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-237d849253fso4966415ad.1
        for <bpf@vger.kernel.org>; Mon, 14 Jul 2025 11:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1752516580; x=1753121380; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sZHS/Z25KEWrT/i7QYhSLdG7UbyfdoDPHvTom044B/E=;
        b=zkXm4PrJ2G9U1anBjixMlXyd/cQE/rFdY+CaFOIoqENKnt0vO6xPJv/E6IF7bYG2cU
         DC5ih+rbj1nEhhllUkbWCcOn/6CJTwsYJyxiJx24oKfKeCLFXAoojBDy5jJadyl7lHZp
         4iDY51V23ief2eSixqhEqBY1Cq3BFXX811h92Xrw9GRlpgnjnc7Xq8/y4BLh0FfCZs7Z
         VZiyXs3pOI2K4QbMceMomOS5ZtRr2j42hepV/vFo1eW81LmM6XbDddMSPQ3KgLJq3bBi
         v3Pjj0QanhXHK8kpInZPns7cMgSUn2T60yg/M2D0t6/bc35Q1USRLESfUD1tOdWPv4gw
         Wlvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752516580; x=1753121380;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sZHS/Z25KEWrT/i7QYhSLdG7UbyfdoDPHvTom044B/E=;
        b=GylU6SzuK9N+zTibeDbVN5QfTVWhPVAozVqIGdPsBmG2argy8b2fffhg7yS2cSeOWG
         /ZBPvrcQFT9ZgyGDMXPIFaJimRRdfXVsh6iK00hGYw7HgKPTf7EfXajGoV7f79o070p4
         sI0XWSrqzlo8He+9J9buoCgTW6cZv6jyLo6/ZK1I5fh6nuL/x3PWk8d0RegMhaJxw6ad
         IAn26CtkoqZ1CdeP++yG4ZET2nIl9onU1gZt0Y93lIXDpESiQYkl5/j0BQcF/rqT6OZj
         n7mumTN4cs2GBBzOrMHLqlWfte8FC/Kk0uf/epWeWZ+da0CEjgSWnK3t0fv4RZBQlq89
         d1/g==
X-Forwarded-Encrypted: i=1; AJvYcCU56fXv3OXp0NoGyWC78ePXudCgER8e94Y+E86CXdqu+uOcEjFDRmmZCVK1MtuE1BECLno=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxc+zFk3WqeadVbKzMPIcWAH4OYeJD8aPvUUDfpgwTdBkW0Azub
	OcmxCcPCsq+sB6rTst465N0mDCXIEQcbanZgfEM+irJ9ApquAdJpqbo52lcSAdPp2EI=
X-Gm-Gg: ASbGncv8uYX633+xZMRaUxkC9j6OkaL7Tfjs7+iZGM57XvD8k64I0iNCQ7dJTI0HwyR
	B9GrGSVndPHKHtqn/hThKPTau42Rhc7a/NlK6O5NDPlLVHeEl828AwuLo/R6AgeIkFW1xXOqVXk
	QedIYKc8RZOiktZ523KL9UxsGLfD+JyL8Np+fGzwjHL0rbA5tDe+udNQkiGOdFtGrsKw6VE8gMc
	aXO72nGD55tGZ6h0XGF5JFr4Z8/FygI8J6ydlz9gKOvjShx5H9Ywjzs592GzgR8inbOkAgC5L18
	+KvPFDDl78CRWOU/RfBtNsBg6MlJO+3F7dtQZeQx4ylpTlRO3IqKiWCFsc14sX87COqqTSqyy5r
	0BWx2FlubqQ==
X-Google-Smtp-Source: AGHT+IHCro7Ewvtrb/PttGUfe+Z+qpQlphQ1Vzx3qAPeiMUfG+K1uYFXsjlo7oViIfLoo2WPPGA5CA==
X-Received: by 2002:a17:903:1c9:b0:234:c8f6:1b09 with SMTP id d9443c01a7336-23dede84f28mr74981955ad.9.1752516580201;
        Mon, 14 Jul 2025 11:09:40 -0700 (PDT)
Received: from t14.. ([2a00:79e1:abc:133:84d3:3b84:b221:e691])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de42aeadcsm98126405ad.78.2025.07.14.11.09.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 11:09:39 -0700 (PDT)
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
Subject: [PATCH v6 bpf-next 11/12] selftests/bpf: Create iter_tcp_destroy test program
Date: Mon, 14 Jul 2025 11:09:15 -0700
Message-ID: <20250714180919.127192-12-jordan@jrife.io>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250714180919.127192-1-jordan@jrife.io>
References: <20250714180919.127192-1-jordan@jrife.io>
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
 .../selftests/bpf/progs/sock_iter_batch.c     | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/sock_iter_batch.c b/tools/testing/selftests/bpf/progs/sock_iter_batch.c
index a36361e4a5de..77966ded5467 100644
--- a/tools/testing/selftests/bpf/progs/sock_iter_batch.c
+++ b/tools/testing/selftests/bpf/progs/sock_iter_batch.c
@@ -70,6 +70,27 @@ int iter_tcp_soreuse(struct bpf_iter__tcp *ctx)
 	return 0;
 }
 
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


