Return-Path: <bpf+bounces-45543-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 164B29D772D
	for <lists+bpf@lfdr.de>; Sun, 24 Nov 2024 19:14:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88833C00BE8
	for <lists+bpf@lfdr.de>; Sun, 24 Nov 2024 15:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3A0A1EABAB;
	Sun, 24 Nov 2024 13:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tkei2gIx"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266881B6D14;
	Sun, 24 Nov 2024 13:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732456635; cv=none; b=pMVVRqEkfftBWoptLsnJkfxJVHrXZYJbt3ihJILRaRisg+VcOJhVUZ2p5veTKKpKA2u3jxSB7w6XCS03RQJMetqbeFnn5NWxrU7r1R+H08JIGdkgVYeAwiDLSdorM9vWUWjhNMH75AgbCLKeJZC7QCuc+KmuohTONAIxlC3QMus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732456635; c=relaxed/simple;
	bh=UfvA3jp7HA7D1xdiFW8nzCh+DbA83drGo8aRe/3mfk8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PIEkKVDQcM+u1ATVpeDCmib2Js/gi0GK7ZmRPCvSVCBPfPsbsnav4MV9WPhB4F74CnZIKerjR94BuCRdxrZR+MVvvZJkYfFY6Bs4c56ftRGFfibmb8s8B0UOuqNT5OkD2mkx9fLzaZXAQdEnYiWrN56cEf86I5Z9LZGDFm2zCsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tkei2gIx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A626C4CED3;
	Sun, 24 Nov 2024 13:57:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732456634;
	bh=UfvA3jp7HA7D1xdiFW8nzCh+DbA83drGo8aRe/3mfk8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Tkei2gIxP5tlztAK9Zx1FlZ/h7s+tJSrs01CGs4EjTnQNzlF7A4dAo27wyGiQ794I
	 H4EFBU0eM1wcdJhZLrx6e/+OqZRhwbeXXiJ7c4raqVB7rj0dnsM783M5+hhzQ6GdYh
	 BywEQ/bsSkBu6RGUmBMfxxbSH6rOeTXM6/OYKPNgV9HfApR6fbgBidhQMxUtO5qvSj
	 RifXSwS2ZNQdsGWcB7GhjxkSaN8fjET3SHgnnKrqQGD4oOAKW6npnlrb4PBb6JXKBH
	 Ybvc0jZDM9dkyTIE0ZLFOUljOGJfZAxi6GEgtN5lXI/4FHpSFUEyKjwDzBR99T48Cm
	 AZVIm4D+cS71g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Zhu Jun <zhujun2@cmss.chinamobile.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	ast@kernel.org,
	daniel@iogearbox.net,
	bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 02/21] samples/bpf: Fix a resource leak
Date: Sun, 24 Nov 2024 08:56:35 -0500
Message-ID: <20241124135709.3351371-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124135709.3351371-1-sashal@kernel.org>
References: <20241124135709.3351371-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.324
Content-Transfer-Encoding: 8bit

From: Zhu Jun <zhujun2@cmss.chinamobile.com>

[ Upstream commit f3ef53174b23246fe9bc2bbc2542f3a3856fa1e2 ]

The opened file should be closed in show_sockopts(), otherwise resource
leak will occur that this problem was discovered by reading code

Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Link: https://lore.kernel.org/bpf/20241010014126.2573-1-zhujun2@cmss.chinamobile.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 samples/bpf/test_cgrp2_sock.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/samples/bpf/test_cgrp2_sock.c b/samples/bpf/test_cgrp2_sock.c
index b0811da5a00f3..3f56519a1ccd7 100644
--- a/samples/bpf/test_cgrp2_sock.c
+++ b/samples/bpf/test_cgrp2_sock.c
@@ -174,8 +174,10 @@ static int show_sockopts(int family)
 		return 1;
 	}
 
-	if (get_bind_to_device(sd, name, sizeof(name)) < 0)
+	if (get_bind_to_device(sd, name, sizeof(name)) < 0) {
+		close(sd);
 		return 1;
+	}
 
 	mark = get_somark(sd);
 	prio = get_priority(sd);
-- 
2.43.0


