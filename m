Return-Path: <bpf+bounces-59384-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CCC69AC9717
	for <lists+bpf@lfdr.de>; Fri, 30 May 2025 23:32:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CABB47A9B4E
	for <lists+bpf@lfdr.de>; Fri, 30 May 2025 21:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C715928368B;
	Fri, 30 May 2025 21:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="mm0Kul7O"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094C727815C
	for <bpf@vger.kernel.org>; Fri, 30 May 2025 21:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748640708; cv=none; b=e9jPzGgB5y0G682rKobS29U6X44TBHw1KYgZmmhV/COCUI4mxrxJPvS7AWLlPca2r7VdB06exp065q/uuqdujktVpRbOwhuqiHDE/xXjus7vuz462HInCyOio7+08wURTmxvzylyg/kzUIkX+7y8U+8fN++fhkyUWg/z6RdPcio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748640708; c=relaxed/simple;
	bh=ii0lhnsuHEZZ21rnkBA0wx5pkbY0pk/4pyArG18nLsA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nHIdmoGMHExCKo2qONo+fLZiAb9rQcvfasFSAHVLzuqAjwVpcLkTCnJGZV0gfMupdBTNGkJ7kwZCl+1fzr+X9lC7bR3cERH96rn4OrlOn1Ghi7Owlwtwvg4NLXKNNgiB5N/pNawkck8O479DqeHPPbWw7GEhoLcbPUdU0xlFo7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=mm0Kul7O; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-30e85955bebso309517a91.0
        for <bpf@vger.kernel.org>; Fri, 30 May 2025 14:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1748640706; x=1749245506; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BZZ0jvcYwhY5yt1MXnZuSSYPelQKSbT2EiEftdDOFWk=;
        b=mm0Kul7OCqF7teCecv9itxh6q7U3yCiAmZ86L7b5YPIA4p7DpyeVCEDmHreIflNaFn
         tXFTDhc58c7AtBpLkjFjTy90SFivoyXqJKeY84LDXodZdPq+FmpNMb2fR+Z+C2ootKC2
         BleRQ4EAmZsaB/B+MtbQFGcqRH9Ag2d78OK8luZit1OezZKtInN6qrnElYlxKWfAA9VV
         skdxWth6Tdb6o2STa5o9WLHew+7tIU8EqU3VSP0wplr908QElu4KgWOmZK4vOlwu/lGA
         +tr5ynybO4qdfWxYBvfBsLU2zBsb6jy1kQGjQ3Jb6zCW1ACvteSMKxbAlOyCA88INxBO
         IR/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748640706; x=1749245506;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BZZ0jvcYwhY5yt1MXnZuSSYPelQKSbT2EiEftdDOFWk=;
        b=eSX+wgXPdjwh+u6/1m/iek4K38Tl3QGhJkVpHy1o9BOk0gDKW0nLo5/9C8GzEChMbb
         zn7eFA9kqnL2F3+Lxgrv6rCN6F4lcy7VpRNMopi4Ns5eHrjmZ+SC6AeDwVg3acz8r/OQ
         KlCJlvjQweTW7dX15EHtP4MneOw7kybzO73lNB16Egkld0FjtFJ9zHWwP4GOJsgYO9QX
         mgmoFn0LCWp5fORBSuWn07HxThonibEYT7i7HvkfTSKhcygrqnTHDuRNwmTWN3kFZxI1
         y+BGHJO/SXAegdBm9RH1fjRAGP5WRSwAd8hrBt5DunyzTudWyZ25IwF1dU9Jcwok6hHy
         xlLw==
X-Forwarded-Encrypted: i=1; AJvYcCUQdSN+Pe8kMFDlLqnlv53IK9J55fBGBfyO17gzswuW6/WTMHsyEmA9itypSW0i1Ddm8yk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyxj3ckhxIDvr3T7DDPyDZqKdU4egQiMmfcm50KwX9GHS/N2ooR
	usu1jqZskkv0kC/c3NUMQC4caNwtDl4wM5QM5ItOv/iPEOVRAm0h43mhUHet6ReN3NI=
X-Gm-Gg: ASbGnctcxpMfkLJysTJ+3FCc72iAvDlm+jknjcVVi6nG1YsK7VuCoOJmHucb6MKdzUQ
	zt07Huivn8mY82AvmEMrkQL0hJRyU2FWfSqLfy4E4VolRp9rZvgL4L2LAiZb7BY3RjtGCghQRBy
	tD6Ye5hSVGbYHU4033mB1PkxD7NySzeDDybrQYSIyjxHhAIyVtue4+0mDA2l/fMM1RscvdBQYxc
	KXenbQQ2IRAe3j+iv2Uy+jmsNmLtkSP7bBHWQclHSozg1tZijGolb/8Zq6sWn4OVyk+A/v/HqM4
	Kc+73/4ahmvhYXYJYN4vqMikA4EQstgGdn+LZWQV
X-Google-Smtp-Source: AGHT+IEW6DUT4RwEdjjRvW2pHlWUpu9SvFiYToPKW1jMtx8KToVpsVLkuVXhDPwSOA7MOT0QlZTncA==
X-Received: by 2002:a05:6a00:2e04:b0:725:f1f2:43eb with SMTP id d2e1a72fcca58-747c0ef16e6mr1922553b3a.6.1748640706194;
        Fri, 30 May 2025 14:31:46 -0700 (PDT)
Received: from t14.. ([2607:fb91:20c7:44b2:2a24:2057:271e:f269])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-747afed4399sm3496763b3a.77.2025.05.30.14.31.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 May 2025 14:31:45 -0700 (PDT)
From: Jordan Rife <jordan@jrife.io>
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: Jordan Rife <jordan@jrife.io>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: [PATCH v2 bpf-next 07/12] selftests/bpf: Allow for iteration over multiple ports
Date: Fri, 30 May 2025 14:30:49 -0700
Message-ID: <20250530213059.3156216-8-jordan@jrife.io>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250530213059.3156216-1-jordan@jrife.io>
References: <20250530213059.3156216-1-jordan@jrife.io>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Prepare to test TCP socket iteration over both listening and established
sockets by allowing the BPF iterator programs to skip the port check.

Signed-off-by: Jordan Rife <jordan@jrife.io>
---
 tools/testing/selftests/bpf/prog_tests/sock_iter_batch.c | 7 ++-----
 tools/testing/selftests/bpf/progs/sock_iter_batch.c      | 4 ++++
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sock_iter_batch.c b/tools/testing/selftests/bpf/prog_tests/sock_iter_batch.c
index 2adacd91fdf8..0d0f1b4debff 100644
--- a/tools/testing/selftests/bpf/prog_tests/sock_iter_batch.c
+++ b/tools/testing/selftests/bpf/prog_tests/sock_iter_batch.c
@@ -416,7 +416,6 @@ static void do_resume_test(struct test_case *tc)
 	int err, iter_fd = -1;
 	const char *addr;
 	int *fds = NULL;
-	int local_port;
 
 	counts = calloc(tc->max_socks, sizeof(*counts));
 	if (!ASSERT_OK_PTR(counts, "counts"))
@@ -431,10 +430,8 @@ static void do_resume_test(struct test_case *tc)
 				     tc->init_socks);
 	if (!ASSERT_OK_PTR(fds, "start_reuseport_server"))
 		goto done;
-	local_port = get_socket_local_port(*fds);
-	if (!ASSERT_GE(local_port, 0, "get_socket_local_port"))
-		goto done;
-	skel->rodata->ports[0] = ntohs(local_port);
+	skel->rodata->ports[0] = 0;
+	skel->rodata->ports[1] = 0;
 	skel->rodata->sf = tc->family;
 
 	err = sock_iter_batch__load(skel);
diff --git a/tools/testing/selftests/bpf/progs/sock_iter_batch.c b/tools/testing/selftests/bpf/progs/sock_iter_batch.c
index 8f483337e103..40dce6a38c30 100644
--- a/tools/testing/selftests/bpf/progs/sock_iter_batch.c
+++ b/tools/testing/selftests/bpf/progs/sock_iter_batch.c
@@ -52,6 +52,8 @@ int iter_tcp_soreuse(struct bpf_iter__tcp *ctx)
 		idx = 0;
 	else if (sk->sk_num == ports[1])
 		idx = 1;
+	else if (!ports[0] && !ports[1])
+		idx = 0;
 	else
 		return 0;
 
@@ -92,6 +94,8 @@ int iter_udp_soreuse(struct bpf_iter__udp *ctx)
 		idx = 0;
 	else if (sk->sk_num == ports[1])
 		idx = 1;
+	else if (!ports[0] && !ports[1])
+		idx = 0;
 	else
 		return 0;
 
-- 
2.43.0


