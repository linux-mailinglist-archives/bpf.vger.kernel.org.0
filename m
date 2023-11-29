Return-Path: <bpf+bounces-16199-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E52637FE443
	for <lists+bpf@lfdr.de>; Thu, 30 Nov 2023 00:45:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77C5EB21343
	for <lists+bpf@lfdr.de>; Wed, 29 Nov 2023 23:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B92AE47A6A;
	Wed, 29 Nov 2023 23:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IdPZF2Xq"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20CBB4CB33;
	Wed, 29 Nov 2023 23:44:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44978C433C8;
	Wed, 29 Nov 2023 23:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701301492;
	bh=6IoTRz3NXYHV8pBke6hkoYRnh3FOSX8xy/nXoYMfI+0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IdPZF2XqN8x+ogQ3rnSf9gZ9RvCSWC6FDWxIek7I1x8liud+uoVUSfkxrYsGY29j4
	 /H0EcRwzrpFDgXqToVEvRQ4+KHgEVYuOxpXvNdl59VD7k8J+aFcVHAIZYxBway7IPv
	 7UUZWNdgThZl9HxYOo3l/XOYExsV/ywsqjDQPOKR07EoPI7g4dm0Dz5zxH9BJ6qLqU
	 8/e9ehERrhxCp+XZHd5lJ1VIGexwAZkgQIt/s8z3ejQf4EAsK4WDKVAU8rmFOTdruY
	 CrWalHZmO+jhxeWxA0lULhlHaTmAQoKQ+ChmR4us50nhzjWB+74Cb0fe+KtJNBNIqu
	 2SCYWead61pmQ==
From: Song Liu <song@kernel.org>
To: bpf@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	fsverity@lists.linux.dev
Cc: ebiggers@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	brauner@kernel.org,
	viro@zeniv.linux.org.uk,
	casey@schaufler-ca.com,
	amir73il@gmail.com,
	kpsingh@kernel.org,
	roberto.sassu@huawei.com,
	kernel-team@meta.com,
	Song Liu <song@kernel.org>
Subject: [PATCH v15 bpf-next 4/6] selftests/bpf: Sort config in alphabetic order
Date: Wed, 29 Nov 2023 15:44:15 -0800
Message-Id: <20231129234417.856536-5-song@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231129234417.856536-1-song@kernel.org>
References: <20231129234417.856536-1-song@kernel.org>
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


