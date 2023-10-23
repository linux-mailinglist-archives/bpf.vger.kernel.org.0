Return-Path: <bpf+bounces-12979-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB7F67D2A16
	for <lists+bpf@lfdr.de>; Mon, 23 Oct 2023 08:14:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 950DE28155E
	for <lists+bpf@lfdr.de>; Mon, 23 Oct 2023 06:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1B9D63A8;
	Mon, 23 Oct 2023 06:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JfBKKvyT"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D9663AF;
	Mon, 23 Oct 2023 06:14:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1428C433C8;
	Mon, 23 Oct 2023 06:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698041685;
	bh=OkdgsQ0WxLHiL+vWRAT85wEiCaCy0CgtTgmYQnUQPbc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JfBKKvyTjYPmart805N9Lwbx8coL7wBCn/8f4nyIoQeJWrqvZ/hIneu0AdtgTsQlD
	 OAmcFyUh3Ii1CPYbg4l0xTqvYfP74k2B2fP+hR6nuXCb7q1L7be9C/mbAxu2WcKcBz
	 hohhTJAuTCIz4dSnLvvxAui2qISuG/IsWxsF2NmpnhJ6MTb+Ab4Cg4MtZmV+ny07Rb
	 DKuc9yJu/c84FngzW+fvmwUN+5yrMSGNKlLQjjgcMdm6TiklbhR0cEZIt7gXCXJvcT
	 88if1XAgAdZnJmyXsUazN+KhNXnSvwg76KQQTjlCCsbIucU5ghXwyE3gLQi+EKlK26
	 ZuZUjQUlcZwqA==
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
Subject: [PATCH v2 bpf-next 7/9] selftests/bpf: Sort config in alphabetic order
Date: Sun, 22 Oct 2023 23:13:52 -0700
Message-Id: <20231023061354.941552-8-song@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231023061354.941552-1-song@kernel.org>
References: <20231023061354.941552-1-song@kernel.org>
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


