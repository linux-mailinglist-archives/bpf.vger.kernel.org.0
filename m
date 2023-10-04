Return-Path: <bpf+bounces-11367-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 788207B7F10
	for <lists+bpf@lfdr.de>; Wed,  4 Oct 2023 14:27:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 436B82817DC
	for <lists+bpf@lfdr.de>; Wed,  4 Oct 2023 12:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16FC213FE7;
	Wed,  4 Oct 2023 12:27:35 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61AA13FE0;
	Wed,  4 Oct 2023 12:27:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10B52C433CB;
	Wed,  4 Oct 2023 12:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696422454;
	bh=wY6Lz/zx7I9HiBpRiawuNkcCXD5tjJfz6F8komvznPE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JXrJm4DS5M4NI/TAZPxlBg/4QQ0mBVNPLkmxB0BQ+hyoYvazGaRUKOD7m7X9a7Jsv
	 9BQSthEQTVVz3PvMnA853dexF644DxsIXZd7XMY0YUqA1h6IW1y8arPOx6lBVwS3NY
	 tzRySzd1Ui1cu7I/GOXbI9Z0Y3orcUbZRhpb1WCz40Mz0Rw0FFuhs04+N2qo8lr6pX
	 FvVqjZjX1j9HBv6WKAzAchdr1V/PrsjijZk4T+8ZmndGXybhpnaq+piKKLj+Wo7MGq
	 kc24UfdHzDd8tkC5q7PZ7SQZRleU1B42NmDDujJtqhl/bQzMIwGKl4oFIQzSHi10vS
	 8op2PCRoSiVBQ==
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
Subject: [PATCH bpf-next 3/3] selftests/bpf: Add uprobe_multi to gen_tar target
Date: Wed,  4 Oct 2023 14:27:21 +0200
Message-Id: <20231004122721.54525-4-bjorn@kernel.org>
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

The uprobe_multi program was not picked up for the gen_tar target. Fix
by adding it to TEST_GEN_FILES.

Signed-off-by: Björn Töpel <bjorn@rivosinc.com>
---
 tools/testing/selftests/bpf/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 098e32c684d5..07ac73cc339d 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -104,7 +104,7 @@ TEST_GEN_PROGS_EXTENDED = test_sock_addr test_skb_cgroup_id_user \
 	xskxceiver xdp_redirect_multi xdp_synproxy veristat xdp_hw_metadata \
 	xdp_features
 
-TEST_GEN_FILES += liburandom_read.so urandom_read sign-file
+TEST_GEN_FILES += liburandom_read.so urandom_read sign-file uprobe_multi
 
 # Emit succinct information message describing current building step
 # $1 - generic step name (e.g., CC, LINK, etc);
-- 
2.39.2


