Return-Path: <bpf+bounces-62533-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 270FBAFB808
	for <lists+bpf@lfdr.de>; Mon,  7 Jul 2025 17:54:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EB8F422CD9
	for <lists+bpf@lfdr.de>; Mon,  7 Jul 2025 15:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 502FE21ADC9;
	Mon,  7 Jul 2025 15:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="HX6GOhyH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8473C21A43C
	for <bpf@vger.kernel.org>; Mon,  7 Jul 2025 15:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751903483; cv=none; b=Ggp6u1tj1O0hIwbz/qCqLbl/CIcPHz+B+4t1vbf6VXg+keSeqY5w1pDwsrmLooIYaQ+OEq10Jxc5NEdmt1okyXLy1jyrb4mEeG0ylxg+aOJf1pvyFnnnbhE2JaGYyeVF6Eb0BZfFCQl3974bw0Sm2MakznQYDyDHOLnmPMUyZdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751903483; c=relaxed/simple;
	bh=8znAfQ1IP5+4ZLJ0094gbfhffGuzbrK/6tpSUK5ZSgI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X6LkiwDneZ2ecKsxLPFPodBx6WQW3itkUhpCltp43N6/rfL3A9qtJ7Two74t7YAFTh3ov1XZ6rtT7+2ToQdUSo6weGY0zV7EXc46QQfrd89QDKJ96X3hF2QR6LdGhDrnD6sekkAGpYoiiW4cgS7P7PEiYS8Gy3m/7k154/PKzkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=HX6GOhyH; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2355360ea88so4467245ad.2
        for <bpf@vger.kernel.org>; Mon, 07 Jul 2025 08:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1751903482; x=1752508282; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hEMTgxL0uwtqGX7Eiy7dFlITzxO3HjkYHcIu9b6MYOw=;
        b=HX6GOhyH64Jnr0zAiPSqjeBJCh1YTgc9fX5Kl5IbKBY//AKzLJwsYOkFRIeUgvoxDx
         AfXRtHwQXHsImXmdztWBDRnC7qbR9pYJOgjoh4cEfb0StM8wQJJgNXowNu81lSQGRC/1
         jvv+d8uzsxdhYtfwp3ZDWDZhhUJFX+lYaHy3TglTUG+89SZnax76IbD99xHkksbNnXSF
         pynR8cTgHcgwqWNRVCD+VmKkQE2BQu7K7g3ZeRLrwaOwFniWFpRg5UkKUtYryOkmIJd+
         ypcLT2M2omCYCFXD9v+UFyqZ/zergGHl25YJJOaO6eRE8cW+XAcEICLJGmLnwoTPK+/h
         fzzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751903482; x=1752508282;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hEMTgxL0uwtqGX7Eiy7dFlITzxO3HjkYHcIu9b6MYOw=;
        b=Jta69lbrEayF3UmoK2FSvuThGupfk21UyuLrZt2/3BGiADBAUomkRh4aPr4cn/1dgq
         qrTTVSGQWYHZ8yNr3+AyrjuLtDvLGgXnn5eLiotDXD86EYlAUE3DTKRp3G40Vqy5xa08
         DRx/Hf5PRJ871J1x/p7toySiAms6Sgt/SEHwUW9jrxp6cDF/qWFPZeXvGvnrx8xcD3B7
         Ar6aZ1Po5wsAqSAYOacm3CpvEidgbzeJ7kk+zhjSOKpb8W5VfF6f+YTjVR57/VmuXmO0
         hjKE0amaS40Qs6Nd90biR5vvxOdiR41TZlIQ8DJrDTii9Hmck8cbOjUfP/oi/IpJiQ+G
         NyzQ==
X-Forwarded-Encrypted: i=1; AJvYcCXXjuUll8OhXx5F07K4NL7SDzPmF7RsC5y8gMn3ZgfgLhtZ5G3D/LQQafjcvSqCgk1xgFs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYj6B/wXuBq1fqX1s9ii0qd1jSfWNPV5l69ohH/wYAxSMG8uvZ
	5mrwq1rjT+dzh0z31kdo4NxyRLZ0mUUliwSV3C9QAlHD27WGG/HYN9ZfbLimqEWi7AA=
X-Gm-Gg: ASbGncsoPzD3IDqAtCfgLLlkt9jghnSHJxzlr23nOJGF8UcfWjgwtuL2s6CH0ESx/fp
	T/jPeK59gRhB/4+kx+fyR+vZmgNq7SSN8IH2kXbANZ2wlP6va7t0ugdx660Mi92v3BI9s10ozam
	xy+TJhGUckmxsCxi2wsTvi55gWVOqCmoogm0E0ca5vWRredLZHJAv0VNIShdA+/6o/c2amWSw+6
	9jjSkmasXS3CiojbR0Txl6D9NaNwpyNeyRWNGGRcVgIPgXS1RvQ0QjOBi0DeS8vBX3GeizDPtwM
	iiR4M/IqePcsxVC2/XJ7ylp95tZaHCx7mLOnfv10J6s506pqa6cNVnTxJ47Vkg==
X-Google-Smtp-Source: AGHT+IFVd7uda0SyHIewGgCtzJeVxXNo5Va6KpD3LRiYMxvxDTfWFeYtuWOownYStZPnBKm+7/Dh9g==
X-Received: by 2002:a17:903:1a6f:b0:234:8a16:d80c with SMTP id d9443c01a7336-23c8743bf06mr73245995ad.14.1751903481710;
        Mon, 07 Jul 2025 08:51:21 -0700 (PDT)
Received: from t14.. ([2001:5a8:4528:b100:e505:eb21:1277:21f5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23c8455eb3bsm95772065ad.115.2025.07.07.08.51.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 08:51:21 -0700 (PDT)
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
Subject: [PATCH v4 bpf-next 11/12] selftests/bpf: Create iter_tcp_destroy test program
Date: Mon,  7 Jul 2025 08:50:59 -0700
Message-ID: <20250707155102.672692-12-jordan@jrife.io>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250707155102.672692-1-jordan@jrife.io>
References: <20250707155102.672692-1-jordan@jrife.io>
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


