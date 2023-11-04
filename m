Return-Path: <bpf+bounces-14192-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D57FE7E0CAA
	for <lists+bpf@lfdr.de>; Sat,  4 Nov 2023 01:14:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91024282033
	for <lists+bpf@lfdr.de>; Sat,  4 Nov 2023 00:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A9F1623;
	Sat,  4 Nov 2023 00:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fcSyiih3"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86CC7196;
	Sat,  4 Nov 2023 00:14:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16764C433C8;
	Sat,  4 Nov 2023 00:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699056845;
	bh=6IoTRz3NXYHV8pBke6hkoYRnh3FOSX8xy/nXoYMfI+0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fcSyiih3cw5I/9o/885/QKKsYCK0gAmou3NZhne6eZ/18b4qKek6iiXSxIG4f79L/
	 0pqQ7lvu9hhpZnnah7/r7gTOBODS+thIT4Rs5dIZR9f2uAWLjCYQn6GVttIAMcWJo+
	 xYE3XtOWlvt1FZU9IuUVUgzB1uzsfLwXxsjTik52CFteYUur+v7ngcsPiqGal/1CZD
	 tgRaLSVCG2vZk6DvdBB8LykbzYFgJLowJpdzA4STIQ/t+5MSr7vdnsLNvVhX1yUCti
	 zOtDIkK4I8ZbjiPMoPwLc+zsZVemB0WAeyWPE8OCGXlF0d74obXFVTJRuTlbn3R2+o
	 iUKOV9CzXy+Ug==
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
Subject: [PATCH v12 bpf-next 7/9] selftests/bpf: Sort config in alphabetic order
Date: Fri,  3 Nov 2023 17:13:11 -0700
Message-Id: <20231104001313.3538201-8-song@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231104001313.3538201-1-song@kernel.org>
References: <20231104001313.3538201-1-song@kernel.org>
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


