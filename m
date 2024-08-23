Return-Path: <bpf+bounces-37981-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 048F095D631
	for <lists+bpf@lfdr.de>; Fri, 23 Aug 2024 21:44:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF8911F23834
	for <lists+bpf@lfdr.de>; Fri, 23 Aug 2024 19:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5754192599;
	Fri, 23 Aug 2024 19:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YeIcpUpE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16457374F6
	for <bpf@vger.kernel.org>; Fri, 23 Aug 2024 19:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724442264; cv=none; b=ku+CSnT8hR08qjWHCrbVPX+ssdOzBaif1OHYyIWeqM94Ij2eWurICDlovPfbp3VNq0nhYUzLQo+bf+mORxRnGT2lKI0RozDEtw6Uoq7bMUFk1Yw31z/dqQz03JLpGnUgboEZWvcslJtcdGsRzxKAVe2ZYThO7cId0859x4WT8TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724442264; c=relaxed/simple;
	bh=6UoSroXC+e17+WtRBYA73eq6sBlFC1FKRhoXGpcQNg8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R269D1FSCmHUedZj/Sal/VD/m83MxmkAwWDRc4+WN1/PgAlignbXf5HYUo198WCnxalHOClHvbGBqZKdjgofikIlmVvxh+3X1GD/KPvudkyaqdMAfndLR2xmvPe/xWZoZk/k6u1HV+QJJ0ECKHe8dNwuMz0p2++y/klhSb6kd3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YeIcpUpE; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-7cda2695893so822423a12.1
        for <bpf@vger.kernel.org>; Fri, 23 Aug 2024 12:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724442262; x=1725047062; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/8HqcLz5QAW83fr7kZjOTm1+gdTRb315/eP6oLHwxGA=;
        b=YeIcpUpEkHJVhpso2LA3PiGyjXROtVIaFZ3sPA2GwreflHfEUHcHsFKYPsVC58f44q
         6+ab8uAZqgbSR3FjgTCAQ9XcxvgvARGv3PPUxPeHT66zL4L8x1YXkbVMvHliA6Hd4DUM
         UgAQo3XIn9TxUL8ztLJuENiTZVg+oaqNnnsG6Ae31oj6Se4plCrEUXw19rmBRGM8ZxLh
         YRWo8aDvWuSrv3g/QeVpSDjYdZgeISlAJ9w6zpODX8N+tCnxSaohvvqjFZARScA99SzR
         gmwNuCGzEUUbPUTPOS3CgsN1Ho30C4v+xz5PPhJf5kca1eOSoYCIRJCmD1gbcNB/Slws
         i9rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724442262; x=1725047062;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/8HqcLz5QAW83fr7kZjOTm1+gdTRb315/eP6oLHwxGA=;
        b=rkNwr372iepkTZ1meYx1X+kdydJ9Jx6A5fht0+3mtNmzOZNzFDOEAi3CsabzBIY8J1
         81WQw2bb771txCJhahqFbalYUhHF3rNeTgcYyvbyfJLjY2hlWEzNwzwLw7ipRPJRwZJ3
         2gOsL3Co8s4OEsz0PitWjp632p7eZE9W2vJS12XYA/2OmeWcmsHFAChYFqkVePNxme/T
         hXwykZ1B0IevCzCsCn6VO9Ex/6fYZQR/wBjCjPyzF3pmKWrHbP7Oq+hJBuY2E52Ii2kp
         hBf1T6ddAx8uIXjlaXrEkp2NuDaHfAhhmpnfbWLUR8IZ4+zPzsndGqipPIIdCUlcbcic
         CvxA==
X-Gm-Message-State: AOJu0Ywh/NX6aqSnaGl3Tv8EPPGT1PCPPSmY48bnIgOaKOfuJlOugLU7
	l2DF8ez3vgJWNf5kh3FaXY+k/2X2sG0ywqjTaJIMXa5/fAGdPxXgcnqCyw==
X-Google-Smtp-Source: AGHT+IHnxtYMTj49G6DIRX1XjQcq9l6EuuqxoJCR1rI73ks7yR21gWxV/Mz1ogyHw2j8tGEBrZYejA==
X-Received: by 2002:a17:90a:6c89:b0:2d3:d7b9:2c7f with SMTP id 98e67ed59e1d1-2d646d65169mr3440245a91.35.1724442262030;
        Fri, 23 Aug 2024 12:44:22 -0700 (PDT)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d5ebbe29bcsm6843198a91.55.2024.08.23.12.44.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 12:44:21 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next] selftests/bpf: use simply-expanded variables for libpcap flags
Date: Fri, 23 Aug 2024 12:44:09 -0700
Message-ID: <20240823194409.774815-1-eddyz87@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Save pkg-config output for libpcap as simply-expanded variables.
For an obscure reason 'shell' call in LDLIBS/CFLAGS recursively
expanded variables makes *.test.o files compilation non-parallel
when make is executed with -j option.

While at it, reuse 'pkg-config --cflags' call to define
-DTRAFFIC_MONITOR=1 option, it's exit status is the same as for
'pkg-config --exists'.

Fixes: f52403b6bfea ("selftests/bpf: Add traffic monitor functions.")
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/testing/selftests/bpf/Makefile | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index ec7d425c4022..c120617b64ad 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -48,9 +48,10 @@ CFLAGS += -g $(OPT_FLAGS) -rdynamic					\
 LDFLAGS += $(SAN_LDFLAGS)
 LDLIBS += $(LIBELF_LIBS) -lz -lrt -lpthread
 
-LDLIBS += $(shell $(PKG_CONFIG) --libs libpcap 2>/dev/null)
-CFLAGS += $(shell $(PKG_CONFIG) --cflags libpcap 2>/dev/null)
-CFLAGS += $(shell $(PKG_CONFIG) --exists libpcap 2>/dev/null && echo "-DTRAFFIC_MONITOR=1")
+PCAP_CFLAGS	:= $(shell $(PKG_CONFIG) --cflags libpcap 2>/dev/null && echo "-DTRAFFIC_MONITOR=1")
+PCAP_LIBS	:= $(shell $(PKG_CONFIG) --libs libpcap 2>/dev/null)
+LDLIBS += $(PCAP_LIBS)
+CFLAGS += $(PCAP_CFLAGS)
 
 # The following tests perform type punning and they may break strict
 # aliasing rules, which are exploited by both GCC and clang by default
-- 
2.46.0


