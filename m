Return-Path: <bpf+bounces-61665-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E025EAE9E0C
	for <lists+bpf@lfdr.de>; Thu, 26 Jun 2025 15:01:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E99D316E938
	for <lists+bpf@lfdr.de>; Thu, 26 Jun 2025 13:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE6112E427A;
	Thu, 26 Jun 2025 13:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b="nVs4QMFB"
X-Original-To: bpf@vger.kernel.org
Received: from mx-rz-1.rrze.uni-erlangen.de (mx-rz-1.rrze.uni-erlangen.de [131.188.11.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72FA021CC62
	for <bpf@vger.kernel.org>; Thu, 26 Jun 2025 13:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=131.188.11.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750942848; cv=none; b=DU+x++t8PWmIdeAEV7+mMBw7eQyNlyGKLxhlqgjU9M5ynAuWrZr6Q0srAhLJIlGXxhTWWOJ1rDSaohNOHWU8K4i4XJw352uz5ROr20UUVn9Zwt5aOHOYX6ZnvUKJ2R3C9cgVMyWRF7tI+5VP9F08vusaDfXcNUN09QmrTkoaYj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750942848; c=relaxed/simple;
	bh=+828giSAR195s2hp9e1R0Cb/iWaHH5cqtiRD21UJI3k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ln3+Q1FBhI4Kb2TPZ2ZONDsk+usJxZcXX9tzl5xeB+vIlX4GLqt2cYFG9r9pVWw9IlTJX4Fc+MjgpdqslAk0m/ngGSZLQYbPdR9OVcoz0J+reZ4IO1krAGezqg71o74D4HWfsFvB4GLYKDPbQ24OflCeVjtOzv2/mmUGALA7y3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fau.de; spf=pass smtp.mailfrom=fau.de; dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b=nVs4QMFB; arc=none smtp.client-ip=131.188.11.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fau.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fau.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fau.de; s=fau-2021;
	t=1750942844; bh=2CoXyAU0RR8gAk167We+AKNrFC4vzLa+h+MHpvTwwFs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:To:CC:
	 Subject;
	b=nVs4QMFBQIxTyFwlEoBDBcu8E4t3mSHsU0JQdAZmd1LJHohPgpl6zfx9Iw1Zia4+Q
	 Cx1PepeIJDJtXRz4/L1gIjiRn3QrzcGUSmF+pIwMUSu6dvinPMUOI256stqAuCCuRW
	 RbPxR12TeDDv2cfzYqfZr9l/H/MDYNjvX5885F47U9zNSwzqMaREoNj6r0l+HsL7Iy
	 rd/iHOueTfikU+Ep9K8EUvU5fWzkXPtq2MPvnxKymj8hjGP8TBGkqXC9CY5pSgTB90
	 y8EVu37olaPTskusAVgprxv9NrKCABJJf4IYqeWNzLWsLtXjE/Dgdjt5bsM+PQPNmF
	 FtsCOIUScVRLQ==
Received: from mx-rz-smart.rrze.uni-erlangen.de (mx-rz-smart.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::1e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-rz-1.rrze.uni-erlangen.de (Postfix) with ESMTPS id 4bSf1m4KGpz8vlq;
	Thu, 26 Jun 2025 15:00:44 +0200 (CEST)
X-Virus-Scanned: amavisd-new at boeck5.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 10.188.34.184
Received: from luis-tp.pool.uni-erlangen.de (i4laptop33.informatik.uni-erlangen.de [10.188.34.184])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: U2FsdGVkX19ot23q9D6xmDkh2dCJyXVNKW+S8MtufQk=)
	by smtp-auth.uni-erlangen.de (Postfix) with ESMTPSA id 4bSf1k0YBWz8t3W;
	Thu, 26 Jun 2025 15:00:42 +0200 (CEST)
From: Luis Gerhorst <luis.gerhorst@fau.de>
To: Eduard Zingerman <eddyz87@gmail.com>,
	Paul Chaignon <paul.chaignon@gmail.com>,
	bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Luis Gerhorst <luis.gerhorst@fau.de>
Subject: [RFC PATCH 2/3] selftests/bpf: Add ldimm64 nospec test
Date: Thu, 26 Jun 2025 15:00:36 +0200
Message-ID: <20250626130036.14843-1-luis.gerhorst@fau.de>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <8734bmoemx.fsf@fau.de>
References: <8734bmoemx.fsf@fau.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Luis Gerhorst <luis.gerhorst@fau.de>
---
 tools/testing/selftests/bpf/progs/bpf_misc.h  |  4 ++++
 .../selftests/bpf/progs/verifier_unpriv.c     | 19 +++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/bpf_misc.h b/tools/testing/selftests/bpf/progs/bpf_misc.h
index a678463e972c..be7d9bfa8390 100644
--- a/tools/testing/selftests/bpf/progs/bpf_misc.h
+++ b/tools/testing/selftests/bpf/progs/bpf_misc.h
@@ -235,4 +235,8 @@
 #define SPEC_V1
 #endif
 
+#if defined(__TARGET_ARCH_x86)
+#define SPEC_V4
+#endif
+
 #endif
diff --git a/tools/testing/selftests/bpf/progs/verifier_unpriv.c b/tools/testing/selftests/bpf/progs/verifier_unpriv.c
index 4470541b5e71..35d2625e97b8 100644
--- a/tools/testing/selftests/bpf/progs/verifier_unpriv.c
+++ b/tools/testing/selftests/bpf/progs/verifier_unpriv.c
@@ -801,4 +801,23 @@ l2_%=:							\
 	: __clobber_all);
 }
 
+SEC("socket")
+__description("ldimm64 nospec")
+__success __success_unpriv
+__retval(0)
+#ifdef SPEC_V4
+__xlated_unpriv("r1 = 0x2020200005642020")
+__xlated_unpriv("*(u64 *)(r10 -8) = r1")
+__xlated_unpriv("nospec")
+#endif
+__naked void ldimm64_nospec(void)
+{
+	asm volatile ("					\
+	r1 = 0x2020200005642020 ll;			\
+	*(u64 *)(r10 -8) = r1;				\
+	r0 = 0;						\
+	exit;						\
+"	::: __clobber_all);
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.49.0


