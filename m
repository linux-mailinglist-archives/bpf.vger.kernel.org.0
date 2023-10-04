Return-Path: <bpf+bounces-11366-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DEBF57B7F0F
	for <lists+bpf@lfdr.de>; Wed,  4 Oct 2023 14:27:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 2D97428218A
	for <lists+bpf@lfdr.de>; Wed,  4 Oct 2023 12:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B8F413FE3;
	Wed,  4 Oct 2023 12:27:32 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C092013FE0;
	Wed,  4 Oct 2023 12:27:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E9CBC433C8;
	Wed,  4 Oct 2023 12:27:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696422451;
	bh=ijfr6HFXllf/luvFREpH5FQI3TulGFgVtkvmLdbFv64=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ScLODdL0FrTl5WcI4ZFVzGB/3dhIzfv39c91kHKpMnyUpcbtbtAicWM3hO66nM6Jb
	 bVGqwF21qcWd+bm1lueR+jBY8wwIWKYNoYTYcMV5uUX7HMo0X13sbX81fvHZnopNo5
	 1Rs4OiEOAF+6PrpMN19sAkF6KeNRClItyAajXK9P4zN5/jtP0FFPT0NH8sVkCsO0IR
	 As5LUiW+61xLkD2OZ1LrQPGhaRqCIxEKNQFMrM9rKHv0Zp81Ws7ZX1n+IbeEys5JI1
	 MRPxVyJR7R7Nz6m5m+bZ3h1RwL7RYNlZzN2W5NJaI3R9hQmaMf1Ni4HoZgRsQyAp7L
	 AZQTBqgRtdMfQ==
From: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org
Cc: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH bpf-next 2/3] selftests/bpf: Enable lld usage for RISC-V
Date: Wed,  4 Oct 2023 14:27:20 +0200
Message-Id: <20231004122721.54525-3-bjorn@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231004122721.54525-1-bjorn@kernel.org>
References: <20231004122721.54525-1-bjorn@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Björn Töpel <bjorn@rivosinc.com>

RISC-V has proper lld support. Use that, similar to what x86 does, for
urandom_read et al.

Signed-off-by: Björn Töpel <bjorn@rivosinc.com>
---
 tools/testing/selftests/bpf/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index a9cbb85fa180..098e32c684d5 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -188,7 +188,7 @@ $(OUTPUT)/%:%.c
 	$(Q)$(LINK.c) $^ $(LDLIBS) -o $@
 
 # LLVM's ld.lld doesn't support all the architectures, so use it only on x86
-ifeq ($(SRCARCH),x86)
+ifeq ($(SRCARCH),$(filter $(SRCARCH),x86 riscv))
 LLD := lld
 else
 LLD := ld
-- 
2.39.2


