Return-Path: <bpf+bounces-57205-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 021ACAA6D2C
	for <lists+bpf@lfdr.de>; Fri,  2 May 2025 10:57:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C6924C097D
	for <lists+bpf@lfdr.de>; Fri,  2 May 2025 08:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C961D22B8AB;
	Fri,  2 May 2025 08:57:35 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail.itouring.de (mail.itouring.de [85.10.202.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 084BF22B8A6;
	Fri,  2 May 2025 08:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.10.202.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746176255; cv=none; b=EZmWd1RP3NiHRQjI2mbbT+khV3ImZdrUQATHGagy/bwGFl3AAOG+WyncR++IZurnt/siW3Cd9iJWdNww0UVRfi3W1GEIIRmxax0A1enu3EnTrTi0NhH6Vv/WvqVygsUi7T0+b5hPQr8Src3CWSyn+3UKAn1SRC55JXvK4rIWcyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746176255; c=relaxed/simple;
	bh=qFHFB+DwmqM2jMBUN6w9mF5dQfpASkF5/ZedKcfaUMM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sNruosvvE3rR092/E4nYHFyZgLQ2s1RjUrCGPZoQMSr01V/Wl72l/ffRubtuz9wi+bGTmwZSRtP7rShAl/EeqBYX2hY4L51BEk5k/KNb3UNHQGTW8TFHZn6V2PbjFvvwtK9gWyQQl2bEg2IeBxwa84sQERsiQh0WsJs+y5/Oz4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=applied-asynchrony.com; spf=pass smtp.mailfrom=applied-asynchrony.com; arc=none smtp.client-ip=85.10.202.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=applied-asynchrony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=applied-asynchrony.com
Received: from tux.applied-asynchrony.com (p5b07e9b7.dip0.t-ipconnect.de [91.7.233.183])
	by mail.itouring.de (Postfix) with UTF8SMTPSA id AB149103765;
	Fri, 02 May 2025 10:57:22 +0200 (CEST)
Received: from localhost (hho.applied-asynchrony.com [192.168.100.221])
	by tux.applied-asynchrony.com (Postfix) with UTF8SMTP id 1DAB8601893B6;
	Fri, 02 May 2025 10:57:22 +0200 (CEST)
From: =?UTF-8?q?Holger=20Hoffst=C3=A4tte?= <holger@applied-asynchrony.com>
To: Quentin Monnet <qmo@kernel.org>,
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
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Holger=20Hoffst=C3=A4tte?= <holger@applied-asynchrony.com>
Subject: [PATCH] bpftool: build bpf bits with -std=gnu11
Date: Fri,  2 May 2025 10:57:10 +0200
Message-ID: <20250502085710.3980-1-holger@applied-asynchrony.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

A gcc-15-based bpf toolchain defaults to C23 and fails to compile various
kernel headers due to their use of a custom 'bool' type.
Explicitly using -std=gnu11 works with both clang and bpf-toolchain.

Signed-off-by: Holger Hoffstätte <holger@applied-asynchrony.com>
---
 tools/bpf/bpftool/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
index 9e9a5f006..ca6c1e04b 100644
--- a/tools/bpf/bpftool/Makefile
+++ b/tools/bpf/bpftool/Makefile
@@ -227,7 +227,7 @@ $(OUTPUT)%.bpf.o: skeleton/%.bpf.c $(OUTPUT)vmlinux.h $(LIBBPF_BOOTSTRAP)
 		-I$(or $(OUTPUT),.) \
 		-I$(srctree)/tools/include/uapi/ \
 		-I$(LIBBPF_BOOTSTRAP_INCLUDE) \
-		-g -O2 -Wall -fno-stack-protector \
+		-g -O2 -Wall -fno-stack-protector -std=gnu11 \
 		--target=bpf -c $< -o $@
 	$(Q)$(LLVM_STRIP) -g $@
 
-- 
2.49.0


