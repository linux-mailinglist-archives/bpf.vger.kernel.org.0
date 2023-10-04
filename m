Return-Path: <bpf+bounces-11359-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADFA17B7DDE
	for <lists+bpf@lfdr.de>; Wed,  4 Oct 2023 13:09:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 368E0282320
	for <lists+bpf@lfdr.de>; Wed,  4 Oct 2023 11:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DAA011CA1;
	Wed,  4 Oct 2023 11:09:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20CA11C94;
	Wed,  4 Oct 2023 11:09:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B1A0C433C8;
	Wed,  4 Oct 2023 11:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696417765;
	bh=myfG9KhH8iXXI0iq3rgYVhXBywfTdM/2Q+7Ha1naXhg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DdFm8es+jlF7PkHpEUfqa9RdXiSnnTrCJCr3asGKmQ25q7aDJqGiUuaAa/5qS7L9z
	 sGjgLmcD4yf8vCIElGYnJZDBLO2K1qx71Kddj8zXqQkRr4jaTXHdL989/eoMzT3rbV
	 3BoQeM5AQxNS/B0ZM4opVnU/OmQG7o+DpGssD0CS5Cf7kWjb/uNoIAas6h/1cmXVzQ
	 n2rh5Faki9Te07CC5tTf4S7dHCGVi1adx+VJ5aoZExoImpEwHz3g+m3LECzBWz5a84
	 /geVjpyVLCm7CVVLgmm3RPTFIfeYpMb/dF7l+Nc5SCS8n/vaIFapNiuXa2ATVXdeaD
	 hmbttxzQ39OeQ==
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
Subject: [PATCH bpf 3/3] selftests/bpf: Define SYS_NANOSLEEP_KPROBE_NAME for riscv
Date: Wed,  4 Oct 2023 13:09:05 +0200
Message-Id: <20231004110905.49024-4-bjorn@kernel.org>
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

Add missing sys_nanosleep name for RISC-V, which is used by some tests
(e.g. attach_probe).

Fixes: 08d0ce30e0e4 ("riscv: Implement syscall wrappers")
Signed-off-by: Björn Töpel <bjorn@rivosinc.com>
---
 tools/testing/selftests/bpf/test_progs.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/bpf/test_progs.h b/tools/testing/selftests/bpf/test_progs.h
index 77bd492c6024..2f9f6f250f17 100644
--- a/tools/testing/selftests/bpf/test_progs.h
+++ b/tools/testing/selftests/bpf/test_progs.h
@@ -417,6 +417,8 @@ int get_bpf_max_tramp_links(void);
 #define SYS_NANOSLEEP_KPROBE_NAME "__s390x_sys_nanosleep"
 #elif defined(__aarch64__)
 #define SYS_NANOSLEEP_KPROBE_NAME "__arm64_sys_nanosleep"
+#elif defined(__riscv)
+#define SYS_NANOSLEEP_KPROBE_NAME "__riscv_sys_nanosleep"
 #else
 #define SYS_NANOSLEEP_KPROBE_NAME "sys_nanosleep"
 #endif
-- 
2.39.2


