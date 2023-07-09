Return-Path: <bpf+bounces-4535-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32BBA74C569
	for <lists+bpf@lfdr.de>; Sun,  9 Jul 2023 17:16:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 636E01C20903
	for <lists+bpf@lfdr.de>; Sun,  9 Jul 2023 15:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 517E0F9CF;
	Sun,  9 Jul 2023 15:14:03 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE88F9C9
	for <bpf@vger.kernel.org>; Sun,  9 Jul 2023 15:14:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3045BC433C8;
	Sun,  9 Jul 2023 15:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688915641;
	bh=Aesp4GTSsA1CjPjXVz0rW/ftouvK6fmZazcFgRA9MIw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NwXc1q2NipC1KXnWvioHiZE9xHVx7sM1tUf1Xo8Rumis221N4WeGVfoEX92A+i9sg
	 MRwrgMxfsjFjetufmrEAJE+WOrq3HNBAi6n2UsBmSl0iiD+YvJoaekoUpwYkJJunjd
	 fbewSIh9seeke/Sw9IfpoQd6LMuHY+4+ZzvnmTGgV/Pwa5BuHkjULyFwXex3P3HtwV
	 LMR/xbpi2PBB/Izs2KGBpeMvz+gMfn6g3FQOBSSt03b3wXsy/fOQKt72CIFyHAVt8W
	 Tdi2NhKJsXE9kaeTcQWtsd2H9Q+ZiuP7RxCgyTdUmFOFGnB7mnUOzRVKQ/TSffbRWa
	 ZeTXfFn/GDmCQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kui-Feng Lee <thinker.li@gmail.com>,
	Kui-Feng Lee <kuifeng@meta.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Yonghong Song <yhs@fb.com>,
	Sasha Levin <sashal@kernel.org>,
	ast@kernel.org,
	daniel@iogearbox.net,
	bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 6.3 02/22] bpf: Print a warning only if writing to unprivileged_bpf_disabled.
Date: Sun,  9 Jul 2023 11:13:36 -0400
Message-Id: <20230709151356.513279-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230709151356.513279-1-sashal@kernel.org>
References: <20230709151356.513279-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.3.12
Content-Transfer-Encoding: 8bit

From: Kui-Feng Lee <thinker.li@gmail.com>

[ Upstream commit fedf99200ab086c42a572fca1d7266b06cdc3e3f ]

Only print the warning message if you are writing to
"/proc/sys/kernel/unprivileged_bpf_disabled".

The kernel may print an annoying warning when you read
"/proc/sys/kernel/unprivileged_bpf_disabled" saying

  WARNING: Unprivileged eBPF is enabled with eIBRS on, data leaks possible
  via Spectre v2 BHB attacks!

However, this message is only meaningful when the feature is
disabled or enabled.

Signed-off-by: Kui-Feng Lee <kuifeng@meta.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Acked-by: Yonghong Song <yhs@fb.com>
Link: https://lore.kernel.org/bpf/20230502181418.308479-1-kuifeng@meta.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/syscall.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index adc83cb82f379..4ae74b8ded867 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -5314,7 +5314,8 @@ static int bpf_unpriv_handler(struct ctl_table *table, int write,
 		*(int *)table->data = unpriv_enable;
 	}
 
-	unpriv_ebpf_notify(unpriv_enable);
+	if (write)
+		unpriv_ebpf_notify(unpriv_enable);
 
 	return ret;
 }
-- 
2.39.2


