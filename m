Return-Path: <bpf+bounces-13120-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C7D77D4788
	for <lists+bpf@lfdr.de>; Tue, 24 Oct 2023 08:31:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E1891C20BD2
	for <lists+bpf@lfdr.de>; Tue, 24 Oct 2023 06:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2DCE125B6;
	Tue, 24 Oct 2023 06:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dwLXckRV"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0203914277;
	Tue, 24 Oct 2023 06:31:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02559C433C7;
	Tue, 24 Oct 2023 06:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698129106;
	bh=/AqxNKM2oDsDuOXrm5zJZpbk7p+aUoJlSJ50wuZ9rqs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dwLXckRVSCLbN1JD34noZq+ZpbLcxWSB89pkNAQOTZtLBTw2RH/huI/XXfwdSROPd
	 qQFy/dWO8jlWoQgBE+IjFjckF4SGC3iVrsNodqkrMrJOtIzsY9LGzfcjxvJnPnEcpB
	 pr2UoULnR78qmNOqzBOgLEyDE58p67YQoNMUbXNzF6Miy6VpLgKXGkCqfG/0d9H1eS
	 NKKGvlhN2UMgQDH7W3U4X1kVTqkpnaKxjH8vLsWSgCRDip+z4Tjo086wGWtFpwUgl/
	 OFr3vNvPptIjQA6vzRgm/W1cYWJKeDkVQdSz8r8iD4HncMO3pk1f7TWCSm67glmQ4N
	 7pHnhakVD4/cQ==
From: Song Liu <song@kernel.org>
To: bpf@vger.kernel.org,
	fsverity@lists.linux.dev
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	kernel-team@meta.com,
	ebiggers@kernel.org,
	tytso@mit.edu,
	roberto.sassu@huaweicloud.com,
	Song Liu <song@kernel.org>
Subject: [PATCH v5 bpf-next 7/9] selftests/bpf: Sort config in alphabetic order
Date: Mon, 23 Oct 2023 23:30:54 -0700
Message-Id: <20231024063056.1008702-8-song@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231024063056.1008702-1-song@kernel.org>
References: <20231024063056.1008702-1-song@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move CONFIG_VSOCKETS up, so the CONFIGs are in alphabetic order.

Signed-off-by: Song Liu <song@kernel.org>
---
 tools/testing/selftests/bpf/config | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftests/bpf/config
index 02dd4409200e..09da30be8728 100644
--- a/tools/testing/selftests/bpf/config
+++ b/tools/testing/selftests/bpf/config
@@ -81,7 +81,7 @@ CONFIG_SECURITY=y
 CONFIG_SECURITYFS=y
 CONFIG_TEST_BPF=m
 CONFIG_USERFAULTFD=y
+CONFIG_VSOCKETS=y
 CONFIG_VXLAN=y
 CONFIG_XDP_SOCKETS=y
 CONFIG_XFRM_INTERFACE=y
-CONFIG_VSOCKETS=y
-- 
2.34.1


