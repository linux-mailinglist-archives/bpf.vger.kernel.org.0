Return-Path: <bpf+bounces-57394-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25DE7AAA16E
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 00:47:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F33433A5EA5
	for <lists+bpf@lfdr.de>; Mon,  5 May 2025 22:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 295D32BD588;
	Mon,  5 May 2025 22:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="leiJ6W/c"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97EE327E7F1;
	Mon,  5 May 2025 22:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746483586; cv=none; b=S+8CpD0jHVcP5CeA8w0EShA3XU/+w35hhk0/ChP9464vK464xYr6b639l9meiUqH0yjPPGM6eqfWk6dneGrFy402Dez9RERg+ZvSdpUV/oMbYqLfeluUb2Wf3ykd/R/dSsQtmrdOwBdGBk0PWL8b2pjX97SIc0KA7evaOprnyiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746483586; c=relaxed/simple;
	bh=cc5YCPlNVsnOL29dlOHKlkRC1mS7iFDhMy8uD9vUwf8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=suUrmAuMWV5sC7LJ2XihOUa/Bi/cQlnTjIthn56cnrkva1ROtGldOyyIcSe6IckWqfooROPv9gzpXr+/HcW2IlCXegPIOYTuFZe+DUmf1rxi8TqBVN5pYDd8O+qhAC1JuIerjNVSt7GGNx95QohpJmMDvDAMIU0cmDgCmqJE9k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=leiJ6W/c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D74BC4CEEE;
	Mon,  5 May 2025 22:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746483586;
	bh=cc5YCPlNVsnOL29dlOHKlkRC1mS7iFDhMy8uD9vUwf8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=leiJ6W/cnqCOpo4W7GWPs2iDZuAzP/0g3iyi+mZoEVh61ArXqEM4AmDnDJrxPEXr4
	 LA9qUqQBG3JGKUmKTe4YEja0sTsK6ItfsBDtyf+YnkgwZ8RWJ7FrqrkOqpK1TUKvaq
	 IpvlEcgtPaibPUlMjFTqAdkDC92/yx2Sc+Cn1Z1qIjg3t9Ko7o3McW0YeQWegwczFY
	 A0AsnzN1yrbdUpCatRmgS70sbRk1gs2SzI5lQXyw04lNxZ0nQR2kPXreNMVZixVg2y
	 bd8FLd6/3yrQeZ1zl3XZZy7JlamZQjekoPEotUtxM8MGaBmnRvebUyI01PzZEbtHXg
	 5srzHNQ1hJ8xw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mykyta Yatsenko <yatsenko@meta.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Sasha Levin <sashal@kernel.org>,
	ast@kernel.org,
	daniel@iogearbox.net,
	bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 127/642] bpf: Return prog btf_id without capable check
Date: Mon,  5 May 2025 18:05:43 -0400
Message-Id: <20250505221419.2672473-127-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Mykyta Yatsenko <yatsenko@meta.com>

[ Upstream commit 07651ccda9ff10a8ca427670cdd06ce2c8e4269c ]

Return prog's btf_id from bpf_prog_get_info_by_fd regardless of capable
check. This patch enables scenario, when freplace program, running
from user namespace, requires to query target prog's btf.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Acked-by: Yonghong Song <yonghong.song@linux.dev>
Link: https://lore.kernel.org/bpf/20250317174039.161275-3-mykyta.yatsenko5@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/syscall.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 1c2caae0d8946..87f886ed33bc3 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -4733,6 +4733,8 @@ static int bpf_prog_get_info_by_fd(struct file *file,
 	info.recursion_misses = stats.misses;
 
 	info.verified_insns = prog->aux->verified_insns;
+	if (prog->aux->btf)
+		info.btf_id = btf_obj_id(prog->aux->btf);
 
 	if (!bpf_capable()) {
 		info.jited_prog_len = 0;
@@ -4879,8 +4881,6 @@ static int bpf_prog_get_info_by_fd(struct file *file,
 		}
 	}
 
-	if (prog->aux->btf)
-		info.btf_id = btf_obj_id(prog->aux->btf);
 	info.attach_btf_id = prog->aux->attach_btf_id;
 	if (attach_btf)
 		info.attach_btf_obj_id = btf_obj_id(attach_btf);
-- 
2.39.5


