Return-Path: <bpf+bounces-48029-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 001B1A03337
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 00:17:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1EB587A2885
	for <lists+bpf@lfdr.de>; Mon,  6 Jan 2025 23:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17AE31DE2A1;
	Mon,  6 Jan 2025 23:17:44 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from www2651.sakura.ne.jp (www2651.sakura.ne.jp [49.212.180.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5254B1DAC81
	for <bpf@vger.kernel.org>; Mon,  6 Jan 2025 23:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.212.180.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736205463; cv=none; b=RnBfRrzbfFIvL7qXR4n3cRdqveDYeAxLhdzYX9qpQfiszLC/O3Ek8oac5/fotRCgY1DWQ93g9UqTAzBG4iyaRoU0LAdXoHByWtLce+bh8Njuq63Thjs1XBROBlTRLVd96GRlivhfTMLWM52nkeP1JR0gWhkNFAQFDg5tYc8kU+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736205463; c=relaxed/simple;
	bh=4oZ3OOt6L78EWPLkFIibNqvPZXdkYVzvchJyU7ZDsm0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IqD2xQbKJpWsjxvOj2RzQDUCGiGZbP7EdS3gimxVXu90ObOo4B1RSWh0+HukX5YJTHpBzGkXnV3QUFJqP8UF/g8n9cPN5p5AJZf6g5VvmQQdTFuPvSl15zYDpnRFj44QwP29HLADrf09GTFNSJ8ZW5mtfKdAs0T4JGsQV5X5i1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=somane.sakura.ne.jp; spf=pass smtp.mailfrom=somane.sakura.ne.jp; arc=none smtp.client-ip=49.212.180.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=somane.sakura.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=somane.sakura.ne.jp
Received: from somane.. (58-191-24-124f1.hyg1.eonet.ne.jp [58.191.24.124])
	(authenticated bits=0)
	by www2651.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 506NGbPp079546
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 7 Jan 2025 08:16:38 +0900 (JST)
	(envelope-from soma.nakata@somane.sakura.ne.jp)
From: Soma Nakata <soma.nakata@somane.sakura.ne.jp>
To: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
Cc: Soma Nakata <soma.nakata@somane.sakura.ne.jp>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] bpf: fix range_tree_set error handling
Date: Tue,  7 Jan 2025 08:15:35 +0900
Message-ID: <20250106231536.52856-1-soma.nakata@somane.sakura.ne.jp>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

`range_tree_set` might fail and return -ENOMEM,
causing subsequent `bpf_arena_alloc_pages` to fail.
Added the error handling.

Signed-off-by: Soma Nakata <soma.nakata@somane.sakura.ne.jp>
---
 kernel/bpf/arena.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
index 41a76ca56040..4b22a651b5d5 100644
--- a/kernel/bpf/arena.c
+++ b/kernel/bpf/arena.c
@@ -138,7 +138,11 @@ static struct bpf_map *arena_map_alloc(union bpf_attr *attr)
 	INIT_LIST_HEAD(&arena->vma_list);
 	bpf_map_init_from_attr(&arena->map, attr);
 	range_tree_init(&arena->rt);
-	range_tree_set(&arena->rt, 0, attr->max_entries);
+	err = range_tree_set(&arena->rt, 0, attr->max_entries);
+	if (err) {
+		bpf_map_area_free(arena);
+		goto err;
+	}
 	mutex_init(&arena->lock);
 
 	return &arena->map;
-- 
2.47.1


