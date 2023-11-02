Return-Path: <bpf+bounces-14024-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DDDD77DFB58
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 21:17:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 177191C20F9E
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 20:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22AB521A01;
	Thu,  2 Nov 2023 20:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p9GsGe6F"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BEAA1CA82;
	Thu,  2 Nov 2023 20:17:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B227C433C7;
	Thu,  2 Nov 2023 20:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698956231;
	bh=6IoTRz3NXYHV8pBke6hkoYRnh3FOSX8xy/nXoYMfI+0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p9GsGe6FTCpnHvAQ+Lb1hSZru1rCgWfMqc4QoCLPw9mM1Gt/rC9ctT5MunPBr6G9D
	 BXSgj9NPXgptA+gmjJZ5jIbbFNachK4blVG4EuAVYSQEVfH1qXQjf+6BYpm7BIkBfp
	 Su9E39538nuR5xeXyJq/VTnOdfCcFdfpEFAjEHn3um19hZ3U1mlt3Zy16CUhRWn0Kj
	 nwpDubw4Hswj2DtwPNPQBzJO9bWcUaW6VI8/a0Ve/ewtBnQxdZdu4bKDNbMUXEJ71e
	 3tuQK1jcfMK/VsThpXCiH5ZtTFvdONg6jx4xtdTCHPnWqiCA3Lsa+LOUmcsMpUUc98
	 f1wQpk0LWvJPQ==
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
	kpsingh@kernel.org,
	vadfed@meta.com,
	Song Liu <song@kernel.org>
Subject: [PATCH v8 bpf-next 7/9] selftests/bpf: Sort config in alphabetic order
Date: Thu,  2 Nov 2023 13:16:17 -0700
Message-Id: <20231102201619.3135203-8-song@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231102201619.3135203-1-song@kernel.org>
References: <20231102201619.3135203-1-song@kernel.org>
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
index 3ec5927ec3e5..782876452acf 100644
--- a/tools/testing/selftests/bpf/config
+++ b/tools/testing/selftests/bpf/config
@@ -82,7 +82,7 @@ CONFIG_SECURITY=y
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


