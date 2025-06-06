Return-Path: <bpf+bounces-59953-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E419AD09B2
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 23:48:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B771171C43
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 21:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A1A523815D;
	Fri,  6 Jun 2025 21:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WNHXw3FE"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964A32AD22;
	Fri,  6 Jun 2025 21:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749246522; cv=none; b=mucMRmyrC9T839/Ubx2vWBhuQXMeLJ78oL8DC9boaia1nOJjANYkRhikEaR80frsOPB9m6WKXT2oyljlBnUfDYi7Gb/qxxi6PQ9+Lg9EvjnGipJCeAuPTTy5nfmvkJgXPf4fKxI3DnplN3FL91qbiT/QHuBQg9nCS0nD/KmBoMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749246522; c=relaxed/simple;
	bh=6OfzKA0KEGwHSKRNuz5HIV5smfII8VgMlF3DmNtFVdM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KB2BFTrwPorS0x7LKjAWa7/2lL1d5+0++bMU+Cmtg1U1NxYGNkRIv6yfdCnjFGNNua1HHp40yS1nQYUAG7b5dmNhujaiWd7TTt/suhYmBVRyDo7gS4xlOXPC6IOZKxbcO2hQ+Q+oLMQjHbu9E4loFHmyizkOpD5v8XhrkYlPv3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WNHXw3FE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 161F8C4CEEB;
	Fri,  6 Jun 2025 21:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749246522;
	bh=6OfzKA0KEGwHSKRNuz5HIV5smfII8VgMlF3DmNtFVdM=;
	h=From:To:Cc:Subject:Date:From;
	b=WNHXw3FEqv66od7d6UIHk5bsqBDoGzqTLztT0YO3N3nupKNy1fqG/v0OaC7z2m/XZ
	 qil4RsalgKR+AL5I3dy9PorRKSZF0IxKeuwjcAePDx3TdVuWc0o5pRKd7RQpcASoPA
	 ctYWFWpSk9OJG7kck55ITfCSUiVNahCRHOqZ75+JuljiKb4VIIdGOcJLXQGK/XX3OY
	 SHuHGQ9H22s6YUuhlo9DHQhYdMYTLFliHHQTvwhlRTNlVhMIf8llhVQiUh/9vENcD+
	 4P1F/dr44TZ9V1ZxV3rlIqcfkeN2I4d/ABUV63Ewkf7ICmqHoxjPiZm4cwhLujxGYe
	 6LbTlTc2WceAg==
From: Andrii Nakryiko <andrii@kernel.org>
To: linux-kernel@vger.kernel.org,
	masahiroy@kernel.org,
	ojeda@kernel.org,
	nathan@kernel.org
Cc: bpf@vger.kernel.org,
	kernel-team@meta.com,
	linux-pm@vger.kernel.org,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH v2] .gitignore: ignore compile_commands.json globally
Date: Fri,  6 Jun 2025 14:48:40 -0700
Message-ID: <20250606214840.3165754-1-andrii@kernel.org>
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

While at it, remove exactly such a local .gitignore rule under
tools/power/cpupower.

  [0] https://github.com/rizsotto/Bear

Reviewed-by: Nathan Chancellor <nathan@kernel.org>
Suggested-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
v1->v2:
  - clean up tools/power/cpupower's .gitignore (Miguel Ojeda).

 .gitignore                      | 2 +-
 tools/power/cpupower/.gitignore | 3 ---
 2 files changed, 1 insertion(+), 4 deletions(-)

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
diff --git a/tools/power/cpupower/.gitignore b/tools/power/cpupower/.gitignore
index 5113d5a7aee0..7677329c42a6 100644
--- a/tools/power/cpupower/.gitignore
+++ b/tools/power/cpupower/.gitignore
@@ -27,6 +27,3 @@ debug/i386/intel_gsic
 debug/i386/powernow-k8-decode
 debug/x86_64/centrino-decode
 debug/x86_64/powernow-k8-decode
-
-# Clang's compilation database file
-compile_commands.json
-- 
2.47.1


