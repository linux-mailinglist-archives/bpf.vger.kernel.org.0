Return-Path: <bpf+bounces-14167-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC6927E0BC0
	for <lists+bpf@lfdr.de>; Sat,  4 Nov 2023 00:03:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B8961F21F4C
	for <lists+bpf@lfdr.de>; Fri,  3 Nov 2023 23:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E53124A1F;
	Fri,  3 Nov 2023 23:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j6pafz7m"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F4824A05;
	Fri,  3 Nov 2023 23:03:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93A76C433C8;
	Fri,  3 Nov 2023 23:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699052594;
	bh=6IoTRz3NXYHV8pBke6hkoYRnh3FOSX8xy/nXoYMfI+0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j6pafz7mVeGKvzV/Kf83WROyk1Q0OF0lsQLPIRVc6uf/F8oMyUaWh7vthKdXI2w/2
	 zoQv4T8KgrU0HZ5B7BZk18i8Pxcre+dJ2WRG5p8Ef8SaDRWG7XRbQ5tclzRyhM8ZDI
	 IZAJmTk+S7bs2xyq7yJW63oQ/J+j7To+ruBPJDfIGu6u0euiDMYL3ZVr4klzS/RtSH
	 //iQ9Fv0h7jjL6hqDTolKiiqVo1ey5TDl7lF25WNTp71foCmg/zgLwG7AomlTUf4it
	 wKTYi4+L/E3NTKqITzYfbR/VEMmIyRqssWFLTFnZgjlffvZko3F511yusGvLtW1oAn
	 HLi4STolWai/g==
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
Subject: [PATCH v11 bpf-next 7/9] selftests/bpf: Sort config in alphabetic order
Date: Fri,  3 Nov 2023 16:02:02 -0700
Message-Id: <20231103230204.3137000-8-song@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231103230204.3137000-1-song@kernel.org>
References: <20231103230204.3137000-1-song@kernel.org>
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


