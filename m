Return-Path: <bpf+bounces-39075-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D94696E49B
	for <lists+bpf@lfdr.de>; Thu,  5 Sep 2024 23:05:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A295F28377E
	for <lists+bpf@lfdr.de>; Thu,  5 Sep 2024 21:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9239719306D;
	Thu,  5 Sep 2024 21:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rVid/LR5"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16508165F0E
	for <bpf@vger.kernel.org>; Thu,  5 Sep 2024 21:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725570328; cv=none; b=ncLXFb4KDwsv/iDIDA8Z4mvejyPmUFtmihJTq79XomJz6NpGbQv9lq38Pgv0ZPgmr1uyzFMBfCaB1iSHRvoorbpDmnUCyR7Li8FQrYZjQIKifpXBIooKwSidq7rsgXtXfNSwPZBbNO7dA63z/1/tp+clWLAHlVMfQedRUjtKiEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725570328; c=relaxed/simple;
	bh=hjPccxIKfi9Q3AMibhorpHJ8taMwIZ56kZGiRz5LuvI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S7YTZMpt7ul0FyG0A8lg7gvFUkBGZizgmvvSHTbmQHV8al46V6IvhN+8dnoCQaPVv5N7R8KcVwbnMMm1Z3X/AXWuhztWt/aXiS+yd7UhbwWI45X7J3Fy9G1zEd1AFv8bIPyMpZwQbKF5KZix3xBL20JF+AqgGrTHprIJrSO0FmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rVid/LR5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82136C4CEC3;
	Thu,  5 Sep 2024 21:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725570327;
	bh=hjPccxIKfi9Q3AMibhorpHJ8taMwIZ56kZGiRz5LuvI=;
	h=From:To:Cc:Subject:Date:From;
	b=rVid/LR5lmX0Ox7h2pQMO4OtCcZnQ4dQS+fXrfgM1WcydEGBdyAblRTocHTAVrWOV
	 Nq+ydQGIBvGT0KQsOIL26960dVgOMovLjIR48KVbFKxryQ/bGrV4dpKk0Vk91Ww4wY
	 kdk1GGW+BaBhywC2TyUutZL7Wcbfkt7o4MlugSHqBzOLoro7c3nnwTXZ4Leu1SJWOg
	 Knt12Ureyl0Lj7QGfjln/fRuhsnr17ErXntGy2BTXY++F81Cu84C0W7d+qyxVi9mQy
	 C4rucLiTNCZiGBk3PdKMRzy2zT10MJQUEZ9uJoPKe3+udo0OK/KiK3zGy5kGp7ZTGB
	 bnPNvbGpRNAKQ==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf-next] bpf: change int cmd argument in __sys_bpf into typed enum bpf_cmd
Date: Thu,  5 Sep 2024 14:05:20 -0700
Message-ID: <20240905210520.2252984-1-andrii@kernel.org>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This improves BTF data recorded about this function and makes
debugging/tracing better, because now command can be displayed as
symbolic name, instead of obscure number.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/syscall.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index fc62f5c4faf9..6988e432fc3d 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -5670,7 +5670,7 @@ static int token_create(union bpf_attr *attr)
 	return bpf_token_create(attr);
 }
 
-static int __sys_bpf(int cmd, bpfptr_t uattr, unsigned int size)
+static int __sys_bpf(enum bpf_cmd cmd, bpfptr_t uattr, unsigned int size)
 {
 	union bpf_attr attr;
 	int err;
-- 
2.43.5


