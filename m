Return-Path: <bpf+bounces-13069-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F11B07D42C9
	for <lists+bpf@lfdr.de>; Tue, 24 Oct 2023 00:42:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5BC9BB20E53
	for <lists+bpf@lfdr.de>; Mon, 23 Oct 2023 22:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E476D224DE;
	Mon, 23 Oct 2023 22:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RhPsQ43c"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 235EF2137C;
	Mon, 23 Oct 2023 22:41:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFA43C433C7;
	Mon, 23 Oct 2023 22:41:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698100918;
	bh=OkdgsQ0WxLHiL+vWRAT85wEiCaCy0CgtTgmYQnUQPbc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RhPsQ43cno1c3dC4cP7Wli4NJWeUTIz63Jw48wsRmx4ESUVjT4DJw9xgHzq7eGojc
	 UV2WWSPZJLQMPK7uxtj7cyqImipTkWvfcnbNL2HV/9O6puQloNKWrQx3mM1OK3PrnY
	 1CJMueYT/xRmnUwW88tJZ56QimyPphscGhT56jcBLZNrHUYYa3ekvb5Z4OQDbHA5zX
	 AUjl1CtYN4F+WAw2v8P6nsSQK92uHO/ePVHbZ4DqwpknX90ljvRJH+FgsP190HPS3X
	 44p0pTWTcPhgv9kAby0voPjx4wOrSdZ+thcTyZ6n6l/bMEKP4Tu/SE0OVHKhJVJZcT
	 vKXh4CUxZPE4w==
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
Subject: [PATCH v4 bpf-next 7/9] selftests/bpf: Sort config in alphabetic order
Date: Mon, 23 Oct 2023 15:40:58 -0700
Message-Id: <20231023224100.2573116-8-song@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231023224100.2573116-1-song@kernel.org>
References: <20231023224100.2573116-1-song@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move CONFIG_VSOCKETS up, so the CONFIGs are in sorted order.

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


