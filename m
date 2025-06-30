Return-Path: <bpf+bounces-61872-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77C7CAEE58F
	for <lists+bpf@lfdr.de>; Mon, 30 Jun 2025 19:19:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC1E1189F395
	for <lists+bpf@lfdr.de>; Mon, 30 Jun 2025 17:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97415293B61;
	Mon, 30 Jun 2025 17:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="zEgovvxj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C28062BDC09
	for <bpf@vger.kernel.org>; Mon, 30 Jun 2025 17:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751303861; cv=none; b=OyN1iYor2ITsadQdoJozze6Vowwc9cHn1QHBDY1mz0Cb5KHp3i6zOrjFb8BkvXYt3kAA1ODkqhRLXp2z9CM2FOuyXgKlT6lanncsr/MnsPHyIR+4jF3p7olgHGELS1+rDmAE23S3xJgFhAhrSTBi2nAVFob3z0Dv4QcApWZTRQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751303861; c=relaxed/simple;
	bh=8znAfQ1IP5+4ZLJ0094gbfhffGuzbrK/6tpSUK5ZSgI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bZEnI+gylpSUE99iBH2ZXCEcwIe438nHsViNuy06QHFUvf6Jfc7J1iKBbwAJf7osQdXisVKYCNfmDrxMIrsDcc2Bog2r6EXXmVlayxc46di0TFBMcglCcARiq1CkNr1FhrS0vbJE2rM7BKfRpKG9xQEJmxR+K80mBgIN8wBs7Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=zEgovvxj; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-74b013aefbdso237887b3a.3
        for <bpf@vger.kernel.org>; Mon, 30 Jun 2025 10:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1751303859; x=1751908659; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hEMTgxL0uwtqGX7Eiy7dFlITzxO3HjkYHcIu9b6MYOw=;
        b=zEgovvxjOg6xufJmTA+OwRvNoxE6AwTwUGzhS7qoFoEwihbsmWQqAgf3KosUBrfzMV
         oM5dWzq2zj3ib/Jr5yGexvOAEqtXnIel+oJeXgaRoNTtQkUoZMzGKvxb4U87wJbnwaEi
         Kw/ITvDsVBf9rb9vX/fs/W3ealhOgzkeoMQWLqJyDkEawLTrG7wR3pteauzluACwDVym
         4GUHoqK5HOB/J4Uo2oQop1gFwR3siVZyOPXBKo3/A31e+iNM4KHyJzfRZjdoqj1BJe0N
         K+a/nnGE1BdYeoZOoWZMnz1mu0SHcOeQRtRprUEOkaMMbUpCAVm6NLJ1m3wiYyZ7Ox4N
         0zeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751303859; x=1751908659;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hEMTgxL0uwtqGX7Eiy7dFlITzxO3HjkYHcIu9b6MYOw=;
        b=sFMuRbo3wzJQOaLnJkkLVy0s9oy8YyANbRssrFx12HJxwRUwp7BCASSAKqiGIlc1rG
         9iXkSZgukArlmto2MTTNWRl/Kw+Kd/a8MYu6rzYUf1DXsUgSf0X09uvZp6KA0AqUyd16
         HpUNhAIjqObLGFpZloKHphWPGLZK2IVZMsLm3HKwL4AbEDAqnceOsgw6xczDiFCuQqi+
         WbkiMeOqRyeQN6bX5Nsjnf7RWxyD1dfLVJG+/SjTj10X23m2hM8X1cSjmb2AW0VQIk3u
         SFY95a4saVElRLOzTYSYa8hedyLVs0prTuVlYY0XbZjfmv/fBs8F3yfSW0VVGF8DaHJs
         kcsQ==
X-Forwarded-Encrypted: i=1; AJvYcCXKuBWY/g6DBD9BKYN2l0F7K4Gwf76EuCF7ci8KNOmnmdKTA13fqjdaeXsp8Dovrfaj+Ww=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+7kqTtNiDK+bxGhdhBMtAdeCZxF1DFsiK/DfEtJvKiu4WBxcR
	1RCvG7Sqe7NbwcInL6EH0hqlvosArTBRSePEcXzPj4M9U9TOCkUXTSrJtaGoSAWSoOI=
X-Gm-Gg: ASbGncu52P9feA6KshelRrbmhpnBv3QMohU8HLeRYxTg1nSbejfYK4OZUfwKDqdCbwn
	Y+XTJGprzJ/Tkcq07zLV1w3n4iKTshE5MrMcDPyRoJZaKwMEDEiw3SnzDi8I8cKT/srMh6M2O8w
	MxLCT8w5NxB4hhMf/g141zvoeHaim2cSfhSajJV8oz6YSRtd9gQmP7USYH7+glcrk13hTdpYtID
	WbUbzu8iV+lJAj53rFZauIhQw+3roF7gLCsjgWpz5BEujMkmIqnQc9MaOHppae5zKtEjIQDBovC
	Ci57TaA3Zsa+3jzbbXDci5188KQzTcU5G+0vpNDzJr/MeEr3FA==
X-Google-Smtp-Source: AGHT+IGMEDSPsMdnGGSTEFA1kYD3IGgEojzA39m5jeY9ZXFm/f7TM/AlTi8Vl7eLjaYxq3I2/cjaYg==
X-Received: by 2002:a05:6a00:b21:b0:739:b1df:2bf1 with SMTP id d2e1a72fcca58-74b0a675951mr3716367b3a.5.1751303858929;
        Mon, 30 Jun 2025 10:17:38 -0700 (PDT)
Received: from t14.. ([2a00:79e1:abc:133:9ab8:319d:a54b:9f64])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74af540a846sm9229232b3a.31.2025.06.30.10.17.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 10:17:38 -0700 (PDT)
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
Subject: [PATCH v3 bpf-next 11/12] selftests/bpf: Create iter_tcp_destroy test program
Date: Mon, 30 Jun 2025 10:17:04 -0700
Message-ID: <20250630171709.113813-12-jordan@jrife.io>
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


