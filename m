Return-Path: <bpf+bounces-40994-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D858E990CE4
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 20:58:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 988982812F0
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 18:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96ECE1DDA2C;
	Fri,  4 Oct 2024 18:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oOXKCsAE"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 156C71DDA1C;
	Fri,  4 Oct 2024 18:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728066311; cv=none; b=jOGSebp36dxjgpwSLpCfsCCnvbJKDJh91b7k4+2piOa1i1csCj98cpa40APxc2UkMx0je59gE2vh7K4HVLO2mjWSBD361ffmLFc+EAWL5OZxnm7SwatcnF+u52gIvP5tWYe5fcDcFHo8Ogbg7pMOh4Fxe50psiRgLN8hyIUY5+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728066311; c=relaxed/simple;
	bh=O4gZNp4PfpL2jnQmHpRzJs76aQnSjUxAfe4rel640P0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L9xXGLESqgx8hi4x8Hbh101mKjSLUoN5PtO2rr1aq8jKb4JjFzeafQ+VuILTtYt1UNNLTM1e2dxQh51IF/F+jeP/yFfYGEsXrJ9pdvdHmYBnJY6k2OQAUoG5IkSlyong74EYKiw46wMOED0UKUhi9gnG/VxULcCvKmFWdwWJ0CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oOXKCsAE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3CE8C4CEC6;
	Fri,  4 Oct 2024 18:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728066310;
	bh=O4gZNp4PfpL2jnQmHpRzJs76aQnSjUxAfe4rel640P0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oOXKCsAEopDoiTTkWmHh3pMp8nSUfV/aBszNjL4vUgaQ85h2oxykpNr0ZXPcAigcz
	 oWzFEwH4GSkXIHotSmtXOoQBHKLcvA4AXXHyFuNOkB481f6Ag8BqjhKq6TGW1JDare
	 wWQe0qYqoYT/XOewp8lWmKcaYHC0SQoyPPpY/uq1xDTmJE+Ud/LSfYp8txMRbMMlD4
	 79I3JFuBH7L1ng16FcY/w8An/mleoybEsZnkYks3NL2+Gtk97LNFyUz+ZUiXN87YbB
	 1CmNjmWJBlxqFs/dgzFOUcmeOOCjNiBHrf9rOMcahHJU+PuUpyUKma+Y20RcYxLHbw
	 rGVA40FSjItDA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kuan-Wei Chiu <visitorckw@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Quentin Monnet <qmo@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	ast@kernel.org,
	daniel@iogearbox.net,
	bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 04/58] bpftool: Fix undefined behavior caused by shifting into the sign bit
Date: Fri,  4 Oct 2024 14:23:37 -0400
Message-ID: <20241004182503.3672477-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004182503.3672477-1-sashal@kernel.org>
References: <20241004182503.3672477-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.54
Content-Transfer-Encoding: 8bit

From: Kuan-Wei Chiu <visitorckw@gmail.com>

[ Upstream commit 4cdc0e4ce5e893bc92255f5f734d983012f2bc2e ]

Replace shifts of '1' with '1U' in bitwise operations within
__show_dev_tc_bpf() to prevent undefined behavior caused by shifting
into the sign bit of a signed integer. By using '1U', the operations
are explicitly performed on unsigned integers, avoiding potential
integer overflow or sign-related issues.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Acked-by: Quentin Monnet <qmo@kernel.org>
Link: https://lore.kernel.org/bpf/20240908140009.3149781-1-visitorckw@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/bpf/bpftool/net.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/bpf/bpftool/net.c b/tools/bpf/bpftool/net.c
index bd4e66d514f14..28e9417a5c2e3 100644
--- a/tools/bpf/bpftool/net.c
+++ b/tools/bpf/bpftool/net.c
@@ -480,9 +480,9 @@ static void __show_dev_tc_bpf(const struct ip_devname_ifindex *dev,
 		if (prog_flags[i] || json_output) {
 			NET_START_ARRAY("prog_flags", "%s ");
 			for (j = 0; prog_flags[i] && j < 32; j++) {
-				if (!(prog_flags[i] & (1 << j)))
+				if (!(prog_flags[i] & (1U << j)))
 					continue;
-				NET_DUMP_UINT_ONLY(1 << j);
+				NET_DUMP_UINT_ONLY(1U << j);
 			}
 			NET_END_ARRAY("");
 		}
@@ -491,9 +491,9 @@ static void __show_dev_tc_bpf(const struct ip_devname_ifindex *dev,
 			if (link_flags[i] || json_output) {
 				NET_START_ARRAY("link_flags", "%s ");
 				for (j = 0; link_flags[i] && j < 32; j++) {
-					if (!(link_flags[i] & (1 << j)))
+					if (!(link_flags[i] & (1U << j)))
 						continue;
-					NET_DUMP_UINT_ONLY(1 << j);
+					NET_DUMP_UINT_ONLY(1U << j);
 				}
 				NET_END_ARRAY("");
 			}
-- 
2.43.0


