Return-Path: <bpf+bounces-9546-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B135E798E1C
	for <lists+bpf@lfdr.de>; Fri,  8 Sep 2023 20:29:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4671E281D75
	for <lists+bpf@lfdr.de>; Fri,  8 Sep 2023 18:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76C83168B1;
	Fri,  8 Sep 2023 18:19:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11439168AB
	for <bpf@vger.kernel.org>; Fri,  8 Sep 2023 18:19:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3303C116B3;
	Fri,  8 Sep 2023 18:19:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694197155;
	bh=J2QMtXX3kvkZ2nBhEkgQpCn/AL0LO2VsYGWrL/6/kog=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CFRTPa7+Kr3eKqwCRT4dnxQmSm5SxlNRYLCvfj/CWkY75+cklI6FTvC4NZ7daA4d1
	 eVngfzhln8Gyy7+zFQ5nmthupxbPCBJ+X5DefoKHMmzoKowWj4N41pkhwyd9O+VGib
	 4dWG8e6txcqiuQI17hxjGGDPU6yWVe+/vRzs46YI6pkmpR80xQNrnJ2ZmXPjcrCEUl
	 3lzAgtshzxAvlMZS9840yj4SeExQHIb2etWxFEUhVlPjp/UmP+xacqhlkzaMPIiui/
	 aD5ABRJMsDCJ84x6OhZSmJp4x/HBoFhu7ytk9YObtaqHGmoUIrC+AWJq/45YWdHArx
	 lZAHqhR/aj4zw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hao Luo <haoluo@google.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	ast@kernel.org,
	daniel@iogearbox.net,
	bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 25/26] libbpf: Free btf_vmlinux when closing bpf_object
Date: Fri,  8 Sep 2023 14:18:03 -0400
Message-Id: <20230908181806.3460164-25-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230908181806.3460164-1-sashal@kernel.org>
References: <20230908181806.3460164-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.52
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
index b9a29d1053765..383e93d699bf4 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -8169,6 +8169,7 @@ void bpf_object__close(struct bpf_object *obj)
 	bpf_object__elf_finish(obj);
 	bpf_object_unload(obj);
 	btf__free(obj->btf);
+	btf__free(obj->btf_vmlinux);
 	btf_ext__free(obj->btf_ext);
 
 	for (i = 0; i < obj->nr_maps; i++)
-- 
2.40.1


