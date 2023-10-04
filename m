Return-Path: <bpf+bounces-11358-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 243A47B7DD6
	for <lists+bpf@lfdr.de>; Wed,  4 Oct 2023 13:09:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by am.mirrors.kernel.org (Postfix) with ESMTP id B723C1F22290
	for <lists+bpf@lfdr.de>; Wed,  4 Oct 2023 11:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E241D11C9B;
	Wed,  4 Oct 2023 11:09:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C1512B76;
	Wed,  4 Oct 2023 11:09:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D630FC433CA;
	Wed,  4 Oct 2023 11:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696417763;
	bh=WpGCVlyEgOw4b2FaJcUO9+9LMMvSL9a+ezCXN7JxYNk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V5k4ZMhEzkCz2qXAkxEoYJrNjM1+W8E/LToiXc3tpQtiJGUS/7/LCJrOpti+PO+b5
	 1emXGUbnb/Aj5AIejFtuvRfYRSBkNYeKFihj0u0vSEZfP4fFbXxqiS50u/vtsn6G4p
	 O3QeOz7VFOYQmT2uyv9GmaVJeyI87MHAEcoA6xOrrd70E8/KUYRpKmCxg5sNFlkzEt
	 2Yy2ySLGpFJLwu9mUxH2W/4mNqMBwqa3EsRtwAbMEKtwXvhL9+Un6pqgLzIvWPySCP
	 7nN+g9/9BAv1R92zn+bWDJT3c59d4bEfN//vHcmgMaWzHIYIOph4TppgWGE78qZRdG
	 tGrk4oBUCyBcQ==
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
	Sami Tolvanen <samitolvanen@google.com>
Subject: [PATCH bpf 2/3] selftests/bpf: Define SYS_PREFIX for riscv
Date: Wed,  4 Oct 2023 13:09:04 +0200
Message-Id: <20231004110905.49024-3-bjorn@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231004110905.49024-1-bjorn@kernel.org>
References: <20231004110905.49024-1-bjorn@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Björn Töpel <bjorn@rivosinc.com>

SYS_PREFIX was missing for a RISC-V, which made a couple of kprobe
tests fail.

Add missing SYS_PREFIX for RISC-V.

Fixes: 08d0ce30e0e4 ("riscv: Implement syscall wrappers")
Signed-off-by: Björn Töpel <bjorn@rivosinc.com>
---
 tools/testing/selftests/bpf/progs/bpf_misc.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/bpf_misc.h b/tools/testing/selftests/bpf/progs/bpf_misc.h
index 38a57a2e70db..799fff4995d8 100644
--- a/tools/testing/selftests/bpf/progs/bpf_misc.h
+++ b/tools/testing/selftests/bpf/progs/bpf_misc.h
@@ -99,6 +99,9 @@
 #elif defined(__TARGET_ARCH_arm64)
 #define SYSCALL_WRAPPER 1
 #define SYS_PREFIX "__arm64_"
+#elif defined(__TARGET_ARCH_riscv)
+#define SYSCALL_WRAPPER 1
+#define SYS_PREFIX "__riscv_"
 #else
 #define SYSCALL_WRAPPER 0
 #define SYS_PREFIX "__se_"
-- 
2.39.2


