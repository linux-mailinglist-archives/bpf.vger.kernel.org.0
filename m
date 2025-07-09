Return-Path: <bpf+bounces-62858-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D06FAFF530
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 01:05:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8FCEF7A55F1
	for <lists+bpf@lfdr.de>; Wed,  9 Jul 2025 23:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D58D2255E34;
	Wed,  9 Jul 2025 23:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="K8UioUWt"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08DA5253F3D
	for <bpf@vger.kernel.org>; Wed,  9 Jul 2025 23:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752102233; cv=none; b=rhRq1D20dP8jKw4sYpJs0EbaunVNgHReEp5EkS7jc6i3URJ6bDKio0Sxre2dCL2PiUJYCmNVaOgkVLDBGBvYvaR9eQfWKYWQScc9n0nCshZqa5kjq556IFsyA5efRGGs9xRcHWsZCX0i5CFJFtmJB4wEGz/TqEp5tO2h9ocnN/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752102233; c=relaxed/simple;
	bh=JYYfuH+lTwaumMcaKIm1Mjx5EJTwz+NEYIR8eCVU6l4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mcrGrOiFznlt06w3pdcd2p2V3niYH5+0F6CkTGjS4JqTWOhKmRrHILICztWcLqgAyVqDh7FMFv1VSaC8k3Mkjc7GQNh0VlAT0uUsJtMsNarK45g9iYxVT84p8/ZWNtkSFGIqtAsd51SY1K5GITH3Wgss5MLLFXknUaTo8qNONIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=K8UioUWt; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2355360ea88so594555ad.2
        for <bpf@vger.kernel.org>; Wed, 09 Jul 2025 16:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1752102231; x=1752707031; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sZHS/Z25KEWrT/i7QYhSLdG7UbyfdoDPHvTom044B/E=;
        b=K8UioUWtZVJ39PKN7fq7ieqBqGM6ZP4gRXOfeVUqWE2+Kj1fzvNms+QrXBZV94zOEB
         CnbpYp5cMObzgyUow4+3RwKde56E8WkNL12BfkpfBftu0Zi4KgIXBWGOJ5mHBCi3rB3v
         mQzim7RYGVp8kQiW36f4TXE12ieaOANQotEUt2e1octDz22z3aVz6vKMFN9TNgOmysut
         kGTzYCy+EhOD4i2WaGcrXtaUqT366HsZoCy1gaXB6iDPEBymHbPCS3G6ApIGZ/r0JOUE
         ZLobzZlWaxaHbHzYrsZ9wDgh9uoLI6wGWs9DPz7q+w2Kr4zviEuJtxZKxUcVKnf7XNBw
         9Ahw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752102231; x=1752707031;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sZHS/Z25KEWrT/i7QYhSLdG7UbyfdoDPHvTom044B/E=;
        b=fvBbLt+hs38GAAMf0CAzMzkH9TZRlWIGB6O277OpGTBrOllPKCSBKZFmM37s54hs6R
         gsSS5dh0RTUOZ34MOXQiwqSYEZ5kUO5pYczePLXJzY2Yb2fUIZtTkH6hlyAq4Kh7NgXn
         jaACXfI+E99VGv+Mr0F2j0EkTSUm/yOf4ZA3H+2sSKZIUaVTMhFXJNJ/JF0HO/HgDyhq
         1OtiOQ38/fRjnZuUter6IHu3jjBHGuA7eXlVZsmdKdJaLgHbfeS0evMr9eFlnbgadfhL
         pk+JOymqflcJhTnWE0BrEwJ2QwTE8/ZxUUGZTlIC20nsSDlnRNSjqOzXUPTtIQMfWl0j
         JXJw==
X-Forwarded-Encrypted: i=1; AJvYcCWgrW8nADppus0TQUY9KdqklBx/IMShc2Cywsk/ATWadDGLcoWdngFEbUFEqAcpL3IMz2k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLFQfuPOqv0NCk717C8YZWoMPAOUyBVGTYiIOBS/Hu/kVhCECa
	h8Pak4ZyzZsLFkWPeZ1JpC08MXfbLHjFQncAEYo1NTQ8C70kuRlt3Y0wz5cVpMX/n8VKvkpB22P
	1q60A
X-Gm-Gg: ASbGncuWa/nrjG8oWb12aY8eg5SEdKKGrW1zjpPQv/45whshOaH8ntDDj3DS9iwQAZ+
	pZ+WJnT7mnSd1PBm9fA9qaG7/2QRg/HI6z8yjoH/DALCQ061xxpy0akSMXh9mcGGG3IgdK8G2Wk
	hyKVjJllJr3qgMTwoGStV9Hbs5Dy8E390ljK9ExIjpBXU93knp7CA3DOFZ5eb9+IEfMSxtsFT4l
	zzS3VWv7PFyRzpofqZmjmeXowNn1msra2ByvXFH1XUe+Yh04OjrFlWY7PMG/PsPayxymYaFu67m
	z2CgF/lepUlEgSWsip6cB2gLGTr/BopSkVoe8tds46nDLK2svIg=
X-Google-Smtp-Source: AGHT+IHOiSjm84qj2GrVnLMMgJpFqnEWUaEvssOaWn174ZtElkUYs791Bz+7vIJ9pifxxhix7y4dPA==
X-Received: by 2002:a17:902:d2ca:b0:234:cb4a:bc1c with SMTP id d9443c01a7336-23ddb1a5cbemr23582025ad.6.1752102231194;
        Wed, 09 Jul 2025 16:03:51 -0700 (PDT)
Received: from t14.. ([2001:5a8:4528:b100:d121:1d56:91c1:bbff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de42ad212sm2679015ad.80.2025.07.09.16.03.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 16:03:50 -0700 (PDT)
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
Subject: [PATCH v5 bpf-next 11/12] selftests/bpf: Create iter_tcp_destroy test program
Date: Wed,  9 Jul 2025 16:03:31 -0700
Message-ID: <20250709230333.926222-12-jordan@jrife.io>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250709230333.926222-1-jordan@jrife.io>
References: <20250709230333.926222-1-jordan@jrife.io>
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


