Return-Path: <bpf+bounces-13196-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9014F7D5EE0
	for <lists+bpf@lfdr.de>; Wed, 25 Oct 2023 01:56:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30BEFB21125
	for <lists+bpf@lfdr.de>; Tue, 24 Oct 2023 23:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8CEC2D61D;
	Tue, 24 Oct 2023 23:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RoKXl7hW"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58DA8749D;
	Tue, 24 Oct 2023 23:56:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EA56C433C8;
	Tue, 24 Oct 2023 23:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698191806;
	bh=/AqxNKM2oDsDuOXrm5zJZpbk7p+aUoJlSJ50wuZ9rqs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RoKXl7hWEM72FKDGwJUZcIIEz4hZSI/wEc2Z7ZF/Vj5mE/YOmj+aKFV3rvzBmTCYz
	 Pc+LMObWNN6gBTXMCcQp2N5MPTaCIH3oFrKWqyA7IheFXbNR2QyI6wKsDQS+Hwhi+k
	 C4j3uU6NEh9z6+Gkt2AelKLycVDS6FnjCbpy/Bh3NkidXciuNcK7kMuLmCFCjUG2L9
	 5uRRdoLlWwBV0iFcKsKon1J6/JjwJ5HbyORaZXAf06QW1G1FqZ55eoBbaYA7zYePTK
	 EznnwUVUuNdhtKrgJ1ZTW99OL9rjrgwkmRK/yBowFYwSBcKEfTgvWuXLKYOWYS5byP
	 7cNcgBvyk84wg==
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
Subject: [PATCH v6 bpf-next 7/9] selftests/bpf: Sort config in alphabetic order
Date: Tue, 24 Oct 2023 16:55:49 -0700
Message-Id: <20231024235551.2769174-8-song@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231024235551.2769174-1-song@kernel.org>
References: <20231024235551.2769174-1-song@kernel.org>
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


