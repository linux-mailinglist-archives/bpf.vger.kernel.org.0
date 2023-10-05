Return-Path: <bpf+bounces-11458-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BBF647BA35E
	for <lists+bpf@lfdr.de>; Thu,  5 Oct 2023 17:56:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id DD4B028272F
	for <lists+bpf@lfdr.de>; Thu,  5 Oct 2023 15:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B123831A69;
	Thu,  5 Oct 2023 15:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QeBzDi88"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21ED330D04
	for <bpf@vger.kernel.org>; Thu,  5 Oct 2023 15:56:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E13C4C433CC;
	Thu,  5 Oct 2023 15:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696521361;
	bh=3yQpTAu+sxNfHSN9OgsgXUOtauvkvvEyt8XXZhf2+8Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=QeBzDi88VBkjZ7kWlDKDGeGHaEjWV1lZkkcsCVKn4dR86Bo+SCfF6chKzIqn7DKRV
	 b9XYa8UC0xp3HXw60hOVdxCN9bKqUQXNtk/wRMsmTZRefN+Ihl7uysL6Qx7y/ayFzM
	 bizhHSa5OfWRTiQ0koQ/OXHjiaKnWcnqDE0HD3NlKKugmCfC5EObuOsgWNih/ajW+Y
	 j0R+Shhw8tStRzMawg2I592r9SBWd8Ifps/l96BWPUWD4Hg0nSiPODvTbDGXAbcKjJ
	 r4yUriACcMWAhvsep2awIgcHgRqFi0FOmJSCOADOjZbLgh1cIdRoTTV35Q0Dy09HP1
	 oZK9daysQ5s1A==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Thu, 05 Oct 2023 17:55:34 +0200
Subject: [PATCH v3 3/3] selftests/hid: force using our compiled libbpf
 headers
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230825-wip-selftests-v3-3-639963c54109@kernel.org>
References: <20230825-wip-selftests-v3-0-639963c54109@kernel.org>
In-Reply-To: <20230825-wip-selftests-v3-0-639963c54109@kernel.org>
To: Jiri Kosina <jikos@kernel.org>, 
 Benjamin Tissoires <benjamin.tissoires@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Justin Stitt <justinstitt@google.com>, 
 Nick Desaulniers <ndesaulniers@google.com>, 
 Eduard Zingerman <eddyz87@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1696521351; l=861;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=3yQpTAu+sxNfHSN9OgsgXUOtauvkvvEyt8XXZhf2+8Q=;
 b=eIdtTxiPAfLwDHc48vMYIjkvNAImwnjNSqDn15AmjAiyy7B9UA+gvMuOv21ud5O/eowiKvU08
 bAxL8sik++/B3aUqy31juWFTeDemZbh3/XHcdEvYyoq7jXXpJ20+jXq
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

Turns out that we were relying on the globally installed headers, not
the ones we freshly compiled.
Add a manual include in CFLAGS to sort this out.

Tested-by: Nick Desaulniers <ndesaulniers@google.com> # Build
Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
---
 tools/testing/selftests/hid/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/hid/Makefile b/tools/testing/selftests/hid/Makefile
index a28054113f47..2b5ea18bde38 100644
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


