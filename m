Return-Path: <bpf+bounces-8555-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F08A788231
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 10:37:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1D171C20F91
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 08:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 386C1AD4C;
	Fri, 25 Aug 2023 08:36:48 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4C53D60
	for <bpf@vger.kernel.org>; Fri, 25 Aug 2023 08:36:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFD12C433CB;
	Fri, 25 Aug 2023 08:36:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692952606;
	bh=Q2ZIsubew9vjZV4NTRllMB9+S/zfEbLIL8U7zfyp2fY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=FiXrbbU5wd2YWWfvKxQ75kgpXUZ1r3EYDKBbLz7Cc4qCwJu2Aj+m3kPleLC4c1T2E
	 S3u3gGOobarm37fRQ1HmNC/5NPC5HiD+zipKXOH09PHF6hZGu3+enfScnlSWOrKYGx
	 rhaX00Z3kSROX9T9rWTPbl8Tf3B6VV9VjfgzzAXVdffwAmwMITeNfWQxXTSGUnuhaR
	 K1mEyvvNAVu9icopvEcu7rNNhyl0LBfKgqKsUNbD0WsYDiF+6kFrGidojzCTlIGy4l
	 wkvNVUqYdmDjoHk3/gdp4ooid83dacxscm0M+ZXb0WhKwyymDfvM022TPYlV68T5sp
	 Pl4MLUa8Az1yQ==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Fri, 25 Aug 2023 10:36:33 +0200
Subject: [PATCH 3/3] selftests/hid: force using our compiled libbpf headers
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230825-wip-selftests-v1-3-c862769020a8@kernel.org>
References: <20230825-wip-selftests-v1-0-c862769020a8@kernel.org>
In-Reply-To: <20230825-wip-selftests-v1-0-c862769020a8@kernel.org>
To: Jiri Kosina <jikos@kernel.org>, 
 Benjamin Tissoires <benjamin.tissoires@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Justin Stitt <justinstitt@google.com>, 
 Nick Desaulniers <ndesaulniers@google.com>
Cc: linux-input@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1692952596; l=798;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=Q2ZIsubew9vjZV4NTRllMB9+S/zfEbLIL8U7zfyp2fY=;
 b=+lEQzv9hCNetlUBhrOIu51yeljnR3xW75p6UxKDfmNdvqNMzDHmzekZqiMA0UasGLiQCQRFbD
 N9XPa2ae5U2CkFGO2TpI4jmOLXbF9q9HMMUenMC8C9aCkZAk/9Grarn
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

Turns out that we were relying on the globally installed headers, not
the ones we freshly compiled.
Add a manual include in CFLAGS to sort this out.

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
---
 tools/testing/selftests/hid/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/hid/Makefile b/tools/testing/selftests/hid/Makefile
index c5522088ece4..b01c14077c5d 100644
--- a/tools/testing/selftests/hid/Makefile
+++ b/tools/testing/selftests/hid/Makefile
@@ -22,6 +22,8 @@ CXX ?= $(CROSS_COMPILE)g++
 HOSTPKG_CONFIG := pkg-config
 
 CFLAGS += -g -O0 -rdynamic -Wall -Werror -I$(OUTPUT)
+CFLAGS += -I$(OUTPUT)/tools/include
+
 LDLIBS += -lelf -lz -lrt -lpthread
 
 # Silence some warnings when compiled with clang

-- 
2.39.1


