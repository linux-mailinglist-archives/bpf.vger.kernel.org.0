Return-Path: <bpf+bounces-28034-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40CE88B494D
	for <lists+bpf@lfdr.de>; Sun, 28 Apr 2024 05:10:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AADE11F219D5
	for <lists+bpf@lfdr.de>; Sun, 28 Apr 2024 03:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 879F71854;
	Sun, 28 Apr 2024 03:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E9qNGKpA"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D3C415A4
	for <bpf@vger.kernel.org>; Sun, 28 Apr 2024 03:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714273799; cv=none; b=n4ZCYKRt9B5t2DkmkSiz42VH6QyEh1n4ZNV0RP9AHD5QVaG+P/Unqjl7xLs34+qtixP3u9+kSZgu3KXwCWOGh7pAHbvArL5D29G6hqx6huKRSS6epjpfcvdaN7UnFDgpXLjdfAAUze0kaYq2A//aQQN50FJydgKQWtWU8dqZc5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714273799; c=relaxed/simple;
	bh=M+f6FGX/NlpWY2UAW4CMRy1hoWIOuV8ddiIs7DCIe9k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iKgonTNR/t6mGSNMzrhY+so8KiGiypexvIAv6+vCLJqxvWOkuQHTAIMWA9MXB4TE2kKRjuJSUmSj3kcexh8uKEuOSYaL1t+xNaSTWNbHUCr/WnsbJSilgUK3qTeqN6K1J2UAbVIpOBOXS4LC6BG+CPgoFG+RMY1B6gA5sa/4ZXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E9qNGKpA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69FC7C4AF17;
	Sun, 28 Apr 2024 03:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714273798;
	bh=M+f6FGX/NlpWY2UAW4CMRy1hoWIOuV8ddiIs7DCIe9k=;
	h=From:To:Cc:Subject:Date:From;
	b=E9qNGKpAwnXCRVwaFypJDYW3nXN8wMNLH36R38C7M7o5cE5zhHv4DFBUiZ9szHJwR
	 FSWZN4v6uyaq3KfGg/Qt9h1Wn2fIBKKlbnUhNmXAFgfYiI9QfOIawKM8HXe9r/qN4u
	 TXz+Go8kbb20H3lKf1S0jCWv6K3q2hqw7f44a4l6qxy+MglowurJGp6AP5N1BwMHkk
	 EzEdXN/+vesC17JqTMoecCBUwVilcWmEHsE8e8SSFtqvN6/dfD2157RimZV5KtZxQu
	 d1x2TWexC4MZMCcuF/t2kCZNLzg0Ny37C7nMu6uPItxPSLk4Zk29Hm1+I1bj976DHg
	 /lHdksqZO6Qag==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf-next 1/2] libbpf: handle nulled-out program in struct_ops correctly
Date: Sat, 27 Apr 2024 20:09:53 -0700
Message-ID: <20240428030954.3918764-1-andrii@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If struct_ops has one of program callbacks set declaratively and host
kernel is old and doesn't support this callback, libbpf will allow to
load such struct_ops as long as that callback was explicitly nulled-out
(presumably through skeleton). This is all working correctly, except we
won't reset corresponding program slot to NULL before bailing out, which
will lead to libbpf not detecting that BPF program has to be not
auto-loaded. Fix this by unconditionally resetting corresponding program
slot to NULL.

Fixes: c911fc61a7ce ("libbpf: Skip zeroed or null fields if not found in the kernel type.")
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/libbpf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 97eb6e5dd7c8..898d5d34ecea 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -1148,6 +1148,7 @@ static int bpf_map__init_kern_struct_ops(struct bpf_map *map)
 			 * presented in the kernel BTF.
 			 */
 			if (libbpf_is_mem_zeroed(mdata, msize)) {
+				st_ops->progs[i] = NULL;
 				pr_info("struct_ops %s: member %s not found in kernel, skipping it as it's set to zero\n",
 					map->name, mname);
 				continue;
-- 
2.43.0


