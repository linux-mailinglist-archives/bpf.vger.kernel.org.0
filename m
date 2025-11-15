Return-Path: <bpf+bounces-74659-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7356BC60C60
	for <lists+bpf@lfdr.de>; Sat, 15 Nov 2025 23:58:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 651483AE040
	for <lists+bpf@lfdr.de>; Sat, 15 Nov 2025 22:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0FB4265621;
	Sat, 15 Nov 2025 22:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="RMdq3qO2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A7D8246770
	for <bpf@vger.kernel.org>; Sat, 15 Nov 2025 22:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763247412; cv=none; b=f2BG6f5a5pJib4cXIs568hh0Snd3aZTYtTbRXs3GZ0gsNduaXP5gyB3j2Olv9H55vV5JnOKui+AAnd4rGgE93FXe6HWVWqOxfaPfUuln6HmYClyXsWjw8piXF72skIkGzg8Sih/Deq6yWwOAIt01sTH1Kd77fySskwWUH9o8QWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763247412; c=relaxed/simple;
	bh=Isqdw0RhAzylXu4IdiwZU689kLt/pJObP5hCd/DHxbo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VgMfix0YOTDT2ngKIP0Eb+b/1VQcII7YSStoN03lzmK8xzgCI+ityS1dyuS2+wzoTclpgasmbwWBhGN7N6aM0Jm2C2fpgMx+O8fuLq9nWzsLfp0K/ayXOl8p0CZEh/aRoZ2zPkbP8c7dsLcXCsZ+l+aDkLWGblL1abG7JmPU4gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=RMdq3qO2; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-477619f8ae5so21467705e9.3
        for <bpf@vger.kernel.org>; Sat, 15 Nov 2025 14:56:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1763247408; x=1763852208; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hax3l6ZHFp82yvZa1z7cG8hX78sJJl+3NtBXaKxMPD8=;
        b=RMdq3qO2e67+fzvYUpA22MDxQcGojoSDGqGXVqIrBYpf9X5yrBfggvNKVWz6w01T2c
         tph9ykq0TYcXe0QOwEFtByB6zrzuc/fQYJnEv+HKwBP9L5Ov4JatAT8ZXAie4D+k9Jja
         18ob2KlL+aZn1w8N9uBRlaVIwPlwzF9RZHM48GmDczgZH9aMu+8wlpamy2MymTP5DfQ5
         2M8Wg6Exj3e97TReaqitftzBT5RCx3aLfz9pwrUPAx/FVJVC2DIklHMduUASsWQVI9R3
         +uQV2OipcVUS6dNWqv6WrKKc9sGV1SQCpvLh7U1nCepbudGt25VEvD1QQjy0KP+MzCkr
         CSmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763247408; x=1763852208;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hax3l6ZHFp82yvZa1z7cG8hX78sJJl+3NtBXaKxMPD8=;
        b=ksZXMkskNP2LQSRJm1w62gQHaIrmgSAb3AsZDvzfjsKKDb3KpVkKUQVI1EjCtLWfwf
         U70+vWt8wgjwpab//6iPEoeVeijia9Tp7AQJax9F3JK+x+YNNi2tDyX2rXM7lJfhnFG7
         SBVh/gfyHTx4J8RfYiZkz+uByjHO2k3xVhnFa8B0U/ToYaKAkIdrhmjTlCyeXO2x7Hu6
         joGAfOF/M0sbr3j1ej8DoPQEMcElf3lfEcXkOpNIO16BWrku+v5R1g/MxOlRlxlLU6LH
         GeiY6CNMIxRuB4Yacg/5iCC/GNjlkpoauEC9xFFf0P2RdYS6RmUMPcothISlKCq1P5qV
         wefw==
X-Gm-Message-State: AOJu0YxCONq7u8DvGlScdeh2FwYMk8QvAhFa8W0wK/5HeS15+7jz2eEs
	nM0pMVsyKE6ilxcNtU7FLxOn/nq6hoJzMjFw/C5/6+xWNloiwprlvOkIRLvSj9SA4/xEyA4j8ae
	SB2M/4Ns=
X-Gm-Gg: ASbGncs6AhgRXMKX5LA5ms9+x3t//z+wbMp7QlERwR/J/qRfsyuvXasYMFH6JA9BO6q
	3UVC5k+WBmru0Ky17EyKrYivPEh5XWNSWMlyP9XlrFegwUdw0zFgDpNFZ0o8xNz2uENwOH2pqWs
	mV0Qxzp/2KGCsbxt1fF08WltSQqXI33qEhGDqyN5OZV1KJrNDUmA1AlhVIEmxzrp46s4MNweurU
	yTUZjBkd7BhmxhcN7fTVe37A/JvRRuiGAQRaxoafiPlzuBtBoHLntGESMtV870WEgTtDASuis3u
	ZkmjuiAmYHzPiouaYlV3Cc7tmqX4yVIww5gewpFoT+2NEf3hyIB3zqjWpbLlw0DTdIaBn0U1G5d
	t63AfyVx4Gr7PMm/kwTvweT0YMIMsKgGw1hfMbI9+uUO1EZSZZWLAwZ8zihd5ApnZxKOEczY9fx
	LxY7KcJavKJt60Drd7k613CGbxOT/+HjuJIqkCH0GtDDfmAPJVBw==
X-Google-Smtp-Source: AGHT+IEvBVqyOu4uOb4WG4c5ywhNFvW1pjUp9ZjPOqqgZTKbrw3cQLaFupO8D/BR8AI9EmrelD5QmQ==
X-Received: by 2002:a05:600c:6287:b0:477:7f4a:44b4 with SMTP id 5b1f17b1804b1-4778fe60641mr68379945e9.1.1763247408577;
        Sat, 15 Nov 2025 14:56:48 -0800 (PST)
Received: from F15.localdomain ([121.167.230.140])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ba1462c605sm6641971b3a.21.2025.11.15.14.56.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Nov 2025 14:56:46 -0800 (PST)
From: Hoyeon Lee <hoyeon.lee@suse.com>
To: bpf@vger.kernel.org
Cc: Hoyeon Lee <hoyeon.lee@suse.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [bpf-next v1 4/5] selftests/bpf: replace TCP CC string comparisons with bpf_strncmp
Date: Sun, 16 Nov 2025 07:55:39 +0900
Message-ID: <20251115225550.1086693-5-hoyeon.lee@suse.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251115225550.1086693-1-hoyeon.lee@suse.com>
References: <20251115225550.1086693-1-hoyeon.lee@suse.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The connect4_prog and bpf_iter_setsockopt tests duplicate the same
open-coded TCP congestion control string comparison logic. Since
bpf_strncmp() provides the same functionality, use it instead to
avoid repeated open-coded loops.

This change applies only to functional BPF tests and does not affect
the verifier performance benchmarks (veristat.cfg). No functional
changes intended.

Signed-off-by: Hoyeon Lee <hoyeon.lee@suse.com>
---
 .../selftests/bpf/progs/bpf_iter_setsockopt.c | 17 ++-------------
 .../selftests/bpf/progs/connect4_prog.c       | 21 +++++++------------
 2 files changed, 10 insertions(+), 28 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_setsockopt.c b/tools/testing/selftests/bpf/progs/bpf_iter_setsockopt.c
index 774d4dbe8189..a8aa5a71d846 100644
--- a/tools/testing/selftests/bpf/progs/bpf_iter_setsockopt.c
+++ b/tools/testing/selftests/bpf/progs/bpf_iter_setsockopt.c
@@ -18,23 +18,10 @@
 
 unsigned short reuse_listen_hport = 0;
 unsigned short listen_hport = 0;
-char cubic_cc[TCP_CA_NAME_MAX] = "bpf_cubic";
+const char cubic_cc[] = "bpf_cubic";
 char dctcp_cc[TCP_CA_NAME_MAX] = "bpf_dctcp";
 bool random_retry = false;
 
-static bool tcp_cc_eq(const char *a, const char *b)
-{
-	int i;
-
-	for (i = 0; i < TCP_CA_NAME_MAX; i++) {
-		if (a[i] != b[i])
-			return false;
-		if (!a[i])
-			break;
-	}
-
-	return true;
-}
 
 SEC("iter/tcp")
 int change_tcp_cc(struct bpf_iter__tcp *ctx)
@@ -58,7 +45,7 @@ int change_tcp_cc(struct bpf_iter__tcp *ctx)
 			   cur_cc, sizeof(cur_cc)))
 		return 0;
 
-	if (!tcp_cc_eq(cur_cc, cubic_cc))
+	if (bpf_strncmp(cur_cc, TCP_CA_NAME_MAX, cubic_cc))
 		return 0;
 
 	if (random_retry && bpf_get_prandom_u32() % 4 == 1)
diff --git a/tools/testing/selftests/bpf/progs/connect4_prog.c b/tools/testing/selftests/bpf/progs/connect4_prog.c
index 9e9ebf27b878..9d158cfad981 100644
--- a/tools/testing/selftests/bpf/progs/connect4_prog.c
+++ b/tools/testing/selftests/bpf/progs/connect4_prog.c
@@ -34,6 +34,9 @@
 #define SOL_TCP 6
 #endif
 
+const char reno[] = "reno";
+const char cubic[] = "cubic";
+
 __attribute__ ((noinline)) __weak
 int do_bind(struct bpf_sock_addr *ctx)
 {
@@ -50,35 +53,27 @@ int do_bind(struct bpf_sock_addr *ctx)
 }
 
 static __inline int verify_cc(struct bpf_sock_addr *ctx,
-			      char expected[TCP_CA_NAME_MAX])
+			      const char expected[])
 {
 	char buf[TCP_CA_NAME_MAX];
-	int i;
 
 	if (bpf_getsockopt(ctx, SOL_TCP, TCP_CONGESTION, &buf, sizeof(buf)))
 		return 1;
 
-	for (i = 0; i < TCP_CA_NAME_MAX; i++) {
-		if (buf[i] != expected[i])
-			return 1;
-		if (buf[i] == 0)
-			break;
-	}
+	if (bpf_strncmp(buf, TCP_CA_NAME_MAX, expected))
+		return 1;
 
 	return 0;
 }
 
 static __inline int set_cc(struct bpf_sock_addr *ctx)
 {
-	char reno[TCP_CA_NAME_MAX] = "reno";
-	char cubic[TCP_CA_NAME_MAX] = "cubic";
-
-	if (bpf_setsockopt(ctx, SOL_TCP, TCP_CONGESTION, &reno, sizeof(reno)))
+	if (bpf_setsockopt(ctx, SOL_TCP, TCP_CONGESTION, (void *)reno, sizeof(reno)))
 		return 1;
 	if (verify_cc(ctx, reno))
 		return 1;
 
-	if (bpf_setsockopt(ctx, SOL_TCP, TCP_CONGESTION, &cubic, sizeof(cubic)))
+	if (bpf_setsockopt(ctx, SOL_TCP, TCP_CONGESTION, (void *)cubic, sizeof(cubic)))
 		return 1;
 	if (verify_cc(ctx, cubic))
 		return 1;
-- 
2.51.1


