Return-Path: <bpf+bounces-20642-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96A6B84174D
	for <lists+bpf@lfdr.de>; Tue, 30 Jan 2024 01:07:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C96A61C23434
	for <lists+bpf@lfdr.de>; Tue, 30 Jan 2024 00:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81FC310FD;
	Tue, 30 Jan 2024 00:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AOohr1n8"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B82173
	for <bpf@vger.kernel.org>; Tue, 30 Jan 2024 00:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706573223; cv=none; b=G/LGGl1Dh00GbIEsCN1Ujc3eKgxFaxS3ghMNL2ysmnzOvsgzfsKXwJDM4Odv1/DZoYjHq2WVrDll4BBCI15J0E+KBewuBX0laUdX5C7brYS41ul4oVfcs0JJfwJypYZ1zu9zd+vScqs6Ub76jcoJgLWYe0RDsadgAKERwVm3jbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706573223; c=relaxed/simple;
	bh=/nG7FABT/0B+T7V9+n77eKR2tb+mCqh0cgWixDvqsHQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Npghz2j9sI81X3UaV8iWI2GRH4e7rvWBqYQPK9Z3ZrvJTk+iblPWTRwmbNchvDcC+SiniHjChmD+qpdbCdSz4bW4ks2MeRqJOzxtthxbmEH+XsNLfN8i0/Wp/zKeNj8a2Q3/xTfhUwZQFpuZRjSd6ZHeTAByOoFcbjLkh4CZQ7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AOohr1n8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A4A6C433C7;
	Tue, 30 Jan 2024 00:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706573222;
	bh=/nG7FABT/0B+T7V9+n77eKR2tb+mCqh0cgWixDvqsHQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AOohr1n8YGp0IaI7BTC6WMCfNfgFZyRfwZCE1DDwG9XXXzpZved4fDV08kdi3HIbH
	 FgUTKhb/U9VkX9YyXifwosGckz9jLxsckG5dqfNt1v2xjCS00XMnEgfhOHuS2vz0pv
	 hOz8jOj11H9MHH6lvCBFpGMyd/K4WGa/wqfgp8EFjWGKNVjFwW+DcWhSw9jInWnZmM
	 pGRK2LwwaGHUud01ucqX8BdepQfjHJJEShDFM2pkU6EhA9hAn2AwzX4Ctx+TH04Dwj
	 ZoGPl28bDTpoSv+CPuGDK+OuXu9SQsqHXrtm4L6rA/pR2Rb2A1oOD/W42eRTBOEkUX
	 uxi5P+ceQSfsg==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH v3 bpf-next 3/4] libbpf: add __arg_trusted and __arg_nullable tag macros
Date: Mon, 29 Jan 2024 16:06:47 -0800
Message-Id: <20240130000648.2144827-4-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240130000648.2144827-1-andrii@kernel.org>
References: <20240130000648.2144827-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add __arg_trusted to annotate global func args that accept trusted
PTR_TO_BTF_ID arguments.

Also add __arg_nullable to combine with __arg_trusted (and maybe other
tags in the future) to force global subprog itself (i.e., callee) to do
NULL checks, as opposed to default non-NULL semantics (and thus caller's
responsibility to ensure non-NULL values).

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/bpf_helpers.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/lib/bpf/bpf_helpers.h b/tools/lib/bpf/bpf_helpers.h
index 2324cc42b017..79eaa581be98 100644
--- a/tools/lib/bpf/bpf_helpers.h
+++ b/tools/lib/bpf/bpf_helpers.h
@@ -190,6 +190,8 @@ enum libbpf_tristate {
 
 #define __arg_ctx __attribute__((btf_decl_tag("arg:ctx")))
 #define __arg_nonnull __attribute((btf_decl_tag("arg:nonnull")))
+#define __arg_nullable __attribute((btf_decl_tag("arg:nullable")))
+#define __arg_trusted __attribute((btf_decl_tag("arg:trusted")))
 
 #ifndef ___bpf_concat
 #define ___bpf_concat(a, b) a ## b
-- 
2.34.1


