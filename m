Return-Path: <bpf+bounces-9549-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B97E798E42
	for <lists+bpf@lfdr.de>; Fri,  8 Sep 2023 20:33:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4697A281D1B
	for <lists+bpf@lfdr.de>; Fri,  8 Sep 2023 18:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 402A1171B1;
	Fri,  8 Sep 2023 18:20:44 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC510171AE
	for <bpf@vger.kernel.org>; Fri,  8 Sep 2023 18:20:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC9A5C433CB;
	Fri,  8 Sep 2023 18:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694197242;
	bh=5gYfhHtbATN1eBZVLKgHgCJ6/y3b9OYHJfOcIM3jMVo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ohSUDPXS5dIWfC5d5DxljfFeXqa1OsFfDszXY6fZQYHJ9iy9cQy4xrofha5IOw9TV
	 QdLcIkeF28rvG2TToqudpMZvXw93KjkMcOCqSc6VReywk13z1HhCQY7x3HewwhL3sv
	 VNc2PMBgLFCJD8VkvFd5DmDcNMcsPRt9Er1a7tIAd/2sTvwCbac4asAFlJxKcgaDq+
	 Hkg97hgOiOeN0KJMwP6On1PGcbPz8aHpFtIqXlzxMqFKSN5y/uWZ0IpYt/Ylb+ekS3
	 OSsOlaP4Y2kw0WLydQhS1QGZ0QvYnz4YoBFD1tahofu8AkTp8rzHJ17Qv2qjkYYAKT
	 rlQs+yUIsbRCA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hao Luo <haoluo@google.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	ast@kernel.org,
	daniel@iogearbox.net,
	bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 13/14] libbpf: Free btf_vmlinux when closing bpf_object
Date: Fri,  8 Sep 2023 14:20:00 -0400
Message-Id: <20230908182003.3460721-13-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230908182003.3460721-1-sashal@kernel.org>
References: <20230908182003.3460721-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.194
Content-Transfer-Encoding: 8bit

From: Hao Luo <haoluo@google.com>

[ Upstream commit 29d67fdebc42af6466d1909c60fdd1ef4f3e5240 ]

I hit a memory leak when testing bpf_program__set_attach_target().
Basically, set_attach_target() may allocate btf_vmlinux, for example,
when setting attach target for bpf_iter programs. But btf_vmlinux
is freed only in bpf_object_load(), which means if we only open
bpf object but not load it, setting attach target may leak
btf_vmlinux.

So let's free btf_vmlinux in bpf_object__close() anyway.

Signed-off-by: Hao Luo <haoluo@google.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Link: https://lore.kernel.org/bpf/20230822193840.1509809-1-haoluo@google.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/lib/bpf/libbpf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 015ed8253f739..44646c5286fbe 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -7962,6 +7962,7 @@ void bpf_object__close(struct bpf_object *obj)
 	bpf_object__elf_finish(obj);
 	bpf_object__unload(obj);
 	btf__free(obj->btf);
+	btf__free(obj->btf_vmlinux);
 	btf_ext__free(obj->btf_ext);
 
 	for (i = 0; i < obj->nr_maps; i++)
-- 
2.40.1


