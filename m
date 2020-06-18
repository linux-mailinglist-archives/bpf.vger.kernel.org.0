Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F3561FE33D
	for <lists+bpf@lfdr.de>; Thu, 18 Jun 2020 04:07:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729676AbgFRCHh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 17 Jun 2020 22:07:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:55176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730699AbgFRBWQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 17 Jun 2020 21:22:16 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 14599221F0;
        Thu, 18 Jun 2020 01:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592443335;
        bh=84CiTjOmC6L1iB5HAl8uSFlVjOWCYawhCLhEijI3Jpk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C8pE7w4gwpKdS7XbVZOaKNOnLQJMRYQAJGcol5219RrH4UcNFwZtq2Mscu9xhIZMH
         mpUzpVnk19jOpsd+CoUuYBTKmzOqqWoLhuD/adIAOSStC/XCSaXC8dSSat5rq2zRt6
         zfdJof+FtRMh93bNg8YV1HERA1NRDjKXGHxzkXCM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Andrey Ignatov <rdna@fb.com>, Alexei Starovoitov <ast@kernel.org>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 266/266] bpf: Fix memlock accounting for sock_hash
Date:   Wed, 17 Jun 2020 21:16:31 -0400
Message-Id: <20200618011631.604574-266-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618011631.604574-1-sashal@kernel.org>
References: <20200618011631.604574-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Andrey Ignatov <rdna@fb.com>

[ Upstream commit 60e5ca8a64bad8f3e2e20a1e57846e497361c700 ]

Add missed bpf_map_charge_init() in sock_hash_alloc() and
correspondingly bpf_map_charge_finish() on ENOMEM.

It was found accidentally while working on unrelated selftest that
checks "map->memory.pages > 0" is true for all map types.

Before:
	# bpftool m l
	...
	3692: sockhash  name m_sockhash  flags 0x0
		key 4B  value 4B  max_entries 8  memlock 0B

After:
	# bpftool m l
	...
	84: sockmap  name m_sockmap  flags 0x0
		key 4B  value 4B  max_entries 8  memlock 4096B

Fixes: 604326b41a6f ("bpf, sockmap: convert to generic sk_msg interface")
Signed-off-by: Andrey Ignatov <rdna@fb.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Link: https://lore.kernel.org/bpf/20200612000857.2881453-1-rdna@fb.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/sock_map.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index b22e9f119180..6bbc118bf00e 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -837,11 +837,15 @@ static struct bpf_map *sock_hash_alloc(union bpf_attr *attr)
 		err = -EINVAL;
 		goto free_htab;
 	}
+	err = bpf_map_charge_init(&htab->map.memory, cost);
+	if (err)
+		goto free_htab;
 
 	htab->buckets = bpf_map_area_alloc(htab->buckets_num *
 					   sizeof(struct bpf_htab_bucket),
 					   htab->map.numa_node);
 	if (!htab->buckets) {
+		bpf_map_charge_finish(&htab->map.memory);
 		err = -ENOMEM;
 		goto free_htab;
 	}
-- 
2.25.1

