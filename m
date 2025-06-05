Return-Path: <bpf+bounces-59781-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63492ACF650
	for <lists+bpf@lfdr.de>; Thu,  5 Jun 2025 20:14:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D266B3A7399
	for <lists+bpf@lfdr.de>; Thu,  5 Jun 2025 18:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AC1D279904;
	Thu,  5 Jun 2025 18:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T/Lv2qFg"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13511DFF8;
	Thu,  5 Jun 2025 18:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749147277; cv=none; b=lA/JjXumY+1jMMJ2TCNyulfFU77sJqHwtnV7L6AXNVfo29UFwJVz4spZeLhtPH3hdnVk8b6DXw7GNANDXsbpZa57nIF//o4+1Hh1uI98xYpcb8vXJ07CI14n3fluZB6QX8WF7Je+/J9VqAPwIXhXvF5eXDC9B5T4NYzIuzez1xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749147277; c=relaxed/simple;
	bh=yqXCXnrnx1xTZOHiwdz8UbMjby7wpkwa+UN+TvEGT90=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uFXL4uO/JiasZuXOqd0WnMY0mAMku60f6oLzWfNBgFSQaSairkMFAkFN6WverB8REXcesc5I+fZgws0ObBaxarZY5xhaPwTjDuFoLCe+45ODQbgQXii/CjVd1dCf/P8sHkGrQ5mb5MRXmJzvsz+BT6McBVKtPetoGNDYZl4J6fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T/Lv2qFg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E79EC4CEE7;
	Thu,  5 Jun 2025 18:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749147277;
	bh=yqXCXnrnx1xTZOHiwdz8UbMjby7wpkwa+UN+TvEGT90=;
	h=From:To:Cc:Subject:Date:From;
	b=T/Lv2qFgHvP0fpl6IS/sYUS0cLUiTw49R6wgAvLKbdKb5RA5kftAfRkT9P2JaqPxB
	 471i1CcZMKvpkYin9rZcRlysCG7pBUgiFmdoFck6/Y5iK32UUM1ZOqJKNb0NQp8Asq
	 1o+NMlLoqgMOpFSPDIGRnzeSVsEKOLJLkDiL6UTSXy5Kim4/eQ0nWZyvmbwePYssFE
	 p287Z7sO/TMkoFwc7j6xwyZWdjJqy7Cae/NSZLRBXzjwkDRt9GjTKWujkTkHp4f2yg
	 aSUeTEwl7BE75YQztsQdaqnlmYVYvrIJq2e0STmz6e4K4h1U2i6fn5owtYp20N8llL
	 V7Y4oo4YU8liA==
From: Andrii Nakryiko <andrii@kernel.org>
To: linux-kernel@vger.kernel.org,
	masahiroy@kernel.org,
	ojeda@kernel.org,
	nathan@kernel.org
Cc: bpf@vger.kernel.org,
	kernel-team@meta.com,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH] .gitignore: ignore compile_commands.json globally
Date: Thu,  5 Jun 2025 11:14:26 -0700
Message-ID: <20250605181426.2845741-1-andrii@kernel.org>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

compile_commands.json can be used with clangd to enable language server
protocol-based assistance. For kernel itself this can be built with
scripts/gen_compile_commands.py, but other projects (e.g., libbpf, or
BPF selftests) can benefit from their own compilation database file,
which can be generated successfully using external tools, like bear [0].

So, instead of adding compile_commands.json to .gitignore in respective
individual projects, let's just ignore it globally anywhere in Linux repo.

  [0] https://github.com/rizsotto/Bear

Suggested-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 .gitignore | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.gitignore b/.gitignore
index bf5ee6e01cd4..451dff66275d 100644
--- a/.gitignore
+++ b/.gitignore
@@ -175,7 +175,7 @@ x509.genkey
 *.kdev4
 
 # Clang's compilation database file
-/compile_commands.json
+compile_commands.json
 
 # Documentation toolchain
 sphinx_*/
-- 
2.47.1


