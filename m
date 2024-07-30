Return-Path: <bpf+bounces-36103-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1104F94235D
	for <lists+bpf@lfdr.de>; Wed, 31 Jul 2024 01:18:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7BC15B22994
	for <lists+bpf@lfdr.de>; Tue, 30 Jul 2024 23:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FAE3191F7B;
	Tue, 30 Jul 2024 23:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PNSRzfAJ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC25136126
	for <bpf@vger.kernel.org>; Tue, 30 Jul 2024 23:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722381489; cv=none; b=dEFVob84FBuxKpGedtEj2fVZ6Hu1FOMmdviPkS9Fx29U3AGM4diLp5Gv7+Coylx8nxhFy13aXa2pgfHgoxWrcwNc0RmBFrc6ETtvZt8cJ5WTU9l0YP7DC2sH/PVH29EHaFxCso4IDjEJqcyb4rI8uCWz98IjFUoo7C+PyVF9py4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722381489; c=relaxed/simple;
	bh=RP+IMnuH+Z2SlxqILWz7gVdkPk2uhCbRazKI7mp3jTw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dNu3Dej84M3OZ6+tqxNL/W0S2UB6dFUBkKx1bP0SAXyZQgT+/M8VhI0YFd+L7/cNonHll2hccvK28RRgDDVOylZBWKHiYnRKso1ZS4Peang25jNABTCqlYwlcCQW5DX1srdTk3dOU85XtgCGa+sLYQ6sSZFzX96bm1vy0MkjMxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PNSRzfAJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2845EC32782;
	Tue, 30 Jul 2024 23:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722381489;
	bh=RP+IMnuH+Z2SlxqILWz7gVdkPk2uhCbRazKI7mp3jTw=;
	h=From:To:Cc:Subject:Date:From;
	b=PNSRzfAJekvxs/G0rgVjaeMX4dzKpDnj7CVSq8vb3aXvlGezsOW0Q49hlGSVT3Fme
	 TLXOtY9cFL5n8JabczYzum5e+oWV2sZAwNyi+BlhPwl/71iYkk7jEw4DPVZjjPZSi/
	 Rjh5A6k7O4SAg7cgtSRKwjKtnVFO6WMK73Jc+rUWIxNrbkoJIA+Nc2NrSOsgMCNPNY
	 TWI5nXFDVbSH+k1BiC8zBzbCtVZ0WfKusFPVzPAEJfji56xQXSKj3Rdz6bpohgniPg
	 1iYLWYOWdiQkW7vlUutSV5YKNwrT16WQTCecZTHDhg/qvT2dlUENsmucYcT1/IsRJr
	 TofLBNAMCzZPA==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf-next] selftests/bpf: fix RELEASE=1 compilation for sock_addr.c
Date: Tue, 30 Jul 2024 16:18:05 -0700
Message-ID: <20240730231805.1933923-1-andrii@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When building selftests with RELEASE=1 using GCC compiler, it complaints
about uninitialized err. Fix the problem.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/testing/selftests/bpf/prog_tests/sock_addr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/sock_addr.c b/tools/testing/selftests/bpf/prog_tests/sock_addr.c
index b880c564a204..a6ee7f8d4f79 100644
--- a/tools/testing/selftests/bpf/prog_tests/sock_addr.c
+++ b/tools/testing/selftests/bpf/prog_tests/sock_addr.c
@@ -2642,6 +2642,7 @@ void test_sock_addr(void)
 			break;
 		default:
 			ASSERT_TRUE(false, "Unknown sock addr test type");
+			err = -EINVAL;
 			break;
 		}
 
-- 
2.43.0


