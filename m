Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9F8B491DBA
	for <lists+bpf@lfdr.de>; Tue, 18 Jan 2022 04:43:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244601AbiARDlz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 17 Jan 2022 22:41:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352911AbiARDER (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 17 Jan 2022 22:04:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56E89C02525E;
        Mon, 17 Jan 2022 18:48:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AE6E6612CE;
        Tue, 18 Jan 2022 02:48:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7DD8C36AEF;
        Tue, 18 Jan 2022 02:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642474085;
        bh=xAngeKfXCJtF/25f0h8+pSD9XBwTu6oIqZSVUBcS/cQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YGAzQC4hAK+kjM5cpXtld1hcnXg9d+GSMnRqYXnN+w+yjdeo+Ex/jGlni3/8qyi3n
         PWX+KgGOAqy7ThKvGwzNCr5eOopUz61ePsRXYKeT1aEIsASYCAxcailZu7iY+5JmhG
         +wiq/TSNqYEDEBc/nLs0SJpWthVwKa1M7Ts53ChmT0NjFBmMfzQtESrkHiiql5WHLt
         DkZ6zwIFmq87e9BpvGF6vn85Er7LJm4llCZw3ZMJXXTQ1CopRv8yjWjgJn34/Xflt5
         CWuIUhgsCOi11pG4rfBlfzdDrAiAj3xz97mQy3RZ93aZcO4NvXNnYliDgqlPidQ+UV
         1zcdx3c1EU3VQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Paolo Abeni <pabeni@redhat.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Sasha Levin <sashal@kernel.org>, ast@kernel.org,
        andrii@kernel.org, davem@davemloft.net, kuba@kernel.org,
        hawk@kernel.org, john.fastabend@gmail.com, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 28/59] bpf: Do not WARN in bpf_warn_invalid_xdp_action()
Date:   Mon, 17 Jan 2022 21:46:29 -0500
Message-Id: <20220118024701.1952911-28-sashal@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220118024701.1952911-1-sashal@kernel.org>
References: <20220118024701.1952911-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Paolo Abeni <pabeni@redhat.com>

[ Upstream commit 2cbad989033bff0256675c38f96f5faab852af4b ]

The WARN_ONCE() in bpf_warn_invalid_xdp_action() can be triggered by
any bugged program, and even attaching a correct program to a NIC
not supporting the given action.

The resulting splat, beyond polluting the logs, fouls automated tools:
e.g. a syzkaller reproducers using an XDP program returning an
unsupported action will never pass validation.

Replace the WARN_ONCE with a less intrusive pr_warn_once().

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Toke Høiland-Jørgensen <toke@redhat.com>
Link: https://lore.kernel.org/bpf/016ceec56e4817ebb2a9e35ce794d5c917df572c.1638189075.git.pabeni@redhat.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/filter.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 01496c7cb42d7..7d68c98a00aa8 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -5534,9 +5534,9 @@ void bpf_warn_invalid_xdp_action(u32 act)
 {
 	const u32 act_max = XDP_REDIRECT;
 
-	WARN_ONCE(1, "%s XDP return value %u, expect packet loss!\n",
-		  act > act_max ? "Illegal" : "Driver unsupported",
-		  act);
+	pr_warn_once("%s XDP return value %u, expect packet loss!\n",
+		     act > act_max ? "Illegal" : "Driver unsupported",
+		     act);
 }
 EXPORT_SYMBOL_GPL(bpf_warn_invalid_xdp_action);
 
-- 
2.34.1

